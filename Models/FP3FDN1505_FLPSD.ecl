
export FP3FDN1505_FLPSD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FL_PSD_lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FL_PSD_lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.2654558727,
      (r_F00_dob_score_d > 92) => 0.0165441686,
      (r_F00_dob_score_d = NULL) => 0.0138593396, 0.0287239593),
   (k_nap_phn_verd_d > 0.5) => -0.0548965313,
   (k_nap_phn_verd_d = NULL) => -0.0220581286, -0.0220581286),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 0.3907710808,
      (nf_vf_hi_risk_index > 6.5) => 0.0425377072,
      (nf_vf_hi_risk_index = NULL) => 0.0903425254, 0.0903425254),
   (f_inq_Communications_count_i > 0.5) => 0.4686572768,
   (f_inq_Communications_count_i = NULL) => 0.1845008635, 0.1845008635),
(f_srchvelocityrisktype_i = NULL) => 0.2504495640, -0.0016766067);

// Tree: 2 
wFDN_FL_PSD_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < nf_vf_level and nf_vf_level <= 2.5) => 0.0052731719,
         (nf_vf_level > 2.5) => 0.2543740330,
         (nf_vf_level = NULL) => 0.0145822685, 0.0145822685),
      (f_phone_ver_experian_d > 0.5) => -0.0606188688,
      (f_phone_ver_experian_d = NULL) => -0.0140737201, -0.0268517507),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.2002877153,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0218403368, -0.0218403368),
(f_varrisktype_i > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.1292644387,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.4097593682,
   (nf_seg_FraudPoint_3_0 = '') => 0.2219737333, 0.2219737333),
(f_varrisktype_i = NULL) => 0.2115505657, -0.0063529499);

// Tree: 3 
wFDN_FL_PSD_lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.45) => 0.0981335488,
      (c_famotf18_p > 31.45) => 0.4052672905,
      (c_famotf18_p = NULL) => 0.1347593783, 0.1347593783),
   (nf_vf_hi_risk_hit_type > 3.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0186579184,
      (k_nap_phn_verd_d > 0.5) => -0.0470309649,
      (k_nap_phn_verd_d = NULL) => -0.0216545275, -0.0216545275),
   (nf_vf_hi_risk_hit_type = NULL) => -0.0139599309, -0.0139599309),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1136719494,
   (f_srchvelocityrisktype_i > 4.5) => 0.3048221885,
   (f_srchvelocityrisktype_i = NULL) => 0.1907347710, 0.1907347710),
(f_inq_Communications_count_i = NULL) => 0.0962237473, -0.0060568911);

// Tree: 4 
wFDN_FL_PSD_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0595784667,
         (f_corrphonelastnamecount_d > 0.5) => -0.0360063959,
         (f_corrphonelastnamecount_d = NULL) => 0.0179367998, 0.0179367998),
      (k_inq_per_phone_i > 2.5) => 0.2681285344,
      (k_inq_per_phone_i = NULL) => 0.0270085181, 0.0270085181),
   (f_phone_ver_experian_d > 0.5) => -0.0501303373,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0127138222,
      (f_rel_felony_count_i > 1.5) => 0.2756900145,
      (f_rel_felony_count_i = NULL) => 0.0022113569, 0.0022113569), -0.0140204223),
(f_srchfraudsrchcount_i > 8.5) => 0.1975206103,
(f_srchfraudsrchcount_i = NULL) => 0.1117038822, -0.0077157944);

// Tree: 5 
wFDN_FL_PSD_lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.55) => -0.0217663122,
   (c_famotf18_p > 27.55) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0484622775,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.2123710218,
      (nf_seg_FraudPoint_3_0 = '') => 0.0937703857, 0.0937703857),
   (c_famotf18_p = NULL) => -0.0202267876, -0.0121322007),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0781258756,
   (f_assocrisktype_i > 5.5) => 0.2456998927,
   (f_assocrisktype_i = NULL) => 0.1153135342, 0.1153135342),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0687161338,
   (f_addrs_per_ssn_i > 3.5) => 0.2470853779,
   (f_addrs_per_ssn_i = NULL) => 0.0921638816, 0.0921638816), -0.0039263851);

// Tree: 6 
wFDN_FL_PSD_lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1791983818,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0212769406,
      (f_phone_ver_experian_d > 0.5) => -0.0504707463,
      (f_phone_ver_experian_d = NULL) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0307091908,
         (f_assocrisktype_i > 8.5) => 0.2015537474,
         (f_assocrisktype_i = NULL) => -0.0202020579, -0.0202020579), -0.0211194602),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0163519449, -0.0163519449),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0922688759,
   (f_inq_Communications_count_i > 0.5) => 0.1968662422,
   (f_inq_Communications_count_i = NULL) => 0.1337426446, 0.1337426446),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0611018134, -0.0110026463);

// Tree: 7 
wFDN_FL_PSD_lgt_7 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 6.85) => 0.2288200408,
      (c_hh4_p > 6.85) => 0.0309733664,
      (c_hh4_p = NULL) => 0.0758693426, 0.0758693426),
   (f_varrisktype_i > 4.5) => 0.2102187214,
   (f_varrisktype_i = NULL) => 0.0998603031, 0.0998603031),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1383154135,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0317025839,
      (f_srchvelocityrisktype_i > 4.5) => 0.0537512346,
      (f_srchvelocityrisktype_i = NULL) => -0.0212690913, -0.0212690913),
   (r_F00_dob_score_d = NULL) => -0.0115547298, -0.0160503276),
(nf_vf_hi_risk_hit_type = NULL) => 0.0584516594, -0.0095783808);

// Tree: 8 
wFDN_FL_PSD_lgt_8 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0035487721,
         (k_inq_per_phone_i > 2.5) => 0.1335943548,
         (k_inq_per_phone_i = NULL) => 0.0014837758, 0.0014837758),
      (f_phone_ver_insurance_d > 3.5) => -0.0545125236,
      (f_phone_ver_insurance_d = NULL) => -0.0255429615, -0.0255429615),
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0324949851,
      (f_assocrisktype_i > 5.5) => 0.1408062033,
      (f_assocrisktype_i = NULL) => 0.0532570551, 0.0532570551),
   (f_srchvelocityrisktype_i = NULL) => -0.0158942438, -0.0158942438),
(f_inq_Communications_count_i > 1.5) => 0.1325469530,
(f_inq_Communications_count_i = NULL) => 0.0438174173, -0.0107146961);

// Tree: 9 
wFDN_FL_PSD_lgt_9 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1318016170,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 44.35) => 0.1034275904,
   (c_fammar_p > 44.35) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0954224807,
         (r_F00_dob_score_d > 98) => -0.0253950847,
         (r_F00_dob_score_d = NULL) => -0.0182043384, -0.0212992254),
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1616486352,
         (f_phone_ver_experian_d > 0.5) => 0.0271376584,
         (f_phone_ver_experian_d = NULL) => 0.0740983037, 0.0724339491),
      (k_inq_per_phone_i = NULL) => -0.0169428359, -0.0169428359),
   (c_fammar_p = NULL) => -0.0410098833, -0.0109885742),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0908551497, -0.0062265232);

// Tree: 10 
wFDN_FL_PSD_lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0515663501,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 23.55) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => 0.1883370851,
         (r_F00_dob_score_d > 80) => -0.0038729207,
         (r_F00_dob_score_d = NULL) => 0.0113557235, -0.0010955997),
      (c_famotf18_p > 23.55) => 0.0837943297,
      (c_famotf18_p = NULL) => -0.0206740956, 0.0093970715),
   (nf_seg_FraudPoint_3_0 = '') => -0.0118608355, -0.0118608355),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1615260009,
   (f_phone_ver_experian_d > 0.5) => -0.0015612582,
   (f_phone_ver_experian_d = NULL) => 0.1636746172, 0.1058169337),
(f_inq_Communications_count_i = NULL) => 0.0302126116, -0.0074691812);

// Tree: 11 
wFDN_FL_PSD_lgt_11 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0247402144,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3384227599,
      (r_C10_M_Hdr_FS_d > 2.5) => 0.0098201768,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0174156136, 0.0174156136),
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1881375640,
         (r_I60_inq_comm_recency_d > 549) => 0.0622281252,
         (r_I60_inq_comm_recency_d = NULL) => 0.0838013936, 0.0838013936),
      (f_varrisktype_i > 2.5) => 0.1522125738,
      (f_varrisktype_i = NULL) => 0.1003589992, 0.1003589992),
   (f_assocrisktype_i = NULL) => 0.0265879044, 0.0382991994),
(nf_seg_FraudPoint_3_0 = '') => -0.0078236859, -0.0078236859);

// Tree: 12 
wFDN_FL_PSD_lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2452470996,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0274489336,
         (f_corrrisktype_i > 8.5) => 0.0551271922,
         (f_corrrisktype_i = NULL) => 0.0197197380, 0.0197197380),
      (f_phone_ver_experian_d > 0.5) => -0.0409586506,
      (f_phone_ver_experian_d = NULL) => -0.0109970516, -0.0147708940),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0133676897, -0.0133676897),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1528628783,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0346795224,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0831479773, 0.0831479773),
(f_srchfraudsrchcount_i = NULL) => 0.0626926359, -0.0100653997);

// Tree: 13 
wFDN_FL_PSD_lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.05) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 0.0651037147,
      (nf_vf_hi_risk_index > 6.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1167998525,
         (r_D33_Eviction_Recency_d > 79.5) => -0.0194472931,
         (r_D33_Eviction_Recency_d = NULL) => -0.0174372866, -0.0174372866),
      (nf_vf_hi_risk_index = NULL) => -0.0132562429, -0.0132562429),
   (c_unemp > 11.05) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0797822769,
      (f_rel_criminal_count_i > 2.5) => 0.2701424841,
      (f_rel_criminal_count_i = NULL) => 0.1489302154, 0.1489302154),
   (c_unemp = NULL) => -0.0302514087, -0.0106553141),
(f_assocsuspicousidcount_i > 13.5) => 0.2157853910,
(f_assocsuspicousidcount_i = NULL) => 0.0310196732, -0.0084120035);

// Tree: 14 
wFDN_FL_PSD_lgt_14 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1375122570,
   (r_I60_inq_comm_recency_d > 549) => 0.0529149446,
   (r_I60_inq_comm_recency_d = NULL) => 0.0740948795, 0.0740948795),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0868014634,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1354506359,
         (r_F00_input_dob_match_level_d > 4.5) => 0.0063357000,
         (r_F00_input_dob_match_level_d = NULL) => 0.0105191844, 0.0105191844),
      (k_nap_phn_verd_d > 0.5) => -0.0354384224,
      (k_nap_phn_verd_d = NULL) => -0.0176108591, -0.0176108591),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0151275674, -0.0151275674),
(nf_vf_hi_risk_hit_type = NULL) => 0.0039301404, -0.0101245565);

// Tree: 15 
wFDN_FL_PSD_lgt_15 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 29.25) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0168693959,
      (r_D33_eviction_count_i > 2.5) => 0.1536180539,
      (r_D33_eviction_count_i = NULL) => -0.0152699336, -0.0152699336),
   (c_famotf18_p > 29.25) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 144.5) => 0.0350146956,
         (c_sub_bus > 144.5) => 0.1647465722,
         (c_sub_bus = NULL) => 0.1084935386, 0.1084935386),
      (k_nap_phn_verd_d > 0.5) => 0.0069170348,
      (k_nap_phn_verd_d = NULL) => 0.0579700847, 0.0579700847),
   (c_famotf18_p = NULL) => -0.0393585773, -0.0101905079),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1452942085,
(f_inq_PrepaidCards_count24_i = NULL) => 0.0657786092, -0.0077633136);

// Tree: 16 
wFDN_FL_PSD_lgt_16 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => -0.0142912394,
   (r_D30_Derog_Count_i > 5.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.95) => 0.0511749146,
      (c_famotf18_p > 29.95) => 0.1929761455,
      (c_famotf18_p = NULL) => 0.0680764754, 0.0680764754),
   (r_D30_Derog_Count_i = NULL) => -0.0106155562, -0.0106155562),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => 0.0207127500,
      (r_D30_Derog_Count_i > 3.5) => 0.1416061698,
      (r_D30_Derog_Count_i = NULL) => 0.0303159342, 0.0303159342),
   (f_rel_felony_count_i > 0.5) => 0.1248876253,
   (f_rel_felony_count_i = NULL) => 0.0488949118, 0.0488949118),
(f_varrisktype_i = NULL) => 0.0192579095, -0.0037816585);

// Tree: 17 
wFDN_FL_PSD_lgt_17 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.35) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0223248177,
      (r_D33_eviction_count_i > 0.5) => 0.0688720978,
      (r_D33_eviction_count_i = NULL) => -0.0190863370, -0.0190863370),
   (c_unemp > 9.35) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 22.35) => 0.0461597039,
      (c_vacant_p > 22.35) => 0.2059148116,
      (c_vacant_p = NULL) => 0.0705850716, 0.0705850716),
   (c_unemp = NULL) => -0.0059606165, -0.0151610233),
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 0.1084099206,
   (k_inf_phn_verd_d > 0.5) => -0.0159651171,
   (k_inf_phn_verd_d = NULL) => 0.0686437521, 0.0686437521),
(f_srchcomponentrisktype_i = NULL) => 0.0175052997, -0.0110342718);

// Tree: 18 
wFDN_FL_PSD_lgt_18 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 21.65) => 0.0543812376,
      (c_white_col > 21.65) => -0.0185035569,
      (c_white_col = NULL) => -0.0264708268, -0.0135479730),
   (f_varrisktype_i > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_totsales and c_totsales <= 10062.5) => 0.1299365717,
         (c_totsales > 10062.5) => 0.0150343244,
         (c_totsales = NULL) => 0.0907409453, 0.0907409453),
      (f_phone_ver_experian_d > 0.5) => -0.0193878103,
      (f_phone_ver_experian_d = NULL) => 0.0415606959, 0.0359591296),
   (f_varrisktype_i = NULL) => -0.0032488421, -0.0080663335),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.2506772428,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0070463730, -0.0070463730);

// Tree: 19 
wFDN_FL_PSD_lgt_19 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 212.75) => 0.0013525457,
      (c_cpiall > 212.75) => 0.0717400584,
      (c_cpiall = NULL) => -0.0259467639, 0.0193288976),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 4.55) => 0.0726988699,
      (c_bigapt_p > 4.55) => 0.2455733041,
      (c_bigapt_p = NULL) => 0.1268374828, 0.1268374828),
   (f_rel_felony_count_i = NULL) => 0.0503627817, 0.0257076102),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.1343185299,
   (r_D33_Eviction_Recency_d > 48) => -0.0213898143,
   (r_D33_Eviction_Recency_d = NULL) => -0.0198676984, -0.0198676984),
(k_nap_phn_verd_d = NULL) => -0.0015944607, -0.0015944607);

// Tree: 20 
wFDN_FL_PSD_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1082387190,
   (r_F00_input_dob_match_level_d > 4.5) => -0.0113697673,
   (r_F00_input_dob_match_level_d = NULL) => -0.0090010711, -0.0090010711),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 11.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0932159136,
      (f_phone_ver_experian_d > 0.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 51.7) => 0.1899689453,
         (c_civ_emp > 51.7) => -0.0261961019,
         (c_civ_emp = NULL) => -0.0001072169, -0.0001072169),
      (f_phone_ver_experian_d = NULL) => 0.0235927120, 0.0359863741),
   (f_assocsuspicousidcount_i > 11.5) => 0.1860980283,
   (f_assocsuspicousidcount_i = NULL) => 0.0420867026, 0.0420867026),
(f_varrisktype_i = NULL) => 0.0342038786, -0.0031209109);

// Tree: 21 
wFDN_FL_PSD_lgt_21 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 7.55) => -0.0106187385,
   (c_famotf18_p > 7.55) => 0.1955741207,
   (c_famotf18_p = NULL) => 0.1096604294, 0.1096604294),
(r_C21_M_Bureau_ADL_FS_d > 5.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0194790139,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_professional and c_professional <= 2.85) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 3.75) => 0.2143530276,
         (c_pop_55_64_p > 3.75) => 0.0474496512,
         (c_pop_55_64_p = NULL) => 0.0557323094, 0.0557323094),
      (c_professional > 2.85) => -0.0067013488,
      (c_professional = NULL) => 0.0041791364, 0.0219925930),
   (nf_seg_FraudPoint_3_0 = '') => -0.0115815692, -0.0115815692),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0049890517, -0.0098861586);

// Tree: 22 
wFDN_FL_PSD_lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 47) => 0.0303719538,
   (c_rich_wht > 47) => -0.0255017412,
   (c_rich_wht = NULL) => -0.0474526585, -0.0160081393),
(f_assocrisktype_i > 4.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 16.3) => 0.2121788065,
   (r_C12_source_profile_d > 16.3) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0250507956,
      (r_D33_eviction_count_i > 0.5) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 1.75) => 0.0347096078,
         (c_bigapt_p > 1.75) => 0.1664267754,
         (c_bigapt_p = NULL) => 0.1028170213, 0.1028170213),
      (r_D33_eviction_count_i = NULL) => 0.0328048336, 0.0328048336),
   (r_C12_source_profile_d = NULL) => 0.0389265260, 0.0389265260),
(f_assocrisktype_i = NULL) => -0.0033470140, -0.0066460029);

// Tree: 23 
wFDN_FL_PSD_lgt_23 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0445342485,
   (f_phone_ver_experian_d > 0.5) => -0.0420122910,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 8.35) => -0.0046733812,
         (c_unemp > 8.35) => 0.1249350526,
         (c_unemp = NULL) => -0.1102565206, 0.0040423340),
      (f_assocrisktype_i > 7.5) => 0.1245264706,
      (f_assocrisktype_i = NULL) => 0.0588918297, 0.0143438438), 0.0151576397),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0964592398,
   (r_D33_Eviction_Recency_d > 79.5) => -0.0263247086,
   (r_D33_Eviction_Recency_d = NULL) => -0.0245008622, -0.0245008622),
(k_nap_phn_verd_d = NULL) => -0.0084905202, -0.0084905202);

// Tree: 24 
wFDN_FL_PSD_lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.1836839441,
(r_D32_Mos_Since_Fel_LS_d > 127.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.0790917445,
      (f_historical_count_d > 1.5) => 0.0018235082,
      (f_historical_count_d = NULL) => 0.0455281499, 0.0455281499),
   (r_I60_inq_comm_recency_d > 549) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 146) => -0.0084627575,
         (c_span_lang > 146) => 0.2337975624,
         (c_span_lang = NULL) => 0.0696857328, 0.0696857328),
      (r_F00_input_dob_match_level_d > 4.5) => -0.0142560462,
      (r_F00_input_dob_match_level_d = NULL) => -0.0125591300, -0.0125591300),
   (r_I60_inq_comm_recency_d = NULL) => -0.0070749924, -0.0070749924),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0099090139, -0.0057297062);

// Tree: 25 
wFDN_FL_PSD_lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0032897047,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 9.65) => 0.0780211013,
         (c_hval_200k_p > 9.65) => 0.1859988347,
         (c_hval_200k_p = NULL) => -0.0133422612, 0.0906215699),
      (r_C12_Num_NonDerogs_d > 3.5) => 0.0131447012,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0569908699, 0.0569908699),
   (f_assocrisktype_i = NULL) => 0.0414203901, 0.0180483383),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0266140024,
   (r_D33_eviction_count_i > 3.5) => 0.1151751885,
   (r_D33_eviction_count_i = NULL) => -0.0256393774, -0.0256393774),
(k_nap_phn_verd_d = NULL) => -0.0080988543, -0.0080988543);

// Tree: 26 
wFDN_FL_PSD_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 0.0424403022,
      (k_inq_per_ssn_i > 3.5) => 0.1558661457,
      (k_inq_per_ssn_i = NULL) => 0.0508140222, 0.0508140222),
   (c_employees > 29.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0092194618,
      (f_assocsuspicousidcount_i > 15.5) => 0.1225235638,
      (f_assocsuspicousidcount_i = NULL) => -0.0085074026, -0.0085074026),
   (c_employees = NULL) => 0.0089543461, -0.0023827240),
(r_D30_Derog_Count_i > 11.5) => 0.1132526977,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0586811464,
   (r_S66_adlperssn_count_i > 1.5) => 0.0776042559,
   (r_S66_adlperssn_count_i = NULL) => 0.0094615548, 0.0094615548), -0.0007122979);

// Tree: 27 
wFDN_FL_PSD_lgt_27 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 25462.5) => 0.1428341839,
         (r_A46_Curr_AVM_AutoVal_d > 25462.5) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 6.5) => 0.1417070880,
            (f_M_Bureau_ADL_FS_noTU_d > 6.5) => -0.0237197691,
            (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0214168430, -0.0214168430),
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0135965391, -0.0167027356),
      (k_inq_per_ssn_i > 2.5) => 0.0430390177,
      (k_inq_per_ssn_i = NULL) => -0.0097232119, -0.0097232119),
   (r_D33_eviction_count_i > 0.5) => 0.0596551520,
   (r_D33_eviction_count_i = NULL) => -0.0089903550, -0.0071041422),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1891847373,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0063303766, -0.0063303766);

// Tree: 28 
wFDN_FL_PSD_lgt_28 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1323508100,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0075453346,
            (k_inq_per_ssn_i > 2.5) => 0.0758857080,
            (k_inq_per_ssn_i = NULL) => 0.0148834379, 0.0148834379),
         (f_phone_ver_experian_d > 0.5) => -0.0340493322,
         (f_phone_ver_experian_d = NULL) => -0.0022145123, -0.0117566586),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0109545762, -0.0109545762),
   (r_D33_eviction_count_i > 2.5) => 0.0939887245,
   (r_D33_eviction_count_i = NULL) => -0.0158737936, -0.0098338389),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1623743503,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0090192948, -0.0090192948);

// Tree: 29 
wFDN_FL_PSD_lgt_29 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 41.5) => 
      map(
      (NULL < c_highinc and c_highinc <= 3.95) => 0.1423662858,
      (c_highinc > 3.95) => 0.0223959082,
      (c_highinc = NULL) => 0.0420798740, 0.0420798740),
   (r_D32_Mos_Since_Crim_LS_d > 41.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1005110416,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0129074429,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0123088740, -0.0123088740),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0068812470, -0.0089652618),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 175.5) => 0.0516838149,
   (c_sub_bus > 175.5) => 0.2694581917,
   (c_sub_bus = NULL) => 0.0751717899, 0.0751717899),
(k_comb_age_d = NULL) => -0.0031018677, -0.0031018677);

// Tree: 30 
wFDN_FL_PSD_lgt_30 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 17.95) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 24.15) => 
         map(
         (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 0.1876912442,
         (r_A44_curr_add_naprop_d > 1.5) => 0.0227201813,
         (r_A44_curr_add_naprop_d = NULL) => 0.1181358772, 0.1181358772),
      (c_fammar18_p > 24.15) => 0.0082884359,
      (c_fammar18_p = NULL) => 0.0543695621, 0.0543695621),
   (c_white_col > 17.95) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0533599857,
      (r_F00_dob_score_d > 92) => -0.0115157578,
      (r_F00_dob_score_d = NULL) => -0.0257134974, -0.0101121004),
   (c_white_col = NULL) => -0.0261294523, -0.0082353675),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1122748618,
(f_inq_PrepaidCards_count_i = NULL) => 0.0026246550, -0.0076694413);

// Tree: 31 
wFDN_FL_PSD_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1064805422,
      (r_F00_dob_score_d > 55) => -0.0059978767,
      (r_F00_dob_score_d = NULL) => -0.0225521528, -0.0059210947),
   (k_comb_age_d > 69.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0235204631) => 0.0021244627,
         (f_add_curr_nhood_BUS_pct_i > 0.0235204631) => 0.1817094937,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1175003206, 0.1175003206),
      (f_phone_ver_experian_d > 0.5) => 0.0802082317,
      (f_phone_ver_experian_d = NULL) => -0.0353416591, 0.0718035153),
   (k_comb_age_d = NULL) => -0.0010020511, -0.0010020511),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1491283124,
(f_inq_PrepaidCards_count_i = NULL) => -0.0013794557, -0.0003778167);

// Tree: 32 
wFDN_FL_PSD_lgt_32 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0314884054,
      (f_hh_members_ct_d > 1.5) => -0.0184907391,
      (f_hh_members_ct_d = NULL) => -0.0082445261, -0.0082445261),
   (f_hh_collections_ct_i > 2.5) => 0.0471450684,
   (f_hh_collections_ct_i = NULL) => -0.0030340621, -0.0030340621),
(f_inq_PrepaidCards_count24_i > 0.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 12.85) => 0.1303640875,
   (C_INC_100K_P > 12.85) => 0.0140643228,
   (C_INC_100K_P = NULL) => 0.0780682201, 0.0780682201),
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 29.5) => -0.0668942221,
   (k_comb_age_d > 29.5) => 0.0835813220,
   (k_comb_age_d = NULL) => 0.0090601002, 0.0090601002), -0.0019557384);

// Tree: 33 
wFDN_FL_PSD_lgt_33 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.75) => -0.0150032531,
   (c_unemp > 11.75) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.1999925696,
      (f_property_owners_ct_d > 0.5) => -0.0212850807,
      (f_property_owners_ct_d = NULL) => 0.0874785101, 0.0874785101),
   (c_unemp = NULL) => -0.0161048348, -0.0137387970),
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => 0.0140163022,
   (r_pb_order_freq_d > 126.5) => -0.0131334682,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1505987312,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => 0.0515371739,
      (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0561887601, 0.0561887601), 0.0233403166),
(f_rel_criminal_count_i = NULL) => -0.0215026043, -0.0042468044);

// Tree: 34 
wFDN_FL_PSD_lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1141255696,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 132) => 0.0419044239,
      (c_cartheft > 132) => 0.1570602335,
      (c_cartheft = NULL) => 0.0740561884, 0.0740561884),
   (r_F00_dob_score_d > 95) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.45) => -0.0108066363,
      (c_hh7p_p > 5.45) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 0.0311768170,
         (r_D30_Derog_Count_i > 2.5) => 0.1464728412,
         (r_D30_Derog_Count_i = NULL) => 0.0455542588, 0.0455542588),
      (c_hh7p_p = NULL) => -0.0019357935, -0.0066531764),
   (r_F00_dob_score_d = NULL) => 0.0210702001, -0.0032630798),
(r_C10_M_Hdr_FS_d = NULL) => -0.0007048492, -0.0025685709);

// Tree: 35 
wFDN_FL_PSD_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0068367882,
   (r_P85_Phn_Disconnected_i > 0.5) => 0.0965325778,
   (r_P85_Phn_Disconnected_i = NULL) => -0.0049854723, -0.0049854723),
(f_hh_tot_derog_i > 5.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 19.75) => 
         map(
         (NULL < c_incollege and c_incollege <= 5.35) => 0.0674713142,
         (c_incollege > 5.35) => 0.2515882826,
         (c_incollege = NULL) => 0.1564949033, 0.1564949033),
      (c_hval_400k_p > 19.75) => -0.0391047430,
      (c_hval_400k_p = NULL) => 0.1123809405, 0.1123809405),
   (r_D31_attr_bankruptcy_recency_d > 9) => -0.0136008631,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0686659431, 0.0686659431),
(f_hh_tot_derog_i = NULL) => 0.0047090888, -0.0027908626);

// Tree: 36 
wFDN_FL_PSD_lgt_36 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 90.5) => 0.2637369108,
         (c_medi_indx > 90.5) => 0.0355191843,
         (c_medi_indx = NULL) => 0.1007242490, 0.1007242490),
      (r_D32_Mos_Since_Crim_LS_d > 10.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 16.85) => 0.0461037832,
         (c_hh2_p > 16.85) => -0.0160010168,
         (c_hh2_p = NULL) => -0.0507925977, -0.0137075700),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0118787509, -0.0118787509),
   (f_rel_felony_count_i > 4.5) => 0.1209857476,
   (f_rel_felony_count_i = NULL) => -0.0111997160, -0.0111997160),
(f_srchcomponentrisktype_i > 3.5) => 0.0720219591,
(f_srchcomponentrisktype_i = NULL) => -0.0008740513, -0.0093452184);

