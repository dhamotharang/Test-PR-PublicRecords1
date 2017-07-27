
export FP31505_FLAP( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   woFDN_FLAP___lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FLAP___lgt_1 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 50.45) => 
      map(
      (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 0.4532190101,
      (r_nas_addr_verd_d > 0.5) => 0.0797068807,
      (r_nas_addr_verd_d = NULL) => 0.1315601447, 0.1315601447),
   (c_fammar_p > 50.45) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0440666715,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.0436891059,
      (nf_seg_FraudPoint_3_0 = '') => -0.0287442342, -0.0287442342),
   (c_fammar_p = NULL) => -0.0433060543, -0.0172410057),
(f_inq_HighRiskCredit_count_i > 1.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1663823146,
   (f_inq_Communications_count_i > 0.5) => 0.5815922610,
   (f_inq_Communications_count_i = NULL) => 0.2984570491, 0.2984570491),
(f_inq_HighRiskCredit_count_i = NULL) => 0.2420763084, -0.0016766067);

// Tree: 2 
woFDN_FLAP___lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 0.1379614368,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0360364943,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1611022963,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0317980898, -0.0317980898),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0227156529, -0.0227156529),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 5.5) => 0.0570470868,
   (f_rel_under500miles_cnt_d > 5.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.2053341054,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 0.4658623133,
      (nf_seg_FraudPoint_3_0 = '') => 0.3461246016, 0.3461246016),
   (f_rel_under500miles_cnt_d = NULL) => 0.1159462096, 0.2185805338),
(f_varrisktype_i = NULL) => 0.1415150563, -0.0068478078);

// Tree: 3 
woFDN_FLAP___lgt_3 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 50.5) => 0.0373036788,
      (c_low_ed > 50.5) => 0.2518470471,
      (c_low_ed = NULL) => -0.0119876245, 0.1053387488),
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0300257873,
      (f_varrisktype_i > 3.5) => 0.1061416576,
      (f_varrisktype_i = NULL) => -0.0235816984, -0.0235816984),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0154248758, -0.0154248758),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.1043275121,
   (f_srchvelocityrisktype_i > 4.5) => 0.3227622973,
   (f_srchvelocityrisktype_i = NULL) => 0.1936871970, 0.1936871970),
(f_inq_Communications_count_i = NULL) => 0.1045520761, -0.0068473366);

// Tree: 4 
woFDN_FLAP___lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0666809440,
         (f_corrphonelastnamecount_d > 0.5) => -0.0361386597,
         (f_corrphonelastnamecount_d = NULL) => 0.0216429498, 0.0216429498),
      (k_inq_per_phone_i > 2.5) => 0.3164004243,
      (k_inq_per_phone_i = NULL) => 0.0326381026, 0.0326381026),
   (f_phone_ver_experian_d > 0.5) => -0.0513153645,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 10.5) => -0.0124576238,
      (f_assocsuspicousidcount_i > 10.5) => 0.4069403533,
      (f_assocsuspicousidcount_i = NULL) => -0.0029108880, -0.0029108880), -0.0133374831),
(f_srchfraudsrchcount_i > 8.5) => 0.1989369162,
(f_srchfraudsrchcount_i = NULL) => 0.1109604541, -0.0063057063);

// Tree: 5 
woFDN_FLAP___lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 58.95) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0536444297,
      (f_rel_felony_count_i > 2.5) => 0.3624942698,
      (f_rel_felony_count_i = NULL) => 0.0653885531, 0.0653885531),
   (c_fammar_p > 58.95) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.3273196264,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0307254244,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0288737227, -0.0288737227),
   (c_fammar_p = NULL) => -0.0338006225, -0.0166174416),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.0781351376,
   (f_varrisktype_i > 4.5) => 0.2123722069,
   (f_varrisktype_i = NULL) => 0.0976074233, 0.0976074233),
(f_srchvelocityrisktype_i = NULL) => 0.0860409979, -0.0054146508);

// Tree: 6 
woFDN_FLAP___lgt_6 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.2432906249,
   (r_I60_inq_comm_recency_d > 549) => 0.1010213045,
   (r_I60_inq_comm_recency_d = NULL) => 0.1465919462, 0.1465919462),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0459233134,
      (f_corrrisktype_i > 7.5) => 0.0269494154,
      (f_corrrisktype_i = NULL) => -0.0284330402, -0.0284330402),
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0389710886,
      (f_rel_felony_count_i > 0.5) => 0.2268470452,
      (f_rel_felony_count_i = NULL) => 0.0709042733, 0.0709042733),
   (k_inq_per_addr_i = NULL) => -0.0175712555, -0.0175712555),
(r_D33_Eviction_Recency_d = NULL) => 0.0695573308, -0.0097500546);

// Tree: 7 
woFDN_FLAP___lgt_7 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.05) => 0.0180473442,
      (c_famotf18_p > 29.05) => 0.1423423207,
      (c_famotf18_p = NULL) => -0.0214243897, 0.0285631061),
   (k_inq_per_phone_i > 2.5) => 0.1953805565,
   (k_inq_per_phone_i = NULL) => 0.0362268150, 0.0362268150),
(f_phone_ver_experian_d > 0.5) => -0.0452361807,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 10.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1313128909,
      (r_I60_inq_comm_recency_d > 549) => -0.0252186182,
      (r_I60_inq_comm_recency_d = NULL) => -0.0112733072, -0.0112733072),
   (f_assocsuspicousidcount_i > 10.5) => 0.2310874445,
   (f_assocsuspicousidcount_i = NULL) => 0.0469467305, -0.0024274403), -0.0094444080);

// Tree: 8 
woFDN_FLAP___lgt_8 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 135.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0490797916,
         (f_corrrisktype_i > 8.5) => 0.1804981738,
         (f_corrrisktype_i = NULL) => 0.1038810824, 0.1038810824),
      (c_ab_av_edu > 135.5) => -0.0094668623,
      (c_ab_av_edu = NULL) => -0.0323444692, 0.0609109275),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0325293693,
      (f_varrisktype_i > 2.5) => 0.0613222348,
      (f_varrisktype_i = NULL) => -0.0240067871, -0.0240067871),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0156574455, -0.0156574455),
(f_inq_Communications_count_i > 1.5) => 0.1313048317,
(f_inq_Communications_count_i = NULL) => 0.0314623596, -0.0102741336);

// Tree: 9 
woFDN_FLAP___lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.1542889019,
      (k_estimated_income_d > 26500) => 0.0320097564,
      (k_estimated_income_d = NULL) => 0.0518758361, 0.0518758361),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0277762817,
      (k_inq_per_phone_i > 2.5) => 0.0831264326,
      (k_inq_per_phone_i = NULL) => -0.0229143418, -0.0229143418),
   (c_fammar_p = NULL) => -0.0423621052, -0.0123921484),
(f_inq_PrepaidCards_count_i > 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 76.65) => 0.2042661841,
   (c_fammar_p > 76.65) => 0.0612954748,
   (c_fammar_p = NULL) => 0.1495288269, 0.1495288269),
(f_inq_PrepaidCards_count_i = NULL) => 0.0800838542, -0.0066778054);

// Tree: 10 
woFDN_FLAP___lgt_10 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 23500) => 0.0815761837,
      (k_estimated_income_d > 23500) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => -0.0234673104,
         (f_srchfraudsrchcount_i > 12.5) => 0.1141442981,
         (f_srchfraudsrchcount_i = NULL) => -0.0220967506, -0.0220967506),
      (k_estimated_income_d = NULL) => -0.0176538793, -0.0176538793),
   (k_inq_ssns_per_addr_i > 2.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.2239663651,
      (f_prevaddrstatus_i > 2.5) => 0.0692494567,
      (f_prevaddrstatus_i = NULL) => 0.0501687239, 0.1021583072),
   (k_inq_ssns_per_addr_i = NULL) => -0.0123719530, -0.0123719530),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1464037733,
(f_inq_PrepaidCards_count_i = NULL) => 0.0224599388, -0.0075681993);

// Tree: 11 
woFDN_FLAP___lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2667227114,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0230250252,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0215095525, -0.0215095525),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0465133704,
      (r_D33_eviction_count_i > 1.5) => 0.2154289568,
      (r_D33_eviction_count_i = NULL) => 0.0569800178, 0.0569800178),
   (f_inq_Communications_count_i = NULL) => 0.0140982502, -0.0142664344),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1691015795,
   (f_phone_ver_experian_d > 0.5) => 0.0242005036,
   (f_phone_ver_experian_d = NULL) => 0.1678041714, 0.1017748599),
(k_inq_ssns_per_addr_i = NULL) => -0.0088691649, -0.0088691649);

// Tree: 12 
woFDN_FLAP___lgt_12 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.95) => 0.1115557206,
      (c_fammar_p > 44.95) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -6811.5) => 0.2051559393,
            (f_addrchangeincomediff_d > -6811.5) => 0.0531209812,
            (f_addrchangeincomediff_d = NULL) => 0.0409391750, 0.0585226950),
         (f_phone_ver_experian_d > 0.5) => -0.0472491568,
         (f_phone_ver_experian_d = NULL) => 0.0034050255, 0.0177670817),
      (c_fammar_p = NULL) => -0.0601159335, 0.0213869446),
   (k_nap_phn_verd_d > 0.5) => -0.0362691944,
   (k_nap_phn_verd_d = NULL) => -0.0141899407, -0.0141899407),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.0969524364,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0432772139, -0.0099694629);

// Tree: 13 
woFDN_FLAP___lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1165268775,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 
            map(
            (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -56) => 0.1154295842,
            (f_addrchangevaluediff_d > -56) => 0.0036684308,
            (f_addrchangevaluediff_d = NULL) => 0.0180313236, 0.0140480761),
         (f_srchaddrsrchcount_i > 15.5) => 0.1761617588,
         (f_srchaddrsrchcount_i = NULL) => 0.0182874080, 0.0182874080),
      (f_phone_ver_experian_d > 0.5) => -0.0408722227,
      (f_phone_ver_experian_d = NULL) => -0.0108066855, -0.0152517471),
   (r_D33_Eviction_Recency_d = NULL) => -0.0127895871, -0.0127895871),
(f_assocsuspicousidcount_i > 13.5) => 0.1953934810,
(f_assocsuspicousidcount_i = NULL) => 0.0407676892, -0.0102074965);

// Tree: 14 
woFDN_FLAP___lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1021822810,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 0.0224764848,
      (r_L79_adls_per_addr_curr_i > 1.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 163) => 0.0866076875,
         (r_C10_M_Hdr_FS_d > 163) => 0.2895591126,
         (r_C10_M_Hdr_FS_d = NULL) => 0.1773583248, 0.1773583248),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0759890306, 0.0759890306),
   (r_C12_source_profile_index_d > 0.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0235907162,
      (f_srchvelocityrisktype_i > 4.5) => 0.0441994039,
      (f_srchvelocityrisktype_i = NULL) => -0.0157636994, -0.0157636994),
   (r_C12_source_profile_index_d = NULL) => -0.0130777384, -0.0130777384),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0176100675, -0.0093832413);

// Tree: 15 
woFDN_FLAP___lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.05) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 0.0179517936,
         (r_D30_Derog_Count_i > 5.5) => 0.1291126262,
         (r_D30_Derog_Count_i = NULL) => 0.0269263597, 0.0269263597),
      (r_L79_adls_per_addr_c6_i > 4.5) => 0.1525553586,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0361313741, 0.0361313741),
   (k_comb_age_d > 68.5) => 0.2907843614,
   (k_comb_age_d = NULL) => 0.0476722976, 0.0476722976),
(c_fammar_p > 61.05) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0222199856,
   (f_varrisktype_i > 4.5) => 0.0851897103,
   (f_varrisktype_i = NULL) => 0.0372906449, -0.0192773612),
(c_fammar_p = NULL) => -0.0363104374, -0.0088045558);

// Tree: 16 
woFDN_FLAP___lgt_16 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 0.0074697484,
      (f_divrisktype_i > 1.5) => 
         map(
         (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0638017851,
         (f_inq_Communications_count_i > 0.5) => 0.1745548908,
         (f_inq_Communications_count_i = NULL) => 0.0787778339, 0.0787778339),
      (f_divrisktype_i = NULL) => 0.0149105921, 0.0149105921),
   (f_phone_ver_insurance_d > 3.5) => -0.0342460881,
   (f_phone_ver_insurance_d = NULL) => -0.0090920317, -0.0090920317),
(r_D30_Derog_Count_i > 5.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.75) => 0.0707533524,
   (c_unemp > 7.75) => 0.2147199495,
   (c_unemp = NULL) => 0.0892106085, 0.0892106085),
(r_D30_Derog_Count_i = NULL) => 0.0238525707, -0.0038410007);

// Tree: 17 
woFDN_FLAP___lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.1235039499,
      (r_D33_Eviction_Recency_d > 30) => -0.0223210484,
      (r_D33_Eviction_Recency_d = NULL) => -0.0206494112, -0.0212237531),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 0.2273956387,
      (k_estimated_income_d > 28500) => 0.0297559427,
      (k_estimated_income_d = NULL) => 0.1139774040, 0.1139774040),
   (k_nap_contradictory_i = NULL) => -0.0189837764, -0.0189837764),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0347398147,
   (f_hh_payday_loan_users_i > 0.5) => 0.1106241124,
   (f_hh_payday_loan_users_i = NULL) => 0.0465196876, 0.0465196876),
(k_inq_per_addr_i = NULL) => -0.0117647112, -0.0117647112);

// Tree: 18 
woFDN_FLAP___lgt_18 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0156893726,
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1967197125,
         (r_C10_M_Hdr_FS_d > 7.5) => 0.0190167146,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0268507196, 0.0268507196),
      (f_rel_felony_count_i > 1.5) => 0.1939136726,
      (f_rel_felony_count_i = NULL) => 0.0361808950, 0.0361808950),
   (f_corrrisktype_i = NULL) => -0.0077447496, -0.0077447496),
(r_D33_eviction_count_i > 2.5) => 0.1194324173,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 98.5) => 0.1191760544,
   (c_many_cars > 98.5) => -0.0720632595,
   (c_many_cars = NULL) => 0.0383269136, 0.0383269136), -0.0058046273);

// Tree: 19 
woFDN_FLAP___lgt_19 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 0.0132090900,
         (k_inq_per_phone_i > 2.5) => 
            map(
            (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0467935242,
            (r_Phn_Cell_n > 0.5) => 0.2988627230,
            (r_Phn_Cell_n = NULL) => 0.1397440413, 0.1397440413),
         (k_inq_per_phone_i = NULL) => 0.0178239959, 0.0178239959),
      (f_rel_felony_count_i > 1.5) => 0.1313124610,
      (f_rel_felony_count_i = NULL) => 0.0242428059, 0.0242428059),
   (k_nap_phn_verd_d > 0.5) => -0.0201979548,
   (k_nap_phn_verd_d = NULL) => -0.0035407295, -0.0035407295),
(f_inq_PrepaidCards_count_i > 1.5) => 0.1296980531,
(f_inq_PrepaidCards_count_i = NULL) => 0.0093511997, -0.0020238246);

// Tree: 20 
woFDN_FLAP___lgt_20 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0168506543,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -5) => 0.2081526419,
      (f_addrchangecrimediff_i > -5) => 0.0236965098,
      (f_addrchangecrimediff_i = NULL) => 0.1125969038, 0.0501622525),
   (k_inq_per_addr_i = NULL) => -0.0104868041, -0.0104868041),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1471401551) => 0.0800885904,
      (f_add_curr_nhood_BUS_pct_i > 0.1471401551) => 0.2519912093,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1033411186, 0.1033411186),
   (f_phone_ver_experian_d > 0.5) => 0.0179800632,
   (f_phone_ver_experian_d = NULL) => 0.0370640715, 0.0509980573),
(f_varrisktype_i = NULL) => 0.0120657566, -0.0034909515);

// Tree: 21 
woFDN_FLAP___lgt_21 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => -0.0233160325,
   (f_srchaddrsrchcount_i > 4.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 0.0134042859,
      (f_hh_lienholders_i > 1.5) => 0.1101179473,
      (f_hh_lienholders_i = NULL) => 0.0278870352, 0.0278870352),
   (f_srchaddrsrchcount_i = NULL) => -0.0145929690, -0.0145929690),
(f_assocrisktype_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 118.5) => 0.1849560274,
   (f_M_Bureau_ADL_FS_noTU_d > 118.5) => 0.0383507719,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0547565981, 0.0547565981),
(f_assocrisktype_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 97.5) => -0.0383764542,
   (c_burglary > 97.5) => 0.0857850463,
   (c_burglary = NULL) => 0.0204852942, 0.0204852942), -0.0095471297);

// Tree: 22 
woFDN_FLAP___lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 47) => 
      map(
      (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 0.0688909960,
      (r_Prop_Owner_History_d > 1.5) => 0.0016512318,
      (r_Prop_Owner_History_d = NULL) => 0.0276260448, 0.0276260448),
   (c_rich_wht > 47) => -0.0192880205,
   (c_rich_wht = NULL) => -0.0429651839, -0.0111870713),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.1858901388,
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0477993807,
      (r_D33_eviction_count_i > 0.5) => 0.1501635721,
      (r_D33_eviction_count_i = NULL) => 0.0623439330, 0.0623439330),
   (r_C12_source_profile_index_d = NULL) => 0.0732808103, 0.0732808103),
(f_assocrisktype_i = NULL) => -0.0023824014, -0.0070134048);

// Tree: 23 
woFDN_FLAP___lgt_23 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 24.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0316766125,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.0236710478,
      (nf_seg_FraudPoint_3_0 = '') => -0.0204224023, -0.0204224023),
   (k_comb_age_d > 70.5) => 0.1073281536,
   (k_comb_age_d = NULL) => -0.0141518522, -0.0141518522),
(f_addrchangecrimediff_i > 24.5) => 0.0868686874,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 52.5) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => 0.0355865875,
      (f_crim_rel_under25miles_cnt_i > 4.5) => 0.2201193544,
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.1271730776, 0.0547454997),
   (c_born_usa > 52.5) => -0.0090527025,
   (c_born_usa = NULL) => -0.0339334128, 0.0074673322), -0.0063350769);

// Tree: 24 
woFDN_FLAP___lgt_24 := map(
(NULL < c_unemp and c_unemp <= 8.95) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0154892005,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 59.5) => 0.0288154060,
      (k_comb_age_d > 59.5) => 0.1700371163,
      (k_comb_age_d = NULL) => 0.0439217802, 0.0439217802),
   (k_inq_per_addr_i = NULL) => -0.0091921609, -0.0091921609),
(c_unemp > 8.95) => 
   map(
   (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0386187094,
   (f_rel_criminal_count_i > 2.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 20.5) => 0.2302370063,
      (f_prevaddrlenofres_d > 20.5) => 0.0906101866,
      (f_prevaddrlenofres_d = NULL) => 0.1329844951, 0.1329844951),
   (f_rel_criminal_count_i = NULL) => 0.0702840231, 0.0702840231),
(c_unemp = NULL) => -0.0316339178, -0.0059011806);

// Tree: 25 
woFDN_FLAP___lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0066180923,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 0.0507131575,
      (f_phones_per_addr_curr_i > 8.5) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 2.5) => 0.2120567305,
         (f_rel_incomeover75_count_d > 2.5) => 0.0752271909,
         (f_rel_incomeover75_count_d = NULL) => 0.1358027683, 0.1358027683),
      (f_phones_per_addr_curr_i = NULL) => 0.0635266518, 0.0635266518),
   (f_assocrisktype_i = NULL) => 0.0341685604, 0.0222917850),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0252314962,
   (r_D33_eviction_count_i > 3.5) => 0.1178663957,
   (r_D33_eviction_count_i = NULL) => -0.0242786098, -0.0242786098),
(k_nap_phn_verd_d = NULL) => -0.0065021926, -0.0065021926);

// Tree: 26 
woFDN_FLAP___lgt_26 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 27.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 10.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0144174150,
      (f_srchcomponentrisktype_i > 1.5) => 0.0561074114,
      (f_srchcomponentrisktype_i = NULL) => -0.0099508856, -0.0099508856),
   (r_D30_Derog_Count_i > 10.5) => 0.1057588354,
   (r_D30_Derog_Count_i = NULL) => -0.0042761708, -0.0080636068),
(c_famotf18_p > 27.05) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.05) => 0.0441158587,
      (c_pop_6_11_p > 10.05) => 0.1395472422,
      (c_pop_6_11_p = NULL) => 0.0733162307, 0.0733162307),
   (k_estimated_income_d > 36500) => 0.0039908080,
   (k_estimated_income_d = NULL) => 0.0397539229, 0.0397539229),
(c_famotf18_p = NULL) => -0.0016918481, -0.0035740867);

// Tree: 27 
woFDN_FLAP___lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 21.5) => 0.0237397959,
      (f_rel_under500miles_cnt_d > 21.5) => 0.1733623818,
      (f_rel_under500miles_cnt_d = NULL) => 0.0336205327, 0.0336205327),
   (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 0.1360758054,
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0489539749, 0.0489539749),
(c_fammar_p > 50.45) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['6: Other']) => -0.0463926704,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1703) => 0.0017845563,
      (f_addrchangeincomediff_d > 1703) => 0.0848744952,
      (f_addrchangeincomediff_d = NULL) => 0.0084967262, 0.0072716493),
   (nf_seg_FraudPoint_3_0 = '') => -0.0122022767, -0.0122022767),
(c_fammar_p = NULL) => -0.0154536382, -0.0072362026);

// Tree: 28 
woFDN_FLAP___lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62814) => 0.1332662004,
      (f_addrchangevaluediff_d > -62814) => 0.0143671919,
      (f_addrchangevaluediff_d = NULL) => 0.0260422489, 0.0207747192),
   (f_phone_ver_experian_d > 0.5) => -0.0348287805,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1544680734,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0023590468,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0011857595, 0.0011857595), -0.0091770089),
(r_D33_eviction_count_i > 2.5) => 0.1035362838,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 98.5) => -0.0514485953,
   (c_burglary > 98.5) => 0.0990116567,
   (c_burglary = NULL) => 0.0189796078, 0.0189796078), -0.0075490198);

// Tree: 29 
woFDN_FLAP___lgt_29 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1401925474,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0140429696,
         (f_phone_ver_experian_d > 0.5) => -0.0210158725,
         (f_phone_ver_experian_d = NULL) => -0.0240454047, -0.0100562547),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0094318505, -0.0094318505),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1340883873,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0269345464, -0.0090052786),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 82.5) => 0.1756466889,
   (c_many_cars > 82.5) => 0.0335149180,
   (c_many_cars = NULL) => 0.1028304122, 0.1028304122),
(k_nap_contradictory_i = NULL) => -0.0070656766, -0.0070656766);

// Tree: 30 
woFDN_FLAP___lgt_30 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 91.5) => 0.1482269668,
   (r_D32_Mos_Since_Fel_LS_d > 91.5) => -0.0096536298,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0089136253, -0.0089136253),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 95.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 16.1) => 0.1697528711,
      (C_INC_50K_P > 16.1) => 0.0062134348,
      (C_INC_50K_P = NULL) => 0.1032820034, 0.1032820034),
   (c_ab_av_edu > 95.5) => 0.0042633835,
   (c_ab_av_edu = NULL) => 0.0467783034, 0.0467783034),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1966.5) => 0.0975917029,
   (c_med_yearblt > 1966.5) => -0.0382921527,
   (c_med_yearblt = NULL) => 0.0148353698, 0.0148353698), -0.0070059018);

// Tree: 31 
woFDN_FLAP___lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.05) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0058143286,
      (f_assocsuspicousidcount_i > 15.5) => 0.1263364743,
      (f_assocsuspicousidcount_i = NULL) => -0.0050641821, -0.0050641821),
   (c_unemp > 9.05) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0462625034) => -0.0029986629,
      (f_add_input_nhood_VAC_pct_i > 0.0462625034) => 0.0953084448,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0500741112, 0.0500741112),
   (c_unemp = NULL) => -0.0344029113, -0.0030146528),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1653344220,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 92.5) => -0.0449460067,
   (c_assault > 92.5) => 0.0827750887,
   (c_assault = NULL) => 0.0115862814, 0.0115862814), -0.0021697542);

// Tree: 32 
woFDN_FLAP___lgt_32 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => -0.0065732397,
   (f_srchaddrsrchcount_i > 15.5) => 
      map(
      (NULL < c_employees and c_employees <= 23.5) => 0.1881555254,
      (c_employees > 23.5) => 0.0459207104,
      (c_employees = NULL) => 0.0676742703, 0.0676742703),
   (f_srchaddrsrchcount_i = NULL) => -0.0045263159, -0.0045263159),
(f_inq_PrepaidCards_count24_i > 0.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 13.7) => 0.1589493105,
   (c_hh4_p > 13.7) => 0.0183526227,
   (c_hh4_p = NULL) => 0.0895882778, 0.0895882778),
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0318278156,
   (c_assault > 90) => 0.1031637265,
   (c_assault = NULL) => 0.0267346917, 0.0267346917), -0.0029894552);

// Tree: 33 
woFDN_FLAP___lgt_33 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 82.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0175041112,
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 0.0223352539,
      (nf_seg_FraudPoint_3_0 = '') => -0.0111546702, -0.0111546702),
   (k_comb_age_d > 82.5) => 0.1837285408,
   (k_comb_age_d = NULL) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 76.6) => 0.0885895372,
      (c_fammar_p > 76.6) => -0.0887523810,
      (c_fammar_p = NULL) => -0.0106017052, -0.0106017052), -0.0092403683),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.75) => 0.0383138582,
   (c_unemp > 7.75) => 0.1738634014,
   (c_unemp = NULL) => 0.0568077766, 0.0568077766),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0059496763, -0.0059496763);

// Tree: 34 
woFDN_FLAP___lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1270355874,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -1) => 0.1097947631,
         (f_addrchangecrimediff_i > -1) => 0.0276029138,
         (f_addrchangecrimediff_i = NULL) => 
            map(
            (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 5.5) => 0.0163446538,
            (f_phones_per_addr_curr_i > 5.5) => 0.1632767184,
            (f_phones_per_addr_curr_i = NULL) => 0.0452646157, 0.0452646157), 0.0380028865),
      (f_phone_ver_experian_d > 0.5) => -0.0234587132,
      (f_phone_ver_experian_d = NULL) => 0.0040214105, 0.0102136721),
   (f_corrphonelastnamecount_d > 0.5) => -0.0208901572,
   (f_corrphonelastnamecount_d = NULL) => -0.0072898700, -0.0072898700),
(r_C10_M_Hdr_FS_d = NULL) => -0.0003474203, -0.0065401015);

// Tree: 35 
woFDN_FLAP___lgt_35 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0128264137,
   (r_P85_Phn_Disconnected_i > 0.5) => 0.1200835425,
   (r_P85_Phn_Disconnected_i = NULL) => -0.0101679707, -0.0101679707),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 8.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -6240) => 0.1364817449,
      (f_addrchangeincomediff_d > -6240) => 0.0292927095,
      (f_addrchangeincomediff_d = NULL) => -0.0044642307, 0.0253237664),
   (f_rel_homeover500_count_d > 8.5) => 0.1974891096,
   (f_rel_homeover500_count_d = NULL) => 0.0314266424, 0.0314266424),
(f_srchvelocityrisktype_i = NULL) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 24.95) => 0.1053361767,
   (C_RENTOCC_P > 24.95) => -0.0312643533,
   (C_RENTOCC_P = NULL) => 0.0274400067, 0.0274400067), -0.0043571771);

// Tree: 36 
woFDN_FLAP___lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0206018255,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0073001289,
      (r_L79_adls_per_addr_c6_i > 4.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 108) => 0.0093625396,
         (c_serv_empl > 108) => 0.1649915292,
         (c_serv_empl = NULL) => 0.0867110793, 0.0867110793),
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0108990066, 0.0108990066),
   (f_srchcomponentrisktype_i > 1.5) => 0.0899110465,
   (f_srchcomponentrisktype_i = NULL) => 0.0168692430, 0.0168692430),
(f_hh_criminals_i = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 114.5) => -0.0586350921,
   (c_cartheft > 114.5) => 0.0737671109,
   (c_cartheft = NULL) => 0.0011594512, 0.0011594512), -0.0085076694);

// Tree: 37 
woFDN_FLAP___lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.05) => -0.0143888652,
   (c_unemp > 9.05) => 0.0636068835,
   (c_unemp = NULL) => -0.0145395388, -0.0111497091),
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 42.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 275) => 0.0477541590,
         (f_prevaddrageoldest_d > 275) => 0.2854508525,
         (f_prevaddrageoldest_d = NULL) => 0.0673224098, 0.0673224098),
      (c_born_usa > 42.5) => 0.0007182551,
      (c_born_usa = NULL) => 0.0173240600, 0.0173240600),
   (f_util_adl_count_n > 4.5) => 0.0811638242,
   (f_util_adl_count_n = NULL) => 0.0262281136, 0.0262281136),
(f_hh_lienholders_i = NULL) => -0.0033199652, 0.0004026856);

// Tree: 38 
woFDN_FLAP___lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0142708495,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 71.5) => 0.0766183861,
      (c_employees > 71.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -67556) => 0.1538194455,
         (f_addrchangevaluediff_d > -67556) => -0.0000052189,
         (f_addrchangevaluediff_d = NULL) => 0.0311603876, 0.0099259859),
      (c_employees = NULL) => 0.0239014426, 0.0239014426),
   (f_inq_Other_count_i = NULL) => -0.0055978352, -0.0055978352),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1158203470,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 557) => 0.0760474809,
   (c_hh00 > 557) => -0.0364679087,
   (c_hh00 = NULL) => 0.0127054838, 0.0127054838), -0.0047610608);

// Tree: 39 
woFDN_FLAP___lgt_39 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0064746204,
   (f_srchfraudsrchcountmo_i > 0.5) => 0.0681890073,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0025579280, -0.0041974326),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 9.7) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 0.0920198930,
         (r_L79_adls_per_addr_curr_i > 4.5) => 0.2777969888,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.1481850615, 0.1481850615),
      (f_srchfraudsrchcount_i > 1.5) => 0.0282104707,
      (f_srchfraudsrchcount_i = NULL) => 0.0681246479, 0.0681246479),
   (c_hval_80k_p > 9.7) => -0.0557418256,
   (c_hval_80k_p = NULL) => 0.0477794301, 0.0477794301),
(k_inq_per_phone_i = NULL) => -0.0016282964, -0.0016282964);

// Tree: 40 
woFDN_FLAP___lgt_40 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0079805070,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 62.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 68) => 0.2543465746,
         (f_mos_inq_banko_cm_fseen_d > 68) => 0.0753590541,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.1347075478, 0.1347075478),
      (c_born_usa > 62.5) => 0.0141411212,
      (c_born_usa = NULL) => 0.0587084773, 0.0587084773),
   (f_hh_tot_derog_i = NULL) => -0.0044309432, -0.0044309432),
(f_addrchangecrimediff_i > 98) => 0.1186365633,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0011434480,
   (k_nap_contradictory_i > 0.5) => 0.1658415711,
   (k_nap_contradictory_i = NULL) => 0.0033374680, 0.0033374680), -0.0018130581);

// Tree: 41 
woFDN_FLAP___lgt_41 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => 
   map(
   (NULL < c_construction and c_construction <= 5) => 0.1789065286,
   (c_construction > 5) => -0.0074688487,
   (c_construction = NULL) => 0.0835516844, 0.0835516844),
(r_I60_inq_comm_recency_d > 4.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1635802509,
      (f_phone_ver_experian_d > 0.5) => -0.0422428596,
      (f_phone_ver_experian_d = NULL) => 0.0834660752, 0.0692923141),
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0090449381,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0076756926, -0.0076756926),
(r_I60_inq_comm_recency_d = NULL) => 
   map(
   (NULL < c_child and c_child <= 23.75) => -0.0495858905,
   (c_child > 23.75) => 0.0663935680,
   (c_child = NULL) => 0.0143010994, 0.0143010994), -0.0064818367);

// Tree: 42 
woFDN_FLAP___lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1299603880,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0067655813,
      (k_comb_age_d > 81.5) => 0.1364047648,
      (k_comb_age_d = NULL) => -0.0050506171, -0.0050506171),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.25) => 0.1404740612,
      (c_pop_0_5_p > 8.25) => 0.0175615512,
      (c_pop_0_5_p = NULL) => 0.0684219001, 0.0684219001),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0040182025, -0.0040182025),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 15.6) => -0.0421085862,
   (c_hh4_p > 15.6) => 0.0727413570,
   (c_hh4_p = NULL) => 0.0007458702, 0.0007458702), -0.0031980255);

