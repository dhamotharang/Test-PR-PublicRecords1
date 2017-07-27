
export FP3FDN1505_FLAD( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLA__D_lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FLA__D_lgt_1 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 0.4560654069,
(nf_vf_hi_risk_index > 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
         map(
         (NULL < c_unemp and c_unemp <= 9.15) => 0.0769992562,
         (c_unemp > 9.15) => 0.4730026014,
         (c_unemp = NULL) => -0.0073649771, 0.0967464914),
      (r_F01_inp_addr_address_score_d > 95) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0402730837,
         (f_varrisktype_i > 3.5) => 0.1272696527,
         (f_varrisktype_i = NULL) => -0.0339877029, -0.0339877029),
      (r_F01_inp_addr_address_score_d = NULL) => -0.0213441426, -0.0213441426),
   (f_inq_HighRiskCredit_count_i > 2.5) => 0.2653824877,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0133542047, -0.0133542047),
(nf_vf_hi_risk_index = NULL) => 0.2096712380, -0.0017012320);

// Tree: 2 
wFDN_FLA__D_lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1362941490,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0374017159,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1737803611,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0327446854, -0.0327446854),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0232523169, -0.0232523169),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0494296491,
   (f_rel_under500miles_cnt_d > 5.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.1855948438,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.4653345184,
      (nf_seg_FraudPoint_3_0 = '') => 0.3410884395, 0.3410884395),
   (f_rel_under500miles_cnt_d = NULL) => 0.0974682921, 0.2062813678),
(f_varrisktype_i = NULL) => 0.1325655406, -0.0079256346);

// Tree: 3 
wFDN_FLA__D_lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.3400164860,
      (r_F01_inp_addr_address_score_d > 75) => 
         map(
         (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => 0.0480355248,
         (f_inq_Collection_count24_i > 1.5) => 0.3663426419,
         (f_inq_Collection_count24_i = NULL) => 0.0747118315, 0.0747118315),
      (r_F01_inp_addr_address_score_d = NULL) => 0.1065483900, 0.1065483900),
   (nf_vf_hi_risk_hit_type > 3.5) => -0.0238545443,
   (nf_vf_hi_risk_hit_type = NULL) => -0.0152013466, -0.0152013466),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1062506430,
   (f_srchvelocityrisktype_i > 4.5) => 0.3669226939,
   (f_srchvelocityrisktype_i = NULL) => 0.2121670519, 0.2121670519),
(f_inq_Communications_count_i = NULL) => 0.1160023766, -0.0054922384);

// Tree: 4 
wFDN_FLA__D_lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 50.45) => 0.1041007148,
   (c_fammar_p > 50.45) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0355291822,
         (f_srchvelocityrisktype_i > 4.5) => 0.0527814267,
         (f_srchvelocityrisktype_i = NULL) => -0.0261054001, -0.0261054001),
      (f_assocsuspicousidcount_i > 15.5) => 0.3998216502,
      (f_assocsuspicousidcount_i = NULL) => -0.0239354661, -0.0239354661),
   (c_fammar_p = NULL) => -0.0333950176, -0.0142520817),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < nf_vf_type and nf_vf_type <= 2.5) => 0.1548226798,
   (nf_vf_type > 2.5) => 0.3105860758,
   (nf_vf_type = NULL) => 0.1858797986, 0.1858797986),
(f_srchfraudsrchcount_i = NULL) => 0.1159769979, -0.0071581504);

// Tree: 5 
wFDN_FLA__D_lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.35) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0549867645,
      (f_rel_felony_count_i > 2.5) => 0.3697179831,
      (f_rel_felony_count_i = NULL) => 0.0666434763, 0.0666434763),
   (c_fammar_p > 59.35) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.3368393588,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0316514922,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0295399068, -0.0295399068),
   (c_fammar_p = NULL) => -0.0243547814, -0.0164257909),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.2027173784,
   (r_I60_inq_comm_recency_d > 549) => 0.0529321039,
   (r_I60_inq_comm_recency_d = NULL) => 0.0912587158, 0.0912587158),
(f_srchvelocityrisktype_i = NULL) => 0.0736380757, -0.0056665169);

// Tree: 6 
wFDN_FLA__D_lgt_6 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 65) => 0.0749345263,
   (r_F01_inp_addr_address_score_d > 65) => -0.0278267401,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0216186451, -0.0216186451),
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 35) => 0.2570555459,
         (r_F01_inp_addr_address_score_d > 35) => 0.0202009256,
         (r_F01_inp_addr_address_score_d = NULL) => 0.0395517933, 0.0395517933),
      (r_D33_eviction_count_i > 0.5) => 0.2971057271,
      (r_D33_eviction_count_i = NULL) => 0.0634511712, 0.0634511712),
   (f_inq_HighRiskCredit_count_i > 1.5) => 0.1978200537,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0847671650, 0.0847671650),
(f_inq_Communications_count_i = NULL) => 0.0661236867, -0.0102344442);

// Tree: 7 
wFDN_FLA__D_lgt_7 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.2349906531,
   (r_F01_inp_addr_address_score_d > 75) => 0.0672925393,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0882081170, 0.0882081170),
(nf_vf_hi_risk_index > 6) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0327693152,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 0.0280003456,
      (f_inq_Communications_count_i > 1.5) => 0.1519485309,
      (f_inq_Communications_count_i = NULL) => 0.0354010097, 0.0354010097),
   (nf_seg_FraudPoint_3_0 = '') => -0.0186896387, -0.0186896387),
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.031302406) => -0.0286435698,
   (f_add_input_nhood_VAC_pct_i > 0.031302406) => 0.2219272195,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0531216351, 0.0531216351), -0.0100380641);

// Tree: 8 
wFDN_FLA__D_lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0672286975,
      (f_rel_felony_count_i > 1.5) => 0.3008305838,
      (f_rel_felony_count_i = NULL) => 0.0881841609, 0.0881841609),
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0300430789,
      (r_D33_eviction_count_i > 2.5) => 0.1960712785,
      (r_D33_eviction_count_i = NULL) => -0.0282079103, -0.0282079103),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0211114691, -0.0211114691),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0430409320,
   (f_rel_felony_count_i > 0.5) => 0.1860475331,
   (f_rel_felony_count_i = NULL) => 0.0702802846, 0.0702802846),
(f_varrisktype_i = NULL) => 0.0355224165, -0.0106157747);

// Tree: 9 
wFDN_FLA__D_lgt_9 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1495833765,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1543386122,
      (r_F01_inp_addr_address_score_d > 75) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 0.0257494922,
         (r_D30_Derog_Count_i > 5.5) => 0.2038870143,
         (r_D30_Derog_Count_i = NULL) => 0.0380309533, 0.0380309533),
      (r_F01_inp_addr_address_score_d = NULL) => 0.0508594851, 0.0508594851),
   (c_fammar_p > 59.25) => -0.0222667917,
   (c_fammar_p = NULL) => -0.0396937866, -0.0119328644),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 99.5) => 0.0183594215,
   (c_assault > 99.5) => 0.1917320510,
   (c_assault = NULL) => 0.0870929492, 0.0870929492), -0.0057565055);

// Tree: 10 
wFDN_FLA__D_lgt_10 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0189837875,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
         map(
         (NULL < c_business and c_business <= 4.5) => 0.1986795031,
         (c_business > 4.5) => 0.0205672660,
         (c_business = NULL) => 0.0451449341, 0.0451449341),
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1660132368,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0564272088, 0.0564272088),
   (k_inq_per_addr_i = NULL) => -0.0108716745, -0.0108716745),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.1044150941,
   (f_rel_felony_count_i > 1.5) => 0.2774706773,
   (f_rel_felony_count_i = NULL) => 0.1316373207, 0.1316373207),
(f_inq_PrepaidCards_count_i = NULL) => 0.0406227373, -0.0061455648);

// Tree: 11 
wFDN_FLA__D_lgt_11 := map(
(NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2845270056,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => -0.0206451721,
      (k_inq_ssns_per_addr_i > 2.5) => 0.0979357042,
      (k_inq_ssns_per_addr_i = NULL) => -0.0158080276, -0.0158080276),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0141512528, -0.0141512528),
(f_inq_Communications_count24_i > 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.15) => 0.0721345017,
   (c_unemp > 9.15) => 0.1961247919,
   (c_unemp = NULL) => 0.0863942546, 0.0863942546),
(f_inq_Communications_count24_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.45) => -0.0438888272,
   (c_pop_35_44_p > 13.45) => 0.1294388707,
   (c_pop_35_44_p = NULL) => 0.0677853942, 0.0677853942), -0.0072569599);

// Tree: 12 
wFDN_FLA__D_lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 109.5) => 0.1152352665,
      (c_ab_av_edu > 109.5) => 0.0038777464,
      (c_ab_av_edu = NULL) => -0.0212182308, 0.0543373875),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1785311252,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0207906939,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0198420636, -0.0198420636),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0125618847, -0.0125618847),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 0.1594446879,
   (f_mos_inq_banko_om_fseen_d > 36.5) => 0.0443783431,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0917399049, 0.0917399049),
(f_srchfraudsrchcount_i = NULL) => 0.0300800002, -0.0089231224);

// Tree: 13 
wFDN_FLA__D_lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1249890318,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0582367076,
      (c_fammar_p > 51.45) => 
         map(
         (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 0.0476101975,
         (r_nas_addr_verd_d > 0.5) => -0.0252505287,
         (r_nas_addr_verd_d = NULL) => -0.0209324111, -0.0209324111),
      (c_fammar_p = NULL) => -0.0516237846, -0.0152521293),
   (r_D33_Eviction_Recency_d = NULL) => -0.0126691270, -0.0126691270),
(f_assocsuspicousidcount_i > 13.5) => 0.1877551557,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 71.6) => 0.1585452191,
   (c_fammar_p > 71.6) => -0.0151804870,
   (c_fammar_p = NULL) => 0.0512115026, 0.0512115026), -0.0099117833);

// Tree: 14 
wFDN_FLA__D_lgt_14 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0351127390,
   (r_C23_inp_addr_occ_index_d > 2) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 36562.5) => 0.2086142065,
      (f_curraddrmedianincome_d > 36562.5) => 0.0731251822,
      (f_curraddrmedianincome_d = NULL) => 0.1110940828, 0.1110940828),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0619436510, 0.0619436510),
(nf_vf_hi_risk_index > 6) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => -0.0161214528,
   (f_inq_PrepaidCards_count_i > 0.5) => 0.0920175207,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0136656661, -0.0136656661),
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0771587641,
   (c_construction > 7.45) => -0.0386009303,
   (c_construction = NULL) => 0.0286143761, 0.0286143761), -0.0073143124);

// Tree: 15 
wFDN_FLA__D_lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.05) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0780057494,
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.2219001560,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0921592975, 0.0921592975),
   (r_F03_address_match_d > 3) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 481.5) => 0.0782229089,
      (c_hh00 > 481.5) => -0.0167655893,
      (c_hh00 = NULL) => 0.0244821715, 0.0244821715),
   (r_F03_address_match_d = NULL) => 0.0468302776, 0.0468302776),
(c_fammar_p > 61.05) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => -0.0221244223,
   (f_srchfraudsrchcount_i > 12.5) => 0.0889598318,
   (f_srchfraudsrchcount_i = NULL) => 0.0424632769, -0.0199071169),
(c_fammar_p = NULL) => -0.0388821429, -0.0095076371);

// Tree: 16 
wFDN_FLA__D_lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
         map(
         (NULL < nf_vf_type and nf_vf_type <= 1.5) => 0.0154908723,
         (nf_vf_type > 1.5) => 0.1260086920,
         (nf_vf_type = NULL) => 0.0203135907, 0.0203135907),
      (f_corraddrnamecount_d > 4.5) => -0.0261203488,
      (f_corraddrnamecount_d = NULL) => -0.0128436696, -0.0128436696),
   (f_srchvelocityrisktype_i > 6.5) => 0.0710400053,
   (f_srchvelocityrisktype_i = NULL) => -0.0098647156, -0.0098647156),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 0.1823612423,
   (nf_vf_hi_risk_hit_type > 3.5) => 0.0772578342,
   (nf_vf_hi_risk_hit_type = NULL) => 0.0906933831, 0.0906933831),
(r_D30_Derog_Count_i = NULL) => 0.0122555987, -0.0046447674);

// Tree: 17 
wFDN_FLA__D_lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 22500) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 78.5) => 0.1595432632,
      (c_rest_indx > 78.5) => 0.0174351663,
      (c_rest_indx = NULL) => 0.0538148391, 0.0538148391),
   (k_estimated_income_d > 22500) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0646295379,
      (r_D33_Eviction_Recency_d > 549) => -0.0291688722,
      (r_D33_Eviction_Recency_d = NULL) => -0.0258465084, -0.0258465084),
   (k_estimated_income_d = NULL) => -0.0182105583, -0.0209765738),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0309295088,
   (f_hh_payday_loan_users_i > 0.5) => 0.1262744574,
   (f_hh_payday_loan_users_i = NULL) => 0.0465790412, 0.0465790412),
(k_inq_per_addr_i = NULL) => -0.0135313432, -0.0135313432);

// Tree: 18 
wFDN_FLA__D_lgt_18 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => -0.0157713612,
(f_crim_rel_under500miles_cnt_i > 2.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 0.0889789674,
      (k_estimated_income_d > 32500) => -0.0020452793,
      (k_estimated_income_d = NULL) => 0.0142496863, 0.0142496863),
   (f_phones_per_addr_curr_i > 9.5) => 0.1207933777,
   (f_phones_per_addr_curr_i = NULL) => 0.0269444321, 0.0269444321),
(f_crim_rel_under500miles_cnt_i = NULL) => 
   map(
   (NULL < c_child and c_child <= 22.65) => -0.0215294305,
   (c_child > 22.65) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.1981949500,
      (k_nap_lname_verd_d > 0.5) => 0.0322969926,
      (k_nap_lname_verd_d = NULL) => 0.0936446748, 0.0936446748),
   (c_child = NULL) => 0.0368173458, 0.0368173458), -0.0054584958);

// Tree: 19 
wFDN_FLA__D_lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
      map(
      (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.2468267950,
      (f_hh_age_18_plus_d > 0.5) => -0.0094510066,
      (f_hh_age_18_plus_d = NULL) => -0.0081224047, -0.0081224047),
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 34.5) => 0.1425153812,
      (r_D32_Mos_Since_Crim_LS_d > 34.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 21.5) => 0.0240622828,
         (f_rel_under25miles_cnt_d > 21.5) => 0.1462320184,
         (f_rel_under25miles_cnt_d = NULL) => 0.0301017471, 0.0301017471),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0387765237, 0.0387765237),
   (f_srchvelocityrisktype_i = NULL) => -0.0021775770, -0.0021775770),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1362731406,
(f_inq_PrepaidCards_count_i = NULL) => 0.0036574950, -0.0006422259);

// Tree: 20 
wFDN_FLA__D_lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0172451991,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 2) => 0.0215981931,
      (f_idverrisktype_i > 2) => 0.1383133531,
      (f_idverrisktype_i = NULL) => 0.0514351513, 0.0514351513),
   (k_inq_per_addr_i = NULL) => -0.0106730350, -0.0106730350),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 5.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 37) => 0.1699802055,
      (c_fammar_p > 37) => 0.0340578991,
      (c_fammar_p = NULL) => 0.0411417978, 0.0411417978),
   (r_L79_adls_per_addr_c6_i > 5.5) => 0.1651261027,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0519033823, 0.0519033823),
(f_varrisktype_i = NULL) => 0.0069485904, -0.0036388620);

// Tree: 21 
wFDN_FLA__D_lgt_21 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => -0.0206774490,
   (f_srchaddrsrchcount_i > 4.5) => 
      map(
      (NULL < c_professional and c_professional <= 1.65) => 0.0680984375,
      (c_professional > 1.65) => -0.0010328709,
      (c_professional = NULL) => 0.0235749553, 0.0235749553),
   (f_srchaddrsrchcount_i = NULL) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 82.5) => 0.0597714847,
      (c_born_usa > 82.5) => -0.0752188123,
      (c_born_usa = NULL) => -0.0021761173, -0.0021761173), -0.0130572169),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 82096.5) => 0.1996310659,
   (r_L80_Inp_AVM_AutoVal_d > 82096.5) => 0.0639103275,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0358391952, 0.0595521891),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0094224536, -0.0094224536);

// Tree: 22 
wFDN_FLA__D_lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0238020866,
   (f_hh_lienholders_i > 0.5) => 0.0230434973,
   (f_hh_lienholders_i = NULL) => -0.0097271395, -0.0097271395),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.1944243559,
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.1388061830,
      (r_D33_Eviction_Recency_d > 549) => 0.0456440193,
      (r_D33_Eviction_Recency_d = NULL) => 0.0592732988, 0.0592732988),
   (r_C12_source_profile_index_d = NULL) => 0.0735939406, 0.0735939406),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 60.5) => -0.0690634841,
   (c_bel_edu > 60.5) => 0.0569227366,
   (c_bel_edu = NULL) => 0.0074557542, 0.0074557542), -0.0055037655);

// Tree: 23 
wFDN_FLA__D_lgt_23 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < c_employees and c_employees <= 50) => 0.3211159717,
   (c_employees > 50) => 0.0895995824,
   (c_employees = NULL) => 0.1344355029, 0.1344355029),
(r_F00_dob_score_d > 92) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 55.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.0959712749,
         (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0191791979,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0167152627, -0.0167152627),
      (f_addrchangecrimediff_i > 55.5) => 0.0863043412,
      (f_addrchangecrimediff_i = NULL) => 0.0104843935, -0.0092321385),
   (r_D33_eviction_count_i > 3.5) => 0.1331845442,
   (r_D33_eviction_count_i = NULL) => -0.0082505395, -0.0082505395),
(r_F00_dob_score_d = NULL) => -0.0015794683, -0.0043179486);

// Tree: 24 
wFDN_FLA__D_lgt_24 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.1797100842,
(r_D32_Mos_Since_Fel_LS_d > 127.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 90.5) => -0.0067392627,
   (r_pb_order_freq_d > 90.5) => -0.0405738072,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 4.5) => 0.0086192767,
      (f_rel_criminal_count_i > 4.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 0.2098881412,
         (r_C12_Num_NonDerogs_d > 1.5) => 0.0625150368,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0837160799, 0.0837160799),
      (f_rel_criminal_count_i = NULL) => 0.0176843292, 0.0176843292), -0.0062637508),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 14.95) => -0.0260576288,
   (c_hh4_p > 14.95) => 0.1005360673,
   (c_hh4_p = NULL) => 0.0230807138, 0.0230807138), -0.0046575050);

// Tree: 25 
wFDN_FLA__D_lgt_25 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0165971945,
(f_assocrisktype_i > 3.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 24.85) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1258047602) => 0.0092309009,
      (f_add_curr_nhood_BUS_pct_i > 0.1258047602) => 0.1065637495,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0402072554, 0.0233655507),
   (c_famotf18_p > 24.85) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 19.5) => 0.1804972751,
      (f_prevaddrlenofres_d > 19.5) => 0.0501507629,
      (f_prevaddrlenofres_d = NULL) => 0.0865538429, 0.0865538429),
   (c_famotf18_p = NULL) => -0.0098638796, 0.0317031344),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.6) => -0.0460482677,
   (c_pop_35_44_p > 15.6) => 0.0865111022,
   (c_pop_35_44_p = NULL) => 0.0149988105, 0.0149988105), -0.0044213584);

// Tree: 26 
wFDN_FLA__D_lgt_26 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 27.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -48691.5) => 0.0699136976,
      (f_addrchangevaluediff_d > -48691.5) => -0.0162852686,
      (f_addrchangevaluediff_d = NULL) => 0.0101094453, -0.0091034232),
   (r_D30_Derog_Count_i > 11.5) => 0.1069671775,
   (r_D30_Derog_Count_i = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => -0.1032712484,
      (k_comb_age_d > 26.5) => 0.0483132220,
      (k_comb_age_d = NULL) => -0.0107005795, -0.0107005795), -0.0076774755),
(c_famotf18_p > 27.05) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 0.0771892306,
   (k_estimated_income_d > 36500) => 0.0086453176,
   (k_estimated_income_d = NULL) => 0.0452588364, 0.0452588364),
(c_famotf18_p = NULL) => -0.0078634424, -0.0028700058);

// Tree: 27 
wFDN_FLA__D_lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 0.0329815366,
   (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 
      map(
      (NULL < c_preschl and c_preschl <= 123) => 0.2383179217,
      (c_preschl > 123) => 0.0405104749,
      (c_preschl = NULL) => 0.1476036786, 0.1476036786),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0504530670, 0.0504530670),
(c_fammar_p > 50.45) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','6: Other']) => -0.0468868400,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.1000845126,
      (r_D33_Eviction_Recency_d > 48) => 0.0066252491,
      (r_D33_Eviction_Recency_d = NULL) => 0.0067703873, 0.0081932577),
   (nf_seg_FraudPoint_3_0 = '') => -0.0118636356, -0.0118636356),
(c_fammar_p = NULL) => -0.0216718248, -0.0069456640);

// Tree: 28 
wFDN_FLA__D_lgt_28 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1143280487,
   (r_F00_dob_score_d > 92) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.1450330245,
         (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0121574031,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0113467891, -0.0113467891),
      (r_D33_eviction_count_i > 2.5) => 0.0981340936,
      (r_D33_eviction_count_i = NULL) => -0.0101542075, -0.0101542075),
   (r_F00_dob_score_d = NULL) => 0.0068635894, -0.0065266492),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.0917849545,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 99.5) => -0.0384643445,
   (c_burglary > 99.5) => 0.0944738027,
   (c_burglary = NULL) => 0.0207093430, 0.0207093430), -0.0047219830);

// Tree: 29 
wFDN_FLA__D_lgt_29 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1760328305,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0097861595,
      (k_comb_age_d > 68.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 2.25) => 0.2113373007,
         (C_INC_150K_P > 2.25) => 0.0464751184,
         (C_INC_150K_P = NULL) => 0.0711074680, 0.0711074680),
      (k_comb_age_d = NULL) => -0.0040854704, -0.0040854704),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1162534044,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0035342999, -0.0035342999),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 75.5) => -0.0876788752,
   (c_unempl > 75.5) => 0.0493979620,
   (c_unempl = NULL) => -0.0035241080, -0.0035241080), -0.0027838889);

// Tree: 30 
wFDN_FLA__D_lgt_30 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0118742581,
   (f_srchaddrsrchcount_i > 14.5) => 0.0546953065,
   (f_srchaddrsrchcount_i = NULL) => -0.0098292533, -0.0098292533),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < f_inq_Banking_count_i and f_inq_Banking_count_i <= 2.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 43318) => 0.1025033446,
      (f_curraddrmedianincome_d > 43318) => -0.0396945042,
      (f_curraddrmedianincome_d = NULL) => 0.0096287349, 0.0096287349),
   (f_inq_Banking_count_i > 2.5) => 0.1425433290,
   (f_inq_Banking_count_i = NULL) => 0.0419292089, 0.0419292089),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.7) => 0.0693283498,
   (c_construction > 4.7) => -0.0389723580,
   (c_construction = NULL) => 0.0075414075, 0.0075414075), -0.0081151736);

// Tree: 31 
wFDN_FLA__D_lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.35) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1244821718,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0125877839,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0119376086, -0.0119376086),
      (k_comb_age_d > 68.5) => 0.0712343882,
      (k_comb_age_d = NULL) => -0.0058802233, -0.0058802233),
   (c_unemp > 8.35) => 0.0518335539,
   (c_unemp = NULL) => -0.0290938881, -0.0024876402),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1557087076,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 105) => -0.0345013082,
   (c_assault > 105) => 0.0784079305,
   (c_assault = NULL) => 0.0073723168, 0.0073723168), -0.0016852028);

// Tree: 32 
wFDN_FLA__D_lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.255) => -0.0105889058,
   (c_hhsize > 4.255) => 0.1553871039,
   (c_hhsize = NULL) => -0.0108116844, -0.0090107089),
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0115451252,
      (f_hh_payday_loan_users_i > 0.5) => 0.1501979644,
      (f_hh_payday_loan_users_i = NULL) => 0.0221421636, 0.0221421636),
   (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 0.0791561825,
   (nf_seg_FraudPoint_3_0 = '') => 0.0350081590, 0.0350081590),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.8) => 0.0695667214,
   (c_construction > 4.8) => -0.0346380480,
   (c_construction = NULL) => 0.0124221705, 0.0124221705), -0.0024240951);

// Tree: 33 
wFDN_FLA__D_lgt_33 := map(
(NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 3204) => -0.0173314141,
(r_A50_pb_total_dollars_d > 3204) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0132827849,
   (r_L79_adls_per_addr_c6_i > 4.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 53.5) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 1.65) => 0.1599084475,
         (c_bigapt_p > 1.65) => -0.0322791687,
         (c_bigapt_p = NULL) => 0.0379110911, 0.0379110911),
      (c_low_ed > 53.5) => 0.1811984307,
      (c_low_ed = NULL) => 0.0853958490, 0.0853958490),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0182818578, 0.0182818578),