// Tree: 37 
wFDN_FL_PSD_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0106367058,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0243085315,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 18.5) => 0.1404604287,
      (C_INC_75K_P > 18.5) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 67.5) => 0.0944636146,
         (c_retired2 > 67.5) => -0.0680630465,
         (c_retired2 = NULL) => 0.0080755695, 0.0080755695),
      (C_INC_75K_P = NULL) => 0.0714711359, 0.0714711359),
   (f_varrisktype_i = NULL) => 0.0268895101, 0.0268895101),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0892867205,
   (r_S66_adlperssn_count_i > 1.5) => 0.1073047647,
   (r_S66_adlperssn_count_i = NULL) => 0.0054346315, 0.0054346315), 0.0011791256);

// Tree: 38 
wFDN_FL_PSD_lgt_38 := map(
(nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0360043875,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 99.5) => 0.1623941993,
      (c_rest_indx > 99.5) => 0.0073852230,
      (c_rest_indx = NULL) => 0.0775289497, 0.0775289497),
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
         map(
         (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0028239192,
         (f_inq_Other_count_i > 0.5) => 0.0316389417,
         (f_inq_Other_count_i = NULL) => 0.0064092825, 0.0064092825),
      (f_inq_PrepaidCards_count_i > 2.5) => 0.1058185209,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0071620089, 0.0071620089),
   (r_F00_input_dob_match_level_d = NULL) => -0.0010861869, 0.0086709575),
(nf_seg_FraudPoint_3_0 = '') => -0.0066281910, -0.0066281910);

// Tree: 39 
wFDN_FL_PSD_lgt_39 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0051248761,
   (f_srchcomponentrisktype_i > 3.5) => 0.0780059019,
   (f_srchcomponentrisktype_i = NULL) => -0.0125291395, -0.0039031987),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 0.25) => 0.2178922013,
      (c_hval_80k_p > 0.25) => 0.0049711301,
      (c_hval_80k_p = NULL) => 0.1383156393, 0.1383156393),
   (f_srchfraudsrchcount_i > 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 8.05) => 0.0542968491,
      (c_construction > 8.05) => -0.0500405808,
      (c_construction = NULL) => 0.0142633029, 0.0142633029),
   (f_srchfraudsrchcount_i = NULL) => 0.0541515139, 0.0541515139),
(k_inq_per_phone_i = NULL) => -0.0010336437, -0.0010336437);

// Tree: 40 
wFDN_FL_PSD_lgt_40 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 234.5) => 0.0210290977,
      (r_C13_max_lres_d > 234.5) => 
         map(
         (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 0.0530309887,
         (r_I60_Inq_Count12_i > 0.5) => 0.1898485209,
         (r_I60_Inq_Count12_i = NULL) => 0.0900857370, 0.0900857370),
      (r_C13_max_lres_d = NULL) => 0.0350864289, 0.0350864289),
   (f_phone_ver_experian_d > 0.5) => -0.0267704250,
   (f_phone_ver_experian_d = NULL) => 0.0151824958, 0.0104505373),
(f_corrphonelastnamecount_d > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0247293940,
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.0552774728,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0225596389, -0.0225596389),
(f_corrphonelastnamecount_d = NULL) => -0.0025453251, -0.0078744070);

// Tree: 41 
wFDN_FL_PSD_lgt_41 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0102909797,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
            map(
            (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 0.1024378679,
            (k_inq_adls_per_phone_i > 2.5) => -0.0952220184,
            (k_inq_adls_per_phone_i = NULL) => 0.0372752680, 0.0372752680),
         (r_Phn_Cell_n > 0.5) => 0.2066974685,
         (r_Phn_Cell_n = NULL) => 0.0961783270, 0.0961783270),
      (f_inq_count24_i > 2.5) => 0.0015417739,
      (f_inq_count24_i = NULL) => 0.0426688740, 0.0426688740),
   (k_inq_per_phone_i = NULL) => -0.0075788517, -0.0075788517),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1162113840,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0070908738, -0.0070908738);

// Tree: 42 
wFDN_FL_PSD_lgt_42 := map(
(NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 222) => 0.0876396239,
   (r_D32_Mos_Since_Fel_LS_d > 222) => -0.0074793236,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0066791477, -0.0066791477),
(f_hh_members_w_derog_i > 3.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 5) => 
      map(
      (NULL < c_families and c_families <= 332.5) => 0.2015873264,
      (c_families > 332.5) => 0.0548665795,
      (c_families = NULL) => 0.1221855104, 0.1221855104),
   (c_newhouse > 5) => 0.0093675873,
   (c_newhouse = NULL) => 0.0520826139, 0.0520826139),
(f_hh_members_w_derog_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0829089923,
   (k_comb_age_d > 27.5) => 0.0514931167,
   (k_comb_age_d = NULL) => -0.0137506255, -0.0137506255), -0.0046195685);

// Tree: 43 
wFDN_FL_PSD_lgt_43 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 43.5) => -0.0052445352,
   (r_pb_order_freq_d > 43.5) => -0.0273790977,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 33.55) => 0.0299161120,
      (c_hh2_p > 33.55) => -0.0182403200,
      (c_hh2_p = NULL) => 0.0083635759, 0.0098345493), -0.0069360529),
(k_inq_per_ssn_i > 3.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 80.5) => 0.1473752290,
      (c_born_usa > 80.5) => 0.0116206008,
      (c_born_usa = NULL) => 0.0799358330, 0.0799358330),
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0251243926,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0343760051, 0.0343760051),
(k_inq_per_ssn_i = NULL) => -0.0038584105, -0.0038584105);

// Tree: 44 
wFDN_FL_PSD_lgt_44 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.55) => -0.0115690068,
   (c_hh7p_p > 7.55) => 0.0590959552,
   (c_hh7p_p = NULL) => -0.0073136533, -0.0087272930),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.55) => 0.1431266039,
      (C_INC_200K_P > 0.55) => 
         map(
         (NULL < r_C20_email_count_i and r_C20_email_count_i <= 4.5) => 0.0252758190,
         (r_C20_email_count_i > 4.5) => 0.1605418109,
         (r_C20_email_count_i = NULL) => 0.0424625568, 0.0424625568),
      (C_INC_200K_P = NULL) => 0.0611683280, 0.0611683280),
   (f_historical_count_d > 0.5) => -0.0012500469,
   (f_historical_count_d = NULL) => 0.0278749653, 0.0278749653),
(f_inq_Communications_count_i = NULL) => 0.0195765790, -0.0051361601);

// Tree: 45 
wFDN_FL_PSD_lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 208.9) => 0.0772810156,
         (c_cpiall > 208.9) => 0.0052146056,
         (c_cpiall = NULL) => -0.0462754340, 0.0092720387),
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1023695796,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0105101646, 0.0105101646),
   (f_historical_count_d > 0.5) => -0.0189131666,
   (f_historical_count_d = NULL) => 0.0175109756, -0.0039536367),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 20.5) => 0.2596812048,
   (c_born_usa > 20.5) => 0.0474228940,
   (c_born_usa = NULL) => 0.0692551774, 0.0692551774),
(k_comb_age_d = NULL) => 0.0012462956, 0.0012462956);

// Tree: 46 
wFDN_FL_PSD_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0039959614,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 0.1254257111,
      (r_F00_dob_score_d > 95) => 
         map(
         (NULL < c_professional and c_professional <= 9.65) => 0.0639620612,
         (c_professional > 9.65) => -0.0658925858,
         (c_professional = NULL) => 0.0325508374, 0.0325508374),
      (r_F00_dob_score_d = NULL) => 0.0388976397, 0.0388976397),
   (k_nap_contradictory_i = NULL) => -0.0008072699, -0.0008072699),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 134.5) => 0.0279837300,
   (c_asian_lang > 134.5) => 0.1827622795,
   (c_asian_lang = NULL) => 0.0738773697, 0.0738773697),
(r_D32_felony_count_i = NULL) => -0.0128594059, 0.0001132426);

// Tree: 47 
wFDN_FL_PSD_lgt_47 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0147357011,
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 361.5) => 
            map(
            (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 6.5) => -0.0177396187,
            (f_addrs_per_ssn_i > 6.5) => 0.0622653664,
            (f_addrs_per_ssn_i = NULL) => 0.0337033261, 0.0337033261),
         (r_C13_Curr_Addr_LRes_d > 361.5) => 0.2228978496,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0430751911, 0.0430751911),
      (k_nap_phn_verd_d > 0.5) => -0.0073039016,
      (k_nap_phn_verd_d = NULL) => 0.0087533778, 0.0087533778),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0047525470, -0.0047525470),
(f_hh_tot_derog_i > 4.5) => 0.0521453146,
(f_hh_tot_derog_i = NULL) => -0.0088145011, -0.0018731951);

// Tree: 48 
wFDN_FL_PSD_lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0907188479,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.45) => -0.0080881710,
      (c_unemp > 11.45) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.04650349655) => -0.0368008922,
         (f_add_curr_nhood_VAC_pct_i > 0.04650349655) => 0.1018998352,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0520542613, 0.0520542613),
      (c_unemp = NULL) => -0.0176026279, -0.0073477884),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0082793190, -0.0068303123),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_employees and c_employees <= 37.5) => 0.1281746429,
   (c_employees > 37.5) => 0.0245384649,
   (c_employees = NULL) => 0.0414484067, 0.0414484067),
(k_inq_per_phone_i = NULL) => -0.0044477756, -0.0044477756);

// Tree: 49 
wFDN_FL_PSD_lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 6.85) => 0.1214449101,
         (c_hval_150k_p > 6.85) => -0.0304952367,
         (c_hval_150k_p = NULL) => 0.0703778898, 0.0703778898),
      (r_F00_input_dob_match_level_d > 5.5) => -0.0009117807,
      (r_F00_input_dob_match_level_d = NULL) => 0.0006812156, 0.0006812156),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1315071497,
      (r_C10_M_Hdr_FS_d > 33) => 0.0282405340,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0513831466, 0.0513831466),
   (f_varrisktype_i = NULL) => 0.0029104716, 0.0029104716),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0704165273,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0025422390, -0.0000904652);

// Tree: 50 
wFDN_FL_PSD_lgt_50 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.75) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0140076873,
      (f_assocrisktype_i > 7.5) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 2.4) => 0.0295254856,
         (c_rnt1250_p > 2.4) => 0.1869112692,
         (c_rnt1250_p = NULL) => 0.0767412206, 0.0767412206),
      (f_assocrisktype_i = NULL) => 0.0171883317, 0.0171883317),
   (c_unemp > 11.75) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1953.5) => 0.1907759578,
      (c_med_yearblt > 1953.5) => 0.0343000870,
      (c_med_yearblt = NULL) => 0.1110891717, 0.1110891717),
   (c_unemp = NULL) => -0.0113463418, 0.0182781946),
(k_estimated_income_d > 32500) => -0.0089093945,
(k_estimated_income_d = NULL) => 0.0273484599, -0.0007476992);

// Tree: 51 
wFDN_FL_PSD_lgt_51 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
   map(
   (NULL < c_employees and c_employees <= 55.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 12.65) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 365.5) => 0.0197154612,
         (r_C13_Curr_Addr_LRes_d > 365.5) => 0.2086604496,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0254049169, 0.0254049169),
      (c_unemp > 12.65) => 0.1048978533,
      (c_unemp = NULL) => 0.0281396809, 0.0281396809),
   (c_employees > 55.5) => 
      map(
      (NULL < c_food and c_food <= 75.5) => -0.0088512924,
      (c_food > 75.5) => 0.1821826284,
      (c_food = NULL) => -0.0079114424, -0.0079114424),
   (c_employees = NULL) => -0.0012913858, -0.0016061862),
(k_inq_adls_per_phone_i > 3.5) => -0.1078817490,
(k_inq_adls_per_phone_i = NULL) => -0.0021340033, -0.0021340033);

// Tree: 52 
wFDN_FL_PSD_lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0237120329,
      (f_corrrisktype_i > 8.5) => 0.0088294413,
      (f_corrrisktype_i = NULL) => -0.0074495485, -0.0090736534),
   (k_comb_age_d > 71.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 173.5) => 0.0594960460,
      (c_sub_bus > 173.5) => 0.2226657080,
      (c_sub_bus = NULL) => 0.0735866904, 0.0735866904),
   (k_comb_age_d = NULL) => -0.0051190900, -0.0051190900),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 307790.5) => 0.0288822667,
   (f_prevaddrmedianvalue_d > 307790.5) => 0.2338651803,
   (f_prevaddrmedianvalue_d = NULL) => 0.0775657087, 0.0775657087),
(r_P85_Phn_Disconnected_i = NULL) => -0.0035025484, -0.0035025484);

// Tree: 53 
wFDN_FL_PSD_lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.0099885291,
      (k_estimated_income_d > 32500) => -0.0297491640,
      (k_estimated_income_d = NULL) => -0.0176075094, -0.0176075094),
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 14.15) => -0.0180540139,
      (c_pop_25_34_p > 14.15) => 0.1723579906,
      (c_pop_25_34_p = NULL) => 0.0780417641, 0.0780417641),
   (r_D32_felony_count_i = NULL) => -0.0301815871, -0.0164450145),
(c_easiqlife > 134.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 0.1341567918,
   (f_attr_arrest_recency_d > 99.5) => 0.0173486359,
   (f_attr_arrest_recency_d = NULL) => 0.0190470659, 0.0190470659),
(c_easiqlife = NULL) => -0.0033617728, -0.0041236719);

// Tree: 54 
wFDN_FL_PSD_lgt_54 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 25.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0970292654,
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < c_employees and c_employees <= 37.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 10.45) => 0.0986796476,
         (C_INC_75K_P > 10.45) => 0.0123879963,
         (C_INC_75K_P = NULL) => 0.0246169529, 0.0246169529),
      (c_employees > 37.5) => 
         map(
         (NULL < c_hval_60k_p and c_hval_60k_p <= 35.15) => -0.0046556942,
         (c_hval_60k_p > 35.15) => -0.1254376747,
         (c_hval_60k_p = NULL) => -0.0054615127, -0.0054615127),
      (c_employees = NULL) => -0.0247644191, -0.0023356629),
   (f_attr_arrest_recency_d = NULL) => -0.0016785608, -0.0016785608),
(f_srchphonesrchcount_i > 25.5) => -0.0935432157,
(f_srchphonesrchcount_i = NULL) => 0.0071731937, -0.0020138033);

// Tree: 55 
wFDN_FL_PSD_lgt_55 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
      map(
      (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0056933703,
         (f_util_adl_count_n > 6.5) => 0.0795646649,
         (f_util_adl_count_n = NULL) => 0.0104856812, 0.0104856812),
      (f_inq_Banking_count24_i > 2.5) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0160335718,
         (k_inf_nothing_found_i > 0.5) => 0.2062548507,
         (k_inf_nothing_found_i = NULL) => 0.1028011727, 0.1028011727),
      (f_inq_Banking_count24_i = NULL) => 0.0129033164, 0.0129033164),
   (k_estimated_income_d > 34500) => -0.0183479180,
   (k_estimated_income_d = NULL) => -0.0286145018, -0.0076599854),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1068113044,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0071906928, -0.0071906928);

// Tree: 56 
wFDN_FL_PSD_lgt_56 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.0498730426,
      (f_hh_age_18_plus_d > 1.5) => 0.0048825460,
      (f_hh_age_18_plus_d = NULL) => 0.0153679530, 0.0153679530),
   (f_phone_ver_experian_d > 0.5) => -0.0172092199,
   (f_phone_ver_experian_d = NULL) => -0.0125548610, -0.0056864734),
(f_inq_HighRiskCredit_count_i > 5.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 36.4) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 6.5) => 0.0753694266,
      (f_inq_HighRiskCredit_count24_i > 6.5) => -0.0753158220,
      (f_inq_HighRiskCredit_count24_i = NULL) => 0.0067647606, 0.0067647606),
   (c_fammar18_p > 36.4) => 0.1030743444,
   (c_fammar18_p = NULL) => 0.0494721778, 0.0494721778),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0041060703, -0.0046539805);

// Tree: 57 
wFDN_FL_PSD_lgt_57 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0063216980,
   (r_D30_Derog_Count_i > 11.5) => 
      map(
      (NULL < c_retail and c_retail <= 16.2) => 0.0053781137,
      (c_retail > 16.2) => 0.1547627881,
      (c_retail = NULL) => 0.0612828078, 0.0612828078),
   (r_D30_Derog_Count_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0838772808,
      (f_addrs_per_ssn_i > 3.5) => 0.0499907021,
      (f_addrs_per_ssn_i = NULL) => -0.0181828077, -0.0181828077), -0.0055375205),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 0.2784992403,
   (k_estimated_income_d > 36500) => 0.0464009780,
   (k_estimated_income_d = NULL) => 0.1211881958, 0.1211881958),
(f_adls_per_phone_c6_i = NULL) => -0.0037392841, -0.0037392841);

// Tree: 58 
wFDN_FL_PSD_lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0090586670,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1280027454) => -0.0292871355,
      (f_add_curr_nhood_MFD_pct_i > 0.1280027454) => 0.1411095026,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0808117613, 0.0678335558),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0076037768, -0.0076037768),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 9.55) => 0.0205076705,
   (c_pop_12_17_p > 9.55) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 134.5) => 0.1863540096,
      (r_C10_M_Hdr_FS_d > 134.5) => 0.0524691988,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0889832381, 0.0889832381),
   (c_pop_12_17_p = NULL) => 0.0408652716, 0.0408652716),
(k_inq_per_phone_i = NULL) => -0.0051774587, -0.0051774587);

// Tree: 59 
wFDN_FL_PSD_lgt_59 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0367929976,
   (f_addrs_per_ssn_i > 3.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 218.4) => -0.0075110292,
      (c_cpiall > 218.4) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 0.1259699632,
         (f_prevaddrlenofres_d > 1.5) => 0.0227398064,
         (f_prevaddrlenofres_d = NULL) => 0.0298436238, 0.0298436238),
      (c_cpiall = NULL) => -0.0118818282, 0.0006671230),
   (f_addrs_per_ssn_i = NULL) => -0.0056855003, -0.0056855003),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0163617956,
   (f_addrs_per_ssn_i > 5.5) => 0.2475670758,
   (f_addrs_per_ssn_i = NULL) => 0.1125336997, 0.1125336997),
(f_nae_nothing_found_i = NULL) => -0.0040825281, -0.0040825281);

// Tree: 60 
wFDN_FL_PSD_lgt_60 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 99.5) => 
      map(
      (NULL < c_murders and c_murders <= 52) => 0.2127956287,
      (c_murders > 52) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60) => 0.1068658082,
         (r_C12_source_profile_d > 60) => -0.0682309387,
         (r_C12_source_profile_d = NULL) => 0.0117045327, 0.0117045327),
      (c_murders = NULL) => 0.0659672094, 0.0659672094),
   (f_mos_liens_unrel_SC_fseen_d > 99.5) => -0.0077908087,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0065556884, -0.0065556884),
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 0.0226461927,
   (f_idrisktype_i > 2.5) => 0.1936854880,
   (f_idrisktype_i = NULL) => 0.0316330032, 0.0316330032),
(f_hh_payday_loan_users_i = NULL) => -0.0154795881, -0.0030728985);

// Tree: 61 
wFDN_FL_PSD_lgt_61 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 3.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 50.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 109.5) => 0.1548668113,
         (c_old_homes > 109.5) => 0.0304619619,
         (c_old_homes = NULL) => 0.0926643866, 0.0926643866),
      (c_lux_prod > 50.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 4.95) => -0.0301768587,
         (c_incollege > 4.95) => 0.0578493598,
         (c_incollege = NULL) => 0.0261494418, 0.0261494418),
      (c_lux_prod = NULL) => 0.0412873258, 0.0412873258),
   (f_historical_count_d > 3.5) => -0.0335210250,
   (f_historical_count_d = NULL) => 0.0232849761, 0.0232849761),
(r_I60_inq_comm_recency_d > 549) => -0.0038286810,
(r_I60_inq_comm_recency_d = NULL) => -0.0149052306, -0.0013936182);

// Tree: 62 
wFDN_FL_PSD_lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0091407297,
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1765.5) => 0.0090612135,
      (c_med_rent > 1765.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 32.5) => 0.3637204465,
         (c_born_usa > 32.5) => 0.0430416116,
         (c_born_usa = NULL) => 0.1317400127, 0.1317400127),
      (c_med_rent = NULL) => -0.0324392067, 0.0134665832),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0005106564, 0.0005106564),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 3.45) => 0.1623410547,
   (c_newhouse > 3.45) => 0.0263434708,
   (c_newhouse = NULL) => 0.0690403867, 0.0690403867),
(f_assoccredbureaucountnew_i = NULL) => 0.0320333982, 0.0021253267);

// Tree: 63 
wFDN_FL_PSD_lgt_63 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 5.6) => -0.0663517275,
      (c_hval_300k_p > 5.6) => 0.0804719534,
      (c_hval_300k_p = NULL) => -0.0083256021, -0.0083256021),
   (k_inq_per_ssn_i > 0.5) => 0.1552132341,
   (k_inq_per_ssn_i = NULL) => 0.0508656931, 0.0508656931),
(f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 161.5) => -0.0066586767,
      (r_C13_Curr_Addr_LRes_d > 161.5) => 0.0337927368,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0022889022, 0.0022889022),
   (c_hval_80k_p > 19.25) => -0.0422193986,
   (c_hval_80k_p = NULL) => 0.0037442945, -0.0005571929),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0008385519, 0.0005269944);

// Tree: 64 
wFDN_FL_PSD_lgt_64 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0732935494,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0060180984,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0119924769, -0.0055894049),
(k_comb_age_d > 69.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 23.2) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 60.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.25) => 0.2761714900,
         (c_pop_55_64_p > 12.25) => -0.0008152666,
         (c_pop_55_64_p = NULL) => 0.1467596447, 0.1467596447),
      (f_prevaddrageoldest_d > 60.5) => 0.0165994173,
      (f_prevaddrageoldest_d = NULL) => 0.0397137517, 0.0397137517),
   (C_INC_15K_P > 23.2) => 0.1647114143,
   (C_INC_15K_P = NULL) => 0.0497403022, 0.0497403022),
(k_comb_age_d = NULL) => -0.0022220786, -0.0022220786);

// Tree: 65 
wFDN_FL_PSD_lgt_65 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0805299049,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0069633346,
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 87.5) => 0.0737246485,
         (c_relig_indx > 87.5) => 0.0106753730,
         (c_relig_indx = NULL) => 0.0138493253, 0.0345266772),
      (f_phone_ver_insurance_d > 3.5) => -0.0129427680,
      (f_phone_ver_insurance_d = NULL) => 0.0087935705, 0.0087935705),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0001826416, -0.0001826416),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.0897629999,
   (k_comb_age_d > 26.5) => 0.0682987718,
   (k_comb_age_d = NULL) => -0.0107321140, -0.0107321140), 0.0011959819);

// Tree: 66 
wFDN_FL_PSD_lgt_66 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => -0.0446696500,
   (f_mos_inq_banko_om_lseen_d > 5.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0004807060,
      (r_D33_eviction_count_i > 3.5) => 0.1000592805,
      (r_D33_eviction_count_i = NULL) => 0.0001567181, 0.0001567181),
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0167876728, -0.0023403630),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 2.5) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 176.5) => 0.0038882266,
      (c_blue_empl > 176.5) => 0.1256445309,
      (c_blue_empl = NULL) => 0.0142537570, 0.0142537570),
   (f_srchphonesrchcount_i > 2.5) => 0.1254944997,
   (f_srchphonesrchcount_i = NULL) => 0.0266543644, 0.0266543644),
(k_nap_contradictory_i = NULL) => -0.0001963304, -0.0001963304);

// Tree: 67 
wFDN_FL_PSD_lgt_67 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0043939669,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 23) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 17.05) => 0.0599103059,
         (c_hh3_p > 17.05) => 0.2856507298,
         (c_hh3_p = NULL) => 0.1810393138, 0.1810393138),
      (r_pb_order_freq_d > 23) => 0.0191662399,
      (r_pb_order_freq_d = NULL) => 0.0363519056, 0.0679989081),
   (f_phone_ver_experian_d > 0.5) => -0.0045389327,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 142) => -0.0191456222,
      (c_rich_fam > 142) => 0.1792496478,
      (c_rich_fam = NULL) => 0.0360231160, 0.0360231160), 0.0229300336),
(f_util_adl_count_n = NULL) => -0.0196756588, -0.0011532965);

// Tree: 68 
wFDN_FL_PSD_lgt_68 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => -0.0024757776,
(r_C13_Curr_Addr_LRes_d > 306.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 233.45) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0866292718,
         (f_phone_ver_experian_d > 0.5) => -0.0411097165,
         (f_phone_ver_experian_d = NULL) => -0.0603320342, -0.0140315329),
      (f_rel_criminal_count_i > 2.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 9.75) => 0.0274613857,
         (c_rnt1000_p > 9.75) => 0.2513955283,
         (c_rnt1000_p = NULL) => 0.1358166160, 0.1358166160),
      (f_rel_criminal_count_i = NULL) => 0.0190075327, 0.0190075327),
   (c_cpiall > 233.45) => 0.2064069552,
   (c_cpiall = NULL) => 0.0332902745, 0.0332902745),
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0211547500, -0.0004337085);

// Tree: 69 
wFDN_FL_PSD_lgt_69 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0998022495,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.85) => -0.0176716798,
   (c_hh4_p > 12.85) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 33.25) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 157.5) => -0.0149322849,
            (r_A50_pb_average_dollars_d > 157.5) => 0.0244399100,
            (r_A50_pb_average_dollars_d = NULL) => 0.0014036856, 0.0014036856),
         (k_inq_per_ssn_i > 10.5) => 0.0965321230,
         (k_inq_per_ssn_i = NULL) => 0.0025993745, 0.0025993745),
      (c_hh3_p > 33.25) => 0.1736247067,
      (c_hh3_p = NULL) => 0.0048968804, 0.0048968804),
   (c_hh4_p = NULL) => -0.0035812354, -0.0051496146),
(f_attr_arrest_recency_d = NULL) => -0.0154322649, -0.0047723802);

// Tree: 70 
wFDN_FL_PSD_lgt_70 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0098192813,
   (k_comb_age_d > 69.5) => 0.0516748044,
   (k_comb_age_d = NULL) => -0.0059951914, -0.0059951914),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.35) => 0.1380323754,
   (C_INC_150K_P > 0.35) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.85) => 0.0548433322,
      (c_pop_6_11_p > 8.85) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 4.5) => 0.0631402185,
         (f_prevaddrcartheftindex_i > 4.5) => -0.0558864127,
         (f_prevaddrcartheftindex_i = NULL) => -0.0361108282, -0.0361108282),
      (c_pop_6_11_p = NULL) => 0.0201737464, 0.0201737464),
   (C_INC_150K_P = NULL) => 0.0268449895, 0.0268449895),
(k_nap_contradictory_i = NULL) => -0.0035875155, -0.0035875155);

// Tree: 71 
wFDN_FL_PSD_lgt_71 := map(
(NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 36.15) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0418099930,
      (f_mos_inq_banko_om_fseen_d > 21.5) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1974.5) => 0.1007021632,
            (c_med_yearblt > 1974.5) => -0.0016811326,
            (c_med_yearblt = NULL) => 0.0575424752, 0.0575424752),
         (r_I60_inq_comm_recency_d > 549) => 0.0120458942,
         (r_I60_inq_comm_recency_d = NULL) => 0.0153789079, 0.0153789079),
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0114451127, 0.0113120506),
   (c_hh3_p > 36.15) => 0.1201742781,
   (c_hh3_p = NULL) => -0.0235050940, 0.0114384879),
(k_inf_phn_verd_d > 0.5) => -0.0177482542,
(k_inf_phn_verd_d = NULL) => 0.0011213139, 0.0011213139);

