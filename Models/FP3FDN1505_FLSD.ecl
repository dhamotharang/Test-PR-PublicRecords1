
export FP3FDN1505_FLSD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FL__SD_lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FL__SD_lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.08442415105) => 0.0201244909,
      (f_add_curr_nhood_VAC_pct_i > 0.08442415105) => 0.2142091661,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0437660810, 0.0437660810),
   (r_Ever_Asset_Owner_d > 0.5) => -0.0398719332,
   (r_Ever_Asset_Owner_d = NULL) => -0.0221402655, -0.0221402655),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 0.4163796803,
      (nf_vf_hi_risk_index > 6.5) => 0.0445829247,
      (nf_vf_hi_risk_index = NULL) => 0.0903425254, 0.0903425254),
   (f_inq_Communications_count_i > 0.5) => 0.4686572768,
   (f_inq_Communications_count_i = NULL) => 0.1845008635, 0.1845008635),
(f_srchvelocityrisktype_i = NULL) => 0.2544948542, -0.0016766067);

// Tree: 2 
wFDN_FL__SD_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 0.1468598042,
      (r_F00_dob_score_d > 95) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 49.65) => 0.0623351403,
         (c_fammar_p > 49.65) => -0.0404757760,
         (c_fammar_p = NULL) => -0.0704165878, -0.0335737207),
      (r_F00_dob_score_d = NULL) => -0.0016516788, -0.0265408932),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1991030806,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0215810585, -0.0215810585),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.1637828891,
   (f_hh_payday_loan_users_i > 0.5) => 0.4944548857,
   (f_hh_payday_loan_users_i = NULL) => 0.2186623485, 0.2186623485),
(f_varrisktype_i = NULL) => 0.2164417253, -0.0062388952);

// Tree: 3 
wFDN_FL__SD_lgt_3 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 1.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.25) => 0.0766104677,
      (c_famotf18_p > 31.25) => 0.4870202794,
      (c_famotf18_p = NULL) => 0.1327254821, 0.1327254821),
   (f_srchunvrfdphonecount_i > 1.5) => 0.3330834544,
   (f_srchunvrfdphonecount_i = NULL) => 0.1804106795, 0.1804106795),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => -0.0244625822,
      (f_rel_felony_count_i > 1.5) => 0.1170685012,
      (f_rel_felony_count_i = NULL) => -0.0186749761, -0.0186749761),
   (f_inq_Communications_count_i > 1.5) => 0.1731889481,
   (f_inq_Communications_count_i = NULL) => -0.0129349149, -0.0129349149),
(nf_vf_hi_risk_hit_type = NULL) => 0.1039648280, -0.0045305573);

// Tree: 4 
wFDN_FL__SD_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1474901410,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3752674679,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1814011943,
         (r_F00_input_dob_match_level_d > 4.5) => 
            map(
            (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0340088175,
            (f_srchvelocityrisktype_i > 4.5) => 0.0468510953,
            (f_srchvelocityrisktype_i = NULL) => -0.0255778595, -0.0255778595),
         (r_F00_input_dob_match_level_d = NULL) => -0.0212118814, -0.0212118814),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0190653051, -0.0190653051),
   (r_D33_Eviction_Recency_d = NULL) => -0.0130228158, -0.0130228158),
(f_srchfraudsrchcount_i > 8.5) => 0.1963042508,
(f_srchfraudsrchcount_i = NULL) => 0.1087949638, -0.0067707741);

// Tree: 5 
wFDN_FL__SD_lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.55) => -0.0212914092,
   (c_famotf18_p > 27.55) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0717663798,
      (f_rel_felony_count_i > 2.5) => 0.3605355314,
      (f_rel_felony_count_i = NULL) => 0.0864098459, 0.0864098459),
   (c_famotf18_p = NULL) => -0.0146720499, -0.0121614536),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0718118192,
   (f_assocrisktype_i > 5.5) => 0.2426501484,
   (f_assocrisktype_i = NULL) => 0.1097758924, 0.1097758924),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0684543028,
   (f_addrs_per_ssn_i > 3.5) => 0.2435336918,
   (f_addrs_per_ssn_i = NULL) => 0.0919966659, 0.0919966659), -0.0042916130);

// Tree: 6 
wFDN_FL__SD_lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0239983105,
      (f_assocrisktype_i > 8.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 116.5) => 0.3555126102,
         (r_C10_M_Hdr_FS_d > 116.5) => 0.0670735555,
         (r_C10_M_Hdr_FS_d = NULL) => 0.1017556062, 0.1017556062),
      (f_assocrisktype_i = NULL) => -0.0187228835, -0.0187228835),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.1763069603,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0140812212, -0.0140812212),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.2001677804,
   (r_I60_inq_comm_recency_d > 549) => 0.0857419542,
   (r_I60_inq_comm_recency_d = NULL) => 0.1312845716, 0.1312845716),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0615502975, -0.0088901343);

// Tree: 7 
wFDN_FL__SD_lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1438783005,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0291323492,
      (f_srchvelocityrisktype_i > 4.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0048868696,
         (f_assocrisktype_i > 3.5) => 0.1091313702,
         (f_assocrisktype_i = NULL) => 0.0409147140, 0.0409147140),
      (f_srchvelocityrisktype_i = NULL) => -0.0204426239, -0.0204426239),
   (r_F00_dob_score_d = NULL) => -0.0065484536, -0.0147855629),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 0.0996254392,
   (r_C14_addrs_5yr_i > 4.5) => 0.2705776053,
   (r_C14_addrs_5yr_i = NULL) => 0.1215106199, 0.1215106199),
(f_inq_Communications_count_i = NULL) => 0.0568350644, -0.0097557210);

// Tree: 8 
wFDN_FL__SD_lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.0972689037,
      (r_F00_dob_score_d > 92) => -0.0362385336,
      (r_F00_dob_score_d = NULL) => -0.0439674811, -0.0322622506),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 64.65) => 0.1085542712,
      (c_fammar_p > 64.65) => 0.0063164317,
      (c_fammar_p = NULL) => -0.0249021162, 0.0321578696),
   (nf_seg_FraudPoint_3_0 = '') => -0.0198508243, -0.0198508243),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0439422801,
   (f_rel_felony_count_i > 0.5) => 0.1847814810,
   (f_rel_felony_count_i = NULL) => 0.0708827180, 0.0708827180),
(f_varrisktype_i = NULL) => 0.0427753548, -0.0096771382);

// Tree: 9 
wFDN_FL__SD_lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 43.75) => 0.0948005305,
   (c_fammar_p > 43.75) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0312547775,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0114585730,
         (f_varrisktype_i > 2.5) => 0.1098085990,
         (f_varrisktype_i = NULL) => 0.0209474758, 0.0209474758),
      (f_hh_lienholders_i = NULL) => -0.0154793713, -0.0154793713),
   (c_fammar_p = NULL) => -0.0344520337, -0.0102418726),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 19.5) => 0.0822837544,
   (f_rel_count_i > 19.5) => 0.2066988466,
   (f_rel_count_i = NULL) => 0.1217750618, 0.1217750618),
(f_inq_PrepaidCards_count_i = NULL) => 0.0843599128, -0.0058209187);

// Tree: 10 
wFDN_FL__SD_lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.25) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27887) => 0.2328425589,
         (f_curraddrmedianincome_d > 27887) => 0.0307479234,
         (f_curraddrmedianincome_d = NULL) => 0.0850552924, 0.0850552924),
      (c_high_ed > 5.25) => -0.0184919523,
      (c_high_ed = NULL) => -0.0288141226, -0.0147015945),
   (r_D30_Derog_Count_i > 5.5) => 0.0901359200,
   (r_D30_Derog_Count_i = NULL) => -0.0099813607, -0.0099813607),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0481977509,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1598502858,
   (nf_seg_FraudPoint_3_0 = '') => 0.0986708146, 0.0986708146),
(f_inq_Communications_count_i = NULL) => 0.0312732216, -0.0059109940);

// Tree: 11 
wFDN_FL__SD_lgt_11 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0241842934,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0162690802,
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 4.5) => 0.3032619920,
      (f_prevaddrageoldest_d > 4.5) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 4.5) => 0.1820717265,
            (f_historical_count_d > 4.5) => 0.0064782767,
            (f_historical_count_d = NULL) => 0.1300756079, 0.1300756079),
         (r_I60_inq_comm_recency_d > 549) => 0.0616923874,
         (r_I60_inq_comm_recency_d = NULL) => 0.0791916960, 0.0791916960),
      (f_prevaddrageoldest_d = NULL) => 0.0944927926, 0.0944927926),
   (f_assocrisktype_i = NULL) => 0.0260817742, 0.0350199681),
(nf_seg_FraudPoint_3_0 = '') => -0.0071394402, -0.0071394402);

// Tree: 12 
wFDN_FL__SD_lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1968826488,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 12.05) => 
         map(
         (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1405396183,
         (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0141243580,
         (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0127365852, -0.0127365852),
      (c_unemp > 12.05) => 0.1469832820,
      (c_unemp = NULL) => -0.0169834526, -0.0109573077),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0098357774, -0.0098357774),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1527597718,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0366439030,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0840715114, 0.0840715114),
(f_srchfraudsrchcount_i = NULL) => 0.0621426108, -0.0066459510);

// Tree: 13 
wFDN_FL__SD_lgt_13 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => 
         map(
         (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 0.0697498998,
         (nf_vf_hi_risk_index > 6.5) => -0.0194670807,
         (nf_vf_hi_risk_index = NULL) => -0.0165137330, -0.0165137330),
      (f_inq_Communications_count24_i > 0.5) => 
         map(
         (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 1.5) => 0.0335232020,
         (f_assoccredbureaucount_i > 1.5) => 0.1425569307,
         (f_assoccredbureaucount_i = NULL) => 0.0671305298, 0.0671305298),
      (f_inq_Communications_count24_i = NULL) => -0.0116919822, -0.0116919822),
   (f_assocsuspicousidcount_i > 13.5) => 0.1954283343,
   (f_assocsuspicousidcount_i = NULL) => -0.0013048199, -0.0098653421),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.3154770481,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0085572010, -0.0085572010);

// Tree: 14 
wFDN_FL__SD_lgt_14 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 23.25) => 0.0667945909,
   (c_famotf18_p > 23.25) => 0.1463660776,
   (c_famotf18_p = NULL) => 0.0848137853, 0.0848137853),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0832962667,
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1608931603,
      (r_F00_dob_score_d > 55) => 
         map(
         (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => -0.0178301340,
         (f_hh_members_w_derog_i > 3.5) => 0.0812877487,
         (f_hh_members_w_derog_i = NULL) => -0.0144261207, -0.0144261207),
      (r_F00_dob_score_d = NULL) => -0.0180849734, -0.0134981710),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0111666437, -0.0111666437),
(nf_vf_hi_risk_index = NULL) => 0.0077187530, -0.0071799621);

// Tree: 15 
wFDN_FL__SD_lgt_15 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 30.65) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.0869004698,
      (r_F00_dob_score_d > 98) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0240620535,
         (f_varrisktype_i > 3.5) => 0.0484976471,
         (f_varrisktype_i = NULL) => -0.0205032671, -0.0205032671),
      (r_F00_dob_score_d = NULL) => -0.0337856946, -0.0175111819),
   (c_famotf18_p > 30.65) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 16.5) => 0.2489240157,
      (r_C21_M_Bureau_ADL_FS_d > 16.5) => 0.0525937781,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0653726693, 0.0653726693),
   (c_famotf18_p = NULL) => -0.0327714529, -0.0122398327),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1334130968,
(f_inq_PrepaidCards_count24_i = NULL) => 0.0679103891, -0.0098925661);

// Tree: 16 
wFDN_FL__SD_lgt_16 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.55) => -0.0125861165,
   (c_unemp > 8.55) => 0.0726743160,
   (c_unemp = NULL) => -0.0107246428, -0.0079275797),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 
         map(
         (NULL < f_current_count_d and f_current_count_d <= 0.5) => 0.0713899011,
         (f_current_count_d > 0.5) => -0.0275176903,
         (f_current_count_d = NULL) => 0.0271819766, 0.0271819766),
      (f_inq_HighRiskCredit_count_i > 4.5) => 0.1233820606,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0344198877, 0.0344198877),
   (r_D30_Derog_Count_i > 5.5) => 0.1431491459,
   (r_D30_Derog_Count_i = NULL) => 0.0468067652, 0.0468067652),
(f_inq_Communications_count_i = NULL) => 0.0248293972, -0.0025742807);

// Tree: 17 
wFDN_FL__SD_lgt_17 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 187.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0330362285,
      (c_housingcpi > 222.35) => 0.0213626403,
      (c_housingcpi = NULL) => -0.0195834656, -0.0195834656),
   (c_unempl > 187.5) => 0.1291610778,
   (c_unempl = NULL) => -0.0151277033, -0.0176399598),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => 0.0038463600,
   (f_assocsuspicousidcount_i > 2.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 72675.5) => 0.1477561614,
      (r_A46_Curr_AVM_AutoVal_d > 72675.5) => 0.0243943296,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0950340952, 0.0665181341),
   (f_assocsuspicousidcount_i = NULL) => 0.0315554971, 0.0315554971),
(f_srchvelocityrisktype_i = NULL) => 0.0173360693, -0.0110476124);

// Tree: 18 
wFDN_FL__SD_lgt_18 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0432847961,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= -0.5) => 0.0134232693,
         (r_pb_order_freq_d > -0.5) => -0.0225734293,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 13.5) => 0.0096773166,
            (f_rel_ageover20_count_d > 13.5) => 0.0865021426,
            (f_rel_ageover20_count_d = NULL) => 0.0883988239, 0.0293499668), 0.0047988739),
      (nf_seg_FraudPoint_3_0 = '') => -0.0114950120, -0.0114950120),
   (f_srchunvrfdaddrcount_i > 0.5) => 0.0814923039,
   (f_srchunvrfdaddrcount_i = NULL) => -0.0000833403, -0.0090850887),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1972420862,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0082717523, -0.0082717523);

// Tree: 19 
wFDN_FL__SD_lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 35.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 93.65) => 0.0674531626,
         (c_occunit_p > 93.65) => 0.2890468342,
         (c_occunit_p = NULL) => 0.1560906313, 0.1560906313),
      (r_D32_Mos_Since_Crim_LS_d > 35.5) => 0.0255415527,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0365292783, 0.0365292783),
   (f_mos_inq_banko_cm_lseen_d > 44.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1297610053,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0096225339,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0088016808, -0.0088016808),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0011513312, -0.0011513312),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1173551034,
(f_inq_PrepaidCards_count_i = NULL) => 0.0159925293, 0.0001902029);

// Tree: 20 
wFDN_FL__SD_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.0895605569,
   (r_F00_input_dob_match_level_d > 4.5) => -0.0100849627,
   (r_F00_input_dob_match_level_d = NULL) => -0.0081117841, -0.0081117841),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 10.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 10.75) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0058676709,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.0701802087,
         (nf_seg_FraudPoint_3_0 = '') => 0.0262071646, 0.0262071646),
      (c_unemp > 10.75) => 0.1681812900,
      (c_unemp = NULL) => 0.0318595302, 0.0318595302),
   (f_assocsuspicousidcount_i > 10.5) => 0.1473933351,
   (f_assocsuspicousidcount_i = NULL) => 0.0374769213, 0.0374769213),
(f_varrisktype_i = NULL) => 0.0377413128, -0.0028123648);

// Tree: 21 
wFDN_FL__SD_lgt_21 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 7.55) => -0.0119679313,
   (c_famotf18_p > 7.55) => 0.1858963151,
   (c_famotf18_p = NULL) => 0.1034528791, 0.1034528791),
(r_C21_M_Bureau_ADL_FS_d > 5.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 21.65) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 93.5) => 0.0817220108,
      (c_rest_indx > 93.5) => -0.0153728625,
      (c_rest_indx = NULL) => 0.0487463935, 0.0487463935),
   (c_white_col > 21.65) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 1.5) => -0.0152077308,
      (f_srchfraudsrchcountmo_i > 1.5) => 0.1113566630,
      (f_srchfraudsrchcountmo_i = NULL) => -0.0142943562, -0.0142943562),
   (c_white_col = NULL) => -0.0120567252, -0.0096666149),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0056926182, -0.0081014629);

// Tree: 22 
wFDN_FL__SD_lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1465535388,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0190639382,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
            map(
            (NULL < C_INC_15K_P and C_INC_15K_P <= 11.1) => 0.0154849483,
            (C_INC_15K_P > 11.1) => 0.1377151081,
            (C_INC_15K_P = NULL) => -0.0163640084, 0.0696037634),
         (r_Ever_Asset_Owner_d > 0.5) => 0.0120295721,
         (r_Ever_Asset_Owner_d = NULL) => 0.0242482707, 0.0242482707),
      (f_assocrisktype_i = NULL) => -0.0088827021, -0.0088827021),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0080962205, -0.0080962205),
(r_D33_eviction_count_i > 2.5) => 0.1342420297,
(r_D33_eviction_count_i = NULL) => -0.0028707316, -0.0065406046);

// Tree: 23 
wFDN_FL__SD_lgt_23 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 4.5) => 0.0580639886,
      (f_rel_educationover12_count_d > 4.5) => 0.2931388803,
      (f_rel_educationover12_count_d = NULL) => 0.1800368098, 0.1800368098),
   (f_util_adl_count_n > 0.5) => -0.0033168947,
   (f_util_adl_count_n = NULL) => 0.0802273336, 0.0802273336),
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.0840944942,
      (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0081252432,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0063066988, -0.0063066988),
   (r_D33_eviction_count_i > 3.5) => 0.1281925983,
   (r_D33_eviction_count_i = NULL) => -0.0054355894, -0.0054355894),
(r_F00_input_dob_match_level_d = NULL) => 0.0154576167, -0.0036208218);

// Tree: 24 
wFDN_FL__SD_lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 122) => 0.1911792428,
(r_D32_Mos_Since_Fel_LS_d > 122) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 90.5) => -0.0058839022,
   (r_pb_order_freq_d > 90.5) => -0.0369068861,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 6.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0220503786,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
            map(
            (NULL < c_finance and c_finance <= 0.85) => 0.0728049650,
            (c_finance > 0.85) => 0.0046860195,
            (c_finance = NULL) => 0.0026394164, 0.0308722743),
         (nf_seg_FraudPoint_3_0 = '') => 0.0069362033, 0.0069362033),
      (f_rel_criminal_count_i > 6.5) => 0.0946909329,
      (f_rel_criminal_count_i = NULL) => 0.0129098130, 0.0129098130), -0.0068444132),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0103647120, -0.0055589716);

// Tree: 25 
wFDN_FL__SD_lgt_25 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 0.0083136479,
   (f_historical_count_d > 0.5) => -0.0330872086,
   (f_historical_count_d = NULL) => -0.0115572270, -0.0115572270),
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1272897644) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 16.5) => 0.1625936408,
         (r_D32_Mos_Since_Crim_LS_d > 16.5) => 0.0074999641,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0139892393, 0.0139892393),
      (f_add_curr_nhood_BUS_pct_i > 0.1272897644) => 0.1311964566,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0296173844, 0.0288071431),
   (f_srchfraudsrchcountmo_i > 0.5) => 0.1411159328,
   (f_srchfraudsrchcountmo_i = NULL) => 0.0349601980, 0.0349601980),
(f_rel_felony_count_i = NULL) => 0.0079925282, -0.0047797053);

// Tree: 26 
wFDN_FL__SD_lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 0.0434184523,
      (k_inq_per_ssn_i > 3.5) => 0.1593332186,
      (k_inq_per_ssn_i = NULL) => 0.0519831034, 0.0519831034),
   (c_employees > 29.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0089412713,
      (f_assocsuspicousidcount_i > 15.5) => 0.1140102045,
      (f_assocsuspicousidcount_i = NULL) => -0.0082766688, -0.0082766688),
   (c_employees = NULL) => 0.0118008664, -0.0020016519),
(r_D30_Derog_Count_i > 11.5) => 0.1047076739,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 28.5) => -0.0769166474,
   (k_comb_age_d > 28.5) => 0.1124532977,
   (k_comb_age_d = NULL) => 0.0159117571, 0.0159117571), -0.0004022919);

// Tree: 27 
wFDN_FL__SD_lgt_27 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0616698189,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.55) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1082490074) => 0.0249711146,
         (f_add_curr_nhood_VAC_pct_i > 0.1082490074) => 
            map(
            (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 108) => 0.1769632763,
            (f_prevaddrageoldest_d > 108) => 0.0184386169,
            (f_prevaddrageoldest_d = NULL) => 0.1118161560, 0.1118161560),
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0441822904, 0.0441822904),
      (c_fammar_p > 44.55) => -0.0110068467,
      (c_fammar_p = NULL) => -0.0198228726, -0.0082054809),
   (r_D33_Eviction_Recency_d = NULL) => -0.0033988698, -0.0055449023),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1665549832,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0048664890, -0.0048664890);

// Tree: 28 
wFDN_FL__SD_lgt_28 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0977280201,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0082427504,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0076445353, -0.0076445353),
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.0700897286,
      (f_inq_PrepaidCards_count24_i = NULL) => -0.0065658509, -0.0065658509),
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 104) => 0.1716433980,
      (r_A50_pb_average_dollars_d > 104) => 0.0216602204,
      (r_A50_pb_average_dollars_d = NULL) => 0.0864011604, 0.0864011604),
   (r_D33_eviction_count_i = NULL) => -0.0102742200, -0.0055690229),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.1457159117,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0048534458, -0.0048534458);

// Tree: 29 
wFDN_FL__SD_lgt_29 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1128) => 0.2231905628,
      (c_popover25 > 1128) => -0.0149272563,
      (c_popover25 = NULL) => 0.1041316533, 0.1041316533),
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 56.5) => 0.0260461931,
      (c_ab_av_edu > 56.5) => -0.0148109068,
      (c_ab_av_edu = NULL) => -0.0168311777, -0.0097021314),
   (f_attr_arrest_recency_d = NULL) => -0.0032138785, -0.0086852886),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 175.5) => 0.0475574595,
   (c_sub_bus > 175.5) => 0.2595699371,
   (c_sub_bus = NULL) => 0.0704239870, 0.0704239870),
(k_comb_age_d = NULL) => -0.0031722732, -0.0031722732);

// Tree: 30 
wFDN_FL__SD_lgt_30 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0099645254,
(k_inq_per_ssn_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
         map(
         (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => -0.0042400629,
         (r_D34_UnRel_Lien60_Count_i > 0.5) => 0.1155167467,
         (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0051281360, 0.0051281360),
      (f_varrisktype_i > 4.5) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 367) => -0.0136140965,
         (r_A50_pb_total_dollars_d > 367) => 0.1328257001,
         (r_A50_pb_total_dollars_d = NULL) => 0.0773560802, 0.0773560802),
      (f_varrisktype_i = NULL) => 0.0157333514, 0.0157333514),
   (k_comb_age_d > 63.5) => 0.2135082538,
   (k_comb_age_d = NULL) => 0.0347959926, 0.0347959926),
(k_inq_per_ssn_i = NULL) => -0.0064500220, -0.0064500220);

// Tree: 31 
wFDN_FL__SD_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 72.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.1095920926,
      (r_F00_dob_score_d > 55) => -0.0046460684,
      (r_F00_dob_score_d = NULL) => -0.0186603404, -0.0044500939),
   (k_comb_age_d > 72.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 2.75) => 0.2083041377,
      (C_INC_150K_P > 2.75) => 0.0476088001,
      (C_INC_150K_P = NULL) => 0.0846695330, 0.0846695330),
   (k_comb_age_d = NULL) => -0.0005094543, -0.0005094543),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1577800119,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_white_col and c_white_col <= 40.35) => -0.0696688243,
   (c_white_col > 40.35) => 0.0559873175,
   (c_white_col = NULL) => -0.0062186933, -0.0062186933), 0.0001055469);

// Tree: 32 
wFDN_FL__SD_lgt_32 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.25) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 0.0203402153,
         (f_assocrisktype_i > 8.5) => 0.1167182142,
         (f_assocrisktype_i = NULL) => 0.0241377180, 0.0241377180),
      (c_unemp > 11.25) => 0.1399813533,
      (c_unemp = NULL) => 0.0599080211, 0.0283787207),
   (f_hh_members_ct_d > 1.5) => -0.0158429123,
   (f_hh_members_ct_d = NULL) => -0.0067304581, -0.0067304581),
(f_hh_collections_ct_i > 2.5) => 0.0460593445,
(f_hh_collections_ct_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0601335272,
   (r_S66_adlperssn_count_i > 1.5) => 0.0992659643,
   (r_S66_adlperssn_count_i = NULL) => 0.0172890830, 0.0172890830), -0.0015377253);

// Tree: 33 
wFDN_FL__SD_lgt_33 := map(
(NULL < c_white_col and c_white_col <= 17.95) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 139.5) => 0.0304360413,
   (c_old_homes > 139.5) => 0.1427384879,
   (c_old_homes = NULL) => 0.0648683952, 0.0648683952),
(c_white_col > 17.95) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 3305.5) => -0.0185094524,
   (r_A50_pb_total_dollars_d > 3305.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 0.1437353536,
         (r_C13_max_lres_d > 17.5) => 0.0207475134,
         (r_C13_max_lres_d = NULL) => 0.0241303408, 0.0241303408),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0605187600,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0162030893, 0.0162030893),
   (r_A50_pb_total_dollars_d = NULL) => -0.0207600421, -0.0051304137),
(c_white_col = NULL) => -0.0126217571, -0.0029725768);

// Tree: 34 
wFDN_FL__SD_lgt_34 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 3.45) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1217) => 0.0924540483,
      (c_popover18 > 1217) => -0.0882255493,
      (c_popover18 = NULL) => 0.0053795435, 0.0053795435),
   (c_rnt1250_p > 3.45) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 117.5) => 0.0802773792,
      (c_no_labfor > 117.5) => 0.2466484447,
      (c_no_labfor = NULL) => 0.1279357574, 0.1279357574),
   (c_rnt1250_p = NULL) => 0.0711080157, 0.0711080157),
(r_F00_dob_score_d > 95) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1178450110,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0051331829,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0045690627, -0.0045690627),
(r_F00_dob_score_d = NULL) => 0.0114562112, -0.0015675464);

