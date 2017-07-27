
export FP3FDN1505_FLA( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLA____lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FLA____lgt_1 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 50.45) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 35) => 0.4632690744,
      (r_F01_inp_addr_address_score_d > 35) => 0.0823342255,
      (r_F01_inp_addr_address_score_d = NULL) => 0.1318342341, 0.1318342341),
   (c_fammar_p > 50.45) => -0.0286838065,
   (c_fammar_p = NULL) => -0.0424770385, -0.0171474015),
(f_inq_HighRiskCredit_count_i > 1.5) => 
   map(
   (NULL < f_vf_hi_risk_ct_i and f_vf_hi_risk_ct_i <= 0.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0993396888,
      (f_inq_Communications_count_i > 0.5) => 0.4995485839,
      (f_inq_Communications_count_i = NULL) => 0.2149131406, 0.2149131406),
   (f_vf_hi_risk_ct_i > 0.5) => 0.7251361300,
   (f_vf_hi_risk_ct_i = NULL) => 0.2992727185, 0.2992727185),
(f_inq_HighRiskCredit_count_i = NULL) => 0.2137423010, -0.0016766067);

// Tree: 2 
wFDN_FLA____lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 35) => 
      map(
      (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 0.4752556411,
      (nf_vf_hi_risk_hit_type > 3.5) => 0.0888578890,
      (nf_vf_hi_risk_hit_type = NULL) => 0.1301778799, 0.1301778799),
   (r_F01_inp_addr_address_score_d > 35) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0367045290,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1647692388,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0323764528, -0.0323764528),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0228201195, -0.0228201195),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0642526705,
   (f_rel_under500miles_cnt_d > 5.5) => 0.3461044777,
   (f_rel_under500miles_cnt_d = NULL) => 0.1158247940, 0.2215997756),
(f_varrisktype_i = NULL) => 0.1231609134, -0.0066591593);

// Tree: 3 
wFDN_FLA____lgt_3 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 49.5) => 0.0298922530,
      (c_low_ed > 49.5) => 0.2275184567,
      (c_low_ed = NULL) => 0.0068033534, 0.0973517796),
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 209.5) => -0.0506509473,
      (r_A50_pb_average_dollars_d > 209.5) => 0.0061457916,
      (r_A50_pb_average_dollars_d = NULL) => -0.0286803894, -0.0286803894),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0205403747, -0.0205403747),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.2612268460,
   (r_I60_inq_comm_recency_d > 549) => 0.0771289868,
   (r_I60_inq_comm_recency_d = NULL) => 0.1230282717, 0.1230282717),
(f_srchvelocityrisktype_i = NULL) => 0.0923682684, -0.0066502854);

// Tree: 4 
wFDN_FLA____lgt_4 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0330250297,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 21.95) => 0.0159239003,
         (c_famotf18_p > 21.95) => 0.1524494936,
         (c_famotf18_p = NULL) => -0.0176964805, 0.0400214622),
      (nf_seg_FraudPoint_3_0 = '') => -0.0172931553, -0.0172931553),
   (f_assocsuspicousidcount_i > 15.5) => 0.3728921450,
   (f_assocsuspicousidcount_i = NULL) => -0.0149041340, -0.0149041340),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1030954130,
   (f_varrisktype_i > 2.5) => 0.2867436561,
   (f_varrisktype_i = NULL) => 0.1818639722, 0.1818639722),
(f_inq_Communications_count_i = NULL) => 0.1159683813, -0.0065319955);

// Tree: 5 
wFDN_FLA____lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
         map(
         (NULL < c_highinc and c_highinc <= 8.75) => 0.1484784188,
         (c_highinc > 8.75) => 0.0011340137,
         (c_highinc = NULL) => 0.0149023500, 0.0588342081),
      (r_F01_inp_addr_address_score_d > 95) => -0.0313587474,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0223882316, -0.0223882316),
   (k_inq_per_addr_i > 3.5) => 0.0892974203,
   (k_inq_per_addr_i = NULL) => -0.0111120553, -0.0111120553),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 6.5) => 0.1174180111,
   (f_assocsuspicousidcount_i > 6.5) => 0.2834467711,
   (f_assocsuspicousidcount_i = NULL) => 0.1523475589, 0.1523475589),
(f_varrisktype_i = NULL) => 0.0801080906, -0.0051301109);

// Tree: 6 
wFDN_FLA____lgt_6 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.2418766338,
   (r_I60_inq_comm_recency_d > 549) => 0.1061298087,
   (r_I60_inq_comm_recency_d = NULL) => 0.1493579239, 0.1493579239),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 10.5) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 0.1446112860,
      (nf_vf_hi_risk_index > 4.5) => 
         map(
         (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0262970823,
         (r_D32_felony_count_i > 0.5) => 0.1957322085,
         (r_D32_felony_count_i = NULL) => -0.0237631149, -0.0237631149),
      (nf_vf_hi_risk_index = NULL) => -0.0204941248, -0.0204941248),
   (f_srchfraudsrchcount_i > 10.5) => 0.1440872473,
   (f_srchfraudsrchcount_i = NULL) => -0.0179120254, -0.0179120254),
(r_D33_Eviction_Recency_d = NULL) => 0.0645793813, -0.0099049369);

// Tree: 7 
wFDN_FLA____lgt_7 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.2180789050,
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.55) => 0.0490196910,
      (c_famotf18_p > 31.55) => 0.2337442020,
      (c_famotf18_p = NULL) => 0.0724085826, 0.0724085826),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0897580816, 0.0897580816),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0306632620,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.1354744897,
      (r_Ever_Asset_Owner_d > 0.5) => 0.0050904021,
      (r_Ever_Asset_Owner_d = NULL) => 0.0282369184, 0.0282369184),
   (f_assocrisktype_i = NULL) => -0.0168008143, -0.0168008143),
(nf_vf_hi_risk_hit_type = NULL) => 0.0383417399, -0.0085075158);

// Tree: 8 
wFDN_FLA____lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0452083856,
      (f_rel_felony_count_i > 1.5) => 0.2612187375,
      (f_rel_felony_count_i = NULL) => 0.0630149308, 0.0630149308),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => -0.0322943734,
      (f_inq_PrepaidCards_count_i > 0.5) => 0.1423084971,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0290456264, -0.0290456264),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0206117770, -0.0206117770),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0460267446,
   (f_rel_felony_count_i > 0.5) => 0.1761483631,
   (f_rel_felony_count_i = NULL) => 0.0722389695, 0.0722389695),
(f_varrisktype_i = NULL) => 0.0298034906, -0.0098022804);

// Tree: 9 
wFDN_FLA____lgt_9 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 76.65) => 0.1827092350,
   (c_fammar_p > 76.65) => 0.0451758269,
   (c_fammar_p = NULL) => 0.1302398423, 0.1302398423),
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.1401587720,
      (k_estimated_income_d > 26500) => 0.0393293424,
      (k_estimated_income_d = NULL) => 0.0583654868, 0.0583654868),
   (c_fammar_p > 59.25) => -0.0215764484,
   (c_fammar_p = NULL) => -0.0419324015, -0.0102963376),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 120.5) => 0.0092791024,
   (c_cartheft > 120.5) => 0.2181459393,
   (c_cartheft = NULL) => 0.0913853762, 0.0913853762), -0.0049525200);

// Tree: 10 
wFDN_FLA____lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 0.1487273991,
   (nf_vf_hi_risk_index > 3.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0301214279,
      (f_hh_lienholders_i > 0.5) => 0.0263995834,
      (f_hh_lienholders_i = NULL) => -0.0131252676, -0.0131252676),
   (nf_vf_hi_risk_index = NULL) => -0.0108611255, -0.0108611255),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0477370511,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_child and c_child <= 20.75) => 0.0222094237,
      (c_child > 20.75) => 0.2078374599,
      (c_child = NULL) => 0.1618641612, 0.1618641612),
   (nf_seg_FraudPoint_3_0 = '') => 0.1049311864, 0.1049311864),
(f_inq_Communications_count_i = NULL) => 0.0205875201, -0.0064580380);

// Tree: 11 
wFDN_FLA____lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3856939964,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0478479502,
         (r_D33_eviction_count_i > 1.5) => 0.2043426433,
         (r_D33_eviction_count_i = NULL) => 0.0576856243, 0.0576856243),
      (r_I60_inq_comm_recency_d > 549) => -0.0227057245,
      (r_I60_inq_comm_recency_d = NULL) => -0.0157104661, -0.0157104661),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0175210557, -0.0134233419),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 5.5) => 0.2148403386,
   (f_prevaddrlenofres_d > 5.5) => 0.0872463568,
   (f_prevaddrlenofres_d = NULL) => 0.1066580908, 0.1066580908),
(k_inq_ssns_per_addr_i = NULL) => -0.0078381590, -0.0078381590);

// Tree: 12 
wFDN_FLA____lgt_12 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 109.5) => 0.1119317153,
      (c_ab_av_edu > 109.5) => 0.0025835379,
      (c_ab_av_edu = NULL) => -0.0572832242, 0.0595073403),
   (k_estimated_income_d > 26500) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1344381247,
         (r_C10_M_Hdr_FS_d > 7.5) => -0.0229479232,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0206706789, -0.0206706789),
      (r_D33_eviction_count_i > 2.5) => 0.1878005522,
      (r_D33_eviction_count_i = NULL) => -0.0192662648, -0.0192662648),
   (k_estimated_income_d = NULL) => -0.0129289813, -0.0129289813),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.0973059282,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0362359099, -0.0087726412);

// Tree: 13 
wFDN_FLA____lgt_13 := map(
(NULL < c_fammar_p and c_fammar_p <= 51.45) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0566217502,
   (f_rel_felony_count_i > 2.5) => 0.1772301520,
   (f_rel_felony_count_i = NULL) => 0.0634052542, 0.0634052542),
(c_fammar_p > 51.45) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
         map(
         (NULL < nf_vf_type and nf_vf_type <= 1.5) => -0.0216309637,
         (nf_vf_type > 1.5) => 0.0778814500,
         (nf_vf_type = NULL) => -0.0187986107, -0.0187986107),
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1394781673,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0174430126, -0.0174430126),
   (f_assocsuspicousidcount_i > 13.5) => 0.1754432473,
   (f_assocsuspicousidcount_i = NULL) => 0.0294909150, -0.0152052246),
(c_fammar_p = NULL) => -0.0507071878, -0.0094341167);

// Tree: 14 
wFDN_FLA____lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1026760130,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 0.1686913183,
      (r_I60_inq_recency_d > 2) => 0.0387697700,
      (r_I60_inq_recency_d = NULL) => 0.0547064086, 0.0547064086),
   (nf_vf_hi_risk_index > 6) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0453463090,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 59.45) => 0.0476031895,
         (c_fammar_p > 59.45) => -0.0089770133,
         (c_fammar_p = NULL) => -0.0557002788, -0.0016360799),
      (nf_seg_FraudPoint_3_0 = '') => -0.0185328286, -0.0185328286),
   (nf_vf_hi_risk_index = NULL) => -0.0133742022, -0.0133742022),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0167604152, -0.0096720948);

// Tree: 15 
wFDN_FLA____lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 60.85) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 5.5) => 0.0291077564,
      (r_L79_adls_per_addr_c6_i > 5.5) => 0.1605300106,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0356513173, 0.0356513173),
   (k_comb_age_d > 68.5) => 0.2952606911,
   (k_comb_age_d = NULL) => 0.0477171203, 0.0477171203),
(c_fammar_p > 60.85) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 9.5) => -0.0214167409,
   (f_srchfraudsrchcount_i > 9.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 26.05) => -0.0444398243,
      (c_hh2_p > 26.05) => 0.1102152239,
      (c_hh2_p = NULL) => 0.0713646804, 0.0713646804),
   (f_srchfraudsrchcount_i = NULL) => 0.0432700102, -0.0189202857),
(c_fammar_p = NULL) => -0.0330449081, -0.0085917017);

// Tree: 16 
wFDN_FLA____lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.55) => 
         map(
         (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 0.0067015662,
         (r_F01_inp_addr_not_verified_i > 0.5) => 0.0804440878,
         (r_F01_inp_addr_not_verified_i = NULL) => 0.0190169163, 0.0190169163),
      (c_unemp > 8.55) => 0.1175232747,
      (c_unemp = NULL) => -0.0324616807, 0.0228817629),
   (f_corraddrnamecount_d > 4.5) => -0.0209799582,
   (f_corraddrnamecount_d = NULL) => -0.0084390828, -0.0084390828),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.75) => 0.0689041291,
   (c_unemp > 7.75) => 0.2094608042,
   (c_unemp = NULL) => 0.0869531403, 0.0869531403),
(r_D30_Derog_Count_i = NULL) => 0.0194156771, -0.0033554151);

// Tree: 17 
wFDN_FLA____lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 22500) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 78.5) => 0.1439529098,
      (c_rest_indx > 78.5) => 0.0296959886,
      (c_rest_indx = NULL) => -0.0044470936, 0.0550699185),
   (k_estimated_income_d > 22500) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.1161351115,
      (r_D33_Eviction_Recency_d > 30) => -0.0264167744,
      (r_D33_Eviction_Recency_d = NULL) => -0.0253279687, -0.0253279687),
   (k_estimated_income_d = NULL) => -0.0096676081, -0.0204431496),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0323632516,
   (f_hh_payday_loan_users_i > 0.5) => 0.1177546766,
   (f_hh_payday_loan_users_i = NULL) => 0.0452304526, 0.0452304526),
(k_inq_per_addr_i = NULL) => -0.0132053336, -0.0132053336);

// Tree: 18 
wFDN_FLA____lgt_18 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 3.5) => -0.0143582092,
   (k_inq_ssns_per_addr_i > 3.5) => 0.1124259523,
   (k_inq_ssns_per_addr_i = NULL) => -0.0131602300, -0.0131602300),
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -21.5) => 0.1565161102,
   (f_addrchangecrimediff_i > -21.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 7.5) => 0.0103755726,
      (f_srchfraudsrchcount_i > 7.5) => 0.1083196828,
      (f_srchfraudsrchcount_i = NULL) => 0.0166709339, 0.0166709339),
   (f_addrchangecrimediff_i = NULL) => 0.0911398505, 0.0395444612),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 78.5) => 0.1090897011,
   (c_fammar_p > 78.5) => -0.0559058290,
   (c_fammar_p = NULL) => 0.0345361653, 0.0345361653), -0.0049342029);

// Tree: 19 
wFDN_FLA____lgt_19 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1459505162,
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.1154834289,
      (r_C10_M_Hdr_FS_d > 8.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98) => -0.0167602818,
         (f_addrchangecrimediff_i > 98) => 0.1379923342,
         (f_addrchangecrimediff_i = NULL) => -0.0002095507, -0.0118993509),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0100290155, -0.0100290155),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0087433522, -0.0087433522),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0384671518,
   (f_rel_ageover20_count_d > 20.5) => 0.1018072969,
   (f_rel_ageover20_count_d = NULL) => 0.0484724741, 0.0484724741),
(f_srchvelocityrisktype_i = NULL) => 0.0028841173, -0.0013743745);

// Tree: 20 
wFDN_FLA____lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0157537774,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -3.5) => 0.1851622282,
      (f_addrchangecrimediff_i > -3.5) => 0.0228202355,
      (f_addrchangecrimediff_i = NULL) => 0.1129986641, 0.0493886085),
   (k_inq_per_addr_i = NULL) => -0.0095578356, -0.0095578356),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 6.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 0.0277469336,
      (r_D30_Derog_Count_i > 2.5) => 0.0972914916,
      (r_D30_Derog_Count_i = NULL) => 0.0391259899, 0.0391259899),
   (r_L79_adls_per_addr_c6_i > 6.5) => 0.1693637325,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0465120500, 0.0465120500),
(f_varrisktype_i = NULL) => 0.0120325635, -0.0030958701);

// Tree: 21 
wFDN_FLA____lgt_21 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0205021569,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 7.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 48.5) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 12.95) => 0.0380907087,
         (c_vacant_p > 12.95) => 0.1654660132,
         (c_vacant_p = NULL) => 0.0786192147, 0.0786192147),
      (c_ab_av_edu > 48.5) => 0.0066724296,
      (c_ab_av_edu = NULL) => -0.0180428304, 0.0131610184),
   (f_assocsuspicousidcount_i > 7.5) => 0.0967413528,
   (f_assocsuspicousidcount_i = NULL) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 7.05) => -0.0501340217,
      (c_pop_12_17_p > 7.05) => 0.0774370786,
      (c_pop_12_17_p = NULL) => 0.0195265133, 0.0195265133), 0.0210022628),
(nf_seg_FraudPoint_3_0 = '') => -0.0106667382, -0.0106667382);

// Tree: 22 
wFDN_FLA____lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 47) => 0.0274130195,
   (c_rich_wht > 47) => -0.0240569666,
   (c_rich_wht = NULL) => -0.0216221467, -0.0147993516),
(f_assocrisktype_i > 5.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 2.5) => 0.1497273310,
   (r_C12_source_profile_index_d > 2.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0326153113,
      (r_D33_eviction_count_i > 2.5) => 0.1475224227,
      (r_D33_eviction_count_i = NULL) => 0.0371070605, 0.0371070605),
   (r_C12_source_profile_index_d = NULL) => 0.0481525101, 0.0481525101),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 58) => -0.0898877554,
   (c_bel_edu > 58) => 0.0564504366,
   (c_bel_edu = NULL) => 0.0051370446, 0.0051370446), -0.0067777842);

// Tree: 23 
wFDN_FLA____lgt_23 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 24.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0160771899,
   (k_comb_age_d > 70.5) => 0.0925768217,
   (k_comb_age_d = NULL) => -0.0107084035, -0.0107084035),
(f_addrchangecrimediff_i > 24.5) => 0.0825710805,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 52.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 
         map(
         (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => 0.0128520166,
         (f_bus_addr_match_count_d > 6.5) => 0.2502678415,
         (f_bus_addr_match_count_d = NULL) => 0.0397233150, 0.0397233150),
      (f_crim_rel_under25miles_cnt_i > 4.5) => 0.2008855691,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.1353164711, 0.0580712706),
   (c_born_usa > 52.5) => -0.0089415339,
   (c_born_usa = NULL) => -0.0263349398, 0.0092689865), -0.0033474849);

// Tree: 24 
wFDN_FLA____lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0146289686,
   (c_unemp > 8.95) => 
      map(
      (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.1125199106,
      (f_curraddractivephonelist_d > 0.5) => 0.0023720770,
      (f_curraddractivephonelist_d = NULL) => 0.0642173770, 0.0642173770),
   (c_unemp = NULL) => -0.0246252042, -0.0113183698),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 59.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0106214344,
      (f_rel_felony_count_i > 0.5) => 0.1014799030,
      (f_rel_felony_count_i = NULL) => 0.0272437204, 0.0272437204),
   (k_comb_age_d > 59.5) => 0.1819685057,
   (k_comb_age_d = NULL) => 0.0438254602, 0.0438254602),
(k_inq_per_addr_i = NULL) => -0.0053801379, -0.0053801379);

// Tree: 25 
wFDN_FLA____lgt_25 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0011116748,
      (r_L79_adls_per_addr_c6_i > 3.5) => 0.0883638499,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0090062959, 0.0090062959),
   (f_historical_count_d > 0.5) => -0.0368610594,
   (f_historical_count_d = NULL) => -0.0132112404, -0.0132112404),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0333083702,
   (f_srchfraudsrchcountmo_i > 0.5) => 0.1637760399,
   (f_srchfraudsrchcountmo_i = NULL) => 0.0403935591, 0.0403935591),
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 97.5) => -0.0539519909,
   (c_burglary > 97.5) => 0.0919033407,
   (c_burglary = NULL) => 0.0173550601, 0.0173550601), -0.0051075308);

// Tree: 26 
wFDN_FLA____lgt_26 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 27.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 10.5) => -0.0079447994,
   (r_D30_Derog_Count_i > 10.5) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 1.5) => 0.0119529297,
      (f_assoccredbureaucount_i > 1.5) => 0.1764557051,
      (f_assoccredbureaucount_i = NULL) => 0.0937448125, 0.0937448125),
   (r_D30_Derog_Count_i = NULL) => 0.0000058131, -0.0062409885),
(c_famotf18_p > 27.05) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 72.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 75.5) => -0.0150752594,
      (c_lar_fam > 75.5) => 0.1188065150,
      (c_lar_fam = NULL) => 0.0809370988, 0.0809370988),
   (f_mos_inq_banko_cm_fseen_d > 72.5) => 0.0224199654,
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0405607950, 0.0405607950),
(c_famotf18_p = NULL) => 0.0077890483, -0.0016728382);

// Tree: 27 
wFDN_FLA____lgt_27 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1514857311) => 0.0474984708,
   (f_add_curr_nhood_BUS_pct_i > 0.1514857311) => 0.1944038964,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0661334085, 0.0661334085),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1621919554,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 46.85) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 104.5) => 0.0692384941,
         (c_medi_indx > 104.5) => -0.0384473299,
         (c_medi_indx = NULL) => 0.0455237489, 0.0455237489),
      (c_fammar_p > 46.85) => -0.0125038999,
      (c_fammar_p = NULL) => -0.0063124316, -0.0088774999),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0080536165, -0.0080536165),
(r_D33_Eviction_Recency_d = NULL) => 0.0103562750, -0.0049980780);

// Tree: 28 
wFDN_FLA____lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.1586406643,
   (f_M_Bureau_ADL_FS_noTU_d > 2.5) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0116079559,
         (r_C23_inp_addr_occ_index_d > 2) => 0.1650349667,
         (r_C23_inp_addr_occ_index_d = NULL) => 0.0809921455, 0.0809921455),
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0074964866,
      (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0063660785, -0.0063660785),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0053917606, -0.0053917606),
