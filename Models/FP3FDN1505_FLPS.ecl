
export FP3FDN1505_FLPS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FL_PS__lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FL_PS__lgt_1 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0586892107,
      (f_phone_ver_experian_d > 0.5) => -0.0532990463,
      (f_phone_ver_experian_d = NULL) => 0.0413058511, 0.0276347636),
   (k_nap_phn_verd_d > 0.5) => -0.0546385881,
   (k_nap_phn_verd_d = NULL) => -0.0223171709, -0.0223171709),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 0.3743752711,
      (nf_vf_hi_risk_index > 6.5) => 0.0426889113,
      (nf_vf_hi_risk_index = NULL) => 0.0876296291, 0.0876296291),
   (f_inq_Communications_count_i > 0.5) => 0.4689469651,
   (f_inq_Communications_count_i = NULL) => 0.1824436694, 0.1824436694),
(f_srchvelocityrisktype_i = NULL) => 0.2475345755, -0.0016766067);

// Tree: 2 
wFDN_FL_PS__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0031287606,
         (f_rel_felony_count_i > 1.5) => 0.2026222217,
         (f_rel_felony_count_i = NULL) => 0.0138424603, 0.0138424603),
      (k_nap_phn_verd_d > 0.5) => -0.0533305094,
      (k_nap_phn_verd_d = NULL) => -0.0268947703, -0.0268947703),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.1924291045,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0221377245, -0.0221377245),
(f_varrisktype_i > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.1280878412,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.4049244790,
   (nf_seg_FraudPoint_3_0 = '') => 0.2199740444, 0.2199740444),
(f_varrisktype_i = NULL) => 0.1678129452, -0.0067201183);

// Tree: 3 
wFDN_FL_PS__lgt_3 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 1.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 33.55) => 0.0895577723,
      (c_famotf18_p > 33.55) => 0.4872994404,
      (c_famotf18_p = NULL) => 0.1310488096, 0.1310488096),
   (f_srchunvrfdphonecount_i > 1.5) => 0.3460126566,
   (f_srchunvrfdphonecount_i = NULL) => 0.1675580428, 0.1675580428),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0145573506,
      (f_phone_ver_experian_d > 0.5) => -0.0529825367,
      (f_phone_ver_experian_d = NULL) => -0.0060081090, -0.0216101470),
   (f_inq_Communications_count_i > 1.5) => 0.1738086651,
   (f_inq_Communications_count_i = NULL) => -0.0159582156, -0.0159582156),
(nf_vf_hi_risk_index = NULL) => 0.0949524262, -0.0051328350);

// Tree: 4 
wFDN_FL_PS__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0099494398,
      (f_corrphonelastnamecount_d > 0.5) => -0.0526643160,
      (f_corrphonelastnamecount_d = NULL) => -0.0252007303, -0.0252007303),
   (f_assocsuspicousidcount_i > 14.5) => 0.3759315178,
   (f_assocsuspicousidcount_i = NULL) => -0.0230029461, -0.0230029461),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0471665591,
   (f_assocrisktype_i > 4.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.1476403267,
      (f_varrisktype_i > 2.5) => 0.2908319567,
      (f_varrisktype_i = NULL) => 0.2037559655, 0.2037559655),
   (f_assocrisktype_i = NULL) => 0.0904039325, 0.0904039325),
(f_srchvelocityrisktype_i = NULL) => 0.0998422111, -0.0074068286);

// Tree: 5 
wFDN_FL_PS__lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.55) => -0.0213183604,
   (c_famotf18_p > 27.55) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0803699192,
      (f_rel_felony_count_i > 2.5) => 0.3480692461,
      (f_rel_felony_count_i = NULL) => 0.0939174560, 0.0939174560),
   (c_famotf18_p = NULL) => -0.0195079326, -0.0116492286),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 0.0479111358,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.2352628319,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0659449889, 0.0659449889),
   (f_assocrisktype_i > 5.5) => 0.2217795241,
   (f_assocrisktype_i = NULL) => 0.1010292834, 0.1010292834),
(f_varrisktype_i = NULL) => 0.0844533323, -0.0042407561);

// Tree: 6 
wFDN_FL_PS__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0232642440,
      (f_phone_ver_experian_d > 0.5) => -0.0523497374,
      (f_phone_ver_experian_d = NULL) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0268602441,
         (f_assocrisktype_i > 8.5) => 0.1845605049,
         (f_assocrisktype_i = NULL) => -0.0174084930, -0.0174084930), -0.0207466481),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.1790838165,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0160142105, -0.0160142105),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1998482031,
   (r_I60_inq_comm_recency_d > 549) => 0.0852609913,
   (r_I60_inq_comm_recency_d = NULL) => 0.1308649698, 0.1308649698),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0641296456, -0.0106149749);

// Tree: 7 
wFDN_FL_PS__lgt_7 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < c_construction and c_construction <= 5.25) => 0.1823236202,
   (c_construction > 5.25) => 0.0323621044,
   (c_construction = NULL) => 0.1105614322, 0.1105614322),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0061456307,
         (f_rel_felony_count_i > 1.5) => 0.1458778281,
         (f_rel_felony_count_i = NULL) => 0.0144428192, 0.0144428192),
      (k_inq_per_phone_i > 2.5) => 0.2484676264,
      (k_inq_per_phone_i = NULL) => 0.0204134679, 0.0204134679),
   (f_phone_ver_experian_d > 0.5) => -0.0470632803,
   (f_phone_ver_experian_d = NULL) => -0.0057734671, -0.0168763355),
(nf_vf_hi_risk_hit_type = NULL) => 0.0485346804, -0.0097760606);

// Tree: 8 
wFDN_FL_PS__lgt_8 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1514939595,
      (f_phone_ver_experian_d > 0.5) => -0.0144632717,
      (f_phone_ver_experian_d = NULL) => 0.1094198516, 0.0821699700),
   (nf_vf_hi_risk_index > 6.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0319848437,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.0356512113,
      (nf_seg_FraudPoint_3_0 = '') => -0.0198537335, -0.0198537335),
   (nf_vf_hi_risk_index = NULL) => -0.0148951802, -0.0148951802),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 13.5) => 0.1164575711,
   (f_srchfraudsrchcount_i > 13.5) => 0.2079488461,
   (f_srchfraudsrchcount_i = NULL) => 0.1295277533, 0.1295277533),
(f_inq_Communications_count_i = NULL) => 0.0452863670, -0.0097546500);

// Tree: 9 
wFDN_FL_PS__lgt_9 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1224571181,
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 44.35) => 0.1333138861,
         (c_fammar_p > 44.35) => 0.0107798530,
         (c_fammar_p = NULL) => -0.0434525918, 0.0166751513),
      (k_nap_phn_verd_d > 0.5) => -0.0426599606,
      (k_nap_phn_verd_d = NULL) => -0.0187081249, -0.0187081249),
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2041888033,
      (f_phone_ver_experian_d > 0.5) => 0.0367256557,
      (f_phone_ver_experian_d = NULL) => 0.0837403446, 0.0921176541),
   (k_inq_per_phone_i = NULL) => -0.0133856979, -0.0133856979),
(r_D33_Eviction_Recency_d = NULL) => 0.0890158988, -0.0071831114);

// Tree: 10 
wFDN_FL_PS__lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 29.55) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0225818135,
      (k_inq_per_phone_i > 2.5) => 0.0752824074,
      (k_inq_per_phone_i = NULL) => -0.0176832488, -0.0176832488),
   (c_famotf18_p > 29.55) => 0.0763219267,
   (c_famotf18_p = NULL) => -0.0299990345, -0.0112941176),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1659335602,
   (f_phone_ver_experian_d > 0.5) => 0.0091157432,
   (f_phone_ver_experian_d = NULL) => 0.1632908436, 0.1116860663),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0964542806,
   (r_S66_adlperssn_count_i > 1.5) => 0.1214153085,
   (r_S66_adlperssn_count_i = NULL) => 0.0255526893, 0.0255526893), -0.0067331188);

// Tree: 11 
wFDN_FL_PS__lgt_11 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3555392275,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
         map(
         (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => 
            map(
            (NULL < c_unemp and c_unemp <= 9.05) => -0.0230446731,
            (c_unemp > 9.05) => 0.0784803113,
            (c_unemp = NULL) => -0.0388289629, -0.0192133426),
         (f_inq_Communications_count24_i > 0.5) => 0.0681707842,
         (f_inq_Communications_count24_i = NULL) => -0.0149022671, -0.0149022671),
      (f_inq_PrepaidCards_count24_i > 0.5) => 0.1712664087,
      (f_inq_PrepaidCards_count24_i = NULL) => -0.0128031351, -0.0128031351),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0108572432, -0.0108572432),
(f_inq_HighRiskCredit_count_i > 4.5) => 0.1085317772,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0199155590, -0.0081306037);

// Tree: 12 
wFDN_FL_PS__lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2239102754,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0546319539,
         (f_corrphonelastnamecount_d > 0.5) => -0.0274233258,
         (f_corrphonelastnamecount_d = NULL) => 0.0193180678, 0.0193180678),
      (f_phone_ver_experian_d > 0.5) => -0.0399843953,
      (f_phone_ver_experian_d = NULL) => -0.0139976115, -0.0150635955),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0137912084, -0.0137912084),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1641284201,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0433998243,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0922415924, 0.0922415924),
(f_srchfraudsrchcount_i = NULL) => 0.0636910069, -0.0100876000);

// Tree: 13 
wFDN_FL_PS__lgt_13 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1286857759,
   (f_phone_ver_experian_d > 0.5) => 0.0161931396,
   (f_phone_ver_experian_d = NULL) => 0.0643570663, 0.0693592139),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.05) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0172132411,
      (r_D30_Derog_Count_i > 8.5) => 0.1039526764,
      (r_D30_Derog_Count_i = NULL) => -0.0144969942, -0.0144969942),
   (c_unemp > 11.05) => 
      map(
      (NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 0.2116218954,
      (k_inf_lname_verd_d > 0.5) => -0.0404161991,
      (k_inf_lname_verd_d = NULL) => 0.1366251941, 0.1366251941),
   (c_unemp = NULL) => -0.0331237770, -0.0124049635),
(nf_vf_hi_risk_index = NULL) => 0.0242209995, -0.0077965077);

// Tree: 14 
wFDN_FL_PS__lgt_14 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 173.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1158463597,
      (r_I60_inq_comm_recency_d > 549) => 0.0375677930,
      (r_I60_inq_comm_recency_d = NULL) => 0.0559418617, 0.0559418617),
   (c_unempl > 173.5) => 0.1979624086,
   (c_unempl = NULL) => 0.0670931046, 0.0670931046),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.35) => 0.0563832511,
      (c_fammar_p > 44.35) => -0.0184130284,
      (c_fammar_p = NULL) => -0.0391341030, -0.0152864548),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.0942761381,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0127125273, -0.0127125273),
(nf_vf_hi_risk_index = NULL) => 0.0095646689, -0.0081761231);

// Tree: 15 
wFDN_FL_PS__lgt_15 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0926115255,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 29.25) => -0.0153789148,
   (c_famotf18_p > 29.25) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 144.5) => 0.0225047772,
         (c_sub_bus > 144.5) => 0.1591648983,
         (c_sub_bus = NULL) => 0.0994503671, 0.0994503671),
      (k_nap_phn_verd_d > 0.5) => 0.0052321800,
      (k_nap_phn_verd_d = NULL) => 0.0524439077, 0.0524439077),
   (c_famotf18_p = NULL) => -0.0351110502, -0.0107511955),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0712486545,
   (r_S66_adlperssn_count_i > 1.5) => 0.1346753602,
   (r_S66_adlperssn_count_i = NULL) => 0.0402148030, 0.0402148030), -0.0074613061);

// Tree: 16 
wFDN_FL_PS__lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 
         map(
         (NULL < c_med_hhinc and c_med_hhinc <= 34065.5) => 0.0845362300,
         (c_med_hhinc > 34065.5) => 0.0046179877,
         (c_med_hhinc = NULL) => -0.0321773054, 0.0114371309),
      (k_inq_per_ssn_i > 3.5) => 0.1161819869,
      (k_inq_per_ssn_i = NULL) => 0.0172905199, 0.0172905199),
   (k_nap_phn_verd_d > 0.5) => -0.0274888246,
   (k_nap_phn_verd_d = NULL) => -0.0096669450, -0.0096669450),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 29.95) => 0.0645216378,
   (c_famotf18_p > 29.95) => 0.1961907739,
   (c_famotf18_p = NULL) => 0.0815817584, 0.0815817584),
(r_D30_Derog_Count_i = NULL) => 0.0137102787, -0.0050830684);

// Tree: 17 
wFDN_FL_PS__lgt_17 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.35) => -0.0229398145,
   (c_unemp > 9.35) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.1578399235,
      (k_estimated_income_d > 28500) => 0.0028980873,
      (k_estimated_income_d = NULL) => 0.0592405732, 0.0592405732),
   (c_unemp = NULL) => -0.0165442634, -0.0197231750),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 2.5) => 0.0086514031,
   (f_assocsuspicousidcount_i > 2.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 18.95) => 0.0592870423,
      (c_hval_150k_p > 18.95) => 0.1756751487,
      (c_hval_150k_p = NULL) => 0.0753007250, 0.0753007250),
   (f_assocsuspicousidcount_i = NULL) => 0.0381675314, 0.0381675314),
(f_srchvelocityrisktype_i = NULL) => 0.0246999391, -0.0119343418);

// Tree: 18 
wFDN_FL_PS__lgt_18 := map(
(nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0418501344,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0207760896,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 8.5) => 0.2390217036,
         (f_prevaddrageoldest_d > 8.5) => 0.0589199291,
         (f_prevaddrageoldest_d = NULL) => 0.0793486832, 0.0793486832),
      (f_assocrisktype_i = NULL) => 0.0487899783, 0.0343469743),
   (k_nap_phn_verd_d > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0114298304,
      (r_D33_eviction_count_i > 2.5) => 0.1401895132,
      (r_D33_eviction_count_i = NULL) => -0.0092549628, -0.0092549628),
   (k_nap_phn_verd_d = NULL) => 0.0088455202, 0.0088455202),
(nf_seg_FraudPoint_3_0 = '') => -0.0082515244, -0.0082515244);

// Tree: 19 
wFDN_FL_PS__lgt_19 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 43.5) => 0.1561052496,
      (r_D32_Mos_Since_Crim_LS_d > 43.5) => 0.0246982937,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0375490241, 0.0375490241),
   (f_mos_inq_banko_cm_lseen_d > 44.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452.5) => -0.0144301656,
      (r_C13_Curr_Addr_LRes_d > 452.5) => 0.2546504123,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0122595045, -0.0122595045),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0091968418, -0.0037942456),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 9.5) => 0.1506605655,
   (r_C13_Curr_Addr_LRes_d > 9.5) => 0.0503486070,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0711826292, 0.0711826292),
(k_inq_per_phone_i = NULL) => 0.0000831552, 0.0000831552);

// Tree: 20 
wFDN_FL_PS__lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0137299166,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 168) => 0.0620602776,
      (c_sub_bus > 168) => 0.3468852987,
      (c_sub_bus = NULL) => 0.1008347762, 0.1008347762),
   (k_comb_age_d = NULL) => -0.0074311081, -0.0074311081),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1091805239,
   (f_phone_ver_experian_d > 0.5) => 0.0160151075,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_rich_blk and c_rich_blk <= 179.5) => 0.0115524278,
      (c_rich_blk > 179.5) => 0.1911921175,
      (c_rich_blk = NULL) => 0.0366462204, 0.0366462204), 0.0511130639),
(f_varrisktype_i = NULL) => 0.0292668054, -0.0008147438);

// Tree: 21 
wFDN_FL_PS__lgt_21 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 21.55) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.15) => 0.0178878573,
      (c_famotf18_p > 31.15) => 
         map(
         (NULL < c_incollege and c_incollege <= 3.45) => -0.0003720251,
         (c_incollege > 3.45) => 0.1706673785,
         (c_incollege = NULL) => 0.1039432155, 0.1039432155),
      (c_famotf18_p = NULL) => 0.0375145179, 0.0375145179),
   (c_white_col > 21.55) => -0.0169103839,
   (c_white_col = NULL) => -0.0097235685, -0.0130456377),
(f_assocrisktype_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 118.5) => 0.2060867821,
   (f_M_Bureau_ADL_FS_noTU_d > 118.5) => 0.0255999309,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0481607873, 0.0481607873),
(f_assocrisktype_i = NULL) => -0.0022882768, -0.0090401021);

// Tree: 22 
wFDN_FL_PS__lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1881985269,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0200856429,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.1166277486,
            (k_estimated_income_d > 32500) => 0.0401076051,
            (k_estimated_income_d = NULL) => 0.0624214450, 0.0624214450),
         (r_C12_Num_NonDerogs_d > 3.5) => -0.0074605620,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0265845183, 0.0265845183),
      (f_assocrisktype_i = NULL) => -0.0091910311, -0.0091910311),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0081902632, -0.0081902632),
(r_D33_eviction_count_i > 2.5) => 0.1313337475,
(r_D33_eviction_count_i = NULL) => 0.0070865698, -0.0065854286);

// Tree: 23 
wFDN_FL_PS__lgt_23 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 0.0356588423,
      (k_inq_per_phone_i > 2.5) => 0.1368995616,
      (k_inq_per_phone_i = NULL) => 0.0393323717, 0.0393323717),
   (f_phone_ver_experian_d > 0.5) => -0.0398387673,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 0.0095200232,
      (f_assocrisktype_i > 7.5) => 0.1219291608,
      (f_assocrisktype_i = NULL) => 0.0624833380, 0.0199201435), 0.0151316262),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1147103569,
   (r_D33_Eviction_Recency_d > 79.5) => -0.0265456856,
   (r_D33_Eviction_Recency_d = NULL) => -0.0244799897, -0.0244799897),
(k_nap_phn_verd_d = NULL) => -0.0084635941, -0.0084635941);

// Tree: 24 
wFDN_FL_PS__lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.1676562194,
(r_D32_Mos_Since_Fel_LS_d > 127.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 134.5) => -0.0253232038,
      (c_easiqlife > 134.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 0.1479285869,
         (r_C10_M_Hdr_FS_d > 10.5) => 0.0121707714,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0155735783, 0.0155735783),
      (c_easiqlife = NULL) => -0.0329988412, -0.0116871475),
   (f_inq_Communications_count_i > 0.5) => 0.0430602774,
   (f_inq_Communications_count_i = NULL) => -0.0065956897, -0.0065956897),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 127.5) => -0.0749924251,
   (c_new_homes > 127.5) => 0.0666697995,
   (c_new_homes = NULL) => -0.0077628948, -0.0077628948), -0.0055078756);

// Tree: 25 
wFDN_FL_PS__lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0012163372,
         (f_assocrisktype_i > 3.5) => 0.0460215131,
         (f_assocrisktype_i = NULL) => 0.0129054519, 0.0129054519),
      (f_srchfraudsrchcountmo_i > 0.5) => 0.1220371969,
      (f_srchfraudsrchcountmo_i = NULL) => 0.0157918356, 0.0157918356),
   (f_inq_Communications_count_i > 3.5) => 0.1620132368,
   (f_inq_Communications_count_i = NULL) => 0.0458864521, 0.0179343863),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0262549184,
   (r_D33_eviction_count_i > 3.5) => 0.1055599687,
   (r_D33_eviction_count_i = NULL) => -0.0253643953, -0.0253643953),
(k_nap_phn_verd_d = NULL) => -0.0079561346, -0.0079561346);

// Tree: 26 
wFDN_FL_PS__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_employees and c_employees <= 29.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 5.15) => 0.0317895703,
      (c_hh7p_p > 5.15) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => 0.0554719650,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.2282746454,
         (nf_seg_FraudPoint_3_0 = '') => 0.1299241837, 0.1299241837),
      (c_hh7p_p = NULL) => 0.0473454786, 0.0473454786),
   (c_employees > 29.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0087136592,
      (f_assocsuspicousidcount_i > 15.5) => 0.1147033834,
      (f_assocsuspicousidcount_i = NULL) => -0.0080679118, -0.0080679118),
   (c_employees = NULL) => 0.0077586399, -0.0023708986),
(r_D30_Derog_Count_i > 11.5) => 0.0962036590,
(r_D30_Derog_Count_i = NULL) => 0.0079605601, -0.0009378142);

// Tree: 27 
wFDN_FL_PS__lgt_27 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0641087273,
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0204894435,
      (k_nap_contradictory_i > 0.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 23.5) => 0.1712825175,
         (c_many_cars > 23.5) => 0.0239154922,
         (c_many_cars = NULL) => 0.0396924326, 0.0396924326),
      (k_nap_contradictory_i = NULL) => -0.0155273849, -0.0155273849),
   (k_inq_per_ssn_i > 2.5) => 0.0434891810,
   (k_inq_per_ssn_i = NULL) => -0.0086060806, -0.0086060806),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 11.9) => 0.0575155413,
   (C_INC_50K_P > 11.9) => -0.0641707494,
   (C_INC_50K_P = NULL) => 0.0033191261, 0.0033191261), -0.0057809285);

// Tree: 28 
wFDN_FL_PS__lgt_28 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 15.65) => 0.1095960213,
      (c_sfdu_p > 15.65) => 0.0042158210,
      (c_sfdu_p = NULL) => -0.0004506081, 0.0113514302),
   (k_inq_per_ssn_i > 2.5) => 0.0744134802,
   (k_inq_per_ssn_i = NULL) => 0.0181626304, 0.0181626304),
(f_phone_ver_experian_d > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => -0.0386403568,
   (f_inq_HighRiskCredit_count_i > 1.5) => 0.0662851024,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0348955787, -0.0348955787),
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 7.5) => 0.0006014732,
   (f_assocsuspicousidcount_i > 7.5) => 0.1001471206,
   (f_assocsuspicousidcount_i = NULL) => -0.0088928894, 0.0047466614), -0.0092749348);

// Tree: 29 
wFDN_FL_PS__lgt_29 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1104848866,
   (r_C10_M_Hdr_FS_d > 2.5) => -0.0085350710,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0079132108, -0.0079132108),
(k_comb_age_d > 67.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 29.5) => 
      map(
      (NULL < c_professional and c_professional <= 5.9) => 0.3014578207,
      (c_professional > 5.9) => 0.0559733532,
      (c_professional = NULL) => 0.1909898103, 0.1909898103),
   (c_born_usa > 29.5) => 0.0472162557,
   (c_born_usa = NULL) => 0.0674186287, 0.0674186287),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 64) => 0.0858103662,
   (c_larceny > 64) => -0.0724852373,
   (c_larceny = NULL) => -0.0025713458, -0.0025713458), -0.0026103791);

// Tree: 30 
wFDN_FL_PS__lgt_30 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 17.95) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 24.15) => 
         map(
         (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 0.1785686821,
         (r_A44_curr_add_naprop_d > 1.5) => 0.0301861238,
         (r_A44_curr_add_naprop_d = NULL) => 0.1153236572, 0.1153236572),
      (c_fammar18_p > 24.15) => 0.0158812032,
      (c_fammar18_p = NULL) => 0.0572402238, 0.0572402238),
   (c_white_col > 17.95) => 
      map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1125379671,
      (f_attr_arrest_recency_d > 79.5) => -0.0103751867,
      (f_attr_arrest_recency_d = NULL) => -0.0094982051, -0.0094982051),
   (c_white_col = NULL) => -0.0251811493, -0.0075359136),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1169503566,
(f_inq_PrepaidCards_count_i = NULL) => -0.0067757815, -0.0070187720);

// Tree: 31 
wFDN_FL_PS__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1096497451,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0138306105,
         (f_phone_ver_experian_d > 0.5) => -0.0246121209,
         (f_phone_ver_experian_d = NULL) => -0.0034828316, -0.0075180017),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0069582982, -0.0069582982),
   (k_comb_age_d > 81.5) => 0.1696894760,
   (k_comb_age_d = NULL) => -0.0048805880, -0.0048805880),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1539974242,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 11.7) => -0.0509273118,
   (c_health > 11.7) => 0.0709706013,
   (c_health = NULL) => -0.0033109395, -0.0033109395), -0.0042005597);

// Tree: 32 
wFDN_FL_PS__lgt_32 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 1.65) => 0.1269020180,
   (c_pop_85p_p > 1.65) => -0.0001997166,
   (c_pop_85p_p = NULL) => 0.0819408602, 0.0819408602),
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0316847455,
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0189201234,
      (f_hh_collections_ct_i > 2.5) => 0.0434859040,
      (f_hh_collections_ct_i = NULL) => -0.0118963935, -0.0118963935),
   (f_hh_members_ct_d = NULL) => -0.0033439068, -0.0033439068),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0458118616,
   (f_addrs_per_ssn_i > 4.5) => 0.0860873250,
   (f_addrs_per_ssn_i = NULL) => 0.0176205717, 0.0176205717), -0.0021121886);