(r_A50_pb_total_dollars_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 75.55) => 0.0413009989,
   (c_fammar_p > 75.55) => -0.0636901597,
   (c_fammar_p = NULL) => -0.0166695795, -0.0166695795), -0.0032276412);

// Tree: 34 
wFDN_FLA__D_lgt_34 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 
   map(
   (NULL < k_inq_lnames_per_addr_i and k_inq_lnames_per_addr_i <= 0.5) => 0.0119582848,
   (k_inq_lnames_per_addr_i > 0.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1775593967,
      (f_prevaddrstatus_i > 2.5) => 0.1064225452,
      (f_prevaddrstatus_i = NULL) => 0.0390821954, 0.1019073104),
   (k_inq_lnames_per_addr_i = NULL) => 0.0476886137, 0.0476886137),
(f_prevaddrlenofres_d > 1.5) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 0.1020347639,
   (r_F00_dob_score_d > 92) => -0.0092450782,
   (r_F00_dob_score_d = NULL) => 0.0319802383, -0.0056130369),
(f_prevaddrlenofres_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.3) => -0.0529879811,
   (c_hh4_p > 11.3) => 0.0616580581,
   (c_hh4_p = NULL) => 0.0140838514, 0.0140838514), -0.0016946554);

// Tree: 35 
wFDN_FLA__D_lgt_35 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 34.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 84.5) => -0.0180905451,
      (r_C13_max_lres_d > 84.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -9) => 0.2062314767,
         (f_addrchangecrimediff_i > -9) => 0.0417190683,
         (f_addrchangecrimediff_i = NULL) => 0.0891314697, 0.0568989724),
      (r_C13_max_lres_d = NULL) => 0.0276410485, 0.0276410485),
   (c_born_usa > 34.5) => -0.0153312382,
   (c_born_usa = NULL) => 0.0058282755, -0.0056186202),
(f_hh_tot_derog_i > 5.5) => 0.0840151630,
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 24.95) => 0.0773562007,
   (C_RENTOCC_P > 24.95) => -0.0448820600,
   (C_RENTOCC_P = NULL) => 0.0109751585, 0.0109751585), -0.0028283595);

// Tree: 36 
wFDN_FLA__D_lgt_36 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1091629502,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => -0.0284002315,
   (f_crim_rel_under500miles_cnt_i > 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.1437263544,
         (r_C10_M_Hdr_FS_d > 13.5) => -0.0002318397,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0013003603, 0.0013003603),
      (k_comb_age_d > 81.5) => 0.2285437287,
      (k_comb_age_d = NULL) => 0.0037641869, 0.0037641869),
   (f_crim_rel_under500miles_cnt_i = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 0.1866046215,
      (c_bigapt_p > 1.15) => -0.0159160761,
      (c_bigapt_p = NULL) => 0.0418200877, 0.0418200877), -0.0104125594),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0130575418, -0.0085174449);

// Tree: 37 
wFDN_FLA__D_lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.05) => -0.0150756492,
   (c_unemp > 9.05) => 0.0609300728,
   (c_unemp = NULL) => -0.0143433999, -0.0118635335),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0240209675,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.3) => 0.1553306087,
      (c_rnt500_p > 3.3) => 
         map(
         (NULL < c_rnt1250_p and c_rnt1250_p <= 2.95) => 0.0853721722,
         (c_rnt1250_p > 2.95) => -0.0726740184,
         (c_rnt1250_p = NULL) => 0.0172709681, 0.0172709681),
      (c_rnt500_p = NULL) => 0.0763476515, 0.0763476515),
   (f_varrisktype_i = NULL) => 0.0269584185, 0.0269584185),
(f_hh_lienholders_i = NULL) => 0.0031236136, 0.0003631672);

// Tree: 38 
wFDN_FLA__D_lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.1006494051,
   (r_F00_input_dob_match_level_d > 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0150830388,
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10) => 0.1596709168,
         (r_D32_Mos_Since_Crim_LS_d > 10) => 0.0162941182,
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0210022327, 0.0210022327),
      (nf_seg_FraudPoint_3_0 = '') => -0.0093248765, -0.0093248765),
   (r_F00_input_dob_match_level_d = NULL) => -0.0073964343, -0.0073964343),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1141653593,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 114.5) => 0.0802250371,
   (c_employees > 114.5) => -0.0271185863,
   (c_employees = NULL) => 0.0130487050, 0.0130487050), -0.0064466076);

// Tree: 39 
wFDN_FLA__D_lgt_39 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0158776788,
(f_crim_rel_under25miles_cnt_i > 0.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 39.5) => 
      map(
      (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 2.5) => 0.0158967412,
      (r_C20_email_domain_free_count_i > 2.5) => 0.1241699711,
      (r_C20_email_domain_free_count_i = NULL) => 0.0285118495, 0.0285118495),
   (r_pb_order_freq_d > 39.5) => -0.0168074015,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 0.0291886122,
      (k_comb_age_d > 68.5) => 0.2270762475,
      (k_comb_age_d = NULL) => 0.0370836111, 0.0370836111), 0.0154180627),
(f_crim_rel_under25miles_cnt_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 162.5) => -0.0013342122,
   (c_very_rich > 162.5) => 0.1064972406,
   (c_very_rich = NULL) => 0.0209565274, 0.0209565274), -0.0018238555);

// Tree: 40 
wFDN_FLA__D_lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98) => 
   map(
   (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 98) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 2.1) => 0.1856951023,
      (c_hval_400k_p > 2.1) => 0.0210615116,
      (c_hval_400k_p = NULL) => 0.0775267514, 0.0775267514),
   (r_F00_dob_score_d > 98) => -0.0072119246,
   (r_F00_dob_score_d = NULL) => 0.0115325148, -0.0045775565),
(f_addrchangecrimediff_i > 98) => 0.1297528162,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0052362816,
   (c_housingcpi > 222.35) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30342.5) => 0.1552603263,
      (f_curraddrmedianincome_d > 30342.5) => 0.0304469339,
      (f_curraddrmedianincome_d = NULL) => 0.0531202662, 0.0531202662),
   (c_housingcpi = NULL) => -0.0327185808, 0.0039660522), -0.0017285635);

// Tree: 41 
wFDN_FLA__D_lgt_41 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 33.5) => -0.0070953420,
(r_pb_order_freq_d > 33.5) => -0.0297894700,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0180972385,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0624053371,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0103852565, 0.0103852565),
   (f_rel_felony_count_i > 2.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 66.5) => 0.1987231292,
      (c_retired2 > 66.5) => 0.0265391840,
      (c_retired2 = NULL) => 0.0985177185, 0.0985177185),
   (f_rel_felony_count_i = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.15) => -0.0587214883,
      (c_pop_35_44_p > 13.15) => 0.0437023924,
      (c_pop_35_44_p = NULL) => 0.0086257209, 0.0086257209), 0.0125418787), -0.0078740819);

// Tree: 42 
wFDN_FLA__D_lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1468385457,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.25) => 0.1663421457,
      (c_pop_0_5_p > 8.25) => 0.0065193152,
      (c_pop_0_5_p = NULL) => 0.0700745928, 0.0700745928),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < c_employees and c_employees <= 40.5) => 0.0323311605,
      (c_employees > 40.5) => -0.0111391347,
      (c_employees = NULL) => -0.0411787257, -0.0064659987),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0054001968, -0.0054001968),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_unempl and c_unempl <= 97.5) => -0.0384490284,
   (c_unempl > 97.5) => 0.0546208477,
   (c_unempl = NULL) => -0.0012210779, -0.0012210779), -0.0044854957);

// Tree: 43 
wFDN_FLA__D_lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0058981669,
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 11.5) => 0.1637574252,
   (r_C21_M_Bureau_ADL_FS_d > 11.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 0.0021667181,
      (f_crim_rel_under25miles_cnt_i > 0.5) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 4.5) => 0.0753656162,
         (r_A50_pb_total_orders_d > 4.5) => -0.0597093810,
         (r_A50_pb_total_orders_d = NULL) => 0.0539830877, 0.0539830877),
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0268139903, 0.0268139903),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0328244165, 0.0328244165),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 0.2) => -0.0597432127,
   (c_high_hval > 0.2) => 0.0509513793,
   (c_high_hval = NULL) => 0.0035108399, 0.0035108399), -0.0022182415);

// Tree: 44 
wFDN_FLA__D_lgt_44 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -5362) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 31.5) => -0.0225595440,
   (f_prevaddrageoldest_d > 31.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.1362446641,
      (f_corraddrnamecount_d > 3.5) => 0.0223196557,
      (f_corraddrnamecount_d = NULL) => 0.0884439613, 0.0884439613),
   (f_prevaddrageoldest_d = NULL) => 0.0491041186, 0.0491041186),
(f_addrchangeincomediff_d > -5362) => -0.0053560508,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => -0.0173852523,
   (r_L79_adls_per_addr_curr_i > 5.5) => 0.0791584897,
   (r_L79_adls_per_addr_curr_i = NULL) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0359498622,
      (c_hval_250k_p > 8.05) => 0.0636685951,
      (c_hval_250k_p = NULL) => 0.0094458905, 0.0094458905), -0.0085985894), -0.0042048865);

// Tree: 45 
wFDN_FLA__D_lgt_45 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 3.15) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 43.5) => 0.0011331109,
      (k_comb_age_d > 43.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 20.95) => 0.2253709643,
         (C_OWNOCC_P > 20.95) => 0.0724737761,
         (C_OWNOCC_P = NULL) => 0.0859093814, 0.0859093814),
      (k_comb_age_d = NULL) => 0.0290807922, 0.0290807922),
   (f_corraddrnamecount_d > 3.5) => -0.0127633906,
   (f_corraddrnamecount_d = NULL) => -0.0059485501, -0.0058224681),
(c_hh7p_p > 3.15) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 10.5) => 0.0302633103,
   (k_inq_per_addr_i > 10.5) => 0.1385963284,
   (k_inq_per_addr_i = NULL) => 0.0334667060, 0.0334667060),
(c_hh7p_p = NULL) => -0.0637752821, -0.0013863982);

// Tree: 46 
wFDN_FLA__D_lgt_46 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0158378356,
      (f_srchaddrsrchcountmo_i > 0.5) => 0.0605905733,
      (f_srchaddrsrchcountmo_i = NULL) => -0.0117029360, -0.0117029360),
   (c_cpiall > 218.4) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 128.5) => 0.0061782484,
      (f_prevaddrageoldest_d > 128.5) => 0.0845271365,
      (f_prevaddrageoldest_d = NULL) => 0.0292984617, 0.0292984617),
   (c_cpiall = NULL) => 0.0032884304, -0.0015407895),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.1452121656,
   (r_E57_br_source_count_d > 0.5) => 0.0009221903,
   (r_E57_br_source_count_d = NULL) => 0.0805304526, 0.0805304526),
(r_D32_felony_count_i = NULL) => -0.0212859827, -0.0007201085);

// Tree: 47 
wFDN_FLA__D_lgt_47 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0019876044,
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 57.5) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 5.5) => -0.0375387445,
      (f_rel_educationover12_count_d > 5.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 12.55) => 0.0044392107,
         (c_pop_25_34_p > 12.55) => 
            map(
            (NULL < c_bargains and c_bargains <= 124) => 0.2503353937,
            (c_bargains > 124) => 0.0385443691,
            (c_bargains = NULL) => 0.1337792594, 0.1337792594),
         (c_pop_25_34_p = NULL) => 0.0782770163, 0.0782770163),
      (f_rel_educationover12_count_d = NULL) => 0.0373840440, 0.0373840440),
   (k_comb_age_d > 57.5) => 0.2340028087,
   (k_comb_age_d = NULL) => 0.0593243353, 0.0593243353),
(f_srchfraudsrchcountmo_i = NULL) => -0.0151355783, 0.0000823460);

// Tree: 48 
wFDN_FLA__D_lgt_48 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124896) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.1877188369,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -25287) => 0.1373859456,
      (f_addrchangevaluediff_d > -25287) => 0.0068682709,
      (f_addrchangevaluediff_d = NULL) => 0.0469581088, 0.0183352106),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0231129286, 0.0231129286),
(r_L80_Inp_AVM_AutoVal_d > 124896) => -0.0052922015,
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 73.5) => 0.0269815334,
   (f_mos_inq_banko_cm_fseen_d > 73.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 22900.5) => 0.0103589528,
      (r_A49_Curr_AVM_Chg_1yr_i > 22900.5) => 0.1264419553,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0316357207, -0.0239512531),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0202898757, -0.0128297560), -0.0043143394);

// Tree: 49 
wFDN_FLA__D_lgt_49 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 0.0837701230,
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0028157969,
      (f_varrisktype_i > 3.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1530913312,
         (r_C10_M_Hdr_FS_d > 33) => 0.0265325854,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0536350319, 0.0536350319),
      (f_varrisktype_i = NULL) => -0.0003127207, -0.0003127207),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0706149284,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0031332764, -0.0031332764),
(r_F00_input_dob_match_level_d = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 7.3) => 0.0673267403,
   (c_rnt500_p > 7.3) => -0.0501862550,
   (c_rnt500_p = NULL) => 0.0183629923, 0.0183629923), -0.0013158226);

// Tree: 50 
wFDN_FLA__D_lgt_50 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 146.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0168410804,
   (f_nae_nothing_found_i > 0.5) => 0.2773611040,
   (f_nae_nothing_found_i = NULL) => -0.0141346064, -0.0141346064),
(r_A50_pb_average_dollars_d > 146.5) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 0.0138082745,
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 85.5) => 0.2670006207,
      (c_easiqlife > 85.5) => 0.0668406443,
      (c_easiqlife = NULL) => 0.1103536826, 0.1103536826),
   (f_hh_members_w_derog_i = NULL) => 0.0183202306, 0.0183202306),
(r_A50_pb_average_dollars_d = NULL) => 
   map(
   (NULL < c_young and c_young <= 21.05) => 0.0812682740,
   (c_young > 21.05) => -0.0367160377,
   (c_young = NULL) => 0.0143854476, 0.0143854476), 0.0004629054);

// Tree: 51 
wFDN_FLA__D_lgt_51 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < c_employees and c_employees <= 71.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 160.5) => 0.0123767176,
      (f_curraddrcrimeindex_i > 160.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 171.5) => 
            map(
            (NULL < c_famotf18_p and c_famotf18_p <= 28.9) => 0.0775758069,
            (c_famotf18_p > 28.9) => 0.2490065389,
            (c_famotf18_p = NULL) => 0.1420234505, 0.1420234505),
         (f_M_Bureau_ADL_FS_all_d > 171.5) => 0.0275018560,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0704071295, 0.0704071295),
      (f_curraddrcrimeindex_i = NULL) => 0.0203153674, 0.0203153674),
   (c_employees > 71.5) => -0.0100512801,
   (c_employees = NULL) => -0.0249454860, -0.0040580122),
(f_bus_addr_match_count_d > 52.5) => 0.1883671391,
(f_bus_addr_match_count_d = NULL) => -0.0027686044, -0.0027686044);

// Tree: 52 
wFDN_FLA__D_lgt_52 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 19.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => -0.0088030741,
      (c_unempl > 191.5) => 0.1095078769,
      (c_unempl = NULL) => 0.0148711445, -0.0075077523),
   (f_srchaddrsrchcount_i > 19.5) => 0.0784844856,
   (f_srchaddrsrchcount_i = NULL) => -0.0064536098, -0.0064536098),
(f_phones_per_addr_curr_i > 9.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.65) => 0.0188265534,
   (c_pop_6_11_p > 10.65) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.03741573515) => 0.2021536166,
      (f_add_input_nhood_BUS_pct_i > 0.03741573515) => 0.0399861284,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.1210698725, 0.1210698725),
   (c_pop_6_11_p = NULL) => 0.0333050654, 0.0333050654),
(f_phones_per_addr_curr_i = NULL) => -0.0058359671, -0.0028211005);

// Tree: 53 
wFDN_FLA__D_lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0171035733,
   (r_D32_felony_count_i > 0.5) => 0.0887691584,
   (r_D32_felony_count_i = NULL) => 0.0429197760, -0.0149713968),
(c_easiqlife > 129.5) => 
   map(
   (NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
         map(
         (NULL < c_blue_empl and c_blue_empl <= 132.5) => 0.0434229883,
         (c_blue_empl > 132.5) => 0.2049688385,
         (c_blue_empl = NULL) => 0.0702009689, 0.0702009689),
      (f_prevaddrlenofres_d > 2.5) => 0.0131134003,
      (f_prevaddrlenofres_d = NULL) => 0.0177235002, 0.0177235002),
   (f_attr_arrests_i > 0.5) => 0.1377868188,
   (f_attr_arrests_i = NULL) => -0.0049658435, 0.0192205174),
(c_easiqlife = NULL) => -0.0246074623, -0.0025316059);

// Tree: 54 
wFDN_FLA__D_lgt_54 := map(
(NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 142) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 121.5) => -0.0177106463,
      (c_rich_fam > 121.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 42363.5) => 
            map(
            (NULL < c_hh1_p and c_hh1_p <= 27.4) => 0.2311924261,
            (c_hh1_p > 27.4) => 0.0297945659,
            (c_hh1_p = NULL) => 0.1249431613, 0.1249431613),
         (f_curraddrmedianincome_d > 42363.5) => 0.0301925021,
         (f_curraddrmedianincome_d = NULL) => 0.0556329539, 0.0556329539),
      (c_rich_fam = NULL) => 0.0989744292, 0.0132378327),
   (f_prevaddrageoldest_d > 142) => 0.1547269185,
   (f_prevaddrageoldest_d = NULL) => 0.0235931212, 0.0235931212),
(r_C12_source_profile_index_d > 1.5) => -0.0066481666,
(r_C12_source_profile_index_d = NULL) => -0.0049907752, -0.0032380018);

// Tree: 55 
wFDN_FLA__D_lgt_55 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 40627.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 71091) => -0.0399273767,
      (c_med_hval > 71091) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.0817787626,
         (r_I60_inq_comm_recency_d > 549) => 0.0215932812,
         (r_I60_inq_comm_recency_d = NULL) => 0.0296805925, 0.0296805925),
      (c_med_hval = NULL) => 0.0271813278, 0.0172786171),
   (k_comb_age_d > 79.5) => 0.2468937666,
   (k_comb_age_d = NULL) => 0.0223768185, 0.0223768185),
(f_curraddrmedianincome_d > 40627.5) => -0.0118278188,
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 114) => -0.0499478525,
   (c_totcrime > 114) => 0.0644877021,
   (c_totcrime = NULL) => -0.0126897650, -0.0126897650), -0.0055268353);

// Tree: 56 
wFDN_FLA__D_lgt_56 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 298.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 13.5) => 0.1451180733,
         (r_C13_max_lres_d > 13.5) => 
            map(
            (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 55.5) => 0.0227103493,
            (f_addrchangecrimediff_i > 55.5) => 0.0834824188,
            (f_addrchangecrimediff_i = NULL) => 0.0118579578, 0.0229765135),
         (r_C13_max_lres_d = NULL) => 0.0270080039, 0.0270080039),
      (r_C13_Curr_Addr_LRes_d > 298.5) => 0.1922723608,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0330832957, 0.0330832957),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0786981763,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0230270059, 0.0230270059),
(f_corraddrnamecount_d > 3.5) => -0.0063245842,
(f_corraddrnamecount_d = NULL) => -0.0125073096, -0.0012930357);

// Tree: 57 
wFDN_FLA__D_lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 241.75) => -0.0116181919,
   (c_housingcpi > 241.75) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 199.5) => -0.0101109775,
      (r_C10_M_Hdr_FS_d > 199.5) => 0.0736051169,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0289834300, 0.0289834300),
   (c_housingcpi = NULL) => -0.0254440716, -0.0050824242),
(r_D30_Derog_Count_i > 11.5) => 0.0624749947,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => -0.0904980973,
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0298712267,
      (c_pop_35_44_p > 16.05) => 0.0978378506,
      (c_pop_35_44_p = NULL) => 0.0321588966, 0.0321588966),
   (k_comb_age_d = NULL) => -0.0026944569, -0.0026944569), -0.0041583820);

// Tree: 58 
wFDN_FLA__D_lgt_58 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.1) => 0.2090348393,
   (r_C12_source_profile_d > 60.1) => -0.0047311574,
   (r_C12_source_profile_d = NULL) => 0.0866907783, 0.0866907783),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 26.65) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3454078554) => 0.0084582040,
      (f_add_curr_nhood_MFD_pct_i > 0.3454078554) => 0.0435617009,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0171339470, 0.0083706133),
   (c_hh1_p > 26.65) => -0.0205989659,
   (c_hh1_p = NULL) => -0.0347989656, -0.0040635165),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 68) => -0.0711518816,
   (c_burglary > 68) => 0.0322203628,
   (c_burglary = NULL) => -0.0144638766, -0.0144638766), -0.0030751785);

// Tree: 59 
wFDN_FLA__D_lgt_59 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => -0.0137373000,
(r_L79_adls_per_addr_curr_i > 3.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1106790801,
   (r_C10_M_Hdr_FS_d > 7.5) => 
      map(
      (NULL < c_professional and c_professional <= 10.45) => 
         map(
         (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 0.1028708756,
         (r_nas_addr_verd_d > 0.5) => 0.0208917584,
         (r_nas_addr_verd_d = NULL) => 0.0242438457, 0.0242438457),
      (c_professional > 10.45) => -0.0299757402,
      (c_professional = NULL) => 0.0113711431, 0.0113711431),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0134236124, 0.0134236124),
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 14.45) => 0.0403960065,
   (c_hh3_p > 14.45) => -0.0748874879,
   (c_hh3_p = NULL) => -0.0195210729, -0.0195210729), -0.0057376333);

// Tree: 60 
wFDN_FLA__D_lgt_60 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0085882089,
(f_divaddrsuspidcountnew_i > 0.5) => 
   map(
   (NULL < c_young and c_young <= 39.65) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0041340865,
      (f_corrrisktype_i > 7.5) => 0.0501167388,
      (f_corrrisktype_i = NULL) => 0.0280765601, 0.0280765601),
   (c_young > 39.65) => -0.0594143312,
   (c_young = NULL) => 0.0197284709, 0.0197284709),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 24.5) => -0.1134980096,
   (k_comb_age_d > 24.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0293107342,
      (c_pop_35_44_p > 15.55) => 0.0781087399,
      (c_pop_35_44_p = NULL) => 0.0264647619, 0.0264647619),
   (k_comb_age_d = NULL) => -0.0138634942, -0.0138634942), -0.0032016205);

// Tree: 61 
wFDN_FLA__D_lgt_61 := map(
(NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.1470409076,
   (r_D33_Eviction_Recency_d > 48) => 0.0272014022,
   (r_D33_Eviction_Recency_d = NULL) => 0.0306253881, 0.0306253881),
(r_I60_inq_recency_d > 4.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 15.05) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 31.65) => 0.0174504088,
      (c_hh3_p > 31.65) => 0.1528109716,
      (c_hh3_p = NULL) => 0.0236776501, 0.0236776501),
   (c_hh1_p > 15.05) => -0.0156989995,
   (c_hh1_p = NULL) => -0.0133059103, -0.0065659662),
(r_I60_inq_recency_d = NULL) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 61.35) => 0.0311652864,
   (c_civ_emp > 61.35) => -0.0635412324,
   (c_civ_emp = NULL) => -0.0161879730, -0.0161879730), -0.0015807518);

// Tree: 62 
wFDN_FLA__D_lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0118124011,
   (r_C14_Addr_Stability_v2_d > 4.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 26.5) => 
         map(
         (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 0.0399995020,
         (f_vardobcountnew_i > 0.5) => 0.1723768764,
         (f_vardobcountnew_i = NULL) => 0.0553674501, 0.0553674501),
      (c_born_usa > 26.5) => 0.0002944489,
      (c_born_usa = NULL) => -0.0226261044, 0.0072184410),
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0018059970, -0.0018059970),
(f_assoccredbureaucountnew_i > 0.5) => 0.0773430839,
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 241976.5) => -0.0231346283,
   (c_med_hval > 241976.5) => 0.1122146862,
   (c_med_hval = NULL) => 0.0319385410, 0.0319385410), 0.0003067859);

// Tree: 63 
wFDN_FLA__D_lgt_63 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.1038400077,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0058946962,
   (c_hval_200k_p > 16.45) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0208562343,
      (f_assocrisktype_i > 4.5) => 
         map(
         (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 4.5) => 0.2095005351,
         (f_rel_criminal_count_i > 4.5) => 0.0042629576,
         (f_rel_criminal_count_i = NULL) => 0.1240837399, 0.1240837399),
      (f_assocrisktype_i = NULL) => 0.0374996252, 0.0374996252),
   (c_hval_200k_p = NULL) => 0.0262850675, -0.0015297468),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 136.5) => -0.0369030667,
   (c_larceny > 136.5) => 0.0552742015,
   (c_larceny = NULL) => -0.0059864674, -0.0059864674), -0.0011035984);