(r_D33_eviction_count_i > 2.5) => 0.1045273105,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 98.5) => -0.0427336615,
   (c_burglary > 98.5) => 0.0798875291,
   (c_burglary = NULL) => 0.0173588425, 0.0173588425), -0.0038590754);

// Tree: 29 
wFDN_FLA____lgt_29 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 192.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 61712.5) => 0.1645897360,
         (r_L80_Inp_AVM_AutoVal_d > 61712.5) => 0.0267548389,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0152410906, 0.0254625478),
      (c_serv_empl > 192.5) => 0.1468178803,
      (c_serv_empl = NULL) => -0.0294141371, 0.0260082109),
   (f_corraddrnamecount_d > 3.5) => -0.0128405508,
   (f_corraddrnamecount_d = NULL) => -0.0060145890, -0.0060145890),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1323770248,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 78.5) => 0.0429435508,
   (c_fammar_p > 78.5) => -0.0823402837,
   (c_fammar_p = NULL) => -0.0112572570, -0.0112572570), -0.0055058001);

// Tree: 30 
wFDN_FLA____lgt_30 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 79.5) => 0.1625965077,
   (r_D32_Mos_Since_Fel_LS_d > 79.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 8288.5) => -0.0178248656,
      (f_addrchangeincomediff_d > 8288.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 85.5) => 0.1531559501,
         (c_work_home > 85.5) => -0.0029562987,
         (c_work_home = NULL) => 0.0505166325, 0.0505166325),
      (f_addrchangeincomediff_d = NULL) => 0.0018802154, -0.0109408056),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0102235315, -0.0102235315),
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 613) => 0.1688111543,
   (c_popover25 > 613) => 0.0344560444,
   (c_popover25 = NULL) => 0.0546255766, 0.0546255766),
(f_srchaddrsrchcount_i = NULL) => -0.0029550465, -0.0080073512);

// Tree: 31 
wFDN_FLA____lgt_31 := map(
(NULL < c_unemp and c_unemp <= 8.35) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 2.5) => 0.1243631992,
   (f_M_Bureau_ADL_FS_all_d > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0069195064,
      (k_comb_age_d > 81.5) => 0.1555882235,
      (k_comb_age_d = NULL) => -0.0048600931, -0.0048600931),
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0150828652, -0.0040304942),
(c_unemp > 8.35) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0189554421,
   (f_rel_criminal_count_i > 2.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 51.5) => -0.0012084206,
      (r_pb_order_freq_d > 51.5) => 0.0858089547,
      (r_pb_order_freq_d = NULL) => 0.1374175152, 0.0843713181),
   (f_rel_criminal_count_i = NULL) => 0.0402175418, 0.0402175418),
(c_unemp = NULL) => -0.0307497098, -0.0016532520);

// Tree: 32 
wFDN_FLA____lgt_32 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0094089120,
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => 0.0298460730,
      (f_assocsuspicousidcount_i > 8.5) => 0.1709054406,
      (f_assocsuspicousidcount_i = NULL) => 0.0396906949, 0.0396906949),
   (f_phones_per_addr_curr_i = NULL) => -0.0053543339, -0.0053543339),
(f_srchaddrsrchcount_i > 15.5) => 
   map(
   (NULL < c_employees and c_employees <= 23.5) => 0.1819642404,
   (c_employees > 23.5) => 0.0486970840,
   (c_employees = NULL) => 0.0691710884, 0.0691710884),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0258770225,
   (c_assault > 90) => 0.0825274408,
   (c_assault = NULL) => 0.0250512489, 0.0250512489), -0.0028137244);

// Tree: 33 
wFDN_FLA____lgt_33 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => -0.0063753954,
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1056907163,
   (f_inq_PrepaidCards_count_i = NULL) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 76.65) => 0.0634714981,
      (c_fammar_p > 76.65) => -0.0819101575,
      (c_fammar_p = NULL) => -0.0164329233, -0.0164329233), -0.0059477017),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.55) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.026257428) => 0.0966228171,
      (f_add_input_nhood_BUS_pct_i > 0.026257428) => -0.0048290696,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0345054431, 0.0345054431),
   (c_unemp > 7.55) => 0.1514688477,
   (c_unemp = NULL) => 0.0512145009, 0.0512145009),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0030997307, -0.0030997307);

// Tree: 34 
wFDN_FLA____lgt_34 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 43.5) => -0.0016191043,
(r_pb_order_freq_d > 43.5) => -0.0262117245,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 121.5) => -0.0101950214,
      (f_prevaddrageoldest_d > 121.5) => 0.0616548446,
      (f_prevaddrageoldest_d = NULL) => -0.0228703814, 0.0068277642),
   (r_L79_adls_per_addr_c6_i > 2.5) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 110.5) => 0.0899548338,
         (c_ab_av_edu > 110.5) => -0.0140051813,
         (c_ab_av_edu = NULL) => 0.0459144933, 0.0459144933),
      (f_hh_payday_loan_users_i > 0.5) => 0.1647583674,
      (f_hh_payday_loan_users_i = NULL) => 0.0576861731, 0.0576861731),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0171000727, 0.0171000727), -0.0030533683);

// Tree: 35 
wFDN_FLA____lgt_35 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => -0.0137174171,
   (f_hh_tot_derog_i > 5.5) => 0.0866422490,
   (f_hh_tot_derog_i = NULL) => -0.0112376935, -0.0112376935),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 0.0191168287,
      (k_comb_age_d > 68.5) => 0.2022214202,
      (k_comb_age_d = NULL) => 0.0253818664, 0.0253818664),
   (f_rel_homeover500_count_d > 8.5) => 0.2021777874,
   (f_rel_homeover500_count_d = NULL) => 0.0317628019, 0.0317628019),
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 24.95) => 0.1223642553,
   (C_RENTOCC_P > 24.95) => -0.0363682749,
   (C_RENTOCC_P = NULL) => 0.0307877956, 0.0307877956), -0.0051548524);

// Tree: 36 
wFDN_FLA____lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0193339383,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
         map(
         (NULL < f_liens_unrel_ST_ct_i and f_liens_unrel_ST_ct_i <= 1.5) => 0.0063836169,
         (f_liens_unrel_ST_ct_i > 1.5) => 0.1635239266,
         (f_liens_unrel_ST_ct_i = NULL) => 0.0092786429, 0.0092786429),
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.1249584721,
      (f_inq_PrepaidCards_count24_i = NULL) => 0.0111896873, 0.0111896873),
   (k_inq_per_addr_i > 6.5) => 0.0865262511,
   (k_inq_per_addr_i = NULL) => 0.0151817838, 0.0151817838),
(f_hh_criminals_i = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 117.5) => -0.0574185330,
   (c_cartheft > 117.5) => 0.0778944271,
   (c_cartheft = NULL) => -0.0005478686, -0.0005478686), -0.0083107495);

// Tree: 37 
wFDN_FLA____lgt_37 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 63.5) => -0.0277189411,
   (c_unempl > 63.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 3507.5) => 0.0249175467,
      (f_addrchangeincomediff_d > 3507.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 3.35) => 0.2659038426,
         (c_pop_65_74_p > 3.35) => 0.0496291728,
         (c_pop_65_74_p = NULL) => 0.1111082667, 0.1111082667),
      (f_addrchangeincomediff_d = NULL) => 0.0545151267, 0.0343531053),
   (c_unempl = NULL) => 0.0185733866, 0.0189901466),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 15.5) => -0.0162284209,
   (f_inq_Collection_count_i > 15.5) => 0.1171671254,
   (f_inq_Collection_count_i = NULL) => -0.0142330996, -0.0142330996),
(f_historical_count_d = NULL) => 0.0059077965, 0.0020013312);

// Tree: 38 
wFDN_FLA____lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0152423164,
      (f_assocsuspicousidcount_i > 13.5) => 0.1068820174,
      (f_assocsuspicousidcount_i = NULL) => -0.0142778096, -0.0142778096),
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 71.5) => 0.0724113238,
      (c_employees > 71.5) => 0.0092790364,
      (c_employees = NULL) => 0.0226755096, 0.0226755096),
   (f_inq_Other_count_i = NULL) => -0.0058822956, -0.0058822956),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1309624264,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 51) => 0.0926665781,
   (c_born_usa > 51) => -0.0310216789,
   (c_born_usa = NULL) => 0.0153614174, 0.0153614174), -0.0049452956);

// Tree: 39 
wFDN_FLA____lgt_39 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0070149556,
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 45.55) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 33.5) => 0.1728448068,
         (c_born_usa > 33.5) => -0.0046672118,
         (c_born_usa = NULL) => 0.0254095754, 0.0254095754),
      (c_hh2_p > 45.55) => 0.2546940965,
      (c_hh2_p = NULL) => 0.0635178060, 0.0635178060),
   (k_comb_age_d = NULL) => -0.0026437774, -0.0026437774),
(f_hh_tot_derog_i > 4.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.1478118499,
   (k_nap_fname_verd_d > 0.5) => 0.0212663964,
   (k_nap_fname_verd_d = NULL) => 0.0545026411, 0.0545026411),
(f_hh_tot_derog_i = NULL) => -0.0015005375, 0.0001345748);

// Tree: 40 
wFDN_FLA____lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98) => 
   map(
   (NULL < c_food and c_food <= 82.4) => -0.0056973411,
   (c_food > 82.4) => 0.1165927925,
   (c_food = NULL) => -0.0039187603, -0.0039187603),
(f_addrchangecrimediff_i > 98) => 0.1102542912,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 136.5) => -0.0117614660,
   (c_span_lang > 136.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 35757.5) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.1) => 0.0450921936,
         (c_pop_45_54_p > 14.1) => 0.2108903357,
         (c_pop_45_54_p = NULL) => 0.1095692488, 0.1095692488),
      (f_curraddrmedianincome_d > 35757.5) => 0.0186673519,
      (f_curraddrmedianincome_d = NULL) => 0.0418427181, 0.0384003964),
   (c_span_lang = NULL) => -0.0142202859, 0.0043896357), -0.0011974561);

// Tree: 41 
wFDN_FLA____lgt_41 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
   map(
   (NULL < c_construction and c_construction <= 5) => 0.1881951404,
   (c_construction > 5) => 0.0030484647,
   (c_construction = NULL) => 0.0934000424, 0.0934000424),
(r_I60_inq_comm_recency_d > 4.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 13.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 6.35) => 0.1924380918,
      (c_hh4_p > 6.35) => 0.0498799884,
      (c_hh4_p = NULL) => 0.0781739631, 0.0781739631),
   (r_D32_Mos_Since_Crim_LS_d > 13.5) => -0.0090196851,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0071639028, -0.0071639028),
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < c_child and c_child <= 25.95) => -0.0336216780,
   (c_child > 25.95) => 0.0764390763,
   (c_child = NULL) => 0.0090375291, 0.0090375291), -0.0059537330);

// Tree: 42 
wFDN_FLA____lgt_42 := map(
(NULL < c_business and c_business <= 5.5) => 
   map(
   (NULL < nf_altlexid_addr_hi_no_hi_lexid and nf_altlexid_addr_hi_no_hi_lexid <= 0.5) => 0.0209630169,
   (nf_altlexid_addr_hi_no_hi_lexid > 0.5) => 0.1284479058,
   (nf_altlexid_addr_hi_no_hi_lexid = NULL) => 0.0270744086, 0.0270744086),
(c_business > 5.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 75.5) => -0.0226244227,
   (f_prevaddrageoldest_d > 75.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.0911738529,
      (r_F01_inp_addr_address_score_d > 25) => 
         map(
         (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 51.5) => 0.0020891346,
         (f_bus_addr_match_count_d > 51.5) => 0.3169409469,
         (f_bus_addr_match_count_d = NULL) => 0.0054936741, 0.0054936741),
      (r_F01_inp_addr_address_score_d = NULL) => 0.0089436439, 0.0089436439),
   (f_prevaddrageoldest_d = NULL) => -0.0046232651, -0.0081719707),
(c_business = NULL) => -0.0393759704, -0.0040680021);

// Tree: 43 
wFDN_FLA____lgt_43 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 87.5) => 0.2054518490,
   (c_lux_prod > 87.5) => 0.0029444649,
   (c_lux_prod = NULL) => 0.0697171699, 0.0697171699),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.25) => -0.0253506246,
      (c_pop_75_84_p > 2.25) => 0.0691510406,
      (c_pop_75_84_p = NULL) => 0.0335670802, 0.0335670802),
   (r_F01_inp_addr_address_score_d > 25) => -0.0059434467,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0037824392, -0.0037824392),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 6.8) => 0.0712192446,
   (c_lowrent > 6.8) => -0.0540280784,
   (c_lowrent = NULL) => 0.0032278407, 0.0032278407), -0.0025920103);

// Tree: 44 
wFDN_FLA____lgt_44 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 136.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 6.5) => -0.0198493751,
      (r_L79_adls_per_addr_curr_i > 6.5) => 0.0474675620,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0164229646, -0.0164229646),
   (c_easiqlife > 136.5) => 
      map(
      (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 7.5) => 0.0112314056,
      (f_crim_rel_under500miles_cnt_i > 7.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 0.5) => -0.0195288427,
         (r_pb_order_freq_d > 0.5) => 0.0092997225,
         (r_pb_order_freq_d = NULL) => 0.1700466400, 0.0696467058),
      (f_crim_rel_under500miles_cnt_i = NULL) => 0.0974526130, 0.0164302861),
   (c_easiqlife = NULL) => 0.0026839922, -0.0052636289),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1116315916,
(f_inq_PrepaidCards_count_i = NULL) => -0.0013191098, -0.0047115884);

// Tree: 45 
wFDN_FLA____lgt_45 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 0.1303642956,
   (f_rel_under25miles_cnt_d > 0.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 184.5) => 0.0218519218,
      (c_sub_bus > 184.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 55.4) => 0.0281419779,
         (r_C12_source_profile_d > 55.4) => 0.2661012084,
         (r_C12_source_profile_d = NULL) => 0.1136062086, 0.1136062086),
      (c_sub_bus = NULL) => -0.0309773879, 0.0255356966),
   (f_rel_under25miles_cnt_d = NULL) => 0.0349222116, 0.0349222116),
(f_corraddrnamecount_d > 2.5) => -0.0034963045,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 9.9) => -0.0438968244,
   (C_INC_125K_P > 9.9) => 0.0657247071,
   (C_INC_125K_P = NULL) => -0.0010645704, -0.0010645704), 0.0008687981);

// Tree: 46 
wFDN_FLA____lgt_46 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.85) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 1.5) => 0.0177061858,
      (f_hh_criminals_i > 1.5) => 0.1977838356,
      (f_hh_criminals_i = NULL) => 0.0350630677, 0.0350630677),
   (c_unemp > 8.85) => 0.1546130082,
   (c_unemp = NULL) => 0.0036814579, 0.0372540256),
(f_corraddrnamecount_d > 1.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 224) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.1) => -0.0059580006,
      (c_pop_35_44_p > 14.1) => 0.1735432560,
      (c_pop_35_44_p = NULL) => 0.0884349016, 0.0884349016),
   (r_D32_Mos_Since_Fel_LS_d > 224) => -0.0045968320,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0036616776, -0.0036616776),
(f_corraddrnamecount_d = NULL) => -0.0227235915, -0.0008479099);

// Tree: 47 
wFDN_FLA____lgt_47 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0971002821,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0074124402,
      (k_comb_age_d > 68.5) => 0.0607375287,
      (k_comb_age_d = NULL) => -0.0029497329, -0.0029497329),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0024689624, -0.0024689624),
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 15.45) => 0.0429338823,
   (C_INC_125K_P > 15.45) => 0.2332294119,
   (C_INC_125K_P = NULL) => 0.0648414940, 0.0648414940),
(f_srchfraudsrchcountmo_i = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 72.5) => -0.0863522051,
   (c_unempl > 72.5) => 0.0401241363,
   (c_unempl = NULL) => -0.0081827996, -0.0081827996), -0.0001727188);

// Tree: 48 
wFDN_FLA____lgt_48 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124975.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.2039890039,
      (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 39055) => 0.0163937853,
         (f_addrchangevaluediff_d > 39055) => 0.1721385614,
         (f_addrchangevaluediff_d = NULL) => 0.0031235298, 0.0185949380),
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0236189005, 0.0236189005),
   (r_A46_Curr_AVM_AutoVal_d > 124975.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1229141999,
      (r_C10_M_Hdr_FS_d > 7.5) => -0.0070822693,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0057575270, -0.0057575270),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0136218003, -0.0046378949),
(r_D33_eviction_count_i > 3.5) => 0.0849924843,
(r_D33_eviction_count_i = NULL) => -0.0001661541, -0.0040077470);

// Tree: 49 
wFDN_FLA____lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0002794009,
      (f_hh_criminals_i > 3.5) => 0.1225523632,
      (f_hh_criminals_i = NULL) => 0.0010052099, 0.0010052099),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 6.85) => 0.1259903267,
      (c_rnt500_p > 6.85) => 0.0223217213,
      (c_rnt500_p = NULL) => 0.0777171593, 0.0777171593),
   (f_varrisktype_i = NULL) => 0.0027143131, 0.0027143131),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0734833163,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 8.95) => -0.0291891492,
   (C_INC_125K_P > 8.95) => 0.0809322657,
   (C_INC_125K_P = NULL) => 0.0220887616, 0.0220887616), -0.0000132029);

// Tree: 50 
wFDN_FLA____lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 153.5) => -0.0134376280,
(r_A50_pb_average_dollars_d > 153.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 15.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3103793239) => 
         map(
         (NULL < c_unemp and c_unemp <= 8.65) => 0.0261484755,
         (c_unemp > 8.65) => 
            map(
            (NULL < c_cpiall and c_cpiall <= 209.3) => 0.2394914746,
            (c_cpiall > 209.3) => 0.0541950036,
            (c_cpiall = NULL) => 0.0986661567, 0.0986661567),
         (c_unemp = NULL) => -0.0010610699, 0.0304110635),
      (f_add_input_mobility_index_i > 0.3103793239) => -0.0101410753,
      (f_add_input_mobility_index_i = NULL) => 0.0164816007, 0.0164816007),
   (f_rel_homeover500_count_d > 15.5) => 0.1967423906,
   (f_rel_homeover500_count_d = NULL) => 0.0381863784, 0.0188813893),
(r_A50_pb_average_dollars_d = NULL) => -0.0046663918, 0.0004003342);

// Tree: 51 
wFDN_FLA____lgt_51 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52) => -0.0122180014,
   (f_bus_addr_match_count_d > 52) => 0.1833451038,
   (f_bus_addr_match_count_d = NULL) => -0.0108313317, -0.0108313317),
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 37.5) => 0.0331221954,
   (r_pb_order_freq_d > 37.5) => -0.0195929816,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 0.0294007262,
      (f_phones_per_addr_curr_i > 9.5) => 0.1052292186,
      (f_phones_per_addr_curr_i = NULL) => 0.0389810394, 0.0389810394), 0.0163992910),
(f_rel_criminal_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.35) => -0.0616611743,
   (c_pop_35_44_p > 16.35) => 0.0646728715,
   (c_pop_35_44_p = NULL) => -0.0081446688, -0.0081446688), -0.0036063099);

// Tree: 52 
wFDN_FLA____lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 19.5) => -0.0062301185,
   (f_srchaddrsrchcount_i > 19.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 64.5) => -0.0271101903,
      (C_OWNOCC_P > 64.5) => 0.1643213846,
      (C_OWNOCC_P = NULL) => 0.0871978724, 0.0871978724),
   (f_srchaddrsrchcount_i = NULL) => -0.0050880474, -0.0050880474),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.65) => 0.0182472457,
   (c_pop_6_11_p > 10.65) => 
      map(
      (NULL < c_preschl and c_preschl <= 126) => 0.2128287026,
      (c_preschl > 126) => 0.0510277529,
      (c_preschl = NULL) => 0.1129515731, 0.1129515731),
   (c_pop_6_11_p = NULL) => 0.0316816599, 0.0316816599),
(f_phones_per_addr_curr_i = NULL) => 0.0023638283, -0.0016489822);

// Tree: 53 
wFDN_FLA____lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0147124563,
   (r_D32_felony_count_i > 0.5) => 0.0816610793,
   (r_D32_felony_count_i = NULL) => 0.0227395966, -0.0130988674),
(c_easiqlife > 129.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 37.35) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 118.5) => 0.0113775568,
      (c_sub_bus > 118.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -14111) => 0.1584259899,
         (f_addrchangeincomediff_d > -14111) => 0.0453168185,
         (f_addrchangeincomediff_d = NULL) => 0.0876191031, 0.0596608605),
      (c_sub_bus = NULL) => 0.0310378242, 0.0310378242),
   (c_high_ed > 37.35) => -0.0123467412,
   (c_high_ed = NULL) => 0.0154363869, 0.0154363869),
(c_easiqlife = NULL) => -0.0135461500, -0.0025494943);

// Tree: 54 
wFDN_FLA____lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1499024472,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_unempl and c_unempl <= 190.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0125220748,
      (c_housingcpi > 222.35) => 0.0216584054,
      (c_housingcpi = NULL) => -0.0042634189, -0.0042634189),
   (c_unempl > 190.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 7.15) => 0.0079704298,
      (c_hval_125k_p > 7.15) => 0.1685388688,
      (c_hval_125k_p = NULL) => 0.0742367697, 0.0742367697),
   (c_unempl = NULL) => 0.0000700263, -0.0033782853),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 113.5) => -0.0305464662,
   (c_for_sale > 113.5) => 0.0736622175,
   (c_for_sale = NULL) => 0.0092278406, 0.0092278406), -0.0026010279);

// Tree: 55 
wFDN_FLA____lgt_55 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0140486060,
(f_corrrisktype_i > 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 118.5) => -0.0018665986,
      (f_prevaddrageoldest_d > 118.5) => 0.0760053498,
      (f_prevaddrageoldest_d = NULL) => 0.0107212960, 0.0107212960),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.45) => 0.1235336755,
      (c_pop_55_64_p > 11.45) => -0.0174207984,
      (c_pop_55_64_p = NULL) => 0.0780893369, 0.0780893369),
   (f_rel_felony_count_i = NULL) => 0.0142129323, 0.0142129323),