// Tree: 43 
woFDN_FLAP___lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0074325729,
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 12.5) => 0.1498793894,
   (f_M_Bureau_ADL_FS_noTU_d > 12.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 23.35) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -66295) => 0.1300542381,
         (f_addrchangevaluediff_d > -66295) => 0.0073747096,
         (f_addrchangevaluediff_d = NULL) => 0.0475576509, 0.0203153839),
      (c_pop_35_44_p > 23.35) => 0.1646498204,
      (c_pop_35_44_p = NULL) => 0.0272838540, 0.0272838540),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0316774512, 0.0316774512),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 6.8) => 0.0604751689,
   (c_lowrent > 6.8) => -0.0527860180,
   (c_lowrent = NULL) => 0.0011900164, 0.0011900164), -0.0019980845);

// Tree: 44 
woFDN_FLAP___lgt_44 := map(
(NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0144963145,
(c_easiqlife > 132.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 7.5) => 0.0117869405,
   (f_crim_rel_under500miles_cnt_i > 7.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 0.5) => -0.0272195481,
      (r_pb_order_freq_d > 0.5) => 0.0230778297,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 32.5) => 0.2539222310,
         (c_born_usa > 32.5) => 0.0525381310,
         (c_born_usa = NULL) => 0.1503532653, 0.1503532653), 0.0638964883),
   (f_crim_rel_under500miles_cnt_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 0.1499808926,
      (c_asian_lang > 158.5) => -0.0516249229,
      (c_asian_lang = NULL) => 0.0599016984, 0.0599016984), 0.0162627578),
(c_easiqlife = NULL) => -0.0171305526, -0.0037944827);

// Tree: 45 
woFDN_FLAP___lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 207.35) => 0.1015244936,
      (c_cpiall > 207.35) => 0.0091048605,
      (c_cpiall = NULL) => -0.0369298476, 0.0144246109),
   (f_historical_count_d > 0.5) => -0.0207685133,
   (f_historical_count_d = NULL) => -0.0032794782, -0.0032794782),
(k_comb_age_d > 67.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 175.5) => 0.0464034922,
   (c_sub_bus > 175.5) => 0.2572696929,
   (c_sub_bus = NULL) => 0.0678271130, 0.0678271130),
(k_comb_age_d = NULL) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0278354235,
   (k_nap_phn_verd_d > 0.5) => -0.1273507915,
   (k_nap_phn_verd_d = NULL) => -0.0201312247, -0.0201312247), 0.0015519369);

// Tree: 46 
woFDN_FLAP___lgt_46 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 3.95) => 0.0864084362,
      (C_INC_125K_P > 3.95) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 119.5) => 0.0051893135,
         (f_prevaddrageoldest_d > 119.5) => 0.0927747011,
         (f_prevaddrageoldest_d = NULL) => 0.0301281002, 0.0301281002),
      (C_INC_125K_P = NULL) => -0.0101874005, 0.0363903229),
   (f_phone_ver_experian_d > 0.5) => -0.0228439395,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0075318565,
      (f_rel_felony_count_i > 1.5) => 0.1082382414,
      (f_rel_felony_count_i = NULL) => 0.0137830713, 0.0137830713), 0.0121123608),
(f_corrphonelastnamecount_d > 0.5) => -0.0149851196,
(f_corrphonelastnamecount_d = NULL) => -0.0242504467, -0.0033887300);

// Tree: 47 
woFDN_FLAP___lgt_47 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 110.5) => 0.0031110785,
      (c_easiqlife > 110.5) => 0.1314715531,
      (c_easiqlife = NULL) => 0.0757083961, 0.0757083961),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0073790401,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0069865522, -0.0064718149),
(k_inq_per_phone_i > 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0117084990,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 11.95) => 0.0457991987,
      (c_hh5_p > 11.95) => 0.1908959414,
      (c_hh5_p = NULL) => 0.0686301562, 0.0686301562),
   (nf_seg_FraudPoint_3_0 = '') => 0.0336152566, 0.0336152566),
(k_inq_per_phone_i = NULL) => -0.0024646879, -0.0024646879);

// Tree: 48 
woFDN_FLAP___lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29850) => 0.0848268631,
   (r_A46_Curr_AVM_AutoVal_d > 29850) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 0.1429766374,
      (f_M_Bureau_ADL_FS_noTU_d > 7.5) => -0.0013249236,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0006138689, 0.0006138689),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0172631665, -0.0060795431),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 29.55) => 0.0073247439,
   (c_rnt1000_p > 29.55) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 77.5) => 0.2050708540,
      (c_rest_indx > 77.5) => 0.0761781267,
      (c_rest_indx = NULL) => 0.1141754047, 0.1141754047),
   (c_rnt1000_p = NULL) => 0.0373331276, 0.0373331276),
(k_inq_per_phone_i = NULL) => -0.0039371440, -0.0039371440);

// Tree: 49 
woFDN_FLAP___lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => -0.0006466830,
      (f_hh_tot_derog_i > 5.5) => 0.0769990779,
      (f_hh_tot_derog_i = NULL) => 0.0016216943, 0.0016216943),
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 6.85) => 0.1267432285,
      (c_rnt500_p > 6.85) => 0.0141550830,
      (c_rnt500_p = NULL) => 0.0734803750, 0.0734803750),
   (f_varrisktype_i = NULL) => 0.0032091379, 0.0032091379),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0688015217,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 8.95) => -0.0313586151,
   (C_INC_125K_P > 8.95) => 0.0750542101,
   (C_INC_125K_P = NULL) => 0.0214006848, 0.0214006848), 0.0005772304);

// Tree: 50 
woFDN_FLAP___lgt_50 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 42.5) => 0.0028254931,
(r_pb_order_freq_d > 42.5) => -0.0225212595,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_hh_members_w_derog_i and f_hh_members_w_derog_i <= 3.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0467938964,
      (f_prevaddrstatus_i > 2.5) => -0.0029280247,
      (f_prevaddrstatus_i = NULL) => -0.0006207998, 0.0118998119),
   (f_hh_members_w_derog_i > 3.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 87.5) => 0.2869357388,
      (c_easiqlife > 87.5) => 0.0487193281,
      (c_easiqlife = NULL) => 0.1049648695, 0.1049648695),
   (f_hh_members_w_derog_i = NULL) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 0.1) => -0.0764503739,
      (c_hval_125k_p > 0.1) => 0.0588832127,
      (c_hval_125k_p = NULL) => 0.0087596621, 0.0087596621), 0.0160793766), -0.0011318212);

// Tree: 51 
woFDN_FLAP___lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 149.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 246.5) => -0.0093719991,
         (r_C10_M_Hdr_FS_d > 246.5) => 0.1535339623,
         (r_C10_M_Hdr_FS_d = NULL) => 0.0324936938, 0.0324936938),
      (f_curraddrmurderindex_i > 149.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.6) => 0.0526946233,
         (c_pop_6_11_p > 7.6) => 0.2200326556,
         (c_pop_6_11_p = NULL) => 0.1415634088, 0.1415634088),
      (f_curraddrmurderindex_i = NULL) => 0.0582685130, 0.0582685130),
   (f_corraddrnamecount_d > 4.5) => 0.0094448921,
   (f_corraddrnamecount_d = NULL) => 0.0233971592, 0.0233971592),
(c_employees > 71.5) => -0.0103038116,
(c_employees = NULL) => -0.0199015546, -0.0034945774);

// Tree: 52 
woFDN_FLAP___lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0056427722,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_murders and c_murders <= 124.5) => 0.0404540923,
      (c_murders > 124.5) => 
         map(
         (NULL < c_retired and c_retired <= 12.25) => 0.2933073522,
         (c_retired > 12.25) => 0.0809784878,
         (c_retired = NULL) => 0.1643933988, 0.1643933988),
      (c_murders = NULL) => 0.0710025129, 0.0710025129),
   (k_comb_age_d = NULL) => -0.0161456429, -0.0021676098),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.0448545874,
   (f_inq_count_i > 2.5) => 0.2378856400,
   (f_inq_count_i = NULL) => 0.1018145702, 0.1018145702),
(r_P85_Phn_Disconnected_i = NULL) => -0.0000691125, -0.0000691125);

// Tree: 53 
woFDN_FLAP___lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0157351898,
   (r_D32_felony_count_i > 0.5) => 0.0864674056,
   (r_D32_felony_count_i = NULL) => 0.0201819018, -0.0140648754),
(c_easiqlife > 129.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 132.5) => 0.0419060658,
      (c_blue_empl > 132.5) => 0.2082313463,
      (c_blue_empl = NULL) => 0.0737098662, 0.0737098662),
   (f_prevaddrlenofres_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0360779606,
      (f_phone_ver_experian_d > 0.5) => -0.0055151383,
      (f_phone_ver_experian_d = NULL) => -0.0048254723, 0.0094528571),
   (f_prevaddrlenofres_d = NULL) => 0.0178536680, 0.0148525820),
(c_easiqlife = NULL) => -0.0248066640, -0.0036021160);

// Tree: 54 
woFDN_FLAP___lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1350793596,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 141.5) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => -0.0200959508,
         (f_srchfraudsrchcount_i > 1.5) => 0.0769689213,
         (f_srchfraudsrchcount_i = NULL) => 0.0035416088, 0.0035416088),
      (f_prevaddrageoldest_d > 141.5) => 0.1333428072,
      (f_prevaddrageoldest_d = NULL) => 0.0261318316, 0.0261318316),
   (r_F01_inp_addr_address_score_d > 25) => -0.0060409237,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0042330599, -0.0042330599),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0447256858,
   (k_nap_lname_verd_d > 0.5) => -0.0665715612,
   (k_nap_lname_verd_d = NULL) => -0.0027507623, -0.0027507623), -0.0036342797);

// Tree: 55 
woFDN_FLAP___lgt_55 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1898.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0023204247,
      (k_inq_per_phone_i > 2.5) => 0.0768879693,
      (k_inq_per_phone_i = NULL) => 0.0013752563, 0.0013752563),
   (f_addrchangeincomediff_d > 1898.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 11.85) => 0.0420067451,
      (c_hval_150k_p > 11.85) => 0.1921525376,
      (c_hval_150k_p = NULL) => 0.0690252682, 0.0690252682),
   (f_addrchangeincomediff_d = NULL) => 0.0098350235, 0.0075384886),
(f_phone_ver_insurance_d > 3.5) => -0.0230737485,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0363458709,
   (c_construction > 7.45) => -0.0868226827,
   (c_construction = NULL) => -0.0085940067, -0.0085940067), -0.0074410434);

// Tree: 56 
woFDN_FLAP___lgt_56 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 5.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 19.95) => 0.0105735923,
      (C_INC_35K_P > 19.95) => 0.1148197672,
      (C_INC_35K_P = NULL) => 0.0576134508, 0.0152464378),
   (f_phone_ver_experian_d > 0.5) => -0.0164102998,
   (f_phone_ver_experian_d = NULL) => -0.0112445312, -0.0048741046),
(f_inq_HighRiskCredit_count_i > 5.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 18.5) => -0.0255456019,
   (f_mos_inq_banko_cm_lseen_d > 18.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 282.5) => 0.1431760577,
      (f_M_Bureau_ADL_FS_all_d > 282.5) => 0.0153730620,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0906542787, 0.0906542787),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0495215776, 0.0495215776),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0113440142, -0.0037183088);

// Tree: 57 
woFDN_FLAP___lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 178.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0082133223,
      (k_comb_age_d > 81.5) => 
         map(
         (NULL < c_popover25 and c_popover25 <= 1295) => 0.1641247012,
         (c_popover25 > 1295) => -0.0695683855,
         (c_popover25 = NULL) => 0.0830475079, 0.0830475079),
      (k_comb_age_d = NULL) => -0.0070835141, -0.0070835141),
   (c_lar_fam > 178.5) => 0.0971833071,
   (c_lar_fam = NULL) => -0.0266970691, -0.0058457322),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 95.5) => 0.1410710831,
   (c_rich_wht > 95.5) => 0.0264267657,
   (c_rich_wht = NULL) => 0.0772350427, 0.0772350427),
(r_D30_Derog_Count_i = NULL) => -0.0085491897, -0.0047273278);

// Tree: 58 
woFDN_FLAP___lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 25.95) => 0.0111543959,
   (c_hh1_p > 25.95) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0248119052,
      (f_hh_collections_ct_i > 4.5) => 0.1327873094,
      (f_hh_collections_ct_i = NULL) => 0.0126276444, -0.0228748415),
   (c_hh1_p = NULL) => -0.0461732542, -0.0043552559),
(k_inq_per_phone_i > 5.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 19.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 3.45) => 0.2004890029,
      (c_lowrent > 3.45) => 0.0531347463,
      (c_lowrent = NULL) => 0.1120764490, 0.1120764490),
   (f_srchphonesrchcount_i > 19.5) => -0.0553075961,
   (f_srchphonesrchcount_i = NULL) => 0.0662067828, 0.0662067828),
(k_inq_per_phone_i = NULL) => -0.0031982276, -0.0031982276);

// Tree: 59 
woFDN_FLAP___lgt_59 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0064285372,
   (f_nae_nothing_found_i > 0.5) => 0.1007781906,
   (f_nae_nothing_found_i = NULL) => -0.0049822850, -0.0049822850),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.95) => -0.0234722993,
   (c_pop_35_44_p > 12.95) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.3487641756) => 0.1934732416,
      (f_add_input_nhood_MFD_pct_i > 0.3487641756) => 0.0700645973,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.1287217924, 0.1287217924),
   (c_pop_35_44_p = NULL) => 0.0717109763, 0.0717109763),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.15) => 0.0483557501,
   (c_hh3_p > 13.15) => -0.0913086828,
   (c_hh3_p = NULL) => -0.0232078436, -0.0232078436), -0.0032999620);

// Tree: 60 
woFDN_FLAP___lgt_60 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 0.5) => -0.0089192605,
(f_divaddrsuspidcountnew_i > 0.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 46.05) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => 
         map(
         (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0429386164,
         (f_hh_payday_loan_users_i > 0.5) => 0.1171428590,
         (f_hh_payday_loan_users_i = NULL) => 0.0508867442, 0.0508867442),
      (f_corraddrnamecount_d > 6.5) => -0.0059133577,
      (f_corraddrnamecount_d = NULL) => 0.0290193183, 0.0290193183),
   (c_high_ed > 46.05) => -0.0374884400,
   (c_high_ed = NULL) => 0.0138761840, 0.0138761840),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 13.65) => -0.0615026017,
   (c_retail > 13.65) => 0.0699721539,
   (c_retail = NULL) => -0.0097408869, -0.0097408869), -0.0045371415);

// Tree: 61 
woFDN_FLAP___lgt_61 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0047563576,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1040925000,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => 
         map(
         (NULL < f_current_count_d and f_current_count_d <= 0.5) => 0.0388536379,
         (f_current_count_d > 0.5) => -0.0422167525,
         (f_current_count_d = NULL) => 0.0031490618, 0.0031490618),
      (r_C23_inp_addr_occ_index_d > 3.5) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 8.5) => 0.2045693672,
         (f_rel_under100miles_cnt_d > 8.5) => 0.0153281239,
         (f_rel_under100miles_cnt_d = NULL) => 0.1169576805, 0.1169576805),
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0148895420, 0.0148895420),
   (r_D33_Eviction_Recency_d = NULL) => 0.0220501552, 0.0220501552),
(f_inq_Communications_count_i = NULL) => -0.0223314976, -0.0024868026);

// Tree: 62 
woFDN_FLAP___lgt_62 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.0914272721,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0081584685,
   (f_prevaddrageoldest_d > 152.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 12.65) => 0.2634728292,
      (c_hh2_p > 12.65) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0156144452,
         (f_corrrisktype_i > 8.5) => 0.1041677054,
         (f_corrrisktype_i = NULL) => 0.0200391185, 0.0200391185),
      (c_hh2_p = NULL) => 0.0243976797, 0.0243976797),
   (f_prevaddrageoldest_d = NULL) => -0.0001823425, -0.0001823425),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 121.5) => -0.0019723647,
   (c_relig_indx > 121.5) => 0.0856404812,
   (c_relig_indx = NULL) => 0.0372228559, 0.0372228559), 0.0006276895);

// Tree: 63 
woFDN_FLAP___lgt_63 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 98455.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13214266075) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 5) => 0.1254449342,
         (c_hh4_p > 5) => -0.0173504217,
         (c_hh4_p = NULL) => 0.0015212112, 0.0015212112),
      (f_add_curr_nhood_BUS_pct_i > 0.13214266075) => 0.1834214045,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0252170218, 0.0252170218),
   (f_addrchangevaluediff_d > 98455.5) => 0.1867124809,
   (f_addrchangevaluediff_d = NULL) => 0.0121038795, 0.0301562167),
(f_corraddrnamecount_d > 1.5) => -0.0035272704,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 127) => -0.0603168162,
   (c_cartheft > 127) => 0.0549020497,
   (c_cartheft = NULL) => -0.0194590623, -0.0194590623), -0.0012560651);

// Tree: 64 
woFDN_FLAP___lgt_64 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 
      map(
      (NULL < c_retail and c_retail <= 12.8) => 0.0001169158,
      (c_retail > 12.8) => 0.1318043107,
      (c_retail = NULL) => 0.0534647291, 0.0534647291),
   (r_C21_M_Bureau_ADL_FS_d > 8.5) => -0.0075120988,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0060249891, -0.0060249891),
(f_prevaddrageoldest_d > 271.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 23.5) => 0.2131705389,
   (f_mos_inq_banko_cm_lseen_d > 23.5) => 0.0483265523,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0559902198, 0.0559902198),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0744475825,
   (c_rich_nfam > 124) => -0.0509439336,
   (c_rich_nfam = NULL) => 0.0112421028, 0.0112421028), -0.0004604472);

// Tree: 65 
woFDN_FLAP___lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0061287147,
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0042014073,
   (f_corrrisktype_i > 6.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
         map(
         (NULL < c_hval_750k_p and c_hval_750k_p <= 42.85) => 0.0382827120,
         (c_hval_750k_p > 42.85) => 0.2349654135,
         (c_hval_750k_p = NULL) => 0.0514524648, 0.0514524648),
      (f_srchcomponentrisktype_i > 1.5) => 0.2216333265,
      (f_srchcomponentrisktype_i = NULL) => 0.0618682727, 0.0618682727),
   (f_corrrisktype_i = NULL) => 0.0233732270, 0.0233732270),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 52.5) => 0.0945842681,
   (c_born_usa > 52.5) => -0.0222395050,
   (c_born_usa = NULL) => 0.0200879490, 0.0200879490), 0.0012946777);

// Tree: 66 
woFDN_FLAP___lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 132.5) => -0.0195424328,
   (c_span_lang > 132.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 0.5) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 75.5) => 0.0297779832,
         (c_sfdu_p > 75.5) => 0.2286610545,
         (c_sfdu_p = NULL) => 0.0866017179, 0.0866017179),
      (f_prevaddrlenofres_d > 0.5) => 0.0087024808,
      (f_prevaddrlenofres_d = NULL) => 0.0126365830, 0.0126365830),
   (c_span_lang = NULL) => -0.0074710763, -0.0074710763),
(c_hh3_p > 23.25) => 
   map(
   (NULL < c_larceny and c_larceny <= 182) => 0.0461453110,
   (c_larceny > 182) => -0.0789438839,
   (c_larceny = NULL) => 0.0394626413, 0.0394626413),
(c_hh3_p = NULL) => -0.0091959382, -0.0003764845);

// Tree: 67 
woFDN_FLAP___lgt_67 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 100.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 18.85) => -0.0060847210,
   (c_pop_55_64_p > 18.85) => 0.0615988802,
   (c_pop_55_64_p = NULL) => -0.0016003773, -0.0016003773),
(f_addrchangecrimediff_i > 100.5) => 0.0882112097,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 9) => 0.1525728443,
   (r_I60_inq_retail_recency_d > 9) => 
      map(
      (NULL < f_util_add_input_inf_n and f_util_add_input_inf_n <= 0.5) => -0.0063681366,
      (f_util_add_input_inf_n > 0.5) => 0.0991544294,
      (f_util_add_input_inf_n = NULL) => -0.0017750785, -0.0017750785),
   (r_I60_inq_retail_recency_d = NULL) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 71.95) => 0.0677897701,
      (c_fammar_p > 71.95) => -0.0592713356,
      (c_fammar_p = NULL) => -0.0092472783, -0.0092472783), 0.0015623162), -0.0003519071);

// Tree: 68 
woFDN_FLAP___lgt_68 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 73) => 0.1486900911,
      (c_serv_empl > 73) => 0.0289824475,
      (c_serv_empl = NULL) => 0.0649567652, 0.0649567652),
   (r_I60_inq_PrepaidCards_recency_d > 549) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.25) => 0.0096335053,
      (c_pop_6_11_p > 15.25) => 0.1601108904,
      (c_pop_6_11_p = NULL) => -0.0028008144, 0.0107150347),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0124873507, 0.0124873507),
(f_historical_count_d > 0.5) => -0.0149939192,
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.7) => 0.0491652298,
   (c_construction > 4.7) => -0.0709390529,
   (c_construction = NULL) => -0.0141455549, -0.0141455549), -0.0017227840);

// Tree: 69 
woFDN_FLAP___lgt_69 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 17.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => -0.0055292630,
      (r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0844689633,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0058571070, -0.0058571070),
   (f_inq_HighRiskCredit_count_i > 17.5) => 0.0685212326,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0054235545, -0.0054235545),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 3.5) => 0.0175101296,
   (f_rel_ageover40_count_d > 3.5) => 0.2143714210,
   (f_rel_ageover40_count_d = NULL) => 0.0860797929, 0.0860797929),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_totsales and c_totsales <= 11494) => -0.0575282327,
   (c_totsales > 11494) => 0.0522516548,
   (c_totsales = NULL) => -0.0083730592, -0.0083730592), -0.0041309144);

// Tree: 70 
woFDN_FLAP___lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124250) => 0.1254666379,
      (r_L80_Inp_AVM_AutoVal_d > 124250) => 0.0396095879,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0057093456, 0.0302966094),
   (f_prevaddrlenofres_d > 1.5) => -0.0106446300,
   (f_prevaddrlenofres_d = NULL) => -0.0021931149, -0.0079405162),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0077694409,
   (r_C14_Addr_Stability_v2_d > 3.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 76500) => 0.1942009468,
      (k_estimated_income_d > 76500) => 0.0693776205,
      (k_estimated_income_d = NULL) => 0.0852066655, 0.0852066655),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0461410746, 0.0461410746),
(c_hval_750k_p = NULL) => 0.0102626095, -0.0034459880);

// Tree: 71 
woFDN_FLAP___lgt_71 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0013343284,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 5.5) => -0.0415345326,
   (f_mos_inq_banko_om_lseen_d > 5.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 88.35) => 0.1558703667,
         (c_occunit_p > 88.35) => 
            map(
            (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 99.5) => 0.1560480868,
            (r_D32_Mos_Since_Crim_LS_d > 99.5) => 0.0324803233,
            (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0531811084, 0.0531811084),
         (c_occunit_p = NULL) => 0.0752156456, 0.0752156456),
      (f_current_count_d > 0.5) => 0.0049139300,
      (f_current_count_d = NULL) => 0.0429720016, 0.0429720016),
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0279668661, 0.0279668661),
(f_inq_Communications_count_i = NULL) => -0.0229081663, 0.0034071290);

// Tree: 72 
woFDN_FLAP___lgt_72 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => -0.0042091714,
   (f_inq_Other_count24_i > 3.5) => 
      map(
      (NULL < c_health and c_health <= 3.5) => -0.0654624888,
      (c_health > 3.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 0.5) => 0.0565994447,
         (k_inq_per_phone_i > 0.5) => 0.2123846517,
         (k_inq_per_phone_i = NULL) => 0.1264736920, 0.1264736920),
      (c_health = NULL) => 0.0690907101, 0.0690907101),
   (f_inq_Other_count24_i = NULL) => -0.0030492327, -0.0030492327),
(f_assocsuspicousidcount_i > 15.5) => 0.0979503940,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => -0.0579060689,
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.0432860766,
   (r_L79_adls_per_addr_c6_i = NULL) => -0.0245721857, -0.0245721857), -0.0028121753);

// Tree: 73 
woFDN_FLAP___lgt_73 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 46.25) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0111801946,
   (f_hh_lienholders_i > 0.5) => 0.0171483076,
   (f_hh_lienholders_i = NULL) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 101.5) => -0.0831163916,
      (c_span_lang > 101.5) => 0.0521376527,
      (c_span_lang = NULL) => -0.0058283663, -0.0058283663), -0.0023518652),
(c_famotf18_p > 46.25) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 237) => -0.0083072374,
   (r_A50_pb_average_dollars_d > 237) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.312773744) => 0.1831898396,
      (f_add_input_mobility_index_i > 0.312773744) => 0.0059864907,
      (f_add_input_mobility_index_i = NULL) => 0.1030631079, 0.1030631079),
   (r_A50_pb_average_dollars_d = NULL) => 0.0468978907, 0.0468978907),
(c_famotf18_p = NULL) => -0.0069654177, -0.0015349994);

// Tree: 74 
woFDN_FLAP___lgt_74 := map(
(NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 4.25) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 17.75) => 0.0912497427,
      (C_INC_75K_P > 17.75) => -0.0348064658,
      (C_INC_75K_P = NULL) => 0.0399890338, 0.0399890338),
   (c_high_ed > 4.25) => -0.0060206663,
   (c_high_ed = NULL) => 0.0447347936, -0.0035567544),
(f_srchphonesrchcountwk_i > 0.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3) => 0.1429901893,
   (r_A44_curr_add_naprop_d > 3) => -0.0272937867,
   (r_A44_curr_add_naprop_d = NULL) => 0.0603897532, 0.0603897532),
(f_srchphonesrchcountwk_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.3) => -0.0466985794,
   (c_pop_6_11_p > 7.3) => 0.0687441483,
   (c_pop_6_11_p = NULL) => 0.0200864697, 0.0200864697), -0.0026184393);

// Tree: 75 
woFDN_FLAP___lgt_75 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0083207873,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.45) => -0.0167405533,
      (c_hval_125k_p > 4.45) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.10997263455) => 
            map(
            (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 61.5) => 0.1397613704,
            (r_I61_inq_collection_recency_d > 61.5) => 0.0194470186,
            (r_I61_inq_collection_recency_d = NULL) => 0.0517079647, 0.0517079647),
         (f_add_curr_nhood_VAC_pct_i > 0.10997263455) => 0.2400596854,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0795556653, 0.0795556653),
      (c_hval_125k_p = NULL) => 0.0268918381, 0.0268918381),
   (f_util_adl_count_n = NULL) => -0.0199378305, -0.0060876341),
(f_bus_addr_match_count_d > 52.5) => 0.1569401775,
(f_bus_addr_match_count_d = NULL) => -0.0049952128, -0.0049952128);

// Tree: 76 
woFDN_FLAP___lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0111848362,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => 0.0020550825,
      (f_prevaddrlenofres_d > 123.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0449802121,
         (f_rel_homeover500_count_d > 3.5) => 
            map(
            (NULL < c_rich_wht and c_rich_wht <= 107.5) => 0.0351162569,
            (c_rich_wht > 107.5) => 0.3158893843,
            (c_rich_wht = NULL) => 0.1976691201, 0.1976691201),
         (f_rel_homeover500_count_d = NULL) => 0.0697229776, 0.0697229776),
      (f_prevaddrlenofres_d = NULL) => 0.0206894154, 0.0206894154),
   (f_nae_nothing_found_i > 0.5) => 0.2074249573,
   (f_nae_nothing_found_i = NULL) => 0.0236079873, 0.0236079873),
(c_rnt1250_p = NULL) => -0.0001501404, -0.0012927178);

// Tree: 77 
woFDN_FLAP___lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 64.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.75) => 0.2029211702,
      (r_C12_source_profile_d > 57.75) => -0.0242403213,
      (r_C12_source_profile_d = NULL) => 0.0779061212, 0.0779061212),
   (f_mos_liens_unrel_SC_fseen_d > 64.5) => -0.0016900904,
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 104.5) => -0.0532969372,
      (c_for_sale > 104.5) => 0.0901990655,
      (c_for_sale = NULL) => 0.0069955009, 0.0069955009), -0.0006311695),
(c_transport > 29.05) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.1934677958,
   (f_phone_ver_insurance_d > 2.5) => 0.0353095592,
   (f_phone_ver_insurance_d = NULL) => 0.0959624752, 0.0959624752),
(c_transport = NULL) => -0.0146220049, 0.0006294392);

// Tree: 78 
woFDN_FLAP___lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 23.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0054460744,
         (f_varrisktype_i > 2.5) => 
            map(
            (NULL < c_civ_emp and c_civ_emp <= 63.15) => 0.2550218596,
            (c_civ_emp > 63.15) => 0.0840982742,
            (c_civ_emp = NULL) => 0.1636661501, 0.1636661501),
         (f_varrisktype_i = NULL) => 0.0744443029, 0.0744443029),
      (r_C13_max_lres_d > 23.5) => 0.0032330627,
      (r_C13_max_lres_d = NULL) => 0.0048469495, 0.0048469495),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0603610194,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0211212046, 0.0023491595),
(r_L77_Add_PO_Box_i > 0.5) => -0.1073112159,
(r_L77_Add_PO_Box_i = NULL) => -0.0002097266, -0.0002097266);

// Tree: 79 
woFDN_FLAP___lgt_79 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 2.25) => -0.1295105601,
   (c_pop_35_44_p > 2.25) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30362.5) => 
         map(
         (NULL < c_med_hval and c_med_hval <= 64846) => -0.0566497686,
         (c_med_hval > 64846) => 0.0574574731,
         (c_med_hval = NULL) => 0.0370148077, 0.0370148077),
      (f_curraddrmedianincome_d > 30362.5) => -0.0060431530,
      (f_curraddrmedianincome_d = NULL) => -0.0112026600, -0.0028168839),
   (c_pop_35_44_p = NULL) => -0.0144458520, -0.0040157613),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 108) => -0.0208205739,
   (r_C13_max_lres_d > 108) => 0.1362607928,
   (r_C13_max_lres_d = NULL) => 0.0561172383, 0.0561172383),
(k_nap_contradictory_i = NULL) => -0.0030202603, -0.0030202603);

// Tree: 80 
woFDN_FLAP___lgt_80 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0085237846,
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 44.85) => 0.0029735111,
         (c_fammar18_p > 44.85) => 
            map(
            (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 8.5) => 0.0443585293,
            (f_srchaddrsrchcount_i > 8.5) => 0.1596483723,
            (f_srchaddrsrchcount_i = NULL) => 0.0555423345, 0.0555423345),
         (c_fammar18_p = NULL) => 0.0145705963, 0.0145705963),
      (f_adls_per_phone_c6_i > 1.5) => 0.1691140048,
      (f_adls_per_phone_c6_i = NULL) => 0.0167444291, 0.0167444291),
   (f_hh_lienholders_i = NULL) => 0.0079799234, -0.0004211495),
(c_bel_edu > 196.5) => -0.0858168430,
(c_bel_edu = NULL) => 0.0202974151, -0.0008718068);

// Tree: 81 
woFDN_FLAP___lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 142.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 16.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0173034829,
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0085623993,
         (r_D30_Derog_Count_i > 1.5) => 0.1091003521,
         (r_D30_Derog_Count_i = NULL) => 0.0384592116, 0.0384592116),
      (k_inq_per_phone_i = NULL) => -0.0148600069, -0.0148600069),
   (f_srchphonesrchcount_i > 16.5) => -0.1006259833,
   (f_srchphonesrchcount_i = NULL) => -0.0316205646, -0.0157063488),
(c_easiqlife > 142.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 0.0160104545,
   (k_comb_age_d > 81.5) => 0.2360529309,
   (k_comb_age_d = NULL) => 0.0191236757, 0.0191236757),
(c_easiqlife = NULL) => 0.0102474485, -0.0053255379);