// Tree: 64 
wFDN_FLA__D_lgt_64 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
      map(
      (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 1.5) => 0.0142515576,
      (f_hh_members_w_derog_i > 1.5) => 0.1063746076,
      (f_hh_members_w_derog_i = NULL) => 0.0351886144, 0.0351886144),
   (f_corraddrnamecount_d > 1.5) => -0.0090465500,
   (f_corraddrnamecount_d = NULL) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.85) => -0.0457681952,
      (c_hh6_p > 1.85) => 0.0453214347,
      (c_hh6_p = NULL) => -0.0063939681, -0.0063939681), -0.0056565105),
(k_comb_age_d > 69.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 1.95) => 0.1732879393,
   (C_INC_150K_P > 1.95) => 0.0495490967,
   (C_INC_150K_P = NULL) => 0.0643779859, 0.0643779859),
(k_comb_age_d = NULL) => -0.0013942613, -0.0013942613);

// Tree: 65 
wFDN_FLA__D_lgt_65 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 3.75) => -0.0061609395,
   (c_hh7p_p > 3.75) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0246971612,
      (f_srchfraudsrchcountmo_i > 0.5) => 0.1464331877,
      (f_srchfraudsrchcountmo_i = NULL) => 0.0291328869, 0.0291328869),
   (c_hh7p_p = NULL) => -0.0120447150, -0.0017932113),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 23.1) => 
      map(
      (NULL < c_white_col and c_white_col <= 21.55) => 0.1447922616,
      (c_white_col > 21.55) => 0.0234543537,
      (c_white_col = NULL) => 0.0345418588, 0.0345418588),
   (c_hval_500k_p > 23.1) => 0.2243676679,
   (c_hval_500k_p = NULL) => 0.0516573006, 0.0516573006),
(k_comb_age_d = NULL) => 0.0019024761, 0.0019024761);

// Tree: 66 
wFDN_FLA__D_lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 5.5) => -0.0074917630,
      (f_hh_collections_ct_i > 5.5) => 0.1234273699,
      (f_hh_collections_ct_i = NULL) => -0.0067276435, -0.0067276435),
   (f_assocsuspicousidcount_i > 16.5) => 0.1109133214,
   (f_assocsuspicousidcount_i = NULL) => 0.0051617931, -0.0059956971),
(c_hh3_p > 23.25) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -5013) => 0.1182952093,
   (f_addrchangeincomediff_d > -5013) => 0.0263280704,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 2.2) => 0.1377862407,
      (c_rnt750_p > 2.2) => -0.0068729353,
      (c_rnt750_p = NULL) => 0.0387701635, 0.0387701635), 0.0320601974),
(c_hh3_p = NULL) => -0.0183210629, -0.0004894528);

// Tree: 67 
wFDN_FLA__D_lgt_67 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6942.5) => -0.0031196552,
(f_addrchangeincomediff_d > 6942.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.29619634885) => 0.0340412188,
   (f_add_curr_nhood_MFD_pct_i > 0.29619634885) => 
      map(
      (NULL < c_bargains and c_bargains <= 59) => 0.2505840684,
      (c_bargains > 59) => 0.0606255681,
      (c_bargains = NULL) => 0.1239450682, 0.1239450682),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0678878178, 0.0549537966),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 131314.5) => 0.0558601150,
   (r_L80_Inp_AVM_AutoVal_d > 131314.5) => 0.0072792166,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => -0.0214773222,
      (f_srchaddrsrchcount_i > 5.5) => 0.0706485934,
      (f_srchaddrsrchcount_i = NULL) => -0.0456859484, -0.0155085609), 0.0015540735), -0.0002038140);

// Tree: 68 
wFDN_FLA__D_lgt_68 := map(
(NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 280.5) => -0.0057648328,
   (r_C13_Curr_Addr_LRes_d > 280.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.1694100371,
      (f_corraddrnamecount_d > 3.5) => 0.0365060288,
      (f_corraddrnamecount_d = NULL) => 0.0496433732, 0.0496433732),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0010929320, -0.0010929320),
(f_attr_arrests_i > 0.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.15) => 0.0002906938,
   (c_pop_6_11_p > 8.15) => 0.1619817857,
   (c_pop_6_11_p = NULL) => 0.0805190982, 0.0805190982),
(f_attr_arrests_i = NULL) => 
   map(
   (NULL < c_no_labfor and c_no_labfor <= 104.5) => 0.0406788886,
   (c_no_labfor > 104.5) => -0.0615399842,
   (c_no_labfor = NULL) => -0.0049660168, -0.0049660168), -0.0003099559);

// Tree: 69 
wFDN_FLA__D_lgt_69 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1105597807,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0086623315,
      (f_varrisktype_i > 4.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 10.7) => 0.1095579786,
         (C_INC_50K_P > 10.7) => 0.0069416199,
         (C_INC_50K_P = NULL) => 0.0413556426, 0.0413556426),
      (f_varrisktype_i = NULL) => -0.0072903588, -0.0072903588),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 7.5) => -0.0039920918,
      (f_rel_count_i > 7.5) => 0.2385806763,
      (f_rel_count_i = NULL) => 0.1097138933, 0.1097138933),
   (f_nae_nothing_found_i = NULL) => -0.0057862064, -0.0057862064),
(f_attr_arrest_recency_d = NULL) => -0.0070189994, -0.0052903629);

// Tree: 70 
wFDN_FLA__D_lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 4.75) => -0.0829819592,
   (c_pop_35_44_p > 4.75) => -0.0055844179,
   (c_pop_35_44_p = NULL) => -0.0074157925, -0.0074157925),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1383945951,
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 6.5) => 0.0246820794,
      (f_hh_members_ct_d > 6.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 7.65) => 0.2456637166,
         (C_INC_150K_P > 7.65) => 0.0321304431,
         (C_INC_150K_P = NULL) => 0.1268769949, 0.1268769949),
      (f_hh_members_ct_d = NULL) => 0.0418090852, 0.0418090852),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0469833089, 0.0469833089),
(c_hval_750k_p = NULL) => 0.0066337176, -0.0029848897);

// Tree: 71 
wFDN_FLA__D_lgt_71 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 29.5) => -0.0312177374,
   (f_mos_inq_banko_om_fseen_d > 29.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < c_murders and c_murders <= 76.5) => 0.0367553486,
         (c_murders > 76.5) => 0.1413275788,
         (c_murders = NULL) => 0.0982827306, 0.0982827306),
      (f_current_count_d > 0.5) => 0.0065966238,
      (f_current_count_d = NULL) => 0.0575847361, 0.0575847361),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0303385226, 0.0303385226),
(r_I60_inq_comm_recency_d > 549) => 0.0002553529,
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < c_finance and c_finance <= 5.3) => 0.0373367422,
   (c_finance > 5.3) => -0.0677249834,
   (c_finance = NULL) => -0.0014047691, -0.0014047691), 0.0029431529);

// Tree: 72 
wFDN_FLA__D_lgt_72 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 13.75) => -0.0034595856,
         (c_vacant_p > 13.75) => 0.0618626434,
         (c_vacant_p = NULL) => -0.0103616013, 0.0040462625),
      (k_comb_age_d > 73.5) => 0.1279216011,
      (k_comb_age_d = NULL) => 0.0083791402, 0.0083791402),
   (f_historical_count_d > 0.5) => -0.0172702293,
   (f_historical_count_d = NULL) => -0.0047502302, -0.0047502302),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0857701951,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.75) => -0.0502209560,
   (c_pop_35_44_p > 15.75) => 0.0424123890,
   (c_pop_35_44_p = NULL) => -0.0102201934, -0.0102201934), -0.0044495979);

// Tree: 73 
wFDN_FLA__D_lgt_73 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 46.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 23.25) => -0.0027573129,
   (c_hval_150k_p > 23.25) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => 0.0178454335,
      (f_srchaddrsrchcount_i > 5.5) => 0.1357186141,
      (f_srchaddrsrchcount_i = NULL) => 0.0387325027, 0.0387325027),
   (c_hval_150k_p = NULL) => 0.0000279935, 0.0000279935),
(c_famotf18_p > 46.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 2.5) => 0.1417346130,
   (r_C12_source_profile_index_d > 2.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3179847077) => 0.0687089516,
      (f_add_input_mobility_index_i > 0.3179847077) => -0.0755741834,
      (f_add_input_mobility_index_i = NULL) => 0.0078666658, 0.0078666658),
   (r_C12_source_profile_index_d = NULL) => 0.0434068288, 0.0434068288),
(c_famotf18_p = NULL) => -0.0089121785, 0.0006260337);

// Tree: 74 
wFDN_FLA__D_lgt_74 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 5.35) => 0.0027669111,
      (c_hval_125k_p > 5.35) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 48.5) => 0.1704214141,
         (r_C10_M_Hdr_FS_d > 48.5) => 0.0392675785,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0576096372, 0.0576096372),
      (c_hval_125k_p = NULL) => 0.0698824513, 0.0237478016),
   (f_hh_members_ct_d > 1.5) => -0.0063776717,
   (f_hh_members_ct_d = NULL) => 
      map(
      (NULL < c_assault and c_assault <= 90) => -0.0346855209,
      (c_assault > 90) => 0.0899236130,
      (c_assault = NULL) => 0.0149707505, 0.0149707505), -0.0005585980),
(r_L77_Add_PO_Box_i > 0.5) => -0.0870785651,
(r_L77_Add_PO_Box_i = NULL) => -0.0025093044, -0.0025093044);

// Tree: 75 
wFDN_FLA__D_lgt_75 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1450) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 69) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0070336425,
      (f_util_adl_count_n > 6.5) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 138.5) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.10997263455) => 0.0506595791,
            (f_add_curr_nhood_VAC_pct_i > 0.10997263455) => 0.2251825002,
            (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0747957278, 0.0747957278),
         (c_lux_prod > 138.5) => -0.0338718677,
         (c_lux_prod = NULL) => 0.0301303502, 0.0301303502),
      (f_util_adl_count_n = NULL) => -0.0045826109, -0.0045826109),
   (f_bus_addr_match_count_d > 69) => 0.1870290594,
   (f_bus_addr_match_count_d = NULL) => -0.0037060567, -0.0037060567),
(f_liens_rel_SC_total_amt_i > 1450) => -0.1338401732,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0281304847, -0.0045976238);

// Tree: 76 
wFDN_FLA__D_lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0108501379,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => -0.0015327916,
         (f_prevaddrlenofres_d > 123.5) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0462298541,
            (f_rel_homeover500_count_d > 3.5) => 0.1917901191,
            (f_rel_homeover500_count_d = NULL) => 0.0697384809, 0.0697384809),
         (f_prevaddrlenofres_d = NULL) => 0.0178195754, 0.0178195754),
      (f_inq_Communications_count24_i > 1.5) => 0.1217533297,
      (f_inq_Communications_count24_i = NULL) => 0.0200399922, 0.0200399922),
   (f_nae_nothing_found_i > 0.5) => 0.2078954462,
   (f_nae_nothing_found_i = NULL) => 0.0229760678, 0.0229760678),
(c_rnt1250_p = NULL) => -0.0038875235, -0.0013153222);

// Tree: 77 
wFDN_FLA__D_lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 64.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.2163530479,
      (r_C12_source_profile_d > 57.95) => -0.0278972911,
      (r_C12_source_profile_d = NULL) => 0.0681183594, 0.0681183594),
   (f_mos_liens_unrel_SC_fseen_d > 64.5) => -0.0018232354,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 131) => -0.0446245241,
      (c_for_sale > 131) => 0.0602277128,
      (c_for_sale = NULL) => -0.0055761048, -0.0055761048), -0.0010351450),
(c_transport > 29.05) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1675695811,
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0153768840,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0933475269, 0.0933475269),
(c_transport = NULL) => -0.0151638782, 0.0001880017);

// Tree: 78 
wFDN_FLA__D_lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0027517363,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0570417888,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0002165506, 0.0002165506),
   (f_prevaddrmedianvalue_d > 809865.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 68.5) => -0.0271870180,
      (c_exp_prod > 68.5) => 0.2016588784,
      (c_exp_prod = NULL) => 0.1094373977, 0.1094373977),
   (f_prevaddrmedianvalue_d = NULL) => 
      map(
      (NULL < c_unempl and c_unempl <= 97.5) => -0.0356578014,
      (c_unempl > 97.5) => 0.0596890042,
      (c_unempl = NULL) => 0.0078956777, 0.0078956777), 0.0021019870),
(r_L77_Add_PO_Box_i > 0.5) => -0.0976212277,
(r_L77_Add_PO_Box_i = NULL) => -0.0002250191, -0.0002250191);

// Tree: 79 
wFDN_FLA__D_lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 8.95) => 0.1155328705,
      (c_hval_500k_p > 8.95) => -0.0482571332,
      (c_hval_500k_p = NULL) => 0.0514177046, 0.0514177046),
   (r_C10_M_Hdr_FS_d > 11.5) => -0.0053799052,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0039641021, -0.0039641021),
(f_inq_PrepaidCards_count_i > 1.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 169) => 0.1129951980,
   (r_C21_M_Bureau_ADL_FS_d > 169) => -0.0339528091,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0562198316, 0.0562198316),
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 18.8) => 0.0572822781,
   (C_RENTOCC_P > 18.8) => -0.0495374403,
   (C_RENTOCC_P = NULL) => -0.0074379042, -0.0074379042), -0.0033917772);

// Tree: 80 
wFDN_FLA__D_lgt_80 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.0876821554,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => -0.0111008204,
      (f_inq_HighRiskCredit_count_i > 4.5) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 0.4) => -0.0142113608,
         (c_bigapt_p > 0.4) => 0.0967638363,
         (c_bigapt_p = NULL) => 0.0495403481, 0.0495403481),
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0094987873, -0.0094987873),
   (r_C14_Addr_Stability_v2_d > 5.5) => 0.0124534234,
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0002552862, -0.0002552862),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.35) => -0.0256284738,
   (c_hval_250k_p > 6.35) => 0.0571413479,
   (c_hval_250k_p = NULL) => 0.0154894376, 0.0154894376), 0.0003670014);

// Tree: 81 
wFDN_FLA__D_lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 142.5) => -0.0144587890,
(c_easiqlife > 142.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 126.5) => 0.0019954181,
   (r_C13_Curr_Addr_LRes_d > 126.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 5.55) => 0.1808166010,
      (c_pop_55_64_p > 5.55) => 
         map(
         (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 22.5) => 
            map(
            (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0268854658,
            (k_inq_per_addr_i > 3.5) => 0.1534948875,
            (k_inq_per_addr_i = NULL) => 0.0398111509, 0.0398111509),
         (f_rel_under500miles_cnt_d > 22.5) => 0.1734186585,
         (f_rel_under500miles_cnt_d = NULL) => 0.0478430473, 0.0478430473),
      (c_pop_55_64_p = NULL) => 0.0577453332, 0.0577453332),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0168325982, 0.0168325982),
(c_easiqlife = NULL) => 0.0119398893, -0.0050655888);

// Tree: 82 
wFDN_FLA__D_lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29953.5) => 
      map(
      (NULL < c_health and c_health <= 5.7) => 0.1401358375,
      (c_health > 5.7) => -0.0122426387,
      (c_health = NULL) => 0.0679565593, 0.0679565593),
   (r_A46_Curr_AVM_AutoVal_d > 29953.5) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => 
         map(
         (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0132598600,
         (r_L70_Add_Standardized_i > 0.5) => 0.0711602628,
         (r_L70_Add_Standardized_i = NULL) => -0.0085545582, -0.0085545582),
      (f_rel_incomeover100_count_d > 11.5) => 0.1050648264,
      (f_rel_incomeover100_count_d = NULL) => 0.1068402207, -0.0063094352),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0004556473, -0.0024568219),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0696827317,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0066441745, -0.0030084465);

// Tree: 83 
wFDN_FLA__D_lgt_83 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0110992275,
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.1228855271,
   (r_C10_M_Hdr_FS_d > 8.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 77.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.705) => 0.0107208452,
         (c_hhsize > 2.705) => 0.1671593187,
         (c_hhsize = NULL) => 0.0809273797, 0.0809273797),
      (f_mos_liens_unrel_CJ_lseen_d > 77.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 172.5) => 0.0159731090,
         (c_no_teens > 172.5) => -0.0463848276,
         (c_no_teens = NULL) => 0.0089480346, 0.0089480346),
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0116352984, 0.0116352984),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0134489442, 0.0134489442),
(f_srchaddrsrchcount_i = NULL) => 0.0006408375, -0.0001154713);

// Tree: 84 
wFDN_FLA__D_lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 309.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => -0.0031544848,
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.35) => -0.0102152247,
      (c_pop_45_54_p > 14.35) => 0.2246742699,
      (c_pop_45_54_p = NULL) => 0.1027976454, 0.1027976454),
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0021825295, -0.0021825295),
(r_C13_Curr_Addr_LRes_d > 309.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 159.9) => 0.0343864745,
   (c_oldhouse > 159.9) => 0.1434639129,
   (c_oldhouse = NULL) => 0.0528975125, 0.0528975125),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => -0.0877145004,
   (k_comb_age_d > 25.5) => 0.0526601596,
   (k_comb_age_d = NULL) => 0.0066113293, 0.0066113293), 0.0010878615);

// Tree: 85 
wFDN_FLA__D_lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0098106164,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 
      map(
      (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.25606784155) => 0.0386975933,
         (f_add_curr_mobility_index_i > 0.25606784155) => -0.0141134166,
         (f_add_curr_mobility_index_i = NULL) => 0.0078546900, 0.0078546900),
      (r_F01_inp_addr_not_verified_i > 0.5) => 0.1193665097,
      (r_F01_inp_addr_not_verified_i = NULL) => 0.0140892503, 0.0140892503),
   (f_inq_Collection_count_i > 8.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 10.8) => 0.0192473800,
      (c_hval_250k_p > 10.8) => 0.1937206075,
      (c_hval_250k_p = NULL) => 0.0957471798, 0.0957471798),
   (f_inq_Collection_count_i = NULL) => 0.0211050802, 0.0211050802),
(f_util_adl_count_n = NULL) => -0.0010584340, -0.0059019307);

// Tree: 86 
wFDN_FLA__D_lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 64.35) => 0.0018728707,
   (C_RENTOCC_P > 64.35) => -0.0410178421,
   (C_RENTOCC_P = NULL) => 0.0036136782, -0.0020388518),
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 128.5) => 0.0095369914,
   (f_curraddrcrimeindex_i > 128.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 1.95) => 0.2388756113,
      (c_rnt500_p > 1.95) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 1.5) => 0.1138597939,
         (f_rel_incomeover75_count_d > 1.5) => -0.0459935477,
         (f_rel_incomeover75_count_d = NULL) => 0.0499184573, 0.0499184573),
      (c_rnt500_p = NULL) => 0.1032961844, 0.1032961844),
   (f_curraddrcrimeindex_i = NULL) => 0.0349656210, 0.0349656210),
(f_phones_per_addr_curr_i = NULL) => -0.0123452882, -0.0002654464);

// Tree: 87 
wFDN_FLA__D_lgt_87 := map(
(NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 92) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 5.45) => 0.1570657751,
   (c_newhouse > 5.45) => 0.0093673312,
   (c_newhouse = NULL) => 0.0615892810, 0.0615892810),
(r_F00_dob_score_d > 92) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2586) => -0.0125960950,
   (f_addrchangeincomediff_d > 2586) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 153.5) => 0.0200698664,
      (c_easiqlife > 153.5) => 0.2026663418,
      (c_easiqlife = NULL) => 0.0401927433, 0.0401927433),
   (f_addrchangeincomediff_d = NULL) => -0.0054652296, -0.0088937054),
(r_F00_dob_score_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 155.5) => -0.0299483449,
   (c_totcrime > 155.5) => 0.0686854052,
   (c_totcrime = NULL) => -0.0042685300, -0.0112020204), -0.0072989769);

// Tree: 88 
wFDN_FLA__D_lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 5.45) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.15) => 0.0850294628,
      (c_pop_45_54_p > 13.15) => -0.0678086655,
      (c_pop_45_54_p = NULL) => 0.0057375015, 0.0057375015),
   (c_hval_300k_p > 5.45) => 0.1491824318,
   (c_hval_300k_p = NULL) => 0.0612645713, 0.0612645713),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 0.5) => -0.0160605743,
   (f_crim_rel_under500miles_cnt_i > 0.5) => 0.0112590075,
   (f_crim_rel_under500miles_cnt_i = NULL) => -0.0000269956, -0.0015826784),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 16.7) => -0.0403664614,
   (c_retail > 16.7) => 0.0976858963,
   (c_retail = NULL) => 0.0092926601, 0.0092926601), -0.0003469510);

// Tree: 89 
wFDN_FLA__D_lgt_89 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 61.5) => -0.0656009852,
(f_mos_inq_banko_am_fseen_d > 61.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 41.85) => -0.0031608620,
   (c_hval_750k_p > 41.85) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 0.0053213389,
      (r_C14_Addr_Stability_v2_d > 5.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 21.7) => 0.0552681652,
         (c_hh3_p > 21.7) => 0.2231484955,
         (c_hh3_p = NULL) => 0.0954725162, 0.0954725162),
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0410809201, 0.0410809201),
   (c_hval_750k_p = NULL) => 0.0401045922, 0.0006333114),
(f_mos_inq_banko_am_fseen_d = NULL) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1173.5) => 0.0547061231,
   (c_popover25 > 1173.5) => -0.0343935888,
   (c_popover25 = NULL) => 0.0118919758, 0.0118919758), -0.0019567619);

// Tree: 90 
wFDN_FLA__D_lgt_90 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
   map(
   (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 1.5) => 
      map(
      (NULL < f_assoccredbureaucountmo_i and f_assoccredbureaucountmo_i <= 0.5) => 0.0027697144,
      (f_assoccredbureaucountmo_i > 0.5) => 0.1335488604,
      (f_assoccredbureaucountmo_i = NULL) => 0.0033522496, 0.0033522496),
   (r_D31_MostRec_Bk_i > 1.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 24.05) => -0.0548978405,
      (c_hval_750k_p > 24.05) => 
         map(
         (NULL < c_incollege and c_incollege <= 6) => -0.0502413687,
         (c_incollege > 6) => 0.1549993287,
         (c_incollege = NULL) => 0.0696191986, 0.0696191986),
      (c_hval_750k_p = NULL) => -0.0412446564, -0.0412446564),
   (r_D31_MostRec_Bk_i = NULL) => -0.0242077781, -0.0011455414),
(k_inq_adls_per_addr_i > 4.5) => -0.0859357307,
(k_inq_adls_per_addr_i = NULL) => -0.0019944459, -0.0019944459);

// Tree: 91 
wFDN_FLA__D_lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.35) => -0.0135113487,
   (c_pop_65_74_p > 4.35) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 28.4) => 0.2524963027,
      (c_lowinc > 28.4) => 0.0397884134,
      (c_lowinc = NULL) => 0.1469668072, 0.1469668072),
   (c_pop_65_74_p = NULL) => 0.0823297722, 0.0823297722),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0119423002,
      (f_srchfraudsrchcountmo_i > 0.5) => 0.0450923565,
      (f_srchfraudsrchcountmo_i = NULL) => -0.0099209806, -0.0099209806),
   (c_food > 65.55) => 0.0547525610,
   (c_food = NULL) => -0.0052524821, -0.0075291831),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0034778698, -0.0058428761);

// Tree: 92 
wFDN_FLA__D_lgt_92 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 94.35) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 19.5) => 0.0018814349,
   (f_addrchangecrimediff_i > 19.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 74.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 156.5) => 0.1513166755,
         (c_burglary > 156.5) => -0.0129349516,
         (c_burglary = NULL) => 0.0870900777, 0.0870900777),
      (c_exp_prod > 74.5) => 0.0021525724,
      (c_exp_prod = NULL) => 0.0374865746, 0.0374865746),
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 4.5) => 0.0036335042,
      (f_inq_HighRiskCredit_count_i > 4.5) => -0.0985148533,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0086499727, 0.0005675271), 0.0026849586),
(C_RENTOCC_P > 94.35) => -0.1299605144,
(C_RENTOCC_P = NULL) => -0.0493304381, 0.0008378398);

// Tree: 93 
wFDN_FLA__D_lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0017543453,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 117.5) => 0.0043595719,
         (c_serv_empl > 117.5) => 0.1421597657,
         (c_serv_empl = NULL) => 0.0738694042, 0.0738694042),
      (r_D33_eviction_count_i = NULL) => 0.0024548526, 0.0024548526),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 58.5) => 0.1159890897,
      (r_pb_order_freq_d > 58.5) => -0.0445956442,
      (r_pb_order_freq_d = NULL) => 0.1277581776, 0.0814221214),
   (f_curraddrcartheftindex_i = NULL) => 0.0054958600, 0.0039462945),