// Tree: 33 
wFDN_FL_PS__lgt_33 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.75) => -0.0140281302,
   (c_unemp > 11.75) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.1761447726,
      (f_property_owners_ct_d > 0.5) => -0.0181019642,
      (f_property_owners_ct_d = NULL) => 0.0765729159, 0.0765729159),
   (c_unemp = NULL) => -0.0171734562, -0.0129639771),
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => 0.0140537261,
   (r_pb_order_freq_d > 126.5) => -0.0148088966,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1365124885,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => 0.0490508578,
      (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0531329045, 0.0531329045), 0.0221089167),
(f_rel_criminal_count_i = NULL) => -0.0250914113, -0.0040726384);

// Tree: 34 
wFDN_FL_PS__lgt_34 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 78.5) => -0.0040987886,
(r_pb_order_freq_d > 78.5) => -0.0277740853,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 49.5) => 
      map(
      (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 91.5) => 0.1153790044,
         (c_rest_indx > 91.5) => 0.0083505836,
         (c_rest_indx = NULL) => 0.0575230751, 0.0575230751),
      (f_hh_members_w_derog_i > 3.5) => 0.2162035211,
      (f_hh_members_w_derog_i = NULL) => 0.0668240603, 0.0668240603),
   (c_no_teens > 49.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 21.5) => -0.0030414794,
      (f_rel_homeover200_count_d > 21.5) => 0.1349938182,
      (f_rel_homeover200_count_d = NULL) => 0.0127130936, 0.0009222206),
   (c_no_teens = NULL) => -0.0003600137, 0.0164199522), -0.0028298268);

// Tree: 35 
wFDN_FL_PS__lgt_35 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0105970516,
      (f_srchcomponentrisktype_i > 1.5) => 0.0424191405,
      (f_srchcomponentrisktype_i = NULL) => -0.0079851335, -0.0079851335),
   (f_hh_tot_derog_i > 5.5) => 0.0748242549,
   (f_hh_tot_derog_i = NULL) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0842595354,
      (f_addrs_per_ssn_i > 4.5) => 0.0501034007,
      (f_addrs_per_ssn_i = NULL) => -0.0177059315, -0.0177059315), -0.0057477137),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 99.5) => 0.1472590125,
   (f_curraddrburglaryindex_i > 99.5) => -0.0042987103,
   (f_curraddrburglaryindex_i = NULL) => 0.0965142392, 0.0965142392),
(r_P85_Phn_Disconnected_i = NULL) => -0.0038693507, -0.0038693507);

// Tree: 36 
wFDN_FL_PS__lgt_36 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 90.5) => 0.2452312747,
      (c_medi_indx > 90.5) => 0.0335833586,
      (c_medi_indx = NULL) => 0.0920070021, 0.0920070021),
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0104681862,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0088684434, -0.0088684434),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 95.5) => 0.2324012174,
      (c_serv_empl > 95.5) => 0.0551186829,
      (c_serv_empl = NULL) => 0.1397308017, 0.1397308017),
   (f_util_adl_count_n > 1.5) => 0.0017206668,
   (f_util_adl_count_n = NULL) => 0.0699618405, 0.0699618405),
(f_srchcomponentrisktype_i = NULL) => -0.0127613214, -0.0072196199);

// Tree: 37 
wFDN_FL_PS__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0095350258,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0232472066,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 18.45) => 0.1519178171,
      (C_INC_75K_P > 18.45) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 67.5) => 0.1044845454,
         (c_retired2 > 67.5) => -0.0670539179,
         (c_retired2 = NULL) => 0.0138604516, 0.0138604516),
      (C_INC_75K_P = NULL) => 0.0798287494, 0.0798287494),
   (f_varrisktype_i = NULL) => 0.0262715444, 0.0262715444),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0640566074,
   (r_S66_adlperssn_count_i > 1.5) => 0.0792748918,
   (r_S66_adlperssn_count_i = NULL) => 0.0123868588, 0.0123868588), 0.0015771521);

// Tree: 38 
wFDN_FL_PS__lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0333275133,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.35) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1431524408) => 
            map(
            (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 24) => 0.1990726257,
            (f_fp_prevaddrcrimeindex_i > 24) => 0.0150967256,
            (f_fp_prevaddrcrimeindex_i = NULL) => 0.0454728088, 0.0454728088),
         (f_add_curr_nhood_BUS_pct_i > 0.1431524408) => 0.1994825690,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0686965028, 0.0686965028),
      (c_high_ed > 5.35) => 0.0064999555,
      (c_high_ed = NULL) => -0.0055894635, 0.0092222456),
   (nf_seg_FraudPoint_3_0 = '') => -0.0056396971, -0.0056396971),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1017140873,
(f_inq_PrepaidCards_count_i = NULL) => -0.0125550810, -0.0051656620);

// Tree: 39 
wFDN_FL_PS__lgt_39 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => -0.0047780069,
   (f_srchcomponentrisktype_i > 3.5) => 0.0775541953,
   (f_srchcomponentrisktype_i = NULL) => 0.0002865636, -0.0034465659),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 0.25) => 0.2099184441,
      (c_hval_80k_p > 0.25) => -0.0025618329,
      (c_hval_80k_p = NULL) => 0.1280358008, 0.1280358008),
   (f_srchfraudsrchcount_i > 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 8.05) => 0.0473192828,
      (c_construction > 8.05) => -0.0559046256,
      (c_construction = NULL) => 0.0077920788, 0.0077920788),
   (f_srchfraudsrchcount_i = NULL) => 0.0478088802, 0.0478088802),
(k_inq_per_phone_i = NULL) => -0.0009130882, -0.0009130882);

// Tree: 40 
wFDN_FL_PS__lgt_40 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0212131349,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.1358390751,
      (r_C10_M_Hdr_FS_d > 11.5) => 0.0090199851,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0121768773, 0.0121768773),
   (k_inq_per_ssn_i = NULL) => -0.0072252733, -0.0072252733),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33150.5) => 0.1558771991,
      (f_curraddrmedianincome_d > 33150.5) => 0.0663735165,
      (f_curraddrmedianincome_d = NULL) => 0.0806794330, 0.0806794330),
   (r_Phn_Cell_n > 0.5) => -0.0047424922,
   (r_Phn_Cell_n = NULL) => 0.0401878099, 0.0401878099),
(k_nap_contradictory_i = NULL) => -0.0037005956, -0.0037005956);

// Tree: 41 
wFDN_FL_PS__lgt_41 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 41.5) => -0.0016053614,
(r_pb_order_freq_d > 41.5) => -0.0297688614,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 207.35) => 0.1528901269,
      (c_cpiall > 207.35) => 0.0329703673,
      (c_cpiall = NULL) => 0.0434631165, 0.0469465374),
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 9.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 72.5) => -0.0138771661,
         (k_comb_age_d > 72.5) => 0.1395441343,
         (k_comb_age_d = NULL) => -0.0096239892, -0.0096239892),
      (f_rel_criminal_count_i > 9.5) => 0.0862614454,
      (f_rel_criminal_count_i = NULL) => -0.0060131303, -0.0060131303),
   (f_hh_members_ct_d = NULL) => 0.0024181807, 0.0062418227), -0.0085133951);

// Tree: 42 
wFDN_FL_PS__lgt_42 := map(
(NULL < c_employees and c_employees <= 40.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45378.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 1.25) => 0.0328747793,
      (c_hh7p_p > 1.25) => 0.1171697186,
      (c_hh7p_p = NULL) => 0.0656479431, 0.0656479431),
   (f_curraddrmedianincome_d > 45378.5) => 0.0066820790,
   (f_curraddrmedianincome_d = NULL) => 0.0284464671, 0.0284464671),
(c_employees > 40.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0122066038,
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 25.5) => 0.1910108293,
      (c_born_usa > 25.5) => 0.0417907347,
      (c_born_usa = NULL) => 0.0571649263, 0.0571649263),
   (k_comb_age_d = NULL) => -0.0140900018, -0.0079879707),
(c_employees = NULL) => -0.0361512742, -0.0041703327);

// Tree: 43 
wFDN_FL_PS__lgt_43 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0037221379,
(f_hh_tot_derog_i > 4.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 145.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 19.15) => 0.1381341278,
      (c_hh2_p > 19.15) => -0.0041786931,
      (c_hh2_p = NULL) => 0.0114374135, 0.0114374135),
   (f_prevaddrcartheftindex_i > 145.5) => 
      map(
      (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 9.35) => 0.1090523324,
         (C_INC_25K_P > 9.35) => 0.2735080132,
         (C_INC_25K_P = NULL) => 0.1896988682, 0.1896988682),
      (r_D31_MostRec_Bk_i > 0.5) => 0.0230254822,
      (r_D31_MostRec_Bk_i = NULL) => 0.1313631831, 0.1313631831),
   (f_prevaddrcartheftindex_i = NULL) => 0.0408219819, 0.0408219819),
(f_hh_tot_derog_i = NULL) => -0.0114799854, -0.0014981984);

// Tree: 44 
wFDN_FL_PS__lgt_44 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 14.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.55) => -0.0072248602,
   (c_hh7p_p > 7.55) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0291231708,
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 0.1585084800,
      (nf_seg_FraudPoint_3_0 = '') => 0.0486089102, 0.0486089102),
   (c_hh7p_p = NULL) => -0.0057386603, -0.0049490272),
(f_srchssnsrchcount_i > 14.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 116.5) => 0.1358185544,
   (c_new_homes > 116.5) => -0.0123583490,
   (c_new_homes = NULL) => 0.0734282793, 0.0734282793),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 9.9) => -0.0649411156,
   (c_newhouse > 9.9) => 0.0590883193,
   (c_newhouse = NULL) => 0.0038564616, 0.0038564616), -0.0040370134);

// Tree: 45 
wFDN_FL_PS__lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 0.0103763097,
      (f_inq_PrepaidCards_count_i > 1.5) => 0.1081922629,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0116280067, 0.0116280067),
   (f_historical_count_d > 0.5) => -0.0202172619,
   (f_historical_count_d = NULL) => -0.0041797022, -0.0041797022),
(k_comb_age_d > 67.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 171.5) => 0.0337869211,
   (c_sub_bus > 171.5) => 0.1892839353,
   (c_sub_bus = NULL) => 0.0523616498, 0.0523616498),
(k_comb_age_d = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0892435900,
   (k_nap_phn_verd_d > 0.5) => -0.1037635437,
   (k_nap_phn_verd_d = NULL) => 0.0179148667, 0.0179148667), 0.0001123860);

// Tree: 46 
wFDN_FL_PS__lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 89.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 2.05) => -0.0002853413,
      (c_hval_500k_p > 2.05) => 0.2057226169,
      (c_hval_500k_p = NULL) => 0.0874587890, 0.0874587890),
   (f_mos_liens_unrel_SC_fseen_d > 89.5) => 
      map(
      (NULL < c_finance and c_finance <= 0.15) => 0.0200783971,
      (c_finance > 0.15) => -0.0133734886,
      (c_finance = NULL) => -0.0185221645, -0.0029750163),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0013919140, -0.0013919140),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 134) => 0.0254751665,
   (c_asian_lang > 134) => 0.2066121610,
   (c_asian_lang = NULL) => 0.0801378098, 0.0801378098),
(r_D32_felony_count_i = NULL) => -0.0302820607, -0.0005790086);

// Tree: 47 
wFDN_FL_PS__lgt_47 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => -0.0047692085,
(f_hh_lienholders_i > 1.5) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 19.55) => 0.0186849368,
   (c_hval_250k_p > 19.55) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 84.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 14.6) => 0.0711207662,
         (c_hh4_p > 14.6) => 0.3037391773,
         (c_hh4_p = NULL) => 0.1810192281, 0.1810192281),
      (c_born_usa > 84.5) => 0.0397443951,
      (c_born_usa = NULL) => 0.1092866579, 0.1092866579),
   (c_hval_250k_p = NULL) => 0.0359233173, 0.0359233173),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1095.5) => -0.0701482982,
   (c_popover25 > 1095.5) => 0.0446948402,
   (c_popover25 = NULL) => -0.0112791264, -0.0112791264), -0.0004246433);

// Tree: 48 
wFDN_FL_PS__lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0046789473,
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_employees and c_employees <= 37.5) => 0.1175533491,
   (c_employees > 37.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 4.35) => -0.0589849789,
         (c_famotf18_p > 4.35) => 
            map(
            (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 405.5) => -0.0047051719,
            (r_A50_pb_total_dollars_d > 405.5) => 0.1289217688,
            (r_A50_pb_total_dollars_d = NULL) => 0.0694864731, 0.0694864731),
         (c_famotf18_p = NULL) => 0.0383328877, 0.0383328877),
      (k_inq_adls_per_phone_i > 2.5) => -0.0679835179,
      (k_inq_adls_per_phone_i = NULL) => 0.0205453352, 0.0205453352),
   (c_employees = NULL) => 0.0360603488, 0.0360603488),
(k_inq_per_phone_i = NULL) => -0.0026684782, -0.0026684782);

// Tree: 49 
wFDN_FL_PS__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0020041424,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1369486293,
      (r_C10_M_Hdr_FS_d > 33) => 
         map(
         (NULL < f_inq_Banking_count_i and f_inq_Banking_count_i <= 2.5) => 0.0037137279,
         (f_inq_Banking_count_i > 2.5) => 0.1016113027,
         (f_inq_Banking_count_i = NULL) => 0.0292731932, 0.0292731932),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0536796254, 0.0536796254),
   (f_varrisktype_i = NULL) => 0.0042551902, 0.0042551902),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0700198670,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 413.5) => -0.0729939213,
   (c_families > 413.5) => 0.0881979288,
   (c_families = NULL) => 0.0048228339, 0.0048228339), 0.0012508678);

// Tree: 50 
wFDN_FL_PS__lgt_50 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0156040463,
(f_corrrisktype_i > 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_I60_inq_banking_count12_i and r_I60_inq_banking_count12_i <= 1.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 0.0267675542,
         (k_comb_age_d > 71.5) => 0.1434650194,
         (k_comb_age_d = NULL) => 0.0306014493, 0.0306014493),
      (r_I60_inq_banking_count12_i > 1.5) => 0.1388677315,
      (r_I60_inq_banking_count12_i = NULL) => 0.0335864715, 0.0335864715),
   (f_phone_ver_experian_d > 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 15.5) => 0.1892047798,
      (f_M_Bureau_ADL_FS_all_d > 15.5) => -0.0310047952,
      (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0244576838, -0.0244576838),
   (f_phone_ver_experian_d = NULL) => 0.0177774846, 0.0109727660),
(f_corrrisktype_i = NULL) => 0.0275477684, -0.0035366860);

// Tree: 51 
wFDN_FL_PS__lgt_51 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0102905835,
   (f_rel_criminal_count_i > 2.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 37.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1928156894) => 0.0074858083,
         (f_add_curr_nhood_BUS_pct_i > 0.1928156894) => 0.1807365021,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0178965643, 0.0178965643),
      (r_pb_order_freq_d > 37.5) => -0.0163057374,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 0.0347479203,
         (C_INC_75K_P > 27.85) => 0.1394672555,
         (C_INC_75K_P = NULL) => 0.0422528060, 0.0422528060), 0.0145791835),
   (f_rel_criminal_count_i = NULL) => 0.0038942613, -0.0036319086),
(k_inq_adls_per_phone_i > 3.5) => -0.1064104005,
(k_inq_adls_per_phone_i = NULL) => -0.0041423576, -0.0041423576);

// Tree: 52 
wFDN_FL_PS__lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0226078025,
      (f_corrrisktype_i > 8.5) => 0.0105086128,
      (f_corrrisktype_i = NULL) => -0.0077692313, -0.0077692313),
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1215044416,
      (f_phone_ver_experian_d > 0.5) => 0.0558475221,
      (f_phone_ver_experian_d = NULL) => -0.0149752526, 0.0561564076),
   (k_comb_age_d = NULL) => -0.0245691457, -0.0048714393),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 307790.5) => 0.0273855985,
   (f_prevaddrmedianvalue_d > 307790.5) => 0.2082898766,
   (f_prevaddrmedianvalue_d = NULL) => 0.0697732118, 0.0697732118),
(r_P85_Phn_Disconnected_i = NULL) => -0.0034120878, -0.0034120878);

// Tree: 53 
wFDN_FL_PS__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 134.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
      map(
      (NULL < c_unempl and c_unempl <= 188.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0035139609,
         (f_util_adl_count_n > 3.5) => 0.0658469935,
         (f_util_adl_count_n = NULL) => 0.0072947878, 0.0072947878),
      (c_unempl > 188.5) => 0.1056297174,
      (c_unempl = NULL) => 0.0102746342, 0.0102746342),
   (k_estimated_income_d > 32500) => -0.0273103643,
   (k_estimated_income_d = NULL) => -0.0357096588, -0.0159133865),
(c_easiqlife > 134.5) => 
   map(
   (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 0.0183952186,
   (f_attr_arrests_i > 0.5) => 0.1166263360,
   (f_attr_arrests_i = NULL) => 0.0198051241, 0.0198051241),
(c_easiqlife = NULL) => -0.0022352534, -0.0035170374);

// Tree: 54 
wFDN_FL_PS__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1352195673,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 38.3) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => -0.0212818949,
      (f_sourcerisktype_i > 3.5) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 11.05) => 0.0066904827,
         (c_hh6_p > 11.05) => 
            map(
            (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 107) => 0.0397739141,
            (f_curraddrcrimeindex_i > 107) => 0.1940646381,
            (f_curraddrcrimeindex_i = NULL) => 0.0747860399, 0.0747860399),
         (c_hh6_p = NULL) => 0.0090345639, 0.0090345639),
      (f_sourcerisktype_i = NULL) => -0.0023813408, -0.0023813408),
   (c_hval_60k_p > 38.3) => -0.1084779095,
   (c_hval_60k_p = NULL) => -0.0256858584, -0.0037192857),
(f_attr_arrest_recency_d = NULL) => 0.0075281212, -0.0030741019);

// Tree: 55 
wFDN_FL_PS__lgt_55 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1019020648) => 0.0061894250,
   (f_add_curr_nhood_VAC_pct_i > 0.1019020648) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 10.55) => 
         map(
         (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0939235135,
         (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0231445424,
         (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0207256814, 0.0207256814),
      (c_hval_150k_p > 10.55) => 
         map(
         (NULL < c_larceny and c_larceny <= 95) => 0.0203664737,
         (c_larceny > 95) => 0.2067580577,
         (c_larceny = NULL) => 0.1330207278, 0.1330207278),
      (c_hval_150k_p = NULL) => 0.0514590625, 0.0514590625),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0130911046, 0.0130911046),
(k_estimated_income_d > 34500) => -0.0165789378,
(k_estimated_income_d = NULL) => 0.0001111331, -0.0061566993);

// Tree: 56 
wFDN_FL_PS__lgt_56 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 162.5) => -0.0073345387,
   (r_C13_Curr_Addr_LRes_d > 162.5) => 0.0219534345,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0010102715, -0.0010102715),
(f_inq_HighRiskCredit_count_i > 5.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => -0.0361445639,
   (f_mos_inq_banko_cm_fseen_d > 41.5) => 
      map(
      (NULL < c_rental and c_rental <= 141.5) => 0.1333394157,
      (c_rental > 141.5) => -0.0058701817,
      (c_rental = NULL) => 0.0850800886, 0.0850800886),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0470596294, 0.0470596294),
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 17.4) => -0.0428166602,
   (C_INC_75K_P > 17.4) => 0.0792966730,
   (C_INC_75K_P = NULL) => 0.0126894003, 0.0126894003), -0.0000545410);

// Tree: 57 
wFDN_FL_PS__lgt_57 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => -0.0078931389,
      (k_inq_per_phone_i > 9.5) => 0.0818497082,
      (k_inq_per_phone_i = NULL) => -0.0072246770, -0.0072246770),
   (r_D30_Derog_Count_i > 11.5) => 
      map(
      (NULL < c_employees and c_employees <= 216.5) => 0.1216672097,
      (c_employees > 216.5) => 0.0041516117,
      (c_employees = NULL) => 0.0539841754, 0.0539841754),
   (r_D30_Derog_Count_i = NULL) => -0.0034753594, -0.0064077342),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 68.5) => 0.0147537891,
   (r_pb_order_freq_d > 68.5) => 0.2077570256,
   (r_pb_order_freq_d = NULL) => 0.1112554073, 0.1112554073),
(f_adls_per_phone_c6_i = NULL) => -0.0047380956, -0.0047380956);

// Tree: 58 
wFDN_FL_PS__lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 77.5) => 0.1587655866,
      (c_born_usa > 77.5) => 
         map(
         (NULL < c_bargains and c_bargains <= 82.5) => 0.1387328853,
         (c_bargains > 82.5) => -0.0639850137,
         (c_bargains = NULL) => 0.0143992406, 0.0143992406),
      (c_born_usa = NULL) => 0.0633693227, 0.0633693227),
   (f_mos_liens_unrel_SC_fseen_d > 93.5) => -0.0077040817,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0111785220, -0.0062255766),
(k_inq_per_phone_i > 5.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 19.5) => 0.1213308440,
   (f_srchphonesrchcount_i > 19.5) => -0.0705946459,
   (f_srchphonesrchcount_i = NULL) => 0.0682252473, 0.0682252473),
(k_inq_per_phone_i = NULL) => -0.0050047826, -0.0050047826);

// Tree: 59 
wFDN_FL_PS__lgt_59 := map(
(NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0351540539,
(f_addrs_per_ssn_i > 3.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 0.1146030662,
   (r_C10_M_Hdr_FS_d > 10.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < c_housingcpi and c_housingcpi <= 222.35) => 
            map(
            (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 6.5) => -0.0106138929,
            (f_inq_Other_count_i > 6.5) => 0.1258264849,
            (f_inq_Other_count_i = NULL) => -0.0095383097, -0.0095383097),
         (c_housingcpi > 222.35) => 0.0291042723,
         (c_housingcpi = NULL) => -0.0155880318, -0.0011536100),
      (f_nae_nothing_found_i > 0.5) => 0.1391971619,
      (f_nae_nothing_found_i = NULL) => 0.0004432843, 0.0004432843),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0306022749, 0.0014363694),
(f_addrs_per_ssn_i = NULL) => -0.0048346263, -0.0048346263);

// Tree: 60 
wFDN_FL_PS__lgt_60 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 8.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
         map(
         (NULL < c_murders and c_murders <= 50) => 0.1965835700,
         (c_murders > 50) => 0.0202816989,
         (c_murders = NULL) => 0.0653111812, 0.0653111812),
      (f_mos_liens_unrel_SC_fseen_d > 93.5) => -0.0035739173,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0022770340, -0.0022770340),
   (k_inq_per_phone_i > 6.5) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 2.5) => 0.1668773587,
      (nf_vf_level > 2.5) => 0.0000835570,
      (nf_vf_level = NULL) => 0.0914230198, 0.0914230198),
   (k_inq_per_phone_i = NULL) => -0.0013326885, -0.0013326885),
(f_srchfraudsrchcountyr_i > 8.5) => -0.0776035149,
(f_srchfraudsrchcountyr_i = NULL) => -0.0096670304, -0.0018117527);

// Tree: 61 
wFDN_FL_PS__lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 41.4) => 0.1598996549,
   (r_C12_source_profile_d > 41.4) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 53) => -0.0383087251,
      (f_mos_inq_banko_cm_fseen_d > 53) => 0.0839961903,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0254739458, 0.0254739458),
   (r_C12_source_profile_d = NULL) => 0.0570059023, 0.0570059023),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0070881663,
   (r_C13_Curr_Addr_LRes_d > 158.5) => 0.0236019564,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0001207193, -0.0001207193),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0959690027,
   (c_rnt1000_p > 10.8) => 0.0336726734,
   (c_rnt1000_p = NULL) => -0.0269075491, -0.0269075491), 0.0007371162);

// Tree: 62 
wFDN_FL_PS__lgt_62 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.0918182142,
(f_M_Bureau_ADL_FS_noTU_d > 2.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0006117051,
      (k_nap_contradictory_i > 0.5) => 0.0425139034,
      (k_nap_contradictory_i = NULL) => 0.0024948921, 0.0024948921),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 36.05) => -0.1100953596,
      (C_OWNOCC_P > 36.05) => -0.0286203139,
      (C_OWNOCC_P = NULL) => -0.0616895972, -0.0616895972),
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0001279207, -0.0001279207),
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 65.5) => 0.0896846343,
   (c_rental > 65.5) => -0.0355730989,
   (c_rental = NULL) => 0.0294645702, 0.0294645702), 0.0006557464);

// Tree: 63 
wFDN_FL_PS__lgt_63 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 122.5) => 0.1472347030,
   (c_asian_lang > 122.5) => 0.0079685287,
   (c_asian_lang = NULL) => 0.0569566302, 0.0569566302),
(r_C10_M_Hdr_FS_d > 8.5) => 
   map(
   (NULL < r_nas_fname_verd_d and r_nas_fname_verd_d <= 0.5) => 0.1795143620,
   (r_nas_fname_verd_d > 0.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 0.0008146195,
      (c_hval_80k_p > 19.25) => -0.0433174871,
      (c_hval_80k_p = NULL) => 0.0021278473, -0.0019879156),
   (r_nas_fname_verd_d = NULL) => -0.0012240047, -0.0012240047),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 94) => -0.0812270384,
   (c_no_teens > 94) => 0.0486700804,
   (c_no_teens = NULL) => -0.0082270047, -0.0082270047), -0.0003579053);