// Tree: 35 
wFDN_FL__SD_lgt_35 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 134.5) => -0.0164085434,
      (c_easiqlife > 134.5) => 0.0159466165,
      (c_easiqlife = NULL) => -0.0036044770, -0.0050291021),
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < c_child and c_child <= 24.85) => 0.0066830823,
      (c_child > 24.85) => 0.1969480929,
      (c_child = NULL) => 0.0996032037, 0.0996032037),
   (f_hh_lienholders_i = NULL) => -0.0039298294, -0.0039298294),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 83.5) => 0.1592380868,
   (c_relig_indx > 83.5) => 0.0121709231,
   (c_relig_indx = NULL) => 0.0743456590, 0.0743456590),
(f_inq_Communications_count_i = NULL) => 0.0064563610, -0.0030946855);

// Tree: 36 
wFDN_FL__SD_lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0190065680,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 80) => 0.1350791242,
   (r_F00_dob_score_d > 80) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0049248197,
      (k_inq_per_ssn_i > 2.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 43.3) => 0.1499880408,
         (r_C12_source_profile_d > 43.3) => 
            map(
            (NULL < c_health and c_health <= 9.6) => -0.0177131002,
            (c_health > 9.6) => 0.1151816627,
            (c_health = NULL) => 0.0357503102, 0.0357503102),
         (r_C12_source_profile_d = NULL) => 0.0585143187, 0.0585143187),
      (k_inq_per_ssn_i = NULL) => 0.0123628953, 0.0123628953),
   (r_F00_dob_score_d = NULL) => 0.0023555925, 0.0137524651),
(f_hh_criminals_i = NULL) => -0.0022669837, -0.0083009205);

// Tree: 37 
wFDN_FL__SD_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0080954324,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 87.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => 0.0397170965,
      (r_C13_Curr_Addr_LRes_d > 310.5) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 1.15) => 0.4111038443,
         (c_pop_85p_p > 1.15) => 0.0810703294,
         (c_pop_85p_p = NULL) => 0.2476292996, 0.2476292996),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0508292872, 0.0508292872),
   (c_born_usa > 87.5) => 0.0000168579,
   (c_born_usa = NULL) => 0.0260671738, 0.0260671738),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0886886613,
   (r_S66_adlperssn_count_i > 1.5) => 0.1089870574,
   (r_S66_adlperssn_count_i = NULL) => 0.0083842363, 0.0083842363), 0.0026745482);

// Tree: 38 
wFDN_FL__SD_lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 9.5) => 
      map(
      (NULL < c_business and c_business <= 21.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 45) => 0.2846198271,
         (f_prevaddrlenofres_d > 45) => 0.0639502455,
         (f_prevaddrlenofres_d = NULL) => 0.1805304018, 0.1805304018),
      (c_business > 21.5) => -0.0181580787,
      (c_business = NULL) => 0.0855905860, 0.0855905860),
   (r_D32_Mos_Since_Crim_LS_d > 9.5) => 
      map(
      (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => -0.0073288637,
      (f_validationrisktype_i > 1.5) => 0.0806750716,
      (f_validationrisktype_i = NULL) => -0.0052285993, -0.0052285993),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0037491524, -0.0037491524),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1135476651,
(f_inq_PrepaidCards_count_i = NULL) => 0.0057111447, -0.0030587610);

// Tree: 39 
wFDN_FL__SD_lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0047990510,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
      map(
      (NULL < c_no_move and c_no_move <= 95.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1297574618) => -0.0121236928,
         (f_add_curr_nhood_BUS_pct_i > 0.1297574618) => 0.1300308112,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0043827361, 0.0043827361),
      (c_no_move > 95.5) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.2206649811,
         (f_inq_count_i > 2.5) => 0.0503907342,
         (f_inq_count_i = NULL) => 0.0824472550, 0.0824472550),
      (c_no_move = NULL) => 0.0265398410, 0.0265398410),
   (k_comb_age_d > 69.5) => 0.2487123865,
   (k_comb_age_d = NULL) => 0.0358821820, 0.0358821820),
(k_inq_per_ssn_i = NULL) => 0.0000820556, 0.0000820556);

// Tree: 40 
wFDN_FL__SD_lgt_40 := map(
(NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => -0.0157860038,
(f_sourcerisktype_i > 4.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 69.5) => 0.0565344870,
   (f_mos_inq_banko_cm_lseen_d > 69.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.35) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0191838476,
         (k_inq_per_ssn_i > 2.5) => 0.1230433788,
         (k_inq_per_ssn_i = NULL) => 0.0295784269, 0.0295784269),
      (c_bigapt_p > 1.35) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0334212764,
         (r_C14_Addr_Stability_v2_d > 5.5) => 0.0185062336,
         (r_C14_Addr_Stability_v2_d = NULL) => -0.0217718188, -0.0217718188),
      (c_bigapt_p = NULL) => -0.0348665306, 0.0021602198),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0110579904, 0.0110579904),
(f_sourcerisktype_i = NULL) => -0.0022118229, -0.0028729191);

// Tree: 41 
wFDN_FL__SD_lgt_41 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => -0.0057622941,
(r_pb_order_freq_d > 41.5) => -0.0308765760,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0106061788,
         (f_varrisktype_i > 3.5) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 43.5) => 0.1332567372,
            (r_C13_max_lres_d > 43.5) => 0.0128547380,
            (r_C13_max_lres_d = NULL) => 0.0630222377, 0.0630222377),
         (f_varrisktype_i = NULL) => 0.0143798331, 0.0143798331),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0555904733,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0075874827, 0.0075874827),
   (f_rel_felony_count_i > 2.5) => 0.0936544441,
   (f_rel_felony_count_i = NULL) => 0.0048570420, 0.0096616614), -0.0087866298);

// Tree: 42 
wFDN_FL__SD_lgt_42 := map(
(NULL < c_employees and c_employees <= 40.5) => 
   map(
   (NULL < c_med_inc and c_med_inc <= 67.5) => 
      map(
      (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.355) => -0.0665050849,
         (c_hhsize > 2.355) => 0.0791531964,
         (c_hhsize = NULL) => 0.0437790423, 0.0437790423),
      (f_vardobcountnew_i > 0.5) => 0.1371265504,
      (f_vardobcountnew_i = NULL) => 0.0676124486, 0.0676124486),
   (c_med_inc > 67.5) => 0.0042008851,
   (c_med_inc = NULL) => 0.0272011478, 0.0272011478),
(c_employees > 40.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0118120749,
   (f_srchcomponentrisktype_i > 3.5) => 0.0498908373,
   (f_srchcomponentrisktype_i = NULL) => -0.0000835132, -0.0095500339),
(c_employees = NULL) => -0.0372203968, -0.0056507976);

// Tree: 43 
wFDN_FL__SD_lgt_43 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 0.0471354860,
(r_I61_inq_collection_recency_d > 9) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0118249480,
   (c_housingcpi > 222.35) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 480.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 8.35) => 
            map(
            (NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 1.5) => 0.2717543481,
            (f_hh_age_30_plus_d > 1.5) => 0.0375429809,
            (f_hh_age_30_plus_d = NULL) => 0.1078921828, 0.1078921828),
         (c_hh1_p > 8.35) => 0.0066903141,
         (c_hh1_p = NULL) => 0.0165645493, 0.0165645493),
      (r_C10_M_Hdr_FS_d > 480.5) => 0.2460410897,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0218527657, 0.0218527657),
   (c_housingcpi = NULL) => -0.0023571142, -0.0035471677),
(r_I61_inq_collection_recency_d = NULL) => -0.0029007405, -0.0010414623);

// Tree: 44 
wFDN_FL__SD_lgt_44 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.55) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 19.95) => 0.0119629117,
         (C_INC_50K_P > 19.95) => 0.1015638111,
         (C_INC_50K_P = NULL) => 0.0218039317, 0.0218039317),
      (f_hh_members_ct_d > 1.5) => -0.0143820917,
      (f_hh_members_ct_d = NULL) => -0.0074026742, -0.0074026742),
   (c_hh7p_p > 7.55) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 0.1743466177,
      (f_mos_inq_banko_cm_lseen_d > 37.5) => 0.0316820952,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0526621720, 0.0526621720),
   (c_hh7p_p = NULL) => -0.0076040375, -0.0049620826),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0964095765,
(f_inq_PrepaidCards_count_i = NULL) => 0.0192963918, -0.0042932699);

// Tree: 45 
wFDN_FL__SD_lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0038478798,
   (r_D32_felony_count_i > 0.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 36.25) => 0.0036790633,
      (c_white_col > 36.25) => 0.2039155185,
      (c_white_col = NULL) => 0.0811899492, 0.0811899492),
   (r_D32_felony_count_i = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0705005520,
      (k_comb_age_d > 27.5) => 0.0869801127,
      (k_comb_age_d = NULL) => 0.0082397803, 0.0082397803), -0.0026102796),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 20.5) => 0.2289666268,
   (c_born_usa > 20.5) => 0.0392788026,
   (c_born_usa = NULL) => 0.0587895502, 0.0587895502),
(k_comb_age_d = NULL) => 0.0017508750, 0.0017508750);

// Tree: 46 
wFDN_FL__SD_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 0.85) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1005336851,
      (r_F00_dob_score_d > 92) => 0.0144683547,
      (r_F00_dob_score_d = NULL) => 0.0000340205, 0.0168133609),
   (c_finance > 0.85) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 0.1212613998,
      (f_mos_liens_unrel_SC_fseen_d > 87.5) => -0.0148600227,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0124825832, -0.0124825832),
   (c_finance = NULL) => -0.0153658692, -0.0025096514),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 132.5) => 0.0166860423,
   (c_serv_empl > 132.5) => 0.1521203528,
   (c_serv_empl = NULL) => 0.0741668834, 0.0741668834),
(r_D32_felony_count_i = NULL) => -0.0117757591, -0.0015400954);

// Tree: 47 
wFDN_FL__SD_lgt_47 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0057954044,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.1463435071,
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
         map(
         (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.0389789154,
            (f_historical_count_d > 1.5) => -0.0236228405,
            (f_historical_count_d = NULL) => 0.0036721534, 0.0036721534),
         (f_srchfraudsrchcountmo_i > 0.5) => 0.1028055710,
         (f_srchfraudsrchcountmo_i = NULL) => 0.0087468403, 0.0087468403),
      (f_hh_collections_ct_i > 4.5) => 0.1716855372,
      (f_hh_collections_ct_i = NULL) => 0.0136387642, 0.0136387642),
   (r_C12_source_profile_index_d = NULL) => 0.0199163263, 0.0199163263),
(f_rel_felony_count_i = NULL) => -0.0046036277, -0.0021011267);

// Tree: 48 
wFDN_FL__SD_lgt_48 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124975.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.2048263832,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 0.0247615402,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0296459282, 0.0296459282),
(r_A46_Curr_AVM_AutoVal_d > 124975.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1459722821,
   (r_C10_M_Hdr_FS_d > 7.5) => -0.0064964941,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0048043086, -0.0048043086),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 6.5) => -0.0378629295,
   (f_addrs_per_ssn_i > 6.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.0448359976,
      (k_estimated_income_d > 28500) => -0.0044954398,
      (k_estimated_income_d = NULL) => 0.0060042086, 0.0060042086),
   (f_addrs_per_ssn_i = NULL) => -0.0118258681, -0.0118258681), -0.0026159317);

// Tree: 49 
wFDN_FL__SD_lgt_49 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 5.5) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 97) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 18) => 0.2040799356,
      (c_hh1_p > 18) => 0.0572222229,
      (c_hh1_p = NULL) => 0.1159653080, 0.1159653080),
   (c_rest_indx > 97) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 0.5) => 0.0868601707,
      (f_util_adl_count_n > 0.5) => -0.0966535248,
      (f_util_adl_count_n = NULL) => -0.0101399255, -0.0101399255),
   (c_rest_indx = NULL) => 0.0517662800, 0.0517662800),
(r_F00_input_dob_match_level_d > 5.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0027120738,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0663353101,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0000673403, -0.0000673403),
(r_F00_input_dob_match_level_d = NULL) => -0.0004602973, 0.0011228602);

// Tree: 50 
wFDN_FL__SD_lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 235.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0163945476,
   (f_nae_nothing_found_i > 0.5) => 0.2850588833,
   (f_nae_nothing_found_i = NULL) => -0.0138374874, -0.0138374874),
(r_A50_pb_average_dollars_d > 235.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 3.75) => -0.0088615098,
      (c_unemp > 3.75) => 0.0316190031,
      (c_unemp = NULL) => -0.0119779905, 0.0138373242),
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 85.5) => 0.2427318342,
      (c_easiqlife > 85.5) => 0.0456169763,
      (c_easiqlife = NULL) => 0.0894202781, 0.0894202781),
   (f_hh_members_w_derog_i = NULL) => 0.0174222272, 0.0174222272),
(r_A50_pb_average_dollars_d = NULL) => 0.0254048012, -0.0011073989);

// Tree: 51 
wFDN_FL__SD_lgt_51 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0106053662,
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 37.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1928156894) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0173971987,
         (k_inq_per_ssn_i > 2.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 63.5) => 0.0036547236,
            (f_prevaddrlenofres_d > 63.5) => 0.1624367849,
            (f_prevaddrlenofres_d = NULL) => 0.0779782417, 0.0779782417),
         (k_inq_per_ssn_i = NULL) => -0.0013686682, -0.0013686682),
      (f_add_curr_nhood_BUS_pct_i > 0.1928156894) => 0.1765289213,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0092014801, 0.0092014801),
   (r_pb_order_freq_d > 37.5) => -0.0149049300,
   (r_pb_order_freq_d = NULL) => 0.0443295967, 0.0132951780),
(f_rel_criminal_count_i = NULL) => 0.0003540057, -0.0042298068);

// Tree: 52 
wFDN_FL__SD_lgt_52 := map(
(NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0138533657,
(c_sub_bus > 118.5) => 
   map(
   (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 33.25) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.35) => 0.0238614664,
         (r_C12_source_profile_d > 81.35) => 
            map(
            (NULL < c_bigapt_p and c_bigapt_p <= 2.85) => 0.0421209831,
            (c_bigapt_p > 2.85) => 0.3047451929,
            (c_bigapt_p = NULL) => 0.1616737950, 0.1616737950),
         (r_C12_source_profile_d = NULL) => 0.0305354281, 0.0305354281),
      (c_high_ed > 33.25) => -0.0116462978,
      (c_high_ed = NULL) => 0.0101008301, 0.0101008301),
   (f_inq_Collection_count24_i > 2.5) => 0.0916756734,
   (f_inq_Collection_count24_i = NULL) => 0.0128757843, 0.0128757843),
(c_sub_bus = NULL) => -0.0001533657, -0.0017411693);

// Tree: 53 
wFDN_FL__SD_lgt_53 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 134.5) => 
      map(
      (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0144772727,
      (r_D32_felony_count_i > 0.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 14.15) => -0.0078464088,
         (c_pop_25_34_p > 14.15) => 0.1659610663,
         (c_pop_25_34_p = NULL) => 0.0790573288, 0.0790573288),
      (r_D32_felony_count_i = NULL) => -0.0407255513, -0.0134528399),
   (c_easiqlife > 134.5) => 
      map(
      (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 0.0149077654,
      (f_attr_arrests_i > 0.5) => 0.1347345773,
      (f_attr_arrests_i = NULL) => 0.0166582984, 0.0166582984),
   (c_easiqlife = NULL) => -0.0022091154, -0.0030104772),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0899772849,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0026366202, -0.0026366202);

// Tree: 54 
wFDN_FL__SD_lgt_54 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.05) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 20.95) => -0.0071371142,
   (c_hval_500k_p > 20.95) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 0.2087535590,
      (r_I61_inq_collection_recency_d > 9) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 30.45) => 0.0141916265,
         (c_hh3_p > 30.45) => 0.1890411604,
         (c_hh3_p = NULL) => 0.0228118757, 0.0228118757),
      (r_I61_inq_collection_recency_d = NULL) => 0.0319202857, 0.0319202857),
   (c_hval_500k_p = NULL) => -0.0024560775, -0.0024560775),
(c_hh6_p > 11.05) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 33.4) => 0.1535217007,
   (c_fammar18_p > 33.4) => 0.0227618895,
   (c_fammar18_p = NULL) => 0.0539313794, 0.0539313794),
(c_hh6_p = NULL) => -0.0223030273, -0.0014369857);

// Tree: 55 
wFDN_FL__SD_lgt_55 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 2.5) => 0.0154582581,
   (f_inq_Banking_count24_i > 2.5) => 
      map(
      (NULL < c_families and c_families <= 405.5) => 0.1788821874,
      (c_families > 405.5) => 0.0144954801,
      (c_families = NULL) => 0.0937533568, 0.0937533568),
   (f_inq_Banking_count24_i = NULL) => 0.0175233403, 0.0175233403),
(k_estimated_income_d > 34500) => 
   map(
   (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => -0.0224497452,
   (f_validationrisktype_i > 1.5) => 0.1087887108,
   (f_validationrisktype_i = NULL) => -0.0206673558, -0.0206673558),
(k_estimated_income_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => -0.1005122307,
   (k_comb_age_d > 23.5) => 0.0438690991,
   (k_comb_age_d = NULL) => -0.0194560456, -0.0194560456), -0.0074154227);

// Tree: 56 
wFDN_FL__SD_lgt_56 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0825891087) => 0.0121127818,
      (f_add_curr_nhood_VAC_pct_i > 0.0825891087) => 0.0763579932,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0225375797, 0.0225375797),
   (f_hh_members_ct_d > 1.5) => -0.0086959456,
   (f_hh_members_ct_d = NULL) => -0.0027702573, -0.0027702573),
(f_inq_HighRiskCredit_count_i > 5.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 53.5) => -0.0287353088,
   (C_OWNOCC_P > 53.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 40.5) => 0.1672780547,
      (r_A50_pb_average_dollars_d > 40.5) => 0.0350809827,
      (r_A50_pb_average_dollars_d = NULL) => 0.0881460046, 0.0881460046),
   (C_OWNOCC_P = NULL) => 0.0463649016, 0.0463649016),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0057130752, -0.0018521608);

// Tree: 57 
wFDN_FL__SD_lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 241.75) => -0.0105204403,
   (c_housingcpi > 241.75) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 188.5) => -0.0150015167,
      (r_C10_M_Hdr_FS_d > 188.5) => 0.0639553475,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0235766309, 0.0235766309),
   (c_housingcpi = NULL) => -0.0214331958, -0.0051373776),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_retail and c_retail <= 16.45) => -0.0028669762,
   (c_retail > 16.45) => 0.1447084557,
   (c_retail = NULL) => 0.0522515586, 0.0522515586),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0799681126,
   (f_addrs_per_ssn_i > 3.5) => 0.0546382881,
   (f_addrs_per_ssn_i = NULL) => -0.0126649123, -0.0126649123), -0.0044459327);

// Tree: 58 
wFDN_FL__SD_lgt_58 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.6) => 0.1828817525,
   (r_C12_source_profile_d > 60.6) => -0.0269936890,
   (r_C12_source_profile_d = NULL) => 0.0655600771, 0.0655600771),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1151943594,
   (C_INC_100K_P > 1.35) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0030285481,
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0618091243,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0055260982, -0.0055260982),
      (f_hh_collections_ct_i > 5.5) => 0.1000715427,
      (f_hh_collections_ct_i = NULL) => -0.0047228751, -0.0047228751),
   (C_INC_100K_P = NULL) => -0.0189150023, -0.0045046506),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0021117111, -0.0035679135);

// Tree: 59 
wFDN_FL__SD_lgt_59 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0353751760,
   (f_addrs_per_ssn_i > 3.5) => 
      map(
      (NULL < f_validationrisktype_i and f_validationrisktype_i <= 1.5) => -0.0016989296,
      (f_validationrisktype_i > 1.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 214) => -0.0709360470,
         (r_C10_M_Hdr_FS_d > 214) => 0.1703328271,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0891475662, 0.0891475662),
      (f_validationrisktype_i = NULL) => 0.0001540052, 0.0001540052),
   (f_addrs_per_ssn_i = NULL) => -0.0058711624, -0.0058711624),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0123542158,
   (f_addrs_per_ssn_i > 5.5) => 0.2297304864,
   (f_addrs_per_ssn_i = NULL) => 0.1058731969, 0.1058731969),
(f_nae_nothing_found_i = NULL) => -0.0043559847, -0.0043559847);

// Tree: 60 
wFDN_FL__SD_lgt_60 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0097328560,
   (k_inq_per_ssn_i > 3.5) => 
      map(
      (NULL < c_food and c_food <= 36.65) => 0.0135926538,
      (c_food > 36.65) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 1.35) => -0.0191512360,
         (c_hval_175k_p > 1.35) => 0.1977761864,
         (c_hval_175k_p = NULL) => 0.0998708896, 0.0998708896),
      (c_food = NULL) => 0.0262214629, 0.0262214629),
   (k_inq_per_ssn_i = NULL) => -0.0072554215, -0.0072554215),
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2.5) => 0.0224622613,
   (f_idrisktype_i > 2.5) => 0.1954753041,
   (f_idrisktype_i = NULL) => 0.0315604875, 0.0315604875),
(f_hh_payday_loan_users_i = NULL) => -0.0110180953, -0.0036770651);

// Tree: 61 
wFDN_FL__SD_lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0162564355,
   (f_inq_Communications_count_i > 0.5) => 0.1082466065,
   (f_inq_Communications_count_i = NULL) => 0.0505642452, 0.0505642452),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 75.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.0529994805,
      (r_C10_M_Hdr_FS_d > 11.5) => -0.0061763676,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0046977132, -0.0046977132),
   (k_comb_age_d > 75.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 325.5) => 0.0338458102,
      (f_prevaddrlenofres_d > 325.5) => 0.2530135008,
      (f_prevaddrlenofres_d = NULL) => 0.0657247470, 0.0657247470),
   (k_comb_age_d = NULL) => -0.0025025349, -0.0025025349),
(r_D33_Eviction_Recency_d = NULL) => -0.0163480478, -0.0015800124);

// Tree: 62 
wFDN_FL__SD_lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0080722060,
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 1765.5) => 0.0073474578,
      (c_med_rent > 1765.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 32.5) => 0.3347766157,
         (c_born_usa > 32.5) => 0.0414815698,
         (c_born_usa = NULL) => 0.1226057314, 0.1226057314),
      (c_med_rent = NULL) => -0.0306879071, 0.0115118220),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0002875860, 0.0002875860),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 3.45) => 0.1734276819,
   (c_newhouse > 3.45) => 0.0278206820,
   (c_newhouse = NULL) => 0.0735345076, 0.0735345076),
(f_assoccredbureaucountnew_i = NULL) => 0.0303176631, 0.0019956149);

// Tree: 63 
wFDN_FL__SD_lgt_63 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 0.0060033404,
   (k_inq_per_ssn_i > 0.5) => 0.1536934676,
   (k_inq_per_ssn_i = NULL) => 0.0596585551, 0.0596585551),
(f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
   map(
   (NULL < f_mos_liens_rel_SC_fseen_d and f_mos_liens_rel_SC_fseen_d <= 273) => -0.1037474967,
   (f_mos_liens_rel_SC_fseen_d > 273) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 0.0647451311,
      (r_F00_dob_score_d > 65) => -0.0031356680,
      (r_F00_dob_score_d = NULL) => 0.0097641522, -0.0020801107),
   (f_mos_liens_rel_SC_fseen_d = NULL) => -0.0031450796, -0.0031450796),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.1) => -0.0642623564,
   (c_pop_55_64_p > 11.1) => 0.0379217432,
   (c_pop_55_64_p = NULL) => -0.0131703066, -0.0131703066), -0.0019045615);

// Tree: 64 
wFDN_FL__SD_lgt_64 := map(
(NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 39.55) => 0.0506526212,
   (c_bigapt_p > 39.55) => 0.2068841460,
   (c_bigapt_p = NULL) => -0.0286647447, 0.0500105172),
(f_corrssnnamecount_d > 1.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0083324904,
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 23.25) => 0.0354504577,
      (C_INC_15K_P > 23.25) => 0.1641396896,
      (C_INC_15K_P = NULL) => 0.0453746589, 0.0453746589),
   (k_comb_age_d = NULL) => -0.0046540436, -0.0046540436),
(f_corrssnnamecount_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => -0.1118701872,
   (k_comb_age_d > 23.5) => 0.0597275164,
   (k_comb_age_d = NULL) => -0.0269208290, -0.0269208290), -0.0013148764);

// Tree: 65 
wFDN_FL__SD_lgt_65 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 547) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.35) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 160.5) => -0.0180669003,
      (c_lar_fam > 160.5) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 844.5) => 0.1764585396,
         (c_popover18 > 844.5) => 0.0205327762,
         (c_popover18 = NULL) => 0.0531063090, 0.0531063090),
      (c_lar_fam = NULL) => -0.0140431681, -0.0140431681),
   (c_hh4_p > 12.35) => 0.0165129736,
   (c_hh4_p = NULL) => 0.0060292945, 0.0036152458),
(r_C10_M_Hdr_FS_d > 547) => 0.1514262143,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0986992884,
   (k_comb_age_d > 25.5) => 0.0651870486,
   (k_comb_age_d = NULL) => -0.0136044596, -0.0136044596), 0.0044295659);

// Tree: 66 
wFDN_FL__SD_lgt_66 := map(
(NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 775) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 207.35) => 
         map(
         (NULL < c_white_col and c_white_col <= 38.05) => 0.1541868626,
         (c_white_col > 38.05) => 0.0300326071,
         (c_white_col = NULL) => 0.0700144860, 0.0700144860),
      (c_cpiall > 207.35) => 0.0082284827,
      (c_cpiall = NULL) => -0.0126385250, 0.0115443381),
   (f_historical_count_d > 0.5) => -0.0165640087,
   (f_historical_count_d = NULL) => -0.0024641975, -0.0024641975),
(f_acc_damage_amt_total_i > 775) => 0.0821507449,
(f_acc_damage_amt_total_i = NULL) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 72.15) => -0.0625259663,
   (C_OWNOCC_P > 72.15) => 0.0661155798,
   (C_OWNOCC_P = NULL) => -0.0006790691, -0.0006790691), -0.0007017573);