(c_cartheft > 189.5) => -0.0549862748,
(c_cartheft = NULL) => -0.0094029828, 0.0017495551);

// Tree: 94 
wFDN_FLA__D_lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0074709155,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.284763757) => 0.0244539550,
      (f_add_input_nhood_BUS_pct_i > 0.284763757) => -0.1056105971,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0875155457, 0.0232068702),
   (f_inq_Other_count_i = NULL) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 92.5) => 0.0669281773,
      (c_rest_indx > 92.5) => -0.0352907719,
      (c_rest_indx = NULL) => 0.0019371170, 0.0019371170), -0.0003524066),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => 0.1086673471,
   (f_rel_incomeover75_count_d > 0.5) => -0.0010396399,
   (f_rel_incomeover75_count_d = NULL) => 0.0613952307, 0.0613952307),
(c_famotf18_p = NULL) => -0.0015536361, 0.0002532253);

// Tree: 95 
wFDN_FLA__D_lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0094593488,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 30.45) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30897.5) => 0.1472512431,
      (f_curraddrmedianincome_d > 30897.5) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0013895971,
         (f_hh_collections_ct_i > 2.5) => 
            map(
            (NULL < c_low_ed and c_low_ed <= 38.1) => 0.2714347614,
            (c_low_ed > 38.1) => 0.0096494480,
            (c_low_ed = NULL) => 0.1147322850, 0.1147322850),
         (f_hh_collections_ct_i = NULL) => 0.0128123520, 0.0128123520),
      (f_curraddrmedianincome_d = NULL) => 0.0184787091, 0.0184787091),
   (C_INC_75K_P > 30.45) => 0.1877264817,
   (C_INC_75K_P = NULL) => 0.0259455226, 0.0259455226),
(c_rnt1000_p = NULL) => -0.0167676337, -0.0052565673);

// Tree: 96 
wFDN_FLA__D_lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45599.5) => 
   map(
   (NULL < c_construction and c_construction <= 40.1) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 41.55) => 
         map(
         (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 0.0133663303,
         (f_hh_tot_derog_i > 5.5) => 0.0993142251,
         (f_hh_tot_derog_i = NULL) => 0.0162184416, 0.0162184416),
      (c_hval_80k_p > 41.55) => -0.1080829504,
      (c_hval_80k_p = NULL) => 0.0133656228, 0.0133656228),
   (c_construction > 40.1) => 0.1484872708,
   (c_construction = NULL) => 0.0017952749, 0.0172208551),
(f_curraddrmedianincome_d > 45599.5) => -0.0099707989,
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 21.8) => -0.0630856471,
   (c_hh1_p > 21.8) => 0.0537076762,
   (c_hh1_p = NULL) => 0.0033105572, 0.0033105572), -0.0031682126);

// Tree: 97 
wFDN_FLA__D_lgt_97 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 13.05) => -0.0012751481,
      (c_unemp > 13.05) => 0.0762865493,
      (c_unemp = NULL) => 0.0220188355, -0.0001346303),
   (k_inq_adls_per_addr_i > 3.5) => -0.0619980526,
   (k_inq_adls_per_addr_i = NULL) => -0.0013998025, -0.0013998025),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1310336254,
   (r_A50_pb_average_dollars_d > 99) => 0.0066956360,
   (r_A50_pb_average_dollars_d = NULL) => 0.0606718174, 0.0606718174),
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 8.15) => 0.0396862910,
   (c_health > 8.15) => -0.0669087347,
   (c_health = NULL) => -0.0156877483, -0.0156877483), -0.0009769433);

// Tree: 98 
wFDN_FLA__D_lgt_98 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 10.15) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 191.5) => -0.0167355322,
      (c_bel_edu > 191.5) => -0.1235837063,
      (c_bel_edu = NULL) => -0.0189832774, -0.0189832774),
   (c_hh4_p > 10.15) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 0.0023808115,
      (f_rel_homeover500_count_d > 14.5) => 0.1037140455,
      (f_rel_homeover500_count_d = NULL) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 35.2) => 0.1360419079,
         (c_oldhouse > 35.2) => 0.0077650090,
         (c_oldhouse = NULL) => 0.0392054254, 0.0392054254), 0.0043145621),
   (c_hh4_p = NULL) => -0.0229643635, -0.0036473195),
(r_L72_Add_Vacant_i > 0.5) => 0.1200700355,
(r_L72_Add_Vacant_i = NULL) => -0.0029055034, -0.0029055034);

// Tree: 99 
wFDN_FLA__D_lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38111460565) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -6426) => 0.0465029959,
   (f_addrchangeincomediff_d > -6426) => 0.0037198744,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 64.45) => 0.0120518614,
      (c_high_hval > 64.45) => 0.1246843875,
      (c_high_hval = NULL) => 0.0289256991, 0.0215415883), 0.0086513211),
(f_add_input_mobility_index_i > 0.38111460565) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 31.5) => -0.0320383327,
   (f_phones_per_addr_curr_i > 31.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 63) => 0.2146609812,
      (c_lar_fam > 63) => -0.0231388327,
      (c_lar_fam = NULL) => 0.0926044396, 0.0926044396),
   (f_phones_per_addr_curr_i = NULL) => -0.0246958012, -0.0249582108),
(f_add_input_mobility_index_i = NULL) => -0.0040309079, 0.0029453458);

// Tree: 100 
wFDN_FLA__D_lgt_100 := map(
(NULL < c_transport and c_transport <= 26.7) => 
   map(
   (NULL < f_rel_count_i and f_rel_count_i <= 34.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0006300455,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0631268291,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0020610623, -0.0020610623),
   (f_rel_count_i > 34.5) => -0.0488688952,
   (f_rel_count_i = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0723640826,
      (c_pop_35_44_p > 14.55) => 0.0451546131,
      (c_pop_35_44_p = NULL) => -0.0036735774, -0.0036735774), -0.0034519296),
(c_transport > 26.7) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => -0.0143649578,
   (f_sourcerisktype_i > 4.5) => 0.1648323799,
   (f_sourcerisktype_i = NULL) => 0.0518928813, 0.0518928813),
(c_transport = NULL) => 0.0135674516, -0.0020328096);

// Tree: 101 
wFDN_FLA__D_lgt_101 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0043363674,
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0295829637,
      (r_C13_max_lres_d > 303) => 0.1898262858,
      (r_C13_max_lres_d = NULL) => 0.0739891044, 0.0739891044),
   (k_comb_age_d = NULL) => -0.0033161459, -0.0033161459),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 2.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 7.85) => 0.1353163421,
      (C_INC_35K_P > 7.85) => -0.1070300088,
      (C_INC_35K_P = NULL) => 0.0023475478, 0.0023475478),
   (f_assocrisktype_i > 2.5) => 0.1801301359,
   (f_assocrisktype_i = NULL) => 0.0598654440, 0.0598654440),
(f_nae_nothing_found_i = NULL) => -0.0024694080, -0.0024694080);

// Tree: 102 
wFDN_FLA__D_lgt_102 := map(
(NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 4.5) => 
   map(
   (NULL < c_vacant_p and c_vacant_p <= 6.35) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3347268673) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 9.5) => -0.0639245236,
         (f_rel_educationover12_count_d > 9.5) => 0.0979201343,
         (f_rel_educationover12_count_d = NULL) => -0.0010496205, -0.0010496205),
      (f_add_curr_nhood_MFD_pct_i > 0.3347268673) => 0.2135830268,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0755316589, 0.0786995191),
   (c_vacant_p > 6.35) => -0.0050853173,
   (c_vacant_p = NULL) => 0.0363467447, 0.0363467447),
(r_I60_inq_banking_recency_d > 4.5) => -0.0013026387,
(r_I60_inq_banking_recency_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0295297795,
   (k_nap_lname_verd_d > 0.5) => -0.0672105750,
   (k_nap_lname_verd_d = NULL) => -0.0174892755, -0.0174892755), 0.0003922287);

// Tree: 103 
wFDN_FLA__D_lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 128.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 51.15) => 0.1617320608,
      (r_C12_source_profile_d > 51.15) => 0.0119033618,
      (r_C12_source_profile_d = NULL) => 0.0475768615, 0.0475768615),
   (f_mos_liens_unrel_SC_fseen_d > 128.5) => -0.0020746387,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0008975125, -0.0008975125),
(f_srchaddrsrchcount_i > 32.5) => -0.0811426532,
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.45) => -0.0749199796,
   (c_pop_35_44_p > 13.45) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.1004178419,
      (k_nap_lname_verd_d > 0.5) => -0.0188328522,
      (k_nap_lname_verd_d = NULL) => 0.0424642335, 0.0424642335),
   (c_pop_35_44_p = NULL) => -0.0005997973, -0.0005997973), -0.0014369004);

// Tree: 104 
wFDN_FLA__D_lgt_104 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0102295348,
(c_pop_35_44_p > 14.75) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 323.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 115.5) => -0.0187376024,
         (r_C21_M_Bureau_ADL_FS_d > 115.5) => 
            map(
            (NULL < c_pop_0_5_p and c_pop_0_5_p <= 9.4) => 0.1344315613,
            (c_pop_0_5_p > 9.4) => -0.0153426837,
            (c_pop_0_5_p = NULL) => 0.0899272142, 0.0899272142),
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0403193632, 0.0403193632),
      (r_F01_inp_addr_address_score_d > 25) => 0.0062584487,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0081507217, 0.0081507217),
   (f_prevaddrageoldest_d > 323.5) => 0.1038213454,
   (f_prevaddrageoldest_d = NULL) => 0.0108981212, 0.0126067769),
(c_pop_35_44_p = NULL) => -0.0017289214, 0.0010733738);

// Tree: 105 
wFDN_FLA__D_lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.15) => -0.0455895236,
   (c_pop_45_54_p > 7.15) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 22.25) => 0.0183293439,
      (C_INC_15K_P > 22.25) => 
         map(
         (NULL < c_retired2 and c_retired2 <= 103.5) => 0.0161311613,
         (c_retired2 > 103.5) => 0.1499881111,
         (c_retired2 = NULL) => 0.0779738858, 0.0779738858),
      (C_INC_15K_P = NULL) => 0.0247316455, 0.0247316455),
   (c_pop_45_54_p = NULL) => 0.0131802540, 0.0178128764),
(f_corraddrnamecount_d > 4.5) => -0.0102139650,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 28.55) => 0.0645423057,
   (c_fammar18_p > 28.55) => -0.0531816626,
   (c_fammar18_p = NULL) => -0.0079688342, -0.0079688342), -0.0022690191);

// Tree: 106 
wFDN_FLA__D_lgt_106 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.85) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.2102159881) => 0.0871101350,
      (f_add_curr_nhood_MFD_pct_i > 0.2102159881) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.28488989145) => 0.2088033096,
         (f_add_curr_mobility_index_i > 0.28488989145) => 0.0580779835,
         (f_add_curr_mobility_index_i = NULL) => 0.1147199851, 0.1147199851),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1018541706, 0.1018541706),
   (c_hval_80k_p > 0.85) => -0.0181815134,
   (c_hval_80k_p = NULL) => 0.0455341103, 0.0455341103),
(r_I61_inq_collection_recency_d > 9) => -0.0060304750,
(r_I61_inq_collection_recency_d = NULL) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 14.65) => -0.0559197032,
   (c_rnt1000_p > 14.65) => 0.0575047459,
   (c_rnt1000_p = NULL) => 0.0019045257, 0.0019045257), -0.0032731222);

// Tree: 107 
wFDN_FLA__D_lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1067162314,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.19658503275) => -0.0288093598,
   (f_add_input_mobility_index_i > 0.19658503275) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 9.5) => -0.0015977103,
      (f_addrchangecrimediff_i > 9.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 188.5) => 0.0561614015,
         (c_robbery > 188.5) => -0.0921830404,
         (c_robbery = NULL) => 0.0378019409, 0.0378019409),
      (f_addrchangecrimediff_i = NULL) => 0.0099713460, 0.0025765432),
   (f_add_input_mobility_index_i = NULL) => 0.1547727548, -0.0030303438),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 8.05) => -0.0235576387,
   (c_pop_12_17_p > 8.05) => 0.0624384412,
   (c_pop_12_17_p = NULL) => 0.0154272509, 0.0154272509), -0.0023446559);

// Tree: 108 
wFDN_FLA__D_lgt_108 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30512.5) => 
   map(
   (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 4.5) => -0.0076375845,
   (f_rel_homeover50_count_d > 4.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 66.5) => 
         map(
         (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.35988481105) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13293832165) => 0.1136935541,
            (f_add_curr_nhood_BUS_pct_i > 0.13293832165) => 0.2438003251,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1358032014, 0.1358032014),
         (f_add_input_mobility_index_i > 0.35988481105) => 0.0011891290,
         (f_add_input_mobility_index_i = NULL) => 0.0982780397, 0.0982780397),
      (c_lowrent > 66.5) => -0.0226035200,
      (c_lowrent = NULL) => 0.0719266962, 0.0719266962),
   (f_rel_homeover50_count_d = NULL) => -0.0002675828, 0.0335268091),
(f_curraddrmedianincome_d > 30512.5) => -0.0002257222,
(f_curraddrmedianincome_d = NULL) => -0.0167787491, 0.0026620949);

// Tree: 109 
wFDN_FLA__D_lgt_109 := map(
(NULL < r_F00_input_dob_match_level_d and r_F00_input_dob_match_level_d <= 4.5) => 
   map(
   (NULL < c_rich_blk and c_rich_blk <= 125.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 125.5) => 0.0822145085,
      (c_asian_lang > 125.5) => -0.0514074390,
      (c_asian_lang = NULL) => 0.0095084488, 0.0095084488),
   (c_rich_blk > 125.5) => 0.1628233089,
   (c_rich_blk = NULL) => 0.0536567070, 0.0536567070),
(r_F00_input_dob_match_level_d > 4.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.0798830398,
      (f_mos_inq_banko_cm_lseen_d > 27.5) => -0.0012862938,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0289229545, -0.0289229545),
   (r_D33_Eviction_Recency_d > 549) => 0.0063058404,
   (r_D33_Eviction_Recency_d = NULL) => 0.0048942786, 0.0048942786),
(r_F00_input_dob_match_level_d = NULL) => 0.0136514442, 0.0058400034);

// Tree: 110 
wFDN_FLA__D_lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 105.5) => -0.0076731845,
(f_prevaddrageoldest_d > 105.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 792966) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6907) => 0.0078595068,
      (f_addrchangeincomediff_d > 6907) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 22.15) => -0.0392517284,
         (c_lowinc > 22.15) => 0.1869386018,
         (c_lowinc = NULL) => 0.0767937453, 0.0767937453),
      (f_addrchangeincomediff_d = NULL) => 0.0383966907, 0.0145198709),
   (f_curraddrmedianvalue_d > 792966) => 0.1795432367,
   (f_curraddrmedianvalue_d = NULL) => 0.0181451320, 0.0181451320),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 2.25) => 0.0244405216,
   (c_hval_500k_p > 2.25) => -0.0685051540,
   (c_hval_500k_p = NULL) => -0.0175530065, -0.0175530065), 0.0012522633);

// Tree: 111 
wFDN_FLA__D_lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 9.75) => 0.1591239976,
   (c_hval_125k_p > 9.75) => -0.0107428127,
   (c_hval_125k_p = NULL) => 0.0911772735, 0.0911772735),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 1.5) => -0.0856213215,
   (nf_vf_hi_risk_hit_type > 1.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52) => 0.1502153154,
         (r_C12_source_profile_d > 52) => 0.0039467917,
         (r_C12_source_profile_d = NULL) => 0.0743212701, 0.0743212701),
      (r_D33_Eviction_Recency_d > 30) => 0.0026967117,
      (r_D33_Eviction_Recency_d = NULL) => 0.0033132122, 0.0033132122),
   (nf_vf_hi_risk_hit_type = NULL) => 0.0027891388, 0.0027891388),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0228830706, 0.0033210235);

// Tree: 112 
wFDN_FLA__D_lgt_112 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 12.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => -0.0007263236,
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 8.5) => 0.1839756068,
      (f_rel_incomeover50_count_d > 8.5) => -0.0526966070,
      (f_rel_incomeover50_count_d = NULL) => 0.0646615155, 0.0646615155),
   (f_hh_lienholders_i = NULL) => -0.0000811184, -0.0000811184),
(f_util_adl_count_n > 12.5) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 110.5) => -0.0042235385,
   (c_new_homes > 110.5) => 0.1692785816,
   (c_new_homes = NULL) => 0.0838830069, 0.0838830069),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 127.5) => 0.0764949283,
   (c_ab_av_edu > 127.5) => -0.0249133718,
   (c_ab_av_edu = NULL) => 0.0364483385, 0.0364483385), 0.0013406211);

// Tree: 113 
wFDN_FLA__D_lgt_113 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 31.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0038120727,
   (f_assocsuspicousidcount_i > 13.5) => 0.1017281485,
   (f_assocsuspicousidcount_i = NULL) => -0.0030499869, -0.0030499869),
(f_rel_homeover200_count_d > 31.5) => -0.0731471730,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.09892355515) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.3232486484) => 0.1056783245,
      (f_add_curr_nhood_MFD_pct_i > 0.3232486484) => -0.0634744325,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0034911853, -0.0034911853),
   (f_add_curr_nhood_BUS_pct_i > 0.09892355515) => 0.1626457130,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.4) => -0.0599207874,
      (c_pop_35_44_p > 13.4) => 0.0590693699,
      (c_pop_35_44_p = NULL) => 0.0179369699, 0.0179369699), 0.0298908506), -0.0025121863);

// Tree: 114 
wFDN_FLA__D_lgt_114 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0054975278) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 39.5) => 0.0469573653,
      (c_no_car > 39.5) => 0.2766688704,
      (c_no_car = NULL) => 0.1595610443, 0.1595610443),
   (f_hh_members_ct_d > 1.5) => 0.0272045651,
   (f_hh_members_ct_d = NULL) => 0.0446243856, 0.0446243856),
(f_add_input_nhood_MFD_pct_i > 0.0054975278) => 
   map(
   (NULL < nf_vf_level and nf_vf_level <= 2) => -0.0080149155,
   (nf_vf_level > 2) => -0.0359547499,
   (nf_vf_level = NULL) => 0.0222926742, -0.0093812264),
(f_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => -0.0071790311,
   (f_srchaddrsrchcount_i > 18.5) => 0.1211417499,
   (f_srchaddrsrchcount_i = NULL) => -0.0204894623, -0.0047612427), -0.0051603020);

// Tree: 115 
wFDN_FLA__D_lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13229074905) => -0.0078316189,
   (f_add_curr_nhood_BUS_pct_i > 0.13229074905) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 40.5) => 
         map(
         (NULL < c_larceny and c_larceny <= 170.5) => 
            map(
            (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 54.5) => 0.1962259756,
            (f_curraddrcrimeindex_i > 54.5) => -0.0254311273,
            (f_curraddrcrimeindex_i = NULL) => 0.0472628688, 0.0472628688),
         (c_larceny > 170.5) => 0.2270744482,
         (c_larceny = NULL) => 0.0865494324, 0.0865494324),
      (f_mos_inq_banko_cm_lseen_d > 40.5) => 0.0116430877,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0240926059, 0.0240926059),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0046084877, -0.0039370069),
(c_pop_0_5_p > 21.15) => 0.1464402576,
(c_pop_0_5_p = NULL) => 0.0027715265, -0.0031384147);

// Tree: 116 
wFDN_FLA__D_lgt_116 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 100) => -0.1164054768,
(f_mos_liens_rel_SC_lseen_d > 100) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0839536596,
   (C_OWNOCC_P > 1.45) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -110409) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 0.1125367198,
         (c_pop_18_24_p > 11.15) => -0.0460728539,
         (c_pop_18_24_p = NULL) => 0.0638834764, 0.0638834764),
      (f_addrchangevaluediff_d > -110409) => -0.0020097523,
      (f_addrchangevaluediff_d = NULL) => 0.0043127988, 0.0001896203),
   (C_OWNOCC_P = NULL) => 0.0203045107, -0.0004249404),
(f_mos_liens_rel_SC_lseen_d = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 11.1) => 0.0394351828,
   (c_rnt500_p > 11.1) => -0.0871756727,
   (c_rnt500_p = NULL) => -0.0024889415, -0.0024889415), -0.0011122081);

// Tree: 117 
wFDN_FLA__D_lgt_117 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.45) => 0.0102180409,
   (c_hval_20k_p > 0.45) => 0.1814249548,
   (c_hval_20k_p = NULL) => 0.0574475344, 0.0574475344),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.75) => -0.0051798636,
   (c_hh3_p > 23.75) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95) => 0.1156625788,
      (r_F00_dob_score_d > 95) => 0.0202898657,
      (r_F00_dob_score_d = NULL) => 0.1191489585, 0.0267157907),
   (c_hh3_p = NULL) => -0.0064684277, -0.0008506302),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_med_rent and c_med_rent <= 866) => 0.0302996024,
   (c_med_rent > 866) => -0.0888270062,
   (c_med_rent = NULL) => -0.0122456149, -0.0122456149), -0.0000564956);

// Tree: 118 
wFDN_FLA__D_lgt_118 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33052.5) => -0.0610032769,
   (f_addrchangeincomediff_d > -33052.5) => -0.0053874026,
   (f_addrchangeincomediff_d = NULL) => -0.0030162872, -0.0056259293),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 3.5) => -0.0058007347,
   (c_hval_175k_p > 3.5) => 0.1424250704,
   (c_hval_175k_p = NULL) => 0.0716505869, 0.0716505869),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 83.75) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 1.85) => 0.0915453653,
      (c_hval_100k_p > 1.85) => -0.0108223385,
      (c_hval_100k_p = NULL) => 0.0412921289, 0.0412921289),
   (c_fammar_p > 83.75) => -0.0682017455,
   (c_fammar_p = NULL) => 0.0018234067, 0.0018234067), -0.0048226551);

// Tree: 119 
wFDN_FLA__D_lgt_119 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
   map(
   (NULL < c_rental and c_rental <= 188.5) => -0.0457576526,
   (c_rental > 188.5) => 0.0780524208,
   (c_rental = NULL) => -0.0378517081, -0.0378517081),
(f_mos_inq_banko_om_fseen_d > 21.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.131329516) => 0.0030915549,
   (f_add_curr_nhood_BUS_pct_i > 0.131329516) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 18.75) => 0.0305905128,
      (C_INC_25K_P > 18.75) => 0.1315024587,
      (C_INC_25K_P = NULL) => 0.0372496767, 0.0372496767),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0151513078, 0.0078244031),
(f_mos_inq_banko_om_fseen_d = NULL) => 
   map(
   (NULL < c_rural_p and c_rural_p <= 0.7) => 0.0178261428,
   (c_rural_p > 0.7) => -0.0964240274,
   (c_rural_p = NULL) => -0.0188201382, -0.0188201382), 0.0043904408);

// Tree: 120 
wFDN_FLA__D_lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1920.5) => -0.0066276445,
(c_popover18 > 1920.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 2.25) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 22.65) => 0.0142933789,
         (c_hval_150k_p > 22.65) => 0.1946698231,
         (c_hval_150k_p = NULL) => 0.0440055337, 0.0440055337),
      (f_rel_felony_count_i > 0.5) => 
         map(
         (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 0.2082292097,
         (r_A44_curr_add_naprop_d > 1.5) => 0.0738721396,
         (r_A44_curr_add_naprop_d = NULL) => 0.1326030744, 0.1326030744),
      (f_rel_felony_count_i = NULL) => 0.0613511249, 0.0613511249),
   (c_hval_500k_p > 2.25) => -0.0015529930,
   (c_hval_500k_p = NULL) => 0.0217081467, 0.0217081467),
(c_popover18 = NULL) => -0.0380744005, -0.0020748206);

// Tree: 121 
wFDN_FLA__D_lgt_121 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0029745299,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 2.4) => -0.0251512801,
      (c_hval_100k_p > 2.4) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.35502917855) => 0.1775950729,
         (f_add_curr_mobility_index_i > 0.35502917855) => -0.0321588079,
         (f_add_curr_mobility_index_i = NULL) => 0.1089718897, 0.1089718897),
      (c_hval_100k_p = NULL) => 0.0460606960, 0.0460606960),
   (f_curraddrcrimeindex_i = NULL) => -0.0017565327, -0.0017565327),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0730182967,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 4.35) => 0.0873021222,
   (C_INC_15K_P > 4.35) => -0.0184227320,
   (C_INC_15K_P = NULL) => 0.0168188861, 0.0168188861), -0.0011186501);

// Tree: 122 
wFDN_FLA__D_lgt_122 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0034238562,
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 20.5) => 0.1481881045,
      (c_many_cars > 20.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 181624.5) => 0.0774494291,
         (r_L80_Inp_AVM_AutoVal_d > 181624.5) => -0.0316152589,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0074561276, 0.0119090886),
      (c_many_cars = NULL) => 0.0247353490, 0.0247353490),
   (f_rel_felony_count_i > 1.5) => 0.1217896233,
   (f_rel_felony_count_i = NULL) => 0.0321768754, 0.0321768754),