// Tree: 64 
wFDN_FL_PS__lgt_64 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 195500) => 0.1669699132,
   (r_A46_Curr_AVM_AutoVal_d > 195500) => 0.0700359628,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0000589470, 0.0495116714),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 270.5) => -0.0071199769,
   (r_C13_Curr_Addr_LRes_d > 270.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 250.95) => 0.0250096352,
      (c_housingcpi > 250.95) => 0.2370291753,
      (c_housingcpi = NULL) => 0.0437636913, 0.0437636913),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0025744244, -0.0025744244),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 101) => 0.0312103994,
   (c_apt20 > 101) => -0.0779559820,
   (c_apt20 = NULL) => -0.0109675207, -0.0109675207), -0.0015639701);

// Tree: 65 
wFDN_FL_PS__lgt_65 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 73.5) => -0.0017581185,
   (r_C13_Curr_Addr_LRes_d > 73.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 410555.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 69.95) => 0.0171228992,
         (c_rnt1000_p > 69.95) => 0.2874755538,
         (c_rnt1000_p = NULL) => 0.0248244975, 0.0248244975),
      (c_med_hval > 410555.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.1526380937,
         (f_corrphonelastnamecount_d > 0.5) => 0.0328230283,
         (f_corrphonelastnamecount_d = NULL) => 0.1023644896, 0.1023644896),
      (c_med_hval = NULL) => 0.0151077176, 0.0399461594),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0157643051, 0.0157643051),
(f_phone_ver_insurance_d > 3.5) => -0.0132461470,
(f_phone_ver_insurance_d = NULL) => 0.0114131004, 0.0016832048);

// Tree: 66 
wFDN_FL_PS__lgt_66 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 207.35) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 51845.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3388887034) => 0.2517203277,
         (f_add_curr_mobility_index_i > 0.3388887034) => 0.0462262219,
         (f_add_curr_mobility_index_i = NULL) => 0.1472608239, 0.1472608239),
      (f_curraddrmedianincome_d > 51845.5) => 0.0252140607,
      (f_curraddrmedianincome_d = NULL) => 0.0607616617, 0.0607616617),
   (c_cpiall > 207.35) => 0.0095306560,
   (c_cpiall = NULL) => -0.0182813147, 0.0118442428),
(f_historical_count_d > 0.5) => -0.0130867927,
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 97.5) => -0.0743995917,
   (c_medi_indx > 97.5) => 0.0491466050,
   (c_medi_indx = NULL) => 0.0027006664, 0.0027006664), -0.0007293951);

// Tree: 67 
wFDN_FL_PS__lgt_67 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0043220001,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 23) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 17.05) => 0.0584577563,
         (c_hh3_p > 17.05) => 0.2825847384,
         (c_hh3_p = NULL) => 0.1768988444, 0.1768988444),
      (r_pb_order_freq_d > 23) => 
         map(
         (NULL < c_med_age and c_med_age <= 37.55) => -0.0740376794,
         (c_med_age > 37.55) => 0.1158192079,
         (c_med_age = NULL) => 0.0248698008, 0.0248698008),
      (r_pb_order_freq_d = NULL) => 0.0368263299, 0.0694014033),
   (f_phone_ver_experian_d > 0.5) => -0.0018905998,
   (f_phone_ver_experian_d = NULL) => 0.0267487085, 0.0236723182),
(f_util_adl_count_n = NULL) => -0.0099347051, -0.0009583871);

// Tree: 68 
wFDN_FL_PS__lgt_68 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 12.95) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 52) => 0.1336612999,
      (f_mos_liens_unrel_SC_fseen_d > 52) => 0.0088748872,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0098985493, 0.0098985493),
   (c_newhouse > 12.95) => -0.0149456515,
   (c_newhouse = NULL) => 0.0224629388, -0.0015919823),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 4.5) => -0.0074695751,
   (f_rel_ageover30_count_d > 4.5) => 0.1717289128,
   (f_rel_ageover30_count_d = NULL) => 0.0778041881, 0.0778041881),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_highrent and c_highrent <= 0.15) => 0.0353502205,
   (c_highrent > 0.15) => -0.0734126250,
   (c_highrent = NULL) => -0.0211722032, -0.0211722032), -0.0008663060);

// Tree: 69 
wFDN_FL_PS__lgt_69 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.36) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => 
         map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0070274173,
         (k_inq_per_ssn_i > 10.5) => 0.0752094181,
         (k_inq_per_ssn_i = NULL) => -0.0062744581, -0.0062744581),
      (f_inq_Communications_count24_i > 2.5) => 0.0674422356,
      (f_inq_Communications_count24_i = NULL) => -0.0057565708, -0.0057565708),
   (c_hhsize > 4.36) => 0.1109949566,
   (c_hhsize = NULL) => -0.0044392873, -0.0048468337),
(f_srchssnsrchcount_i > 22.5) => 0.0801416388,
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0960446798,
   (f_addrs_per_ssn_i > 3.5) => 0.0350560881,
   (f_addrs_per_ssn_i = NULL) => -0.0288955060, -0.0288955060), -0.0045440279);

// Tree: 70 
wFDN_FL_PS__lgt_70 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 21.5) => -0.0895651771,
(f_mos_inq_banko_am_lseen_d > 21.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 18.5) => 
         map(
         (NULL < c_rnt1500_p and c_rnt1500_p <= 0.05) => 0.1518069952,
         (c_rnt1500_p > 0.05) => 0.0265411442,
         (c_rnt1500_p = NULL) => 0.0653403016, 0.0653403016),
      (c_sfdu_p > 18.5) => 0.0087416525,
      (c_sfdu_p = NULL) => 0.0036202098, 0.0135227107),
   (f_phone_ver_experian_d > 0.5) => -0.0139725357,
   (f_phone_ver_experian_d = NULL) => -0.0084790016, -0.0041144297),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 14.45) => -0.0461657120,
   (C_INC_100K_P > 14.45) => 0.0802632589,
   (C_INC_100K_P = NULL) => 0.0085869919, 0.0085869919), -0.0055316220);

// Tree: 71 
wFDN_FL_PS__lgt_71 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 1.65) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 0.5) => 0.1204788827,
   (r_C12_source_profile_index_d > 0.5) => -0.0053111476,
   (r_C12_source_profile_index_d = NULL) => -0.0101281107, -0.0040265253),
(c_hh7p_p > 1.65) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0564843101,
      (r_Ever_Asset_Owner_d > 0.5) => -0.0021047145,
      (r_Ever_Asset_Owner_d = NULL) => 0.0114662606, 0.0114662606),
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 0.0465652676,
      (r_D32_criminal_count_i > 2.5) => 0.1512101610,
      (r_D32_criminal_count_i = NULL) => 0.0607359302, 0.0607359302),
   (f_rel_felony_count_i = NULL) => 0.0189478935, 0.0189478935),
(c_hh7p_p = NULL) => -0.0241729869, 0.0012686680);

// Tree: 72 
wFDN_FL_PS__lgt_72 := map(
(NULL < r_P85_Phn_Invalid_i and r_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => -0.0062776768,
      (k_comb_age_d > 63.5) => 0.0331140238,
      (k_comb_age_d = NULL) => -0.0018303322, -0.0018303322),
   (f_hh_collections_ct_i > 4.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 119.5) => 0.0105048009,
      (c_rest_indx > 119.5) => 0.2347623636,
      (c_rest_indx = NULL) => 0.0662902642, 0.0662902642),
   (f_hh_collections_ct_i = NULL) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.75) => -0.0349884825,
      (c_pop_55_64_p > 11.75) => 0.0700631356,
      (c_pop_55_64_p = NULL) => 0.0070321647, 0.0070321647), -0.0006192267),
(r_P85_Phn_Invalid_i > 0.5) => -0.0772020185,
(r_P85_Phn_Invalid_i = NULL) => -0.0024364455, -0.0024364455);

// Tree: 73 
wFDN_FL_PS__lgt_73 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 6.5) => -0.0440096209,
   (f_mos_inq_banko_om_fseen_d > 6.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0007904701,
      (f_inq_Communications_count_i > 0.5) => 0.0357743614,
      (f_inq_Communications_count_i = NULL) => 0.0020682799, 0.0020682799),
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0000792775, -0.0000792775),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1019.5) => 0.1165893531,
   (c_popover25 > 1019.5) => 0.0045185626,
   (c_popover25 = NULL) => 0.0584152023, 0.0584152023),
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.55) => -0.0601531525,
   (c_pop_55_64_p > 12.55) => 0.0670284065,
   (c_pop_55_64_p = NULL) => -0.0078446081, -0.0078446081), 0.0004655044);

// Tree: 74 
wFDN_FL_PS__lgt_74 := map(
(NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0196136153,
   (f_util_add_curr_conv_n > 0.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
         map(
         (NULL < c_rnt250_p and c_rnt250_p <= 43.1) => 0.0043805001,
         (c_rnt250_p > 43.1) => 0.1001421749,
         (c_rnt250_p = NULL) => 0.0872269394, 0.0071929342),
      (f_assocsuspicousidcount_i > 13.5) => 0.0993811048,
      (f_assocsuspicousidcount_i = NULL) => 0.0080591139, 0.0080591139),
   (f_util_add_curr_conv_n = NULL) => -0.0042171266, -0.0042171266),
(f_srchphonesrchcountwk_i > 0.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3) => 0.1358412743,
   (r_A44_curr_add_naprop_d > 3) => -0.0356692882,
   (r_A44_curr_add_naprop_d = NULL) => 0.0520203227, 0.0520203227),
(f_srchphonesrchcountwk_i = NULL) => 0.0303762303, -0.0033056881);

// Tree: 75 
wFDN_FL_PS__lgt_75 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1450) => 
   map(
   (NULL < c_employees and c_employees <= 37.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 0.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 118.5) => 0.0175785609,
         (c_unempl > 118.5) => 0.1725659504,
         (c_unempl = NULL) => 0.1014889310, 0.1014889310),
      (f_rel_incomeover50_count_d > 0.5) => 0.0161944962,
      (f_rel_incomeover50_count_d = NULL) => 0.0251398711, 0.0251398711),
   (c_employees > 37.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => -0.0192235319,
      (f_prevaddrageoldest_d > 134.5) => 0.0160970405,
      (f_prevaddrageoldest_d = NULL) => -0.0066935159, -0.0066935159),
   (c_employees = NULL) => -0.0092800896, -0.0028674600),
(f_liens_rel_SC_total_amt_i > 1450) => -0.1328186313,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0194290293, -0.0035679944);

// Tree: 76 
wFDN_FL_PS__lgt_76 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => -0.0039755217,
      (nf_seg_FraudPoint_3_0 in ['3: Derog','6: Other']) => 0.1351592594,
      (nf_seg_FraudPoint_3_0 = '') => 0.0520477751, 0.0520477751),
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0041432508,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.15) => 0.0544571706,
      (c_hval_250k_p > 8.15) => -0.0358411398,
      (c_hval_250k_p = NULL) => 0.0167205633, 0.0167205633), -0.0028959101),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0229000772,
   (f_addrs_per_ssn_i > 5.5) => 0.2090385233,
   (f_addrs_per_ssn_i = NULL) => 0.0846468716, 0.0846468716),
(f_nae_nothing_found_i = NULL) => -0.0016605804, -0.0016605804);

// Tree: 77 
wFDN_FL_PS__lgt_77 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 16) => -0.0134133412,
   (f_srchphonesrchcount_i > 16) => -0.1169901018,
   (f_srchphonesrchcount_i = NULL) => -0.0047060994, -0.0141344941),
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 38.5) => -0.0299659184,
      (c_born_usa > 38.5) => 0.1687942722,
      (c_born_usa = NULL) => 0.0851057709, 0.0851057709),
   (r_C21_M_Bureau_ADL_FS_d > 7.5) => 
      map(
      (NULL < c_transport and c_transport <= 29.05) => 0.0082383274,
      (c_transport > 29.05) => 0.1329451032,
      (c_transport = NULL) => 0.0239760179, 0.0107492200),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0121675513, 0.0121675513),
(f_util_add_curr_conv_n = NULL) => 0.0004316761, 0.0004316761);

// Tree: 78 
wFDN_FL_PS__lgt_78 := map(
(NULL < c_easiqlife and c_easiqlife <= 121.5) => -0.0123319350,
(c_easiqlife > 121.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => -0.0535673377,
         (f_mos_inq_banko_om_lseen_d > 5.5) => 
            map(
            (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.0915530750,
            (r_I60_inq_comm_recency_d > 549) => 0.0395863100,
            (r_I60_inq_comm_recency_d = NULL) => 0.0434597484, 0.0434597484),
         (f_mos_inq_banko_om_lseen_d = NULL) => 0.0370928341, 0.0370928341),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0753159894,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0292229539, 0.0292229539),
   (f_phone_ver_insurance_d > 3.5) => -0.0064371077,
   (f_phone_ver_insurance_d = NULL) => 0.0112472637, 0.0112472637),
(c_easiqlife = NULL) => -0.0136546722, -0.0022625697);

// Tree: 79 
wFDN_FL_PS__lgt_79 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0086230107,
   (f_inq_Communications_count_i > 0.5) => 0.0248528240,
   (f_inq_Communications_count_i = NULL) => -0.0056413905, -0.0056413905),
(f_srchcomponentrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 14.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 829.5) => -0.0350218895,
      (c_hh00 > 829.5) => 0.1468537084,
      (c_hh00 = NULL) => 0.0190005653, 0.0190005653),
   (f_rel_educationover12_count_d > 14.5) => 0.1302328302,
   (f_rel_educationover12_count_d = NULL) => 0.0432926692, 0.0432926692),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 60) => -0.0638191915,
   (c_old_homes > 60) => 0.0396523144,
   (c_old_homes = NULL) => -0.0034608131, -0.0034608131), -0.0045937727);

// Tree: 80 
wFDN_FL_PS__lgt_80 := map(
(NULL < c_med_rent and c_med_rent <= 1523.5) => -0.0038987218,
(c_med_rent > 1523.5) => 
   map(
   (NULL < c_armforce and c_armforce <= 138.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 215) => 0.0208965916,
      (f_M_Bureau_ADL_FS_all_d > 215) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 252240.5) => -0.0420851628,
         (r_A46_Curr_AVM_AutoVal_d > 252240.5) => 0.1184401258,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.2615214568, 0.1213530761),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0735109736, 0.0735109736),
   (c_armforce > 138.5) => -0.0739223938,
   (c_armforce = NULL) => 0.0498922949, 0.0498922949),
(c_med_rent = NULL) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 0.5) => -0.0042501201,
   (f_srchfraudsrchcountyr_i > 0.5) => 0.1418375291,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0178175006, 0.0178175006), 0.0009313734);

// Tree: 81 
wFDN_FL_PS__lgt_81 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0064333636,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 47.5) => 
         map(
         (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
            map(
            (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.1797412808,
            (f_hh_age_18_plus_d > 1.5) => 0.0329542142,
            (f_hh_age_18_plus_d = NULL) => 0.0675307232, 0.0675307232),
         (f_inq_count24_i > 2.5) => -0.0071640765,
         (f_inq_count24_i = NULL) => 0.0242496243, 0.0242496243),
      (c_rnt1000_p > 47.5) => 0.1369556683,
      (c_rnt1000_p = NULL) => 0.0361233379, 0.0361233379),
   (k_inq_per_phone_i = NULL) => -0.0043737840, -0.0043737840),
(f_srchphonesrchcount_i > 22.5) => -0.1089529681,
(f_srchphonesrchcount_i = NULL) => -0.0132744573, -0.0049252795);

// Tree: 82 
wFDN_FL_PS__lgt_82 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 42.1) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 161.5) => -0.0080745965,
      (r_C13_Curr_Addr_LRes_d > 161.5) => 
         map(
         (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 25.5) => 0.0168152654,
         (f_rel_incomeover25_count_d > 25.5) => 0.1532142426,
         (f_rel_incomeover25_count_d = NULL) => 0.0199260268, 0.0199260268),
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0019557679, -0.0019557679),
   (r_I60_inq_hiRiskCred_count12_i > 2.5) => -0.0643803701,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0095188809, -0.0024733684),
(c_hval_500k_p > 42.1) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 153.5) => 0.0402328122,
   (f_prevaddrageoldest_d > 153.5) => 0.2884329238,
   (f_prevaddrageoldest_d = NULL) => 0.1044876635, 0.1044876635),
(c_hval_500k_p = NULL) => -0.0117816050, -0.0010151623);

// Tree: 83 
wFDN_FL_PS__lgt_83 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0022816541,
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < c_young and c_young <= 33.3) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2843076196) => 0.0441240753,
         (f_add_curr_mobility_index_i > 0.2843076196) => 0.2059092683,
         (f_add_curr_mobility_index_i = NULL) => 0.1062732653, 0.1062732653),
      (r_C12_Num_NonDerogs_d > 1.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0604066682,
         (f_phone_ver_experian_d > 0.5) => 0.0212079976,
         (f_phone_ver_experian_d = NULL) => -0.0183118120, 0.0263831145),
      (r_C12_Num_NonDerogs_d = NULL) => 0.0385937247, 0.0385937247),
   (c_young > 33.3) => -0.0454109535,
   (c_young = NULL) => 0.0274784305, 0.0274784305),
(k_inq_per_phone_i = NULL) => 0.0006767587, 0.0006767587);

// Tree: 84 
wFDN_FL_PS__lgt_84 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 7.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 77.45) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 193.5) => -0.0001130040,
      (c_span_lang > 193.5) => 0.0683064629,
      (c_span_lang = NULL) => 0.0013600037, 0.0013600037),
   (c_low_ed > 77.45) => -0.0516942949,
   (c_low_ed = NULL) => 0.0072410237, 0.0000106805),
(f_hh_tot_derog_i > 7.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.55) => -0.0093749861,
   (c_med_age > 36.55) => 0.1716463892,
   (c_med_age = NULL) => 0.0811357015, 0.0811357015),
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 103.35) => 0.0573611579,
   (c_oldhouse > 103.35) => -0.0507044944,
   (c_oldhouse = NULL) => 0.0154752461, 0.0154752461), 0.0008827077);

// Tree: 85 
wFDN_FL_PS__lgt_85 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 12.85) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 2.5) => 0.1213208073,
      (r_C13_max_lres_d > 2.5) => 
         map(
         (NULL < c_hval_80k_p and c_hval_80k_p <= 41.55) => -0.0039934129,
         (c_hval_80k_p > 41.55) => -0.1092960766,
         (c_hval_80k_p = NULL) => -0.0049209951, -0.0049209951),
      (r_C13_max_lres_d = NULL) => -0.0046639956, -0.0039506277),
   (c_unemp > 12.85) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.1321527068,
      (r_D30_Derog_Count_i > 0.5) => -0.0186317778,
      (r_D30_Derog_Count_i = NULL) => 0.0640564880, 0.0640564880),
   (c_unemp = NULL) => 0.0157657920, -0.0027669875),
(k_inq_adls_per_phone_i > 2.5) => -0.0721656573,
(k_inq_adls_per_phone_i = NULL) => -0.0033469055, -0.0033469055);

// Tree: 86 
wFDN_FL_PS__lgt_86 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_pop_85p_p and c_pop_85p_p <= 4.75) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 10.65) => 0.0917687704,
      (c_hh1_p > 10.65) => 0.0049850371,
      (c_hh1_p = NULL) => 0.0128744674, 0.0128744674),
   (c_pop_85p_p > 4.75) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0516774354,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.2093598746,
      (nf_seg_FraudPoint_3_0 = '') => 0.0983981581, 0.0983981581),
   (c_pop_85p_p = NULL) => 0.0411356411, 0.0208119482),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 4.5) => -0.0103269649,
   (r_S66_adlperssn_count_i > 4.5) => 0.0893322853,
   (r_S66_adlperssn_count_i = NULL) => -0.0087501412, -0.0087501412),
(f_hh_members_ct_d = NULL) => -0.0078158972, -0.0027445464);

// Tree: 87 
wFDN_FL_PS__lgt_87 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 24.55) => -0.0088234299,
(c_famotf18_p > 24.55) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 32.55) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 240.5) => 0.0934672823,
         (r_D32_Mos_Since_Crim_LS_d > 240.5) => 0.0098558155,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0251950621, 0.0251950621),
      (f_historical_count_d > 1.5) => -0.0475428466,
      (f_historical_count_d = NULL) => -0.0028379397, -0.0028379397),
   (c_rnt1000_p > 32.55) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 109.5) => 0.1356663642,
      (c_relig_indx > 109.5) => -0.0013119394,
      (c_relig_indx = NULL) => 0.0864022375, 0.0864022375),
   (c_rnt1000_p = NULL) => 0.0184452825, 0.0184452825),
(c_famotf18_p = NULL) => 0.0057794177, -0.0054092435);

// Tree: 88 
wFDN_FL_PS__lgt_88 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0046620507,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 16.65) => 0.0112907793,
         (c_hval_175k_p > 16.65) => 0.0913118102,
         (c_hval_175k_p = NULL) => 0.0232342168, 0.0232342168),
      (k_comb_age_d > 69.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 25.7) => 0.0094949835,
         (C_RENTOCC_P > 25.7) => 0.2410173503,
         (C_RENTOCC_P = NULL) => 0.1107860190, 0.1107860190),
      (k_comb_age_d = NULL) => 0.0276305509, 0.0276305509),
   (k_inq_per_ssn_i = NULL) => 0.0019651142, 0.0019651142),
(f_srchphonesrchcountmo_i > 2.5) => -0.1081271884,
(f_srchphonesrchcountmo_i = NULL) => -0.0179614447, 0.0013552293);

// Tree: 89 
wFDN_FL_PS__lgt_89 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 287.5) => -0.0064614394,
   (r_C13_Curr_Addr_LRes_d > 287.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 45.25) => 0.0221211833,
      (c_hval_750k_p > 45.25) => 0.2672419672,
      (c_hval_750k_p = NULL) => 0.0370803746, 0.0370803746),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0031206890, -0.0031206890),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 676.5) => 0.1294634413,
   (r_A50_pb_total_dollars_d > 676.5) => -0.0430724700,
   (r_A50_pb_total_dollars_d = NULL) => 0.0530734958, 0.0530734958),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12) => -0.0389437709,
   (c_pop_25_34_p > 12) => 0.0579530435,
   (c_pop_25_34_p = NULL) => 0.0137544966, 0.0137544966), -0.0023820540);

// Tree: 90 
wFDN_FL_PS__lgt_90 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0894915972,
(r_D32_Mos_Since_Fel_LS_d > 117) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
      map(
      (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => -0.0035295361,
      (f_srchphonesrchcountwk_i > 0.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 43.4) => 0.1724457656,
         (c_low_ed > 43.4) => -0.0116366516,
         (c_low_ed = NULL) => 0.0804045570, 0.0804045570),
      (f_srchphonesrchcountwk_i = NULL) => -0.0026934317, -0.0026934317),
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0896759530,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0030552790, -0.0030552790),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.75) => -0.0718860407,
   (c_pop_6_11_p > 7.75) => 0.0353027781,
   (c_pop_6_11_p = NULL) => -0.0154205022, -0.0154205022), -0.0026649465);

// Tree: 91 
wFDN_FL_PS__lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 15.1) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 65.5) => 0.0252316049,
      (c_blue_empl > 65.5) => 0.2753431281,
      (c_blue_empl = NULL) => 0.1233522794, 0.1233522794),
   (c_blue_col > 15.1) => -0.0250078751,
   (c_blue_col = NULL) => 0.0686174651, 0.0686174651),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0063536841,
   (r_D33_eviction_count_i > 3.5) => 0.0608468858,
   (r_D33_eviction_count_i = NULL) => -0.0058910577, -0.0058910577),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0447256934,
   (r_Phn_Cell_n > 0.5) => -0.0510285537,
   (r_Phn_Cell_n = NULL) => 0.0061270822, 0.0061270822), -0.0045412255);

// Tree: 92 
wFDN_FL_PS__lgt_92 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 124) => 0.1758636894,
   (c_work_home > 124) => 0.0089368728,
   (c_work_home = NULL) => 0.0931016543, 0.0931016543),
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0356049061,
   (f_mos_inq_banko_om_fseen_d > 21.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0935401510,
      (r_D33_Eviction_Recency_d > 30) => 0.0019639735,
      (r_D33_Eviction_Recency_d = NULL) => 0.0026437207, 0.0026437207),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0000179709, 0.0000179709),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 94.5) => 0.0535524846,
   (c_rental > 94.5) => -0.0635158047,
   (c_rental = NULL) => -0.0064825356, -0.0064825356), 0.0008737375);

// Tree: 93 
wFDN_FL_PS__lgt_93 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0054112268,
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 5.65) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => 0.0318530312,
      (k_inq_per_ssn_i > 1.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
            map(
            (NULL < c_hh5_p and c_hh5_p <= 6.45) => 0.1979169432,
            (c_hh5_p > 6.45) => -0.0103645209,
            (c_hh5_p = NULL) => 0.0764864371, 0.0764864371),
         (f_srchvelocityrisktype_i > 5.5) => 0.1622556277,
         (f_srchvelocityrisktype_i = NULL) => 0.0969196855, 0.0969196855),
      (k_inq_per_ssn_i = NULL) => 0.0478491718, 0.0478491718),
   (c_vacant_p > 5.65) => 0.0015732120,
   (c_vacant_p = NULL) => 0.0569650366, 0.0210857184),