// Tree: 72 
wFDN_FL_PSD_lgt_72 := map(
(NULL < r_P85_Phn_Invalid_i and r_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => -0.0031720843,
      (k_inq_per_phone_i > 4.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 130.5) => 0.0141244008,
         (c_no_labfor > 130.5) => 0.1530318900,
         (c_no_labfor = NULL) => 0.0431583432, 0.0431583432),
      (k_inq_per_phone_i = NULL) => -0.0022312879, -0.0022312879),
   (f_assocsuspicousidcount_i > 15.5) => 0.0998526916,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 113.5) => -0.0776722650,
      (c_relig_indx > 113.5) => 0.0664901911,
      (c_relig_indx = NULL) => -0.0022227553, -0.0022227553), -0.0017366185),
(r_P85_Phn_Invalid_i > 0.5) => -0.0787622800,
(r_P85_Phn_Invalid_i = NULL) => -0.0035643461, -0.0035643461);

// Tree: 73 
wFDN_FL_PSD_lgt_73 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 186.5) => -0.0071800005,
      (c_unempl > 186.5) => 0.0816501123,
      (c_unempl = NULL) => 0.0137602344, -0.0052828401),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 0.0862890395,
      (r_F00_input_dob_match_level_d > 5.5) => 0.0042370627,
      (r_F00_input_dob_match_level_d = NULL) => 0.0057617297, 0.0057617297),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0005978034, -0.0005978034),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 993.5) => 0.1188699285,
   (c_popover25 > 993.5) => 0.0017557534,
   (c_popover25 = NULL) => 0.0572308890, 0.0572308890),
(f_inq_PrepaidCards_count_i = NULL) => -0.0017027604, 0.0000182191);

// Tree: 74 
wFDN_FL_PSD_lgt_74 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0170227010,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 80.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1921196206,
         (r_Phn_Cell_n > 0.5) => 0.0464715589,
         (r_Phn_Cell_n = NULL) => 0.1166947315, 0.1166947315),
      (c_ab_av_edu > 80.5) => -0.0019626099,
      (c_ab_av_edu = NULL) => 0.0285181750, 0.0285181750),
   (r_C14_Addr_Stability_v2_d > 1.5) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.0316075327,
      (r_Prop_Owner_History_d > 1.5) => -0.0045225454,
      (r_Prop_Owner_History_d = NULL) => 0.0058498574, 0.0058498574),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0072765348, 0.0072765348),
(f_util_add_curr_conv_n = NULL) => -0.0035752721, -0.0035752721);

// Tree: 75 
wFDN_FL_PSD_lgt_75 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => 
   map(
   (NULL < c_employees and c_employees <= 37.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 156.5) => 0.0045088305,
      (c_robbery > 156.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 161.5) => 0.1681137221,
         (c_bargains > 161.5) => -0.0024309483,
         (c_bargains = NULL) => 0.1121537521, 0.1121537521),
      (c_robbery = NULL) => 0.0254488760, 0.0254488760),
   (c_employees > 37.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => -0.0720901738,
      (r_F00_dob_score_d > 80) => -0.0151123429,
      (r_F00_dob_score_d = NULL) => -0.0676126172, -0.0181890929),
   (c_employees = NULL) => -0.0251461149, -0.0130979530),
(f_prevaddrageoldest_d > 134.5) => 0.0151562517,
(f_prevaddrageoldest_d = NULL) => -0.0216186353, -0.0032452615);

// Tree: 76 
wFDN_FL_PSD_lgt_76 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.25) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.8399655766) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
            map(
            (NULL < c_cpiall and c_cpiall <= 208.5) => 0.1698546123,
            (c_cpiall > 208.5) => 0.0321961420,
            (c_cpiall = NULL) => 0.0448166027, 0.0448166027),
         (k_estimated_income_d > 32500) => 0.0044851658,
         (k_estimated_income_d = NULL) => 0.0163291036, 0.0163291036),
      (f_add_curr_nhood_MFD_pct_i > 0.8399655766) => -0.0442726772,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0021959351, 0.0084904474),
   (c_pop_6_11_p > 15.25) => 0.1711831943,
   (c_pop_6_11_p = NULL) => -0.0111716641, 0.0091395078),
(f_historical_count_d > 0.5) => -0.0149079223,
(f_historical_count_d = NULL) => 0.0218978390, -0.0028463256);

// Tree: 77 
wFDN_FL_PSD_lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 16) => -0.0130022955,
   (f_srchphonesrchcount_i > 16) => -0.1260630384,
   (f_srchphonesrchcount_i = NULL) => -0.0002751562, -0.0137885325),
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 125) => 0.2044184282,
      (c_asian_lang > 125) => 0.0012027389,
      (c_asian_lang = NULL) => 0.0727575591, 0.0727575591),
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 38.5) => 0.1635664626,
      (f_mos_liens_unrel_SC_fseen_d > 38.5) => 0.0101211208,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0112544608, 0.0112544608),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0125108725, 0.0125108725),
(f_util_add_curr_conv_n = NULL) => 0.0008259339, 0.0008259339);

// Tree: 78 
wFDN_FL_PSD_lgt_78 := map(
(NULL < c_med_rent and c_med_rent <= 752.5) => 
   map(
   (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0192169175,
   (f_srchunvrfdaddrcount_i > 0.5) => 
      map(
      (NULL < c_construction and c_construction <= 4.3) => 0.1391197459,
      (c_construction > 4.3) => 0.0019967559,
      (c_construction = NULL) => 0.0580470292, 0.0580470292),
   (f_srchunvrfdaddrcount_i = NULL) => 0.0064487690, -0.0171924644),
(c_med_rent > 752.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 0.0106002750,
      (f_inq_Communications_count24_i > 1.5) => 0.0738825235,
      (f_inq_Communications_count24_i = NULL) => 0.0116713142, 0.0116713142),
   (k_inq_per_phone_i > 6.5) => 0.1258071781,
   (k_inq_per_phone_i = NULL) => 0.0130660498, 0.0130660498),
(c_med_rent = NULL) => -0.0085504153, -0.0017622152);

// Tree: 79 
wFDN_FL_PSD_lgt_79 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0407232132) => 0.0582015609,
      (f_add_curr_nhood_BUS_pct_i > 0.0407232132) => -0.0043460444,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0202676081, 0.0254947093),
   (r_I60_inq_comm_recency_d > 549) => -0.0090454349,
   (r_I60_inq_comm_recency_d = NULL) => -0.0059253002, -0.0059253002),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 14.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 829.5) => -0.0331042739,
      (c_hh00 > 829.5) => 0.1285152120,
      (c_hh00 = NULL) => 0.0151403488, 0.0151403488),
   (f_rel_educationover12_count_d > 14.5) => 0.1334641963,
   (f_rel_educationover12_count_d = NULL) => 0.0421343824, 0.0421343824),
(f_srchcomponentrisktype_i = NULL) => -0.0027176351, -0.0048891883);

// Tree: 80 
wFDN_FL_PSD_lgt_80 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 12.5) => 0.1334679114,
   (r_C13_max_lres_d > 12.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 0.0007457680,
         (k_inq_per_phone_i > 2.5) => 
            map(
            (NULL < c_mort_indx and c_mort_indx <= 130.5) => 0.0636362290,
            (c_mort_indx > 130.5) => -0.0396300451,
            (c_mort_indx = NULL) => 0.0411241813, 0.0411241813),
         (k_inq_per_phone_i = NULL) => 0.0024702946, 0.0024702946),
      (k_inq_adls_per_phone_i > 2.5) => -0.0714893592,
      (k_inq_adls_per_phone_i = NULL) => 0.0018524711, 0.0018524711),
   (r_C13_max_lres_d = NULL) => 0.0028887273, 0.0028887273),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0513189397,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0090760587, 0.0006958206);

// Tree: 81 
wFDN_FL_PSD_lgt_81 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 134.5) => -0.0153958712,
      (c_easiqlife > 134.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 114.5) => -0.0031482713,
         (r_C13_Curr_Addr_LRes_d > 114.5) => 0.0520396763,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0133871986, 0.0133871986),
      (c_easiqlife = NULL) => 0.0536567023, -0.0039463964),
   (k_inq_per_phone_i > 6.5) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 73.7) => 0.0019024332,
      (c_oldhouse > 73.7) => 0.1347468545,
      (c_oldhouse = NULL) => 0.0760739017, 0.0760739017),
   (k_inq_per_phone_i = NULL) => -0.0031734077, -0.0031734077),
(f_srchphonesrchcount_i > 22.5) => -0.1131043158,
(f_srchphonesrchcount_i = NULL) => -0.0182633145, -0.0037812430);

// Tree: 82 
wFDN_FL_PSD_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 42.1) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0047878019,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.0422014192,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0038484105, -0.0038484105),
   (c_hval_500k_p > 42.1) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 20.45) => 0.0196893440,
      (c_hh4_p > 20.45) => 0.2606524485,
      (c_hh4_p = NULL) => 0.0934535597, 0.0934535597),
   (c_hval_500k_p = NULL) => -0.0065794970, -0.0023842001),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 89.5) => 0.0064303047,
   (c_new_homes > 89.5) => -0.1078499599,
   (c_new_homes = NULL) => -0.0614236024, -0.0614236024),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0261070642, -0.0027530946);

// Tree: 83 
wFDN_FL_PSD_lgt_83 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0023971077,
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 88.5) => -0.0149004629,
   (c_very_rich > 88.5) => 
      map(
      (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
         map(
         (NULL < c_transport and c_transport <= 6.8) => 
            map(
            (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 1.5) => 0.0760961140,
            (f_srchfraudsrchcountyr_i > 1.5) => -0.0299389966,
            (f_srchfraudsrchcountyr_i = NULL) => 0.0381449914, 0.0381449914),
         (c_transport > 6.8) => 0.1952246845,
         (c_transport = NULL) => 0.0518040952, 0.0518040952),
      (r_D31_ALL_Bk_i > 1.5) => 0.1780025616,
      (r_D31_ALL_Bk_i = NULL) => 0.0624961347, 0.0624961347),
   (c_very_rich = NULL) => 0.0337594670, 0.0337594670),
(k_inq_per_phone_i = NULL) => 0.0011971722, 0.0011971722);

// Tree: 84 
wFDN_FL_PSD_lgt_84 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 12.5) => -0.0000576743,
      (f_srchphonesrchcount_i > 12.5) => -0.0764762983,
      (f_srchphonesrchcount_i = NULL) => -0.0011074427, -0.0011074427),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 197.5) => 0.0089332943,
      (c_sub_bus > 197.5) => 0.1796962231,
      (c_sub_bus = NULL) => 0.0249965174, 0.0111020640),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0042458629, 0.0042458629),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0560804381,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.1015540107,
   (k_comb_age_d > 25.5) => 0.1077932552,
   (k_comb_age_d = NULL) => 0.0070695707, 0.0070695707), 0.0018487975);

// Tree: 85 
wFDN_FL_PSD_lgt_85 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.55) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0166510665,
      (f_corrrisktype_i > 8.5) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 0.0050439654,
         (f_srchcomponentrisktype_i > 1.5) => 
            map(
            (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 2.5) => 0.1199458485,
            (r_I60_Inq_Count12_i > 2.5) => -0.0202022546,
            (r_I60_Inq_Count12_i = NULL) => 0.0714330436, 0.0714330436),
         (f_srchcomponentrisktype_i = NULL) => 0.0080563843, 0.0080563843),
      (f_corrrisktype_i = NULL) => 0.0040619110, -0.0059934012),
   (k_inq_adls_per_phone_i > 2.5) => -0.0744727293,
   (k_inq_adls_per_phone_i = NULL) => -0.0065584214, -0.0065584214),
(c_hval_80k_p > 41.55) => -0.0951191572,
(c_hval_80k_p = NULL) => 0.0197858785, -0.0067142614);

// Tree: 86 
wFDN_FL_PSD_lgt_86 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 0.5) => -0.0715968697,
   (f_rel_homeover200_count_d > 0.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 3.4) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 5.5) => 0.2625908587,
         (f_corrssnnamecount_d > 5.5) => 0.0350612206,
         (f_corrssnnamecount_d = NULL) => 0.1413524384, 0.1413524384),
      (c_highrent > 3.4) => 0.0095220099,
      (c_highrent = NULL) => 0.0735672890, 0.0735672890),
   (f_rel_homeover200_count_d = NULL) => 0.0510051177, 0.0510051177),
(r_I61_inq_collection_recency_d > 4.5) => 
   map(
   (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 0.0008059322,
   (r_D31_ALL_Bk_i > 1.5) => -0.0413677005,
   (r_D31_ALL_Bk_i = NULL) => -0.0029068629, -0.0029068629),
(r_I61_inq_collection_recency_d = NULL) => -0.0088904378, -0.0014948485);

// Tree: 87 
wFDN_FL_PSD_lgt_87 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 24.55) => -0.0104181083,
   (c_famotf18_p > 24.55) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 31.95) => 0.0015760574,
      (c_rnt1000_p > 31.95) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 109.5) => 
            map(
            (NULL < c_assault and c_assault <= 76) => 0.2640494915,
            (c_assault > 76) => 0.0664215212,
            (c_assault = NULL) => 0.1320060246, 0.1320060246),
         (c_relig_indx > 109.5) => -0.0007658020,
         (c_relig_indx = NULL) => 0.0839981325, 0.0839981325),
      (c_rnt1000_p = NULL) => 0.0219941222, 0.0219941222),
   (c_famotf18_p = NULL) => 0.0041305523, -0.0064230157),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0989274769,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0060077596, -0.0060077596);

// Tree: 88 
wFDN_FL_PSD_lgt_88 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0049168616,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < k_inq_lnames_per_ssn_i and k_inq_lnames_per_ssn_i <= 0.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 2.55) => 0.2835077709,
         (C_INC_150K_P > 2.55) => 0.0715899640,
         (C_INC_150K_P = NULL) => 0.1102002477, 0.1102002477),
      (k_inq_lnames_per_ssn_i > 0.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 17.95) => 0.0020521521,
         (c_hval_175k_p > 17.95) => 0.0759897969,
         (c_hval_175k_p = NULL) => 0.0114604391, 0.0114604391),
      (k_inq_lnames_per_ssn_i = NULL) => 0.0303942102, 0.0303942102),
   (k_inq_per_ssn_i = NULL) => 0.0023158317, 0.0023158317),
(f_srchphonesrchcountmo_i > 2.5) => -0.0966983600,
(f_srchphonesrchcountmo_i = NULL) => -0.0278980884, 0.0017278565);

// Tree: 89 
wFDN_FL_PSD_lgt_89 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 43.15) => 
   map(
   (NULL < c_burglary and c_burglary <= 20) => -0.0477731267,
   (c_burglary > 20) => 0.0005942317,
   (c_burglary = NULL) => -0.0058859254, -0.0058859254),
(c_hval_750k_p > 43.15) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 152.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 276) => -0.0176234213,
      (r_C13_Curr_Addr_LRes_d > 276) => 0.2000145287,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0022682193, 0.0022682193),
   (c_rich_fam > 152.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 294.5) => 0.0709307635,
      (f_M_Bureau_ADL_FS_all_d > 294.5) => 0.3729086393,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1730703391, 0.1730703391),
   (c_rich_fam = NULL) => 0.0478599310, 0.0478599310),
(c_hval_750k_p = NULL) => 0.0096140500, -0.0022250417);

// Tree: 90 
wFDN_FL_PSD_lgt_90 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => -0.0102285565,
   (k_comb_age_d > 73.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 3.65) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 85.5) => 0.0516107054,
         (c_exp_prod > 85.5) => 0.2575958653,
         (c_exp_prod = NULL) => 0.1456826682, 0.1456826682),
      (c_hval_250k_p > 3.65) => 0.0108852503,
      (c_hval_250k_p = NULL) => 0.0509772224, 0.0509772224),
   (k_comb_age_d = NULL) => -0.0078651212, -0.0078651212),
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 3.25) => 0.1595679694,
   (C_INC_100K_P > 3.25) => 0.0243695538,
   (C_INC_100K_P = NULL) => 0.0298920307, 0.0298920307),
(C_INC_50K_P = NULL) => 0.0035441978, -0.0036558349);

// Tree: 91 
wFDN_FL_PSD_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_no_labfor and c_no_labfor <= 53.5) => -0.0279827738,
   (c_no_labfor > 53.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0547290585,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','6: Other']) => 0.1765141241,
      (nf_seg_FraudPoint_3_0 = '') => 0.1075025870, 0.1075025870),
   (c_no_labfor = NULL) => 0.0669836006, 0.0669836006),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 52.6) => -0.0070970328,
   (c_hval_500k_p > 52.6) => 0.1058426908,
   (c_hval_500k_p = NULL) => -0.0033748503, -0.0063237956),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 11.35) => -0.0460749009,
   (c_rnt1000_p > 11.35) => 0.0765122342,
   (c_rnt1000_p = NULL) => 0.0158255337, 0.0158255337), -0.0048898905);

// Tree: 92 
wFDN_FL_PSD_lgt_92 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0064005759,
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 
      map(
      (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 996) => 0.0204071545,
      (f_liens_unrel_CJ_total_amt_i > 996) => -0.0529176492,
      (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0144688781, 0.0144688781),
   (C_INC_75K_P > 27.85) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 122) => 0.0304783810,
         (c_blue_empl > 122) => 0.2725375519,
         (c_blue_empl = NULL) => 0.1583586977, 0.1583586977),
      (f_phone_ver_insurance_d > 3.5) => 0.0063920159,
      (f_phone_ver_insurance_d = NULL) => 0.0842107032, 0.0842107032),
   (C_INC_75K_P = NULL) => 0.0188028793, 0.0188028793),
(f_rel_criminal_count_i = NULL) => -0.0189763019, 0.0001791413);

// Tree: 93 
wFDN_FL_PSD_lgt_93 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0061761480,
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 5.65) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => 0.0282380834,
         (k_inq_per_ssn_i > 1.5) => 0.1086082963,
         (k_inq_per_ssn_i = NULL) => 0.0478419766, 0.0478419766),
      (c_vacant_p > 5.65) => 0.0008122952,
      (c_vacant_p = NULL) => 0.0434999342, 0.0203072830),
   (f_hh_collections_ct_i = NULL) => 0.0013195235, 0.0013195235),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < c_employees and c_employees <= 146.5) => -0.0274133269,
   (c_employees > 146.5) => 0.1265219159,
   (c_employees = NULL) => 0.0561174250, 0.0561174250),
(r_D33_eviction_count_i = NULL) => 0.0100869217, 0.0019433148);

// Tree: 94 
wFDN_FL_PSD_lgt_94 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 19.25) => 0.0169550797,
   (C_INC_50K_P > 19.25) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 535) => 0.1862255579,
      (f_mos_inq_banko_cm_fseen_d > 535) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 73) => -0.0301638126,
         (c_lux_prod > 73) => 0.1707162620,
         (c_lux_prod = NULL) => 0.0634590276, 0.0634590276),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0992659323, 0.0992659323),
   (C_INC_50K_P = NULL) => 0.0104773212, 0.0275789488),
(f_hh_members_ct_d > 1.5) => -0.0034238546,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0611401076,
   (c_rnt1000_p > 10.8) => 0.0611804879,
   (c_rnt1000_p = NULL) => -0.0050297427, -0.0050297427), 0.0023641466);

// Tree: 95 
wFDN_FL_PSD_lgt_95 := map(
(NULL < c_incollege and c_incollege <= 5.95) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => -0.0146189553,
   (f_srchfraudsrchcountyr_i > 5.5) => -0.1111286985,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0156031399, -0.0156031399),
(c_incollege > 5.95) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 4.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
         map(
         (NULL < c_employees and c_employees <= 79.5) => 0.0387398104,
         (c_employees > 79.5) => -0.0193596296,
         (c_employees = NULL) => -0.0070566933, -0.0070566933),
      (f_rel_criminal_count_i > 2.5) => 0.0350640052,
      (f_rel_criminal_count_i = NULL) => 0.0032951907, 0.0032951907),
   (f_inq_HighRiskCredit_count24_i > 4.5) => 0.0834298019,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0046176584, 0.0042542705),
(c_incollege = NULL) => 0.0138153156, -0.0057039731);

// Tree: 96 
wFDN_FL_PSD_lgt_96 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13913896975) => -0.0059980609,
   (f_add_curr_nhood_BUS_pct_i > 0.13913896975) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
         map(
         (NULL < c_rnt2000_p and c_rnt2000_p <= 12.75) => -0.0113418237,
         (c_rnt2000_p > 12.75) => 
            map(
            (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 3.5) => 0.1461269020,
            (f_rel_homeover300_count_d > 3.5) => 0.0342234248,
            (f_rel_homeover300_count_d = NULL) => 0.0808498736, 0.0808498736),
         (c_rnt2000_p = NULL) => 0.0084191635, 0.0084191635),
      (f_rel_felony_count_i > 0.5) => 0.0965158165,
      (f_rel_felony_count_i = NULL) => 0.0206996947, 0.0206996947),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0299377154, -0.0044400010),
(f_assoccredbureaucountmo_i > 0.5) => 0.1307729027,
(f_assoccredbureaucountmo_i = NULL) => 0.0192585505, -0.0035395562);

// Tree: 97 
wFDN_FL_PSD_lgt_97 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 34) => 
      map(
      (NULL < c_larceny and c_larceny <= 118.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 10.85) => -0.0363581717,
         (c_newhouse > 10.85) => 0.1322309068,
         (c_newhouse = NULL) => 0.0454811868, 0.0454811868),
      (c_larceny > 118.5) => 0.2173648995,
      (c_larceny = NULL) => 0.1074020274, 0.1074020274),
   (c_high_ed > 34) => -0.0247840241,
   (c_high_ed = NULL) => 0.0374439124, 0.0374439124),
(r_C10_M_Hdr_FS_d > 13.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 64.5) => -0.0274181297,
   (r_C13_max_lres_d > 64.5) => 0.0030247685,
   (r_C13_max_lres_d = NULL) => -0.0019947404, -0.0019947404),
(r_C10_M_Hdr_FS_d = NULL) => 0.0066052561, -0.0008463406);

// Tree: 98 
wFDN_FL_PSD_lgt_98 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 2.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1546.5) => 0.0501800063,
      (c_popover25 > 1546.5) => 0.2597980725,
      (c_popover25 = NULL) => 0.0955518821, 0.0955518821),
   (f_prevaddrageoldest_d > 2.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','6: Other']) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 3.485) => -0.0042370256,
         (c_hhsize > 3.485) => 0.1013205590,
         (c_hhsize = NULL) => 0.0001573549, 0.0006899329),
      (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly']) => 0.1827774396,
      (nf_seg_FraudPoint_3_0 = '') => 0.0068697670, 0.0068697670),
   (f_prevaddrageoldest_d = NULL) => 0.0161667795, 0.0161667795),
(f_hh_members_ct_d > 1.5) => -0.0093968861,
(f_hh_members_ct_d = NULL) => 0.0320239350, -0.0043965913);

// Tree: 99 
wFDN_FL_PSD_lgt_99 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0807755587,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 198.5) => 
      map(
      (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => -0.0028560813,
      (f_hh_age_65_plus_d > 0.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 233.45) => 0.0170476513,
         (c_cpiall > 233.45) => 0.1017006822,
         (c_cpiall = NULL) => 0.0247947669, 0.0247947669),
      (f_hh_age_65_plus_d = NULL) => 0.0029314112, 0.0029314112),
   (c_bel_edu > 198.5) => -0.1248054313,
   (c_bel_edu = NULL) => -0.0110490757, 0.0020624598),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 93.5) => 0.0507135665,
   (c_apt20 > 93.5) => -0.0396134211,
   (c_apt20 = NULL) => 0.0055500727, 0.0055500727), 0.0024817069);

// Tree: 100 
wFDN_FL_PSD_lgt_100 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_rape and c_rape <= 57.5) => 0.1938190552,
   (c_rape > 57.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 229.5) => 0.0743861075,
      (r_C21_M_Bureau_ADL_FS_d > 229.5) => -0.0771802427,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0053972860, 0.0053972860),
   (c_rape = NULL) => 0.0624673411, 0.0624673411),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.45) => -0.0193392566,
   (c_hh4_p > 12.45) => 
      map(
      (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 0.5) => 0.0004451158,
      (f_inq_QuizProvider_count24_i > 0.5) => 0.0697812896,
      (f_inq_QuizProvider_count24_i = NULL) => 0.0049670401, 0.0049670401),
   (c_hh4_p = NULL) => -0.0178774781, -0.0056672944),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0304957940, -0.0042681648);

// Tree: 101 
wFDN_FL_PSD_lgt_101 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 3.85) => -0.0666592320,
   (C_OWNOCC_P > 3.85) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0037163380,
      (r_P85_Phn_Disconnected_i > 0.5) => 
         map(
         (NULL < c_high_hval and c_high_hval <= 2.5) => -0.0280632703,
         (c_high_hval > 2.5) => 0.1625986857,
         (c_high_hval = NULL) => 0.0699405388, 0.0699405388),
      (r_P85_Phn_Disconnected_i = NULL) => -0.0024028998, -0.0024028998),
   (C_OWNOCC_P = NULL) => 0.0239477953, -0.0028772309),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => -0.0160960315,
   (f_addrs_per_ssn_i > 7.5) => 0.2431543541,
   (f_addrs_per_ssn_i = NULL) => 0.0723541001, 0.0723541001),
(f_nae_nothing_found_i = NULL) => -0.0018690065, -0.0018690065);

// Tree: 102 
wFDN_FL_PSD_lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0105165699,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 44) => -0.1070992963,
   (f_mos_inq_banko_am_fseen_d > 44) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
         map(
         (NULL < c_food and c_food <= 89.6) => 
            map(
            (NULL < r_I60_inq_mortgage_recency_d and r_I60_inq_mortgage_recency_d <= 61.5) => -0.0494418577,
            (r_I60_inq_mortgage_recency_d > 61.5) => 0.0202086881,
            (r_I60_inq_mortgage_recency_d = NULL) => 0.0119788351, 0.0119788351),
         (c_food > 89.6) => 0.1363000298,
         (c_food = NULL) => 0.0372654977, 0.0136580892),
      (f_addrs_per_ssn_c6_i > 1.5) => 0.1536834086,
      (f_addrs_per_ssn_c6_i = NULL) => 0.0157758851, 0.0157758851),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0126771899, 0.0126771899),
(k_inq_per_ssn_i = NULL) => -0.0010671926, -0.0010671926);

// Tree: 103 
wFDN_FL_PSD_lgt_103 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < f_accident_count_i and f_accident_count_i <= 2.5) => -0.0036470074,
   (f_accident_count_i > 2.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.05) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 56.65) => 0.0030753524,
         (c_civ_emp > 56.65) => 0.2511465722,
         (c_civ_emp = NULL) => 0.1448303351, 0.1448303351),
      (c_pop_45_54_p > 16.05) => -0.0555044951,
      (c_pop_45_54_p = NULL) => 0.0769390871, 0.0769390871),
   (f_accident_count_i = NULL) => -0.0024744244, -0.0024744244),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0936173233,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0718154378,
   (k_comb_age_d > 27.5) => 0.0573882808,
   (k_comb_age_d = NULL) => -0.0059946754, -0.0059946754), -0.0019659996);

// Tree: 104 
wFDN_FL_PSD_lgt_104 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 198.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 5.5) => 0.1121766609,
      (r_C13_max_lres_d > 5.5) => -0.0016062097,
      (r_C13_max_lres_d = NULL) => -0.0153058092, -0.0010690530),
   (c_serv_empl > 198.5) => 0.1526393162,
   (c_serv_empl = NULL) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 15.5) => 0.1489293297,
      (r_C13_Curr_Addr_LRes_d > 15.5) => -0.0429763851,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0076253324, -0.0076253324), -0.0003337125),
(k_inq_per_phone_i > 6.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 17.3) => 0.1204504104,
   (c_newhouse > 17.3) => -0.0054983506,
   (c_newhouse = NULL) => 0.0649077891, 0.0649077891),
(k_inq_per_phone_i = NULL) => 0.0005046292, 0.0005046292);