(f_prevaddroccupantowned_i = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.5) => 0.0732025665,
   (C_INC_75K_P > 15.5) => -0.0257662549,
   (C_INC_75K_P = NULL) => 0.0097460869, 0.0097460869), -0.0006194473);

// Tree: 123 
wFDN_FLA__D_lgt_123 := map(
(NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0059112918,
(c_easiqlife > 132.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72571) => 0.1234304421,
   (f_addrchangevaluediff_d > -72571) => 0.0151950012,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 24.55) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0248834747,
         (f_srchaddrsrchcount_i > 1.5) => 
            map(
            (NULL < c_hh5_p and c_hh5_p <= 12.5) => 0.0276476996,
            (c_hh5_p > 12.5) => 0.1474376028,
            (c_hh5_p = NULL) => 0.0499647226, 0.0499647226),
         (f_srchaddrsrchcount_i = NULL) => -0.0092576114, 0.0054650044),
      (c_hval_150k_p > 24.55) => 0.1959746351,
      (c_hval_150k_p = NULL) => 0.0152047606, 0.0152047606), 0.0171020204),
(c_easiqlife = NULL) => -0.0191695947, 0.0018262006);

// Tree: 124 
wFDN_FLA__D_lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 6.5) => 0.0276265478,
   (f_rel_incomeover25_count_d > 6.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 38.85) => -0.0177411317,
      (c_med_age > 38.85) => 0.0226803615,
      (c_med_age = NULL) => -0.0023114220, -0.0023114220),
   (f_rel_incomeover25_count_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1.15) => 
         map(
         (NULL < c_robbery and c_robbery <= 109.5) => 0.1293811547,
         (c_robbery > 109.5) => -0.0062522714,
         (c_robbery = NULL) => 0.0656218519, 0.0656218519),
      (c_bigapt_p > 1.15) => -0.0332282740,
      (c_bigapt_p = NULL) => 0.0104149891, 0.0104149891), 0.0100091764),
(c_high_ed > 42.55) => -0.0280353614,
(c_high_ed = NULL) => -0.0352406578, -0.0018169782);

// Tree: 125 
wFDN_FLA__D_lgt_125 := map(
(NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 345.5) => -0.0086325784,
      (r_C21_M_Bureau_ADL_FS_d > 345.5) => 0.0316298410,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0039116587, -0.0039116587),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 61500) => 0.0108487212,
      (k_estimated_income_d > 61500) => 0.1884738142,
      (k_estimated_income_d = NULL) => 0.0805248626, 0.0805248626),
   (f_nae_nothing_found_i = NULL) => -0.0026836145, -0.0026836145),
(f_liens_unrel_SC_total_amt_i > 5693) => 0.1339070039,
(f_liens_unrel_SC_total_amt_i = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 7) => 0.0625357073,
   (c_hh5_p > 7) => -0.0427965945,
   (c_hh5_p = NULL) => 0.0186472482, 0.0186472482), -0.0017621156);

// Tree: 126 
wFDN_FLA__D_lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 6.5) => 0.0009287880,
   (r_L79_adls_per_addr_curr_i > 6.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00943851735) => 0.1941036919,
      (f_add_curr_nhood_MFD_pct_i > 0.00943851735) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 1.65) => -0.0233852512,
         (c_hh7p_p > 1.65) => 
            map(
            (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.1669687229,
            (f_inq_count_i > 2.5) => -0.0202841958,
            (f_inq_count_i = NULL) => 0.0882682208, 0.0882682208),
         (c_hh7p_p = NULL) => 0.0205544231, 0.0205544231),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0145306331, 0.0339973909),
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0004014753, 0.0028518840),
(r_L72_Add_Vacant_i > 0.5) => 0.0916200234,
(r_L72_Add_Vacant_i = NULL) => 0.0034608918, 0.0034608918);

// Tree: 127 
wFDN_FLA__D_lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0057655007,
   (f_prevaddroccupantowned_i > 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 55704.5) => 0.1486942832,
      (r_A46_Curr_AVM_AutoVal_d > 55704.5) => 0.0264950422,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 129.5) => -0.0506277245,
         (c_sub_bus > 129.5) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2661637171) => 0.1787302575,
            (f_add_curr_mobility_index_i > 0.2661637171) => -0.0623482925,
            (f_add_curr_mobility_index_i = NULL) => 0.0684695253, 0.0684695253),
         (c_sub_bus = NULL) => 0.0021679636, 0.0021679636), 0.0255093571),
   (f_prevaddroccupantowned_i = NULL) => -0.0035425391, -0.0035425391),
(f_assocsuspicousidcount_i > 16.5) => 0.0987649461,
(f_assocsuspicousidcount_i = NULL) => -0.0219925153, -0.0032939870);

// Tree: 128 
wFDN_FLA__D_lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => -0.0104348954,
(r_C13_Curr_Addr_LRes_d > 54.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 12.5) => 
      map(
      (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 4.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0199611892,
         (f_phones_per_addr_c6_i > 0.5) => 0.2349850679,
         (f_phones_per_addr_c6_i = NULL) => 0.0914823842, 0.0914823842),
      (r_C20_email_verification_d > 4.5) => -0.0726403986,
      (r_C20_email_verification_d = NULL) => 0.0105021843, 0.0113925920),
   (k_inq_per_addr_i > 12.5) => 0.0996943249,
   (k_inq_per_addr_i = NULL) => 0.0121514453, 0.0121514453),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.03850662655) => 0.0484814950,
   (f_add_input_nhood_BUS_pct_i > 0.03850662655) => -0.0413562839,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0011984535, 0.0011984535), 0.0017590699);

// Tree: 129 
wFDN_FLA__D_lgt_129 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 4.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 32.5) => 
      map(
      (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 3.5) => 0.1101766814,
      (r_C12_source_profile_index_d > 3.5) => -0.0466944601,
      (r_C12_source_profile_index_d = NULL) => -0.0011710700, -0.0011710700),
   (c_rnt1000_p > 32.5) => 0.1644870793,
   (c_rnt1000_p = NULL) => 0.0387643767, 0.0387643767),
(r_I61_inq_collection_recency_d > 4.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.005) => -0.0073570275,
   (c_hhsize > 4.005) => 0.0626046991,
   (c_hhsize = NULL) => 0.0246278586, -0.0055992327),
(r_I61_inq_collection_recency_d = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0584392688,
   (c_hval_250k_p > 8.05) => 0.0361028640,
   (c_hval_250k_p = NULL) => -0.0148479860, -0.0148479860), -0.0045362890);

// Tree: 130 
wFDN_FLA__D_lgt_130 := map(
(NULL < c_lar_fam and c_lar_fam <= 181.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 40.55) => -0.0027338748,
   (c_famotf18_p > 40.55) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 2.5) => -0.0249646892,
      (f_rel_bankrupt_count_i > 2.5) => -0.1048208820,
      (f_rel_bankrupt_count_i = NULL) => -0.0421677520, -0.0421677520),
   (c_famotf18_p = NULL) => -0.0039918210, -0.0039918210),
(c_lar_fam > 181.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 7.65) => -0.0413303073,
   (C_INC_15K_P > 7.65) => 0.1643692792,
   (C_INC_15K_P = NULL) => 0.0833361088, 0.0833361088),
(c_lar_fam = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 0.1405918196,
   (r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0676942650,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0364487773, 0.0364487773), -0.0021394202);

// Tree: 131 
wFDN_FLA__D_lgt_131 := map(
(NULL < c_white_col and c_white_col <= 11.65) => -0.1051493690,
(c_white_col > 11.65) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 822417.5) => 0.0005331663,
   (c_med_hval > 822417.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 51.5) => 
         map(
         (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.6) => 
            map(
            (NULL < c_fammar18_p and c_fammar18_p <= 36.7) => 0.0718394377,
            (c_fammar18_p > 36.7) => 0.3576694966,
            (c_fammar18_p = NULL) => 0.2128231830, 0.2128231830),
         (c_pop_0_5_p > 7.6) => -0.0297408693,
         (c_pop_0_5_p = NULL) => 0.1380137089, 0.1380137089),
      (c_born_usa > 51.5) => -0.0292565536,
      (c_born_usa = NULL) => 0.0724361628, 0.0724361628),
   (c_med_hval = NULL) => 0.0025870375, 0.0025870375),
(c_white_col = NULL) => -0.0081938310, 0.0017290577);

// Tree: 132 
wFDN_FLA__D_lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0029266231,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2298085977,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 0.0005011918,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < c_rental and c_rental <= 121.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.9) => 0.1496568852,
         (c_pop_65_74_p > 6.9) => 0.0439053439,
         (c_pop_65_74_p = NULL) => 0.1004277194, 0.1004277194),
      (c_rental > 121.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 64.5) => 0.0493349162,
         (c_no_labfor > 64.5) => -0.0873580311,
         (c_no_labfor = NULL) => -0.0238078012, -0.0238078012),
      (c_rental = NULL) => 0.0388501135, 0.0388501135),
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0111737422, 0.0020874550), 0.0007111959);

// Tree: 133 
wFDN_FLA__D_lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 21.2) => 
      map(
      (NULL < c_rape and c_rape <= 66) => 0.2281055698,
      (c_rape > 66) => 0.0492729485,
      (c_rape = NULL) => 0.1290598103, 0.1290598103),
   (c_hh1_p > 21.2) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => -0.1033033659,
      (r_L79_adls_per_addr_curr_i > 1.5) => 0.0468500040,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0002234313, 0.0002234313),
   (c_hh1_p = NULL) => 0.0525632102, 0.0525632102),
(f_mos_liens_unrel_SC_fseen_d > 127.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0094477391,
   (f_bus_name_nover_i > 0.5) => 0.0170555343,
   (f_bus_name_nover_i = NULL) => 0.0013233654, 0.0013233654),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0093742453, 0.0024655080);

// Tree: 134 
wFDN_FLA__D_lgt_134 := map(
(NULL < f_idverrisktype_i and f_idverrisktype_i <= 5.5) => 0.0051282332,
(f_idverrisktype_i > 5.5) => 
   map(
   (NULL < c_preschl and c_preschl <= 186.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.30097863295) => 
         map(
         (NULL < c_hval_100k_p and c_hval_100k_p <= 4.95) => 
            map(
            (NULL < c_highinc and c_highinc <= 9.4) => 0.1214616702,
            (c_highinc > 9.4) => 0.0088990698,
            (c_highinc = NULL) => 0.0339129810, 0.0339129810),
         (c_hval_100k_p > 4.95) => -0.0546120602,
         (c_hval_100k_p = NULL) => 0.0053395519, 0.0053395519),
      (f_add_input_mobility_index_i > 0.30097863295) => -0.0526718987,
      (f_add_input_mobility_index_i = NULL) => -0.0220917499, -0.0220917499),
   (c_preschl > 186.5) => -0.1079251740,
   (c_preschl = NULL) => 0.0525449356, -0.0218182123),
(f_idverrisktype_i = NULL) => -0.0017333112, 0.0026272690);

// Tree: 135 
wFDN_FLA__D_lgt_135 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.25) => -0.0128630726,
   (c_pop_12_17_p > 10.25) => 0.0210202444,
   (c_pop_12_17_p = NULL) => 0.0068122871, -0.0047098308),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 111.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 6.5) => -0.0071988364,
      (f_srchaddrsrchcount_i > 6.5) => 0.1364187283,
      (f_srchaddrsrchcount_i = NULL) => 0.0052896475, 0.0052896475),
   (c_bel_edu > 111.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 156.5) => 0.0741827847,
      (f_curraddrmurderindex_i > 156.5) => 0.2181518921,
      (f_curraddrmurderindex_i = NULL) => 0.1020837745, 0.1020837745),
   (c_bel_edu = NULL) => 0.0345083875, 0.0345083875),
(k_comb_age_d = NULL) => -0.0019827362, -0.0019827362);

// Tree: 136 
wFDN_FLA__D_lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 3181.5) => -0.0015582353,
   (r_A50_pb_total_dollars_d > 3181.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0281257514,
      (f_rel_criminal_count_i > 2.5) => 0.1094277944,
      (f_rel_criminal_count_i = NULL) => 0.0453694158, 0.0453694158),
   (r_A50_pb_total_dollars_d = NULL) => 0.0200257570, 0.0200257570),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 204269.5) => -0.0104638264,
   (f_addrchangevaluediff_d > 204269.5) => 0.1109630715,
   (f_addrchangevaluediff_d = NULL) => -0.0069902665, -0.0088216242),
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_business and c_business <= 30.5) => -0.0383678799,
   (c_business > 30.5) => 0.0850812983,
   (c_business = NULL) => 0.0093898314, 0.0093898314), -0.0031049160);

// Tree: 137 
wFDN_FLA__D_lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 0.0001119378,
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1169966851,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 103.5) => -0.0631950169,
      (c_blue_empl > 103.5) => 0.0525903769,
      (c_blue_empl = NULL) => -0.0045199862, -0.0045199862),
   (C_INC_75K_P = NULL) => -0.0377273926, -0.0377273926),
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
      map(
      (NULL < c_assault and c_assault <= 88) => -0.0363078347,
      (c_assault > 88) => 0.0892938627,
      (c_assault = NULL) => 0.0159424714, 0.0159424714),
   (r_L77_Apartment_i > 0.5) => -0.1001460282,
   (r_L77_Apartment_i = NULL) => -0.0148209810, -0.0148209810), -0.0007529170);

// Tree: 138 
wFDN_FLA__D_lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 75.45) => 0.0024152804,
   (c_low_ed > 75.45) => -0.0483003873,
   (c_low_ed = NULL) => -0.0087149923, 0.0005084835),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 26.55) => -0.0683082725,
      (c_famotf18_p > 26.55) => 0.0798527694,
      (c_famotf18_p = NULL) => -0.0094592605, -0.0094592605),
   (f_vardobcountnew_i > 0.5) => 0.1393603811,
   (f_vardobcountnew_i = NULL) => 0.0338248836, 0.0338248836),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0259556286,
   (c_construction > 7.45) => -0.0681121947,
   (c_construction = NULL) => -0.0095534173, -0.0095534173), 0.0011630504);

// Tree: 139 
wFDN_FLA__D_lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => -0.0057111669,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity']) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 4.85) => 0.0474291540,
      (c_hval_175k_p > 4.85) => 0.1942721595,
      (c_hval_175k_p = NULL) => 0.1010214918, 0.1010214918),
   (nf_seg_FraudPoint_3_0 = '') => 0.0542462230, 0.0542462230),
(r_C21_M_Bureau_ADL_FS_d > 7.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0037568425,
   (c_lar_fam > 181.5) => 0.0836349776,
   (c_lar_fam = NULL) => -0.0415409658, -0.0036511691),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 17.65) => 0.0319866891,
   (c_hh3_p > 17.65) => -0.0614127761,
   (c_hh3_p = NULL) => -0.0039808068, -0.0039808068), -0.0025105341);

// Tree: 140 
wFDN_FLA__D_lgt_140 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 198.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 2.5) => -0.0026055505,
      (f_inq_Communications_count24_i > 2.5) => 0.0681200312,
      (f_inq_Communications_count24_i = NULL) => -0.0020871122, -0.0020871122),
   (c_work_home > 198.5) => 0.1707459978,
   (c_work_home = NULL) => -0.0333904952, -0.0017964589),
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => 0.1024308984,
      (f_adl_util_conv_n > 0.5) => -0.1111524526,
      (f_adl_util_conv_n = NULL) => 0.0126899947, 0.0126899947),
   (r_C23_inp_addr_occ_index_d > 2) => 0.1490128640,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0588883004, 0.0588883004),
(f_srchcomponentrisktype_i = NULL) => -0.0075273495, -0.0010184713);

// Tree: 141 
wFDN_FLA__D_lgt_141 := map(
(NULL < c_rich_blk and c_rich_blk <= 193.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => -0.0414427304,
   (nf_vf_hi_risk_index > 3.5) => -0.0030454699,
   (nf_vf_hi_risk_index = NULL) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 11.45) => 0.0570726624,
      (c_newhouse > 11.45) => -0.0463291713,
      (c_newhouse = NULL) => 0.0018784403, 0.0018784403), -0.0037288857),
(c_rich_blk > 193.5) => 
   map(
   (NULL < f_hh_age_65_plus_d and f_hh_age_65_plus_d <= 0.5) => 
      map(
      (NULL < c_professional and c_professional <= 1.55) => 0.1316898493,
      (c_professional > 1.55) => -0.0479268986,
      (c_professional = NULL) => 0.0002177967, 0.0002177967),
   (f_hh_age_65_plus_d > 0.5) => 0.2054902493,
   (f_hh_age_65_plus_d = NULL) => 0.0429479807, 0.0429479807),
(c_rich_blk = NULL) => -0.0312932049, -0.0034740709);

// Tree: 142 
wFDN_FLA__D_lgt_142 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
      map(
      (NULL < c_business and c_business <= 7.5) => 0.0099727716,
      (c_business > 7.5) => -0.0965519737,
      (c_business = NULL) => -0.0645945501, -0.0645945501),
   (f_util_adl_count_n > 3.5) => 0.0284053700,
   (f_util_adl_count_n = NULL) => -0.0363557080, -0.0363557080),
(nf_vf_hi_risk_index > 3.5) => 0.0020618952,
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 15.65) => -0.0688248812,
   (c_lowinc > 15.65) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 30.5) => -0.0313068139,
      (k_comb_age_d > 30.5) => 0.0834193135,
      (k_comb_age_d = NULL) => 0.0250319094, 0.0250319094),
   (c_lowinc = NULL) => -0.0051160294, -0.0051160294), 0.0012012286);

// Tree: 143 
wFDN_FLA__D_lgt_143 := map(
(NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 0.5) => 0.0711051991,
(f_hh_age_18_plus_d > 0.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0046206877,
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 25.25) => -0.0031900320,
      (c_rnt1000_p > 25.25) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 30) => 0.1710187534,
         (c_many_cars > 30) => 0.0572360121,
         (c_many_cars = NULL) => 0.0748767472, 0.0748767472),
      (c_rnt1000_p = NULL) => 0.0212729992, 0.0212729992),
   (f_hh_collections_ct_i = NULL) => -0.0020053109, -0.0020053109),
(f_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 141) => -0.0315872041,
   (c_larceny > 141) => 0.0618578952,
   (c_larceny = NULL) => -0.0023497804, -0.0023497804), -0.0016991307);

// Tree: 144 
wFDN_FLA__D_lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.65) => -0.0067572673,
   (c_unemp > 8.65) => 0.0287611160,
   (c_unemp = NULL) => -0.0045912975, -0.0045912975),
(c_rnt2001_p > 49) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.95) => -0.0737300404,
   (c_pop_45_54_p > 12.95) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 61.5) => 0.0255962014,
      (r_C13_Curr_Addr_LRes_d > 61.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 6.45) => 0.0765666282,
         (c_pop_18_24_p > 6.45) => 0.3603485879,
         (c_pop_18_24_p = NULL) => 0.2044683565, 0.2044683565),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.1327685475, 0.1327685475),
   (c_pop_45_54_p = NULL) => 0.0884701706, 0.0884701706),
(c_rnt2001_p = NULL) => 0.0027637732, -0.0022060358);

// Tree: 145 
wFDN_FLA__D_lgt_145 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 36.75) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 59.5) => -0.0045523703,
   (k_comb_age_d > 59.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 229.85) => 0.0047901806,
         (c_cpiall > 229.85) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 377.5) => 0.2626554082,
            (f_M_Bureau_ADL_FS_all_d > 377.5) => -0.0257389205,
            (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1393288861, 0.1393288861),
         (c_cpiall = NULL) => 0.0153734309, 0.0153734309),
      (k_inq_per_addr_i > 3.5) => 0.1215662218,
      (k_inq_per_addr_i = NULL) => 0.0224087671, 0.0224087671),
   (k_comb_age_d = NULL) => 0.0000622599, 0.0000622599),
(C_INC_15K_P > 36.75) => -0.0629153630,
(C_INC_15K_P = NULL) => 0.0015985072, -0.0011011781);

// Tree: 146 
wFDN_FLA__D_lgt_146 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => -0.0030134540,
      (f_fp_prevaddrcrimeindex_i > 197.5) => -0.1082371364,
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0034752615, -0.0034752615),
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 0.0884947531,
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0028221497, -0.0028221497),
(f_assocsuspicousidcount_i > 13.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 29.65) => 0.0040813291,
   (c_hh2_p > 29.65) => 0.1421284244,
   (c_hh2_p = NULL) => 0.0731048768, 0.0731048768),
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 9.4) => -0.0078489705,
   (c_hval_750k_p > 9.4) => 0.0920711930,
   (c_hval_750k_p = NULL) => 0.0239727377, 0.0239727377), -0.0018042930);

// Tree: 147 
wFDN_FLA__D_lgt_147 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 56.85) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => -0.0360350800,
   (nf_vf_hi_risk_index > 4.5) => -0.0013263176,
   (nf_vf_hi_risk_index = NULL) => 0.0168510890, -0.0019364189),
(c_fammar18_p > 56.85) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 165.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 42) => 0.1237195437,
      (f_mos_inq_banko_cm_lseen_d > 42) => -0.0149463317,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0069229832, 0.0069229832),
   (c_lar_fam > 165.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 39) => 0.0144313923,
      (f_fp_prevaddrcrimeindex_i > 39) => 0.2821512280,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.1577774461, 0.1577774461),
   (c_lar_fam = NULL) => 0.0343317518, 0.0343317518),
(c_fammar18_p = NULL) => -0.0448011445, -0.0008221847);

// Tree: 148 
wFDN_FLA__D_lgt_148 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0069652128,
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 8.35) => 0.0024342545,
   (c_hval_150k_p > 8.35) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 43500) => 
         map(
         (NULL < c_families and c_families <= 662.5) => 
            map(
            (NULL < c_hval_80k_p and c_hval_80k_p <= 0.95) => 0.1372623644,
            (c_hval_80k_p > 0.95) => 0.0137029354,
            (c_hval_80k_p = NULL) => 0.0618962397, 0.0618962397),
         (c_families > 662.5) => 0.2283320502,
         (c_families = NULL) => 0.0976772282, 0.0976772282),
      (k_estimated_income_d > 43500) => 0.0043465280,
      (k_estimated_income_d = NULL) => 0.0644147145, 0.0644147145),
   (c_hval_150k_p = NULL) => 0.0200697809, 0.0200697809),
(k_inq_ssns_per_addr_i = NULL) => -0.0033143697, -0.0033143697);

// Tree: 149 
wFDN_FLA__D_lgt_149 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 0.0535935665,
(f_rel_under100miles_cnt_d > 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 47510) => -0.0537797991,
   (r_L80_Inp_AVM_AutoVal_d > 47510) => 0.0060157958,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0013801291, 0.0013541467),
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 153.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 139.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 54.65) => 0.1164842641,
         (c_oldhouse > 54.65) => -0.0209736450,
         (c_oldhouse = NULL) => 0.0237415784, 0.0237415784),
      (c_bargains > 139.5) => 0.1678185033,
      (c_bargains = NULL) => 0.0647289795, 0.0647289795),
   (c_asian_lang > 153.5) => -0.0498296920,
   (c_asian_lang = NULL) => 0.0181437396, 0.0181437396), 0.0034679069);

// Tree: 150 
wFDN_FLA__D_lgt_150 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0014380186,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 59.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 11.5) => -0.0407695909,
      (f_srchfraudsrchcount_i > 11.5) => 0.0665959364,
      (f_srchfraudsrchcount_i = NULL) => 0.0078804137, 0.0078804137),
   (c_burglary > 59.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 173.5) => -0.0706863395,
      (f_curraddrcartheftindex_i > 173.5) => 0.0445648048,
      (f_curraddrcartheftindex_i = NULL) => -0.0526349554, -0.0526349554),
   (c_burglary = NULL) => -0.0304613851, -0.0304613851),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.4) => -0.0486114725,
   (c_hval_250k_p > 6.4) => 0.0554622514,
   (c_hval_250k_p = NULL) => -0.0022002172, -0.0022002172), 0.0000578185);

// Tree: 151 
wFDN_FLA__D_lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 80.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.35) => 0.0318711959,
      (c_hh2_p > 17.35) => -0.0045019681,
      (c_hh2_p = NULL) => -0.0032537534, -0.0023915392),
   (f_bus_addr_match_count_d > 80.5) => 0.1096135736,
   (f_bus_addr_match_count_d = NULL) => -0.0018868086, -0.0018868086),
(r_C14_addrs_10yr_i > 10.5) => 0.1013092589,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 9.95) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 8.05) => -0.0214922076,
      (c_hval_250k_p > 8.05) => 0.0704565687,
      (c_hval_250k_p = NULL) => 0.0187828762, 0.0187828762),
   (c_construction > 9.95) => -0.0676450982,
   (c_construction = NULL) => -0.0064884613, -0.0064884613), -0.0015300051);