(f_corrrisktype_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0348231213,
   (c_construction > 7.45) => -0.0890237449,
   (c_construction = NULL) => -0.0096347281, -0.0096347281), -0.0059447480);

// Tree: 56 
wFDN_FLA____lgt_56 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
            map(
            (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.45) => -0.0071917030,
            (c_pop_75_84_p > 2.45) => 0.1101936645,
            (c_pop_75_84_p = NULL) => 0.0640199188, 0.0640199188),
         (r_F01_inp_addr_address_score_d > 25) => 0.0267733472,
         (r_F01_inp_addr_address_score_d = NULL) => 0.0344377336, 0.0344377336),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0845939638,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0236012775, 0.0236012775),
   (f_corraddrnamecount_d > 3.5) => -0.0043979540,
   (f_corraddrnamecount_d = NULL) => 0.0297730204, 0.0007591785),
(r_L77_Add_PO_Box_i > 0.5) => -0.0967541438,
(r_L77_Add_PO_Box_i = NULL) => -0.0013471401, -0.0013471401);

// Tree: 57 
wFDN_FLA____lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0065147781,
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1295) => 0.1898958670,
      (c_popover25 > 1295) => -0.0445989507,
      (c_popover25 = NULL) => 0.1069453192, 0.1069453192),
   (k_comb_age_d = NULL) => -0.0051244937, -0.0051244937),
(r_D30_Derog_Count_i > 11.5) => 0.0724665412,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 85.5) => 0.0859907647,
      (c_many_cars > 85.5) => -0.0476052529,
      (c_many_cars = NULL) => 0.0198170363, 0.0198170363),
   (r_L77_Apartment_i > 0.5) => -0.1125860165,
   (r_L77_Apartment_i = NULL) => -0.0173748324, -0.0173748324), -0.0042198455);

// Tree: 58 
wFDN_FLA____lgt_58 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 148.5) => 0.0286225814,
   (c_span_lang > 148.5) => 0.2032725808,
   (c_span_lang = NULL) => 0.0681524166, 0.0681524166),
(f_mos_liens_unrel_SC_fseen_d > 93.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 25.95) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 0.0016424877,
      (k_inq_ssns_per_addr_i > 1.5) => 0.0437222392,
      (k_inq_ssns_per_addr_i = NULL) => 0.0077235882, 0.0077235882),
   (c_hh1_p > 25.95) => -0.0217255918,
   (c_hh1_p = NULL) => -0.0356771006, -0.0054566960),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0502487829,
   (c_assault > 90) => 0.0519487326,
   (c_assault = NULL) => -0.0056814453, -0.0056814453), -0.0040377448);

// Tree: 59 
wFDN_FLA____lgt_59 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0071032899,
   (f_nae_nothing_found_i > 0.5) => 0.1002900157,
   (f_nae_nothing_found_i = NULL) => -0.0056263682, -0.0056263682),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.95) => -0.0426783037,
   (c_pop_35_44_p > 12.95) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.3487641756) => 0.1939278278,
      (f_add_input_nhood_MFD_pct_i > 0.3487641756) => 0.0567488821,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.1219512205, 0.1219512205),
   (c_pop_35_44_p = NULL) => 0.0602821805, 0.0602821805),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.3) => 0.0415982451,
   (c_hh3_p > 13.3) => -0.0932008615,
   (c_hh3_p = NULL) => -0.0268072717, -0.0268072717), -0.0042674352);

// Tree: 60 
wFDN_FLA____lgt_60 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0064558395,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -20633.5) => 0.1549373200,
   (r_A49_Curr_AVM_Chg_1yr_i > -20633.5) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.75) => -0.0245000095,
      (c_pop_12_17_p > 10.75) => 0.0807646467,
      (c_pop_12_17_p = NULL) => 0.0044231764, 0.0044231764),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 27.7) => 0.0027817780,
      (c_rnt1000_p > 27.7) => 0.1348791915,
      (c_rnt1000_p = NULL) => 0.0439585868, 0.0439585868), 0.0333330126),
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 15.5) => -0.0580183449,
   (c_retail > 15.5) => 0.0744149375,
   (c_retail = NULL) => -0.0103804735, -0.0103804735), -0.0030035211);

// Tree: 61 
wFDN_FLA____lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 8.95) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => 0.0137324294,
      (f_mos_inq_banko_cm_fseen_d > 41.5) => 0.1528943963,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0947828057, 0.0947828057),
   (c_low_hval > 8.95) => -0.0601521223,
   (c_low_hval = NULL) => 0.0563691872, 0.0563691872),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0034826786,
   (c_lar_fam > 181.5) => 0.1246501986,
   (c_lar_fam = NULL) => -0.0129970983, -0.0022936287),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 258868) => -0.0613540522,
   (c_med_hval > 258868) => 0.0432985194,
   (c_med_hval = NULL) => -0.0206558299, -0.0206558299), -0.0014037950);

// Tree: 62 
wFDN_FLA____lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0006240710,
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0296683626,
   (f_rel_incomeover75_count_d > 0.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 84.5) => -0.0078871729,
      (c_unattach > 84.5) => 
         map(
         (NULL < c_families and c_families <= 389.5) => 0.0787144103,
         (c_families > 389.5) => 0.2498454689,
         (c_families = NULL) => 0.1642799396, 0.1642799396),
      (c_unattach = NULL) => 0.1082026515, 0.1082026515),
   (f_rel_incomeover75_count_d = NULL) => 0.0633021297, 0.0633021297),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 206426.5) => -0.0253741493,
   (c_med_hval > 206426.5) => 0.0714951184,
   (c_med_hval = NULL) => 0.0205112933, 0.0205112933), 0.0009594948);

// Tree: 63 
wFDN_FLA____lgt_63 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 100041) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13214266075) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 5) => 0.1353497871,
         (c_hh4_p > 5) => -0.0235795563,
         (c_hh4_p = NULL) => -0.0037133884, -0.0037133884),
      (f_add_curr_nhood_BUS_pct_i > 0.13214266075) => 0.1782392005,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0193410332, 0.0193410332),
   (f_addrchangevaluediff_d > 100041) => 0.1790581113,
   (f_addrchangevaluediff_d = NULL) => 0.0112377230, 0.0252523383),
(f_corraddrnamecount_d > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.0644905281,
   (r_C10_M_Hdr_FS_d > 8.5) => -0.0051823803,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0041547740, -0.0041547740),
(f_corraddrnamecount_d = NULL) => -0.0243650807, -0.0023100668);

// Tree: 64 
wFDN_FLA____lgt_64 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => -0.0042867548,
(f_prevaddrageoldest_d > 271.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 24.5) => 0.2206459096,
   (f_mos_inq_banko_cm_lseen_d > 24.5) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 14.25) => 0.0088416344,
      (c_rnt1250_p > 14.25) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 30.5) => 0.2007389174,
         (r_pb_order_freq_d > 30.5) => 0.0141069937,
         (r_pb_order_freq_d = NULL) => 0.3165697879, 0.1368387788),
      (c_rnt1250_p = NULL) => 0.0399196359, 0.0399196359),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0481494298, 0.0481494298),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0774435077,
   (c_rich_nfam > 124) => -0.0533970272,
   (c_rich_nfam = NULL) => 0.0110468183, 0.0110468183), 0.0004490988);

// Tree: 65 
wFDN_FLA____lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 1.55) => 0.0292008414,
      (c_hh7p_p > 1.55) => 0.1732058401,
      (c_hh7p_p = NULL) => 0.0658813599, 0.0658813599),
   (r_D32_Mos_Since_Crim_LS_d > 11.5) => -0.0077914543,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0061245076, -0.0061245076),
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2439426565,
   (f_adl_per_email_i > 0.5) => -0.0512943585,
   (f_adl_per_email_i = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 9999.5) => 0.0957121551,
      (k_estimated_income_d > 9999.5) => 0.0212502109,
      (k_estimated_income_d = NULL) => 0.0238968419, 0.0238968419), 0.0272348136),
(f_prevaddrageoldest_d = NULL) => 0.0113493834, 0.0021352691);

// Tree: 66 
wFDN_FLA____lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.295) => -0.0076593816,
      (c_hhsize > 4.295) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 10.5) => -0.0317734452,
         (c_born_usa > 10.5) => 0.2546846802,
         (c_born_usa = NULL) => 0.1127942069, 0.1127942069),
      (c_hhsize = NULL) => -0.0064073383, -0.0064073383),
   (f_assocsuspicousidcount_i > 16.5) => 0.0977145558,
   (f_assocsuspicousidcount_i = NULL) => 0.0065401325, -0.0057182808),
(c_hh3_p > 23.25) => 
   map(
   (NULL < c_larceny and c_larceny <= 182) => 0.0451134155,
   (c_larceny > 182) => -0.0788835301,
   (c_larceny = NULL) => 0.0384890973, 0.0384890973),
(c_hh3_p = NULL) => 0.0021621244, 0.0011784966);

// Tree: 67 
wFDN_FLA____lgt_67 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 13.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 19.15) => -0.0082917643,
   (c_pop_55_64_p > 19.15) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 149.5) => 0.0219326069,
      (c_easiqlife > 149.5) => 0.2436664627,
      (c_easiqlife = NULL) => 0.0668356996, 0.0668356996),
   (c_pop_55_64_p = NULL) => -0.0037879907, -0.0037879907),
(f_addrchangecrimediff_i > 13.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 1.5) => 0.0054220001,
   (f_rel_bankrupt_count_i > 1.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 11.55) => 0.1849643381,
      (c_famotf18_p > 11.55) => 0.0241126399,
      (c_famotf18_p = NULL) => 0.1045384890, 0.1045384890),
   (f_rel_bankrupt_count_i = NULL) => 0.0388423405, 0.0388423405),
(f_addrchangecrimediff_i = NULL) => 0.0052028225, -0.0002461785);

// Tree: 68 
wFDN_FLA____lgt_68 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 2.5) => 0.0066382816,
      (f_hh_lienholders_i > 2.5) => 0.0891541255,
      (f_hh_lienholders_i = NULL) => 0.0092409520, 0.0092409520),
   (f_inq_PrepaidCards_count_i > 0.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 73) => 0.1509275006,
      (c_serv_empl > 73) => 0.0301458914,
      (c_serv_empl = NULL) => 0.0674553937, 0.0674553937),
   (f_inq_PrepaidCards_count_i = NULL) => 0.0111320856, 0.0111320856),
(f_historical_count_d > 0.5) => -0.0142335055,
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1374.5) => 0.0378647170,
   (c_popover18 > 1374.5) => -0.0801844218,
   (c_popover18 = NULL) => -0.0136778648, -0.0136778648), -0.0020380898);

// Tree: 69 
wFDN_FLA____lgt_69 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62436.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 142.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -106765) => 0.0030128531,
         (f_addrchangevaluediff_d > -106765) => 0.1653446607,
         (f_addrchangevaluediff_d = NULL) => 0.0586434164, 0.0586434164),
      (c_rich_fam > 142.5) => -0.1090439885,
      (c_rich_fam = NULL) => 0.0148081197, 0.0148081197),
   (f_util_adl_count_n > 3.5) => 0.1997658440,
   (f_util_adl_count_n = NULL) => 0.0496823034, 0.0496823034),
(f_addrchangevaluediff_d > -62436.5) => -0.0078214992,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 1.5) => -0.0099458527,
   (k_inq_adls_per_addr_i > 1.5) => 0.0444529786,
   (k_inq_adls_per_addr_i = NULL) => -0.0020579294, -0.0020579294), -0.0051434028);

// Tree: 70 
wFDN_FLA____lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0104217041,
   (f_srchfraudsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 11.05) => 
         map(
         (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 61.5) => 0.0890461296,
         (r_I61_inq_collection_recency_d > 61.5) => -0.0088945855,
         (r_I61_inq_collection_recency_d = NULL) => 0.0135560082, 0.0135560082),
      (c_hh5_p > 11.05) => 0.1621582640,
      (c_hh5_p = NULL) => 0.0377885104, 0.0377885104),
   (f_srchfraudsrchcountmo_i = NULL) => 0.0013504180, -0.0085214571),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 62500) => 0.1626209877,
   (k_estimated_income_d > 62500) => 0.0394864338,
   (k_estimated_income_d = NULL) => 0.0459535847, 0.0459535847),
(c_hval_750k_p = NULL) => 0.0206178233, -0.0037659768);

// Tree: 71 
wFDN_FLA____lgt_71 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.55) => 0.1359696568,
      (C_INC_200K_P > 0.55) => 
         map(
         (NULL < nf_vf_level and nf_vf_level <= 0) => 0.0869628504,
         (nf_vf_level > 0) => -0.0206649647,
         (nf_vf_level = NULL) => 0.0527278074, 0.0527278074),
      (C_INC_200K_P = NULL) => 0.0666974603, 0.0666974603),
   (f_current_count_d > 0.5) => -0.0044937357,
   (f_current_count_d = NULL) => 0.0331023285, 0.0331023285),
(r_I60_inq_comm_recency_d > 549) => 0.0005131298,
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 9.5) => -0.0518584916,
   (C_INC_125K_P > 9.5) => 0.0495878590,
   (C_INC_125K_P = NULL) => -0.0097617067, -0.0097617067), 0.0032481157);

// Tree: 72 
wFDN_FLA____lgt_72 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 6.45) => -0.0524870275,
   (c_pop_45_54_p > 6.45) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 82.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 0.0290107442,
         (f_corraddrnamecount_d > 2.5) => -0.0059523923,
         (f_corraddrnamecount_d = NULL) => -0.0025850099, -0.0025850099),
      (k_comb_age_d > 82.5) => 
         map(
         (NULL < c_construction and c_construction <= 4.45) => 0.2179175054,
         (c_construction > 4.45) => -0.0380008580,
         (c_construction = NULL) => 0.0910710123, 0.0910710123),
      (k_comb_age_d = NULL) => -0.0016597142, -0.0016597142),
   (c_pop_45_54_p = NULL) => -0.0211127904, -0.0042810911),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0866950697,
(f_inq_PrepaidCards_count_i = NULL) => -0.0180472206, -0.0040945732);

// Tree: 73 
wFDN_FLA____lgt_73 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 46.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 190.5) => -0.0015755393,
   (f_curraddrcrimeindex_i > 190.5) => 0.0720081349,
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 102) => -0.0791000294,
      (c_span_lang > 102) => 0.0536823739,
      (c_span_lang = NULL) => -0.0050112971, -0.0050112971), -0.0000967516),
(c_famotf18_p > 46.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 2.5) => 0.1395556616,
   (r_C12_source_profile_index_d > 2.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 453.5) => 0.0864342431,
      (c_hh00 > 453.5) => -0.0595595856,
      (c_hh00 = NULL) => 0.0164608696, 0.0164608696),
   (r_C12_source_profile_index_d = NULL) => 0.0475069012, 0.0475069012),
(c_famotf18_p = NULL) => 0.0007603963, 0.0007967623);

// Tree: 74 
wFDN_FLA____lgt_74 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 32392.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 5.15) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 25481.5) => 
         map(
         (NULL < c_pop00 and c_pop00 <= 1125) => 0.1089899659,
         (c_pop00 > 1125) => -0.0630966984,
         (c_pop00 = NULL) => 0.0229466338, 0.0229466338),
      (f_curraddrmedianincome_d > 25481.5) => 0.1776141144,
      (f_curraddrmedianincome_d = NULL) => 0.0894795724, 0.0894795724),
   (c_high_ed > 5.15) => 0.0124801606,
   (c_high_ed = NULL) => 0.0472356150, 0.0281923915),
(f_curraddrmedianincome_d > 32392.5) => -0.0061491221,
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 0.5) => 0.0591281314,
   (k_inq_per_addr_i > 0.5) => -0.0506206956,
   (k_inq_per_addr_i = NULL) => 0.0183240803, 0.0183240803), -0.0021798221);

// Tree: 75 
wFDN_FLA____lgt_75 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 32.5) => -0.0207063594,
(k_comb_age_d > 32.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 118.45) => -0.0073828333,
   (c_oldhouse > 118.45) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 193.5) => 
         map(
         (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 15.5) => 0.0421288046,
         (f_rel_under500miles_cnt_d > 15.5) => -0.0327031971,
         (f_rel_under500miles_cnt_d = NULL) => 0.0291982749, 0.0291982749),
      (c_rich_blk > 193.5) => 0.2136472492,
      (c_rich_blk = NULL) => 0.0328234513, 0.0328234513),
   (c_oldhouse = NULL) => -0.0244908226, 0.0044641544),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 7.65) => 0.0242973260,
   (c_pop_65_74_p > 7.65) => -0.1180188160,
   (c_pop_65_74_p = NULL) => -0.0317326511, -0.0317326511), -0.0042255196);

// Tree: 76 
wFDN_FLA____lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0110571676,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 135.5) => 0.0005331770,
      (f_prevaddrlenofres_d > 135.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0461575241,
         (f_rel_homeover500_count_d > 3.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03648382765) => 0.0826480123,
            (f_add_curr_nhood_BUS_pct_i > 0.03648382765) => 0.2472752744,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1598170414, 0.1598170414),
         (f_rel_homeover500_count_d = NULL) => 0.0637852733, 0.0637852733),
      (f_prevaddrlenofres_d = NULL) => 0.0165769808, 0.0165769808),
   (f_nae_nothing_found_i > 0.5) => 0.2229424424,
   (f_nae_nothing_found_i = NULL) => 0.0198023574, 0.0198023574),
(c_rnt1250_p = NULL) => 0.0033211226, -0.0021834524);

// Tree: 77 
wFDN_FLA____lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 64.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.1) => 0.2173252170,
      (r_C12_source_profile_d > 60.1) => -0.0201798654,
      (r_C12_source_profile_d = NULL) => 0.0777107429, 0.0777107429),
   (f_mos_liens_unrel_SC_fseen_d > 64.5) => -0.0021285961,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 110.5) => -0.0534173964,
      (c_for_sale > 110.5) => 0.0922253443,
      (c_for_sale = NULL) => 0.0021714359, 0.0021714359), -0.0011119643),
(c_transport > 29.05) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1812843183,
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0226820302,
   (r_C12_Num_NonDerogs_d = NULL) => 0.1015963394, 0.1015963394),
(c_transport = NULL) => -0.0068509226, 0.0004449996);

// Tree: 78 
wFDN_FLA____lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 23.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0194545439,
         (f_varrisktype_i > 2.5) => 
            map(
            (NULL < c_hval_400k_p and c_hval_400k_p <= 5.55) => 0.2431744145,
            (c_hval_400k_p > 5.55) => 0.0725582529,
            (c_hval_400k_p = NULL) => 0.1526736679, 0.1526736679),
         (f_varrisktype_i = NULL) => 0.0795337567, 0.0795337567),
      (r_C13_max_lres_d > 23.5) => 0.0019616990,
      (r_C13_max_lres_d = NULL) => 0.0036487672, 0.0036487672),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0621763175,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0161942981, 0.0011455937),
(r_L77_Add_PO_Box_i > 0.5) => -0.1007424166,
(r_L77_Add_PO_Box_i = NULL) => -0.0012319270, -0.0012319270);

// Tree: 79 
wFDN_FLA____lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 216064.5) => 0.1979762099,
      (r_L80_Inp_AVM_AutoVal_d > 216064.5) => 0.0233979571,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0013195311, 0.0412382264),
   (r_C10_M_Hdr_FS_d > 11.5) => -0.0051025175,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0039920446, -0.0039920446),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 8.65) => 0.1357920347,
   (c_pop_12_17_p > 8.65) => -0.0067517776,
   (c_pop_12_17_p = NULL) => 0.0531405805, 0.0531405805),
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0506236155,
   (c_pop_35_44_p > 15.55) => 0.0540484013,
   (c_pop_35_44_p = NULL) => -0.0068246865, -0.0068246865), -0.0034661195);

// Tree: 80 
wFDN_FLA____lgt_80 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 43.75) => -0.0068372589,
(c_fammar18_p > 43.75) => 
   map(
   (NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 163.5) => 0.1909751779,
   (f_mos_liens_rel_CJ_lseen_d > 163.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 13.75) => 
            map(
            (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0206207483) => 0.2493545352,
            (f_add_input_nhood_VAC_pct_i > 0.0206207483) => 0.0311762993,
            (f_add_input_nhood_VAC_pct_i = NULL) => 0.1413043612, 0.1413043612),
         (c_high_ed > 13.75) => 0.0385672546,
         (c_high_ed = NULL) => 0.0595953173, 0.0595953173),
      (r_Ever_Asset_Owner_d > 0.5) => 0.0052280081,
      (r_Ever_Asset_Owner_d = NULL) => 0.0137991297, 0.0137991297),
   (f_mos_liens_rel_CJ_lseen_d = NULL) => 0.0166913626, 0.0166913626),
(c_fammar18_p = NULL) => 0.0294921375, 0.0002297469);

// Tree: 81 
wFDN_FLA____lgt_81 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 35.6) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0051446090,
   (f_srchaddrsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 53.5) => -0.1087920104,
      (c_lar_fam > 53.5) => 
         map(
         (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => -0.0530833127,
         (nf_vf_hi_risk_index > 4.5) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 177.5) => 0.0360398396,
            (r_C13_max_lres_d > 177.5) => 0.1576586853,
            (r_C13_max_lres_d = NULL) => 0.0755399775, 0.0755399775),
         (nf_vf_hi_risk_index = NULL) => 0.0628560167, 0.0628560167),
      (c_lar_fam = NULL) => 0.0487745661, 0.0487745661),
   (f_srchaddrsrchcountmo_i = NULL) => -0.0252031338, -0.0022621489),
(c_hval_80k_p > 35.6) => -0.0890734070,
(c_hval_80k_p = NULL) => 0.0159698734, -0.0030904640);