// Tree: 82 
woFDN_FLAP___lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0027961128,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0343561191,
      (f_mos_inq_banko_cm_fseen_d > 46.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 37.4) => 
            map(
            (NULL < c_retail and c_retail <= 9.75) => 0.1142955559,
            (c_retail > 9.75) => -0.0392786028,
            (c_retail = NULL) => 0.0425319303, 0.0425319303),
         (c_fammar18_p > 37.4) => 0.1492108078,
         (c_fammar18_p = NULL) => 0.0857961417, 0.0857961417),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0427628852, 0.0427628852),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0017630954, -0.0017630954),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0709699693,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0035666429, -0.0022978366);

// Tree: 83 
woFDN_FLAP___lgt_83 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0020638376,
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 84.5) => -0.0166200648,
   (c_very_rich > 84.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 280.5) => 0.0385233483,
         (f_M_Bureau_ADL_FS_noTU_d > 280.5) => 0.2091505761,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.1028827412, 0.1028827412),
      (f_phone_ver_experian_d > 0.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 0.1284830178,
         (f_mos_inq_banko_cm_lseen_d > 44.5) => 0.0021813963,
         (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0225180980, 0.0225180980),
      (f_phone_ver_experian_d = NULL) => 0.0257308606, 0.0451207338),
   (c_very_rich = NULL) => 0.0243920522, 0.0243920522),
(k_inq_per_phone_i = NULL) => 0.0005661094, 0.0005661094);

// Tree: 84 
woFDN_FLAP___lgt_84 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 35.75) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0052575985,
      (k_comb_age_d > 67.5) => 
         map(
         (NULL < c_hval_500k_p and c_hval_500k_p <= 23.45) => 0.0373291674,
         (c_hval_500k_p > 23.45) => 0.2323873322,
         (c_hval_500k_p = NULL) => 0.0521437116, 0.0521437116),
      (k_comb_age_d = NULL) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 9.85) => -0.0440250650,
         (C_INC_125K_P > 9.85) => 0.0801764553,
         (C_INC_125K_P = NULL) => 0.0048731713, 0.0048731713), -0.0011564955),
   (c_hval_60k_p > 35.75) => -0.1088230685,
   (c_hval_60k_p = NULL) => -0.0073360787, -0.0020513935),
(r_L70_Add_Standardized_i > 0.5) => 0.0446317036,
(r_L70_Add_Standardized_i = NULL) => 0.0017759949, 0.0017759949);

// Tree: 85 
woFDN_FLAP___lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0107426481,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 4.5) => 0.0110036057,
      (f_idverrisktype_i > 4.5) => 0.1210604667,
      (f_idverrisktype_i = NULL) => 0.0163888828, 0.0163888828),
   (f_inq_Collection_count_i > 8.5) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 11.95) => 0.1940583066,
      (C_INC_50K_P > 11.95) => 0.0317969762,
      (C_INC_50K_P = NULL) => 0.0979496725, 0.0979496725),
   (f_inq_Collection_count_i = NULL) => 0.0231899089, 0.0231899089),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 37.25) => 0.0692127785,
   (c_med_age > 37.25) => -0.0504476198,
   (c_med_age = NULL) => 0.0072304139, 0.0072304139), -0.0062700654);

// Tree: 86 
woFDN_FLAP___lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 44.5) => -0.0037599145,
   (f_rel_under500miles_cnt_d > 44.5) => -0.1256764043,
   (f_rel_under500miles_cnt_d = NULL) => 0.0202799064, -0.0040098797),
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 128.5) => 0.0105637401,
   (f_curraddrcrimeindex_i > 128.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0513303671,
      (r_C23_inp_addr_occ_index_d > 2) => 0.2010248674,
      (r_C23_inp_addr_occ_index_d = NULL) => 0.1152350368, 0.1152350368),
   (f_curraddrcrimeindex_i = NULL) => 0.0387952728, 0.0387952728),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.25) => -0.0471149383,
   (c_pop_55_64_p > 11.25) => 0.0679856530,
   (c_pop_55_64_p = NULL) => -0.0010747018, -0.0010747018), -0.0018350631);

// Tree: 87 
woFDN_FLAP___lgt_87 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 112) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => -0.0068848638,
   (f_hh_collections_ct_i > 4.5) => 0.0751967256,
   (f_hh_collections_ct_i = NULL) => -0.0056770363, -0.0056770363),
(f_addrchangecrimediff_i > 112) => 0.1165760274,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 402.5) => -0.0132485288,
   (f_M_Bureau_ADL_FS_all_d > 402.5) => 
      map(
      (NULL < c_hval_1001k_p and c_hval_1001k_p <= 1.15) => 0.0138037295,
      (c_hval_1001k_p > 1.15) => 0.3348204402,
      (c_hval_1001k_p = NULL) => 0.1076682648, 0.1076682648),
   (f_M_Bureau_ADL_FS_all_d = NULL) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 13.4) => 0.0938600314,
      (c_hh3_p > 13.4) => -0.0337145857,
      (c_hh3_p = NULL) => 0.0196157870, 0.0196157870), -0.0043381780), -0.0048872766);

// Tree: 88 
woFDN_FLAP___lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 107) => -0.0102018638,
   (c_rich_fam > 107) => 0.1398234958,
   (c_rich_fam = NULL) => 0.0651803365, 0.0651803365),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0148782894,
   (f_crim_rel_under100miles_cnt_i > 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 31.25) => 0.0085690711,
      (c_famotf18_p > 31.25) => 0.0533562186,
      (c_famotf18_p = NULL) => 0.0117793937, 0.0117793937),
   (f_crim_rel_under100miles_cnt_i = NULL) => -0.0332868805, -0.0027758620),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_apt20 and c_apt20 <= 110.5) => -0.0522141963,
   (c_apt20 > 110.5) => 0.0475397890,
   (c_apt20 = NULL) => -0.0009891768, -0.0009891768), -0.0016483274);

// Tree: 89 
woFDN_FLAP___lgt_89 := map(
(NULL < c_newhouse and c_newhouse <= 8.95) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 17258) => 0.0073828171,
      (f_addrchangeincomediff_d > 17258) => 0.0905421046,
      (f_addrchangeincomediff_d = NULL) => 0.0103346481, 0.0098897329),
   (r_D33_eviction_count_i > 2.5) => 0.0824199634,
   (r_D33_eviction_count_i = NULL) => 0.0159321479, 0.0108927611),
(c_newhouse > 8.95) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 29.5) => -0.0131844666,
   (f_rel_under500miles_cnt_d > 29.5) => -0.0804553739,
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 0.65) => 0.0915705294,
      (c_bigapt_p > 0.65) => -0.0336060602,
      (c_bigapt_p = NULL) => 0.0062853804, 0.0062853804), -0.0141461276),
(c_newhouse = NULL) => 0.0040594028, -0.0031205824);

// Tree: 90 
woFDN_FLAP___lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 48.95) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.65) => 0.1346367073,
      (c_pop_25_34_p > 0.65) => 
         map(
         (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => -0.0033229676,
         (f_srchphonesrchcountwk_i > 0.5) => 0.0716075114,
         (f_srchphonesrchcountwk_i = NULL) => -0.0026096394, -0.0026096394),
      (c_pop_25_34_p = NULL) => -0.0016730738, -0.0016730738),
   (c_hval_80k_p > 48.95) => -0.1153064930,
   (c_hval_80k_p = NULL) => -0.0012950517, -0.0022205910),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0744136984,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 118) => -0.0567196546,
   (c_for_sale > 118) => 0.0415627791,
   (c_for_sale = NULL) => -0.0161586502, -0.0161586502), -0.0027008203);

// Tree: 91 
woFDN_FLAP___lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_med_age and c_med_age <= 34.35) => -0.1232312861,
      (c_med_age > 34.35) => 0.1231995994,
      (c_med_age = NULL) => 0.0187797326, 0.0187797326),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','6: Other']) => 0.1462835036,
   (nf_seg_FraudPoint_3_0 = '') => 0.0746385275, 0.0746385275),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 15.8) => 0.0970509802,
      (c_fammar_p > 15.8) => -0.0103643368,
      (c_fammar_p = NULL) => -0.0098471622, -0.0098471622),
   (c_food > 65.55) => 0.0605670601,
   (c_food = NULL) => -0.0100892812, -0.0073617521),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0048846940, -0.0058613554);

// Tree: 92 
woFDN_FLAP___lgt_92 := map(
(NULL < c_hh3_p and c_hh3_p <= 21.55) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 7.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 170.5) => -0.0255519320,
         (c_cartheft > 170.5) => -0.1514581955,
         (c_cartheft = NULL) => -0.0461978516, -0.0461978516),
      (f_mos_inq_banko_cm_lseen_d > 7.5) => -0.0026982928,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0043856583, -0.0043856583),
   (f_assocsuspicousidcount_i > 15.5) => 0.1066627706,
   (f_assocsuspicousidcount_i = NULL) => -0.0060940567, -0.0038009942),
(c_hh3_p > 21.55) => 
   map(
   (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 0.0220490664,
   (f_acc_damage_amt_total_i > 275) => 0.1765480806,
   (f_acc_damage_amt_total_i = NULL) => 0.0266105787, 0.0266105787),
(c_hh3_p = NULL) => -0.0497512074, 0.0014211309);

// Tree: 93 
woFDN_FLAP___lgt_93 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 222.35) => 
      map(
      (NULL < c_unempl and c_unempl <= 183.5) => -0.0092484162,
      (c_unempl > 183.5) => 0.0649606876,
      (c_unempl = NULL) => -0.0076748491, -0.0076748491),
   (c_housingcpi > 222.35) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 7.8) => 0.0190342736,
      (c_hval_20k_p > 7.8) => 0.1538223137,
      (c_hval_20k_p = NULL) => 0.0230537976, 0.0230537976),
   (c_housingcpi = NULL) => -0.0072039541, -0.0001960871),
(r_D33_eviction_count_i > 2.5) => 
   map(
   (NULL < c_food and c_food <= 16.8) => 0.1408759396,
   (c_food > 16.8) => -0.0058834575,
   (c_food = NULL) => 0.0635751885, 0.0635751885),
(r_D33_eviction_count_i = NULL) => 0.0054635190, 0.0005240598);

// Tree: 94 
woFDN_FLAP___lgt_94 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 164.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 147.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 154.5) => -0.0198288797,
      (c_for_sale > 154.5) => 0.1405130686,
      (c_for_sale = NULL) => 0.0205330590, 0.0205330590),
   (c_span_lang > 147.5) => 0.1424110498,
   (c_span_lang = NULL) => 0.0479067254, 0.0479067254),
(f_mos_liens_unrel_SC_fseen_d > 164.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0255156712,
   (f_hh_members_ct_d > 1.5) => -0.0073494057,
   (f_hh_members_ct_d = NULL) => -0.0007704340, -0.0007704340),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => -0.0410932295,
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.0629443749,
   (r_L79_adls_per_addr_c6_i = NULL) => -0.0041568019, -0.0041568019), 0.0006311421);

// Tree: 95 
woFDN_FLAP___lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0096622764,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 29862) => 0.1540648570,
      (f_curraddrmedianincome_d > 29862) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 30.65) => 0.0016750620,
         (C_INC_75K_P > 30.65) => 0.1846110379,
         (C_INC_75K_P = NULL) => 0.0086271743, 0.0086271743),
      (f_curraddrmedianincome_d = NULL) => 0.0139518849, 0.0139518849),
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 32.55) => 0.2522313906,
      (c_fammar18_p > 32.55) => 0.0460726902,
      (c_fammar18_p = NULL) => 0.1196070037, 0.1196070037),
   (f_hh_collections_ct_i = NULL) => 0.0246537260, 0.0246537260),
(c_rnt1000_p = NULL) => -0.0159364607, -0.0055712529);

// Tree: 96 
woFDN_FLAP___lgt_96 := map(
(NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0134212603,
(k_inf_nothing_found_i > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 0.0047044616,
      (k_inq_per_addr_i > 6.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2282203897) => 0.1987838942,
         (f_add_curr_mobility_index_i > 0.2282203897) => 0.0224610965,
         (f_add_curr_mobility_index_i = NULL) => 0.0919530227, 0.0919530227),
      (k_inq_per_addr_i = NULL) => 0.0076553129, 0.0076553129),
   (f_srchfraudsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 8.85) => 0.0626784829,
      (c_hval_150k_p > 8.85) => 0.2290486399,
      (c_hval_150k_p = NULL) => 0.1114421496, 0.1114421496),
   (f_srchfraudsrchcountmo_i = NULL) => -0.0060472645, 0.0109351017),
(k_inf_nothing_found_i = NULL) => -0.0032236538, -0.0032236538);

// Tree: 97 
woFDN_FLAP___lgt_97 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0006514444,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1454133979,
      (r_A50_pb_average_dollars_d > 99) => -0.0063241834,
      (r_A50_pb_average_dollars_d = NULL) => 0.0622024662, 0.0622024662),
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_incollege and c_incollege <= 7.05) => -0.0511584430,
      (c_incollege > 7.05) => 0.0546054019,
      (c_incollege = NULL) => -0.0099832057, -0.0099832057), 0.0011338288),
(k_inq_adls_per_addr_i > 3.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 48) => -0.1129135302,
   (f_curraddrmurderindex_i > 48) => -0.0293773759,
   (f_curraddrmurderindex_i = NULL) => -0.0592813689, -0.0592813689),
(k_inq_adls_per_addr_i = NULL) => -0.0000949549, -0.0000949549);

// Tree: 98 
woFDN_FLAP___lgt_98 := map(
(NULL < c_hh4_p and c_hh4_p <= 10.15) => -0.0194692872,
(c_hh4_p > 10.15) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0036319502,
      (f_phones_per_addr_curr_i > 9.5) => 
         map(
         (NULL < f_adl_util_misc_n and f_adl_util_misc_n <= 0.5) => 
            map(
            (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.25) => -0.0378888923,
            (c_pop_35_44_p > 12.25) => 0.1319373407,
            (c_pop_35_44_p = NULL) => 0.0894807824, 0.0894807824),
         (f_adl_util_misc_n > 0.5) => -0.0073179584,
         (f_adl_util_misc_n = NULL) => 0.0467850415, 0.0467850415),
      (f_phones_per_addr_curr_i = NULL) => 0.0000657524, 0.0000657524),
   (f_rel_homeover500_count_d > 14.5) => 0.1191169741,
   (f_rel_homeover500_count_d = NULL) => 0.0547478137, 0.0025767719),
(c_hh4_p = NULL) => -0.0154960189, -0.0048210724);

// Tree: 99 
woFDN_FLAP___lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38111460565) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0117547845,
      (f_util_add_curr_conv_n > 0.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 7.5) => 0.0206805209,
         (k_inq_per_phone_i > 7.5) => 0.1132105463,
         (k_inq_per_phone_i = NULL) => 0.0216208997, 0.0216208997),
      (f_util_add_curr_conv_n = NULL) => 0.0067955690, 0.0067955690),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 76500) => 0.0212004968,
      (k_estimated_income_d > 76500) => 0.2473258853,
      (k_estimated_income_d = NULL) => 0.1050323482, 0.1050323482),
   (r_P85_Phn_Disconnected_i = NULL) => 0.0087919848, 0.0087919848),
(f_add_input_mobility_index_i > 0.38111460565) => -0.0264792289,
(f_add_input_mobility_index_i = NULL) => 0.0224730785, 0.0029762483);

// Tree: 100 
woFDN_FLAP___lgt_100 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.85) => -0.0752461816,
(C_OWNOCC_P > 1.85) => 
   map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1080939823,
   (f_attr_arrest_recency_d > 79.5) => 
      map(
      (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
         map(
         (NULL < c_transport and c_transport <= 26.6) => 0.0077240912,
         (c_transport > 26.6) => 0.1549158145,
         (c_transport = NULL) => 0.0104573626, 0.0104573626),
      (f_historical_count_d > 0.5) => -0.0184775878,
      (f_historical_count_d = NULL) => -0.0045073345, -0.0045073345),
   (f_attr_arrest_recency_d = NULL) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.15) => -0.0545363757,
      (c_pop_35_44_p > 15.15) => 0.0833286390,
      (c_pop_35_44_p = NULL) => 0.0149753964, 0.0149753964), -0.0035641032),
(C_OWNOCC_P = NULL) => 0.0175933982, -0.0041289925);

// Tree: 101 
woFDN_FLAP___lgt_101 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 115.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 0.0041950092,
      (f_nae_nothing_found_i > 0.5) => 0.1451859608,
      (f_nae_nothing_found_i = NULL) => 0.0061480110, 0.0061480110),
   (c_no_teens > 115.5) => -0.0177508783,
   (c_no_teens = NULL) => 0.0006726115, -0.0036602333),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 44839) => 0.1421229412,
   (f_curraddrmedianincome_d > 44839) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 97.5) => 0.0325569120,
      (c_many_cars > 97.5) => -0.0917890321,
      (c_many_cars = NULL) => -0.0234462231, -0.0234462231),
   (f_curraddrmedianincome_d = NULL) => 0.0349899525, 0.0349899525),
(k_nap_contradictory_i = NULL) => -0.0030081923, -0.0030081923);

// Tree: 102 
woFDN_FLAP___lgt_102 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0115987582,
   (c_hh7p_p > 0.85) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.1230380027,
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 0.0138921659,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0155592858, 0.0155592858),
   (c_hh7p_p = NULL) => 0.0062370287, -0.0016141254),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_health and c_health <= 7.65) => -0.0191057559,
   (c_health > 7.65) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 100.5) => 0.2633682999,
      (c_old_homes > 100.5) => 0.0286989696,
      (c_old_homes = NULL) => 0.1599546967, 0.1599546967),
   (c_health = NULL) => 0.0650740585, 0.0650740585),
(r_P85_Phn_Disconnected_i = NULL) => -0.0002367266, -0.0002367266);

// Tree: 103 
woFDN_FLAP___lgt_103 := map(
(NULL < f_accident_count_i and f_accident_count_i <= 2.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 124.5) => 0.0047874915,
   (c_bel_edu > 124.5) => -0.0192581071,
   (c_bel_edu = NULL) => 0.0468775131, -0.0007897367),
(f_accident_count_i > 2.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.75) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 77.55) => 0.2662396125,
      (c_fammar_p > 77.55) => 0.0087545222,
      (c_fammar_p = NULL) => 0.1603384866, 0.1603384866),
   (c_retired > 15.75) => -0.0890298247,
   (c_retired = NULL) => 0.0818081344, 0.0818081344),
(f_accident_count_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.85) => -0.0569442362,
   (c_pop_35_44_p > 13.85) => 0.0474616551,
   (c_pop_35_44_p = NULL) => 0.0080194295, 0.0080194295), 0.0005064619);

// Tree: 104 
woFDN_FLAP___lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 773816) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0048022860,
   (k_inq_per_phone_i > 1.5) => 0.0274006302,
   (k_inq_per_phone_i = NULL) => -0.0015791049, -0.0015791049),
(f_prevaddrmedianvalue_d > 773816) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0091843455,
   (f_bus_addr_match_count_d > 0.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1065.5) => 0.0445215860,
      (c_popover18 > 1065.5) => 0.4415519997,
      (c_popover18 = NULL) => 0.2486026398, 0.2486026398),
   (f_bus_addr_match_count_d = NULL) => 0.1069620459, 0.1069620459),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.55) => -0.0571579795,
   (c_pop_35_44_p > 16.55) => 0.0530622478,
   (c_pop_35_44_p = NULL) => -0.0166358371, -0.0166358371), 0.0004680751);

// Tree: 105 
woFDN_FLAP___lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < c_assault and c_assault <= 152.5) => 0.0193892617,
      (c_assault > 152.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1185320130,
         (f_phone_ver_experian_d > 0.5) => 0.0162405899,
         (f_phone_ver_experian_d = NULL) => 0.0824785466, 0.0767027309),
      (c_assault = NULL) => 0.0120088233, 0.0290193706),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0830965573,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0188860076, 0.0188860076),
(f_corraddrnamecount_d > 3.5) => -0.0065102301,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 61.15) => 0.0752674028,
   (c_civ_emp > 61.15) => -0.0477365327,
   (c_civ_emp = NULL) => 0.0045401399, 0.0045401399), -0.0018933676);

// Tree: 106 
woFDN_FLAP___lgt_106 := map(
(NULL < c_hh3_p and c_hh3_p <= 34.65) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => -0.0131560635,
      (k_comb_age_d > 55.5) => 0.0235123309,
      (k_comb_age_d = NULL) => -0.0126081232, -0.0049378291),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_retail and c_retail <= 14.65) => -0.0040189806,
      (c_retail > 14.65) => 0.1459516977,
      (c_retail = NULL) => 0.0556780855, 0.0556780855),
   (k_nap_contradictory_i = NULL) => -0.0039157387, -0.0039157387),
(c_hh3_p > 34.65) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1789593439,
   (r_Phn_Cell_n > 0.5) => -0.0166466492,
   (r_Phn_Cell_n = NULL) => 0.0800574373, 0.0800574373),
(c_hh3_p = NULL) => -0.0330140127, -0.0034026346);

// Tree: 107 
woFDN_FLAP___lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0855456767,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.19658503275) => -0.0280921734,
      (f_add_input_mobility_index_i > 0.19658503275) => 
         map(
         (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 5.5) => 
            map(
            (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => 0.0033380197,
            (f_phones_per_addr_curr_i > 13.5) => 0.0434156192,
            (f_phones_per_addr_curr_i = NULL) => 0.0059419694, 0.0059419694),
         (f_rel_incomeover100_count_d > 5.5) => -0.0494800589,
         (f_rel_incomeover100_count_d = NULL) => -0.0383990972, 0.0023279706),
      (f_add_input_mobility_index_i = NULL) => 0.1346465299, -0.0032533011),
   (r_D32_criminal_count_i > 10.5) => 0.0879553539,
   (r_D32_criminal_count_i = NULL) => -0.0026596093, -0.0026596093),
(f_attr_arrest_recency_d = NULL) => -0.0095777411, -0.0021161455);

// Tree: 108 
woFDN_FLAP___lgt_108 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1355161415) => 0.0013551622,
      (f_add_curr_nhood_BUS_pct_i > 0.1355161415) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 744.5) => 0.0197480020,
         (c_hh00 > 744.5) => 0.1467608269,
         (c_hh00 = NULL) => 0.0584332462, 0.0584332462),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 
         map(
         (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 9.5) => 0.0002054740,
         (f_rel_educationover12_count_d > 9.5) => 0.1996682510,
         (f_rel_educationover12_count_d = NULL) => 0.0307590207, 0.0307590207), 0.0097655438),
   (f_srchcomponentrisktype_i > 1.5) => 0.0669634673,
   (f_srchcomponentrisktype_i = NULL) => 0.0139732548, 0.0139732548),
(f_corrphonelastnamecount_d > 0.5) => -0.0126839342,
(f_corrphonelastnamecount_d = NULL) => -0.0203325620, -0.0011793628);

// Tree: 109 
woFDN_FLAP___lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 4.95) => -0.1509262982,
      (C_INC_125K_P > 4.95) => -0.0561917843,
      (C_INC_125K_P = NULL) => -0.0843414684, -0.0843414684),
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 20.5) => 
         map(
         (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 3.5) => 0.1406986709,
         (f_rel_ageover40_count_d > 3.5) => -0.0143509390,
         (f_rel_ageover40_count_d = NULL) => 0.0660993303, 0.0660993303),
      (f_prevaddrlenofres_d > 20.5) => -0.0431523199,
      (f_prevaddrlenofres_d = NULL) => -0.0082570167, -0.0082570167),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0346566900, -0.0346566900),
(r_D33_Eviction_Recency_d > 549) => 0.0092659276,
(r_D33_Eviction_Recency_d = NULL) => 0.0115028229, 0.0075185526);

// Tree: 110 
woFDN_FLAP___lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 101.5) => -0.0092797086,
(f_prevaddrageoldest_d > 101.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 12.5) => 0.0038093170,
   (r_P88_Phn_Dst_to_Inp_Add_i > 12.5) => 0.0568819937,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 10.65) => 
         map(
         (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 0.0414857087,
         (f_bus_name_nover_i > 0.5) => 
            map(
            (NULL < c_bargains and c_bargains <= 46.5) => -0.0227157208,
            (c_bargains > 46.5) => 0.2261564618,
            (c_bargains = NULL) => 0.1438228074, 0.1438228074),
         (f_bus_name_nover_i = NULL) => 0.0800433124, 0.0800433124),
      (c_pop_18_24_p > 10.65) => -0.0253345456,
      (c_pop_18_24_p = NULL) => 0.0555315063, 0.0555315063), 0.0180790329),
(f_prevaddrageoldest_d = NULL) => -0.0149715273, 0.0006710506);

// Tree: 111 
woFDN_FLAP___lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.75) => 0.1755265473,
   (r_C12_source_profile_d > 57.75) => -0.0082627901,
   (r_C12_source_profile_d = NULL) => 0.0801244485, 0.0801244485),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 19.5) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 92.5) => 0.2114025200,
         (c_rest_indx > 92.5) => 0.0256964434,
         (c_rest_indx = NULL) => 0.1065684445, 0.1065684445),
      (f_addrchangeecontrajindex_d > 2.5) => -0.0540896770,
      (f_addrchangeecontrajindex_d = NULL) => 0.1032034049, 0.0412156710),
   (k_comb_age_d > 19.5) => 0.0015097585,
   (k_comb_age_d = NULL) => 0.0026342361, 0.0026342361),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0340677053, 0.0030033830);

// Tree: 112 
woFDN_FLAP___lgt_112 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0072220794) => 0.0946371980,
   (f_add_input_nhood_MFD_pct_i > 0.0072220794) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 820864.5) => 0.0045353863,
      (f_prevaddrmedianvalue_d > 820864.5) => 0.1916017683,
      (f_prevaddrmedianvalue_d = NULL) => 0.0070065925, 0.0070065925),
   (f_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1869015788) => 0.0274050009,
      (f_add_curr_nhood_MFD_pct_i > 0.1869015788) => 0.1146998692,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0095518568, 0.0046647837), 0.0125176428),
(f_phone_ver_insurance_d > 3.5) => -0.0158114753,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => 0.0021506079,
   (c_assault > 90) => 0.0920138333,
   (c_assault = NULL) => 0.0383857794, 0.0383857794), -0.0008000381);

// Tree: 113 
woFDN_FLAP___lgt_113 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30022.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24466.5) => -0.0105606163,
      (f_prevaddrmedianincome_d > 24466.5) => 
         map(
         (NULL < c_young and c_young <= 34.65) => 0.0918776352,
         (c_young > 34.65) => -0.0358313142,
         (c_young = NULL) => 0.0695489916, 0.0695489916),
      (f_prevaddrmedianincome_d = NULL) => 0.0242696480, 0.0242696480),
   (f_curraddrmedianincome_d > 30022.5) => -0.0038739585,
   (f_curraddrmedianincome_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => 0.0691172571,
      (f_phones_per_addr_c6_i > 0.5) => -0.0481977894,
      (f_phones_per_addr_c6_i = NULL) => 0.0257616965, 0.0257616965), -0.0010395964),
(r_L77_Add_PO_Box_i > 0.5) => -0.1027706251,
(r_L77_Add_PO_Box_i = NULL) => -0.0032851374, -0.0032851374);

// Tree: 114 
woFDN_FLAP___lgt_114 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 29.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00532387285) => 0.0461060098,
   (f_add_input_nhood_MFD_pct_i > 0.00532387285) => -0.0098328021,
   (f_add_input_nhood_MFD_pct_i = NULL) => 0.0002401773, -0.0045083727),
(f_rel_under500miles_cnt_d > 29.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 39.5) => -0.1091309673,
   (f_mos_inq_banko_cm_lseen_d > 39.5) => -0.0152294433,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0530756849, -0.0530756849),
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 7.5) => -0.0548298007,
   (r_P88_Phn_Dst_to_Inp_Add_i > 7.5) => 0.0011137352,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 110) => 0.1717837610,
      (c_asian_lang > 110) => 0.0070676892,
      (c_asian_lang = NULL) => 0.0661382805, 0.0661382805), 0.0105332553), -0.0050872593);

// Tree: 115 
woFDN_FLAP___lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 64.35) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0071438811,
      (f_corrrisktype_i > 7.5) => 
         map(
         (NULL < c_unempl and c_unempl <= 64.5) => -0.0275020876,
         (c_unempl > 64.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13083113685) => 0.0229637992,
            (f_add_curr_nhood_BUS_pct_i > 0.13083113685) => 0.1025364985,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0400608651, 0.0333278775),
         (c_unempl = NULL) => 0.0182860184, 0.0182860184),
      (f_corrrisktype_i = NULL) => 0.0012118583, -0.0013743838),
   (C_RENTOCC_P > 64.35) => -0.0332317687,
   (C_RENTOCC_P = NULL) => -0.0045137946, -0.0045137946),
(c_pop_0_5_p > 21.15) => 0.1468157965,
(c_pop_0_5_p = NULL) => 0.0085223510, -0.0035495736);

// Tree: 116 
woFDN_FLAP___lgt_116 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 11.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 61) => 0.1252440029,
      (f_mos_inq_banko_cm_lseen_d > 61) => 0.0108527214,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0469003942, 0.0469003942),
   (r_D32_Mos_Since_Crim_LS_d > 11.5) => -0.0042154116,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 9.6) => -0.0562946889,
      (C_INC_125K_P > 9.6) => 0.0716505019,
      (C_INC_125K_P = NULL) => -0.0045073498, -0.0045073498), -0.0032462360),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 110.5) => 0.0351422781,
   (c_cartheft > 110.5) => 0.2368657404,
   (c_cartheft = NULL) => 0.0921263070, 0.0921263070),
(f_adls_per_phone_c6_i = NULL) => -0.0019079378, -0.0019079378);

// Tree: 117 
woFDN_FLAP___lgt_117 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1481160293,
   (r_Phn_Cell_n > 0.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 1.15) => -0.0856817020,
      (c_low_hval > 1.15) => 0.0744338289,
      (c_low_hval = NULL) => -0.0049623021, -0.0049623021),
   (r_Phn_Cell_n = NULL) => 0.0466095422, 0.0466095422),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.75) => -0.0060453099,
   (c_hh3_p > 23.75) => 0.0287152187,
   (c_hh3_p = NULL) => -0.0000402290, -0.0011739662),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 1.2) => -0.0921692923,
   (c_hval_125k_p > 1.2) => 0.0258728858,
   (c_hval_125k_p = NULL) => -0.0261772085, -0.0261772085), -0.0007494447);

// Tree: 118 
woFDN_FLAP___lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => -0.0055182510,
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 0.1) => -0.0455584173,
   (c_hval_250k_p > 0.1) => 
      map(
      (NULL < c_work_home and c_work_home <= 81.5) => 0.1578350675,
      (c_work_home > 81.5) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 15.3) => -0.0150464797,
         (c_pop_25_34_p > 15.3) => 0.1433692227,
         (c_pop_25_34_p = NULL) => 0.0501174263, 0.0501174263),
      (c_work_home = NULL) => 0.0818941304, 0.0818941304),
   (c_hval_250k_p = NULL) => 0.0420378354, 0.0420378354),
(f_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0325771747,
   (k_nap_lname_verd_d > 0.5) => -0.0618076553,
   (k_nap_lname_verd_d = NULL) => -0.0118714952, -0.0118714952), -0.0044721982);

// Tree: 119 
woFDN_FLAP___lgt_119 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0709779926,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 5.35) => 0.0939950897,
      (c_hh3_p > 5.35) => -0.0561238070,
      (c_hh3_p = NULL) => -0.0467530893, -0.0467530893),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 12.5) => 0.0088074878,
      (f_inq_HighRiskCredit_count_i > 12.5) => -0.0662657772,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0083370548, 0.0083370548),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0046924370, 0.0046924370),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0267188781,
   (r_Phn_Cell_n > 0.5) => -0.0852718428,
   (r_Phn_Cell_n = NULL) => -0.0203600237, -0.0203600237), 0.0055528807);

// Tree: 120 
woFDN_FLAP___lgt_120 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0066617943,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < c_amus_indx and c_amus_indx <= 142.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 464.5) => -0.0054726513,
      (r_pb_order_freq_d > 464.5) => 0.0937729493,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 75.45) => 0.0266049638,
         (c_low_ed > 75.45) => 0.1884342046,
         (c_low_ed = NULL) => 0.0382139481, 0.0382139481), 0.0151619122),
   (c_amus_indx > 142.5) => 0.1767082475,
   (c_amus_indx = NULL) => 0.0213067287, 0.0213067287),