// Tree: 152 
wFDN_FLA__D_lgt_152 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 153.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 18.6) => 0.1740664181,
      (c_rnt750_p > 18.6) => 
         map(
         (NULL < c_rental and c_rental <= 120) => -0.0474923221,
         (c_rental > 120) => 0.1196804997,
         (c_rental = NULL) => 0.0337505446, 0.0337505446),
      (c_rnt750_p = NULL) => 0.0978542431, 0.0978542431),
   (c_asian_lang > 153.5) => -0.0290853672,
   (c_asian_lang = NULL) => 0.0290706868, 0.0290706868),
(r_C10_M_Hdr_FS_d > 15.5) => -0.0010210300,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 63.5) => 0.0471538609,
   (c_no_car > 63.5) => -0.0496308098,
   (c_no_car = NULL) => -0.0112940247, -0.0112940247), -0.0001278823);

// Tree: 153 
wFDN_FLA__D_lgt_153 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 10.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.0344397500,
   (r_I60_inq_recency_d > 4.5) => 0.0006374847,
   (r_I60_inq_recency_d = NULL) => 0.0050880227, 0.0050880227),
(f_rel_incomeover50_count_d > 10.5) => -0.0220472941,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => -0.1240018300,
   (f_corraddrnamecount_d > 3.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.15) => -0.0675180911,
      (c_pop_35_44_p > 13.15) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 61009.5) => 0.1519212936,
         (f_prevaddrmedianincome_d > 61009.5) => -0.0194723730,
         (f_prevaddrmedianincome_d = NULL) => 0.0591485750, 0.0591485750),
      (c_pop_35_44_p = NULL) => 0.0063143506, 0.0063143506),
   (f_corraddrnamecount_d = NULL) => -0.0170250360, -0.0205699495), -0.0001274756);

// Tree: 154 
wFDN_FLA__D_lgt_154 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 32.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 13.75) => -0.0066524025,
   (c_hval_500k_p > 13.75) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 0.0200571018,
      (k_comb_age_d > 71.5) => 
         map(
         (NULL < c_med_yearblt and c_med_yearblt <= 1975.5) => 0.2266004487,
         (c_med_yearblt > 1975.5) => -0.0426851289,
         (c_med_yearblt = NULL) => 0.1010859845, 0.1010859845),
      (k_comb_age_d = NULL) => 0.0236543208, 0.0236543208),
   (c_hval_500k_p = NULL) => 0.0235750907, 0.0006405210),
(f_rel_under500miles_cnt_d > 32.5) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 142.5) => -0.1003887656,
   (c_for_sale > 142.5) => 0.0407740265,
   (c_for_sale = NULL) => -0.0593530702, -0.0593530702),
(f_rel_under500miles_cnt_d = NULL) => -0.0090643835, -0.0005297518);

// Tree: 155 
wFDN_FLA__D_lgt_155 := map(
(NULL < c_unempl and c_unempl <= 190.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34062.5) => -0.0027391172,
   (f_addrchangevaluediff_d > 34062.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 26.95) => 0.1139303883,
      (c_hh2_p > 26.95) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 112.5) => 0.0954347249,
         (c_lux_prod > 112.5) => -0.0461510888,
         (c_lux_prod = NULL) => -0.0058419604, -0.0058419604),
      (c_hh2_p = NULL) => 0.0262844769, 0.0262844769),
   (f_addrchangevaluediff_d = NULL) => -0.0115917236, -0.0036885679),
(c_unempl > 190.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 130) => -0.0451852006,
   (c_burglary > 130) => 0.1392788674,
   (c_burglary = NULL) => 0.0578072374, 0.0578072374),
(c_unempl = NULL) => 0.0158313017, -0.0026682557);

// Tree: 156 
wFDN_FLA__D_lgt_156 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0110758666,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < C_INC_50K_P and C_INC_50K_P <= 15.25) => 0.0011515613,
   (C_INC_50K_P > 15.25) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => 0.0504279095,
      (r_pb_order_freq_d > 126.5) => -0.0524822374,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 2.25) => 0.0213873511,
         (c_pop_85p_p > 2.25) => 0.1499872210,
         (c_pop_85p_p = NULL) => 0.0505931824, 0.0505931824), 0.0324928053),
   (C_INC_50K_P = NULL) => 0.0109916101, 0.0109916101),
(f_hh_criminals_i = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 113) => -0.0519925279,
   (c_preschl > 113) => 0.0526263186,
   (c_preschl = NULL) => 0.0027418355, 0.0027418355), -0.0036965619);

// Tree: 157 
wFDN_FLA__D_lgt_157 := map(
(NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 9.5) => -0.0153678479,
   (f_rel_homeover500_count_d > 9.5) => 0.0874519136,
   (f_rel_homeover500_count_d = NULL) => 0.0017699190, -0.0126813708),
(f_util_add_curr_conv_n > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 14.5) => 
      map(
      (NULL < c_hval_1001k_p and c_hval_1001k_p <= 22.8) => 0.0078484836,
      (c_hval_1001k_p > 22.8) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 113.5) => 0.0263014467,
         (f_prevaddrcartheftindex_i > 113.5) => 0.2771589102,
         (f_prevaddrcartheftindex_i = NULL) => 0.1056867199, 0.1056867199),
      (c_hval_1001k_p = NULL) => 0.0214654532, 0.0113167225),
   (f_inq_HighRiskCredit_count_i > 14.5) => 0.0962206365,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0119627435, 0.0119627435),
(f_util_add_curr_conv_n = NULL) => 0.0011065109, 0.0011065109);

// Tree: 158 
wFDN_FLA__D_lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 0.0007497229,
      (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0660410973,
      (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => -0.0008043101, -0.0008043101),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 2825) => -0.1606559884,
      (r_A50_pb_average_dollars_d > 2825) => 0.0156227689,
      (r_A50_pb_average_dollars_d = NULL) => -0.0663958196, -0.0663958196),
   (r_I60_inq_comm_count12_i = NULL) => -0.0015638130, -0.0015638130),
(r_D33_eviction_count_i > 3.5) => 0.0754401690,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 1.6) => 0.0462769516,
   (c_hval_80k_p > 1.6) => -0.0469829396,
   (c_hval_80k_p = NULL) => 0.0143386327, 0.0143386327), -0.0008807600);

// Tree: 159 
wFDN_FLA__D_lgt_159 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 0.0003775408,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 12.4) => 
      map(
      (NULL < c_families and c_families <= 242) => 0.1578708995,
      (c_families > 242) => 
         map(
         (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 118) => 0.1150850893,
         (f_prevaddrcartheftindex_i > 118) => -0.0446860207,
         (f_prevaddrcartheftindex_i = NULL) => 0.0529518798, 0.0529518798),
      (c_families = NULL) => 0.0807875381, 0.0807875381),
   (c_rnt1250_p > 12.4) => -0.0330120987,
   (c_rnt1250_p = NULL) => 0.0436364539, 0.0436364539),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0471301588,
   (c_many_cars > 91.5) => -0.0408739663,
   (c_many_cars = NULL) => 0.0071773658, 0.0071773658), 0.0014943767);

// Tree: 160 
wFDN_FLA__D_lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.3) => -0.0044205546,
(r_C12_source_profile_d > 81.3) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 14.65) => -0.0313911873,
   (C_RENTOCC_P > 14.65) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 366.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 53.5) => 0.2134244399,
         (c_no_labfor > 53.5) => 0.0308350445,
         (c_no_labfor = NULL) => 0.0707889604, 0.0707889604),
      (f_M_Bureau_ADL_FS_noTU_d > 366.5) => 0.2975252529,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.1020186761, 0.1020186761),
   (C_RENTOCC_P = NULL) => 0.0422621748, 0.0422621748),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 85.5) => 0.0481883661,
   (c_very_rich > 85.5) => -0.0400458776,
   (c_very_rich = NULL) => -0.0055875339, -0.0055875339), -0.0008874232);

// Tree: 161 
wFDN_FLA__D_lgt_161 := map(
(NULL < c_med_age and c_med_age <= 28.05) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 28.5) => -0.1220549621,
   (f_mos_inq_banko_cm_fseen_d > 28.5) => -0.0274444559,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0334782892, -0.0334782892),
(c_med_age > 28.05) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 129.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.45) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 50.55) => 0.1178838310,
         (c_civ_emp > 50.55) => -0.0044531814,
         (c_civ_emp = NULL) => 0.0371333278, 0.0371333278),
      (c_high_ed > 5.45) => -0.0164440376,
      (c_high_ed = NULL) => -0.0142153251, -0.0142153251),
   (c_easiqlife > 129.5) => 0.0158357812,
   (c_easiqlife = NULL) => -0.0030309882, -0.0030309882),
(c_med_age = NULL) => -0.0346393959, -0.0056565572);

// Tree: 162 
wFDN_FLA__D_lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0012152049,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.65) => 
      map(
      (NULL < c_rental and c_rental <= 103.5) => 0.0519552834,
      (c_rental > 103.5) => -0.0833488030,
      (c_rental = NULL) => -0.0229451930, -0.0229451930),
   (c_pop_45_54_p > 12.65) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 6.5) => 0.0300682196,
      (f_rel_homeover150_count_d > 6.5) => 0.1440183365,
      (f_rel_homeover150_count_d = NULL) => 0.0842412260, 0.0842412260),
   (c_pop_45_54_p = NULL) => 0.0435467211, 0.0435467211),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 100.5) => 0.0526140465,
   (c_rich_fam > 100.5) => -0.0319292503,
   (c_rich_fam = NULL) => 0.0118520998, 0.0118520998), 0.0000260552);

// Tree: 163 
wFDN_FLA__D_lgt_163 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.5141160012) => 
      map(
      (NULL < c_incollege and c_incollege <= 8.35) => 
         map(
         (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 3.5) => 
            map(
            (NULL < c_unempl and c_unempl <= 120) => 0.0235838067,
            (c_unempl > 120) => 0.1938335684,
            (c_unempl = NULL) => 0.0722265958, 0.0722265958),
         (f_componentcharrisktype_i > 3.5) => -0.0221227194,
         (f_componentcharrisktype_i = NULL) => 0.0104769526, 0.0104769526),
      (c_incollege > 8.35) => 0.1016203655,
      (c_incollege = NULL) => -0.0029297817, 0.0307854905),
   (f_add_input_mobility_index_i > 0.5141160012) => -0.0267617351,
   (f_add_input_mobility_index_i = NULL) => 0.0218999603, 0.0218999603),
(f_corraddrnamecount_d > 1.5) => -0.0050145053,
(f_corraddrnamecount_d = NULL) => -0.0147468548, -0.0030823613);

// Tree: 164 
wFDN_FLA__D_lgt_164 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 6436) => 0.0008361367,
(f_addrchangeincomediff_d > 6436) => 
   map(
   (NULL < f_inq_Banking_count_i and f_inq_Banking_count_i <= 1.5) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0404499922,
      (r_F03_input_add_not_most_rec_i > 0.5) => 0.2513051780,
      (r_F03_input_add_not_most_rec_i = NULL) => 0.0777251834, 0.0777251834),
   (f_inq_Banking_count_i > 1.5) => -0.0867386057,
   (f_inq_Banking_count_i = NULL) => 0.0536482773, 0.0536482773),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 51.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 130500) => -0.0102437545,
      (k_estimated_income_d > 130500) => 0.2138093282,
      (k_estimated_income_d = NULL) => 0.0082194935, -0.0031730748),
   (c_hh2_p > 51.25) => 0.1494262776,
   (c_hh2_p = NULL) => 0.0299582313, 0.0062233470), 0.0039336831);

// Tree: 165 
wFDN_FLA__D_lgt_165 := map(
(NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 9.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 0.0014320410,
   (k_inq_ssns_per_addr_i > 1.5) => 0.0353187459,
   (k_inq_ssns_per_addr_i = NULL) => 0.0056657049, 0.0056657049),
(f_rel_homeover150_count_d > 9.5) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 25.45) => -0.0232912197,
   (c_hval_125k_p > 25.45) => 0.1374949976,
   (c_hval_125k_p = NULL) => -0.0201010170, -0.0201010170),
(f_rel_homeover150_count_d = NULL) => 
   map(
   (NULL < c_child and c_child <= 17.75) => -0.0840476804,
   (c_child > 17.75) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.30977956995) => -0.0041458679,
      (f_add_curr_mobility_index_i > 0.30977956995) => 0.1832355411,
      (f_add_curr_mobility_index_i = NULL) => 0.0407971025, 0.0510091351),
   (c_child = NULL) => 0.0141754581, 0.0141754581), 0.0007989077);

// Tree: 166 
wFDN_FLA__D_lgt_166 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 45.5) => 0.1226875033,
   (f_mos_inq_banko_cm_lseen_d > 45.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 82.5) => 0.1308530225,
      (c_rich_fam > 82.5) => -0.0594493536,
      (c_rich_fam = NULL) => 0.0137438680, 0.0137438680),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0443408039, 0.0443408039),
(r_D32_Mos_Since_Crim_LS_d > 11.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 194.5) => 
      map(
      (NULL < c_info and c_info <= 23.35) => 0.0005282642,
      (c_info > 23.35) => 0.1509011975,
      (c_info = NULL) => 0.0016011417, 0.0016011417),
   (c_asian_lang > 194.5) => -0.0516160412,
   (c_asian_lang = NULL) => 0.0291612215, -0.0001679256),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0273483422, 0.0002838015);

// Tree: 167 
wFDN_FLA__D_lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 206.5) => -0.0812205963,
      (f_mos_liens_unrel_CJ_lseen_d > 206.5) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 0.0181113078,
         (f_hh_collections_ct_i > 2.5) => 0.1218249860,
         (f_hh_collections_ct_i = NULL) => 0.0270388401, 0.0270388401),
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0195431324, 0.0195431324),
   (c_rnt750_p > 57.25) => 0.1496768038,
   (c_rnt750_p = NULL) => 0.0282975794, 0.0282975794),
(c_many_cars > 22.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => -0.0063278883,
   (k_inq_adls_per_addr_i > 4.5) => -0.0805139726,
   (k_inq_adls_per_addr_i = NULL) => -0.0070303583, -0.0070303583),
(c_many_cars = NULL) => 0.0042647424, -0.0037130674);

// Tree: 168 
wFDN_FLA__D_lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0061037124,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 127.5) => -0.0085734570,
      (c_easiqlife > 127.5) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => -0.0052467646,
         (f_sourcerisktype_i > 3.5) => 0.1365992625,
         (f_sourcerisktype_i = NULL) => 0.0823447913, 0.0823447913),
      (c_easiqlife = NULL) => 0.0172501816, 0.0172501816),
   (r_C12_source_profile_d > 81.05) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 1.05) => 0.3371464373,
      (c_hval_80k_p > 1.05) => 0.0301994233,
      (c_hval_80k_p = NULL) => 0.1851924700, 0.1851924700),
   (r_C12_source_profile_d = NULL) => 0.0368596280, 0.0368596280),
(c_hval_150k_p = NULL) => -0.0102086815, -0.0032425286);

// Tree: 169 
wFDN_FLA__D_lgt_169 := map(
(NULL < f_vf_lo_risk_ct_d and f_vf_lo_risk_ct_d <= 3.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 36.85) => -0.0034972042,
   (c_hval_500k_p > 36.85) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 47) => 0.2334452505,
         (c_rich_wht > 47) => 0.0602212766,
         (c_rich_wht = NULL) => 0.1165190681, 0.1165190681),
      (f_rel_incomeover100_count_d > 0.5) => -0.0154941047,
      (f_rel_incomeover100_count_d = NULL) => 0.0466297413, 0.0466297413),
   (c_hval_500k_p = NULL) => 0.0136776135, -0.0017473322),
(f_vf_lo_risk_ct_d > 3.5) => -0.0942601399,
(f_vf_lo_risk_ct_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 15.6) => 0.0445261819,
   (c_hh3_p > 15.6) => -0.0521049787,
   (c_hh3_p = NULL) => -0.0028166015, -0.0028166015), -0.0021562475);

// Tree: 170 
wFDN_FLA__D_lgt_170 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 7.95) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => 
         map(
         (NULL < c_burglary and c_burglary <= 76.5) => 0.0185675640,
         (c_burglary > 76.5) => 
            map(
            (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 117.5) => 0.2488076976,
            (f_curraddrburglaryindex_i > 117.5) => 0.0852253470,
            (f_curraddrburglaryindex_i = NULL) => 0.1444943146, 0.1444943146),
         (c_burglary = NULL) => 0.0931507897, 0.0931507897),
      (k_comb_age_d > 27.5) => 0.0235574709,
      (k_comb_age_d = NULL) => 0.0402055646, 0.0402055646),
   (c_femdiv_p > 7.95) => -0.0442914716,
   (c_femdiv_p = NULL) => 0.0270257843, 0.0270257843),
(r_I60_inq_comm_recency_d > 549) => -0.0018005596,
(r_I60_inq_comm_recency_d = NULL) => -0.0007276218, 0.0008923175);

// Tree: 171 
wFDN_FLA__D_lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 13.25) => 
      map(
      (NULL < nf_vf_type and nf_vf_type <= 2.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 180.5) => 0.0111019174,
         (c_sub_bus > 180.5) => 0.1031104491,
         (c_sub_bus = NULL) => 0.0179672212, 0.0179672212),
      (nf_vf_type > 2.5) => -0.0841761716,
      (nf_vf_type = NULL) => 0.0125205167, 0.0125205167),
   (c_bigapt_p > 13.25) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 15.65) => 0.0462447416,
      (C_INC_25K_P > 15.65) => 0.1413479994,
      (C_INC_25K_P = NULL) => 0.0705662305, 0.0705662305),
   (c_bigapt_p = NULL) => 0.0364023107, 0.0231431840),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0020259640,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0118598700, 0.0014249013);

// Tree: 172 
wFDN_FLA__D_lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.95) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 20247.5) => 0.0793191596,
      (r_L80_Inp_AVM_AutoVal_d > 20247.5) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 177.5) => -0.0061924310,
         (f_curraddrcartheftindex_i > 177.5) => 0.0722778256,
         (f_curraddrcartheftindex_i = NULL) => 0.0121156716, -0.0026779218),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0026137186, -0.0000027599),
   (c_manufacturing > 16.55) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => -0.0450814230,
      (r_D30_Derog_Count_i > 4.5) => -0.1250977005,
      (r_D30_Derog_Count_i = NULL) => -0.0493649497, -0.0493649497),
   (c_manufacturing = NULL) => -0.0038032329, -0.0038032329),
(c_pop_0_5_p > 19.95) => 0.1168880008,
(c_pop_0_5_p = NULL) => 0.0010885357, -0.0029992818);

// Tree: 173 
wFDN_FLA__D_lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0081065823,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 119.5) => 0.1950800735,
      (c_easiqlife > 119.5) => 0.0348978294,
      (c_easiqlife = NULL) => 0.1091641426, 0.1091641426),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 15.35) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 12.5) => 0.2324262961,
         (c_serv_empl > 12.5) => 0.0269014649,
         (c_serv_empl = NULL) => 0.0346910357, 0.0346910357),
      (C_INC_25K_P > 15.35) => -0.0429411762,
      (C_INC_25K_P = NULL) => 0.0207999338, 0.0207999338),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0263288675, 0.0263288675),
(f_rel_felony_count_i = NULL) => -0.0183697356, -0.0033905494);

// Tree: 174 
wFDN_FLA__D_lgt_174 := map(
(NULL < c_info and c_info <= 27.55) => 
   map(
   (NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 0.5) => 0.0024106203,
   (nf_vf_hi_addr_add_entries > 0.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 1.5) => 
         map(
         (NULL < c_preschl and c_preschl <= 118) => -0.0258963918,
         (c_preschl > 118) => -0.1281185363,
         (c_preschl = NULL) => -0.0770074640, -0.0770074640),
      (f_util_adl_count_n > 1.5) => 0.0054251181,
      (f_util_adl_count_n = NULL) => -0.0349985520, -0.0349985520),
   (nf_vf_hi_addr_add_entries = NULL) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 3.95) => 0.0284108408,
      (c_femdiv_p > 3.95) => -0.0628218180,
      (c_femdiv_p = NULL) => -0.0271746202, -0.0271746202), 0.0014161834),
(c_info > 27.55) => 0.1894817087,
(c_info = NULL) => -0.0096861410, 0.0021303673);

// Tree: 175 
wFDN_FLA__D_lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0091675340,
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0095475214,
   (r_F03_input_add_not_most_rec_i > 0.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 136.5) => 0.0450906576,
      (c_serv_empl > 136.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 100.5) => 0.2898308361,
         (f_curraddrcrimeindex_i > 100.5) => 0.0680816245,
         (f_curraddrcrimeindex_i = NULL) => 0.1853704637, 0.1853704637),
      (c_serv_empl = NULL) => 0.0889507520, 0.0889507520),
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0209722417, 0.0209722417),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 77.3) => 0.0626599557,
   (c_fammar_p > 77.3) => -0.0436330295,
   (c_fammar_p = NULL) => 0.0066013265, 0.0066013265), -0.0023256542);

// Tree: 176 
wFDN_FLA__D_lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0051634369,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 91.5) => -0.0162466088,
         (c_many_cars > 91.5) => 
            map(
            (NULL < c_rape and c_rape <= 112.5) => 0.0564294531,
            (c_rape > 112.5) => 0.2587373591,
            (c_rape = NULL) => 0.0952486823, 0.0952486823),
         (c_many_cars = NULL) => 0.0379997537, 0.0379997537),
      (c_pop_55_64_p > 17.45) => 0.2674600272,
      (c_pop_55_64_p = NULL) => 0.0575924207, 0.0575924207),
   (f_util_adl_count_n = NULL) => 0.0105836658, 0.0085817739),
(c_pop_18_24_p > 11.15) => -0.0258483880,
(c_pop_18_24_p = NULL) => 0.0133374131, 0.0008580325);

// Tree: 177 
wFDN_FLA__D_lgt_177 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -72490) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
         map(
         (NULL < c_medi_indx and c_medi_indx <= 102.5) => -0.0439429413,
         (c_medi_indx > 102.5) => 0.1154713574,
         (c_medi_indx = NULL) => 0.0201601629, 0.0201601629),
      (f_util_adl_count_n > 3.5) => 0.1573681873,
      (f_util_adl_count_n = NULL) => 0.0515219971, 0.0515219971),
   (f_addrchangevaluediff_d > -72490) => 0.0006261795,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -5253) => -0.0344748333,
      (r_A49_Curr_AVM_Chg_1yr_i > -5253) => 0.0512086405,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0021032467, 0.0061477723), 0.0028242203),
(f_inq_PrepaidCards_count24_i > 1.5) => 0.0772479184,
(f_inq_PrepaidCards_count24_i = NULL) => -0.0260106097, 0.0027006357);

// Tree: 178 
wFDN_FLA__D_lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 14.55) => -0.0077626427,
(c_rnt1250_p > 14.55) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 9.35) => 0.0045309892,
   (c_pop_6_11_p > 9.35) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 118891.5) => 
         map(
         (NULL < c_vacant_p and c_vacant_p <= 5.65) => 0.0487825738,
         (c_vacant_p > 5.65) => 0.2347032104,
         (c_vacant_p = NULL) => 0.1533629319, 0.1533629319),
      (r_A46_Curr_AVM_AutoVal_d > 118891.5) => 0.0452013588,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_retail and c_retail <= 28.4) => 0.0187465016,
         (c_retail > 28.4) => 0.1921925666,
         (c_retail = NULL) => 0.0468039533, 0.0468039533), 0.0585497479),
   (c_pop_6_11_p = NULL) => 0.0203937574, 0.0203937574),
(c_rnt1250_p = NULL) => -0.0011973580, 0.0005384139);

// Tree: 179 
wFDN_FLA__D_lgt_179 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 53.75) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.078796035) => 0.0070863412,
      (f_add_curr_nhood_VAC_pct_i > 0.078796035) => 
         map(
         (NULL < c_unemp and c_unemp <= 4.15) => -0.0118688382,
         (c_unemp > 4.15) => 0.1211764962,
         (c_unemp = NULL) => 0.0609229809, 0.0609229809),
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0164046902, 0.0164046902),
   (c_hh2_p > 53.75) => 0.2162580823,
   (c_hh2_p = NULL) => -0.0045779609, 0.0206071720),
(f_hh_members_ct_d > 1.5) => -0.0069778438,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.55) => 0.0541211297,
   (c_pop_45_54_p > 16.55) => -0.0737296322,
   (c_pop_45_54_p = NULL) => 0.0151422388, 0.0151422388), -0.0015748230);