// Tree: 82 
wFDN_FLA____lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0027392410,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0362332320,
      (f_mos_inq_banko_cm_fseen_d > 46.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 6.65) => -0.0087684642,
         (c_pop_6_11_p > 6.65) => 
            map(
            (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 60.5) => 0.0544077568,
            (r_C13_Curr_Addr_LRes_d > 60.5) => 0.2108016356,
            (r_C13_Curr_Addr_LRes_d = NULL) => 0.1244722145, 0.1244722145),
         (c_pop_6_11_p = NULL) => 0.0837597849, 0.0837597849),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0410576436, 0.0410576436),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0017480260, -0.0017480260),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0717180975,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0087444564, -0.0023680131);

// Tree: 83 
wFDN_FLA____lgt_83 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => 
   map(
   (NULL < nf_vf_type and nf_vf_type <= 2.5) => -0.0139047694,
   (nf_vf_type > 2.5) => 0.0674165743,
   (nf_vf_type = NULL) => -0.0122626248, -0.0122626248),
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.1077625823,
   (r_C10_M_Hdr_FS_d > 8.5) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => 0.0084991574,
      (r_D34_UnRel_Lien60_Count_i > 0.5) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 11.65) => 0.1039044883,
         (C_INC_25K_P > 11.65) => -0.0677417389,
         (C_INC_25K_P = NULL) => 0.0604996952, 0.0604996952),
      (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0118201524, 0.0118201524),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0132813792, 0.0132813792),
(f_srchaddrsrchcount_i = NULL) => -0.0046474450, -0.0009214122);

// Tree: 84 
wFDN_FLA____lgt_84 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0029070958,
   (k_comb_age_d > 67.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 21.9) => 0.0358393500,
      (c_hval_500k_p > 21.9) => 0.2360115327,
      (c_hval_500k_p = NULL) => 0.0525399669, 0.0525399669),
   (k_comb_age_d = NULL) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => -0.0350965785,
      (C_INC_125K_P > 9.95) => 0.0730217156,
      (C_INC_125K_P = NULL) => 0.0053605896, 0.0053605896), 0.0010472621),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0060368255,
   (c_pop_35_44_p > 14.55) => 0.1979410453,
   (c_pop_35_44_p = NULL) => 0.0923735508, 0.0923735508),
(r_L71_Add_HiRisk_Comm_i = NULL) => 0.0018824099, 0.0018824099);

// Tree: 85 
wFDN_FLA____lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0102927131,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.219648761) => 0.0499618777,
      (f_add_curr_mobility_index_i > 0.219648761) => 0.0033639991,
      (f_add_curr_mobility_index_i = NULL) => 0.0144116207, 0.0144116207),
   (f_inq_Collection_count_i > 8.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 10.8) => 0.0298439696,
      (c_hval_250k_p > 10.8) => 0.1732550916,
      (c_hval_250k_p = NULL) => 0.0923841582, 0.0923841582),
   (f_inq_Collection_count_i = NULL) => 0.0212223240, 0.0212223240),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 37.25) => 0.0768353015,
   (c_med_age > 37.25) => -0.0496502638,
   (c_med_age = NULL) => 0.0084647257, 0.0084647257), -0.0061568038);

// Tree: 86 
wFDN_FLA____lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 44.5) => -0.0031385737,
   (f_rel_under500miles_cnt_d > 44.5) => -0.1250509422,
   (f_rel_under500miles_cnt_d = NULL) => 0.0213119511, -0.0034210467),
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 128.5) => 0.0115450497,
   (f_curraddrcrimeindex_i > 128.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.06232831775) => 0.1659849450,
      (f_add_curr_nhood_VAC_pct_i > 0.06232831775) => 0.0156979404,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1025304319, 0.1025304319),
   (f_curraddrcrimeindex_i = NULL) => 0.0365105509, 0.0365105509),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.25) => -0.0486267766,
   (c_pop_55_64_p > 11.25) => 0.0795707195,
   (c_pop_55_64_p = NULL) => -0.0004390653, -0.0004390653), -0.0013167410);

// Tree: 87 
wFDN_FLA____lgt_87 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 29.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0052887146,
   (f_hh_collections_ct_i > 4.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 956.5) => 0.1769820383,
      (c_popover25 > 956.5) => 0.0075312695,
      (c_popover25 = NULL) => 0.0757378682, 0.0757378682),
   (f_hh_collections_ct_i = NULL) => -0.0042115715, -0.0042115715),
(f_rel_under100miles_cnt_d > 29.5) => -0.0712236918,
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 187482.5) => 0.1242506861,
   (r_L80_Inp_AVM_AutoVal_d > 187482.5) => -0.0192311410,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 9.95) => -0.0859081958,
      (c_hh4_p > 9.95) => 0.0361732231,
      (c_hh4_p = NULL) => -0.0229684420, -0.0229684420), 0.0006271000), -0.0050235106);

// Tree: 88 
wFDN_FLA____lgt_88 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 86.85) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 42.5) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 171) => 0.0355609832,
         (c_born_usa > 171) => 
            map(
            (NULL < c_fammar_p and c_fammar_p <= 51.75) => 0.1897085568,
            (c_fammar_p > 51.75) => 0.0450077197,
            (c_fammar_p = NULL) => 0.1205594842, 0.1205594842),
         (c_born_usa = NULL) => 0.0441597573, 0.0441597573),
      (f_inq_QuizProvider_count_i > 1.5) => -0.0699161834,
      (f_inq_QuizProvider_count_i = NULL) => 0.0321854398, 0.0321854398),
   (c_exp_prod > 42.5) => -0.0003123428,
   (c_exp_prod = NULL) => 0.0030706734, 0.0030706734),
(C_RENTOCC_P > 86.85) => -0.0592228308,
(C_RENTOCC_P = NULL) => -0.0382206965, 0.0010084530);

// Tree: 89 
wFDN_FLA____lgt_89 := map(
(NULL < c_newhouse and c_newhouse <= 8.95) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -79) => 0.1301380074,
      (f_addrchangecrimediff_i > -79) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
            map(
            (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 9.5) => 0.0083164345,
            (f_rel_incomeover100_count_d > 9.5) => 0.1732981027,
            (f_rel_incomeover100_count_d = NULL) => 0.0111000587, 0.0111000587),
         (r_D33_eviction_count_i > 2.5) => 0.0991875267,
         (r_D33_eviction_count_i = NULL) => 0.0122255005, 0.0122255005),
      (f_addrchangecrimediff_i = NULL) => 0.0088190779, 0.0126651000),
   (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0901059501,
   (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 0.0289445483, 0.0105525164),
(c_newhouse > 8.95) => -0.0151047695,
(c_newhouse = NULL) => 0.0112949627, -0.0036250418);

// Tree: 90 
wFDN_FLA____lgt_90 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 5.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.0793028864,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0040095642,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0035976022, -0.0035976022),
   (r_D32_criminal_count_i > 5.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 25.8) => 0.1737796648,
      (c_hh2_p > 25.8) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 41.5) => 0.1439670163,
         (c_no_labfor > 41.5) => -0.0205752569,
         (c_no_labfor = NULL) => 0.0205603114, 0.0205603114),
      (c_hh2_p = NULL) => 0.0493609417, 0.0493609417),
   (r_D32_criminal_count_i = NULL) => -0.0145709496, -0.0026139118),
(k_inq_adls_per_addr_i > 4.5) => -0.0873756904,
(k_inq_adls_per_addr_i = NULL) => -0.0034625319, -0.0034625319);

// Tree: 91 
wFDN_FLA____lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 77.5) => 0.1195507905,
      (f_fp_prevaddrcrimeindex_i > 77.5) => -0.0965646027,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0124166640, 0.0124166640),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','6: Other']) => 0.1486217554,
   (nf_seg_FraudPoint_3_0 = '') => 0.0723729722, 0.0723729722),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => -0.0086832603,
   (c_food > 65.55) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 0) => 0.0243464179,
      (nf_vf_level > 0) => 0.1408506420,
      (nf_vf_level = NULL) => 0.0489863918, 0.0489863918),
   (c_food = NULL) => -0.0005392368, -0.0064767337),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0111233306, -0.0049528237);

// Tree: 92 
wFDN_FLA____lgt_92 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 94.35) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.15) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0035939735,
      (f_assocsuspicousidcount_i > 15.5) => 0.0892666619,
      (f_assocsuspicousidcount_i = NULL) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.25) => -0.0524038399,
         (c_pop_55_64_p > 11.25) => 0.0642378828,
         (c_pop_55_64_p = NULL) => -0.0001161711, -0.0001161711), -0.0030383745),
   (c_hh3_p > 23.15) => 
      map(
      (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 0.0266512472,
      (f_acc_damage_amt_total_i > 275) => 0.1958885835,
      (f_acc_damage_amt_total_i = NULL) => 0.0314197634, 0.0314197634),
   (c_hh3_p = NULL) => 0.0022899730, 0.0022899730),
(C_RENTOCC_P > 94.35) => -0.1286794661,
(C_RENTOCC_P = NULL) => -0.0431298052, 0.0006066359);

// Tree: 93 
wFDN_FLA____lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0014690501,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_food and c_food <= 15.7) => 0.1607224558,
         (c_food > 15.7) => 0.0086609169,
         (c_food = NULL) => 0.0765455325, 0.0765455325),
      (r_D33_eviction_count_i = NULL) => 0.0021915596, 0.0021915596),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 45.5) => 0.0987776289,
      (r_pb_order_freq_d > 45.5) => 0.0006458555,
      (r_pb_order_freq_d = NULL) => 0.1307840718, 0.0879785135),
   (f_curraddrcartheftindex_i = NULL) => 0.0083782190, 0.0039373997),
(c_cartheft > 189.5) => -0.0589805022,
(c_cartheft = NULL) => 0.0012316099, 0.0018405973);

// Tree: 94 
wFDN_FLA____lgt_94 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 8.15) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0085000888) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 234833.5) => 0.2509417449,
         (f_curraddrmedianvalue_d > 234833.5) => -0.0167593007,
         (f_curraddrmedianvalue_d = NULL) => 0.1319635024, 0.1319635024),
      (f_add_input_nhood_MFD_pct_i > 0.0085000888) => 0.0088158992,
      (f_add_input_nhood_MFD_pct_i = NULL) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 49814) => 0.1615996684,
         (f_curraddrmedianincome_d > 49814) => -0.0190584056,
         (f_curraddrmedianincome_d = NULL) => 0.0179309330, 0.0179309330), 0.0168685127),
   (c_hh7p_p > 8.15) => 0.1276394963,
   (c_hh7p_p = NULL) => 0.0982878175, 0.0231104783),
(f_hh_members_ct_d > 1.5) => -0.0047783465,
(f_hh_members_ct_d = NULL) => -0.0003102338, 0.0010287702);

// Tree: 95 
wFDN_FLA____lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0094410001,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31289) => 0.1402991756,
   (f_curraddrmedianincome_d > 31289) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => -0.0058602593,
         (k_comb_age_d > 66.5) => 0.1581462831,
         (k_comb_age_d = NULL) => 0.0058821446, 0.0058821446),
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 0.55) => 0.2014569135,
         (c_pop_85p_p > 0.55) => 0.0309773891,
         (c_pop_85p_p = NULL) => 0.1026282037, 0.1026282037),
      (f_rel_felony_count_i = NULL) => 0.0194318295, 0.0194318295),
   (f_curraddrmedianincome_d = NULL) => 0.0250463126, 0.0250463126),
(c_rnt1000_p = NULL) => -0.0117260209, -0.0052398573);

// Tree: 96 
wFDN_FLA____lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 54769.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 44.85) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 208.5) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.1896562086,
         (f_hh_members_ct_d > 1.5) => 
            map(
            (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1318580281,
            (f_prevaddrstatus_i > 2.5) => -0.0544395102,
            (f_prevaddrstatus_i = NULL) => -0.0176402493, 0.0057854748),
         (f_hh_members_ct_d = NULL) => 0.0598651024, 0.0598651024),
      (c_cpiall > 208.5) => 0.0110351963,
      (c_cpiall = NULL) => 0.0162173759, 0.0162173759),
   (c_hval_80k_p > 44.85) => -0.1226599234,
   (c_hval_80k_p = NULL) => -0.0076257160, 0.0132440533),
(f_curraddrmedianincome_d > 54769.5) => -0.0128330186,
(f_curraddrmedianincome_d = NULL) => -0.0091546467, -0.0032718097);

// Tree: 97 
wFDN_FLA____lgt_97 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0003341537,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 13.5) => 0.1227174363,
      (f_rel_ageover20_count_d > 13.5) => 0.0104695600,
      (f_rel_ageover20_count_d = NULL) => 0.0633466588, 0.0633466588),
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_incollege and c_incollege <= 7.25) => -0.0508760216,
      (c_incollege > 7.25) => 0.0591171092,
      (c_incollege = NULL) => -0.0106716359, -0.0106716359), 0.0008004392),
(k_inq_adls_per_addr_i > 3.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 48) => -0.1151198527,
   (f_curraddrmurderindex_i > 48) => -0.0364222952,
   (f_curraddrmurderindex_i = NULL) => -0.0639817512, -0.0639817512),
(k_inq_adls_per_addr_i = NULL) => -0.0005171647, -0.0005171647);

// Tree: 98 
wFDN_FLA____lgt_98 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 10.15) => -0.0221869812,
      (c_hh4_p > 10.15) => 0.0034503816,
      (c_hh4_p = NULL) => -0.0080800542, -0.0048799660),
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 782.5) => 0.0138191295,
      (c_hh00 > 782.5) => 0.1868727077,
      (c_hh00 = NULL) => 0.0711740297, 0.0711740297),
   (f_inq_Other_count24_i = NULL) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 2.15) => -0.0613881222,
      (c_hval_125k_p > 2.15) => 0.0535579541,
      (c_hval_125k_p = NULL) => 0.0086571430, 0.0086571430), -0.0036438880),
(r_L72_Add_Vacant_i > 0.5) => 0.1168419631,
(r_L72_Add_Vacant_i = NULL) => -0.0029214482, -0.0029214482);

// Tree: 99 
wFDN_FLA____lgt_99 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 116.5) => 0.0938017107,
(r_D32_Mos_Since_Fel_LS_d > 116.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 63.5) => -0.0096339662,
   (r_C13_Curr_Addr_LRes_d > 63.5) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 31.2) => 0.0115901619,
      (c_rnt2001_p > 31.2) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 142) => 0.0692456979,
         (c_lar_fam > 142) => 0.3190962910,
         (c_lar_fam = NULL) => 0.1095696860, 0.1095696860),
      (c_rnt2001_p = NULL) => 0.0408830222, 0.0171106305),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0038920120, 0.0038920120),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 427) => -0.0537165767,
   (c_employees > 427) => 0.0614743826,
   (c_employees = NULL) => -0.0009207203, -0.0009207203), 0.0042784816);

// Tree: 100 
wFDN_FLA____lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 45073.5) => 0.0334619735,
      (f_prevaddrmedianincome_d > 45073.5) => -0.0040600040,
      (f_prevaddrmedianincome_d = NULL) => 0.0046936277, 0.0046936277),
   (c_transport > 26.6) => 0.1608266206,
   (c_transport = NULL) => 0.0181378322, 0.0078645191),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 33.05) => -0.0123456777,
   (c_famotf18_p > 33.05) => -0.0633032908,
   (c_famotf18_p = NULL) => 0.0181350758, -0.0147537356),
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.65) => -0.0565235950,
   (c_pop_35_44_p > 14.65) => 0.0595626950,
   (c_pop_35_44_p = NULL) => 0.0071088899, 0.0071088899), -0.0035211236);

// Tree: 101 
wFDN_FLA____lgt_101 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 2.45) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 24500) => -0.0850323328,
      (k_estimated_income_d > 24500) => -0.0138472037,
      (k_estimated_income_d = NULL) => -0.0292920996, -0.0292920996),
   (C_INC_125K_P > 2.45) => -0.0001928463,
   (C_INC_125K_P = NULL) => 0.0110747397, -0.0016529078),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 10.1) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 11.1) => 0.3013135784,
      (c_hval_400k_p > 11.1) => 0.0189617692,
      (c_hval_400k_p = NULL) => 0.1642495934, 0.1642495934),
   (C_INC_35K_P > 10.1) => -0.0469441469,
   (C_INC_35K_P = NULL) => 0.0795265231, 0.0795265231),
(f_nae_nothing_found_i = NULL) => -0.0005393705, -0.0005393705);

// Tree: 102 
wFDN_FLA____lgt_102 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0090993305,
(c_hh7p_p > 0.85) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 5.5) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 55853) => -0.0776060511,
         (r_A46_Curr_AVM_AutoVal_d > 55853) => 0.0084227095,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0189587139, 0.0090327291),
      (f_srchfraudsrchcountmo_i > 0.5) => 0.0825512833,
      (f_srchfraudsrchcountmo_i = NULL) => 0.0120564064, 0.0120564064),
   (r_L79_adls_per_addr_c6_i > 5.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 17.5) => 0.0117015850,
      (r_C13_Curr_Addr_LRes_d > 17.5) => 0.1641568346,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0864909527, 0.0864909527),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0148082998, 0.0148082998),
(c_hh7p_p = NULL) => 0.0110532515, -0.0001874017);

// Tree: 103 
wFDN_FLA____lgt_103 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 128.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 86) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 137.5) => 0.2014896311,
      (c_sub_bus > 137.5) => 0.0316522396,
      (c_sub_bus = NULL) => 0.1102546687, 0.1102546687),
   (c_born_usa > 86) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.0961386958,
      (r_C12_source_profile_d > 57.95) => -0.0593736443,
      (r_C12_source_profile_d = NULL) => -0.0167331639, -0.0167331639),
   (c_born_usa = NULL) => 0.0333174151, 0.0333174151),
(f_mos_liens_unrel_SC_fseen_d > 128.5) => -0.0032946458,
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0518619051,
   (c_construction > 7.45) => -0.0556064329,
   (c_construction = NULL) => 0.0088745699, 0.0088745699), -0.0022291465);

// Tree: 104 
wFDN_FLA____lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 773816) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 58) => 0.0738044324,
   (f_mos_liens_unrel_SC_fseen_d > 58) => -0.0015236723,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0007236843, -0.0007236843),
(f_prevaddrmedianvalue_d > 773816) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0171035324,
   (f_bus_addr_match_count_d > 0.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1065.5) => 0.0647328141,
      (c_popover18 > 1065.5) => 0.4601379223,
      (c_popover18 = NULL) => 0.2679784304, 0.2679784304),
   (f_bus_addr_match_count_d = NULL) => 0.1191705062, 0.1191705062),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 0.0144103716,
   (r_L77_Apartment_i > 0.5) => -0.0894407175,
   (r_L77_Apartment_i = NULL) => -0.0148515375, -0.0148515375), 0.0015605120);

// Tree: 105 
wFDN_FLA____lgt_105 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0089410649,
(f_corrrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 84.55) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.35) => -0.0053788306,
      (c_pop_45_54_p > 14.35) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 158.5) => 0.0266976405,
         (f_fp_prevaddrburglaryindex_i > 158.5) => 0.1170816506,
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.0365730420, 0.0365730420),
      (c_pop_45_54_p = NULL) => 0.0131848306, 0.0136460001),
   (r_C12_source_profile_d > 84.55) => 0.1716926798,
   (r_C12_source_profile_d = NULL) => 0.0163923270, 0.0163923270),
(f_corrrisktype_i = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 72.5) => -0.0859153251,
   (c_unempl > 72.5) => 0.0424609537,
   (c_unempl = NULL) => -0.0077312756, -0.0077312756), -0.0018006747);

// Tree: 106 
wFDN_FLA____lgt_106 := map(
(NULL < c_hh3_p and c_hh3_p <= 36.15) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 77.85) => -0.0027787947,
      (c_low_ed > 77.85) => -0.0587878634,
      (c_low_ed = NULL) => -0.0041907880, -0.0041907880),
   (f_historical_count_d > 16.5) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 94.5) => 0.3042795904,
      (c_medi_indx > 94.5) => -0.0039555066,
      (c_medi_indx = NULL) => 0.1351594487, 0.1351594487),
   (f_historical_count_d = NULL) => 0.0044689890, -0.0028070874),
(c_hh3_p > 36.15) => 
   map(
   (NULL < c_robbery and c_robbery <= 101.5) => -0.0114816098,
   (c_robbery > 101.5) => 0.1619809639,
   (c_robbery = NULL) => 0.0868138486, 0.0868138486),
(c_hh3_p = NULL) => -0.0292961329, -0.0025648573);

// Tree: 107 
wFDN_FLA____lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1042123491,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 22.15) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => -0.0042758274,
      (r_D32_criminal_count_i > 10.5) => 0.0925109389,
      (r_D32_criminal_count_i = NULL) => -0.0036758257, -0.0036758257),
   (c_hval_40k_p > 22.15) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.15) => -0.0656484143,
      (c_pop_65_74_p > 4.15) => 
         map(
         (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => 0.2793503575,
         (f_crim_rel_under100miles_cnt_i > 0.5) => 0.0437225745,
         (f_crim_rel_under100miles_cnt_i = NULL) => 0.1469059827, 0.1469059827),
      (c_pop_65_74_p = NULL) => 0.0775947663, 0.0775947663),
   (c_hval_40k_p = NULL) => 0.0295199956, -0.0014921066),
(f_attr_arrest_recency_d = NULL) => -0.0128711503, -0.0008797602);

// Tree: 108 
wFDN_FLA____lgt_108 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 29865) => 0.0364123796,
   (f_curraddrmedianincome_d > 29865) => -0.0044336083,
   (f_curraddrmedianincome_d = NULL) => -0.0007360588, -0.0007360588),