(f_hh_collections_ct_i = NULL) => -0.0007977936, 0.0019199247);

// Tree: 94 
wFDN_FL_PS__lgt_94 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 28.5) => -0.1090984233,
(f_mos_liens_unrel_OT_fseen_d > 28.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 177.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 14.85) => -0.0336183597,
         (c_high_ed > 14.85) => 0.0416470000,
         (c_high_ed = NULL) => 0.0189658346, 0.0189658346),
      (c_serv_empl > 177.5) => 0.0947720960,
      (c_serv_empl = NULL) => 0.0717104608, 0.0306766770),
   (f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0002075766,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0037669374, 0.0037669374),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0646776054,
   (c_rnt1000_p > 10.8) => 0.0437124756,
   (c_rnt1000_p = NULL) => -0.0104825649, -0.0104825649), 0.0028734210);

// Tree: 95 
wFDN_FL_PS__lgt_95 := map(
(NULL < c_incollege and c_incollege <= 5.95) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 5.5) => -0.0139025736,
   (f_srchfraudsrchcountyr_i > 5.5) => -0.1144489214,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0476583995, -0.0151914820),
(c_incollege > 5.95) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 4.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0053950020,
      (f_rel_criminal_count_i > 2.5) => 
         map(
         (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 1.5) => 0.0296396875,
         (k_inq_addrs_per_ssn_i > 1.5) => 0.1320767182,
         (k_inq_addrs_per_ssn_i = NULL) => 0.0335176608, 0.0335176608),
      (f_rel_criminal_count_i = NULL) => 0.0041390771, 0.0041390771),
   (f_inq_HighRiskCredit_count24_i > 4.5) => 0.0929888619,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0017314626, 0.0052307740),
(c_incollege = NULL) => 0.0112229240, -0.0050995245);

// Tree: 96 
wFDN_FL_PS__lgt_96 := map(
(NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13918900825) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 22.05) => -0.0087045620,
      (c_vacant_p > 22.05) => 0.0516040329,
      (c_vacant_p = NULL) => -0.0056113672, -0.0056113672),
   (f_add_curr_nhood_BUS_pct_i > 0.13918900825) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0106065310,
      (f_rel_felony_count_i > 0.5) => 0.0939130396,
      (f_rel_felony_count_i = NULL) => 0.0221666853, 0.0221666853),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0354232974, -0.0042747478),
(f_assoccredbureaucountmo_i > 0.5) => 0.1332226985,
(f_assoccredbureaucountmo_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 7.15) => -0.0346900212,
   (c_health > 7.15) => 0.0721749179,
   (c_health = NULL) => 0.0200456793, 0.0200456793), -0.0033069352);

// Tree: 97 
wFDN_FL_PS__lgt_97 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 28.5) => -0.0034540493,
   (f_rel_incomeover25_count_d > 28.5) => -0.0623243775,
   (f_rel_incomeover25_count_d = NULL) => -0.0010736532, -0.0048022279),
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1257668806,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 22.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 126) => 0.0146953941,
         (c_sub_bus > 126) => 0.2535209803,
         (c_sub_bus = NULL) => 0.1219645133, 0.1219645133),
      (k_comb_age_d > 22.5) => 0.0074265610,
      (k_comb_age_d = NULL) => 0.0183437487, 0.0183437487),
   (r_D33_Eviction_Recency_d = NULL) => 0.0247059388, 0.0247059388),
(C_INC_50K_P = NULL) => 0.0053828631, -0.0014417776);

// Tree: 98 
wFDN_FL_PS__lgt_98 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.45) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 112) => -0.0845177585,
      (c_mort_indx > 112) => 0.0661098387,
      (c_mort_indx = NULL) => -0.0299425422, -0.0299425422),
   (c_pop_6_11_p > 7.45) => 
      map(
      (NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 0.1672801526,
      (r_A41_Prop_Owner_Inp_Only_d > 0.5) => -0.0022649086,
      (r_A41_Prop_Owner_Inp_Only_d = NULL) => 0.1027518084, 0.1027518084),
   (c_pop_6_11_p = NULL) => 0.0354289394, 0.0354289394),
(r_C21_M_Bureau_ADL_FS_d > 8.5) => -0.0058754647,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 79.65) => -0.0383752892,
   (c_fammar_p > 79.65) => 0.0713728233,
   (c_fammar_p = NULL) => 0.0193868753, 0.0193868753), -0.0047502695);

// Tree: 99 
wFDN_FL_PS__lgt_99 := map(
(NULL < c_bel_edu and c_bel_edu <= 198.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.85) => -0.0064294516,
      (c_hh6_p > 1.85) => 0.1651750189,
      (c_hh6_p = NULL) => 0.0841395745, 0.0841395745),
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0121894819,
      (f_util_add_curr_conv_n > 0.5) => 0.0144108311,
      (f_util_add_curr_conv_n = NULL) => 0.0027491236, 0.0027491236),
   (f_hh_age_18_plus_d = NULL) => 
      map(
      (NULL < c_preschl and c_preschl <= 95) => 0.0806963624,
      (c_preschl > 95) => -0.0453373032,
      (c_preschl = NULL) => 0.0136139275, 0.0136139275), 0.0035720316),
(c_bel_edu > 198.5) => -0.1258010866,
(c_bel_edu = NULL) => -0.0078439586, 0.0027405033);

// Tree: 100 
wFDN_FL_PS__lgt_100 := map(
(NULL < nf_vf_level and nf_vf_level <= 5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.45) => -0.0169144621,
   (c_hh4_p > 12.45) => 0.0107944171,
   (c_hh4_p = NULL) => -0.0078519950, -0.0011213156),
(nf_vf_level > 5) => 
   map(
   (NULL < c_bargains and c_bargains <= 41.5) => 0.0714406828,
   (c_bargains > 41.5) => 
      map(
      (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 160.5) => -0.0327573157,
      (f_prevaddrcartheftindex_i > 160.5) => -0.1294238438,
      (f_prevaddrcartheftindex_i = NULL) => -0.0551918683, -0.0551918683),
   (c_bargains = NULL) => -0.0361052229, -0.0361052229),
(nf_vf_level = NULL) => 
   map(
   (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => -0.0405311951,
   (k_nap_nothing_found_i > 0.5) => 0.0814018349,
   (k_nap_nothing_found_i = NULL) => 0.0274314774, 0.0274314774), -0.0018092102);

// Tree: 101 
wFDN_FL_PS__lgt_101 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 5.95) => -0.0118674447,
   (c_femdiv_p > 5.95) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 3.475) => 0.0105631903,
      (c_hhsize > 3.475) => 0.1665910199,
      (c_hhsize = NULL) => 0.0132303327, 0.0132303327),
   (c_femdiv_p = NULL) => 0.0222408998, -0.0039984583),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.35) => -0.0347826709,
   (c_high_hval > 2.35) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0311958077,
      (r_E57_br_source_count_d > 0.5) => 0.3719401250,
      (r_E57_br_source_count_d = NULL) => 0.2000602482, 0.2000602482),
   (c_high_hval = NULL) => 0.0889858945, 0.0889858945),
(r_P85_Phn_Disconnected_i = NULL) => -0.0022905077, -0.0022905077);

// Tree: 102 
wFDN_FL_PS__lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0103104938,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 77.5) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
         map(
         (NULL < c_food and c_food <= 94.3) => 
            map(
            (NULL < c_no_labfor and c_no_labfor <= 173.5) => 0.0112452418,
            (c_no_labfor > 173.5) => -0.0775352696,
            (c_no_labfor = NULL) => 0.0071482425, 0.0071482425),
         (c_food > 94.3) => 0.1388956979,
         (c_food = NULL) => 0.0261337469, 0.0087572575),
      (f_addrs_per_ssn_c6_i > 1.5) => 0.1503718115,
      (f_addrs_per_ssn_c6_i = NULL) => 0.0108035486, 0.0108035486),
   (k_comb_age_d > 77.5) => 0.1163192627,
   (k_comb_age_d = NULL) => 0.0128114204, 0.0128114204),
(k_inq_per_ssn_i = NULL) => -0.0008903872, -0.0008903872);

// Tree: 103 
wFDN_FL_PS__lgt_103 := map(
(NULL < f_accident_count_i and f_accident_count_i <= 2.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 11.5) => -0.0001795964,
   (f_rel_ageover40_count_d > 11.5) => -0.0655300747,
   (f_rel_ageover40_count_d = NULL) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0456078338) => -0.0508928873,
      (f_add_curr_nhood_VAC_pct_i > 0.0456078338) => 0.0989278299,
      (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0087355427, -0.0087355427), -0.0023319216),
(f_accident_count_i > 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2730372573) => 0.0136815280,
   (f_add_curr_nhood_MFD_pct_i > 0.2730372573) => 0.1979954343,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0901655299, 0.0901655299),
(f_accident_count_i = NULL) => 
   map(
   (NULL < c_families and c_families <= 430) => -0.0535245159,
   (c_families > 430) => 0.0505882913,
   (c_families = NULL) => -0.0059070305, -0.0059070305), -0.0010425663);

// Tree: 104 
wFDN_FL_PS__lgt_104 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 198.5) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 3.5) => -0.0000944540,
      (r_D34_UnRel_Lien60_Count_i > 3.5) => -0.1079019979,
      (r_D34_UnRel_Lien60_Count_i = NULL) => 
         map(
         (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => -0.0629669749,
         (k_nap_nothing_found_i > 0.5) => 0.0452414420,
         (k_nap_nothing_found_i = NULL) => -0.0031444355, -0.0031444355), -0.0005959735),
   (c_serv_empl > 198.5) => 0.1555635150,
   (c_serv_empl = NULL) => -0.0048141874, 0.0001978338),
(k_inq_per_phone_i > 6.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 17.3) => 0.1199780382,
   (c_newhouse > 17.3) => -0.0140526163,
   (c_newhouse = NULL) => 0.0608713521, 0.0608713521),
(k_inq_per_phone_i = NULL) => 0.0009774778, 0.0009774778);

// Tree: 105 
wFDN_FL_PS__lgt_105 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 
   map(
   (NULL < nf_altlexid_phone_hi_no_hi_lexid and nf_altlexid_phone_hi_no_hi_lexid <= 0.5) => -0.0156679328,
   (nf_altlexid_phone_hi_no_hi_lexid > 0.5) => 0.1096828939,
   (nf_altlexid_phone_hi_no_hi_lexid = NULL) => -0.0146313847, -0.0146313847),
(f_corrrisktype_i > 8.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 83.5) => -0.0065409424,
   (f_curraddrcrimeindex_i > 83.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 11.5) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 42.15) => 0.0106357046,
         (c_low_ed > 42.15) => 0.1752143700,
         (c_low_ed = NULL) => 0.0929250373, 0.0929250373),
      (r_C21_M_Bureau_ADL_FS_d > 11.5) => 0.0221724158,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0259481431, 0.0259481431),
   (f_curraddrcrimeindex_i = NULL) => 0.0081608225, 0.0081608225),
(f_corrrisktype_i = NULL) => -0.0201882237, -0.0047122383);

// Tree: 106 
wFDN_FL_PS__lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 50.85) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => -0.0113013896,
      (k_comb_age_d > 55.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 191.5) => 0.0157028829,
         (c_sub_bus > 191.5) => 0.1408834337,
         (c_sub_bus = NULL) => 0.0195033419, 0.0195033419),
      (k_comb_age_d = NULL) => -0.0044774919, -0.0044774919),
   (c_hval_500k_p > 50.85) => 0.1190514147,
   (c_hval_500k_p = NULL) => -0.0305387306, -0.0042107732),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 124.5) => 0.0036691606,
   (c_blue_empl > 124.5) => 0.2765871841,
   (c_blue_empl = NULL) => 0.1401281723, 0.1401281723),
(f_historical_count_d = NULL) => 0.0014021447, -0.0029112008);

// Tree: 107 
wFDN_FL_PS__lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 21.8) => 0.1342375483,
   (c_high_ed > 21.8) => -0.0020978791,
   (c_high_ed = NULL) => 0.0682338890, 0.0682338890),
(f_attr_arrest_recency_d > 99.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 55.5) => 0.0061411226,
      (r_C13_Curr_Addr_LRes_d > 55.5) => 0.2009822808,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.1026512290, 0.1026512290),
   (f_hh_age_18_plus_d > 0.5) => -0.0013355999,
   (f_hh_age_18_plus_d = NULL) => -0.0004336904, -0.0004336904),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 17.7) => -0.0490130791,
   (c_rnt750_p > 17.7) => 0.0503212466,
   (c_rnt750_p = NULL) => -0.0012561918, -0.0012561918), 0.0002469243);

// Tree: 108 
wFDN_FL_PS__lgt_108 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0112012662,
(f_corrrisktype_i > 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.9) => 0.0062612273,
      (r_C12_source_profile_d > 81.9) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 2.55) => 0.0501730855,
         (c_pop_85p_p > 2.55) => 0.3403291821,
         (c_pop_85p_p = NULL) => 0.1206225081, 0.1206225081),
      (r_C12_source_profile_d = NULL) => 0.0116861694, 0.0116861694),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 2.5) => 0.0892200426,
      (f_current_count_d > 2.5) => -0.0527566821,
      (f_current_count_d = NULL) => 0.0579673045, 0.0579673045),
   (f_rel_felony_count_i = NULL) => 0.0143398660, 0.0143398660),
(f_corrrisktype_i = NULL) => -0.0047766814, 0.0000263309);

// Tree: 109 
wFDN_FL_PS__lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 11.5) => -0.0921995937,
   (f_mos_inq_banko_cm_lseen_d > 11.5) => 
      map(
      (NULL < c_health and c_health <= 26.8) => -0.0298432953,
      (c_health > 26.8) => 0.0881324141,
      (c_health = NULL) => -0.0129896225, -0.0129896225),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0270247905, -0.0270247905),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 0.0080729251,
   (f_srchssnsrchcount_i > 22.5) => 0.1173454216,
   (f_srchssnsrchcount_i = NULL) => 0.0085258118, 0.0085258118),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.3) => 0.0650294157,
   (c_bigapt_p > 1.3) => -0.0571682281,
   (c_bigapt_p = NULL) => 0.0169201071, 0.0169201071), 0.0072357773);

// Tree: 110 
wFDN_FL_PS__lgt_110 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 24.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => -0.0022182143,
   (k_comb_age_d > 63.5) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 1.5) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 1978.5) => 
            map(
            (NULL < c_hval_750k_p and c_hval_750k_p <= 3.85) => 0.0450002979,
            (c_hval_750k_p > 3.85) => -0.0708497425,
            (c_hval_750k_p = NULL) => -0.0054702366, -0.0054702366),
         (r_A50_pb_average_dollars_d > 1978.5) => 0.0765656267,
         (r_A50_pb_average_dollars_d = NULL) => 0.0166664249, 0.0166664249),
      (f_inq_Other_count24_i > 1.5) => 0.2218594160,
      (f_inq_Other_count24_i = NULL) => 0.0245699340, 0.0245699340),
   (k_comb_age_d = NULL) => 0.0007299175, 0.0007299175),
(f_srchphonesrchcount_i > 24.5) => -0.0856604909,
(f_srchphonesrchcount_i = NULL) => -0.0274303981, 0.0000984290);

// Tree: 111 
wFDN_FL_PS__lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 31.5) => 0.0987018075,
(f_mos_liens_unrel_SC_fseen_d > 31.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 35.85) => 
      map(
      (NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0265661504,
         (f_phone_ver_experian_d > 0.5) => -0.0039438615,
         (f_phone_ver_experian_d = NULL) => 0.0094439129, 0.0098227858),
      (k_inf_phn_verd_d > 0.5) => -0.0151674558,
      (k_inf_phn_verd_d = NULL) => 0.0007771242, 0.0007771242),
   (c_hval_60k_p > 35.85) => -0.0897518009,
   (c_hval_60k_p = NULL) => -0.0159458662, -0.0003177776),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 4) => 0.0443046225,
   (c_hval_500k_p > 4) => -0.0700760233,
   (c_hval_500k_p = NULL) => -0.0143521189, -0.0143521189), 0.0001427165);

// Tree: 112 
wFDN_FL_PS__lgt_112 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 
      map(
      (NULL < c_mining and c_mining <= 0.65) => 0.0112674573,
      (c_mining > 0.65) => -0.0726158884,
      (c_mining = NULL) => -0.0030969418, 0.0073615743),
   (f_adl_util_inf_n > 0.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 4.5) => 0.2331482412,
      (f_rel_incomeover50_count_d > 4.5) => 0.0074349952,
      (f_rel_incomeover50_count_d = NULL) => 0.1023371555, 0.1023371555),
   (f_adl_util_inf_n = NULL) => 0.0099781435, 0.0099781435),
(f_phone_ver_insurance_d > 3.5) => -0.0146075019,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 16.45) => -0.0221724312,
   (C_INC_75K_P > 16.45) => 0.0733226676,
   (C_INC_75K_P = NULL) => 0.0276510986, 0.0276510986), -0.0016919032);

// Tree: 113 
wFDN_FL_PS__lgt_113 := map(
(NULL < c_civ_emp and c_civ_emp <= 32.15) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 33.5) => 0.1773609774,
   (f_prevaddrlenofres_d > 33.5) => 0.0013440347,
   (f_prevaddrlenofres_d = NULL) => 0.0817655688, 0.0817655688),
(c_civ_emp > 32.15) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => 0.0097387941,
      (f_hh_members_w_derog_i > 1.5) => 0.1180872412,
      (f_hh_members_w_derog_i = NULL) => 0.0377918029, 0.0377918029),
   (f_corrssnnamecount_d > 1.5) => -0.0063767420,
   (f_corrssnnamecount_d = NULL) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 2.625) => 0.0783726602,
      (c_hhsize > 2.625) => -0.0429557283,
      (c_hhsize = NULL) => 0.0207416757, 0.0207416757), -0.0037875967),
(c_civ_emp = NULL) => 0.0255610354, -0.0022858940);

// Tree: 114 
wFDN_FL_PS__lgt_114 := map(
(NULL < c_white_col and c_white_col <= 10.3) => 0.0972815717,
(c_white_col > 10.3) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0219434410,
         (f_hh_members_ct_d > 1.5) => -0.0090092634,
         (f_hh_members_ct_d = NULL) => -0.0029193217, -0.0029193217),
      (r_D31_MostRec_Bk_i > 0.5) => -0.0342429133,
      (r_D31_MostRec_Bk_i = NULL) => -0.0170693658, -0.0061799067),
   (k_inq_adls_per_phone_i > 2.5) => -0.0752780104,
   (k_inq_adls_per_phone_i = NULL) => -0.0067072447, -0.0067072447),
(c_white_col = NULL) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => -0.0242401907,
   (f_vardobcountnew_i > 0.5) => 0.1521970210,
   (f_vardobcountnew_i = NULL) => 0.0056449396, 0.0056449396), -0.0059299070);

// Tree: 115 
wFDN_FL_PS__lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.05) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0609968009,
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 53.5) => -0.0128633743,
      (r_C13_Curr_Addr_LRes_d > 53.5) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 0.0829189873,
         (f_corrssnnamecount_d > 1.5) => 0.0016188744,
         (f_corrssnnamecount_d = NULL) => 0.0054488057, 0.0054488057),
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0028068595, -0.0028068595),
   (r_D33_Eviction_Recency_d = NULL) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 83) => -0.0780234892,
      (c_lar_fam > 83) => 0.0370102378,
      (c_lar_fam = NULL) => -0.0081815835, -0.0081815835), -0.0023596445),
(c_pop_0_5_p > 21.05) => 0.1480591835,
(c_pop_0_5_p = NULL) => 0.0045189858, -0.0015732274);

// Tree: 116 
wFDN_FL_PS__lgt_116 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1132719046,
   (f_mos_liens_rel_SC_lseen_d > 71.5) => 
      map(
      (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0083279060,
      (r_F04_curr_add_occ_index_d > 2) => 0.0178879982,
      (r_F04_curr_add_occ_index_d = NULL) => -0.0024461326, -0.0024461326),
   (f_mos_liens_rel_SC_lseen_d = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 6.3) => 0.0531709703,
      (c_hval_250k_p > 6.3) => -0.0540324613,
      (c_hval_250k_p = NULL) => 0.0033678013, 0.0033678013), -0.0028376803),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 16.25) => 0.0333667883,
   (C_INC_50K_P > 16.25) => 0.2584058417,
   (C_INC_50K_P = NULL) => 0.1012556648, 0.1012556648),
(f_adls_per_phone_c6_i = NULL) => -0.0013605969, -0.0013605969);

// Tree: 117 
wFDN_FL_PS__lgt_117 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 3.5) => 0.0741675021,
(r_C21_M_Bureau_ADL_FS_d > 3.5) => 
   map(
   (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 24.05) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => -0.0912741676,
         (r_D33_Eviction_Recency_d > 30) => 
            map(
            (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 4.5) => -0.0129475827,
            (f_inq_HighRiskCredit_count24_i > 4.5) => 0.0843201651,
            (f_inq_HighRiskCredit_count24_i = NULL) => -0.0121401844, -0.0121401844),
         (r_D33_Eviction_Recency_d = NULL) => -0.0127441143, -0.0127441143),
      (c_hh3_p > 24.05) => 0.0327687749,
      (c_hh3_p = NULL) => -0.0253652428, -0.0069720784),
   (r_F04_curr_add_occ_index_d > 2) => 0.0200841829,
   (r_F04_curr_add_occ_index_d = NULL) => -0.0010627410, -0.0010627410),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0122618157, -0.0006230648);

// Tree: 118 
wFDN_FL_PS__lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0058529157,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 5.25) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1684) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 39.95) => -0.0499977719,
         (c_rnt750_p > 39.95) => 0.0767794152,
         (c_rnt750_p = NULL) => -0.0160162578, -0.0160162578),
      (c_popover25 > 1684) => 0.1345077837,
      (c_popover25 = NULL) => 0.0162824232, 0.0162824232),
   (c_hh6_p > 5.25) => 0.1424493826,
   (c_hh6_p = NULL) => 0.0382245031, 0.0382245031),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 5.75) => 0.0269251570,
   (c_construction > 5.75) => -0.0686409498,
   (c_construction = NULL) => -0.0288217386, -0.0288217386), -0.0050185194);

// Tree: 119 
wFDN_FL_PS__lgt_119 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0375848868,
      (f_util_adl_count_n > 4.5) => 0.1075716107,
      (f_util_adl_count_n = NULL) => -0.0124353618, -0.0124353618),
   (f_assocrisktype_i > 3.5) => -0.0694319870,
   (f_assocrisktype_i = NULL) => -0.0337418833, -0.0337418833),
(f_mos_inq_banko_om_fseen_d > 21.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0094013843,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0515874464,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0066701521, 0.0066701521),
(f_mos_inq_banko_om_fseen_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.55) => -0.0666513315,
   (c_pop_55_64_p > 12.55) => 0.0500018729,
   (c_pop_55_64_p = NULL) => -0.0227967434, -0.0227967434), 0.0036526587);

// Tree: 120 
wFDN_FL_PS__lgt_120 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 272.5) => 
      map(
      (NULL < c_unattach and c_unattach <= 153.5) => 0.0004785302,
      (c_unattach > 153.5) => 0.0656192879,
      (c_unattach = NULL) => 0.0030460018, 0.0030460018),
   (c_oldhouse > 272.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.35) => 0.0751972499,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.35) => -0.0510496645,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0397359517, -0.0309440548),
   (c_oldhouse = NULL) => -0.0357624451, -0.0009934610),
(f_rel_felony_count_i > 4.5) => 0.0739891826,
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0412566190,
   (f_addrs_per_ssn_i > 5.5) => 0.0777823397,
   (f_addrs_per_ssn_i = NULL) => 0.0119976520, 0.0119976520), -0.0004924868);

// Tree: 121 
wFDN_FL_PS__lgt_121 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 5) => 
   map(
   (NULL < c_transport and c_transport <= 57.1) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 5.5) => -0.0453897521,
      (f_mos_inq_banko_om_fseen_d > 5.5) => 0.0012239595,
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0008060860, -0.0008060860),
   (c_transport > 57.1) => 0.1194402535,
   (c_transport = NULL) => 0.0053730158, -0.0001295553),
(nf_vf_lexid_hi_summary > 5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 1.5) => -0.1116122431,
   (f_rel_bankrupt_count_i > 1.5) => 0.0139434967,
   (f_rel_bankrupt_count_i = NULL) => -0.0715576513, -0.0715576513),
(nf_vf_lexid_hi_summary = NULL) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 4.55) => 0.0643555684,
   (c_hval_300k_p > 4.55) => -0.0677831691,
   (c_hval_300k_p = NULL) => 0.0077246809, 0.0077246809), -0.0009699968);