// Tree: 180 
wFDN_FLA__D_lgt_180 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 148.5) => 0.0047051090,
   (f_prevaddrcartheftindex_i > 148.5) => -0.0219599973,
   (f_prevaddrcartheftindex_i = NULL) => -0.0001369921, -0.0001369921),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 21.95) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 13.35) => -0.0812024642,
      (C_INC_50K_P > 13.35) => 0.0996942478,
      (C_INC_50K_P = NULL) => 0.0079157689, 0.0079157689),
   (C_INC_75K_P > 21.95) => 0.2295547866,
   (C_INC_75K_P = NULL) => 0.0683627737, 0.0683627737),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 5.75) => -0.0387634497,
   (c_professional > 5.75) => 0.0538735815,
   (c_professional = NULL) => 0.0028921281, 0.0028921281), 0.0009310474);

// Tree: 181 
wFDN_FLA__D_lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 9.35) => -0.0061591089,
   (C_INC_35K_P > 9.35) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0614611819) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 105.5) => 0.1339433357,
         (c_bel_edu > 105.5) => -0.0262807939,
         (c_bel_edu = NULL) => 0.0489661658, 0.0489661658),
      (f_add_input_nhood_VAC_pct_i > 0.0614611819) => 0.1735718234,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0822436411, 0.0822436411),
   (C_INC_35K_P = NULL) => 0.0335103009, 0.0335103009),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => 
   map(
   (NULL < c_rnt250_p and c_rnt250_p <= 14.25) => -0.0000826293,
   (c_rnt250_p > 14.25) => -0.0453185223,
   (c_rnt250_p = NULL) => -0.0151582931, -0.0054463145),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0043133337, -0.0029699466);

// Tree: 182 
wFDN_FLA__D_lgt_182 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0038699247,
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.03655072715) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.81889721295) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 181.5) => 0.1076874573,
         (c_asian_lang > 181.5) => -0.0231206679,
         (c_asian_lang = NULL) => 0.0855914902, 0.0855914902),
      (f_add_input_nhood_MFD_pct_i > 0.81889721295) => -0.0175098561,
      (f_add_input_nhood_MFD_pct_i = NULL) => -0.0132690920, 0.0537540472),
   (f_add_curr_nhood_BUS_pct_i > 0.03655072715) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 15.5) => 0.0090175960,
      (f_rel_homeover50_count_d > 15.5) => -0.0865942046,
      (f_rel_homeover50_count_d = NULL) => -0.0110081827, -0.0110081827),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0669770023, 0.0236895396),
(k_inq_per_addr_i = NULL) => -0.0008760783, -0.0008760783);

// Tree: 183 
wFDN_FLA__D_lgt_183 := map(
(NULL < c_oldhouse and c_oldhouse <= 613.2) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 189) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0037021329,
      (k_inq_adls_per_addr_i > 3.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 43.3) => 0.0132404775,
         (r_C12_source_profile_d > 43.3) => -0.0908194373,
         (r_C12_source_profile_d = NULL) => -0.0517969693, -0.0517969693),
      (k_inq_adls_per_addr_i = NULL) => -0.0046627981, -0.0046627981),
   (c_totcrime > 189) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.1416960614,
      (r_C12_Num_NonDerogs_d > 2.5) => 0.0230001478,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0593023344, 0.0593023344),
   (c_totcrime = NULL) => -0.0030812426, -0.0030812426),
(c_oldhouse > 613.2) => -0.0579947528,
(c_oldhouse = NULL) => 0.0197634384, -0.0042537665);

// Tree: 184 
wFDN_FLA__D_lgt_184 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => 0.0003054571,
(f_util_adl_count_n > 7.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 165.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 2.95) => 0.2309683681,
      (c_famotf18_p > 2.95) => 
         map(
         (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 3.5) => 0.1876367132,
         (f_rel_ageover30_count_d > 3.5) => 0.0206562043,
         (f_rel_ageover30_count_d = NULL) => 0.0456805313, 0.0456805313),
      (c_famotf18_p = NULL) => 0.0762823686, 0.0762823686),
   (c_sub_bus > 165.5) => -0.0727314991,
   (c_sub_bus = NULL) => 0.0478987747, 0.0478987747),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.15134660595) => 0.0578207958,
   (f_add_input_nhood_MFD_pct_i > 0.15134660595) => -0.0272274610,
   (f_add_input_nhood_MFD_pct_i = NULL) => -0.0525371804, -0.0056730827), 0.0023123172);

// Tree: 185 
wFDN_FLA__D_lgt_185 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 61.5) => 0.1235771853,
      (r_I61_inq_collection_recency_d > 61.5) => -0.0205698445,
      (r_I61_inq_collection_recency_d = NULL) => 0.0579388057, 0.0579388057),
   (r_D33_Eviction_Recency_d > 30) => 0.0073073467,
   (r_D33_Eviction_Recency_d = NULL) => 0.0078046914, 0.0078046914),
(r_D31_ALL_Bk_i > 1.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 120.5) => -0.0973715689,
   (r_C13_max_lres_d > 120.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 27.2) => -0.0240895114,
      (C_INC_75K_P > 27.2) => 0.1472185264,
      (C_INC_75K_P = NULL) => -0.0093557007, -0.0093557007),
   (r_C13_max_lres_d = NULL) => -0.0334696372, -0.0334696372),
(r_D31_ALL_Bk_i = NULL) => 0.0051538909, 0.0042025045);

// Tree: 186 
wFDN_FLA__D_lgt_186 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3923820453) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.75) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30263) => 0.0358759236,
      (f_curraddrmedianincome_d > 30263) => 0.0031658389,
      (f_curraddrmedianincome_d = NULL) => 0.0135480757, 0.0053565896),
   (c_pop_6_11_p > 15.75) => 0.1407519879,
   (c_pop_6_11_p = NULL) => 0.0024759328, 0.0060242791),
(f_add_input_mobility_index_i > 0.3923820453) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 58.85) => -0.0344003356,
   (c_rnt750_p > 58.85) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 0.5) => -0.0707209447,
      (f_rel_ageover40_count_d > 0.5) => 0.0733569621,
      (f_rel_ageover40_count_d = NULL) => 0.0275910388, 0.0275910388),
   (c_rnt750_p = NULL) => 0.0256645216, -0.0258312935),
(f_add_input_mobility_index_i = NULL) => -0.0122625748, 0.0011249639);

// Tree: 187 
wFDN_FLA__D_lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
      map(
      (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => -0.0007527329,
      (r_L72_Add_Vacant_i > 0.5) => 0.1007423075,
      (r_L72_Add_Vacant_i = NULL) => -0.0001077425, -0.0001077425),
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0683292803,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0004449802, -0.0004449802),
(f_rel_bankrupt_count_i > 7.5) => -0.0903115778,
(f_rel_bankrupt_count_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 9.85) => -0.0653193442,
   (c_hh4_p > 9.85) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.3) => -0.0308490631,
      (c_pop_0_5_p > 8.3) => 0.0878840612,
      (c_pop_0_5_p = NULL) => 0.0285174991, 0.0285174991),
   (c_hh4_p = NULL) => -0.0035385654, -0.0035385654), -0.0016167733);

// Tree: 188 
wFDN_FLA__D_lgt_188 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 432.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 19.25) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 0.0345658923,
      (f_corraddrnamecount_d > 1.5) => -0.0008338097,
      (f_corraddrnamecount_d = NULL) => 0.0013213899, 0.0013213899),
   (c_hval_80k_p > 19.25) => -0.0352480352,
   (c_hval_80k_p = NULL) => -0.0224744285, -0.0015125721),
(f_prevaddrageoldest_d > 432.5) => 
   map(
   (NULL < c_robbery and c_robbery <= 105.5) => -0.0234843352,
   (c_robbery > 105.5) => 0.1871790297,
   (c_robbery = NULL) => 0.0719725020, 0.0719725020),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 16.15) => 0.0806067659,
   (C_INC_75K_P > 16.15) => -0.0077307711,
   (C_INC_75K_P = NULL) => 0.0282585959, 0.0282585959), -0.0003204433);

// Tree: 189 
wFDN_FLA__D_lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 160500) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0063947024,
      (f_rel_homeover500_count_d > 14.5) => 0.0751630821,
      (f_rel_homeover500_count_d = NULL) => 0.0056846855, -0.0054883657),
   (k_estimated_income_d > 160500) => 0.1777713785,
   (k_estimated_income_d = NULL) => -0.0044885772, -0.0044885772),
(f_phones_per_addr_curr_i > 38.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0147677573,
   (f_rel_under25miles_cnt_d > 4.5) => 0.1460756794,
   (f_rel_under25miles_cnt_d = NULL) => 0.0521317252, 0.0521317252),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 28.7) => 0.0691382791,
   (c_fammar18_p > 28.7) => -0.0228413614,
   (c_fammar18_p = NULL) => 0.0108413238, 0.0108413238), -0.0032386573);

// Tree: 190 
wFDN_FLA__D_lgt_190 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 7.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 0.65) => -0.0325721069,
      (C_INC_150K_P > 0.65) => -0.0028950304,
      (C_INC_150K_P = NULL) => -0.0096573610, -0.0048365786),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.0687319210,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0044815468, -0.0044815468),
(f_inq_Banking_count24_i > 7.5) => -0.0987696017,
(f_inq_Banking_count24_i = NULL) => 
   map(
   (NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
      map(
      (NULL < c_burglary and c_burglary <= 63.5) => -0.0522720325,
      (c_burglary > 63.5) => 0.0702235375,
      (c_burglary = NULL) => 0.0172805369, 0.0172805369),
   (r_L77_Apartment_i > 0.5) => -0.0937063861,
   (r_L77_Apartment_i = NULL) => -0.0136789732, -0.0136789732), -0.0050801570);

// Tree: 191 
wFDN_FLA__D_lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => -0.0045901837,
(c_totcrime > 163.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 161.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 0.1806868680,
         (f_corraddrnamecount_d > 3.5) => 0.0693311619,
         (f_corraddrnamecount_d = NULL) => 0.0882731119, 0.0882731119),
      (c_cartheft > 161.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 8.95) => 0.0682991413,
         (c_hh3_p > 8.95) => -0.0335727048,
         (c_hh3_p = NULL) => -0.0001902740, -0.0001902740),
      (c_cartheft = NULL) => 0.0280597620, 0.0280597620),
   (f_crim_rel_under25miles_cnt_i > 4.5) => 0.1115848227,
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0233346865, 0.0318849684),
(c_totcrime = NULL) => -0.0313961892, -0.0013707933);

// Tree: 192 
wFDN_FLA__D_lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.0829112620,
(r_D32_Mos_Since_Fel_LS_d > 120) => 
   map(
   (NULL < c_unempl and c_unempl <= 165.5) => -0.0006122087,
   (c_unempl > 165.5) => 
      map(
      (NULL < c_rental and c_rental <= 190.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.1195157089,
         (r_D33_Eviction_Recency_d > 549) => -0.0351413550,
         (r_D33_Eviction_Recency_d = NULL) => -0.0410155189, -0.0410155189),
      (c_rental > 190.5) => 0.0661011772,
      (c_rental = NULL) => -0.0332206420, -0.0332206420),
   (c_unempl = NULL) => 0.0104273333, -0.0026298176),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 2.85) => -0.0611797787,
   (c_hh5_p > 2.85) => 0.0346373251,
   (c_hh5_p = NULL) => 0.0052455755, 0.0052455755), -0.0020323635);

// Tree: 193 
wFDN_FLA__D_lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 19999.5) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 2.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 56035) => 0.0787424364,
         (f_curraddrmedianincome_d > 56035) => -0.0482268268,
         (f_curraddrmedianincome_d = NULL) => 0.0073617063, 0.0073617063),
      (f_rel_under25miles_cnt_d > 2.5) => -0.0658163442,
      (f_rel_under25miles_cnt_d = NULL) => -0.0351730355, -0.0351730355),
   (k_estimated_income_d > 19999.5) => -0.0050996219,
   (k_estimated_income_d = NULL) => -0.0066731576, -0.0066731576),
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.1704719646,
   (f_adl_per_email_i > 0.5) => -0.0347967066,
   (f_adl_per_email_i = NULL) => 0.0186084188, 0.0207805206),
(f_prevaddrageoldest_d = NULL) => -0.0146664425, -0.0004265253);

// Tree: 194 
wFDN_FLA__D_lgt_194 := map(
(NULL < c_hval_20k_p and c_hval_20k_p <= 28.55) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 79.3) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => -0.0026428516,
      (f_rel_incomeover50_count_d > 22.5) => -0.0621630748,
      (f_rel_incomeover50_count_d = NULL) => 0.0060492501, -0.0036235779),
   (c_rnt1000_p > 79.3) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 0) => 0.0273181495,
      (nf_vf_level > 0) => 0.2365877676,
      (nf_vf_level = NULL) => 0.0874160911, 0.0874160911),
   (c_rnt1000_p = NULL) => -0.0021715659, -0.0021715659),
(c_hval_20k_p > 28.55) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 129) => -0.0088425806,
   (c_sub_bus > 129) => 0.1666905615,
   (c_sub_bus = NULL) => 0.0649108404, 0.0649108404),
(c_hval_20k_p = NULL) => -0.0034265074, -0.0015696591);

// Tree: 195 
wFDN_FLA__D_lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 0.0234685151,
      (r_Ever_Asset_Owner_d > 0.5) => -0.0007817680,
      (r_Ever_Asset_Owner_d = NULL) => 0.0043704623, 0.0043704623),
   (f_inq_Auto_count24_i > 1.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 7.5) => 
         map(
         (NULL < c_hval_500k_p and c_hval_500k_p <= 21.95) => -0.0447231336,
         (c_hval_500k_p > 21.95) => 0.1187183055,
         (c_hval_500k_p = NULL) => -0.0266221273, -0.0266221273),
      (k_inq_per_addr_i > 7.5) => -0.1133263716,
      (k_inq_per_addr_i = NULL) => -0.0346906168, -0.0346906168),
   (f_inq_Auto_count24_i = NULL) => 0.0099646552, 0.0022867315),
(c_hval_80k_p > 40.05) => -0.1181009784,
(c_hval_80k_p = NULL) => 0.0230679949, 0.0016743659);

// Tree: 196 
wFDN_FLA__D_lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0907235955,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 44.45) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 25.95) => -0.0018971224,
      (c_hval_60k_p > 25.95) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.09132271925) => -0.0600030908,
         (f_add_curr_nhood_MFD_pct_i > 0.09132271925) => 0.1339887082,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0579134929, 0.0579134929),
      (c_hval_60k_p = NULL) => -0.0010305939, -0.0010305939),
   (c_hval_60k_p > 44.45) => -0.1080263484,
   (c_hval_60k_p = NULL) => 0.0269399946, -0.0009089998),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0467696746,
   (k_nap_lname_verd_d > 0.5) => -0.0454054987,
   (k_nap_lname_verd_d = NULL) => 0.0027876122, 0.0027876122), -0.0030960707);

// Tree: 197 
wFDN_FLA__D_lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -91324) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 0.0017969954,
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.1315866619,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0430385716, 0.0430385716),
(f_addrchangevaluediff_d > -91324) => -0.0006751846,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 10.45) => -0.0134156008,
   (c_hh5_p > 10.45) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.9011822972) => -0.0045349164,
      (f_add_input_nhood_SFD_pct_d > 0.9011822972) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04343242155) => 0.0266567031,
         (f_add_curr_nhood_BUS_pct_i > 0.04343242155) => 0.1662535511,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0777766756, 0.0777766756),
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0334068079, 0.0334068079),
   (c_hh5_p = NULL) => -0.0087849236, -0.0044739715), -0.0008031901);

// Tree: 198 
wFDN_FLA__D_lgt_198 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0940308142,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 0.0043400408,
      (f_liens_unrel_SC_total_amt_i > 5693) => 0.1179721157,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0049019629, 0.0049019629),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => 0.0376229086,
      (f_srchaddrsrchcount_i > 2.5) => -0.1018945007,
      (f_srchaddrsrchcount_i = NULL) => -0.0501852511, -0.0501852511),
   (r_I60_inq_comm_count12_i = NULL) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 8.85) => 0.0410460662,
      (c_pop_12_17_p > 8.85) => -0.0604692208,
      (c_pop_12_17_p = NULL) => 0.0018996483, 0.0018996483), 0.0042201255),
(c_pop_45_54_p = NULL) => -0.0314034053, 0.0020995414);

// Tree: 199 
wFDN_FLA__D_lgt_199 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < f_acc_damage_amt_last_i and f_acc_damage_amt_last_i <= 1925) => -0.0076681946,
      (f_acc_damage_amt_last_i > 1925) => 0.1920969858,
      (f_acc_damage_amt_last_i = NULL) => -0.0063604029, -0.0063604029),
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 158.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 53.55) => 0.0028632507,
         (C_RENTOCC_P > 53.55) => 0.0648975847,
         (C_RENTOCC_P = NULL) => 0.0111659173, 0.0111659173),
      (c_easiqlife > 158.5) => 0.1878014188,
      (c_easiqlife = NULL) => 0.0175347466, 0.0175347466),
   (f_rel_felony_count_i = NULL) => -0.0014082276, -0.0028552641),
(C_INC_25K_P > 27.65) => 0.0843982061,
(C_INC_25K_P = NULL) => -0.0384075925, -0.0030418510);

// Tree: 200 
wFDN_FLA__D_lgt_200 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 10.5) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 22.85) => -0.0036033751,
   (c_hval_40k_p > 22.85) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.0176400010,
      (f_rel_under100miles_cnt_d > 8.5) => 0.1422732334,
      (f_rel_under100miles_cnt_d = NULL) => 0.0685718508, 0.0685718508),
   (c_hval_40k_p = NULL) => -0.0280217133, -0.0028710361),
(f_inq_HighRiskCredit_count_i > 10.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 36.5) => -0.0053767521,
   (f_prevaddrageoldest_d > 36.5) => -0.1166138392,
   (f_prevaddrageoldest_d = NULL) => -0.0615459743, -0.0615459743),
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1344.5) => 0.0566857057,
   (c_popover18 > 1344.5) => -0.0345114699,
   (c_popover18 = NULL) => 0.0128013505, 0.0128013505), -0.0031355924);

// Tree: 201 
wFDN_FLA__D_lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0059521932,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.15) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => -0.0294803779,
      (r_L79_adls_per_addr_curr_i > 2.5) => 0.0638789019,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0005870230, 0.0005870230),
   (c_finance > 5.15) => 
      map(
      (NULL < c_larceny and c_larceny <= 158.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 1.45) => 0.1822986632,
         (c_pop_75_84_p > 1.45) => 0.0227250845,
         (c_pop_75_84_p = NULL) => 0.0542613649, 0.0542613649),
      (c_larceny > 158.5) => 0.2438359499,
      (c_larceny = NULL) => 0.0980536702, 0.0980536702),
   (c_finance = NULL) => 0.1096912955, 0.0408445494),
(r_L70_Add_Standardized_i = NULL) => -0.0020638395, -0.0020638395);

// Tree: 202 
wFDN_FLA__D_lgt_202 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 5.25) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 148.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 2.05) => -0.0584768961,
         (C_INC_150K_P > 2.05) => 0.0562033884,
         (C_INC_150K_P = NULL) => -0.0075524341, -0.0075524341),
      (f_fp_prevaddrcrimeindex_i > 148.5) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 0.1742074909,
         (f_historical_count_d > 1.5) => 0.0009021406,
         (f_historical_count_d = NULL) => 0.0948982628, 0.0948982628),
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0316133831, 0.0316133831),
   (c_high_ed > 5.25) => -0.0010979250,
   (c_high_ed = NULL) => 0.0001472805, 0.0001472805),
(c_bel_edu > 196.5) => -0.0730815629,
(c_bel_edu = NULL) => 0.0189157718, -0.0001640477);

// Tree: 203 
wFDN_FLA__D_lgt_203 := map(
(NULL < c_low_hval and c_low_hval <= 62.55) => 
   map(
   (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 6.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -116.5) => 0.0905116382,
      (f_addrchangecrimediff_i > -116.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 75.35) => 0.0000629757,
         (c_rnt1000_p > 75.35) => 0.1101489163,
         (c_rnt1000_p = NULL) => 0.0020211854, 0.0020211854),
      (f_addrchangecrimediff_i = NULL) => -0.0069357280, 0.0006061523),
   (f_inq_Auto_count_i > 6.5) => -0.0976952517,
   (f_inq_Auto_count_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 2.25) => -0.0503475941,
      (c_high_hval > 2.25) => 0.0456162346,
      (c_high_hval = NULL) => 0.0020537071, 0.0020537071), 0.0000142438),
(c_low_hval > 62.55) => -0.0656851156,
(c_low_hval = NULL) => -0.0120824313, -0.0010513350);

// Tree: 204 
wFDN_FLA__D_lgt_204 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 37.5) => 0.1503038085,
      (f_prevaddrmurderindex_i > 37.5) => 0.0087255913,
      (f_prevaddrmurderindex_i = NULL) => 0.0566674215, 0.0566674215),
   (r_C10_M_Hdr_FS_d > 11.5) => 0.0021152002,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0029596203, 0.0029596203),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => 
   map(
   (NULL < c_med_age and c_med_age <= 41.35) => -0.0855674152,
   (c_med_age > 41.35) => 0.0251016504,
   (c_med_age = NULL) => -0.0646718573, -0.0646718573),
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 12.9) => -0.0368794074,
   (c_blue_col > 12.9) => 0.0626294772,
   (c_blue_col = NULL) => 0.0032949870, 0.0032949870), 0.0014344185);

// Tree: 205 
wFDN_FLA__D_lgt_205 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 0.5) => -0.0005714337,
(f_inq_HighRiskCredit_count_i > 0.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.025466754) => -0.0277698166,
   (f_add_curr_nhood_BUS_pct_i > 0.025466754) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 68.05) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.04764652065) => 
            map(
            (NULL < c_lowrent and c_lowrent <= 3.95) => -0.0013258194,
            (c_lowrent > 3.95) => 0.1804984967,
            (c_lowrent = NULL) => 0.1072391849, 0.1072391849),
         (f_add_input_nhood_BUS_pct_i > 0.04764652065) => 0.0477672903,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0717892712, 0.0717892712),
      (c_low_ed > 68.05) => -0.0464503620,
      (c_low_ed = NULL) => 0.0549262363, 0.0549262363),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0231330708, 0.0231330708),
(f_inq_HighRiskCredit_count_i = NULL) => -0.0132441679, 0.0011404792);

// Tree: 206 
wFDN_FLA__D_lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 186.5) => -0.0832770258,
(f_mos_liens_unrel_FT_fseen_d > 186.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 27.1) => -0.0505283420,
   (c_fammar_p > 27.1) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 25009.5) => 0.0545698295,
      (f_curraddrmedianvalue_d > 25009.5) => -0.0039328324,
      (f_curraddrmedianvalue_d = NULL) => -0.0021488859, -0.0021488859),
   (c_fammar_p = NULL) => 0.0192755535, -0.0024343671),
(f_mos_liens_unrel_FT_fseen_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 9.35) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 3.55) => 0.0168608440,
      (C_INC_200K_P > 3.55) => -0.1012305201,
      (C_INC_200K_P = NULL) => -0.0427694488, -0.0427694488),
   (c_high_hval > 9.35) => 0.0678317510,
   (c_high_hval = NULL) => -0.0011233180, -0.0011233180), -0.0032364451);

// Tree: 207 
wFDN_FLA__D_lgt_207 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 153.5) => -0.0564466936,
   (r_C21_M_Bureau_ADL_FS_d > 153.5) => 
      map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 1.5) => 0.0870079521,
      (f_rel_under100miles_cnt_d > 1.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3313371393) => 
            map(
            (NULL < c_hh2_p and c_hh2_p <= 26.05) => -0.0829430334,
            (c_hh2_p > 26.05) => 0.0379966196,
            (c_hh2_p = NULL) => 0.0054859602, 0.0054859602),
         (f_add_curr_mobility_index_i > 0.3313371393) => -0.1194473670,
         (f_add_curr_mobility_index_i = NULL) => -0.0216531146, -0.0216531146),
      (f_rel_under100miles_cnt_d = NULL) => 0.0060331297, 0.0060331297),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0264068281, -0.0264068281),
(r_F01_inp_addr_address_score_d > 75) => 0.0022591776,
(r_F01_inp_addr_address_score_d = NULL) => -0.0122910701, 0.0002290230);

// Tree: 208 
wFDN_FLA__D_lgt_208 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 103.5) => 
         map(
         (NULL < c_transport and c_transport <= 17.5) => -0.0044641165,
         (c_transport > 17.5) => 0.0671157072,
         (c_transport = NULL) => -0.0021127379, -0.0021127379),
      (f_addrchangecrimediff_i > 103.5) => 0.0785553994,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 192.5) => -0.0026170515,
         (f_curraddrburglaryindex_i > 192.5) => 0.1170381332,
         (f_curraddrburglaryindex_i = NULL) => 0.0086599624, 0.0004526483), -0.0011338211),
   (r_L77_Add_PO_Box_i > 0.5) => -0.0876955740,
   (r_L77_Add_PO_Box_i = NULL) => -0.0031267481, -0.0031267481),
(r_L72_Add_Vacant_i > 0.5) => 0.0878789760,
(r_L72_Add_Vacant_i = NULL) => -0.0025381324, -0.0025381324);