// Tree: 105 
wFDN_FL_PSD_lgt_105 := map(
(NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 917749) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 15.45) => 
         map(
         (NULL < c_employees and c_employees <= 315.5) => 
            map(
            (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 12.5) => 0.0709600505,
            (f_rel_incomeover25_count_d > 12.5) => 0.1308967577,
            (f_rel_incomeover25_count_d = NULL) => 0.0877165493, 0.0877165493),
         (c_employees > 315.5) => -0.0191595097,
         (c_employees = NULL) => 0.0468521738, 0.0468521738),
      (c_hval_125k_p > 15.45) => -0.0770336887,
      (c_hval_125k_p = NULL) => 0.0282692944, 0.0282692944),
   (r_F00_dob_score_d > 92) => -0.0037903784,
   (r_F00_dob_score_d = NULL) => 0.0182754316, -0.0019961995),
(f_curraddrmedianvalue_d > 917749) => 0.2037013106,
(f_curraddrmedianvalue_d = NULL) => -0.0271884111, -0.0012827408);

// Tree: 106 
wFDN_FL_PSD_lgt_106 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.45) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 11.05) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => -0.0041432635,
      (c_hval_500k_p > 50.85) => 0.1359482324,
      (c_hval_500k_p = NULL) => -0.0032128866, -0.0032128866),
   (c_hh6_p > 11.05) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.1602583289,
      (r_Prop_Owner_History_d > 1.5) => 
         map(
         (NULL < c_hval_1000k_p and c_hval_1000k_p <= 0.75) => -0.0569104658,
         (c_hval_1000k_p > 0.75) => 0.1996445212,
         (c_hval_1000k_p = NULL) => 0.0199110840, 0.0199110840),
      (r_Prop_Owner_History_d = NULL) => 0.0668693727, 0.0668693727),
   (c_hh6_p = NULL) => -0.0016876271, -0.0016876271),
(c_hh6_p > 17.45) => -0.1204387673,
(c_hh6_p = NULL) => -0.0312233386, -0.0030015835);

// Tree: 107 
wFDN_FL_PSD_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0844610617,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 0.0635717226,
   (r_F00_dob_score_d > 65) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 8.5) => -0.0015748969,
      (r_D32_criminal_count_i > 8.5) => 
         map(
         (NULL < c_child and c_child <= 24.85) => 0.1397758169,
         (c_child > 24.85) => -0.0160150058,
         (c_child = NULL) => 0.0737627564, 0.0737627564),
      (r_D32_criminal_count_i = NULL) => -0.0008266762, -0.0008266762),
   (r_F00_dob_score_d = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 42.05) => -0.0585476963,
      (c_hh2_p > 42.05) => 0.1002545964,
      (c_hh2_p = NULL) => -0.0353802531, -0.0353802531), -0.0014755397),
(f_attr_arrest_recency_d = NULL) => 0.0031519331, -0.0008280375);

// Tree: 108 
wFDN_FL_PSD_lgt_108 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00940018095) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 1.5) => 0.1995441144,
   (f_phone_ver_insurance_d > 1.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1319420526) => 0.0126556390,
      (f_add_curr_nhood_BUS_pct_i > 0.1319420526) => 0.1811032972,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0225091232, 0.0225091232),
   (f_phone_ver_insurance_d = NULL) => 0.0332656796, 0.0332656796),
(f_add_curr_nhood_MFD_pct_i > 0.00940018095) => 0.0047646720,
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0271479533,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 80.05) => 0.1745651825,
      (c_fammar_p > 80.05) => -0.0297530638,
      (c_fammar_p = NULL) => 0.0582865057, 0.0582865057),
   (f_util_adl_count_n = NULL) => -0.0017532136, -0.0212241127), 0.0021781862);

// Tree: 109 
wFDN_FL_PSD_lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0095001538,
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => -0.0962231180,
   (f_mos_inq_banko_cm_lseen_d > 11.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 102.5) => 
         map(
         (NULL < c_med_inc and c_med_inc <= 60.5) => 0.1267170532,
         (c_med_inc > 60.5) => -0.0085412765,
         (c_med_inc = NULL) => 0.0260745993, 0.0260745993),
      (c_relig_indx > 102.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 19.5) => 0.0387143869,
         (r_C13_Curr_Addr_LRes_d > 19.5) => -0.0988780143,
         (r_C13_Curr_Addr_LRes_d = NULL) => -0.0584513809, -0.0584513809),
      (c_relig_indx = NULL) => -0.0144143887, -0.0144143887),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0288705497, -0.0288705497),
(r_D33_eviction_count_i = NULL) => 0.0174471739, 0.0080564086);

// Tree: 110 
wFDN_FL_PSD_lgt_110 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 64.5) => -0.0139466193,
   (k_comb_age_d > 64.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 27.7) => 0.1562684601,
      (C_OWNOCC_P > 27.7) => 0.0246790292,
      (C_OWNOCC_P = NULL) => 0.0344911114, 0.0344911114),
   (k_comb_age_d = NULL) => -0.0081287922, -0.0081287922),
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 11.5) => 0.0234573491,
      (f_inq_Collection_count_i > 11.5) => 0.1445159516,
      (f_inq_Collection_count_i = NULL) => 0.0254530164, 0.0254530164),
   (r_D34_unrel_liens_ct_i > 0.5) => -0.0236985748,
   (r_D34_unrel_liens_ct_i = NULL) => 0.0163225075, 0.0163225075),
(f_hh_criminals_i = NULL) => -0.0307134010, -0.0002721093);

// Tree: 111 
wFDN_FL_PSD_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1953116549,
   (r_C12_source_profile_d > 57.95) => -0.0369150598,
   (r_C12_source_profile_d = NULL) => 0.0782981940, 0.0782981940),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
      map(
      (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 8.5) => -0.0021048207,
      (r_C12_source_profile_index_d > 8.5) => 0.0481827302,
      (r_C12_source_profile_index_d = NULL) => 0.0026275978, 0.0026275978),
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 98.5) => -0.0339949255,
      (r_A50_pb_average_dollars_d > 98.5) => 0.1418199199,
      (r_A50_pb_average_dollars_d = NULL) => 0.0733729190, 0.0733729190),
   (f_hh_lienholders_i = NULL) => 0.0033709117, 0.0033709117),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0032306882, 0.0040870866);

// Tree: 112 
wFDN_FL_PSD_lgt_112 := map(
(NULL < c_easiqlife and c_easiqlife <= 93.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 4.5) => 0.1379218154,
   (c_no_teens > 4.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 18.55) => -0.0921886878,
      (c_fammar_p > 18.55) => -0.0188697223,
      (c_fammar_p = NULL) => -0.0199173898, -0.0199173898),
   (c_no_teens = NULL) => -0.0172491556, -0.0172491556),
(c_easiqlife > 93.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
      map(
      (NULL < c_mining and c_mining <= 2.35) => 0.0111174999,
      (c_mining > 2.35) => -0.0816535719,
      (c_mining = NULL) => 0.0083696642, 0.0083696642),
   (f_srchssnsrchcount_i > 22.5) => 0.0818272044,
   (f_srchssnsrchcount_i = NULL) => 0.0346097773, 0.0090624237),
(c_easiqlife = NULL) => 0.0136866010, 0.0004589351);

// Tree: 113 
wFDN_FL_PSD_lgt_113 := map(
(NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => -0.0407224041,
(f_mos_inq_banko_om_lseen_d > 5.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 0.95) => 0.1696409086,
      (c_pop_65_74_p > 0.95) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
            map(
            (NULL < c_no_teens and c_no_teens <= 36.5) => 0.1205684704,
            (c_no_teens > 36.5) => 0.0249957529,
            (c_no_teens = NULL) => 0.0449163314, 0.0449163314),
         (r_E57_br_source_count_d > 0.5) => -0.0088161280,
         (r_E57_br_source_count_d = NULL) => 0.0160711160, 0.0160711160),
      (c_pop_65_74_p = NULL) => 0.0338707951, 0.0209585061),
   (f_mos_inq_banko_cm_lseen_d > 44.5) => -0.0056162481,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0013585006, -0.0013585006),
(f_mos_inq_banko_om_lseen_d = NULL) => 0.0315766855, -0.0031346136);

// Tree: 114 
wFDN_FL_PSD_lgt_114 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1035261489,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => -0.0048745858,
   (f_srchssnsrchcount_i > 6.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 20.25) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 7.75) => -0.0324306779,
         (c_femdiv_p > 7.75) => -0.1455310167,
         (c_femdiv_p = NULL) => -0.0491662889, -0.0491662889),
      (c_hval_150k_p > 20.25) => 0.0522487039,
      (c_hval_150k_p = NULL) => -0.0332500526, -0.0332500526),
   (f_srchssnsrchcount_i = NULL) => -0.0119118503, -0.0060729838),
(C_INC_100K_P = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0232051005,
   (f_vardobcountnew_i > 0.5) => 0.1602984911,
   (f_vardobcountnew_i = NULL) => 0.0078769411, 0.0078769411), -0.0051974873);

// Tree: 115 
wFDN_FL_PSD_lgt_115 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.0779497855,
(r_F00_dob_score_d > 55) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0687849161,
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 17.5) => -0.0012656052,
      (f_rel_incomeover50_count_d > 17.5) => -0.0439496548,
      (f_rel_incomeover50_count_d = NULL) => 0.0125394477, -0.0026729727),
   (r_D33_Eviction_Recency_d = NULL) => -0.0021106384, -0.0021106384),
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => -0.0257038082,
   (f_hh_age_65_plus_d > 0.5) => 0.2074743557,
   (f_hh_age_65_plus_d = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 10.45) => -0.0613121140,
      (c_rnt1000_p > 10.45) => 0.0480663890,
      (c_rnt1000_p = NULL) => -0.0132232894, -0.0132232894), -0.0002330271), -0.0015946282);

// Tree: 116 
wFDN_FL_PSD_lgt_116 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1210980346,
   (f_mos_liens_rel_SC_lseen_d > 71.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.2010080418) => -0.0180144337,
         (f_add_curr_nhood_BUS_pct_i > 0.2010080418) => 0.0965108666,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0096752128, -0.0096752128),
      (r_C14_Addr_Stability_v2_d > 1.5) => -0.0011701632,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0017621604, -0.0017621604),
   (f_mos_liens_rel_SC_lseen_d = NULL) => 0.0053871077, -0.0021827134),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 16.25) => 0.0323202010,
   (C_INC_50K_P > 16.25) => 0.2019653361,
   (C_INC_50K_P = NULL) => 0.0834980630, 0.0834980630),
(f_adls_per_phone_c6_i = NULL) => -0.0009669042, -0.0009669042);

// Tree: 117 
wFDN_FL_PSD_lgt_117 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 3.5) => 0.0715492495,
(r_C21_M_Bureau_ADL_FS_d > 3.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 3.5) => 0.1135271055,
      (c_born_usa > 3.5) => 
         map(
         (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 2) => 0.1080851787,
         (r_I60_inq_banking_recency_d > 2) => 0.0070874615,
         (r_I60_inq_banking_recency_d = NULL) => 0.0092137292, 0.0092137292),
      (c_born_usa = NULL) => 0.0620133061, 0.0131802974),
   (f_phone_ver_experian_d > 0.5) => -0.0101023968,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 5.5) => -0.0174781162,
      (f_util_adl_count_n > 5.5) => 0.0889866097,
      (f_util_adl_count_n = NULL) => -0.0120216404, -0.0120216404), -0.0028360684),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0094265862, -0.0023459344);

// Tree: 118 
wFDN_FL_PSD_lgt_118 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < c_young and c_young <= 32.85) => 
      map(
      (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0013893092,
      (f_srchunvrfdaddrcount_i > 0.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0335020215) => 0.0910242564,
         (f_add_curr_nhood_BUS_pct_i > 0.0335020215) => -0.0086660646,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0418320893, 0.0418320893),
      (f_srchunvrfdaddrcount_i = NULL) => -0.0004116922, -0.0004116922),
   (c_young > 32.85) => -0.0344757364,
   (c_young = NULL) => -0.0155139958, -0.0053620478),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 28.65) => 0.1307473550,
   (c_hh2_p > 28.65) => -0.0010793042,
   (c_hh2_p = NULL) => 0.0612387529, 0.0612387529),
(f_inq_Communications_count_i = NULL) => -0.0196435683, -0.0048963473);

// Tree: 119 
wFDN_FL_PSD_lgt_119 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0063771200,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 23.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 69.5) => -0.0880791275,
      (c_mort_indx > 69.5) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.1053386117,
         (r_A50_pb_total_dollars_d > 39.5) => 
            map(
            (NULL < c_hval_250k_p and c_hval_250k_p <= 0.95) => 0.0832693989,
            (c_hval_250k_p > 0.95) => -0.0473330863,
            (c_hval_250k_p = NULL) => -0.0153712967, -0.0153712967),
         (r_A50_pb_total_dollars_d = NULL) => 0.0066894797, 0.0066894797),
      (c_mort_indx = NULL) => -0.0215345849, -0.0215345849),
   (f_rel_homeover50_count_d > 23.5) => -0.1401409307,
   (f_rel_homeover50_count_d = NULL) => -0.0379532320, -0.0379532320),
(f_srchssnsrchcount_i = NULL) => -0.0191985837, 0.0044569088);

// Tree: 120 
wFDN_FL_PSD_lgt_120 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 272.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 151.5) => 0.0007760880,
      (c_unattach > 151.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 155.5) => 0.0117493781,
         (c_sub_bus > 155.5) => 0.1321486370,
         (c_sub_bus = NULL) => 0.0562806109, 0.0562806109),
      (c_unattach = NULL) => 0.0033347539, 0.0033347539),
   (c_oldhouse > 272.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.35) => 0.0712308500,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.35) => -0.0457771381,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0389522085, -0.0300627006),
   (c_oldhouse = NULL) => -0.0365294288, -0.0006700298),
(f_rel_felony_count_i > 4.5) => 0.0824147249,
(f_rel_felony_count_i = NULL) => 0.0089026094, -0.0001879626);

// Tree: 121 
wFDN_FL_PSD_lgt_121 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 189) => -0.0017748038,
   (c_totcrime > 189) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 9.75) => 
         map(
         (NULL < c_rental and c_rental <= 164.5) => 
            map(
            (NULL < c_robbery and c_robbery <= 174.5) => -0.0153210611,
            (c_robbery > 174.5) => 0.1966524502,
            (c_robbery = NULL) => 0.0759453118, 0.0759453118),
         (c_rental > 164.5) => -0.0555602871,
         (c_rental = NULL) => 0.0164427785, 0.0164427785),
      (c_femdiv_p > 9.75) => 0.2040381390,
      (c_femdiv_p = NULL) => 0.0479065573, 0.0479065573),
   (c_totcrime = NULL) => 0.0064345944, -0.0003197454),
(nf_vf_lexid_hi_summary > 5) => -0.0679927450,
(nf_vf_lexid_hi_summary = NULL) => 0.0115484458, -0.0011001699);

// Tree: 122 
wFDN_FL_PSD_lgt_122 := map(
(NULL < c_popover25 and c_popover25 <= 327.5) => -0.1202195266,
(c_popover25 > 327.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 36.5) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 0.0052378805,
         (r_C14_Addr_Stability_v2_d > 4.5) => 0.0573140213,
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0357962657, 0.0357962657),
      (c_exp_prod > 36.5) => -0.0036746219,
      (c_exp_prod = NULL) => -0.0004262465, -0.0004262465),
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 80) => 0.1778646332,
      (c_new_homes > 80) => 0.0106694295,
      (c_new_homes = NULL) => 0.0649647791, 0.0649647791),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0147650095, 0.0007275672),
(c_popover25 = NULL) => -0.0001872483, -0.0001150581);

// Tree: 123 
wFDN_FL_PSD_lgt_123 := map(
(NULL < c_low_ed and c_low_ed <= 75.25) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 17.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 21.35) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 7.25) => 
            map(
            (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 14.5) => 0.1070466072,
            (f_rel_educationover8_count_d > 14.5) => -0.0221577580,
            (f_rel_educationover8_count_d = NULL) => 0.0761435130, 0.0761435130),
         (c_hval_300k_p > 7.25) => -0.0597593924,
         (c_hval_300k_p = NULL) => 0.0444251177, 0.0444251177),
      (c_white_col > 21.35) => 0.0016575985,
      (c_white_col = NULL) => 0.0037967033, 0.0037967033),
   (f_inq_HighRiskCredit_count_i > 17.5) => 0.0896998378,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0186753246, 0.0043429984),
(c_low_ed > 75.25) => -0.0428253220,
(c_low_ed = NULL) => 0.0142885382, 0.0028352740);

// Tree: 124 
wFDN_FL_PSD_lgt_124 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 36.45) => -0.0002470898,
      (c_hval_40k_p > 36.45) => -0.1090328213,
      (c_hval_40k_p = NULL) => 0.0004437113, -0.0007222260),
   (f_rel_under25miles_cnt_d > 10.5) => -0.0938299403,
   (f_rel_under25miles_cnt_d = NULL) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2654528774) => 0.0787370605,
      (f_add_curr_nhood_MFD_pct_i > 0.2654528774) => -0.0651123939,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0217164691, -0.0217164691), -0.0015504451),
(f_inq_QuizProvider_count_i > 5.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0262737093,
   (f_inq_Collection_count_i > 1.5) => 0.1900805895,
   (f_inq_Collection_count_i = NULL) => 0.0739172076, 0.0739172076),
(f_inq_QuizProvider_count_i = NULL) => 0.0114580803, -0.0005675928);

// Tree: 125 
wFDN_FL_PSD_lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 345.5) => -0.0075087034,
   (r_C21_M_Bureau_ADL_FS_d > 345.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 143.5) => 0.0117901530,
      (c_totcrime > 143.5) => 0.1158760744,
      (c_totcrime = NULL) => 0.0270511493, 0.0270511493),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0118462068, -0.0034422239),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 6.5) => -0.0802123374,
      (f_rel_incomeover25_count_d > 6.5) => 0.0852237438,
      (f_rel_incomeover25_count_d = NULL) => -0.0042744641, -0.0042744641),
   (r_C20_email_domain_free_count_i > 0.5) => 0.2492086591,
   (r_C20_email_domain_free_count_i = NULL) => 0.0741512536, 0.0741512536),
(f_nae_nothing_found_i = NULL) => -0.0023289395, -0.0023289395);

// Tree: 126 
wFDN_FL_PSD_lgt_126 := map(
(NULL < c_new_homes and c_new_homes <= 169.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0073827425,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID']) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 245389) => 0.1573735033,
         (r_A46_Curr_AVM_AutoVal_d > 245389) => -0.0565514633,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < c_work_home and c_work_home <= 80.5) => 0.1289191960,
            (c_work_home > 80.5) => -0.0134046772,
            (c_work_home = NULL) => 0.0474633944, 0.0474633944), 0.0433098076),
      (nf_seg_FraudPoint_3_0 = '') => 0.0085322588, 0.0085322588),
   (f_hh_collections_ct_i > 5.5) => 0.1128470258,
   (f_hh_collections_ct_i = NULL) => -0.0232005611, 0.0089385145),
(c_new_homes > 169.5) => -0.0211684179,
(c_new_homes = NULL) => 0.0213530657, 0.0029151786);

// Tree: 127 
wFDN_FL_PSD_lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < c_highinc and c_highinc <= 0.55) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => -0.1083010248,
      (r_I60_inq_hiRiskCred_recency_d > 549) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.5) => -0.0525654085,
         (c_pop_45_54_p > 17.5) => 0.0788350834,
         (c_pop_45_54_p = NULL) => -0.0313583671, -0.0313583671),
      (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0422306992, -0.0422306992),
   (c_highinc > 0.55) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.95) => -0.0002160036,
      (c_pop_6_11_p > 15.95) => 0.1328711963,
      (c_pop_6_11_p = NULL) => 0.0004576283, 0.0004576283),
   (c_highinc = NULL) => -0.0155230417, -0.0011889280),
(f_assocsuspicousidcount_i > 16.5) => 0.0811677422,
(f_assocsuspicousidcount_i = NULL) => -0.0289688475, -0.0009640175);

// Tree: 128 
wFDN_FL_PSD_lgt_128 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0107891565,
(f_corrrisktype_i > 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 15.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 13.55) => 0.0338146635,
         (c_newhouse > 13.55) => 0.2063958299,
         (c_newhouse = NULL) => 0.1028471300, 0.1028471300),
      (c_many_cars > 15.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => 0.0115337491,
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity']) => 0.0737184591,
         (nf_seg_FraudPoint_3_0 = '') => 0.0217354523, 0.0217354523),
      (c_many_cars = NULL) => -0.0231107621, 0.0242215331),
   (f_phone_ver_experian_d > 0.5) => -0.0207703565,
   (f_phone_ver_experian_d = NULL) => 0.0121004914, 0.0066737344),
(f_corrrisktype_i = NULL) => 0.0097801555, -0.0029894029);

// Tree: 129 
wFDN_FL_PSD_lgt_129 := map(
(NULL < c_hval_300k_p and c_hval_300k_p <= 33.85) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0122301137,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 53.05) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 2.45) => 
            map(
            (NULL < C_INC_25K_P and C_INC_25K_P <= 20.95) => 0.0254450330,
            (C_INC_25K_P > 20.95) => 0.1514481686,
            (C_INC_25K_P = NULL) => 0.0280231022, 0.0280231022),
         (c_low_hval > 2.45) => -0.0149444539,
         (c_low_hval = NULL) => 0.0089099480, 0.0089099480),
      (c_famotf18_p > 53.05) => 0.1062372604,
      (c_famotf18_p = NULL) => 0.0099258091, 0.0099258091),
   (k_inf_nothing_found_i = NULL) => -0.0032120739, -0.0032120739),
(c_hval_300k_p > 33.85) => -0.1020474844,
(c_hval_300k_p = NULL) => 0.0338561973, -0.0034544664);

// Tree: 130 
wFDN_FL_PSD_lgt_130 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 40.5) => -0.0018179899,
(c_famotf18_p > 40.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 9.25) => 0.0372323064,
   (c_hh3_p > 9.25) => 
      map(
      (NULL < c_rental and c_rental <= 67) => 0.0204654429,
      (c_rental > 67) => -0.0819244768,
      (c_rental = NULL) => -0.0524790097, -0.0524790097),
   (c_hh3_p = NULL) => -0.0340707137, -0.0340707137),
(c_famotf18_p = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.19251168555) => 0.0593908119,
   (f_add_curr_mobility_index_i > 0.19251168555) => -0.0849115730,
   (f_add_curr_mobility_index_i = NULL) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','5: Vuln Vic/Friendly','6: Other']) => 0.0018541756,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity']) => 0.2057840937,
      (nf_seg_FraudPoint_3_0 = '') => 0.0856393357, 0.0856393357), 0.0206106791), -0.0022275498);

// Tree: 131 
wFDN_FL_PSD_lgt_131 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 5175.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 32) => -0.1027020425,
   (c_fammar_p > 32) => -0.0136875740,
   (c_fammar_p = NULL) => -0.0153299074, -0.0153299074),
(r_A49_Curr_AVM_Chg_1yr_i > 5175.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 9.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 22.5) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 228278) => 0.2580564997,
         (f_prevaddrmedianvalue_d > 228278) => -0.0229601699,
         (f_prevaddrmedianvalue_d = NULL) => 0.1187916015, 0.1187916015),
      (c_many_cars > 22.5) => 0.0116507361,
      (c_many_cars = NULL) => 0.0156293486, 0.0156293486),
   (f_inq_Collection_count_i > 9.5) => 0.1344533173,
   (f_inq_Collection_count_i = NULL) => 0.0188121335, 0.0188121335),
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0011779994, 0.0007227460);

// Tree: 132 
wFDN_FL_PSD_lgt_132 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 12.5) => 
   map(
   (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 25.5) => 0.0282710980,
      (c_many_cars > 25.5) => -0.0011896693,
      (c_many_cars = NULL) => -0.0450096235, 0.0004849953),
   (f_srchphonesrchcountwk_i > 0.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 141) => 0.0237483503,
      (c_for_sale > 141) => 0.1825970134,
      (c_for_sale = NULL) => 0.0857986093, 0.0857986093),
   (f_srchphonesrchcountwk_i = NULL) => 0.0013764646, 0.0013764646),
(f_srchphonesrchcount_i > 12.5) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 660.5) => -0.1273456741,
   (c_hh00 > 660.5) => 0.0322460521,
   (c_hh00 = NULL) => -0.0611205360, -0.0611205360),
(f_srchphonesrchcount_i = NULL) => 0.0129084095, 0.0007404015);

// Tree: 133 
wFDN_FL_PSD_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 1.95) => -0.0054855876,
   (c_hval_500k_p > 1.95) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 8.95) => 0.0452810102,
      (c_rnt750_p > 8.95) => 0.2593995598,
      (c_rnt750_p = NULL) => 0.1534002778, 0.1534002778),
   (c_hval_500k_p = NULL) => 0.0688082662, 0.0688082662),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 135.5) => 0.0045020823,
   (c_medi_indx > 135.5) => -0.0493266409,
   (c_medi_indx = NULL) => 0.0137293178, 0.0017044823),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0532597184,
   (r_S66_adlperssn_count_i > 1.5) => 0.0718258838,
   (r_S66_adlperssn_count_i = NULL) => 0.0105094121, 0.0105094121), 0.0029232150);

// Tree: 134 
wFDN_FL_PSD_lgt_134 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 44.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0088853322,
      (r_C14_Addr_Stability_v2_d > 5.5) => 0.0118982046,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0001232607, 0.0001232607),
   (f_rel_count_i > 44.5) => -0.0946183426,
   (f_rel_count_i = NULL) => -0.0009844684, -0.0009844684),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 14.5) => 0.1941098028,
   (c_hh1_p > 14.5) => 0.0239573721,
   (c_hh1_p = NULL) => 0.0565536232, 0.0565536232),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.1) => -0.0766944133,
   (c_pop_55_64_p > 11.1) => 0.0654751926,
   (c_pop_55_64_p = NULL) => -0.0056096103, -0.0056096103), 0.0001796294);

// Tree: 135 
wFDN_FL_PSD_lgt_135 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 48.5) => 0.0066729398,
      (k_comb_age_d > 48.5) => 0.2143989999,
      (k_comb_age_d = NULL) => 0.0482181518, 0.0482181518),
   (f_adl_per_email_i > 0.5) => -0.0597929785,
   (f_adl_per_email_i = NULL) => -0.0000043712, 0.0007574066),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 8.85) => 0.0036435652,
   (C_INC_100K_P > 8.85) => -0.0943585783,
   (C_INC_100K_P = NULL) => -0.0672516024, -0.0672516024),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 83) => -0.0633943473,
   (c_asian_lang > 83) => 0.0472220305,
   (c_asian_lang = NULL) => -0.0102133965, -0.0102133965), -0.0008524022);

// Tree: 136 
wFDN_FL_PSD_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.65) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 208.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 5.5) => 0.1971814962,
         (f_prevaddrlenofres_d > 5.5) => 0.0518892831,
         (f_prevaddrlenofres_d = NULL) => 0.0808384834, 0.0808384834),
      (c_cpiall > 208.5) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 124.5) => -0.0125585478,
         (c_retired2 > 124.5) => 0.0515697783,
         (c_retired2 = NULL) => 0.0064376516, 0.0064376516),
      (c_cpiall = NULL) => 0.0152295757, 0.0152295757),
   (c_hh7p_p > 7.65) => 0.1291592620,
   (c_hh7p_p = NULL) => 0.0720711480, 0.0207968801),
(f_hh_members_ct_d > 1.5) => -0.0065749952,
(f_hh_members_ct_d = NULL) => 0.0016851638, -0.0013383244);

// Tree: 137 
wFDN_FL_PSD_lgt_137 := map(
(NULL < c_bel_edu and c_bel_edu <= 198.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 14445.5) => -0.0947431921,
   (r_A46_Curr_AVM_AutoVal_d > 14445.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.0797641869,
      (r_C10_M_Hdr_FS_d > 7.5) => -0.0016259221,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0008002759, -0.0008002759),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 183.5) => -0.0050648044,
      (c_bel_edu > 183.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.35) => 0.0321427538,
         (r_C12_source_profile_d > 75.35) => 0.1559619861,
         (r_C12_source_profile_d = NULL) => 0.0506444782, 0.0506444782),
      (c_bel_edu = NULL) => -0.0013175908, -0.0013175908), -0.0014409627),