// Tree: 67 
wFDN_FL__SD_lgt_67 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 10.5) => -0.0320463236,
   (f_hh_members_ct_d > 10.5) => 0.0805129119,
   (f_hh_members_ct_d = NULL) => -0.0283781921, -0.0283781921),
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 20.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 5.8) => -0.0129436342,
      (c_rnt1000_p > 5.8) => 0.1693057416,
      (c_rnt1000_p = NULL) => 0.1013022432, 0.1013022432),
   (k_comb_age_d > 20.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 7.7) => 0.1111050635,
      (c_hh2_p > 7.7) => 0.0029055879,
      (c_hh2_p = NULL) => -0.0002336104, 0.0034864580),
   (k_comb_age_d = NULL) => 0.0047542505, 0.0047542505),
(f_addrs_per_ssn_i = NULL) => -0.0009711192, -0.0009711192);

// Tree: 68 
wFDN_FL__SD_lgt_68 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0804306643,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 241.75) => -0.0070366691,
   (c_housingcpi > 241.75) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 138.5) => -0.0028449319,
      (r_C13_max_lres_d > 138.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 19.75) => 
            map(
            (NULL < c_med_yearblt and c_med_yearblt <= 1964.5) => 0.1739338866,
            (c_med_yearblt > 1964.5) => 0.0251263267,
            (c_med_yearblt = NULL) => 0.1048569362, 0.1048569362),
         (c_hh1_p > 19.75) => 0.0171474193,
         (c_hh1_p = NULL) => 0.0582493899, 0.0582493899),
      (r_C13_max_lres_d = NULL) => 0.0245985068, 0.0245985068),
   (c_housingcpi = NULL) => 0.0306001454, -0.0009150401),
(f_attr_arrest_recency_d = NULL) => -0.0218958490, -0.0004985326);

// Tree: 69 
wFDN_FL__SD_lgt_69 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1020170459,
   (f_attr_arrest_recency_d > 48) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0073752220,
         (k_inq_per_ssn_i > 10.5) => 0.0700654599,
         (k_inq_per_ssn_i = NULL) => -0.0066192730, -0.0066192730),
      (f_nae_nothing_found_i > 0.5) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 7.5) => -0.0186741242,
         (f_rel_count_i > 7.5) => 0.2056702186,
         (f_rel_count_i = NULL) => 0.0864872865, 0.0864872865),
      (f_nae_nothing_found_i = NULL) => -0.0054230110, -0.0054230110),
   (f_attr_arrest_recency_d = NULL) => -0.0049591298, -0.0049591298),
(f_srchssnsrchcount_i > 22.5) => 0.0707602430,
(f_srchssnsrchcount_i = NULL) => -0.0160534236, -0.0045673041);

// Tree: 70 
wFDN_FL__SD_lgt_70 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 155.5) => -0.0145700157,
(r_A50_pb_average_dollars_d > 155.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.38) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 0.0044396217,
      (k_comb_age_d > 68.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 117.5) => 0.0179516368,
         (c_exp_prod > 117.5) => 
            map(
            (NULL < c_for_sale and c_for_sale <= 120) => 0.2748581413,
            (c_for_sale > 120) => 0.0766644703,
            (c_for_sale = NULL) => 0.1711306125, 0.1711306125),
         (c_exp_prod = NULL) => 0.0805094628, 0.0805094628),
      (k_comb_age_d = NULL) => 0.0082043173, 0.0082043173),
   (c_hhsize > 4.38) => 0.1724584108,
   (c_hhsize = NULL) => 0.0075424767, 0.0096637225),
(r_A50_pb_average_dollars_d = NULL) => 0.0016021016, -0.0038530334);

// Tree: 71 
wFDN_FL__SD_lgt_71 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 2.05) => 0.0100534277,
   (c_hh7p_p > 2.05) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 2346.5) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
            map(
            (NULL < c_hh00 and c_hh00 <= 394.5) => 0.0878941792,
            (c_hh00 > 394.5) => -0.0194528333,
            (c_hh00 = NULL) => 0.0117274406, 0.0117274406),
         (f_rel_criminal_count_i > 2.5) => 0.0877051238,
         (f_rel_criminal_count_i = NULL) => 0.0291566196, 0.0291566196),
      (c_popover18 > 2346.5) => 0.2493074644,
      (c_popover18 = NULL) => 0.0433746950, 0.0433746950),
   (c_hh7p_p = NULL) => -0.0132264452, 0.0161206641),
(k_estimated_income_d > 34500) => -0.0072574431,
(k_estimated_income_d = NULL) => -0.0037742204, 0.0008951332);

// Tree: 72 
wFDN_FL__SD_lgt_72 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 39.85) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 22.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 0.1378459954,
         (r_F00_dob_score_d > 98) => 0.0206478160,
         (r_F00_dob_score_d = NULL) => 0.0269929403, 0.0269929403),
      (c_many_cars > 22.5) => -0.0070470938,
      (c_many_cars = NULL) => -0.0042830510, -0.0042830510),
   (c_hval_80k_p > 39.85) => -0.0936677117,
   (c_hval_80k_p = NULL) => 0.0092094646, -0.0047811548),
(f_assocsuspicousidcount_i > 15.5) => 0.0866583431,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 113.5) => -0.0840213330,
   (c_relig_indx > 113.5) => 0.0632309002,
   (c_relig_indx = NULL) => -0.0077657122, -0.0077657122), -0.0043615222);

// Tree: 73 
wFDN_FL__SD_lgt_73 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0894163528,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 186.5) => -0.0075198014,
      (c_unempl > 186.5) => 0.0826821039,
      (c_unempl = NULL) => 0.0215305370, -0.0053822385),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 3.5) => -0.0021008092,
      (f_rel_under25miles_cnt_d > 3.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 177.5) => 0.0372138622,
         (c_burglary > 177.5) => 0.1944511839,
         (c_burglary = NULL) => 0.0475365938, 0.0475365938),
      (f_rel_under25miles_cnt_d = NULL) => 0.0060651006, 0.0060651006),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0005512346, -0.0005512346),
(f_attr_arrest_recency_d = NULL) => -0.0024459191, -0.0001828806);

// Tree: 74 
wFDN_FL__SD_lgt_74 := map(
(NULL < C_INC_125K_P and C_INC_125K_P <= 0.35) => 
   map(
   (NULL < c_retired and c_retired <= 11.45) => -0.0089183390,
   (c_retired > 11.45) => 0.1768131432,
   (c_retired = NULL) => 0.0610674369, 0.0610674369),
(C_INC_125K_P > 0.35) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0143959548,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 16) => -0.0446974115,
      (f_curraddrburglaryindex_i > 16) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 19.5) => 0.0726272059,
         (r_C21_M_Bureau_ADL_FS_d > 19.5) => 0.0124084325,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0157493558, 0.0157493558),
      (f_curraddrburglaryindex_i = NULL) => 0.0083336841, 0.0083336841),
   (k_inq_per_ssn_i = NULL) => -0.0050653090, -0.0050653090),
(C_INC_125K_P = NULL) => 0.0464119249, -0.0031040672);

// Tree: 75 
wFDN_FL__SD_lgt_75 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1450) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 
      map(
      (NULL < c_employees and c_employees <= 40.5) => 
         map(
         (NULL < c_assault and c_assault <= 60.5) => -0.0754377873,
         (c_assault > 60.5) => 
            map(
            (NULL < c_robbery and c_robbery <= 130) => 0.0242774821,
            (c_robbery > 130) => 0.1271607071,
            (c_robbery = NULL) => 0.0723071509, 0.0723071509),
         (c_assault = NULL) => 0.0270684353, 0.0270684353),
      (c_employees > 40.5) => -0.0208136749,
      (c_employees = NULL) => -0.0264926359, -0.0149491904),
   (r_C14_Addr_Stability_v2_d > 4.5) => 0.0031627638,
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0033776641, -0.0033776641),
(f_liens_rel_SC_total_amt_i > 1450) => -0.1270957364,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0235622945, -0.0040638651);

// Tree: 76 
wFDN_FL__SD_lgt_76 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 98.55) => -0.0301653483,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 98.55) => 0.0091011948,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 53.9) => 
         map(
         (NULL < c_hval_20k_p and c_hval_20k_p <= 34.65) => 
            map(
            (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 0.0563813071,
            (r_I61_inq_collection_recency_d > 9) => -0.0064948300,
            (r_I61_inq_collection_recency_d = NULL) => -0.0033545459, -0.0033545459),
         (c_hval_20k_p > 34.65) => 0.1424437354,
         (c_hval_20k_p = NULL) => -0.0021738993, -0.0021738993),
      (c_rnt250_p > 53.9) => 0.1414917130,
      (c_rnt250_p = NULL) => -0.0134711397, -0.0013065224), -0.0024505754),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0877985444,
(f_inq_PrepaidCards_count_i = NULL) => 0.0225304385, -0.0018683702);

// Tree: 77 
wFDN_FL__SD_lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0147059933,
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 125) => 0.1974539227,
      (c_asian_lang > 125) => 0.0077266857,
      (c_asian_lang = NULL) => 0.0745320508, 0.0745320508),
   (f_M_Bureau_ADL_FS_noTU_d > 7.5) => 
      map(
      (NULL < c_transport and c_transport <= 31.75) => 
         map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 64.5) => 0.1115581732,
         (f_mos_liens_unrel_SC_fseen_d > 64.5) => 0.0066805724,
         (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0080269634, 0.0080269634),
      (c_transport > 31.75) => 0.1259364302,
      (c_transport = NULL) => 0.0376475535, 0.0102875978),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0116001973, 0.0116001973),
(f_util_add_curr_conv_n = NULL) => -0.0000898300, -0.0000898300);

// Tree: 78 
wFDN_FL__SD_lgt_78 := map(
(NULL < c_med_rent and c_med_rent <= 752.5) => 
   map(
   (NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 33) => -0.0193924616,
      (c_hval_40k_p > 33) => 0.0901947636,
      (c_hval_40k_p = NULL) => -0.0181080888, -0.0181080888),
   (f_srchunvrfdaddrcount_i > 0.5) => 
      map(
      (NULL < c_construction and c_construction <= 4.55) => 0.1444725162,
      (c_construction > 4.55) => -0.0060027615,
      (c_construction = NULL) => 0.0588004603, 0.0588004603),
   (f_srchunvrfdaddrcount_i = NULL) => 0.0093543056, -0.0160685721),
(c_med_rent > 752.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 15.5) => 0.0127049294,
   (f_srchssnsrchcount_i > 15.5) => 0.1069249413,
   (f_srchssnsrchcount_i = NULL) => 0.0134626116, 0.0134626116),
(c_med_rent = NULL) => -0.0116787677, -0.0011025478);

// Tree: 79 
wFDN_FL__SD_lgt_79 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0368598263) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 5.15) => 0.1634340910,
      (c_pop_55_64_p > 5.15) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 116.5) => 0.0155670426,
         (f_curraddrmurderindex_i > 116.5) => 
            map(
            (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.15) => 0.0133606844,
            (c_pop_45_54_p > 12.15) => 0.1848849845,
            (c_pop_45_54_p = NULL) => 0.1088056578, 0.1088056578),
         (f_curraddrmurderindex_i = NULL) => 0.0394053690, 0.0394053690),
      (c_pop_55_64_p = NULL) => 0.0520379240, 0.0520379240),
   (f_add_curr_nhood_BUS_pct_i > 0.0368598263) => -0.0036298313,
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0292153563, 0.0207844595),
(r_I60_inq_comm_recency_d > 549) => -0.0071180822,
(r_I60_inq_comm_recency_d = NULL) => -0.0004118646, -0.0044838849);

// Tree: 80 
wFDN_FL__SD_lgt_80 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 47.8) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 1523.5) => -0.0041223102,
   (c_med_rent > 1523.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 18.65) => 
         map(
         (NULL < c_retail and c_retail <= 29.4) => -0.0039691366,
         (c_retail > 29.4) => 0.2512556105,
         (c_retail = NULL) => 0.0148076159, 0.0148076159),
      (c_pop_45_54_p > 18.65) => 0.1386177768,
      (c_pop_45_54_p = NULL) => 0.0483728333, 0.0483728333),
   (c_med_rent = NULL) => 0.0001828132, 0.0001828132),
(c_hval_100k_p > 47.8) => 0.1204156294,
(c_hval_100k_p = NULL) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => -0.0049069802,
   (f_srchfraudsrchcountyr_i > 0.5) => 0.1410162940,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0180175221, 0.0180175221), 0.0013509923);

// Tree: 81 
wFDN_FL__SD_lgt_81 := map(
(NULL < c_med_hval and c_med_hval <= 395060.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 9.5) => 
      map(
      (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0190681546,
      (f_inq_Other_count_i > 0.5) => 
         map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 0.1448121072,
         (f_mos_liens_unrel_SC_fseen_d > 66.5) => 0.0110545562,
         (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0142768685, 0.0142768685),
      (f_inq_Other_count_i = NULL) => -0.0116756094, -0.0116756094),
   (f_srchfraudsrchcountyr_i > 9.5) => -0.1109812320,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0114576086, -0.0121970853),
(c_med_hval > 395060.5) => 
   map(
   (NULL < c_trailer and c_trailer <= 166.5) => 0.0155434305,
   (c_trailer > 166.5) => 0.2314254562,
   (c_trailer = NULL) => 0.0195323815, 0.0195323815),
(c_med_hval = NULL) => 0.0422344435, -0.0041411613);

// Tree: 82 
wFDN_FL__SD_lgt_82 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 42.1) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0045906031,
      (f_inq_HighRiskCredit_count_i > 2.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0402763889,
         (f_mos_inq_banko_cm_fseen_d > 46.5) => 0.0893792032,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0412985878, 0.0412985878),
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0036694417, -0.0036694417),
   (r_I60_inq_hiRiskCred_count12_i > 2.5) => -0.0617320506,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0206881122, -0.0040781758),
(c_hval_500k_p > 42.1) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 152.5) => 0.2022848394,
   (c_asian_lang > 152.5) => 0.0133985491,
   (c_asian_lang = NULL) => 0.0904566377, 0.0904566377),
(c_hval_500k_p = NULL) => -0.0128746492, -0.0027924228);

// Tree: 83 
wFDN_FL__SD_lgt_83 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 4.5) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 13.6) => 0.0021768918,
   (c_lowrent > 13.6) => 0.1703822121,
   (c_lowrent = NULL) => 0.0800497253, 0.0800497253),
(r_D32_Mos_Since_Crim_LS_d > 4.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 63.35) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => 0.0129440666,
         (f_util_adl_count_n > 7.5) => 0.0886970995,
         (f_util_adl_count_n = NULL) => 0.0166705655, 0.0166705655),
      (k_estimated_income_d > 34500) => -0.0062531220,
      (k_estimated_income_d = NULL) => 0.0013142912, 0.0013142912),
   (c_low_hval > 63.35) => -0.0671165927,
   (c_low_hval = NULL) => -0.0018565734, 0.0004710567),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0046202455, 0.0011087056);

// Tree: 84 
wFDN_FL__SD_lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 309.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 77.45) => 0.0008825400,
   (c_low_ed > 77.45) => -0.0580945390,
   (c_low_ed = NULL) => -0.0090101436, -0.0010044382),
(r_C13_Curr_Addr_LRes_d > 309.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 0.5) => 0.0323938961,
   (f_srchunvrfdphonecount_i > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 3.5) => 0.3249711340,
      (f_inq_count_i > 3.5) => 0.0207028810,
      (f_inq_count_i = NULL) => 0.1713307290, 0.1713307290),
   (f_srchunvrfdphonecount_i = NULL) => 0.0517759681, 0.0517759681),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0940081937,
   (k_comb_age_d > 25.5) => 0.1017188270,
   (k_comb_age_d = NULL) => 0.0075482793, 0.0075482793), 0.0020794879);

// Tree: 85 
wFDN_FL__SD_lgt_85 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 5.05) => -0.0140019303,
(c_femdiv_p > 5.05) => 
   map(
   (NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 5.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 10.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 11.2) => 0.0134561960,
         (c_unemp > 11.2) => 
            map(
            (NULL < c_child and c_child <= 25.45) => 0.0090020114,
            (c_child > 25.45) => 0.1579503299,
            (c_child = NULL) => 0.0806117799, 0.0806117799),
         (c_unemp = NULL) => 0.0149784673, 0.0149784673),
      (f_inq_count24_i > 10.5) => -0.0868765976,
      (f_inq_count24_i = NULL) => 0.0131043690, 0.0131043690),
   (f_hh_age_30_plus_d > 5.5) => -0.0841104198,
   (f_hh_age_30_plus_d = NULL) => 0.0105130543, 0.0105130543),
(c_femdiv_p = NULL) => 0.0139111549, -0.0039426711);

// Tree: 86 
wFDN_FL__SD_lgt_86 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 
         map(
         (NULL < c_work_home and c_work_home <= 191.5) => 0.0000383228,
         (c_work_home > 191.5) => 0.1903567797,
         (c_work_home = NULL) => 0.0079784382, 0.0079784382),
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < c_burglary and c_burglary <= 22.5) => 0.1907208580,
         (c_burglary > 22.5) => 0.0398935410,
         (c_burglary = NULL) => 0.0580625082, 0.0580625082),
      (nf_seg_FraudPoint_3_0 = '') => 0.0224521717, 0.0224521717),
   (f_hh_members_ct_d > 1.5) => -0.0042825722,
   (f_hh_members_ct_d = NULL) => 0.0009062629, 0.0009062629),
(r_D31_ALL_Bk_i > 1.5) => -0.0359436013,
(r_D31_ALL_Bk_i = NULL) => -0.0081076056, -0.0024278792);

// Tree: 87 
wFDN_FL__SD_lgt_87 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 24.55) => -0.0103026724,
   (c_famotf18_p > 24.55) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 31.95) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 74.2) => 0.0134124144,
         (c_low_ed > 74.2) => -0.0717900630,
         (c_low_ed = NULL) => 0.0017506228, 0.0017506228),
      (c_rnt1000_p > 31.95) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 109.5) => 0.1289062551,
         (c_relig_indx > 109.5) => 0.0086366342,
         (c_relig_indx = NULL) => 0.0857586792, 0.0857586792),
      (c_rnt1000_p = NULL) => 0.0225761494, 0.0225761494),
   (c_famotf18_p = NULL) => -0.0018131011, -0.0063945620),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0902948216,
(r_S65_SSN_Prior_DoB_i = NULL) => -0.0060134450, -0.0060134450);

// Tree: 88 
wFDN_FL__SD_lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 5.6) => 0.0002607857,
   (c_hval_300k_p > 5.6) => 0.1516831085,
   (c_hval_300k_p = NULL) => 0.0546351652, 0.0546351652),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 74.8) => -0.0005860919,
   (c_rnt1000_p > 74.8) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1740034562) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 122.5) => -0.0556567107,
         (c_many_cars > 122.5) => 0.3086771228,
         (c_many_cars = NULL) => 0.1150222023, 0.1150222023),
      (f_add_curr_nhood_MFD_pct_i > 0.1740034562) => 0.2469078926,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0319248848, 0.1050322247),
   (c_rnt1000_p = NULL) => -0.0144501049, 0.0010123270),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0317779080, 0.0017362277);

// Tree: 89 
wFDN_FL__SD_lgt_89 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 19.95) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 7.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 51) => 0.0116116898,
         (c_hval_750k_p > 51) => 0.1689609478,
         (c_hval_750k_p = NULL) => 0.0162716486, 0.0162716486),
      (f_rel_homeover500_count_d > 7.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 52.5) => 0.3012557095,
         (k_comb_age_d > 52.5) => -0.0188980221,
         (k_comb_age_d = NULL) => 0.1473356462, 0.1473356462),
      (f_rel_homeover500_count_d = NULL) => 0.0213125716, 0.0213125716),
   (r_C14_addrs_10yr_i > 0.5) => -0.0064003396,
   (r_C14_addrs_10yr_i = NULL) => 0.0249530692, 0.0003919169),
(c_hval_80k_p > 19.95) => -0.0407308725,
(c_hval_80k_p = NULL) => 0.0071257532, -0.0019307715);

// Tree: 90 
wFDN_FL__SD_lgt_90 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 32.25) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => -0.0084791801,
      (k_comb_age_d > 73.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 197.15) => 
            map(
            (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.045430726) => 0.1441414820,
            (f_add_curr_nhood_MFD_pct_i > 0.045430726) => -0.0263877579,
            (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0233829485, 0.0271950192),
         (c_oldhouse > 197.15) => 0.1853289655,
         (c_oldhouse = NULL) => 0.0458428903, 0.0458428903),
      (k_comb_age_d = NULL) => -0.0063778611, -0.0063778611),
   (c_hval_60k_p > 32.25) => -0.0963263313,
   (c_hval_60k_p = NULL) => -0.0071588192, -0.0071588192),
(C_INC_50K_P > 19.85) => 0.0275326123,
(C_INC_50K_P = NULL) => 0.0022050052, -0.0033154821);

// Tree: 91 
wFDN_FL__SD_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_health and c_health <= 5.15) => 0.1290453793,
   (c_health > 5.15) => 0.0233598461,
   (c_health = NULL) => 0.0653377448, 0.0653377448),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 5.55) => -0.0179024359,
   (c_incollege > 5.55) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0020889190,
      (f_srchfraudsrchcountmo_i > 0.5) => 0.0699493770,
      (f_srchfraudsrchcountmo_i = NULL) => 0.0045148069, 0.0045148069),
   (c_incollege = NULL) => -0.0013594139, -0.0060489046),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 12.25) => -0.0460121672,
   (c_rnt1000_p > 12.25) => 0.0694660911,
   (c_rnt1000_p = NULL) => 0.0122986365, 0.0122986365), -0.0046787273);

// Tree: 92 
wFDN_FL__SD_lgt_92 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 40.6) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 28.5) => -0.0325119494,
      (f_mos_inq_banko_om_fseen_d > 28.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.1014748728,
         (r_D33_Eviction_Recency_d > 30) => 
            map(
            (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 6.5) => 0.0069573631,
            (r_C14_addrs_15yr_i > 6.5) => -0.0357729930,
            (r_C14_addrs_15yr_i = NULL) => 0.0028037673, 0.0028037673),
         (r_D33_Eviction_Recency_d = NULL) => 0.0035494812, 0.0035494812),
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0008583739, 0.0008583739),
   (c_hh3_p > 40.6) => 0.1381842144,
   (c_hh3_p = NULL) => -0.0168861009, 0.0010113383),
(f_assocsuspicousidcount_i > 15.5) => 0.0807364843,
(f_assocsuspicousidcount_i = NULL) => -0.0141878503, 0.0013500287);

// Tree: 93 
wFDN_FL__SD_lgt_93 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 
   map(
   (NULL < c_employees and c_employees <= 20.5) => 0.0422428512,
   (c_employees > 20.5) => -0.0107617903,
   (c_employees = NULL) => -0.0060513103, -0.0070162937),
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 6.45) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 4.5) => 
         map(
         (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 7.5) => 0.0259237360,
         (f_inq_HighRiskCredit_count_i > 7.5) => 0.1023533537,
         (f_inq_HighRiskCredit_count_i = NULL) => 0.0274947740, 0.0274947740),
      (f_inq_QuizProvider_count_i > 4.5) => 0.1906122975,
      (f_inq_QuizProvider_count_i = NULL) => 0.0312307285, 0.0312307285),
   (c_unemp > 6.45) => -0.0213232961,
   (c_unemp = NULL) => 0.0441518852, 0.0217156881),
(f_hh_collections_ct_i = NULL) => 0.0050939472, 0.0011739272);

// Tree: 94 
wFDN_FL__SD_lgt_94 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 28.5) => -0.1111361276,
(f_mos_liens_unrel_OT_fseen_d > 28.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 19.25) => 0.0138622350,
      (C_INC_50K_P > 19.25) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 535) => 0.1702083995,
         (f_mos_inq_banko_cm_fseen_d > 535) => 0.0441591814,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0809235367, 0.0809235367),
      (C_INC_50K_P = NULL) => 0.0135205604, 0.0227405487),
   (f_hh_members_ct_d > 1.5) => -0.0014370124,
   (f_hh_members_ct_d = NULL) => 0.0031186571, 0.0031186571),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0625149459,
   (c_rnt1000_p > 10.8) => 0.0673910596,
   (c_rnt1000_p = NULL) => -0.0018112050, -0.0018112050), 0.0023373266);

// Tree: 95 
wFDN_FL__SD_lgt_95 := map(
(NULL < c_incollege and c_incollege <= 5.95) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => -0.0136080347,
   (f_srchfraudsrchcountyr_i > 5.5) => -0.1022610114,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0145119581, -0.0145119581),
(c_incollege > 5.95) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 10.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 19.05) => -0.0229055027,
         (c_hh4_p > 19.05) => 0.0329475620,
         (c_hh4_p = NULL) => -0.0064934548, -0.0064934548),
      (f_rel_criminal_count_i > 2.5) => 0.0345682320,
      (f_rel_criminal_count_i = NULL) => 0.0035367704, 0.0035367704),
   (f_srchfraudsrchcount_i > 10.5) => 0.0687771612,
   (f_srchfraudsrchcount_i = NULL) => 0.0049870566, 0.0049870566),
(c_incollege = NULL) => 0.0129560990, -0.0048300024);

// Tree: 96 
wFDN_FL__SD_lgt_96 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00478183075) => -0.0380161325,
   (f_add_curr_nhood_BUS_pct_i > 0.00478183075) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 2) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 281067.5) => 
            map(
            (NULL < c_med_age and c_med_age <= 37.95) => 0.1203095117,
            (c_med_age > 37.95) => 0.0142116322,
            (c_med_age = NULL) => 0.0770257997, 0.0770257997),
         (f_prevaddrmedianvalue_d > 281067.5) => -0.0396568081,
         (f_prevaddrmedianvalue_d = NULL) => 0.0383879015, 0.0383879015),
      (r_I60_inq_recency_d > 2) => -0.0015670799,
      (r_I60_inq_recency_d = NULL) => 0.0007237177, 0.0007237177),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0317598392, -0.0049051516),
(f_assoccredbureaucountmo_i > 0.5) => 0.1226865241,
(f_assoccredbureaucountmo_i = NULL) => 0.0110221548, -0.0040993824);