// Final Score Sum 

   wFDN_FLA__D_lgt := sum(
      wFDN_FLA__D_lgt_0, wFDN_FLA__D_lgt_1, wFDN_FLA__D_lgt_2, wFDN_FLA__D_lgt_3, wFDN_FLA__D_lgt_4, 
      wFDN_FLA__D_lgt_5, wFDN_FLA__D_lgt_6, wFDN_FLA__D_lgt_7, wFDN_FLA__D_lgt_8, wFDN_FLA__D_lgt_9, 
      wFDN_FLA__D_lgt_10, wFDN_FLA__D_lgt_11, wFDN_FLA__D_lgt_12, wFDN_FLA__D_lgt_13, wFDN_FLA__D_lgt_14, 
      wFDN_FLA__D_lgt_15, wFDN_FLA__D_lgt_16, wFDN_FLA__D_lgt_17, wFDN_FLA__D_lgt_18, wFDN_FLA__D_lgt_19, 
      wFDN_FLA__D_lgt_20, wFDN_FLA__D_lgt_21, wFDN_FLA__D_lgt_22, wFDN_FLA__D_lgt_23, wFDN_FLA__D_lgt_24, 
      wFDN_FLA__D_lgt_25, wFDN_FLA__D_lgt_26, wFDN_FLA__D_lgt_27, wFDN_FLA__D_lgt_28, wFDN_FLA__D_lgt_29, 
      wFDN_FLA__D_lgt_30, wFDN_FLA__D_lgt_31, wFDN_FLA__D_lgt_32, wFDN_FLA__D_lgt_33, wFDN_FLA__D_lgt_34, 
      wFDN_FLA__D_lgt_35, wFDN_FLA__D_lgt_36, wFDN_FLA__D_lgt_37, wFDN_FLA__D_lgt_38, wFDN_FLA__D_lgt_39, 
      wFDN_FLA__D_lgt_40, wFDN_FLA__D_lgt_41, wFDN_FLA__D_lgt_42, wFDN_FLA__D_lgt_43, wFDN_FLA__D_lgt_44, 
      wFDN_FLA__D_lgt_45, wFDN_FLA__D_lgt_46, wFDN_FLA__D_lgt_47, wFDN_FLA__D_lgt_48, wFDN_FLA__D_lgt_49, 
      wFDN_FLA__D_lgt_50, wFDN_FLA__D_lgt_51, wFDN_FLA__D_lgt_52, wFDN_FLA__D_lgt_53, wFDN_FLA__D_lgt_54, 
      wFDN_FLA__D_lgt_55, wFDN_FLA__D_lgt_56, wFDN_FLA__D_lgt_57, wFDN_FLA__D_lgt_58, wFDN_FLA__D_lgt_59, 
      wFDN_FLA__D_lgt_60, wFDN_FLA__D_lgt_61, wFDN_FLA__D_lgt_62, wFDN_FLA__D_lgt_63, wFDN_FLA__D_lgt_64, 
      wFDN_FLA__D_lgt_65, wFDN_FLA__D_lgt_66, wFDN_FLA__D_lgt_67, wFDN_FLA__D_lgt_68, wFDN_FLA__D_lgt_69, 
      wFDN_FLA__D_lgt_70, wFDN_FLA__D_lgt_71, wFDN_FLA__D_lgt_72, wFDN_FLA__D_lgt_73, wFDN_FLA__D_lgt_74, 
      wFDN_FLA__D_lgt_75, wFDN_FLA__D_lgt_76, wFDN_FLA__D_lgt_77, wFDN_FLA__D_lgt_78, wFDN_FLA__D_lgt_79, 
      wFDN_FLA__D_lgt_80, wFDN_FLA__D_lgt_81, wFDN_FLA__D_lgt_82, wFDN_FLA__D_lgt_83, wFDN_FLA__D_lgt_84, 
      wFDN_FLA__D_lgt_85, wFDN_FLA__D_lgt_86, wFDN_FLA__D_lgt_87, wFDN_FLA__D_lgt_88, wFDN_FLA__D_lgt_89, 
      wFDN_FLA__D_lgt_90, wFDN_FLA__D_lgt_91, wFDN_FLA__D_lgt_92, wFDN_FLA__D_lgt_93, wFDN_FLA__D_lgt_94, 
      wFDN_FLA__D_lgt_95, wFDN_FLA__D_lgt_96, wFDN_FLA__D_lgt_97, wFDN_FLA__D_lgt_98, wFDN_FLA__D_lgt_99, 
      wFDN_FLA__D_lgt_100, wFDN_FLA__D_lgt_101, wFDN_FLA__D_lgt_102, wFDN_FLA__D_lgt_103, wFDN_FLA__D_lgt_104, 
      wFDN_FLA__D_lgt_105, wFDN_FLA__D_lgt_106, wFDN_FLA__D_lgt_107, wFDN_FLA__D_lgt_108, wFDN_FLA__D_lgt_109, 
      wFDN_FLA__D_lgt_110, wFDN_FLA__D_lgt_111, wFDN_FLA__D_lgt_112, wFDN_FLA__D_lgt_113, wFDN_FLA__D_lgt_114, 
      wFDN_FLA__D_lgt_115, wFDN_FLA__D_lgt_116, wFDN_FLA__D_lgt_117, wFDN_FLA__D_lgt_118, wFDN_FLA__D_lgt_119, 
      wFDN_FLA__D_lgt_120, wFDN_FLA__D_lgt_121, wFDN_FLA__D_lgt_122, wFDN_FLA__D_lgt_123, wFDN_FLA__D_lgt_124, 
      wFDN_FLA__D_lgt_125, wFDN_FLA__D_lgt_126, wFDN_FLA__D_lgt_127, wFDN_FLA__D_lgt_128, wFDN_FLA__D_lgt_129, 
      wFDN_FLA__D_lgt_130, wFDN_FLA__D_lgt_131, wFDN_FLA__D_lgt_132, wFDN_FLA__D_lgt_133, wFDN_FLA__D_lgt_134, 
      wFDN_FLA__D_lgt_135, wFDN_FLA__D_lgt_136, wFDN_FLA__D_lgt_137, wFDN_FLA__D_lgt_138, wFDN_FLA__D_lgt_139, 
      wFDN_FLA__D_lgt_140, wFDN_FLA__D_lgt_141, wFDN_FLA__D_lgt_142, wFDN_FLA__D_lgt_143, wFDN_FLA__D_lgt_144, 
      wFDN_FLA__D_lgt_145, wFDN_FLA__D_lgt_146, wFDN_FLA__D_lgt_147, wFDN_FLA__D_lgt_148, wFDN_FLA__D_lgt_149, 
      wFDN_FLA__D_lgt_150, wFDN_FLA__D_lgt_151, wFDN_FLA__D_lgt_152, wFDN_FLA__D_lgt_153, wFDN_FLA__D_lgt_154, 
      wFDN_FLA__D_lgt_155, wFDN_FLA__D_lgt_156, wFDN_FLA__D_lgt_157, wFDN_FLA__D_lgt_158, wFDN_FLA__D_lgt_159, 
      wFDN_FLA__D_lgt_160, wFDN_FLA__D_lgt_161, wFDN_FLA__D_lgt_162, wFDN_FLA__D_lgt_163, wFDN_FLA__D_lgt_164, 
      wFDN_FLA__D_lgt_165, wFDN_FLA__D_lgt_166, wFDN_FLA__D_lgt_167, wFDN_FLA__D_lgt_168, wFDN_FLA__D_lgt_169, 
      wFDN_FLA__D_lgt_170, wFDN_FLA__D_lgt_171, wFDN_FLA__D_lgt_172, wFDN_FLA__D_lgt_173, wFDN_FLA__D_lgt_174, 
      wFDN_FLA__D_lgt_175, wFDN_FLA__D_lgt_176, wFDN_FLA__D_lgt_177, wFDN_FLA__D_lgt_178, wFDN_FLA__D_lgt_179, 
      wFDN_FLA__D_lgt_180, wFDN_FLA__D_lgt_181, wFDN_FLA__D_lgt_182, wFDN_FLA__D_lgt_183, wFDN_FLA__D_lgt_184, 
      wFDN_FLA__D_lgt_185, wFDN_FLA__D_lgt_186, wFDN_FLA__D_lgt_187, wFDN_FLA__D_lgt_188, wFDN_FLA__D_lgt_189, 
      wFDN_FLA__D_lgt_190, wFDN_FLA__D_lgt_191, wFDN_FLA__D_lgt_192, wFDN_FLA__D_lgt_193, wFDN_FLA__D_lgt_194, 
      wFDN_FLA__D_lgt_195, wFDN_FLA__D_lgt_196, wFDN_FLA__D_lgt_197, wFDN_FLA__D_lgt_198, wFDN_FLA__D_lgt_199, 
      wFDN_FLA__D_lgt_200, wFDN_FLA__D_lgt_201, wFDN_FLA__D_lgt_202, wFDN_FLA__D_lgt_203, wFDN_FLA__D_lgt_204, 
      wFDN_FLA__D_lgt_205, wFDN_FLA__D_lgt_206, wFDN_FLA__D_lgt_207, wFDN_FLA__D_lgt_208); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLA__D_lgt;
			
self.final_score_0	:= 	wFDN_FLA__D_lgt_0	;
self.final_score_1	:= 	wFDN_FLA__D_lgt_1	;
self.final_score_2	:= 	wFDN_FLA__D_lgt_2	;
self.final_score_3	:= 	wFDN_FLA__D_lgt_3	;
self.final_score_4	:= 	wFDN_FLA__D_lgt_4	;
self.final_score_5	:= 	wFDN_FLA__D_lgt_5	;
self.final_score_6	:= 	wFDN_FLA__D_lgt_6	;
self.final_score_7	:= 	wFDN_FLA__D_lgt_7	;
self.final_score_8	:= 	wFDN_FLA__D_lgt_8	;
self.final_score_9	:= 	wFDN_FLA__D_lgt_9	;
self.final_score_10	:= 	wFDN_FLA__D_lgt_10	;
self.final_score_11	:= 	wFDN_FLA__D_lgt_11	;
self.final_score_12	:= 	wFDN_FLA__D_lgt_12	;
self.final_score_13	:= 	wFDN_FLA__D_lgt_13	;
self.final_score_14	:= 	wFDN_FLA__D_lgt_14	;
self.final_score_15	:= 	wFDN_FLA__D_lgt_15	;
self.final_score_16	:= 	wFDN_FLA__D_lgt_16	;
self.final_score_17	:= 	wFDN_FLA__D_lgt_17	;
self.final_score_18	:= 	wFDN_FLA__D_lgt_18	;
self.final_score_19	:= 	wFDN_FLA__D_lgt_19	;
self.final_score_20	:= 	wFDN_FLA__D_lgt_20	;
self.final_score_21	:= 	wFDN_FLA__D_lgt_21	;
self.final_score_22	:= 	wFDN_FLA__D_lgt_22	;
self.final_score_23	:= 	wFDN_FLA__D_lgt_23	;
self.final_score_24	:= 	wFDN_FLA__D_lgt_24	;
self.final_score_25	:= 	wFDN_FLA__D_lgt_25	;
self.final_score_26	:= 	wFDN_FLA__D_lgt_26	;
self.final_score_27	:= 	wFDN_FLA__D_lgt_27	;
self.final_score_28	:= 	wFDN_FLA__D_lgt_28	;
self.final_score_29	:= 	wFDN_FLA__D_lgt_29	;
self.final_score_30	:= 	wFDN_FLA__D_lgt_30	;
self.final_score_31	:= 	wFDN_FLA__D_lgt_31	;
self.final_score_32	:= 	wFDN_FLA__D_lgt_32	;
self.final_score_33	:= 	wFDN_FLA__D_lgt_33	;
self.final_score_34	:= 	wFDN_FLA__D_lgt_34	;
self.final_score_35	:= 	wFDN_FLA__D_lgt_35	;
self.final_score_36	:= 	wFDN_FLA__D_lgt_36	;
self.final_score_37	:= 	wFDN_FLA__D_lgt_37	;
self.final_score_38	:= 	wFDN_FLA__D_lgt_38	;
self.final_score_39	:= 	wFDN_FLA__D_lgt_39	;
self.final_score_40	:= 	wFDN_FLA__D_lgt_40	;
self.final_score_41	:= 	wFDN_FLA__D_lgt_41	;
self.final_score_42	:= 	wFDN_FLA__D_lgt_42	;
self.final_score_43	:= 	wFDN_FLA__D_lgt_43	;
self.final_score_44	:= 	wFDN_FLA__D_lgt_44	;
self.final_score_45	:= 	wFDN_FLA__D_lgt_45	;
self.final_score_46	:= 	wFDN_FLA__D_lgt_46	;
self.final_score_47	:= 	wFDN_FLA__D_lgt_47	;
self.final_score_48	:= 	wFDN_FLA__D_lgt_48	;
self.final_score_49	:= 	wFDN_FLA__D_lgt_49	;
self.final_score_50	:= 	wFDN_FLA__D_lgt_50	;
self.final_score_51	:= 	wFDN_FLA__D_lgt_51	;
self.final_score_52	:= 	wFDN_FLA__D_lgt_52	;
self.final_score_53	:= 	wFDN_FLA__D_lgt_53	;
self.final_score_54	:= 	wFDN_FLA__D_lgt_54	;
self.final_score_55	:= 	wFDN_FLA__D_lgt_55	;
self.final_score_56	:= 	wFDN_FLA__D_lgt_56	;
self.final_score_57	:= 	wFDN_FLA__D_lgt_57	;
self.final_score_58	:= 	wFDN_FLA__D_lgt_58	;
self.final_score_59	:= 	wFDN_FLA__D_lgt_59	;
self.final_score_60	:= 	wFDN_FLA__D_lgt_60	;
self.final_score_61	:= 	wFDN_FLA__D_lgt_61	;
self.final_score_62	:= 	wFDN_FLA__D_lgt_62	;
self.final_score_63	:= 	wFDN_FLA__D_lgt_63	;
self.final_score_64	:= 	wFDN_FLA__D_lgt_64	;
self.final_score_65	:= 	wFDN_FLA__D_lgt_65	;
self.final_score_66	:= 	wFDN_FLA__D_lgt_66	;
self.final_score_67	:= 	wFDN_FLA__D_lgt_67	;
self.final_score_68	:= 	wFDN_FLA__D_lgt_68	;
self.final_score_69	:= 	wFDN_FLA__D_lgt_69	;
self.final_score_70	:= 	wFDN_FLA__D_lgt_70	;
self.final_score_71	:= 	wFDN_FLA__D_lgt_71	;
self.final_score_72	:= 	wFDN_FLA__D_lgt_72	;
self.final_score_73	:= 	wFDN_FLA__D_lgt_73	;
self.final_score_74	:= 	wFDN_FLA__D_lgt_74	;
self.final_score_75	:= 	wFDN_FLA__D_lgt_75	;
self.final_score_76	:= 	wFDN_FLA__D_lgt_76	;
self.final_score_77	:= 	wFDN_FLA__D_lgt_77	;
self.final_score_78	:= 	wFDN_FLA__D_lgt_78	;
self.final_score_79	:= 	wFDN_FLA__D_lgt_79	;
self.final_score_80	:= 	wFDN_FLA__D_lgt_80	;
self.final_score_81	:= 	wFDN_FLA__D_lgt_81	;
self.final_score_82	:= 	wFDN_FLA__D_lgt_82	;
self.final_score_83	:= 	wFDN_FLA__D_lgt_83	;
self.final_score_84	:= 	wFDN_FLA__D_lgt_84	;
self.final_score_85	:= 	wFDN_FLA__D_lgt_85	;
self.final_score_86	:= 	wFDN_FLA__D_lgt_86	;
self.final_score_87	:= 	wFDN_FLA__D_lgt_87	;
self.final_score_88	:= 	wFDN_FLA__D_lgt_88	;
self.final_score_89	:= 	wFDN_FLA__D_lgt_89	;
self.final_score_90	:= 	wFDN_FLA__D_lgt_90	;
self.final_score_91	:= 	wFDN_FLA__D_lgt_91	;
self.final_score_92	:= 	wFDN_FLA__D_lgt_92	;
self.final_score_93	:= 	wFDN_FLA__D_lgt_93	;
self.final_score_94	:= 	wFDN_FLA__D_lgt_94	;
self.final_score_95	:= 	wFDN_FLA__D_lgt_95	;
self.final_score_96	:= 	wFDN_FLA__D_lgt_96	;
self.final_score_97	:= 	wFDN_FLA__D_lgt_97	;
self.final_score_98	:= 	wFDN_FLA__D_lgt_98	;
self.final_score_99	:= 	wFDN_FLA__D_lgt_99	;
self.final_score_100	:= 	wFDN_FLA__D_lgt_100	;
self.final_score_101	:= 	wFDN_FLA__D_lgt_101	;
self.final_score_102	:= 	wFDN_FLA__D_lgt_102	;
self.final_score_103	:= 	wFDN_FLA__D_lgt_103	;
self.final_score_104	:= 	wFDN_FLA__D_lgt_104	;
self.final_score_105	:= 	wFDN_FLA__D_lgt_105	;
self.final_score_106	:= 	wFDN_FLA__D_lgt_106	;
self.final_score_107	:= 	wFDN_FLA__D_lgt_107	;
self.final_score_108	:= 	wFDN_FLA__D_lgt_108	;
self.final_score_109	:= 	wFDN_FLA__D_lgt_109	;
self.final_score_110	:= 	wFDN_FLA__D_lgt_110	;
self.final_score_111	:= 	wFDN_FLA__D_lgt_111	;
self.final_score_112	:= 	wFDN_FLA__D_lgt_112	;
self.final_score_113	:= 	wFDN_FLA__D_lgt_113	;
self.final_score_114	:= 	wFDN_FLA__D_lgt_114	;
self.final_score_115	:= 	wFDN_FLA__D_lgt_115	;
self.final_score_116	:= 	wFDN_FLA__D_lgt_116	;
self.final_score_117	:= 	wFDN_FLA__D_lgt_117	;
self.final_score_118	:= 	wFDN_FLA__D_lgt_118	;
self.final_score_119	:= 	wFDN_FLA__D_lgt_119	;
self.final_score_120	:= 	wFDN_FLA__D_lgt_120	;
self.final_score_121	:= 	wFDN_FLA__D_lgt_121	;
self.final_score_122	:= 	wFDN_FLA__D_lgt_122	;
self.final_score_123	:= 	wFDN_FLA__D_lgt_123	;
self.final_score_124	:= 	wFDN_FLA__D_lgt_124	;
self.final_score_125	:= 	wFDN_FLA__D_lgt_125	;
self.final_score_126	:= 	wFDN_FLA__D_lgt_126	;
self.final_score_127	:= 	wFDN_FLA__D_lgt_127	;
self.final_score_128	:= 	wFDN_FLA__D_lgt_128	;
self.final_score_129	:= 	wFDN_FLA__D_lgt_129	;
self.final_score_130	:= 	wFDN_FLA__D_lgt_130	;
self.final_score_131	:= 	wFDN_FLA__D_lgt_131	;
self.final_score_132	:= 	wFDN_FLA__D_lgt_132	;
self.final_score_133	:= 	wFDN_FLA__D_lgt_133	;
self.final_score_134	:= 	wFDN_FLA__D_lgt_134	;
self.final_score_135	:= 	wFDN_FLA__D_lgt_135	;
self.final_score_136	:= 	wFDN_FLA__D_lgt_136	;
self.final_score_137	:= 	wFDN_FLA__D_lgt_137	;
self.final_score_138	:= 	wFDN_FLA__D_lgt_138	;
self.final_score_139	:= 	wFDN_FLA__D_lgt_139	;
self.final_score_140	:= 	wFDN_FLA__D_lgt_140	;
self.final_score_141	:= 	wFDN_FLA__D_lgt_141	;
self.final_score_142	:= 	wFDN_FLA__D_lgt_142	;
self.final_score_143	:= 	wFDN_FLA__D_lgt_143	;
self.final_score_144	:= 	wFDN_FLA__D_lgt_144	;
self.final_score_145	:= 	wFDN_FLA__D_lgt_145	;
self.final_score_146	:= 	wFDN_FLA__D_lgt_146	;
self.final_score_147	:= 	wFDN_FLA__D_lgt_147	;
self.final_score_148	:= 	wFDN_FLA__D_lgt_148	;
self.final_score_149	:= 	wFDN_FLA__D_lgt_149	;
self.final_score_150	:= 	wFDN_FLA__D_lgt_150	;
self.final_score_151	:= 	wFDN_FLA__D_lgt_151	;
self.final_score_152	:= 	wFDN_FLA__D_lgt_152	;
self.final_score_153	:= 	wFDN_FLA__D_lgt_153	;
self.final_score_154	:= 	wFDN_FLA__D_lgt_154	;
self.final_score_155	:= 	wFDN_FLA__D_lgt_155	;
self.final_score_156	:= 	wFDN_FLA__D_lgt_156	;
self.final_score_157	:= 	wFDN_FLA__D_lgt_157	;
self.final_score_158	:= 	wFDN_FLA__D_lgt_158	;
self.final_score_159	:= 	wFDN_FLA__D_lgt_159	;
self.final_score_160	:= 	wFDN_FLA__D_lgt_160	;
self.final_score_161	:= 	wFDN_FLA__D_lgt_161	;
self.final_score_162	:= 	wFDN_FLA__D_lgt_162	;
self.final_score_163	:= 	wFDN_FLA__D_lgt_163	;
self.final_score_164	:= 	wFDN_FLA__D_lgt_164	;
self.final_score_165	:= 	wFDN_FLA__D_lgt_165	;
self.final_score_166	:= 	wFDN_FLA__D_lgt_166	;
self.final_score_167	:= 	wFDN_FLA__D_lgt_167	;
self.final_score_168	:= 	wFDN_FLA__D_lgt_168	;
self.final_score_169	:= 	wFDN_FLA__D_lgt_169	;
self.final_score_170	:= 	wFDN_FLA__D_lgt_170	;
self.final_score_171	:= 	wFDN_FLA__D_lgt_171	;
self.final_score_172	:= 	wFDN_FLA__D_lgt_172	;
self.final_score_173	:= 	wFDN_FLA__D_lgt_173	;
self.final_score_174	:= 	wFDN_FLA__D_lgt_174	;
self.final_score_175	:= 	wFDN_FLA__D_lgt_175	;
self.final_score_176	:= 	wFDN_FLA__D_lgt_176	;
self.final_score_177	:= 	wFDN_FLA__D_lgt_177	;
self.final_score_178	:= 	wFDN_FLA__D_lgt_178	;
self.final_score_179	:= 	wFDN_FLA__D_lgt_179	;
self.final_score_180	:= 	wFDN_FLA__D_lgt_180	;
self.final_score_181	:= 	wFDN_FLA__D_lgt_181	;
self.final_score_182	:= 	wFDN_FLA__D_lgt_182	;
self.final_score_183	:= 	wFDN_FLA__D_lgt_183	;
self.final_score_184	:= 	wFDN_FLA__D_lgt_184	;
self.final_score_185	:= 	wFDN_FLA__D_lgt_185	;
self.final_score_186	:= 	wFDN_FLA__D_lgt_186	;
self.final_score_187	:= 	wFDN_FLA__D_lgt_187	;
self.final_score_188	:= 	wFDN_FLA__D_lgt_188	;
self.final_score_189	:= 	wFDN_FLA__D_lgt_189	;
self.final_score_190	:= 	wFDN_FLA__D_lgt_190	;
self.final_score_191	:= 	wFDN_FLA__D_lgt_191	;
self.final_score_192	:= 	wFDN_FLA__D_lgt_192	;
self.final_score_193	:= 	wFDN_FLA__D_lgt_193	;
self.final_score_194	:= 	wFDN_FLA__D_lgt_194	;
self.final_score_195	:= 	wFDN_FLA__D_lgt_195	;
self.final_score_196	:= 	wFDN_FLA__D_lgt_196	;
self.final_score_197	:= 	wFDN_FLA__D_lgt_197	;
self.final_score_198	:= 	wFDN_FLA__D_lgt_198	;
self.final_score_199	:= 	wFDN_FLA__D_lgt_199	;
self.final_score_200	:= 	wFDN_FLA__D_lgt_200	;
self.final_score_201	:= 	wFDN_FLA__D_lgt_201	;
self.final_score_202	:= 	wFDN_FLA__D_lgt_202	;
self.final_score_203	:= 	wFDN_FLA__D_lgt_203	;
self.final_score_204	:= 	wFDN_FLA__D_lgt_204	;
self.final_score_205	:= 	wFDN_FLA__D_lgt_205	;
self.final_score_206	:= 	wFDN_FLA__D_lgt_206	;
self.final_score_207	:= 	wFDN_FLA__D_lgt_207	;
self.final_score_208	:= 	wFDN_FLA__D_lgt_208	;
self.FP3_wFDN_LGT		:= 	wFDN_FLA__D_lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