(c_bel_edu > 198.5) => -0.1033488618,
(c_bel_edu = NULL) => 0.0189303524, -0.0014524672);

// Tree: 138 
wFDN_FL_PSD_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 87.5) => 0.0105197308,
   (c_old_homes > 87.5) => -0.0138975689,
   (c_old_homes = NULL) => -0.0148661101, -0.0003444971),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 53.7) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 54.45) => -0.0233053865,
         (c_sfdu_p > 54.45) => 0.1556486805,
         (c_sfdu_p = NULL) => 0.0654197392, 0.0654197392),
      (c_civ_emp > 53.7) => -0.0761483454,
      (c_civ_emp = NULL) => -0.0002627505, -0.0002627505),
   (f_vardobcountnew_i > 0.5) => 0.1378960983,
   (f_vardobcountnew_i = NULL) => 0.0392746692, 0.0392746692),
(f_curraddrcrimeindex_i = NULL) => -0.0214100633, 0.0004690884);

// Tree: 139 
wFDN_FL_PSD_lgt_139 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 8.5) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 82.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 120) => 0.2328489512,
      (c_for_sale > 120) => 0.0247004954,
      (c_for_sale = NULL) => 0.1210655212, 0.1210655212),
   (c_old_homes > 82.5) => -0.0297028679,
   (c_old_homes = NULL) => 0.0551043509, 0.0551043509),
(r_D32_Mos_Since_Crim_LS_d > 8.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 2.95) => -0.0364183523,
      (c_femdiv_p > 2.95) => 0.0767670569,
      (c_femdiv_p = NULL) => 0.0395043708, 0.0395043708),
   (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0056106562,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0047043519, -0.0047043519),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0215041329, -0.0035939614);

// Tree: 140 
wFDN_FL_PSD_lgt_140 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 5.25) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 7.5) => -0.0042712471,
   (f_rel_criminal_count_i > 7.5) => -0.0639216078,
   (f_rel_criminal_count_i = NULL) => -0.0063854674, -0.0070180602),
(c_femdiv_p > 5.25) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 29.15) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 24.55) => -0.0094616039,
      (C_INC_25K_P > 24.55) => 0.0945015699,
      (C_INC_25K_P = NULL) => -0.0068308141, -0.0068308141),
   (c_fammar18_p > 29.15) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -19985) => -0.0727163741,
      (r_A49_Curr_AVM_Chg_1yr_i > -19985) => 0.0435068872,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0475935068, 0.0376451591),
   (c_fammar18_p = NULL) => 0.0162576474, 0.0162576474),
(c_femdiv_p = NULL) => -0.0280815174, 0.0009246787);

// Tree: 141 
wFDN_FL_PSD_lgt_141 := map(
(NULL < c_lowinc and c_lowinc <= 72.85) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => -0.0949215831,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 49930.5) => 0.1375894553,
         (f_prevaddrmedianincome_d > 49930.5) => 0.0111898363,
         (f_prevaddrmedianincome_d = NULL) => 0.0647416475, 0.0647416475),
      (nf_seg_FraudPoint_3_0 = '') => 0.0427761438, 0.0427761438),
   (f_corrssnnamecount_d > 1.5) => -0.0042709108,
   (f_corrssnnamecount_d = NULL) => 0.0022973315, -0.0016116135),
(c_lowinc > 72.85) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => -0.1140750285,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => -0.0018922041,
   (nf_seg_FraudPoint_3_0 = '') => -0.0583502268, -0.0583502268),
(c_lowinc = NULL) => -0.0264592949, -0.0029384599);

// Tree: 142 
wFDN_FL_PSD_lgt_142 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 0.35) => 0.1013075549,
   (C_INC_125K_P > 0.35) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 73.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 
            map(
            (NULL < c_no_labfor and c_no_labfor <= 63.5) => 0.0201694035,
            (c_no_labfor > 63.5) => 0.1986054883,
            (c_no_labfor = NULL) => 0.1219222122, 0.1219222122),
         (r_I60_inq_recency_d > 4.5) => 0.0285580689,
         (r_I60_inq_recency_d = NULL) => 0.0440547237, 0.0440547237),
      (r_A50_pb_total_dollars_d > 73.5) => 0.0018831697,
      (r_A50_pb_total_dollars_d = NULL) => 0.0097378102, 0.0097378102),
   (C_INC_125K_P = NULL) => 0.0161281577, 0.0113412380),
(f_phone_ver_experian_d > 0.5) => -0.0051659588,
(f_phone_ver_experian_d = NULL) => -0.0102063038, -0.0009271997);

// Tree: 143 
wFDN_FL_PSD_lgt_143 := map(
(NULL < c_child and c_child <= 33.25) => 
   map(
   (NULL < c_child and c_child <= 32.55) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 0.0018417801,
      (f_assocsuspicousidcount_i > 15.5) => 0.0905650437,
      (f_assocsuspicousidcount_i = NULL) => 0.0113968418, 0.0024002078),
   (c_child > 32.55) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 822) => 0.1848504628,
      (c_popover25 > 822) => 0.0284972519,
      (c_popover25 = NULL) => 0.0758770127, 0.0758770127),
   (c_child = NULL) => 0.0034592289, 0.0034592289),
(c_child > 33.25) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 33.5) => 0.0758692735,
   (r_C13_max_lres_d > 33.5) => -0.0459146359,
   (r_C13_max_lres_d = NULL) => -0.0371125626, -0.0371125626),
(c_child = NULL) => -0.0079843801, 0.0002077544);

// Tree: 144 
wFDN_FL_PSD_lgt_144 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < c_rape and c_rape <= 53.5) => -0.0173172960,
   (c_rape > 53.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
            map(
            (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0628363070,
            (r_F00_dob_score_d > 92) => 0.0206930204,
            (r_F00_dob_score_d = NULL) => -0.0317933108, 0.0200721173),
         (f_corrphonelastnamecount_d > 0.5) => -0.0050211824,
         (f_corrphonelastnamecount_d = NULL) => 0.0059943453, 0.0059943453),
      (f_prevaddrcartheftindex_i > 194.5) => -0.0794338199,
      (f_prevaddrcartheftindex_i = NULL) => 0.0040145120, 0.0040145120),
   (c_rape = NULL) => -0.0096324873, -0.0038464650),
(r_C14_addrs_10yr_i > 10.5) => 0.1102403391,
(r_C14_addrs_10yr_i = NULL) => -0.0177617639, -0.0035042781);

// Tree: 145 
wFDN_FL_PSD_lgt_145 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 444.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 71.05) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 22.05) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0031354049,
         (r_F04_curr_add_occ_index_d > 2) => 0.0261600872,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0030553617, 0.0030553617),
      (c_pop_25_34_p > 22.05) => -0.0298270621,
      (c_pop_25_34_p = NULL) => -0.0013433059, -0.0013433059),
   (c_low_hval > 71.05) => -0.0839526999,
   (c_low_hval = NULL) => 0.0053010639, -0.0018000205),
(f_prevaddrageoldest_d > 444.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.85) => 0.2323490814,
   (c_pop_35_44_p > 14.85) => -0.0302079583,
   (c_pop_35_44_p = NULL) => 0.1034574437, 0.1034574437),
(f_prevaddrageoldest_d = NULL) => -0.0165459066, -0.0009811023);

// Tree: 146 
wFDN_FL_PSD_lgt_146 := map(
(NULL < c_white_col and c_white_col <= 11.15) => 0.0782292041,
(c_white_col > 11.15) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 12.55) => 
      map(
      (NULL < c_rental and c_rental <= 87.5) => 0.0443146435,
      (c_rental > 87.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 43.5) => -0.0524042023,
         (r_C13_Curr_Addr_LRes_d > 43.5) => -0.1405090834,
         (r_C13_Curr_Addr_LRes_d = NULL) => -0.0975310926, -0.0975310926),
      (c_rental = NULL) => -0.0481934453, -0.0481934453),
   (c_hh2_p > 12.55) => 
      map(
      (NULL < r_L75_Add_Curr_Drop_Delivery_i and r_L75_Add_Curr_Drop_Delivery_i <= 0.5) => -0.0017115857,
      (r_L75_Add_Curr_Drop_Delivery_i > 0.5) => 0.0913284810,
      (r_L75_Add_Curr_Drop_Delivery_i = NULL) => -0.0096039059, -0.0009497742),
   (c_hh2_p = NULL) => -0.0019202719, -0.0019202719),
(c_white_col = NULL) => -0.0027294423, -0.0015162005);

// Tree: 147 
wFDN_FL_PSD_lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0092915262,
   (c_sub_bus > 118.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 181.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.85) => 0.0050989219,
         (r_C12_source_profile_d > 78.85) => 0.0778788369,
         (r_C12_source_profile_d = NULL) => 0.0106813140, 0.0106813140),
      (c_born_usa > 181.5) => 0.0940621441,
      (c_born_usa = NULL) => 0.0123689320, 0.0123689320),
   (c_sub_bus = NULL) => -0.0317057259, -0.0004426508),
(f_prevaddrcartheftindex_i > 194.5) => -0.0754069121,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 408) => -0.0528538513,
   (c_families > 408) => 0.0774696388,
   (c_families = NULL) => 0.0129284818, 0.0129284818), -0.0018131923);

// Tree: 148 
wFDN_FL_PSD_lgt_148 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0036918869,
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_assault and c_assault <= 138.5) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 181.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.33382363505) => 
            map(
            (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0902399481,
            (f_phone_ver_experian_d > 0.5) => 0.0294629917,
            (f_phone_ver_experian_d = NULL) => 0.0296131312, 0.0469880512),
         (f_add_curr_mobility_index_i > 0.33382363505) => -0.0548737737,
         (f_add_curr_mobility_index_i = NULL) => 0.0232992547, 0.0232992547),
      (c_rich_blk > 181.5) => 0.1394582239,
      (c_rich_blk = NULL) => 0.0406092188, 0.0406092188),
   (c_assault > 138.5) => -0.0368914464,
   (c_assault = NULL) => 0.0237302395, 0.0237302395),
(k_inq_per_phone_i = NULL) => -0.0022651148, -0.0022651148);

// Tree: 149 
wFDN_FL_PSD_lgt_149 := map(
(NULL < c_hhsize and c_hhsize <= 4.295) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 13.35) => -0.0027639848,
      (c_hval_200k_p > 13.35) => 0.0294601259,
      (c_hval_200k_p = NULL) => 0.0018700485, 0.0018700485),
   (k_inq_adls_per_phone_i > 3.5) => -0.0897010683,
   (k_inq_adls_per_phone_i = NULL) => 0.0014736368, 0.0014736368),
(c_hhsize > 4.295) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 1.75) => 0.1812689178,
   (c_femdiv_p > 1.75) => 0.0021625843,
   (c_femdiv_p = NULL) => 0.0754974610, 0.0754974610),
(c_hhsize = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0210664287,
   (f_vardobcountnew_i > 0.5) => 0.1376072343,
   (f_vardobcountnew_i = NULL) => 0.0047054083, 0.0047054083), 0.0022950032);

// Tree: 150 
wFDN_FL_PSD_lgt_150 := map(
(NULL < c_unempl and c_unempl <= 22.5) => -0.0786132924,
(c_unempl > 22.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.8) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 7.25) => 0.1678058637,
         (c_pop_65_74_p > 7.25) => -0.0587354679,
         (c_pop_65_74_p = NULL) => 0.0936650643, 0.0936650643),
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.8) => -0.0505828519,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 4.05) => 0.0982870201,
         (c_hh6_p > 4.05) => -0.0594578732,
         (c_hh6_p = NULL) => 0.0637012414, 0.0637012414), 0.0479996030),
   (f_corrssnnamecount_d > 1.5) => -0.0009261791,
   (f_corrssnnamecount_d = NULL) => -0.0134953082, 0.0017558493),
(c_unempl = NULL) => 0.0285167276, -0.0006355383);

// Tree: 151 
wFDN_FL_PSD_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => -0.0020127330,
      (k_inq_per_phone_i > 6.5) => 
         map(
         (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.85) => 0.1248963678,
         (c_pop_0_5_p > 7.85) => 0.0071663128,
         (c_pop_0_5_p = NULL) => 0.0580256966, 0.0580256966),
      (k_inq_per_phone_i = NULL) => -0.0014058951, -0.0014058951),
   (k_inq_adls_per_phone_i > 3.5) => -0.0947711375,
   (k_inq_adls_per_phone_i = NULL) => -0.0018382796, -0.0018382796),
(r_C14_addrs_10yr_i > 10.5) => 0.1106352277,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 28.5) => -0.0764684916,
   (k_comb_age_d > 28.5) => 0.0547348943,
   (k_comb_age_d = NULL) => -0.0078575467, -0.0078575467), -0.0014289361);

// Tree: 152 
wFDN_FL_PSD_lgt_152 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3103939173) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 14.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 173.5) => 0.0050788435,
         (r_pb_order_freq_d > 173.5) => -0.0250057916,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 5.5) => 0.0142608124,
            (k_inq_per_ssn_i > 5.5) => 0.1674452924,
            (k_inq_per_ssn_i = NULL) => 0.0176790188, 0.0176790188), 0.0047793092),
      (f_srchfraudsrchcount_i > 14.5) => 0.0782551257,
      (f_srchfraudsrchcount_i = NULL) => 0.0054530177, 0.0054530177),
   (f_add_curr_mobility_index_i > 0.3103939173) => -0.0149159747,
   (f_add_curr_mobility_index_i = NULL) => 0.0446370994, -0.0000087017),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0819815544,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0005726134, -0.0003338739);

// Tree: 153 
wFDN_FL_PSD_lgt_153 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0088623418,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 20.35) => 0.0055775384,
   (c_pop_45_54_p > 20.35) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 122.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 14.9) => -0.0168396255,
         (c_rnt1000_p > 14.9) => 0.1409230907,
         (c_rnt1000_p = NULL) => 0.0354775734, 0.0354775734),
      (c_no_teens > 122.5) => 
         map(
         (NULL < c_retail and c_retail <= 4.25) => 0.0190256787,
         (c_retail > 4.25) => 0.2556349764,
         (c_retail = NULL) => 0.1711316558, 0.1711316558),
      (c_no_teens = NULL) => 0.0713784648, 0.0713784648),
   (c_pop_45_54_p = NULL) => 0.0142106461, 0.0142106461),
(f_hh_criminals_i = NULL) => -0.0008097066, -0.0014104112);

// Tree: 154 
wFDN_FL_PSD_lgt_154 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 18.75) => 
   map(
   (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 5.5) => 0.0025836138,
   (f_dl_addrs_per_adl_i > 5.5) => 0.1424697755,
   (f_dl_addrs_per_adl_i = NULL) => -0.0172210617, 0.0031873340),
(c_hval_80k_p > 18.75) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 59.5) => -0.1094623736,
   (c_born_usa > 59.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 10.25) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 570.5) => 0.0665888273,
         (c_hh00 > 570.5) => -0.0671858374,
         (c_hh00 = NULL) => 0.0222436345, 0.0222436345),
      (c_hval_60k_p > 10.25) => -0.0543779330,
      (c_hval_60k_p = NULL) => -0.0136481130, -0.0136481130),
   (c_born_usa = NULL) => -0.0334139919, -0.0334139919),
(c_hval_80k_p = NULL) => -0.0054411530, 0.0005001131);

// Tree: 155 
wFDN_FL_PSD_lgt_155 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 19.5) => -0.0991227788,
(f_mos_liens_unrel_OT_fseen_d > 19.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 196.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0035649990,
      (f_hh_collections_ct_i > 4.5) => 
         map(
         (NULL < c_employees and c_employees <= 223.5) => -0.0223604577,
         (c_employees > 223.5) => 0.1631983940,
         (c_employees = NULL) => 0.0533778491, 0.0533778491),
      (f_hh_collections_ct_i = NULL) => -0.0026412448, -0.0026412448),
   (c_rich_wht > 196.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 73) => 0.1313010045,
      (r_pb_order_freq_d > 73) => -0.0401245665,
      (r_pb_order_freq_d = NULL) => 0.0397771827, 0.0397771827),
   (c_rich_wht = NULL) => 0.0135463297, -0.0017235203),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0265363200, -0.0020233394);

// Tree: 156 
wFDN_FL_PSD_lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0016910712,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 57) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => -0.0880686633,
      (f_varrisktype_i > 1.5) => 0.0701184490,
      (f_varrisktype_i = NULL) => 0.0068436041, 0.0068436041),
   (f_prevaddrcartheftindex_i > 57) => 
      map(
      (NULL < c_finance and c_finance <= 8.35) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 1.25) => -0.0052645281,
         (c_pop_75_84_p > 1.25) => -0.1051297413,
         (c_pop_75_84_p = NULL) => -0.0825121843, -0.0825121843),
      (c_finance > 8.35) => 0.0287430950,
      (c_finance = NULL) => -0.0635409083, -0.0635409083),
   (f_prevaddrcartheftindex_i = NULL) => -0.0427975053, -0.0427975053),
(f_srchssnsrchcount_i = NULL) => 0.0108142351, 0.0000302675);

// Tree: 157 
wFDN_FL_PSD_lgt_157 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 20986.5) => 0.0671516941,
      (r_A46_Curr_AVM_AutoVal_d > 20986.5) => 0.0044686177,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 1.5) => -0.0127912735,
         (f_divssnidmsrcurelcount_i > 1.5) => 
            map(
            (NULL < c_rnt1250_p and c_rnt1250_p <= 11.05) => 0.0152123348,
            (c_rnt1250_p > 11.05) => 0.2339166128,
            (c_rnt1250_p = NULL) => 0.0724261122, 0.0724261122),
         (f_divssnidmsrcurelcount_i = NULL) => -0.0084651186, -0.0084651186), -0.0006236594),
   (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0733648295,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0248451859, -0.0003821816),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0777420843,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0000618992, -0.0000618992);

// Tree: 158 
wFDN_FL_PSD_lgt_158 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 1.5) => 0.1548140033,
      (r_wealth_index_d > 1.5) => -0.0055724602,
      (r_wealth_index_d = NULL) => 0.0738713021, 0.0738713021),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => -0.0024343786,
      (k_inq_per_phone_i > 9.5) => 0.0754512337,
      (k_inq_per_phone_i = NULL) => -0.0019292429, -0.0019292429),
   (r_D33_Eviction_Recency_d = NULL) => -0.0012773656, -0.0012773656),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 543) => -0.1648328948,
   (r_A50_pb_total_dollars_d > 543) => -0.0100644857,
   (r_A50_pb_total_dollars_d = NULL) => -0.0736679415, -0.0736679415),
(r_I60_inq_comm_count12_i = NULL) => 0.0035316297, -0.0020737827);

// Tree: 159 
wFDN_FL_PSD_lgt_159 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1147711474,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 17.5) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 0.0052823307,
      (f_rel_ageover50_count_d > 1.5) => -0.0307465481,
      (f_rel_ageover50_count_d = NULL) => 0.0008431820, 0.0008431820),
   (f_rel_homeover500_count_d > 17.5) => 0.1131794615,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.45) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 106.5) => -0.0140051668,
         (c_easiqlife > 106.5) => 0.1612004149,
         (c_easiqlife = NULL) => 0.0707254014, 0.0707254014),
      (c_bigapt_p > 1.45) => -0.0403650222,
      (c_bigapt_p = NULL) => 0.0027974991, 0.0027974991), 0.0014309658),
(C_INC_100K_P = NULL) => 0.0060480375, 0.0020952199);

// Tree: 160 
wFDN_FL_PSD_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.55) => -0.0044769397,
(r_C12_source_profile_d > 79.55) => 
   map(
   (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 84.15) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 62500) => 0.0508621812,
         (k_estimated_income_d > 62500) => 
            map(
            (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.2752634555,
            (k_nap_phn_verd_d > 0.5) => 0.1450233540,
            (k_nap_phn_verd_d = NULL) => 0.2004633972, 0.2004633972),
         (k_estimated_income_d = NULL) => 0.0891683749, 0.0891683749),
      (c_fammar_p > 84.15) => -0.0069014499,
      (c_fammar_p = NULL) => 0.0522972268, 0.0522972268),
   (r_D31_MostRec_Bk_i > 0.5) => -0.0684633456,
   (r_D31_MostRec_Bk_i = NULL) => 0.0346459488, 0.0346459488),
(r_C12_source_profile_d = NULL) => -0.0088986380, -0.0010492502);

// Tree: 161 
wFDN_FL_PSD_lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => -0.1045925957,
   (r_I60_inq_hiRiskCred_recency_d > 549) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 117.5) => -0.0557093566,
      (c_mort_indx > 117.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 4.85) => -0.0507245520,
         (c_incollege > 4.85) => 0.1531974958,
         (c_incollege = NULL) => 0.0548521111, 0.0548521111),
      (c_mort_indx = NULL) => -0.0254391295, -0.0254391295),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0396988379, -0.0396988379),
(f_mos_inq_banko_cm_fseen_d > 25.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0039148418,
   (f_hh_tot_derog_i > 4.5) => 0.0367165224,
   (f_hh_tot_derog_i = NULL) => -0.0019368926, -0.0019368926),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0098634511, -0.0039461238);

// Tree: 162 
wFDN_FL_PSD_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 9.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0044183191,
   (f_hh_payday_loan_users_i > 0.5) => 0.0273653650,
   (f_hh_payday_loan_users_i = NULL) => -0.0015544137, -0.0015544137),
(r_D30_Derog_Count_i > 9.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 10.75) => 
      map(
      (NULL < c_rental and c_rental <= 114) => 0.0743587784,
      (c_rental > 114) => -0.0734372319,
      (c_rental = NULL) => 0.0100996435, 0.0100996435),
   (c_vacant_p > 10.75) => 0.1160626140,
   (c_vacant_p = NULL) => 0.0443817810, 0.0443817810),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 60.5) => 0.0660597338,
   (c_larceny > 60.5) => -0.0366211409,
   (c_larceny = NULL) => 0.0137126212, 0.0137126212), -0.0005601324);

// Tree: 163 
wFDN_FL_PSD_lgt_163 := map(
(NULL < c_civ_emp and c_civ_emp <= 42.25) => -0.0488304395,
(c_civ_emp > 42.25) => 
   map(
   (NULL < c_white_col and c_white_col <= 17.95) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 10.5) => 0.1568853859,
      (f_prevaddrlenofres_d > 10.5) => 
         map(
         (NULL < c_highinc and c_highinc <= 3.15) => -0.0515189860,
         (c_highinc > 3.15) => 0.0822184417,
         (c_highinc = NULL) => 0.0083518392, 0.0083518392),
      (f_prevaddrlenofres_d = NULL) => 0.0542838998, 0.0542838998),
   (c_white_col > 17.95) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 3.5) => -0.0408031998,
      (f_mos_inq_banko_om_lseen_d > 3.5) => 0.0022064698,
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0061425960, 0.0002543583),
   (c_white_col = NULL) => 0.0013966224, 0.0013966224),
(c_civ_emp = NULL) => -0.0053483449, -0.0003905708);

// Tree: 164 
wFDN_FL_PSD_lgt_164 := map(
(NULL < c_hh3_p and c_hh3_p <= 7.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 0.0187417085,
      (f_prevaddroccupantowned_i > 0.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04725068165) => 0.2029549234,
         (f_add_curr_nhood_BUS_pct_i > 0.04725068165) => 0.0531622492,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1177280570, 0.1177280570),
      (f_prevaddroccupantowned_i = NULL) => 0.0281345737, 0.0281345737),
   (f_rel_felony_count_i > 1.5) => 0.1032640423,
   (f_rel_felony_count_i = NULL) => 0.0314542479, 0.0314542479),
(c_hh3_p > 7.25) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 21.5) => -0.0823307694,
   (f_mos_inq_banko_am_lseen_d > 21.5) => 0.0009749253,
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0117097381, -0.0006197775),
(c_hh3_p = NULL) => 0.0381322941, 0.0036229465);

// Tree: 165 
wFDN_FL_PSD_lgt_165 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 9.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0059025211,
   (f_rel_ageover20_count_d > 20.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 128.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39.5) => 0.0331170803,
         (f_mos_inq_banko_cm_lseen_d > 39.5) => 0.1981526361,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.1236675622, 0.1236675622),
      (c_for_sale > 128.5) => -0.0213383849,
      (c_for_sale = NULL) => 0.0644504739, 0.0644504739),
   (f_rel_ageover20_count_d = NULL) => 0.0070324966, 0.0070324966),
(f_rel_incomeover50_count_d > 9.5) => -0.0202905559,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_rape and c_rape <= 19.5) => 0.1389575150,
   (c_rape > 19.5) => -0.0068635546,
   (c_rape = NULL) => 0.0185182698, 0.0185182698), 0.0021761054);

// Tree: 166 
wFDN_FL_PSD_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_health and c_health <= 2.3) => 0.1329716828,
   (c_health > 2.3) => -0.0001187184,
   (c_health = NULL) => 0.0416729535, 0.0416729535),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 8.25) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 27.15) => 0.0183520635,
      (c_hh3_p > 27.15) => 
         map(
         (NULL < c_preschl and c_preschl <= 104) => 0.2827130439,
         (c_preschl > 104) => 0.0543834716,
         (c_preschl = NULL) => 0.1453585355, 0.1453585355),
      (c_hh3_p = NULL) => 0.0389564088, 0.0389564088),
   (c_hh1_p > 8.25) => -0.0054002946,
   (c_hh1_p = NULL) => 0.0090943680, -0.0022209766),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0318308799, -0.0017428692);

// Tree: 167 
wFDN_FL_PSD_lgt_167 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.05) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
         map(
         (NULL < c_bargains and c_bargains <= 109.5) => 0.0338176095,
         (c_bargains > 109.5) => -0.0066079017,
         (c_bargains = NULL) => 0.0108294003, 0.0108294003),
      (k_estimated_income_d > 34500) => -0.0127635551,
      (k_estimated_income_d = NULL) => -0.0047090444, -0.0047090444),
   (c_hval_1000k_p > 41.05) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 4.4) => 0.2155133194,
      (c_famotf18_p > 4.4) => -0.0176750416,
      (c_famotf18_p = NULL) => 0.1006593506, 0.1006593506),
   (c_hval_1000k_p = NULL) => 0.0086300560, -0.0032498364),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0656001517,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0321171497, -0.0037965361);

// Tree: 168 
wFDN_FL_PSD_lgt_168 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 36.5) => -0.1215588810,
(f_mos_liens_rel_CJ_lseen_d > 36.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 35.05) => 
      map(
      (NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i <= 9) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0089886349,
         (f_rel_felony_count_i > 0.5) => 
            map(
            (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 0.0120946980,
            (f_idrisktype_i > 2.5) => 0.1158565968,
            (f_idrisktype_i = NULL) => 0.0154976730, 0.0154976730),
         (f_rel_felony_count_i = NULL) => -0.0053561728, -0.0053561728),
      (r_C12_NonDerog_Recency_i > 9) => 0.1173078946,
      (r_C12_NonDerog_Recency_i = NULL) => -0.0048324408, -0.0048324408),
   (c_hval_20k_p > 35.05) => 0.1089017641,
   (c_hval_20k_p = NULL) => -0.0000591225, -0.0042609089),
(f_mos_liens_rel_CJ_lseen_d = NULL) => 0.0300035261, -0.0044997895);

// Tree: 169 
wFDN_FL_PSD_lgt_169 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < c_assault and c_assault <= 80.5) => 0.1353195433,
   (c_assault > 80.5) => -0.0231683537,
   (c_assault = NULL) => 0.0599546692, 0.0599546692),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 37.25) => -0.0051727103,
   (c_hval_1001k_p > 37.25) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 92.5) => -0.0060845828,
      (c_cartheft > 92.5) => 0.2071910912,
      (c_cartheft = NULL) => 0.0738937950, 0.0738937950),
   (c_hval_1001k_p = NULL) => 0.0092192386, -0.0031511696),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 30.5) => -0.0763200656,
   (k_comb_age_d > 30.5) => 0.0333769622,
   (k_comb_age_d = NULL) => -0.0209284971, -0.0209284971), -0.0025763387);