(f_rel_felony_count_i = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 2.8) => -0.0551115407,
   (c_hval_200k_p > 2.8) => 0.0622804832,
   (c_hval_200k_p = NULL) => 0.0026377614, 0.0026377614), -0.0025154743);

// Tree: 121 
woFDN_FLAP___lgt_121 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 130010.5) => 
      map(
      (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 0.5) => 
         map(
         (NULL < c_high_ed and c_high_ed <= 2.65) => 0.1577699408,
         (c_high_ed > 2.65) => 0.0208754960,
         (c_high_ed = NULL) => 0.0254066934, 0.0254066934),
      (f_rel_ageover50_count_d > 0.5) => -0.0170845436,
      (f_rel_ageover50_count_d = NULL) => 0.0164230751, 0.0164230751),
   (r_L80_Inp_AVM_AutoVal_d > 130010.5) => -0.0038186307,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0086293292, -0.0026039038),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0818367805,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32304782865) => 0.0467196600,
   (f_add_input_mobility_index_i > 0.32304782865) => -0.0653294898,
   (f_add_input_mobility_index_i = NULL) => -0.0002686932, -0.0002686932), -0.0021556270);

// Tree: 122 
woFDN_FLAP___lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0049109649,
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 1.85) => 0.1440897851,
      (C_INC_150K_P > 1.85) => 0.0222653782,
      (C_INC_150K_P = NULL) => 0.0379899959, 0.0379899959),
   (k_comb_age_d = NULL) => -0.0017925571, -0.0022713228),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 115.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 17.05) => 0.0918394958,
      (C_INC_75K_P > 17.05) => -0.1057056144,
      (C_INC_75K_P = NULL) => 0.0021844073, 0.0021844073),
   (c_exp_prod > 115.5) => 0.1934143746,
   (c_exp_prod = NULL) => 0.0834148359, 0.0834148359),
(r_P85_Phn_Disconnected_i = NULL) => -0.0006636519, -0.0006636519);

// Tree: 123 
woFDN_FLAP___lgt_123 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0021562774,
   (c_easiqlife > 132.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 9.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 25.85) => 0.0097175460,
         (C_INC_75K_P > 25.85) => 
            map(
            (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 100725.5) => 0.2002058153,
            (r_L80_Inp_AVM_AutoVal_d > 100725.5) => 0.0814230395,
            (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0160249161, 0.0749879852),
         (C_INC_75K_P = NULL) => 0.0159023536, 0.0159023536),
      (r_C14_addrs_10yr_i > 9.5) => 0.1407966172,
      (r_C14_addrs_10yr_i = NULL) => 0.0546821712, 0.0178444641),
   (c_easiqlife = NULL) => -0.0027599486, 0.0048577614),
(r_L77_Add_PO_Box_i > 0.5) => -0.0934427424,
(r_L77_Add_PO_Box_i = NULL) => 0.0027034422, 0.0027034422);

// Tree: 124 
woFDN_FLAP___lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 3.5) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 173) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 3.485) => 0.0175290914,
         (c_hhsize > 3.485) => 0.1381057150,
         (c_hhsize = NULL) => 0.0294295775, 0.0294295775),
      (f_curraddrmurderindex_i > 173) => 0.1819028683,
      (f_curraddrmurderindex_i = NULL) => 0.0426543017, 0.0426543017),
   (f_prevaddrageoldest_d > 3.5) => 0.0041879426,
   (f_prevaddrageoldest_d = NULL) => 0.0100491756, 0.0068235659),
(c_high_ed > 42.55) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 51.5) => -0.0569151267,
   (f_prevaddrageoldest_d > 51.5) => -0.0022706761,
   (f_prevaddrageoldest_d = NULL) => -0.0265621752, -0.0265621752),
(c_high_ed = NULL) => -0.0366585540, -0.0036347176);

// Tree: 125 
woFDN_FLAP___lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 23.75) => -0.0057389572,
   (c_hval_150k_p > 23.75) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 9.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 4.5) => 0.1435019956,
         (f_prevaddrlenofres_d > 4.5) => 0.0069830036,
         (f_prevaddrlenofres_d = NULL) => 0.0204977962, 0.0204977962),
      (f_srchaddrsrchcount_i > 9.5) => 0.1435749408,
      (f_srchaddrsrchcount_i = NULL) => 0.0299527291, 0.0299527291),
   (c_hval_150k_p = NULL) => -0.0207777631, -0.0038803625),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.0200455603,
   (f_inq_count_i > 2.5) => 0.2019630439,
   (f_inq_count_i = NULL) => 0.0813438428, 0.0813438428),
(f_nae_nothing_found_i = NULL) => -0.0026374395, -0.0026374395);

// Tree: 126 
woFDN_FLAP___lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < c_child and c_child <= 2.75) => -0.1178541826,
   (c_child > 2.75) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 4.5) => 
         map(
         (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 8.5) => -0.0628390880,
         (f_rel_homeover300_count_d > 8.5) => 0.0726534151,
         (f_rel_homeover300_count_d = NULL) => -0.0434830162, -0.0434830162),
      (f_mos_inq_banko_cm_lseen_d > 4.5) => 0.0071001420,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 
         map(
         (NULL < c_totsales and c_totsales <= 9398) => -0.0698983783,
         (c_totsales > 9398) => 0.0534869871,
         (c_totsales = NULL) => -0.0070416827, -0.0070416827), 0.0055283045),
   (c_child = NULL) => -0.0019179238, 0.0044492748),
(r_L72_Add_Vacant_i > 0.5) => 0.1069908026,
(r_L72_Add_Vacant_i = NULL) => 0.0051527771, 0.0051527771);

// Tree: 127 
woFDN_FLAP___lgt_127 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0037596041,
   (f_prevaddroccupantowned_i > 0.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1953.5) => 
         map(
         (NULL < c_professional and c_professional <= 4.75) => 0.1746449814,
         (c_professional > 4.75) => -0.0037919322,
         (c_professional = NULL) => 0.1018746200, 0.1018746200),
      (c_med_yearblt > 1953.5) => 0.0133609275,
      (c_med_yearblt = NULL) => 0.0314064297, 0.0314064297),
   (f_prevaddroccupantowned_i = NULL) => -0.0042914239, -0.0012947341),
(k_inq_adls_per_phone_i > 2.5) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 113.5) => -0.0336599991,
   (c_for_sale > 113.5) => -0.1365826650,
   (c_for_sale = NULL) => -0.0846118139, -0.0846118139),
(k_inq_adls_per_phone_i = NULL) => -0.0019843907, -0.0019843907);

// Tree: 128 
woFDN_FLAP___lgt_128 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 54.5) => -0.0111273498,
(r_C13_Curr_Addr_LRes_d > 54.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 1076) => 0.0007490853,
   (r_P88_Phn_Dst_to_Inp_Add_i > 1076) => 0.1684611769,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_business and c_business <= 3.5) => 0.1157099050,
      (c_business > 3.5) => 
         map(
         (NULL < c_families and c_families <= 871.5) => 0.0127517441,
         (c_families > 871.5) => 
            map(
            (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 55) => 0.2968294472,
            (f_curraddrmurderindex_i > 55) => 0.0218410189,
            (f_curraddrmurderindex_i = NULL) => 0.1633791805, 0.1633791805),
         (c_families = NULL) => 0.0281311220, 0.0281311220),
      (c_business = NULL) => -0.0530186919, 0.0333547913), 0.0094470389),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0240868452, 0.0003759653);

// Tree: 129 
woFDN_FLAP___lgt_129 := map(
(NULL < c_hhsize and c_hhsize <= 4.005) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0165272578,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0066438643,
      (f_srchfraudsrchcountmo_i > 0.5) => 
         map(
         (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => -0.0314119844,
         (f_util_add_input_conv_n > 0.5) => 0.1427580463,
         (f_util_add_input_conv_n = NULL) => 0.0717998857, 0.0717998857),
      (f_srchfraudsrchcountmo_i = NULL) => 0.0272922031, 0.0090572428),
   (k_inf_nothing_found_i = NULL) => -0.0061173019, -0.0061173019),
(c_hhsize > 4.005) => 
   map(
   (NULL < c_med_age and c_med_age <= 26.65) => 0.2219412158,
   (c_med_age > 26.65) => -0.0030520877,
   (c_med_age = NULL) => 0.0719456801, 0.0719456801),
(c_hhsize = NULL) => 0.0129171520, -0.0044542003);

// Tree: 130 
woFDN_FLAP___lgt_130 := map(
(NULL < c_lar_fam and c_lar_fam <= 181.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 12.45) => -0.0947166388,
   (c_white_col > 12.45) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2620) => -0.0095223080,
      (f_addrchangeincomediff_d > 2620) => 0.0338656616,
      (f_addrchangeincomediff_d = NULL) => 0.0042496335, -0.0046049651),
   (c_white_col = NULL) => -0.0052446808, -0.0052446808),
(c_lar_fam > 181.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 7.65) => -0.0570744130,
   (C_INC_15K_P > 7.65) => 0.1608000392,
   (C_INC_15K_P = NULL) => 0.0749707096, 0.0749707096),
(c_lar_fam = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 0.1573045580,
   (r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0658905957,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0444806341, 0.0444806341), -0.0032417975);

// Tree: 131 
woFDN_FLAP___lgt_131 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 5175.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 44.05) => -0.0929618738,
   (c_fammar_p > 44.05) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 30050) => 0.1811887688,
      (r_L80_Inp_AVM_AutoVal_d > 30050) => -0.0141321709,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 55.55) => 0.1086073722,
         (c_civ_emp > 55.55) => -0.0496472762,
         (c_civ_emp = NULL) => -0.0206247974, -0.0206247974), -0.0110105497),
   (c_fammar_p = NULL) => -0.0147836309, -0.0147836309),
(r_A49_Curr_AVM_Chg_1yr_i > 5175.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 9.5) => 0.0191163002,
   (f_inq_Collection_count_i > 9.5) => 0.1207764769,
   (f_inq_Collection_count_i = NULL) => 0.0221072616, 0.0221072616),
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0014444987, 0.0014831442);

// Tree: 132 
woFDN_FLAP___lgt_132 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 12.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => -0.0023679040,
      (f_addrchangecrimediff_i > 98.5) => 0.0603804848,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0134363489,
         (f_phones_per_addr_curr_i > 4.5) => 0.0499925273,
         (f_phones_per_addr_curr_i = NULL) => 0.0066679274, 0.0066679274), 0.0000902663),
   (f_assocsuspicousidcount_i > 16.5) => 0.0970220505,
   (f_assocsuspicousidcount_i = NULL) => 0.0005755514, 0.0005755514),
(f_srchphonesrchcount_i > 12.5) => 
   map(
   (NULL < c_no_car and c_no_car <= 77.5) => 0.0312227480,
   (c_no_car > 77.5) => -0.1436100550,
   (c_no_car = NULL) => -0.0604137556, -0.0604137556),
(f_srchphonesrchcount_i = NULL) => 0.0001355525, -0.0001365643);

// Tree: 133 
woFDN_FLAP___lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 124.5) => 
   map(
   (NULL < c_rape and c_rape <= 66) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.28762863355) => 0.2128727609,
      (f_add_curr_mobility_index_i > 0.28762863355) => 0.0382988486,
      (f_add_curr_mobility_index_i = NULL) => 0.1386444832, 0.1386444832),
   (c_rape > 66) => 0.0060158005,
   (c_rape = NULL) => 0.0579316151, 0.0579316151),
(f_mos_liens_unrel_SC_fseen_d > 124.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => -0.0110316379,
   (f_bus_name_nover_i > 0.5) => 0.0158261899,
   (f_bus_name_nover_i = NULL) => -0.0001088086, -0.0001088086),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.75) => 0.0615846934,
   (c_hh3_p > 13.75) => -0.0450849523,
   (c_hh3_p = NULL) => -0.0025837653, -0.0025837653), 0.0013653188);

// Tree: 134 
woFDN_FLAP___lgt_134 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 29.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0011373846,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.99316572085) => 0.0277244727,
      (f_add_input_nhood_SFD_pct_d > 0.99316572085) => 0.2351066188,
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0379102362, 0.0379102362),
   (r_L70_Add_Standardized_i = NULL) => 0.0021480504, 0.0021480504),
(f_rel_under100miles_cnt_d > 29.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 89) => -0.1355948308,
   (c_medi_indx > 89) => -0.0245501051,
   (c_medi_indx = NULL) => -0.0585889406, -0.0585889406),
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 201236.5) => 0.0828655489,
   (r_L80_Inp_AVM_AutoVal_d > 201236.5) => -0.0413801983,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0217987096, -0.0072788270), 0.0008793051);

// Tree: 135 
woFDN_FLAP___lgt_135 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0063701478,
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < c_young and c_young <= 23.2) => 0.0267599780,
      (c_young > 23.2) => 0.2400261663,
      (c_young = NULL) => 0.1040303360, 0.1040303360),
   (f_adls_per_phone_c6_i = NULL) => -0.0050389831, -0.0050389831),
(k_comb_age_d > 66.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 17.5) => 0.1567001146,
   (c_born_usa > 17.5) => 0.0310103993,
   (c_born_usa = NULL) => 0.0404765704, 0.0404765704),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 122.5) => 0.0531002242,
   (c_rich_nfam > 122.5) => -0.0512754245,
   (c_rich_nfam = NULL) => 0.0020227791, 0.0020227791), -0.0013937555);

// Tree: 136 
woFDN_FLAP___lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 21205.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 119.5) => 0.0166024811,
      (c_easiqlife > 119.5) => 0.2206735695,
      (c_easiqlife = NULL) => 0.1197703352, 0.1134182518),
   (f_curraddrmedianincome_d > 21205.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 67.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 3.55) => 0.1816889093,
         (c_incollege > 3.55) => 0.0435765850,
         (c_incollege = NULL) => 0.0751785575, 0.0751785575),
      (r_D32_Mos_Since_Crim_LS_d > 67.5) => 0.0072331621,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0139200317, 0.0139200317),
   (f_curraddrmedianincome_d = NULL) => 0.0202891605, 0.0202891605),
(f_hh_members_ct_d > 1.5) => -0.0077000682,
(f_hh_members_ct_d = NULL) => -0.0096466941, -0.0020693120);

// Tree: 137 
woFDN_FLAP___lgt_137 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 190159.5) => -0.0045592180,
(f_addrchangevaluediff_d > 190159.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 29.85) => 0.1981198308,
   (c_hh2_p > 29.85) => -0.0328567831,
   (c_hh2_p = NULL) => 0.0680741742, 0.0680741742),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 21.5) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 3.5) => 0.0057807325,
      (r_C14_addrs_5yr_i > 3.5) => -0.0557922048,
      (r_C14_addrs_5yr_i = NULL) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 76.75) => 0.0425524466,
         (c_fammar_p > 76.75) => -0.0688015209,
         (c_fammar_p = NULL) => -0.0151273064, -0.0151273064), -0.0015352688),
   (f_bus_addr_match_count_d > 21.5) => 0.1766727500,
   (f_bus_addr_match_count_d = NULL) => 0.0021273623, 0.0021273623), -0.0023133257);

// Tree: 138 
woFDN_FLAP___lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 75.45) => 0.0016100600,
   (c_low_ed > 75.45) => -0.0480858704,
   (c_low_ed = NULL) => -0.0133727398, -0.0003591297),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0624501419) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 28.8) => 0.0673658054,
      (c_famotf18_p > 28.8) => 0.1738602282,
      (c_famotf18_p = NULL) => 0.1022300509, 0.1022300509),
   (f_add_input_nhood_BUS_pct_i > 0.0624501419) => -0.0159065617,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0508663063, 0.0508663063),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 63.05) => 0.0494716802,
   (c_civ_emp > 63.05) => -0.0572479868,
   (c_civ_emp = NULL) => 0.0023371606, 0.0023371606), 0.0009035756);

// Tree: 139 
woFDN_FLAP___lgt_139 := map(
(NULL < c_incollege and c_incollege <= 15.05) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.95) => 0.1314824479,
      (c_pop_45_54_p > 11.95) => 0.0110285736,
      (c_pop_45_54_p = NULL) => 0.0532180017, 0.0532180017),
   (r_C21_M_Bureau_ADL_FS_d > 7.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0004160375,
      (c_lar_fam > 181.5) => 0.0888640885,
      (c_lar_fam = NULL) => 0.0004888020, 0.0004888020),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 6.45) => -0.0784878380,
      (C_INC_25K_P > 6.45) => 0.0426873790,
      (C_INC_25K_P = NULL) => -0.0106297165, -0.0106297165), 0.0012598910),
(c_incollege > 15.05) => -0.0516487488,
(c_incollege = NULL) => -0.0255723650, -0.0024022131);

// Tree: 140 
woFDN_FLAP___lgt_140 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.95) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 0.0001519835,
      (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0662541321,
      (f_inq_HighRiskCredit_count24_i = NULL) => 0.0004990777, 0.0004990777),
   (f_srchaddrsrchcountmo_i > 1.5) => 
      map(
      (NULL < c_robbery and c_robbery <= 55.5) => 0.1750058860,
      (c_robbery > 55.5) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 520) => 0.0695560647,
         (c_hh00 > 520) => -0.0629418621,
         (c_hh00 = NULL) => 0.0027684918, 0.0027684918),
      (c_robbery = NULL) => 0.0532518660, 0.0532518660),
   (f_srchaddrsrchcountmo_i = NULL) => -0.0062247713, 0.0011783743),
(c_hval_80k_p > 40.95) => -0.0909532375,
(c_hval_80k_p = NULL) => -0.0209751800, -0.0001040455);

// Tree: 141 
woFDN_FLAP___lgt_141 := map(
(NULL < c_housingcpi and c_housingcpi <= 204.35) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.25) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 194.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0041866677,
         (f_assocrisktype_i > 8.5) => 0.0911386994,
         (f_assocrisktype_i = NULL) => 0.0013117234, 0.0013117234),
      (c_new_homes > 194.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 69847.5) => 0.2988015071,
         (f_curraddrmedianincome_d > 69847.5) => 0.0072560881,
         (f_curraddrmedianincome_d = NULL) => 0.1171137822, 0.1171137822),
      (c_new_homes = NULL) => 0.0104383276, 0.0104383276),
   (c_unemp > 11.25) => 0.1369159665,
   (c_unemp = NULL) => 0.0140860466, 0.0140860466),
(c_housingcpi > 204.35) => -0.0070044630,
(c_housingcpi = NULL) => -0.0276196945, -0.0044959092);

// Tree: 142 
woFDN_FLAP___lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < c_hval_400k_p and c_hval_400k_p <= 1.55) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 2274.5) => 0.0073776589,
      (c_pop00 > 2274.5) => 0.0684198224,
      (c_pop00 = NULL) => 0.0173003571, 0.0173003571),
   (c_hval_400k_p > 1.55) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 22.5) => -0.0016061289,
      (f_rel_homeover50_count_d > 22.5) => -0.0534142972,
      (f_rel_homeover50_count_d = NULL) => -0.0568021790, -0.0052368585),
   (c_hval_400k_p = NULL) => 0.0370150408, 0.0023523865),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0617283959,
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.271039828) => -0.0757756257,
   (f_add_input_nhood_SFD_pct_d > 0.271039828) => 0.0507298866,
   (f_add_input_nhood_SFD_pct_d = NULL) => 0.0032903195, 0.0032903195), 0.0010047188);

// Tree: 143 
woFDN_FLAP___lgt_143 := map(
(NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => 0.0001100333,
   (c_hval_200k_p > 16.45) => 0.0440265622,
   (c_hval_200k_p = NULL) => 0.0129864598, 0.0042529586),
(f_inq_Auto_count24_i > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0611553179,
      (f_varrisktype_i > 3.5) => -0.1315057406,
      (f_varrisktype_i = NULL) => -0.0685307655, -0.0685307655),
   (r_C23_inp_addr_occ_index_d > 2) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => 0.0876119124,
      (r_I60_inq_recency_d > 9) => -0.0789727750,
      (r_I60_inq_recency_d = NULL) => 0.0169102718, 0.0169102718),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0465309774, -0.0465309774),
(f_inq_Auto_count24_i = NULL) => -0.0077146125, 0.0014333547);

// Tree: 144 
woFDN_FLAP___lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => -0.0018489608,
      (f_assocsuspicousidcount_i > 9.5) => -0.0504495706,
      (f_assocsuspicousidcount_i = NULL) => -0.0031168737, -0.0031168737),
   (r_C14_addrs_10yr_i > 10.5) => 0.1181164672,
   (r_C14_addrs_10yr_i = NULL) => -0.0138579113, -0.0027204349),
(c_rnt2001_p > 49) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0279218077,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 62.5) => 0.4156506353,
      (c_no_teens > 62.5) => 0.0271592729,
      (c_no_teens = NULL) => 0.1946124464, 0.1946124464),
   (k_inf_nothing_found_i = NULL) => 0.0917373657, 0.0917373657),
(c_rnt2001_p = NULL) => 0.0047778723, -0.0002980669);

// Tree: 145 
woFDN_FLAP___lgt_145 := map(
(NULL < c_low_hval and c_low_hval <= 71.05) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 323.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => -0.0032354179,
      (f_hh_lienholders_i > 3.5) => 0.0670751320,
      (f_hh_lienholders_i = NULL) => -0.0024966454, -0.0024966454),
   (f_prevaddrageoldest_d > 323.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 21.7) => 0.0330522657,
      (c_hval_500k_p > 21.7) => 0.2012283752,
      (c_hval_500k_p = NULL) => 0.0568674141, 0.0568674141),
   (f_prevaddrageoldest_d = NULL) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 62.65) => 0.0440422242,
      (c_civ_emp > 62.65) => -0.0589200362,
      (c_civ_emp = NULL) => -0.0062416704, -0.0062416704), 0.0002220952),
(c_low_hval > 71.05) => -0.0918079712,
(c_low_hval = NULL) => 0.0073621649, -0.0003341072);

// Tree: 146 
woFDN_FLAP___lgt_146 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => -0.0052077976,
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1161109074,
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0043526703, -0.0043526703),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 208.95) => 0.1925158536,
   (c_housingcpi > 208.95) => 
      map(
      (NULL < c_rural_p and c_rural_p <= 18.6) => -0.0129999339,
      (c_rural_p > 18.6) => 0.2097922422,
      (c_rural_p = NULL) => 0.0369644880, 0.0369644880),
   (c_housingcpi = NULL) => 0.0611184267, 0.0611184267),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0353088257,
   (c_high_hval > 3.7) => 0.0599005060,
   (c_high_hval = NULL) => 0.0105327044, 0.0105327044), -0.0024966427);

// Tree: 147 
woFDN_FLAP___lgt_147 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 63.5) => -0.0633833389,
(f_mos_inq_banko_am_lseen_d > 63.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 218.4) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 182.5) => 
         map(
         (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 14.5) => -0.0034969195,
         (f_srchphonesrchcount_i > 14.5) => -0.0744140727,
         (f_srchphonesrchcount_i = NULL) => -0.0043481502, -0.0043481502),
      (c_lar_fam > 182.5) => 0.1279093374,
      (c_lar_fam = NULL) => -0.0034556241, -0.0034556241),
   (c_cpiall > 218.4) => 0.0210077807,
   (c_cpiall = NULL) => -0.0386699012, 0.0016372279),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 38.45) => 0.0837448897,
   (c_low_ed > 38.45) => -0.0298784859,
   (c_low_ed = NULL) => 0.0212520331, 0.0212520331), -0.0009437375);

// Tree: 148 
woFDN_FLAP___lgt_148 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 96) => 0.0801812271,
(r_D32_Mos_Since_Fel_LS_d > 96) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0080178054,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 78.5) => 0.1110419639,
      (f_mos_liens_unrel_SC_fseen_d > 78.5) => 
         map(
         (NULL < c_employees and c_employees <= 90.5) => 0.0443320579,
         (c_employees > 90.5) => -0.0014623265,
         (c_employees = NULL) => 0.0107977199, 0.0107977199),
      (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0132522454, 0.0132522454),
   (f_inq_Other_count_i = NULL) => -0.0032138459, -0.0032138459),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 135.5) => -0.0405560771,
   (c_relig_indx > 135.5) => 0.0367381444,
   (c_relig_indx = NULL) => -0.0090438176, -0.0090438176), -0.0029085094);

// Tree: 149 
woFDN_FLAP___lgt_149 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0945270674,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 1.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 86.15) => 0.1336771780,
         (c_occunit_p > 86.15) => 0.0127880265,
         (c_occunit_p = NULL) => 0.0261275191, 0.0261275191),
      (r_C12_Num_NonDerogs_d > 1.5) => 0.0009735314,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0040177917, 0.0040177917),
   (f_divsrchaddrsuspidcount_i > 1.5) => -0.0682557159,
   (f_divsrchaddrsuspidcount_i = NULL) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 128.5) => 0.0594225537,
      (c_ab_av_edu > 128.5) => -0.0692307874,
      (c_ab_av_edu = NULL) => 0.0079612173, 0.0079612173), 0.0034033494),
(c_pop_45_54_p = NULL) => 0.0039480314, 0.0020646852);

// Tree: 150 
woFDN_FLAP___lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 2.75) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 27.5) => 0.0062307596,
      (f_srchaddrsrchcount_i > 27.5) => 0.0831788657,
      (f_srchaddrsrchcount_i = NULL) => 0.0263282674, 0.0071118626),
   (c_trailer_p > 2.75) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 39.5) => -0.0620643310,
      (f_mos_inq_banko_cm_fseen_d > 39.5) => -0.0110902489,
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0175641656, -0.0175641656),
   (c_trailer_p = NULL) => 0.0005388258, 0.0005388258),
(c_low_ed > 77.75) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9522119962) => -0.0726578801,
   (f_add_curr_nhood_SFD_pct_d > 0.9522119962) => 0.0487421669,
   (f_add_curr_nhood_SFD_pct_d = NULL) => -0.0498305209, -0.0498305209),
(c_low_ed = NULL) => 0.0050365024, -0.0007661335);

// Tree: 151 
woFDN_FLAP___lgt_151 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.94494685515) => 
      map(
      (NULL < c_rape and c_rape <= 95.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 5064.5) => 0.0127538904,
         (f_addrchangeincomediff_d > 5064.5) => 0.0743262336,
         (f_addrchangeincomediff_d = NULL) => 0.0168419075, 0.0160206183),
      (c_rape > 95.5) => -0.0127755238,
      (c_rape = NULL) => 0.0036393222, 0.0036393222),
   (f_add_curr_nhood_MFD_pct_i > 0.94494685515) => -0.0415291401,
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0180002646, -0.0019038144),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.75) => -0.0183279125,
   (c_pop_45_54_p > 13.75) => 0.2024502747,
   (c_pop_45_54_p = NULL) => 0.0841762459, 0.0841762459),
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0011302135, -0.0011302135);

// Tree: 152 
woFDN_FLAP___lgt_152 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37763534975) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 183.5) => 0.0103185133,
      (c_larceny > 183.5) => -0.0500261601,
      (c_larceny = NULL) => -0.0533908702, 0.0072153219),
   (f_srchfraudsrchcountyr_i > 7.5) => -0.0821112678,
   (f_srchfraudsrchcountyr_i = NULL) => 0.0277167465, 0.0069526362),
(f_add_input_mobility_index_i > 0.37763534975) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.585) => -0.0081371000,
   (c_hhsize > 2.585) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 22500) => -0.1372982631,
      (k_estimated_income_d > 22500) => -0.0455602846,
      (k_estimated_income_d = NULL) => -0.0532789283, -0.0532789283),
   (c_hhsize = NULL) => 0.0772478486, -0.0198279950),
(f_add_input_mobility_index_i = NULL) => 0.0655685766, 0.0027439011);

// Tree: 153 
woFDN_FLAP___lgt_153 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32739754485) => 0.0064387885,
(f_add_input_mobility_index_i > 0.32739754485) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 25500) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 9.55) => -0.1153480958,
      (c_pop_35_44_p > 9.55) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 1.5) => 0.0893964884,
         (f_rel_under100miles_cnt_d > 1.5) => -0.0514339075,
         (f_rel_under100miles_cnt_d = NULL) => -0.0185296094, -0.0185296094),
      (c_pop_35_44_p = NULL) => -0.0808132535, -0.0489052931),
   (k_estimated_income_d > 25500) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.0980955109,
      (r_D33_Eviction_Recency_d > 48) => -0.0149698772,
      (r_D33_Eviction_Recency_d = NULL) => -0.0130165881, -0.0130165881),
   (k_estimated_income_d = NULL) => -0.0368237860, -0.0171243592),
(f_add_input_mobility_index_i = NULL) => 0.0477814619, 0.0003573910);

// Tree: 154 
woFDN_FLAP___lgt_154 := map(
(NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 32.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 8.5) => -0.0020444179,
   (f_util_adl_count_n > 8.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 54399) => 0.1167191107,
      (f_curraddrmedianincome_d > 54399) => 0.0030562452,
      (f_curraddrmedianincome_d = NULL) => 0.0481605569, 0.0481605569),
   (f_util_adl_count_n = NULL) => -0.0002227629, -0.0002227629),
(f_rel_homeover150_count_d > 32.5) => -0.0790263150,
(f_rel_homeover150_count_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 229750) => 0.0798981004,
   (r_L80_Inp_AVM_AutoVal_d > 229750) => -0.0790618955,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_employees and c_employees <= 198.5) => 0.0539972779,
      (c_employees > 198.5) => -0.0729809149,
      (c_employees = NULL) => -0.0171105101, -0.0171105101), -0.0060496879), -0.0011800510);

// Tree: 155 
woFDN_FLAP___lgt_155 := map(
(NULL < c_unempl and c_unempl <= 190.5) => 
   map(
   (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 2) => 0.1235215609,
   (r_I60_inq_retail_recency_d > 2) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -13557) => 0.0390448190,
      (f_addrchangeincomediff_d > -13557) => -0.0024527872,
      (f_addrchangeincomediff_d = NULL) => -0.0174765695, -0.0044297697),
   (r_I60_inq_retail_recency_d = NULL) => 
      map(
      (NULL < c_burglary and c_burglary <= 98.5) => -0.0339853356,
      (c_burglary > 98.5) => 0.0735579705,
      (c_burglary = NULL) => 0.0119807549, 0.0119807549), -0.0036597305),
(c_unempl > 190.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 135) => -0.0106139575,
   (f_fp_prevaddrburglaryindex_i > 135) => 0.1662673169,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0778266797, 0.0778266797),
(c_unempl = NULL) => 0.0197285564, -0.0023633938);

// Tree: 156 
woFDN_FLAP___lgt_156 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0007890631,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 65.55) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 1.75) => 0.0499874395,
      (C_INC_200K_P > 1.75) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 68.2) => -0.0789390028,
         (C_OWNOCC_P > 68.2) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3038216052) => -0.0472312176,
            (f_add_curr_mobility_index_i > 0.3038216052) => 0.0742425397,
            (f_add_curr_mobility_index_i = NULL) => -0.0063137415, -0.0063137415),
         (C_OWNOCC_P = NULL) => -0.0413400936, -0.0413400936),
      (C_INC_200K_P = NULL) => -0.0219378924, -0.0219378924),
   (c_low_ed > 65.55) => -0.1037345281,
   (c_low_ed = NULL) => -0.0335370470, -0.0335370470),
(f_srchfraudsrchcount_i = NULL) => 0.0027011875, -0.0006689818);

// Tree: 157 
woFDN_FLAP___lgt_157 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => -0.0029278457,
   (f_srchaddrsrchcount_i > 12.5) => 
      map(
      (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 19) => 0.1124470494,
      (f_mos_inq_banko_om_lseen_d > 19) => 
         map(
         (NULL < c_unattach and c_unattach <= 117.5) => 0.0510783130,
         (c_unattach > 117.5) => -0.0575599400,
         (c_unattach = NULL) => 0.0126605701, 0.0126605701),
      (f_mos_inq_banko_om_lseen_d = NULL) => 0.0283749763, 0.0283749763),
   (f_srchaddrsrchcount_i = NULL) => -0.0016361688, -0.0016361688),