// Tree: 122 
wFDN_FL_PS__lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0021177820,
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 0.0721031105,
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => -0.0091562245, -0.0010131656),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 1.5) => 0.1833532444,
   (f_hh_age_18_plus_d > 1.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 141.5) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 5.15) => 0.1953838112,
         (c_hval_125k_p > 5.15) => -0.0313459488,
         (c_hval_125k_p = NULL) => 0.0892992446, 0.0892992446),
      (c_span_lang > 141.5) => -0.0811406744,
      (c_span_lang = NULL) => 0.0314529691, 0.0314529691),
   (f_hh_age_18_plus_d = NULL) => 0.0658836981, 0.0658836981),
(r_P85_Phn_Disconnected_i = NULL) => 0.0002103324, 0.0002103324);

// Tree: 123 
wFDN_FL_PS__lgt_123 := map(
(NULL < c_low_ed and c_low_ed <= 75.25) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 73.05) => 0.0006847720,
      (c_low_ed > 73.05) => 0.1205670248,
      (c_low_ed = NULL) => 0.0022628716, 0.0022628716),
   (f_srchcomponentrisktype_i > 1.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 2.235) => 0.1319264716,
      (c_hhsize > 2.235) => 
         map(
         (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 2.5) => 0.0471075418,
         (f_assoccredbureaucount_i > 2.5) => -0.0857226385,
         (f_assoccredbureaucount_i = NULL) => 0.0273709820, 0.0273709820),
      (c_hhsize = NULL) => 0.0481239620, 0.0481239620),
   (f_srchcomponentrisktype_i = NULL) => 0.0268230774, 0.0045414061),
(c_low_ed > 75.25) => -0.0427290189,
(c_low_ed = NULL) => 0.0112334065, 0.0029672507);

// Tree: 124 
wFDN_FL_PS__lgt_124 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 10.5) => 
   map(
   (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 5.5) => -0.0014870630,
   (f_inq_QuizProvider_count_i > 5.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0191738155,
      (f_inq_Collection_count_i > 1.5) => 0.1937988005,
      (f_inq_Collection_count_i = NULL) => 0.0790050500, 0.0790050500),
   (f_inq_QuizProvider_count_i = NULL) => -0.0005630715, -0.0005630715),
(f_rel_under25miles_cnt_d > 10.5) => -0.0999720052,
(f_rel_under25miles_cnt_d = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 106.5) => -0.0143682757,
      (c_easiqlife > 106.5) => 0.1371487426,
      (c_easiqlife = NULL) => 0.0608029582, 0.0608029582),
   (c_bigapt_p > 1.15) => -0.0506398856,
   (c_bigapt_p = NULL) => -0.0057144892, -0.0057144892), -0.0012093158);

// Tree: 125 
wFDN_FL_PS__lgt_125 := map(
(NULL < c_lowinc and c_lowinc <= 74) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 27.95) => -0.0049467203,
      (c_hval_500k_p > 27.95) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 43011.5) => 0.1371800871,
         (f_curraddrmedianincome_d > 43011.5) => 0.0195159312,
         (f_curraddrmedianincome_d = NULL) => 0.0324285205, 0.0324285205),
      (c_hval_500k_p = NULL) => -0.0024024182, -0.0024024182),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 0.5) => 0.0246617368,
      (r_C20_email_domain_free_count_i > 0.5) => 0.2476394845,
      (r_C20_email_domain_free_count_i = NULL) => 0.0930753640, 0.0930753640),
   (f_nae_nothing_found_i = NULL) => -0.0010154073, -0.0010154073),
(c_lowinc > 74) => -0.0737546711,
(c_lowinc = NULL) => -0.0134995761, -0.0021198329);

// Tree: 126 
wFDN_FL_PS__lgt_126 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 817635.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0103487651,
         (f_util_adl_count_n > 6.5) => 0.0843036924,
         (f_util_adl_count_n = NULL) => 0.0149980545, 0.0149980545),
      (k_estimated_income_d > 34500) => -0.0091377208,
      (k_estimated_income_d = NULL) => -0.0007936441, -0.0007936441),
   (f_prevaddrmedianvalue_d > 817635.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 126.5) => 0.0275816962,
      (c_robbery > 126.5) => 0.2856206069,
      (c_robbery = NULL) => 0.1075586685, 0.1075586685),
   (f_prevaddrmedianvalue_d = NULL) => 0.0006969260, 0.0006969260),
(f_hh_collections_ct_i > 5.5) => 0.1013521899,
(f_hh_collections_ct_i = NULL) => 0.0125485007, 0.0013920197);

// Tree: 127 
wFDN_FL_PS__lgt_127 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 4.5) => 0.0982090324,
(r_C13_max_lres_d > 4.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.35) => 0.0894216042,
         (c_pop_25_34_p > 17.35) => 
            map(
            (NULL < c_burglary and c_burglary <= 114.5) => -0.0627838893,
            (c_burglary > 114.5) => 0.0931771372,
            (c_burglary = NULL) => -0.0080866572, -0.0080866572),
         (c_pop_25_34_p = NULL) => 0.0561837315, 0.0561837315),
      (f_current_count_d > 0.5) => -0.0267727570,
      (f_current_count_d = NULL) => 0.0190411923, 0.0190411923),
   (r_I60_inq_comm_recency_d > 549) => -0.0063457288,
   (r_I60_inq_comm_recency_d = NULL) => -0.0040068968, -0.0040068968),
(r_C13_max_lres_d = NULL) => -0.0163498660, -0.0033217518);

// Tree: 128 
wFDN_FL_PS__lgt_128 := map(
(NULL < c_rich_blk and c_rich_blk <= 186.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 0.0002814315,
   (k_inq_adls_per_phone_i > 2.5) => -0.0798739815,
   (k_inq_adls_per_phone_i = NULL) => -0.0003634290, -0.0003634290),
(c_rich_blk > 186.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 14.5) => 0.0202792935,
   (f_rel_ageover30_count_d > 14.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 140.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0396703156) => 0.1270778291,
         (f_add_curr_nhood_BUS_pct_i > 0.0396703156) => -0.0303381360,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0391872486, 0.0391872486),
      (c_lar_fam > 140.5) => 0.2229741392,
      (c_lar_fam = NULL) => 0.1007754088, 0.1007754088),
   (f_rel_ageover30_count_d = NULL) => 0.0302946937, 0.0302946937),
(c_rich_blk = NULL) => -0.0163348276, 0.0029675432);

// Tree: 129 
wFDN_FL_PS__lgt_129 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.15) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0141819940,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 45.75) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 2.45) => 0.0265590659,
         (c_low_hval > 2.45) => -0.0166719934,
         (c_low_hval = NULL) => 0.0073550408, 0.0073550408),
      (c_famotf18_p > 45.75) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.7) => 0.0122085683,
         (c_pop_45_54_p > 11.7) => 0.1587199397,
         (c_pop_45_54_p = NULL) => 0.0833305932, 0.0833305932),
      (c_famotf18_p = NULL) => 0.0089154559, 0.0089154559),
   (k_inf_nothing_found_i = NULL) => -0.0047890560, -0.0047890560),
(c_pop_0_5_p > 20.15) => 0.1168464829,
(c_pop_0_5_p = NULL) => 0.0386758796, -0.0032713853);

// Tree: 130 
wFDN_FL_PS__lgt_130 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.35) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 7.5) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 8.5) => -0.0035506278,
         (k_inq_per_phone_i > 8.5) => 0.0656752869,
         (k_inq_per_phone_i = NULL) => -0.0030983604, -0.0030983604),
      (f_inq_Other_count24_i > 4.5) => 0.1292925399,
      (f_inq_Other_count24_i = NULL) => -0.0025462255, -0.0025462255),
   (r_I60_Inq_Count12_i > 7.5) => -0.0600597949,
   (r_I60_Inq_Count12_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 81.5) => -0.0528258934,
      (c_asian_lang > 81.5) => 0.0609881608,
      (c_asian_lang = NULL) => 0.0115443504, 0.0115443504), -0.0032023819),
(c_hh6_p > 17.35) => -0.1046323878,
(c_hh6_p = NULL) => 0.0273694419, -0.0030507956);

// Tree: 131 
wFDN_FL_PS__lgt_131 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 22.35) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 268.5) => -0.0579090984,
   (c_hh00 > 268.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 5175.5) => -0.0206817138,
      (r_A49_Curr_AVM_Chg_1yr_i > 5175.5) => 0.0249202588,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0006909463, 0.0015469410),
   (c_hh00 = NULL) => -0.0004212659, -0.0004212659),
(C_INC_50K_P > 22.35) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 20.65) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 73.5) => 0.1303571151,
      (r_D32_Mos_Since_Crim_LS_d > 73.5) => 0.0010909511,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0158361409, 0.0158361409),
   (c_hval_250k_p > 20.65) => 0.1568299829,
   (c_hval_250k_p = NULL) => 0.0360429878, 0.0360429878),
(C_INC_50K_P = NULL) => 0.0056564444, 0.0015138247);

// Tree: 132 
wFDN_FL_PS__lgt_132 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 12.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 0.0012698001,
   (f_assocsuspicousidcount_i > 13.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 99.5) => 0.1608642212,
      (c_many_cars > 99.5) => 0.0092803816,
      (c_many_cars = NULL) => 0.0835861853, 0.0835861853),
   (f_assocsuspicousidcount_i = NULL) => 0.0019858830, 0.0019858830),
(f_srchphonesrchcount_i > 12.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => -0.1435783065,
   (f_mos_inq_banko_cm_lseen_d > 44.5) => -0.0010761180,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0495462501, -0.0495462501),
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 63.75) => 0.0643138752,
   (c_civ_emp > 63.75) => -0.0494048101,
   (c_civ_emp = NULL) => 0.0118283282, 0.0118283282), 0.0014841406);

// Tree: 133 
wFDN_FL_PS__lgt_133 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 71) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 27.85) => -0.0904519184,
      (c_fammar_p > 27.85) => 0.0149238776,
      (c_fammar_p = NULL) => 0.0115819297, 0.0115819297),
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.85) => 0.1565728029,
      (c_hh2_p > 17.85) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 20.25) => 0.0753926356,
         (C_INC_75K_P > 20.25) => -0.0242666296,
         (C_INC_75K_P = NULL) => 0.0362162348, 0.0362162348),
      (c_hh2_p = NULL) => 0.0343522375, 0.0494689949),
   (f_sourcerisktype_i = NULL) => 0.0197827823, 0.0197827823),
(f_mos_inq_banko_cm_lseen_d > 71) => -0.0037787439,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0032739335, 0.0010580880);

// Tree: 134 
wFDN_FL_PS__lgt_134 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 42.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 133.5) => -0.0080161918,
   (c_easiqlife > 133.5) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 4.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 14.75) => 0.0043852635,
         (c_hval_175k_p > 14.75) => 0.0655750038,
         (c_hval_175k_p = NULL) => 0.0131203420, 0.0131203420),
      (f_dl_addrs_per_adl_i > 4.5) => 0.1836586368,
      (f_dl_addrs_per_adl_i = NULL) => 0.0157875286, 0.0157875286),
   (c_easiqlife = NULL) => 0.0068408216, 0.0004829028),
(f_rel_count_i > 42.5) => -0.0642936796,
(f_rel_count_i = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 98) => 0.0401897415,
   (c_apt20 > 98) => -0.0639170813,
   (c_apt20 = NULL) => -0.0057156292, -0.0057156292), -0.0005355465);

// Tree: 135 
wFDN_FL_PS__lgt_135 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 158.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 31.55) => -0.0204621829,
      (c_hval_175k_p > 31.55) => 
         map(
         (NULL < c_robbery and c_robbery <= 107) => -0.0334346511,
         (c_robbery > 107) => 0.2055326863,
         (c_robbery = NULL) => 0.0840902689, 0.0840902689),
      (c_hval_175k_p = NULL) => -0.0300306602, -0.0178640812),
   (r_C21_M_Bureau_ADL_FS_d > 158.5) => 0.0076253619,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0039315826, -0.0017104714),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < c_unattach and c_unattach <= 80.5) => -0.0717353354,
   (c_unattach > 80.5) => 0.1762020898,
   (c_unattach = NULL) => 0.0820486372, 0.0820486372),
(f_adls_per_phone_c6_i = NULL) => -0.0006407847, -0.0006407847);

// Tree: 136 
wFDN_FL_PS__lgt_136 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 21.5) => -0.0129513471,
   (f_rel_homeover300_count_d > 21.5) => 0.0991064544,
   (f_rel_homeover300_count_d = NULL) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.71924486805) => -0.0247114436,
      (f_add_curr_nhood_SFD_pct_d > 0.71924486805) => 0.1351372707,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0275755190, 0.0275755190), -0.0110229378),
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 16.95) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 118) => 0.1558892971,
      (r_D32_Mos_Since_Crim_LS_d > 118) => 0.0233948523,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0699619375, 0.0699619375),
   (c_hh2_p > 16.95) => 0.0109350433,
   (c_hh2_p = NULL) => 0.0145038335, 0.0145038335),
(f_hh_criminals_i = NULL) => -0.0014538264, -0.0029139165);

// Tree: 137 
wFDN_FL_PS__lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.0946916700,
   (C_INC_100K_P > 1.35) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3104075971) => 0.0067595683,
      (f_add_curr_mobility_index_i > 0.3104075971) => -0.0166782134,
      (f_add_curr_mobility_index_i = NULL) => -0.0000650314, -0.0000650314),
   (C_INC_100K_P = NULL) => 0.0201421059, 0.0009457386),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < c_food and c_food <= 9.3) => -0.1007712128,
   (c_food > 9.3) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 134.5) => -0.0597574118,
      (c_asian_lang > 134.5) => 0.0621416923,
      (c_asian_lang = NULL) => -0.0058744745, -0.0058744745),
   (c_food = NULL) => -0.0378108768, -0.0378108768),
(f_inq_HighRiskCredit_count24_i = NULL) => -0.0173223208, 0.0001271623);

// Tree: 138 
wFDN_FL_PS__lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 106408) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 12.5) => 0.0200178447,
      (f_rel_homeover200_count_d > 12.5) => 0.1348237504,
      (f_rel_homeover200_count_d = NULL) => 0.0246298467, 0.0246298467),
   (r_A46_Curr_AVM_AutoVal_d > 106408) => -0.0005245586,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0073792578, -0.0005177276),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.25) => 0.1197940753,
      (C_INC_200K_P > 0.25) => -0.0343103769,
      (C_INC_200K_P = NULL) => 0.0043884990, 0.0043884990),
   (f_vardobcountnew_i > 0.5) => 0.1415883579,
   (f_vardobcountnew_i = NULL) => 0.0435256382, 0.0435256382),
(f_curraddrcrimeindex_i = NULL) => -0.0162190183, 0.0004157902);

// Tree: 139 
wFDN_FL_PS__lgt_139 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0092411205) => 
   map(
   (NULL < c_child and c_child <= 33.45) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 22.75) => 0.0290462669,
      (c_hh3_p > 22.75) => 
         map(
         (NULL < c_rental and c_rental <= 65.5) => 0.0126112365,
         (c_rental > 65.5) => 0.3140839632,
         (c_rental = NULL) => 0.1393171651, 0.1393171651),
      (c_hh3_p = NULL) => 0.0501619708, 0.0501619708),
   (c_child > 33.45) => -0.1122515139,
   (c_child = NULL) => 0.0350378963, 0.0350378963),
(f_add_curr_nhood_MFD_pct_i > 0.0092411205) => -0.0040653839,
(f_add_curr_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 13.75) => 0.1504307512,
   (c_hh2_p > 13.75) => -0.0134990920,
   (c_hh2_p = NULL) => -0.0180774433, -0.0108566540), -0.0017878087);

// Tree: 140 
wFDN_FL_PS__lgt_140 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0114179878,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_trailer and c_trailer <= 173.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 53.5) => 0.0189240467,
         (k_comb_age_d > 53.5) => 
            map(
            (NULL < c_lowrent and c_lowrent <= 12.4) => 0.0401320045,
            (c_lowrent > 12.4) => 0.1841787934,
            (c_lowrent = NULL) => 0.0960046984, 0.0960046984),
         (k_comb_age_d = NULL) => 0.0321584978, 0.0321584978),
      (c_trailer > 173.5) => 0.1831646090,
      (c_trailer = NULL) => 0.0429446486, 0.0429446486),
   (f_hh_members_ct_d > 1.5) => 0.0036229636,
   (f_hh_members_ct_d = NULL) => 0.0116013868, 0.0116013868),
(k_inq_per_ssn_i = NULL) => -0.0019961042, -0.0019961042);

// Tree: 141 
wFDN_FL_PS__lgt_141 := map(
(NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 5) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 72.85) => -0.0014569239,
      (c_lowinc > 72.85) => -0.0573842910,
      (c_lowinc = NULL) => -0.0345399758, -0.0029954598),
   (nf_vf_hi_summary > 5) => -0.0607959693,
   (nf_vf_hi_summary = NULL) => -0.0038003244, -0.0038003244),
(r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.4859980615) => 0.1452681577,
   (f_add_curr_nhood_SFD_pct_d > 0.4859980615) => 0.0045716766,
   (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0536022685, 0.0536022685),
(r_C14_Addrs_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 3.4) => 0.0519465293,
   (c_hval_125k_p > 3.4) => -0.0435796766,
   (c_hval_125k_p = NULL) => 0.0009019918, 0.0009019918), -0.0028542837);

// Tree: 142 
wFDN_FL_PS__lgt_142 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0124240958,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 37.5) => -0.0003554594,
      (k_comb_age_d > 37.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 11.3) => 0.1548870945,
         (C_OWNOCC_P > 11.3) => 
            map(
            (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 6.5) => 0.0575540829,
            (f_assocsuspicousidcount_i > 6.5) => -0.0449849749,
            (f_assocsuspicousidcount_i = NULL) => 0.0468489699, 0.0468489699),
         (C_OWNOCC_P = NULL) => 0.0323203746, 0.0503873109),
      (k_comb_age_d = NULL) => 0.0275366956, 0.0275366956),
   (f_corrrisktype_i = NULL) => 0.0103309471, 0.0103309471),
(f_phone_ver_experian_d > 0.5) => -0.0055252128,
(f_phone_ver_experian_d = NULL) => -0.0113295866, -0.0017196399);

// Tree: 143 
wFDN_FL_PS__lgt_143 := map(
(NULL < c_child and c_child <= 33.25) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 9.45) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 42.5) => 0.0183111698,
         (k_comb_age_d > 42.5) => 0.0887287435,
         (k_comb_age_d = NULL) => 0.0508306838, 0.0508306838),
      (c_hh1_p > 9.45) => -0.0001669546,
      (c_hh1_p = NULL) => 0.0036867029, 0.0036867029),
   (f_assocsuspicousidcount_i > 15.5) => 0.0960355013,
   (f_assocsuspicousidcount_i = NULL) => 0.0214332563, 0.0043523991),
(c_child > 33.25) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 11.5) => -0.0302043614,
   (f_rel_homeover300_count_d > 11.5) => -0.1397696799,
   (f_rel_homeover300_count_d = NULL) => -0.0363719456, -0.0363719456),
(c_child = NULL) => -0.0103225343, 0.0010197505);

// Tree: 144 
wFDN_FL_PS__lgt_144 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 23.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 11.5) => -0.0001493038,
   (f_srchssnsrchcount_i > 11.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04403438665) => 0.0224785712,
      (f_add_curr_nhood_BUS_pct_i > 0.04403438665) => 0.1119165953,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0671975833, 0.0671975833),
   (f_srchssnsrchcount_i = NULL) => 0.0007748975, 0.0007748975),
(f_rel_incomeover25_count_d > 23.5) => 
   map(
   (NULL < c_no_labfor and c_no_labfor <= 155.5) => -0.0550657337,
   (c_no_labfor > 155.5) => 0.0877453200,
   (c_no_labfor = NULL) => -0.0416939122, -0.0416939122),
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 4.45) => -0.0838343244,
   (c_famotf18_p > 4.45) => 0.0204427385,
   (c_famotf18_p = NULL) => -0.0059406147, -0.0059406147), -0.0012045406);

// Tree: 145 
wFDN_FL_PS__lgt_145 := map(
(NULL < c_low_hval and c_low_hval <= 71.05) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 328.5) => -0.0025789928,
   (r_C13_Curr_Addr_LRes_d > 328.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 41903.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.75) => 0.0558218548,
         (c_pop_35_44_p > 15.75) => 0.3136115274,
         (c_pop_35_44_p = NULL) => 0.1379923129, 0.1379923129),
      (f_prevaddrmedianincome_d > 41903.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 37.4) => -0.0129052477,
         (c_hval_750k_p > 37.4) => 0.1403874979,
         (c_hval_750k_p = NULL) => 0.0102332800, 0.0102332800),
      (f_prevaddrmedianincome_d = NULL) => 0.0487294104, 0.0487294104),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0136271127, -0.0004635215),
(c_low_hval > 71.05) => -0.0917657133,
(c_low_hval = NULL) => 0.0106381583, -0.0008698656);

// Tree: 146 
wFDN_FL_PS__lgt_146 := map(
(NULL < r_L75_Add_Curr_Drop_Delivery_i and r_L75_Add_Curr_Drop_Delivery_i <= 0.5) => 
   map(
   (NULL < c_health and c_health <= 22.45) => -0.0070529220,
   (c_health > 22.45) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 135.5) => 0.0014938473,
      (c_no_labfor > 135.5) => 0.0794898554,
      (c_no_labfor = NULL) => 0.0222334821, 0.0222334821),
   (c_health = NULL) => -0.0119666002, -0.0032486002),
(r_L75_Add_Curr_Drop_Delivery_i > 0.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 106.5) => 0.2125429479,
   (c_totcrime > 106.5) => -0.0019251307,
   (c_totcrime = NULL) => 0.1024619872, 0.1024619872),
(r_L75_Add_Curr_Drop_Delivery_i = NULL) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 113) => 0.0593204587,
   (c_rich_wht > 113) => -0.0557289418,
   (c_rich_wht = NULL) => 0.0085900144, 0.0085900144), -0.0021827876);

// Tree: 147 
wFDN_FL_PS__lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 16.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 20.15) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 
            map(
            (NULL < c_pop_75_84_p and c_pop_75_84_p <= 7.65) => 0.0289360855,
            (c_pop_75_84_p > 7.65) => 0.1952204156,
            (c_pop_75_84_p = NULL) => 0.0553710302, 0.0553710302),
         (f_util_adl_count_n > 1.5) => -0.0402920330,
         (f_util_adl_count_n = NULL) => 0.0191165572, 0.0191165572),
      (c_hh4_p > 20.15) => 0.1719448481,
      (c_hh4_p = NULL) => 0.0344431766, 0.0344431766),
   (c_many_cars > 16.5) => -0.0013541834,
   (c_many_cars = NULL) => -0.0366629805, -0.0001603987),
(f_prevaddrcartheftindex_i > 194.5) => -0.0786588832,
(f_prevaddrcartheftindex_i = NULL) => 0.0127229180, -0.0015858791);

// Tree: 148 
wFDN_FL_PS__lgt_148 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21111.5) => 0.0865374626,
   (r_A46_Curr_AVM_AutoVal_d > 21111.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.7398458792) => 0.0005457575,
      (f_add_curr_nhood_MFD_pct_i > 0.7398458792) => 0.0917822254,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0204689246, -0.0013720776),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0065972388, -0.0030228852),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 46) => 0.1500370537,
   (f_mos_inq_banko_cm_lseen_d > 46) => 0.0198894143,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0489700223, 0.0489700223),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 64365) => -0.0584166130,
   (c_med_hhinc > 64365) => 0.0442925922,
   (c_med_hhinc = NULL) => -0.0011688593, -0.0011688593), -0.0018852124);

// Tree: 149 
wFDN_FL_PS__lgt_149 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => -0.0085570377,
   (f_util_add_curr_misc_n > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0130195647,
      (r_D33_eviction_count_i > 0.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 58.8) => -0.0153465887,
         (c_civ_emp > 58.8) => 0.1082783562,
         (c_civ_emp = NULL) => 0.0648781096, 0.0648781096),
      (r_D33_eviction_count_i = NULL) => 0.0147124639, 0.0147124639),
   (f_util_add_curr_misc_n = NULL) => 0.0022318730, 0.0022318730),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 216.5) => 0.0323830640,
   (r_A50_pb_total_dollars_d > 216.5) => -0.1135413783,
   (r_A50_pb_total_dollars_d = NULL) => -0.0513255308, -0.0513255308),
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0092689149, 0.0015648244);

// Tree: 150 
wFDN_FL_PS__lgt_150 := map(
(NULL < c_unempl and c_unempl <= 24.5) => -0.0680762867,
(c_unempl > 24.5) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 58.5) => 
         map(
         (NULL < c_child and c_child <= 20.95) => 
            map(
            (NULL < c_hval_300k_p and c_hval_300k_p <= 7.65) => 0.2172035715,
            (c_hval_300k_p > 7.65) => -0.0335946840,
            (c_hval_300k_p = NULL) => 0.1278781654, 0.1278781654),
         (c_child > 20.95) => -0.0104912689,
         (c_child = NULL) => 0.0263064313, 0.0263064313),
      (k_comb_age_d > 58.5) => 0.1462789190,
      (k_comb_age_d = NULL) => 0.0443208761, 0.0443208761),
   (f_corrssnnamecount_d > 1.5) => -0.0008244760,
   (f_corrssnnamecount_d = NULL) => -0.0124697895, 0.0015373603),