// Tree: 170 
wFDN_FL_PSD_lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 37.15) => 
      map(
      (NULL < c_amus_indx and c_amus_indx <= 168.5) => 
         map(
         (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => -0.0004836083,
         (r_D32_criminal_count_i > 5.5) => 0.0421982705,
         (r_D32_criminal_count_i = NULL) => 0.0004369185, 0.0004369185),
      (c_amus_indx > 168.5) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 59.5) => 0.2463690657,
         (f_prevaddrcartheftindex_i > 59.5) => 0.0076602201,
         (f_prevaddrcartheftindex_i = NULL) => 0.1135224038, 0.1135224038),
      (c_amus_indx = NULL) => 0.0015095703, 0.0015095703),
   (c_hh3_p > 37.15) => -0.0889659925,
   (c_hh3_p = NULL) => -0.0185352507, 0.0003650292),
(f_util_adl_count_n > 13.5) => 0.1188617548,
(f_util_adl_count_n = NULL) => 0.0125465977, 0.0013707641);

// Tree: 171 
wFDN_FL_PSD_lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 47.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 11.45) => 0.0076992917,
   (c_bigapt_p > 11.45) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 18.25) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 4.4) => -0.0161842583,
         (c_hval_175k_p > 4.4) => 
            map(
            (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0484455802,
            (f_srchvelocityrisktype_i > 4.5) => 0.1904295318,
            (f_srchvelocityrisktype_i = NULL) => 0.0967015637, 0.0967015637),
         (c_hval_175k_p = NULL) => 0.0328825905, 0.0328825905),
      (C_INC_25K_P > 18.25) => 0.1717377373,
      (C_INC_25K_P = NULL) => 0.0528155678, 0.0528155678),
   (c_bigapt_p = NULL) => 0.0382574795, 0.0172573365),
(f_mos_inq_banko_cm_lseen_d > 47.5) => -0.0012481919,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0187352003, 0.0020845639);

// Tree: 172 
wFDN_FL_PSD_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 27878) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 0.5) => -0.0027854871,
      (f_srchssnsrchcount_i > 0.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 0.5) => 
            map(
            (NULL < c_pop_0_5_p and c_pop_0_5_p <= 4.95) => -0.0125144136,
            (c_pop_0_5_p > 4.95) => 0.1534025712,
            (c_pop_0_5_p = NULL) => 0.1021191395, 0.1021191395),
         (k_inq_per_phone_i > 0.5) => -0.0099074637,
         (k_inq_per_phone_i = NULL) => 0.0593224596, 0.0593224596),
      (f_srchssnsrchcount_i = NULL) => 0.0295397016, 0.0295397016),
   (c_med_hhinc > 27878) => -0.0047939610,
   (c_med_hhinc = NULL) => -0.0033464578, -0.0033464578),
(c_pop_0_5_p > 20) => 0.1415482311,
(c_pop_0_5_p = NULL) => -0.0041461636, -0.0027139088);

// Tree: 173 
wFDN_FL_PSD_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0078393787,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 3.05) => 0.1833768948,
      (c_construction > 3.05) => 0.0276809652,
      (c_construction = NULL) => 0.0979508095, 0.0979508095),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 12.5) => 0.1917123750,
      (c_serv_empl > 12.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 22.45) => 0.0026831208,
         (C_INC_50K_P > 22.45) => 0.0986689055,
         (C_INC_50K_P = NULL) => 0.0090105420, 0.0090105420),
      (c_serv_empl = NULL) => 0.0160039136, 0.0160039136),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0212790745, 0.0212790745),
(f_rel_felony_count_i = NULL) => 0.0071365087, -0.0035871840);

// Tree: 174 
wFDN_FL_PSD_lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 21.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 25.5) => 
            map(
            (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 0.1156222903,
            (r_C10_M_Hdr_FS_d > 15.5) => 0.0081937676,
            (r_C10_M_Hdr_FS_d = NULL) => 0.0463233278, 0.0463233278),
         (r_C13_max_lres_d > 25.5) => 0.0017643356,
         (r_C13_max_lres_d = NULL) => 0.0030907185, 0.0030907185),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0560911726,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0005861929, 0.0005861929),
   (f_srchssnsrchcount_i > 21.5) => 0.0867530198,
   (f_srchssnsrchcount_i = NULL) => 0.0010541543, 0.0010541543),
(f_srchphonesrchcount_i > 21.5) => -0.1151167096,
(f_srchphonesrchcount_i = NULL) => -0.0224149212, 0.0002464797);

// Tree: 175 
wFDN_FL_PSD_lgt_175 := map(
(NULL < c_retail and c_retail <= 13.15) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 18.5) => -0.0600496819,
   (f_mos_inq_banko_om_fseen_d > 18.5) => -0.0083105224,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0118105767, -0.0115519184),
(c_retail > 13.15) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0173411682,
      (r_C14_Addr_Stability_v2_d > 3.5) => 0.0175080080,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0088204413, 0.0088204413),
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_families and c_families <= 289) => 0.1859776770,
      (c_families > 289) => 0.0391197334,
      (c_families = NULL) => 0.0606395113, 0.0606395113),
   (f_hh_collections_ct_i = NULL) => 0.0143459123, 0.0143459123),
(c_retail = NULL) => 0.0087994140, -0.0013147718);

// Tree: 176 
wFDN_FL_PSD_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.35) => 
   map(
   (NULL < c_food and c_food <= 97.95) => 0.0058275735,
   (c_food > 97.95) => 0.1084823379,
   (c_food = NULL) => 0.0066593403, 0.0066593403),
(c_pop_18_24_p > 11.35) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.15) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0455603414,
      (f_varrisktype_i > 4.5) => -0.1340115665,
      (f_varrisktype_i = NULL) => -0.0495494686, -0.0495494686),
   (c_hval_175k_p > 2.15) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 15.5) => 0.0910941401,
      (r_C21_M_Bureau_ADL_FS_d > 15.5) => -0.0039112003,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0009625347, 0.0009625347),
   (c_hval_175k_p = NULL) => -0.0213379774, -0.0213379774),
(c_pop_18_24_p = NULL) => 0.0072109151, 0.0008633755);

// Tree: 177 
wFDN_FL_PSD_lgt_177 := map(
(NULL < c_med_hhinc and c_med_hhinc <= 23355.5) => 
   map(
   (NULL < r_C20_email_domain_ISP_count_i and r_C20_email_domain_ISP_count_i <= 0.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 83.5) => 0.0530348460,
      (c_span_lang > 83.5) => -0.0585240639,
      (c_span_lang = NULL) => -0.0187553784, -0.0187553784),
   (r_C20_email_domain_ISP_count_i > 0.5) => -0.1438292697,
   (r_C20_email_domain_ISP_count_i = NULL) => -0.0496970031, -0.0496970031),
(c_med_hhinc > 23355.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 13.85) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 2.75) => 0.1531971145,
      (c_hh6_p > 2.75) => -0.0047829664,
      (c_hh6_p = NULL) => 0.0756432566, 0.0756432566),
   (c_white_col > 13.85) => 0.0045420824,
   (c_white_col = NULL) => 0.0051886170, 0.0051886170),
(c_med_hhinc = NULL) => -0.0039329254, 0.0037231629);

// Tree: 178 
wFDN_FL_PSD_lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0149451926,
   (r_C13_Curr_Addr_LRes_d > 158.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 11.35) => 0.0113406730,
      (c_femdiv_p > 11.35) => 0.1665644436,
      (c_femdiv_p = NULL) => 0.0162684118, 0.0162684118),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0196658153, -0.0074188225),
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 14.65) => -0.0140762926,
   (c_hh3_p > 14.65) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 0.0344779962,
      (r_D30_Derog_Count_i > 5.5) => 0.1120848272,
      (r_D30_Derog_Count_i = NULL) => 0.0374854443, 0.0374854443),
   (c_hh3_p = NULL) => 0.0180313078, 0.0180313078),
(c_rnt1250_p = NULL) => -0.0002299395, -0.0003652233);

// Tree: 179 
wFDN_FL_PSD_lgt_179 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.078796035) => 0.0070064158,
   (f_add_curr_nhood_VAC_pct_i > 0.078796035) => 
      map(
      (NULL < c_work_home and c_work_home <= 56.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 12.65) => 0.2083212445,
         (C_INC_50K_P > 12.65) => 0.0706523351,
         (C_INC_50K_P = NULL) => 0.1299923823, 0.1299923823),
      (c_work_home > 56.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 21.3) => 0.1809694999,
         (c_hh1_p > 21.3) => -0.0120883303,
         (c_hh1_p = NULL) => 0.0352921628, 0.0352921628),
      (c_work_home = NULL) => 0.0635318170, 0.0635318170),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0164555827, 0.0164555827),
(f_hh_members_ct_d > 1.5) => -0.0059733517,
(f_hh_members_ct_d = NULL) => 0.0401071371, -0.0014849991);

// Tree: 180 
wFDN_FL_PSD_lgt_180 := map(
(NULL < c_civ_emp and c_civ_emp <= 43.65) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 5.5) => -0.0538079879,
   (f_util_adl_count_n > 5.5) => 0.0650609780,
   (f_util_adl_count_n = NULL) => -0.0420387834, -0.0420387834),
(c_civ_emp > 43.65) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 75.8) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 1.5) => 0.0005373898,
      (f_srchfraudsrchcountmo_i > 1.5) => 0.0651824731,
      (f_srchfraudsrchcountmo_i = NULL) => -0.0098022695, 0.0009584588),
   (c_rnt1000_p > 75.8) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.2527701155,
      (f_phone_ver_insurance_d > 2.5) => 0.0331283629,
      (f_phone_ver_insurance_d = NULL) => 0.0923064517, 0.0923064517),
   (c_rnt1000_p = NULL) => 0.0024507965, 0.0024507965),
(c_civ_emp = NULL) => 0.0248929236, 0.0012034032);

// Tree: 181 
wFDN_FL_PSD_lgt_181 := map(
(NULL < c_rnt250_p and c_rnt250_p <= 18.35) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 6.45) => -0.0158373956,
      (c_lowrent > 6.45) => 
         map(
         (NULL < c_incollege and c_incollege <= 6.85) => 0.0282705884,
         (c_incollege > 6.85) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 259.35) => 0.1540254249,
            (c_oldhouse > 259.35) => 0.0072311680,
            (c_oldhouse = NULL) => 0.1095163791, 0.1095163791),
         (c_incollege = NULL) => 0.0548869267, 0.0548869267),
      (c_lowrent = NULL) => 0.0276948592, 0.0276948592),
   (k_estimated_income_d > 28500) => -0.0031384462,
   (k_estimated_income_d = NULL) => 0.0294769333, 0.0017440583),
(c_rnt250_p > 18.35) => -0.0372286220,
(c_rnt250_p = NULL) => -0.0236149868, -0.0022403322);

// Tree: 182 
wFDN_FL_PSD_lgt_182 := map(
(NULL < c_preschl and c_preschl <= 196.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0021362137,
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => -0.0339714220,
      (f_assocrisktype_i > 1.5) => 
         map(
         (NULL < c_hh5_p and c_hh5_p <= 6.65) => 0.1997710661,
         (c_hh5_p > 6.65) => 0.0352902227,
         (c_hh5_p = NULL) => 0.1250070464, 0.1250070464),
      (f_assocrisktype_i = NULL) => 0.0561710085, 0.0561710085),
   (f_inq_Other_count24_i = NULL) => -0.0138343791, 0.0028727877),
(c_preschl > 196.5) => -0.0780189229,
(c_preschl = NULL) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 1.5) => -0.0385976910,
   (f_hh_tot_derog_i > 1.5) => 0.1785413369,
   (f_hh_tot_derog_i = NULL) => -0.0001459882, -0.0001459882), 0.0017962142);

// Tree: 183 
wFDN_FL_PSD_lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < r_C22_stl_recency_d and r_C22_stl_recency_d <= 4.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.8233573598) => 
            map(
            (NULL < C_INC_15K_P and C_INC_15K_P <= 16.8) => 0.0327120076,
            (C_INC_15K_P > 16.8) => 0.1263152107,
            (C_INC_15K_P = NULL) => 0.0566023649, 0.0566023649),
         (f_add_curr_nhood_MFD_pct_i > 0.8233573598) => -0.0585996097,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0261152387, 0.0235645868),
      (r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0054387180,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0037544297, -0.0037544297),
   (r_C22_stl_recency_d > 4.5) => -0.0843607996,
   (r_C22_stl_recency_d = NULL) => -0.0040768552, -0.0040768552),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0920816256,
(f_srchfraudsrchcountyr_i = NULL) => 0.0018665645, -0.0046789560);

// Tree: 184 
wFDN_FL_PSD_lgt_184 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => -0.0011097678,
(f_util_adl_count_n > 7.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.13189985735) => 0.1721025351,
      (f_add_curr_nhood_MFD_pct_i > 0.13189985735) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => 0.0863164474,
         (f_rel_homeover300_count_d > 1.5) => -0.0854123775,
         (f_rel_homeover300_count_d = NULL) => 0.0004520349, 0.0004520349),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0558231640, 0.0558231640),
   (f_phone_ver_experian_d > 0.5) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 16.25) => -0.0607030699,
      (C_INC_100K_P > 16.25) => 0.1201963152,
      (C_INC_100K_P = NULL) => -0.0058850745, -0.0058850745),
   (f_phone_ver_experian_d = NULL) => 0.0787351788, 0.0249555199),
(f_util_adl_count_n = NULL) => 0.0034069030, 0.0000806429);

// Tree: 185 
wFDN_FL_PSD_lgt_185 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.15) => 
   map(
   (NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 0.0052126854,
   (r_D31_ALL_Bk_i > 1.5) => -0.0347510329,
   (r_D31_ALL_Bk_i = NULL) => -0.0013169626, 0.0016242294),
(c_hh6_p > 11.15) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 70328.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 73.4) => 
         map(
         (NULL < c_highrent and c_highrent <= 4.15) => 0.1267966450,
         (c_highrent > 4.15) => -0.0156977598,
         (c_highrent = NULL) => 0.0612492188, 0.0612492188),
      (c_fammar_p > 73.4) => -0.0735279065,
      (c_fammar_p = NULL) => 0.0073383686, 0.0073383686),
   (f_prevaddrmedianincome_d > 70328.5) => 0.1637047149,
   (f_prevaddrmedianincome_d = NULL) => 0.0487294603, 0.0487294603),
(c_hh6_p = NULL) => -0.0039332857, 0.0027511978);

// Tree: 186 
wFDN_FL_PSD_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 14.45) => 
      map(
      (NULL < c_robbery and c_robbery <= 108.5) => -0.0017644719,
      (c_robbery > 108.5) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => 0.0070948876,
         (f_assocsuspicousidcount_i > 1.5) => 
            map(
            (NULL < c_rental and c_rental <= 157.5) => 0.0432559834,
            (c_rental > 157.5) => 0.1253589215,
            (c_rental = NULL) => 0.0649118160, 0.0649118160),
         (f_assocsuspicousidcount_i = NULL) => 0.0371381484, 0.0371381484),
      (c_robbery = NULL) => 0.0141070369, 0.0141070369),
   (C_INC_75K_P > 14.45) => -0.0071907482,
   (C_INC_75K_P = NULL) => 0.0078862059, -0.0005870257),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0829942387,
(f_inq_PrepaidCards_count_i = NULL) => 0.0291627494, -0.0000323192);

// Tree: 187 
wFDN_FL_PSD_lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 2.45) => -0.0296387059,
   (c_unemp > 2.45) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 
         map(
         (NULL < c_unemp and c_unemp <= 13.95) => 0.0089270670,
         (c_unemp > 13.95) => -0.0824741205,
         (c_unemp = NULL) => 0.0083561226, 0.0083561226),
      (c_hval_80k_p > 19.25) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 7.5) => -0.0488285356,
         (f_rel_homeover150_count_d > 7.5) => 0.0699903448,
         (f_rel_homeover150_count_d = NULL) => -0.0388993812, -0.0388993812),
      (c_hval_80k_p = NULL) => 0.0048690386, 0.0048690386),
   (c_unemp = NULL) => -0.0110591277, -0.0018148371),
(f_rel_bankrupt_count_i > 7.5) => -0.0816712493,
(f_rel_bankrupt_count_i = NULL) => 0.0019264521, -0.0027937777);

// Tree: 188 
wFDN_FL_PSD_lgt_188 := map(
(NULL < c_sfdu_p and c_sfdu_p <= 0.05) => -0.0796530712,
(c_sfdu_p > 0.05) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 12.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 0.0018168659,
      (f_srchfraudsrchcount_i > 12.5) => 
         map(
         (NULL < c_food and c_food <= 22.75) => 0.1025717183,
         (c_food > 22.75) => -0.0070797051,
         (c_food = NULL) => 0.0616570080, 0.0616570080),
      (f_srchfraudsrchcount_i = NULL) => 0.0024840800, 0.0024840800),
   (f_inq_count24_i > 12.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 113.5) => 0.0148054391,
      (c_span_lang > 113.5) => -0.1314950223,
      (c_span_lang = NULL) => -0.0610145081, -0.0610145081),
   (f_inq_count24_i = NULL) => 0.0025825337, 0.0017746301),
(c_sfdu_p = NULL) => -0.0242348372, 0.0002864939);

// Tree: 189 
wFDN_FL_PSD_lgt_189 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0223986869,
(f_addrs_per_ssn_i > 4.5) => 
   map(
   (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 12.95) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 44.3) => -0.0263491662,
         (c_high_ed > 44.3) => 0.1983639375,
         (c_high_ed = NULL) => 0.0312406242, 0.0312406242),
      (C_INC_25K_P > 12.95) => 0.2054551586,
      (C_INC_25K_P = NULL) => 0.0662234624, 0.0662234624),
   (r_C20_email_verification_d > 1.5) => -0.0291053042,
   (r_C20_email_verification_d = NULL) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 0.0006759367,
      (f_inq_QuizProvider_count_i > 5.5) => 0.0970804002,
      (f_inq_QuizProvider_count_i = NULL) => 0.0018264991, 0.0018264991), 0.0031175444),
(f_addrs_per_ssn_i = NULL) => -0.0031986532, -0.0031986532);

// Tree: 190 
wFDN_FL_PSD_lgt_190 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 47645.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 177.5) => -0.0273619446,
   (c_unempl > 177.5) => -0.1065829860,
   (c_unempl = NULL) => -0.0406048650, -0.0406048650),
(r_A46_Curr_AVM_AutoVal_d > 47645.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.75) => -0.0039369855,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.75) => 0.1829997521,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0014745112, -0.0021108682),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 3.75) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 116.5) => 0.0102287688,
      (c_exp_prod > 116.5) => 0.2213887199,
      (c_exp_prod = NULL) => 0.0796240578, 0.0796240578),
   (c_pop_25_34_p > 3.75) => -0.0087587480,
   (c_pop_25_34_p = NULL) => -0.0002618451, -0.0049689367), -0.0043896391);

// Tree: 191 
wFDN_FL_PSD_lgt_191 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 5.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 640.5) => -0.1354183758,
   (c_popover25 > 640.5) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 2.5) => -0.0493332983,
      (f_assoccredbureaucount_i > 2.5) => 0.0667468043,
      (f_assoccredbureaucount_i = NULL) => -0.0226246021, -0.0226246021),
   (c_popover25 = NULL) => -0.0410058097, -0.0410058097),
(f_mos_inq_banko_cm_lseen_d > 5.5) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.85) => 
      map(
      (NULL < c_armforce and c_armforce <= 125.5) => 0.0144777210,
      (c_armforce > 125.5) => -0.0177702358,
      (c_armforce = NULL) => 0.0056408936, 0.0056408936),
   (c_manufacturing > 16.85) => -0.0449329216,
   (c_manufacturing = NULL) => -0.0310570646, 0.0010168865),
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0430634098, -0.0007115582);

// Tree: 192 
wFDN_FL_PSD_lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.0693001233,
(r_D32_Mos_Since_Fel_LS_d > 120) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 5.45) => 
      map(
      (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
         map(
         (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 35.35) => -0.0115235724,
            (c_famotf18_p > 35.35) => -0.0609401511,
            (c_famotf18_p = NULL) => -0.0130321439, -0.0130321439),
         (f_inq_Communications_count_i > 3.5) => 0.0797117971,
         (f_inq_Communications_count_i = NULL) => -0.0123153495, -0.0123153495),
      (k_inq_addrs_per_ssn_i > 2.5) => -0.1179964007,
      (k_inq_addrs_per_ssn_i = NULL) => -0.0129699645, -0.0129699645),
   (c_femdiv_p > 5.45) => 0.0116121399,
   (c_femdiv_p = NULL) => -0.0121701923, -0.0047942553),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0027025170, -0.0043374387);

// Tree: 193 
wFDN_FL_PSD_lgt_193 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 34.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.21049605035) => -0.0066132786,
   (f_add_curr_nhood_MFD_pct_i > 0.21049605035) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.85) => -0.0020663399,
      (c_pop_45_54_p > 13.85) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 1.35) => 0.1488493966,
         (C_INC_125K_P > 1.35) => 0.0292214531,
         (C_INC_125K_P = NULL) => 0.0335715601, 0.0335715601),
      (c_pop_45_54_p = NULL) => 0.0135226363, 0.0135226363),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0143389651, -0.0011323483),
(f_rel_ageover30_count_d > 34.5) => -0.0682104952,
(f_rel_ageover30_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 89.1) => -0.0381537064,
   (c_sfdu_p > 89.1) => 0.0748204041,
   (c_sfdu_p = NULL) => -0.0161758077, -0.0161758077), -0.0021714624);

// Tree: 194 
wFDN_FL_PSD_lgt_194 := map(
(NULL < c_hh1_p and c_hh1_p <= 44.55) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 0.0031784440,
      (r_I60_inq_hiRiskCred_count12_i > 2.5) => -0.0470139998,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0064781242, 0.0025806579),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 2.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.15) => 0.2070037068,
         (c_pop_55_64_p > 11.15) => -0.0015018187,
         (c_pop_55_64_p = NULL) => 0.1000777963, 0.1000777963),
      (f_hh_age_18_plus_d > 2.5) => -0.0304627940,
      (f_hh_age_18_plus_d = NULL) => 0.0419222726, 0.0419222726),
   (r_P85_Phn_Disconnected_i = NULL) => 0.0033512962, 0.0033512962),
(c_hh1_p > 44.55) => -0.0323599757,
(c_hh1_p = NULL) => -0.0058188924, -0.0005513693);

// Tree: 195 
wFDN_FL_PSD_lgt_195 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 3.95) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 12.5) => 0.0598954463,
   (r_C21_M_Bureau_ADL_FS_d > 12.5) => 
      map(
      (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => -0.0515746225,
      (nf_vf_hi_risk_hit_type > 3.5) => -0.0098921647,
      (nf_vf_hi_risk_hit_type = NULL) => -0.0119308708, -0.0119308708),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0306476865, -0.0099945564),
(c_rnt1250_p > 3.95) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 4.55) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.55) => 0.2403917270,
      (c_pop_18_24_p > 7.55) => 0.0049645369,
      (c_pop_18_24_p = NULL) => 0.1103305520, 0.1103305520),
   (c_rnt1250_p > 4.55) => 0.0096725896,
   (c_rnt1250_p = NULL) => 0.0120991049, 0.0120991049),
(c_rnt1250_p = NULL) => 0.0229500180, 0.0011657840);

// Tree: 196 
wFDN_FL_PSD_lgt_196 := map(
(NULL < c_lowrent and c_lowrent <= 90.35) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 22.5) => -0.0953389621,
   (f_mos_inq_banko_am_lseen_d > 22.5) => -0.0024725908,
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0072847064, -0.0042114184),
(c_lowrent > 90.35) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03763570665) => 
         map(
         (NULL < c_hval_60k_p and c_hval_60k_p <= 6.85) => -0.1095414838,
         (c_hval_60k_p > 6.85) => 0.1863524292,
         (c_hval_60k_p = NULL) => 0.0369690945, 0.0369690945),
      (f_add_curr_nhood_BUS_pct_i > 0.03763570665) => -0.0299125684,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0071240514, 0.0071240514),
   (f_util_adl_count_n > 2.5) => 0.2803850624,
   (f_util_adl_count_n = NULL) => 0.0665783299, 0.0665783299),
(c_lowrent = NULL) => -0.0027930848, -0.0028207858);

// Tree: 197 
wFDN_FL_PSD_lgt_197 := map(
(NULL < c_hh1_p and c_hh1_p <= 19.65) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 121.5) => 
         map(
         (NULL < c_apt20 and c_apt20 <= 166.5) => 
            map(
            (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 101) => 0.1440122629,
            (f_mos_liens_unrel_SC_fseen_d > 101) => 0.0380722744,
            (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0398446290, 0.0398446290),
         (c_apt20 > 166.5) => -0.0765126665,
         (c_apt20 = NULL) => 0.0356662478, 0.0356662478),
      (c_rest_indx > 121.5) => -0.0141542879,
      (c_rest_indx = NULL) => 0.0217943902, 0.0217943902),
   (f_assocsuspicousidcount_i > 9.5) => -0.0643979281,
   (f_assocsuspicousidcount_i = NULL) => 0.0192414961, 0.0192414961),
(c_hh1_p > 19.65) => -0.0088291027,
(c_hh1_p = NULL) => -0.0001910013, 0.0018583624);

// Tree: 198 
wFDN_FL_PSD_lgt_198 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 109.5) => -0.0095992057,
   (c_sub_bus > 109.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 188.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 54.5) => -0.0712526892,
         (c_easiqlife > 54.5) => 0.0180470393,
         (c_easiqlife = NULL) => 0.0143693156, 0.0143693156),
      (c_unempl > 188.5) => 0.0814151193,
      (c_unempl = NULL) => 0.0153785616, 0.0153785616),
   (c_sub_bus = NULL) => -0.0169826660, 0.0028862094),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 2.2) => -0.1055875406,
   (c_hval_300k_p > 2.2) => 0.0136211737,
   (c_hval_300k_p = NULL) => -0.0496827642, -0.0496827642),
(r_I60_inq_comm_count12_i = NULL) => 0.0031813759, 0.0022751040);

// Tree: 199 
wFDN_FL_PSD_lgt_199 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => -0.0012764448,
   (r_D30_Derog_Count_i > 18.5) => -0.0760215119,
   (r_D30_Derog_Count_i = NULL) => -0.0184639421, -0.0017432071),
(c_hh6_p > 11.05) => 
   map(
   (NULL < c_larceny and c_larceny <= 150.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 53.3) => 
         map(
         (NULL < f_inq_Banking_count_i and f_inq_Banking_count_i <= 1.5) => -0.0310123834,
         (f_inq_Banking_count_i > 1.5) => 0.0971802511,
         (f_inq_Banking_count_i = NULL) => -0.0036574698, -0.0036574698),
      (c_high_hval > 53.3) => 0.1563144165,
      (c_high_hval = NULL) => 0.0239238899, 0.0239238899),
   (c_larceny > 150.5) => 0.1767137384,
   (c_larceny = NULL) => 0.0475328169, 0.0475328169),
(c_hh6_p = NULL) => -0.0224448165, -0.0009118092);

// Tree: 200 
wFDN_FL_PSD_lgt_200 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 8.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 10.15) => -0.0037256511,
   (c_hh7p_p > 10.15) => 
      map(
      (NULL < c_no_car and c_no_car <= 174) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 76.45) => -0.0817393918,
         (c_sfdu_p > 76.45) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.35) => 0.1375634522,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.35) => -0.0657369261,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0820318362, 0.0499829132),
         (c_sfdu_p = NULL) => 0.0042383470, 0.0042383470),
      (c_no_car > 174) => 0.1423620152,
      (c_no_car = NULL) => 0.0312119927, 0.0312119927),
   (c_hh7p_p = NULL) => -0.0500959907, -0.0040599010),
(f_srchvelocityrisktype_i > 8.5) => -0.0708233887,
(f_srchvelocityrisktype_i = NULL) => 0.0151404202, -0.0043545336);