(f_prevaddrmedianvalue_d > 809865.5) => 0.1035796456,
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.5) => -0.0408033175,
   (c_pop_35_44_p > 16.5) => 0.0511988923,
   (c_pop_35_44_p = NULL) => -0.0054691355, -0.0054691355), 0.0000647191);

// Tree: 158 
woFDN_FLAP___lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0029722865,
      (f_srchunvrfddobcount_i > 0.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 24.05) => 0.2124828546,
         (c_oldhouse > 24.05) => 0.0243537996,
         (c_oldhouse = NULL) => 0.0498455415, 0.0498455415),
      (f_srchunvrfddobcount_i = NULL) => -0.0013340589, -0.0013340589),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 213.5) => -0.1662146261,
      (r_A50_pb_total_dollars_d > 213.5) => -0.0034080362,
      (r_A50_pb_total_dollars_d = NULL) => -0.0613191051, -0.0613191051),
   (r_I60_inq_comm_count12_i = NULL) => -0.0020510884, -0.0020510884),
(r_D33_eviction_count_i > 3.5) => 0.0723761153,
(r_D33_eviction_count_i = NULL) => 0.0010579667, -0.0015642543);

// Tree: 159 
woFDN_FLAP___lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 22.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 2091.5) => -0.0049066182,
      (c_popover18 > 2091.5) => 0.0298204831,
      (c_popover18 = NULL) => 0.0099715806, 0.0002291441),
   (k_inq_per_addr_i > 22.5) => 0.0924991980,
   (k_inq_per_addr_i = NULL) => 0.0006141373, 0.0006141373),
(f_rel_homeover500_count_d > 19.5) => 0.1102872069,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 110.5) => -0.0430140492,
   (c_easiqlife > 110.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1032296654,
      (r_Phn_Cell_n > 0.5) => -0.0099759852,
      (r_Phn_Cell_n = NULL) => 0.0418602864, 0.0418602864),
   (c_easiqlife = NULL) => 0.0022840512, 0.0022840512), 0.0012794684);

// Tree: 160 
woFDN_FLAP___lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.4) => -0.0069180201,
(r_C12_source_profile_d > 75.4) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 8.05) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 1.75) => 
         map(
         (NULL < c_sfdu_p and c_sfdu_p <= 47.95) => 0.2244993921,
         (c_sfdu_p > 47.95) => 0.0561158646,
         (c_sfdu_p = NULL) => 0.1216697570, 0.1216697570),
      (c_pop_75_84_p > 1.75) => 0.0486554613,
      (c_pop_75_84_p = NULL) => 0.0606716331, 0.0606716331),
   (C_INC_125K_P > 8.05) => 0.0058278154,
   (C_INC_125K_P = NULL) => 0.0023428105, 0.0254669758),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 130.5) => -0.0418540589,
   (c_no_car > 130.5) => 0.0625773142,
   (c_no_car = NULL) => -0.0033403610, -0.0033403610), -0.0012270495);

// Tree: 161 
woFDN_FLAP___lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.65) => -0.1369968611,
   (C_INC_150K_P > 0.65) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 110.5) => -0.0630261510,
      (c_retired2 > 110.5) => 
         map(
         (NULL < c_lux_prod and c_lux_prod <= 87.5) => 0.1289457881,
         (c_lux_prod > 87.5) => -0.0325230089,
         (c_lux_prod = NULL) => 0.0231558866, 0.0231558866),
      (c_retired2 = NULL) => -0.0314468123, -0.0314468123),
   (C_INC_150K_P = NULL) => -0.0422242079, -0.0422242079),
(f_mos_inq_banko_cm_fseen_d > 25.5) => -0.0017414757,
(f_mos_inq_banko_cm_fseen_d = NULL) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 1.65) => 0.0276111409,
   (c_wholesale > 1.65) => -0.0696802163,
   (c_wholesale = NULL) => -0.0144385135, -0.0144385135), -0.0039141444);

// Tree: 162 
woFDN_FLAP___lgt_162 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0042587169,
   (f_hh_payday_loan_users_i > 0.5) => 0.0271566815,
   (f_hh_payday_loan_users_i = NULL) => -0.0014460821, -0.0014460821),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 21.85) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.45) => 0.1129868187,
      (c_pop_18_24_p > 8.45) => -0.0582151044,
      (c_pop_18_24_p = NULL) => 0.0110497958, 0.0110497958),
   (C_INC_75K_P > 21.85) => 0.2459865256,
   (C_INC_75K_P = NULL) => 0.0787217886, 0.0787217886),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 5.3) => -0.0309124950,
   (C_INC_150K_P > 5.3) => 0.0605500753,
   (C_INC_150K_P = NULL) => 0.0094571912, 0.0094571912), -0.0001261787);

// Tree: 163 
woFDN_FLAP___lgt_163 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0038255790,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 3.65) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.03622665655) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 3.5) => 0.2761936077,
         (r_A50_pb_total_orders_d > 3.5) => 0.0420648175,
         (r_A50_pb_total_orders_d = NULL) => 0.1817868374, 0.1817868374),
      (f_add_input_nhood_VAC_pct_i > 0.03622665655) => 0.0149616671,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0904591894, 0.0904591894),
   (C_INC_200K_P > 3.65) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 5.15) => 0.0788049046,
      (c_newhouse > 5.15) => -0.0563981699,
      (c_newhouse = NULL) => -0.0091619493, -0.0091619493),
   (C_INC_200K_P = NULL) => 0.0271361784, 0.0271361784),
(k_comb_age_d = NULL) => -0.0087151094, -0.0019958768);

// Tree: 164 
woFDN_FLAP___lgt_164 := map(
(NULL < c_manufacturing and c_manufacturing <= 16.35) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1618280103,
      (r_Phn_Cell_n > 0.5) => 0.0022303686,
      (r_Phn_Cell_n = NULL) => 0.0520518546, 0.0520518546),
   (r_C10_M_Hdr_FS_d > 8.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 0.0071064318,
      (k_inq_adls_per_addr_i > 4.5) => -0.0663648367,
      (k_inq_adls_per_addr_i = NULL) => 0.0063525105, 0.0063525105),
   (r_C10_M_Hdr_FS_d = NULL) => 
      map(
      (NULL < c_med_age and c_med_age <= 37.2) => 0.0600083487,
      (c_med_age > 37.2) => -0.0645444184,
      (c_med_age = NULL) => 0.0034886057, 0.0034886057), 0.0070729943),
(c_manufacturing > 16.35) => -0.0441074401,
(c_manufacturing = NULL) => 0.0293476125, 0.0040085116);

// Tree: 165 
woFDN_FLAP___lgt_165 := map(
(NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 25.05) => 
      map(
      (NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 29.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 75.35) => 0.0089656589,
         (c_rnt1000_p > 75.35) => 0.1261658117,
         (c_rnt1000_p = NULL) => 0.0109366454, 0.0109366454),
      (f_liens_rel_O_total_amt_i > 29.5) => -0.1042343066,
      (f_liens_rel_O_total_amt_i = NULL) => 0.0113534186, 0.0097017392),
   (c_pop_55_64_p > 25.05) => 0.1558698746,
   (c_pop_55_64_p = NULL) => 0.0014274573, 0.0107670185),
(k_inf_lname_verd_d > 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 76) => 0.0019614724,
   (f_curraddrcrimeindex_i > 76) => -0.0486948316,
   (f_curraddrcrimeindex_i = NULL) => -0.0208861500, -0.0208861500),
(k_inf_lname_verd_d = NULL) => 0.0003091210, 0.0003091210);

// Tree: 166 
woFDN_FLAP___lgt_166 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < c_info and c_info <= 20.45) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.85) => 
         map(
         (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0083378072,
         (f_srchfraudsrchcountmo_i > 0.5) => -0.0632050062,
         (f_srchfraudsrchcountmo_i = NULL) => -0.0105298907, -0.0105298907),
      (c_pop_35_44_p > 13.85) => 0.0123007432,
      (c_pop_35_44_p = NULL) => 0.0023896650, 0.0023896650),
   (c_info > 20.45) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 3.2) => -0.0275615570,
      (c_hval_250k_p > 3.2) => 0.2614579088,
      (c_hval_250k_p = NULL) => 0.1300854243, 0.1300854243),
   (c_info = NULL) => 0.0035735279, 0.0035735279),
(c_asian_lang > 194.5) => -0.0532256436,
(c_asian_lang = NULL) => 0.0080763326, 0.0012163199);

// Tree: 167 
woFDN_FLAP___lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
      map(
      (NULL < f_corraddrphonecount_d and f_corraddrphonecount_d <= 1.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00180917015) => 0.1195592006,
         (f_add_curr_nhood_VAC_pct_i > 0.00180917015) => -0.0043927343,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0088826767, 0.0088826767),
      (f_corraddrphonecount_d > 1.5) => 
         map(
         (NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 0.1859368672,
         (k_inf_lname_verd_d > 0.5) => -0.0008886622,
         (k_inf_lname_verd_d = NULL) => 0.1067133832, 0.1067133832),
      (f_corraddrphonecount_d = NULL) => 0.0240815475, 0.0240815475),
   (c_rnt750_p > 57.25) => 0.1360338400,
   (c_rnt750_p = NULL) => 0.0316128836, 0.0316128836),
(c_many_cars > 22.5) => -0.0076858431,
(c_many_cars = NULL) => 0.0041005812, -0.0040122509);

// Tree: 168 
woFDN_FLAP___lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0057351820,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1894.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 45.15) => 0.1083456653,
      (c_fammar_p > 45.15) => 0.0000989418,
      (c_fammar_p = NULL) => 0.0101360845, 0.0101360845),
   (c_popover18 > 1894.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.55) => 0.0001269201,
      (c_hh6_p > 1.55) => 
         map(
         (NULL < c_unattach and c_unattach <= 89.5) => 0.1231477673,
         (c_unattach > 89.5) => 0.2943381711,
         (c_unattach = NULL) => 0.2070969076, 0.2070969076),
      (c_hh6_p = NULL) => 0.1260034037, 0.1260034037),
   (c_popover18 = NULL) => 0.0328577721, 0.0328577721),
(c_hval_150k_p = NULL) => -0.0105695129, -0.0031911980);

// Tree: 169 
woFDN_FLAP___lgt_169 := map(
(NULL < c_hh6_p and c_hh6_p <= 16.85) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 10.65) => -0.0039649351,
   (c_hh6_p > 10.65) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 317.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01232719995) => 0.0094851267,
         (f_add_curr_nhood_VAC_pct_i > 0.01232719995) => 
            map(
            (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => 0.0787351206,
            (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => 0.2172876103,
            (nf_seg_FraudPoint_3_0 = '') => 0.1459738288, 0.1459738288),
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0840331728, 0.0840331728),
      (f_M_Bureau_ADL_FS_all_d > 317.5) => -0.0639886686,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0526487951, 0.0526487951),
   (c_hh6_p = NULL) => -0.0025088254, -0.0025088254),
(c_hh6_p > 16.85) => -0.0900060842,
(c_hh6_p = NULL) => 0.0041434832, -0.0028915361);

// Tree: 170 
woFDN_FLAP___lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0031363402,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 32.25) => 0.0051579988,
      (c_rnt1000_p > 32.25) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.1386562295) => 0.0568339700,
         (f_add_input_nhood_BUS_pct_i > 0.1386562295) => 0.2079894809,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0767023490, 0.0767023490),
      (c_rnt1000_p = NULL) => 0.0211993329, 0.0211993329),
   (f_rel_felony_count_i = NULL) => 0.0003837913, 0.0003837913),
(f_util_adl_count_n > 13.5) => 0.1075487997,
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 13.5) => -0.0328579424,
   (c_retail > 13.5) => 0.0485829887,
   (c_retail = NULL) => -0.0015345073, -0.0015345073), 0.0012320249);

// Tree: 171 
woFDN_FLAP___lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 57.15) => 
      map(
      (NULL < c_no_car and c_no_car <= 102.5) => -0.0312421809,
      (c_no_car > 102.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 17.45) => 0.0680129450,
         (c_hh4_p > 17.45) => 0.1925841842,
         (c_hh4_p = NULL) => 0.0899423563, 0.0899423563),
      (c_no_car = NULL) => 0.0549569073, 0.0549569073),
   (c_sfdu_p > 57.15) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 81.5) => 0.0632991599,
      (r_D32_Mos_Since_Crim_LS_d > 81.5) => -0.0167003045,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0013183756, -0.0013183756),
   (c_sfdu_p = NULL) => 0.0350708346, 0.0176458988),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0022944705,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0093073016, 0.0004992113);

// Tree: 172 
woFDN_FLAP___lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.75) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 7.5) => 
      map(
      (NULL < c_business and c_business <= 22.5) => 0.0114269438,
      (c_business > 22.5) => -0.0141001874,
      (c_business = NULL) => -0.0019960781, -0.0019960781),
   (r_L79_adls_per_addr_curr_i > 7.5) => 
      map(
      (NULL < c_transport and c_transport <= 5.75) => -0.0600670895,
      (c_transport > 5.75) => 0.0756593931,
      (c_transport = NULL) => -0.0440459234, -0.0440459234),
   (r_L79_adls_per_addr_curr_i = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 92.5) => 0.0423682792,
      (c_many_cars > 92.5) => -0.0531077118,
      (c_many_cars = NULL) => -0.0064465132, -0.0064465132), -0.0035703596),
(c_pop_0_5_p > 20.75) => 0.1314382108,
(c_pop_0_5_p = NULL) => -0.0006045390, -0.0029135529);

// Tree: 173 
woFDN_FLAP___lgt_173 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0078649471,
(f_rel_felony_count_i > 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 118.5) => 0.1985287436,
      (c_easiqlife > 118.5) => 0.0271327481,
      (c_easiqlife = NULL) => 0.1085458459, 0.1085458459),
   (r_C12_Num_NonDerogs_d > 1.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 15.35) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0085554111) => 0.0938031531,
         (f_add_input_nhood_MFD_pct_i > 0.0085554111) => 0.0323517300,
         (f_add_input_nhood_MFD_pct_i = NULL) => -0.0385297372, 0.0252418654),
      (C_INC_25K_P > 15.35) => -0.0393804961,
      (C_INC_25K_P = NULL) => 0.0139964962, 0.0139964962),
   (r_C12_Num_NonDerogs_d = NULL) => 0.0204216730, 0.0204216730),
(f_rel_felony_count_i = NULL) => -0.0208149305, -0.0039839550);

// Tree: 174 
woFDN_FLAP___lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 21.5) => 
   map(
   (NULL < c_info and c_info <= 27.55) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 0.0115865092,
      (f_dl_addrs_per_adl_i > 0.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 13.5) => -0.0188986700,
         (f_addrchangecrimediff_i > 13.5) => 
            map(
            (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0176907771,
            (f_phones_per_addr_c6_i > 0.5) => 0.1405606847,
            (f_phones_per_addr_c6_i = NULL) => 0.0480884450, 0.0480884450),
         (f_addrchangecrimediff_i = NULL) => -0.0198349135, -0.0167646542),
      (f_dl_addrs_per_adl_i = NULL) => 0.0003578394, 0.0003578394),
   (c_info > 27.55) => 0.2029330517,
   (c_info = NULL) => -0.0044350620, 0.0013234689),
(f_srchphonesrchcount_i > 21.5) => -0.0984462102,
(f_srchphonesrchcount_i = NULL) => -0.0274374059, 0.0004406751);

// Tree: 175 
woFDN_FLAP___lgt_175 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 38.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -218422.5) => -0.0831226350,
   (f_addrchangevaluediff_d > -218422.5) => -0.0039984432,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 160.5) => -0.0054335107,
      (r_C13_Curr_Addr_LRes_d > 160.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1358362573) => 
            map(
            (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.2112095303,
            (k_nap_fname_verd_d > 0.5) => 0.0025825038,
            (k_nap_fname_verd_d = NULL) => 0.0584746250, 0.0584746250),
         (f_add_curr_nhood_BUS_pct_i > 0.1358362573) => 0.3585640355,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0121588513, 0.0779907792),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0096824275, 0.0096824275), -0.0014435050),
(f_srchaddrsrchcount_i > 38.5) => -0.0955462786,
(f_srchaddrsrchcount_i = NULL) => 0.0067516747, -0.0017242909);

// Tree: 176 
woFDN_FLAP___lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 25.45) => 0.0007711284,
      (c_hval_40k_p > 25.45) => 0.1122748986,
      (c_hval_40k_p = NULL) => 0.0020969437, 0.0020969437),
   (f_util_adl_count_n > 4.5) => 
      map(
      (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 0.1595276990,
      (r_nas_addr_verd_d > 0.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 90.5) => -0.0149049678,
         (c_many_cars > 90.5) => 0.0744897673,
         (c_many_cars = NULL) => 0.0340226863, 0.0340226863),
      (r_nas_addr_verd_d = NULL) => 0.0405051637, 0.0405051637),
   (f_util_adl_count_n = NULL) => 0.0137464206, 0.0069768028),
(c_pop_18_24_p > 11.15) => -0.0232275961,
(c_pop_18_24_p = NULL) => 0.0137807701, 0.0002601643);

// Tree: 177 
woFDN_FLAP___lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0063188384,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 120.5) => 0.0071327587,
      (c_ab_av_edu > 120.5) => 
         map(
         (NULL < c_hval_400k_p and c_hval_400k_p <= 4.05) => 0.1697269217,
         (c_hval_400k_p > 4.05) => 
            map(
            (NULL < c_ab_av_edu and c_ab_av_edu <= 129.5) => 0.1918717343,
            (c_ab_av_edu > 129.5) => 0.0292528967,
            (c_ab_av_edu = NULL) => 0.0534331487, 0.0534331487),
         (c_hval_400k_p = NULL) => 0.0849986014, 0.0849986014),
      (c_ab_av_edu = NULL) => -0.0083418578, 0.0382900310),
   (f_phone_ver_insurance_d > 3.5) => -0.0032783409,
   (f_phone_ver_insurance_d = NULL) => 0.0154138420, 0.0154138420),
(f_prevaddrageoldest_d = NULL) => -0.0110702575, 0.0014895804);

// Tree: 178 
woFDN_FLAP___lgt_178 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 24.05) => -0.0046108404,
(c_rnt1250_p > 24.05) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 132016) => 
      map(
      (NULL < c_professional and c_professional <= 0.75) => 0.2318532416,
      (c_professional > 0.75) => 0.0512081689,
      (c_professional = NULL) => 0.0919597510, 0.0919597510),
   (r_L80_Inp_AVM_AutoVal_d > 132016) => 0.0159311004,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 13.15) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 47738) => 0.0806401644,
         (f_prevaddrmedianincome_d > 47738) => -0.0240331893,
         (f_prevaddrmedianincome_d = NULL) => -0.0036626265, -0.0036626265),
      (c_hval_200k_p > 13.15) => 0.1747377953,
      (c_hval_200k_p = NULL) => 0.0148663121, 0.0148663121), 0.0259776194),
(c_rnt1250_p = NULL) => -0.0044618700, 0.0006205255);

// Tree: 179 
woFDN_FLAP___lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 185.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 194.5) => 0.0013455248,
      (f_curraddrcartheftindex_i > 194.5) => 0.1310876938,
      (f_curraddrcartheftindex_i = NULL) => 0.0019340555, 0.0019340555),
   (c_cartheft > 185.5) => -0.0381990781,
   (c_cartheft = NULL) => 0.0048561459, 0.0002075522),
(f_rel_incomeover50_count_d > 22.5) => -0.0600047134,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 229700) => 0.1004802383,
   (r_L80_Inp_AVM_AutoVal_d > 229700) => -0.0202190191,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_retail and c_retail <= 12.1) => -0.0527053210,
      (c_retail > 12.1) => 0.0596097209,
      (c_retail = NULL) => -0.0064247510, -0.0064247510), 0.0162331312), -0.0006256127);

// Tree: 180 
woFDN_FLAP___lgt_180 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.15) => -0.0194216502,
   (c_pop_45_54_p > 11.15) => 0.0058351410,
   (c_pop_45_54_p = NULL) => 0.0388451381, 0.0007657003),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 14.75) => -0.0598702036,
   (C_INC_75K_P > 14.75) => 
      map(
      (NULL < c_med_rent and c_med_rent <= 808.5) => 0.2330572196,
      (c_med_rent > 808.5) => 0.0441526728,
      (c_med_rent = NULL) => 0.1200007105, 0.1200007105),
   (C_INC_75K_P = NULL) => 0.0691676261, 0.0691676261),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 105) => -0.0591315920,
   (c_lux_prod > 105) => 0.0542341392,
   (c_lux_prod = NULL) => 0.0057872455, 0.0057872455), 0.0018298862);

// Tree: 181 
woFDN_FLAP___lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 7.15) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 850.5) => 
         map(
         (NULL < C_INC_201K_P and C_INC_201K_P <= 1.5) => 0.1848952034,
         (C_INC_201K_P > 1.5) => 0.0159379731,
         (C_INC_201K_P = NULL) => 0.0995801663, 0.0995801663),
      (c_popover18 > 850.5) => -0.0222660526,
      (c_popover18 = NULL) => 0.0006084235, 0.0006084235),
   (c_hval_200k_p > 7.15) => 
      map(
      (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 2.5) => 0.1838058555,
      (f_addrchangeecontrajindex_d > 2.5) => -0.0191992048,
      (f_addrchangeecontrajindex_d = NULL) => 0.1049312779, 0.1049312779),
   (c_hval_200k_p = NULL) => 0.0273023765, 0.0273023765),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0050956509,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0154205484, -0.0029666338);

// Tree: 182 
woFDN_FLAP___lgt_182 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0107659102,
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 857031) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 12.25) => -0.0856028729,
      (c_hh2_p > 12.25) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 54.5) => 0.0471459852,
         (c_ab_av_edu > 54.5) => 0.0074107842,
         (c_ab_av_edu = NULL) => 0.0121984278, 0.0121984278),
      (c_hh2_p = NULL) => 0.0101995428, 0.0101995428),
   (f_curraddrmedianvalue_d > 857031) => 0.1633558021,
   (f_curraddrmedianvalue_d = NULL) => 0.0116951012, 0.0116951012),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0301504279,
   (k_nap_lname_verd_d > 0.5) => -0.0865606299,
   (k_nap_lname_verd_d = NULL) => -0.0172869698, -0.0172869698), -0.0010519890);

// Tree: 183 
woFDN_FLAP___lgt_183 := map(
(NULL < c_transport and c_transport <= 26.65) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 38.5) => -0.0063753577,
   (f_srchaddrsrchcount_i > 38.5) => -0.0848458728,
   (f_srchaddrsrchcount_i = NULL) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.95) => -0.0716820986,
      (c_pop_75_84_p > 2.95) => 0.0276690202,
      (c_pop_75_84_p = NULL) => -0.0180640345, -0.0180640345), -0.0068971711),
(c_transport > 26.65) => 
   map(
   (NULL < c_totsales and c_totsales <= 592.5) => -0.0543455181,
   (c_totsales > 592.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1590976507,
      (r_C12_Num_NonDerogs_d > 3.5) => 0.0165470427,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0937291398, 0.0937291398),
   (c_totsales = NULL) => 0.0546700765, 0.0546700765),
(c_transport = NULL) => 0.0144662694, -0.0051843874);

// Tree: 184 
woFDN_FLAP___lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < c_robbery and c_robbery <= 13) => -0.0401752872,
   (c_robbery > 13) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
         map(
         (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 0.0072586385,
         (k_inq_adls_per_addr_i > 3.5) => -0.0433248004,
         (k_inq_adls_per_addr_i = NULL) => 0.0062771963, 0.0062771963),
      (f_phones_per_addr_curr_i > 50.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 0.0001072725,
         (f_rel_under25miles_cnt_d > 4.5) => 0.1407943575,
         (f_rel_under25miles_cnt_d = NULL) => 0.0591611106, 0.0591611106),
      (f_phones_per_addr_curr_i = NULL) => -0.0003037304, 0.0070041436),
   (c_robbery = NULL) => 0.0029390652, 0.0029390652),
(C_RENTOCC_P > 92.2) => -0.0923756010,
(C_RENTOCC_P = NULL) => 0.0164306014, 0.0025102094);

// Tree: 185 
woFDN_FLAP___lgt_185 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 5.15) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 109.5) => -0.0204379799,
      (f_curraddrmurderindex_i > 109.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.1265772500,
         (r_C12_Num_NonDerogs_d > 3.5) => 0.0097320592,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0826504865, 0.0826504865),
      (f_curraddrmurderindex_i = NULL) => 0.0387877913, 0.0387877913),
   (c_high_ed > 5.15) => 0.0061304956,
   (c_high_ed = NULL) => -0.0051094736, 0.0072068252),
(r_D31_ALL_Bk_i > 1.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => -0.0269822931,
   (f_inq_Communications_count24_i > 0.5) => -0.1045752459,
   (f_inq_Communications_count24_i = NULL) => -0.0324658940, -0.0324658940),
(r_D31_ALL_Bk_i = NULL) => 0.0057449681, 0.0036495205);

// Tree: 186 
woFDN_FLAP___lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3923820453) => 
      map(
      (NULL < c_white_col and c_white_col <= 20.45) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 0.75) => 0.1374599615,
         (c_pop_75_84_p > 0.75) => 0.0311087646,
         (c_pop_75_84_p = NULL) => 0.0408945518, 0.0408945518),
      (c_white_col > 20.45) => 0.0031801082,
      (c_white_col = NULL) => -0.0355428286, 0.0048818883),
   (f_add_input_mobility_index_i > 0.3923820453) => -0.0257666262,
   (f_add_input_mobility_index_i = NULL) => -0.0293438911, 0.0001462650),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0792993353,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 36.3) => 0.0517241273,
   (c_med_age > 36.3) => -0.0491239919,
   (c_med_age = NULL) => 0.0029008315, 0.0029008315), 0.0005287062);

// Tree: 187 
woFDN_FLAP___lgt_187 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 80.45) => -0.0041762379,
      (c_high_hval > 80.45) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0008545079,
         (k_inf_nothing_found_i > 0.5) => 
            map(
            (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 3.5) => 0.1877742825,
            (f_rel_ageover40_count_d > 3.5) => 0.0311388470,
            (f_rel_ageover40_count_d = NULL) => 0.1205457991, 0.1205457991),
         (k_inf_nothing_found_i = NULL) => 0.0426912544, 0.0426912544),
      (c_high_hval = NULL) => -0.0109074150, -0.0018575940),
   (f_rel_bankrupt_count_i > 7.5) => -0.0792142941,
   (f_rel_bankrupt_count_i = NULL) => 0.0086739354, -0.0026994383),
(r_L72_Add_Vacant_i > 0.5) => 0.0865263024,
(r_L72_Add_Vacant_i = NULL) => -0.0021081664, -0.0021081664);

// Tree: 188 
woFDN_FLAP___lgt_188 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 11.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0014862119,
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_totsales and c_totsales <= 1663.5) => -0.0224491996,
      (c_totsales > 1663.5) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 27.75) => 0.0231580051,
         (c_rnt1000_p > 27.75) => 0.1301406414,
         (c_rnt1000_p = NULL) => 0.0552240372, 0.0552240372),
      (c_totsales = NULL) => 0.0296598069, 0.0296598069),
   (f_hh_collections_ct_i = NULL) => 0.0013363411, 0.0013363411),
(r_L79_adls_per_addr_curr_i > 11.5) => -0.0611892145,
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 1.9) => 0.0459766693,
   (c_hval_100k_p > 1.9) => -0.0448668782,
   (c_hval_100k_p = NULL) => 0.0044890650, 0.0044890650), 0.0007178040);

// Tree: 189 
woFDN_FLAP___lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0044477967,
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 45.5) => 0.1832941533,
      (f_fp_prevaddrburglaryindex_i > 45.5) => -0.0350986899,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0721820050, 0.0721820050),
   (f_rel_homeover500_count_d = NULL) => 0.0134329554, -0.0034268031),
(f_phones_per_addr_curr_i > 44.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.54491947855) => -0.0494044671,
      (f_add_curr_nhood_MFD_pct_i > 0.54491947855) => 0.0334912838,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0120640388, -0.0120640388),
   (f_rel_under25miles_cnt_d > 5.5) => 0.1271936984,
   (f_rel_under25miles_cnt_d = NULL) => 0.0395129009, 0.0395129009),
(f_phones_per_addr_curr_i = NULL) => -0.0105054049, -0.0028430893);

// Tree: 190 
woFDN_FLAP___lgt_190 := map(
(NULL < c_hh2_p and c_hh2_p <= 51.15) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -281708.5) => -0.0845347464,
   (f_addrchangevaluediff_d > -281708.5) => -0.0051684523,
   (f_addrchangevaluediff_d = NULL) => -0.0127503184, -0.0071986236),
(c_hh2_p > 51.15) => 
   map(
   (NULL < f_hh_college_attendees_d and f_hh_college_attendees_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 0.5) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 41.5) => 0.0072827201,
         (c_rnt750_p > 41.5) => 0.2530635164,
         (c_rnt750_p = NULL) => 0.0588879407, 0.0588879407),
      (k_inq_per_phone_i > 0.5) => 0.1977431807,
      (k_inq_per_phone_i = NULL) => 0.0934161154, 0.0934161154),
   (f_hh_college_attendees_d > 0.5) => -0.0730827499,
   (f_hh_college_attendees_d = NULL) => 0.0517079828, 0.0517079828),
(c_hh2_p = NULL) => -0.0226125093, -0.0052188243);

// Tree: 191 
woFDN_FLAP___lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => -0.0053874879,
(c_totcrime > 163.5) => 
   map(
   (NULL < f_util_add_input_misc_n and f_util_add_input_misc_n <= 0.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 119.5) => 0.0990201669,
      (c_no_car > 119.5) => -0.0231909777,
      (c_no_car = NULL) => 0.0110822584, 0.0110822584),
   (f_util_add_input_misc_n > 0.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 33.2) => 0.0407021865,
      (c_low_hval > 33.2) => 
         map(
         (NULL < c_blue_col and c_blue_col <= 16.35) => 0.0692881683,
         (c_blue_col > 16.35) => 0.3078390761,
         (c_blue_col = NULL) => 0.1762247821, 0.1762247821),
      (c_low_hval = NULL) => 0.0709924005, 0.0709924005),
   (f_util_add_input_misc_n = NULL) => 0.0344256246, 0.0344256246),
(c_totcrime = NULL) => -0.0317324790, -0.0018070887);

// Tree: 192 
woFDN_FLAP___lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 94.5) => 0.0848120860,
(r_D32_Mos_Since_Fel_LS_d > 94.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 165.5) => 0.0000544368,
   (c_unempl > 165.5) => 
      map(
      (NULL < c_rental and c_rental <= 190.5) => 
         map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0360897259,
         (r_D33_eviction_count_i > 0.5) => -0.1141898319,
         (r_D33_eviction_count_i = NULL) => -0.0414793192, -0.0414793192),
      (c_rental > 190.5) => 0.0660028938,
      (c_rental = NULL) => -0.0336056222, -0.0336056222),
   (c_unempl = NULL) => 0.0014584154, -0.0022357659),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0309739867,
   (c_high_hval > 3.7) => 0.0691250262,
   (c_high_hval = NULL) => 0.0130695789, 0.0130695789), -0.0017068408);

// Tree: 193 
woFDN_FLAP___lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0086383316,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2009243126,
   (f_adl_per_email_i > 0.5) => -0.0377738969,
   (f_adl_per_email_i = NULL) => 
      map(
      (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 230.5) => 0.1269538016,
      (f_mos_liens_unrel_OT_fseen_d > 230.5) => 
         map(
         (NULL < c_rnt2001_p and c_rnt2001_p <= 48.3) => 
            map(
            (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 9.5) => -0.0096787459,
            (r_P88_Phn_Dst_to_Inp_Add_i > 9.5) => 0.0838603543,
            (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0171072740, 0.0011053479),
         (c_rnt2001_p > 48.3) => 0.1532907874,
         (c_rnt2001_p = NULL) => 0.0058402536, 0.0058402536),
      (f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0102062186, 0.0102062186), 0.0133171075),
(f_prevaddrageoldest_d = NULL) => -0.0176100842, -0.0035635981);