(c_unempl = NULL) => 0.0238393987, -0.0010384561);

// Tree: 151 
wFDN_FL_PS__lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => -0.0019998357,
      (k_inq_per_phone_i > 6.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.45) => 0.1116724837,
         (c_pop_6_11_p > 8.45) => -0.0122833784,
         (c_pop_6_11_p = NULL) => 0.0586913491, 0.0586913491),
      (k_inq_per_phone_i = NULL) => -0.0013900946, -0.0013900946),
   (k_inq_adls_per_phone_i > 3.5) => -0.0986313474,
   (k_inq_adls_per_phone_i = NULL) => -0.0018412941, -0.0018412941),
(r_C14_addrs_10yr_i > 10.5) => 0.1128482091,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 65.5) => 0.0703385067,
   (c_rental > 65.5) => -0.0310280683,
   (c_rental = NULL) => 0.0121902389, 0.0121902389), -0.0012319610);

// Tree: 152 
wFDN_FL_PS__lgt_152 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1022731686,
   (f_hh_age_18_plus_d > 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 19999.5) => -0.0809752528,
      (k_estimated_income_d > 19999.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
            map(
            (NULL < c_asian_lang and c_asian_lang <= 153.5) => 0.1154123883,
            (c_asian_lang > 153.5) => -0.0083184250,
            (c_asian_lang = NULL) => 0.0486536726, 0.0486536726),
         (r_C10_M_Hdr_FS_d > 15.5) => 0.0064983442,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0085606601, 0.0085606601),
      (k_estimated_income_d = NULL) => 0.0071473727, 0.0071473727),
   (f_hh_age_18_plus_d = NULL) => 0.0082819006, 0.0082819006),
(f_dl_addrs_per_adl_i > 0.5) => -0.0141725693,
(f_dl_addrs_per_adl_i = NULL) => -0.0072392902, -0.0005979327);

// Tree: 153 
wFDN_FL_PS__lgt_153 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 26.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.40573036235) => 0.0046060177,
   (f_add_curr_mobility_index_i > 0.40573036235) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0800150209,
      (r_D33_Eviction_Recency_d > 549) => -0.0428586578,
      (r_D33_Eviction_Recency_d = NULL) => -0.0358099553, -0.0358099553),
   (f_add_curr_mobility_index_i = NULL) => 0.0658653388, 0.0005198772),
(f_rel_homeover300_count_d > 26.5) => -0.1156453573,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 4.15) => -0.0916890364,
   (c_famotf18_p > 4.15) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 61.6) => -0.0209405177,
      (C_OWNOCC_P > 61.6) => 0.0777646639,
      (C_OWNOCC_P = NULL) => 0.0160739254, 0.0160739254),
   (c_famotf18_p = NULL) => -0.0104049738, -0.0104049738), -0.0005253683);

// Tree: 154 
wFDN_FL_PS__lgt_154 := map(
(NULL < c_hval_20k_p and c_hval_20k_p <= 37.7) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 85.05) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.38155616785) => 0.0017951544,
      (f_add_curr_mobility_index_i > 0.38155616785) => -0.0263451826,
      (f_add_curr_mobility_index_i = NULL) => -0.0023805391, -0.0023805391),
   (r_C12_source_profile_d > 85.05) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 16.5) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 93.5) => 0.1541525493,
         (c_medi_indx > 93.5) => -0.0343509317,
         (c_medi_indx = NULL) => 0.0274659993, 0.0274659993),
      (c_famotf18_p > 16.5) => 0.2540765286,
      (c_famotf18_p = NULL) => 0.0656159201, 0.0656159201),
   (r_C12_source_profile_d = NULL) => -0.0151249767, -0.0008721568),
(c_hval_20k_p > 37.7) => 0.1029383320,
(c_hval_20k_p = NULL) => -0.0095786716, -0.0005905270);

// Tree: 155 
wFDN_FL_PS__lgt_155 := map(
(NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1547005712,
(r_I60_inq_retail_recency_d > 2) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 32.1) => 
         map(
         (NULL < c_bargains and c_bargains <= 90.5) => 0.0383227423,
         (c_bargains > 90.5) => -0.0057508872,
         (c_bargains = NULL) => 0.0087881947, 0.0087881947),
      (c_vacant_p > 32.1) => 0.1716310614,
      (c_vacant_p = NULL) => 0.0077111972, 0.0123034232),
   (k_estimated_income_d > 32500) => -0.0101858958,
   (k_estimated_income_d = NULL) => -0.0035679030, -0.0035679030),
(r_I60_inq_retail_recency_d = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 89.5) => -0.0379037959,
   (c_span_lang > 89.5) => 0.0602829236,
   (c_span_lang = NULL) => 0.0139684332, 0.0139684332), -0.0027171319);

// Tree: 156 
wFDN_FL_PS__lgt_156 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => 0.0001453116,
   (k_inq_per_phone_i > 4.5) => 0.0606433787,
   (k_inq_per_phone_i = NULL) => 0.0010305510, 0.0010305510),
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 23.15) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 40.5) => 0.0045716090,
      (r_A50_pb_average_dollars_d > 40.5) => -0.0781495601,
      (r_A50_pb_average_dollars_d = NULL) => -0.0510543398, -0.0510543398),
   (C_INC_15K_P > 23.15) => 0.0507527591,
   (C_INC_15K_P = NULL) => -0.0379676050, -0.0379676050),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 2.35) => 0.0673817872,
   (c_hval_125k_p > 2.35) => -0.0361399380,
   (c_hval_125k_p = NULL) => 0.0066376344, 0.0066376344), -0.0005532676);

// Tree: 157 
wFDN_FL_PS__lgt_157 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 15.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 20986.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 138.5) => 0.1690197248,
      (c_born_usa > 138.5) => -0.0129959909,
      (c_born_usa = NULL) => 0.0753611526, 0.0753611526),
   (r_A46_Curr_AVM_AutoVal_d > 20986.5) => 0.0035738984,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0058766694, 0.0000559772),
(f_srchssnsrchcount_i > 15.5) => 
   map(
   (NULL < c_professional and c_professional <= 4.7) => 0.0015804517,
   (c_professional > 4.7) => 0.1228553930,
   (c_professional = NULL) => 0.0518651835, 0.0518651835),
(f_srchssnsrchcount_i = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 24.95) => 0.0475892817,
   (c_lowinc > 24.95) => -0.0666315298,
   (c_lowinc = NULL) => -0.0005533744, -0.0005533744), 0.0005564724);

// Tree: 158 
wFDN_FL_PS__lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 2.5) => -0.0030517999,
      (r_I61_inq_collection_count12_i > 2.5) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 156) => -0.0331911449,
         (r_A50_pb_average_dollars_d > 156) => 0.1401590707,
         (r_A50_pb_average_dollars_d = NULL) => 0.0573649379, 0.0573649379),
      (r_I61_inq_collection_count12_i = NULL) => -0.0020680212, -0.0020680212),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 543) => -0.1465204090,
      (r_A50_pb_total_dollars_d > 543) => -0.0063044198,
      (r_A50_pb_total_dollars_d = NULL) => -0.0635757394, -0.0635757394),
   (r_I60_inq_comm_count12_i = NULL) => -0.0027675323, -0.0027675323),
(r_D33_eviction_count_i > 3.5) => 0.0806507570,
(r_D33_eviction_count_i = NULL) => 0.0067562099, -0.0021812244);

// Tree: 159 
wFDN_FL_PS__lgt_159 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 1.35) => 0.1388035355,
(C_INC_100K_P > 1.35) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 17.5) => 0.0003330024,
   (f_rel_homeover500_count_d > 17.5) => 0.1169224604,
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 137.5) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1970.5) => -0.0412329363,
         (c_med_yearblt > 1970.5) => 
            map(
            (NULL < c_employees and c_employees <= 374.5) => 0.1392965050,
            (c_employees > 374.5) => 0.0196837637,
            (c_employees = NULL) => 0.0826378381, 0.0826378381),
         (c_med_yearblt = NULL) => 0.0423248642, 0.0423248642),
      (c_sub_bus > 137.5) => -0.0437677528,
      (c_sub_bus = NULL) => -0.0012249099, -0.0012249099), 0.0008292915),
(C_INC_100K_P = NULL) => 0.0056997282, 0.0016211525);

// Tree: 160 
wFDN_FL_PS__lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.55) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 197.5) => -0.0031856853,
   (f_curraddrcartheftindex_i > 197.5) => -0.0978682155,
   (f_curraddrcartheftindex_i = NULL) => -0.0039125511, -0.0039125511),
(r_C12_source_profile_d > 79.55) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 178.5) => 
      map(
      (NULL < c_retail and c_retail <= 26.8) => 0.0143216645,
      (c_retail > 26.8) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 8.15) => 0.2985981247,
         (C_INC_125K_P > 8.15) => 0.0455217933,
         (C_INC_125K_P = NULL) => 0.1545709442, 0.1545709442),
      (c_retail = NULL) => 0.0312506747, 0.0312506747),
   (c_old_homes > 178.5) => 0.2014976162,
   (c_old_homes = NULL) => 0.0407176038, 0.0407176038),
(r_C12_source_profile_d = NULL) => -0.0099557118, -0.0001040154);

// Tree: 161 
wFDN_FL_PS__lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.2) => 
         map(
         (NULL < c_retired and c_retired <= 16.45) => -0.0515939072,
         (c_retired > 16.45) => 0.0898435488,
         (c_retired = NULL) => -0.0173060391, -0.0173060391),
      (c_famotf18_p > 29.2) => -0.0899451405,
      (c_famotf18_p = NULL) => -0.0288171535, -0.0288171535),
   (f_inq_HighRiskCredit_count_i > 1.5) => -0.1168472588,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0387802507, -0.0387802507),
(f_mos_inq_banko_cm_fseen_d > 25.5) => -0.0010234846,
(f_mos_inq_banko_cm_fseen_d = NULL) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 825) => 0.0331729940,
   (c_med_rent > 825) => -0.0722133192,
   (c_med_rent = NULL) => -0.0172683183, -0.0172683183), -0.0030995574);

// Tree: 162 
wFDN_FL_PS__lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0001806436,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 89.25) => 0.1034734382,
   (c_occunit_p > 89.25) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 7.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 10.35) => -0.1246471538,
         (c_pop_55_64_p > 10.35) => 0.0250575618,
         (c_pop_55_64_p = NULL) => -0.0552386038, -0.0552386038),
      (f_rel_homeover150_count_d > 7.5) => 0.0701529628,
      (f_rel_homeover150_count_d = NULL) => 0.0018704265, 0.0018704265),
   (c_occunit_p = NULL) => 0.0319619108, 0.0319619108),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 65) => 0.0618946096,
   (c_larceny > 65) => -0.0219049524,
   (c_larceny = NULL) => 0.0189728827, 0.0189728827), 0.0007444400);

// Tree: 163 
wFDN_FL_PS__lgt_163 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0089307686,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 42.35) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 165.5) => 0.0983318647,
      (f_mos_liens_unrel_SC_fseen_d > 165.5) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 57.5) => 
            map(
            (NULL < c_hh7p_p and c_hh7p_p <= 5.45) => 0.0283499154,
            (c_hh7p_p > 5.45) => 0.1583796470,
            (c_hh7p_p = NULL) => 0.0430597890, 0.0430597890),
         (c_retired2 > 57.5) => -0.0054776779,
         (c_retired2 = NULL) => 0.0085462525, 0.0085462525),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0109182531, 0.0109182531),
   (c_hval_500k_p > 42.35) => 0.1185946951,
   (c_hval_500k_p = NULL) => 0.0138789657, 0.0138789657),
(c_rnt1250_p = NULL) => -0.0059884634, -0.0026462005);

// Tree: 164 
wFDN_FL_PS__lgt_164 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 21.5) => -0.0828636101,
(f_mos_inq_banko_am_lseen_d > 21.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0016996574,
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
            map(
            (NULL < c_hval_250k_p and c_hval_250k_p <= 1.05) => 0.1919407676,
            (c_hval_250k_p > 1.05) => 0.0307576252,
            (c_hval_250k_p = NULL) => 0.0796882220, 0.0796882220),
         (f_inq_count_i > 2.5) => 0.0045862246,
         (f_inq_count_i = NULL) => 0.0197120304, 0.0197120304),
      (k_comb_age_d > 68.5) => 0.1345123506,
      (k_comb_age_d = NULL) => 0.0253792910, 0.0253792910),
   (k_inq_per_ssn_i = NULL) => 0.0045855406, 0.0045855406),
(f_mos_inq_banko_am_lseen_d = NULL) => -0.0060516222, 0.0027313463);

// Tree: 165 
wFDN_FL_PS__lgt_165 := map(
(NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 2.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 57.5) => -0.0336407869,
      (f_fp_prevaddrcrimeindex_i > 57.5) => 0.1849115741,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.1007284424, 0.1007284424),
   (c_born_usa > 2.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 19.5) => 0.0127216794,
      (f_rel_incomeover25_count_d > 19.5) => -0.0310266555,
      (f_rel_incomeover25_count_d = NULL) => 0.0228503576, 0.0097831583),
   (c_born_usa = NULL) => 0.0135504067, 0.0114090128),
(k_inf_phn_verd_d > 0.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 5.5) => -0.0261938389,
   (f_inq_Collection_count_i > 5.5) => 0.0454552034,
   (f_inq_Collection_count_i = NULL) => -0.0206860689, -0.0206860689),
(k_inf_phn_verd_d = NULL) => 0.0000384730, 0.0000384730);

// Tree: 166 
wFDN_FL_PS__lgt_166 := map(
(NULL < c_oldhouse and c_oldhouse <= 403.55) => 
   map(
   (NULL < c_hval_400k_p and c_hval_400k_p <= 56.9) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 8.25) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 27.15) => 0.0195327501,
         (c_hh3_p > 27.15) => 
            map(
            (NULL < c_rental and c_rental <= 90.5) => 0.0690651229,
            (c_rental > 90.5) => 0.2825109630,
            (c_rental = NULL) => 0.1605419115, 0.1605419115),
         (c_hh3_p = NULL) => 0.0413534136, 0.0413534136),
      (c_hh1_p > 8.25) => -0.0027498267,
      (c_hh1_p = NULL) => 0.0001671245, 0.0001671245),
   (c_hval_400k_p > 56.9) => 0.1444285860,
   (c_hval_400k_p = NULL) => 0.0012263310, 0.0012263310),
(c_oldhouse > 403.55) => -0.0405339549,
(c_oldhouse = NULL) => 0.0083053201, -0.0007915910);

// Tree: 167 
wFDN_FL_PS__lgt_167 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0068264790,
   (r_F04_curr_add_occ_index_d > 2) => 
      map(
      (NULL < c_employees and c_employees <= 37.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 112.5) => 
            map(
            (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 0.0392685723,
            (f_util_add_curr_misc_n > 0.5) => 0.2047836843,
            (f_util_add_curr_misc_n = NULL) => 0.1016254284, 0.1016254284),
         (c_exp_prod > 112.5) => -0.0113267150,
         (c_exp_prod = NULL) => 0.0592683747, 0.0592683747),
      (c_employees > 37.5) => 0.0021541539,
      (c_employees = NULL) => 0.0279182795, 0.0101334557),
   (r_F04_curr_add_occ_index_d = NULL) => -0.0030113081, -0.0030113081),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0715744639,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0213113385, -0.0035281957);

// Tree: 168 
wFDN_FL_PS__lgt_168 := map(
(NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 104) => 
   map(
   (NULL < c_construction and c_construction <= 24.9) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 98912.5) => -0.0848221886,
      (r_A46_Curr_AVM_AutoVal_d > 98912.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 16.05) => 0.1035916346,
         (c_hh3_p > 16.05) => -0.0866155191,
         (c_hh3_p = NULL) => -0.0008358223, -0.0008358223),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0851220459, -0.0555470376),
   (c_construction > 24.9) => 0.0909095004,
   (c_construction = NULL) => -0.0378661678, -0.0378661678),
(f_mos_liens_unrel_CJ_lseen_d > 104) => -0.0003662298,
(f_mos_liens_unrel_CJ_lseen_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0427256056,
   (f_addrs_per_ssn_i > 3.5) => 0.0572742458,
   (f_addrs_per_ssn_i = NULL) => 0.0102154922, 0.0102154922), -0.0017450823);

// Tree: 169 
wFDN_FL_PS__lgt_169 := map(
(NULL < f_varmsrcssncount_i and f_varmsrcssncount_i <= 0.5) => -0.0860686611,
(f_varmsrcssncount_i > 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 0.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 92.5) => 0.1377623226,
      (c_rest_indx > 92.5) => -0.0230036218,
      (c_rest_indx = NULL) => 0.0396538745, 0.0396538745),
   (r_C13_Curr_Addr_LRes_d > 0.5) => 
      map(
      (NULL < c_hval_1001k_p and c_hval_1001k_p <= 37.25) => -0.0036809314,
      (c_hval_1001k_p > 37.25) => 0.0817466154,
      (c_hval_1001k_p = NULL) => 0.0144343711, -0.0014495087),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0007742176, -0.0007742176),
(f_varmsrcssncount_i = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 10.8) => -0.0456671842,
   (c_rnt1000_p > 10.8) => 0.0378967862,
   (c_rnt1000_p = NULL) => -0.0005156841, -0.0005156841), -0.0017062503);

// Tree: 170 
wFDN_FL_PS__lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 38.05) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 385.35) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.0282030474,
         (k_estimated_income_d > 28500) => -0.0013316570,
         (k_estimated_income_d = NULL) => 0.0031575354, 0.0031575354),
      (c_oldhouse > 385.35) => -0.0334393575,
      (c_oldhouse = NULL) => 0.0010987149, 0.0010987149),
   (c_hh3_p > 38.05) => -0.0906149643,
   (c_hh3_p = NULL) => -0.0182692530, 0.0001173721),
(f_util_adl_count_n > 13.5) => 0.1076295876,
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.75) => 0.0637024487,
   (c_hh4_p > 12.75) => -0.0446603194,
   (c_hh4_p = NULL) => 0.0038177611, 0.0038177611), 0.0009818137);

// Tree: 171 
wFDN_FL_PS__lgt_171 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 12.95) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 81.85) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 0.0024098921,
      (f_srchcomponentrisktype_i > 3.5) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 107.5) => 0.0814105576,
         (c_medi_indx > 107.5) => -0.0413961737,
         (c_medi_indx = NULL) => 0.0445685382, 0.0445685382),
      (f_srchcomponentrisktype_i = NULL) => -0.0017301134, 0.0032160065),
   (c_low_ed > 81.85) => -0.0565756469,
   (c_low_ed = NULL) => 0.0022790024, 0.0022790024),
(c_femdiv_p > 12.95) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04861726755) => 0.1572892338,
   (f_add_curr_nhood_BUS_pct_i > 0.04861726755) => -0.0219505272,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0757250729, 0.0757250729),
(c_femdiv_p = NULL) => 0.0166016545, 0.0037117527);

// Tree: 172 
wFDN_FL_PS__lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20) => 
   map(
   (NULL < c_med_hhinc and c_med_hhinc <= 27878) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 0.5) => -0.0072048268,
      (f_srchssnsrchcount_i > 0.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 18) => 0.0216272761,
         (r_I60_inq_recency_d > 18) => 
            map(
            (NULL < c_preschl and c_preschl <= 90) => 0.0541182408,
            (c_preschl > 90) => 0.1625103967,
            (c_preschl = NULL) => 0.1164437304, 0.1164437304),
         (r_I60_inq_recency_d = NULL) => 0.0636124219, 0.0636124219),
      (f_srchssnsrchcount_i = NULL) => 0.0301326720, 0.0301326720),
   (c_med_hhinc > 27878) => -0.0053091779,
   (c_med_hhinc = NULL) => -0.0038053578, -0.0038053578),
(c_pop_0_5_p > 20) => 0.1378145118,
(c_pop_0_5_p = NULL) => -0.0074790717, -0.0032564519);

// Tree: 173 
wFDN_FL_PS__lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0081718826,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 1.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 8.5) => 
         map(
         (NULL < c_retail and c_retail <= 38.75) => 
            map(
            (NULL < c_hh6_p and c_hh6_p <= 10.3) => 0.0242732213,
            (c_hh6_p > 10.3) => 0.1086138286,
            (c_hh6_p = NULL) => 0.0270358230, 0.0270358230),
         (c_retail > 38.75) => -0.0934663921,
         (c_retail = NULL) => 0.0213573221, 0.0213573221),
      (f_srchphonesrchcount_i > 8.5) => -0.0902416747,
      (f_srchphonesrchcount_i = NULL) => 0.0180730667, 0.0180730667),
   (f_idrisktype_i > 1.5) => 0.1271014960,
   (f_idrisktype_i = NULL) => 0.0239615732, 0.0239615732),
(f_rel_felony_count_i = NULL) => 0.0167933673, -0.0033939831);

// Tree: 174 
wFDN_FL_PS__lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 21.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 38.35) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
            map(
            (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 14.5) => 0.0597100789,
            (r_C10_M_Hdr_FS_d > 14.5) => 0.0017922564,
            (r_C10_M_Hdr_FS_d = NULL) => 0.0026506329, 0.0026506329),
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0559565180,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0001139055, 0.0001139055),
      (c_hval_20k_p > 38.35) => 0.1495759061,
      (c_hval_20k_p = NULL) => -0.0104076237, 0.0004726198),
   (f_srchssnsrchcount_i > 21.5) => 0.0850710146,
   (f_srchssnsrchcount_i = NULL) => 0.0009330192, 0.0009330192),
(f_srchphonesrchcount_i > 21.5) => -0.0957243890,
(f_srchphonesrchcount_i = NULL) => -0.0237209179, 0.0001720820);

// Tree: 175 
wFDN_FL_PS__lgt_175 := map(
(NULL < c_retail and c_retail <= 13.15) => -0.0129316289,
(c_retail > 13.15) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 
      map(
      (NULL < c_white_col and c_white_col <= 18.35) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 110.5) => 0.0255503157,
         (c_asian_lang > 110.5) => 0.1873440526,
         (c_asian_lang = NULL) => 0.0933993021, 0.0933993021),
      (c_white_col > 18.35) => 0.0056324773,
      (c_white_col = NULL) => 0.0080238388, 0.0080238388),
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 6.05) => 0.0320939454,
      (c_femdiv_p > 6.05) => 0.2377132751,
      (c_femdiv_p = NULL) => 0.0932901745, 0.0932901745),
   (f_hh_members_w_derog_i = NULL) => 0.0110593854, 0.0110593854),
(c_retail = NULL) => 0.0102965180, -0.0033594199);

// Tree: 176 
wFDN_FL_PS__lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.35) => 0.0058399176,
(c_pop_18_24_p > 11.35) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.15) => 
      map(
      (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 0.5) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1975.5) => -0.0466020641,
         (c_med_yearblt > 1975.5) => 0.1827487087,
         (c_med_yearblt = NULL) => 0.0322751858, 0.0322751858),
      (f_divssnidmsrcurelcount_i > 0.5) => -0.0647347015,
      (f_divssnidmsrcurelcount_i = NULL) => -0.0487635616, -0.0487635616),
   (c_hval_175k_p > 2.15) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 15.5) => 0.1081386991,
      (r_C21_M_Bureau_ADL_FS_d > 15.5) => -0.0036921021,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0019186528, 0.0019186528),
   (c_hval_175k_p = NULL) => -0.0204417151, -0.0204417151),
(c_pop_18_24_p = NULL) => 0.0097742403, 0.0004929611);

// Tree: 177 
wFDN_FL_PS__lgt_177 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 37.8) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 0.0053043688,
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 57) => 0.1840895787,
      (c_cartheft > 57) => -0.0038338614,
      (c_cartheft = NULL) => 0.0655338514, 0.0655338514),
   (k_comb_age_d = NULL) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 96.5) => -0.0672656157,
      (c_mort_indx > 96.5) => 0.0385698215,
      (c_mort_indx = NULL) => -0.0162378156, -0.0162378156), 0.0058443184),
(C_INC_15K_P > 37.8) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 3.5) => -0.0158949429,
   (r_C14_addrs_15yr_i > 3.5) => -0.1111312584,
   (r_C14_addrs_15yr_i = NULL) => -0.0475017550, -0.0475017550),
(C_INC_15K_P = NULL) => 0.0002956663, 0.0047407602);

// Tree: 178 
wFDN_FL_PS__lgt_178 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 1.5) => -0.0064688322,
(f_srchphonesrchcount_i > 1.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 23.5) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => 
         map(
         (NULL < c_retail and c_retail <= 8.6) => 0.0401589641,
         (c_retail > 8.6) => 0.1923691819,
         (c_retail = NULL) => 0.1218327395, 0.1218327395),
      (r_A44_curr_add_naprop_d > 3.5) => 0.0279614492,
      (r_A44_curr_add_naprop_d = NULL) => 0.0734303554, 0.0734303554),
   (k_comb_age_d > 23.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.35) => -0.0666849832,
      (C_INC_200K_P > 0.35) => 0.0188344039,
      (C_INC_200K_P = NULL) => 0.0106162169, 0.0106162169),
   (k_comb_age_d = NULL) => 0.0166524104, 0.0166524104),