// Tree: 97 
wFDN_FL__SD_lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => -0.0041863356,
   (f_assoccredbureaucountnew_i > 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 9.5) => -0.0263690216,
      (f_rel_count_i > 9.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 77.5) => 0.1865501351,
         (c_exp_prod > 77.5) => 0.0460235966,
         (c_exp_prod = NULL) => 0.0965727112, 0.0965727112),
      (f_rel_count_i = NULL) => 0.0489996059, 0.0489996059),
   (f_assoccredbureaucountnew_i = NULL) => -0.0032045727, -0.0032045727),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 14.5) => 0.1159668533,
   (f_rel_educationover8_count_d > 14.5) => -0.0149015297,
   (f_rel_educationover8_count_d = NULL) => 0.0557258516, 0.0557258516),
(r_D33_eviction_count_i = NULL) => 0.0110824407, -0.0025041950);

// Tree: 98 
wFDN_FL__SD_lgt_98 := map(
(NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => -0.0074055289,
(f_rel_ageover30_count_d > 13.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 165.5) => -0.0165500583,
      (c_retired2 > 165.5) => 0.1502136862,
      (c_retired2 = NULL) => -0.0050595373, -0.0050595373),
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 11.5) => 0.2419936653,
      (f_fp_prevaddrburglaryindex_i > 11.5) => 0.0276943128,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0434227056, 0.0434227056),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0146905702, 0.0146905702),
(f_rel_ageover30_count_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 0.1039312570,
   (c_bigapt_p > 1.3) => -0.0230813344,
   (c_bigapt_p = NULL) => 0.0279949034, 0.0279949034), -0.0033413027);

// Tree: 99 
wFDN_FL__SD_lgt_99 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 116.5) => 0.0815217202,
(r_D32_Mos_Since_Fel_LS_d > 116.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0252906752,
      (f_util_add_curr_conv_n > 0.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 31.45) => 
            map(
            (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 12.5) => 0.0207312097,
            (f_srchssnsrchcount_i > 12.5) => 0.1212738424,
            (f_srchssnsrchcount_i = NULL) => 0.0229360920, 0.0229360920),
         (c_newhouse > 31.45) => -0.0247862309,
         (c_newhouse = NULL) => 0.0077988141, 0.0077988141),
      (f_util_add_curr_conv_n = NULL) => -0.0065601646, -0.0065601646),
   (r_C14_Addr_Stability_v2_d > 5.5) => 0.0131351163,
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0018574710, 0.0018574710),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0143923178, 0.0023853168);

// Tree: 100 
wFDN_FL__SD_lgt_100 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 32.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0176787705,
   (c_hh4_p > 11.55) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 173.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.2) => 0.1565952638,
         (r_C12_source_profile_d > 60.2) => 0.0105882030,
         (r_C12_source_profile_d = NULL) => 0.0628791038, 0.0628791038),
      (f_mos_liens_unrel_SC_fseen_d > 173.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 9.5) => 0.0056312675,
         (k_inq_per_ssn_i > 9.5) => 0.0942037035,
         (k_inq_per_ssn_i = NULL) => 0.0067353217, 0.0067353217),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0083765063, 0.0083765063),
   (c_hh4_p = NULL) => -0.0078958162, -0.0016813506),
(f_rel_count_i > 32.5) => -0.0473389891,
(f_rel_count_i = NULL) => 0.0291455111, -0.0030353624);

// Tree: 101 
wFDN_FL__SD_lgt_101 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 41.85) => 
   map(
   (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 0.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 0.0015582455,
      (f_nae_nothing_found_i > 0.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 106) => -0.0418338714,
         (c_easiqlife > 106) => 0.2006188580,
         (c_easiqlife = NULL) => 0.0853266510, 0.0853266510),
      (f_nae_nothing_found_i = NULL) => 0.0026706974, 0.0026706974),
   (f_inq_Auto_count_i > 0.5) => 
      map(
      (NULL < c_highinc and c_highinc <= 3.65) => -0.0936097162,
      (c_highinc > 3.65) => -0.0202515570,
      (c_highinc = NULL) => -0.0290384686, -0.0290384686),
   (f_inq_Auto_count_i = NULL) => 0.0074954440, -0.0010477401),
(c_hval_60k_p > 41.85) => -0.1019227583,
(c_hval_60k_p = NULL) => 0.0198446905, -0.0010085631);

// Tree: 102 
wFDN_FL__SD_lgt_102 := map(
(NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 1.15) => -0.0081302196,
   (c_hh7p_p > 1.15) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 10.55) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 803529.5) => 0.0091747452,
         (f_prevaddrmedianvalue_d > 803529.5) => 0.2168563919,
         (f_prevaddrmedianvalue_d = NULL) => 0.0121344460, 0.0121344460),
      (c_femdiv_p > 10.55) => 0.1325852504,
      (c_femdiv_p = NULL) => 0.0156899591, 0.0156899591),
   (c_hh7p_p = NULL) => -0.0002782900, -0.0005539798),
(f_addrs_per_ssn_c6_i > 1.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 98.5) => 0.0021211832,
   (f_prevaddrcartheftindex_i > 98.5) => 0.1892321693,
   (f_prevaddrcartheftindex_i = NULL) => 0.0740869471, 0.0740869471),
(f_addrs_per_ssn_c6_i = NULL) => 0.0005228266, 0.0005228266);

// Tree: 103 
wFDN_FL__SD_lgt_103 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 195.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0007256373,
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0525903567,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0014920501, -0.0014920501),
      (f_rel_felony_count_i > 4.5) => 0.0810888179,
      (f_rel_felony_count_i = NULL) => -0.0010423656, -0.0010423656),
   (f_prevaddrmurderindex_i > 195.5) => -0.0795392823,
   (f_prevaddrmurderindex_i = NULL) => -0.0023040913, -0.0023040913),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0945496738,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => -0.0723151136,
   (k_comb_age_d > 27.5) => 0.0405143919,
   (k_comb_age_d = NULL) => -0.0143476612, -0.0143476612), -0.0018654734);

// Tree: 104 
wFDN_FL__SD_lgt_104 := map(
(NULL < c_serv_empl and c_serv_empl <= 198.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 6.5) => 0.1010193122,
   (r_C13_max_lres_d > 6.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.12825735025) => -0.0132383509,
         (f_add_curr_nhood_BUS_pct_i > 0.12825735025) => 0.0319782257,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0137785573, -0.0069952029),
      (r_C14_Addr_Stability_v2_d > 5.5) => 0.0105148197,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0005262298, 0.0005262298),
   (r_C13_max_lres_d = NULL) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 25.65) => 0.0409782943,
      (c_lowinc > 25.65) => -0.0804440903,
      (c_lowinc = NULL) => -0.0197328980, -0.0197328980), 0.0009987562),
(c_serv_empl > 198.5) => 0.1248987666,
(c_serv_empl = NULL) => -0.0004402254, 0.0016962616);

// Tree: 105 
wFDN_FL__SD_lgt_105 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
   map(
   (NULL < c_larceny and c_larceny <= 54.5) => -0.0204806141,
   (c_larceny > 54.5) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
         map(
         (NULL < c_professional and c_professional <= 2.85) => 0.0844364110,
         (c_professional > 2.85) => 
            map(
            (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 188834.5) => 0.1059924831,
            (r_A46_Curr_AVM_AutoVal_d > 188834.5) => -0.0381151125,
            (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0148622129, 0.0077049638),
         (c_professional = NULL) => 0.0463836215, 0.0463836215),
      (f_historical_count_d > 0.5) => 0.0040462755,
      (f_historical_count_d = NULL) => 0.0240793077, 0.0240793077),
   (c_larceny = NULL) => -0.0118010097, 0.0113301256),
(k_estimated_income_d > 32500) => -0.0090637488,
(k_estimated_income_d = NULL) => -0.0283177688, -0.0032800277);

// Tree: 106 
wFDN_FL__SD_lgt_106 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => -0.0034759264,
      (c_hval_500k_p > 50.85) => 0.1098757472,
      (c_hval_500k_p = NULL) => -0.0026609858, -0.0026609858),
   (f_historical_count_d > 16.5) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 124.5) => -0.0216283529,
      (c_blue_empl > 124.5) => 0.2978546253,
      (c_blue_empl = NULL) => 0.1395786544, 0.1395786544),
   (f_historical_count_d = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 8.85) => -0.0592391164,
      (c_rnt1000_p > 8.85) => 0.0660660467,
      (c_rnt1000_p = NULL) => 0.0027931426, 0.0027931426), -0.0013568685),
(c_hh6_p > 17.35) => -0.1206383775,
(c_hh6_p = NULL) => -0.0282448495, -0.0026376309);

// Tree: 107 
wFDN_FL__SD_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0733296260,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.95) => -0.0094187449,
      (c_pop_45_54_p > 13.95) => 0.1423552628,
      (c_pop_45_54_p = NULL) => 0.0649802785, 0.0649802785),
   (r_F00_dob_score_d > 65) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 3.75) => 
         map(
         (NULL < c_young and c_young <= 16.2) => -0.0639991885,
         (c_young > 16.2) => 0.0719626685,
         (c_young = NULL) => 0.0405868553, 0.0405868553),
      (C_INC_100K_P > 3.75) => -0.0031044516,
      (C_INC_100K_P = NULL) => 0.0128674581, -0.0016925699),
   (r_F00_dob_score_d = NULL) => -0.0261273699, -0.0019650380),
(f_attr_arrest_recency_d = NULL) => -0.0010366386, -0.0014187392);

// Tree: 108 
wFDN_FL__SD_lgt_108 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0081291095) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1319420526) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 28.2) => 0.0143218636,
      (C_INC_75K_P > 28.2) => 0.2483906484,
      (C_INC_75K_P = NULL) => 0.0263799525, 0.0263799525),
   (f_add_curr_nhood_BUS_pct_i > 0.1319420526) => 0.1968276993,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0362539435, 0.0362539435),
(f_add_curr_nhood_MFD_pct_i > 0.0081291095) => 0.0056453371,
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0277970066,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 80.05) => 0.1861486879,
      (c_fammar_p > 80.05) => -0.0178539078,
      (c_fammar_p = NULL) => 0.0700496497, 0.0700496497),
   (f_util_adl_count_n = NULL) => -0.0068508575, -0.0212997636), 0.0028237052);

// Tree: 109 
wFDN_FL__SD_lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0089401579,
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.65) => 
      map(
      (NULL < c_assault and c_assault <= 72.5) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 124.5) => 0.1398943104,
         (c_lux_prod > 124.5) => 0.0102165349,
         (c_lux_prod = NULL) => 0.0732375099, 0.0732375099),
      (c_assault > 72.5) => -0.0556663779,
      (c_assault = NULL) => 0.0184880092, 0.0184880092),
   (c_vacant_p > 6.65) => -0.0611859768,
   (c_vacant_p = NULL) => -0.0310039780, -0.0310039780),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 30.5) => -0.0585102936,
   (k_comb_age_d > 30.5) => 0.0551917651,
   (k_comb_age_d = NULL) => -0.0022112160, -0.0022112160), 0.0072845941);

// Tree: 110 
wFDN_FL__SD_lgt_110 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 376.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 386.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 28.75) => 0.1303202011,
      (c_civ_emp > 28.75) => 0.0013665595,
      (c_civ_emp = NULL) => -0.0044230801, 0.0018732691),
   (r_C10_M_Hdr_FS_d > 386.5) => -0.0465512645,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0019746658, -0.0019746658),
(r_C13_max_lres_d > 376.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 9.15) => 0.2252965080,
   (c_pop_35_44_p > 9.15) => 0.0190650763,
   (c_pop_35_44_p = NULL) => 0.0523154415, 0.0523154415),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 1.8) => 0.0211522144,
   (c_highrent > 1.8) => -0.0879995727,
   (c_highrent = NULL) => -0.0328938161, -0.0328938161), 0.0000120512);

// Tree: 111 
wFDN_FL__SD_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1867813055,
   (r_C12_source_profile_d > 57.95) => -0.0266874312,
   (r_C12_source_profile_d = NULL) => 0.0726003533, 0.0726003533),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0045288436,
      (k_inq_per_ssn_i > 1.5) => 0.0197792260,
      (k_inq_per_ssn_i = NULL) => 0.0004699059, 0.0004699059),
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 95.5) => 0.1492792255,
      (c_lux_prod > 95.5) => 0.0030463734,
      (c_lux_prod = NULL) => 0.0710616534, 0.0710616534),
   (f_hh_lienholders_i = NULL) => 0.0012060034, 0.0012060034),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0052423925, 0.0018868047);

// Tree: 112 
wFDN_FL__SD_lgt_112 := map(
(NULL < c_easiqlife and c_easiqlife <= 95.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 4.5) => 0.1324798068,
   (c_no_teens > 4.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 18.55) => -0.0900896548,
      (c_fammar_p > 18.55) => -0.0173705109,
      (c_fammar_p = NULL) => -0.0183930715, -0.0183930715),
   (c_no_teens = NULL) => -0.0157953509, -0.0157953509),
(c_easiqlife > 95.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 2.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 224.4) => 0.0244154612,
      (c_cpiall > 224.4) => 0.1577403498,
      (c_cpiall = NULL) => 0.0469140362, 0.0469140362),
   (f_corrssnnamecount_d > 2.5) => 0.0054748524,
   (f_corrssnnamecount_d = NULL) => 0.0180372360, 0.0097315338),
(c_easiqlife = NULL) => 0.0131841156, 0.0009297796);

// Tree: 113 
wFDN_FL__SD_lgt_113 := map(
(NULL < f_mos_liens_rel_OT_lseen_d and f_mos_liens_rel_OT_lseen_d <= 238) => -0.0638835423,
(f_mos_liens_rel_OT_lseen_d > 238) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 187) => -0.0035289948,
   (c_totcrime > 187) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 100.5) => 
         map(
         (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 
            map(
            (NULL < C_INC_50K_P and C_INC_50K_P <= 13.25) => 0.0938881305,
            (C_INC_50K_P > 13.25) => 0.2462845130,
            (C_INC_50K_P = NULL) => 0.1715516716, 0.1715516716),
         (r_C20_email_domain_free_count_i > 0.5) => -0.0048172738,
         (r_C20_email_domain_free_count_i = NULL) => 0.1005986476, 0.1005986476),
      (c_rest_indx > 100.5) => -0.0315054993,
      (c_rest_indx = NULL) => 0.0318171496, 0.0318171496),
   (c_totcrime = NULL) => 0.0289338662, -0.0016923321),
(f_mos_liens_rel_OT_lseen_d = NULL) => 0.0358520798, -0.0028192580);

// Tree: 114 
wFDN_FL__SD_lgt_114 := map(
(NULL < c_rich_blk and c_rich_blk <= 181.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => -0.0172253666,
   (f_prevaddrageoldest_d > 134.5) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0009214019,
      (f_srchunvrfddobcount_i > 0.5) => 0.1581490629,
      (f_srchunvrfddobcount_i = NULL) => 0.0039377599, 0.0039377599),
   (f_prevaddrageoldest_d = NULL) => -0.0242498239, -0.0098624432),
(c_rich_blk > 181.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 28.6) => 0.0140727647,
   (C_INC_15K_P > 28.6) => 0.1602437467,
   (C_INC_15K_P = NULL) => 0.0185420213, 0.0185420213),
(c_rich_blk = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0265979732,
   (f_vardobcountnew_i > 0.5) => 0.1670708628,
   (f_vardobcountnew_i = NULL) => 0.0062058687, 0.0062058687), -0.0057360140);

// Tree: 115 
wFDN_FL__SD_lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.2) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 19.6) => -0.0598544461,
   (c_fammar_p > 19.6) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 55) => 0.0654969171,
      (r_F00_dob_score_d > 55) => 
         map(
         (NULL < r_I60_inq_mortgage_recency_d and r_I60_inq_mortgage_recency_d <= 9) => -0.1051214846,
         (r_I60_inq_mortgage_recency_d > 9) => -0.0003612646,
         (r_I60_inq_mortgage_recency_d = NULL) => -0.0022319828, -0.0022319828),
      (r_F00_dob_score_d = NULL) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 54.7) => -0.0341560512,
         (r_C12_source_profile_d > 54.7) => 0.1035667715,
         (r_C12_source_profile_d = NULL) => -0.0090140344, -0.0056194377), -0.0019754145),
   (c_fammar_p = NULL) => -0.0024788740, -0.0024788740),
(c_pop_0_5_p > 21.2) => 0.1272623095,
(c_pop_0_5_p = NULL) => 0.0050097537, -0.0017703001);

// Tree: 116 
wFDN_FL__SD_lgt_116 := map(
(NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0069672338,
(r_F04_curr_add_occ_index_d > 2) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 7.75) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 23.2) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 119.5) => 
            map(
            (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 2.5) => 0.0546660269,
            (r_C20_email_domain_free_count_i > 2.5) => 0.2417940963,
            (r_C20_email_domain_free_count_i = NULL) => 0.0687782493, 0.0687782493),
         (f_fp_prevaddrcrimeindex_i > 119.5) => -0.0233920412,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0389639819, 0.0389639819),
      (C_INC_50K_P > 23.2) => 0.1840392533,
      (C_INC_50K_P = NULL) => 0.0470703073, 0.0470703073),
   (c_newhouse > 7.75) => -0.0034771843,
   (c_newhouse = NULL) => 0.0525875928, 0.0174861501),
(r_F04_curr_add_occ_index_d = NULL) => 0.0026550352, -0.0015288158);

// Tree: 117 
wFDN_FL__SD_lgt_117 := map(
(NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => -0.0810345739,
   (r_D33_Eviction_Recency_d > 30) => -0.0041501976,
   (r_D33_Eviction_Recency_d = NULL) => -0.0046871975, -0.0046871975),
(r_F04_curr_add_occ_index_d > 2) => 
   map(
   (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 13.15) => 0.0251076360,
      (c_blue_col > 13.15) => 0.1615343062,
      (c_blue_col = NULL) => 0.0760685712, 0.0760685712),
   (r_I60_inq_banking_recency_d > 9) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 21.65) => 0.0099310568,
      (C_INC_25K_P > 21.65) => 0.1080300099,
      (C_INC_25K_P = NULL) => 0.0251657234, 0.0134775391),
   (r_I60_inq_banking_recency_d = NULL) => 0.0196003237, 0.0196003237),
(r_F04_curr_add_occ_index_d = NULL) => -0.0113170006, 0.0004489321);

// Tree: 118 
wFDN_FL__SD_lgt_118 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 85.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
      map(
      (NULL < c_young and c_young <= 32.85) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 11.05) => -0.0031691423,
         (c_hh6_p > 11.05) => 0.0607577747,
         (c_hh6_p = NULL) => -0.0013682975, -0.0013682975),
      (c_young > 32.85) => -0.0354940270,
      (c_young = NULL) => -0.0164059445, -0.0063395652),
   (f_inq_Communications_count_i > 3.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 88.5) => 0.1318519796,
      (c_no_labfor > 88.5) => -0.0074376729,
      (c_no_labfor = NULL) => 0.0590124366, 0.0590124366),
   (f_inq_Communications_count_i = NULL) => -0.0225879400, -0.0059031454),
(k_comb_age_d > 85.5) => 0.0916973407,
(k_comb_age_d = NULL) => -0.0052491414, -0.0052491414);

// Tree: 119 
wFDN_FL__SD_lgt_119 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 0.0074652966,
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 23.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 39.5) => 0.0709607818,
      (r_A50_pb_total_dollars_d > 39.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 151.5) => -0.0699578737,
         (c_relig_indx > 151.5) => 0.0308349272,
         (c_relig_indx = NULL) => -0.0410757261, -0.0410757261),
      (r_A50_pb_total_dollars_d = NULL) => -0.0217312931, -0.0217312931),
   (f_rel_homeover50_count_d > 23.5) => -0.1319403490,
   (f_rel_homeover50_count_d = NULL) => -0.0369875054, -0.0369875054),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.75) => -0.0815035780,
   (c_pop_55_64_p > 11.75) => 0.0392053690,
   (c_pop_55_64_p = NULL) => -0.0261325014, -0.0261325014), 0.0054655319);

// Tree: 120 
wFDN_FL__SD_lgt_120 := map(
(NULL < c_pop00 and c_pop00 <= 2411.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 39.5) => -0.1202913784,
   (f_mos_inq_banko_am_fseen_d > 39.5) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 18) => 
         map(
         (NULL < c_rental and c_rental <= 157.5) => 0.0103779568,
         (c_rental > 157.5) => 
            map(
            (NULL < c_serv_empl and c_serv_empl <= 96) => 0.0082291302,
            (c_serv_empl > 96) => 0.1347884459,
            (c_serv_empl = NULL) => 0.0880300780, 0.0880300780),
         (c_rental = NULL) => 0.0282098353, 0.0282098353),
      (r_I61_inq_collection_recency_d > 18) => -0.0092540822,
      (r_I61_inq_collection_recency_d = NULL) => -0.0057237440, -0.0057237440),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0138488578, -0.0075677506),
(c_pop00 > 2411.5) => 0.0249771896,
(c_pop00 = NULL) => -0.0293686623, -0.0009800006);

// Tree: 121 
wFDN_FL__SD_lgt_121 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0410816384,
(f_mos_inq_banko_om_fseen_d > 5.5) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 44.5) => -0.0152675006,
   (f_prevaddrmurderindex_i > 44.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0042125633,
      (f_inq_Communications_count_i > 0.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 1.5) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 7.5) => 0.0666555260,
            (f_historical_count_d > 7.5) => -0.0729169503,
            (f_historical_count_d = NULL) => 0.0538376456, 0.0538376456),
         (f_rel_homeover500_count_d > 1.5) => -0.0565890872,
         (f_rel_homeover500_count_d = NULL) => 0.0346060235, 0.0346060235),
      (f_inq_Communications_count_i = NULL) => 0.0070088394, 0.0070088394),
   (f_prevaddrmurderindex_i = NULL) => -0.0007950094, -0.0007950094),
(f_mos_inq_banko_om_fseen_d = NULL) => 0.0135836788, -0.0024388538);

// Tree: 122 
wFDN_FL__SD_lgt_122 := map(
(NULL < c_popover25 and c_popover25 <= 325.5) => -0.1103994314,
(c_popover25 > 325.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 36.5) => 
         map(
         (NULL < c_retired and c_retired <= 12.25) => -0.0016915312,
         (c_retired > 12.25) => 0.0720866893,
         (c_retired = NULL) => 0.0330672049, 0.0330672049),
      (c_exp_prod > 36.5) => -0.0035069784,
      (c_exp_prod = NULL) => -0.0004972469, -0.0004972469),
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 80) => 0.1850052312,
      (c_new_homes > 80) => 0.0104249146,
      (c_new_homes = NULL) => 0.0671185226, 0.0671185226),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0162672074, 0.0007041511),
(c_popover25 = NULL) => -0.0004933762, -0.0000699781);

// Tree: 123 
wFDN_FL__SD_lgt_123 := map(
(NULL < c_low_ed and c_low_ed <= 75.25) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 73.05) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 17.5) => 0.0035292809,
      (f_inq_HighRiskCredit_count_i > 17.5) => 0.0704226462,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0166337467, 0.0039753818),
   (c_low_ed > 73.05) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 0.5) => 0.0054635956,
      (f_rel_homeover300_count_d > 0.5) => 0.1783525511,
      (f_rel_homeover300_count_d = NULL) => 0.0856931109, 0.0856931109),
   (c_low_ed = NULL) => 0.0050547763, 0.0050547763),
(c_low_ed > 75.25) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 72.65) => -0.0244351338,
   (c_lowinc > 72.65) => -0.1274773323,
   (c_lowinc = NULL) => -0.0357393412, -0.0357393412),
(c_low_ed = NULL) => 0.0171642887, 0.0038406793);

// Tree: 124 
wFDN_FL__SD_lgt_124 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 188.5) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => 0.0012508650,
      (f_inq_QuizProvider_count_i > 5.5) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0111776313,
         (f_inq_Collection_count_i > 1.5) => 0.1714139670,
         (f_inq_Collection_count_i = NULL) => 0.0733050485, 0.0733050485),
      (f_inq_QuizProvider_count_i = NULL) => 0.0020993807, 0.0020993807),
   (c_span_lang > 188.5) => -0.0374440456,
   (c_span_lang = NULL) => -0.0009699366, -0.0000472760),
(f_rel_under25miles_cnt_d > 10.5) => -0.0967411648,
(f_rel_under25miles_cnt_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 168.5) => -0.0253270804,
   (c_new_homes > 168.5) => 0.1136739871,
   (c_new_homes = NULL) => 0.0024731331, 0.0024731331), -0.0004823488);

// Tree: 125 
wFDN_FL__SD_lgt_125 := map(
(NULL < c_lowinc and c_lowinc <= 74) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
         map(
         (NULL < c_med_hhinc and c_med_hhinc <= 25961) => 0.0493869262,
         (c_med_hhinc > 25961) => -0.0002938979,
         (c_med_hhinc = NULL) => 0.0008311326, 0.0008311326),
      (f_inq_Auto_count24_i > 1.5) => -0.0458301585,
      (f_inq_Auto_count24_i = NULL) => 0.0088218591, -0.0016042777),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 41.65) => 0.0047710401,
      (c_white_col > 41.65) => 0.2203431766,
      (c_white_col = NULL) => 0.0822801229, 0.0822801229),
   (f_nae_nothing_found_i = NULL) => -0.0003860821, -0.0003860821),
(c_lowinc > 74) => -0.0714236564,
(c_lowinc = NULL) => -0.0123067070, -0.0014547263);

// Tree: 126 
wFDN_FL__SD_lgt_126 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00264561835) => 0.1936605077,
      (f_add_curr_nhood_MFD_pct_i > 0.00264561835) => 0.0092097797,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0137976768, 0.0124688234),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 27.5) => 0.2265360563,
      (r_A50_pb_average_dollars_d > 27.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 14.8) => -0.0061557667,
         (c_hh4_p > 14.8) => 0.1329862519,
         (c_hh4_p = NULL) => 0.0426089594, 0.0426089594),
      (r_A50_pb_average_dollars_d = NULL) => 0.0762300417, 0.0762300417),
   (f_util_adl_count_n = NULL) => 0.0165724866, 0.0165724866),
(k_estimated_income_d > 34500) => -0.0054095003,
(k_estimated_income_d = NULL) => -0.0035031496, 0.0021155970);