// Tree: 194 
woFDN_FLAP___lgt_194 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 335.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.8657834043) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.74257692535) => 0.0044505797,
      (f_add_input_nhood_MFD_pct_i > 0.74257692535) => 0.0706521822,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0082247058, 0.0082247058),
   (f_add_input_nhood_MFD_pct_i > 0.8657834043) => -0.0448792099,
   (f_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
         map(
         (NULL < c_food and c_food <= 68.8) => -0.0183247185,
         (c_food > 68.8) => 0.1661832985,
         (c_food = NULL) => -0.0135685035, -0.0113922625),
      (f_srchaddrsrchcount_i > 14.5) => 0.1031659784,
      (f_srchaddrsrchcount_i = NULL) => -0.0077197646, -0.0077197646), 0.0019536103),
(f_M_Bureau_ADL_FS_noTU_d > 335.5) => -0.0292856690,
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0071463280, -0.0035034814);

// Tree: 195 
woFDN_FLAP___lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 35.65) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 2.15) => -0.0552255156,
   (c_pop_18_24_p > 2.15) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -48.5) => 0.0601936618,
      (f_addrchangecrimediff_i > -48.5) => 0.0047503584,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0264097672,
         (f_srchaddrsrchcount_i > 1.5) => 
            map(
            (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0559048303,
            (f_varrisktype_i > 3.5) => -0.0621687102,
            (f_varrisktype_i = NULL) => 0.0434631969, 0.0434631969),
         (f_srchaddrsrchcount_i = NULL) => 0.0107713793, 0.0025587538), 0.0052137669),
   (c_pop_18_24_p = NULL) => 0.0025090830, 0.0025090830),
(c_hval_80k_p > 35.65) => -0.0820890896,
(c_hval_80k_p = NULL) => 0.0217258613, 0.0017691720);

// Tree: 196 
woFDN_FLAP___lgt_196 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0830380706,
   (f_mos_inq_banko_am_lseen_d > 43.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 44.35) => 
         map(
         (NULL < c_white_col and c_white_col <= 13.45) => 0.0852533144,
         (c_white_col > 13.45) => 0.0002282612,
         (c_white_col = NULL) => 0.0008997613, 0.0008997613),
      (c_hval_60k_p > 44.35) => -0.1147276163,
      (c_hval_60k_p = NULL) => 0.0236808809, 0.0008924162),
   (f_mos_inq_banko_am_lseen_d = NULL) => -0.0012489469, -0.0012489469),
(r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0732479623,
(r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 0.85) => -0.0491004190,
   (c_hval_150k_p > 0.85) => 0.0411443420,
   (c_hval_150k_p = NULL) => -0.0008874645, -0.0008874645), -0.0026631673);

// Tree: 197 
woFDN_FLAP___lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62436.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 454824.5) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 2.5) => 0.0363926725,
      (r_C14_addrs_5yr_i > 2.5) => 0.1757925931,
      (r_C14_addrs_5yr_i = NULL) => 0.0808820088, 0.0808820088),
   (f_prevaddrmedianvalue_d > 454824.5) => -0.0404619233,
   (f_prevaddrmedianvalue_d = NULL) => 0.0382024189, 0.0382024189),
(f_addrchangevaluediff_d > -62436.5) => -0.0009299709,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 55.85) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 11.5) => -0.0045884489,
      (f_inq_count_i > 11.5) => 0.0989823241,
      (f_inq_count_i = NULL) => 0.0023387202, -0.0000378856),
   (c_lowinc > 55.85) => -0.0585997039,
   (c_lowinc = NULL) => -0.0075499899, -0.0045730226), -0.0008693504);

// Tree: 198 
woFDN_FLAP___lgt_198 := map(
(NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 39.25) => 0.0046877178,
   (c_famotf18_p > 39.25) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 4.65) => -0.0434599820,
         (C_INC_125K_P > 4.65) => 0.1031368746,
         (C_INC_125K_P = NULL) => -0.0012400873, -0.0012400873),
      (f_rel_incomeover50_count_d > 3.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => -0.0246212243,
         (r_D30_Derog_Count_i > 0.5) => -0.1425818958,
         (r_D30_Derog_Count_i = NULL) => -0.0801321285, -0.0801321285),
      (f_rel_incomeover50_count_d = NULL) => -0.0311916563, -0.0311916563),
   (c_famotf18_p = NULL) => -0.0427493482, 0.0024848214),
(f_liens_unrel_SC_total_amt_i > 5693) => 0.1069852287,
(f_liens_unrel_SC_total_amt_i = NULL) => 0.0143937429, 0.0031455840);

// Tree: 199 
woFDN_FLAP___lgt_199 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 55.85) => 0.0002866284,
      (c_lowinc > 55.85) => -0.0350516338,
      (c_lowinc = NULL) => -0.0016196818, -0.0016196818),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 34.4) => -0.0238013784,
      (c_med_age > 34.4) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 65052.5) => 0.1470199600,
         (f_prevaddrmedianincome_d > 65052.5) => 0.0164906753,
         (f_prevaddrmedianincome_d = NULL) => 0.0902680971, 0.0902680971),
      (c_med_age = NULL) => 0.0446403069, 0.0446403069),
   (k_nap_contradictory_i = NULL) => -0.0008493083, -0.0008493083),
(C_INC_25K_P > 27.65) => 0.0781717554,
(C_INC_25K_P = NULL) => -0.0422237795, -0.0012277257);

// Tree: 200 
woFDN_FLAP___lgt_200 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 9.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 109.5) => 
      map(
      (NULL < c_food and c_food <= 68.85) => -0.0049705829,
      (c_food > 68.85) => 0.0654027903,
      (c_food = NULL) => -0.0028776672, -0.0028776672),
   (f_addrchangecrimediff_i > 109.5) => 0.0715856468,
   (f_addrchangecrimediff_i = NULL) => -0.0087479905, -0.0038610864),
(f_inq_HighRiskCredit_count_i > 9.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 40.5) => -0.0016144883,
   (k_comb_age_d > 40.5) => -0.1204301628,
   (k_comb_age_d = NULL) => -0.0538524141, -0.0538524141),
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 580.5) => 0.0695564973,
   (c_hh00 > 580.5) => -0.0434848006,
   (c_hh00 = NULL) => 0.0065334728, 0.0065334728), -0.0042059771);

// Tree: 201 
woFDN_FLAP___lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 121.5) => -0.0193831230,
   (r_A50_pb_average_dollars_d > 121.5) => 
      map(
      (NULL < c_relig_indx and c_relig_indx <= 177.5) => 0.0135632259,
      (c_relig_indx > 177.5) => -0.0480169417,
      (c_relig_indx = NULL) => 0.0775686996, 0.0074476239),
   (r_A50_pb_average_dollars_d = NULL) => -0.0322889315, -0.0071133817),
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.55) => 0.0027500987,
   (c_finance > 5.55) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 24.85) => 0.1752254945,
      (c_hh1_p > 24.85) => 0.0466718703,
      (c_hh1_p = NULL) => 0.0956646196, 0.0956646196),
   (c_finance = NULL) => 0.0893342486, 0.0376996588),
(r_L70_Add_Standardized_i = NULL) => -0.0033898543, -0.0033898543);

// Tree: 202 
woFDN_FLAP___lgt_202 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 47.5) => -0.0753339479,
(f_mos_inq_banko_am_lseen_d > 47.5) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 182.5) => -0.0013167309,
   (c_rich_nfam > 182.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 7.55) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9622917995) => 0.0555160606,
         (f_add_curr_nhood_SFD_pct_d > 0.9622917995) => 0.3363227669,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0983937313, 0.0983937313),
      (C_INC_125K_P > 7.55) => 0.0134966973,
      (C_INC_125K_P = NULL) => 0.0352751991, 0.0352751991),
   (c_rich_nfam = NULL) => 0.0137116356, 0.0029326926),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0406979878,
   (r_Phn_Cell_n > 0.5) => -0.0652510430,
   (r_Phn_Cell_n = NULL) => 0.0013250372, 0.0013250372), 0.0003657194);

// Tree: 203 
woFDN_FLAP___lgt_203 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => -0.0042580041,
(r_C13_Curr_Addr_LRes_d > 310.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 40.3) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 7.35) => 0.1633075375,
      (C_INC_100K_P > 7.35) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => -0.0066593279,
         (f_inq_Collection_count_i > 3.5) => 0.1465468870,
         (f_inq_Collection_count_i = NULL) => 0.0069126026, 0.0069126026),
      (C_INC_100K_P = NULL) => 0.0198640581, 0.0198640581),
   (c_hval_750k_p > 40.3) => 0.1668368331,
   (c_hval_750k_p = NULL) => 0.0341674734, 0.0341674734),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 114) => -0.0314320221,
   (c_totcrime > 114) => 0.0552720761,
   (c_totcrime = NULL) => 0.0006107968, 0.0006107968), -0.0020132611);

// Tree: 204 
woFDN_FLAP___lgt_204 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 90.75) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 180.5) => 0.0058833314,
   (c_for_sale > 180.5) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 12.25) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0468683970,
         (f_varrisktype_i > 3.5) => -0.1240034651,
         (f_varrisktype_i = NULL) => -0.0517391533, -0.0517391533),
      (c_pop_18_24_p > 12.25) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 14) => -0.0444128174,
         (c_famotf18_p > 14) => 0.1221953303,
         (c_famotf18_p = NULL) => 0.0461803629, 0.0461803629),
      (c_pop_18_24_p = NULL) => -0.0366164481, -0.0366164481),
   (c_for_sale = NULL) => 0.0022969690, 0.0022969690),
(C_RENTOCC_P > 90.75) => -0.0852828221,
(C_RENTOCC_P = NULL) => -0.0143214446, 0.0010520019);

// Tree: 205 
woFDN_FLAP___lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5132.5) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0132222373,
   (r_Phn_Cell_n > 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 44.5) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 2.65) => 0.1128967868,
         (c_pop_65_74_p > 2.65) => 0.0075783868,
         (c_pop_65_74_p = NULL) => 0.0229462758, 0.0229462758),
      (f_mos_inq_banko_cm_lseen_d > 44.5) => -0.0215470474,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0138884838, -0.0138884838),
   (r_Phn_Cell_n = NULL) => 0.0003579003, 0.0003579003),
(f_liens_unrel_ST_total_amt_i > 5132.5) => 0.1310128099,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.45) => -0.0453637851,
   (c_pop_75_84_p > 3.45) => 0.0469973949,
   (c_pop_75_84_p = NULL) => 0.0026349384, 0.0026349384), 0.0009925235);

// Tree: 206 
woFDN_FLAP___lgt_206 := map(
(NULL < f_liens_rel_OT_total_amt_i and f_liens_rel_OT_total_amt_i <= 1374) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 0.6) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 80) => 0.0918841399,
         (c_rest_indx > 80) => -0.0304638267,
         (c_rest_indx = NULL) => 0.0021622977, 0.0021622977),
      (c_hval_20k_p > 0.6) => 0.1501350173,
      (c_hval_20k_p = NULL) => 0.0351761316, 0.0351761316),
   (r_C10_M_Hdr_FS_d > 10.5) => -0.0046997430,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0038789206, -0.0038789206),
(f_liens_rel_OT_total_amt_i > 1374) => -0.0911842952,
(f_liens_rel_OT_total_amt_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 133.5) => 0.0419434207,
   (c_span_lang > 133.5) => -0.0615740032,
   (c_span_lang = NULL) => -0.0021919151, -0.0021919151), -0.0048216003);

// Tree: 207 
woFDN_FLAP___lgt_207 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 
   map(
   (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 2.5) => 0.0379287718,
   (f_rel_educationover12_count_d > 2.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 2.15) => -0.1078343181,
      (c_pop_65_74_p > 2.15) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01273588345) => 
            map(
            (NULL < c_med_hhinc and c_med_hhinc <= 59820) => 0.0743468766,
            (c_med_hhinc > 59820) => -0.0510527527,
            (c_med_hhinc = NULL) => 0.0138306376, 0.0138306376),
         (f_add_curr_nhood_VAC_pct_i > 0.01273588345) => -0.0526297996,
         (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0258591626, -0.0258591626),
      (c_pop_65_74_p = NULL) => -0.0395444974, -0.0395444974),
   (f_rel_educationover12_count_d = NULL) => -0.0249346644, -0.0249346644),
(r_F01_inp_addr_address_score_d > 75) => 0.0016837601,
(r_F01_inp_addr_address_score_d = NULL) => -0.0056247835, -0.0000333399);

// Tree: 208 
woFDN_FLAP___lgt_208 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 0.5) => -0.0023612245,
   (f_srchphonesrchcountmo_i > 0.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 161245) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 9.9) => 0.1877687579,
         (C_INC_35K_P > 9.9) => 0.0217617455,
         (C_INC_35K_P = NULL) => 0.0964005573, 0.0964005573),
      (f_curraddrmedianvalue_d > 161245) => 0.0036344562,
      (f_curraddrmedianvalue_d = NULL) => 0.0360668206, 0.0360668206),
   (f_srchphonesrchcountmo_i = NULL) => -0.0011631392, -0.0011631392),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0783021877,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 11.45) => 0.0475749221,
   (c_lowrent > 11.45) => -0.0513670263,
   (c_lowrent = NULL) => 0.0089257235, 0.0089257235), -0.0013896672);

// Tree: 209 
woFDN_FLAP___lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.65) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 9.45) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.178974359) => 
         map(
         (NULL < c_pop_0_5_p and c_pop_0_5_p <= 14.55) => 
            map(
            (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 14.5) => 0.0906056674,
            (f_mos_inq_banko_cm_lseen_d > 14.5) => -0.0075595503,
            (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0021995649, 0.0021995649),
         (c_pop_0_5_p > 14.55) => 0.1121667829,
         (c_pop_0_5_p = NULL) => 0.0177007482, 0.0177007482),
      (f_add_input_nhood_BUS_pct_i > 0.178974359) => -0.0358490825,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0108135590, 0.0108135590),
   (c_femdiv_p > 9.45) => 0.1530358164,
   (c_femdiv_p = NULL) => 0.0213890602, 0.0213890602),
(c_hh2_p > 17.65) => 0.0000153851,
(c_hh2_p = NULL) => 0.0058991875, 0.0014637008);

// Tree: 210 
woFDN_FLAP___lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0001519813,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0595161031) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.04134465485) => 
         map(
         (NULL < c_professional and c_professional <= 1.65) => 0.0193087482,
         (c_professional > 1.65) => -0.0581054491,
         (c_professional = NULL) => -0.0329981418, -0.0329981418),
      (f_add_input_nhood_VAC_pct_i > 0.04134465485) => 0.0891468892,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0167121377, -0.0167121377),
   (f_add_input_nhood_VAC_pct_i > 0.0595161031) => -0.0825848871,
   (f_add_input_nhood_VAC_pct_i = NULL) => -0.0336508447, -0.0336508447),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 85) => 0.0621822926,
   (c_born_usa > 85) => -0.0476142731,
   (c_born_usa = NULL) => 0.0082144891, 0.0082144891), -0.0011593201);

// Tree: 211 
woFDN_FLAP___lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0035836726,
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.228134107) => 
      map(
      (NULL < c_retail and c_retail <= 10.1) => 0.0160150013,
      (c_retail > 10.1) => 0.2056098151,
      (c_retail = NULL) => 0.0984475291, 0.0984475291),
   (f_add_curr_mobility_index_i > 0.228134107) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 1.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 24.95) => 0.0040303361,
         (c_famotf18_p > 24.95) => 0.1005367164,
         (c_famotf18_p = NULL) => 0.0250790528, 0.0250790528),
      (f_inq_QuizProvider_count_i > 1.5) => -0.0649649798,
      (f_inq_QuizProvider_count_i = NULL) => 0.0072485513, 0.0072485513),
   (f_add_curr_mobility_index_i = NULL) => 0.0323391791, 0.0323391791),
(f_srchaddrsrchcount_i = NULL) => -0.0057561931, -0.0024162697);

// Tree: 212 
woFDN_FLAP___lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0047953418) => -0.0358536645,
   (f_add_curr_nhood_BUS_pct_i > 0.0047953418) => 
      map(
      (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 9.5) => 0.0006934841,
      (f_rel_ageover40_count_d > 9.5) => 0.0473774780,
      (f_rel_ageover40_count_d = NULL) => 0.0108231010, 0.0038495605),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0177236743, -0.0013683629),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9259030225) => 
      map(
      (NULL < c_work_home and c_work_home <= 91.5) => 0.0611756001,
      (c_work_home > 91.5) => -0.0728321630,
      (c_work_home = NULL) => 0.0040405073, 0.0040405073),
   (f_add_curr_nhood_SFD_pct_d > 0.9259030225) => 0.1379411684,
   (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0430335570, 0.0430335570),
(f_srchaddrsrchcount_i = NULL) => -0.0056022920, -0.0007773603);

// Tree: 213 
woFDN_FLAP___lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125511) => 
   map(
   (NULL < c_families and c_families <= 1369) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 176.5) => 
         map(
         (NULL < c_retired and c_retired <= 4.75) => 
            map(
            (NULL < c_food and c_food <= 23.1) => 0.1971622114,
            (c_food > 23.1) => -0.0370579994,
            (c_food = NULL) => 0.0975513171, 0.0975513171),
         (c_retired > 4.75) => -0.0005535618,
         (c_retired = NULL) => 0.0092795309, 0.0092795309),
      (c_sub_bus > 176.5) => 0.0928405038,
      (c_sub_bus = NULL) => 0.0148083097, 0.0148083097),
   (c_families > 1369) => 0.2024879757,
   (c_families = NULL) => 0.0211488389, 0.0211488389),
(r_A46_Curr_AVM_AutoVal_d > 125511) => -0.0064492686,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0034715074, 0.0020567878);

// Tree: 214 
woFDN_FLAP___lgt_214 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 6.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 76.5) => 0.2246466515,
   (c_totcrime > 76.5) => -0.0123970872,
   (c_totcrime = NULL) => 0.0894101596, 0.0894101596),
(r_D32_Mos_Since_Crim_LS_d > 6.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 59128.5) => -0.0373233767,
   (r_L80_Inp_AVM_AutoVal_d > 59128.5) => 0.0051522846,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 1.5) => 0.0036279006,
      (f_inq_PrepaidCards_count_i > 1.5) => 0.0931575305,
      (f_inq_PrepaidCards_count_i = NULL) => 0.0049644131, 0.0049644131), 0.0033218937),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.65) => 0.0381012517,
   (c_pop_65_74_p > 6.65) => -0.0664672935,
   (c_pop_65_74_p = NULL) => -0.0058351118, -0.0058351118), 0.0042766561);

// Tree: 215 
woFDN_FLAP___lgt_215 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125594) => 
   map(
   (NULL < c_families and c_families <= 1371) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 2.5) => 0.0098526774,
      (f_crim_rel_under25miles_cnt_i > 2.5) => 
         map(
         (NULL < c_med_rent and c_med_rent <= 446.5) => -0.0851186166,
         (c_med_rent > 446.5) => 
            map(
            (NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 0.1620774549,
            (r_A41_Prop_Owner_Inp_Only_d > 0.5) => 0.0556838855,
            (r_A41_Prop_Owner_Inp_Only_d = NULL) => 0.0858096632, 0.0858096632),
         (c_med_rent = NULL) => 0.0507474520, 0.0507474520),
      (f_crim_rel_under25miles_cnt_i = NULL) => 0.0174313817, 0.0174313817),
   (c_families > 1371) => 0.2024180073,
   (c_families = NULL) => 0.0225098147, 0.0225098147),
(r_A46_Curr_AVM_AutoVal_d > 125594) => -0.0021061955,
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0038138614, 0.0009858721);

// Tree: 216 
woFDN_FLAP___lgt_216 := map(
(NULL < c_asian_lang and c_asian_lang <= 181.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0018289045,
   (r_L79_adls_per_addr_c6_i > 4.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0756294472) => 
         map(
         (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 0.1097068186,
         (r_F03_address_match_d > 3) => 
            map(
            (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1207389559,
            (r_Phn_Cell_n > 0.5) => -0.0306329216,
            (r_Phn_Cell_n = NULL) => 0.0356898082, 0.0356898082),
         (r_F03_address_match_d = NULL) => 0.0642659958, 0.0642659958),
      (f_add_input_nhood_BUS_pct_i > 0.0756294472) => -0.0294816894,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0320582021, 0.0320582021),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0032407673, 0.0032407673),
(c_asian_lang > 181.5) => -0.0269438257,
(c_asian_lang = NULL) => 0.0167244812, -0.0007666673);

// Tree: 217 
woFDN_FLAP___lgt_217 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 13.55) => -0.0090313874,
(C_INC_50K_P > 13.55) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0050050228,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 18.4) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 65) => 0.2931750982,
         (f_curraddrburglaryindex_i > 65) => 0.0784674060,
         (f_curraddrburglaryindex_i = NULL) => 0.1566823510, 0.1566823510),
      (C_RENTOCC_P > 18.4) => 
         map(
         (NULL < c_no_move and c_no_move <= 134) => -0.0103631861,
         (c_no_move > 134) => 0.0971839407,
         (c_no_move = NULL) => 0.0078995336, 0.0078995336),
      (C_RENTOCC_P = NULL) => 0.0454232424, 0.0454232424),
   (k_inq_per_addr_i = NULL) => 0.0096151879, 0.0096151879),
(C_INC_50K_P = NULL) => 0.0170986193, -0.0011473884);

// Tree: 218 
woFDN_FLAP___lgt_218 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0029804572,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 163.5) => 
      map(
      (NULL < c_med_hhinc and c_med_hhinc <= 84757.5) => -0.0088289773,
      (c_med_hhinc > 84757.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1890161446,
         (f_phone_ver_experian_d > 0.5) => 0.0697272534,
         (f_phone_ver_experian_d = NULL) => 0.1222143655, 0.1222143655),
      (c_med_hhinc = NULL) => 0.0223480012, 0.0223480012),
   (c_totcrime > 163.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.35) => 0.0620622248,
      (c_hval_150k_p > 4.35) => 0.2710429151,
      (c_hval_150k_p = NULL) => 0.1313174535, 0.1313174535),
   (c_totcrime = NULL) => -0.0039005556, 0.0380983566),
(r_L70_Add_Standardized_i = NULL) => 0.0004036469, 0.0004036469);

// Tree: 219 
woFDN_FLAP___lgt_219 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 12.5) => 
         map(
         (NULL < f_divrisktype_i and f_divrisktype_i <= 3.5) => 0.0028839144,
         (f_divrisktype_i > 3.5) => -0.0527094403,
         (f_divrisktype_i = NULL) => 0.0020227915, 0.0020227915),
      (r_L79_adls_per_addr_curr_i > 12.5) => 0.0794251251,
      (r_L79_adls_per_addr_curr_i = NULL) => 
         map(
         (NULL < c_finance and c_finance <= 2.55) => 0.0520977628,
         (c_finance > 2.55) => -0.0628431932,
         (c_finance = NULL) => -0.0048977526, -0.0048977526), 0.0026186603),
   (k_inq_adls_per_phone_i > 2.5) => -0.0680176889,
   (k_inq_adls_per_phone_i = NULL) => 0.0020630099, 0.0020630099),
(c_femdiv_p > 15.45) => 0.1133157074,
(c_femdiv_p = NULL) => 0.0036593806, 0.0027126794);

// Tree: 220 
woFDN_FLAP___lgt_220 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 4.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 120.5) => -0.0648949513,
      (c_sub_bus > 120.5) => 0.0993293273,
      (c_sub_bus = NULL) => 0.0125693310, 0.0125693310),
   (r_C14_Addr_Stability_v2_d > 2.5) => -0.0744829364,
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0501263434, -0.0501263434),
(f_mos_inq_banko_cm_lseen_d > 4.5) => 
   map(
   (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0030081158,
   (f_srchunvrfddobcount_i > 0.5) => 0.0431189453,
   (f_srchunvrfddobcount_i = NULL) => -0.0014680120, -0.0014680120),
(f_mos_inq_banko_cm_lseen_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 128.5) => -0.0310928291,
   (c_no_car > 128.5) => 0.0632232787,
   (c_no_car = NULL) => 0.0063752137, 0.0063752137), -0.0028441736);

// Tree: 221 
woFDN_FLAP___lgt_221 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 198.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 14.05) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 19.5) => 0.1122606542,
      (f_mos_liens_unrel_CJ_fseen_d > 19.5) => 0.0035908196,
      (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0042192717, 0.0042192717),
   (C_INC_25K_P > 14.05) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 191.5) => -0.0171554400,
         (c_sub_bus > 191.5) => 0.1168584286,
         (c_sub_bus = NULL) => -0.0071156805, -0.0071156805),
      (r_I60_Inq_Count12_i > 0.5) => -0.0612668751,
      (r_I60_Inq_Count12_i = NULL) => -0.0262087720, -0.0262087720),
   (C_INC_25K_P = NULL) => 0.0064674427, -0.0002109013),
(f_curraddrburglaryindex_i > 198.5) => 0.0985924669,
(f_curraddrburglaryindex_i = NULL) => -0.0234594564, -0.0000258067);

// Tree: 222 
woFDN_FLAP___lgt_222 := map(
(NULL < c_med_age and c_med_age <= 30.45) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 9999.5) => -0.0846186442,
   (k_estimated_income_d > 9999.5) => -0.0173856253,
   (k_estimated_income_d = NULL) => -0.0208171028, -0.0208171028),
(c_med_age > 30.45) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 55.5) => -0.0009362358,
   (f_addrchangecrimediff_i > 55.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 105.5) => 0.0155316252,
      (c_lar_fam > 105.5) => 0.1782553088,
      (c_lar_fam = NULL) => 0.0671744709, 0.0671744709),
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 36.95) => -0.0033773378,
      (c_trailer_p > 36.95) => 0.1334051736,
      (c_trailer_p = NULL) => 0.0019949674, 0.0019949674), 0.0007502375),
(c_med_age = NULL) => 0.0160066583, -0.0017798266);

// Tree: 223 
woFDN_FLAP___lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => -0.0508597371,
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 0.0025440428,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => -0.0111073571,
   (f_rel_under25miles_cnt_d > 5.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 18.95) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 10.05) => 0.0480645214,
         (c_newhouse > 10.05) => -0.0113010502,
         (c_newhouse = NULL) => 0.0144865655, 0.0144865655),
      (C_INC_25K_P > 18.95) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 2.5) => -0.0098824402,
         (f_phones_per_addr_curr_i > 2.5) => 0.1578543763,
         (f_phones_per_addr_curr_i = NULL) => 0.0846022222, 0.0846022222),
      (C_INC_25K_P = NULL) => -0.0069761624, 0.0185696445),
   (f_rel_under25miles_cnt_d = NULL) => -0.0098886679, 0.0003602128), 0.0001813923);

// Tree: 224 
woFDN_FLAP___lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 7.9) => -0.0537174110,
      (c_famotf18_p > 7.9) => 
         map(
         (NULL < c_young and c_young <= 31.9) => 0.1309241928,
         (c_young > 31.9) => -0.0203500995,
         (c_young = NULL) => 0.0621631508, 0.0621631508),
      (c_famotf18_p = NULL) => 0.0109874712, 0.0109874712),
   (c_hval_20k_p > 0.65) => 0.1692750670,
   (c_hval_20k_p = NULL) => 0.0440435153, 0.0440435153),
(r_C10_M_Hdr_FS_d > 10.5) => 0.0018031131,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 91.5) => -0.0227250807,
   (c_serv_empl > 91.5) => 0.0712877509,
   (c_serv_empl = NULL) => 0.0191461804, 0.0191461804), 0.0028430640);

// Tree: 225 
woFDN_FLAP___lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 65039) => -0.0225802648,
(r_A46_Curr_AVM_AutoVal_d > 65039) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 42.5) => -0.0010310762,
   (r_P88_Phn_Dst_to_Inp_Add_i > 42.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 3.55) => 0.2246175994,
      (c_incollege > 3.55) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 18.1) => -0.0422144508,
         (c_lowrent > 18.1) => 0.1633244518,
         (c_lowrent = NULL) => 0.0094049083, 0.0094049083),
      (c_incollege = NULL) => 0.0526045361, 0.0526045361),
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_rape and c_rape <= 121.5) => 0.0532365977,
      (c_rape > 121.5) => -0.0331749655,
      (c_rape = NULL) => 0.0363554219, 0.0363554219), 0.0102706281),
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0057672869, 0.0016251432);

// Tree: 226 
woFDN_FLAP___lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => -0.0855770478,
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 17.15) => -0.0239704992,
      (C_INC_75K_P > 17.15) => 0.1122616410,
      (C_INC_75K_P = NULL) => 0.0435826282, 0.0435826282),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 5.5) => -0.0031771273,
      (f_inq_HighRiskCredit_count24_i > 5.5) => 0.0542322464,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0027386742, -0.0027386742),
   (r_D33_Eviction_Recency_d = NULL) => -0.0022877226, -0.0022877226),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 23.25) => -0.0663652309,
   (c_lowinc > 23.25) => 0.0329263624,
   (c_lowinc = NULL) => -0.0070981558, -0.0070981558), -0.0029911047);

// Tree: 227 
woFDN_FLAP___lgt_227 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 26965.5) => 0.0020026331,
(f_addrchangeincomediff_d > 26965.5) => -0.0638336086,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 110.25) => -0.0036061725,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 110.25) => 
      map(
      (NULL < c_exp_homes and c_exp_homes <= 167.5) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 100.5) => 
            map(
            (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.15) => 0.2080056934,
            (c_pop_75_84_p > 3.15) => -0.0063949732,
            (c_pop_75_84_p = NULL) => 0.1072190552, 0.1072190552),
         (c_rich_fam > 100.5) => -0.0544875822,
         (c_rich_fam = NULL) => 0.0256805389, 0.0256805389),
      (c_exp_homes > 167.5) => 0.2474686492,
      (c_exp_homes = NULL) => 0.0775271101, 0.0775271101),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0061330404, 0.0032283116), 0.0012558138);

// Tree: 228 
woFDN_FLAP___lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 194.5) => -0.0024518985,
   (f_fp_prevaddrcrimeindex_i > 194.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 34.3) => 0.1463161983,
      (c_med_age > 34.3) => 0.0125576457,
      (c_med_age = NULL) => 0.0647329676, 0.0647329676),
   (f_fp_prevaddrcrimeindex_i = NULL) => -0.0016656867, -0.0016656867),
(f_assocsuspicousidcount_i > 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 284.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 8.45) => -0.0170192576,
      (c_hval_200k_p > 8.45) => 0.1037502405,
      (c_hval_200k_p = NULL) => 0.0055420773, 0.0055420773),
   (r_C10_M_Hdr_FS_d > 284.5) => -0.1015930553,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0412751046, -0.0412751046),
(f_assocsuspicousidcount_i = NULL) => -0.0125083988, -0.0033250627);

// Tree: 229 
woFDN_FLAP___lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 0.0017018330,
   (k_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 40.5) => -0.1192950975,
      (c_born_usa > 40.5) => 
         map(
         (NULL < c_totsales and c_totsales <= 13179.5) => 
            map(
            (NULL < c_construction and c_construction <= 6.2) => -0.0354417644,
            (c_construction > 6.2) => 0.1212889529,
            (c_construction = NULL) => 0.0436994889, 0.0436994889),
         (c_totsales > 13179.5) => -0.1142875915,
         (c_totsales = NULL) => -0.0106726881, -0.0106726881),
      (c_born_usa = NULL) => -0.0510181545, -0.0510181545),
   (k_inq_adls_per_addr_i = NULL) => 0.0006155455, 0.0006155455),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0632714635,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0333097573, -0.0023011573);

// Tree: 230 
woFDN_FLAP___lgt_230 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0068775813,
         (f_phones_per_addr_c6_i > 0.5) => 
            map(
            (NULL < c_hval_500k_p and c_hval_500k_p <= 36.85) => 0.0124603719,
            (c_hval_500k_p > 36.85) => 0.1382490476,
            (c_hval_500k_p = NULL) => 0.0162476201, 0.0162476201),
         (f_phones_per_addr_c6_i = NULL) => 0.0013688182, 0.0013688182),
      (f_inq_count24_i > 14.5) => -0.0868982610,
      (f_inq_count24_i = NULL) => 0.0006582476, 0.0006582476),
   (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0923694868,
   (f_fp_prevaddrcrimeindex_i = NULL) => -0.0102265822, 0.0000212633),
(f_bus_addr_match_count_d > 52.5) => 0.1328820830,
(f_bus_addr_match_count_d = NULL) => 0.0007334853, 0.0007334853);