(f_srchaddrsrchcountmo_i > 0.5) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 4.75) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 0.65) => 0.0368920516,
      (c_hval_40k_p > 0.65) => -0.0850948685,
      (c_hval_40k_p = NULL) => 0.0045513332, 0.0045513332),
   (c_hval_125k_p > 4.75) => 0.1075320826,
   (c_hval_125k_p = NULL) => 0.0438173744, 0.0438173744),
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 21.05) => 0.0504587062,
   (C_RENTOCC_P > 21.05) => -0.0602326050,
   (C_RENTOCC_P = NULL) => -0.0199812191, -0.0199812191), 0.0014872200);

// Tree: 109 
wFDN_FLA____lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.0804632324,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.95) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 44105.5) => 0.1291562108,
         (f_prevaddrmedianincome_d > 44105.5) => 0.0008556682,
         (f_prevaddrmedianincome_d = NULL) => 0.0460319156, 0.0460319156),
      (c_pop_55_64_p > 8.95) => -0.0471551913,
      (c_pop_55_64_p = NULL) => -0.0074177463, -0.0074177463),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0326156078, -0.0326156078),
(r_D33_Eviction_Recency_d > 549) => 0.0084934710,
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 121) => -0.0254061250,
   (c_totcrime > 121) => 0.0885999742,
   (c_totcrime = NULL) => 0.0170513188, 0.0170513188), 0.0069399745);

// Tree: 110 
wFDN_FLA____lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 121.5) => -0.0071856792,
(f_prevaddrageoldest_d > 121.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 16.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0429044239,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < c_blue_col and c_blue_col <= 15.05) => 0.2655736683,
         (c_blue_col > 15.05) => 0.0381160500,
         (c_blue_col = NULL) => 0.1518448591, 0.1518448591),
      (f_hh_lienholders_i = NULL) => 0.0789991465, 0.0789991465),
   (c_born_usa > 16.5) => 0.0142356781,
   (c_born_usa = NULL) => -0.0256412985, 0.0191029800),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38558214875) => 0.0214581226,
   (f_add_input_mobility_index_i > 0.38558214875) => -0.0983381260,
   (f_add_input_mobility_index_i = NULL) => -0.0170969919, -0.0170969919), 0.0007265973);

// Tree: 111 
wFDN_FLA____lgt_111 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 19.5) => 
   map(
   (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 2.95) => -0.0133113909,
      (C_INC_150K_P > 2.95) => 0.1899150844,
      (C_INC_150K_P = NULL) => 0.1038021712, 0.1038021712),
   (f_addrchangeecontrajindex_d > 2.5) => -0.0537016637,
   (f_addrchangeecontrajindex_d = NULL) => 0.1100273633, 0.0418346784),
(k_comb_age_d > 19.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0004961356,
      (k_inq_ssns_per_addr_i > 1.5) => 0.0339829583,
      (k_inq_ssns_per_addr_i = NULL) => 0.0034355640, 0.0034355640),
   (k_inq_adls_per_addr_i > 3.5) => -0.0612302794,
   (k_inq_adls_per_addr_i = NULL) => 0.0020591296, 0.0020591296),
(k_comb_age_d = NULL) => -0.0256223281, 0.0027762181);

// Tree: 112 
wFDN_FLA____lgt_112 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0021489415,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 4.2) => 0.2533573158,
      (C_INC_25K_P > 4.2) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 0.45) => 0.1320920251,
         (c_pop_85p_p > 0.45) => -0.0078905712,
         (c_pop_85p_p = NULL) => 0.0354224295, 0.0354224295),
      (C_INC_25K_P = NULL) => 0.0929629935, 0.0929629935),
   (k_nap_fname_verd_d > 0.5) => 0.0026696696,
   (k_nap_fname_verd_d = NULL) => 0.0273022532, 0.0273022532),
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.85) => 0.0805500913,
   (c_med_age > 36.85) => -0.0234520863,
   (c_med_age = NULL) => 0.0304195453, 0.0304195453), 0.0009649808);

// Tree: 113 
wFDN_FLA____lgt_113 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0080076695,
   (r_C23_inp_addr_occ_index_d > 2) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 112.5) => 0.0056608368,
      (f_prevaddrageoldest_d > 112.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0259733429,
         (f_corrrisktype_i > 8.5) => 
            map(
            (NULL < c_very_rich and c_very_rich <= 122) => 0.1409063959,
            (c_very_rich > 122) => 0.0227460121,
            (c_very_rich = NULL) => 0.0929037400, 0.0929037400),
         (f_corrrisktype_i = NULL) => 0.0524905288, 0.0524905288),
      (f_prevaddrageoldest_d = NULL) => 0.0140863297, 0.0140863297),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0299559075, -0.0023392551),
(r_L77_Add_PO_Box_i > 0.5) => -0.0957224848,
(r_L77_Add_PO_Box_i = NULL) => -0.0044005325, -0.0044005325);

// Tree: 114 
wFDN_FLA____lgt_114 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 30.5) => 
   map(
   (NULL < c_retail and c_retail <= 28.85) => -0.0098920345,
   (c_retail > 28.85) => 
      map(
      (NULL < f_hh_bankruptcies_i and f_hh_bankruptcies_i <= 0.5) => 0.0543217672,
      (f_hh_bankruptcies_i > 0.5) => -0.0537937624,
      (f_hh_bankruptcies_i = NULL) => 0.0321374776, 0.0321374776),
   (c_retail = NULL) => 0.0323431703, -0.0047700885),
(f_rel_under500miles_cnt_d > 30.5) => -0.0585468614,
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < c_child and c_child <= 22.95) => -0.0343801785,
   (c_child > 22.95) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 212835.5) => 0.1477424359,
      (c_med_hval > 212835.5) => -0.0077912845,
      (c_med_hval = NULL) => 0.0649257796, 0.0649257796),
   (c_child = NULL) => 0.0107322626, 0.0107322626), -0.0053426235);

// Tree: 115 
wFDN_FLA____lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 363.75) => 0.0008330389,
   (c_oldhouse > 363.75) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 114.5) => -0.0736234981,
         (f_M_Bureau_ADL_FS_all_d > 114.5) => 
            map(
            (NULL < c_retired2 and c_retired2 <= 36.5) => 0.2066871130,
            (c_retired2 > 36.5) => 0.0051492541,
            (c_retired2 = NULL) => 0.0448220610, 0.0448220610),
         (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0039818963, -0.0039818963),
      (r_I60_Inq_Count12_i > 0.5) => -0.0863672328,
      (r_I60_Inq_Count12_i = NULL) => -0.0374792309, -0.0374792309),
   (c_oldhouse = NULL) => -0.0014702416, -0.0014702416),
(c_pop_0_5_p > 21.15) => 0.1464046487,
(c_pop_0_5_p = NULL) => 0.0073079459, -0.0006288759);

// Tree: 116 
wFDN_FLA____lgt_116 := map(
(NULL < c_easiqlife and c_easiqlife <= 130.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 15.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 4.5) => -0.0338439230,
      (f_rel_homeover100_count_d > 4.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0071205503,
         (f_rel_under25miles_cnt_d > 5.5) => 0.2245717354,
         (f_rel_under25miles_cnt_d = NULL) => 0.1273374656, 0.1273374656),
      (f_rel_homeover100_count_d = NULL) => 0.0667921724, 0.0667921724),
   (r_D32_Mos_Since_Crim_LS_d > 15.5) => -0.0137980684,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0429954156, -0.0120466110),
(c_easiqlife > 130.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 0.0091249942,
   (k_comb_age_d > 81.5) => 0.1609880851,
   (k_comb_age_d = NULL) => 0.0593754406, 0.0118211384),
(c_easiqlife = NULL) => 0.0109302720, -0.0028227965);

// Tree: 117 
wFDN_FLA____lgt_117 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 0.0138712662,
   (c_hval_20k_p > 0.65) => 0.1684473685,
   (c_hval_20k_p = NULL) => 0.0561051739, 0.0561051739),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.75) => -0.0052837729,
   (c_hh3_p > 23.75) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 114.5) => 0.0082472416,
      (c_no_labfor > 114.5) => 0.0770035697,
      (c_no_labfor = NULL) => 0.0261393744, 0.0261393744),
   (c_hh3_p = NULL) => 0.0005437606, -0.0008693981),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 1.2) => -0.0908664119,
   (c_hval_125k_p > 1.2) => 0.0207478139,
   (c_hval_125k_p = NULL) => -0.0265049240, -0.0265049240), -0.0003472251);

// Tree: 118 
wFDN_FLA____lgt_118 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => -0.0064899828,
   (k_comb_age_d > 84.5) => 0.0857381733,
   (k_comb_age_d = NULL) => -0.0058196117, -0.0058196117),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 9.45) => -0.0028399096,
   (c_pop_0_5_p > 9.45) => 0.1364309617,
   (c_pop_0_5_p = NULL) => 0.0622399368, 0.0622399368),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0876595303,
      (k_nap_lname_verd_d > 0.5) => -0.0656260662,
      (k_nap_lname_verd_d = NULL) => 0.0182894063, 0.0182894063),
   (r_L77_Apartment_i > 0.5) => -0.0896553429,
   (r_L77_Apartment_i = NULL) => -0.0109934778, -0.0109934778), -0.0053168333);

// Tree: 119 
wFDN_FLA____lgt_119 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0646104141,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < c_trailer and c_trailer <= 155.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0531234757) => -0.0707791148,
         (f_add_input_nhood_BUS_pct_i > 0.0531234757) => 0.0263130460,
         (f_add_input_nhood_BUS_pct_i = NULL) => -0.0305661411, -0.0305661411),
      (c_trailer > 155.5) => -0.1278153164,
      (c_trailer = NULL) => -0.0476422728, -0.0476422728),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0070253871,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0033962941, 0.0033962941),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 1.95) => 0.0303487290,
   (c_hval_100k_p > 1.95) => -0.0702530511,
   (c_hval_100k_p = NULL) => -0.0101714324, -0.0101714324), 0.0042847020);

// Tree: 120 
wFDN_FLA____lgt_120 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.25) => -0.0138778095,
(c_pop_35_44_p > 14.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0034328521,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => 
         map(
         (NULL < c_work_home and c_work_home <= 99.5) => 0.0621185190,
         (c_work_home > 99.5) => -0.0283062584,
         (c_work_home = NULL) => 0.0128845432, 0.0128845432),
      (f_divaddrsuspidcountnew_i > 0.5) => 
         map(
         (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.2132180660,
         (r_C18_invalid_addrs_per_adl_i > 0.5) => 0.0582475157,
         (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0995729957, 0.0995729957),
      (f_divaddrsuspidcountnew_i = NULL) => 0.0320069959, 0.0320069959),
   (f_rel_felony_count_i = NULL) => 0.0362576900, 0.0079257836),
(c_pop_35_44_p = NULL) => -0.0309898253, -0.0028467913);

// Tree: 121 
wFDN_FLA____lgt_121 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 178.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 67.5) => -0.0228227727,
      (r_C13_max_lres_d > 67.5) => 0.0037138214,
      (r_C13_max_lres_d = NULL) => -0.0016372427, -0.0016372427),
   (c_lar_fam > 178.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.03674912395) => 0.0173645261,
      (f_add_curr_nhood_VAC_pct_i > 0.03674912395) => 0.1638949359,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0566262627, 0.0566262627),
   (c_lar_fam = NULL) => 0.0015054314, -0.0006002615),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0697032692,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32254086925) => 0.0530057912,
   (f_add_input_mobility_index_i > 0.32254086925) => -0.0535321979,
   (f_add_input_mobility_index_i = NULL) => 0.0042293624, 0.0042293624), -0.0001978396);

// Tree: 122 
wFDN_FLA____lgt_122 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 41.5) => -0.0150009293,
   (r_C13_Curr_Addr_LRes_d > 41.5) => 0.0084831761,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0004865005, -0.0004865005),
(r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0563449747) => 
      map(
      (NULL < c_unemp and c_unemp <= 4.05) => -0.0837534277,
      (c_unemp > 4.05) => 0.1245414658,
      (c_unemp = NULL) => 0.0168027278, 0.0168027278),
   (f_add_input_nhood_BUS_pct_i > 0.0563449747) => 0.0911148508,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0455052938, 0.0455052938),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.5) => 0.0764593947,
   (C_INC_75K_P > 15.5) => -0.0243016158,
   (C_INC_75K_P = NULL) => 0.0092853877, 0.0092853877), 0.0003599411);

// Tree: 123 
wFDN_FLA____lgt_123 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 24.15) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 197) => 0.0099894578,
      (f_M_Bureau_ADL_FS_noTU_d > 197) => -0.0966793404,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0365842428, -0.0365842428),
   (nf_vf_hi_risk_index > 4.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => -0.0005345420,
      (f_inq_Communications_count_i > 1.5) => 0.0523611029,
      (f_inq_Communications_count_i = NULL) => 0.0010624860, 0.0010624860),
   (nf_vf_hi_risk_index = NULL) => 0.0157379371, 0.0003071727),
(c_hval_150k_p > 24.15) => 
   map(
   (NULL < c_families and c_families <= 787.5) => 0.0248458490,
   (c_families > 787.5) => 0.2455476171,
   (c_families = NULL) => 0.0507445258, 0.0507445258),
(c_hval_150k_p = NULL) => -0.0154204467, 0.0030636684);

// Tree: 124 
wFDN_FLA____lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => -0.0063982747,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 
         map(
         (NULL < c_high_hval and c_high_hval <= 4.9) => 
            map(
            (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0564058788,
            (f_varrisktype_i > 2.5) => 0.1772644527,
            (f_varrisktype_i = NULL) => 0.1099368454, 0.1099368454),
         (c_high_hval > 4.9) => -0.0138613174,
         (c_high_hval = NULL) => 0.0716648581, 0.0716648581),
      (nf_seg_FraudPoint_3_0 = '') => 0.0308137751, 0.0308137751),
   (f_prevaddrlenofres_d > 2.5) => 0.0026971019,
   (f_prevaddrlenofres_d = NULL) => -0.0091739727, 0.0046831131),
(c_high_ed > 42.55) => -0.0275931090,
(c_high_ed = NULL) => -0.0297336599, -0.0052654092);

// Tree: 125 
wFDN_FLA____lgt_125 := map(
(NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 39.65) => -0.0070616777,
      (c_hval_750k_p > 39.65) => 0.0384766890,
      (c_hval_750k_p = NULL) => -0.0202320924, -0.0038269188),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 61500) => 0.0116373602,
      (k_estimated_income_d > 61500) => 0.1922820633,
      (k_estimated_income_d = NULL) => 0.0829187836, 0.0829187836),
   (f_nae_nothing_found_i = NULL) => -0.0025390643, -0.0025390643),
(f_liens_unrel_SC_total_amt_i > 5693) => 0.1254890490,
(f_liens_unrel_SC_total_amt_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.24828402115) => -0.0777913081,
   (f_add_input_mobility_index_i > 0.24828402115) => 0.0308809222,
   (f_add_input_mobility_index_i = NULL) => -0.0051209210, -0.0051209210), -0.0019874645);

// Tree: 126 
wFDN_FLA____lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.1895058485) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 17.5) => -0.0383146139,
      (f_rel_incomeover50_count_d > 17.5) => 0.1030829360,
      (f_rel_incomeover50_count_d = NULL) => -0.0326814976, -0.0326814976),
   (f_add_input_mobility_index_i > 0.1895058485) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.55) => -0.0674998824,
      (C_OWNOCC_P > 1.55) => 
         map(
         (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 5.5) => 0.0175357792,
         (r_C14_addrs_15yr_i > 5.5) => -0.0138055566,
         (r_C14_addrs_15yr_i = NULL) => -0.0060491625, 0.0116123179),
      (C_OWNOCC_P = NULL) => 0.0022327457, 0.0102856940),
   (f_add_input_mobility_index_i = NULL) => 0.0376253043, 0.0026989385),
(r_L72_Add_Vacant_i > 0.5) => 0.1118176859,
(r_L72_Add_Vacant_i = NULL) => 0.0034475649, 0.0034475649);

// Tree: 127 
wFDN_FLA____lgt_127 := map(
(NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 2.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 3.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 54.5) => 0.0208677337,
      (c_no_labfor > 54.5) => -0.0086355957,
      (c_no_labfor = NULL) => -0.0068427320, -0.0004980434),
   (f_inq_HighRiskCredit_count24_i > 3.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 111) => 
         map(
         (NULL < c_retail and c_retail <= 6.35) => -0.0279667327,
         (c_retail > 6.35) => -0.1399191446,
         (c_retail = NULL) => -0.0799446382, -0.0799446382),
      (c_many_cars > 111) => 0.0386976335,
      (c_many_cars = NULL) => -0.0433266531, -0.0433266531),
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0010553314, -0.0010553314),
(nf_vf_hi_addr_add_entries > 2.5) => 0.0821262535,
(nf_vf_hi_addr_add_entries = NULL) => -0.0198548741, -0.0009212379);

// Tree: 128 
wFDN_FLA____lgt_128 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 178) => -0.0875025101,
(f_mos_liens_rel_SC_lseen_d > 178) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1906.5) => -0.0037347998,
   (c_popover18 > 1906.5) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 2.55) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 20.5) => 0.1859471446,
         (c_born_usa > 20.5) => 0.0505147664,
         (c_born_usa = NULL) => 0.0601267933, 0.0601267933),
      (c_rnt2000_p > 2.55) => -0.0076857168,
      (c_rnt2000_p = NULL) => 0.0282251310, 0.0282251310),
   (c_popover18 = NULL) => -0.0088864943, 0.0022586311),
(f_mos_liens_rel_SC_lseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 14.95) => 0.0824876782,
   (c_hh3_p > 14.95) => -0.0085983824,
   (c_hh3_p = NULL) => 0.0305348881, 0.0305348881), 0.0017892178);

// Tree: 129 
wFDN_FLA____lgt_129 := map(
(NULL < c_low_hval and c_low_hval <= 67.2) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.005) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 0.0030488206,
      (c_pop_18_24_p > 11.15) => -0.0244605699,
      (c_pop_18_24_p = NULL) => -0.0030570443, -0.0030570443),
   (c_hhsize > 4.005) => 
      map(
      (NULL < c_construction and c_construction <= 11.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 0.1206988030,
         (r_L79_adls_per_addr_curr_i > 4.5) => -0.0597037760,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0156883466, 0.0156883466),
      (c_construction > 11.5) => 0.1763246548,
      (c_construction = NULL) => 0.0668362258, 0.0668362258),
   (c_hhsize = NULL) => -0.0019138636, -0.0019138636),
(c_low_hval > 67.2) => -0.0904103363,
(c_low_hval = NULL) => 0.0164302105, -0.0022929514);

// Tree: 130 
wFDN_FLA____lgt_130 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0154065350,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13212450645) => 0.0048009524,
      (f_add_curr_nhood_BUS_pct_i > 0.13212450645) => 0.0544362778,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1215736176, 0.0162695483),
   (f_inq_Other_count_i = NULL) => 0.0035162980, -0.0079606192),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 163.5) => 0.0142653220,
   (c_totcrime > 163.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.8215421906) => 0.0378705142,
      (f_add_curr_nhood_SFD_pct_d > 0.8215421906) => 0.2170776952,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0968354576, 0.0968354576),
   (c_totcrime = NULL) => 0.0772020628, 0.0320879257),
(r_L70_Add_Standardized_i = NULL) => -0.0045793034, -0.0045793034);

// Tree: 131 
wFDN_FLA____lgt_131 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 813323.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 11.65) => -0.1021166277,
   (c_white_col > 11.65) => 0.0004044915,
   (c_white_col = NULL) => 0.0153507044, 0.0001305669),
(f_prevaddrmedianvalue_d > 813323.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.65) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 178.5) => 0.0708151448,
      (c_rich_asian > 178.5) => 0.2998069206,
      (c_rich_asian = NULL) => 0.1676962807, 0.1676962807),
   (c_pop_0_5_p > 7.65) => -0.0463016299,
   (c_pop_0_5_p = NULL) => 0.1001179931, 0.1001179931),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 119.5) => -0.0425983148,
   (c_easiqlife > 119.5) => 0.0533081831,
   (c_easiqlife = NULL) => -0.0010865471, -0.0010865471), 0.0016125710);

// Tree: 132 
wFDN_FLA____lgt_132 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 111) => -0.0022348596,
(f_addrchangecrimediff_i > 111) => 0.0748921281,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 53.65) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 24.5) => 
         map(
         (NULL < f_idverrisktype_i and f_idverrisktype_i <= 4) => 
            map(
            (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => 0.0003816349,
            (f_inq_QuizProvider_count_i > 1.5) => 0.0762034978,
            (f_inq_QuizProvider_count_i = NULL) => 0.0082333065, 0.0082333065),
         (f_idverrisktype_i > 4) => -0.0730592319,
         (f_idverrisktype_i = NULL) => 0.0038783491, 0.0038783491),
      (f_phones_per_addr_curr_i > 24.5) => 0.1026403784,
      (f_phones_per_addr_curr_i = NULL) => 0.0072030872, 0.0075683923),
   (c_construction > 53.65) => 0.1922787945,
   (c_construction = NULL) => -0.0200622927, 0.0085425213), 0.0006642228);

// Tree: 133 
wFDN_FLA____lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.25) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 71) => 0.1156302758,
      (c_rich_fam > 71) => -0.0429127203,
      (c_rich_fam = NULL) => 0.0137097783, 0.0137097783),
   (c_hval_20k_p > 0.25) => 0.1451413160,
   (c_hval_20k_p = NULL) => 0.0637235493, 0.0637235493),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0096525956,
   (f_bus_name_nover_i > 0.5) => 0.0177382650,
   (f_bus_name_nover_i = NULL) => 0.0014741053, 0.0014741053),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.8) => 0.0540139250,
   (c_hh3_p > 15.8) => -0.0612664100,
   (c_hh3_p = NULL) => -0.0007235003, -0.0007235003), 0.0025630046);