// Tree: 127 
wFDN_FL__SD_lgt_127 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 10.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0034303719,
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 0.0602888571,
      (f_current_count_d > 0.5) => -0.0265123820,
      (f_current_count_d = NULL) => 0.0219917911, 0.0219917911),
   (f_inq_Communications_count_i = NULL) => -0.0012445141, -0.0012445141),
(f_srchssnsrchcount_i > 10.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 0.5) => 0.0399676803,
   (r_A44_curr_add_naprop_d > 0.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 71.5) => -0.0116039932,
      (c_ab_av_edu > 71.5) => -0.1194079005,
      (c_ab_av_edu = NULL) => -0.0796906715, -0.0796906715),
   (r_A44_curr_add_naprop_d = NULL) => -0.0495159567, -0.0495159567),
(f_srchssnsrchcount_i = NULL) => -0.0318539409, -0.0023417549);

// Tree: 128 
wFDN_FL__SD_lgt_128 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0670582529,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 0.75) => -0.0827685894,
   (c_pop_18_24_p > 0.75) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 53.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -25560.5) => 
            map(
            (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.65) => 0.2280370238,
            (c_pop_65_74_p > 4.65) => -0.0136449109,
            (c_pop_65_74_p = NULL) => 0.0681944744, 0.0681944744),
         (r_A49_Curr_AVM_Chg_1yr_i > -25560.5) => -0.0369915432,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0031352152, -0.0098367637),
      (r_C13_Curr_Addr_LRes_d > 53.5) => 0.0149336939,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0037278143, 0.0037278143),
   (c_pop_18_24_p = NULL) => -0.0220517653, 0.0017269598),
(r_C10_M_Hdr_FS_d = NULL) => 0.0181954594, 0.0021786146);

// Tree: 129 
wFDN_FL__SD_lgt_129 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 52.35) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 33.85) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.85) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.0106183745,
         (k_estimated_income_d > 32500) => -0.0116824328,
         (k_estimated_income_d = NULL) => -0.0074618861, -0.0055198579),
      (c_pop_0_5_p > 19.85) => 0.1076830570,
      (c_pop_0_5_p = NULL) => -0.0049891756, -0.0049891756),
   (c_hval_300k_p > 33.85) => -0.1030998262,
   (c_hval_300k_p = NULL) => -0.0061375080, -0.0061375080),
(c_hval_500k_p > 52.35) => 0.0917186406,
(c_hval_500k_p = NULL) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 0.5) => -0.0214306332,
   (f_rel_criminal_count_i > 0.5) => 0.1454544083,
   (f_rel_criminal_count_i = NULL) => 0.0293604664, 0.0293604664), -0.0046703232);

// Tree: 130 
wFDN_FL__SD_lgt_130 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1900) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 193.5) => -0.0138797081,
         (f_curraddrburglaryindex_i > 193.5) => 0.0989070109,
         (f_curraddrburglaryindex_i = NULL) => -0.0116545055, -0.0116545055),
      (r_C14_Addr_Stability_v2_d > 4.5) => 0.0000530869,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0041760832, -0.0041760832),
   (f_acc_damage_amt_last_i > 1900) => 0.0972706438,
   (f_acc_damage_amt_last_i = NULL) => 0.0090634584, -0.0031817005),
(c_hh6_p > 17.35) => -0.0976119364,
(c_hh6_p = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0143935139,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity']) => 0.1511740708,
   (nf_seg_FraudPoint_3_0 = '') => 0.0123441085, 0.0123441085), -0.0033831280);

// Tree: 131 
wFDN_FL__SD_lgt_131 := map(
(NULL < c_hh00 and c_hh00 <= 268.5) => -0.0424063047,
(c_hh00 > 268.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 269.9) => 
         map(
         (NULL < c_rental and c_rental <= 115.5) => 0.0081426761,
         (c_rental > 115.5) => 
            map(
            (NULL < c_rich_wht and c_rich_wht <= 168.5) => 0.1108935135,
            (c_rich_wht > 168.5) => 0.3285226201,
            (c_rich_wht = NULL) => 0.1574029597, 0.1574029597),
         (c_rental = NULL) => 0.0704601009, 0.0704601009),
      (c_oldhouse > 269.9) => -0.0946461752,
      (c_oldhouse = NULL) => 0.0541749598, 0.0541749598),
   (f_corrssnnamecount_d > 1.5) => -0.0001750910,
   (f_corrssnnamecount_d = NULL) => 0.0001791518, 0.0028307971),
(c_hh00 = NULL) => 0.0055109063, 0.0013097631);

// Tree: 132 
wFDN_FL__SD_lgt_132 := map(
(NULL < c_hh3_p and c_hh3_p <= 17.75) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 82.5) => -0.0080970773,
   (k_comb_age_d > 82.5) => 0.0996320766,
   (k_comb_age_d = NULL) => -0.0067690696, -0.0067690696),
(c_hh3_p > 17.75) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 77.75) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 5.5) => 0.1926803501,
      (f_rel_homeover100_count_d > 5.5) => 0.0097887846,
      (f_rel_homeover100_count_d = NULL) => 0.0973706610, 0.0973706610),
   (c_occunit_p > 77.75) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.95) => 0.0050144769,
      (r_C12_source_profile_d > 78.95) => 0.0881052405,
      (r_C12_source_profile_d = NULL) => 0.0136762481, 0.0136762481),
   (c_occunit_p = NULL) => 0.0161560826, 0.0161560826),
(c_hh3_p = NULL) => -0.0380955446, 0.0014975903);

// Tree: 133 
wFDN_FL__SD_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 
   map(
   (NULL < c_hval_400k_p and c_hval_400k_p <= 6.55) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 24.85) => -0.0865108187,
      (c_fammar18_p > 24.85) => 0.0348287229,
      (c_fammar18_p = NULL) => -0.0079230327, -0.0079230327),
   (c_hval_400k_p > 6.55) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 16) => 0.0440046454,
      (c_hh3_p > 16) => 0.2199911507,
      (c_hh3_p = NULL) => 0.1319978980, 0.1319978980),
   (c_hval_400k_p = NULL) => 0.0478709833, 0.0478709833),
(f_mos_liens_unrel_SC_fseen_d > 127.5) => 0.0016466688,
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0503489233,
   (r_S66_adlperssn_count_i > 1.5) => 0.0643058565,
   (r_S66_adlperssn_count_i = NULL) => 0.0086481964, 0.0086481964), 0.0028805364);

// Tree: 134 
wFDN_FL__SD_lgt_134 := map(
(NULL < c_hh2_p and c_hh2_p <= 36.35) => 
   map(
   (NULL < f_idverrisktype_i and f_idverrisktype_i <= 5.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 122.5) => 0.1162203508,
         (c_rest_indx > 122.5) => -0.0587862373,
         (c_rest_indx = NULL) => 0.0475468795, 0.0475468795),
      (f_M_Bureau_ADL_FS_noTU_d > 8.5) => -0.0062747234,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0051507724, -0.0051507724),
   (f_idverrisktype_i > 5.5) => -0.0531750742,
   (f_idverrisktype_i = NULL) => -0.0282994573, -0.0080316676),
(c_hh2_p > 36.35) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 22.35) => 0.0208955170,
   (C_INC_25K_P > 22.35) => -0.1090403502,
   (C_INC_25K_P = NULL) => 0.0190756870, 0.0190756870),
(c_hh2_p = NULL) => 0.0086683926, 0.0015417282);

// Tree: 135 
wFDN_FL__SD_lgt_135 := map(
(NULL < c_no_teens and c_no_teens <= 48.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.05) => -0.0040844602,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.05) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 207.35) => 
         map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 169820) => 0.2789013462,
         (f_prevaddrmedianvalue_d > 169820) => 0.0465365288,
         (f_prevaddrmedianvalue_d = NULL) => 0.1743371784, 0.1743371784),
      (c_cpiall > 207.35) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 22.55) => 0.0740728460,
         (c_hh4_p > 22.55) => -0.0546533371,
         (c_hh4_p = NULL) => 0.0309875391, 0.0309875391),
      (c_cpiall = NULL) => 0.0593736063, 0.0593736063),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0041291591, 0.0189166647),
(c_no_teens > 48.5) => -0.0082920588,
(c_no_teens = NULL) => -0.0089935082, -0.0018615289);

// Tree: 136 
wFDN_FL__SD_lgt_136 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 0.5) => -0.0058305415,
(r_D32_criminal_count_i > 0.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 16.55) => 
      map(
      (NULL < c_totsales and c_totsales <= 1924) => 0.0402844775,
      (c_totsales > 1924) => 0.2191765193,
      (c_totsales = NULL) => 0.1290261990, 0.1290261990),
   (c_hh2_p > 16.55) => 
      map(
      (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 1.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 18.75) => 0.0001844699,
         (c_pop_55_64_p > 18.75) => 0.1236127668,
         (c_pop_55_64_p = NULL) => 0.0084211581, 0.0084211581),
      (f_inq_QuizProvider_count24_i > 1.5) => 0.1427615359,
      (f_inq_QuizProvider_count24_i = NULL) => 0.0119768466, 0.0119768466),
   (c_hh2_p = NULL) => 0.0187184646, 0.0187184646),
(r_D32_criminal_count_i = NULL) => 0.0027960545, -0.0014811786);

// Tree: 137 
wFDN_FL__SD_lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0793580317,
   (C_INC_100K_P > 1.35) => -0.0004883746,
   (C_INC_100K_P = NULL) => 0.0228227913, 0.0005223487),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_201K_P and C_INC_201K_P <= 0.15) => -0.1119722471,
   (C_INC_201K_P > 0.15) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 134) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.605) => -0.0339710477,
         (c_hhsize > 2.605) => 0.0866320629,
         (c_hhsize = NULL) => 0.0274901529, 0.0274901529),
      (c_lux_prod > 134) => -0.0980298950,
      (c_lux_prod = NULL) => -0.0148828569, -0.0148828569),
   (C_INC_201K_P = NULL) => -0.0393863697, -0.0393863697),
(f_inq_HighRiskCredit_count24_i = NULL) => -0.0075774142, -0.0002034232);

// Tree: 138 
wFDN_FL__SD_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 87.5) => 0.0100706467,
   (c_old_homes > 87.5) => -0.0117447494,
   (c_old_homes = NULL) => -0.0147081630, 0.0003096460),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.350936958) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 142) => -0.0491467860,
         (f_fp_prevaddrcrimeindex_i > 142) => 0.1407771212,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0520535441, 0.0520535441),
      (f_add_curr_mobility_index_i > 0.350936958) => -0.0856088929,
      (f_add_curr_mobility_index_i = NULL) => -0.0006550466, -0.0006550466),
   (f_vardobcountnew_i > 0.5) => 0.1209273465,
   (f_vardobcountnew_i = NULL) => 0.0341386286, 0.0341386286),
(f_curraddrcrimeindex_i = NULL) => -0.0257132808, 0.0009461978);

// Tree: 139 
wFDN_FL__SD_lgt_139 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0185357404,
(f_addrs_per_ssn_i > 5.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 91.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 45) => -0.0493902502,
      (c_robbery > 45) => 
         map(
         (NULL < c_rape and c_rape <= 83.5) => 
            map(
            (NULL < c_rest_indx and c_rest_indx <= 79.5) => 0.2454740068,
            (c_rest_indx > 79.5) => 0.0861883375,
            (c_rest_indx = NULL) => 0.1250978139, 0.1250978139),
         (c_rape > 83.5) => 0.0105883305,
         (c_rape = NULL) => 0.0581342650, 0.0581342650),
      (c_robbery = NULL) => 0.0307136094, 0.0307136094),
   (r_C21_M_Bureau_ADL_FS_d > 91.5) => 0.0012900810,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0042712439, 0.0042712439),
(f_addrs_per_ssn_i = NULL) => -0.0030679843, -0.0030679843);

// Tree: 140 
wFDN_FL__SD_lgt_140 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 3.515) => 
      map(
      (NULL < c_work_home and c_work_home <= 166.5) => 0.0041247896,
      (c_work_home > 166.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 38.75) => 0.0327553844,
         (c_low_ed > 38.75) => 0.1765666838,
         (c_low_ed = NULL) => 0.0690078161, 0.0690078161),
      (c_work_home = NULL) => 0.0157630006, 0.0157630006),
   (c_hhsize > 3.515) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 68.15) => 0.1943322128,
      (c_low_ed > 68.15) => -0.0027843702,
      (c_low_ed = NULL) => 0.0966309499, 0.0966309499),
   (c_hhsize = NULL) => -0.0422405876, 0.0175943753),
(f_hh_age_18_plus_d > 1.5) => -0.0070093132,
(f_hh_age_18_plus_d = NULL) => 0.0012777692, -0.0013974321);

// Tree: 141 
wFDN_FL__SD_lgt_141 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 35.05) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 27878) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 0.5) => -0.0152702935,
      (f_srchssnsrchcount_i > 0.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 88.1) => 0.0125294739,
         (c_occunit_p > 88.1) => 0.1840601084,
         (c_occunit_p = NULL) => 0.1097751879, 0.1097751879),
      (f_srchssnsrchcount_i = NULL) => 0.0506250432, 0.0506250432),
   (c_med_hhinc > 27878) => -0.0026910646,
   (c_med_hhinc = NULL) => -0.0016133469, -0.0016133469),
(C_INC_15K_P > 35.05) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 113.5) => 0.0429344724,
   (f_curraddrburglaryindex_i > 113.5) => -0.0718318895,
   (f_curraddrburglaryindex_i = NULL) => -0.0407918770, -0.0407918770),
(C_INC_15K_P = NULL) => -0.0271785317, -0.0031577253);

// Tree: 142 
wFDN_FL__SD_lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 112.5) => -0.0008625089,
      (c_robbery > 112.5) => 0.1667831803,
      (c_robbery = NULL) => 0.0718661357, 0.0718661357),
   (r_C13_max_lres_d > 17.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 75.7) => 0.0000483142,
      (C_RENTOCC_P > 75.7) => 0.0442267579,
      (C_RENTOCC_P = NULL) => -0.0053429146, 0.0017849017),
   (r_C13_max_lres_d = NULL) => 0.0026582969, 0.0026582969),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0478679800,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 102.5) => -0.0618526850,
   (c_medi_indx > 102.5) => 0.0589090168,
   (c_medi_indx = NULL) => 0.0014034445, 0.0014034445), 0.0004888439);

// Tree: 143 
wFDN_FL__SD_lgt_143 := map(
(NULL < c_child and c_child <= 33.45) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => 0.0016478733,
   (f_srchunvrfddobcount_i > 0.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 149.5) => -0.0130261393,
      (c_new_homes > 149.5) => 0.1433356939,
      (c_new_homes = NULL) => 0.0385653285, 0.0385653285),
   (f_srchunvrfddobcount_i = NULL) => 0.0146577675, 0.0030203470),
(c_child > 33.45) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 193.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 70.05) => -0.0360795548,
      (c_low_ed > 70.05) => -0.1126388553,
      (c_low_ed = NULL) => -0.0461949028, -0.0461949028),
   (c_span_lang > 193.5) => 0.0482584997,
   (c_span_lang = NULL) => -0.0355553241, -0.0355553241),
(c_child = NULL) => -0.0055581402, 0.0001670218);

// Tree: 144 
wFDN_FL__SD_lgt_144 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 6.5) => 
      map(
      (NULL < c_employees and c_employees <= 40.5) => 
         map(
         (NULL < f_srchunvrfdssncount_i and f_srchunvrfdssncount_i <= 0.5) => 0.0140144393,
         (f_srchunvrfdssncount_i > 0.5) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.25703406045) => 0.2232211706,
            (f_add_curr_mobility_index_i > 0.25703406045) => 0.0101358420,
            (f_add_curr_mobility_index_i = NULL) => 0.1103041588, 0.1103041588),
         (f_srchunvrfdssncount_i = NULL) => 0.0208797027, 0.0208797027),
      (c_employees > 40.5) => -0.0058805439,
      (c_employees = NULL) => -0.0062481292, -0.0023635018),
   (f_varrisktype_i > 6.5) => -0.0687785771,
   (f_varrisktype_i = NULL) => -0.0027926356, -0.0027926356),
(r_C14_addrs_10yr_i > 10.5) => 0.1064859976,
(r_C14_addrs_10yr_i = NULL) => -0.0189782778, -0.0024882168);

// Tree: 145 
wFDN_FL__SD_lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 57.5) => -0.0081596129,
(k_comb_age_d > 57.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 43.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 229.85) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 94.6) => -0.0041723083,
         (c_oldhouse > 94.6) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 178.5) => 0.2366594460,
            (r_C13_max_lres_d > 178.5) => 0.0395201500,
            (r_C13_max_lres_d = NULL) => 0.1020277317, 0.1020277317),
         (c_oldhouse = NULL) => 0.0448299609, 0.0448299609),
      (c_cpiall > 229.85) => 0.2219089105,
      (c_cpiall = NULL) => 0.0625122294, 0.0625122294),
   (f_prevaddrlenofres_d > 43.5) => 0.0071435910,
   (f_prevaddrlenofres_d = NULL) => 0.0231229011, 0.0231229011),
(k_comb_age_d = NULL) => -0.0019129745, -0.0019129745);

// Tree: 146 
wFDN_FL__SD_lgt_146 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 185.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 12.35) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => 0.0397880078,
            (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity']) => 0.1426657586,
            (nf_seg_FraudPoint_3_0 = '') => 0.0618464805, 0.0618464805),
         (c_pop_18_24_p > 12.35) => -0.0567896459,
         (c_pop_18_24_p = NULL) => 0.0370038729, 0.0370038729),
      (c_rich_wht > 185.5) => 0.1902353797,
      (c_rich_wht = NULL) => 0.0494388904, 0.0494388904),
   (r_C14_addrs_15yr_i > 1.5) => 0.0018631876,
   (r_C14_addrs_15yr_i = NULL) => 0.0152376160, 0.0152376160),
(f_hh_age_18_plus_d > 1.5) => -0.0077652835,
(f_hh_age_18_plus_d = NULL) => 0.0025981972, -0.0024956447);

// Tree: 147 
wFDN_FL__SD_lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 197.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => -0.0624877864,
      (f_mos_inq_banko_om_lseen_d > 5.5) => -0.0014706007,
      (f_mos_inq_banko_om_lseen_d = NULL) => -0.0047246735, -0.0047246735),
   (c_housingcpi > 222.35) => 
      map(
      (NULL < c_incollege and c_incollege <= 1.75) => -0.0740247011,
      (c_incollege > 1.75) => 0.0234553703,
      (c_incollege = NULL) => 0.0186553398, 0.0186553398),
   (c_housingcpi = NULL) => -0.0300552356, 0.0002561090),
(f_prevaddrcartheftindex_i > 197.5) => -0.1067778600,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 408) => -0.0494416705,
   (c_families > 408) => 0.0678094320,
   (c_families = NULL) => 0.0119755736, 0.0119755736), -0.0007841435);

// Tree: 148 
wFDN_FL__SD_lgt_148 := map(
(NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 2) => -0.0035854862,
(nf_vf_hi_summary > 2) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 9.65) => -0.0543416515,
      (c_pop_18_24_p > 9.65) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 98) => 0.1445869674,
         (f_prevaddrmurderindex_i > 98) => 0.0056157470,
         (f_prevaddrmurderindex_i = NULL) => 0.0737903080, 0.0737903080),
      (c_pop_18_24_p = NULL) => 0.0015513020, 0.0015513020),
   (r_C14_Addr_Stability_v2_d > 4.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 47.5) => 0.1140628424,
      (c_born_usa > 47.5) => -0.0095338231,
      (c_born_usa = NULL) => 0.0400303220, 0.0400303220),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0189790196, 0.0189790196),
(nf_vf_hi_summary = NULL) => 0.0006456923, -0.0027538787);

// Tree: 149 
wFDN_FL__SD_lgt_149 := map(
(NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 197.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 18.75) => -0.0133553147,
      (c_hh5_p > 18.75) => 
         map(
         (NULL < c_health and c_health <= 0.5) => -0.0394318419,
         (c_health > 0.5) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 32.5) => 0.2337850685,
            (c_born_usa > 32.5) => 0.0552123653,
            (c_born_usa = NULL) => 0.1444987169, 0.1444987169),
         (c_health = NULL) => 0.0616289047, 0.0616289047),
      (c_hh5_p = NULL) => -0.0112831726, -0.0112831726),
   (c_serv_empl > 197.5) => 0.1207880023,
   (c_serv_empl = NULL) => 0.0085530978, -0.0093979597),
(f_util_add_curr_misc_n > 0.5) => 0.0139047593,
(f_util_add_curr_misc_n = NULL) => 0.0013394776, 0.0013394776);

// Tree: 150 
wFDN_FL__SD_lgt_150 := map(
(NULL < c_unempl and c_unempl <= 22.5) => -0.0753732716,
(c_unempl > 22.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_child and c_child <= 21.75) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 99.5) => 0.0413994726,
         (f_curraddrcrimeindex_i > 99.5) => 0.2066510346,
         (f_curraddrcrimeindex_i = NULL) => 0.1156868720, 0.1156868720),
      (c_child > 21.75) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 2.05) => -0.0132472660,
         (c_pop_85p_p > 2.05) => 0.1275835709,
         (c_pop_85p_p = NULL) => 0.0102761266, 0.0102761266),
      (c_child = NULL) => 0.0444210634, 0.0444210634),
   (f_corrssnnamecount_d > 1.5) => -0.0015406973,
   (f_corrssnnamecount_d = NULL) => -0.0138565571, 0.0009686124),
(c_unempl = NULL) => 0.0272167271, -0.0012890486);

// Tree: 151 
wFDN_FL__SD_lgt_151 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 367.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 9.5) => -0.0035008960,
   (r_C14_addrs_10yr_i > 9.5) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 12.5) => 0.0010607857,
      (f_rel_homeover100_count_d > 12.5) => 0.1495860482,
      (f_rel_homeover100_count_d = NULL) => 0.0738952894, 0.0738952894),
   (r_C14_addrs_10yr_i = NULL) => -0.0028501398, -0.0028501398),
(f_prevaddrlenofres_d > 367.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 148.5) => 0.0087212704,
   (c_relig_indx > 148.5) => 0.2438648277,
   (c_relig_indx = NULL) => 0.0859325877, 0.0859325877),
(f_prevaddrlenofres_d = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 18.1) => 0.0508643910,
   (C_RENTOCC_P > 18.1) => -0.0464896860,
   (C_RENTOCC_P = NULL) => 0.0049426566, 0.0049426566), -0.0013343779);

// Tree: 152 
wFDN_FL__SD_lgt_152 := map(
(NULL < c_fammar_p and c_fammar_p <= 18.85) => -0.0721456212,
(c_fammar_p > 18.85) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 917961.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.31121900185) => 
         map(
         (NULL < c_white_col and c_white_col <= 20.05) => 
            map(
            (NULL < c_unemp and c_unemp <= 10.35) => 0.0256187567,
            (c_unemp > 10.35) => 0.1478963635,
            (c_unemp = NULL) => 0.0437339577, 0.0437339577),
         (c_white_col > 20.05) => 0.0046938063,
         (c_white_col = NULL) => 0.0065176916, 0.0065176916),
      (f_add_curr_mobility_index_i > 0.31121900185) => -0.0152535227,
      (f_add_curr_mobility_index_i = NULL) => 0.0002904286, 0.0002904286),
   (f_curraddrmedianvalue_d > 917961.5) => 0.1718510970,
   (f_curraddrmedianvalue_d = NULL) => 0.0009415308, 0.0010631309),
(c_fammar_p = NULL) => 0.0130383780, 0.0007788712);

// Tree: 153 
wFDN_FL__SD_lgt_153 := map(
(NULL < c_hval_60k_p and c_hval_60k_p <= 35.15) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 26.5) => 0.0023063432,
   (f_rel_homeover300_count_d > 26.5) => -0.0981029428,
   (f_rel_homeover300_count_d = NULL) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 4.05) => -0.1006739760,
      (c_famotf18_p > 4.05) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 14.5) => 0.0984531967,
         (f_M_Bureau_ADL_FS_all_d > 14.5) => -0.0526981962,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0206160028, 0.0072402312),
      (c_famotf18_p = NULL) => -0.0178237137, -0.0178237137), 0.0011437579),
(c_hval_60k_p > 35.15) => 
   map(
   (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => -0.1194846958,
   (r_Prop_Owner_History_d > 1.5) => -0.0366518171,
   (r_Prop_Owner_History_d = NULL) => -0.0776661551, -0.0776661551),
(c_hval_60k_p = NULL) => -0.0007237322, 0.0004528672);

// Tree: 154 
wFDN_FL__SD_lgt_154 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.95) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.45) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 0.5) => -0.0368536951,
      (f_inq_HighRiskCredit_count_i > 0.5) => -0.1282585988,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0491673090, -0.0491673090),
   (C_INC_150K_P > 0.45) => -0.0082243193,
   (C_INC_150K_P = NULL) => -0.0111763217, -0.0111763217),
(c_pop_35_44_p > 13.95) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 44522) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 48.5) => 0.1280573295,
      (r_C13_Curr_Addr_LRes_d > 48.5) => -0.0178807080,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0623852126, 0.0623852126),
   (f_curraddrmedianvalue_d > 44522) => 0.0079178035,
   (f_curraddrmedianvalue_d = NULL) => -0.0025409560, 0.0094052395),
(c_pop_35_44_p = NULL) => -0.0038947780, 0.0002802800);

// Tree: 155 
wFDN_FL__SD_lgt_155 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 19.5) => -0.0915463833,
(f_mos_liens_unrel_OT_fseen_d > 19.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 16) => -0.0382036171,
   (c_burglary > 16) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 109.5) => 
         map(
         (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 
            map(
            (NULL < C_INC_75K_P and C_INC_75K_P <= 15.55) => 0.1342484894,
            (C_INC_75K_P > 15.55) => -0.0053334186,
            (C_INC_75K_P = NULL) => 0.0447981117, 0.0447981117),
         (r_F00_dob_score_d > 95) => -0.0139771842,
         (r_F00_dob_score_d = NULL) => -0.0365683176, -0.0127387541),
      (c_asian_lang > 109.5) => 0.0135319104,
      (c_asian_lang = NULL) => 0.0025658376, 0.0025658376),
   (c_burglary = NULL) => 0.0148826755, -0.0016408356),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0280654480, -0.0018883565);