(f_srchphonesrchcount_i = NULL) => 0.0285836913, -0.0012548088);

// Tree: 179 
wFDN_FL_PS__lgt_179 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 23.5) => 0.0010020941,
(f_rel_incomeover25_count_d > 23.5) => 
   map(
   (NULL < c_assault and c_assault <= 37) => -0.1085652697,
   (c_assault > 37) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 138) => -0.0736433452,
      (r_pb_order_freq_d > 138) => 0.0254416584,
      (r_pb_order_freq_d = NULL) => 0.0384755018, -0.0092073260),
   (c_assault = NULL) => -0.0352341678, -0.0352341678),
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 25.05) => 
      map(
      (NULL < c_incollege and c_incollege <= 3.95) => 0.1767774694,
      (c_incollege > 3.95) => 0.0322565855,
      (c_incollege = NULL) => 0.0651022409, 0.0651022409),
   (c_rnt1000_p > 25.05) => -0.0374724164,
   (c_rnt1000_p = NULL) => 0.0343951779, 0.0343951779), 0.0003447625);

// Tree: 180 
wFDN_FL_PS__lgt_180 := map(
(NULL < c_high_ed and c_high_ed <= 65.55) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < c_trailer and c_trailer <= 173.5) => 0.0142000846,
         (c_trailer > 173.5) => 
            map(
            (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.55) => 0.1960703994,
            (c_pop_65_74_p > 6.55) => 0.0282684772,
            (c_pop_65_74_p = NULL) => 0.0923814758, 0.0923814758),
         (c_trailer = NULL) => 0.0217373538, 0.0217373538),
      (f_hh_members_ct_d > 1.5) => -0.0012785686,
      (f_hh_members_ct_d = NULL) => -0.0065772564, 0.0031144312),
   (k_inq_adls_per_phone_i > 2.5) => -0.0752035121,
   (k_inq_adls_per_phone_i = NULL) => 0.0025140846, 0.0025140846),
(c_high_ed > 65.55) => -0.0471233428,
(c_high_ed = NULL) => 0.0267234927, -0.0004372366);

// Tree: 181 
wFDN_FL_PS__lgt_181 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 6.45) => -0.0121350511,
   (c_lowrent > 6.45) => 
      map(
      (NULL < c_incollege and c_incollege <= 7.15) => 0.0155043645,
      (c_incollege > 7.15) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
            map(
            (NULL < c_lowrent and c_lowrent <= 22.85) => 0.1586351510,
            (c_lowrent > 22.85) => -0.0185526732,
            (c_lowrent = NULL) => 0.0559075798, 0.0559075798),
         (f_hh_lienholders_i > 0.5) => 0.1684405262,
         (f_hh_lienholders_i = NULL) => 0.0869730129, 0.0869730129),
      (c_incollege = NULL) => 0.0348866182, 0.0348866182),
   (c_lowrent = NULL) => -0.0247446242, 0.0150058097),
(k_estimated_income_d > 28500) => -0.0072578089,
(k_estimated_income_d = NULL) => 0.0182801102, -0.0031965765);

// Tree: 182 
wFDN_FL_PS__lgt_182 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 17.25) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0003139882,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 4.75) => 
         map(
         (NULL < f_rel_count_i and f_rel_count_i <= 7.5) => 0.0034232610,
         (f_rel_count_i > 7.5) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 58660.5) => 0.1343226837,
            (f_prevaddrmedianincome_d > 58660.5) => 0.0325371965,
            (f_prevaddrmedianincome_d = NULL) => 0.0818799073, 0.0818799073),
         (f_rel_count_i = NULL) => 0.0455375916, 0.0455375916),
      (c_hh6_p > 4.75) => -0.0540114046,
      (c_hh6_p = NULL) => 0.0271825706, 0.0271825706),
   (k_nap_contradictory_i = NULL) => 0.0017596113, 0.0017596113),
(c_pop_0_5_p > 17.25) => -0.0851064001,
(c_pop_0_5_p = NULL) => 0.0058325040, 0.0007025929);

// Tree: 183 
wFDN_FL_PS__lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < r_nas_fname_verd_d and r_nas_fname_verd_d <= 0.5) => 0.1012014578,
   (r_nas_fname_verd_d > 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 15.75) => 0.0630748729,
      (c_fammar_p > 15.75) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 40.45) => -0.0033645301,
         (c_famotf18_p > 40.45) => -0.0370618682,
         (c_famotf18_p = NULL) => -0.0042673877, -0.0042673877),
      (c_fammar_p = NULL) => -0.0054903141, -0.0038921573),
   (r_nas_fname_verd_d = NULL) => -0.0034202052, -0.0034202052),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0767795739,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 125.5) => -0.0492203563,
   (c_ab_av_edu > 125.5) => 0.0482723529,
   (c_ab_av_edu = NULL) => -0.0081283880, -0.0081283880), -0.0039924967);

// Tree: 184 
wFDN_FL_PS__lgt_184 := map(
(NULL < c_burglary and c_burglary <= 4) => -0.0654428789,
(c_burglary > 4) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => -0.0000924984,
   (f_util_adl_count_n > 7.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.88932134) => 
            map(
            (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 3.5) => 0.1199490923,
            (f_rel_homeover200_count_d > 3.5) => -0.0677153048,
            (f_rel_homeover200_count_d = NULL) => 0.0164101146, 0.0164101146),
         (f_add_curr_nhood_SFD_pct_d > 0.88932134) => 0.1978325683,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0765386992, 0.0765386992),
      (f_phone_ver_experian_d > 0.5) => -0.0064107002,
      (f_phone_ver_experian_d = NULL) => 0.0928296986, 0.0332992234),
   (f_util_adl_count_n = NULL) => -0.0053955569, 0.0013260450),
(c_burglary = NULL) => 0.0128765312, -0.0011177209);

// Tree: 185 
wFDN_FL_PS__lgt_185 := map(
(NULL < c_for_sale and c_for_sale <= 163.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 41.4) => 
         map(
         (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 0.5) => -0.0217073406,
         (f_rel_bankrupt_count_i > 0.5) => 
            map(
            (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.35) => 0.2274167335,
            (c_pop_35_44_p > 14.35) => 0.0479355884,
            (c_pop_35_44_p = NULL) => 0.1403549840, 0.1403549840),
         (f_rel_bankrupt_count_i = NULL) => 0.0868744169, 0.0868744169),
      (c_med_age > 41.4) => -0.0576528480,
      (c_med_age = NULL) => 0.0506072755, 0.0506072755),
   (r_I61_inq_collection_recency_d > 4.5) => 0.0077532502,
   (r_I61_inq_collection_recency_d = NULL) => 0.0001006896, 0.0088082140),
(c_for_sale > 163.5) => -0.0212731759,
(c_for_sale = NULL) => -0.0039144659, 0.0031316071);

// Tree: 186 
wFDN_FL_PS__lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 2.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 83.25) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 59.85) => 0.0020998239,
         (c_lowinc > 59.85) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 19649) => -0.0424271392,
            (f_prevaddrmedianincome_d > 19649) => 0.0699421009,
            (f_prevaddrmedianincome_d = NULL) => 0.0451333077, 0.0451333077),
         (c_lowinc = NULL) => 0.0034970149, 0.0034970149),
      (C_RENTOCC_P > 83.25) => -0.0558492903,
      (C_RENTOCC_P = NULL) => 0.0052684902, 0.0021553715),
   (k_inq_addrs_per_ssn_i > 2.5) => -0.0705185727,
   (k_inq_addrs_per_ssn_i = NULL) => 0.0016795060, 0.0016795060),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0740473564,
(f_inq_PrepaidCards_count_i = NULL) => 0.0143146579, 0.0020951513);

// Tree: 187 
wFDN_FL_PS__lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 197.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 
         map(
         (NULL < c_unemp and c_unemp <= 2.45) => -0.0297847837,
         (c_unemp > 2.45) => 0.0093609916,
         (c_unemp = NULL) => 0.0017946207, 0.0017946207),
      (c_hval_80k_p > 19.25) => -0.0368156749,
      (c_hval_80k_p = NULL) => -0.0101451651, -0.0009332032),
   (f_curraddrmurderindex_i > 197.5) => -0.0825430965,
   (f_curraddrmurderindex_i = NULL) => -0.0014400970, -0.0014400970),
(f_rel_bankrupt_count_i > 7.5) => -0.0776542321,
(f_rel_bankrupt_count_i = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0521221313,
   (r_Phn_Cell_n > 0.5) => -0.0733611582,
   (r_Phn_Cell_n = NULL) => -0.0052694507, -0.0052694507), -0.0024283366);

// Tree: 188 
wFDN_FL_PS__lgt_188 := map(
(NULL < c_sfdu_p and c_sfdu_p <= 6.85) => -0.0478184150,
(c_sfdu_p > 6.85) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 19.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 0.0022778373,
      (f_srchfraudsrchcount_i > 12.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02322530465) => -0.0193096851,
         (f_add_curr_nhood_BUS_pct_i > 0.02322530465) => 0.0940073039,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0541509836, 0.0541509836),
      (f_srchfraudsrchcount_i = NULL) => 0.0029583304, 0.0029583304),
   (f_inq_count24_i > 19.5) => -0.1169558542,
   (f_inq_count24_i = NULL) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12.55) => -0.0531071003,
      (c_pop_25_34_p > 12.55) => 0.0384386118,
      (c_pop_25_34_p = NULL) => -0.0046417233, -0.0046417233), 0.0023751563),
(c_sfdu_p = NULL) => -0.0251307333, -0.0004563818);

// Tree: 189 
wFDN_FL_PS__lgt_189 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 105500) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0004365740,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 108.5) => -0.0273240717,
         (c_serv_empl > 108.5) => -0.1077486380,
         (c_serv_empl = NULL) => -0.0681834491, -0.0681834491),
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0028535315, -0.0028535315),
   (f_rel_homeover500_count_d > 14.5) => 0.0926369287,
   (f_rel_homeover500_count_d = NULL) => 0.0016951218, -0.0021729211),
(k_estimated_income_d > 105500) => 0.1472915414,
(k_estimated_income_d = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.6) => -0.0600654590,
   (c_hval_175k_p > 2.6) => 0.0558541512,
   (c_hval_175k_p = NULL) => 0.0021096047, 0.0021096047), -0.0014628161);

// Tree: 190 
wFDN_FL_PS__lgt_190 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 7.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 9.5) => 
      map(
      (NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 3.5) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => -0.0396253712,
         (f_mos_inq_banko_om_fseen_d > 21.5) => -0.0030851518,
         (f_mos_inq_banko_om_fseen_d = NULL) => -0.0056276763, -0.0056276763),
      (f_inq_Banking_count24_i > 3.5) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 4.95) => 0.1228462689,
         (C_INC_200K_P > 4.95) => -0.0020795175,
         (C_INC_200K_P = NULL) => 0.0526824710, 0.0526824710),
      (f_inq_Banking_count24_i = NULL) => -0.0049274658, -0.0049274658),
   (r_C14_addrs_10yr_i > 9.5) => 0.0762255546,
   (r_C14_addrs_10yr_i = NULL) => -0.0042850936, -0.0042850936),
(f_inq_Banking_count24_i > 7.5) => -0.1140945784,
(f_inq_Banking_count24_i = NULL) => -0.0066118091, -0.0048346091);

// Tree: 191 
wFDN_FL_PS__lgt_191 := map(
(NULL < c_manufacturing and c_manufacturing <= 30.75) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 6.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 1023.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 71.5) => 
            map(
            (NULL < c_assault and c_assault <= 46.5) => -0.0703267879,
            (c_assault > 46.5) => 0.0912460167,
            (c_assault = NULL) => 0.0031153960, 0.0031153960),
         (f_curraddrcrimeindex_i > 71.5) => -0.0841189568,
         (f_curraddrcrimeindex_i = NULL) => -0.0515484282, -0.0515484282),
      (c_hh00 > 1023.5) => 0.1245133624,
      (c_hh00 = NULL) => -0.0297925090, -0.0297925090),
   (f_mos_inq_banko_cm_lseen_d > 6.5) => 0.0045904432,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0267478609, 0.0030104199),
(c_manufacturing > 30.75) => -0.0709650874,
(c_manufacturing = NULL) => -0.0217729837, 0.0000138047);

// Tree: 192 
wFDN_FL_PS__lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0692710264,
(r_D32_Mos_Since_Fel_LS_d > 117) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 3.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 5.45) => 
         map(
         (NULL < nf_vf_hi_ssn_add_entries and nf_vf_hi_ssn_add_entries <= 0.5) => -0.0119962302,
         (nf_vf_hi_ssn_add_entries > 0.5) => -0.0919744331,
         (nf_vf_hi_ssn_add_entries = NULL) => -0.0126609841, -0.0126609841),
      (c_femdiv_p > 5.45) => 0.0125803273,
      (c_femdiv_p = NULL) => -0.0084348501, -0.0042298110),
   (f_rel_ageover50_count_d > 3.5) => -0.0560467476,
   (f_rel_ageover50_count_d = NULL) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.75) => -0.0157810010,
      (c_hval_125k_p > 4.75) => 0.1735047703,
      (c_hval_125k_p = NULL) => 0.0342945999, 0.0342945999), -0.0052146895),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0056632132, -0.0048196751);

// Tree: 193 
wFDN_FL_PS__lgt_193 := map(
(NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => -0.0022552467,
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0639699365,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0166876099, -0.0027322235),
(C_INC_75K_P > 27.85) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 168) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 25.15) => -0.0229660215,
      (c_hval_150k_p > 25.15) => 0.1583153180,
      (c_hval_150k_p = NULL) => -0.0000769635, -0.0000769635),
   (r_C13_max_lres_d > 168) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.25) => 0.0275885640,
      (c_incollege > 6.25) => 0.1708297167,
      (c_incollege = NULL) => 0.0836394499, 0.0836394499),
   (r_C13_max_lres_d = NULL) => 0.0325582485, 0.0325582485),
(C_INC_75K_P = NULL) => -0.0210747990, -0.0013510037);

// Tree: 194 
wFDN_FL_PS__lgt_194 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 12.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 18.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 13.25) => 0.0053148458,
      (c_hval_125k_p > 13.25) => 
         map(
         (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 2.5) => 
            map(
            (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 6.5) => -0.0294231203,
            (r_D30_Derog_Count_i > 6.5) => -0.0969095760,
            (r_D30_Derog_Count_i = NULL) => -0.0321641669, -0.0321641669),
         (r_C20_email_domain_free_count_i > 2.5) => 0.0804339416,
         (r_C20_email_domain_free_count_i = NULL) => -0.0215470936, -0.0215470936),
      (c_hval_125k_p = NULL) => -0.0180468649, -0.0003385498),
   (r_D30_Derog_Count_i > 18.5) => -0.0867558522,
   (r_D30_Derog_Count_i = NULL) => -0.0006911606, -0.0006911606),
(r_C14_addrs_15yr_i > 12.5) => 0.1075996114,
(r_C14_addrs_15yr_i = NULL) => 0.0019520493, -0.0002109905);

// Tree: 195 
wFDN_FL_PS__lgt_195 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 3.95) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 12.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 93.5) => 0.1455897051,
      (c_no_labfor > 93.5) => 0.0095098191,
      (c_no_labfor = NULL) => 0.0626319136, 0.0626319136),
   (r_C21_M_Bureau_ADL_FS_d > 12.5) => 
      map(
      (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 101685) => -0.1311509264,
         (r_A46_Curr_AVM_AutoVal_d > 101685) => -0.0155857317,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0401982936, -0.0484752118),
      (nf_vf_hi_risk_hit_type > 3.5) => -0.0119094337,
      (nf_vf_hi_risk_hit_type = NULL) => -0.0136819965, -0.0136819965),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0466047520, -0.0118141524),
(c_rnt1250_p > 3.95) => 0.0156497861,
(c_rnt1250_p = NULL) => 0.0227841837, 0.0019213404);

// Tree: 196 
wFDN_FL_PS__lgt_196 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 74.85) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 24) => -0.0937811949,
   (f_mos_inq_banko_am_lseen_d > 24) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 88.5) => -0.0043026625,
      (c_lowrent > 88.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 2.5) => 0.0252235192,
         (f_util_adl_count_n > 2.5) => 0.2410999117,
         (f_util_adl_count_n = NULL) => 0.0722627331, 0.0722627331),
      (c_lowrent = NULL) => -0.0026321212, -0.0026321212),
   (f_mos_inq_banko_am_lseen_d = NULL) => 0.0164694889, -0.0042283487),
(c_rnt1000_p > 74.85) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.2164052417,
   (f_phone_ver_insurance_d > 2.5) => 0.0193439571,
   (f_phone_ver_insurance_d = NULL) => 0.0823680616, 0.0823680616),
(c_rnt1000_p = NULL) => 0.0004164985, -0.0025913888);

// Tree: 197 
wFDN_FL_PS__lgt_197 := map(
(NULL < c_hh4_p and c_hh4_p <= 11.55) => -0.0160295533,
(c_hh4_p > 11.55) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 112.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 156.5) => 0.0093540160,
      (r_A50_pb_average_dollars_d > 156.5) => 
         map(
         (NULL < c_child and c_child <= 38.65) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 0.0560680587,
            (f_historical_count_d > 0.5) => -0.0013972532,
            (f_historical_count_d = NULL) => 0.0317761715, 0.0317761715),
         (c_child > 38.65) => 0.1817825594,
         (c_child = NULL) => 0.0355917953, 0.0355917953),
      (r_A50_pb_average_dollars_d = NULL) => 0.0210081471, 0.0210081471),
   (c_rest_indx > 112.5) => -0.0090642246,
   (c_rest_indx = NULL) => 0.0090531469, 0.0090531469),
(c_hh4_p = NULL) => -0.0012624663, -0.0007201350);

// Tree: 198 
wFDN_FL_PS__lgt_198 := map(
(NULL < c_sub_bus and c_sub_bus <= 118.5) => -0.0084370143,
(c_sub_bus > 118.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.4) => 
      map(
      (NULL < c_retail and c_retail <= 16.35) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 188.5) => -0.0021444303,
         (c_born_usa > 188.5) => 0.1356021039,
         (c_born_usa = NULL) => -0.0003102554, -0.0003102554),
      (c_retail > 16.35) => 0.0381463731,
      (c_retail = NULL) => 0.0107295058, 0.0107295058),
   (r_C12_source_profile_d > 81.4) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 23.3) => 0.1945951511,
      (c_high_ed > 23.3) => 0.0429761617,
      (c_high_ed = NULL) => 0.0816608421, 0.0816608421),
   (r_C12_source_profile_d = NULL) => 0.0138576936, 0.0138576936),
(c_sub_bus = NULL) => -0.0136249580, 0.0012009431);

// Tree: 199 
wFDN_FL_PS__lgt_199 := map(
(NULL < c_hh6_p and c_hh6_p <= 11.05) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 15.55) => -0.0010326748,
   (c_pop_0_5_p > 15.55) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => -0.0933024075,
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0301531892,
      (nf_seg_FraudPoint_3_0 = '') => -0.0485105201, -0.0485105201),
   (c_pop_0_5_p = NULL) => -0.0023906509, -0.0023906509),
(c_hh6_p > 11.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 0.1151919255,
      (r_Prop_Owner_History_d > 0.5) => -0.0166727408,
      (r_Prop_Owner_History_d = NULL) => 0.0165305924, 0.0165305924),
   (r_D30_Derog_Count_i > 1.5) => 0.1115693151,
   (r_D30_Derog_Count_i = NULL) => 0.0352087229, 0.0352087229),
(c_hh6_p = NULL) => -0.0212016952, -0.0018188607);

// Tree: 200 
wFDN_FL_PS__lgt_200 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 8.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 18.7) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.34) => 
         map(
         (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 40.5) => -0.0913381885,
         (f_mos_inq_banko_am_lseen_d > 40.5) => -0.0013760121,
         (f_mos_inq_banko_am_lseen_d = NULL) => -0.0032990163, -0.0032990163),
      (c_hhsize > 4.34) => 0.0786191742,
      (c_hhsize = NULL) => -0.0026501058, -0.0026501058),
   (c_hh6_p > 18.7) => -0.0934810320,
   (c_hh6_p = NULL) => -0.0505339469, -0.0042790120),
(f_srchvelocityrisktype_i > 8.5) => -0.0630853452,
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 81.5) => -0.0370939409,
   (c_asian_lang > 81.5) => 0.0562618714,
   (c_asian_lang = NULL) => 0.0104174993, 0.0104174993), -0.0045120117);

// Tree: 201 
wFDN_FL_PS__lgt_201 := map(
(NULL < c_relig_indx and c_relig_indx <= 99.5) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 4.5) => 0.1369835656,
   (f_mos_acc_lseen_d > 4.5) => 0.0083972213,
   (f_mos_acc_lseen_d = NULL) => -0.0067033170, 0.0098218474),
(c_relig_indx > 99.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 3.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => -0.0139471380,
      (f_inq_Communications_count_i > 3.5) => -0.0825930325,
      (f_inq_Communications_count_i = NULL) => -0.0145310422, -0.0145310422),
   (f_srchcomponentrisktype_i > 3.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 1.1) => 0.1284920124,
      (c_high_hval > 1.1) => -0.0050016938,
      (c_high_hval = NULL) => 0.0532693684, 0.0532693684),
   (f_srchcomponentrisktype_i = NULL) => 0.0067115374, -0.0130700532),
(c_relig_indx = NULL) => 0.0001591076, -0.0024204223);

// Tree: 202 
wFDN_FL_PS__lgt_202 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 68.3) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 5.5) => -0.0572196496,
   (r_C10_M_Hdr_FS_d > 5.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.0907622091,
      (r_C10_M_Hdr_FS_d > 7.5) => 
         map(
         (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 0.5) => 0.0725558627,
         (r_C12_source_profile_index_d > 0.5) => -0.0023628608,
         (r_C12_source_profile_index_d = NULL) => -0.0015888941, -0.0015888941),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0011219332, -0.0011219332),
   (r_C10_M_Hdr_FS_d = NULL) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 17.2) => -0.0541395234,
      (c_hh3_p > 17.2) => 0.0497858830,
      (c_hh3_p = NULL) => -0.0098302416, -0.0098302416), -0.0016922399),
(c_hval_1001k_p > 68.3) => 0.1699101064,
(c_hval_1001k_p = NULL) => 0.0345965277, 0.0001935815);

// Tree: 203 
wFDN_FL_PS__lgt_203 := map(
(NULL < c_rape and c_rape <= 195.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 2) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 42.45) => 0.0114480047,
      (c_high_ed > 42.45) => -0.0186098617,
      (c_high_ed = NULL) => 0.0026664036, 0.0026664036),
   (r_D31_attr_bankruptcy_recency_d > 2) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 82.55) => -0.0518480101,
      (c_fammar_p > 82.55) => 0.0232506399,
      (c_fammar_p = NULL) => -0.0256707664, -0.0256707664),
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0014232877, -0.0002124581),
(c_rape > 195.5) => 
   map(
   (NULL < c_highinc and c_highinc <= 1.35) => -0.1416869439,
   (c_highinc > 1.35) => -0.0202490198,
   (c_highinc = NULL) => -0.0657882413, -0.0657882413),
(c_rape = NULL) => -0.0245632563, -0.0015270107);

// Tree: 204 
wFDN_FL_PS__lgt_204 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 198.5) => 
   map(
   (NULL < c_hval_1000k_p and c_hval_1000k_p <= 41.3) => 
      map(
      (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 1.5) => 0.0025968128,
      (r_S65_SSN_Problem_i > 1.5) => -0.0572028682,
      (r_S65_SSN_Problem_i = NULL) => 0.0011790514, 0.0011790514),
   (c_hval_1000k_p > 41.3) => 
      map(
      (NULL < c_hval_1000k_p and c_hval_1000k_p <= 49.45) => 0.2228596571,
      (c_hval_1000k_p > 49.45) => -0.0181275255,
      (c_hval_1000k_p = NULL) => 0.0873043669, 0.0873043669),
   (c_hval_1000k_p = NULL) => 0.0024580864, 0.0023139696),
(f_prevaddrcartheftindex_i > 198.5) => -0.1186956039,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 102.5) => 0.0364092864,
   (c_robbery > 102.5) => -0.0687878009,
   (c_robbery = NULL) => -0.0067042740, -0.0067042740), 0.0015566209);

// Tree: 205 
wFDN_FL_PS__lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5922.5) => 
   map(
   (NULL < f_varmsrcssncount_i and f_varmsrcssncount_i <= 0.5) => -0.0775205276,
   (f_varmsrcssncount_i > 0.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 17.5) => 
         map(
         (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2969.5) => 0.0036042824,
         (f_liens_unrel_SC_total_amt_i > 2969.5) => -0.0737269245,
         (f_liens_unrel_SC_total_amt_i = NULL) => 0.0028182683, 0.0028182683),
      (f_inq_HighRiskCredit_count_i > 17.5) => 0.0643209904,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0031218258, 0.0031218258),
   (f_varmsrcssncount_i = NULL) => 0.0021994248, 0.0021994248),