// Tree: 201 
wFDN_FL_PSD_lgt_201 := map(
(NULL < f_varmsrcssncount_i and f_varmsrcssncount_i <= 1.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 47.85) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 20.15) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 0.0399286313,
         (k_estimated_income_d > 34500) => -0.0034267797,
         (k_estimated_income_d = NULL) => 0.0072500304, 0.0072500304),
      (c_hh1_p > 20.15) => -0.0122214482,
      (c_hh1_p = NULL) => -0.0044108001, -0.0044108001),
   (c_hval_100k_p > 47.85) => 0.1180412165,
   (c_hval_100k_p = NULL) => -0.0005009523, -0.0036793511),
(f_varmsrcssncount_i > 1.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 1.5) => 0.0221411556,
   (r_E57_br_source_count_d > 1.5) => 0.2229701409,
   (r_E57_br_source_count_d = NULL) => 0.0800725937, 0.0800725937),
(f_varmsrcssncount_i = NULL) => 0.0004475956, -0.0022751363);

// Tree: 202 
wFDN_FL_PSD_lgt_202 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 68.3) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => -0.0353837289,
   (f_mos_inq_banko_om_fseen_d > 14.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.45) => -0.0137789761,
         (c_pop_35_44_p > 14.45) => 
            map(
            (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 72) => 0.1893748782,
            (r_D32_Mos_Since_Crim_LS_d > 72) => 0.0975642713,
            (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.1094483854, 0.1094483854),
         (c_pop_35_44_p = NULL) => 0.0514785244, 0.0514785244),
      (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0028672182,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0006659199, 0.0006659199),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0245608214, -0.0017485610),
(c_hval_1001k_p > 68.3) => 0.1478629634,
(c_hval_1001k_p = NULL) => 0.0322305224, -0.0000373504);

// Tree: 203 
wFDN_FL_PSD_lgt_203 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => -0.0047087604,
(r_C13_Curr_Addr_LRes_d > 310.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 64.5) => -0.0479024820,
   (c_span_lang > 64.5) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 0.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 6.65) => 0.0167175074,
         (c_pop_75_84_p > 6.65) => 0.1552134890,
         (c_pop_75_84_p = NULL) => 0.0499945739, 0.0499945739),
      (r_C14_addrs_5yr_i > 0.5) => 0.1733449524,
      (r_C14_addrs_5yr_i = NULL) => 0.0659662365, 0.0659662365),
   (c_span_lang = NULL) => 0.0332936780, 0.0332936780),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 107.5) => 0.0502760308,
   (c_sub_bus > 107.5) => -0.0592616632,
   (c_sub_bus = NULL) => -0.0025012218, -0.0025012218), -0.0025322527);

// Tree: 204 
wFDN_FL_PSD_lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0074685275,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.1032607428,
      (r_C10_M_Hdr_FS_d > 11.5) => 0.0120519817,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0133437874, 0.0133437874),
   (k_inq_per_ssn_i = NULL) => 0.0010227344, 0.0010227344),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 18.75) => 0.0274778018,
   (c_fammar18_p > 18.75) => -0.0807908286,
   (c_fammar18_p = NULL) => -0.0604673655, -0.0604673655),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.75) => 0.0498640978,
   (c_hval_125k_p > 3.75) => -0.0620138678,
   (c_hval_125k_p = NULL) => -0.0060748850, -0.0060748850), -0.0004606115);

// Tree: 205 
wFDN_FL_PSD_lgt_205 := map(
(NULL < c_for_sale and c_for_sale <= 108.5) => -0.0088490815,
(c_for_sale > 108.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0085493809,
      (k_nap_contradictory_i > 0.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 13.75) => 0.0045295473,
         (C_INC_50K_P > 13.75) => 0.1224509356,
         (C_INC_50K_P = NULL) => 0.0509834275, 0.0509834275),
      (k_nap_contradictory_i = NULL) => 0.0113296394, 0.0113296394),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 2.65) => -0.0245880806,
      (c_hval_750k_p > 2.65) => 0.2340734111,
      (c_hval_750k_p = NULL) => 0.1047426653, 0.1047426653),
   (r_P85_Phn_Disconnected_i = NULL) => 0.0128500337, 0.0128500337),
(c_for_sale = NULL) => -0.0150172627, 0.0015087209);

// Tree: 206 
wFDN_FL_PSD_lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 37.4) => -0.1379899094,
   (c_med_age > 37.4) => 0.0144448986,
   (c_med_age = NULL) => -0.0675465512, -0.0675465512),
(f_mos_liens_unrel_FT_lseen_d > 184.5) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 929.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 25009.5) => 0.0542087257,
      (f_curraddrmedianvalue_d > 25009.5) => -0.0108169807,
      (f_curraddrmedianvalue_d = NULL) => -0.0088725779, -0.0088725779),
   (c_hh00 > 929.5) => 
      map(
      (NULL < c_business and c_business <= 158.5) => 0.0485736274,
      (c_business > 158.5) => -0.0279824750,
      (c_business = NULL) => 0.0213874269, 0.0213874269),
   (c_hh00 = NULL) => 0.0102094669, -0.0021800806),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0244752257, -0.0030252584);

// Tree: 207 
wFDN_FL_PSD_lgt_207 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0011777103,
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 20.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.31449654675) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 89.5) => 
            map(
            (NULL < c_hh2_p and c_hh2_p <= 30.55) => -0.0635624512,
            (c_hh2_p > 30.55) => 0.0921323856,
            (c_hh2_p = NULL) => 0.0196037349, 0.0196037349),
         (r_C10_M_Hdr_FS_d > 89.5) => -0.0796027283,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0334008611, -0.0334008611),
      (f_add_curr_mobility_index_i > 0.31449654675) => -0.0091580892,
      (f_add_curr_mobility_index_i = NULL) => -0.0237120689, -0.0237120689),
   (f_rel_homeover100_count_d > 20.5) => -0.1500900085,
   (f_rel_homeover100_count_d = NULL) => -0.0336007966, -0.0336007966),
(f_varrisktype_i = NULL) => -0.0132149324, -0.0008090903);

// Tree: 208 
wFDN_FL_PSD_lgt_208 := map(
(NULL < c_totsales and c_totsales <= 969.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => -0.0191527804,
   (f_inq_HighRiskCredit_count24_i > 2.5) => -0.0925245110,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0205898763, -0.0205898763),
(c_totsales > 969.5) => 
   map(
   (NULL < c_employees and c_employees <= 18.5) => 0.1900406133,
   (c_employees > 18.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 17.5) => 
         map(
         (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 0.0012254926,
         (f_nae_nothing_found_i > 0.5) => 0.0799762050,
         (f_nae_nothing_found_i = NULL) => 0.0022310348, 0.0022310348),
      (f_srchssnsrchcount_i > 17.5) => 0.0663242970,
      (f_srchssnsrchcount_i = NULL) => -0.0007610480, 0.0027350642),
   (c_employees = NULL) => 0.0037097002, 0.0037097002),
(c_totsales = NULL) => 0.0027925344, -0.0016352680);

// Tree: 209 
wFDN_FL_PSD_lgt_209 := map(
(NULL < c_popover25 and c_popover25 <= 6354) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 8.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => 0.0009032831,
         (k_inq_per_phone_i > 4.5) => 0.0461611252,
         (k_inq_per_phone_i = NULL) => 0.0016361731, 0.0016361731),
      (k_inq_per_ssn_i > 10.5) => 0.0771000854,
      (k_inq_per_ssn_i = NULL) => 0.0020620982, 0.0020620982),
   (r_I60_Inq_Count12_i > 8.5) => -0.0609480763,
   (r_I60_Inq_Count12_i = NULL) => -0.0029894854, 0.0011723367),
(c_popover25 > 6354) => 0.1717724298,
(c_popover25 = NULL) => 
   map(
   (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => -0.0328997646,
   (f_property_owners_ct_d > 0.5) => 0.1365748084,
   (f_property_owners_ct_d = NULL) => 0.0180533750, 0.0180533750), 0.0024442836);

// Tree: 210 
wFDN_FL_PSD_lgt_210 := map(
(NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 4.5) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 2.65) => 0.1683570625,
   (c_hval_125k_p > 2.65) => -0.0243462679,
   (c_hval_125k_p = NULL) => 0.0820543440, 0.0820543440),
(r_I60_inq_retail_recency_d > 4.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0000540442,
   (f_srchfraudsrchcount_i > 6.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 84453) => 
         map(
         (NULL < c_med_age and c_med_age <= 31.35) => 0.0152979496,
         (c_med_age > 31.35) => -0.0702065715,
         (c_med_age = NULL) => -0.0467514659, -0.0467514659),
      (f_prevaddrmedianincome_d > 84453) => 0.0519615160,
      (f_prevaddrmedianincome_d = NULL) => -0.0296626605, -0.0296626605),
   (f_srchfraudsrchcount_i = NULL) => -0.0011192352, -0.0011192352),
(r_I60_inq_retail_recency_d = NULL) => -0.0136087264, -0.0001200611);

// Tree: 211 
wFDN_FL_PSD_lgt_211 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 8.25) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.06331075715) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 124.5) => -0.0474398900,
      (f_fp_prevaddrcrimeindex_i > 124.5) => 0.0863102702,
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0023719012, -0.0023719012),
   (f_add_curr_nhood_VAC_pct_i > 0.06331075715) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.29941229765) => 0.1484562385,
      (f_add_curr_mobility_index_i > 0.29941229765) => 0.0206138785,
      (f_add_curr_mobility_index_i = NULL) => 0.0771877964, 0.0771877964),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0283911819, 0.0283911819),
(c_fammar18_p > 8.25) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => -0.0104475303,
   (f_srchphonesrchcount_i > 1.5) => 0.0152060810,
   (f_srchphonesrchcount_i = NULL) => -0.0142807325, -0.0049892293),
(c_fammar18_p = NULL) => 0.0138633838, -0.0033676501);

// Tree: 212 
wFDN_FL_PSD_lgt_212 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00477897935) => -0.0310026321,
(f_add_curr_nhood_BUS_pct_i > 0.00477897935) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0029111643,
   (f_rel_ageover20_count_d > 20.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 10.5) => 0.1004491062,
      (f_addrs_per_ssn_i > 10.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 23.5) => 
            map(
            (NULL < c_cartheft and c_cartheft <= 91) => 0.0303894381,
            (c_cartheft > 91) => -0.1195271593,
            (c_cartheft = NULL) => -0.0490535451, -0.0490535451),
         (f_mos_inq_banko_cm_lseen_d > 23.5) => 0.0367173334,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0170018270, 0.0170018270),
      (f_addrs_per_ssn_i = NULL) => 0.0428953594, 0.0428953594),
   (f_rel_ageover20_count_d = NULL) => 0.0140142472, 0.0058705945),
(f_add_curr_nhood_BUS_pct_i = NULL) => -0.0146234751, 0.0008922146);

// Tree: 213 
wFDN_FL_PSD_lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125511) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 2.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 9.75) => 
         map(
         (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => 0.0288926216,
         (r_D31_attr_bankruptcy_recency_d > 9) => -0.0663511539,
         (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0157882380, 0.0157882380),
      (c_femdiv_p > 9.75) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','6: Other']) => 0.0137890377,
         (nf_seg_FraudPoint_3_0 in ['3: Derog','5: Vuln Vic/Friendly']) => 0.1843215522,
         (nf_seg_FraudPoint_3_0 = '') => 0.0921704419, 0.0921704419),
      (c_femdiv_p = NULL) => 0.0223679784, 0.0223679784),
   (f_inq_Other_count24_i > 2.5) => 0.1402632726,
   (f_inq_Other_count24_i = NULL) => 0.0258999655, 0.0258999655),
(r_A46_Curr_AVM_AutoVal_d > 125511) => -0.0069717885,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0041314598, 0.0028505646);

// Tree: 214 
wFDN_FL_PSD_lgt_214 := map(
(NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.95) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0082593996,
   (c_hh4_p > 11.55) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 89.85) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 169.5) => 0.0239630949,
         (c_mort_indx > 169.5) => 0.2284647687,
         (c_mort_indx = NULL) => 0.0279494823, 0.0279494823),
      (c_fammar_p > 89.85) => -0.0250162797,
      (c_fammar_p = NULL) => 0.0185276881, 0.0185276881),
   (c_hh4_p = NULL) => 0.0074532745, 0.0074532745),
(c_pop_6_11_p > 10.95) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 58.5) => -0.0177166784,
   (f_liens_unrel_SC_total_amt_i > 58.5) => -0.1061632864,
   (f_liens_unrel_SC_total_amt_i = NULL) => -0.0214748870, -0.0214748870),
(c_pop_6_11_p = NULL) => 0.0015822922, 0.0033631079);

// Tree: 215 
wFDN_FL_PSD_lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42.5) => 0.1274002334,
(f_mos_liens_unrel_FT_fseen_d > 42.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1288079234) => -0.0021711391,
   (f_add_curr_nhood_BUS_pct_i > 0.1288079234) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 0.0474402788,
         (r_C14_Addr_Stability_v2_d > 1.5) => 0.0074721968,
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0105647897, 0.0105647897),
      (f_hh_lienholders_i > 1.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 70) => 0.1911037035,
         (r_C13_Curr_Addr_LRes_d > 70) => -0.0009270745,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.1009235038, 0.1009235038),
      (f_hh_lienholders_i = NULL) => 0.0211848723, 0.0211848723),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0243736992, -0.0005871294),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0198220715, -0.0001843001);

// Tree: 216 
wFDN_FL_PSD_lgt_216 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0776322682,
(f_mos_liens_unrel_FT_lseen_d > 184) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0177080191,
   (f_addrs_per_ssn_i > 4.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 25124) => 0.0831895318,
      (c_med_hval > 25124) => 
         map(
         (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 2.5) => 0.0953530381,
            (c_born_usa > 2.5) => 0.0065701106,
            (c_born_usa = NULL) => 0.0074434504, 0.0074434504),
         (k_inq_adls_per_phone_i > 2.5) => -0.0826583074,
         (k_inq_adls_per_phone_i = NULL) => 0.0066745448, 0.0066745448),
      (c_med_hval = NULL) => 0.0342269945, 0.0081965409),
   (f_addrs_per_ssn_i = NULL) => 0.0018005589, 0.0018005589),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0080663185, 0.0009342275);

// Tree: 217 
wFDN_FL_PSD_lgt_217 := map(
(NULL < c_unempl and c_unempl <= 58.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 7.5) => -0.0294898944,
   (f_srchphonesrchcount_i > 7.5) => 0.0944948918,
   (f_srchphonesrchcount_i = NULL) => -0.0269447522, -0.0269447522),
(c_unempl > 58.5) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 27.5) => -0.0759645892,
   (f_mos_liens_unrel_CJ_lseen_d > 27.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => 0.0223556063,
      (r_pb_order_freq_d > 41.5) => -0.0134761004,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 173.5) => 0.0136325466,
         (c_no_labfor > 173.5) => -0.0770589363,
         (c_no_labfor = NULL) => 0.0096633901, 0.0096633901), 0.0050905497),
   (f_mos_liens_unrel_CJ_lseen_d = NULL) => -0.0035540205, 0.0038630941),
(c_unempl = NULL) => 0.0205124118, -0.0023907865);

// Tree: 218 
wFDN_FL_PSD_lgt_218 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1355795886,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < c_families and c_families <= 120.5) => -0.0724306985,
   (c_families > 120.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 88.5) => -0.0107035184,
      (c_no_car > 88.5) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 15.5) => 0.0134534214,
         (f_rel_homeover300_count_d > 15.5) => 
            map(
            (NULL < c_rnt1000_p and c_rnt1000_p <= 17.6) => 0.2201906590,
            (c_rnt1000_p > 17.6) => -0.0189963729,
            (c_rnt1000_p = NULL) => 0.0837416811, 0.0837416811),
         (f_rel_homeover300_count_d = NULL) => -0.0501141508, 0.0136735955),
      (c_no_car = NULL) => 0.0008556967, 0.0008556967),
   (c_families = NULL) => 0.0248867929, 0.0001586882),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0211743767, 0.0005854983);

// Tree: 219 
wFDN_FL_PSD_lgt_219 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 25.55) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 5.85) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 2.45) => -0.0418408314,
      (C_INC_125K_P > 2.45) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0074116341,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 76.75) => 0.1591645147,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i > 76.75) => 0.0206919797,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0541533540, 0.0424869577),
         (nf_seg_FraudPoint_3_0 = '') => 0.0209485168, 0.0209485168),
      (C_INC_125K_P = NULL) => 0.0155939226, 0.0155939226),
   (c_newhouse > 5.85) => -0.0055095449,
   (c_newhouse = NULL) => 0.0018388589, 0.0018388589),
(c_pop_45_54_p > 25.55) => -0.0752671013,
(c_pop_45_54_p = NULL) => -0.0109344035, -0.0003717719);

// Tree: 220 
wFDN_FL_PSD_lgt_220 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 23.5) => -0.0932570121,
(f_mos_inq_banko_am_lseen_d > 23.5) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.35) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 2918.5) => -0.0029483234,
      (c_popover25 > 2918.5) => 0.0592679407,
      (c_popover25 = NULL) => -0.0004684438, -0.0004684438),
   (c_hval_1000k_p > 41.35) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.1672448761,
      (k_nap_fname_verd_d > 0.5) => -0.0121786503,
      (k_nap_fname_verd_d = NULL) => 0.0775331129, 0.0775331129),
   (c_hval_1000k_p = NULL) => -0.0253095107, -0.0001881829),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.55) => -0.0466399451,
   (c_pop_55_64_p > 11.55) => 0.0800359229,
   (c_pop_55_64_p = NULL) => 0.0179399092, 0.0179399092), -0.0017417223);

// Tree: 221 
wFDN_FL_PSD_lgt_221 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 75.2) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0013873460,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 138.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 15.55) => -0.0234090258,
         (C_INC_125K_P > 15.55) => 0.0959087044,
         (C_INC_125K_P = NULL) => -0.0118695935, -0.0118695935),
      (c_bel_edu > 138.5) => -0.0822914238,
      (c_bel_edu = NULL) => -0.0298302044, -0.0298302044),
   (f_varrisktype_i = NULL) => 0.0023310171, -0.0003887029),
(c_rnt1000_p > 75.2) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 109.35) => 0.0486448066,
   (c_oldhouse > 109.35) => 0.2397791261,
   (c_oldhouse = NULL) => 0.0999035559, 0.0999035559),
(c_rnt1000_p = NULL) => -0.0031201736, 0.0012826532);

// Tree: 222 
wFDN_FL_PSD_lgt_222 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 1.5) => 0.0015036051,
(f_rel_ageover50_count_d > 1.5) => -0.0348806839,
(f_rel_ageover50_count_d = NULL) => 
   map(
   (NULL < c_families and c_families <= 428) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 11.15) => -0.1056268519,
      (c_pop_35_44_p > 11.15) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 22.7) => -0.0344268652,
         (c_rnt750_p > 22.7) => 0.0809349959,
         (c_rnt750_p = NULL) => 0.0186893874, 0.0186893874),
      (c_pop_35_44_p = NULL) => -0.0192270656, -0.0192270656),
   (c_families > 428) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 114.5) => 0.1619447107,
      (c_exp_prod > 114.5) => 0.0230194695,
      (c_exp_prod = NULL) => 0.0893531432, 0.0893531432),
   (c_families = NULL) => 0.0195266424, 0.0195266424), -0.0022035998);

// Tree: 223 
wFDN_FL_PSD_lgt_223 := map(
(NULL < c_cpiall and c_cpiall <= 199.2) => -0.0566860184,
(c_cpiall > 199.2) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','6: Other']) => -0.0065557840,
   (nf_seg_FraudPoint_3_0 in ['3: Derog','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 43229.5) => -0.0509544998,
      (r_A46_Curr_AVM_AutoVal_d > 43229.5) => 0.0225687165,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 171.5) => 0.0068814978,
         (c_exp_prod > 171.5) => 
            map(
            (NULL < c_high_hval and c_high_hval <= 1.15) => 0.2169280112,
            (c_high_hval > 1.15) => -0.0016456100,
            (c_high_hval = NULL) => 0.0978834497, 0.0978834497),
         (c_exp_prod = NULL) => 0.0127559754, 0.0127559754), 0.0159947373),
   (nf_seg_FraudPoint_3_0 = '') => 0.0014729808, 0.0014729808),
(c_cpiall = NULL) => 0.0205889205, -0.0000712980);

// Tree: 224 
wFDN_FL_PSD_lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 0.85) => 0.0009976524,
   (c_low_hval > 0.85) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 17.85) => 0.0224083147,
      (C_INC_75K_P > 17.85) => 0.1720973892,
      (C_INC_75K_P = NULL) => 0.1007502603, 0.1007502603),
   (c_low_hval = NULL) => 0.0442103206, 0.0442103206),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 73.5) => -0.0373163286,
      (c_many_cars > 73.5) => 0.0218281634,
      (c_many_cars = NULL) => -0.0026482423, -0.0026482423),
   (r_C14_Addr_Stability_v2_d > 2.5) => 0.0027454082,
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0021013576, 0.0021013576),
(r_C10_M_Hdr_FS_d = NULL) => 0.0306367829, 0.0031649877);

// Tree: 225 
wFDN_FL_PSD_lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 14799) => -0.0924296857,
(r_A46_Curr_AVM_AutoVal_d > 14799) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 192.5) => 
      map(
      (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0055232725,
      (k_inf_nothing_found_i > 0.5) => 0.0298888346,
      (k_inf_nothing_found_i = NULL) => 0.0083739207, 0.0083739207),
   (c_sub_bus > 192.5) => 
      map(
      (NULL < c_hval_300k_p and c_hval_300k_p <= 2.4) => 0.2176617075,
      (c_hval_300k_p > 2.4) => 0.0122288413,
      (c_hval_300k_p = NULL) => 0.1074749883, 0.1074749883),
   (c_sub_bus = NULL) => 0.0099334511, 0.0099334511),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0092828323,
   (f_adls_per_phone_c6_i > 1.5) => 0.1705402919,
   (f_adls_per_phone_c6_i = NULL) => -0.0068796366, -0.0068796366), 0.0020835837);

// Tree: 226 
wFDN_FL_PSD_lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => 0.0007750361,
   (f_inq_Collection_count_i > 1.5) => -0.1438636468,
   (f_inq_Collection_count_i = NULL) => -0.0736506939, -0.0736506939),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 7.5) => 0.0020220537,
   (f_sourcerisktype_i > 7.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 3.55) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 44.4) => 0.0185405071,
         (r_C12_source_profile_d > 44.4) => -0.0805883888,
         (r_C12_source_profile_d = NULL) => -0.0046556545, -0.0046556545),
      (c_hh6_p > 3.55) => -0.0939416600,
      (c_hh6_p = NULL) => -0.0284081635, -0.0277852344),
   (f_sourcerisktype_i = NULL) => 0.0002080291, 0.0002080291),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0043383956, -0.0003610836);

// Tree: 227 
wFDN_FL_PSD_lgt_227 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0041084846,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.65) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 225.45) => 
         map(
         (NULL < r_I60_inq_retpymt_recency_d and r_I60_inq_retpymt_recency_d <= 61.5) => 
            map(
            (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 244) => 0.1917637749,
            (r_C10_M_Hdr_FS_d > 244) => -0.0046266210,
            (r_C10_M_Hdr_FS_d = NULL) => 0.1016899843, 0.1016899843),
         (r_I60_inq_retpymt_recency_d > 61.5) => 0.0148446696,
         (r_I60_inq_retpymt_recency_d = NULL) => 0.0243590245, 0.0243590245),
      (c_cpiall > 225.45) => -0.0633895089,
      (c_cpiall = NULL) => 0.0128098613, 0.0128098613),
   (c_hval_750k_p > 41.65) => 0.1217829598,
   (c_hval_750k_p = NULL) => 0.0209594048, 0.0209594048),
(k_inq_per_ssn_i = NULL) => -0.0010908522, -0.0010908522);

// Tree: 228 
wFDN_FL_PSD_lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => -0.0034250571,
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 156) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 167.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.45) => 
            map(
            (NULL < c_hh4_p and c_hh4_p <= 15.25) => -0.1154647769,
            (c_hh4_p > 15.25) => 0.0421468821,
            (c_hh4_p = NULL) => -0.0417198723, -0.0417198723),
         (c_pop_6_11_p > 8.45) => -0.1326542747,
         (c_pop_6_11_p = NULL) => -0.0889897379, -0.0889897379),
      (c_serv_empl > 167.5) => 0.0221890693,
      (c_serv_empl = NULL) => -0.0660542497, -0.0660542497),
   (c_burglary > 156) => 0.0576784162,
   (c_burglary = NULL) => -0.0464025910, -0.0464025910),
(f_assocsuspicousidcount_i = NULL) => -0.0044131798, -0.0046042584);

// Tree: 229 
wFDN_FL_PSD_lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0114105259,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < c_pop_85p_p and c_pop_85p_p <= 4.35) => 0.0067432499,
      (c_pop_85p_p > 4.35) => 
         map(
         (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 14.5) => 
            map(
            (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 76.7) => 0.0080914962,
            (r_C12_source_profile_d > 76.7) => 0.1407428631,
            (r_C12_source_profile_d = NULL) => 0.0293812218, 0.0293812218),
         (f_rel_homeover100_count_d > 14.5) => 0.1498774193,
         (f_rel_homeover100_count_d = NULL) => 0.0449291182, 0.0449291182),
      (c_pop_85p_p = NULL) => 0.0041944531, 0.0101145137),
   (f_corrrisktype_i = NULL) => -0.0021574871, -0.0021574871),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0632403605,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0419324524, -0.0049662998);

// Tree: 230 
wFDN_FL_PSD_lgt_230 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 198.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1987.5) => 
         map(
         (NULL < c_families and c_families <= 614.5) => 0.0037863075,
         (c_families > 614.5) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 22.5) => 0.2167462561,
            (c_oldhouse > 22.5) => 0.0376036899,
            (c_oldhouse = NULL) => 0.0485080200, 0.0485080200),
         (c_families = NULL) => 0.0094760928, 0.0094760928),
      (c_med_yearblt > 1987.5) => -0.0193728757,
      (c_med_yearblt = NULL) => 0.0021087806, 0.0021087806),
   (c_bel_edu > 198.5) => -0.1100863455,
   (c_bel_edu = NULL) => -0.0064953821, 0.0013681976),
(f_inq_count24_i > 14.5) => -0.0988978721,
(f_inq_count24_i = NULL) => -0.0066746304, 0.0005415846);

// Tree: 231 
wFDN_FL_PSD_lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0009603646,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 36.5) => -0.0579739234,
   (f_mos_inq_banko_cm_fseen_d > 36.5) => 
      map(
      (NULL < c_rnt1500_p and c_rnt1500_p <= 2.65) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 88.5) => 0.1348817235,
         (f_prevaddrcartheftindex_i > 88.5) => 0.0390170937,
         (f_prevaddrcartheftindex_i = NULL) => 0.0810073861, 0.0810073861),
      (c_rnt1500_p > 2.65) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.75) => -0.0914348993,
         (c_pop_45_54_p > 12.75) => 0.0583583674,
         (c_pop_45_54_p = NULL) => -0.0105649148, -0.0105649148),
      (c_rnt1500_p = NULL) => 0.0441523613, 0.0441523613),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0273388876, 0.0273388876),
(f_srchvelocityrisktype_i = NULL) => 0.0297828890, 0.0003989972);