// Tree: 156 
wFDN_FL__SD_lgt_156 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => 0.0003418464,
   (f_hh_criminals_i > 3.5) => 0.0739419713,
   (f_hh_criminals_i = NULL) => 0.0011020526, 0.0011020526),
(f_srchssnsrchcount_i > 6.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0506160043) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 38500) => -0.1598395045,
      (k_estimated_income_d > 38500) => -0.0414884804,
      (k_estimated_income_d = NULL) => -0.1001004161, -0.1001004161),
   (f_add_curr_nhood_MFD_pct_i > 0.0506160043) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 57) => 0.0874587209,
      (f_prevaddrcartheftindex_i > 57) => -0.0435142181,
      (f_prevaddrcartheftindex_i = NULL) => -0.0070578330, -0.0070578330),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0456435878, -0.0344434096),
(f_srchssnsrchcount_i = NULL) => 0.0084238324, -0.0002240874);

// Tree: 157 
wFDN_FL__SD_lgt_157 := map(
(NULL < r_S65_SSN_Prior_DoB_i and r_S65_SSN_Prior_DoB_i <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 20986.5) => 0.0671947710,
   (r_A46_Curr_AVM_AutoVal_d > 20986.5) => 0.0059719084,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 1.5) => -0.0110882862,
      (f_divssnidmsrcurelcount_i > 1.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 121.5) => 0.0018007061,
         (c_easiqlife > 121.5) => 
            map(
            (NULL < c_unattach and c_unattach <= 107.5) => 0.0616876094,
            (c_unattach > 107.5) => 0.2829547893,
            (c_unattach = NULL) => 0.1660589207, 0.1660589207),
         (c_easiqlife = NULL) => 0.0749577260, 0.0749577260),
      (f_divssnidmsrcurelcount_i = NULL) => -0.0245051142, -0.0070335589), 0.0007805313),
(r_S65_SSN_Prior_DoB_i > 0.5) => 0.0751827769,
(r_S65_SSN_Prior_DoB_i = NULL) => 0.0010855547, 0.0010855547);

// Tree: 158 
wFDN_FL__SD_lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < c_manufacturing and c_manufacturing <= 17.55) => 0.0036272860,
      (c_manufacturing > 17.55) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => -0.0868392518,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0225327185,
         (nf_seg_FraudPoint_3_0 = '') => -0.0345997402, -0.0345997402),
      (c_manufacturing = NULL) => -0.0229922695, 0.0003923192),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 543) => -0.1551465802,
      (r_A50_pb_total_dollars_d > 543) => -0.0032925993,
      (r_A50_pb_total_dollars_d = NULL) => -0.0650814605, -0.0650814605),
   (r_I60_inq_comm_count12_i = NULL) => -0.0003663270, -0.0003663270),
(r_D33_eviction_count_i > 3.5) => 0.0770106163,
(r_D33_eviction_count_i = NULL) => 0.0082253082, 0.0001561852);

// Tree: 159 
wFDN_FL__SD_lgt_159 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1110200717,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 17.5) => 0.0004356237,
   (f_rel_homeover500_count_d > 17.5) => 0.1240342188,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_families and c_families <= 426.5) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 10.55) => -0.1086242579,
         (C_INC_100K_P > 10.55) => 0.0063597559,
         (C_INC_100K_P = NULL) => -0.0371167866, -0.0371167866),
      (c_families > 426.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 108.5) => 0.1638689321,
         (c_exp_prod > 108.5) => 0.0054087425,
         (c_exp_prod = NULL) => 0.0749088256, 0.0749088256),
      (c_families = NULL) => 0.0034258159, 0.0034258159), 0.0011040405),
(C_INC_100K_P = NULL) => 0.0117738237, 0.0019048016);

// Tree: 160 
wFDN_FL__SD_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.45) => -0.0036242201,
(r_C12_source_profile_d > 81.45) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 147.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0004408269,
      (f_util_adl_count_n > 3.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 139.5) => 0.0120139709,
         (f_prevaddrageoldest_d > 139.5) => 0.2983129103,
         (f_prevaddrageoldest_d = NULL) => 0.1343639450, 0.1343639450),
      (f_util_adl_count_n = NULL) => 0.0204268024, 0.0204268024),
   (c_sub_bus > 147.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 82) => 0.2727673376,
      (f_prevaddrcartheftindex_i > 82) => 0.0163245061,
      (f_prevaddrcartheftindex_i = NULL) => 0.1298078281, 0.1298078281),
   (c_sub_bus = NULL) => 0.0402935023, 0.0402935023),
(r_C12_source_profile_d = NULL) => -0.0030042845, -0.0002440031);

// Tree: 161 
wFDN_FL__SD_lgt_161 := map(
(NULL < c_retired2 and c_retired2 <= 68.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 457.5) => -0.0145696974,
   (f_liens_unrel_CJ_total_amt_i > 457.5) => -0.0713257960,
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0179600591, -0.0179600591),
(c_retired2 > 68.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 65) => 0.0772819639,
   (r_F00_dob_score_d > 65) => 
      map(
      (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 3.5) => 0.0008701462,
      (f_inq_Collection_count24_i > 3.5) => 
         map(
         (NULL < c_hval_40k_p and c_hval_40k_p <= 0.2) => 0.1424122501,
         (c_hval_40k_p > 0.2) => -0.0668164304,
         (c_hval_40k_p = NULL) => 0.0705300040, 0.0705300040),
      (f_inq_Collection_count24_i = NULL) => 0.0022848680, 0.0022848680),
   (r_F00_dob_score_d = NULL) => -0.0093578894, 0.0024622151),
(c_retired2 = NULL) => -0.0316916427, -0.0047214983);

// Tree: 162 
wFDN_FL__SD_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0006100849,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 10.6) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 16.5) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 16.15) => -0.0803838488,
         (C_INC_100K_P > 16.15) => 0.0656928770,
         (C_INC_100K_P = NULL) => -0.0270855840, -0.0270855840),
      (f_rel_incomeover25_count_d > 16.5) => 0.0866152573,
      (f_rel_incomeover25_count_d = NULL) => 0.0053219022, 0.0053219022),
   (c_vacant_p > 10.6) => 0.1198901735,
   (c_vacant_p = NULL) => 0.0392247580, 0.0392247580),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 65) => 0.0668075148,
   (c_larceny > 65) => -0.0426254045,
   (c_larceny = NULL) => 0.0141955344, 0.0141955344), 0.0004463080);

// Tree: 163 
wFDN_FL__SD_lgt_163 := map(
(NULL < c_civ_emp and c_civ_emp <= 42.25) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => -0.0753982247,
   (f_historical_count_d > 0.5) => -0.0098400424,
   (f_historical_count_d = NULL) => -0.0423763255, -0.0423763255),
(c_civ_emp > 42.25) => 
   map(
   (NULL < c_white_col and c_white_col <= 17.95) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 10.5) => 0.1498819090,
      (f_prevaddrlenofres_d > 10.5) => 0.0002502853,
      (f_prevaddrlenofres_d = NULL) => 0.0465219119, 0.0465219119),
   (c_white_col > 17.95) => -0.0005093870,
   (c_white_col = NULL) => 0.0004849239, 0.0004849239),
(c_civ_emp = NULL) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => -0.1100984551,
   (r_F00_dob_score_d > 98) => -0.0126038355,
   (r_F00_dob_score_d = NULL) => 0.1558320664, -0.0020936316), -0.0009630310);

// Tree: 164 
wFDN_FL__SD_lgt_164 := map(
(NULL < c_hh3_p and c_hh3_p <= 7.25) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 1.35) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 7.15) => 0.0847105893,
         (C_INC_200K_P > 7.15) => -0.0816353334,
         (C_INC_200K_P = NULL) => 0.0575279519, 0.0575279519),
      (c_highrent > 1.35) => -0.0159251893,
      (c_highrent = NULL) => 0.0196635529, 0.0196635529),
   (f_prevaddroccupantowned_i > 0.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.25) => 0.0354773806,
      (c_pop_35_44_p > 15.25) => 0.2633014614,
      (c_pop_35_44_p = NULL) => 0.1255473661, 0.1255473661),
   (f_prevaddroccupantowned_i = NULL) => 0.0302437326, 0.0302437326),
(c_hh3_p > 7.25) => 0.0000274610,
(c_hh3_p = NULL) => 0.0397627001, 0.0041062139);

// Tree: 165 
wFDN_FL__SD_lgt_165 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 9.5) => 
   map(
   (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0061480653,
   (f_rel_ageover20_count_d > 20.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 129.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39.5) => 0.0330336039,
         (f_mos_inq_banko_cm_lseen_d > 39.5) => 0.2056614839,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.1284332218, 0.1284332218),
      (c_for_sale > 129.5) => -0.0228583455,
      (c_for_sale = NULL) => 0.0669710226, 0.0669710226),
   (f_rel_ageover20_count_d = NULL) => 0.0073281487, 0.0073281487),
(f_rel_incomeover50_count_d > 9.5) => 
   map(
   (NULL < c_rnt250_p and c_rnt250_p <= 18.35) => -0.0156319362,
   (c_rnt250_p > 18.35) => -0.1059851397,
   (c_rnt250_p = NULL) => -0.0207426704, -0.0207426704),
(f_rel_incomeover50_count_d = NULL) => 0.0260921516, 0.0025066718);

// Tree: 166 
wFDN_FL__SD_lgt_166 := map(
(NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 8.15) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 27.15) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 12.1) => -0.0115449206,
         (c_lowrent > 12.1) => 0.1204972502,
         (c_lowrent = NULL) => 0.0159458264, 0.0159458264),
      (c_hh3_p > 27.15) => 
         map(
         (NULL < c_rental and c_rental <= 90.5) => 0.0607662583,
         (c_rental > 90.5) => 0.2857674806,
         (c_rental = NULL) => 0.1590861202, 0.1590861202),
      (c_hh3_p = NULL) => 0.0393116631, 0.0393116631),
   (c_hh1_p > 8.15) => -0.0023742950,
   (c_hh1_p = NULL) => 0.0096335356, 0.0004762754),
(f_inq_Auto_count24_i > 1.5) => -0.0387283996,
(f_inq_Auto_count24_i = NULL) => -0.0326186968, -0.0018503297);

// Tree: 167 
wFDN_FL__SD_lgt_167 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 5.75) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0326422116) => -0.0984646256,
      (f_add_curr_nhood_BUS_pct_i > 0.0326422116) => 0.0427759148,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0217564011, -0.0217564011),
   (c_hval_300k_p > 5.75) => 0.1280219691,
   (c_hval_300k_p = NULL) => 0.0340284001, 0.0340284001),
(r_C10_M_Hdr_FS_d > 8.5) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.05) => -0.0059262235,
   (c_hval_1000k_p > 41.05) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 4.4) => 0.1975256298,
      (c_famotf18_p > 4.4) => -0.0246495090,
      (c_famotf18_p = NULL) => 0.0880960838, 0.0880960838),
   (c_hval_1000k_p = NULL) => 0.0064006213, -0.0046030664),
(r_C10_M_Hdr_FS_d = NULL) => -0.0300388697, -0.0042005118);

// Tree: 168 
wFDN_FL__SD_lgt_168 := map(
(NULL < f_mos_liens_rel_CJ_lseen_d and f_mos_liens_rel_CJ_lseen_d <= 38) => -0.1357955991,
(f_mos_liens_rel_CJ_lseen_d > 38) => 
   map(
   (NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 5.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
         map(
         (NULL < c_rnt250_p and c_rnt250_p <= 53.55) => -0.0026965789,
         (c_rnt250_p > 53.55) => 
            map(
            (NULL < c_retail and c_retail <= 13.4) => -0.0026372532,
            (c_retail > 13.4) => 0.1947249310,
            (c_retail = NULL) => 0.0850792731, 0.0850792731),
         (c_rnt250_p = NULL) => 0.0155180975, -0.0014177569),
      (f_rel_felony_count_i > 4.5) => 0.0741673332,
      (f_rel_felony_count_i = NULL) => -0.0010444972, -0.0010444972),
   (f_hh_age_30_plus_d > 5.5) => -0.0433660333,
   (f_hh_age_30_plus_d = NULL) => -0.0023541763, -0.0023541763),
(f_mos_liens_rel_CJ_lseen_d = NULL) => 0.0407707235, -0.0026060660);

// Tree: 169 
wFDN_FL__SD_lgt_169 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 18.75) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 105) => 0.1465003790,
      (c_relig_indx > 105) => -0.0230756728,
      (c_relig_indx = NULL) => 0.0640459685, 0.0640459685),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 16.55) => -0.0060487642,
      (c_hval_150k_p > 16.55) => 0.0270734588,
      (c_hval_150k_p = NULL) => -0.0012304541, -0.0012304541),
   (r_D33_Eviction_Recency_d = NULL) => -0.0073311193, -0.0006619234),
(c_hval_80k_p > 18.75) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 2.5) => -0.0278855070,
   (f_srchfraudsrchcountyr_i > 2.5) => -0.1076095597,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0325045135, -0.0325045135),
(c_hval_80k_p = NULL) => 0.0141191101, -0.0024912540);

// Tree: 170 
wFDN_FL__SD_lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_amus_indx and c_amus_indx <= 168.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 125) => -0.0089331341,
         (f_prevaddrcartheftindex_i > 125) => 0.0938815131,
         (f_prevaddrcartheftindex_i = NULL) => 0.0294975835, 0.0294975835),
      (r_F00_dob_score_d > 98) => -0.0018313383,
      (r_F00_dob_score_d = NULL) => 0.0047782886, -0.0005647557),
   (c_amus_indx > 168.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 59) => 0.2301269637,
      (f_prevaddrmurderindex_i > 59) => -0.0062538914,
      (f_prevaddrmurderindex_i = NULL) => 0.1047423362, 0.1047423362),
   (c_amus_indx = NULL) => -0.0162156677, 0.0000651609),
(f_util_adl_count_n > 13.5) => 0.1026331850,
(f_util_adl_count_n = NULL) => 0.0152637795, 0.0009713915);

// Tree: 171 
wFDN_FL__SD_lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 47.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 0.85) => 0.1370338141,
   (c_pop_65_74_p > 0.85) => 
      map(
      (NULL < c_pop_85p_p and c_pop_85p_p <= 2.65) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 0.1112645741,
         (f_prevaddrlenofres_d > 3.5) => -0.0052571687,
         (f_prevaddrlenofres_d = NULL) => 0.0025250971, 0.0025250971),
      (c_pop_85p_p > 2.65) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 40.55) => 0.1725364541,
         (C_OWNOCC_P > 40.55) => 0.0408855945,
         (C_OWNOCC_P = NULL) => 0.0678658941, 0.0678658941),
      (c_pop_85p_p = NULL) => 0.0154213070, 0.0154213070),
   (c_pop_65_74_p = NULL) => 0.0238150417, 0.0187233232),
(f_mos_inq_banko_cm_lseen_d > 47.5) => -0.0012316724,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0132607558, 0.0023094061);

// Tree: 172 
wFDN_FL__SD_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 27878) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 38.55) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.02831632655) => 0.0034909704,
         (f_add_curr_nhood_VAC_pct_i > 0.02831632655) => 
            map(
            (NULL < c_hval_175k_p and c_hval_175k_p <= 1.2) => 0.0610133191,
            (c_hval_175k_p > 1.2) => 0.1775386199,
            (c_hval_175k_p = NULL) => 0.1022036580, 0.1022036580),
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0646530103, 0.0646530103),
      (c_rnt500_p > 38.55) => -0.0300545514,
      (c_rnt500_p = NULL) => 0.0339321314, 0.0339321314),
   (c_med_hhinc > 27878) => -0.0047419502,
   (c_med_hhinc = NULL) => -0.0031081874, -0.0031081874),
(c_pop_0_5_p > 20) => 0.1361080107,
(c_pop_0_5_p = NULL) => 0.0018731601, -0.0023561925);

// Tree: 173 
wFDN_FL__SD_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0068319086,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 3.05) => 0.1597474295,
      (c_construction > 3.05) => 0.0276109905,
      (c_construction = NULL) => 0.0872477904, 0.0872477904),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 153.5) => -0.0010666929,
      (r_C13_Curr_Addr_LRes_d > 153.5) => 
         map(
         (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 20.5) => 0.0399170950,
         (f_rel_ageover20_count_d > 20.5) => 0.1438932716,
         (f_rel_ageover20_count_d = NULL) => 0.0595570394, 0.0595570394),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0118778763, 0.0118778763),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0167296576, 0.0167296576),
(f_rel_felony_count_i = NULL) => 0.0021904789, -0.0034129726);

// Tree: 174 
wFDN_FL__SD_lgt_174 := map(
(NULL < c_employees and c_employees <= 6.5) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 162) => -0.0615548367,
   (c_rich_nfam > 162) => 0.0693422139,
   (c_rich_nfam = NULL) => -0.0414666755, -0.0414666755),
(c_employees > 6.5) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 14.5) => -0.1144887179,
   (f_mos_liens_unrel_CJ_fseen_d > 14.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 18.5) => 0.1191812317,
      (f_mos_liens_unrel_CJ_lseen_d > 18.5) => 
         map(
         (NULL < c_white_col and c_white_col <= 11.6) => 0.1063541414,
         (c_white_col > 11.6) => 0.0037474510,
         (c_white_col = NULL) => 0.0041834815, 0.0041834815),
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0047282179, 0.0047282179),
   (f_mos_liens_unrel_CJ_fseen_d = NULL) => -0.0214000125, 0.0039802610),
(c_employees = NULL) => -0.0080735976, 0.0022325604);

// Tree: 175 
wFDN_FL__SD_lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 12.55) => 0.0868439387,
   (c_white_col > 12.55) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 73.5) => -0.0533669461,
         (c_many_cars > 73.5) => 0.0077082227,
         (c_many_cars = NULL) => -0.0175122294, -0.0175122294),
      (r_C14_Addr_Stability_v2_d > 2.5) => -0.0087210651,
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0102973734, -0.0102973734),
   (c_white_col = NULL) => 0.0179341973, -0.0089721949),
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.1650750062,
   (f_adl_per_email_i > 0.5) => -0.0798242800,
   (f_adl_per_email_i = NULL) => 0.0209274049, 0.0217031631),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0005617738, -0.0021347250);

// Tree: 176 
wFDN_FL__SD_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 0.0083119455,
(c_pop_18_24_p > 11.15) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 34.3) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 2.15) => 
         map(
         (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 0.5) => 0.0248438815,
         (f_divssnidmsrcurelcount_i > 0.5) => -0.0654475316,
         (f_divssnidmsrcurelcount_i = NULL) => -0.0505027460, -0.0505027460),
      (c_hval_175k_p > 2.15) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 12.5) => 0.1149465761,
         (r_C10_M_Hdr_FS_d > 12.5) => -0.0116119949,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0074760939, -0.0074760939),
      (c_hval_175k_p = NULL) => -0.0260568683, -0.0260568683),
   (c_hh3_p > 34.3) => 0.0954685311,
   (c_hh3_p = NULL) => -0.0232072468, -0.0232072468),
(c_pop_18_24_p = NULL) => 0.0110159312, 0.0014887769);

// Tree: 177 
wFDN_FL__SD_lgt_177 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 37.75) => 
   map(
   (NULL < c_retired and c_retired <= 1.15) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 6.85) => -0.0111755105,
      (c_pop_45_54_p > 6.85) => 0.2044783284,
      (c_pop_45_54_p = NULL) => 0.0817787304, 0.0817787304),
   (c_retired > 1.15) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 115.5) => -0.0050070010,
      (c_many_cars > 115.5) => 0.0190753647,
      (c_many_cars = NULL) => 0.0051713801, 0.0051713801),
   (c_retired = NULL) => 0.0059026550, 0.0059026550),
(C_INC_15K_P > 37.75) => 
   map(
   (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => -0.0871532125,
   (f_prevaddrstatus_i > 2.5) => -0.0985814730,
   (f_prevaddrstatus_i = NULL) => 0.0360239057, -0.0511409161),
(C_INC_15K_P = NULL) => -0.0076190283, 0.0045316515);

// Tree: 178 
wFDN_FL__SD_lgt_178 := map(
(NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 3.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 14.05) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 2.5) => -0.0625350424,
      (f_addrs_per_ssn_i > 2.5) => -0.0001808924,
      (f_addrs_per_ssn_i = NULL) => -0.0055910990, -0.0055910990),
   (c_rnt1250_p > 14.05) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 20.25) => 0.0454748177,
      (c_hh1_p > 20.25) => 0.0010865502,
      (c_hh1_p = NULL) => 0.0208616002, 0.0208616002),
   (c_rnt1250_p = NULL) => -0.0024805874, 0.0021486491),
(f_rel_ageover50_count_d > 3.5) => -0.0628149527,
(f_rel_ageover50_count_d = NULL) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 9.35) => -0.0126462965,
   (C_INC_150K_P > 9.35) => 0.1039079244,
   (C_INC_150K_P = NULL) => 0.0095366036, 0.0095366036), 0.0003331793);

// Tree: 179 
wFDN_FL__SD_lgt_179 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 186) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 0.0117024910,
   (f_hh_criminals_i > 0.5) => -0.1254855296,
   (f_hh_criminals_i = NULL) => -0.0626076868, -0.0626076868),
(f_mos_liens_unrel_FT_lseen_d > 186) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 14701) => 0.1068824109,
   (c_med_hhinc > 14701) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 1.95) => -0.0672588396,
      (c_high_ed > 1.95) => 0.0011612491,
      (c_high_ed = NULL) => 0.0003966839, 0.0003966839),
   (c_med_hhinc = NULL) => 0.0084515112, 0.0010880565),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.55) => 0.1001621877,
   (c_hval_250k_p > 6.55) => -0.0154340065,
   (c_hval_250k_p = NULL) => 0.0429363490, 0.0429363490), 0.0006981858);

// Tree: 180 
wFDN_FL__SD_lgt_180 := map(
(NULL < c_civ_emp and c_civ_emp <= 43.65) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 10.25) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0946071303) => -0.0936182345,
      (f_add_curr_nhood_MFD_pct_i > 0.0946071303) => 
         map(
         (NULL < c_rnt250_p and c_rnt250_p <= 15.3) => 0.1211275630,
         (c_rnt250_p > 15.3) => -0.0167982661,
         (c_rnt250_p = NULL) => 0.0426525223, 0.0426525223),
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0011772533, -0.0011772533),
   (c_high_ed > 10.25) => -0.0819555542,
   (c_high_ed = NULL) => -0.0523792472, -0.0523792472),
(c_civ_emp > 43.65) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 186.5) => 0.0045114618,
   (c_old_homes > 186.5) => -0.0453070643,
   (c_old_homes = NULL) => 0.0020362677, 0.0020362677),
(c_civ_emp = NULL) => 0.0293375041, 0.0005070514);

// Tree: 181 
wFDN_FL__SD_lgt_181 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 6.45) => -0.0163876035,
   (c_lowrent > 6.45) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.85) => 0.0197258273,
      (c_incollege > 6.85) => 
         map(
         (NULL < c_rich_blk and c_rich_blk <= 174) => 
            map(
            (NULL < c_occunit_p and c_occunit_p <= 94.35) => 0.0326905633,
            (c_occunit_p > 94.35) => 0.1837972490,
            (c_occunit_p = NULL) => 0.0667003301, 0.0667003301),
         (c_rich_blk > 174) => 0.2271632195,
         (c_rich_blk = NULL) => 0.0870575624, 0.0870575624),
      (c_incollege = NULL) => 0.0400010014, 0.0400010014),
   (c_lowrent = NULL) => -0.0254272489, 0.0168120614),
(k_estimated_income_d > 28500) => -0.0077217199,
(k_estimated_income_d = NULL) => 0.0171534185, -0.0032592331);

// Tree: 182 
wFDN_FL__SD_lgt_182 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 17.35) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0021373397,
      (r_C14_Addr_Stability_v2_d > 5.5) => 0.0073306175,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0019411039, 0.0019411039),
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 1.5) => -0.0283956742,
      (f_assocrisktype_i > 1.5) => 0.1109938998,
      (f_assocrisktype_i = NULL) => 0.0506396513, 0.0506396513),
   (f_inq_Other_count24_i = NULL) => -0.0109502330, 0.0026153967),
(c_pop_0_5_p > 17.35) => 
   map(
   (NULL < c_totsales and c_totsales <= 1523.5) => -0.1372909854,
   (c_totsales > 1523.5) => -0.0218482605,
   (c_totsales = NULL) => -0.0731561383, -0.0731561383),
(c_pop_0_5_p = NULL) => 0.0005870448, 0.0016013478);

// Tree: 183 
wFDN_FL__SD_lgt_183 := map(
(NULL < c_fammar_p and c_fammar_p <= 15.75) => 0.0677714511,
(c_fammar_p > 15.75) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 7.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 14.5) => -0.0595194705,
         (c_exp_prod > 14.5) => -0.0041841876,
         (c_exp_prod = NULL) => -0.0053218182, -0.0053218182),
      (k_inq_per_ssn_i > 7.5) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 7.5) => 0.1480171594,
         (f_inq_count_i > 7.5) => 0.0020771517,
         (f_inq_count_i = NULL) => 0.0434398277, 0.0434398277),
      (k_inq_per_ssn_i = NULL) => -0.0045684782, -0.0045684782),
   (f_srchfraudsrchcountyr_i > 7.5) => -0.0664152593,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0086611032, -0.0049357937),
(c_fammar_p = NULL) => -0.0056005120, -0.0045055907);

// Tree: 184 
wFDN_FL__SD_lgt_184 := map(
(NULL < c_bel_edu and c_bel_edu <= 198.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => -0.0000713997,
   (f_util_adl_count_n > 7.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 117.5) => 0.2188590388,
         (r_A50_pb_total_dollars_d > 117.5) => 0.0387624595,
         (r_A50_pb_total_dollars_d = NULL) => 0.0940193645, 0.0940193645),
      (k_estimated_income_d > 33500) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 127) => -0.0597673532,
         (c_asian_lang > 127) => 0.0605650783,
         (c_asian_lang = NULL) => 0.0086182909, 0.0086182909),
      (k_estimated_income_d = NULL) => 0.0363500049, 0.0363500049),
   (f_util_adl_count_n = NULL) => -0.0045703936, 0.0014944665),
(c_bel_edu > 198.5) => -0.1144746244,
(c_bel_edu = NULL) => 0.0052582317, 0.0010434950);