// Tree: 134 
wFDN_FLA____lgt_134 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 37.5) => 
   map(
   (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 4.5) => 0.0017713525,
   (f_dl_addrs_per_adl_i > 4.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 4.05) => -0.0632475655,
      (c_unemp > 4.05) => 0.1411673869,
      (c_unemp = NULL) => 0.0614584118, 0.0614584118),
   (f_dl_addrs_per_adl_i = NULL) => 0.0025515117, 0.0025515117),
(f_rel_count_i > 37.5) => 
   map(
   (NULL < c_health and c_health <= 0.65) => -0.1325585969,
   (c_health > 0.65) => -0.0220734485,
   (c_health = NULL) => -0.0520218037, -0.0520218037),
(f_rel_count_i = NULL) => 
   map(
   (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => -0.0580249181,
   (k_nap_nothing_found_i > 0.5) => 0.0402376459,
   (k_nap_nothing_found_i = NULL) => -0.0047500340, -0.0047500340), 0.0012599518);

// Tree: 135 
wFDN_FLA____lgt_135 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.25) => -0.0129419415,
   (c_pop_12_17_p > 10.25) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 3.75) => 
         map(
         (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.1740375929,
         (r_Prop_Owner_History_d > 1.5) => 0.0324373919,
         (r_Prop_Owner_History_d = NULL) => 0.0914374756, 0.0914374756),
      (c_pop_55_64_p > 3.75) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 28.45) => -0.0058354094,
         (c_newhouse > 28.45) => 0.0675481632,
         (c_newhouse = NULL) => 0.0150727593, 0.0150727593),
      (c_pop_55_64_p = NULL) => 0.0185623884, 0.0185623884),
   (c_pop_12_17_p = NULL) => 0.0178550864, -0.0051380903),
(k_comb_age_d > 66.5) => 0.0406082313,
(k_comb_age_d = NULL) => -0.0057832368, -0.0015447735);

// Tree: 136 
wFDN_FLA____lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 29902.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 11.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 130) => 0.0356130386,
         (c_sub_bus > 130) => 
            map(
            (NULL < c_retail and c_retail <= 8.8) => 0.2076910062,
            (c_retail > 8.8) => 0.0775890155,
            (c_retail = NULL) => 0.1401852563, 0.1401852563),
         (c_sub_bus = NULL) => 0.0904875687, 0.0904875687),
      (c_incollege > 11.5) => -0.0478389223,
      (c_incollege = NULL) => 0.1114055426, 0.0718352375),
   (f_curraddrmedianincome_d > 29902.5) => 0.0148165650,
   (f_curraddrmedianincome_d = NULL) => 0.0213645706, 0.0213645706),
(f_hh_members_ct_d > 1.5) => -0.0076616301,
(f_hh_members_ct_d = NULL) => -0.0160877143, -0.0016308775);

// Tree: 137 
wFDN_FLA____lgt_137 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 190159.5) => -0.0047637331,
(f_addrchangevaluediff_d > 190159.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 30.2) => 0.1860179800,
   (c_hh2_p > 30.2) => -0.0313322604,
   (c_hh2_p = NULL) => 0.0615524577, 0.0615524577),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 21.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 3.25) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 135.5) => -0.0122806725,
         (c_easiqlife > 135.5) => 0.0480166095,
         (c_easiqlife = NULL) => 0.0081049666, 0.0081049666),
      (c_hh6_p > 3.25) => -0.0360663615,
      (c_hh6_p = NULL) => 0.0171721450, -0.0012585405),
   (f_bus_addr_match_count_d > 21.5) => 0.1450324979,
   (f_bus_addr_match_count_d = NULL) => 0.0018084596, 0.0018084596), -0.0025951534);

// Tree: 138 
wFDN_FLA____lgt_138 := map(
(NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 190.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 6.95) => -0.0447711304,
   (c_pop_45_54_p > 6.95) => 0.0028033138,
   (c_pop_45_54_p = NULL) => -0.0090967875, 0.0000945072),
(f_curraddrcartheftindex_i > 190.5) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 485) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 357.5) => 0.0431772414,
      (c_hh00 > 357.5) => 0.2375647088,
      (c_hh00 = NULL) => 0.1403709751, 0.1403709751),
   (c_hh00 > 485) => 0.0079460350,
   (c_hh00 = NULL) => 0.0489444685, 0.0489444685),
(f_curraddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 63.1) => 0.0453201961,
   (c_civ_emp > 63.1) => -0.0533017719,
   (c_civ_emp = NULL) => 0.0028368868, 0.0028368868), 0.0013847406);

// Tree: 139 
wFDN_FLA____lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 14.3) => -0.0319386213,
      (C_INC_50K_P > 14.3) => 0.1161074431,
      (C_INC_50K_P = NULL) => 0.0242540454, 0.0242540454),
   (r_L79_adls_per_addr_curr_i > 4.5) => 0.1304862657,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0519186861, 0.0519186861),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0031081161,
   (c_lar_fam > 181.5) => 0.0804450530,
   (c_lar_fam = NULL) => -0.0364050973, -0.0029524011),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 5.95) => -0.0982065629,
   (C_INC_25K_P > 5.95) => 0.0302985952,
   (C_INC_25K_P = NULL) => -0.0178908391, -0.0178908391), -0.0023220728);

// Tree: 140 
wFDN_FLA____lgt_140 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => -0.0014760666,
   (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0682341319,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0011032848, -0.0011032848),
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.1116627890,
      (f_adl_util_conv_n > 0.5) => -0.1126461155,
      (f_adl_util_conv_n = NULL) => 0.0128147972, 0.0128147972),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1451281289,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0583893892, 0.0583893892),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 3.7) => -0.0583476489,
   (c_hval_750k_p > 3.7) => 0.0429018698,
   (c_hval_750k_p = NULL) => -0.0162219367, -0.0162219367), -0.0004533565);

// Tree: 141 
wFDN_FLA____lgt_141 := map(
(NULL < c_rich_blk and c_rich_blk <= 193.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 208.9) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 25.55) => 0.0087097372,
      (c_famotf18_p > 25.55) => 0.0740024938,
      (c_famotf18_p = NULL) => 0.0159977094, 0.0159977094),
   (c_cpiall > 208.9) => -0.0085035674,
   (c_cpiall = NULL) => -0.0049768532, -0.0049768532),
(c_rich_blk > 193.5) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 13.5) => 
      map(
      (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0678218052,
      (f_phones_per_addr_c6_i > 0.5) => 0.1533992669,
      (f_phones_per_addr_c6_i = NULL) => 0.0204373790, 0.0204373790),
   (f_rel_incomeover25_count_d > 13.5) => 0.1344024180,
   (f_rel_incomeover25_count_d = NULL) => 0.0438869755, 0.0438869755),
(c_rich_blk = NULL) => -0.0278841934, -0.0045689497);

// Tree: 142 
wFDN_FLA____lgt_142 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -56.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 47.9) => -0.0780565920,
   (r_C12_source_profile_d > 47.9) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 10.1) => 0.0107013308,
      (c_famotf18_p > 10.1) => 0.1949611636,
      (c_famotf18_p = NULL) => 0.0860803533, 0.0860803533),
   (r_C12_source_profile_d = NULL) => 0.0446477263, 0.0446477263),
(f_addrchangecrimediff_i > -56.5) => -0.0042360788,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -6952.5) => -0.0480244955,
   (r_A49_Curr_AVM_Chg_1yr_i > -6952.5) => 0.0484427398,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 5.5) => 0.1143138865,
      (c_born_usa > 5.5) => -0.0104612865,
      (c_born_usa = NULL) => 0.0257313746, -0.0020860095), 0.0051245108), -0.0012793620);

// Tree: 143 
wFDN_FLA____lgt_143 := map(
(NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0036979250,
      (f_srchunvrfddobcount_i > 0.5) => 0.0484594536,
      (f_srchunvrfddobcount_i = NULL) => 0.0050352981, 0.0050352981),
   (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0670825035,
   (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 0.0036467777, 0.0036467777),
(f_inq_Auto_count24_i > 1.5) => -0.0429972729,
(f_inq_Auto_count24_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 15.7) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1152) => 0.0204311815,
      (c_popover25 > 1152) => -0.0967262660,
      (c_popover25 = NULL) => -0.0375675549, -0.0375675549),
   (c_retail > 15.7) => 0.0530752074,
   (c_retail = NULL) => -0.0071545228, -0.0071545228), 0.0010301577);

// Tree: 144 
wFDN_FLA____lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < c_employees and c_employees <= 82.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.95) => 0.0075242524,
      (c_unemp > 8.95) => 0.0581185911,
      (c_unemp = NULL) => 0.0126274763, 0.0126274763),
   (c_employees > 82.5) => -0.0110316688,
   (c_employees = NULL) => -0.0051589146, -0.0051589146),
(c_rnt2001_p > 49) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99257004065) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 631907) => -0.0364752613,
      (f_prevaddrmedianvalue_d > 631907) => 0.1575805506,
      (f_prevaddrmedianvalue_d = NULL) => 0.0228719045, 0.0228719045),
   (f_add_input_nhood_SFD_pct_d > 0.99257004065) => 0.1868674099,
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0748308765, 0.0748308765),
(c_rnt2001_p = NULL) => 0.0030099276, -0.0030679266);

// Tree: 145 
wFDN_FLA____lgt_145 := map(
(NULL < c_med_hhinc and c_med_hhinc <= 21102.5) => -0.0670459879,
(c_med_hhinc > 21102.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 323.5) => -0.0016785232,
   (f_prevaddrageoldest_d > 323.5) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 6.25) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 102.5) => 
            map(
            (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 1.5) => 0.1107926990,
            (f_hh_tot_derog_i > 1.5) => 0.2555749084,
            (f_hh_tot_derog_i = NULL) => 0.1557251088, 0.1557251088),
         (c_relig_indx > 102.5) => 0.0148868265,
         (c_relig_indx = NULL) => 0.0837788056, 0.0837788056),
      (c_hval_100k_p > 6.25) => -0.0459562001,
      (c_hval_100k_p = NULL) => 0.0481697218, 0.0481697218),
   (f_prevaddrageoldest_d = NULL) => 0.0015374601, 0.0006907984),
(c_med_hhinc = NULL) => 0.0032138312, -0.0002586068);

// Tree: 146 
wFDN_FLA____lgt_146 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 5) => 
      map(
      (NULL < c_work_home and c_work_home <= 91.5) => 0.2164865228,
      (c_work_home > 91.5) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 103.5) => -0.0804009390,
         (c_rich_wht > 103.5) => 0.1590097529,
         (c_rich_wht = NULL) => 0.0304373443, 0.0304373443),
      (c_work_home = NULL) => 0.0379415841, 0.0813286229),
   (f_prevaddrmurderindex_i > 5) => 0.0137686402,
   (f_prevaddrmurderindex_i = NULL) => 0.0194808601, 0.0194808601),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => -0.0094023900,
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1236123223,
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0085698731, -0.0085698731),
(f_hh_members_ct_d = NULL) => 0.0002955771, -0.0026922860);

// Tree: 147 
wFDN_FLA____lgt_147 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 546.5) => -0.0580025625,
(f_mos_inq_banko_am_lseen_d > 546.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 182.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.2455325579) => 0.0084702937,
         (f_add_input_nhood_MFD_pct_i > 0.2455325579) => -0.0244343728,
         (f_add_input_nhood_MFD_pct_i = NULL) => -0.0110953115, -0.0041093498),
      (c_lar_fam > 182.5) => 0.1314023244,
      (c_lar_fam = NULL) => -0.0031869788, -0.0031869788),
   (c_cpiall > 218.4) => 0.0211461242,
   (c_cpiall = NULL) => -0.0347464731, 0.0019644093),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 33.15) => 0.0737278272,
   (c_lowinc > 33.15) => -0.0583775599,
   (c_lowinc = NULL) => 0.0207118495, 0.0207118495), -0.0007714589);

// Tree: 148 
wFDN_FLA____lgt_148 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 61.5) => -0.0634497114,
(f_mos_inq_banko_am_fseen_d > 61.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 15.55) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 2.7) => 0.1684052565,
         (c_hh6_p > 2.7) => 0.0174395996,
         (c_hh6_p = NULL) => 0.0851701376, 0.0851701376),
      (r_Prop_Owner_History_d > 0.5) => 0.0051073842,
      (r_Prop_Owner_History_d = NULL) => 0.0343216039, 0.0343216039),
   (c_hh2_p > 15.55) => -0.0007838223,
   (c_hh2_p = NULL) => 0.0031926673, 0.0007845503),
(f_mos_inq_banko_am_fseen_d = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 135.5) => -0.0426667326,
   (c_relig_indx > 135.5) => 0.0481389131,
   (c_relig_indx = NULL) => -0.0060831631, -0.0060831631), -0.0021095834);

// Tree: 149 
wFDN_FLA____lgt_149 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0085561595) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => 0.0271897941,
   (f_crim_rel_under500miles_cnt_i > 2.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 1.5) => 0.2847738997,
      (f_srchvelocityrisktype_i > 1.5) => 0.0271982274,
      (f_srchvelocityrisktype_i = NULL) => 0.1061150291, 0.1061150291),
   (f_crim_rel_under500miles_cnt_i = NULL) => 0.0454811454, 0.0454811454),
(f_add_input_nhood_MFD_pct_i > 0.0085561595) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 820276.5) => -0.0033787829,
   (f_prevaddrmedianvalue_d > 820276.5) => 0.1466273855,
   (f_prevaddrmedianvalue_d = NULL) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 62.1) => 0.0454160767,
      (c_civ_emp > 62.1) => -0.0814242470,
      (c_civ_emp = NULL) => -0.0150949034, -0.0150949034), -0.0016810977),
(f_add_input_nhood_MFD_pct_i = NULL) => 0.0048728052, 0.0034777548);

// Tree: 150 
wFDN_FLA____lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 2.75) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => 0.0026851060,
      (f_inq_Collection_count24_i > 1.5) => 
         map(
         (NULL < c_white_col and c_white_col <= 30.75) => -0.0286876968,
         (c_white_col > 30.75) => 0.0728678385,
         (c_white_col = NULL) => 0.0495423622, 0.0495423622),
      (f_inq_Collection_count24_i = NULL) => 0.0264849357, 0.0059336680),
   (c_trailer_p > 2.75) => -0.0206016652,
   (c_trailer_p = NULL) => -0.0011346381, -0.0011346381),
(c_low_ed > 77.75) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 2.5) => -0.1176343100,
   (f_rel_homeover100_count_d > 2.5) => -0.0323312116,
   (f_rel_homeover100_count_d = NULL) => -0.0568806498, -0.0568806498),
(c_low_ed = NULL) => -0.0012305078, -0.0026924872);

// Tree: 151 
wFDN_FLA____lgt_151 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.94494685515) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 0.55) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1423) => 0.0207728713,
      (f_addrchangeincomediff_d > 1423) => 0.0943307144,
      (f_addrchangeincomediff_d = NULL) => 
         map(
         (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 1.5) => -0.0031363271,
         (f_inq_Other_count_i > 1.5) => 0.1424404916,
         (f_inq_Other_count_i = NULL) => 0.0127291878, 0.0127291878), 0.0226982662),
   (c_pop_85p_p > 0.55) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 6.5) => -0.0016423029,
      (f_assoccredbureaucount_i > 6.5) => -0.1250614198,
      (f_assoccredbureaucount_i = NULL) => -0.0026354620, -0.0026354620),
   (c_pop_85p_p = NULL) => 0.0058871600, 0.0058871600),
(f_add_curr_nhood_MFD_pct_i > 0.94494685515) => -0.0398674011,
(f_add_curr_nhood_MFD_pct_i = NULL) => -0.0191783545, -0.0003609419);

// Tree: 152 
wFDN_FLA____lgt_152 := map(
(NULL < c_med_age and c_med_age <= 28.75) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 57.95) => -0.0442266571,
   (c_fammar18_p > 57.95) => 0.0688452556,
   (c_fammar18_p = NULL) => -0.0298540605, -0.0298540605),
(c_med_age > 28.75) => 
   map(
   (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 18.5) => 0.1235270570,
      (f_mos_liens_unrel_CJ_lseen_d > 18.5) => 0.0136313314,
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0146774903, 0.0146774903),
   (f_dl_addrs_per_adl_i > 0.5) => -0.0129557780,
   (f_dl_addrs_per_adl_i = NULL) => 
      map(
      (NULL < c_no_car and c_no_car <= 65) => 0.0731567042,
      (c_no_car > 65) => -0.0395442916,
      (c_no_car = NULL) => 0.0038022452, 0.0038022452), 0.0035447054),
(c_med_age = NULL) => 0.0209438378, 0.0012869989);

// Tree: 153 
wFDN_FLA____lgt_153 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 34.9) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 4.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 175.5) => 
            map(
            (NULL < c_no_teens and c_no_teens <= 105.5) => 0.1405239003,
            (c_no_teens > 105.5) => 0.0240023790,
            (c_no_teens = NULL) => 0.0847962162, 0.0847962162),
         (c_span_lang > 175.5) => -0.0634579165,
         (c_span_lang = NULL) => 0.0628326410, 0.0628326410),
      (r_I60_inq_recency_d > 2) => 0.0054084015,
      (r_I60_inq_recency_d = NULL) => 0.0086277094, 0.0086277094),
   (f_rel_incomeover75_count_d > 4.5) => -0.0188062893,
   (f_rel_incomeover75_count_d = NULL) => -0.0121123217, 0.0007287455),
(c_hval_60k_p > 34.9) => -0.0864595797,
(c_hval_60k_p = NULL) => -0.0077251274, -0.0001560656);

// Tree: 154 
wFDN_FLA____lgt_154 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 31.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 16.15) => -0.0049744135,
   (c_hval_500k_p > 16.15) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 0.0210798118,
      (k_comb_age_d > 70.5) => 0.1384738589,
      (k_comb_age_d = NULL) => 0.0262682094, 0.0262682094),
   (c_hval_500k_p = NULL) => 0.0104018431, 0.0011422137),
(f_rel_under500miles_cnt_d > 31.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 12.8) => -0.0178332812,
   (C_INC_25K_P > 12.8) => -0.1237417618,
   (C_INC_25K_P = NULL) => -0.0443104013, -0.0443104013),
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 229750) => 0.0687181531,
   (r_L80_Inp_AVM_AutoVal_d > 229750) => -0.0744489998,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0062901105, -0.0006653441), 0.0003512547);

// Tree: 155 
wFDN_FLA____lgt_155 := map(
(NULL < c_unempl and c_unempl <= 190.5) => 
   map(
   (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1084453321,
   (r_I60_inq_retail_recency_d > 2) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -13557) => 0.0391464851,
      (f_addrchangeincomediff_d > -13557) => -0.0029547588,
      (f_addrchangeincomediff_d = NULL) => -0.0181729806, -0.0049421141),
   (r_I60_inq_retail_recency_d = NULL) => 
      map(
      (NULL < c_burglary and c_burglary <= 98.5) => -0.0312012667,
      (c_burglary > 98.5) => 0.0773737230,
      (c_burglary = NULL) => 0.0157938781, 0.0157938781), -0.0041525981),
(c_unempl > 190.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 130) => -0.0418029547,
   (c_burglary > 130) => 0.1447119040,
   (c_burglary = NULL) => 0.0623345081, 0.0623345081),
(c_unempl = NULL) => 0.0124230097, -0.0031512184);

// Tree: 156 
wFDN_FLA____lgt_156 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0122112785,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 5.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 19.35) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 10.55) => -0.0112390210,
         (c_hval_200k_p > 10.55) => 0.0573316041,
         (c_hval_200k_p = NULL) => 0.0033179916, 0.0033179916),
      (c_pop_45_54_p > 19.35) => 0.0583901976,
      (c_pop_45_54_p = NULL) => 0.0129855272, 0.0129855272),
   (r_L79_adls_per_addr_c6_i > 5.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 131) => 0.0209630545,
      (c_serv_empl > 131) => 0.1548451014,
      (c_serv_empl = NULL) => 0.0814259144, 0.0814259144),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0151094221, 0.0151094221),
(f_hh_criminals_i = NULL) => 0.0017254213, -0.0033556695);

// Tree: 157 
wFDN_FLA____lgt_157 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 24.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21894) => 0.0689046005,
   (r_A46_Curr_AVM_AutoVal_d > 21894) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 25605.5) => -0.0931309104,
      (c_med_hhinc > 25605.5) => 0.0072601925,
      (c_med_hhinc = NULL) => 0.0058229229, 0.0058229229),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 1.5) => -0.0042222026,
      (f_divsrchaddrsuspidcount_i > 1.5) => -0.0933201417,
      (f_divsrchaddrsuspidcount_i = NULL) => 0.0036893122, -0.0052072396), 0.0016457387),
(c_hval_40k_p > 24.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.7) => 0.2230618271,
   (c_pop_18_24_p > 6.7) => -0.0055107099,
   (c_pop_18_24_p = NULL) => 0.0736975950, 0.0736975950),
(c_hval_40k_p = NULL) => 0.0046875954, 0.0028660146);

// Tree: 158 
wFDN_FLA____lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 3.5) => 0.0006714817,
      (nf_vf_level > 3.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 65.65) => -0.0010414018,
         (c_low_ed > 65.65) => 
            map(
            (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => -0.0565856465,
            (r_C20_email_domain_free_count_i > 0.5) => -0.1626080840,
            (r_C20_email_domain_free_count_i = NULL) => -0.0985528614, -0.0985528614),
         (c_low_ed = NULL) => -0.0248005392, -0.0248005392),
      (nf_vf_level = NULL) => -0.0005551928, -0.0005551928),
   (f_assocsuspicousidcount_i > 15.5) => 0.0700831015,
   (f_assocsuspicousidcount_i = NULL) => -0.0001409752, -0.0001409752),
(r_D33_eviction_count_i > 3.5) => 0.0697532399,
(r_D33_eviction_count_i = NULL) => 0.0012638627, 0.0002847052);