// Tree: 231 
woFDN_FLAP___lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0016929374,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => 0.1221709674,
   (k_comb_age_d > 26.5) => 
      map(
      (NULL < c_no_move and c_no_move <= 143.5) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 41) => 
            map(
            (NULL < c_rental and c_rental <= 102) => -0.0130560387,
            (c_rental > 102) => 0.1655368702,
            (c_rental = NULL) => 0.0745555770, 0.0745555770),
         (f_fp_prevaddrcrimeindex_i > 41) => -0.0428619672,
         (f_fp_prevaddrcrimeindex_i = NULL) => -0.0053732332, -0.0053732332),
      (c_no_move > 143.5) => 0.1458451693,
      (c_no_move = NULL) => 0.0151042588, 0.0151042588),
   (k_comb_age_d = NULL) => 0.0368247591, 0.0368247591),
(f_srchvelocityrisktype_i = NULL) => 0.0169715580, 0.0000228127);

// Tree: 232 
woFDN_FLAP___lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1390751626,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 751.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 87.55) => 0.0107138828,
         (r_C12_source_profile_d > 87.55) => 0.1782006234,
         (r_C12_source_profile_d = NULL) => 0.0129788867, 0.0129788867),
      (f_phone_ver_experian_d > 0.5) => -0.0094461774,
      (f_phone_ver_experian_d = NULL) => -0.0121770486, -0.0025708765),
   (f_liens_unrel_O_total_amt_i > 751.5) => -0.0649932973,
   (f_liens_unrel_O_total_amt_i = NULL) => -0.0036127529, -0.0036127529),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.35) => -0.0652442433,
   (c_pop_55_64_p > 9.35) => 0.0429617634,
   (c_pop_55_64_p = NULL) => -0.0000136718, -0.0000136718), -0.0029464162);

// Tree: 233 
woFDN_FLAP___lgt_233 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 9.5) => -0.0026876067,
(f_rel_homeover300_count_d > 9.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => -0.0037980794,
      (f_inq_Collection_count_i > 3.5) => -0.0903572539,
      (f_inq_Collection_count_i = NULL) => -0.0207896543, -0.0207896543),
   (f_varrisktype_i > 3.5) => -0.1071189565,
   (f_varrisktype_i = NULL) => -0.0271204698, -0.0271204698),
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 37.3) => 0.0992590021,
      (c_med_age > 37.3) => -0.0171519606,
      (c_med_age = NULL) => 0.0427357601, 0.0427357601),
   (r_Phn_Cell_n > 0.5) => -0.0460276309,
   (r_Phn_Cell_n = NULL) => -0.0038874352, -0.0038874352), -0.0047474915);

// Tree: 234 
woFDN_FLAP___lgt_234 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 1.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 52) => -0.0194436187,
      (f_addrchangecrimediff_i > 52) => -0.0901475996,
      (f_addrchangecrimediff_i = NULL) => -0.0096193027, -0.0181340269),
   (f_util_add_curr_conv_n > 0.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 69.5) => 
         map(
         (NULL < C_INC_201K_P and C_INC_201K_P <= 7.15) => 0.0667082552,
         (C_INC_201K_P > 7.15) => -0.0391492720,
         (C_INC_201K_P = NULL) => 0.0340422433, 0.0340422433),
      (r_A50_pb_total_dollars_d > 69.5) => -0.0010299418,
      (r_A50_pb_total_dollars_d = NULL) => 0.0056028676, 0.0056028676),
   (f_util_add_curr_conv_n = NULL) => -0.0049555502, -0.0049555502),
(f_srchfraudsrchcountmo_i > 1.5) => 0.0607416344,
(f_srchfraudsrchcountmo_i = NULL) => 0.0134415140, -0.0042613196);

// Tree: 235 
woFDN_FLAP___lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.07085281545) => 0.0101245572,
   (f_add_curr_nhood_VAC_pct_i > 0.07085281545) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 11.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','6: Other']) => 0.0864330972,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 0.1865091914,
         (nf_seg_FraudPoint_3_0 = '') => 0.1216322752, 0.1216322752),
      (r_C13_Curr_Addr_LRes_d > 11.5) => 0.0391955991,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0637909037, 0.0637909037),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0203567441, 0.0203567441),
(f_hh_members_ct_d > 1.5) => -0.0063500385,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0558363492,
   (c_pop_35_44_p > 15.55) => 0.0679568588,
   (c_pop_35_44_p = NULL) => 0.0019338145, 0.0019338145), -0.0008802365);

// Tree: 236 
woFDN_FLAP___lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.25) => 
   map(
   (NULL < f_corraddrphonecount_d and f_corraddrphonecount_d <= 2.5) => -0.0568487305,
   (f_corraddrphonecount_d > 2.5) => 0.1311272608,
   (f_corraddrphonecount_d = NULL) => -0.0436830968, -0.0436830968),
(c_pop_45_54_p > 7.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0005234705,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 101) => 0.0252233242,
         (c_cartheft > 101) => 0.1547306163,
         (c_cartheft = NULL) => 0.0936422710, 0.0936422710),
      (f_corraddrnamecount_d > 3.5) => 0.0138068426,
      (f_corraddrnamecount_d = NULL) => 0.0290272660, 0.0290272660),
   (f_rel_felony_count_i = NULL) => 0.0067881308, 0.0019578905),
(c_pop_45_54_p = NULL) => 0.0092823321, -0.0006833892);

// Tree: 237 
woFDN_FLAP___lgt_237 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => -0.0065698900,
(r_L79_adls_per_addr_c6_i > 3.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 132.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
            map(
            (NULL < c_young and c_young <= 24.4) => 0.1798442687,
            (c_young > 24.4) => 0.0430615516,
            (c_young = NULL) => 0.1127312533, 0.1127312533),
         (r_Phn_Cell_n > 0.5) => 0.0316052817,
         (r_Phn_Cell_n = NULL) => 0.0676987493, 0.0676987493),
      (c_new_homes > 132.5) => -0.0130456154,
      (c_new_homes = NULL) => 0.0380570681, 0.0380570681),
   (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0431237221,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0179204268, 0.0179204268),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0045523590, -0.0045523590);

// Tree: 238 
woFDN_FLAP___lgt_238 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 348668.5) => -0.0067120604,
(f_addrchangevaluediff_d > 348668.5) => 0.0923146140,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 10.55) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => -0.0371237769,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0258970286,
         (nf_seg_FraudPoint_3_0 = '') => 0.0148847425, 0.0148847425),
      (f_bus_addr_match_count_d > 6.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 281) => 0.1843104884,
         (r_C21_M_Bureau_ADL_FS_d > 281) => 0.0039395427,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0941250156, 0.0941250156),
      (f_bus_addr_match_count_d = NULL) => 0.0218838834, 0.0218838834),
   (c_pop_18_24_p > 10.55) => -0.0373291376,
   (c_pop_18_24_p = NULL) => -0.0110607076, 0.0029291744), -0.0040491810);

// Tree: 239 
woFDN_FLAP___lgt_239 := map(
(NULL < c_old_homes and c_old_homes <= 164.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0063034389,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 23.5) => 
         map(
         (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 0.5) => 0.0491309223,
         (f_rel_ageover50_count_d > 0.5) => 0.1857701309,
         (f_rel_ageover50_count_d = NULL) => 0.0797731247, 0.0797731247),
      (c_no_car > 23.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 8.5) => 0.0661248043,
         (r_C13_Curr_Addr_LRes_d > 8.5) => -0.0049154661,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0054619851, 0.0054619851),
      (c_no_car = NULL) => 0.0186462196, 0.0186462196),
   (f_inq_Other_count_i = NULL) => 0.0263893591, -0.0002295147),
(c_old_homes > 164.5) => -0.0283095499,
(c_old_homes = NULL) => 0.0126493644, -0.0034913048);

// Tree: 240 
woFDN_FLAP___lgt_240 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 6.95) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 49.85) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 7.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 13) => -0.0426422278,
         (c_robbery > 13) => 0.0136980463,
         (c_robbery = NULL) => 0.0080227556, 0.0080227556),
      (f_inq_HighRiskCredit_count24_i > 7.5) => 0.0797403337,
      (f_inq_HighRiskCredit_count24_i = NULL) => 0.0178597132, 0.0085489828),
   (c_famotf18_p > 49.85) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => 0.0184451818,
      (f_srchfraudsrchcount_i > 0.5) => 0.1249971981,
      (f_srchfraudsrchcount_i = NULL) => 0.0707698327, 0.0707698327),
   (c_famotf18_p = NULL) => 0.0093514815, 0.0093514815),
(c_hval_100k_p > 6.95) => -0.0145802705,
(c_hval_100k_p = NULL) => -0.0289123357, 0.0023482255);

// Tree: 241 
woFDN_FLAP___lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0015132353,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 80.5) => -0.0291124025,
   (c_easiqlife > 80.5) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => -0.0161732373,
      (k_nap_fname_verd_d > 0.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 5.5) => 0.2126667231,
         (r_pb_order_freq_d > 5.5) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 44486) => 0.1781331168,
            (f_prevaddrmedianincome_d > 44486) => 0.0332206020,
            (f_prevaddrmedianincome_d = NULL) => 0.0625349657, 0.0625349657),
         (r_pb_order_freq_d = NULL) => 0.1400731497, 0.1037175798),
      (k_nap_fname_verd_d = NULL) => 0.0731694833, 0.0731694833),
   (c_easiqlife = NULL) => 0.0468040749, 0.0468040749),
(k_comb_age_d = NULL) => -0.0041447126, 0.0014678207);

// Tree: 242 
woFDN_FLAP___lgt_242 := map(
(NULL < c_incollege and c_incollege <= 3.25) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 4.5) => -0.0134847373,
   (f_inq_Collection_count_i > 4.5) => -0.0653609296,
   (f_inq_Collection_count_i = NULL) => -0.0192149945, -0.0192149945),
(c_incollege > 3.25) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 0.0046097903,
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < c_finance and c_finance <= 18.45) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 23.75) => 0.0119402228,
         (c_hval_150k_p > 23.75) => 0.1401665420,
         (c_hval_150k_p = NULL) => 0.0203518693, 0.0203518693),
      (c_finance > 18.45) => 0.1813602571,
      (c_finance = NULL) => 0.0286588271, 0.0286588271),
   (f_srchvelocityrisktype_i = NULL) => 0.0158822912, 0.0078911360),
(c_incollege = NULL) => -0.0207433053, 0.0020886776);

// Tree: 243 
woFDN_FLAP___lgt_243 := map(
(NULL < c_info and c_info <= 27.85) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => -0.0018392323,
      (k_comb_age_d > 63.5) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 4.5) => 0.0210181580,
         (k_inq_per_addr_i > 4.5) => 0.0985509949,
         (k_inq_per_addr_i = NULL) => 0.0248245284, 0.0248245284),
      (k_comb_age_d = NULL) => -0.0170870258, 0.0008970586),
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 13.5) => 0.0344785743,
      (c_pop_25_34_p > 13.5) => 0.1813150375,
      (c_pop_25_34_p = NULL) => 0.0854394645, 0.0854394645),
   (f_adls_per_phone_c6_i = NULL) => 0.0020631607, 0.0020631607),
(c_info > 27.85) => 0.1526798942,
(c_info = NULL) => 0.0190060759, 0.0031868148);

// Tree: 244 
woFDN_FLAP___lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 56.05) => -0.0421641624,
   (c_fammar_p > 56.05) => -0.0068570373,
   (c_fammar_p = NULL) => 0.0149442739, -0.0089440731),
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 460.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 24) => 0.0062803495,
      (c_hh4_p > 24) => 0.0779116412,
      (c_hh4_p = NULL) => 0.0106849361, 0.0106849361),
   (r_C10_M_Hdr_FS_d > 460.5) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 20.75) => 0.2143437815,
      (c_lowrent > 20.75) => 0.0274084961,
      (c_lowrent = NULL) => 0.1208761388, 0.1208761388),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0141632364, 0.0141632364),
(f_curraddrcrimeindex_i = NULL) => -0.0008582315, -0.0029025844);

// Tree: 245 
woFDN_FLAP___lgt_245 := map(
(NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 46977) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.0826801229,
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 0.0114609705,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0131706049, 0.0131706049),
   (C_INC_75K_P > 27.85) => 0.1319515882,
   (C_INC_75K_P = NULL) => -0.0169340265, 0.0133180280),
(f_prevaddrmedianincome_d > 46977) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 6.5) => 
      map(
      (NULL < c_health and c_health <= 4.05) => -0.1237552170,
      (c_health > 4.05) => -0.0390671067,
      (c_health = NULL) => -0.0675913005, -0.0675913005),
   (f_mos_inq_banko_om_fseen_d > 6.5) => -0.0050065523,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0076287232, -0.0076287232),
(f_prevaddrmedianincome_d = NULL) => 0.0000533041, -0.0020074022);

// Tree: 246 
woFDN_FLAP___lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.385) => 
   map(
   (NULL < c_totsales and c_totsales <= 173970.5) => 
      map(
      (NULL < f_varmsrcssncount_i and f_varmsrcssncount_i <= 0.5) => -0.0823216605,
      (f_varmsrcssncount_i > 0.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 1.5) => 0.1119644720,
         (c_no_teens > 1.5) => 0.0034420730,
         (c_no_teens = NULL) => 0.0039348828, 0.0039348828),
      (f_varmsrcssncount_i = NULL) => 
         map(
         (NULL < C_INC_15K_P and C_INC_15K_P <= 9.35) => 0.0574100120,
         (C_INC_15K_P > 9.35) => -0.0543298590,
         (C_INC_15K_P = NULL) => 0.0052647389, 0.0052647389), 0.0028010517),
   (c_totsales > 173970.5) => -0.0573103376,
   (c_totsales = NULL) => 0.0000707175, 0.0000707175),
(c_hhsize > 4.385) => 0.0894377423,
(c_hhsize = NULL) => -0.0255315947, 0.0000337816);

// Tree: 247 
woFDN_FLAP___lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 187) => -0.0056991780,
      (f_fp_prevaddrcrimeindex_i > 187) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 4.85) => -0.0251024974,
         (c_femdiv_p > 4.85) => 
            map(
            (NULL < c_rest_indx and c_rest_indx <= 97.5) => 0.1798838378,
            (c_rest_indx > 97.5) => 0.0440118560,
            (c_rest_indx = NULL) => 0.1003348570, 0.1003348570),
         (c_femdiv_p = NULL) => 0.0470162764, 0.0470162764),
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0039659275, -0.0039659275),
   (r_D33_eviction_count_i > 3.5) => 0.0706610613,
   (r_D33_eviction_count_i = NULL) => -0.0035354217, -0.0035354217),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0827648135,
(f_inq_HighRiskCredit_count_i = NULL) => -0.0019247261, -0.0038345358);

// Tree: 248 
woFDN_FLAP___lgt_248 := map(
(NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 4.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 40.45) => -0.0013051188,
   (c_famotf18_p > 40.45) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 95.5) => -0.0778497370,
      (c_easiqlife > 95.5) => 
         map(
         (NULL < c_assault and c_assault <= 110) => 0.1030910598,
         (c_assault > 110) => -0.0334068868,
         (c_assault = NULL) => 0.0073856030, 0.0073856030),
      (c_easiqlife = NULL) => -0.0368802642, -0.0368802642),
   (c_famotf18_p = NULL) => 0.0358019600, -0.0015856744),
(f_hh_workers_paw_d > 4.5) => -0.1114663293,
(f_hh_workers_paw_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0399015083,
   (k_nap_lname_verd_d > 0.5) => -0.0487396228,
   (k_nap_lname_verd_d = NULL) => -0.0025157201, -0.0025157201), -0.0023079299);

// Tree: 249 
woFDN_FLAP___lgt_249 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 7.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 156.5) => -0.0017841886,
   (c_born_usa > 156.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 52.05) => 
         map(
         (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 1.5) => 0.1158159302,
         (f_property_owners_ct_d > 1.5) => 0.0133976940,
         (f_property_owners_ct_d = NULL) => 0.0713805050, 0.0713805050),
      (c_civ_emp > 52.05) => 0.0048382085,
      (c_civ_emp = NULL) => 0.0207881058, 0.0207881058),
   (c_born_usa = NULL) => 0.0157697311, 0.0014650932),
(r_I60_Inq_Count12_i > 7.5) => -0.0540409131,
(r_I60_Inq_Count12_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 93.5) => 0.0407663583,
   (c_born_usa > 93.5) => -0.0598327995,
   (c_born_usa = NULL) => 0.0022390212, 0.0022390212), 0.0006087675);

// Tree: 250 
woFDN_FLAP___lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => -0.0030198189,
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 2.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 18.5) => 0.1026665231,
      (c_many_cars > 18.5) => 0.0065254742,
      (c_many_cars = NULL) => 0.0145372282, 0.0145372282),
   (f_crim_rel_under25miles_cnt_i > 2.5) => 
      map(
      (NULL < c_families and c_families <= 261) => 0.1847021660,
      (c_families > 261) => 
         map(
         (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.15) => 0.1014687625,
         (c_pop_65_74_p > 4.15) => -0.0532470309,
         (c_pop_65_74_p = NULL) => 0.0192421870, 0.0192421870),
      (c_families = NULL) => 0.0621074665, 0.0621074665),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0219592622, 0.0219592622),
(C_INC_50K_P = NULL) => 0.0019034053, -0.0003976938);

// Tree: 251 
woFDN_FLAP___lgt_251 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1391) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 100.5) => 
         map(
         (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 79.5) => 0.0351625585,
         (f_curraddrcrimeindex_i > 79.5) => -0.0770825943,
         (f_curraddrcrimeindex_i = NULL) => -0.0515926592, -0.0515926592),
      (c_exp_prod > 100.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 177.7) => -0.0339826922,
         (c_oldhouse > 177.7) => 0.1470191480,
         (c_oldhouse = NULL) => 0.0286717909, 0.0286717909),
      (c_exp_prod = NULL) => -0.0325633975, -0.0325633975),
   (C_INC_150K_P > 0.55) => 0.0090611521,
   (C_INC_150K_P = NULL) => -0.0273998493, 0.0061083398),
(f_liens_rel_SC_total_amt_i > 1391) => -0.1341066743,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0116532854, 0.0053470286);

// Tree: 252 
woFDN_FLAP___lgt_252 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 17.5) => 
   map(
   (NULL < r_Phn_PCS_n and r_Phn_PCS_n <= 0.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 0.0298137759,
         (f_phone_ver_insurance_d > 3.5) => -0.0150781624,
         (f_phone_ver_insurance_d = NULL) => 0.0193746877, 0.0193746877),
      (f_corrphonelastnamecount_d > 0.5) => -0.0037738965,
      (f_corrphonelastnamecount_d = NULL) => 0.0061286835, 0.0061286835),
   (r_Phn_PCS_n > 0.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 11.35) => -0.1140713566,
      (c_fammar18_p > 11.35) => -0.0167121458,
      (c_fammar18_p = NULL) => -0.0228513572, -0.0228513572),
   (r_Phn_PCS_n = NULL) => 0.0024367216, 0.0024367216),
(f_inq_HighRiskCredit_count_i > 17.5) => 0.0783583193,
(f_inq_HighRiskCredit_count_i = NULL) => -0.0133972842, 0.0025961111);

// Tree: 253 
woFDN_FLAP___lgt_253 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 6.5) => 0.0000856646,
(r_D30_Derog_Count_i > 6.5) => 
   map(
   (NULL < c_rental and c_rental <= 114) => 
      map(
      (NULL < c_hval_100k_p and c_hval_100k_p <= 0.65) => 0.0705402221,
      (c_hval_100k_p > 0.65) => 
         map(
         (NULL < c_white_col and c_white_col <= 36.05) => 0.0148611671,
         (c_white_col > 36.05) => -0.1032903009,
         (c_white_col = NULL) => -0.0327394243, -0.0327394243),
      (c_hval_100k_p = NULL) => 0.0102214370, 0.0102214370),
   (c_rental > 114) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => -0.0316616157,
      (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.1263989194,
      (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0779869052, -0.0779869052),
   (c_rental = NULL) => -0.0328394096, -0.0328394096),
(r_D30_Derog_Count_i = NULL) => -0.0108588850, -0.0012671192);

// Tree: 254 
woFDN_FLAP___lgt_254 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 37.45) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 62.5) => -0.0196851780,
   (k_comb_age_d > 62.5) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 24.2) => 0.0066708953,
      (c_trailer_p > 24.2) => 
         map(
         (NULL < c_unemp and c_unemp <= 3.95) => 0.0201042996,
         (c_unemp > 3.95) => 0.2559495683,
         (c_unemp = NULL) => 0.1380269340, 0.1380269340),
      (c_trailer_p = NULL) => 0.0208127463, 0.0208127463),
   (k_comb_age_d = NULL) => -0.0398240810, -0.0142674824),
(c_fammar18_p > 37.45) => 
   map(
   (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 0.0094911496,
   (r_D32_felony_count_i > 0.5) => 0.1144505341,
   (r_D32_felony_count_i = NULL) => 0.0240872332, 0.0106594496),
(c_fammar18_p = NULL) => 0.0360431122, -0.0023010417);

// Tree: 255 
woFDN_FLAP___lgt_255 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 185.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 74.25) => -0.1384045698,
   (c_fammar_p > 74.25) => 0.0023325745,
   (c_fammar_p = NULL) => -0.0602172674, -0.0602172674),
(f_mos_liens_unrel_FT_lseen_d > 185.5) => 
   map(
   (NULL < c_pop_12_17_p and c_pop_12_17_p <= 13.75) => 0.0044223175,
   (c_pop_12_17_p > 13.75) => 
      map(
      (NULL < c_unempl and c_unempl <= 167.5) => -0.0265882543,
      (c_unempl > 167.5) => -0.1146254849,
      (c_unempl = NULL) => -0.0374775554, -0.0374775554),
   (c_pop_12_17_p = NULL) => 0.0173328439, 0.0030757160),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 4.65) => -0.0666093117,
   (c_pop_65_74_p > 4.65) => 0.0303929256,
   (c_pop_65_74_p = NULL) => -0.0048202154, -0.0048202154), 0.0022950575);

// Tree: 256 
woFDN_FLAP___lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 82.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 4.5) => -0.0956894362,
   (r_I60_inq_comm_recency_d > 4.5) => -0.0203359997,
   (r_I60_inq_comm_recency_d = NULL) => -0.0215542888, -0.0215542888),
(r_C13_max_lres_d > 82.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 22.05) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 4950) => -0.0226558515,
      (r_A49_Curr_AVM_Chg_1yr_i > 4950) => 0.0174984192,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0125848819, 0.0050968306),
   (c_pop_35_44_p > 22.05) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 136.5) => 0.0417982608,
      (c_retired2 > 136.5) => 0.2660810509,
      (c_retired2 = NULL) => 0.0615234573, 0.0615234573),
   (c_pop_35_44_p = NULL) => -0.0450964196, 0.0077738648),
(r_C13_max_lres_d = NULL) => 0.0157490466, 0.0001478632);

// Tree: 257 
woFDN_FLAP___lgt_257 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 804) => 
      map(
      (NULL < c_transport and c_transport <= 46.65) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 184.5) => 0.0013970478,
         (c_span_lang > 184.5) => -0.0320267807,
         (c_span_lang = NULL) => -0.0009395384, -0.0009395384),
      (c_transport > 46.65) => 0.1036163205,
      (c_transport = NULL) => 0.0182537596, 0.0000838781),
   (f_liens_unrel_O_total_amt_i > 804) => -0.0637601762,
   (f_liens_unrel_O_total_amt_i = NULL) => -0.0010416682, -0.0010416682),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0774833900,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0618690207,
   (k_nap_lname_verd_d > 0.5) => -0.0249025723,
   (k_nap_lname_verd_d = NULL) => 0.0213004837, 0.0213004837), -0.0004485272);

// Tree: 258 
woFDN_FLAP___lgt_258 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 27.7) => -0.0048255627,
   (C_INC_25K_P > 27.7) => 0.0823574483,
   (C_INC_25K_P = NULL) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.19434134995) => 0.1662198859,
      (f_add_curr_mobility_index_i > 0.19434134995) => -0.1064975785,
      (f_add_curr_mobility_index_i = NULL) => 0.0286395151, 0.0058988109), -0.0040885119),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 118.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 193.5) => 0.1686652292,
      (r_C13_max_lres_d > 193.5) => -0.0181965833,
      (r_C13_max_lres_d = NULL) => 0.0930033910, 0.0930033910),
   (c_old_homes > 118.5) => -0.0561478734,
   (c_old_homes = NULL) => 0.0440631324, 0.0440631324),
(r_P85_Phn_Disconnected_i = NULL) => -0.0030749929, -0.0030749929);

// Tree: 259 
woFDN_FLAP___lgt_259 := map(
(NULL < C_INC_100K_P and C_INC_100K_P <= 12.45) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 44.5) => -0.0081862403,
   (k_comb_age_d > 44.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.00062829185) => 0.2409663796,
      (f_add_curr_nhood_SFD_pct_d > 0.00062829185) => 0.0212268920,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0270125552, 0.0270125552),
   (k_comb_age_d = NULL) => 0.0137257969, 0.0058006579),
(C_INC_100K_P > 12.45) => 
   map(
   (NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n <= 9) => -0.0614532588,
   (r_D31_bk_chapter_n > 9) => -0.0817106408,
   (r_D31_bk_chapter_n = NULL) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => -0.0091889456,
      (f_hh_lienholders_i > 3.5) => 0.0875913215,
      (f_hh_lienholders_i = NULL) => -0.0066388964, -0.0083778554), -0.0146299406),
(C_INC_100K_P = NULL) => -0.0535110926, -0.0076423164);

// Tree: 260 
woFDN_FLAP___lgt_260 := map(
(NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 10.55) => 0.0112974825,
      (c_low_hval > 10.55) => -0.0740921581,
      (c_low_hval = NULL) => -0.0336726103, -0.0336726103),
   (C_INC_150K_P > 0.55) => 0.0035901989,
   (C_INC_150K_P = NULL) => -0.0237325388, 0.0010759552),
(r_D32_felony_count_i > 0.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 12.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.0065178910,
      (f_srchvelocityrisktype_i > 2.5) => 0.1726237276,
      (f_srchvelocityrisktype_i = NULL) => 0.0895708093, 0.0895708093),
   (f_rel_under100miles_cnt_d > 12.5) => -0.0499638833,
   (f_rel_under100miles_cnt_d = NULL) => 0.0470297445, 0.0470297445),
(r_D32_felony_count_i = NULL) => 0.0068578617, 0.0017429812);

// Tree: 261 
woFDN_FLAP___lgt_261 := map(
(NULL < c_business and c_business <= 243.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < c_families and c_families <= 480) => 0.0103097026,
      (c_families > 480) => 0.1483626528,
      (c_families = NULL) => 0.0532833836, 0.0532833836),
   (r_C10_M_Hdr_FS_d > 11.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 9.5) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 25.5) => 0.0078202970,
         (f_rel_homeover150_count_d > 25.5) => 0.1707066652,
         (f_rel_homeover150_count_d = NULL) => 0.0086308382, 0.0086308382),
      (f_rel_homeover300_count_d > 9.5) => -0.0245165050,
      (f_rel_homeover300_count_d = NULL) => -0.0798583840, 0.0046475382),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0016425082, 0.0057014335),
(c_business > 243.5) => -0.0414040452,
(c_business = NULL) => 0.0011676728, 0.0023951965);

// Tree: 262 
woFDN_FLAP___lgt_262 := map(
(NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 1.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 197.5) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 76.3) => 0.0038594199,
      (c_lowinc > 76.3) => 
         map(
         (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.75) => 0.1941646956,
         (c_pop_0_5_p > 7.75) => -0.0114947646,
         (c_pop_0_5_p = NULL) => 0.0962316193, 0.0962316193),
      (c_lowinc = NULL) => 0.0046600044, 0.0046600044),
   (c_bel_edu > 197.5) => -0.0779667391,
   (c_bel_edu = NULL) => -0.0031465819, 0.0038820173),
(f_srchaddrsrchcountwk_i > 1.5) => -0.0852145645,
(f_srchaddrsrchcountwk_i = NULL) => 
   map(
   (NULL < c_rich_old and c_rich_old <= 134.5) => -0.0333121996,
   (c_rich_old > 134.5) => 0.0542341510,
   (c_rich_old = NULL) => 0.0021073163, 0.0021073163), 0.0034521136);

// Tree: 263 
woFDN_FLAP___lgt_263 := map(
(NULL < c_retail and c_retail <= 34.95) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 2.05) => -0.0301989376,
   (C_INC_15K_P > 2.05) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 9.45) => 0.0515045611,
      (c_hh1_p > 9.45) => 0.0033337140,
      (c_hh1_p = NULL) => 0.0062125833, 0.0062125833),
   (C_INC_15K_P = NULL) => 0.0009839607, 0.0009839607),
(c_retail > 34.95) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 50.5) => 0.1437758585,
   (c_ab_av_edu > 50.5) => 
      map(
      (NULL < c_preschl and c_preschl <= 180.5) => 0.0017812946,
      (c_preschl > 180.5) => 0.1751060085,
      (c_preschl = NULL) => 0.0194347377, 0.0194347377),
   (c_ab_av_edu = NULL) => 0.0373666584, 0.0373666584),
(c_retail = NULL) => -0.0041489391, 0.0026756182);

// Tree: 264 
woFDN_FLAP___lgt_264 := map(
(NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 6.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -26347.5) => -0.0473621420,
      (f_addrchangeincomediff_d > -26347.5) => 0.0060438766,
      (f_addrchangeincomediff_d = NULL) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 151.5) => -0.0030220722,
         (c_easiqlife > 151.5) => 0.0701716210,
         (c_easiqlife = NULL) => 0.0090876637, 0.0079679747), 0.0056533176),
   (f_inq_Other_count_i > 6.5) => 0.0807342923,
   (f_inq_Other_count_i = NULL) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 117.5) => -0.0560199013,
      (c_totcrime > 117.5) => 0.0497432302,
      (c_totcrime = NULL) => -0.0132110147, -0.0132110147), 0.0060261082),
(r_P85_Phn_Not_Issued_i > 0.5) => -0.0558361419,
(r_P85_Phn_Not_Issued_i = NULL) => 0.0046313425, 0.0046313425);

// Tree: 265 
woFDN_FLAP___lgt_265 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.0231054668,
   (r_I60_inq_recency_d > 4.5) => -0.0018965512,
   (r_I60_inq_recency_d = NULL) => 0.0117893370, 0.0014665425),
(k_inq_per_phone_i > 4.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
      map(
      (NULL < c_for_sale and c_for_sale <= 102.5) => 0.1330735374,
      (c_for_sale > 102.5) => 0.0316719503,
      (c_for_sale = NULL) => 0.0832039044, 0.0832039044),
   (r_L79_adls_per_addr_curr_i > 2.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.28741641665) => 0.0428624123,
      (f_add_curr_mobility_index_i > 0.28741641665) => -0.0786775831,
      (f_add_curr_mobility_index_i = NULL) => -0.0062897917, -0.0062897917),
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0360660034, 0.0360660034),
(k_inq_per_phone_i = NULL) => 0.0021838983, 0.0021838983);

// Tree: 266 
woFDN_FLAP___lgt_266 := map(
(NULL < c_med_rent and c_med_rent <= 1970) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0060764449,
   (r_L70_Add_Standardized_i > 0.5) => 0.0326880884,
   (r_L70_Add_Standardized_i = NULL) => -0.0031532495, -0.0031532495),
(c_med_rent > 1970) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 160) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 5.5) => -0.0289365616,
      (r_wealth_index_d > 5.5) => 0.1960372722,
      (r_wealth_index_d = NULL) => 0.0234042895, 0.0234042895),
   (r_C13_Curr_Addr_LRes_d > 160) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 47.5) => 0.2412337090,
      (c_born_usa > 47.5) => 0.0331983160,
      (c_born_usa = NULL) => 0.1351764498, 0.1351764498),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0562595067, 0.0562595067),
(c_med_rent = NULL) => -0.0202242533, -0.0019035788);