// Tree: 185 
wFDN_FL__SD_lgt_185 := map(
(NULL < c_for_sale and c_for_sale <= 163.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 6.45) => -0.0487991148,
      (c_pop_0_5_p > 6.45) => 
         map(
         (NULL < c_retired and c_retired <= 7.6) => -0.0021827127,
         (c_retired > 7.6) => 
            map(
            (NULL < c_blue_col and c_blue_col <= 12.55) => 0.0397695244,
            (c_blue_col > 12.55) => 0.2287734411,
            (c_blue_col = NULL) => 0.1513860106, 0.1513860106),
         (c_retired = NULL) => 0.0988702814, 0.0988702814),
      (c_pop_0_5_p = NULL) => 0.0563676508, 0.0563676508),
   (r_I61_inq_collection_recency_d > 4.5) => 0.0066598616,
   (r_I61_inq_collection_recency_d = NULL) => -0.0026880269, 0.0079160397),
(c_for_sale > 163.5) => -0.0208158271,
(c_for_sale = NULL) => -0.0018959042, 0.0025488384);

// Tree: 186 
wFDN_FL__SD_lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 14.45) => 
      map(
      (NULL < c_robbery and c_robbery <= 117.5) => 0.0018595180,
      (c_robbery > 117.5) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 4.5) => 0.0244623557,
         (f_rel_homeover300_count_d > 4.5) => 
            map(
            (NULL < r_wealth_index_d and r_wealth_index_d <= 1.5) => 0.1878279730,
            (r_wealth_index_d > 1.5) => 0.0893965730,
            (r_wealth_index_d = NULL) => 0.1093953337, 0.1093953337),
         (f_rel_homeover300_count_d = NULL) => 0.0450422696, 0.0450422696),
      (c_robbery = NULL) => 0.0174728256, 0.0174728256),
   (C_INC_75K_P > 14.45) => -0.0078320040,
   (C_INC_75K_P = NULL) => 0.0101943091, 0.0000174162),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0834857556,
(f_inq_PrepaidCards_count_i = NULL) => 0.0272605638, 0.0005575770);

// Tree: 187 
wFDN_FL__SD_lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < f_mos_liens_unrel_OT_lseen_d and f_mos_liens_unrel_OT_lseen_d <= 9.5) => 0.0977877876,
   (f_mos_liens_unrel_OT_lseen_d > 9.5) => 
      map(
      (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 1.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 52.5) => 
            map(
            (NULL < c_child and c_child <= 30.65) => -0.0339843404,
            (c_child > 30.65) => 0.1359731400,
            (c_child = NULL) => -0.0110171133, -0.0110171133),
         (k_comb_age_d > 52.5) => 0.1970127131,
         (k_comb_age_d = NULL) => 0.0187014333, 0.0187014333),
      (r_C20_email_verification_d > 1.5) => -0.0958165748,
      (r_C20_email_verification_d = NULL) => -0.0010234693, -0.0015419069),
   (f_mos_liens_unrel_OT_lseen_d = NULL) => -0.0011342939, -0.0011342939),
(f_rel_bankrupt_count_i > 7.5) => -0.0743822691,
(f_rel_bankrupt_count_i = NULL) => -0.0014338703, -0.0020604851);

// Tree: 188 
wFDN_FL__SD_lgt_188 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 27.35) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.40149593995) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 118175.5) => 0.1008040163,
      (r_A46_Curr_AVM_AutoVal_d > 118175.5) => -0.0298969928,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 1.5) => -0.0775107752,
         (f_rel_educationover12_count_d > 1.5) => 0.0011114431,
         (f_rel_educationover12_count_d = NULL) => -0.0149659183, -0.0149659183), -0.0103555234),
   (f_add_curr_nhood_SFD_pct_d > 0.40149593995) => 
      map(
      (NULL < c_retail and c_retail <= 21) => -0.0883509064,
      (c_retail > 21) => 0.0679974034,
      (c_retail = NULL) => -0.0618511929, -0.0618511929),
   (f_add_curr_nhood_SFD_pct_d = NULL) => -0.0216501127, -0.0216501127),
(C_OWNOCC_P > 27.35) => 0.0044434866,
(C_OWNOCC_P = NULL) => -0.0243620005, 0.0009708291);

// Tree: 189 
wFDN_FL__SD_lgt_189 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 105500) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 13.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0018178077,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 32.5) => 0.0391484031,
         (c_no_labfor > 32.5) => -0.0860207539,
         (c_no_labfor = NULL) => -0.0679343849, -0.0679343849),
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0041802724, -0.0041802724),
   (f_rel_homeover500_count_d > 13.5) => 0.0827571587,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 6.75) => -0.0788105271,
      (c_vacant_p > 6.75) => 0.0660867948,
      (c_vacant_p = NULL) => -0.0016761318, -0.0016761318), -0.0035003758),
(k_estimated_income_d > 105500) => 0.1548390090,
(k_estimated_income_d = NULL) => -0.0101696048, -0.0028273944);

// Tree: 190 
wFDN_FL__SD_lgt_190 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 7.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0078468218,
   (k_inq_per_ssn_i > 3.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 13.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 120.5) => 0.0606599254,
         (c_robbery > 120.5) => 
            map(
            (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 0.5) => -0.0469539452,
            (f_rel_ageover50_count_d > 0.5) => 0.1001999861,
            (f_rel_ageover50_count_d = NULL) => -0.0093356470, -0.0093356470),
         (c_robbery = NULL) => 0.0375309536, 0.0375309536),
      (f_rel_homeover300_count_d > 13.5) => -0.1029024002,
      (f_rel_homeover300_count_d = NULL) => 0.0278570142, 0.0278570142),
   (k_inq_per_ssn_i = NULL) => -0.0053075404, -0.0053075404),
(f_inq_Banking_count24_i > 7.5) => -0.1092399997,
(f_inq_Banking_count24_i = NULL) => -0.0056950605, -0.0058102666);

// Tree: 191 
wFDN_FL__SD_lgt_191 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 12.05) => 
      map(
      (NULL < c_rental and c_rental <= 138.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 124) => 0.0650254534,
         (c_no_teens > 124) => -0.0658285364,
         (c_no_teens = NULL) => 0.0161993378, 0.0161993378),
      (c_rental > 138.5) => 0.1656479468,
      (c_rental = NULL) => 0.0634738978, 0.0634738978),
   (c_incollege > 12.05) => -0.1045471341,
   (c_incollege = NULL) => 0.0293232816, 0.0293232816),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < c_retail and c_retail <= 17.05) => -0.0091741134,
   (c_retail > 17.05) => 0.0147990996,
   (c_retail = NULL) => -0.0326608645, -0.0030772999),
(r_C10_M_Hdr_FS_d = NULL) => -0.0399713955, -0.0027179532);

// Tree: 192 
wFDN_FL__SD_lgt_192 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 5.45) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 56.35) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 176.5) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 38.95) => -0.0361922315,
         (c_hh2_p > 38.95) => 0.0729989140,
         (c_hh2_p = NULL) => -0.0225433383, -0.0225433383),
      (f_prevaddrageoldest_d > 176.5) => -0.1044841153,
      (f_prevaddrageoldest_d = NULL) => -0.0381017137, -0.0381017137),
   (c_fammar_p > 56.35) => -0.0080893634,
   (c_fammar_p = NULL) => -0.0107253105, -0.0107253105),
(c_femdiv_p > 5.45) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 4.5) => 0.0561422233,
   (r_C13_Curr_Addr_LRes_d > 4.5) => 0.0058160451,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0108282296, 0.0108282296),
(c_femdiv_p = NULL) => -0.0119292482, -0.0035986270);

// Tree: 193 
wFDN_FL__SD_lgt_193 := map(
(NULL < c_hh2_p and c_hh2_p <= 16.95) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 0.35) => 0.1052144215,
   (c_pop_75_84_p > 0.35) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 34.95) => 
         map(
         (NULL < c_rich_asian and c_rich_asian <= 187.5) => -0.0290250830,
         (c_rich_asian > 187.5) => 0.1153524542,
         (c_rich_asian = NULL) => -0.0072197799, -0.0072197799),
      (c_lowrent > 34.95) => 
         map(
         (NULL < c_rnt500_p and c_rnt500_p <= 36.85) => 0.1665570481,
         (c_rnt500_p > 36.85) => 0.0155251649,
         (c_rnt500_p = NULL) => 0.0772142440, 0.0772142440),
      (c_lowrent = NULL) => 0.0134877009, 0.0134877009),
   (c_pop_75_84_p = NULL) => 0.0258276185, 0.0258276185),
(c_hh2_p > 16.95) => -0.0036948461,
(c_hh2_p = NULL) => -0.0204033096, -0.0025356365);

// Tree: 194 
wFDN_FL__SD_lgt_194 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 8.5) => -0.0030630071,
   (f_addrs_per_ssn_i > 8.5) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 44.45) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 0.35) => 0.0650041096,
         (c_hval_250k_p > 0.35) => 0.0110199194,
         (c_hval_250k_p = NULL) => 0.0235044289, 0.0235044289),
      (c_hval_400k_p > 44.45) => 0.1987191561,
      (c_hval_400k_p = NULL) => 0.0282944718, 0.0282944718),
   (f_addrs_per_ssn_i = NULL) => 0.0060724312, 0.0060724312),
(r_C18_invalid_addrs_per_adl_i > 1.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 26.15) => -0.0992708377,
   (c_fammar_p > 26.15) => -0.0122418272,
   (c_fammar_p = NULL) => -0.0110997848, -0.0132332525),
(r_C18_invalid_addrs_per_adl_i = NULL) => 0.0058952601, -0.0020865529);

// Tree: 195 
wFDN_FL__SD_lgt_195 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 3.95) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 12.5) => 0.0638910612,
   (r_C21_M_Bureau_ADL_FS_d > 12.5) => -0.0131648539,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0401846968, -0.0111481633),
(c_rnt1250_p > 3.95) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 4.55) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 7.55) => 0.2620922131,
      (c_pop_18_24_p > 7.55) => 0.0010716496,
      (c_pop_18_24_p = NULL) => 0.1178920416, 0.1178920416),
   (c_rnt1250_p > 4.55) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 8.25) => 0.1018058978,
      (c_fammar18_p > 8.25) => 0.0065750503,
      (c_fammar18_p = NULL) => 0.0097176025, 0.0097176025),
   (c_rnt1250_p = NULL) => 0.0123257537, 0.0123257537),
(c_rnt1250_p = NULL) => 0.0238823775, 0.0007082454);

// Tree: 196 
wFDN_FL__SD_lgt_196 := map(
(NULL < c_lowrent and c_lowrent <= 90.35) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 24) => -0.0916453884,
   (f_mos_inq_banko_am_lseen_d > 24) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 74.85) => -0.0042629108,
      (c_rnt1000_p > 74.85) => 0.0802196142,
      (c_rnt1000_p = NULL) => -0.0027008081, -0.0027008081),
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0111879191, -0.0043338195),
(c_lowrent > 90.35) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 317) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 14.75) => 0.1421026898,
      (C_INC_75K_P > 14.75) => -0.0410112031,
      (C_INC_75K_P = NULL) => 0.0186778559, 0.0186778559),
   (r_C21_M_Bureau_ADL_FS_d > 317) => 0.2266743732,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0691539982, 0.0691539982),
(c_lowrent = NULL) => -0.0010301213, -0.0028455749);

// Tree: 197 
wFDN_FL__SD_lgt_197 := map(
(NULL < c_rest_indx and c_rest_indx <= 112.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 10.15) => -0.0149339386,
   (c_hh4_p > 10.15) => 0.0237314445,
   (c_hh4_p = NULL) => 0.0129214668, 0.0129214668),
(c_rest_indx > 112.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.25) => -0.0242493226,
   (r_C12_source_profile_d > 78.25) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.48345868125) => 0.0225253011,
      (f_add_curr_nhood_MFD_pct_i > 0.48345868125) => 
         map(
         (NULL < c_burglary and c_burglary <= 90) => 0.3037668195,
         (c_burglary > 90) => 0.0362190557,
         (c_burglary = NULL) => 0.1612413752, 0.1612413752),
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0369747533, 0.0284857894),
   (r_C12_source_profile_d = NULL) => -0.0156769545, -0.0156769545),
(c_rest_indx = NULL) => 0.0011549377, 0.0003101078);

// Tree: 198 
wFDN_FL__SD_lgt_198 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0317759084,
(r_A50_pb_average_dollars_d > 24.5) => 
   map(
   (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 1124.5) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 159.5) => -0.0000259466,
      (c_very_rich > 159.5) => 
         map(
         (NULL < c_rich_hisp and c_rich_hisp <= 171) => 0.0064631446,
         (c_rich_hisp > 171) => 
            map(
            (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0703222876,
            (f_rel_incomeover75_count_d > 0.5) => 0.0897734028,
            (f_rel_incomeover75_count_d = NULL) => 0.0709952616, 0.0709952616),
         (c_rich_hisp = NULL) => 0.0242134213, 0.0242134213),
      (c_very_rich = NULL) => -0.0174476690, 0.0048798308),
   (f_liens_unrel_ST_total_amt_i > 1124.5) => 0.0996549283,
   (f_liens_unrel_ST_total_amt_i = NULL) => 0.0056691282, 0.0056691282),
(r_A50_pb_average_dollars_d = NULL) => 0.0049593964, 0.0014632384);

// Tree: 199 
wFDN_FL__SD_lgt_199 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => -0.0011549769,
   (r_D30_Derog_Count_i > 18.5) => -0.0778334500,
   (r_D30_Derog_Count_i = NULL) => -0.0198755949, -0.0016436894),
(c_hh6_p > 11.05) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 54.5) => -0.0703697060,
   (c_rest_indx > 54.5) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.1600517458,
      (r_Prop_Owner_History_d > 0.5) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 74750) => -0.0047324853,
         (f_prevaddrmedianincome_d > 74750) => 0.1727281140,
         (f_prevaddrmedianincome_d = NULL) => 0.0379263126, 0.0379263126),
      (r_Prop_Owner_History_d = NULL) => 0.0699734121, 0.0699734121),
   (c_rest_indx = NULL) => 0.0458327591, 0.0458327591),
(c_hh6_p = NULL) => -0.0206524937, -0.0008199828);

// Tree: 200 
wFDN_FL__SD_lgt_200 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 20.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 36.65) => 
      map(
      (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 40.5) => -0.0910476104,
      (f_mos_inq_banko_am_lseen_d > 40.5) => 
         map(
         (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 17.5) => 
            map(
            (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 0.0002169148,
            (f_hh_collections_ct_i > 4.5) => 0.0661262182,
            (f_hh_collections_ct_i = NULL) => 0.0010890716, 0.0010890716),
         (f_rel_incomeover50_count_d > 17.5) => -0.0430565541,
         (f_rel_incomeover50_count_d = NULL) => 0.0060213083, -0.0004108186),
      (f_mos_inq_banko_am_lseen_d = NULL) => -0.0023852329, -0.0023852329),
   (c_hval_200k_p > 36.65) => 0.1178956446,
   (c_hval_200k_p = NULL) => -0.0535958471, -0.0031636943),
(f_srchssnsrchcount_i > 20.5) => -0.0663710469,
(f_srchssnsrchcount_i = NULL) => 0.0171725181, -0.0033481033);

// Tree: 201 
wFDN_FL__SD_lgt_201 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.103756515) => 0.0049903905,
      (f_add_curr_nhood_VAC_pct_i > 0.103756515) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0832430034,
         (r_E57_br_source_count_d > 0.5) => -0.0395228745,
         (r_E57_br_source_count_d = NULL) => 0.0488772031, 0.0488772031),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0119827354, 0.0119827354),
   (k_estimated_income_d > 32500) => -0.0079182662,
   (k_estimated_income_d = NULL) => -0.0021586404, -0.0021586404),
(f_prevaddrcartheftindex_i > 194.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 10.55) => -0.0297044514,
   (c_pop_0_5_p > 10.55) => -0.1475005539,
   (c_pop_0_5_p = NULL) => -0.0524754452, -0.0524754452),
(f_prevaddrcartheftindex_i = NULL) => -0.0019021518, -0.0032316583);

// Tree: 202 
wFDN_FL__SD_lgt_202 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 68.3) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => -0.0388601315,
   (f_mos_inq_banko_om_fseen_d > 14.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.05) => -0.0183006689,
         (c_pop_35_44_p > 14.05) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 53.5) => 0.2561433666,
            (c_span_lang > 53.5) => 0.0755775176,
            (c_span_lang = NULL) => 0.0970223928, 0.0970223928),
         (c_pop_35_44_p = NULL) => 0.0469560636, 0.0469560636),
      (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0025852496,
      (f_mos_inq_banko_om_fseen_d = NULL) => 0.0006361048, 0.0006361048),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0226503817, -0.0019785792),
(c_hval_1001k_p > 68.3) => 0.1450783625,
(c_hval_1001k_p = NULL) => 0.0279822237, -0.0003814215);

// Tree: 203 
wFDN_FL__SD_lgt_203 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 11.55) => -0.0090162161,
(c_rnt1250_p > 11.55) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 153066.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
         map(
         (NULL < c_hval_500k_p and c_hval_500k_p <= 44.35) => 
            map(
            (NULL < c_white_col and c_white_col <= 20.45) => 0.0713018883,
            (c_white_col > 20.45) => 0.0014191985,
            (c_white_col = NULL) => 0.0038265049, 0.0038265049),
         (c_hval_500k_p > 44.35) => 0.1046855011,
         (c_hval_500k_p = NULL) => 0.0059277340, 0.0059277340),
      (f_inq_Communications_count24_i > 1.5) => 0.0785980488,
      (f_inq_Communications_count24_i = NULL) => 0.0073242203, 0.0073242203),
   (f_curraddrmedianincome_d > 153066.5) => 0.2217503516,
   (f_curraddrmedianincome_d = NULL) => 0.0099008380, 0.0099008380),
(c_rnt1250_p = NULL) => -0.0256801882, -0.0031492667);

// Tree: 204 
wFDN_FL__SD_lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 9.25) => -0.0255428118,
      (c_pop_18_24_p > 9.25) => 0.0628929580,
      (c_pop_18_24_p = NULL) => 0.0115431562, 0.0115431562),
   (r_C14_Addr_Stability_v2_d > 1.5) => 0.0011072463,
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0016968505, 0.0016968505),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 10.45) => -0.0460091946,
   (c_pop_0_5_p > 10.45) => -0.1080333944,
   (c_pop_0_5_p = NULL) => -0.0612506362, -0.0612506362),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 101) => 0.0451356018,
   (c_robbery > 101) => -0.0705891533,
   (c_robbery = NULL) => -0.0110735650, -0.0110735650), 0.0001301973);

// Tree: 205 
wFDN_FL__SD_lgt_205 := map(
(NULL < c_for_sale and c_for_sale <= 108.5) => -0.0093614934,
(c_for_sale > 108.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21111.5) => 0.1123659106,
   (r_A46_Curr_AVM_AutoVal_d > 21111.5) => 0.0131712489,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 13.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 25.5) => 
            map(
            (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 5.5) => 0.0220511499,
            (f_corrssnnamecount_d > 5.5) => 0.1441759016,
            (f_corrssnnamecount_d = NULL) => 0.0614588174, 0.0614588174),
         (c_born_usa > 25.5) => 0.0016188014,
         (c_born_usa = NULL) => 0.0100065869, 0.0100065869),
      (f_inq_count_i > 13.5) => 0.1125015209,
      (f_inq_count_i = NULL) => 0.0129490252, 0.0129490252), 0.0139581321),
(c_for_sale = NULL) => -0.0143565959, 0.0018119896);

// Tree: 206 
wFDN_FL__SD_lgt_206 := map(
(NULL < c_pop_12_17_p and c_pop_12_17_p <= 16.75) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 929.5) => -0.0105678684,
   (c_hh00 > 929.5) => 
      map(
      (NULL < c_totsales and c_totsales <= 57796.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.00629088655) => -0.0474919203,
         (f_add_curr_nhood_BUS_pct_i > 0.00629088655) => 
            map(
            (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 1.5) => 0.0524621467,
            (f_divssnidmsrcurelcount_i > 1.5) => 0.2267684718,
            (f_divssnidmsrcurelcount_i = NULL) => 0.0613813300, 0.0613813300),
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0458865163, 0.0458865163),
      (c_totsales > 57796.5) => -0.0274539513,
      (c_totsales = NULL) => 0.0180822304, 0.0180822304),
   (c_hh00 = NULL) => -0.0044761685, -0.0044761685),
(c_pop_12_17_p > 16.75) => 0.0775144386,
(c_pop_12_17_p = NULL) => 0.0173725008, -0.0033712614);

// Tree: 207 
wFDN_FL__SD_lgt_207 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0020190535,
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 20.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.23382248165) => 0.0016501119,
      (f_add_curr_mobility_index_i > 0.23382248165) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 16.75) => 
            map(
            (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 137243) => -0.0930005458,
            (f_prevaddrmedianvalue_d > 137243) => -0.0198279570,
            (f_prevaddrmedianvalue_d = NULL) => -0.0471224941, -0.0471224941),
         (c_hval_175k_p > 16.75) => 0.0536654057,
         (c_hval_175k_p = NULL) => -0.0329205627, -0.0329205627),
      (f_add_curr_mobility_index_i = NULL) => -0.0244554832, -0.0244554832),
   (f_rel_homeover100_count_d > 20.5) => -0.1381476620,
   (f_rel_homeover100_count_d = NULL) => -0.0333376846, -0.0333376846),
(f_varrisktype_i = NULL) => -0.0154073956, -0.0000236144);

// Tree: 208 
wFDN_FL__SD_lgt_208 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 47.8) => 
   map(
   (NULL < c_totsales and c_totsales <= 969.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => -0.0179790492,
      (f_inq_HighRiskCredit_count24_i > 2.5) => -0.0852624212,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0192601680, -0.0192601680),
   (c_totsales > 969.5) => 
      map(
      (NULL < c_employees and c_employees <= 18.5) => 0.1821210164,
      (c_employees > 18.5) => 
         map(
         (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 17.5) => 0.0015605607,
         (f_srchssnsrchcount_i > 17.5) => 0.0634794646,
         (f_srchssnsrchcount_i = NULL) => 0.0026662626, 0.0020841825),
      (c_employees = NULL) => 0.0030253055, 0.0030253055),
   (c_totsales = NULL) => -0.0019553657, -0.0019553657),
(c_hval_100k_p > 47.8) => 0.0923660975,
(c_hval_100k_p = NULL) => 0.0037646658, -0.0013009431);

// Tree: 209 
wFDN_FL__SD_lgt_209 := map(
(NULL < c_popover25 and c_popover25 <= 6354) => 
   map(
   (NULL < f_liens_unrel_ST_ct_i and f_liens_unrel_ST_ct_i <= 2.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.85) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 5.85) => 0.0074298708,
         (c_pop_65_74_p > 5.85) => 0.0796468193,
         (c_pop_65_74_p = NULL) => 0.0273710669, 0.0273710669),
      (c_hh2_p > 17.85) => -0.0021975068,
      (c_hh2_p = NULL) => -0.0003103582, -0.0003103582),
   (f_liens_unrel_ST_ct_i > 2.5) => 0.0915979835,
   (f_liens_unrel_ST_ct_i = NULL) => -0.0062539687, 0.0001643954),
(c_popover25 > 6354) => 0.1473661702,
(c_popover25 = NULL) => 
   map(
   (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => -0.0280471061,
   (f_property_owners_ct_d > 0.5) => 0.1268108351,
   (f_property_owners_ct_d = NULL) => 0.0185114906, 0.0185114906), 0.0013540025);

// Tree: 210 
wFDN_FL__SD_lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0010052271,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < c_retired and c_retired <= 4.25) => 0.0591206373,
   (c_retired > 4.25) => 
      map(
      (NULL < c_no_move and c_no_move <= 58.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 9.55) => -0.1025324155,
         (C_INC_150K_P > 9.55) => 0.0359268725,
         (C_INC_150K_P = NULL) => -0.0723011299, -0.0723011299),
      (c_no_move > 58.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 46.5) => -0.0778400103,
         (c_many_cars > 46.5) => 0.0201788230,
         (c_many_cars = NULL) => -0.0090874637, -0.0090874637),
      (c_no_move = NULL) => -0.0419873036, -0.0419873036),
   (c_retired = NULL) => -0.0289734102, -0.0289734102),
(f_srchfraudsrchcount_i = NULL) => -0.0094886923, -0.0002703809);

// Tree: 211 
wFDN_FL__SD_lgt_211 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 8.25) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.06331075715) => 0.0081777150,
   (f_add_curr_nhood_VAC_pct_i > 0.06331075715) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.29941229765) => 0.1588800322,
      (f_add_curr_mobility_index_i > 0.29941229765) => 0.0128283717,
      (f_add_curr_mobility_index_i = NULL) => 0.0774604284, 0.0774604284),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0349670308, 0.0349670308),
(c_fammar18_p > 8.25) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 1.5) => -0.0013717843,
   (r_D34_unrel_liens_ct_i > 1.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2067589861) => 0.0476511940,
      (f_add_curr_mobility_index_i > 0.2067589861) => -0.0547988187,
      (f_add_curr_mobility_index_i = NULL) => -0.0271130743, -0.0271130743),
   (r_D34_unrel_liens_ct_i = NULL) => -0.0172330242, -0.0032272106),
(c_fammar18_p = NULL) => 0.0157659163, -0.0014335322);

// Tree: 212 
wFDN_FL__SD_lgt_212 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 18.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 58.35) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 109.5) => 0.2553814215,
      (c_lux_prod > 109.5) => -0.0292510595,
      (c_lux_prod = NULL) => 0.0700837661, 0.0700837661),
   (c_occunit_p > 58.35) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2079.5) => 0.0002661431,
      (f_liens_unrel_SC_total_amt_i > 2079.5) => -0.0574160715,
      (f_liens_unrel_SC_total_amt_i = NULL) => -0.0005407355, -0.0005407355),
   (c_occunit_p = NULL) => -0.0122720197, -0.0000061644),
(f_srchfraudsrchcount_i > 18.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 82) => 0.1057910115,
   (c_born_usa > 82) => -0.0198587485,
   (c_born_usa = NULL) => 0.0475352137, 0.0475352137),