// Final Score Sum 

   wFDN_FL_PSD_lgt := sum(
      wFDN_FL_PSD_lgt_0, wFDN_FL_PSD_lgt_1, wFDN_FL_PSD_lgt_2, wFDN_FL_PSD_lgt_3, wFDN_FL_PSD_lgt_4, 
      wFDN_FL_PSD_lgt_5, wFDN_FL_PSD_lgt_6, wFDN_FL_PSD_lgt_7, wFDN_FL_PSD_lgt_8, wFDN_FL_PSD_lgt_9, 
      wFDN_FL_PSD_lgt_10, wFDN_FL_PSD_lgt_11, wFDN_FL_PSD_lgt_12, wFDN_FL_PSD_lgt_13, wFDN_FL_PSD_lgt_14, 
      wFDN_FL_PSD_lgt_15, wFDN_FL_PSD_lgt_16, wFDN_FL_PSD_lgt_17, wFDN_FL_PSD_lgt_18, wFDN_FL_PSD_lgt_19, 
      wFDN_FL_PSD_lgt_20, wFDN_FL_PSD_lgt_21, wFDN_FL_PSD_lgt_22, wFDN_FL_PSD_lgt_23, wFDN_FL_PSD_lgt_24, 
      wFDN_FL_PSD_lgt_25, wFDN_FL_PSD_lgt_26, wFDN_FL_PSD_lgt_27, wFDN_FL_PSD_lgt_28, wFDN_FL_PSD_lgt_29, 
      wFDN_FL_PSD_lgt_30, wFDN_FL_PSD_lgt_31, wFDN_FL_PSD_lgt_32, wFDN_FL_PSD_lgt_33, wFDN_FL_PSD_lgt_34, 
      wFDN_FL_PSD_lgt_35, wFDN_FL_PSD_lgt_36, wFDN_FL_PSD_lgt_37, wFDN_FL_PSD_lgt_38, wFDN_FL_PSD_lgt_39, 
      wFDN_FL_PSD_lgt_40, wFDN_FL_PSD_lgt_41, wFDN_FL_PSD_lgt_42, wFDN_FL_PSD_lgt_43, wFDN_FL_PSD_lgt_44, 
      wFDN_FL_PSD_lgt_45, wFDN_FL_PSD_lgt_46, wFDN_FL_PSD_lgt_47, wFDN_FL_PSD_lgt_48, wFDN_FL_PSD_lgt_49, 
      wFDN_FL_PSD_lgt_50, wFDN_FL_PSD_lgt_51, wFDN_FL_PSD_lgt_52, wFDN_FL_PSD_lgt_53, wFDN_FL_PSD_lgt_54, 
      wFDN_FL_PSD_lgt_55, wFDN_FL_PSD_lgt_56, wFDN_FL_PSD_lgt_57, wFDN_FL_PSD_lgt_58, wFDN_FL_PSD_lgt_59, 
      wFDN_FL_PSD_lgt_60, wFDN_FL_PSD_lgt_61, wFDN_FL_PSD_lgt_62, wFDN_FL_PSD_lgt_63, wFDN_FL_PSD_lgt_64, 
      wFDN_FL_PSD_lgt_65, wFDN_FL_PSD_lgt_66, wFDN_FL_PSD_lgt_67, wFDN_FL_PSD_lgt_68, wFDN_FL_PSD_lgt_69, 
      wFDN_FL_PSD_lgt_70, wFDN_FL_PSD_lgt_71, wFDN_FL_PSD_lgt_72, wFDN_FL_PSD_lgt_73, wFDN_FL_PSD_lgt_74, 
      wFDN_FL_PSD_lgt_75, wFDN_FL_PSD_lgt_76, wFDN_FL_PSD_lgt_77, wFDN_FL_PSD_lgt_78, wFDN_FL_PSD_lgt_79, 
      wFDN_FL_PSD_lgt_80, wFDN_FL_PSD_lgt_81, wFDN_FL_PSD_lgt_82, wFDN_FL_PSD_lgt_83, wFDN_FL_PSD_lgt_84, 
      wFDN_FL_PSD_lgt_85, wFDN_FL_PSD_lgt_86, wFDN_FL_PSD_lgt_87, wFDN_FL_PSD_lgt_88, wFDN_FL_PSD_lgt_89, 
      wFDN_FL_PSD_lgt_90, wFDN_FL_PSD_lgt_91, wFDN_FL_PSD_lgt_92, wFDN_FL_PSD_lgt_93, wFDN_FL_PSD_lgt_94, 
      wFDN_FL_PSD_lgt_95, wFDN_FL_PSD_lgt_96, wFDN_FL_PSD_lgt_97, wFDN_FL_PSD_lgt_98, wFDN_FL_PSD_lgt_99, 
      wFDN_FL_PSD_lgt_100, wFDN_FL_PSD_lgt_101, wFDN_FL_PSD_lgt_102, wFDN_FL_PSD_lgt_103, wFDN_FL_PSD_lgt_104, 
      wFDN_FL_PSD_lgt_105, wFDN_FL_PSD_lgt_106, wFDN_FL_PSD_lgt_107, wFDN_FL_PSD_lgt_108, wFDN_FL_PSD_lgt_109, 
      wFDN_FL_PSD_lgt_110, wFDN_FL_PSD_lgt_111, wFDN_FL_PSD_lgt_112, wFDN_FL_PSD_lgt_113, wFDN_FL_PSD_lgt_114, 
      wFDN_FL_PSD_lgt_115, wFDN_FL_PSD_lgt_116, wFDN_FL_PSD_lgt_117, wFDN_FL_PSD_lgt_118, wFDN_FL_PSD_lgt_119, 
      wFDN_FL_PSD_lgt_120, wFDN_FL_PSD_lgt_121, wFDN_FL_PSD_lgt_122, wFDN_FL_PSD_lgt_123, wFDN_FL_PSD_lgt_124, 
      wFDN_FL_PSD_lgt_125, wFDN_FL_PSD_lgt_126, wFDN_FL_PSD_lgt_127, wFDN_FL_PSD_lgt_128, wFDN_FL_PSD_lgt_129, 
      wFDN_FL_PSD_lgt_130, wFDN_FL_PSD_lgt_131, wFDN_FL_PSD_lgt_132, wFDN_FL_PSD_lgt_133, wFDN_FL_PSD_lgt_134, 
      wFDN_FL_PSD_lgt_135, wFDN_FL_PSD_lgt_136, wFDN_FL_PSD_lgt_137, wFDN_FL_PSD_lgt_138, wFDN_FL_PSD_lgt_139, 
      wFDN_FL_PSD_lgt_140, wFDN_FL_PSD_lgt_141, wFDN_FL_PSD_lgt_142, wFDN_FL_PSD_lgt_143, wFDN_FL_PSD_lgt_144, 
      wFDN_FL_PSD_lgt_145, wFDN_FL_PSD_lgt_146, wFDN_FL_PSD_lgt_147, wFDN_FL_PSD_lgt_148, wFDN_FL_PSD_lgt_149, 
      wFDN_FL_PSD_lgt_150, wFDN_FL_PSD_lgt_151, wFDN_FL_PSD_lgt_152, wFDN_FL_PSD_lgt_153, wFDN_FL_PSD_lgt_154, 
      wFDN_FL_PSD_lgt_155, wFDN_FL_PSD_lgt_156, wFDN_FL_PSD_lgt_157, wFDN_FL_PSD_lgt_158, wFDN_FL_PSD_lgt_159, 
      wFDN_FL_PSD_lgt_160, wFDN_FL_PSD_lgt_161, wFDN_FL_PSD_lgt_162, wFDN_FL_PSD_lgt_163, wFDN_FL_PSD_lgt_164, 
      wFDN_FL_PSD_lgt_165, wFDN_FL_PSD_lgt_166, wFDN_FL_PSD_lgt_167, wFDN_FL_PSD_lgt_168, wFDN_FL_PSD_lgt_169, 
      wFDN_FL_PSD_lgt_170, wFDN_FL_PSD_lgt_171, wFDN_FL_PSD_lgt_172, wFDN_FL_PSD_lgt_173, wFDN_FL_PSD_lgt_174, 
      wFDN_FL_PSD_lgt_175, wFDN_FL_PSD_lgt_176, wFDN_FL_PSD_lgt_177, wFDN_FL_PSD_lgt_178, wFDN_FL_PSD_lgt_179, 
      wFDN_FL_PSD_lgt_180, wFDN_FL_PSD_lgt_181, wFDN_FL_PSD_lgt_182, wFDN_FL_PSD_lgt_183, wFDN_FL_PSD_lgt_184, 
      wFDN_FL_PSD_lgt_185, wFDN_FL_PSD_lgt_186, wFDN_FL_PSD_lgt_187, wFDN_FL_PSD_lgt_188, wFDN_FL_PSD_lgt_189, 
      wFDN_FL_PSD_lgt_190, wFDN_FL_PSD_lgt_191, wFDN_FL_PSD_lgt_192, wFDN_FL_PSD_lgt_193, wFDN_FL_PSD_lgt_194, 
      wFDN_FL_PSD_lgt_195, wFDN_FL_PSD_lgt_196, wFDN_FL_PSD_lgt_197, wFDN_FL_PSD_lgt_198, wFDN_FL_PSD_lgt_199, 
      wFDN_FL_PSD_lgt_200, wFDN_FL_PSD_lgt_201, wFDN_FL_PSD_lgt_202, wFDN_FL_PSD_lgt_203, wFDN_FL_PSD_lgt_204, 
      wFDN_FL_PSD_lgt_205, wFDN_FL_PSD_lgt_206, wFDN_FL_PSD_lgt_207, wFDN_FL_PSD_lgt_208, wFDN_FL_PSD_lgt_209, 
      wFDN_FL_PSD_lgt_210, wFDN_FL_PSD_lgt_211, wFDN_FL_PSD_lgt_212, wFDN_FL_PSD_lgt_213, wFDN_FL_PSD_lgt_214, 
      wFDN_FL_PSD_lgt_215, wFDN_FL_PSD_lgt_216, wFDN_FL_PSD_lgt_217, wFDN_FL_PSD_lgt_218, wFDN_FL_PSD_lgt_219, 
      wFDN_FL_PSD_lgt_220, wFDN_FL_PSD_lgt_221, wFDN_FL_PSD_lgt_222, wFDN_FL_PSD_lgt_223, wFDN_FL_PSD_lgt_224, 
      wFDN_FL_PSD_lgt_225, wFDN_FL_PSD_lgt_226, wFDN_FL_PSD_lgt_227, wFDN_FL_PSD_lgt_228, wFDN_FL_PSD_lgt_229, 
      wFDN_FL_PSD_lgt_230, wFDN_FL_PSD_lgt_231); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FL_PSD_lgt;
			
self.final_score_0	:= 	wFDN_FL_PSD_lgt_0	;
self.final_score_1	:= 	wFDN_FL_PSD_lgt_1	;
self.final_score_2	:= 	wFDN_FL_PSD_lgt_2	;
self.final_score_3	:= 	wFDN_FL_PSD_lgt_3	;
self.final_score_4	:= 	wFDN_FL_PSD_lgt_4	;
self.final_score_5	:= 	wFDN_FL_PSD_lgt_5	;
self.final_score_6	:= 	wFDN_FL_PSD_lgt_6	;
self.final_score_7	:= 	wFDN_FL_PSD_lgt_7	;
self.final_score_8	:= 	wFDN_FL_PSD_lgt_8	;
self.final_score_9	:= 	wFDN_FL_PSD_lgt_9	;
self.final_score_10	:= 	wFDN_FL_PSD_lgt_10	;
self.final_score_11	:= 	wFDN_FL_PSD_lgt_11	;
self.final_score_12	:= 	wFDN_FL_PSD_lgt_12	;
self.final_score_13	:= 	wFDN_FL_PSD_lgt_13	;
self.final_score_14	:= 	wFDN_FL_PSD_lgt_14	;
self.final_score_15	:= 	wFDN_FL_PSD_lgt_15	;
self.final_score_16	:= 	wFDN_FL_PSD_lgt_16	;
self.final_score_17	:= 	wFDN_FL_PSD_lgt_17	;
self.final_score_18	:= 	wFDN_FL_PSD_lgt_18	;
self.final_score_19	:= 	wFDN_FL_PSD_lgt_19	;
self.final_score_20	:= 	wFDN_FL_PSD_lgt_20	;
self.final_score_21	:= 	wFDN_FL_PSD_lgt_21	;
self.final_score_22	:= 	wFDN_FL_PSD_lgt_22	;
self.final_score_23	:= 	wFDN_FL_PSD_lgt_23	;
self.final_score_24	:= 	wFDN_FL_PSD_lgt_24	;
self.final_score_25	:= 	wFDN_FL_PSD_lgt_25	;
self.final_score_26	:= 	wFDN_FL_PSD_lgt_26	;
self.final_score_27	:= 	wFDN_FL_PSD_lgt_27	;
self.final_score_28	:= 	wFDN_FL_PSD_lgt_28	;
self.final_score_29	:= 	wFDN_FL_PSD_lgt_29	;
self.final_score_30	:= 	wFDN_FL_PSD_lgt_30	;
self.final_score_31	:= 	wFDN_FL_PSD_lgt_31	;
self.final_score_32	:= 	wFDN_FL_PSD_lgt_32	;
self.final_score_33	:= 	wFDN_FL_PSD_lgt_33	;
self.final_score_34	:= 	wFDN_FL_PSD_lgt_34	;
self.final_score_35	:= 	wFDN_FL_PSD_lgt_35	;
self.final_score_36	:= 	wFDN_FL_PSD_lgt_36	;
self.final_score_37	:= 	wFDN_FL_PSD_lgt_37	;
self.final_score_38	:= 	wFDN_FL_PSD_lgt_38	;
self.final_score_39	:= 	wFDN_FL_PSD_lgt_39	;
self.final_score_40	:= 	wFDN_FL_PSD_lgt_40	;
self.final_score_41	:= 	wFDN_FL_PSD_lgt_41	;
self.final_score_42	:= 	wFDN_FL_PSD_lgt_42	;
self.final_score_43	:= 	wFDN_FL_PSD_lgt_43	;
self.final_score_44	:= 	wFDN_FL_PSD_lgt_44	;
self.final_score_45	:= 	wFDN_FL_PSD_lgt_45	;
self.final_score_46	:= 	wFDN_FL_PSD_lgt_46	;
self.final_score_47	:= 	wFDN_FL_PSD_lgt_47	;
self.final_score_48	:= 	wFDN_FL_PSD_lgt_48	;
self.final_score_49	:= 	wFDN_FL_PSD_lgt_49	;
self.final_score_50	:= 	wFDN_FL_PSD_lgt_50	;
self.final_score_51	:= 	wFDN_FL_PSD_lgt_51	;
self.final_score_52	:= 	wFDN_FL_PSD_lgt_52	;
self.final_score_53	:= 	wFDN_FL_PSD_lgt_53	;
self.final_score_54	:= 	wFDN_FL_PSD_lgt_54	;
self.final_score_55	:= 	wFDN_FL_PSD_lgt_55	;
self.final_score_56	:= 	wFDN_FL_PSD_lgt_56	;
self.final_score_57	:= 	wFDN_FL_PSD_lgt_57	;
self.final_score_58	:= 	wFDN_FL_PSD_lgt_58	;
self.final_score_59	:= 	wFDN_FL_PSD_lgt_59	;
self.final_score_60	:= 	wFDN_FL_PSD_lgt_60	;
self.final_score_61	:= 	wFDN_FL_PSD_lgt_61	;
self.final_score_62	:= 	wFDN_FL_PSD_lgt_62	;
self.final_score_63	:= 	wFDN_FL_PSD_lgt_63	;
self.final_score_64	:= 	wFDN_FL_PSD_lgt_64	;
self.final_score_65	:= 	wFDN_FL_PSD_lgt_65	;
self.final_score_66	:= 	wFDN_FL_PSD_lgt_66	;
self.final_score_67	:= 	wFDN_FL_PSD_lgt_67	;
self.final_score_68	:= 	wFDN_FL_PSD_lgt_68	;
self.final_score_69	:= 	wFDN_FL_PSD_lgt_69	;
self.final_score_70	:= 	wFDN_FL_PSD_lgt_70	;
self.final_score_71	:= 	wFDN_FL_PSD_lgt_71	;
self.final_score_72	:= 	wFDN_FL_PSD_lgt_72	;
self.final_score_73	:= 	wFDN_FL_PSD_lgt_73	;
self.final_score_74	:= 	wFDN_FL_PSD_lgt_74	;
self.final_score_75	:= 	wFDN_FL_PSD_lgt_75	;
self.final_score_76	:= 	wFDN_FL_PSD_lgt_76	;
self.final_score_77	:= 	wFDN_FL_PSD_lgt_77	;
self.final_score_78	:= 	wFDN_FL_PSD_lgt_78	;
self.final_score_79	:= 	wFDN_FL_PSD_lgt_79	;
self.final_score_80	:= 	wFDN_FL_PSD_lgt_80	;
self.final_score_81	:= 	wFDN_FL_PSD_lgt_81	;
self.final_score_82	:= 	wFDN_FL_PSD_lgt_82	;
self.final_score_83	:= 	wFDN_FL_PSD_lgt_83	;
self.final_score_84	:= 	wFDN_FL_PSD_lgt_84	;
self.final_score_85	:= 	wFDN_FL_PSD_lgt_85	;
self.final_score_86	:= 	wFDN_FL_PSD_lgt_86	;
self.final_score_87	:= 	wFDN_FL_PSD_lgt_87	;
self.final_score_88	:= 	wFDN_FL_PSD_lgt_88	;
self.final_score_89	:= 	wFDN_FL_PSD_lgt_89	;
self.final_score_90	:= 	wFDN_FL_PSD_lgt_90	;
self.final_score_91	:= 	wFDN_FL_PSD_lgt_91	;
self.final_score_92	:= 	wFDN_FL_PSD_lgt_92	;
self.final_score_93	:= 	wFDN_FL_PSD_lgt_93	;
self.final_score_94	:= 	wFDN_FL_PSD_lgt_94	;
self.final_score_95	:= 	wFDN_FL_PSD_lgt_95	;
self.final_score_96	:= 	wFDN_FL_PSD_lgt_96	;
self.final_score_97	:= 	wFDN_FL_PSD_lgt_97	;
self.final_score_98	:= 	wFDN_FL_PSD_lgt_98	;
self.final_score_99	:= 	wFDN_FL_PSD_lgt_99	;
self.final_score_100	:= 	wFDN_FL_PSD_lgt_100	;
self.final_score_101	:= 	wFDN_FL_PSD_lgt_101	;
self.final_score_102	:= 	wFDN_FL_PSD_lgt_102	;
self.final_score_103	:= 	wFDN_FL_PSD_lgt_103	;
self.final_score_104	:= 	wFDN_FL_PSD_lgt_104	;
self.final_score_105	:= 	wFDN_FL_PSD_lgt_105	;
self.final_score_106	:= 	wFDN_FL_PSD_lgt_106	;
self.final_score_107	:= 	wFDN_FL_PSD_lgt_107	;
self.final_score_108	:= 	wFDN_FL_PSD_lgt_108	;
self.final_score_109	:= 	wFDN_FL_PSD_lgt_109	;
self.final_score_110	:= 	wFDN_FL_PSD_lgt_110	;
self.final_score_111	:= 	wFDN_FL_PSD_lgt_111	;
self.final_score_112	:= 	wFDN_FL_PSD_lgt_112	;
self.final_score_113	:= 	wFDN_FL_PSD_lgt_113	;
self.final_score_114	:= 	wFDN_FL_PSD_lgt_114	;
self.final_score_115	:= 	wFDN_FL_PSD_lgt_115	;
self.final_score_116	:= 	wFDN_FL_PSD_lgt_116	;
self.final_score_117	:= 	wFDN_FL_PSD_lgt_117	;
self.final_score_118	:= 	wFDN_FL_PSD_lgt_118	;
self.final_score_119	:= 	wFDN_FL_PSD_lgt_119	;
self.final_score_120	:= 	wFDN_FL_PSD_lgt_120	;
self.final_score_121	:= 	wFDN_FL_PSD_lgt_121	;
self.final_score_122	:= 	wFDN_FL_PSD_lgt_122	;
self.final_score_123	:= 	wFDN_FL_PSD_lgt_123	;
self.final_score_124	:= 	wFDN_FL_PSD_lgt_124	;
self.final_score_125	:= 	wFDN_FL_PSD_lgt_125	;
self.final_score_126	:= 	wFDN_FL_PSD_lgt_126	;
self.final_score_127	:= 	wFDN_FL_PSD_lgt_127	;
self.final_score_128	:= 	wFDN_FL_PSD_lgt_128	;
self.final_score_129	:= 	wFDN_FL_PSD_lgt_129	;
self.final_score_130	:= 	wFDN_FL_PSD_lgt_130	;
self.final_score_131	:= 	wFDN_FL_PSD_lgt_131	;
self.final_score_132	:= 	wFDN_FL_PSD_lgt_132	;
self.final_score_133	:= 	wFDN_FL_PSD_lgt_133	;
self.final_score_134	:= 	wFDN_FL_PSD_lgt_134	;
self.final_score_135	:= 	wFDN_FL_PSD_lgt_135	;
self.final_score_136	:= 	wFDN_FL_PSD_lgt_136	;
self.final_score_137	:= 	wFDN_FL_PSD_lgt_137	;
self.final_score_138	:= 	wFDN_FL_PSD_lgt_138	;
self.final_score_139	:= 	wFDN_FL_PSD_lgt_139	;
self.final_score_140	:= 	wFDN_FL_PSD_lgt_140	;
self.final_score_141	:= 	wFDN_FL_PSD_lgt_141	;
self.final_score_142	:= 	wFDN_FL_PSD_lgt_142	;
self.final_score_143	:= 	wFDN_FL_PSD_lgt_143	;
self.final_score_144	:= 	wFDN_FL_PSD_lgt_144	;
self.final_score_145	:= 	wFDN_FL_PSD_lgt_145	;
self.final_score_146	:= 	wFDN_FL_PSD_lgt_146	;
self.final_score_147	:= 	wFDN_FL_PSD_lgt_147	;
self.final_score_148	:= 	wFDN_FL_PSD_lgt_148	;
self.final_score_149	:= 	wFDN_FL_PSD_lgt_149	;
self.final_score_150	:= 	wFDN_FL_PSD_lgt_150	;
self.final_score_151	:= 	wFDN_FL_PSD_lgt_151	;
self.final_score_152	:= 	wFDN_FL_PSD_lgt_152	;
self.final_score_153	:= 	wFDN_FL_PSD_lgt_153	;
self.final_score_154	:= 	wFDN_FL_PSD_lgt_154	;
self.final_score_155	:= 	wFDN_FL_PSD_lgt_155	;
self.final_score_156	:= 	wFDN_FL_PSD_lgt_156	;
self.final_score_157	:= 	wFDN_FL_PSD_lgt_157	;
self.final_score_158	:= 	wFDN_FL_PSD_lgt_158	;
self.final_score_159	:= 	wFDN_FL_PSD_lgt_159	;
self.final_score_160	:= 	wFDN_FL_PSD_lgt_160	;
self.final_score_161	:= 	wFDN_FL_PSD_lgt_161	;
self.final_score_162	:= 	wFDN_FL_PSD_lgt_162	;
self.final_score_163	:= 	wFDN_FL_PSD_lgt_163	;
self.final_score_164	:= 	wFDN_FL_PSD_lgt_164	;
self.final_score_165	:= 	wFDN_FL_PSD_lgt_165	;
self.final_score_166	:= 	wFDN_FL_PSD_lgt_166	;
self.final_score_167	:= 	wFDN_FL_PSD_lgt_167	;
self.final_score_168	:= 	wFDN_FL_PSD_lgt_168	;
self.final_score_169	:= 	wFDN_FL_PSD_lgt_169	;
self.final_score_170	:= 	wFDN_FL_PSD_lgt_170	;
self.final_score_171	:= 	wFDN_FL_PSD_lgt_171	;
self.final_score_172	:= 	wFDN_FL_PSD_lgt_172	;
self.final_score_173	:= 	wFDN_FL_PSD_lgt_173	;
self.final_score_174	:= 	wFDN_FL_PSD_lgt_174	;
self.final_score_175	:= 	wFDN_FL_PSD_lgt_175	;
self.final_score_176	:= 	wFDN_FL_PSD_lgt_176	;
self.final_score_177	:= 	wFDN_FL_PSD_lgt_177	;
self.final_score_178	:= 	wFDN_FL_PSD_lgt_178	;
self.final_score_179	:= 	wFDN_FL_PSD_lgt_179	;
self.final_score_180	:= 	wFDN_FL_PSD_lgt_180	;
self.final_score_181	:= 	wFDN_FL_PSD_lgt_181	;
self.final_score_182	:= 	wFDN_FL_PSD_lgt_182	;
self.final_score_183	:= 	wFDN_FL_PSD_lgt_183	;
self.final_score_184	:= 	wFDN_FL_PSD_lgt_184	;
self.final_score_185	:= 	wFDN_FL_PSD_lgt_185	;
self.final_score_186	:= 	wFDN_FL_PSD_lgt_186	;
self.final_score_187	:= 	wFDN_FL_PSD_lgt_187	;
self.final_score_188	:= 	wFDN_FL_PSD_lgt_188	;
self.final_score_189	:= 	wFDN_FL_PSD_lgt_189	;
self.final_score_190	:= 	wFDN_FL_PSD_lgt_190	;
self.final_score_191	:= 	wFDN_FL_PSD_lgt_191	;
self.final_score_192	:= 	wFDN_FL_PSD_lgt_192	;
self.final_score_193	:= 	wFDN_FL_PSD_lgt_193	;
self.final_score_194	:= 	wFDN_FL_PSD_lgt_194	;
self.final_score_195	:= 	wFDN_FL_PSD_lgt_195	;
self.final_score_196	:= 	wFDN_FL_PSD_lgt_196	;
self.final_score_197	:= 	wFDN_FL_PSD_lgt_197	;
self.final_score_198	:= 	wFDN_FL_PSD_lgt_198	;
self.final_score_199	:= 	wFDN_FL_PSD_lgt_199	;
self.final_score_200	:= 	wFDN_FL_PSD_lgt_200	;
self.final_score_201	:= 	wFDN_FL_PSD_lgt_201	;
self.final_score_202	:= 	wFDN_FL_PSD_lgt_202	;
self.final_score_203	:= 	wFDN_FL_PSD_lgt_203	;
self.final_score_204	:= 	wFDN_FL_PSD_lgt_204	;
self.final_score_205	:= 	wFDN_FL_PSD_lgt_205	;
self.final_score_206	:= 	wFDN_FL_PSD_lgt_206	;
self.final_score_207	:= 	wFDN_FL_PSD_lgt_207	;
self.final_score_208	:= 	wFDN_FL_PSD_lgt_208	;
self.final_score_209	:= 	wFDN_FL_PSD_lgt_209	;
self.final_score_210	:= 	wFDN_FL_PSD_lgt_210	;
self.final_score_211	:= 	wFDN_FL_PSD_lgt_211	;
self.final_score_212	:= 	wFDN_FL_PSD_lgt_212	;
self.final_score_213	:= 	wFDN_FL_PSD_lgt_213	;
self.final_score_214	:= 	wFDN_FL_PSD_lgt_214	;
self.final_score_215	:= 	wFDN_FL_PSD_lgt_215	;
self.final_score_216	:= 	wFDN_FL_PSD_lgt_216	;
self.final_score_217	:= 	wFDN_FL_PSD_lgt_217	;
self.final_score_218	:= 	wFDN_FL_PSD_lgt_218	;
self.final_score_219	:= 	wFDN_FL_PSD_lgt_219	;
self.final_score_220	:= 	wFDN_FL_PSD_lgt_220	;
self.final_score_221	:= 	wFDN_FL_PSD_lgt_221	;
self.final_score_222	:= 	wFDN_FL_PSD_lgt_222	;
self.final_score_223	:= 	wFDN_FL_PSD_lgt_223	;
self.final_score_224	:= 	wFDN_FL_PSD_lgt_224	;
self.final_score_225	:= 	wFDN_FL_PSD_lgt_225	;
self.final_score_226	:= 	wFDN_FL_PSD_lgt_226	;
self.final_score_227	:= 	wFDN_FL_PSD_lgt_227	;
self.final_score_228	:= 	wFDN_FL_PSD_lgt_228	;
self.final_score_229	:= 	wFDN_FL_PSD_lgt_229	;
self.final_score_230	:= 	wFDN_FL_PSD_lgt_230	;
self.final_score_231	:= 	wFDN_FL_PSD_lgt_231	;
// self.wFDN_submodel_lgt	:= 	wFDN_FL_PSD_lgt	;
self.FP3_wFDN_LGT		:= 	wFDN_FL_PSD_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