// Tree: 267 
woFDN_FLAP___lgt_267 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0154524392,
(f_srchfraudsrchcount_i > 0.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 3.55) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 61.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 7.55) => 0.1377175477,
         (c_hh3_p > 7.55) => 0.0284537471,
         (c_hh3_p = NULL) => 0.0393927007, 0.0393927007),
      (r_I61_inq_collection_recency_d > 61.5) => 0.0060732115,
      (r_I61_inq_collection_recency_d = NULL) => 0.0116521395, 0.0116521395),
   (c_hval_60k_p > 3.55) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 41.75) => -0.0837254066,
      (c_fammar_p > 41.75) => -0.0082342480,
      (c_fammar_p = NULL) => -0.0152661419, -0.0152661419),
   (c_hval_60k_p = NULL) => 0.0925534773, 0.0073532904),
(f_srchfraudsrchcount_i = NULL) => -0.0263790475, -0.0037670362);

// Tree: 268 
woFDN_FLAP___lgt_268 := map(
(NULL < c_unempl and c_unempl <= 184.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 14.05) => 0.0036744319,
   (C_INC_25K_P > 14.05) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 7.5) => -0.0194021863,
      (r_D30_Derog_Count_i > 7.5) => -0.0936829660,
      (r_D30_Derog_Count_i = NULL) => -0.0222978777, -0.0222978777),
   (C_INC_25K_P = NULL) => -0.0001489788, -0.0001489788),
(c_unempl > 184.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 30.6) => 
      map(
      (NULL < f_rel_count_i and f_rel_count_i <= 8.5) => -0.0986933590,
      (f_rel_count_i > 8.5) => 0.0465840935,
      (f_rel_count_i = NULL) => -0.0155002879, -0.0155002879),
   (c_hh1_p > 30.6) => 0.1094924853,
   (c_hh1_p = NULL) => 0.0427542625, 0.0427542625),
(c_unempl = NULL) => -0.0275140834, -0.0000292807);

// Final Score Sum 

   woFDN_FLAP___lgt := sum(
      woFDN_FLAP___lgt_0, woFDN_FLAP___lgt_1, woFDN_FLAP___lgt_2, woFDN_FLAP___lgt_3, woFDN_FLAP___lgt_4, 
      woFDN_FLAP___lgt_5, woFDN_FLAP___lgt_6, woFDN_FLAP___lgt_7, woFDN_FLAP___lgt_8, woFDN_FLAP___lgt_9, 
      woFDN_FLAP___lgt_10, woFDN_FLAP___lgt_11, woFDN_FLAP___lgt_12, woFDN_FLAP___lgt_13, woFDN_FLAP___lgt_14, 
      woFDN_FLAP___lgt_15, woFDN_FLAP___lgt_16, woFDN_FLAP___lgt_17, woFDN_FLAP___lgt_18, woFDN_FLAP___lgt_19, 
      woFDN_FLAP___lgt_20, woFDN_FLAP___lgt_21, woFDN_FLAP___lgt_22, woFDN_FLAP___lgt_23, woFDN_FLAP___lgt_24, 
      woFDN_FLAP___lgt_25, woFDN_FLAP___lgt_26, woFDN_FLAP___lgt_27, woFDN_FLAP___lgt_28, woFDN_FLAP___lgt_29, 
      woFDN_FLAP___lgt_30, woFDN_FLAP___lgt_31, woFDN_FLAP___lgt_32, woFDN_FLAP___lgt_33, woFDN_FLAP___lgt_34, 
      woFDN_FLAP___lgt_35, woFDN_FLAP___lgt_36, woFDN_FLAP___lgt_37, woFDN_FLAP___lgt_38, woFDN_FLAP___lgt_39, 
      woFDN_FLAP___lgt_40, woFDN_FLAP___lgt_41, woFDN_FLAP___lgt_42, woFDN_FLAP___lgt_43, woFDN_FLAP___lgt_44, 
      woFDN_FLAP___lgt_45, woFDN_FLAP___lgt_46, woFDN_FLAP___lgt_47, woFDN_FLAP___lgt_48, woFDN_FLAP___lgt_49, 
      woFDN_FLAP___lgt_50, woFDN_FLAP___lgt_51, woFDN_FLAP___lgt_52, woFDN_FLAP___lgt_53, woFDN_FLAP___lgt_54, 
      woFDN_FLAP___lgt_55, woFDN_FLAP___lgt_56, woFDN_FLAP___lgt_57, woFDN_FLAP___lgt_58, woFDN_FLAP___lgt_59, 
      woFDN_FLAP___lgt_60, woFDN_FLAP___lgt_61, woFDN_FLAP___lgt_62, woFDN_FLAP___lgt_63, woFDN_FLAP___lgt_64, 
      woFDN_FLAP___lgt_65, woFDN_FLAP___lgt_66, woFDN_FLAP___lgt_67, woFDN_FLAP___lgt_68, woFDN_FLAP___lgt_69, 
      woFDN_FLAP___lgt_70, woFDN_FLAP___lgt_71, woFDN_FLAP___lgt_72, woFDN_FLAP___lgt_73, woFDN_FLAP___lgt_74, 
      woFDN_FLAP___lgt_75, woFDN_FLAP___lgt_76, woFDN_FLAP___lgt_77, woFDN_FLAP___lgt_78, woFDN_FLAP___lgt_79, 
      woFDN_FLAP___lgt_80, woFDN_FLAP___lgt_81, woFDN_FLAP___lgt_82, woFDN_FLAP___lgt_83, woFDN_FLAP___lgt_84, 
      woFDN_FLAP___lgt_85, woFDN_FLAP___lgt_86, woFDN_FLAP___lgt_87, woFDN_FLAP___lgt_88, woFDN_FLAP___lgt_89, 
      woFDN_FLAP___lgt_90, woFDN_FLAP___lgt_91, woFDN_FLAP___lgt_92, woFDN_FLAP___lgt_93, woFDN_FLAP___lgt_94, 
      woFDN_FLAP___lgt_95, woFDN_FLAP___lgt_96, woFDN_FLAP___lgt_97, woFDN_FLAP___lgt_98, woFDN_FLAP___lgt_99, 
      woFDN_FLAP___lgt_100, woFDN_FLAP___lgt_101, woFDN_FLAP___lgt_102, woFDN_FLAP___lgt_103, woFDN_FLAP___lgt_104, 
      woFDN_FLAP___lgt_105, woFDN_FLAP___lgt_106, woFDN_FLAP___lgt_107, woFDN_FLAP___lgt_108, woFDN_FLAP___lgt_109, 
      woFDN_FLAP___lgt_110, woFDN_FLAP___lgt_111, woFDN_FLAP___lgt_112, woFDN_FLAP___lgt_113, woFDN_FLAP___lgt_114, 
      woFDN_FLAP___lgt_115, woFDN_FLAP___lgt_116, woFDN_FLAP___lgt_117, woFDN_FLAP___lgt_118, woFDN_FLAP___lgt_119, 
      woFDN_FLAP___lgt_120, woFDN_FLAP___lgt_121, woFDN_FLAP___lgt_122, woFDN_FLAP___lgt_123, woFDN_FLAP___lgt_124, 
      woFDN_FLAP___lgt_125, woFDN_FLAP___lgt_126, woFDN_FLAP___lgt_127, woFDN_FLAP___lgt_128, woFDN_FLAP___lgt_129, 
      woFDN_FLAP___lgt_130, woFDN_FLAP___lgt_131, woFDN_FLAP___lgt_132, woFDN_FLAP___lgt_133, woFDN_FLAP___lgt_134, 
      woFDN_FLAP___lgt_135, woFDN_FLAP___lgt_136, woFDN_FLAP___lgt_137, woFDN_FLAP___lgt_138, woFDN_FLAP___lgt_139, 
      woFDN_FLAP___lgt_140, woFDN_FLAP___lgt_141, woFDN_FLAP___lgt_142, woFDN_FLAP___lgt_143, woFDN_FLAP___lgt_144, 
      woFDN_FLAP___lgt_145, woFDN_FLAP___lgt_146, woFDN_FLAP___lgt_147, woFDN_FLAP___lgt_148, woFDN_FLAP___lgt_149, 
      woFDN_FLAP___lgt_150, woFDN_FLAP___lgt_151, woFDN_FLAP___lgt_152, woFDN_FLAP___lgt_153, woFDN_FLAP___lgt_154, 
      woFDN_FLAP___lgt_155, woFDN_FLAP___lgt_156, woFDN_FLAP___lgt_157, woFDN_FLAP___lgt_158, woFDN_FLAP___lgt_159, 
      woFDN_FLAP___lgt_160, woFDN_FLAP___lgt_161, woFDN_FLAP___lgt_162, woFDN_FLAP___lgt_163, woFDN_FLAP___lgt_164, 
      woFDN_FLAP___lgt_165, woFDN_FLAP___lgt_166, woFDN_FLAP___lgt_167, woFDN_FLAP___lgt_168, woFDN_FLAP___lgt_169, 
      woFDN_FLAP___lgt_170, woFDN_FLAP___lgt_171, woFDN_FLAP___lgt_172, woFDN_FLAP___lgt_173, woFDN_FLAP___lgt_174, 
      woFDN_FLAP___lgt_175, woFDN_FLAP___lgt_176, woFDN_FLAP___lgt_177, woFDN_FLAP___lgt_178, woFDN_FLAP___lgt_179, 
      woFDN_FLAP___lgt_180, woFDN_FLAP___lgt_181, woFDN_FLAP___lgt_182, woFDN_FLAP___lgt_183, woFDN_FLAP___lgt_184, 
      woFDN_FLAP___lgt_185, woFDN_FLAP___lgt_186, woFDN_FLAP___lgt_187, woFDN_FLAP___lgt_188, woFDN_FLAP___lgt_189, 
      woFDN_FLAP___lgt_190, woFDN_FLAP___lgt_191, woFDN_FLAP___lgt_192, woFDN_FLAP___lgt_193, woFDN_FLAP___lgt_194, 
      woFDN_FLAP___lgt_195, woFDN_FLAP___lgt_196, woFDN_FLAP___lgt_197, woFDN_FLAP___lgt_198, woFDN_FLAP___lgt_199, 
      woFDN_FLAP___lgt_200, woFDN_FLAP___lgt_201, woFDN_FLAP___lgt_202, woFDN_FLAP___lgt_203, woFDN_FLAP___lgt_204, 
      woFDN_FLAP___lgt_205, woFDN_FLAP___lgt_206, woFDN_FLAP___lgt_207, woFDN_FLAP___lgt_208, woFDN_FLAP___lgt_209, 
      woFDN_FLAP___lgt_210, woFDN_FLAP___lgt_211, woFDN_FLAP___lgt_212, woFDN_FLAP___lgt_213, woFDN_FLAP___lgt_214, 
      woFDN_FLAP___lgt_215, woFDN_FLAP___lgt_216, woFDN_FLAP___lgt_217, woFDN_FLAP___lgt_218, woFDN_FLAP___lgt_219, 
      woFDN_FLAP___lgt_220, woFDN_FLAP___lgt_221, woFDN_FLAP___lgt_222, woFDN_FLAP___lgt_223, woFDN_FLAP___lgt_224, 
      woFDN_FLAP___lgt_225, woFDN_FLAP___lgt_226, woFDN_FLAP___lgt_227, woFDN_FLAP___lgt_228, woFDN_FLAP___lgt_229, 
      woFDN_FLAP___lgt_230, woFDN_FLAP___lgt_231, woFDN_FLAP___lgt_232, woFDN_FLAP___lgt_233, woFDN_FLAP___lgt_234, 
      woFDN_FLAP___lgt_235, woFDN_FLAP___lgt_236, woFDN_FLAP___lgt_237, woFDN_FLAP___lgt_238, woFDN_FLAP___lgt_239, 
      woFDN_FLAP___lgt_240, woFDN_FLAP___lgt_241, woFDN_FLAP___lgt_242, woFDN_FLAP___lgt_243, woFDN_FLAP___lgt_244, 
      woFDN_FLAP___lgt_245, woFDN_FLAP___lgt_246, woFDN_FLAP___lgt_247, woFDN_FLAP___lgt_248, woFDN_FLAP___lgt_249, 
      woFDN_FLAP___lgt_250, woFDN_FLAP___lgt_251, woFDN_FLAP___lgt_252, woFDN_FLAP___lgt_253, woFDN_FLAP___lgt_254, 
      woFDN_FLAP___lgt_255, woFDN_FLAP___lgt_256, woFDN_FLAP___lgt_257, woFDN_FLAP___lgt_258, woFDN_FLAP___lgt_259, 
      woFDN_FLAP___lgt_260, woFDN_FLAP___lgt_261, woFDN_FLAP___lgt_262, woFDN_FLAP___lgt_263, woFDN_FLAP___lgt_264, 
      woFDN_FLAP___lgt_265, woFDN_FLAP___lgt_266, woFDN_FLAP___lgt_267, woFDN_FLAP___lgt_268); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_woFDN_LGT := woFDN_FLAP___lgt;
			
self.final_score_0	:= 	woFDN_FLAP___lgt_0	;
self.final_score_1	:= 	woFDN_FLAP___lgt_1	;
self.final_score_2	:= 	woFDN_FLAP___lgt_2	;
self.final_score_3	:= 	woFDN_FLAP___lgt_3	;
self.final_score_4	:= 	woFDN_FLAP___lgt_4	;
self.final_score_5	:= 	woFDN_FLAP___lgt_5	;
self.final_score_6	:= 	woFDN_FLAP___lgt_6	;
self.final_score_7	:= 	woFDN_FLAP___lgt_7	;
self.final_score_8	:= 	woFDN_FLAP___lgt_8	;
self.final_score_9	:= 	woFDN_FLAP___lgt_9	;
self.final_score_10	:= 	woFDN_FLAP___lgt_10	;
self.final_score_11	:= 	woFDN_FLAP___lgt_11	;
self.final_score_12	:= 	woFDN_FLAP___lgt_12	;
self.final_score_13	:= 	woFDN_FLAP___lgt_13	;
self.final_score_14	:= 	woFDN_FLAP___lgt_14	;
self.final_score_15	:= 	woFDN_FLAP___lgt_15	;
self.final_score_16	:= 	woFDN_FLAP___lgt_16	;
self.final_score_17	:= 	woFDN_FLAP___lgt_17	;
self.final_score_18	:= 	woFDN_FLAP___lgt_18	;
self.final_score_19	:= 	woFDN_FLAP___lgt_19	;
self.final_score_20	:= 	woFDN_FLAP___lgt_20	;
self.final_score_21	:= 	woFDN_FLAP___lgt_21	;
self.final_score_22	:= 	woFDN_FLAP___lgt_22	;
self.final_score_23	:= 	woFDN_FLAP___lgt_23	;
self.final_score_24	:= 	woFDN_FLAP___lgt_24	;
self.final_score_25	:= 	woFDN_FLAP___lgt_25	;
self.final_score_26	:= 	woFDN_FLAP___lgt_26	;
self.final_score_27	:= 	woFDN_FLAP___lgt_27	;
self.final_score_28	:= 	woFDN_FLAP___lgt_28	;
self.final_score_29	:= 	woFDN_FLAP___lgt_29	;
self.final_score_30	:= 	woFDN_FLAP___lgt_30	;
self.final_score_31	:= 	woFDN_FLAP___lgt_31	;
self.final_score_32	:= 	woFDN_FLAP___lgt_32	;
self.final_score_33	:= 	woFDN_FLAP___lgt_33	;
self.final_score_34	:= 	woFDN_FLAP___lgt_34	;
self.final_score_35	:= 	woFDN_FLAP___lgt_35	;
self.final_score_36	:= 	woFDN_FLAP___lgt_36	;
self.final_score_37	:= 	woFDN_FLAP___lgt_37	;
self.final_score_38	:= 	woFDN_FLAP___lgt_38	;
self.final_score_39	:= 	woFDN_FLAP___lgt_39	;
self.final_score_40	:= 	woFDN_FLAP___lgt_40	;
self.final_score_41	:= 	woFDN_FLAP___lgt_41	;
self.final_score_42	:= 	woFDN_FLAP___lgt_42	;
self.final_score_43	:= 	woFDN_FLAP___lgt_43	;
self.final_score_44	:= 	woFDN_FLAP___lgt_44	;
self.final_score_45	:= 	woFDN_FLAP___lgt_45	;
self.final_score_46	:= 	woFDN_FLAP___lgt_46	;
self.final_score_47	:= 	woFDN_FLAP___lgt_47	;
self.final_score_48	:= 	woFDN_FLAP___lgt_48	;
self.final_score_49	:= 	woFDN_FLAP___lgt_49	;
self.final_score_50	:= 	woFDN_FLAP___lgt_50	;
self.final_score_51	:= 	woFDN_FLAP___lgt_51	;
self.final_score_52	:= 	woFDN_FLAP___lgt_52	;
self.final_score_53	:= 	woFDN_FLAP___lgt_53	;
self.final_score_54	:= 	woFDN_FLAP___lgt_54	;
self.final_score_55	:= 	woFDN_FLAP___lgt_55	;
self.final_score_56	:= 	woFDN_FLAP___lgt_56	;
self.final_score_57	:= 	woFDN_FLAP___lgt_57	;
self.final_score_58	:= 	woFDN_FLAP___lgt_58	;
self.final_score_59	:= 	woFDN_FLAP___lgt_59	;
self.final_score_60	:= 	woFDN_FLAP___lgt_60	;
self.final_score_61	:= 	woFDN_FLAP___lgt_61	;
self.final_score_62	:= 	woFDN_FLAP___lgt_62	;
self.final_score_63	:= 	woFDN_FLAP___lgt_63	;
self.final_score_64	:= 	woFDN_FLAP___lgt_64	;
self.final_score_65	:= 	woFDN_FLAP___lgt_65	;
self.final_score_66	:= 	woFDN_FLAP___lgt_66	;
self.final_score_67	:= 	woFDN_FLAP___lgt_67	;
self.final_score_68	:= 	woFDN_FLAP___lgt_68	;
self.final_score_69	:= 	woFDN_FLAP___lgt_69	;
self.final_score_70	:= 	woFDN_FLAP___lgt_70	;
self.final_score_71	:= 	woFDN_FLAP___lgt_71	;
self.final_score_72	:= 	woFDN_FLAP___lgt_72	;
self.final_score_73	:= 	woFDN_FLAP___lgt_73	;
self.final_score_74	:= 	woFDN_FLAP___lgt_74	;
self.final_score_75	:= 	woFDN_FLAP___lgt_75	;
self.final_score_76	:= 	woFDN_FLAP___lgt_76	;
self.final_score_77	:= 	woFDN_FLAP___lgt_77	;
self.final_score_78	:= 	woFDN_FLAP___lgt_78	;
self.final_score_79	:= 	woFDN_FLAP___lgt_79	;
self.final_score_80	:= 	woFDN_FLAP___lgt_80	;
self.final_score_81	:= 	woFDN_FLAP___lgt_81	;
self.final_score_82	:= 	woFDN_FLAP___lgt_82	;
self.final_score_83	:= 	woFDN_FLAP___lgt_83	;
self.final_score_84	:= 	woFDN_FLAP___lgt_84	;
self.final_score_85	:= 	woFDN_FLAP___lgt_85	;
self.final_score_86	:= 	woFDN_FLAP___lgt_86	;
self.final_score_87	:= 	woFDN_FLAP___lgt_87	;
self.final_score_88	:= 	woFDN_FLAP___lgt_88	;
self.final_score_89	:= 	woFDN_FLAP___lgt_89	;
self.final_score_90	:= 	woFDN_FLAP___lgt_90	;
self.final_score_91	:= 	woFDN_FLAP___lgt_91	;
self.final_score_92	:= 	woFDN_FLAP___lgt_92	;
self.final_score_93	:= 	woFDN_FLAP___lgt_93	;
self.final_score_94	:= 	woFDN_FLAP___lgt_94	;
self.final_score_95	:= 	woFDN_FLAP___lgt_95	;
self.final_score_96	:= 	woFDN_FLAP___lgt_96	;
self.final_score_97	:= 	woFDN_FLAP___lgt_97	;
self.final_score_98	:= 	woFDN_FLAP___lgt_98	;
self.final_score_99	:= 	woFDN_FLAP___lgt_99	;
self.final_score_100	:= 	woFDN_FLAP___lgt_100	;
self.final_score_101	:= 	woFDN_FLAP___lgt_101	;
self.final_score_102	:= 	woFDN_FLAP___lgt_102	;
self.final_score_103	:= 	woFDN_FLAP___lgt_103	;
self.final_score_104	:= 	woFDN_FLAP___lgt_104	;
self.final_score_105	:= 	woFDN_FLAP___lgt_105	;
self.final_score_106	:= 	woFDN_FLAP___lgt_106	;
self.final_score_107	:= 	woFDN_FLAP___lgt_107	;
self.final_score_108	:= 	woFDN_FLAP___lgt_108	;
self.final_score_109	:= 	woFDN_FLAP___lgt_109	;
self.final_score_110	:= 	woFDN_FLAP___lgt_110	;
self.final_score_111	:= 	woFDN_FLAP___lgt_111	;
self.final_score_112	:= 	woFDN_FLAP___lgt_112	;
self.final_score_113	:= 	woFDN_FLAP___lgt_113	;
self.final_score_114	:= 	woFDN_FLAP___lgt_114	;
self.final_score_115	:= 	woFDN_FLAP___lgt_115	;
self.final_score_116	:= 	woFDN_FLAP___lgt_116	;
self.final_score_117	:= 	woFDN_FLAP___lgt_117	;
self.final_score_118	:= 	woFDN_FLAP___lgt_118	;
self.final_score_119	:= 	woFDN_FLAP___lgt_119	;
self.final_score_120	:= 	woFDN_FLAP___lgt_120	;
self.final_score_121	:= 	woFDN_FLAP___lgt_121	;
self.final_score_122	:= 	woFDN_FLAP___lgt_122	;
self.final_score_123	:= 	woFDN_FLAP___lgt_123	;
self.final_score_124	:= 	woFDN_FLAP___lgt_124	;
self.final_score_125	:= 	woFDN_FLAP___lgt_125	;
self.final_score_126	:= 	woFDN_FLAP___lgt_126	;
self.final_score_127	:= 	woFDN_FLAP___lgt_127	;
self.final_score_128	:= 	woFDN_FLAP___lgt_128	;
self.final_score_129	:= 	woFDN_FLAP___lgt_129	;
self.final_score_130	:= 	woFDN_FLAP___lgt_130	;
self.final_score_131	:= 	woFDN_FLAP___lgt_131	;
self.final_score_132	:= 	woFDN_FLAP___lgt_132	;
self.final_score_133	:= 	woFDN_FLAP___lgt_133	;
self.final_score_134	:= 	woFDN_FLAP___lgt_134	;
self.final_score_135	:= 	woFDN_FLAP___lgt_135	;
self.final_score_136	:= 	woFDN_FLAP___lgt_136	;
self.final_score_137	:= 	woFDN_FLAP___lgt_137	;
self.final_score_138	:= 	woFDN_FLAP___lgt_138	;
self.final_score_139	:= 	woFDN_FLAP___lgt_139	;
self.final_score_140	:= 	woFDN_FLAP___lgt_140	;
self.final_score_141	:= 	woFDN_FLAP___lgt_141	;
self.final_score_142	:= 	woFDN_FLAP___lgt_142	;
self.final_score_143	:= 	woFDN_FLAP___lgt_143	;
self.final_score_144	:= 	woFDN_FLAP___lgt_144	;
self.final_score_145	:= 	woFDN_FLAP___lgt_145	;
self.final_score_146	:= 	woFDN_FLAP___lgt_146	;
self.final_score_147	:= 	woFDN_FLAP___lgt_147	;
self.final_score_148	:= 	woFDN_FLAP___lgt_148	;
self.final_score_149	:= 	woFDN_FLAP___lgt_149	;
self.final_score_150	:= 	woFDN_FLAP___lgt_150	;
self.final_score_151	:= 	woFDN_FLAP___lgt_151	;
self.final_score_152	:= 	woFDN_FLAP___lgt_152	;
self.final_score_153	:= 	woFDN_FLAP___lgt_153	;
self.final_score_154	:= 	woFDN_FLAP___lgt_154	;
self.final_score_155	:= 	woFDN_FLAP___lgt_155	;
self.final_score_156	:= 	woFDN_FLAP___lgt_156	;
self.final_score_157	:= 	woFDN_FLAP___lgt_157	;
self.final_score_158	:= 	woFDN_FLAP___lgt_158	;
self.final_score_159	:= 	woFDN_FLAP___lgt_159	;
self.final_score_160	:= 	woFDN_FLAP___lgt_160	;
self.final_score_161	:= 	woFDN_FLAP___lgt_161	;
self.final_score_162	:= 	woFDN_FLAP___lgt_162	;
self.final_score_163	:= 	woFDN_FLAP___lgt_163	;
self.final_score_164	:= 	woFDN_FLAP___lgt_164	;
self.final_score_165	:= 	woFDN_FLAP___lgt_165	;
self.final_score_166	:= 	woFDN_FLAP___lgt_166	;
self.final_score_167	:= 	woFDN_FLAP___lgt_167	;
self.final_score_168	:= 	woFDN_FLAP___lgt_168	;
self.final_score_169	:= 	woFDN_FLAP___lgt_169	;
self.final_score_170	:= 	woFDN_FLAP___lgt_170	;
self.final_score_171	:= 	woFDN_FLAP___lgt_171	;
self.final_score_172	:= 	woFDN_FLAP___lgt_172	;
self.final_score_173	:= 	woFDN_FLAP___lgt_173	;
self.final_score_174	:= 	woFDN_FLAP___lgt_174	;
self.final_score_175	:= 	woFDN_FLAP___lgt_175	;
self.final_score_176	:= 	woFDN_FLAP___lgt_176	;
self.final_score_177	:= 	woFDN_FLAP___lgt_177	;
self.final_score_178	:= 	woFDN_FLAP___lgt_178	;
self.final_score_179	:= 	woFDN_FLAP___lgt_179	;
self.final_score_180	:= 	woFDN_FLAP___lgt_180	;
self.final_score_181	:= 	woFDN_FLAP___lgt_181	;
self.final_score_182	:= 	woFDN_FLAP___lgt_182	;
self.final_score_183	:= 	woFDN_FLAP___lgt_183	;
self.final_score_184	:= 	woFDN_FLAP___lgt_184	;
self.final_score_185	:= 	woFDN_FLAP___lgt_185	;
self.final_score_186	:= 	woFDN_FLAP___lgt_186	;
self.final_score_187	:= 	woFDN_FLAP___lgt_187	;
self.final_score_188	:= 	woFDN_FLAP___lgt_188	;
self.final_score_189	:= 	woFDN_FLAP___lgt_189	;
self.final_score_190	:= 	woFDN_FLAP___lgt_190	;
self.final_score_191	:= 	woFDN_FLAP___lgt_191	;
self.final_score_192	:= 	woFDN_FLAP___lgt_192	;
self.final_score_193	:= 	woFDN_FLAP___lgt_193	;
self.final_score_194	:= 	woFDN_FLAP___lgt_194	;
self.final_score_195	:= 	woFDN_FLAP___lgt_195	;
self.final_score_196	:= 	woFDN_FLAP___lgt_196	;
self.final_score_197	:= 	woFDN_FLAP___lgt_197	;
self.final_score_198	:= 	woFDN_FLAP___lgt_198	;
self.final_score_199	:= 	woFDN_FLAP___lgt_199	;
self.final_score_200	:= 	woFDN_FLAP___lgt_200	;
self.final_score_201	:= 	woFDN_FLAP___lgt_201	;
self.final_score_202	:= 	woFDN_FLAP___lgt_202	;
self.final_score_203	:= 	woFDN_FLAP___lgt_203	;
self.final_score_204	:= 	woFDN_FLAP___lgt_204	;
self.final_score_205	:= 	woFDN_FLAP___lgt_205	;
self.final_score_206	:= 	woFDN_FLAP___lgt_206	;
self.final_score_207	:= 	woFDN_FLAP___lgt_207	;
self.final_score_208	:= 	woFDN_FLAP___lgt_208	;
self.final_score_209	:= 	woFDN_FLAP___lgt_209	;
self.final_score_210	:= 	woFDN_FLAP___lgt_210	;
self.final_score_211	:= 	woFDN_FLAP___lgt_211	;
self.final_score_212	:= 	woFDN_FLAP___lgt_212	;
self.final_score_213	:= 	woFDN_FLAP___lgt_213	;
self.final_score_214	:= 	woFDN_FLAP___lgt_214	;
self.final_score_215	:= 	woFDN_FLAP___lgt_215	;
self.final_score_216	:= 	woFDN_FLAP___lgt_216	;
self.final_score_217	:= 	woFDN_FLAP___lgt_217	;
self.final_score_218	:= 	woFDN_FLAP___lgt_218	;
self.final_score_219	:= 	woFDN_FLAP___lgt_219	;
self.final_score_220	:= 	woFDN_FLAP___lgt_220	;
self.final_score_221	:= 	woFDN_FLAP___lgt_221	;
self.final_score_222	:= 	woFDN_FLAP___lgt_222	;
self.final_score_223	:= 	woFDN_FLAP___lgt_223	;
self.final_score_224	:= 	woFDN_FLAP___lgt_224	;
self.final_score_225	:= 	woFDN_FLAP___lgt_225	;
self.final_score_226	:= 	woFDN_FLAP___lgt_226	;
self.final_score_227	:= 	woFDN_FLAP___lgt_227	;
self.final_score_228	:= 	woFDN_FLAP___lgt_228	;
self.final_score_229	:= 	woFDN_FLAP___lgt_229	;
self.final_score_230	:= 	woFDN_FLAP___lgt_230	;
self.final_score_231	:= 	woFDN_FLAP___lgt_231	;
self.final_score_232	:= 	woFDN_FLAP___lgt_232	;
self.final_score_233	:= 	woFDN_FLAP___lgt_233	;
self.final_score_234	:= 	woFDN_FLAP___lgt_234	;
self.final_score_235	:= 	woFDN_FLAP___lgt_235	;
self.final_score_236	:= 	woFDN_FLAP___lgt_236	;
self.final_score_237	:= 	woFDN_FLAP___lgt_237	;
self.final_score_238	:= 	woFDN_FLAP___lgt_238	;
self.final_score_239	:= 	woFDN_FLAP___lgt_239	;
self.final_score_240	:= 	woFDN_FLAP___lgt_240	;
self.final_score_241	:= 	woFDN_FLAP___lgt_241	;
self.final_score_242	:= 	woFDN_FLAP___lgt_242	;
self.final_score_243	:= 	woFDN_FLAP___lgt_243	;
self.final_score_244	:= 	woFDN_FLAP___lgt_244	;
self.final_score_245	:= 	woFDN_FLAP___lgt_245	;
self.final_score_246	:= 	woFDN_FLAP___lgt_246	;
self.final_score_247	:= 	woFDN_FLAP___lgt_247	;
self.final_score_248	:= 	woFDN_FLAP___lgt_248	;
self.final_score_249	:= 	woFDN_FLAP___lgt_249	;
self.final_score_250	:= 	woFDN_FLAP___lgt_250	;
self.final_score_251	:= 	woFDN_FLAP___lgt_251	;
self.final_score_252	:= 	woFDN_FLAP___lgt_252	;
self.final_score_253	:= 	woFDN_FLAP___lgt_253	;
self.final_score_254	:= 	woFDN_FLAP___lgt_254	;
self.final_score_255	:= 	woFDN_FLAP___lgt_255	;
self.final_score_256	:= 	woFDN_FLAP___lgt_256	;
self.final_score_257	:= 	woFDN_FLAP___lgt_257	;
self.final_score_258	:= 	woFDN_FLAP___lgt_258	;
self.final_score_259	:= 	woFDN_FLAP___lgt_259	;
self.final_score_260	:= 	woFDN_FLAP___lgt_260	;
self.final_score_261	:= 	woFDN_FLAP___lgt_261	;
self.final_score_262	:= 	woFDN_FLAP___lgt_262	;
self.final_score_263	:= 	woFDN_FLAP___lgt_263	;
self.final_score_264	:= 	woFDN_FLAP___lgt_264	;
self.final_score_265	:= 	woFDN_FLAP___lgt_265	;
self.final_score_266	:= 	woFDN_FLAP___lgt_266	;
self.final_score_267	:= 	woFDN_FLAP___lgt_267	;
self.final_score_268	:= 	woFDN_FLAP___lgt_268	;
// self.woFDN_submodel_lgt	:= 	woFDN_FLAP___lgt	;
self.FP3_woFDN_LGT		:= 	woFDN_FLAP___lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