(f_srchfraudsrchcount_i = NULL) => 0.0032844503, 0.0004324148);

// Tree: 213 
wFDN_FL__SD_lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 23.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 12.95) => 0.0119399127,
      (C_INC_25K_P > 12.95) => 0.1649664335,
      (C_INC_25K_P = NULL) => 0.0891424818, 0.0891424818),
   (c_many_cars > 23.5) => 
      map(
      (NULL < c_work_home and c_work_home <= 70.5) => -0.0212837948,
      (c_work_home > 70.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 4.65) => 0.1993235429,
         (c_hh3_p > 4.65) => 0.0393969889,
         (c_hh3_p = NULL) => 0.0446556957, 0.0446556957),
      (c_work_home = NULL) => 0.0218326258, 0.0218326258),
   (c_many_cars = NULL) => 0.0248416448, 0.0248416448),
(r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0082016518,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0035968923, 0.0033987380);

// Final Score Sum 

   wFDN_FL__SD_lgt := sum(
      wFDN_FL__SD_lgt_0, wFDN_FL__SD_lgt_1, wFDN_FL__SD_lgt_2, wFDN_FL__SD_lgt_3, wFDN_FL__SD_lgt_4, 
      wFDN_FL__SD_lgt_5, wFDN_FL__SD_lgt_6, wFDN_FL__SD_lgt_7, wFDN_FL__SD_lgt_8, wFDN_FL__SD_lgt_9, 
      wFDN_FL__SD_lgt_10, wFDN_FL__SD_lgt_11, wFDN_FL__SD_lgt_12, wFDN_FL__SD_lgt_13, wFDN_FL__SD_lgt_14, 
      wFDN_FL__SD_lgt_15, wFDN_FL__SD_lgt_16, wFDN_FL__SD_lgt_17, wFDN_FL__SD_lgt_18, wFDN_FL__SD_lgt_19, 
      wFDN_FL__SD_lgt_20, wFDN_FL__SD_lgt_21, wFDN_FL__SD_lgt_22, wFDN_FL__SD_lgt_23, wFDN_FL__SD_lgt_24, 
      wFDN_FL__SD_lgt_25, wFDN_FL__SD_lgt_26, wFDN_FL__SD_lgt_27, wFDN_FL__SD_lgt_28, wFDN_FL__SD_lgt_29, 
      wFDN_FL__SD_lgt_30, wFDN_FL__SD_lgt_31, wFDN_FL__SD_lgt_32, wFDN_FL__SD_lgt_33, wFDN_FL__SD_lgt_34, 
      wFDN_FL__SD_lgt_35, wFDN_FL__SD_lgt_36, wFDN_FL__SD_lgt_37, wFDN_FL__SD_lgt_38, wFDN_FL__SD_lgt_39, 
      wFDN_FL__SD_lgt_40, wFDN_FL__SD_lgt_41, wFDN_FL__SD_lgt_42, wFDN_FL__SD_lgt_43, wFDN_FL__SD_lgt_44, 
      wFDN_FL__SD_lgt_45, wFDN_FL__SD_lgt_46, wFDN_FL__SD_lgt_47, wFDN_FL__SD_lgt_48, wFDN_FL__SD_lgt_49, 
      wFDN_FL__SD_lgt_50, wFDN_FL__SD_lgt_51, wFDN_FL__SD_lgt_52, wFDN_FL__SD_lgt_53, wFDN_FL__SD_lgt_54, 
      wFDN_FL__SD_lgt_55, wFDN_FL__SD_lgt_56, wFDN_FL__SD_lgt_57, wFDN_FL__SD_lgt_58, wFDN_FL__SD_lgt_59, 
      wFDN_FL__SD_lgt_60, wFDN_FL__SD_lgt_61, wFDN_FL__SD_lgt_62, wFDN_FL__SD_lgt_63, wFDN_FL__SD_lgt_64, 
      wFDN_FL__SD_lgt_65, wFDN_FL__SD_lgt_66, wFDN_FL__SD_lgt_67, wFDN_FL__SD_lgt_68, wFDN_FL__SD_lgt_69, 
      wFDN_FL__SD_lgt_70, wFDN_FL__SD_lgt_71, wFDN_FL__SD_lgt_72, wFDN_FL__SD_lgt_73, wFDN_FL__SD_lgt_74, 
      wFDN_FL__SD_lgt_75, wFDN_FL__SD_lgt_76, wFDN_FL__SD_lgt_77, wFDN_FL__SD_lgt_78, wFDN_FL__SD_lgt_79, 
      wFDN_FL__SD_lgt_80, wFDN_FL__SD_lgt_81, wFDN_FL__SD_lgt_82, wFDN_FL__SD_lgt_83, wFDN_FL__SD_lgt_84, 
      wFDN_FL__SD_lgt_85, wFDN_FL__SD_lgt_86, wFDN_FL__SD_lgt_87, wFDN_FL__SD_lgt_88, wFDN_FL__SD_lgt_89, 
      wFDN_FL__SD_lgt_90, wFDN_FL__SD_lgt_91, wFDN_FL__SD_lgt_92, wFDN_FL__SD_lgt_93, wFDN_FL__SD_lgt_94, 
      wFDN_FL__SD_lgt_95, wFDN_FL__SD_lgt_96, wFDN_FL__SD_lgt_97, wFDN_FL__SD_lgt_98, wFDN_FL__SD_lgt_99, 
      wFDN_FL__SD_lgt_100, wFDN_FL__SD_lgt_101, wFDN_FL__SD_lgt_102, wFDN_FL__SD_lgt_103, wFDN_FL__SD_lgt_104, 
      wFDN_FL__SD_lgt_105, wFDN_FL__SD_lgt_106, wFDN_FL__SD_lgt_107, wFDN_FL__SD_lgt_108, wFDN_FL__SD_lgt_109, 
      wFDN_FL__SD_lgt_110, wFDN_FL__SD_lgt_111, wFDN_FL__SD_lgt_112, wFDN_FL__SD_lgt_113, wFDN_FL__SD_lgt_114, 
      wFDN_FL__SD_lgt_115, wFDN_FL__SD_lgt_116, wFDN_FL__SD_lgt_117, wFDN_FL__SD_lgt_118, wFDN_FL__SD_lgt_119, 
      wFDN_FL__SD_lgt_120, wFDN_FL__SD_lgt_121, wFDN_FL__SD_lgt_122, wFDN_FL__SD_lgt_123, wFDN_FL__SD_lgt_124, 
      wFDN_FL__SD_lgt_125, wFDN_FL__SD_lgt_126, wFDN_FL__SD_lgt_127, wFDN_FL__SD_lgt_128, wFDN_FL__SD_lgt_129, 
      wFDN_FL__SD_lgt_130, wFDN_FL__SD_lgt_131, wFDN_FL__SD_lgt_132, wFDN_FL__SD_lgt_133, wFDN_FL__SD_lgt_134, 
      wFDN_FL__SD_lgt_135, wFDN_FL__SD_lgt_136, wFDN_FL__SD_lgt_137, wFDN_FL__SD_lgt_138, wFDN_FL__SD_lgt_139, 
      wFDN_FL__SD_lgt_140, wFDN_FL__SD_lgt_141, wFDN_FL__SD_lgt_142, wFDN_FL__SD_lgt_143, wFDN_FL__SD_lgt_144, 
      wFDN_FL__SD_lgt_145, wFDN_FL__SD_lgt_146, wFDN_FL__SD_lgt_147, wFDN_FL__SD_lgt_148, wFDN_FL__SD_lgt_149, 
      wFDN_FL__SD_lgt_150, wFDN_FL__SD_lgt_151, wFDN_FL__SD_lgt_152, wFDN_FL__SD_lgt_153, wFDN_FL__SD_lgt_154, 
      wFDN_FL__SD_lgt_155, wFDN_FL__SD_lgt_156, wFDN_FL__SD_lgt_157, wFDN_FL__SD_lgt_158, wFDN_FL__SD_lgt_159, 
      wFDN_FL__SD_lgt_160, wFDN_FL__SD_lgt_161, wFDN_FL__SD_lgt_162, wFDN_FL__SD_lgt_163, wFDN_FL__SD_lgt_164, 
      wFDN_FL__SD_lgt_165, wFDN_FL__SD_lgt_166, wFDN_FL__SD_lgt_167, wFDN_FL__SD_lgt_168, wFDN_FL__SD_lgt_169, 
      wFDN_FL__SD_lgt_170, wFDN_FL__SD_lgt_171, wFDN_FL__SD_lgt_172, wFDN_FL__SD_lgt_173, wFDN_FL__SD_lgt_174, 
      wFDN_FL__SD_lgt_175, wFDN_FL__SD_lgt_176, wFDN_FL__SD_lgt_177, wFDN_FL__SD_lgt_178, wFDN_FL__SD_lgt_179, 
      wFDN_FL__SD_lgt_180, wFDN_FL__SD_lgt_181, wFDN_FL__SD_lgt_182, wFDN_FL__SD_lgt_183, wFDN_FL__SD_lgt_184, 
      wFDN_FL__SD_lgt_185, wFDN_FL__SD_lgt_186, wFDN_FL__SD_lgt_187, wFDN_FL__SD_lgt_188, wFDN_FL__SD_lgt_189, 
      wFDN_FL__SD_lgt_190, wFDN_FL__SD_lgt_191, wFDN_FL__SD_lgt_192, wFDN_FL__SD_lgt_193, wFDN_FL__SD_lgt_194, 
      wFDN_FL__SD_lgt_195, wFDN_FL__SD_lgt_196, wFDN_FL__SD_lgt_197, wFDN_FL__SD_lgt_198, wFDN_FL__SD_lgt_199, 
      wFDN_FL__SD_lgt_200, wFDN_FL__SD_lgt_201, wFDN_FL__SD_lgt_202, wFDN_FL__SD_lgt_203, wFDN_FL__SD_lgt_204, 
      wFDN_FL__SD_lgt_205, wFDN_FL__SD_lgt_206, wFDN_FL__SD_lgt_207, wFDN_FL__SD_lgt_208, wFDN_FL__SD_lgt_209, 
      wFDN_FL__SD_lgt_210, wFDN_FL__SD_lgt_211, wFDN_FL__SD_lgt_212, wFDN_FL__SD_lgt_213); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FL__SD_lgt;
			
self.final_score_0	:= 	wFDN_FL__SD_lgt_0	;
self.final_score_1	:= 	wFDN_FL__SD_lgt_1	;
self.final_score_2	:= 	wFDN_FL__SD_lgt_2	;
self.final_score_3	:= 	wFDN_FL__SD_lgt_3	;
self.final_score_4	:= 	wFDN_FL__SD_lgt_4	;
self.final_score_5	:= 	wFDN_FL__SD_lgt_5	;
self.final_score_6	:= 	wFDN_FL__SD_lgt_6	;
self.final_score_7	:= 	wFDN_FL__SD_lgt_7	;
self.final_score_8	:= 	wFDN_FL__SD_lgt_8	;
self.final_score_9	:= 	wFDN_FL__SD_lgt_9	;
self.final_score_10	:= 	wFDN_FL__SD_lgt_10	;
self.final_score_11	:= 	wFDN_FL__SD_lgt_11	;
self.final_score_12	:= 	wFDN_FL__SD_lgt_12	;
self.final_score_13	:= 	wFDN_FL__SD_lgt_13	;
self.final_score_14	:= 	wFDN_FL__SD_lgt_14	;
self.final_score_15	:= 	wFDN_FL__SD_lgt_15	;
self.final_score_16	:= 	wFDN_FL__SD_lgt_16	;
self.final_score_17	:= 	wFDN_FL__SD_lgt_17	;
self.final_score_18	:= 	wFDN_FL__SD_lgt_18	;
self.final_score_19	:= 	wFDN_FL__SD_lgt_19	;
self.final_score_20	:= 	wFDN_FL__SD_lgt_20	;
self.final_score_21	:= 	wFDN_FL__SD_lgt_21	;
self.final_score_22	:= 	wFDN_FL__SD_lgt_22	;
self.final_score_23	:= 	wFDN_FL__SD_lgt_23	;
self.final_score_24	:= 	wFDN_FL__SD_lgt_24	;
self.final_score_25	:= 	wFDN_FL__SD_lgt_25	;
self.final_score_26	:= 	wFDN_FL__SD_lgt_26	;
self.final_score_27	:= 	wFDN_FL__SD_lgt_27	;
self.final_score_28	:= 	wFDN_FL__SD_lgt_28	;
self.final_score_29	:= 	wFDN_FL__SD_lgt_29	;
self.final_score_30	:= 	wFDN_FL__SD_lgt_30	;
self.final_score_31	:= 	wFDN_FL__SD_lgt_31	;
self.final_score_32	:= 	wFDN_FL__SD_lgt_32	;
self.final_score_33	:= 	wFDN_FL__SD_lgt_33	;
self.final_score_34	:= 	wFDN_FL__SD_lgt_34	;
self.final_score_35	:= 	wFDN_FL__SD_lgt_35	;
self.final_score_36	:= 	wFDN_FL__SD_lgt_36	;
self.final_score_37	:= 	wFDN_FL__SD_lgt_37	;
self.final_score_38	:= 	wFDN_FL__SD_lgt_38	;
self.final_score_39	:= 	wFDN_FL__SD_lgt_39	;
self.final_score_40	:= 	wFDN_FL__SD_lgt_40	;
self.final_score_41	:= 	wFDN_FL__SD_lgt_41	;
self.final_score_42	:= 	wFDN_FL__SD_lgt_42	;
self.final_score_43	:= 	wFDN_FL__SD_lgt_43	;
self.final_score_44	:= 	wFDN_FL__SD_lgt_44	;
self.final_score_45	:= 	wFDN_FL__SD_lgt_45	;
self.final_score_46	:= 	wFDN_FL__SD_lgt_46	;
self.final_score_47	:= 	wFDN_FL__SD_lgt_47	;
self.final_score_48	:= 	wFDN_FL__SD_lgt_48	;
self.final_score_49	:= 	wFDN_FL__SD_lgt_49	;
self.final_score_50	:= 	wFDN_FL__SD_lgt_50	;
self.final_score_51	:= 	wFDN_FL__SD_lgt_51	;
self.final_score_52	:= 	wFDN_FL__SD_lgt_52	;
self.final_score_53	:= 	wFDN_FL__SD_lgt_53	;
self.final_score_54	:= 	wFDN_FL__SD_lgt_54	;
self.final_score_55	:= 	wFDN_FL__SD_lgt_55	;
self.final_score_56	:= 	wFDN_FL__SD_lgt_56	;
self.final_score_57	:= 	wFDN_FL__SD_lgt_57	;
self.final_score_58	:= 	wFDN_FL__SD_lgt_58	;
self.final_score_59	:= 	wFDN_FL__SD_lgt_59	;
self.final_score_60	:= 	wFDN_FL__SD_lgt_60	;
self.final_score_61	:= 	wFDN_FL__SD_lgt_61	;
self.final_score_62	:= 	wFDN_FL__SD_lgt_62	;
self.final_score_63	:= 	wFDN_FL__SD_lgt_63	;
self.final_score_64	:= 	wFDN_FL__SD_lgt_64	;
self.final_score_65	:= 	wFDN_FL__SD_lgt_65	;
self.final_score_66	:= 	wFDN_FL__SD_lgt_66	;
self.final_score_67	:= 	wFDN_FL__SD_lgt_67	;
self.final_score_68	:= 	wFDN_FL__SD_lgt_68	;
self.final_score_69	:= 	wFDN_FL__SD_lgt_69	;
self.final_score_70	:= 	wFDN_FL__SD_lgt_70	;
self.final_score_71	:= 	wFDN_FL__SD_lgt_71	;
self.final_score_72	:= 	wFDN_FL__SD_lgt_72	;
self.final_score_73	:= 	wFDN_FL__SD_lgt_73	;
self.final_score_74	:= 	wFDN_FL__SD_lgt_74	;
self.final_score_75	:= 	wFDN_FL__SD_lgt_75	;
self.final_score_76	:= 	wFDN_FL__SD_lgt_76	;
self.final_score_77	:= 	wFDN_FL__SD_lgt_77	;
self.final_score_78	:= 	wFDN_FL__SD_lgt_78	;
self.final_score_79	:= 	wFDN_FL__SD_lgt_79	;
self.final_score_80	:= 	wFDN_FL__SD_lgt_80	;
self.final_score_81	:= 	wFDN_FL__SD_lgt_81	;
self.final_score_82	:= 	wFDN_FL__SD_lgt_82	;
self.final_score_83	:= 	wFDN_FL__SD_lgt_83	;
self.final_score_84	:= 	wFDN_FL__SD_lgt_84	;
self.final_score_85	:= 	wFDN_FL__SD_lgt_85	;
self.final_score_86	:= 	wFDN_FL__SD_lgt_86	;
self.final_score_87	:= 	wFDN_FL__SD_lgt_87	;
self.final_score_88	:= 	wFDN_FL__SD_lgt_88	;
self.final_score_89	:= 	wFDN_FL__SD_lgt_89	;
self.final_score_90	:= 	wFDN_FL__SD_lgt_90	;
self.final_score_91	:= 	wFDN_FL__SD_lgt_91	;
self.final_score_92	:= 	wFDN_FL__SD_lgt_92	;
self.final_score_93	:= 	wFDN_FL__SD_lgt_93	;
self.final_score_94	:= 	wFDN_FL__SD_lgt_94	;
self.final_score_95	:= 	wFDN_FL__SD_lgt_95	;
self.final_score_96	:= 	wFDN_FL__SD_lgt_96	;
self.final_score_97	:= 	wFDN_FL__SD_lgt_97	;
self.final_score_98	:= 	wFDN_FL__SD_lgt_98	;
self.final_score_99	:= 	wFDN_FL__SD_lgt_99	;
self.final_score_100	:= 	wFDN_FL__SD_lgt_100	;
self.final_score_101	:= 	wFDN_FL__SD_lgt_101	;
self.final_score_102	:= 	wFDN_FL__SD_lgt_102	;
self.final_score_103	:= 	wFDN_FL__SD_lgt_103	;
self.final_score_104	:= 	wFDN_FL__SD_lgt_104	;
self.final_score_105	:= 	wFDN_FL__SD_lgt_105	;
self.final_score_106	:= 	wFDN_FL__SD_lgt_106	;
self.final_score_107	:= 	wFDN_FL__SD_lgt_107	;
self.final_score_108	:= 	wFDN_FL__SD_lgt_108	;
self.final_score_109	:= 	wFDN_FL__SD_lgt_109	;
self.final_score_110	:= 	wFDN_FL__SD_lgt_110	;
self.final_score_111	:= 	wFDN_FL__SD_lgt_111	;
self.final_score_112	:= 	wFDN_FL__SD_lgt_112	;
self.final_score_113	:= 	wFDN_FL__SD_lgt_113	;
self.final_score_114	:= 	wFDN_FL__SD_lgt_114	;
self.final_score_115	:= 	wFDN_FL__SD_lgt_115	;
self.final_score_116	:= 	wFDN_FL__SD_lgt_116	;
self.final_score_117	:= 	wFDN_FL__SD_lgt_117	;
self.final_score_118	:= 	wFDN_FL__SD_lgt_118	;
self.final_score_119	:= 	wFDN_FL__SD_lgt_119	;
self.final_score_120	:= 	wFDN_FL__SD_lgt_120	;
self.final_score_121	:= 	wFDN_FL__SD_lgt_121	;
self.final_score_122	:= 	wFDN_FL__SD_lgt_122	;
self.final_score_123	:= 	wFDN_FL__SD_lgt_123	;
self.final_score_124	:= 	wFDN_FL__SD_lgt_124	;
self.final_score_125	:= 	wFDN_FL__SD_lgt_125	;
self.final_score_126	:= 	wFDN_FL__SD_lgt_126	;
self.final_score_127	:= 	wFDN_FL__SD_lgt_127	;
self.final_score_128	:= 	wFDN_FL__SD_lgt_128	;
self.final_score_129	:= 	wFDN_FL__SD_lgt_129	;
self.final_score_130	:= 	wFDN_FL__SD_lgt_130	;
self.final_score_131	:= 	wFDN_FL__SD_lgt_131	;
self.final_score_132	:= 	wFDN_FL__SD_lgt_132	;
self.final_score_133	:= 	wFDN_FL__SD_lgt_133	;
self.final_score_134	:= 	wFDN_FL__SD_lgt_134	;
self.final_score_135	:= 	wFDN_FL__SD_lgt_135	;
self.final_score_136	:= 	wFDN_FL__SD_lgt_136	;
self.final_score_137	:= 	wFDN_FL__SD_lgt_137	;
self.final_score_138	:= 	wFDN_FL__SD_lgt_138	;
self.final_score_139	:= 	wFDN_FL__SD_lgt_139	;
self.final_score_140	:= 	wFDN_FL__SD_lgt_140	;
self.final_score_141	:= 	wFDN_FL__SD_lgt_141	;
self.final_score_142	:= 	wFDN_FL__SD_lgt_142	;
self.final_score_143	:= 	wFDN_FL__SD_lgt_143	;
self.final_score_144	:= 	wFDN_FL__SD_lgt_144	;
self.final_score_145	:= 	wFDN_FL__SD_lgt_145	;
self.final_score_146	:= 	wFDN_FL__SD_lgt_146	;
self.final_score_147	:= 	wFDN_FL__SD_lgt_147	;
self.final_score_148	:= 	wFDN_FL__SD_lgt_148	;
self.final_score_149	:= 	wFDN_FL__SD_lgt_149	;
self.final_score_150	:= 	wFDN_FL__SD_lgt_150	;
self.final_score_151	:= 	wFDN_FL__SD_lgt_151	;
self.final_score_152	:= 	wFDN_FL__SD_lgt_152	;
self.final_score_153	:= 	wFDN_FL__SD_lgt_153	;
self.final_score_154	:= 	wFDN_FL__SD_lgt_154	;
self.final_score_155	:= 	wFDN_FL__SD_lgt_155	;
self.final_score_156	:= 	wFDN_FL__SD_lgt_156	;
self.final_score_157	:= 	wFDN_FL__SD_lgt_157	;
self.final_score_158	:= 	wFDN_FL__SD_lgt_158	;
self.final_score_159	:= 	wFDN_FL__SD_lgt_159	;
self.final_score_160	:= 	wFDN_FL__SD_lgt_160	;
self.final_score_161	:= 	wFDN_FL__SD_lgt_161	;
self.final_score_162	:= 	wFDN_FL__SD_lgt_162	;
self.final_score_163	:= 	wFDN_FL__SD_lgt_163	;
self.final_score_164	:= 	wFDN_FL__SD_lgt_164	;
self.final_score_165	:= 	wFDN_FL__SD_lgt_165	;
self.final_score_166	:= 	wFDN_FL__SD_lgt_166	;
self.final_score_167	:= 	wFDN_FL__SD_lgt_167	;
self.final_score_168	:= 	wFDN_FL__SD_lgt_168	;
self.final_score_169	:= 	wFDN_FL__SD_lgt_169	;
self.final_score_170	:= 	wFDN_FL__SD_lgt_170	;
self.final_score_171	:= 	wFDN_FL__SD_lgt_171	;
self.final_score_172	:= 	wFDN_FL__SD_lgt_172	;
self.final_score_173	:= 	wFDN_FL__SD_lgt_173	;
self.final_score_174	:= 	wFDN_FL__SD_lgt_174	;
self.final_score_175	:= 	wFDN_FL__SD_lgt_175	;
self.final_score_176	:= 	wFDN_FL__SD_lgt_176	;
self.final_score_177	:= 	wFDN_FL__SD_lgt_177	;
self.final_score_178	:= 	wFDN_FL__SD_lgt_178	;
self.final_score_179	:= 	wFDN_FL__SD_lgt_179	;
self.final_score_180	:= 	wFDN_FL__SD_lgt_180	;
self.final_score_181	:= 	wFDN_FL__SD_lgt_181	;
self.final_score_182	:= 	wFDN_FL__SD_lgt_182	;
self.final_score_183	:= 	wFDN_FL__SD_lgt_183	;
self.final_score_184	:= 	wFDN_FL__SD_lgt_184	;
self.final_score_185	:= 	wFDN_FL__SD_lgt_185	;
self.final_score_186	:= 	wFDN_FL__SD_lgt_186	;
self.final_score_187	:= 	wFDN_FL__SD_lgt_187	;
self.final_score_188	:= 	wFDN_FL__SD_lgt_188	;
self.final_score_189	:= 	wFDN_FL__SD_lgt_189	;
self.final_score_190	:= 	wFDN_FL__SD_lgt_190	;
self.final_score_191	:= 	wFDN_FL__SD_lgt_191	;
self.final_score_192	:= 	wFDN_FL__SD_lgt_192	;
self.final_score_193	:= 	wFDN_FL__SD_lgt_193	;
self.final_score_194	:= 	wFDN_FL__SD_lgt_194	;
self.final_score_195	:= 	wFDN_FL__SD_lgt_195	;
self.final_score_196	:= 	wFDN_FL__SD_lgt_196	;
self.final_score_197	:= 	wFDN_FL__SD_lgt_197	;
self.final_score_198	:= 	wFDN_FL__SD_lgt_198	;
self.final_score_199	:= 	wFDN_FL__SD_lgt_199	;
self.final_score_200	:= 	wFDN_FL__SD_lgt_200	;
self.final_score_201	:= 	wFDN_FL__SD_lgt_201	;
self.final_score_202	:= 	wFDN_FL__SD_lgt_202	;
self.final_score_203	:= 	wFDN_FL__SD_lgt_203	;
self.final_score_204	:= 	wFDN_FL__SD_lgt_204	;
self.final_score_205	:= 	wFDN_FL__SD_lgt_205	;
self.final_score_206	:= 	wFDN_FL__SD_lgt_206	;
self.final_score_207	:= 	wFDN_FL__SD_lgt_207	;
self.final_score_208	:= 	wFDN_FL__SD_lgt_208	;
self.final_score_209	:= 	wFDN_FL__SD_lgt_209	;
self.final_score_210	:= 	wFDN_FL__SD_lgt_210	;
self.final_score_211	:= 	wFDN_FL__SD_lgt_211	;
self.final_score_212	:= 	wFDN_FL__SD_lgt_212	;
self.FP3_wFDN_LGT		:= 	wFDN_FL__SD_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