// Tree: 159 
wFDN_FLA____lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 22.5) => -0.0000612486,
   (k_inq_per_addr_i > 22.5) => 0.0804410905,
   (k_inq_per_addr_i = NULL) => 0.0002749194, 0.0002749194),
(f_rel_homeover500_count_d > 19.5) => 0.1039261167,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.14038461535) => 
      map(
      (NULL < c_burglary and c_burglary <= 94.5) => -0.0637047171,
      (c_burglary > 94.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0272058732,
         (c_hh4_p > 11.55) => 0.0906242016,
         (c_hh4_p = NULL) => 0.0297775236, 0.0297775236),
      (c_burglary = NULL) => -0.0235468531, -0.0235468531),
   (f_add_input_nhood_BUS_pct_i > 0.14038461535) => 0.1147374504,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0054324447, 0.0019277851), 0.0009153634);

// Tree: 160 
wFDN_FLA____lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => -0.0046869977,
(r_C12_source_profile_d > 81.3) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 38.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 0.2) => 0.2602845518,
      (c_hh6_p > 0.2) => 0.0367066767,
      (c_hh6_p = NULL) => 0.1523504052, 0.1523504052),
   (C_OWNOCC_P > 38.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 140.5) => -0.0073338162,
      (c_sub_bus > 140.5) => 0.1199934477,
      (c_sub_bus = NULL) => 0.0139125083, 0.0139125083),
   (C_OWNOCC_P = NULL) => 0.0306230141, 0.0306230141),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 128) => -0.0352526018,
   (c_no_car > 128) => 0.0549965617,
   (c_no_car = NULL) => 0.0006156555, 0.0006156555), -0.0019243215);

// Tree: 161 
wFDN_FLA____lgt_161 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 3.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 4.25) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => -0.0608670809,
      (r_D30_Derog_Count_i > 3.5) => -0.1511756471,
      (r_D30_Derog_Count_i = NULL) => -0.0844862444, -0.0844862444),
   (c_hval_300k_p > 4.25) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 3.55) => 0.0947287552,
      (c_hval_175k_p > 3.55) => -0.0586939742,
      (c_hval_175k_p = NULL) => 0.0083649671, 0.0083649671),
   (c_hval_300k_p = NULL) => -0.0439644729, -0.0439644729),
(f_mos_inq_banko_cm_lseen_d > 3.5) => -0.0021000926,
(f_mos_inq_banko_cm_lseen_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.34338654915) => 0.0221501274,
   (f_add_input_mobility_index_i > 0.34338654915) => -0.1022703925,
   (f_add_input_mobility_index_i = NULL) => -0.0219482847, -0.0219482847), -0.0035269179);

// Tree: 162 
wFDN_FLA____lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0014000115,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.6) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.28043700485) => -0.0674838222,
      (f_add_curr_mobility_index_i > 0.28043700485) => -0.0013191998,
      (f_add_curr_mobility_index_i = NULL) => -0.0358398723, -0.0358398723),
   (c_pop_45_54_p > 12.6) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.15) => 0.1669844057,
      (c_pop_55_64_p > 8.15) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => 0.1278184033,
         (f_mos_inq_banko_cm_lseen_d > 27.5) => -0.0133007504,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0402627240, 0.0402627240),
      (c_pop_55_64_p = NULL) => 0.0741455266, 0.0741455266),
   (c_pop_45_54_p = NULL) => 0.0320389052, 0.0320389052),
(r_D30_Derog_Count_i = NULL) => 0.0097407128, -0.0004361593);

// Tree: 163 
wFDN_FLA____lgt_163 := map(
(NULL < c_high_ed and c_high_ed <= 4.15) => 
   map(
   (NULL < c_unattach and c_unattach <= 80.5) => 0.1870995113,
   (c_unattach > 80.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 137.5) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 133) => -0.0711120432,
         (c_for_sale > 133) => 0.0741921753,
         (c_for_sale = NULL) => -0.0316944095, -0.0316944095),
      (f_curraddrmurderindex_i > 137.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 51.35) => 0.1351207272,
         (c_civ_emp > 51.35) => 0.0001294815,
         (c_civ_emp = NULL) => 0.0660307196, 0.0660307196),
      (f_curraddrmurderindex_i = NULL) => 0.0077058807, 0.0077058807),
   (c_unattach = NULL) => 0.0353783024, 0.0353783024),
(c_high_ed > 4.15) => -0.0033953920,
(c_high_ed = NULL) => 0.0058155188, -0.0020384169);

// Tree: 164 
wFDN_FLA____lgt_164 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 0.0037195320,
   (f_assocsuspicousidcount_i > 9.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => -0.0161162661,
      (f_inq_HighRiskCredit_count_i > 1.5) => -0.1257097560,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0344874292, -0.0344874292),
   (f_assocsuspicousidcount_i = NULL) => -0.0070618280, 0.0024491365),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_rich_blk and c_rich_blk <= 181.5) => 0.0260752861,
   (c_rich_blk > 181.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 105.5) => 0.0181201330,
      (c_no_teens > 105.5) => 0.2435406011,
      (c_no_teens = NULL) => 0.1372101916, 0.1372101916),
   (c_rich_blk = NULL) => 0.0515681192, 0.0392751243),
(r_L70_Add_Standardized_i = NULL) => 0.0055670799, 0.0055670799);

// Tree: 165 
wFDN_FLA____lgt_165 := map(
(NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 29.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 50.35) => 0.0001581062,
   (c_hh2_p > 50.35) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 115.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 16.5) => 0.2954733796,
         (f_prevaddrlenofres_d > 16.5) => 0.0722423697,
         (f_prevaddrlenofres_d = NULL) => 0.1143829175, 0.1143829175),
      (c_serv_empl > 115.5) => -0.0330805873,
      (c_serv_empl = NULL) => 0.0662419108, 0.0662419108),
   (c_hh2_p = NULL) => 0.0119582757, 0.0035058143),
(f_liens_rel_O_total_amt_i > 29.5) => -0.1072896816,
(f_liens_rel_O_total_amt_i = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 142.5) => 0.0442132826,
   (c_no_teens > 142.5) => -0.0600260997,
   (c_no_teens = NULL) => 0.0040670340, 0.0040670340), 0.0024305833);

// Tree: 166 
wFDN_FLA____lgt_166 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < c_info and c_info <= 23.35) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 10.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1130) => -0.0026556262,
         (f_addrchangeincomediff_d > 1130) => 0.0338264414,
         (f_addrchangeincomediff_d = NULL) => 0.0087889740, 0.0013445792),
      (f_srchfraudsrchcountyr_i > 10.5) => -0.0950852937,
      (f_srchfraudsrchcountyr_i = NULL) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 2) => 0.0563163864,
         (c_hval_300k_p > 2) => -0.0422641044,
         (c_hval_300k_p = NULL) => 0.0028872655, 0.0028872655), 0.0009442879),
   (c_info > 23.35) => 0.1422425005,
   (c_info = NULL) => 0.0019446292, 0.0019446292),
(c_asian_lang > 194.5) => -0.0546317426,
(c_asian_lang = NULL) => 0.0028640213, -0.0004797915);

// Tree: 167 
wFDN_FLA____lgt_167 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 22.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 0.0156893408,
      (c_rnt750_p > 57.25) => 0.1383423121,
      (c_rnt750_p = NULL) => 0.0239580804, 0.0239580804),
   (c_many_cars > 22.5) => -0.0087330308,
   (c_many_cars = NULL) => -0.0003548101, -0.0057322571),
(f_hh_collections_ct_i > 4.5) => 
   map(
   (NULL < c_hval_400k_p and c_hval_400k_p <= 18.15) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 10.2) => 0.1795449359,
      (c_newhouse > 10.2) => 0.0149946233,
      (c_newhouse = NULL) => 0.1007267189, 0.1007267189),
   (c_hval_400k_p > 18.15) => -0.0605903062,
   (c_hval_400k_p = NULL) => 0.0510185658, 0.0510185658),
(f_hh_collections_ct_i = NULL) => 0.0047344298, -0.0048184865);

// Tree: 168 
wFDN_FLA____lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0060905684,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1894.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 13.5) => 0.0073347812,
      (f_corraddrnamecount_d > 13.5) => 0.1897265800,
      (f_corraddrnamecount_d = NULL) => 0.0237970783, 0.0237970783),
   (c_popover18 > 1894.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.55) => -0.0047098269,
      (c_hh6_p > 1.55) => 
         map(
         (NULL < c_unattach and c_unattach <= 89.5) => 0.1041704877,
         (c_unattach > 89.5) => 0.3291075142,
         (c_unattach = NULL) => 0.2144761449, 0.2144761449),
      (c_hh6_p = NULL) => 0.1285962612, 0.1285962612),
   (c_popover18 = NULL) => 0.0443482942, 0.0443482942),
(c_hval_150k_p = NULL) => -0.0130767974, -0.0027807831);

// Tree: 169 
wFDN_FLA____lgt_169 := map(
(NULL < c_transport and c_transport <= 46.8) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 36.85) => -0.0055755759,
   (c_hval_500k_p > 36.85) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 47) => 0.2176761667,
         (c_rich_wht > 47) => 
            map(
            (NULL < c_femdiv_p and c_femdiv_p <= 4.25) => -0.0639510862,
            (c_femdiv_p > 4.25) => 0.1775750683,
            (c_femdiv_p = NULL) => 0.0534882366, 0.0534882366),
         (c_rich_wht = NULL) => 0.1065178786, 0.1065178786),
      (f_rel_incomeover100_count_d > 0.5) => -0.0098563111,
      (f_rel_incomeover100_count_d = NULL) => 0.0450886876, 0.0450886876),
   (c_hval_500k_p = NULL) => -0.0041347299, -0.0041347299),
(c_transport > 46.8) => 0.1011606385,
(c_transport = NULL) => 0.0022550215, -0.0032036018);

// Tree: 170 
wFDN_FLA____lgt_170 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0817195300,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 37500) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0140430517,
      (f_assocrisktype_i > 7.5) => 
         map(
         (NULL < c_assault and c_assault <= 88) => 0.1547765566,
         (c_assault > 88) => 0.0315718710,
         (c_assault = NULL) => 0.0711330086, 0.0711330086),
      (f_assocrisktype_i = NULL) => 0.0179310900, 0.0179310900),
   (k_estimated_income_d > 37500) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0058999168,
      (f_nae_nothing_found_i > 0.5) => 0.1222002544,
      (f_nae_nothing_found_i = NULL) => -0.0044639772, -0.0044639772),
   (k_estimated_income_d = NULL) => 0.0035564090, 0.0014733263),
(c_pop_45_54_p = NULL) => -0.0370809247, -0.0004020762);

// Tree: 171 
wFDN_FLA____lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 35.55) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 81.5) => 
         map(
         (NULL < c_hval_100k_p and c_hval_100k_p <= 1.55) => 0.1641119410,
         (c_hval_100k_p > 1.55) => 0.0082361192,
         (c_hval_100k_p = NULL) => 0.0712007369, 0.0712007369),
      (r_D32_Mos_Since_Crim_LS_d > 81.5) => -0.0154272766,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0006032491, 0.0006032491),
   (C_RENTOCC_P > 35.55) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 28.5) => 0.0639008580,
      (f_rel_under500miles_cnt_d > 28.5) => -0.0753002831,
      (f_rel_under500miles_cnt_d = NULL) => 0.0533871767, 0.0533871767),
   (C_RENTOCC_P = NULL) => 0.0629070695, 0.0220942063),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0021675662,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0050935239, 0.0012938041);

// Tree: 172 
wFDN_FLA____lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.75) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 20247.5) => 0.0878773513,
      (r_L80_Inp_AVM_AutoVal_d > 20247.5) => -0.0025300303,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 92.95) => -0.0504942773,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 92.95) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45494.5) => 0.1427545321,
            (f_curraddrmedianincome_d > 45494.5) => 0.0067479711,
            (f_curraddrmedianincome_d = NULL) => 0.0312291521, 0.0312291521),
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0010562190, -0.0001225283), -0.0010157775),
   (c_manufacturing > 16.55) => -0.0505689743,
   (c_manufacturing = NULL) => -0.0048337254, -0.0048337254),
(c_pop_0_5_p > 20.75) => 0.1226071863,
(c_pop_0_5_p = NULL) => 0.0014597479, -0.0041421216);

// Tree: 173 
wFDN_FLA____lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.55) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0053224433,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 117) => 0.1935912272,
         (c_easiqlife > 117) => 0.0454773823,
         (c_easiqlife = NULL) => 0.1139333610, 0.1139333610),
      (r_C12_Num_NonDerogs_d > 1.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 134.5) => -0.0072919823,
         (c_exp_prod > 134.5) => 0.0595520813,
         (c_exp_prod = NULL) => 0.0143149971, 0.0143149971),
      (r_C12_Num_NonDerogs_d = NULL) => 0.0210087212, 0.0210087212),
   (f_rel_felony_count_i = NULL) => -0.0135306216, -0.0016332408),
(c_low_hval > 71.55) => -0.1055479771,
(c_low_hval = NULL) => -0.0395864152, -0.0031291963);

// Tree: 174 
wFDN_FLA____lgt_174 := map(
(NULL < c_info and c_info <= 27.55) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 4.7) => 0.0720352041,
      (c_pop_0_5_p > 4.7) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 130) => -0.0171798496,
         (f_prevaddrmurderindex_i > 130) => -0.1250859201,
         (f_prevaddrmurderindex_i = NULL) => -0.0549264598, -0.0549264598),
      (c_pop_0_5_p = NULL) => -0.0313422498, -0.0313422498),
   (nf_vf_hi_risk_index > 4.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 184.5) => 0.0007545123,
      (c_unempl > 184.5) => 0.0592878407,
      (c_unempl = NULL) => 0.0017911994, 0.0017911994),
   (nf_vf_hi_risk_index = NULL) => -0.0264648893, 0.0006102208),
(c_info > 27.55) => 0.1971858901,
(c_info = NULL) => -0.0045171104, 0.0015105293);

// Tree: 175 
wFDN_FLA____lgt_175 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2843546681) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0021640273,
   (k_comb_age_d > 56.5) => 0.0356101307,
   (k_comb_age_d = NULL) => 0.0060776072, 0.0060776072),
(f_add_curr_mobility_index_i > 0.2843546681) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 19999.5) => -0.0563991885,
   (k_estimated_income_d > 19999.5) => -0.0143680005,
   (k_estimated_income_d = NULL) => -0.0166675228, -0.0166675228),
(f_add_curr_mobility_index_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 14.15) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 7.05) => 0.0594946489,
      (c_newhouse > 7.05) => -0.0877748076,
      (c_newhouse = NULL) => -0.0316217054, -0.0316217054),
   (c_famotf18_p > 14.15) => 0.0943111638,
   (c_famotf18_p = NULL) => 0.0415249478, 0.0147346489), -0.0018586203);

// Tree: 176 
wFDN_FLA____lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0049583417,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 91.5) => -0.0215870781,
         (c_many_cars > 91.5) => 
            map(
            (NULL < c_rape and c_rape <= 112.5) => 0.0549662265,
            (c_rape > 112.5) => 0.2369326330,
            (c_rape = NULL) => 0.0908282190, 0.0908282190),
         (c_many_cars = NULL) => 0.0337123679, 0.0337123679),
      (c_pop_55_64_p > 17.45) => 0.2408871520,
      (c_pop_55_64_p = NULL) => 0.0517127999, 0.0517127999),
   (f_util_adl_count_n = NULL) => 0.0124825471, 0.0080340239),
(c_pop_18_24_p > 11.15) => -0.0214345887,
(c_pop_18_24_p = NULL) => 0.0183616392, 0.0015638956);

// Tree: 177 
wFDN_FLA____lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0053708048,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 33.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 35.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 26.7) => 0.0431959409,
         (c_hval_750k_p > 26.7) => 0.3438142761,
         (c_hval_750k_p = NULL) => 0.1905578699, 0.1905578699),
      (c_bel_edu > 35.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 11.05) => 0.0164030873,
         (c_pop_65_74_p > 11.05) => 0.1761240183,
         (c_pop_65_74_p = NULL) => 0.0329756350, 0.0329756350),
      (c_bel_edu = NULL) => 0.0539318123, 0.0539318123),
   (c_born_usa > 33.5) => 0.0081717774,
   (c_born_usa = NULL) => 0.0385284100, 0.0163992771),
(f_prevaddrageoldest_d = NULL) => -0.0117000753, 0.0024389835);

// Tree: 178 
wFDN_FLA____lgt_178 := map(
(NULL < c_families and c_families <= 105.5) => -0.0809930959,
(c_families > 105.5) => 
   map(
   (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0067225931,
   (f_phones_per_addr_c6_i > 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 9.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 47.5) => -0.1152594237,
         (r_C13_max_lres_d > 47.5) => 
            map(
            (NULL < c_easiqlife and c_easiqlife <= 159.5) => 0.0452645056,
            (c_easiqlife > 159.5) => 0.2412714986,
            (c_easiqlife = NULL) => 0.0578870702, 0.0578870702),
         (r_C13_max_lres_d = NULL) => 0.0382961414, 0.0382961414),
      (r_pb_order_freq_d > 9.5) => -0.0085833232,
      (r_pb_order_freq_d = NULL) => 0.0279969933, 0.0151454171),
   (f_phones_per_addr_c6_i = NULL) => 0.0010980521, 0.0010980521),
(c_families = NULL) => -0.0027232192, -0.0003304179);

// Tree: 179 
wFDN_FLA____lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0025588586,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0625975572,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0005040840, 0.0005040840),
(f_rel_incomeover50_count_d > 22.5) => -0.0626001021,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 9.85) => 0.0092946238,
         (c_hh4_p > 9.85) => 0.1602996328,
         (c_hh4_p = NULL) => 0.1036727544, 0.1036727544),
      (c_asian_lang > 158.5) => -0.0311003906,
      (c_asian_lang = NULL) => 0.0495512552, 0.0495512552),
   (c_pop_45_54_p > 16.85) => -0.0809606109,
   (c_pop_45_54_p = NULL) => 0.0148486781, 0.0148486781), -0.0004450974);

// Tree: 180 
wFDN_FLA____lgt_180 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 0.0087445084,
   (f_dl_addrs_per_adl_i > 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 0.5) => -0.0214695151,
      (f_addrchangecrimediff_i > 0.5) => 0.0441089476,
      (f_addrchangecrimediff_i = NULL) => -0.0234219799, -0.0187006386),
   (f_dl_addrs_per_adl_i = NULL) => -0.0022949549, -0.0022949549),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 18.85) => -0.0070736893,
   (C_INC_75K_P > 18.85) => 0.1802303004,
   (C_INC_75K_P = NULL) => 0.0749350846, 0.0749350846),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 105) => -0.0531019205,
   (c_lux_prod > 105) => 0.0486028335,
   (c_lux_prod = NULL) => 0.0034007206, 0.0034007206), -0.0010780648);

// Tree: 181 
wFDN_FLA____lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 17.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 3.9) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.75310017755) => 
         map(
         (NULL < c_child and c_child <= 21.95) => 0.0174624662,
         (c_child > 21.95) => 
            map(
            (NULL < c_oldhouse and c_oldhouse <= 98.15) => 0.0808092337,
            (c_oldhouse > 98.15) => 0.2402991260,
            (c_oldhouse = NULL) => 0.1605541799, 0.1605541799),
         (c_child = NULL) => 0.1061793287, 0.1061793287),
      (f_add_curr_nhood_MFD_pct_i > 0.75310017755) => -0.0727766334,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0670327120, 0.0670327120),
   (c_high_hval > 3.9) => -0.0129060657,
   (c_high_hval = NULL) => 0.0257073342, 0.0257073342),
(r_C21_M_Bureau_ADL_FS_d > 17.5) => -0.0044446960,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0210977980, -0.0026039615);

// Tree: 182 
wFDN_FLA____lgt_182 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0035997722,
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0365790614) => 
      map(
      (NULL < c_incollege and c_incollege <= 4.45) => 
         map(
         (NULL < c_hval_100k_p and c_hval_100k_p <= 5.95) => 0.0664076475,
         (c_hval_100k_p > 5.95) => 0.2100079114,
         (c_hval_100k_p = NULL) => 0.1165181562, 0.1165181562),
      (c_incollege > 4.45) => 0.0274273452,
      (c_incollege = NULL) => 0.0535027045, 0.0535027045),
   (f_add_curr_nhood_BUS_pct_i > 0.0365790614) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 15.5) => 0.0097348047,
      (f_rel_educationover8_count_d > 15.5) => -0.0840606226,
      (f_rel_educationover8_count_d = NULL) => -0.0131566308, -0.0131566308),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0672728742, 0.0228074964),
(k_inq_per_addr_i = NULL) => -0.0007310914, -0.0007310914);

// Tree: 183 
wFDN_FLA____lgt_183 := map(
(NULL < c_transport and c_transport <= 26.65) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
      map(
      (NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0586355702,
      (f_divaddrsuspidcountnew_i > 0.5) => 0.0753040555,
      (f_divaddrsuspidcountnew_i = NULL) => 0.0356802496, 0.0356802496),
   (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0088180523,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0138798307, -0.0079950445),
(c_transport > 26.65) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 18.65) => 
      map(
      (NULL < c_rich_old and c_rich_old <= 134.5) => -0.0311349927,
      (c_rich_old > 134.5) => 0.1527336894,
      (c_rich_old = NULL) => 0.0228882798, 0.0228882798),
   (C_INC_50K_P > 18.65) => 0.1767166033,
   (C_INC_50K_P = NULL) => 0.0592256791, 0.0592256791),
(c_transport = NULL) => 0.0213067391, -0.0059907030);