(f_liens_unrel_ST_total_amt_i > 5922.5) => 0.1574273521,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.25) => -0.0579586681,
   (c_pop_6_11_p > 8.25) => 0.0578388808,
   (c_pop_6_11_p = NULL) => -0.0023393730, -0.0023393730), 0.0027762875);

// Final Score Sum 

   wFDN_FL_PS__lgt := sum(
      wFDN_FL_PS__lgt_0, wFDN_FL_PS__lgt_1, wFDN_FL_PS__lgt_2, wFDN_FL_PS__lgt_3, wFDN_FL_PS__lgt_4, 
      wFDN_FL_PS__lgt_5, wFDN_FL_PS__lgt_6, wFDN_FL_PS__lgt_7, wFDN_FL_PS__lgt_8, wFDN_FL_PS__lgt_9, 
      wFDN_FL_PS__lgt_10, wFDN_FL_PS__lgt_11, wFDN_FL_PS__lgt_12, wFDN_FL_PS__lgt_13, wFDN_FL_PS__lgt_14, 
      wFDN_FL_PS__lgt_15, wFDN_FL_PS__lgt_16, wFDN_FL_PS__lgt_17, wFDN_FL_PS__lgt_18, wFDN_FL_PS__lgt_19, 
      wFDN_FL_PS__lgt_20, wFDN_FL_PS__lgt_21, wFDN_FL_PS__lgt_22, wFDN_FL_PS__lgt_23, wFDN_FL_PS__lgt_24, 
      wFDN_FL_PS__lgt_25, wFDN_FL_PS__lgt_26, wFDN_FL_PS__lgt_27, wFDN_FL_PS__lgt_28, wFDN_FL_PS__lgt_29, 
      wFDN_FL_PS__lgt_30, wFDN_FL_PS__lgt_31, wFDN_FL_PS__lgt_32, wFDN_FL_PS__lgt_33, wFDN_FL_PS__lgt_34, 
      wFDN_FL_PS__lgt_35, wFDN_FL_PS__lgt_36, wFDN_FL_PS__lgt_37, wFDN_FL_PS__lgt_38, wFDN_FL_PS__lgt_39, 
      wFDN_FL_PS__lgt_40, wFDN_FL_PS__lgt_41, wFDN_FL_PS__lgt_42, wFDN_FL_PS__lgt_43, wFDN_FL_PS__lgt_44, 
      wFDN_FL_PS__lgt_45, wFDN_FL_PS__lgt_46, wFDN_FL_PS__lgt_47, wFDN_FL_PS__lgt_48, wFDN_FL_PS__lgt_49, 
      wFDN_FL_PS__lgt_50, wFDN_FL_PS__lgt_51, wFDN_FL_PS__lgt_52, wFDN_FL_PS__lgt_53, wFDN_FL_PS__lgt_54, 
      wFDN_FL_PS__lgt_55, wFDN_FL_PS__lgt_56, wFDN_FL_PS__lgt_57, wFDN_FL_PS__lgt_58, wFDN_FL_PS__lgt_59, 
      wFDN_FL_PS__lgt_60, wFDN_FL_PS__lgt_61, wFDN_FL_PS__lgt_62, wFDN_FL_PS__lgt_63, wFDN_FL_PS__lgt_64, 
      wFDN_FL_PS__lgt_65, wFDN_FL_PS__lgt_66, wFDN_FL_PS__lgt_67, wFDN_FL_PS__lgt_68, wFDN_FL_PS__lgt_69, 
      wFDN_FL_PS__lgt_70, wFDN_FL_PS__lgt_71, wFDN_FL_PS__lgt_72, wFDN_FL_PS__lgt_73, wFDN_FL_PS__lgt_74, 
      wFDN_FL_PS__lgt_75, wFDN_FL_PS__lgt_76, wFDN_FL_PS__lgt_77, wFDN_FL_PS__lgt_78, wFDN_FL_PS__lgt_79, 
      wFDN_FL_PS__lgt_80, wFDN_FL_PS__lgt_81, wFDN_FL_PS__lgt_82, wFDN_FL_PS__lgt_83, wFDN_FL_PS__lgt_84, 
      wFDN_FL_PS__lgt_85, wFDN_FL_PS__lgt_86, wFDN_FL_PS__lgt_87, wFDN_FL_PS__lgt_88, wFDN_FL_PS__lgt_89, 
      wFDN_FL_PS__lgt_90, wFDN_FL_PS__lgt_91, wFDN_FL_PS__lgt_92, wFDN_FL_PS__lgt_93, wFDN_FL_PS__lgt_94, 
      wFDN_FL_PS__lgt_95, wFDN_FL_PS__lgt_96, wFDN_FL_PS__lgt_97, wFDN_FL_PS__lgt_98, wFDN_FL_PS__lgt_99, 
      wFDN_FL_PS__lgt_100, wFDN_FL_PS__lgt_101, wFDN_FL_PS__lgt_102, wFDN_FL_PS__lgt_103, wFDN_FL_PS__lgt_104, 
      wFDN_FL_PS__lgt_105, wFDN_FL_PS__lgt_106, wFDN_FL_PS__lgt_107, wFDN_FL_PS__lgt_108, wFDN_FL_PS__lgt_109, 
      wFDN_FL_PS__lgt_110, wFDN_FL_PS__lgt_111, wFDN_FL_PS__lgt_112, wFDN_FL_PS__lgt_113, wFDN_FL_PS__lgt_114, 
      wFDN_FL_PS__lgt_115, wFDN_FL_PS__lgt_116, wFDN_FL_PS__lgt_117, wFDN_FL_PS__lgt_118, wFDN_FL_PS__lgt_119, 
      wFDN_FL_PS__lgt_120, wFDN_FL_PS__lgt_121, wFDN_FL_PS__lgt_122, wFDN_FL_PS__lgt_123, wFDN_FL_PS__lgt_124, 
      wFDN_FL_PS__lgt_125, wFDN_FL_PS__lgt_126, wFDN_FL_PS__lgt_127, wFDN_FL_PS__lgt_128, wFDN_FL_PS__lgt_129, 
      wFDN_FL_PS__lgt_130, wFDN_FL_PS__lgt_131, wFDN_FL_PS__lgt_132, wFDN_FL_PS__lgt_133, wFDN_FL_PS__lgt_134, 
      wFDN_FL_PS__lgt_135, wFDN_FL_PS__lgt_136, wFDN_FL_PS__lgt_137, wFDN_FL_PS__lgt_138, wFDN_FL_PS__lgt_139, 
      wFDN_FL_PS__lgt_140, wFDN_FL_PS__lgt_141, wFDN_FL_PS__lgt_142, wFDN_FL_PS__lgt_143, wFDN_FL_PS__lgt_144, 
      wFDN_FL_PS__lgt_145, wFDN_FL_PS__lgt_146, wFDN_FL_PS__lgt_147, wFDN_FL_PS__lgt_148, wFDN_FL_PS__lgt_149, 
      wFDN_FL_PS__lgt_150, wFDN_FL_PS__lgt_151, wFDN_FL_PS__lgt_152, wFDN_FL_PS__lgt_153, wFDN_FL_PS__lgt_154, 
      wFDN_FL_PS__lgt_155, wFDN_FL_PS__lgt_156, wFDN_FL_PS__lgt_157, wFDN_FL_PS__lgt_158, wFDN_FL_PS__lgt_159, 
      wFDN_FL_PS__lgt_160, wFDN_FL_PS__lgt_161, wFDN_FL_PS__lgt_162, wFDN_FL_PS__lgt_163, wFDN_FL_PS__lgt_164, 
      wFDN_FL_PS__lgt_165, wFDN_FL_PS__lgt_166, wFDN_FL_PS__lgt_167, wFDN_FL_PS__lgt_168, wFDN_FL_PS__lgt_169, 
      wFDN_FL_PS__lgt_170, wFDN_FL_PS__lgt_171, wFDN_FL_PS__lgt_172, wFDN_FL_PS__lgt_173, wFDN_FL_PS__lgt_174, 
      wFDN_FL_PS__lgt_175, wFDN_FL_PS__lgt_176, wFDN_FL_PS__lgt_177, wFDN_FL_PS__lgt_178, wFDN_FL_PS__lgt_179, 
      wFDN_FL_PS__lgt_180, wFDN_FL_PS__lgt_181, wFDN_FL_PS__lgt_182, wFDN_FL_PS__lgt_183, wFDN_FL_PS__lgt_184, 
      wFDN_FL_PS__lgt_185, wFDN_FL_PS__lgt_186, wFDN_FL_PS__lgt_187, wFDN_FL_PS__lgt_188, wFDN_FL_PS__lgt_189, 
      wFDN_FL_PS__lgt_190, wFDN_FL_PS__lgt_191, wFDN_FL_PS__lgt_192, wFDN_FL_PS__lgt_193, wFDN_FL_PS__lgt_194, 
      wFDN_FL_PS__lgt_195, wFDN_FL_PS__lgt_196, wFDN_FL_PS__lgt_197, wFDN_FL_PS__lgt_198, wFDN_FL_PS__lgt_199, 
      wFDN_FL_PS__lgt_200, wFDN_FL_PS__lgt_201, wFDN_FL_PS__lgt_202, wFDN_FL_PS__lgt_203, wFDN_FL_PS__lgt_204, 
      wFDN_FL_PS__lgt_205); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FL_PS__lgt;
			
self.final_score_0	:= 	wFDN_FL_PS__lgt_0	;
self.final_score_1	:= 	wFDN_FL_PS__lgt_1	;
self.final_score_2	:= 	wFDN_FL_PS__lgt_2	;
self.final_score_3	:= 	wFDN_FL_PS__lgt_3	;
self.final_score_4	:= 	wFDN_FL_PS__lgt_4	;
self.final_score_5	:= 	wFDN_FL_PS__lgt_5	;
self.final_score_6	:= 	wFDN_FL_PS__lgt_6	;
self.final_score_7	:= 	wFDN_FL_PS__lgt_7	;
self.final_score_8	:= 	wFDN_FL_PS__lgt_8	;
self.final_score_9	:= 	wFDN_FL_PS__lgt_9	;
self.final_score_10	:= 	wFDN_FL_PS__lgt_10	;
self.final_score_11	:= 	wFDN_FL_PS__lgt_11	;
self.final_score_12	:= 	wFDN_FL_PS__lgt_12	;
self.final_score_13	:= 	wFDN_FL_PS__lgt_13	;
self.final_score_14	:= 	wFDN_FL_PS__lgt_14	;
self.final_score_15	:= 	wFDN_FL_PS__lgt_15	;
self.final_score_16	:= 	wFDN_FL_PS__lgt_16	;
self.final_score_17	:= 	wFDN_FL_PS__lgt_17	;
self.final_score_18	:= 	wFDN_FL_PS__lgt_18	;
self.final_score_19	:= 	wFDN_FL_PS__lgt_19	;
self.final_score_20	:= 	wFDN_FL_PS__lgt_20	;
self.final_score_21	:= 	wFDN_FL_PS__lgt_21	;
self.final_score_22	:= 	wFDN_FL_PS__lgt_22	;
self.final_score_23	:= 	wFDN_FL_PS__lgt_23	;
self.final_score_24	:= 	wFDN_FL_PS__lgt_24	;
self.final_score_25	:= 	wFDN_FL_PS__lgt_25	;
self.final_score_26	:= 	wFDN_FL_PS__lgt_26	;
self.final_score_27	:= 	wFDN_FL_PS__lgt_27	;
self.final_score_28	:= 	wFDN_FL_PS__lgt_28	;
self.final_score_29	:= 	wFDN_FL_PS__lgt_29	;
self.final_score_30	:= 	wFDN_FL_PS__lgt_30	;
self.final_score_31	:= 	wFDN_FL_PS__lgt_31	;
self.final_score_32	:= 	wFDN_FL_PS__lgt_32	;
self.final_score_33	:= 	wFDN_FL_PS__lgt_33	;
self.final_score_34	:= 	wFDN_FL_PS__lgt_34	;
self.final_score_35	:= 	wFDN_FL_PS__lgt_35	;
self.final_score_36	:= 	wFDN_FL_PS__lgt_36	;
self.final_score_37	:= 	wFDN_FL_PS__lgt_37	;
self.final_score_38	:= 	wFDN_FL_PS__lgt_38	;
self.final_score_39	:= 	wFDN_FL_PS__lgt_39	;
self.final_score_40	:= 	wFDN_FL_PS__lgt_40	;
self.final_score_41	:= 	wFDN_FL_PS__lgt_41	;
self.final_score_42	:= 	wFDN_FL_PS__lgt_42	;
self.final_score_43	:= 	wFDN_FL_PS__lgt_43	;
self.final_score_44	:= 	wFDN_FL_PS__lgt_44	;
self.final_score_45	:= 	wFDN_FL_PS__lgt_45	;
self.final_score_46	:= 	wFDN_FL_PS__lgt_46	;
self.final_score_47	:= 	wFDN_FL_PS__lgt_47	;
self.final_score_48	:= 	wFDN_FL_PS__lgt_48	;
self.final_score_49	:= 	wFDN_FL_PS__lgt_49	;
self.final_score_50	:= 	wFDN_FL_PS__lgt_50	;
self.final_score_51	:= 	wFDN_FL_PS__lgt_51	;
self.final_score_52	:= 	wFDN_FL_PS__lgt_52	;
self.final_score_53	:= 	wFDN_FL_PS__lgt_53	;
self.final_score_54	:= 	wFDN_FL_PS__lgt_54	;
self.final_score_55	:= 	wFDN_FL_PS__lgt_55	;
self.final_score_56	:= 	wFDN_FL_PS__lgt_56	;
self.final_score_57	:= 	wFDN_FL_PS__lgt_57	;
self.final_score_58	:= 	wFDN_FL_PS__lgt_58	;
self.final_score_59	:= 	wFDN_FL_PS__lgt_59	;
self.final_score_60	:= 	wFDN_FL_PS__lgt_60	;
self.final_score_61	:= 	wFDN_FL_PS__lgt_61	;
self.final_score_62	:= 	wFDN_FL_PS__lgt_62	;
self.final_score_63	:= 	wFDN_FL_PS__lgt_63	;
self.final_score_64	:= 	wFDN_FL_PS__lgt_64	;
self.final_score_65	:= 	wFDN_FL_PS__lgt_65	;
self.final_score_66	:= 	wFDN_FL_PS__lgt_66	;
self.final_score_67	:= 	wFDN_FL_PS__lgt_67	;
self.final_score_68	:= 	wFDN_FL_PS__lgt_68	;
self.final_score_69	:= 	wFDN_FL_PS__lgt_69	;
self.final_score_70	:= 	wFDN_FL_PS__lgt_70	;
self.final_score_71	:= 	wFDN_FL_PS__lgt_71	;
self.final_score_72	:= 	wFDN_FL_PS__lgt_72	;
self.final_score_73	:= 	wFDN_FL_PS__lgt_73	;
self.final_score_74	:= 	wFDN_FL_PS__lgt_74	;
self.final_score_75	:= 	wFDN_FL_PS__lgt_75	;
self.final_score_76	:= 	wFDN_FL_PS__lgt_76	;
self.final_score_77	:= 	wFDN_FL_PS__lgt_77	;
self.final_score_78	:= 	wFDN_FL_PS__lgt_78	;
self.final_score_79	:= 	wFDN_FL_PS__lgt_79	;
self.final_score_80	:= 	wFDN_FL_PS__lgt_80	;
self.final_score_81	:= 	wFDN_FL_PS__lgt_81	;
self.final_score_82	:= 	wFDN_FL_PS__lgt_82	;
self.final_score_83	:= 	wFDN_FL_PS__lgt_83	;
self.final_score_84	:= 	wFDN_FL_PS__lgt_84	;
self.final_score_85	:= 	wFDN_FL_PS__lgt_85	;
self.final_score_86	:= 	wFDN_FL_PS__lgt_86	;
self.final_score_87	:= 	wFDN_FL_PS__lgt_87	;
self.final_score_88	:= 	wFDN_FL_PS__lgt_88	;
self.final_score_89	:= 	wFDN_FL_PS__lgt_89	;
self.final_score_90	:= 	wFDN_FL_PS__lgt_90	;
self.final_score_91	:= 	wFDN_FL_PS__lgt_91	;
self.final_score_92	:= 	wFDN_FL_PS__lgt_92	;
self.final_score_93	:= 	wFDN_FL_PS__lgt_93	;
self.final_score_94	:= 	wFDN_FL_PS__lgt_94	;
self.final_score_95	:= 	wFDN_FL_PS__lgt_95	;
self.final_score_96	:= 	wFDN_FL_PS__lgt_96	;
self.final_score_97	:= 	wFDN_FL_PS__lgt_97	;
self.final_score_98	:= 	wFDN_FL_PS__lgt_98	;
self.final_score_99	:= 	wFDN_FL_PS__lgt_99	;
self.final_score_100	:= 	wFDN_FL_PS__lgt_100	;
self.final_score_101	:= 	wFDN_FL_PS__lgt_101	;
self.final_score_102	:= 	wFDN_FL_PS__lgt_102	;
self.final_score_103	:= 	wFDN_FL_PS__lgt_103	;
self.final_score_104	:= 	wFDN_FL_PS__lgt_104	;
self.final_score_105	:= 	wFDN_FL_PS__lgt_105	;
self.final_score_106	:= 	wFDN_FL_PS__lgt_106	;
self.final_score_107	:= 	wFDN_FL_PS__lgt_107	;
self.final_score_108	:= 	wFDN_FL_PS__lgt_108	;
self.final_score_109	:= 	wFDN_FL_PS__lgt_109	;
self.final_score_110	:= 	wFDN_FL_PS__lgt_110	;
self.final_score_111	:= 	wFDN_FL_PS__lgt_111	;
self.final_score_112	:= 	wFDN_FL_PS__lgt_112	;
self.final_score_113	:= 	wFDN_FL_PS__lgt_113	;
self.final_score_114	:= 	wFDN_FL_PS__lgt_114	;
self.final_score_115	:= 	wFDN_FL_PS__lgt_115	;
self.final_score_116	:= 	wFDN_FL_PS__lgt_116	;
self.final_score_117	:= 	wFDN_FL_PS__lgt_117	;
self.final_score_118	:= 	wFDN_FL_PS__lgt_118	;
self.final_score_119	:= 	wFDN_FL_PS__lgt_119	;
self.final_score_120	:= 	wFDN_FL_PS__lgt_120	;
self.final_score_121	:= 	wFDN_FL_PS__lgt_121	;
self.final_score_122	:= 	wFDN_FL_PS__lgt_122	;
self.final_score_123	:= 	wFDN_FL_PS__lgt_123	;
self.final_score_124	:= 	wFDN_FL_PS__lgt_124	;
self.final_score_125	:= 	wFDN_FL_PS__lgt_125	;
self.final_score_126	:= 	wFDN_FL_PS__lgt_126	;
self.final_score_127	:= 	wFDN_FL_PS__lgt_127	;
self.final_score_128	:= 	wFDN_FL_PS__lgt_128	;
self.final_score_129	:= 	wFDN_FL_PS__lgt_129	;
self.final_score_130	:= 	wFDN_FL_PS__lgt_130	;
self.final_score_131	:= 	wFDN_FL_PS__lgt_131	;
self.final_score_132	:= 	wFDN_FL_PS__lgt_132	;
self.final_score_133	:= 	wFDN_FL_PS__lgt_133	;
self.final_score_134	:= 	wFDN_FL_PS__lgt_134	;
self.final_score_135	:= 	wFDN_FL_PS__lgt_135	;
self.final_score_136	:= 	wFDN_FL_PS__lgt_136	;
self.final_score_137	:= 	wFDN_FL_PS__lgt_137	;
self.final_score_138	:= 	wFDN_FL_PS__lgt_138	;
self.final_score_139	:= 	wFDN_FL_PS__lgt_139	;
self.final_score_140	:= 	wFDN_FL_PS__lgt_140	;
self.final_score_141	:= 	wFDN_FL_PS__lgt_141	;
self.final_score_142	:= 	wFDN_FL_PS__lgt_142	;
self.final_score_143	:= 	wFDN_FL_PS__lgt_143	;
self.final_score_144	:= 	wFDN_FL_PS__lgt_144	;
self.final_score_145	:= 	wFDN_FL_PS__lgt_145	;
self.final_score_146	:= 	wFDN_FL_PS__lgt_146	;
self.final_score_147	:= 	wFDN_FL_PS__lgt_147	;
self.final_score_148	:= 	wFDN_FL_PS__lgt_148	;
self.final_score_149	:= 	wFDN_FL_PS__lgt_149	;
self.final_score_150	:= 	wFDN_FL_PS__lgt_150	;
self.final_score_151	:= 	wFDN_FL_PS__lgt_151	;
self.final_score_152	:= 	wFDN_FL_PS__lgt_152	;
self.final_score_153	:= 	wFDN_FL_PS__lgt_153	;
self.final_score_154	:= 	wFDN_FL_PS__lgt_154	;
self.final_score_155	:= 	wFDN_FL_PS__lgt_155	;
self.final_score_156	:= 	wFDN_FL_PS__lgt_156	;
self.final_score_157	:= 	wFDN_FL_PS__lgt_157	;
self.final_score_158	:= 	wFDN_FL_PS__lgt_158	;
self.final_score_159	:= 	wFDN_FL_PS__lgt_159	;
self.final_score_160	:= 	wFDN_FL_PS__lgt_160	;
self.final_score_161	:= 	wFDN_FL_PS__lgt_161	;
self.final_score_162	:= 	wFDN_FL_PS__lgt_162	;
self.final_score_163	:= 	wFDN_FL_PS__lgt_163	;
self.final_score_164	:= 	wFDN_FL_PS__lgt_164	;
self.final_score_165	:= 	wFDN_FL_PS__lgt_165	;
self.final_score_166	:= 	wFDN_FL_PS__lgt_166	;
self.final_score_167	:= 	wFDN_FL_PS__lgt_167	;
self.final_score_168	:= 	wFDN_FL_PS__lgt_168	;
self.final_score_169	:= 	wFDN_FL_PS__lgt_169	;
self.final_score_170	:= 	wFDN_FL_PS__lgt_170	;
self.final_score_171	:= 	wFDN_FL_PS__lgt_171	;
self.final_score_172	:= 	wFDN_FL_PS__lgt_172	;
self.final_score_173	:= 	wFDN_FL_PS__lgt_173	;
self.final_score_174	:= 	wFDN_FL_PS__lgt_174	;
self.final_score_175	:= 	wFDN_FL_PS__lgt_175	;
self.final_score_176	:= 	wFDN_FL_PS__lgt_176	;
self.final_score_177	:= 	wFDN_FL_PS__lgt_177	;
self.final_score_178	:= 	wFDN_FL_PS__lgt_178	;
self.final_score_179	:= 	wFDN_FL_PS__lgt_179	;
self.final_score_180	:= 	wFDN_FL_PS__lgt_180	;
self.final_score_181	:= 	wFDN_FL_PS__lgt_181	;
self.final_score_182	:= 	wFDN_FL_PS__lgt_182	;
self.final_score_183	:= 	wFDN_FL_PS__lgt_183	;
self.final_score_184	:= 	wFDN_FL_PS__lgt_184	;
self.final_score_185	:= 	wFDN_FL_PS__lgt_185	;
self.final_score_186	:= 	wFDN_FL_PS__lgt_186	;
self.final_score_187	:= 	wFDN_FL_PS__lgt_187	;
self.final_score_188	:= 	wFDN_FL_PS__lgt_188	;
self.final_score_189	:= 	wFDN_FL_PS__lgt_189	;
self.final_score_190	:= 	wFDN_FL_PS__lgt_190	;
self.final_score_191	:= 	wFDN_FL_PS__lgt_191	;
self.final_score_192	:= 	wFDN_FL_PS__lgt_192	;
self.final_score_193	:= 	wFDN_FL_PS__lgt_193	;
self.final_score_194	:= 	wFDN_FL_PS__lgt_194	;
self.final_score_195	:= 	wFDN_FL_PS__lgt_195	;
self.final_score_196	:= 	wFDN_FL_PS__lgt_196	;
self.final_score_197	:= 	wFDN_FL_PS__lgt_197	;
self.final_score_198	:= 	wFDN_FL_PS__lgt_198	;
self.final_score_199	:= 	wFDN_FL_PS__lgt_199	;
self.final_score_200	:= 	wFDN_FL_PS__lgt_200	;
self.final_score_201	:= 	wFDN_FL_PS__lgt_201	;
self.final_score_202	:= 	wFDN_FL_PS__lgt_202	;
self.final_score_203	:= 	wFDN_FL_PS__lgt_203	;
self.final_score_204	:= 	wFDN_FL_PS__lgt_204	;
self.final_score_205	:= 	wFDN_FL_PS__lgt_205	;
// self.wFDN_submodel_lgt	:= 	wFDN_FL_PS__lgt	;
self.FP3_wFDN_LGT		:= 	wFDN_FL_PS__lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