// Tree: 184 
wFDN_FLA____lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12637.5) => 0.0432660173,
   (f_addrchangeincomediff_d > -12637.5) => -0.0017599974,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 130500) => -0.0067395098,
         (k_estimated_income_d > 130500) => 0.2068586919,
         (k_estimated_income_d = NULL) => -0.0013272356, -0.0013272356),
      (f_util_adl_count_n > 6.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 22.4) => 0.1685810652,
         (c_high_ed > 22.4) => 0.0185247483,
         (c_high_ed = NULL) => 0.0747958672, 0.0747958672),
      (f_util_adl_count_n = NULL) => 0.0006926093, 0.0054283030), 0.0009956935),
(C_RENTOCC_P > 92.2) => -0.0890001257,
(C_RENTOCC_P = NULL) => 0.0223547272, 0.0007759676);

// Tree: 185 
wFDN_FLA____lgt_185 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 4.25) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.15703172865) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 33.2) => -0.0675763877,
         (c_hh2_p > 33.2) => 0.1475517740,
         (c_hh2_p = NULL) => -0.0035501491, -0.0035501491),
      (f_add_curr_nhood_MFD_pct_i > 0.15703172865) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 2.5) => 0.0215057363,
         (f_rel_educationover12_count_d > 2.5) => 0.1490146354,
         (f_rel_educationover12_count_d = NULL) => 0.0972718938, 0.0972718938),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0431565480, 0.0431565480),
   (c_high_ed > 4.25) => 0.0070695682,
   (c_high_ed = NULL) => -0.0067326839, 0.0078907688),
(r_D31_ALL_Bk_i > 1.5) => -0.0340275007,
(r_D31_ALL_Bk_i = NULL) => -0.0001666553, 0.0040452066);

// Final Score Sum 

   wFDN_FLA____lgt := sum(
      wFDN_FLA____lgt_0, wFDN_FLA____lgt_1, wFDN_FLA____lgt_2, wFDN_FLA____lgt_3, wFDN_FLA____lgt_4, 
      wFDN_FLA____lgt_5, wFDN_FLA____lgt_6, wFDN_FLA____lgt_7, wFDN_FLA____lgt_8, wFDN_FLA____lgt_9, 
      wFDN_FLA____lgt_10, wFDN_FLA____lgt_11, wFDN_FLA____lgt_12, wFDN_FLA____lgt_13, wFDN_FLA____lgt_14, 
      wFDN_FLA____lgt_15, wFDN_FLA____lgt_16, wFDN_FLA____lgt_17, wFDN_FLA____lgt_18, wFDN_FLA____lgt_19, 
      wFDN_FLA____lgt_20, wFDN_FLA____lgt_21, wFDN_FLA____lgt_22, wFDN_FLA____lgt_23, wFDN_FLA____lgt_24, 
      wFDN_FLA____lgt_25, wFDN_FLA____lgt_26, wFDN_FLA____lgt_27, wFDN_FLA____lgt_28, wFDN_FLA____lgt_29, 
      wFDN_FLA____lgt_30, wFDN_FLA____lgt_31, wFDN_FLA____lgt_32, wFDN_FLA____lgt_33, wFDN_FLA____lgt_34, 
      wFDN_FLA____lgt_35, wFDN_FLA____lgt_36, wFDN_FLA____lgt_37, wFDN_FLA____lgt_38, wFDN_FLA____lgt_39, 
      wFDN_FLA____lgt_40, wFDN_FLA____lgt_41, wFDN_FLA____lgt_42, wFDN_FLA____lgt_43, wFDN_FLA____lgt_44, 
      wFDN_FLA____lgt_45, wFDN_FLA____lgt_46, wFDN_FLA____lgt_47, wFDN_FLA____lgt_48, wFDN_FLA____lgt_49, 
      wFDN_FLA____lgt_50, wFDN_FLA____lgt_51, wFDN_FLA____lgt_52, wFDN_FLA____lgt_53, wFDN_FLA____lgt_54, 
      wFDN_FLA____lgt_55, wFDN_FLA____lgt_56, wFDN_FLA____lgt_57, wFDN_FLA____lgt_58, wFDN_FLA____lgt_59, 
      wFDN_FLA____lgt_60, wFDN_FLA____lgt_61, wFDN_FLA____lgt_62, wFDN_FLA____lgt_63, wFDN_FLA____lgt_64, 
      wFDN_FLA____lgt_65, wFDN_FLA____lgt_66, wFDN_FLA____lgt_67, wFDN_FLA____lgt_68, wFDN_FLA____lgt_69, 
      wFDN_FLA____lgt_70, wFDN_FLA____lgt_71, wFDN_FLA____lgt_72, wFDN_FLA____lgt_73, wFDN_FLA____lgt_74, 
      wFDN_FLA____lgt_75, wFDN_FLA____lgt_76, wFDN_FLA____lgt_77, wFDN_FLA____lgt_78, wFDN_FLA____lgt_79, 
      wFDN_FLA____lgt_80, wFDN_FLA____lgt_81, wFDN_FLA____lgt_82, wFDN_FLA____lgt_83, wFDN_FLA____lgt_84, 
      wFDN_FLA____lgt_85, wFDN_FLA____lgt_86, wFDN_FLA____lgt_87, wFDN_FLA____lgt_88, wFDN_FLA____lgt_89, 
      wFDN_FLA____lgt_90, wFDN_FLA____lgt_91, wFDN_FLA____lgt_92, wFDN_FLA____lgt_93, wFDN_FLA____lgt_94, 
      wFDN_FLA____lgt_95, wFDN_FLA____lgt_96, wFDN_FLA____lgt_97, wFDN_FLA____lgt_98, wFDN_FLA____lgt_99, 
      wFDN_FLA____lgt_100, wFDN_FLA____lgt_101, wFDN_FLA____lgt_102, wFDN_FLA____lgt_103, wFDN_FLA____lgt_104, 
      wFDN_FLA____lgt_105, wFDN_FLA____lgt_106, wFDN_FLA____lgt_107, wFDN_FLA____lgt_108, wFDN_FLA____lgt_109, 
      wFDN_FLA____lgt_110, wFDN_FLA____lgt_111, wFDN_FLA____lgt_112, wFDN_FLA____lgt_113, wFDN_FLA____lgt_114, 
      wFDN_FLA____lgt_115, wFDN_FLA____lgt_116, wFDN_FLA____lgt_117, wFDN_FLA____lgt_118, wFDN_FLA____lgt_119, 
      wFDN_FLA____lgt_120, wFDN_FLA____lgt_121, wFDN_FLA____lgt_122, wFDN_FLA____lgt_123, wFDN_FLA____lgt_124, 
      wFDN_FLA____lgt_125, wFDN_FLA____lgt_126, wFDN_FLA____lgt_127, wFDN_FLA____lgt_128, wFDN_FLA____lgt_129, 
      wFDN_FLA____lgt_130, wFDN_FLA____lgt_131, wFDN_FLA____lgt_132, wFDN_FLA____lgt_133, wFDN_FLA____lgt_134, 
      wFDN_FLA____lgt_135, wFDN_FLA____lgt_136, wFDN_FLA____lgt_137, wFDN_FLA____lgt_138, wFDN_FLA____lgt_139, 
      wFDN_FLA____lgt_140, wFDN_FLA____lgt_141, wFDN_FLA____lgt_142, wFDN_FLA____lgt_143, wFDN_FLA____lgt_144, 
      wFDN_FLA____lgt_145, wFDN_FLA____lgt_146, wFDN_FLA____lgt_147, wFDN_FLA____lgt_148, wFDN_FLA____lgt_149, 
      wFDN_FLA____lgt_150, wFDN_FLA____lgt_151, wFDN_FLA____lgt_152, wFDN_FLA____lgt_153, wFDN_FLA____lgt_154, 
      wFDN_FLA____lgt_155, wFDN_FLA____lgt_156, wFDN_FLA____lgt_157, wFDN_FLA____lgt_158, wFDN_FLA____lgt_159, 
      wFDN_FLA____lgt_160, wFDN_FLA____lgt_161, wFDN_FLA____lgt_162, wFDN_FLA____lgt_163, wFDN_FLA____lgt_164, 
      wFDN_FLA____lgt_165, wFDN_FLA____lgt_166, wFDN_FLA____lgt_167, wFDN_FLA____lgt_168, wFDN_FLA____lgt_169, 
      wFDN_FLA____lgt_170, wFDN_FLA____lgt_171, wFDN_FLA____lgt_172, wFDN_FLA____lgt_173, wFDN_FLA____lgt_174, 
      wFDN_FLA____lgt_175, wFDN_FLA____lgt_176, wFDN_FLA____lgt_177, wFDN_FLA____lgt_178, wFDN_FLA____lgt_179, 
      wFDN_FLA____lgt_180, wFDN_FLA____lgt_181, wFDN_FLA____lgt_182, wFDN_FLA____lgt_183, wFDN_FLA____lgt_184, 
      wFDN_FLA____lgt_185); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLA____lgt;
			
self.final_score_0	:= 	wFDN_FLA____lgt_0	;
self.final_score_1	:= 	wFDN_FLA____lgt_1	;
self.final_score_2	:= 	wFDN_FLA____lgt_2	;
self.final_score_3	:= 	wFDN_FLA____lgt_3	;
self.final_score_4	:= 	wFDN_FLA____lgt_4	;
self.final_score_5	:= 	wFDN_FLA____lgt_5	;
self.final_score_6	:= 	wFDN_FLA____lgt_6	;
self.final_score_7	:= 	wFDN_FLA____lgt_7	;
self.final_score_8	:= 	wFDN_FLA____lgt_8	;
self.final_score_9	:= 	wFDN_FLA____lgt_9	;
self.final_score_10	:= 	wFDN_FLA____lgt_10	;
self.final_score_11	:= 	wFDN_FLA____lgt_11	;
self.final_score_12	:= 	wFDN_FLA____lgt_12	;
self.final_score_13	:= 	wFDN_FLA____lgt_13	;
self.final_score_14	:= 	wFDN_FLA____lgt_14	;
self.final_score_15	:= 	wFDN_FLA____lgt_15	;
self.final_score_16	:= 	wFDN_FLA____lgt_16	;
self.final_score_17	:= 	wFDN_FLA____lgt_17	;
self.final_score_18	:= 	wFDN_FLA____lgt_18	;
self.final_score_19	:= 	wFDN_FLA____lgt_19	;
self.final_score_20	:= 	wFDN_FLA____lgt_20	;
self.final_score_21	:= 	wFDN_FLA____lgt_21	;
self.final_score_22	:= 	wFDN_FLA____lgt_22	;
self.final_score_23	:= 	wFDN_FLA____lgt_23	;
self.final_score_24	:= 	wFDN_FLA____lgt_24	;
self.final_score_25	:= 	wFDN_FLA____lgt_25	;
self.final_score_26	:= 	wFDN_FLA____lgt_26	;
self.final_score_27	:= 	wFDN_FLA____lgt_27	;
self.final_score_28	:= 	wFDN_FLA____lgt_28	;
self.final_score_29	:= 	wFDN_FLA____lgt_29	;
self.final_score_30	:= 	wFDN_FLA____lgt_30	;
self.final_score_31	:= 	wFDN_FLA____lgt_31	;
self.final_score_32	:= 	wFDN_FLA____lgt_32	;
self.final_score_33	:= 	wFDN_FLA____lgt_33	;
self.final_score_34	:= 	wFDN_FLA____lgt_34	;
self.final_score_35	:= 	wFDN_FLA____lgt_35	;
self.final_score_36	:= 	wFDN_FLA____lgt_36	;
self.final_score_37	:= 	wFDN_FLA____lgt_37	;
self.final_score_38	:= 	wFDN_FLA____lgt_38	;
self.final_score_39	:= 	wFDN_FLA____lgt_39	;
self.final_score_40	:= 	wFDN_FLA____lgt_40	;
self.final_score_41	:= 	wFDN_FLA____lgt_41	;
self.final_score_42	:= 	wFDN_FLA____lgt_42	;
self.final_score_43	:= 	wFDN_FLA____lgt_43	;
self.final_score_44	:= 	wFDN_FLA____lgt_44	;
self.final_score_45	:= 	wFDN_FLA____lgt_45	;
self.final_score_46	:= 	wFDN_FLA____lgt_46	;
self.final_score_47	:= 	wFDN_FLA____lgt_47	;
self.final_score_48	:= 	wFDN_FLA____lgt_48	;
self.final_score_49	:= 	wFDN_FLA____lgt_49	;
self.final_score_50	:= 	wFDN_FLA____lgt_50	;
self.final_score_51	:= 	wFDN_FLA____lgt_51	;
self.final_score_52	:= 	wFDN_FLA____lgt_52	;
self.final_score_53	:= 	wFDN_FLA____lgt_53	;
self.final_score_54	:= 	wFDN_FLA____lgt_54	;
self.final_score_55	:= 	wFDN_FLA____lgt_55	;
self.final_score_56	:= 	wFDN_FLA____lgt_56	;
self.final_score_57	:= 	wFDN_FLA____lgt_57	;
self.final_score_58	:= 	wFDN_FLA____lgt_58	;
self.final_score_59	:= 	wFDN_FLA____lgt_59	;
self.final_score_60	:= 	wFDN_FLA____lgt_60	;
self.final_score_61	:= 	wFDN_FLA____lgt_61	;
self.final_score_62	:= 	wFDN_FLA____lgt_62	;
self.final_score_63	:= 	wFDN_FLA____lgt_63	;
self.final_score_64	:= 	wFDN_FLA____lgt_64	;
self.final_score_65	:= 	wFDN_FLA____lgt_65	;
self.final_score_66	:= 	wFDN_FLA____lgt_66	;
self.final_score_67	:= 	wFDN_FLA____lgt_67	;
self.final_score_68	:= 	wFDN_FLA____lgt_68	;
self.final_score_69	:= 	wFDN_FLA____lgt_69	;
self.final_score_70	:= 	wFDN_FLA____lgt_70	;
self.final_score_71	:= 	wFDN_FLA____lgt_71	;
self.final_score_72	:= 	wFDN_FLA____lgt_72	;
self.final_score_73	:= 	wFDN_FLA____lgt_73	;
self.final_score_74	:= 	wFDN_FLA____lgt_74	;
self.final_score_75	:= 	wFDN_FLA____lgt_75	;
self.final_score_76	:= 	wFDN_FLA____lgt_76	;
self.final_score_77	:= 	wFDN_FLA____lgt_77	;
self.final_score_78	:= 	wFDN_FLA____lgt_78	;
self.final_score_79	:= 	wFDN_FLA____lgt_79	;
self.final_score_80	:= 	wFDN_FLA____lgt_80	;
self.final_score_81	:= 	wFDN_FLA____lgt_81	;
self.final_score_82	:= 	wFDN_FLA____lgt_82	;
self.final_score_83	:= 	wFDN_FLA____lgt_83	;
self.final_score_84	:= 	wFDN_FLA____lgt_84	;
self.final_score_85	:= 	wFDN_FLA____lgt_85	;
self.final_score_86	:= 	wFDN_FLA____lgt_86	;
self.final_score_87	:= 	wFDN_FLA____lgt_87	;
self.final_score_88	:= 	wFDN_FLA____lgt_88	;
self.final_score_89	:= 	wFDN_FLA____lgt_89	;
self.final_score_90	:= 	wFDN_FLA____lgt_90	;
self.final_score_91	:= 	wFDN_FLA____lgt_91	;
self.final_score_92	:= 	wFDN_FLA____lgt_92	;
self.final_score_93	:= 	wFDN_FLA____lgt_93	;
self.final_score_94	:= 	wFDN_FLA____lgt_94	;
self.final_score_95	:= 	wFDN_FLA____lgt_95	;
self.final_score_96	:= 	wFDN_FLA____lgt_96	;
self.final_score_97	:= 	wFDN_FLA____lgt_97	;
self.final_score_98	:= 	wFDN_FLA____lgt_98	;
self.final_score_99	:= 	wFDN_FLA____lgt_99	;
self.final_score_100	:= 	wFDN_FLA____lgt_100	;
self.final_score_101	:= 	wFDN_FLA____lgt_101	;
self.final_score_102	:= 	wFDN_FLA____lgt_102	;
self.final_score_103	:= 	wFDN_FLA____lgt_103	;
self.final_score_104	:= 	wFDN_FLA____lgt_104	;
self.final_score_105	:= 	wFDN_FLA____lgt_105	;
self.final_score_106	:= 	wFDN_FLA____lgt_106	;
self.final_score_107	:= 	wFDN_FLA____lgt_107	;
self.final_score_108	:= 	wFDN_FLA____lgt_108	;
self.final_score_109	:= 	wFDN_FLA____lgt_109	;
self.final_score_110	:= 	wFDN_FLA____lgt_110	;
self.final_score_111	:= 	wFDN_FLA____lgt_111	;
self.final_score_112	:= 	wFDN_FLA____lgt_112	;
self.final_score_113	:= 	wFDN_FLA____lgt_113	;
self.final_score_114	:= 	wFDN_FLA____lgt_114	;
self.final_score_115	:= 	wFDN_FLA____lgt_115	;
self.final_score_116	:= 	wFDN_FLA____lgt_116	;
self.final_score_117	:= 	wFDN_FLA____lgt_117	;
self.final_score_118	:= 	wFDN_FLA____lgt_118	;
self.final_score_119	:= 	wFDN_FLA____lgt_119	;
self.final_score_120	:= 	wFDN_FLA____lgt_120	;
self.final_score_121	:= 	wFDN_FLA____lgt_121	;
self.final_score_122	:= 	wFDN_FLA____lgt_122	;
self.final_score_123	:= 	wFDN_FLA____lgt_123	;
self.final_score_124	:= 	wFDN_FLA____lgt_124	;
self.final_score_125	:= 	wFDN_FLA____lgt_125	;
self.final_score_126	:= 	wFDN_FLA____lgt_126	;
self.final_score_127	:= 	wFDN_FLA____lgt_127	;
self.final_score_128	:= 	wFDN_FLA____lgt_128	;
self.final_score_129	:= 	wFDN_FLA____lgt_129	;
self.final_score_130	:= 	wFDN_FLA____lgt_130	;
self.final_score_131	:= 	wFDN_FLA____lgt_131	;
self.final_score_132	:= 	wFDN_FLA____lgt_132	;
self.final_score_133	:= 	wFDN_FLA____lgt_133	;
self.final_score_134	:= 	wFDN_FLA____lgt_134	;
self.final_score_135	:= 	wFDN_FLA____lgt_135	;
self.final_score_136	:= 	wFDN_FLA____lgt_136	;
self.final_score_137	:= 	wFDN_FLA____lgt_137	;
self.final_score_138	:= 	wFDN_FLA____lgt_138	;
self.final_score_139	:= 	wFDN_FLA____lgt_139	;
self.final_score_140	:= 	wFDN_FLA____lgt_140	;
self.final_score_141	:= 	wFDN_FLA____lgt_141	;
self.final_score_142	:= 	wFDN_FLA____lgt_142	;
self.final_score_143	:= 	wFDN_FLA____lgt_143	;
self.final_score_144	:= 	wFDN_FLA____lgt_144	;
self.final_score_145	:= 	wFDN_FLA____lgt_145	;
self.final_score_146	:= 	wFDN_FLA____lgt_146	;
self.final_score_147	:= 	wFDN_FLA____lgt_147	;
self.final_score_148	:= 	wFDN_FLA____lgt_148	;
self.final_score_149	:= 	wFDN_FLA____lgt_149	;
self.final_score_150	:= 	wFDN_FLA____lgt_150	;
self.final_score_151	:= 	wFDN_FLA____lgt_151	;
self.final_score_152	:= 	wFDN_FLA____lgt_152	;
self.final_score_153	:= 	wFDN_FLA____lgt_153	;
self.final_score_154	:= 	wFDN_FLA____lgt_154	;
self.final_score_155	:= 	wFDN_FLA____lgt_155	;
self.final_score_156	:= 	wFDN_FLA____lgt_156	;
self.final_score_157	:= 	wFDN_FLA____lgt_157	;
self.final_score_158	:= 	wFDN_FLA____lgt_158	;
self.final_score_159	:= 	wFDN_FLA____lgt_159	;
self.final_score_160	:= 	wFDN_FLA____lgt_160	;
self.final_score_161	:= 	wFDN_FLA____lgt_161	;
self.final_score_162	:= 	wFDN_FLA____lgt_162	;
self.final_score_163	:= 	wFDN_FLA____lgt_163	;
self.final_score_164	:= 	wFDN_FLA____lgt_164	;
self.final_score_165	:= 	wFDN_FLA____lgt_165	;
self.final_score_166	:= 	wFDN_FLA____lgt_166	;
self.final_score_167	:= 	wFDN_FLA____lgt_167	;
self.final_score_168	:= 	wFDN_FLA____lgt_168	;
self.final_score_169	:= 	wFDN_FLA____lgt_169	;
self.final_score_170	:= 	wFDN_FLA____lgt_170	;
self.final_score_171	:= 	wFDN_FLA____lgt_171	;
self.final_score_172	:= 	wFDN_FLA____lgt_172	;
self.final_score_173	:= 	wFDN_FLA____lgt_173	;
self.final_score_174	:= 	wFDN_FLA____lgt_174	;
self.final_score_175	:= 	wFDN_FLA____lgt_175	;
self.final_score_176	:= 	wFDN_FLA____lgt_176	;
self.final_score_177	:= 	wFDN_FLA____lgt_177	;
self.final_score_178	:= 	wFDN_FLA____lgt_178	;
self.final_score_179	:= 	wFDN_FLA____lgt_179	;
self.final_score_180	:= 	wFDN_FLA____lgt_180	;
self.final_score_181	:= 	wFDN_FLA____lgt_181	;
self.final_score_182	:= 	wFDN_FLA____lgt_182	;
self.final_score_183	:= 	wFDN_FLA____lgt_183	;
self.final_score_184	:= 	wFDN_FLA____lgt_184	;
self.final_score_185	:= 	wFDN_FLA____lgt_185	;
self.FP3_wFDN_LGT		:= 	wFDN_FLA____lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
