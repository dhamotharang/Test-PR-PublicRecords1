Import Models;

export FP31505_FLAPS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

NULL := models.common.NULL;

// *** Here begins the actual tree code that came directly from the Modeler and is unchanged...

   woFDN_FLAPS__lgt_0 :=  -2.2064558179;

// Tree: 1 
woFDN_FLAPS__lgt_1 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0413395783,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 50.45) => 0.2545717700,
      (c_fammar_p > 50.45) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0207439309,
         (f_varrisktype_i > 3.5) => 0.2421857130,
         (f_varrisktype_i = NULL) => 0.0409106007, 0.0409106007),
      (c_fammar_p = NULL) => -0.0363853074, 0.0611352585),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.1895953158,
      (f_srchvelocityrisktype_i > 5.5) => 0.5468113363,
      (f_srchvelocityrisktype_i = NULL) => 0.3421713893, 0.3421713893),
   (f_inq_Communications_count_i = NULL) => 0.3050346590, 0.1117720452),
(nf_seg_FraudPoint_3_0 = '') => -0.0016766067, -0.0016766067);

// Tree: 2 
woFDN_FLAPS__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.1140419844,
      (f_rel_felony_count_i > 1.5) => 0.5119707232,
      (f_rel_felony_count_i = NULL) => 0.1472027126, 0.1472027126),
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0372312377,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1941877054,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0321900608, -0.0321900608),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0223794002, -0.0223794002),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.1585291567,
   (f_hh_payday_loan_users_i > 0.5) => 0.4668387053,
   (f_hh_payday_loan_users_i = NULL) => 0.2101290811, 0.2101290811),
(f_varrisktype_i = NULL) => 0.2066919836, -0.0072507890);

// Tree: 3 
woFDN_FLAPS__lgt_3 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0336471330,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.6) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => 0.0127617038,
         (f_srchcomponentrisktype_i > 2.5) => 0.3260769148,
         (f_srchcomponentrisktype_i = NULL) => 0.0213066641, 0.0213066641),
      (c_famotf18_p > 29.6) => 0.1927677379,
      (c_famotf18_p = NULL) => -0.0330107953, 0.0366941624),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.1439879174,
      (f_inq_count_i > 8.5) => 0.3321839462,
      (f_inq_count_i = NULL) => 0.1997630311, 0.1997630311),
   (f_inq_Communications_count_i = NULL) => 0.1307394319, 0.0650900322),
(nf_seg_FraudPoint_3_0 = '') => -0.0077427352, -0.0077427352);

// Tree: 4 
woFDN_FLAPS__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0363266315,
   (f_corrrisktype_i > 7.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 18.55) => 0.0419471181,
      (c_famotf18_p > 18.55) => 0.2037674797,
      (c_famotf18_p = NULL) => -0.0397867655, 0.0696467700),
   (f_corrrisktype_i = NULL) => -0.0237635230, -0.0237635230),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0324164239,
      (f_assocrisktype_i > 4.5) => 0.1789378652,
      (f_assocrisktype_i = NULL) => 0.0697829453, 0.0697829453),
   (f_varrisktype_i > 4.5) => 0.2543230504,
   (f_varrisktype_i = NULL) => 0.0895387858, 0.0895387858),
(f_srchvelocityrisktype_i = NULL) => 0.1352653814, -0.0078250130);

// Tree: 5 
woFDN_FLAPS__lgt_5 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 30.5) => 0.2536527795,
      (c_born_usa > 30.5) => 0.0486742114,
      (c_born_usa = NULL) => 0.0955477133, 0.0955477133),
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0341867829,
      (k_inq_per_addr_i > 3.5) => 0.0687539112,
      (k_inq_per_addr_i = NULL) => -0.0248028480, -0.0248028480),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0184981541, -0.0184981541),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 4.5) => 0.0443057256,
   (f_assocrisktype_i > 4.5) => 0.2016895333,
   (f_assocrisktype_i = NULL) => 0.0817460332, 0.0817460332),
(f_varrisktype_i = NULL) => 0.1002323971, -0.0062516664);

// Tree: 6 
woFDN_FLAPS__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1575630611,
      (r_F01_inp_addr_address_score_d > 95) => 0.0148064731,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0317803561, 0.0317803561),
   (f_phone_ver_experian_d > 0.5) => -0.0525244678,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => -0.0240313843,
      (f_assocrisktype_i > 7.5) => 0.2030389233,
      (f_assocrisktype_i = NULL) => -0.0098069647, -0.0098069647), -0.0162959372),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 0.1861024065,
   (r_I60_inq_comm_recency_d > 549) => 0.0907236901,
   (r_I60_inq_comm_recency_d = NULL) => 0.1283982831, 0.1283982831),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0764638236, -0.0108191806);

// Tree: 7 
woFDN_FLAPS__lgt_7 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0590819771,
         (f_corrphonelastnamecount_d > 0.5) => -0.0368651697,
         (f_corrphonelastnamecount_d = NULL) => 0.0176060410, 0.0176060410),
      (k_inq_per_phone_i > 2.5) => 0.2592880142,
      (k_inq_per_phone_i = NULL) => 0.0275064174, 0.0275064174),
   (f_phone_ver_experian_d > 0.5) => -0.0485219976,
   (f_phone_ver_experian_d = NULL) => -0.0019864391, -0.0146100391),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_employees and c_employees <= 38.5) => 0.3124007144,
   (c_employees > 38.5) => 0.0816108076,
   (c_employees = NULL) => 0.1255171802, 0.1255171802),
(f_inq_Communications_count_i = NULL) => 0.0611015590, -0.0092795901);

// Tree: 8 
woFDN_FLAPS__lgt_8 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0371826206,
      (r_L79_adls_per_addr_c6_i > 3.5) => 0.2008799578,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0564345083, 0.0564345083),
   (c_fammar_p > 59.25) => -0.0322459038,
   (c_fammar_p = NULL) => -0.0461931759, -0.0207698617),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 0.0437660975,
   (f_assocrisktype_i > 5.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 20.5) => 0.1113521113,
      (c_hval_150k_p > 20.5) => 0.2824748490,
      (c_hval_150k_p = NULL) => 0.1363585859, 0.1363585859),
   (f_assocrisktype_i = NULL) => 0.0635710722, 0.0635710722),
(f_srchvelocityrisktype_i = NULL) => 0.0417312146, -0.0092825855);

// Tree: 9 
woFDN_FLAPS__lgt_9 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 15.5) => 0.1031659151,
   (f_rel_under500miles_cnt_d > 15.5) => 0.2261229642,
   (f_rel_under500miles_cnt_d = NULL) => 0.1395583750, 0.1395583750),
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1482680580,
      (r_F01_inp_addr_address_score_d > 75) => 0.0436057878,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0550724200, 0.0550724200),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0280291951,
      (k_inq_per_phone_i > 2.5) => 0.0960200875,
      (k_inq_per_phone_i = NULL) => -0.0225681370, -0.0225681370),
   (c_fammar_p = NULL) => -0.0387967076, -0.0115977946),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0987337571, -0.0064117663);

// Tree: 10 
woFDN_FLAPS__lgt_10 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0277030287,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0250622131,
      (f_rel_felony_count_i > 2.5) => 0.1896140734,
      (f_rel_felony_count_i = NULL) => 0.0307153926, 0.0307153926),
   (nf_seg_FraudPoint_3_0 = '') => -0.0134101327, -0.0134101327),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1659816978,
   (f_phone_ver_experian_d > 0.5) => 0.0107692297,
   (f_phone_ver_experian_d = NULL) => 0.1586706245, 0.1116240789),
(f_inq_Communications_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0752051209,
   (f_addrs_per_ssn_i > 4.5) => 0.1586062852,
   (f_addrs_per_ssn_i = NULL) => 0.0356537354, 0.0356537354), -0.0086835851);

// Tree: 11 
woFDN_FLAPS__lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.3099610029,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
         map(
         (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.1657892339,
         (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0210825693,
         (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0191171935, -0.0191171935),
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.0759413779,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0165652855, -0.0165652855),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0108990032, -0.0145607150),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1925409240,
   (f_phone_ver_experian_d > 0.5) => 0.0412443933,
   (f_phone_ver_experian_d = NULL) => 0.1933453836, 0.1203994744),
(k_inq_ssns_per_addr_i = NULL) => -0.0082834969, -0.0082834969);

// Tree: 12 
woFDN_FLAPS__lgt_12 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.95) => 0.1195298479,
      (c_fammar_p > 44.95) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0612278136,
         (f_phone_ver_experian_d > 0.5) => -0.0434318383,
         (f_phone_ver_experian_d = NULL) => 0.0052544407, 0.0196536586),
      (c_fammar_p = NULL) => -0.0524978626, 0.0236715755),
   (k_nap_phn_verd_d > 0.5) => -0.0358714159,
   (k_nap_phn_verd_d = NULL) => -0.0129357598, -0.0129357598),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 34.5) => 0.1661533490,
   (f_mos_inq_banko_om_fseen_d > 34.5) => 0.0396523785,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0906091075, 0.0906091075),
(f_srchfraudsrchcount_i = NULL) => 0.0689700286, -0.0092760585);

// Tree: 13 
woFDN_FLAPS__lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0649641345,
   (c_fammar_p > 51.45) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 
            map(
            (NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => -0.0464295497,
            (f_corrrisktype_i > 3.5) => 0.0384126811,
            (f_corrrisktype_i = NULL) => 0.0112512281, 0.0112512281),
         (f_srchaddrsrchcount_i > 15.5) => 0.1738836692,
         (f_srchaddrsrchcount_i = NULL) => 0.0152961173, 0.0152961173),
      (f_phone_ver_experian_d > 0.5) => -0.0409445699,
      (f_phone_ver_experian_d = NULL) => -0.0200103328, -0.0191034195),
   (c_fammar_p = NULL) => -0.0490946214, -0.0128156546),
(f_assocsuspicousidcount_i > 13.5) => 0.2194270252,
(f_assocsuspicousidcount_i = NULL) => 0.0475187385, -0.0103206161);

// Tree: 14 
woFDN_FLAPS__lgt_14 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -14793) => 0.1446371297,
         (f_addrchangeincomediff_d > -14793) => 0.0047146591,
         (f_addrchangeincomediff_d = NULL) => 0.0051903795, 0.0086041171),
      (f_corrphonelastnamecount_d > 0.5) => -0.0344184408,
      (f_corrphonelastnamecount_d = NULL) => -0.0156464945, -0.0156464945),
   (f_srchcomponentrisktype_i > 1.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0343855927,
      (r_C23_inp_addr_occ_index_d > 2) => 0.1795423945,
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0811098851, 0.0811098851),
   (f_srchcomponentrisktype_i = NULL) => -0.0119424836, -0.0119424836),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1064325074,
(f_inq_PrepaidCards_count_i = NULL) => 0.0214921780, -0.0081772405);

// Tree: 15 
woFDN_FLAPS__lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.05) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0133266830,
      (f_idverrisktype_i > 1.5) => 0.0684251363,
      (f_idverrisktype_i = NULL) => 0.0361114990, 0.0361114990),
   (k_comb_age_d > 68.5) => 0.2921941473,
   (k_comb_age_d = NULL) => 0.0476886998, 0.0476886998),
(c_fammar_p > 61.05) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => -0.0250729365,
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 3.5) => 0.0221177266,
      (f_srchssnsrchcount_i > 3.5) => 0.1343890822,
      (f_srchssnsrchcount_i = NULL) => 0.0491253489, 0.0491253489),
   (f_varrisktype_i = NULL) => 0.0283787324, -0.0210355014),
(c_fammar_p = NULL) => -0.0239725701, -0.0099711092);

// Tree: 16 
woFDN_FLAPS__lgt_16 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 19.05) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 1.05) => 0.1552970513,
      (C_INC_150K_P > 1.05) => 0.0451559207,
      (C_INC_150K_P = NULL) => 0.0598777550, 0.0598777550),
   (c_hval_200k_p > 19.05) => 0.2702615821,
   (c_hval_200k_p = NULL) => 0.0109617891, 0.0671880072),
(f_corrssnaddrcount_d > 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 2.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 0.0961693213,
      (r_C10_M_Hdr_FS_d > 11.5) => -0.0150310816,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0123570427, -0.0123570427),
   (f_inq_Communications_count_i > 2.5) => 0.0958559289,
   (f_inq_Communications_count_i = NULL) => -0.0105563364, -0.0105563364),
(f_corrssnaddrcount_d = NULL) => 0.0193095942, -0.0031949573);

// Tree: 17 
woFDN_FLAPS__lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => -0.0256657903,
      (r_D33_eviction_count_i > 0.5) => 0.0562440858,
      (r_D33_eviction_count_i = NULL) => -0.0160411503, -0.0226643692),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 0.0393529731,
      (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => 0.2521821264,
      (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.1090728681, 0.1090728681),
   (k_nap_contradictory_i = NULL) => -0.0205051250, -0.0205051250),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0399471006,
   (f_hh_payday_loan_users_i > 0.5) => 0.1196335092,
   (f_hh_payday_loan_users_i = NULL) => 0.0528443228, 0.0528443228),
(k_inq_per_addr_i = NULL) => -0.0124213624, -0.0124213624);

// Tree: 18 
woFDN_FLAPS__lgt_18 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => -0.0195523316,
   (k_inq_per_phone_i > 5.5) => 0.1079772942,
   (k_inq_per_phone_i = NULL) => -0.0175430955, -0.0175430955),
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 0.0457538427,
      (k_inq_per_ssn_i > 2.5) => 0.1683661469,
      (k_inq_per_ssn_i = NULL) => 0.0587333569, 0.0587333569),
   (f_phone_ver_experian_d > 0.5) => -0.0303644474,
   (f_phone_ver_experian_d = NULL) => 0.0567623175, 0.0317137889),
(f_corrrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0850364932,
   (f_addrs_per_ssn_i > 3.5) => 0.1250063529,
   (f_addrs_per_ssn_i = NULL) => 0.0246318955, 0.0246318955), -0.0075373527);

// Tree: 19 
woFDN_FLAPS__lgt_19 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 0.0149055668,
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0624375688,
         (r_Phn_Cell_n > 0.5) => 0.3262432527,
         (r_Phn_Cell_n = NULL) => 0.1635367531, 0.1635367531),
      (k_inq_per_phone_i = NULL) => 0.0204634280, 0.0204634280),
   (f_rel_felony_count_i > 1.5) => 0.1330893837,
   (f_rel_felony_count_i = NULL) => 0.0532770825, 0.0273880665),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => -0.0211002583,
   (r_D33_eviction_count_i > 2.5) => 0.1603297695,
   (r_D33_eviction_count_i = NULL) => -0.0196634641, -0.0196634641),
(k_nap_phn_verd_d = NULL) => -0.0017775768, -0.0017775768);

// Tree: 20 
woFDN_FLAPS__lgt_20 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0180009238,
   (k_inq_per_addr_i > 3.5) => 0.0547057379,
   (k_inq_per_addr_i = NULL) => -0.0122207274, -0.0122207274),
(f_divrisktype_i > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -580) => 0.1625913408,
   (f_addrchangeincomediff_d > -580) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.1011779514,
      (f_prevaddrstatus_i > 2.5) => 0.0095388602,
      (f_prevaddrstatus_i = NULL) => -0.0013082817, 0.0320741313),
   (f_addrchangeincomediff_d = NULL) => 0.1075271405, 0.0550646709),
(f_divrisktype_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 96.5) => -0.0691397453,
   (c_burglary > 96.5) => 0.0982669082,
   (c_burglary = NULL) => 0.0168258335, 0.0168258335), -0.0025982722);

// Tree: 21 
woFDN_FLAPS__lgt_21 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0306009200,
      (f_corrssnaddrcount_d > 2.5) => -0.0300159678,
      (f_corrssnaddrcount_d = NULL) => -0.0242530946, -0.0242530946),
   (f_srchaddrsrchcount_i > 4.5) => 
      map(
      (NULL < c_professional and c_professional <= 1.65) => 0.0772176709,
      (c_professional > 1.65) => 0.0002108645,
      (c_professional = NULL) => 0.0276580696, 0.0276580696),
   (f_srchaddrsrchcount_i = NULL) => -0.0285026076, -0.0156526228),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 82096.5) => 0.2223756640,
   (r_L80_Inp_AVM_AutoVal_d > 82096.5) => 0.0672078092,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0365499795, 0.0630164518),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0117145178, -0.0117145178);

// Tree: 22 
woFDN_FLAPS__lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1986245308,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0213327768,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 10866) => 
            map(
            (NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 0.0875794951,
            (r_A41_Prop_Owner_d > 0.5) => 0.0083706581,
            (r_A41_Prop_Owner_d = NULL) => 0.0252675239, 0.0252675239),
         (f_addrchangeincomediff_d > 10866) => 0.1802362199,
         (f_addrchangeincomediff_d = NULL) => 0.0078533335, 0.0266558064),
      (f_assocrisktype_i = NULL) => -0.0100769622, -0.0100769622),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0089688127, -0.0089688127),
(r_D33_eviction_count_i > 2.5) => 0.1407365517,
(r_D33_eviction_count_i = NULL) => -0.0028002411, -0.0073285355);

// Tree: 23 
woFDN_FLAPS__lgt_23 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 0.0196784974,
   (k_inq_per_phone_i > 5.5) => 0.1780454686,
   (k_inq_per_phone_i = NULL) => 0.0222663211, 0.0222663211),
(f_phone_ver_experian_d > 0.5) => -0.0313854597,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
      map(
      (NULL < c_business and c_business <= 2.5) => 0.1444265376,
      (c_business > 2.5) => -0.0166703396,
      (c_business = NULL) => -0.0939718250, -0.0064781939),
   (f_assocrisktype_i > 8.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52.15) => 0.2423509438,
      (r_C12_source_profile_d > 52.15) => 0.0437432017,
      (r_C12_source_profile_d = NULL) => 0.1228876403, 0.1228876403),
   (f_assocrisktype_i = NULL) => 0.0215316714, 0.0007568087), -0.0072758773);

// Tree: 24 
woFDN_FLAPS__lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => -0.0165180871,
   (c_unemp > 8.95) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0511347601,
      (f_corrrisktype_i > 7.5) => 0.1528437193,
      (f_corrrisktype_i = NULL) => 0.0682202572, 0.0682202572),
   (c_unemp = NULL) => -0.0247946510, -0.0129015273),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 59.5) => 0.0152249446,
      (k_comb_age_d > 59.5) => 0.1666515539,
      (k_comb_age_d = NULL) => 0.0308991661, 0.0308991661),
   (f_rel_felony_count_i > 0.5) => 0.1156475378,
   (f_rel_felony_count_i = NULL) => 0.0461601275, 0.0461601275),
(k_inq_per_addr_i = NULL) => -0.0065367435, -0.0065367435);

// Tree: 25 
woFDN_FLAPS__lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0055692509,
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 0.0491898148,
      (f_phones_per_addr_curr_i > 9.5) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 2.5) => 0.2424608728,
         (f_rel_incomeover75_count_d > 2.5) => 0.0823338855,
         (f_rel_incomeover75_count_d = NULL) => 0.1576253828, 0.1576253828),
      (f_phones_per_addr_curr_i = NULL) => 0.0621642765, 0.0621642765),
   (f_assocrisktype_i = NULL) => 0.0503435201, 0.0210882000),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0256938145,
   (r_D33_eviction_count_i > 3.5) => 0.1132370931,
   (r_D33_eviction_count_i = NULL) => -0.0247871636, -0.0247871636),
(k_nap_phn_verd_d = NULL) => -0.0072977463, -0.0072977463);

// Tree: 26 
woFDN_FLAPS__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.05) => -0.0077726529,
   (c_famotf18_p > 27.05) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.45) => 0.0214431354,
      (c_pop_6_11_p > 10.45) => 
         map(
         (NULL < c_no_move and c_no_move <= 133.5) => 0.0593490496,
         (c_no_move > 133.5) => 0.2119654443,
         (c_no_move = NULL) => 0.1028685684, 0.1028685684),
      (c_pop_6_11_p = NULL) => 0.0402902519, 0.0402902519),
   (c_famotf18_p = NULL) => -0.0050527848, -0.0034248174),
(r_D30_Derog_Count_i > 11.5) => 0.1254138092,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 78) => -0.0635837367,
   (c_burglary > 78) => 0.0809668175,
   (c_burglary = NULL) => 0.0086915404, 0.0086915404), -0.0015810305);

// Tree: 27 
woFDN_FLAPS__lgt_27 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0688204252,
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 46.85) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 0.0286536862,
      (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 0.1590062598,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0498404682, 0.0498404682),
   (c_fammar_p > 46.85) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0272921534,
         (k_comb_age_d > 68.5) => 0.0759283216,
         (k_comb_age_d = NULL) => -0.0203154905, -0.0203154905),
      (k_inq_ssns_per_addr_i > 1.5) => 0.0359767426,
      (k_inq_ssns_per_addr_i = NULL) => -0.0131179162, -0.0131179162),
   (c_fammar_p = NULL) => -0.0189613422, -0.0094697791),
(r_D33_Eviction_Recency_d = NULL) => 0.0229481897, -0.0062297789);

// Tree: 28 
woFDN_FLAPS__lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1566078422,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62814) => 0.1662892476,
         (f_addrchangevaluediff_d > -62814) => 0.0084807374,
         (f_addrchangevaluediff_d = NULL) => 0.0282006990, 0.0180333668),
      (f_phone_ver_experian_d > 0.5) => -0.0355131260,
      (f_phone_ver_experian_d = NULL) => 0.0010862848, -0.0107443288),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0097884153, -0.0097884153),
(r_D33_eviction_count_i > 2.5) => 0.1058407658,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 88) => -0.0682421468,
   (c_assault > 88) => 0.0996912261,
   (c_assault = NULL) => 0.0074035167, 0.0074035167), -0.0083796770);

// Tree: 29 
woFDN_FLAPS__lgt_29 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1124096805,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0122537872,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0115895832, -0.0115895832),
      (k_comb_age_d > 67.5) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 182.5) => 0.0483432914,
         (c_sub_bus > 182.5) => 0.2613322539,
         (c_sub_bus = NULL) => 0.0635749216, 0.0635749216),
      (k_comb_age_d = NULL) => -0.0063266636, -0.0063266636),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1249356225,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0235952056, -0.0059323969),
(k_nap_contradictory_i > 0.5) => 0.1048648394,
(k_nap_contradictory_i = NULL) => -0.0040370087, -0.0040370087);

// Tree: 30 
woFDN_FLAPS__lgt_30 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 92) => 0.1588420963,
   (r_D32_Mos_Since_Fel_LS_d > 92) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => -0.0152958588,
      (k_inq_per_ssn_i > 3.5) => 0.0408188765,
      (k_inq_per_ssn_i = NULL) => -0.0112233891, -0.0112233891),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0103841122, -0.0103841122),
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 613) => 0.1679524197,
   (c_popover25 > 613) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0995076656,
      (r_Phn_Cell_n > 0.5) => -0.0166102092,
      (r_Phn_Cell_n = NULL) => 0.0373134763, 0.0373134763),
   (c_popover25 = NULL) => 0.0569251336, 0.0569251336),
(f_srchaddrsrchcount_i = NULL) => -0.0054299280, -0.0081432095);

// Tree: 31 
woFDN_FLAPS__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.35) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1112646812,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0124252090,
         (k_comb_age_d > 68.5) => 0.0696871919,
         (k_comb_age_d = NULL) => -0.0071484159, -0.0071484159),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0065565062, -0.0065565062),
   (c_unemp > 8.35) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0206396962,
      (f_rel_criminal_count_i > 2.5) => 0.0993020009,
      (f_rel_criminal_count_i = NULL) => 0.0453513555, 0.0453513555),
   (c_unemp = NULL) => -0.0360333558, -0.0037495644),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1749520238,
(f_inq_PrepaidCards_count_i = NULL) => 0.0052190697, -0.0029194909);

// Tree: 32 
woFDN_FLAPS__lgt_32 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 13.7) => 0.1560787207,
   (c_hh4_p > 13.7) => 0.0207921515,
   (c_hh4_p = NULL) => 0.0924671551, 0.0924671551),
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0119055283,
   (f_phones_per_addr_curr_i > 7.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => 0.0337135774,
      (k_inq_per_phone_i > 4.5) => 0.1549177949,
      (k_inq_per_phone_i = NULL) => 0.0374636203, 0.0374636203),
   (f_phones_per_addr_curr_i = NULL) => -0.0050898166, -0.0050898166),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0499872989,
   (c_assault > 90) => 0.0964698564,
   (c_assault = NULL) => 0.0145531425, 0.0145531425), -0.0037149756);

// Tree: 33 
woFDN_FLAPS__lgt_33 := map(
(NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => -0.0132965656,
(f_rel_criminal_count_i > 2.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 3.5) => 
      map(
      (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 0.0149118439,
      (f_util_add_input_conv_n > 0.5) => 
         map(
         (NULL < C_INC_201K_P and C_INC_201K_P <= 4.95) => 0.1438772478,
         (C_INC_201K_P > 4.95) => 0.0148990740,
         (C_INC_201K_P = NULL) => 0.1048586406, 0.1048586406),
      (f_util_add_input_conv_n = NULL) => 0.0630651795, 0.0630651795),
   (f_corrssnaddrcount_d > 3.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 7.75) => -0.0002956768,
      (c_hh7p_p > 7.75) => 0.1585903248,
      (c_hh7p_p = NULL) => 0.0076418966, 0.0076418966),
   (f_corrssnaddrcount_d = NULL) => 0.0227712302, 0.0227712302),
(f_rel_criminal_count_i = NULL) => -0.0149943323, -0.0040311545);

// Tree: 34 
woFDN_FLAPS__lgt_34 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -1) => 0.1247356713,
      (f_addrchangecrimediff_i > -1) => 
         map(
         (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0167642988,
         (r_L70_Add_Standardized_i > 0.5) => 0.1838365373,
         (r_L70_Add_Standardized_i = NULL) => 0.0270865964, 0.0270865964),
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.35) => 0.0135640546,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.35) => 0.2438649353,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0296020255, 0.0538519433), 0.0401260623),
   (f_phone_ver_experian_d > 0.5) => -0.0252550983,
   (f_phone_ver_experian_d = NULL) => 0.0115207762, 0.0119324562),
(f_corrphonelastnamecount_d > 0.5) => -0.0199308089,
(f_corrphonelastnamecount_d = NULL) => -0.0054447990, -0.0059124094);

// Tree: 35 
woFDN_FLAPS__lgt_35 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
   map(
   (NULL < c_urban_p and c_urban_p <= 95.35) => -0.0472299688,
   (c_urban_p > 95.35) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 84.5) => 0.1607785946,
      (c_rest_indx > 84.5) => 0.0475844337,
      (c_rest_indx = NULL) => 0.0788293111, 0.0788293111),
   (c_urban_p = NULL) => 0.0729410370, 0.0489906558),
(f_corrssnaddrcount_d > 1.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => -0.0099280685,
   (f_hh_tot_derog_i > 5.5) => 0.0708517455,
   (f_hh_tot_derog_i = NULL) => -0.0075625284, -0.0075625284),
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0736128228,
   (f_addrs_per_ssn_i > 5.5) => 0.0678661929,
   (f_addrs_per_ssn_i = NULL) => -0.0035344318, -0.0035344318), -0.0047376723);

// Tree: 36 
woFDN_FLAPS__lgt_36 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0244377334,
   (f_hh_criminals_i > 0.5) => 0.0170013476,
   (f_hh_criminals_i = NULL) => -0.0110129373, -0.0110129373),
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < c_finance and c_finance <= 1.85) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 113.5) => 0.2545442853,
         (c_bel_edu > 113.5) => 0.0646724463,
         (c_bel_edu = NULL) => 0.1680847872, 0.1680847872),
      (c_finance > 1.85) => 0.0374125817,
      (c_finance = NULL) => 0.1013221320, 0.1013221320),
   (f_corrphonelastnamecount_d > 0.5) => 0.0203135756,
   (f_corrphonelastnamecount_d = NULL) => 0.0591441233, 0.0591441233),
(f_srchcomponentrisktype_i = NULL) => -0.0122197951, -0.0083459681);

// Tree: 37 
woFDN_FLAPS__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0105751865,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 5.5) => 0.0150951557,
      (f_util_adl_count_n > 5.5) => 0.0990330364,
      (f_util_adl_count_n = NULL) => 0.0225266850, 0.0225266850),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.3) => 0.1598941424,
      (c_rnt500_p > 3.3) => 0.0156435266,
      (c_rnt500_p = NULL) => 0.0790059467, 0.0790059467),
   (f_varrisktype_i = NULL) => 0.0256564458, 0.0256564458),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0841926492,
   (r_S66_adlperssn_count_i > 1.5) => 0.0690599874,
   (r_S66_adlperssn_count_i = NULL) => 0.0058871449, 0.0058871449), 0.0008313414);

// Tree: 38 
woFDN_FLAPS__lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0147420446,
      (f_assocsuspicousidcount_i > 15.5) => 0.1342106184,
      (f_assocsuspicousidcount_i = NULL) => -0.0139752750, -0.0139752750),
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -69798) => 0.1205635528,
      (f_addrchangevaluediff_d > -69798) => 0.0192287965,
      (f_addrchangevaluediff_d = NULL) => 0.0359327071, 0.0250518543),
   (f_inq_Other_count_i = NULL) => -0.0052689349, -0.0052689349),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1127767573,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1262) => 0.0716424010,
   (c_popover18 > 1262) => -0.0646170061,
   (c_popover18 = NULL) => 0.0004981088, 0.0004981088), -0.0046192540);

// Tree: 39 
woFDN_FLAPS__lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0088026588,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < c_food and c_food <= 15) => 0.1632478051,
      (c_food > 15) => -0.0072951791,
      (c_food = NULL) => 0.0645123932, 0.0645123932),
   (k_inq_per_phone_i = NULL) => -0.0070162489, -0.0070162489),
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.1148480527,
      (f_inq_count_i > 2.5) => 0.0137229443,
      (f_inq_count_i = NULL) => 0.0331139445, 0.0331139445),
   (k_comb_age_d > 68.5) => 0.2631298919,
   (k_comb_age_d = NULL) => 0.0429501528, 0.0429501528),
(k_inq_per_ssn_i = NULL) => -0.0010210685, -0.0010210685);

// Tree: 40 
woFDN_FLAPS__lgt_40 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0033698457,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 9.5) => 0.1275655790,
         (f_M_Bureau_ADL_FS_noTU_d > 9.5) => 
            map(
            (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0536460637,
            (f_phone_ver_experian_d > 0.5) => -0.0130133609,
            (f_phone_ver_experian_d = NULL) => 0.0265061881, 0.0220341500),
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0268041888, 0.0268041888),
      (k_comb_age_d > 73.5) => 0.2211492931,
      (k_comb_age_d = NULL) => 0.0329610157, 0.0329610157),
   (k_inq_per_ssn_i = NULL) => 0.0101807974, 0.0101807974),
(f_phone_ver_insurance_d > 3.5) => -0.0215798374,
(f_phone_ver_insurance_d = NULL) => 0.0188796630, -0.0051341481);

// Tree: 41 
woFDN_FLAPS__lgt_41 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_health and c_health <= 7.2) => 0.2269819111,
      (c_health > 7.2) => 0.0464890457,
      (c_health = NULL) => 0.1305115865, 0.1305115865),
   (f_phone_ver_experian_d > 0.5) => -0.0419476731,
   (f_phone_ver_experian_d = NULL) => 0.0845638378, 0.0570421430),
(r_D32_Mos_Since_Crim_LS_d > 14.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0140832029,
   (k_inq_per_phone_i > 1.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 0.0947001174,
      (f_inq_count24_i > 1.5) => -0.0017765646,
      (f_inq_count24_i = NULL) => 0.0298251208, 0.0298251208),
   (k_inq_per_phone_i = NULL) => -0.0097545151, -0.0097545151),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0181824234, -0.0080080585);

// Tree: 42 
woFDN_FLAPS__lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1322610982,
(r_D32_Mos_Since_Fel_LS_d > 125) => 
   map(
   (NULL < c_employees and c_employees <= 40.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.75) => 0.0205432809,
      (c_unemp > 9.75) => 
         map(
         (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 7764) => -0.0180375666,
         (r_A50_pb_total_dollars_d > 7764) => 0.1604472429,
         (r_A50_pb_total_dollars_d = NULL) => 0.0967838713, 0.0967838713),
      (c_unemp = NULL) => 0.0284181314, 0.0284181314),
   (c_employees > 40.5) => -0.0083728444,
   (c_employees = NULL) => -0.0408937207, -0.0046104143),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0614976665,
   (c_many_cars > 91.5) => -0.0702297207,
   (c_many_cars = NULL) => -0.0108930598, -0.0108930598), -0.0038919755);

// Tree: 43 
woFDN_FLAPS__lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0091924196,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 6.5) => -0.0184680840,
      (f_rel_homeover50_count_d > 6.5) => 0.2228050633,
      (f_rel_homeover50_count_d = NULL) => 0.0985128359, 0.0985128359),
   (f_nae_nothing_found_i = NULL) => -0.0078308232, -0.0078308232),
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.1532779549,
   (r_C21_M_Bureau_ADL_FS_d > 7.5) => 0.0292998204,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0330198798, 0.0330198798),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 8.6) => -0.0668102280,
   (c_famotf18_p > 8.6) => 0.0514905599,
   (c_famotf18_p = NULL) => -0.0022825255, -0.0022825255), -0.0021995798);

// Tree: 44 
woFDN_FLAPS__lgt_44 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0363751102,
      (r_C14_Addr_Stability_v2_d > 3.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 34.5) => 0.1646482897,
         (c_born_usa > 34.5) => 0.0157228050,
         (c_born_usa = NULL) => -0.0117513805, 0.0358161067),
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0053223808, 0.0053223808),
   (f_util_add_input_conv_n > 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -11254.5) => 0.1513669529,
      (f_addrchangevaluediff_d > -11254.5) => 0.0395024022,
      (f_addrchangevaluediff_d = NULL) => 0.1355457149, 0.0798761964),
   (f_util_add_input_conv_n = NULL) => 0.0330354418, 0.0330354418),
(f_corrssnaddrcount_d > 2.5) => -0.0078958801,
(f_corrssnaddrcount_d = NULL) => 0.0038151781, -0.0039807646);

// Tree: 45 
woFDN_FLAPS__lgt_45 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 2.05) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0133379545,
   (f_corrrisktype_i > 7.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 44.5) => 0.0075624634,
      (k_comb_age_d > 44.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 8.15) => 0.0592604591,
         (c_hval_175k_p > 8.15) => 0.2138459056,
         (c_hval_175k_p = NULL) => 0.1103096065, 0.1103096065),
      (k_comb_age_d = NULL) => 0.0296090061, 0.0296090061),
   (f_corrrisktype_i = NULL) => 0.0069962719, -0.0086800810),
(c_hh7p_p > 2.05) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 21.5) => 0.0252004407,
   (f_srchaddrsrchcount_i > 21.5) => 0.1487075705,
   (f_srchaddrsrchcount_i = NULL) => 0.0275572740, 0.0275572740),
(c_hh7p_p = NULL) => -0.0487519196, -0.0017385917);

// Tree: 46 
woFDN_FLAPS__lgt_46 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 3.85) => -0.0121515236,
   (c_hh5_p > 3.85) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 100) => 0.0198032950,
      (c_cartheft > 100) => 
         map(
         (NULL < c_employees and c_employees <= 62.5) => 0.1741564160,
         (c_employees > 62.5) => 0.0720123403,
         (c_employees = NULL) => 0.0971351551, 0.0971351551),
      (c_cartheft = NULL) => 0.0547383020, 0.0547383020),
   (c_hh5_p = NULL) => 0.0562973476, 0.0270582286),
(r_F01_inp_addr_address_score_d > 95) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 224) => 0.1022491296,
   (r_D32_Mos_Since_Fel_LS_d > 224) => -0.0051892792,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0042140440, -0.0042140440),
(r_F01_inp_addr_address_score_d = NULL) => -0.0201826621, -0.0011321604);

// Tree: 47 
woFDN_FLAPS__lgt_47 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0047993754,
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 23.1) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 57.25) => 0.0083200109,
         (c_low_ed > 57.25) => 0.1541922327,
         (c_low_ed = NULL) => 0.0374944553, 0.0374944553),
      (c_hval_500k_p > 23.1) => 0.3027860101,
      (c_hval_500k_p = NULL) => 0.0619292037, 0.0619292037),
   (k_comb_age_d = NULL) => -0.0006131140, -0.0006131140),
(f_assocsuspicousidcount_i > 13.5) => 0.1022063547,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 87.5) => 0.0452444655,
   (c_rich_wht > 87.5) => -0.0660296410,
   (c_rich_wht = NULL) => -0.0124532193, -0.0124532193), 0.0000891718);

// Tree: 48 
woFDN_FLAPS__lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0073308895,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 33.4) => -0.0162976483,
      (c_low_ed > 33.4) => 0.1319923070,
      (c_low_ed = NULL) => 0.0745396542, 0.0745396542),
   (k_nap_contradictory_i = NULL) => -0.0059458998, -0.0059458998),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 29.55) => 0.0097718821,
   (c_rnt1000_p > 29.55) => 
      map(
      (NULL < c_totsales and c_totsales <= 3474) => 0.2152437421,
      (c_totsales > 3474) => 0.0602089582,
      (c_totsales = NULL) => 0.1211474860, 0.1211474860),
   (c_rnt1000_p = NULL) => 0.0410510696, 0.0410510696),
(k_inq_per_phone_i = NULL) => -0.0036266170, -0.0036266170);

// Tree: 49 
woFDN_FLAPS__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0012850433,
      (f_hh_criminals_i > 3.5) => 0.1369467410,
      (f_hh_criminals_i = NULL) => 0.0002739167, 0.0002739167),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1533610746,
      (r_C10_M_Hdr_FS_d > 33) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 103.5) => -0.0207789321,
         (c_sub_bus > 103.5) => 0.0743417200,
         (c_sub_bus = NULL) => 0.0377928980, 0.0377928980),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0634987168, 0.0634987168),
   (f_varrisktype_i = NULL) => 0.0030782003, 0.0030782003),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0724983261,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0157052011, 0.0001104116);

// Tree: 50 
woFDN_FLAPS__lgt_50 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1148335600,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.35) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 158.5) => -0.0139069093,
      (f_prevaddrageoldest_d > 158.5) => 
         map(
         (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0033690497,
         (f_idverrisktype_i > 1.5) => 0.0845202501,
         (f_idverrisktype_i = NULL) => 0.0295037422, 0.0295037422),
      (f_prevaddrageoldest_d = NULL) => -0.0041398937, -0.0041398937),
   (c_unemp > 8.35) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 3.5) => 0.0297163203,
      (k_inq_per_ssn_i > 3.5) => 0.1741358492,
      (k_inq_per_ssn_i = NULL) => 0.0398747866, 0.0398747866),
   (c_unemp = NULL) => 0.0010319404, -0.0010305015),
(r_C10_M_Hdr_FS_d = NULL) => 0.0264427694, -0.0002656012);

// Tree: 51 
woFDN_FLAPS__lgt_51 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 
   map(
   (NULL < c_totsales and c_totsales <= 5553) => 0.0004500019,
   (c_totsales > 5553) => 0.1635162195,
   (c_totsales = NULL) => 0.0781005817, 0.0781005817),
(r_D33_Eviction_Recency_d > 48) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => -0.0136592335,
      (r_pb_order_freq_d > 126.5) => -0.0334014326,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => -0.0017364248,
         (f_crim_rel_under25miles_cnt_i > 1.5) => 0.0485034105,
         (f_crim_rel_under25miles_cnt_i = NULL) => 0.0524546007, 0.0106623150), -0.0084387417),
   (f_bus_addr_match_count_d > 52.5) => 0.2200355349,
   (f_bus_addr_match_count_d = NULL) => -0.0068937539, -0.0068937539),
(r_D33_Eviction_Recency_d = NULL) => -0.0069987506, -0.0059097580);

// Tree: 52 
woFDN_FLAPS__lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0050015465,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1459659441,
      (f_phone_ver_experian_d > 0.5) => 0.0484135408,
      (f_phone_ver_experian_d = NULL) => -0.0126828347, 0.0591019871),
   (k_comb_age_d = NULL) => -0.0102138380, -0.0020310383),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 63.5) => 0.2129398391,
      (c_old_homes > 63.5) => -0.0312302694,
      (c_old_homes = NULL) => 0.0466644892, 0.0466644892),
   (f_inq_count_i > 2.5) => 0.2627798783,
   (f_inq_count_i = NULL) => 0.1110580541, 0.1110580541),
(r_P85_Phn_Disconnected_i = NULL) => 0.0002512485, 0.0002512485);

// Tree: 53 
woFDN_FLAPS__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => -0.0136125972,
(c_easiqlife > 129.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 16.8) => 0.0439975616,
      (c_blue_col > 16.8) => 0.2599985812,
      (c_blue_col = NULL) => 0.0816384900, 0.0816384900),
   (f_prevaddrlenofres_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 4.5) => -0.0027639645,
         (r_C14_Addr_Stability_v2_d > 4.5) => 0.0824643109,
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0421141389, 0.0421141389),
      (f_phone_ver_experian_d > 0.5) => -0.0053408027,
      (f_phone_ver_experian_d = NULL) => -0.0057044443, 0.0110968288),
   (f_prevaddrlenofres_d = NULL) => 0.0167565491, 0.0167565491),
(c_easiqlife = NULL) => -0.0109194627, -0.0023170071);

// Tree: 54 
woFDN_FLAPS__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1560506619,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_unempl and c_unempl <= 190.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0126165933,
      (c_housingcpi > 222.35) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 0.0158449792,
         (k_inq_per_phone_i > 5.5) => 0.1409929498,
         (k_inq_per_phone_i = NULL) => 0.0180721163, 0.0180721163),
      (c_housingcpi = NULL) => -0.0052142151, -0.0052142151),
   (c_unempl > 190.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 142) => -0.0167593671,
      (f_fp_prevaddrburglaryindex_i > 142) => 0.1764739099,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0798572714, 0.0798572714),
   (c_unempl = NULL) => -0.0123009882, -0.0045252494),
(f_attr_arrest_recency_d = NULL) => 0.0190200271, -0.0036940394);

// Tree: 55 
woFDN_FLAPS__lgt_55 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33253) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
      map(
      (NULL < c_retail and c_retail <= 13.6) => 0.0332417441,
      (c_retail > 13.6) => 0.1880256034,
      (c_retail = NULL) => 0.0924486848, 0.0924486848),
   (r_I60_inq_comm_recency_d > 549) => 
      map(
      (NULL < c_employees and c_employees <= 33.5) => 0.0906435487,
      (c_employees > 33.5) => 0.0024629158,
      (c_employees = NULL) => 0.0079783102, 0.0169350781),
   (r_I60_inq_comm_recency_d = NULL) => 0.0273156548, 0.0273156548),
(f_curraddrmedianincome_d > 33253) => -0.0095677034,
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 6.65) => 0.0331403338,
   (c_construction > 6.65) => -0.0747968956,
   (c_construction = NULL) => -0.0150300000, -0.0150300000), -0.0053078903);

// Tree: 56 
woFDN_FLAPS__lgt_56 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00563981495) => 0.1843439991,
   (f_add_curr_nhood_MFD_pct_i > 0.00563981495) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 163.5) => 0.0081659211,
      (c_rich_wht > 163.5) => 
         map(
         (NULL < c_food and c_food <= 16.45) => 0.0044314463,
         (c_food > 16.45) => 0.1848514958,
         (c_food = NULL) => 0.0976285580, 0.0976285580),
      (c_rich_wht = NULL) => 0.0244416538, 0.0244416538),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0201625391, 0.0324579175),
(f_corrssnaddrcount_d > 2.5) => -0.0051058874,
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0650171174,
   (f_addrs_per_ssn_i > 5.5) => 0.0573639992,
   (f_addrs_per_ssn_i = NULL) => -0.0038265591, -0.0038265591), -0.0015803622);

// Tree: 57 
woFDN_FLAPS__lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 19.5) => 0.1917577706,
         (r_C13_max_lres_d > 19.5) => 0.0301705820,
         (r_C13_max_lres_d = NULL) => 0.0966390710, 0.0966390710),
      (f_M_Bureau_ADL_FS_noTU_d > 7.5) => -0.0038572738,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0026620997, -0.0026620997),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0597302716,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0051525313, -0.0051525313),
(r_D30_Derog_Count_i > 11.5) => 0.0797820360,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 83.5) => 0.0565298817,
   (c_very_rich > 83.5) => -0.0632915390,
   (c_very_rich = NULL) => -0.0110616890, -0.0110616890), -0.0041122055);

// Tree: 58 
woFDN_FLAPS__lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0092751571,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 55.95) => 0.1502619194,
      (c_low_ed > 55.95) => -0.0649673792,
      (c_low_ed = NULL) => 0.1042727530, 0.1042727530),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0069665066, -0.0069665066),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 3151.5) => 0.0037087539,
   (r_A50_pb_total_dollars_d > 3151.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 129.5) => 0.0289248874,
      (c_lar_fam > 129.5) => 0.1722002058,
      (c_lar_fam = NULL) => 0.0765145691, 0.0765145691),
   (r_A50_pb_total_dollars_d = NULL) => 0.0365404902, 0.0365404902),
(k_inq_per_phone_i = NULL) => -0.0047885844, -0.0047885844);

// Tree: 59 
woFDN_FLAPS__lgt_59 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0185594194,
      (f_nae_nothing_found_i > 0.5) => 0.1167627806,
      (f_nae_nothing_found_i = NULL) => -0.0170077750, -0.0170077750),
   (f_phones_per_addr_curr_i > 50.5) => 0.0931292420,
   (f_phones_per_addr_curr_i = NULL) => -0.0151270199, -0.0151270199),
(r_L79_adls_per_addr_curr_i > 3.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -60905) => 0.1148206829,
   (f_addrchangevaluediff_d > -60905) => 0.0132798143,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_families and c_families <= 748.5) => 0.0234089239,
      (c_families > 748.5) => 0.2307281783,
      (c_families = NULL) => 0.0454411095, 0.0454411095), 0.0203788485),
(r_L79_adls_per_addr_curr_i = NULL) => -0.0030861388, -0.0044206802);

// Tree: 60 
woFDN_FLAPS__lgt_60 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1415.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52.15) => 0.1201574899,
      (r_C12_source_profile_d > 52.15) => -0.0479547744,
      (r_C12_source_profile_d = NULL) => 0.0087458117, 0.0087458117),
   (c_popover25 > 1415.5) => 0.1941835188,
   (c_popover25 = NULL) => 0.0646836325, 0.0646836325),
(f_mos_liens_unrel_SC_fseen_d > 93.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 6.45) => 0.1235118282,
      (c_hh5_p > 6.45) => -0.0100422584,
      (c_hh5_p = NULL) => 0.0594790470, 0.0594790470),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0048278926,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0040615270, -0.0040615270),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0172688353, -0.0028560172);

// Tree: 61 
woFDN_FLAPS__lgt_61 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1042048429,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 5.65) => 0.1447220964,
         (c_pop_55_64_p > 5.65) => 0.0340224664,
         (c_pop_55_64_p = NULL) => 0.0520958754, 0.0520958754),
      (f_current_count_d > 0.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 10.15) => 0.0166998999,
         (C_INC_35K_P > 10.15) => -0.0806010745,
         (C_INC_35K_P = NULL) => -0.0252772904, -0.0252772904),
      (f_current_count_d = NULL) => 0.0189359472, 0.0189359472),
   (r_D33_Eviction_Recency_d = NULL) => 0.0258576020, 0.0258576020),
(r_I60_inq_comm_recency_d > 549) => -0.0049233580,
(r_I60_inq_comm_recency_d = NULL) => -0.0214227786, -0.0022564747);

// Tree: 62 
woFDN_FLAPS__lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0090469940,
   (f_prevaddrageoldest_d > 152.5) => 
      map(
      (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 0.0209761609,
      (r_F01_inp_addr_not_verified_i > 0.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 9.85) => 0.0401537532,
         (C_INC_35K_P > 9.85) => 0.1687675239,
         (C_INC_35K_P = NULL) => 0.1044606385, 0.1044606385),
      (r_F01_inp_addr_not_verified_i = NULL) => 0.0254215835, 0.0254215835),
   (f_prevaddrageoldest_d = NULL) => -0.0006955519, -0.0006955519),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 0.0357510578,
   (f_assocrisktype_i > 8.5) => 0.1438246659,
   (f_assocrisktype_i = NULL) => 0.0576970395, 0.0576970395),
(f_assoccredbureaucountnew_i = NULL) => 0.0403354347, 0.0008293645);

// Tree: 63 
woFDN_FLAPS__lgt_63 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0063122138,
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124843) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.35) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 90) => 0.2373436007,
         (f_prevaddrmurderindex_i > 90) => 0.0354633723,
         (f_prevaddrmurderindex_i = NULL) => 0.1541362093, 0.1541362093),
      (c_pop_75_84_p > 3.35) => 0.0025003193,
      (c_pop_75_84_p = NULL) => 0.0825303724, 0.0825303724),
   (r_L80_Inp_AVM_AutoVal_d > 124843) => 0.0041933583,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 25.75) => 0.0620269581,
      (c_hh1_p > 25.75) => -0.0270526239,
      (c_hh1_p = NULL) => 0.0147632460, 0.0147632460), 0.0216141149),
(k_inq_ssns_per_addr_i = NULL) => -0.0026422738, -0.0026422738);

// Tree: 64 
woFDN_FLAPS__lgt_64 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 0.0516882243,
   (r_C21_M_Bureau_ADL_FS_d > 8.5) => -0.0072450326,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0057223551, -0.0057223551),
(f_prevaddrageoldest_d > 271.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 5.55) => 0.0424351189,
      (c_incollege > 5.55) => 
         map(
         (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 0.5) => 0.1139257474,
         (f_srchphonesrchcount_i > 0.5) => 0.3787864246,
         (f_srchphonesrchcount_i = NULL) => 0.2035109765, 0.2035109765),
      (c_incollege = NULL) => 0.1186752000, 0.1186752000),
   (f_phone_ver_insurance_d > 3.5) => -0.0028559924,
   (f_phone_ver_insurance_d = NULL) => 0.0467531989, 0.0467531989),
(f_prevaddrageoldest_d = NULL) => -0.0057361470, -0.0012836751);

// Tree: 65 
woFDN_FLAPS__lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0056604803,
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.2752394955,
      (f_adl_per_email_i > 0.5) => -0.0760762653,
      (f_adl_per_email_i = NULL) => 0.0195555246, 0.0228473349),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 136) => 0.0481587902,
      (c_bargains > 136) => 0.1881943025,
      (c_bargains = NULL) => 0.1024582746, 0.1024582746),
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0270192032, 0.0270192032),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0742957613,
   (k_nap_lname_verd_d > 0.5) => -0.0460139735,
   (k_nap_lname_verd_d = NULL) => 0.0151604679, 0.0151604679), 0.0022516367);

// Tree: 66 
woFDN_FLAPS__lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 132.5) => -0.0196969830,
   (c_span_lang > 132.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1182) => 0.0032465240,
      (f_addrchangeincomediff_d > 1182) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 0.3) => -0.0311711062,
         (c_hval_125k_p > 0.3) => 
            map(
            (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 2.5) => 0.0299473901,
            (f_phones_per_addr_curr_i > 2.5) => 0.2033381596,
            (f_phones_per_addr_curr_i = NULL) => 0.1197953343, 0.1197953343),
         (c_hval_125k_p = NULL) => 0.0616015667, 0.0616015667),
      (f_addrchangeincomediff_d = NULL) => 0.0314422648, 0.0120574462),
   (c_span_lang = NULL) => -0.0077837645, -0.0077837645),
(c_hh3_p > 23.25) => 0.0380190571,
(c_hh3_p = NULL) => -0.0083094914, -0.0008340635);

// Tree: 67 
woFDN_FLAPS__lgt_67 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 99) => -0.0021067899,
(f_addrchangecrimediff_i > 99) => 0.0985844864,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 131314.5) => 
         map(
         (NULL < c_construction and c_construction <= 15.15) => 0.0180665107,
         (c_construction > 15.15) => 0.1749618997,
         (c_construction = NULL) => 0.0537069448, 0.0537069448),
      (r_L80_Inp_AVM_AutoVal_d > 131314.5) => -0.0042844256,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => -0.0318481864,
         (f_srchaddrsrchcount_i > 5.5) => 0.0661206141,
         (f_srchaddrsrchcount_i = NULL) => -0.0459591792, -0.0239915770), -0.0066661502),
   (k_nap_contradictory_i > 0.5) => 0.1093112989,
   (k_nap_contradictory_i = NULL) => -0.0032814356, -0.0032814356), -0.0017827487);

// Tree: 68 
woFDN_FLAPS__lgt_68 := map(
(NULL < f_attr_arrests_i and f_attr_arrests_i <= 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => -0.0048642797,
   (r_C13_Curr_Addr_LRes_d > 306.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0427100897,
      (f_corrrisktype_i > 6.5) => 0.1898913579,
      (f_corrrisktype_i = NULL) => 0.0527365771, 0.0527365771),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0012595929, -0.0012595929),
(f_attr_arrests_i > 0.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 8.15) => 0.0027715001,
   (c_pop_6_11_p > 8.15) => 0.1664630735,
   (c_pop_6_11_p = NULL) => 0.0833384464, 0.0833384464),
(f_attr_arrests_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0937169432,
   (f_addrs_per_ssn_i > 3.5) => 0.0488398764,
   (f_addrs_per_ssn_i = NULL) => -0.0218683061, -0.0218683061), -0.0006090245);

// Tree: 69 
woFDN_FLAPS__lgt_69 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0194183306,
   (f_crim_rel_under100miles_cnt_i > 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 0.5) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 3.5) => 0.1452957625,
         (f_corrssnaddrcount_d > 3.5) => 0.0002046995,
         (f_corrssnaddrcount_d = NULL) => 0.0704730170, 0.0704730170),
      (f_prevaddrlenofres_d > 0.5) => 0.0050275000,
      (f_prevaddrlenofres_d = NULL) => 0.0075696269, 0.0075696269),
   (f_crim_rel_under100miles_cnt_i = NULL) => 0.0196220428, -0.0063487377),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0981911817,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0953241595,
   (f_addrs_per_ssn_i > 3.5) => 0.0307323210,
   (f_addrs_per_ssn_i = NULL) => -0.0267671262, -0.0267671262), -0.0060460055);

// Tree: 70 
woFDN_FLAPS__lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => -0.0076021474,
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.65) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','6: Other']) => -0.0097351965,
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly']) => 
            map(
            (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 546023) => 0.1964680438,
            (f_prevaddrmedianvalue_d > 546023) => 0.0235880192,
            (f_prevaddrmedianvalue_d = NULL) => 0.0942729554, 0.0942729554),
         (nf_seg_FraudPoint_3_0 = '') => 0.0176851345, 0.0176851345),
      (k_inq_per_ssn_i > 2.5) => 0.1171430549,
      (k_inq_per_ssn_i = NULL) => 0.0329863530, 0.0329863530),
   (c_hval_250k_p > 8.65) => 0.2121754159,
   (c_hval_250k_p = NULL) => 0.0430239146, 0.0430239146),
(c_hval_750k_p = NULL) => 0.0173883424, -0.0032248541);

// Tree: 71 
woFDN_FLAPS__lgt_71 := map(
(NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 36.15) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 50.5) => 0.0011255635,
         (f_prevaddrlenofres_d > 50.5) => 0.0628031875,
         (f_prevaddrlenofres_d = NULL) => 0.0327198921, 0.0327198921),
      (f_phone_ver_experian_d > 0.5) => -0.0067694748,
      (f_phone_ver_experian_d = NULL) => 0.0078148792, 0.0107555775),
   (c_hh3_p > 36.15) => 0.1514570702,
   (c_hh3_p = NULL) => -0.0225687703, 0.0113572754),
(k_inf_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0850168338,
   (r_D33_Eviction_Recency_d > 79.5) => -0.0213955671,
   (r_D33_Eviction_Recency_d = NULL) => -0.0196400326, -0.0196400326),
(k_inf_phn_verd_d = NULL) => -0.0002572461, -0.0002572461);

// Tree: 72 
woFDN_FLAPS__lgt_72 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0285808294,
         (f_phone_ver_experian_d > 0.5) => -0.0219983677,
         (f_phone_ver_experian_d = NULL) => 0.0155693776, 0.0082093883),
      (f_corrphonelastnamecount_d > 0.5) => -0.0157317809,
      (f_corrphonelastnamecount_d = NULL) => -0.0054603420, -0.0054603420),
   (r_P85_Phn_Not_Issued_i > 0.5) => -0.0712142501,
   (r_P85_Phn_Not_Issued_i = NULL) => -0.0070390673, -0.0070390673),
(f_assocsuspicousidcount_i > 15.5) => 0.1086419004,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0992700044,
   (r_S66_adlperssn_count_i > 1.5) => 0.0268800870,
   (r_S66_adlperssn_count_i = NULL) => -0.0257652267, -0.0257652267), -0.0066520213);

// Tree: 73 
woFDN_FLAPS__lgt_73 := map(
(NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.15) => -0.0062942457,
(c_pop_12_17_p > 10.15) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.1615624892,
   (r_C10_M_Hdr_FS_d > 13.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 76.5) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 
            map(
            (NULL < c_med_hhinc and c_med_hhinc <= 32414) => 0.2091398493,
            (c_med_hhinc > 32414) => 0.0850819460,
            (c_med_hhinc = NULL) => 0.1035134059, 0.1035134059),
         (f_historical_count_d > 1.5) => -0.0053178485,
         (f_historical_count_d = NULL) => 0.0510296945, 0.0510296945),
      (f_mos_inq_banko_cm_lseen_d > 76.5) => 0.0053981430,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0158018289, 0.0158018289),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0187873463, 0.0187873463),
(c_pop_12_17_p = NULL) => 0.0012147461, -0.0000974520);

// Tree: 74 
woFDN_FLAPS__lgt_74 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0050787034,
(f_util_adl_count_n > 6.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 2.75) => 
         map(
         (NULL < c_retail and c_retail <= 6.2) => 0.0900230372,
         (c_retail > 6.2) => -0.1011155972,
         (c_retail = NULL) => -0.0101706018, -0.0101706018),
      (c_hval_125k_p > 2.75) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 31.65) => 0.0527699883,
         (c_hh2_p > 31.65) => 0.2320166606,
         (c_hh2_p = NULL) => 0.1474938395, 0.1474938395),
      (c_hval_125k_p = NULL) => 0.0683424601, 0.0683424601),
   (f_phone_ver_experian_d > 0.5) => -0.0100910997,
   (f_phone_ver_experian_d = NULL) => 0.0910230238, 0.0267198550),
(f_util_adl_count_n = NULL) => 0.0237860120, -0.0028197704);

// Tree: 75 
woFDN_FLAPS__lgt_75 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1450) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0136472638,
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 0.0048182939,
      (f_util_adl_count_n > 3.5) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => 
            map(
            (NULL < c_hval_500k_p and c_hval_500k_p <= 2.55) => 0.2452500659,
            (c_hval_500k_p > 2.55) => 0.0401167702,
            (c_hval_500k_p = NULL) => 0.1563589711, 0.1563589711),
         (f_addrs_per_ssn_i > 7.5) => 0.0261421931,
         (f_addrs_per_ssn_i = NULL) => 0.0523927902, 0.0523927902),
      (f_util_adl_count_n = NULL) => 0.0140634409, 0.0140634409),
   (f_hh_lienholders_i = NULL) => -0.0050698778, -0.0050698778),
(f_liens_rel_SC_total_amt_i > 1450) => -0.1358991401,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0242461988, -0.0057895477);

// Tree: 76 
woFDN_FLAPS__lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0110964718,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => -0.0025027695,
         (f_prevaddrlenofres_d > 123.5) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0429700478,
            (f_rel_homeover500_count_d > 3.5) => 0.1979002092,
            (f_rel_homeover500_count_d = NULL) => 0.0680572074, 0.0680572074),
         (f_prevaddrlenofres_d = NULL) => 0.0167904821, 0.0167904821),
      (f_nae_nothing_found_i > 0.5) => 0.1992902937,
      (f_nae_nothing_found_i = NULL) => 0.0197288573, 0.0197288573),
   (f_inq_Communications_count24_i > 1.5) => 0.1373337263,
   (f_inq_Communications_count24_i = NULL) => 0.0221894923, 0.0221894923),
(c_rnt1250_p = NULL) => -0.0002311080, -0.0016252055);

// Tree: 77 
woFDN_FLAPS__lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 26998.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 6.5) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0605208618,
         (c_pop_35_44_p > 14.55) => 0.0954843640,
         (c_pop_35_44_p = NULL) => 0.0003592264, 0.0003592264),
      (f_rel_homeover50_count_d > 6.5) => 
         map(
         (NULL < c_pop00 and c_pop00 <= 1440) => 0.0325179084,
         (c_pop00 > 1440) => 0.1737661496,
         (c_pop00 = NULL) => 0.0908108333, 0.0908108333),
      (f_rel_homeover50_count_d = NULL) => 0.0420145717, 0.0420145717),
   (f_curraddrmedianincome_d > 26998.5) => -0.0043120666,
   (f_curraddrmedianincome_d = NULL) => 0.0031751887, -0.0015056590),
(c_transport > 29.05) => 0.1100067999,
(c_transport = NULL) => -0.0026277999, 0.0003049218);

// Tree: 78 
woFDN_FLAPS__lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 0.0011301526,
      (f_varrisktype_i > 3.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 27.5) => 0.1482482865,
         (r_C13_max_lres_d > 27.5) => 
            map(
            (NULL < c_pop_55_64_p and c_pop_55_64_p <= 14.55) => 0.0521456426,
            (c_pop_55_64_p > 14.55) => -0.0685906680,
            (c_pop_55_64_p = NULL) => 0.0316321918, 0.0316321918),
         (r_C13_max_lres_d = NULL) => 0.0534837736, 0.0534837736),
      (f_varrisktype_i = NULL) => 0.0034626293, 0.0034626293),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0579235009,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0278109355, 0.0010308544),
(r_L77_Add_PO_Box_i > 0.5) => -0.1057745316,
(r_L77_Add_PO_Box_i = NULL) => -0.0014614116, -0.0014614116);

// Tree: 79 
woFDN_FLAPS__lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 8.05) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.25) => -0.0523953096,
      (c_pop_45_54_p > 7.25) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30362.5) => 0.0401340074,
         (f_curraddrmedianincome_d > 30362.5) => -0.0060315615,
         (f_curraddrmedianincome_d = NULL) => -0.0028219236, -0.0028219236),
      (c_pop_45_54_p = NULL) => -0.0057617211, -0.0057617211),
   (c_hh7p_p > 8.05) => 
      map(
      (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 0.5) => 0.0271319048,
      (r_C14_Addrs_Per_ADL_c6_i > 0.5) => 0.1545810566,
      (r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0461792506, 0.0461792506),
   (c_hh7p_p = NULL) => 0.0021641529, -0.0037055803),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1016126749,
(f_inq_PrepaidCards_count_i = NULL) => -0.0039330616, -0.0032923879);

// Tree: 80 
woFDN_FLAPS__lgt_80 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 135.5) => -0.0060057752,
   (c_lar_fam > 135.5) => 
      map(
      (NULL < c_transport and c_transport <= 26) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 2.5) => 
            map(
            (NULL < c_rnt1000_p and c_rnt1000_p <= 7.9) => -0.0359898604,
            (c_rnt1000_p > 7.9) => 0.1475607175,
            (c_rnt1000_p = NULL) => 0.0883508536, 0.0883508536),
         (f_prevaddrageoldest_d > 2.5) => 0.0127776953,
         (f_prevaddrageoldest_d = NULL) => 0.0169507767, 0.0169507767),
      (c_transport > 26) => 0.1667317632,
      (c_transport = NULL) => 0.0206592468, 0.0206592468),
   (c_lar_fam = NULL) => 0.0003252082, 0.0003252082),
(c_bel_edu > 196.5) => -0.0832565535,
(c_bel_edu = NULL) => 0.0312564398, 0.0001359801);

// Tree: 81 
woFDN_FLAPS__lgt_81 := map(
(NULL < c_easiqlife and c_easiqlife <= 142.5) => -0.0148930891,
(c_easiqlife > 142.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 80.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0256691824,
      (f_addrs_per_ssn_i > 5.5) => 
         map(
         (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 17.5) => 0.0115305971,
         (r_P88_Phn_Dst_to_Inp_Add_i > 17.5) => 0.0714941100,
         (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 2995) => -0.0268045323,
            (r_A49_Curr_AVM_Chg_1yr_i > 2995) => 0.1500187832,
            (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0404659658, 0.0620150134), 0.0300484937),
      (f_addrs_per_ssn_i = NULL) => 0.0138141493, 0.0138141493),
   (k_comb_age_d > 80.5) => 0.2196944075,
   (k_comb_age_d = NULL) => 0.0170682544, 0.0170682544),
(c_easiqlife = NULL) => 0.0124611143, -0.0052884923);

// Tree: 82 
woFDN_FLAPS__lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0033486786,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0172078207,
      (f_mos_inq_banko_cm_fseen_d > 46.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 37.4) => 0.0416783500,
         (c_fammar18_p > 37.4) => 0.1940740236,
         (c_fammar18_p = NULL) => 0.1020428700, 0.1020428700),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0573238610, 0.0573238610),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0021394212, -0.0021394212),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => -0.1264061143,
   (f_divrisktype_i > 1.5) => 0.0137760040,
   (f_divrisktype_i = NULL) => -0.0661716104, -0.0661716104),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0057589810, -0.0027145653);

// Tree: 83 
woFDN_FLAPS__lgt_83 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => -0.0043095259,
   (f_inq_Communications_count_i > 3.5) => 0.0895444355,
   (f_inq_Communications_count_i = NULL) => -0.0015864578, -0.0037060750),
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 154.5) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 1.5) => 0.0039483627,
      (r_D34_unrel_liens_ct_i > 1.5) => 0.0881138187,
      (r_D34_unrel_liens_ct_i = NULL) => 0.0120934068, 0.0120934068),
   (c_rich_fam > 154.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 32.6) => 0.0602899530,
      (c_rnt1000_p > 32.6) => 0.2492039427,
      (c_rnt1000_p = NULL) => 0.1000968294, 0.1000968294),
   (c_rich_fam = NULL) => 0.0318377644, 0.0318377644),
(k_inq_per_phone_i = NULL) => -0.0001727064, -0.0001727064);

// Tree: 84 
woFDN_FLAPS__lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 308.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 67.5) => -0.0037720176,
   (f_bus_addr_match_count_d > 67.5) => 0.1881328757,
   (f_bus_addr_match_count_d = NULL) => -0.0027494338, -0.0027494338),
(r_C13_Curr_Addr_LRes_d > 308.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 159.9) => 0.0379824223,
   (c_oldhouse > 159.9) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 5.55) => 0.0495293619,
      (c_rnt1250_p > 5.55) => 0.2477222639,
      (c_rnt1250_p = NULL) => 0.1517717320, 0.1517717320),
   (c_oldhouse = NULL) => 0.0577855342, 0.0577855342),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.05) => 0.0701593259,
   (c_pop_18_24_p > 8.05) => -0.0380991586,
   (c_pop_18_24_p = NULL) => 0.0128460106, 0.0128460106), 0.0009142495);

// Tree: 85 
woFDN_FLAPS__lgt_85 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 15.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0063926636,
   (f_srchcomponentrisktype_i > 1.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02699390565) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 34.15) => 0.0082604467,
         (c_low_ed > 34.15) => 0.1621080385,
         (c_low_ed = NULL) => 0.0883563579, 0.0883563579),
      (f_add_curr_nhood_BUS_pct_i > 0.02699390565) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 17.7) => -0.0265250718,
         (c_pop_25_34_p > 17.7) => 0.0905806694,
         (c_pop_25_34_p = NULL) => 0.0122028111, 0.0122028111),
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0452761777, 0.0452761777),
   (f_srchcomponentrisktype_i = NULL) => -0.0044178468, -0.0044178468),
(f_srchphonesrchcount_i > 15.5) => -0.0700306263,
(f_srchphonesrchcount_i = NULL) => 0.0083836207, -0.0048708892);

// Tree: 86 
woFDN_FLAPS__lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 45.5) => -0.0033675106,
   (f_rel_under500miles_cnt_d > 45.5) => -0.1248832687,
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 6.7) => -0.0462142630,
      (c_hval_200k_p > 6.7) => 0.2186148088,
      (c_hval_200k_p = NULL) => 0.0244068228, 0.0244068228), -0.0035357323),
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 128.5) => 0.0090482483,
   (f_curraddrcrimeindex_i > 128.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 12.1) => 0.1786109834,
      (c_newhouse > 12.1) => 0.0359465675,
      (c_newhouse = NULL) => 0.1093891958, 0.1093891958),
   (f_curraddrcrimeindex_i = NULL) => 0.0359421386, 0.0359421386),
(f_phones_per_addr_curr_i = NULL) => -0.0173155134, -0.0016772658);

// Tree: 87 
woFDN_FLAPS__lgt_87 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2586) => -0.0074079111,
(f_addrchangeincomediff_d > 2586) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 102) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 18.55) => -0.0441998609,
      (c_hval_250k_p > 18.55) => 0.1042181913,
      (c_hval_250k_p = NULL) => -0.0050049527, -0.0050049527),
   (f_curraddrcartheftindex_i > 102) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 76.5) => 0.2141486672,
      (c_totcrime > 76.5) => 
         map(
         (NULL < c_bigapt_p and c_bigapt_p <= 0.75) => -0.0282164071,
         (c_bigapt_p > 0.75) => 0.1178033261,
         (c_bigapt_p = NULL) => 0.0447934595, 0.0447934595),
      (c_totcrime = NULL) => 0.0916070941, 0.0916070941),
   (f_curraddrcartheftindex_i = NULL) => 0.0398376199, 0.0398376199),
(f_addrchangeincomediff_d = NULL) => -0.0059080896, -0.0050963524);

// Tree: 88 
woFDN_FLAPS__lgt_88 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0055857637,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 178.5) => 0.0182015593,
      (c_bargains > 178.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 67.15) => 
            map(
            (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0043196334,
            (f_hh_collections_ct_i > 1.5) => 0.1519002978,
            (f_hh_collections_ct_i = NULL) => 0.0422597039, 0.0422597039),
         (r_C12_source_profile_d > 67.15) => 0.2213027186,
         (r_C12_source_profile_d = NULL) => 0.0756632514, 0.0756632514),
      (c_bargains = NULL) => 0.0242549137, 0.0242549137),
   (k_inq_per_ssn_i = NULL) => 0.0005318608, 0.0005318608),
(f_srchphonesrchcountmo_i > 2.5) => -0.1088732901,
(f_srchphonesrchcountmo_i = NULL) => -0.0029164608, 0.0000737101);

// Tree: 89 
woFDN_FLAPS__lgt_89 := map(
(NULL < c_newhouse and c_newhouse <= 8.95) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 80.5) => 0.0067300308,
      (k_comb_age_d > 80.5) => 0.1276969542,
      (k_comb_age_d = NULL) => 0.0176951473, 0.0086702126),
   (f_nae_nothing_found_i > 0.5) => 0.1449120510,
   (f_nae_nothing_found_i = NULL) => 0.0101673757, 0.0101673757),
(c_newhouse > 8.95) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 29.5) => -0.0128017037,
   (f_rel_under100miles_cnt_d > 29.5) => -0.0906091430,
   (f_rel_under100miles_cnt_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 0.65) => 0.1247930423,
      (c_bigapt_p > 0.65) => -0.0374318718,
      (c_bigapt_p = NULL) => 0.0166430996, 0.0166430996), -0.0134000864),
(c_newhouse = NULL) => 0.0118773995, -0.0028292017);

// Tree: 90 
woFDN_FLAPS__lgt_90 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0927057508,
   (r_D32_Mos_Since_Fel_LS_d > 117) => 
      map(
      (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => -0.0035152952,
      (f_srchphonesrchcountwk_i > 0.5) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 10.55) => 0.0114946212,
         (c_pop_55_64_p > 10.55) => 0.1577159241,
         (c_pop_55_64_p = NULL) => 0.0734528004, 0.0734528004),
      (f_srchphonesrchcountwk_i = NULL) => -0.0027490746, -0.0027490746),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0022383764, -0.0022383764),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0967841411,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.75) => -0.0765740394,
   (c_pop_35_44_p > 15.75) => 0.0285226011,
   (c_pop_35_44_p = NULL) => -0.0224951856, -0.0224951856), -0.0028191802);

// Tree: 91 
woFDN_FLAPS__lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 121.5) => -0.0358743692,
      (c_lar_fam > 121.5) => 0.1255169771,
      (c_lar_fam = NULL) => 0.0294993407, 0.0294993407),
   (c_retired > 15.45) => 0.2262232322,
   (c_retired = NULL) => 0.0809784899, 0.0809784899),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => -0.0089778260,
   (c_food > 65.55) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => 0.0175349583,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => 0.1183677316,
      (nf_seg_FraudPoint_3_0 = '') => 0.0522251326, 0.0522251326),
   (c_food = NULL) => -0.0086795706, -0.0068106968),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0057227764, -0.0052051660);

// Tree: 92 
woFDN_FLAPS__lgt_92 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.15) => -0.0052964918,
   (c_hh3_p > 23.15) => 
      map(
      (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => 
            map(
            (NULL < c_no_labfor and c_no_labfor <= 114.5) => 0.0003947310,
            (c_no_labfor > 114.5) => 0.0712735543,
            (c_no_labfor = NULL) => 0.0171989526, 0.0171989526),
         (k_comb_age_d > 69.5) => 0.1483983561,
         (k_comb_age_d = NULL) => 0.0237123982, 0.0237123982),
      (f_acc_damage_amt_total_i > 275) => 0.1857189011,
      (f_acc_damage_amt_total_i = NULL) => 0.0280955980, 0.0280955980),
   (c_hh3_p = NULL) => -0.0579762048, -0.0014912583),
(f_assocsuspicousidcount_i > 15.5) => 0.1014906974,
(f_assocsuspicousidcount_i = NULL) => -0.0008631822, -0.0009091576);

// Tree: 93 
woFDN_FLAPS__lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 0.0021866610,
      (r_D33_eviction_count_i > 3.5) => 0.0920148818,
      (r_D33_eviction_count_i = NULL) => 0.0027171426, 0.0027171426),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 55.5) => 0.0911886888,
      (r_pb_order_freq_d > 55.5) => -0.0523769222,
      (r_pb_order_freq_d = NULL) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0641389567,
         (k_inf_nothing_found_i > 0.5) => 0.2004065167,
         (k_inf_nothing_found_i = NULL) => 0.1274914188, 0.1274914188), 0.0734561297),
   (f_curraddrcartheftindex_i = NULL) => -0.0019990470, 0.0039757966),
(c_cartheft > 189.5) => -0.0572251459,
(c_cartheft = NULL) => -0.0030826756, 0.0018409484);

// Tree: 94 
woFDN_FLAPS__lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < c_child and c_child <= 5.15) => -0.0894665243,
   (c_child > 5.15) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 8.15) => 0.0218789683,
         (c_hh7p_p > 8.15) => 0.1437890274,
         (c_hh7p_p = NULL) => 0.0263212629, 0.0263212629),
      (f_hh_members_ct_d > 1.5) => -0.0037136284,
      (f_hh_members_ct_d = NULL) => 0.0076303607, 0.0018056996),
   (c_child = NULL) => 0.0000423086, 0.0000423086),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 2.5) => 0.1123463347,
   (f_rel_incomeover50_count_d > 2.5) => -0.0054484061,
   (f_rel_incomeover50_count_d = NULL) => 0.0644622937, 0.0644622937),
(c_famotf18_p = NULL) => 0.0118505020, 0.0009705985);

// Tree: 95 
woFDN_FLAPS__lgt_95 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0087917469,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 51.35) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 40.5) => 0.1512360907,
         (f_mos_inq_banko_cm_fseen_d > 40.5) => 0.0369869030,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0635731919, 0.0635731919),
      (k_nap_fname_verd_d > 0.5) => -0.0131412546,
      (k_nap_fname_verd_d = NULL) => 0.0097650309, 0.0097650309),
   (c_rnt1000_p > 51.35) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => 0.0801190793,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => 0.2273457154,
      (nf_seg_FraudPoint_3_0 = '') => 0.1550238591, 0.1550238591),
   (c_rnt1000_p = NULL) => 0.0238104137, 0.0238104137),
(f_hh_collections_ct_i = NULL) => -0.0184989121, -0.0058073995);

// Tree: 96 
woFDN_FLAPS__lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45599.5) => 
   map(
   (NULL < c_construction and c_construction <= 40.1) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 5.5) => 0.0110989585,
      (r_L79_adls_per_addr_c6_i > 5.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 5.05) => -0.0086488313,
         (c_hval_250k_p > 5.05) => 0.1602884700,
         (c_hval_250k_p = NULL) => 0.0787836317, 0.0787836317),
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0139181228, 0.0139181228),
   (c_construction > 40.1) => 0.1499652054,
   (c_construction = NULL) => -0.0200892670, 0.0158256892),
(f_curraddrmedianincome_d > 45599.5) => -0.0099998993,
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.26693968695) => -0.0696613453,
   (f_add_input_mobility_index_i > 0.26693968695) => 0.0430134991,
   (f_add_input_mobility_index_i = NULL) => -0.0059755637, -0.0059755637), -0.0036453350);

// Tree: 97 
woFDN_FLAPS__lgt_97 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 2.05) => 0.1327887887,
   (c_low_hval > 2.05) => -0.0254207945,
   (c_low_hval = NULL) => 0.0627845483, 0.0627845483),
(r_D33_Eviction_Recency_d > 30) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 390) => -0.0070430599,
   (r_P88_Phn_Dst_to_Inp_Add_i > 390) => -0.0617294912,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 11.5) => 0.1255367392,
      (r_C13_max_lres_d > 11.5) => 0.0088171378,
      (r_C13_max_lres_d = NULL) => 0.0107636027, 0.0107636027), -0.0034285624),
(r_D33_Eviction_Recency_d = NULL) => 
   map(
   (NULL < c_health and c_health <= 9.05) => 0.0468112738,
   (c_health > 9.05) => -0.0669825498,
   (c_health = NULL) => -0.0065610506, -0.0065610506), -0.0028686057);

// Tree: 98 
woFDN_FLAPS__lgt_98 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 23.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 10.05) => -0.0043434619,
   (c_hh6_p > 10.05) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 17.6) => 0.0126134659,
      (C_INC_15K_P > 17.6) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 77.5) => 0.2198124541,
         (c_rest_indx > 77.5) => 0.0620765584,
         (c_rest_indx = NULL) => 0.1409445062, 0.1409445062),
      (C_INC_15K_P = NULL) => 0.0410682420, 0.0410682420),
   (c_hh6_p = NULL) => -0.0135072466, -0.0029035527),
(f_srchphonesrchcount_i > 23.5) => -0.0913209001,
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 1.9) => 0.0729587275,
   (c_bigapt_p > 1.9) => -0.0348339691,
   (c_bigapt_p = NULL) => 0.0185287520, 0.0185287520), -0.0031409814);

// Tree: 99 
woFDN_FLAPS__lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38111460565) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 4.5) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0038258652,
      (f_util_add_curr_conv_n > 0.5) => 
         map(
         (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 420.5) => 0.0231357758,
         (r_P88_Phn_Dst_to_Inp_Add_i > 420.5) => -0.0612819421,
         (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0544046661, 0.0299731277),
      (f_util_add_curr_conv_n = NULL) => 0.0152697102, 0.0152697102),
   (r_C12_Num_NonDerogs_d > 4.5) => -0.0165544892,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0508918518, 0.0073752217),
(f_add_input_mobility_index_i > 0.38111460565) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 31.5) => -0.0316517613,
   (f_phones_per_addr_curr_i > 31.5) => 0.0600288384,
   (f_phones_per_addr_curr_i = NULL) => -0.0264829554, -0.0264829554),
(f_add_input_mobility_index_i = NULL) => 0.0123946085, 0.0017406660);

// Tree: 100 
woFDN_FLAPS__lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < c_assault and c_assault <= 182.5) => 0.0033132007,
      (c_assault > 182.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0271656233,
         (f_rel_under25miles_cnt_d > 5.5) => 0.1658607399,
         (f_rel_under25miles_cnt_d = NULL) => 0.0715680168, 0.0715680168),
      (c_assault = NULL) => 0.0066785262, 0.0066785262),
   (c_transport > 26.6) => 0.1541648827,
   (c_transport = NULL) => -0.0046864092, 0.0089366758),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 36.05) => -0.0140780154,
   (c_famotf18_p > 36.05) => -0.0710288924,
   (c_famotf18_p = NULL) => 0.0982827615, -0.0155664590),
(f_historical_count_d = NULL) => 0.0096831948, -0.0033523513);

// Tree: 101 
woFDN_FLAPS__lgt_101 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0041561759,
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0113036023,
      (r_C13_max_lres_d > 303) => 0.2450493823,
      (r_C13_max_lres_d = NULL) => 0.0977420703, 0.0977420703),
   (k_comb_age_d = NULL) => 0.0008052504, -0.0030191158),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 46803) => 0.1290099109,
   (f_curraddrmedianincome_d > 46803) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 78.5) => 0.0583045419,
      (c_many_cars > 78.5) => -0.0685952612,
      (c_many_cars = NULL) => -0.0161573261, -0.0161573261),
   (f_curraddrmedianincome_d = NULL) => 0.0421942104, 0.0421942104),
(k_nap_contradictory_i = NULL) => -0.0022563526, -0.0022563526);

// Tree: 102 
woFDN_FLAPS__lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0105183449,
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 44) => -0.1190490679,
   (f_mos_inq_banko_am_fseen_d > 44) => 
      map(
      (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => -0.0527700285,
         (C_INC_150K_P > 0.55) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 19.55) => 0.0200781270,
            (C_INC_35K_P > 19.55) => 0.1075533031,
            (C_INC_35K_P = NULL) => 0.0223413915, 0.0223413915),
         (C_INC_150K_P = NULL) => 0.0188388641, 0.0185471201),
      (f_addrs_per_ssn_c6_i > 1.5) => 0.1233293191,
      (f_addrs_per_ssn_c6_i = NULL) => 0.0201331482, 0.0201331482),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0165678362, 0.0165678362),
(k_inq_per_ssn_i = NULL) => 0.0005168450, 0.0005168450);

// Tree: 103 
woFDN_FLAPS__lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
      map(
      (NULL < c_unempl and c_unempl <= 171.5) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 7) => 0.1512072386,
         (C_INC_25K_P > 7) => -0.0144752957,
         (C_INC_25K_P = NULL) => 0.0139952114, 0.0139952114),
      (c_unempl > 171.5) => 0.1428196108,
      (c_unempl = NULL) => 0.0958446493, 0.0440264317),
   (k_estimated_income_d > 27500) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => -0.0034503561,
      (r_D34_unrel_liens_ct_i > 7.5) => 0.1251335025,
      (r_D34_unrel_liens_ct_i = NULL) => -0.0027787302, -0.0027787302),
   (k_estimated_income_d = NULL) => -0.0005195330, -0.0005195330),
(f_srchaddrsrchcount_i > 32.5) => -0.0887306680,
(f_srchaddrsrchcount_i = NULL) => -0.0062322295, -0.0011747691);

// Tree: 104 
woFDN_FLAPS__lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0059456602,
   (k_inq_per_phone_i > 1.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 25.5) => 0.1118366262,
      (c_no_labfor > 25.5) => 0.0131997090,
      (c_no_labfor = NULL) => 0.0244029144, 0.0244029144),
   (k_inq_per_phone_i = NULL) => -0.0029194000, -0.0029194000),
(f_prevaddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < f_hh_age_18_plus_d and f_hh_age_18_plus_d <= 3.5) => 0.0716199900,
   (f_hh_age_18_plus_d > 3.5) => 0.3141498786,
   (f_hh_age_18_plus_d = NULL) => 0.1302020887, 0.1302020887),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.55) => 0.0429924109,
   (c_construction > 4.55) => -0.0536942929,
   (c_construction = NULL) => -0.0111854835, -0.0111854835), -0.0008272108);

// Tree: 105 
woFDN_FLAPS__lgt_105 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0094883761,
(f_corrrisktype_i > 5.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 208.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 152) => 0.0480260258,
      (c_larceny > 152) => 
         map(
         (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 3.5) => 0.0768952890,
         (r_C12_source_profile_index_d > 3.5) => 0.2283394753,
         (r_C12_source_profile_index_d = NULL) => 0.1484105992, 0.1484105992),
      (c_larceny = NULL) => 0.0761858542, 0.0761858542),
   (c_cpiall > 208.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 2.35) => -0.0471105726,
      (c_unemp > 2.35) => 0.0177007535,
      (c_unemp = NULL) => 0.0074174103, 0.0074174103),
   (c_cpiall = NULL) => 0.0006349305, 0.0139871628),
(f_corrrisktype_i = NULL) => -0.0144794284, -0.0024843685);

// Tree: 106 
woFDN_FLAPS__lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 36.15) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => -0.0118750476,
      (k_comb_age_d > 55.5) => 0.0218601712,
      (k_comb_age_d = NULL) => -0.0044265757, -0.0044265757),
   (c_hh3_p > 36.15) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 33.75) => 0.0020420346,
      (c_fammar18_p > 33.75) => 0.2159800410,
      (c_fammar18_p = NULL) => 0.0950585591, 0.0950585591),
   (c_hh3_p = NULL) => -0.0312730479, -0.0041264590),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 126.5) => -0.0333980474,
   (c_blue_empl > 126.5) => 0.3035100324,
   (c_blue_empl = NULL) => 0.1489650417, 0.1489650417),
(f_historical_count_d = NULL) => -0.0007004497, -0.0027763996);

// Tree: 107 
woFDN_FLAPS__lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0959147110,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 111.5) => -0.0044413916,
      (f_addrchangecrimediff_i > 111.5) => 0.0942921853,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 157.5) => -0.0139592921,
         (c_span_lang > 157.5) => 0.0491974279,
         (c_span_lang = NULL) => 0.0160609777, 0.0020220113), -0.0026312156),
   (r_D32_criminal_count_i > 10.5) => 0.0940116706,
   (r_D32_criminal_count_i = NULL) => -0.0020276329, -0.0020276329),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.3) => 0.0676818764,
   (c_femdiv_p > 4.3) => -0.0374930403,
   (c_femdiv_p = NULL) => 0.0150944180, 0.0150944180), -0.0011832837);

// Tree: 108 
woFDN_FLAPS__lgt_108 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => -0.0014187868,
(f_phones_per_addr_curr_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.45) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.95) => 
         map(
         (NULL < f_addrchangeecontrajindex_d and f_addrchangeecontrajindex_d <= 3.5) => 0.0370692652,
         (f_addrchangeecontrajindex_d > 3.5) => 0.0003718873,
         (f_addrchangeecontrajindex_d = NULL) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 60599) => 0.2031432957,
            (f_curraddrmedianincome_d > 60599) => 0.0202993200,
            (f_curraddrmedianincome_d = NULL) => 0.1096897081, 0.1096897081), 0.0478972357),
      (c_pop_75_84_p > 2.95) => -0.0079483945,
      (c_pop_75_84_p = NULL) => 0.0180577219, 0.0180577219),
   (r_C12_source_profile_d > 79.45) => 0.1742509205,
   (r_C12_source_profile_d = NULL) => 0.0258616437, 0.0258616437),
(f_phones_per_addr_curr_i = NULL) => -0.0209124233, 0.0013345349);

// Tree: 109 
woFDN_FLAPS__lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 4.95) => 0.0591451290,
      (c_high_ed > 4.95) => 0.0050622247,
      (c_high_ed = NULL) => -0.0128369690, 0.0066890866),
   (f_srchssnsrchcount_i > 21.5) => 0.1065653150,
   (f_srchssnsrchcount_i = NULL) => 0.0071278301, 0.0071278301),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => -0.0003865860,
      (f_srchvelocityrisktype_i > 2.5) => -0.1351770644,
      (f_srchvelocityrisktype_i = NULL) => -0.0851604718, -0.0851604718),
   (f_mos_inq_banko_cm_lseen_d > 21.5) => -0.0004507828,
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0275510656, -0.0275510656),
(r_D33_eviction_count_i = NULL) => 0.0198956536, 0.0058929094);

// Tree: 110 
woFDN_FLAPS__lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 103.5) => -0.0090083324,
(f_prevaddrageoldest_d > 103.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 12.5) => 0.0035521117,
   (r_P88_Phn_Dst_to_Inp_Add_i > 12.5) => 0.0491847765,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 69375) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 21.5) => 0.1731581378,
         (c_born_usa > 21.5) => 0.0421628297,
         (c_born_usa = NULL) => 0.0576064871, 0.0576064871),
      (r_A49_Curr_AVM_Chg_1yr_i > 69375) => 0.2272735595,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 11.55) => -0.0225012406,
         (C_INC_35K_P > 11.55) => 0.1198655478,
         (C_INC_35K_P = NULL) => 0.0253565216, 0.0253565216), 0.0561556485), 0.0175101608),
(f_prevaddrageoldest_d = NULL) => -0.0307655824, 0.0002968343);

// Tree: 111 
woFDN_FLAPS__lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.75) => 0.2114028869,
   (r_C12_source_profile_d > 57.75) => -0.0246904694,
   (r_C12_source_profile_d = NULL) => 0.0933562087, 0.0933562087),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
      map(
      (NULL < c_rape and c_rape <= 98.5) => 0.0138462486,
      (c_rape > 98.5) => -0.0135172913,
      (c_rape = NULL) => -0.0064031914, 0.0031325438),
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 5.1) => 0.1501844953,
      (C_INC_200K_P > 5.1) => -0.0294545508,
      (C_INC_200K_P = NULL) => 0.0638463491, 0.0638463491),
   (f_hh_lienholders_i = NULL) => 0.0037713799, 0.0037713799),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0314518430, 0.0043979143);

// Tree: 112 
woFDN_FLAPS__lgt_112 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0085000888) => 0.0869714544,
      (f_add_input_nhood_MFD_pct_i > 0.0085000888) => 0.0038141672,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0054614241, 0.0105741567),
   (f_phone_ver_insurance_d > 3.5) => -0.0161541671,
   (f_phone_ver_insurance_d = NULL) => 0.0198767228, -0.0024246153),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_bel_edu and c_bel_edu <= 132.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.15) => 0.1265256745,
      (c_incollege > 6.15) => -0.0274289283,
      (c_incollege = NULL) => 0.0321664018, 0.0321664018),
   (c_bel_edu > 132.5) => 0.1360659108,
   (c_bel_edu = NULL) => 0.0590112510, 0.0590112510),
(k_nap_contradictory_i = NULL) => -0.0013397407, -0.0013397407);

// Tree: 113 
woFDN_FLAPS__lgt_113 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 17532) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 0.55) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 5.6) => -0.0567136971,
         (c_hval_300k_p > 5.6) => 0.1259522760,
         (c_hval_300k_p = NULL) => 0.0146591003, 0.0146591003),
      (c_hval_20k_p > 0.55) => 0.1803251317,
      (c_hval_20k_p = NULL) => 0.0564856726, 0.0564856726),
   (r_C21_M_Bureau_ADL_FS_d > 7.5) => -0.0061679169,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0048534149, -0.0048534149),
(f_addrchangeincomediff_d > 17532) => 0.0585945537,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 36.9) => -0.0072153047,
   (c_hval_500k_p > 36.9) => 0.1316241637,
   (c_hval_500k_p = NULL) => 0.0130890206, -0.0021621895), -0.0028445863);

// Tree: 114 
woFDN_FLAPS__lgt_114 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0054975278) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 39.5) => 0.0500917362,
      (c_no_car > 39.5) => 0.2606757075,
      (c_no_car = NULL) => 0.1574482706, 0.1574482706),
   (f_hh_members_ct_d > 1.5) => 0.0210495526,
   (f_hh_members_ct_d = NULL) => 0.0389551758, 0.0389551758),
(f_add_input_nhood_MFD_pct_i > 0.0054975278) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 6.5) => -0.0084865218,
   (f_srchssnsrchcount_i > 6.5) => -0.0429915569,
   (f_srchssnsrchcount_i = NULL) => 0.0078578291, -0.0097212179),
(f_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => -0.0062970312,
   (f_srchaddrsrchcount_i > 18.5) => 0.1108383874,
   (f_srchaddrsrchcount_i = NULL) => -0.0037442057, -0.0037442057), -0.0055719471);

// Tree: 115 
woFDN_FLAPS__lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13229074905) => -0.0081293643,
   (f_add_curr_nhood_BUS_pct_i > 0.13229074905) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0040622798,
      (c_easiqlife > 132.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01879119585) => 
            map(
            (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0750561018,
            (f_bus_addr_match_count_d > 0.5) => 0.3332916949,
            (f_bus_addr_match_count_d = NULL) => 0.1438384794, 0.1438384794),
         (f_add_input_nhood_VAC_pct_i > 0.01879119585) => 0.0423886790,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0790614109, 0.0790614109),
      (c_easiqlife = NULL) => 0.0300397472, 0.0300397472),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0091741033, -0.0037078626),
(c_pop_0_5_p > 21.15) => 0.1657962362,
(c_pop_0_5_p = NULL) => 0.0151771575, -0.0025172861);

// Tree: 116 
woFDN_FLAPS__lgt_116 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0898213460,
(C_OWNOCC_P > 1.45) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 231294.5) => -0.0032374758,
      (f_addrchangevaluediff_d > 231294.5) => 0.0842179289,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 26.5) => -0.0060615649,
         (f_phones_per_addr_curr_i > 26.5) => 0.0910103203,
         (f_phones_per_addr_curr_i = NULL) => 0.0093948406, -0.0021590518), -0.0023860970),
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.22459745345) => -0.0496438203,
      (f_add_input_mobility_index_i > 0.22459745345) => 0.2224871020,
      (f_add_input_mobility_index_i = NULL) => 0.0994900749, 0.0994900749),
   (f_adls_per_phone_c6_i = NULL) => -0.0009163699, -0.0009163699),
(C_OWNOCC_P = NULL) => 0.0096839755, -0.0017610735);

// Tree: 117 
woFDN_FLAPS__lgt_117 := map(
(NULL < c_young and c_young <= 29.65) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
      map(
      (NULL < c_very_rich and c_very_rich <= 115.5) => -0.0000729878,
      (c_very_rich > 115.5) => 0.1605759592,
      (c_very_rich = NULL) => 0.0730582493, 0.0730582493),
   (r_C21_M_Bureau_ADL_FS_d > 6.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.75) => -0.0004728143,
      (c_hh3_p > 23.75) => 
         map(
         (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 1.5) => 0.0334387932,
         (f_inq_Other_count24_i > 1.5) => 0.1703220471,
         (f_inq_Other_count24_i = NULL) => 0.0397703975, 0.0397703975),
      (c_hh3_p = NULL) => 0.0051936030, 0.0051936030),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0034364909, 0.0060349312),
(c_young > 29.65) => -0.0212344123,
(c_young = NULL) => 0.0038494548, 0.0005851045);

// Tree: 118 
woFDN_FLAPS__lgt_118 := map(
(NULL < f_srchunvrfdaddrcount_i and f_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37763534975) => -0.0018858921,
      (f_add_input_mobility_index_i > 0.37763534975) => -0.0313793598,
      (f_add_input_mobility_index_i = NULL) => 0.0684322382, -0.0063222065),
   (k_comb_age_d > 84.5) => 0.0978736966,
   (k_comb_age_d = NULL) => -0.0056416879, -0.0056416879),
(f_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 108.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0333244262) => 0.0572104789,
      (f_add_curr_nhood_BUS_pct_i > 0.0333244262) => -0.0328667916,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0084186241, 0.0084186241),
   (c_medi_indx > 108.5) => 0.1410815412,
   (c_medi_indx = NULL) => 0.0416952755, 0.0416952755),
(f_srchunvrfdaddrcount_i = NULL) => -0.0141527408, -0.0045623061);

// Tree: 119 
woFDN_FLAPS__lgt_119 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0210298104,
   (f_rel_under25miles_cnt_d > 5.5) => 0.1344098272,
   (f_rel_under25miles_cnt_d = NULL) => 0.0746276365, 0.0746276365),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 5.45) => 0.0878151971,
      (c_hh3_p > 5.45) => -0.0577372052,
      (c_hh3_p = NULL) => -0.0487413830, -0.0487413830),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0072904194,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0035476985, 0.0035476985),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0245538572,
   (c_rich_nfam > 124) => -0.0764084033,
   (c_rich_nfam = NULL) => -0.0246546395, -0.0246546395), 0.0045249641);

// Tree: 120 
woFDN_FLAPS__lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1920.5) => -0.0067004551,
(c_popover18 > 1920.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 127.5) => 0.1503840946,
   (f_mos_liens_unrel_SC_fseen_d > 127.5) => 
      map(
      (NULL < c_hval_400k_p and c_hval_400k_p <= 7.55) => 
         map(
         (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 1.5) => 0.0415413085,
         (k_inq_adls_per_addr_i > 1.5) => 
            map(
            (NULL < c_construction and c_construction <= 8.9) => 0.0522912305,
            (c_construction > 8.9) => 0.3208665638,
            (c_construction = NULL) => 0.1452596151, 0.1452596151),
         (k_inq_adls_per_addr_i = NULL) => 0.0597620921, 0.0597620921),
      (c_hval_400k_p > 7.55) => -0.0095507821,
      (c_hval_400k_p = NULL) => 0.0174803256, 0.0174803256),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0204476919, 0.0204476919),
(c_popover18 = NULL) => -0.0277684373, -0.0021394008);

// Tree: 121 
woFDN_FLAPS__lgt_121 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0001150901,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 69.25) => 0.0988501959,
      (c_fammar_p > 69.25) => -0.0393338871,
      (c_fammar_p = NULL) => 0.0425354497, 0.0425354497),
   (f_curraddrcrimeindex_i = NULL) => 0.0009303531, 0.0009303531),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 18.45) => -0.0746105553,
   (c_pop_45_54_p > 18.45) => 0.0346374416,
   (c_pop_45_54_p = NULL) => -0.0561979715, -0.0561979715),
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 100) => 0.0769939705,
   (c_robbery > 100) => -0.0316559287,
   (c_robbery = NULL) => 0.0191802626, 0.0191802626), -0.0013136291);

// Tree: 122 
woFDN_FLAPS__lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0029797492,
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 144.5) => 0.1058075751,
      (c_rest_indx > 144.5) => -0.0452938506,
      (c_rest_indx = NULL) => 0.0597216403, 0.0597216403),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => -0.0157032089, -0.0020827275),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 1.95) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 9.5) => -0.0212866984,
      (f_rel_under500miles_cnt_d > 9.5) => 0.1198262861,
      (f_rel_under500miles_cnt_d = NULL) => 0.0313175503, 0.0313175503),
   (c_hval_1001k_p > 1.95) => 0.2523464140,
   (c_hval_1001k_p = NULL) => 0.0821737490, 0.0821737490),
(r_P85_Phn_Disconnected_i = NULL) => -0.0005018808, -0.0005018808);

// Tree: 123 
woFDN_FLAPS__lgt_123 := map(
(NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0050737816,
(c_easiqlife > 132.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 14.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -68066) => 0.1265813284,
      (f_addrchangevaluediff_d > -68066) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 25.85) => 0.0149797746,
         (C_INC_75K_P > 25.85) => 0.1076568425,
         (C_INC_75K_P = NULL) => 0.0235696838, 0.0235696838),
      (f_addrchangevaluediff_d = NULL) => 0.0243605161, 0.0256547842),
   (f_rel_under500miles_cnt_d > 14.5) => -0.0157191160,
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 1.25) => -0.0076864612,
      (c_hval_200k_p > 1.25) => 0.1362498757,
      (c_hval_200k_p = NULL) => 0.0604262696, 0.0604262696), 0.0191119493),
(c_easiqlife = NULL) => -0.0112872770, 0.0032334173);

// Tree: 124 
woFDN_FLAPS__lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.65) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 685435.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 12.5) => 
            map(
            (NULL < c_sfdu_p and c_sfdu_p <= 1.55) => -0.0906632512,
            (c_sfdu_p > 1.55) => 0.0044654861,
            (c_sfdu_p = NULL) => 0.0032329583, 0.0032329583),
         (f_util_adl_count_n > 12.5) => 0.1204774110,
         (f_util_adl_count_n = NULL) => 0.0041509644, 0.0041509644),
      (f_prevaddrmedianvalue_d > 685435.5) => 0.1355899836,
      (f_prevaddrmedianvalue_d = NULL) => 0.0055791539, 0.0055791539),
   (r_C13_Curr_Addr_LRes_d > 452) => 0.1488075197,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0156465923, 0.0068632274),
(c_high_ed > 42.65) => -0.0271642621,
(c_high_ed = NULL) => -0.0328031518, -0.0036541593);

// Tree: 125 
woFDN_FLAPS__lgt_125 := map(
(NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => -0.0042395406,
      (k_inq_per_ssn_i > 10.5) => 0.0734759314,
      (k_inq_per_ssn_i = NULL) => -0.0035329216, -0.0035329216),
   (f_inq_count24_i > 16.5) => -0.1162467835,
   (f_inq_count24_i = NULL) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2611569633) => -0.0566361657,
      (f_add_input_mobility_index_i > 0.2611569633) => 0.0680069372,
      (f_add_input_mobility_index_i = NULL) => 0.0067982706, 0.0067982706), -0.0040787849),
(f_nae_nothing_found_i > 0.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => 0.0077332685,
   (f_addrs_per_ssn_i > 7.5) => 0.2046940015,
   (f_addrs_per_ssn_i = NULL) => 0.0780763875, 0.0780763875),
(f_nae_nothing_found_i = NULL) => -0.0029000508, -0.0029000508);

// Tree: 126 
woFDN_FLAPS__lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 3.5) => -0.0556952469,
      (f_mos_inq_banko_cm_lseen_d > 3.5) => 0.0044446457,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0029182278, 0.0029182278),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 10) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 0.85) => 0.0637471005,
         (c_pop_85p_p > 0.85) => -0.0763412297,
         (c_pop_85p_p = NULL) => -0.0024057221, -0.0024057221),
      (c_highrent > 10) => 0.1516597690,
      (c_highrent = NULL) => 0.0470115109, 0.0470115109),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0016263344, 0.0034493263),
(r_L72_Add_Vacant_i > 0.5) => 0.1179975700,
(r_L72_Add_Vacant_i = NULL) => 0.0042352026, 0.0042352026);

// Tree: 127 
woFDN_FLAPS__lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => -0.0010545603,
   (f_inq_HighRiskCredit_count24_i > 2.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 73.5) => -0.1483935983,
      (c_mort_indx > 73.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 12.5) => -0.0704472398,
         (c_hh4_p > 12.5) => 0.0794352244,
         (c_hh4_p = NULL) => 0.0123549607, 0.0123549607),
      (c_mort_indx = NULL) => -0.0357120104, -0.0357120104),
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0016225789, -0.0016225789),
(f_assocsuspicousidcount_i > 16.5) => 0.0956850361,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0819080620,
   (r_S66_adlperssn_count_i > 1.5) => 0.0475644737,
   (r_S66_adlperssn_count_i = NULL) => -0.0092217262, -0.0092217262), -0.0012075945);

// Tree: 128 
woFDN_FLAPS__lgt_128 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 16800) => 0.1051186686,
(r_L80_Inp_AVM_AutoVal_d > 16800) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.05) => -0.0237214988,
   (c_hh4_p > 12.05) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 2.5) => 
         map(
         (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 1.5) => 0.0212509143,
         (f_crim_rel_under500miles_cnt_i > 1.5) => 0.2263723400,
         (f_crim_rel_under500miles_cnt_i = NULL) => 0.0849465149, 0.0849465149),
      (r_C13_Curr_Addr_LRes_d > 2.5) => 0.0170283087,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0198576325, 0.0198576325),
   (c_hh4_p = NULL) => 0.0051484570, 0.0051484570),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 1.5) => -0.0085705162,
   (f_hh_criminals_i > 1.5) => 0.0489535808,
   (f_hh_criminals_i = NULL) => -0.0120071828, -0.0042160914), 0.0015907761);

// Tree: 129 
woFDN_FLAPS__lgt_129 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => -0.0080716100,
(f_util_adl_count_n > 3.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -58040) => 0.1601413604,
   (f_addrchangevaluediff_d > -58040) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 1.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 184.5) => 0.0019002824,
         (c_born_usa > 184.5) => 0.2073211510,
         (c_born_usa = NULL) => 0.0088154404, 0.0088154404),
      (f_inq_HighRiskCredit_count24_i > 1.5) => 0.1097939297,
      (f_inq_HighRiskCredit_count24_i = NULL) => 0.0130920262, 0.0130920262),
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 5.95) => 0.1356789509,
      (c_pop_55_64_p > 5.95) => -0.0159240134,
      (c_pop_55_64_p = NULL) => 0.0014500759, 0.0067098304), 0.0145372358),
(f_util_adl_count_n = NULL) => -0.0161368843, -0.0041032918);

// Tree: 130 
woFDN_FLAPS__lgt_130 := map(
(NULL < c_lar_fam and c_lar_fam <= 181.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 12.45) => -0.0870446957,
   (c_white_col > 12.45) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 27.75) => 
         map(
         (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2620) => -0.0100211990,
         (f_addrchangeincomediff_d > 2620) => 0.0328057918,
         (f_addrchangeincomediff_d = NULL) => 0.0007634675, -0.0059197802),
      (C_INC_25K_P > 27.75) => 0.0966184619,
      (C_INC_25K_P = NULL) => -0.0053467055, -0.0053467055),
   (c_white_col = NULL) => -0.0059267385, -0.0059267385),
(c_lar_fam > 181.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 7.65) => -0.0535568775,
   (C_INC_15K_P > 7.65) => 0.1625103869,
   (C_INC_15K_P = NULL) => 0.0773929797, 0.0773929797),
(c_lar_fam = NULL) => 0.0335644690, -0.0041288612);

// Tree: 131 
woFDN_FLAPS__lgt_131 := map(
(NULL < c_med_hval and c_med_hval <= 774793.5) => -0.0008586824,
(c_med_hval > 774793.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 30.45) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 107374.5) => 
         map(
         (NULL < c_med_age and c_med_age <= 37.1) => -0.0497035857,
         (c_med_age > 37.1) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 97.5) => 0.0181080979,
            (r_A50_pb_average_dollars_d > 97.5) => 0.3273461258,
            (r_A50_pb_average_dollars_d = NULL) => 0.1848277303, 0.1848277303),
         (c_med_age = NULL) => 0.1026755180, 0.1026755180),
      (f_curraddrmedianincome_d > 107374.5) => -0.0247834600,
      (f_curraddrmedianincome_d = NULL) => 0.0355380349, 0.0355380349),
   (c_hval_750k_p > 30.45) => 0.2279894062,
   (c_hval_750k_p = NULL) => 0.0638397072, 0.0638397072),
(c_med_hval = NULL) => 0.0005287468, 0.0014276256);

// Tree: 132 
woFDN_FLAPS__lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0012003695,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2224722795,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 0.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 6.5) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 504.5) => 
            map(
            (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 197.5) => 0.0032950213,
            (r_A50_pb_average_dollars_d > 197.5) => 0.0776701566,
            (r_A50_pb_average_dollars_d = NULL) => 0.0424805345, 0.0424805345),
         (c_hh00 > 504.5) => 0.0022023017,
         (c_hh00 = NULL) => -0.0085912234, 0.0146158767),
      (f_corraddrnamecount_d > 6.5) => -0.0172355126,
      (f_corraddrnamecount_d = NULL) => 0.0094923699, 0.0010173794),
   (r_S65_SSN_Problem_i > 0.5) => -0.0531135599,
   (r_S65_SSN_Problem_i = NULL) => -0.0025547534, -0.0025547534), -0.0009922952);

// Tree: 133 
woFDN_FLAPS__lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 124.5) => 
   map(
   (NULL < c_rape and c_rape <= 66) => 
      map(
      (NULL < c_rape and c_rape <= 28.5) => 0.0243960237,
      (c_rape > 28.5) => 0.2104168194,
      (c_rape = NULL) => 0.1326540277, 0.1326540277),
   (c_rape > 66) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.26265960445) => 0.0437294251,
      (f_add_curr_mobility_index_i > 0.26265960445) => -0.0224415096,
      (f_add_curr_mobility_index_i = NULL) => 0.0116672196, 0.0116672196),
   (c_rape = NULL) => 0.0582299660, 0.0582299660),
(f_mos_liens_unrel_SC_fseen_d > 124.5) => 0.0008348912,
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 2.65) => -0.0503092688,
   (c_hval_200k_p > 2.65) => 0.0582064093,
   (c_hval_200k_p = NULL) => 0.0015477809, 0.0015477809), 0.0022852205);

// Tree: 134 
woFDN_FLAPS__lgt_134 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 31.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 0.0008471629,
   (r_C14_addrs_10yr_i > 10.5) => 0.1115184198,
   (r_C14_addrs_10yr_i = NULL) => 0.0013014411, 0.0013014411),
(f_rel_under100miles_cnt_d > 31.5) => 
   map(
   (NULL < c_health and c_health <= 1.05) => -0.1442758626,
   (c_health > 1.05) => -0.0300904932,
   (c_health = NULL) => -0.0657734212, -0.0657734212),
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 165.5) => 
      map(
      (NULL < c_murders and c_murders <= 32.5) => 0.0721532545,
      (c_murders > 32.5) => -0.0496110717,
      (c_murders = NULL) => -0.0236757098, -0.0236757098),
   (c_assault > 165.5) => 0.1071476983,
   (c_assault = NULL) => -0.0029984538, -0.0029984538), 0.0003190018);

// Tree: 135 
woFDN_FLAPS__lgt_135 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0038070327,
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 57.5) => 0.1505361159,
   (c_rest_indx > 57.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 11.15) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0540684784,
         (r_C23_inp_addr_occ_index_d > 2) => 0.0594942653,
         (r_C23_inp_addr_occ_index_d = NULL) => -0.0189181053, -0.0189181053),
      (c_hval_175k_p > 11.15) => 0.1117436149,
      (c_hval_175k_p = NULL) => 0.0134966948, 0.0134966948),
   (c_rest_indx = NULL) => 0.0335439464, 0.0335439464),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.5) => -0.0396622603,
   (c_pop_35_44_p > 15.5) => 0.0673721618,
   (c_pop_35_44_p = NULL) => 0.0105973814, 0.0105973814), -0.0022940880);

// Tree: 136 
woFDN_FLAPS__lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 9.45) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 0.95) => 0.0459534991,
      (c_low_hval > 0.95) => 0.2892150658,
      (c_low_hval = NULL) => 0.1302841756, 0.1302841756),
   (c_hh1_p > 9.45) => 0.0159559748,
   (c_hh1_p = NULL) => 0.0765836015, 0.0248979612),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -29731.5) => -0.0791240856,
      (f_addrchangeincomediff_d > -29731.5) => -0.0069654075,
      (f_addrchangeincomediff_d = NULL) => -0.0058861541, -0.0076086354),
   (f_rel_homeover500_count_d > 14.5) => 0.1115027715,
   (f_rel_homeover500_count_d = NULL) => -0.0064958825, -0.0064958825),
(f_hh_members_ct_d = NULL) => -0.0087873968, -0.0005588458);

// Tree: 137 
woFDN_FLAPS__lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 61.5) => -0.0236993492,
   (c_unempl > 61.5) => 0.0058803479,
   (c_unempl = NULL) => 0.0255351351, -0.0007330165),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1194136562,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 100.5) => -0.0760757742,
      (c_blue_empl > 100.5) => 0.0537770714,
      (c_blue_empl = NULL) => -0.0058129331, -0.0058129331),
   (C_INC_75K_P = NULL) => -0.0396746871, -0.0396746871),
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.1) => -0.0627467982,
   (c_hval_80k_p > 0.1) => 0.0464531142,
   (c_hval_80k_p = NULL) => -0.0124955110, -0.0124955110), -0.0014868258);

// Tree: 138 
woFDN_FLAPS__lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 153.5) => -0.0087382698,
   (f_prevaddrageoldest_d > 153.5) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 36.5) => 0.1378957602,
      (c_retired2 > 36.5) => 0.0169537542,
      (c_retired2 = NULL) => 0.0050272784, 0.0239858674),
   (f_prevaddrageoldest_d = NULL) => -0.0010453768, -0.0010453768),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.35) => 0.1203253119,
      (C_INC_200K_P > 0.35) => -0.0386575307,
      (C_INC_200K_P = NULL) => 0.0016376598, 0.0016376598),
   (f_vardobcountnew_i > 0.5) => 0.1565427791,
   (f_vardobcountnew_i = NULL) => 0.0466101138, 0.0466101138),
(f_curraddrcrimeindex_i = NULL) => -0.0188731562, -0.0000311371);

// Tree: 139 
woFDN_FLAPS__lgt_139 := map(
(NULL < c_hval_40k_p and c_hval_40k_p <= 36.05) => 
   map(
   (NULL < c_incollege and c_incollege <= 15.05) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.5) => 
            map(
            (NULL < c_preschl and c_preschl <= 117) => 0.1884771207,
            (c_preschl > 117) => 0.0365359915,
            (c_preschl = NULL) => 0.1011109714, 0.1011109714),
         (c_pop_45_54_p > 16.5) => -0.0437846532,
         (c_pop_45_54_p = NULL) => 0.0533520784, 0.0533520784),
      (r_C21_M_Bureau_ADL_FS_d > 6.5) => 0.0014619412,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0061265011, 0.0023055835),
   (c_incollege > 15.05) => -0.0480567734,
   (c_incollege = NULL) => -0.0006641067, -0.0006641067),
(c_hval_40k_p > 36.05) => -0.1265144103,
(c_hval_40k_p = NULL) => -0.0294667475, -0.0018852267);

// Tree: 140 
woFDN_FLAPS__lgt_140 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.45) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0002785025,
      (k_inq_per_ssn_i > 0.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 1.595) => 0.2866887400,
         (c_hhsize > 1.595) => 
            map(
            (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0304932226) => 0.1676364985,
            (f_add_input_nhood_MFD_pct_i > 0.0304932226) => 0.0222944321,
            (f_add_input_nhood_MFD_pct_i = NULL) => 0.0248035644, 0.0402015566),
         (c_hhsize = NULL) => 0.0534016941, 0.0534016941),
      (k_inq_per_ssn_i = NULL) => 0.0226127891, 0.0226127891),
   (f_hh_members_ct_d > 1.5) => -0.0037947311,
   (f_hh_members_ct_d = NULL) => -0.0091762186, 0.0010486410),
(c_hval_80k_p > 41.45) => -0.0953119066,
(c_hval_80k_p = NULL) => -0.0225008498, -0.0002819639);

// Tree: 141 
woFDN_FLAPS__lgt_141 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 208.9) => 
      map(
      (NULL < c_unemp and c_unemp <= 11.25) => 
         map(
         (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
            map(
            (NULL < c_new_homes and c_new_homes <= 194.5) => -0.0010192636,
            (c_new_homes > 194.5) => 0.1435173023,
            (c_new_homes = NULL) => 0.0099913817, 0.0099913817),
         (k_inq_ssns_per_addr_i > 2.5) => 0.1015934321,
         (k_inq_ssns_per_addr_i = NULL) => 0.0145188393, 0.0145188393),
      (c_unemp > 11.25) => 0.1272236263,
      (c_unemp = NULL) => 0.0177281884, 0.0177281884),
   (c_cpiall > 208.9) => -0.0058973417,
   (c_cpiall = NULL) => -0.0108418924, -0.0025813345),
(r_L77_Add_PO_Box_i > 0.5) => -0.0888887003,
(r_L77_Add_PO_Box_i = NULL) => -0.0045544631, -0.0045544631);

// Tree: 142 
woFDN_FLAPS__lgt_142 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 75.35) => 
   map(
   (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 25.5) => 0.0011633385,
   (f_rel_incomeover25_count_d > 25.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 29.5) => -0.1190191574,
      (f_mos_inq_banko_cm_lseen_d > 29.5) => -0.0225844817,
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0421155552, -0.0421155552),
   (f_rel_incomeover25_count_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 182183.5) => 0.0917322138,
      (r_L80_Inp_AVM_AutoVal_d > 182183.5) => -0.0481773784,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0301206649, -0.0105033725), -0.0005404890),
(c_rnt1000_p > 75.35) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 191.5) => -0.0036405378,
   (r_A50_pb_average_dollars_d > 191.5) => 0.1870327561,
   (r_A50_pb_average_dollars_d = NULL) => 0.0722396506, 0.0722396506),
(c_rnt1000_p = NULL) => 0.0266506293, 0.0011985701);

// Tree: 143 
woFDN_FLAPS__lgt_143 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 
   map(
   (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0017278683,
      (c_hval_200k_p > 16.45) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.1217838195,
         (f_corrssnaddrcount_d > 2.5) => 0.0281128598,
         (f_corrssnaddrcount_d = NULL) => 0.0363169573, 0.0363169573),
      (c_hval_200k_p = NULL) => 0.0065241380, 0.0018128242),
   (f_inq_Auto_count24_i > 1.5) => -0.0436764440,
   (f_inq_Auto_count24_i = NULL) => -0.0006026643, -0.0006026643),
(f_inq_QuizProvider_count_i > 6.5) => 0.1019246672,
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1281) => 0.0546395058,
   (c_popover18 > 1281) => -0.0625256750,
   (c_popover18 = NULL) => -0.0059289351, -0.0059289351), 0.0001135332);

// Tree: 144 
woFDN_FLAPS__lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 11.5) => -0.0034812972,
      (f_srchssnsrchcount_i > 11.5) => 0.0520073524,
      (f_srchssnsrchcount_i = NULL) => -0.0026976933, -0.0026976933),
   (f_assocsuspicousidcount_i > 9.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 46.75) => 0.0566365544,
      (r_C12_source_profile_d > 46.75) => -0.0724458837,
      (r_C12_source_profile_d = NULL) => -0.0486345602, -0.0486345602),
   (f_assocsuspicousidcount_i = NULL) => -0.0127217186, -0.0039594340),
(c_rnt2001_p > 49) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 9.15) => 0.0537051142,
   (c_rnt1500_p > 9.15) => 0.2531433174,
   (c_rnt1500_p = NULL) => 0.0912231921, 0.0912231921),
(c_rnt2001_p = NULL) => 0.0082316712, -0.0014148359);

// Tree: 145 
woFDN_FLAPS__lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 56.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 18.55) => -0.0881377263,
   (c_fammar_p > 18.55) => -0.0052672999,
   (c_fammar_p = NULL) => 0.0093708270, -0.0056284580),
(k_comb_age_d > 56.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 250.95) => 0.0215041154,
   (c_housingcpi > 250.95) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 377.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 73.2) => 0.0379171793,
         (r_C12_source_profile_d > 73.2) => 0.3718849869,
         (r_C12_source_profile_d = NULL) => 0.2112023625, 0.2112023625),
      (f_M_Bureau_ADL_FS_all_d > 377.5) => -0.0604787875,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0995112231, 0.0995112231),
   (c_housingcpi = NULL) => 0.0354669198, 0.0273845782),
(k_comb_age_d = NULL) => -0.0054562202, 0.0009705193);

// Tree: 146 
woFDN_FLAPS__lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0054654842,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 114) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 94479.5) => 0.1703070419,
         (f_curraddrmedianvalue_d > 94479.5) => 0.0217197190,
         (f_curraddrmedianvalue_d = NULL) => 0.0916855944, 0.0916855944),
      (c_span_lang > 114) => -0.0318183840,
      (c_span_lang = NULL) => 0.0479365362, 0.0479365362),
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0492498986,
      (c_high_hval > 3.7) => 0.0612859447,
      (c_high_hval = NULL) => 0.0075391585, 0.0075391585), -0.0039888139),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.0945345531,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0032820243, -0.0032820243);

// Tree: 147 
woFDN_FLAPS__lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < c_fammar18_p and c_fammar18_p <= 56.85) => -0.0010778239,
   (c_fammar18_p > 56.85) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 165.5) => 0.0166040168,
      (c_lar_fam > 165.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 56) => 0.0294102666,
         (c_no_labfor > 56) => 0.2958190742,
         (c_no_labfor = NULL) => 0.1710720929, 0.1710720929),
      (c_lar_fam = NULL) => 0.0445680650, 0.0445680650),
   (c_fammar18_p = NULL) => -0.0398670199, 0.0006569014),
(f_prevaddrcartheftindex_i > 194.5) => -0.0710593847,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 6.5) => -0.0226716199,
   (c_hval_250k_p > 6.5) => 0.0802071678,
   (c_hval_250k_p = NULL) => 0.0237081614, 0.0237081614), -0.0001903394);

// Tree: 148 
woFDN_FLAPS__lgt_148 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0042008028,
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 8.55) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2233654488) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 3.35) => 0.2565611131,
         (c_femdiv_p > 3.35) => 0.0134979104,
         (c_femdiv_p = NULL) => 0.1405039082, 0.1405039082),
      (f_add_input_mobility_index_i > 0.2233654488) => 0.0218982486,
      (f_add_input_mobility_index_i = NULL) => 0.0473629066, 0.0473629066),
   (c_pop_65_74_p > 8.55) => 
      map(
      (NULL < c_retail and c_retail <= 11.95) => -0.1213282253,
      (c_retail > 11.95) => 0.0675737688,
      (c_retail = NULL) => -0.0449340365, -0.0449340365),
   (c_pop_65_74_p = NULL) => 0.0281402661, 0.0281402661),
(k_inq_per_phone_i = NULL) => -0.0025180984, -0.0025180984);

// Tree: 149 
woFDN_FLAPS__lgt_149 := map(
(NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 2.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 47510) => -0.0454148124,
   (r_L80_Inp_AVM_AutoVal_d > 47510) => 0.0108948593,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.0825508882,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.2) => -0.0318549845,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.2) => 0.0676112968,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0040050429, -0.0021075468),
      (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0009655993, -0.0009655993), 0.0043007313),
(f_srchaddrsrchcountmo_i > 2.5) => -0.0830318569,
(f_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 87.5) => 0.0637462069,
   (c_very_rich > 87.5) => -0.0504450096,
   (c_very_rich = NULL) => 0.0015527765, 0.0015527765), 0.0038351972);

// Tree: 150 
woFDN_FLAPS__lgt_150 := map(
(NULL < c_low_ed and c_low_ed <= 77.75) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.8) => 0.1050804385,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.8) => -0.0541230746,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 3.55) => -0.0484866336,
         (c_femdiv_p > 3.55) => 
            map(
            (NULL < c_no_car and c_no_car <= 47.5) => 0.2633043073,
            (c_no_car > 47.5) => 0.0390571524,
            (c_no_car = NULL) => 0.1014563607, 0.1014563607),
         (c_femdiv_p = NULL) => 0.0459979929, 0.0459979929), 0.0405263652),
   (f_corrssnnamecount_d > 1.5) => -0.0022242902,
   (f_corrssnnamecount_d = NULL) => 0.0063143871, 0.0002172877),
(c_low_ed > 77.75) => -0.0488071766,
(c_low_ed = NULL) => 0.0082245904, -0.0009709329);

// Tree: 151 
woFDN_FLAPS__lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.94867404285) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 0.0044739386,
         (k_inq_per_phone_i > 6.5) => 0.0743996643,
         (k_inq_per_phone_i = NULL) => 0.0051998609, 0.0051998609),
      (f_add_curr_nhood_MFD_pct_i > 0.94867404285) => -0.0415000412,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0193290064, -0.0006952683),
   (k_inq_adls_per_phone_i > 3.5) => -0.0925181509,
   (k_inq_adls_per_phone_i = NULL) => -0.0011064374, -0.0011064374),
(r_C14_addrs_10yr_i > 10.5) => 0.0991774696,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 99.5) => -0.0556599870,
   (c_no_car > 99.5) => 0.0439061071,
   (c_no_car = NULL) => -0.0097064051, -0.0097064051), -0.0007728583);

// Tree: 152 
woFDN_FLAPS__lgt_152 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => -0.0019085954,
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < c_health and c_health <= 24.55) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 114.5) => -0.0139327860,
         (f_fp_prevaddrburglaryindex_i > 114.5) => 0.0507905788,
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.0087440133, 0.0087440133),
      (c_health > 24.55) => 0.0974597164,
      (c_health = NULL) => 0.0210877602, 0.0210877602),
   (f_inq_Communications_count_i = NULL) => 0.0001741350, 0.0001741350),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0944103557,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.25) => -0.0644167518,
   (c_high_hval > 2.25) => 0.0695815587,
   (c_high_hval = NULL) => 0.0032204906, 0.0032204906), -0.0001790042);

// Tree: 153 
woFDN_FLAPS__lgt_153 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32739754485) => 0.0061123810,
(f_add_input_mobility_index_i > 0.32739754485) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 74.65) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
         map(
         (NULL < c_rnt500_p and c_rnt500_p <= 65.75) => -0.0306847721,
         (c_rnt500_p > 65.75) => 0.1407801845,
         (c_rnt500_p = NULL) => -0.0253087038, -0.0253087038),
      (k_inq_per_ssn_i > 2.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 9.35) => 0.1164856996,
         (C_INC_50K_P > 9.35) => 0.0029914618,
         (C_INC_50K_P = NULL) => 0.0329083529, 0.0329083529),
      (k_inq_per_ssn_i = NULL) => -0.0165825347, -0.0165825347),
   (c_low_ed > 74.65) => -0.0941397419,
   (c_low_ed = NULL) => -0.0071591105, -0.0191400802),
(f_add_input_mobility_index_i = NULL) => 0.0476866430, -0.0004233196);

// Tree: 154 
woFDN_FLAPS__lgt_154 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 13.75) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.86465236285) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 14.5) => 0.0685349363,
      (c_many_cars > 14.5) => -0.0041488621,
      (c_many_cars = NULL) => -0.0017244329, -0.0017244329),
   (f_add_curr_nhood_MFD_pct_i > 0.86465236285) => -0.0592587864,
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0170932026, -0.0072206492),
(c_hval_500k_p > 13.75) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 0.0153387947,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1975.5) => 0.2178864175,
      (c_med_yearblt > 1975.5) => -0.0478006684,
      (c_med_yearblt = NULL) => 0.0983272289, 0.0983272289),
   (k_comb_age_d = NULL) => 0.0189378594, 0.0189378594),
(c_hval_500k_p = NULL) => 0.0183611521, -0.0008658814);

// Tree: 155 
woFDN_FLAPS__lgt_155 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34701) => -0.0001196035,
(f_addrchangevaluediff_d > 34701) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 1.85) => 0.1295727125,
   (C_INC_200K_P > 1.85) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3344839322) => -0.0242556419,
      (f_add_curr_mobility_index_i > 0.3344839322) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 780) => 0.1475758400,
         (c_hh00 > 780) => -0.0399949049,
         (c_hh00 = NULL) => 0.0555940324, 0.0555940324),
      (f_add_curr_mobility_index_i = NULL) => 0.0022758793, 0.0022758793),
   (C_INC_200K_P = NULL) => 0.0252092513, 0.0252092513),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => -0.0391864992,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0045726752,
   (nf_seg_FraudPoint_3_0 = '') => -0.0059350815, -0.0059350815), -0.0006550189);

// Tree: 156 
woFDN_FLAPS__lgt_156 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => 0.0015253427,
(f_srchfraudsrchcount_i > 6.5) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 3.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 757.5) => -0.0982156652,
      (c_popover18 > 757.5) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 141.5) => -0.0288343889,
         (f_curraddrcartheftindex_i > 141.5) => 0.0920686898,
         (f_curraddrcartheftindex_i = NULL) => -0.0025362616, -0.0025362616),
      (c_popover18 = NULL) => -0.0198117094, -0.0198117094),
   (f_crim_rel_under25miles_cnt_i > 3.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 65) => -0.1614449807,
      (f_mos_inq_banko_cm_fseen_d > 65) => -0.0444817454,
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.1029633630, -0.1029633630),
   (f_crim_rel_under25miles_cnt_i = NULL) => -0.0353250777, -0.0353250777),
(f_srchfraudsrchcount_i = NULL) => 0.0081883599, 0.0000233627);

// Tree: 157 
woFDN_FLAPS__lgt_157 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21894) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 13.35) => 0.1805906126,
      (c_blue_col > 13.35) => -0.0296304770,
      (c_blue_col = NULL) => 0.0659245638, 0.0659245638),
   (r_A46_Curr_AVM_AutoVal_d > 21894) => 0.0046367697,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_hval_20k_p and c_hval_20k_p <= 28.15) => -0.0079658686,
      (c_hval_20k_p > 28.15) => 0.1023119856,
      (c_hval_20k_p = NULL) => -0.0147775803, -0.0063642973), 0.0003995401),
(f_inq_HighRiskCredit_count24_i > 8.5) => 0.0758043955,
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0696070977,
   (k_nap_lname_verd_d > 0.5) => -0.0614131128,
   (k_nap_lname_verd_d = NULL) => -0.0026799150, -0.0026799150), 0.0007874883);

// Tree: 158 
woFDN_FLAPS__lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 10.5) => 
         map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 31.5) => 0.0926918546,
         (f_mos_liens_unrel_SC_fseen_d > 31.5) => -0.0021336964,
         (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0016250831, -0.0016250831),
      (f_inq_HighRiskCredit_count24_i > 10.5) => 0.0779112185,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0013032041, -0.0013032041),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 543) => -0.1510787856,
      (r_A50_pb_total_dollars_d > 543) => -0.0129309081,
      (r_A50_pb_total_dollars_d = NULL) => -0.0697040084, -0.0697040084),
   (r_I60_inq_comm_count12_i = NULL) => -0.0021020616, -0.0021020616),
(r_D33_eviction_count_i > 3.5) => 0.0829563289,
(r_D33_eviction_count_i = NULL) => 0.0112512123, -0.0014844119);

// Tree: 159 
woFDN_FLAPS__lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0007533072,
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 2.95) => -0.0371347164,
      (c_rnt1000_p > 2.95) => 0.0929619693,
      (c_rnt1000_p = NULL) => 0.0466859670, 0.0466859670),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0001698791, -0.0001698791),
(f_rel_homeover500_count_d > 19.5) => 0.1227098614,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.72711108105) => -0.0448852993,
   (f_add_curr_nhood_SFD_pct_d > 0.72711108105) => 0.1509414623,
   (f_add_curr_nhood_SFD_pct_d = NULL) => 
      map(
      (NULL < c_burglary and c_burglary <= 97.5) => -0.0476705995,
      (c_burglary > 97.5) => 0.0525773625,
      (c_burglary = NULL) => 0.0020321716, 0.0020321716), 0.0062819686), 0.0005878328);

// Tree: 160 
woFDN_FLAPS__lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 74.6) => -0.0067999967,
(r_C12_source_profile_d > 74.6) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.25) => 0.1285350833,
      (c_high_ed > 5.25) => 0.0121588912,
      (c_high_ed = NULL) => -0.0196134529, 0.0154982937),
   (f_srchaddrsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 3.55) => -0.0208776310,
      (c_unemp > 3.55) => 0.1737199285,
      (c_unemp = NULL) => 0.0988747133, 0.0988747133),
   (f_srchaddrsrchcountmo_i = NULL) => 0.0197063691, 0.0197063691),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 7.4) => -0.0454809558,
   (C_INC_25K_P > 7.4) => 0.0647524153,
   (C_INC_25K_P = NULL) => 0.0065736917, 0.0065736917), -0.0011361806);

// Tree: 161 
woFDN_FLAPS__lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 2.15) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 2.545) => -0.0363386733,
      (c_hhsize > 2.545) => -0.1451620932,
      (c_hhsize = NULL) => -0.0971716409, -0.0971716409),
   (C_INC_150K_P > 2.15) => -0.0160767189,
   (C_INC_150K_P = NULL) => -0.0371352390, -0.0371352390),
(f_mos_inq_banko_cm_fseen_d > 25.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0046951326,
   (f_hh_tot_derog_i > 4.5) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 54.5) => -0.0247668163,
      (f_curraddrburglaryindex_i > 54.5) => 0.0802784163,
      (f_curraddrburglaryindex_i = NULL) => 0.0397790495, 0.0397790495),
   (f_hh_tot_derog_i = NULL) => -0.0025313829, -0.0025313829),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0026418684, -0.0042808777);

// Tree: 162 
woFDN_FLAPS__lgt_162 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.255) => -0.0025530487,
   (c_hhsize > 4.255) => 0.0651998172,
   (c_hhsize = NULL) => 0.0133391901, -0.0014292534),
(f_phones_per_addr_curr_i > 44.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 21.95) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 535) => 0.1020298792,
      (f_mos_inq_banko_cm_fseen_d > 535) => -0.0484548314,
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0010467181, 0.0010467181),
   (C_INC_75K_P > 21.95) => 0.2332572917,
   (C_INC_75K_P = NULL) => 0.0619174510, 0.0619174510),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.45) => -0.0385130832,
   (c_pop_55_64_p > 9.45) => 0.0642110757,
   (c_pop_55_64_p = NULL) => 0.0189428023, 0.0189428023), -0.0001929997);

// Tree: 163 
woFDN_FLAPS__lgt_163 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 4.15) => 0.0414702923,
   (c_high_ed > 4.15) => -0.0053749467,
   (c_high_ed = NULL) => 0.0099764349, -0.0036402951),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_hh_age_30_plus_d and f_hh_age_30_plus_d <= 2.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 0.5) => 
         map(
         (NULL < c_preschl and c_preschl <= 94.5) => 0.3066074048,
         (c_preschl > 94.5) => 0.0426239917,
         (c_preschl = NULL) => 0.1746156983, 0.1746156983),
      (f_srchphonesrchcount_i > 0.5) => -0.0400821608,
      (f_srchphonesrchcount_i = NULL) => 0.1042836410, 0.1042836410),
   (f_hh_age_30_plus_d > 2.5) => -0.0511406316,
   (f_hh_age_30_plus_d = NULL) => 0.0524755501, 0.0524755501),
(r_P85_Phn_Disconnected_i = NULL) => -0.0024502941, -0.0024502941);

// Tree: 164 
woFDN_FLAPS__lgt_164 := map(
(NULL < c_manufacturing and c_manufacturing <= 16.35) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 102) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 72.5) => -0.0218264060,
      (f_prevaddrageoldest_d > 72.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0501059225,
         (f_phone_ver_experian_d > 0.5) => -0.0050676443,
         (f_phone_ver_experian_d = NULL) => 0.0079767991, 0.0138826561),
      (f_prevaddrageoldest_d = NULL) => -0.0048473495, -0.0048473495),
   (f_curraddrcartheftindex_i > 102) => 0.0189493295,
   (f_curraddrcartheftindex_i = NULL) => 0.0018051824, 0.0044742135),
(c_manufacturing > 16.35) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => -0.1032750955,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0237767701,
   (nf_seg_FraudPoint_3_0 = '') => -0.0366367934, -0.0366367934),
(c_manufacturing = NULL) => 0.0262972740, 0.0021047150);

// Tree: 165 
woFDN_FLAPS__lgt_165 := map(
(NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 25.05) => 
      map(
      (NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 29.5) => 
         map(
         (NULL < c_retail and c_retail <= 43.95) => 0.0080811556,
         (c_retail > 43.95) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 124.5) => 0.1903563394,
            (c_span_lang > 124.5) => -0.0125082062,
            (c_span_lang = NULL) => 0.0954680842, 0.0954680842),
         (c_retail = NULL) => 0.0101146810, 0.0101146810),
      (f_liens_rel_O_total_amt_i > 29.5) => -0.1158933484,
      (f_liens_rel_O_total_amt_i = NULL) => 0.0163136678, 0.0088564142),
   (c_pop_55_64_p > 25.05) => 0.1627349716,
   (c_pop_55_64_p = NULL) => 0.0131205978, 0.0103582451),
(k_inf_lname_verd_d > 0.5) => -0.0238341213,
(k_inf_lname_verd_d = NULL) => -0.0009385785, -0.0009385785);

// Tree: 166 
woFDN_FLAPS__lgt_166 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 10.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 113.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.9) => 0.1939960711,
         (r_C12_source_profile_d > 60.9) => -0.0106629808,
         (r_C12_source_profile_d = NULL) => 0.0995380471, 0.0995380471),
      (c_bargains > 113.5) => -0.0135327964,
      (c_bargains = NULL) => 0.0513166580, 0.0513166580),
   (r_D32_Mos_Since_Crim_LS_d > 10.5) => -0.0002668453,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0005779752, 0.0005779752),
(f_srchfraudsrchcountyr_i > 10.5) => -0.0923862305,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 14.9) => 0.0346952987,
   (c_hh3_p > 14.9) => -0.0583232263,
   (c_hh3_p = NULL) => -0.0150777717, -0.0150777717), 0.0000659067);

// Tree: 167 
woFDN_FLAPS__lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 194) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 74.05) => 0.0217275178,
         (r_C12_source_profile_d > 74.05) => 
            map(
            (NULL < c_low_hval and c_low_hval <= 0.55) => 0.2321046044,
            (c_low_hval > 0.55) => 0.0040006553,
            (c_low_hval = NULL) => 0.1338159109, 0.1338159109),
         (r_C12_source_profile_d = NULL) => 0.0363477430, 0.0363477430),
      (c_rnt750_p > 57.25) => 0.1753649900,
      (c_rnt750_p = NULL) => 0.0454410416, 0.0454410416),
   (f_liens_unrel_CJ_total_amt_i > 194) => -0.0809714389,
   (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0362621942, 0.0362621942),
(c_many_cars > 22.5) => -0.0075353339,
(c_many_cars = NULL) => 0.0133202615, -0.0032671446);

// Tree: 168 
woFDN_FLAPS__lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0064518393,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1894.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 13.5) => 0.0066605457,
      (f_corraddrnamecount_d > 13.5) => 0.1693676004,
      (f_corraddrnamecount_d = NULL) => 0.0213672092, 0.0213672092),
   (c_popover18 > 1894.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.55) => 0.0008590241,
      (c_hh6_p > 1.55) => 
         map(
         (NULL < c_unattach and c_unattach <= 89.5) => 0.1170362373,
         (c_unattach > 89.5) => 0.3254620436,
         (c_unattach = NULL) => 0.2192450462, 0.2192450462),
      (c_hh6_p = NULL) => 0.1336785931, 0.1336785931),
   (c_popover18 = NULL) => 0.0433915746, 0.0433915746),
(c_hval_150k_p = NULL) => -0.0062440819, -0.0030207888);

// Tree: 169 
woFDN_FLAPS__lgt_169 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 66.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1280453639,
   (r_C12_source_profile_d > 57.95) => -0.0208026760,
   (r_C12_source_profile_d = NULL) => 0.0484530093, 0.0484530093),
(f_mos_liens_unrel_SC_fseen_d > 66.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 192.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 12.05) => -0.0032856092,
      (c_unemp > 12.05) => -0.0889709504,
      (c_unemp = NULL) => -0.0038678747, -0.0038678747),
   (c_unempl > 192.5) => 0.0748818548,
   (c_unempl = NULL) => 0.0040698200, -0.0031730018),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16) => -0.0620358676,
   (c_pop_35_44_p > 16) => 0.0490712819,
   (c_pop_35_44_p = NULL) => -0.0105973724, -0.0105973724), -0.0026560077);

// Tree: 170 
woFDN_FLAPS__lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 96.5) => -0.0144384421,
   (c_easiqlife > 96.5) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
         map(
         (NULL < c_highrent and c_highrent <= 99.95) => 0.0059061106,
         (c_highrent > 99.95) => 0.0939563526,
         (c_highrent = NULL) => 0.0089853614, 0.0089853614),
      (r_P85_Phn_Disconnected_i > 0.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.21126580455) => 0.0809737837,
         (f_add_input_nhood_MFD_pct_i > 0.21126580455) => 0.1671079049,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.1205489205, 0.1205489205),
      (r_P85_Phn_Disconnected_i = NULL) => 0.0109881936, 0.0109881936),
   (c_easiqlife = NULL) => -0.0350420172, 0.0008142794),
(f_util_adl_count_n > 13.5) => 0.1197384548,
(f_util_adl_count_n = NULL) => 0.0134989068, 0.0018460438);

// Tree: 171 
woFDN_FLAPS__lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 40.7) => 
      map(
      (NULL < c_info and c_info <= 3.05) => -0.0080445562,
      (c_info > 3.05) => 0.1450687134,
      (c_info = NULL) => 0.0038781984, 0.0038781984),
   (C_RENTOCC_P > 40.7) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
         map(
         (NULL < c_totsales and c_totsales <= 624) => 0.1827420494,
         (c_totsales > 624) => 0.0660360102,
         (c_totsales = NULL) => 0.0830266269, 0.0830266269),
      (f_divrisktype_i > 1.5) => -0.0259601044,
      (f_divrisktype_i = NULL) => 0.0598771896, 0.0598771896),
   (C_RENTOCC_P = NULL) => 0.0384834828, 0.0216234528),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0008944001,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0126636063, 0.0022484459);

// Tree: 172 
woFDN_FLAPS__lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0067311749) => -0.0278109112,
         (f_add_curr_nhood_BUS_pct_i > 0.0067311749) => 0.0061906623,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 
            map(
            (NULL < c_high_hval and c_high_hval <= 78.65) => -0.0395836019,
            (c_high_hval > 78.65) => 0.1671802953,
            (c_high_hval = NULL) => -0.0137946694, -0.0137946694), 0.0006261220),
      (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0623806685,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0108194875, 0.0003961129),
   (c_manufacturing > 16.55) => -0.0501242398,
   (c_manufacturing = NULL) => -0.0034976110, -0.0034976110),
(c_pop_0_5_p > 20.55) => 0.1339072588,
(c_pop_0_5_p = NULL) => 0.0011408815, -0.0027735458);

// Tree: 173 
woFDN_FLAPS__lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.4) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0068303543,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 118.5) => 0.1983912294,
         (c_easiqlife > 118.5) => 0.0408534929,
         (c_easiqlife = NULL) => 0.1142820989, 0.1142820989),
      (r_C12_Num_NonDerogs_d > 1.5) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 15.45) => 0.0295257456,
         (C_INC_25K_P > 15.45) => -0.0471645287,
         (C_INC_25K_P = NULL) => 0.0167673150, 0.0167673150),
      (r_C12_Num_NonDerogs_d = NULL) => 0.0232867170, 0.0232867170),
   (f_rel_felony_count_i = NULL) => 0.0057721857, -0.0024128932),
(c_low_hval > 71.4) => -0.1095374278,
(c_low_hval = NULL) => -0.0373613897, -0.0038745944);

// Tree: 174 
woFDN_FLAPS__lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < c_info and c_info <= 27.55) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 
         map(
         (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 0.0108083547,
         (f_dl_addrs_per_adl_i > 0.5) => -0.0163685970,
         (f_dl_addrs_per_adl_i = NULL) => 0.0000690572, 0.0000690572),
      (f_srchssnsrchcount_i > 21.5) => 0.0788931070,
      (f_srchssnsrchcount_i = NULL) => 0.0005170687, 0.0005170687),
   (c_info > 27.55) => 0.1880951242,
   (c_info = NULL) => -0.0034707546, 0.0014129058),
(f_srchphonesrchcount_i > 22.5) => -0.1125566008,
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_health and c_health <= 7.05) => 0.0258212025,
   (c_health > 7.05) => -0.0802343627,
   (c_health = NULL) => -0.0315850209, -0.0315850209), 0.0005091836);

// Tree: 175 
woFDN_FLAPS__lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0094286314,
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0063743597,
   (r_F03_input_add_not_most_rec_i > 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1267588201) => 
         map(
         (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.1792236124,
         (k_nap_fname_verd_d > 0.5) => 
            map(
            (NULL < c_blue_empl and c_blue_empl <= 103) => -0.0757022835,
            (c_blue_empl > 103) => 0.1505320167,
            (c_blue_empl = NULL) => 0.0219458546, 0.0219458546),
         (k_nap_fname_verd_d = NULL) => 0.0635926129, 0.0635926129),
      (f_add_curr_nhood_BUS_pct_i > 0.1267588201) => 0.3517357297,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.1024259170, 0.1024259170),
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0202140464, 0.0202140464),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0053256756, -0.0027774444);

// Tree: 176 
woFDN_FLAPS__lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 0.0038613273,
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_robbery and c_robbery <= 165.5) => 0.0252773971,
         (c_robbery > 165.5) => 0.1907615175,
         (c_robbery = NULL) => 0.0406712688, 0.0406712688),
      (c_pop_55_64_p > 17.45) => 0.2471618324,
      (c_pop_55_64_p = NULL) => 0.0585536215, 0.0585536215),
   (f_util_adl_count_n = NULL) => 0.0112763284, 0.0074367759),
(c_pop_18_24_p > 11.15) => -0.0259212815,
(c_pop_18_24_p = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 25) => 0.1656422997,
   (f_mos_inq_banko_cm_lseen_d > 25) => -0.0014431141,
   (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0283935670, 0.0283935670), 0.0003251484);

// Tree: 177 
woFDN_FLAPS__lgt_177 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -69166) => 0.0792728496,
      (f_addrchangevaluediff_d > -69166) => 0.0072060035,
      (f_addrchangevaluediff_d = NULL) => 0.0121238439, 0.0096418257),
   (f_rel_incomeover100_count_d > 0.5) => -0.0119727889,
   (f_rel_incomeover100_count_d = NULL) => 0.0112594909, 0.0010569585),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 119.5) => -0.0079121999,
   (c_easiqlife > 119.5) => 0.1438486916,
   (c_easiqlife = NULL) => 0.0637526655, 0.0637526655),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_new_homes and c_new_homes <= 114.5) => -0.0608355358,
   (c_new_homes > 114.5) => 0.0489911474,
   (c_new_homes = NULL) => -0.0069027896, -0.0069027896), 0.0017156604);

// Tree: 178 
woFDN_FLAPS__lgt_178 := map(
(NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0100273143,
(f_phones_per_addr_c6_i > 0.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 40.55) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1322749531) => 
         map(
         (NULL < c_unempl and c_unempl <= 176.5) => 0.0142235052,
         (c_unempl > 176.5) => 0.1125889584,
         (c_unempl = NULL) => 0.0179254308, 0.0179254308),
      (f_add_curr_nhood_BUS_pct_i > 0.1322749531) => 
         map(
         (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0478676410,
         (f_hh_lienholders_i > 0.5) => 0.1451193033,
         (f_hh_lienholders_i = NULL) => 0.0792391450, 0.0792391450),
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0046541681, 0.0244161417),
   (c_hh1_p > 40.55) => -0.0254863737,
   (c_hh1_p = NULL) => 0.0760088522, 0.0151999168),
(f_phones_per_addr_c6_i = NULL) => -0.0010461416, -0.0010461416);

// Tree: 179 
woFDN_FLAPS__lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0012694270,
   (f_assocsuspicousidcount_i > 13.5) => 0.0892689954,
   (f_assocsuspicousidcount_i = NULL) => -0.0008206245, -0.0008206245),
(f_rel_incomeover50_count_d > 22.5) => -0.0575554280,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 10.7) => 0.0448238465,
         (c_hh4_p > 10.7) => 0.1621348984,
         (c_hh4_p = NULL) => 0.1161128703, 0.1161128703),
      (c_asian_lang > 158.5) => -0.0262514680,
      (c_asian_lang = NULL) => 0.0560034830, 0.0560034830),
   (c_pop_45_54_p > 16.85) => -0.0888550342,
   (c_pop_45_54_p = NULL) => 0.0173116315, 0.0173116315), -0.0015423585);

// Tree: 180 
woFDN_FLAPS__lgt_180 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => 
         map(
         (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 33.5) => 
            map(
            (NULL < c_many_cars and c_many_cars <= 74.5) => -0.1366617479,
            (c_many_cars > 74.5) => -0.0166062227,
            (c_many_cars = NULL) => -0.0594831960, -0.0594831960),
         (f_mos_liens_unrel_CJ_fseen_d > 33.5) => 0.0011468806,
         (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0147723376, 0.0005725157),
      (k_inq_per_phone_i > 9.5) => 0.0949813328,
      (k_inq_per_phone_i = NULL) => 0.0009715004, 0.0009715004),
   (k_inq_adls_per_ssn_i > 1.5) => 0.1318523168,
   (k_inq_adls_per_ssn_i = NULL) => 0.0015222931, 0.0015222931),
(k_inq_adls_per_phone_i > 2.5) => -0.0743058670,
(k_inq_adls_per_phone_i = NULL) => 0.0009783150, 0.0009783150);

// Tree: 181 
woFDN_FLAPS__lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 9.35) => -0.0096938312,
   (C_INC_35K_P > 9.35) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0614611819) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 8.55) => -0.0105485613,
         (C_INC_125K_P > 8.55) => 0.1592193646,
         (C_INC_125K_P = NULL) => 0.0438558320, 0.0438558320),
      (f_add_input_nhood_VAC_pct_i > 0.0614611819) => 0.1805643743,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0794000530, 0.0794000530),
   (C_INC_35K_P = NULL) => 0.0302330055, 0.0302330055),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => 
   map(
   (NULL < c_rnt250_p and c_rnt250_p <= 14.25) => 0.0005821618,
   (c_rnt250_p > 14.25) => -0.0437935093,
   (c_rnt250_p = NULL) => -0.0112611523, -0.0046584533),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0183654438, -0.0022777342);

// Tree: 182 
woFDN_FLAPS__lgt_182 := map(
(NULL < c_burglary and c_burglary <= 178.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 186.5) => 
      map(
      (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0002031114,
      (f_hh_tot_derog_i > 4.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 2.65) => -0.0186689792,
         (c_hval_175k_p > 2.65) => 
            map(
            (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.2086760971,
            (r_D30_Derog_Count_i > 0.5) => 0.0397148233,
            (r_D30_Derog_Count_i = NULL) => 0.0814581968, 0.0814581968),
         (c_hval_175k_p = NULL) => 0.0411609678, 0.0411609678),
      (f_hh_tot_derog_i = NULL) => 0.0018483277, 0.0018483277),
   (f_fp_prevaddrburglaryindex_i > 186.5) => 0.1187098212,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0020356889, 0.0023365238),
(c_burglary > 178.5) => -0.0388623145,
(c_burglary = NULL) => 0.0190874129, 0.0001324485);

// Tree: 183 
woFDN_FLAPS__lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 0.5) => -0.0131302176,
      (f_srchphonesrchcount_i > 0.5) => 
         map(
         (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 2.5) => 0.0094163451,
         (f_inq_Collection_count24_i > 2.5) => 0.1068919052,
         (f_inq_Collection_count24_i = NULL) => 0.0118987787, 0.0118987787),
      (f_srchphonesrchcount_i = NULL) => -0.0031705753, -0.0031705753),
   (k_inq_adls_per_addr_i > 3.5) => -0.0483207128,
   (k_inq_adls_per_addr_i = NULL) => -0.0040710466, -0.0040710466),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0768496336,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 98.5) => -0.0631351940,
   (c_burglary > 98.5) => 0.0468234489,
   (c_burglary = NULL) => -0.0060412832, -0.0060412832), -0.0046100775);

// Tree: 184 
woFDN_FLAPS__lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 7.5) => 0.0006302750,
   (f_util_adl_count_n > 7.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1357528602) => 0.1897226916,
         (f_add_curr_nhood_MFD_pct_i > 0.1357528602) => 
            map(
            (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => 0.0947018608,
            (f_rel_homeover300_count_d > 1.5) => -0.0786038616,
            (f_rel_homeover300_count_d = NULL) => 0.0097154008, 0.0097154008),
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0677822688, 0.0677822688),
      (f_phone_ver_experian_d > 0.5) => -0.0091643232,
      (f_phone_ver_experian_d = NULL) => 0.0583119064, 0.0249241471),
   (f_util_adl_count_n = NULL) => 0.0085754538, 0.0017727377),
(C_RENTOCC_P > 92.2) => -0.0932812885,
(C_RENTOCC_P = NULL) => 0.0248838462, 0.0015580424);

// Tree: 185 
woFDN_FLAPS__lgt_185 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 61.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.7) => 0.1574817037,
      (c_fammar_p > 44.7) => 0.0397208380,
      (c_fammar_p = NULL) => 0.0802829140, 0.0802829140),
   (c_no_teens > 61.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.75) => -0.0517922392,
      (c_hh6_p > 1.75) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 150.5) => 0.1972325918,
         (f_fp_prevaddrburglaryindex_i > 150.5) => -0.0464836090,
         (f_fp_prevaddrburglaryindex_i = NULL) => 0.0868312359, 0.0868312359),
      (c_hh6_p = NULL) => 0.0017356373, 0.0017356373),
   (c_no_teens = NULL) => 0.0574269225, 0.0360527501),
(k_estimated_income_d > 27500) => 0.0008642334,
(k_estimated_income_d = NULL) => -0.0030496905, 0.0024829926);

// Tree: 186 
woFDN_FLAPS__lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 4.25) => 
      map(
      (NULL < c_med_age and c_med_age <= 25.15) => 0.1036526481,
      (c_med_age > 25.15) => -0.0201118785,
      (c_med_age = NULL) => -0.0177455059, -0.0177455059),
   (c_incollege > 4.25) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 23.05) => 0.0070052702,
      (C_INC_25K_P > 23.05) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 0.5) => -0.0191756517,
         (f_hh_collections_ct_i > 0.5) => 0.1634863919,
         (f_hh_collections_ct_i = NULL) => 0.0841726098, 0.0841726098),
      (C_INC_25K_P = NULL) => 0.0083938621, 0.0083938621),
   (c_incollege = NULL) => -0.0040823455, 0.0001644291),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0695952862,
(f_inq_PrepaidCards_count_i = NULL) => 0.0306730159, 0.0006981001);

// Tree: 187 
woFDN_FLAPS__lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 3.5) => 
      map(
      (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => -0.0040001693,
      (r_L72_Add_Vacant_i > 0.5) => 0.0931012800,
      (r_L72_Add_Vacant_i = NULL) => -0.0033522324, -0.0033522324),
   (r_C20_email_domain_free_count_i > 3.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0076023990,
      (r_D30_Derog_Count_i > 1.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2921335638) => 0.0378668859,
         (f_add_curr_mobility_index_i > 0.2921335638) => 0.1953864136,
         (f_add_curr_mobility_index_i = NULL) => 0.1026531433, 0.1026531433),
      (r_D30_Derog_Count_i = NULL) => 0.0367233378, 0.0367233378),
   (r_C20_email_domain_free_count_i = NULL) => -0.0020342546, -0.0020342546),
(f_rel_bankrupt_count_i > 7.5) => -0.0776446049,
(f_rel_bankrupt_count_i = NULL) => -0.0057218448, -0.0030225462);

// Tree: 188 
woFDN_FLAPS__lgt_188 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 11.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 12.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','6: Other']) => -0.0135213198,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 0.0114570970,
      (nf_seg_FraudPoint_3_0 = '') => -0.0005237408, -0.0005237408),
   (f_srchfraudsrchcount_i > 12.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.15) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 103) => 0.0605933021,
         (r_C13_max_lres_d > 103) => -0.0775872086,
         (r_C13_max_lres_d = NULL) => -0.0084969532, -0.0084969532),
      (c_pop_45_54_p > 14.15) => 0.1176811741,
      (c_pop_45_54_p = NULL) => 0.0406911303, 0.0406911303),
   (f_srchfraudsrchcount_i = NULL) => 0.0000661319, 0.0000661319),
(r_L79_adls_per_addr_curr_i > 11.5) => -0.0648900665,
(r_L79_adls_per_addr_curr_i = NULL) => 0.0086203264, -0.0005373716);

// Tree: 189 
woFDN_FLAPS__lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0035496732,
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < c_burglary and c_burglary <= 45.5) => 0.1905797275,
      (c_burglary > 45.5) => -0.0403301038,
      (c_burglary = NULL) => 0.0773032065, 0.0773032065),
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 1) => 0.0959877687,
      (c_bigapt_p > 1) => -0.0530524068,
      (c_bigapt_p = NULL) => -0.0053898126, -0.0053898126), -0.0028892223),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => 0.0081305775,
   (f_rel_under25miles_cnt_d > 4.5) => 0.1543020482,
   (f_rel_under25miles_cnt_d = NULL) => 0.0653663943, 0.0653663943),
(f_phones_per_addr_curr_i = NULL) => -0.0006002354, -0.0019401163);

// Tree: 190 
woFDN_FLAPS__lgt_190 := map(
(NULL < c_hh2_p and c_hh2_p <= 51.15) => -0.0078359496,
(c_hh2_p > 51.15) => 
   map(
   (NULL < c_rape and c_rape <= 14.5) => 0.2575500467,
   (c_rape > 14.5) => 
      map(
      (NULL < f_varmsrcssnunrelcount_i and f_varmsrcssnunrelcount_i <= 0.5) => 0.1597370586,
      (f_varmsrcssnunrelcount_i > 0.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 12.8) => -0.0629147360,
         (c_hh3_p > 12.8) => 
            map(
            (NULL < c_mort_indx and c_mort_indx <= 100.5) => 0.2296737152,
            (c_mort_indx > 100.5) => -0.0200335437,
            (c_mort_indx = NULL) => 0.0916775985, 0.0916775985),
         (c_hh3_p = NULL) => -0.0136870094, -0.0136870094),
      (f_varmsrcssnunrelcount_i = NULL) => 0.0211526471, 0.0211526471),
   (c_rape = NULL) => 0.0460613195, 0.0460613195),
(c_hh2_p = NULL) => -0.0260318435, -0.0061190455);

// Tree: 191 
woFDN_FLAPS__lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => -0.0039248215,
(c_totcrime > 163.5) => 
   map(
   (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 162.5) => 0.0998732461,
      (c_cartheft > 162.5) => -0.0073580325,
      (c_cartheft = NULL) => 0.0267247716, 0.0267247716),
   (f_rel_ageover30_count_d > 13.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1043299272) => 0.1673863852,
      (f_add_curr_nhood_MFD_pct_i > 0.1043299272) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => -0.0902649311,
         (f_phone_ver_insurance_d > 2.5) => 0.1038217046,
         (f_phone_ver_insurance_d = NULL) => 0.0256076872, 0.0256076872),
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0668660385, 0.0668660385),
   (f_rel_ageover30_count_d = NULL) => -0.0086018250, 0.0316067320),
(c_totcrime = NULL) => -0.0345858747, -0.0008947605);

// Tree: 192 
woFDN_FLAPS__lgt_192 := map(
(NULL < c_unempl and c_unempl <= 165.5) => 0.0007778137,
(c_unempl > 165.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.34149557305) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 30.9) => -0.1261432619,
         (c_hh2_p > 30.9) => -0.0304327498,
         (c_hh2_p = NULL) => -0.0770286570, -0.0770286570),
      (f_add_curr_mobility_index_i > 0.34149557305) => -0.0367437012,
      (f_add_curr_mobility_index_i = NULL) => -0.0667599428, -0.0667599428),
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 149.5) => -0.0442579501,
      (f_prevaddrmurderindex_i > 149.5) => 0.0419950785,
      (f_prevaddrmurderindex_i = NULL) => -0.0166725220, -0.0166725220),
   (nf_seg_FraudPoint_3_0 = '') => -0.0284207157, -0.0284207157),
(c_unempl = NULL) => -0.0035161376, -0.0013318013);

// Tree: 193 
woFDN_FLAPS__lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 14.15) => -0.0094886241,
   (c_pop_6_11_p > 14.15) => 0.0752036295,
   (c_pop_6_11_p = NULL) => -0.0226277710, -0.0082570462),
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < c_sub_bus and c_sub_bus <= 166.5) => 0.0069526455,
   (c_sub_bus > 166.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','6: Other']) => 0.0414285160,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.66879220905) => 0.2033710133,
         (f_add_input_nhood_SFD_pct_d > 0.66879220905) => 0.0218878011,
         (f_add_input_nhood_SFD_pct_d = NULL) => 0.1247282880, 0.1247282880),
      (nf_seg_FraudPoint_3_0 = '') => 0.0632537838, 0.0632537838),
   (c_sub_bus = NULL) => -0.0354216484, 0.0148839406),
(f_prevaddrageoldest_d = NULL) => -0.0149234285, -0.0029024950);

// Tree: 194 
woFDN_FLAPS__lgt_194 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
      map(
      (NULL < c_highinc and c_highinc <= 8.45) => 0.0101993476,
      (c_highinc > 8.45) => -0.0504435490,
      (c_highinc = NULL) => -0.0045267113, -0.0250533993),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0034421859,
   (nf_seg_FraudPoint_3_0 = '') => 0.0014457529, 0.0014457529),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 82.5) => -0.1168427594,
   (c_no_teens > 82.5) => 0.0020190703,
   (c_no_teens = NULL) => -0.0464765562, -0.0464765562),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.95) => -0.0597509481,
   (c_retail > 9.95) => 0.0369305089,
   (c_retail = NULL) => -0.0094126688, -0.0094126688), 0.0008581065);

// Tree: 195 
woFDN_FLAPS__lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 35.65) => 
   map(
   (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 196.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 2.5) => 0.1495560024,
      (f_mos_inq_banko_cm_fseen_d > 2.5) => 
         map(
         (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 258) => -0.0712087060,
         (f_mos_liens_unrel_FT_fseen_d > 258) => 0.0057808319,
         (f_mos_liens_unrel_FT_fseen_d = NULL) => 0.0047264465, 0.0047264465),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0055973107, 0.0055973107),
   (f_prevaddrmurderindex_i > 196.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.04652068545) => -0.1320817826,
      (f_add_curr_nhood_BUS_pct_i > 0.04652068545) => -0.0771651097,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.1016814815, -0.1016814815),
   (f_prevaddrmurderindex_i = NULL) => -0.0149531750, 0.0044117309),
(c_hval_80k_p > 35.65) => -0.0826694302,
(c_hval_80k_p = NULL) => 0.0201460781, 0.0035531288);

// Tree: 196 
woFDN_FLAPS__lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0889970501,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 25.75) => -0.0266612505,
      (c_vacant_p > 25.75) => 0.1285886417,
      (c_vacant_p = NULL) => -0.0765602527, -0.0230520462),
   (f_addrs_per_ssn_i > 4.5) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 16.5) => 0.0079361318,
      (k_inq_per_ssn_i > 16.5) => -0.0796231624,
      (k_inq_per_ssn_i = NULL) => 0.0073702596, 0.0073702596),
   (f_addrs_per_ssn_i = NULL) => 0.0000062187, 0.0000062187),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 1.25) => -0.0431441586,
   (c_hval_150k_p > 1.25) => 0.0781948007,
   (c_hval_150k_p = NULL) => 0.0169977603, 0.0169977603), -0.0020418738);

// Tree: 197 
woFDN_FLAPS__lgt_197 := map(
(NULL < c_hh4_p and c_hh4_p <= 10.95) => -0.0153878691,
(c_hh4_p > 10.95) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -13203.5) => 0.0673843981,
   (f_addrchangeincomediff_d > -13203.5) => 0.0078260704,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 10.45) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 4.5) => -0.0009512069,
         (f_assocsuspicousidcount_i > 4.5) => -0.0786366231,
         (f_assocsuspicousidcount_i = NULL) => -0.0139327593, -0.0139327593),
      (c_hh5_p > 10.45) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 154.5) => 0.0357397843,
         (c_easiqlife > 154.5) => 0.1910662440,
         (c_easiqlife = NULL) => 0.0565315151, 0.0565315151),
      (c_hh5_p = NULL) => 0.0031999073, 0.0031999073), 0.0080633032),
(c_hh4_p = NULL) => 0.0005700414, -0.0005244858);

// Tree: 198 
woFDN_FLAPS__lgt_198 := map(
(NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5693) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 40.45) => 0.0044615969,
   (c_famotf18_p > 40.45) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 4.65) => 
            map(
            (NULL < C_INC_25K_P and C_INC_25K_P <= 18.55) => -0.0847054743,
            (C_INC_25K_P > 18.55) => 0.0458498147,
            (C_INC_25K_P = NULL) => -0.0403811478, -0.0403811478),
         (C_INC_125K_P > 4.65) => 0.0871791373,
         (C_INC_125K_P = NULL) => -0.0050742832, -0.0050742832),
      (f_rel_incomeover50_count_d > 3.5) => -0.0837657986,
      (f_rel_incomeover50_count_d = NULL) => -0.0349378223, -0.0349378223),
   (c_famotf18_p = NULL) => -0.0276753421, 0.0025696101),
(f_liens_unrel_SC_total_amt_i > 5693) => 0.1135424873,
(f_liens_unrel_SC_total_amt_i = NULL) => 0.0008152830, 0.0030877702);

// Tree: 199 
woFDN_FLAPS__lgt_199 := map(
(NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0042129208,
(f_prevaddroccupantowned_i > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 65574.5) => 0.1480049046,
   (r_A46_Curr_AVM_AutoVal_d > 65574.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 10.5) => 
         map(
         (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 0.0290197357,
         (k_inq_ssns_per_addr_i > 1.5) => 0.1495003587,
         (k_inq_ssns_per_addr_i = NULL) => 0.0510176023, 0.0510176023),
      (f_rel_homeover50_count_d > 10.5) => -0.0495748862,
      (f_rel_homeover50_count_d = NULL) => 0.0176125920, 0.0176125920),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 133.5) => -0.0322410075,
      (c_sub_bus > 133.5) => 0.0863771671,
      (c_sub_bus = NULL) => 0.0146256139, 0.0146256139), 0.0247259549),
(f_prevaddroccupantowned_i = NULL) => 0.0058884970, -0.0020576288);

// Tree: 200 
woFDN_FLAPS__lgt_200 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 73.5) => -0.0014051977,
   (f_addrchangecrimediff_i > 73.5) => -0.0921728138,
   (f_addrchangecrimediff_i = NULL) => -0.0019374222, -0.0019374222),
(f_addrchangecrimediff_i > 98.5) => 0.0728635383,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 106) => -0.0874099240,
   (f_mos_liens_unrel_CJ_fseen_d > 106) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0241657397) => 0.0258132001,
      (f_add_curr_nhood_BUS_pct_i > 0.0241657397) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 7.5) => -0.0097365341,
         (f_srchaddrsrchcount_i > 7.5) => -0.0781794110,
         (f_srchaddrsrchcount_i = NULL) => -0.0150950512, -0.0150950512),
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0530064077, -0.0057386080),
   (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0010100457, -0.0087815062), -0.0030281519);

// Tree: 201 
woFDN_FLAPS__lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0057933185,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_larceny and c_larceny <= 178.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -25493) => 0.1022130145,
      (f_addrchangevaluediff_d > -25493) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 9.85) => 0.1618615103,
         (C_INC_75K_P > 9.85) => -0.0112488833,
         (C_INC_75K_P = NULL) => 0.0067446701, 0.0067446701),
      (f_addrchangevaluediff_d = NULL) => -0.0037971295, 0.0120398161),
   (c_larceny > 178.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 4.55) => -0.0251877704,
      (c_hval_175k_p > 4.55) => 0.2637306109,
      (c_hval_175k_p = NULL) => 0.1180367263, 0.1180367263),
   (c_larceny = NULL) => 0.0900553715, 0.0309858762),
(r_L70_Add_Standardized_i = NULL) => -0.0027373255, -0.0027373255);

// Tree: 202 
woFDN_FLAPS__lgt_202 := map(
(NULL < c_rich_nfam and c_rich_nfam <= 180.5) => -0.0040663685,
(c_rich_nfam > 180.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 7.55) => 
      map(
      (NULL < c_exp_homes and c_exp_homes <= 194.5) => 
         map(
         (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => 
            map(
            (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00963688095) => 0.1369278955,
            (f_add_curr_nhood_VAC_pct_i > 0.00963688095) => -0.0447198963,
            (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0011910841, 0.0011910841),
         (f_crim_rel_under25miles_cnt_i > 1.5) => 0.1118807055,
         (f_crim_rel_under25miles_cnt_i = NULL) => 0.0227412758, 0.0227412758),
      (c_exp_homes > 194.5) => 0.4226030153,
      (c_exp_homes = NULL) => 0.0728492632, 0.0728492632),
   (C_INC_125K_P > 7.55) => 0.0095186430,
   (C_INC_125K_P = NULL) => 0.0257478771, 0.0257478771),
(c_rich_nfam = NULL) => 0.0199009364, 0.0001391759);

// Tree: 203 
woFDN_FLAPS__lgt_203 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 120.5) => 0.0002300378,
(f_addrchangecrimediff_i > 120.5) => 0.0854674198,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.1332104519,
      (r_D33_Eviction_Recency_d > 549) => -0.0235984276,
      (r_D33_Eviction_Recency_d = NULL) => -0.0265951812, -0.0265951812),
   (f_phones_per_addr_curr_i > 4.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 153.5) => 
         map(
         (NULL < c_hval_20k_p and c_hval_20k_p <= 8.95) => -0.0047324081,
         (c_hval_20k_p > 8.95) => 0.1426175437,
         (c_hval_20k_p = NULL) => 0.0058967963, 0.0058967963),
      (c_easiqlife > 153.5) => 0.1246175069,
      (c_easiqlife = NULL) => 0.0215025900, 0.0215025900),
   (f_phones_per_addr_curr_i = NULL) => -0.0047329234, -0.0115082372), -0.0020925633);

// Tree: 204 
woFDN_FLAPS__lgt_204 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 80.75) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < r_L70_Add_Invalid_i and r_L70_Add_Invalid_i <= 0.5) => 0.0043416702,
      (r_L70_Add_Invalid_i > 0.5) => -0.0671844809,
      (r_L70_Add_Invalid_i = NULL) => 0.0034624491, 0.0034624491),
   (r_D33_eviction_count_i > 3.5) => 0.0665903501,
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1973.5) => 0.0599975483,
      (c_med_yearblt > 1973.5) => -0.0427577601,
      (c_med_yearblt = NULL) => 0.0076684561, 0.0076684561), 0.0039322252),
(C_RENTOCC_P > 80.75) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 38.15) => -0.0772517264,
   (c_hval_750k_p > 38.15) => 0.0801643381,
   (c_hval_750k_p = NULL) => -0.0530338703, -0.0530338703),
(C_RENTOCC_P = NULL) => -0.0042713492, 0.0018810224);

// Tree: 205 
woFDN_FLAPS__lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5922.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 3227.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 12.55) => 0.0013979493,
      (c_hh6_p > 12.55) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 74) => 0.1158884720,
         (c_low_ed > 74) => -0.0660148311,
         (c_low_ed = NULL) => 0.0747338786, 0.0747338786),
      (c_hh6_p = NULL) => -0.0122069756, 0.0023869646),
   (f_liens_unrel_SC_total_amt_i > 3227.5) => -0.0732391938,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0016560145, 0.0016560145),
(f_liens_unrel_ST_total_amt_i > 5922.5) => 0.1607852518,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1256) => 0.0577744601,
   (c_popover18 > 1256) => -0.0287005553,
   (c_popover18 = NULL) => 0.0117602317, 0.0117602317), 0.0023873961);

// Tree: 206 
woFDN_FLAPS__lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 186.5) => -0.0799062178,
(f_mos_liens_unrel_FT_lseen_d > 186.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 33969.5) => 
      map(
      (NULL < c_wholesale and c_wholesale <= 0.95) => 0.0108499014,
      (c_wholesale > 0.95) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.35) => 0.0006990509,
         (c_pop_35_44_p > 14.35) => 0.2244944487,
         (c_pop_35_44_p = NULL) => 0.1340565825, 0.1340565825),
      (c_wholesale = NULL) => -0.0043156005, 0.0326059836),
   (f_curraddrmedianvalue_d > 33969.5) => -0.0054592818,
   (f_curraddrmedianvalue_d = NULL) => -0.0034310514, -0.0034310514),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.05) => 0.0506118994,
   (c_pop_18_24_p > 8.05) => -0.0608605802,
   (c_pop_18_24_p = NULL) => -0.0045724964, -0.0045724964), -0.0042545659);

// Tree: 207 
woFDN_FLAPS__lgt_207 := map(
(NULL < f_srchunvrfdphonecount_i and f_srchunvrfdphonecount_i <= 1.5) => 
   map(
   (NULL < r_C22_stl_inq_Count24_i and r_C22_stl_inq_Count24_i <= 0.5) => 
      map(
      (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5701) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => 0.0007108876,
         (k_inq_per_phone_i > 9.5) => 0.0675475014,
         (k_inq_per_phone_i = NULL) => 0.0010915816, 0.0010915816),
      (f_liens_unrel_SC_total_amt_i > 5701) => 0.1211151529,
      (f_liens_unrel_SC_total_amt_i = NULL) => 0.0015849373, 0.0015849373),
   (r_C22_stl_inq_Count24_i > 0.5) => -0.0976989109,
   (r_C22_stl_inq_Count24_i = NULL) => 0.0011623145, 0.0011623145),
(f_srchunvrfdphonecount_i > 1.5) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 12.55) => -0.0260477568,
   (c_pop_18_24_p > 12.55) => -0.1116924786,
   (c_pop_18_24_p = NULL) => -0.0438093042, -0.0438093042),
(f_srchunvrfdphonecount_i = NULL) => -0.0158505980, -0.0002535558);

// Tree: 208 
woFDN_FLAPS__lgt_208 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0035648508,
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < c_rental and c_rental <= 129.5) => -0.0073007141,
   (c_rental > 129.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 12.6) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 16.5) => -0.0469559670,
         (r_C13_Curr_Addr_LRes_d > 16.5) => 0.0938387831,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0475247206, 0.0475247206),
      (c_hval_175k_p > 12.6) => 0.1724256018,
      (c_hval_175k_p = NULL) => 0.0789037597, 0.0789037597),
   (c_rental = NULL) => 0.0270794591, 0.0270794591),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 86) => 0.0533838445,
   (c_robbery > 86) => -0.0533795490,
   (c_robbery = NULL) => -0.0052879303, -0.0052879303), -0.0023245322);

// Tree: 209 
woFDN_FLAPS__lgt_209 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => 0.0005519933,
(r_D30_Derog_Count_i > 4.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.18322199235) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.09861632865) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 0.05) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 66500) => 0.1722428355,
            (k_estimated_income_d > 66500) => 0.0429666906,
            (k_estimated_income_d = NULL) => 0.0837082635, 0.0837082635),
         (c_hval_125k_p > 0.05) => 0.0039204963,
         (c_hval_125k_p = NULL) => 0.0266972811, 0.0266972811),
      (f_add_input_nhood_BUS_pct_i > 0.09861632865) => -0.0521619767,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0126952822, 0.0126952822),
   (f_add_curr_nhood_BUS_pct_i > 0.18322199235) => 0.1625956725,
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0256377128, 0.0256377128),
(r_D30_Derog_Count_i = NULL) => 0.0097594506, 0.0022315809);

// Tree: 210 
woFDN_FLAPS__lgt_210 := map(
(NULL < c_families and c_families <= 110.5) => -0.0704502728,
(c_families > 110.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0055190512,
   (f_corrrisktype_i > 7.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 13.45) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 0.1005639042,
         (f_rel_under100miles_cnt_d > 0.5) => -0.0279252334,
         (f_rel_under100miles_cnt_d = NULL) => -0.0157618899, -0.0157618899),
      (c_pop_45_54_p > 13.45) => 
         map(
         (NULL < c_unattach and c_unattach <= 127.5) => 0.0258264456,
         (c_unattach > 127.5) => 0.1007000955,
         (c_unattach = NULL) => 0.0451451570, 0.0451451570),
      (c_pop_45_54_p = NULL) => 0.0161573112, 0.0161573112),
   (f_corrrisktype_i = NULL) => -0.0022793202, -0.0031602764),
(c_families = NULL) => 0.0136812325, -0.0039197252);

// Tree: 211 
woFDN_FLAPS__lgt_211 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 18.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 11.5) => 0.0003273739,
   (k_inq_per_addr_i > 11.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 11.85) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2688976816) => 0.0863335057,
         (f_add_curr_mobility_index_i > 0.2688976816) => -0.0640596220,
         (f_add_curr_mobility_index_i = NULL) => 0.0007650020, 0.0007650020),
      (C_INC_125K_P > 11.85) => 0.1578541273,
      (C_INC_125K_P = NULL) => 0.0491001175, 0.0491001175),
   (k_inq_per_addr_i = NULL) => 0.0010475931, 0.0010475931),
(f_rel_under100miles_cnt_d > 18.5) => -0.0337844728,
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 141345) => 0.1080085199,
   (r_L80_Inp_AVM_AutoVal_d > 141345) => -0.0120412458,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0428968793, -0.0107304781), -0.0013741835);

// Tree: 212 
woFDN_FLAPS__lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0047953418) => -0.0362830371,
   (f_add_curr_nhood_BUS_pct_i > 0.0047953418) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 14.55) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 17.5) => -0.0324718672,
         (f_mos_inq_banko_om_fseen_d > 17.5) => 0.0090061477,
         (f_mos_inq_banko_om_fseen_d = NULL) => 0.0063188397, 0.0063188397),
      (c_hh7p_p > 14.55) => -0.0853143764,
      (c_hh7p_p = NULL) => 0.0106561925, 0.0055943171),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0165971328, 0.0001057590),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.4304599763) => 0.0040153249,
   (f_add_curr_nhood_MFD_pct_i > 0.4304599763) => 0.0468175798,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0192804647, 0.0192804647),
(f_srchaddrsrchcount_i = NULL) => 0.0232631916, 0.0005670798);

// Tree: 213 
woFDN_FLAPS__lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1803.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 176.5) => 
         map(
         (NULL < c_retired and c_retired <= 4.75) => 0.0817853944,
         (c_retired > 4.75) => 0.0028379819,
         (c_retired = NULL) => 0.0117858142, 0.0117858142),
      (c_sub_bus > 176.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 106) => 0.0221496310,
         (c_no_labfor > 106) => 0.1840707133,
         (c_no_labfor = NULL) => 0.0834483264, 0.0834483264),
      (c_sub_bus = NULL) => 0.0159077336, 0.0159077336),
   (f_liens_unrel_SC_total_amt_i > 1803.5) => 0.1647800702,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0188887575, 0.0188887575),
(r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0093153139,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0020300507, 0.0011423047);

// Tree: 214 
woFDN_FLAPS__lgt_214 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 0.0035503232,
   (f_inq_Communications_count24_i > 1.5) => 
      map(
      (NULL < c_preschl and c_preschl <= 150) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.14556920545) => 0.0492101062,
         (f_add_curr_nhood_MFD_pct_i > 0.14556920545) => -0.0569285787,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0184725334, -0.0184725334),
      (c_preschl > 150) => 0.1423646214,
      (c_preschl = NULL) => 0.0333224825, 0.0333224825),
   (f_inq_Communications_count24_i = NULL) => 0.0041162344, 0.0041162344),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0781974546,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.85) => -0.0595950018,
   (c_pop_35_44_p > 14.85) => 0.0343862489,
   (c_pop_35_44_p = NULL) => -0.0107970447, -0.0107970447), 0.0036365024);

// Tree: 215 
woFDN_FLAPS__lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42) => 0.1449457281,
(f_mos_liens_unrel_FT_fseen_d > 42) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125594) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -30.5) => 0.1269053427,
      (f_addrchangecrimediff_i > -30.5) => 0.0224678671,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.017284056) => 0.1291782360,
         (f_add_input_nhood_BUS_pct_i > 0.017284056) => 
            map(
            (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 1.5) => 0.0213125479,
            (f_crim_rel_under500miles_cnt_i > 1.5) => -0.0729600163,
            (f_crim_rel_under500miles_cnt_i = NULL) => -0.0217177863, -0.0217177863),
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0159082349, 0.0159082349), 0.0238423054),
   (r_A46_Curr_AVM_AutoVal_d > 125594) => -0.0026725859,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0043619002, 0.0007632203),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0138858452, 0.0012490002);

// Tree: 216 
woFDN_FLAPS__lgt_216 := map(
(NULL < c_asian_lang and c_asian_lang <= 181.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0017266677,
   (r_L79_adls_per_addr_c6_i > 4.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.080982906) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 90.5) => 0.0923545005,
         (r_pb_order_freq_d > 90.5) => -0.0503433163,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < c_low_ed and c_low_ed <= 59.25) => 0.0521605842,
            (c_low_ed > 59.25) => 0.1674992890,
            (c_low_ed = NULL) => 0.0868862157, 0.0868862157), 0.0650569893),
      (f_add_input_nhood_BUS_pct_i > 0.080982906) => -0.0266976331,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0352226642, 0.0352226642),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0032912500, 0.0032912500),
(c_asian_lang > 181.5) => -0.0269599582,
(c_asian_lang = NULL) => 0.0176709778, -0.0007038862);

// Tree: 217 
woFDN_FLAPS__lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33052.5) => -0.0696872713,
(f_addrchangeincomediff_d > -33052.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0070715508,
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < c_health and c_health <= 2.35) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 96) => 0.0259645113,
         (f_fp_prevaddrcrimeindex_i > 96) => 0.1083939141,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0633505246, 0.0633505246),
      (c_health > 2.35) => 0.0020869193,
      (c_health = NULL) => 0.0187641075, 0.0187641075),
   (f_sourcerisktype_i = NULL) => 0.0001149688, 0.0001149688),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 29.55) => -0.0068840161,
   (c_hval_150k_p > 29.55) => 0.0912197931,
   (c_hval_150k_p = NULL) => 0.0251957345, -0.0004876123), -0.0007157562);

// Tree: 218 
woFDN_FLAPS__lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 188.5) => 
      map(
      (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 37.05) => -0.0156823736,
         (c_famotf18_p > 37.05) => 0.0952556468,
         (c_famotf18_p = NULL) => -0.0033559269, -0.0033559269),
      (f_prevaddroccupantowned_i > 0.5) => 0.1296847808,
      (f_prevaddroccupantowned_i = NULL) => 0.0130581864, 0.0130581864),
   (c_exp_homes > 188.5) => 0.2400029807,
   (c_exp_homes = NULL) => 0.0436154515, 0.0337731177),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0086404098,
   (f_inq_Other_count_i > 0.5) => 0.0192709688,
   (f_inq_Other_count_i = NULL) => -0.0021596420, -0.0021596420),
(f_rel_incomeover25_count_d = NULL) => -0.0266803262, -0.0004225800);

// Tree: 219 
woFDN_FLAPS__lgt_219 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0051527930,
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 34.15) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 20501.5) => -0.0955766956,
      (f_prevaddrmedianincome_d > 20501.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 22.25) => 0.0079655717,
         (c_hval_250k_p > 22.25) => 
            map(
            (NULL < c_totcrime and c_totcrime <= 32.5) => 0.1731157302,
            (c_totcrime > 32.5) => 0.0259798139,
            (c_totcrime = NULL) => 0.0708779060, 0.0708779060),
         (c_hval_250k_p = NULL) => 0.0182865336, 0.0182865336),
      (f_prevaddrmedianincome_d = NULL) => 0.0149533009, 0.0149533009),
   (c_hval_100k_p > 34.15) => 0.1133985072,
   (c_hval_100k_p = NULL) => 0.1077339951, 0.0188085412),
(f_hh_collections_ct_i = NULL) => -0.0115372522, 0.0015105907);

// Tree: 220 
woFDN_FLAPS__lgt_220 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
   map(
   (NULL < c_food and c_food <= 62.65) => -0.0088272695,
   (c_food > 62.65) => 
      map(
      (NULL < c_assault and c_assault <= 74.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.01504815985) => 0.0343019172,
         (f_add_curr_nhood_VAC_pct_i > 0.01504815985) => 0.2229979357,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1209164831, 0.1209164831),
      (c_assault > 74.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.09640669375) => -0.0505923252,
         (f_add_curr_nhood_VAC_pct_i > 0.09640669375) => 0.0993229283,
         (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0173364767, -0.0173364767),
      (c_assault = NULL) => 0.0368516537, 0.0368516537),
   (c_food = NULL) => -0.0482644758, -0.0076470355),
(r_L70_Add_Standardized_i > 0.5) => 0.0337697159,
(r_L70_Add_Standardized_i = NULL) => -0.0040555159, -0.0040555159);

// Tree: 221 
woFDN_FLAPS__lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 11.25) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 49.75) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 165.5) => 0.1544968779,
         (c_asian_lang > 165.5) => -0.0140049371,
         (c_asian_lang = NULL) => 0.1036788702, 0.1036788702),
      (c_newhouse > 49.75) => -0.0822767485,
      (c_newhouse = NULL) => 0.0711975394, 0.0711975394),
   (f_corrssnnamecount_d > 1.5) => 0.0041710040,
   (f_corrssnnamecount_d = NULL) => -0.0097905309, 0.0073869349),
(C_INC_25K_P > 11.25) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => -0.0080975588,
   (f_inq_count24_i > 2.5) => -0.0551567742,
   (f_inq_count24_i = NULL) => -0.0171952787, -0.0171952787),
(C_INC_25K_P = NULL) => -0.0130053889, 0.0007175270);

// Tree: 222 
woFDN_FLAPS__lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0048671506,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < c_health and c_health <= 8.65) => -0.0143744325,
   (c_health > 8.65) => 0.1502433313,
   (c_health = NULL) => 0.0636524844, 0.0636524844),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 984.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 22.5) => -0.0748013378,
      (f_prevaddrageoldest_d > 22.5) => -0.0217121749,
      (f_prevaddrageoldest_d = NULL) => -0.0430907975, -0.0430907975),
   (c_popover18 > 984.5) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 36.7) => 0.0108760470,
      (c_trailer_p > 36.7) => 0.1884051899,
      (c_trailer_p = NULL) => 0.0172642112, 0.0172642112),
   (c_popover18 = NULL) => 0.0183321753, -0.0004973259), -0.0029415784);

// Tree: 223 
woFDN_FLAPS__lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 81428.5) => -0.1017052107,
   (f_prevaddrmedianvalue_d > 81428.5) => 
      map(
      (NULL < c_rental and c_rental <= 136.5) => 
         map(
         (NULL < C_INC_100K_P and C_INC_100K_P <= 12.85) => 0.1635023446,
         (C_INC_100K_P > 12.85) => -0.0270648026,
         (C_INC_100K_P = NULL) => 0.0429966485, 0.0429966485),
      (c_rental > 136.5) => -0.0825618913,
      (c_rental = NULL) => -0.0086399804, -0.0086399804),
   (f_prevaddrmedianvalue_d = NULL) => -0.0384755984, -0.0384755984),
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 
   map(
   (NULL < r_nas_ssn_verd_d and r_nas_ssn_verd_d <= 0.5) => 0.0962369889,
   (r_nas_ssn_verd_d > 0.5) => 0.0000353924,
   (r_nas_ssn_verd_d = NULL) => 0.0016068975, 0.0016068975),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0043082080, 0.0017144438);

// Tree: 224 
woFDN_FLAPS__lgt_224 := map(
(NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 4.5) => -0.0379915489,
      (f_rel_under500miles_cnt_d > 4.5) => 0.0742408566,
      (f_rel_under500miles_cnt_d = NULL) => 0.0424628974, 0.0078006330),
   (c_hval_20k_p > 0.65) => 0.1679853781,
   (c_hval_20k_p = NULL) => 0.0447663434, 0.0447663434),
(f_M_Bureau_ADL_FS_all_d > 10.5) => 
   map(
   (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 0.5) => 
      map(
      (NULL < c_food and c_food <= 47.75) => 0.0008986275,
      (c_food > 47.75) => 0.0363797320,
      (c_food = NULL) => 0.0088398109, 0.0042360160),
   (r_S65_SSN_Problem_i > 0.5) => -0.0594646126,
   (r_S65_SSN_Problem_i = NULL) => 0.0019786007, 0.0019786007),
(f_M_Bureau_ADL_FS_all_d = NULL) => 0.0226683417, 0.0031786546);

// Tree: 225 
woFDN_FLAPS__lgt_225 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 289973.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 0.1110839563,
      (r_C10_M_Hdr_FS_d > 7.5) => 0.0000204400,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0012799232, 0.0012799232),
   (r_L80_Inp_AVM_AutoVal_d > 289973.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 24.65) => 0.0218162133,
      (c_pop_35_44_p > 24.65) => 0.1851271484,
      (c_pop_35_44_p = NULL) => 0.0281912426, 0.0281912426),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0121155844, -0.0001719379),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 240.5) => 0.2456410687,
   (f_M_Bureau_ADL_FS_noTU_d > 240.5) => 0.0284789563,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0932466039, 0.0932466039),
(f_adls_per_phone_c6_i = NULL) => 0.0010873897, 0.0010873897);

// Tree: 226 
woFDN_FLAPS__lgt_226 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 19.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 14.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0787343148,
      (r_D33_Eviction_Recency_d > 30) => 
         map(
         (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 5.5) => 
            map(
            (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0141984061,
            (f_corrphonelastnamecount_d > 0.5) => -0.0137996426,
            (f_corrphonelastnamecount_d = NULL) => -0.0018438172, -0.0018438172),
         (f_inq_HighRiskCredit_count24_i > 5.5) => 0.0691879213,
         (f_inq_HighRiskCredit_count24_i = NULL) => -0.0014057936, -0.0014057936),
      (r_D33_Eviction_Recency_d = NULL) => -0.0007982279, -0.0007982279),
   (f_rel_under100miles_cnt_d > 14.5) => -0.0277829642,
   (f_rel_under100miles_cnt_d = NULL) => -0.0058109288, -0.0037993532),
(r_D30_Derog_Count_i > 19.5) => -0.1117872287,
(r_D30_Derog_Count_i = NULL) => -0.0000233710, -0.0042418509);

// Tree: 227 
woFDN_FLAPS__lgt_227 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -100) => -0.0917594224,
(f_addrchangecrimediff_i > -100) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 14.5) => -0.0009245556,
   (r_D30_Derog_Count_i > 14.5) => 0.0831544986,
   (r_D30_Derog_Count_i = NULL) => -0.0003017478, -0.0003017478),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.65) => 0.0156375829,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.65) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.00154835035) => 0.2183872031,
      (f_add_input_nhood_VAC_pct_i > 0.00154835035) => 
         map(
         (NULL < c_robbery and c_robbery <= 156.5) => -0.0034907416,
         (c_robbery > 156.5) => 0.1578853132,
         (c_robbery = NULL) => 0.0364538264, 0.0364538264),
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0795433104, 0.0795433104),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0053807353, 0.0067527568), 0.0007569578);

// Tree: 228 
woFDN_FLAPS__lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 16.5) => -0.0010508044,
   (f_inq_Collection_count_i > 16.5) => -0.0877198125,
   (f_inq_Collection_count_i = NULL) => -0.0016815625, -0.0016815625),
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 20.6) => -0.1211184025,
   (c_hh2_p > 20.6) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 15.85) => -0.0625275111,
      (C_INC_50K_P > 15.85) => 
         map(
         (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2933510108) => 0.0933695760,
         (f_add_input_mobility_index_i > 0.2933510108) => -0.0419295173,
         (f_add_input_mobility_index_i = NULL) => 0.0243935677, 0.0243935677),
      (C_INC_50K_P = NULL) => -0.0298118283, -0.0298118283),
   (c_hh2_p = NULL) => -0.0491879327, -0.0491879327),
(f_assocsuspicousidcount_i = NULL) => -0.0066757683, -0.0030340746);

// Tree: 229 
woFDN_FLAPS__lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 22.95) => -0.0027193100,
   (c_hval_150k_p > 22.95) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 5.5) => 
         map(
         (NULL < c_asian_lang and c_asian_lang <= 168.5) => 0.0038362223,
         (c_asian_lang > 168.5) => 0.1491424364,
         (c_asian_lang = NULL) => 0.0219480450, 0.0219480450),
      (f_assocrisktype_i > 5.5) => 
         map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 3.5) => 0.0034532537,
         (f_sourcerisktype_i > 3.5) => 0.1958953806,
         (f_sourcerisktype_i = NULL) => 0.0912338730, 0.0912338730),
      (f_assocrisktype_i = NULL) => 0.0315804650, 0.0315804650),
   (c_hval_150k_p = NULL) => 0.0106310245, -0.0000776447),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0658201841,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0173514329, -0.0029426429);

// Tree: 230 
woFDN_FLAPS__lgt_230 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 17.15) => 
         map(
         (NULL < c_hh6_p and c_hh6_p <= 10.75) => 0.0015769961,
         (c_hh6_p > 10.75) => 
            map(
            (NULL < c_rnt250_p and c_rnt250_p <= 2.3) => 0.0954744088,
            (c_rnt250_p > 2.3) => -0.0577378485,
            (c_rnt250_p = NULL) => 0.0574469061, 0.0574469061),
         (c_hh6_p = NULL) => 0.0028621057, 0.0028621057),
      (c_hh6_p > 17.15) => -0.1037671740,
      (c_hh6_p = NULL) => -0.0194975625, 0.0018264849),
   (f_inq_count24_i > 14.5) => -0.0919743133,
   (f_inq_count24_i = NULL) => -0.0019143460, 0.0010618938),
(f_bus_addr_match_count_d > 52.5) => 0.1292303797,
(f_bus_addr_match_count_d = NULL) => 0.0017186499, 0.0017186499);

// Tree: 231 
woFDN_FLAPS__lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0005673969,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 12.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 15.45) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.1099713714,
         (r_L79_adls_per_addr_c6_i > 0.5) => -0.0222121435,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0153399914, 0.0153399914),
      (c_rnt500_p > 15.45) => 
         map(
         (NULL < c_construction and c_construction <= 8.6) => 0.1653982473,
         (c_construction > 8.6) => -0.0319714426,
         (c_construction = NULL) => 0.0954964821, 0.0954964821),
      (c_rnt500_p = NULL) => 0.0436305176, 0.0436305176),
   (f_rel_homeover200_count_d > 12.5) => -0.0793892907,
   (f_rel_homeover200_count_d = NULL) => 0.0269368066, 0.0269368066),
(f_srchvelocityrisktype_i = NULL) => 0.0124477046, 0.0006213608);

// Tree: 232 
woFDN_FLAPS__lgt_232 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 221.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 7.65) => -0.0223504543,
   (c_hval_150k_p > 7.65) => 0.1351432523,
   (c_hval_150k_p = NULL) => 0.0502336018, 0.0502336018),
(r_D32_Mos_Since_Fel_LS_d > 221.5) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 24.5) => -0.0031120778,
   (f_rel_homeover200_count_d > 24.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0407333665) => -0.0255764079,
      (f_add_curr_nhood_BUS_pct_i > 0.0407333665) => 0.1243136111,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0526994909, 0.0526994909),
   (f_rel_homeover200_count_d = NULL) => -0.0202055482, -0.0025219390),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.95) => -0.0631115638,
   (c_hh4_p > 11.95) => 0.0465574115,
   (c_hh4_p = NULL) => -0.0077830718, -0.0077830718), -0.0020880336);

// Tree: 233 
woFDN_FLAPS__lgt_233 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0541698103,
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 15.75) => 0.0079527577,
      (c_hval_250k_p > 15.75) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.0129315558,
         (f_corrssnnamecount_d > 3.5) => 
            map(
            (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0764554597,
            (r_S66_adlperssn_count_i > 1.5) => 0.2134549129,
            (r_S66_adlperssn_count_i = NULL) => 0.1437741566, 0.1437741566),
         (f_corrssnnamecount_d = NULL) => 0.0848639809, 0.0848639809),
      (c_hval_250k_p = NULL) => 0.0217890919, 0.0273373579),
   (f_corrssnaddrcount_d > 2.5) => -0.0085906091,
   (f_corrssnaddrcount_d = NULL) => -0.0060092399, -0.0060092399),
(f_corrssnaddrcount_d = NULL) => 0.0062888315, -0.0070487784);

// Tree: 234 
woFDN_FLAPS__lgt_234 := map(
(NULL < f_srchssnsrchcountmo_i and f_srchssnsrchcountmo_i <= 0.5) => -0.0057689791,
(f_srchssnsrchcountmo_i > 0.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 166.5) => 
      map(
      (NULL < c_food and c_food <= 1.3) => 0.1283682185,
      (c_food > 1.3) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.25) => -0.0616040630,
         (c_pop_35_44_p > 14.25) => 
            map(
            (NULL < c_work_home and c_work_home <= 96.5) => 0.1024922117,
            (c_work_home > 96.5) => -0.0370350562,
            (c_work_home = NULL) => 0.0212983779, 0.0212983779),
         (c_pop_35_44_p = NULL) => -0.0141162571, -0.0141162571),
      (c_food = NULL) => 0.0070797806, 0.0070797806),
   (c_relig_indx > 166.5) => 0.1759867202,
   (c_relig_indx = NULL) => 0.0320589759, 0.0320589759),
(f_srchssnsrchcountmo_i = NULL) => 0.0336906337, -0.0041911561);

// Tree: 235 
woFDN_FLAPS__lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0794253224) => 0.0095071824,
   (f_add_curr_nhood_VAC_pct_i > 0.0794253224) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 11.5) => 0.1523911782,
      (r_C13_Curr_Addr_LRes_d > 11.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 56.75) => 0.1115936562,
         (c_civ_emp > 56.75) => -0.0173457029,
         (c_civ_emp = NULL) => 0.0310065568, 0.0310065568),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0673633033, 0.0673633033),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0196094321, 0.0196094321),
(f_hh_members_ct_d > 1.5) => -0.0070688476,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0553945727,
   (c_pop_35_44_p > 15.55) => 0.0466569360,
   (c_pop_35_44_p = NULL) => -0.0060985049, -0.0060985049), -0.0020729798);

// Tree: 236 
woFDN_FLAPS__lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.75) => -0.0350116327,
(c_pop_45_54_p > 7.75) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0008685653,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.1359761229,
      (f_corrssnnamecount_d > 3.5) => 
         map(
         (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
            map(
            (NULL < c_retired2 and c_retired2 <= 52) => 0.0851969497,
            (c_retired2 > 52) => -0.0241251282,
            (c_retired2 = NULL) => -0.0033150880, -0.0033150880),
         (r_F01_inp_addr_not_verified_i > 0.5) => 0.0855599947,
         (r_F01_inp_addr_not_verified_i = NULL) => 0.0087688048, 0.0087688048),
      (f_corrssnnamecount_d = NULL) => 0.0295421100, 0.0295421100),
   (f_rel_felony_count_i = NULL) => 0.0038419903, 0.0022638434),
(c_pop_45_54_p = NULL) => 0.0093866672, -0.0003413913);

// Tree: 237 
woFDN_FLAPS__lgt_237 := map(
(NULL < c_pop_75_84_p and c_pop_75_84_p <= 0.05) => -0.0698273089,
(c_pop_75_84_p > 0.05) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 12.5) => 
      map(
      (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => -0.0003014507,
      (k_inq_adls_per_phone_i > 2.5) => -0.0825237254,
      (k_inq_adls_per_phone_i = NULL) => -0.0008838989, -0.0008838989),
   (f_hh_members_ct_d > 12.5) => 
      map(
      (NULL < c_med_age and c_med_age <= 37.65) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 39.4) => 0.1722691756,
         (c_fammar18_p > 39.4) => 0.0405354694,
         (c_fammar18_p = NULL) => 0.1064023225, 0.1064023225),
      (c_med_age > 37.65) => -0.0530319784,
      (c_med_age = NULL) => 0.0447804761, 0.0447804761),
   (f_hh_members_ct_d = NULL) => -0.0045413223, -0.0003038364),
(c_pop_75_84_p = NULL) => 0.0068744919, -0.0015509352);

// Tree: 238 
woFDN_FLAPS__lgt_238 := map(
(NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 9.5) => -0.0067997284,
(f_crim_rel_under500miles_cnt_i > 9.5) => 
   map(
   (NULL < c_child and c_child <= 25.85) => -0.0192311156,
   (c_child > 25.85) => 0.0948954829,
   (c_child = NULL) => 0.0372439022, 0.0372439022),
(f_crim_rel_under500miles_cnt_i = NULL) => 
   map(
   (NULL < c_retired2 and c_retired2 <= 143.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 70.5) => 0.1054757215,
      (c_ab_av_edu > 70.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 5.65) => -0.0378560318,
         (c_hval_250k_p > 5.65) => 0.0649758460,
         (c_hval_250k_p = NULL) => 0.0153868694, 0.0153868694),
      (c_ab_av_edu = NULL) => 0.0339132059, 0.0339132059),
   (c_retired2 > 143.5) => -0.0925252022,
   (c_retired2 = NULL) => 0.0102837329, 0.0102837329), -0.0056978755);

// Tree: 239 
woFDN_FLAPS__lgt_239 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 30.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 23.5) => -0.0026209596,
   (f_rel_homeover300_count_d > 23.5) => 0.1450329473,
   (f_rel_homeover300_count_d = NULL) => -0.0019955113, -0.0019955113),
(f_rel_homeover200_count_d > 30.5) => -0.0865824627,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 33.45) => -0.0918173123,
   (c_sfdu_p > 33.45) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1431934132,
         (r_Phn_Cell_n > 0.5) => 0.0356219874,
         (r_Phn_Cell_n = NULL) => 0.0817240271, 0.0817240271),
      (k_nap_phn_verd_d > 0.5) => -0.0562017000,
      (k_nap_phn_verd_d = NULL) => 0.0307372654, 0.0307372654),
   (c_sfdu_p = NULL) => -0.0075859902, -0.0075859902), -0.0027673813);

// Tree: 240 
woFDN_FLAPS__lgt_240 := map(
(NULL < c_hh2_p and c_hh2_p <= 16.95) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.45) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 123) => -0.0621693777,
         (c_cartheft > 123) => 0.0704346210,
         (c_cartheft = NULL) => 0.0038597739, 0.0038597739),
      (c_pop_75_84_p > 2.45) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.10042789825) => 0.0655848580,
         (f_add_input_nhood_BUS_pct_i > 0.10042789825) => 0.1939237311,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.1110501987, 0.1110501987),
      (c_pop_75_84_p = NULL) => 0.0563290365, 0.0563290365),
   (r_E57_br_source_count_d > 0.5) => -0.0269846821,
   (r_E57_br_source_count_d = NULL) => 0.0298309770, 0.0298309770),
(c_hh2_p > 16.95) => 0.0014755212,
(c_hh2_p = NULL) => -0.0302314191, 0.0023118392);

// Tree: 241 
woFDN_FLAPS__lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1919.5) => -0.0090300471,
   (c_popover18 > 1919.5) => 
      map(
      (NULL < c_employees and c_employees <= 53.5) => 0.1948160095,
      (c_employees > 53.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => 0.0734518449,
         (r_I60_inq_recency_d > 4.5) => 0.0071420240,
         (r_I60_inq_recency_d = NULL) => 0.0163455076, 0.0163455076),
      (c_employees = NULL) => 0.0207904966, 0.0207904966),
   (c_popover18 = NULL) => -0.0134194603, -0.0036512782),
(k_comb_age_d > 66.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 23.8) => 0.0371875726,
   (C_INC_15K_P > 23.8) => 0.1386574126,
   (C_INC_15K_P = NULL) => 0.0434695459, 0.0434695459),
(k_comb_age_d = NULL) => 0.0008236399, 0.0000264893);

// Tree: 242 
woFDN_FLAPS__lgt_242 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0020509536,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 5.65) => -0.0010702894,
   (c_incollege > 5.65) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 18.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 7.5) => 
            map(
            (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.05127642275) => 0.0491615678,
            (f_add_input_nhood_BUS_pct_i > 0.05127642275) => 0.1229117555,
            (f_add_input_nhood_BUS_pct_i = NULL) => 0.0777022909, 0.0777022909),
         (f_srchaddrsrchcount_i > 7.5) => -0.0684953076,
         (f_srchaddrsrchcount_i = NULL) => 0.0540101899, 0.0540101899),
      (f_srchaddrsrchcount_i > 18.5) => 0.1393438922,
      (f_srchaddrsrchcount_i = NULL) => 0.0593830527, 0.0593830527),
   (c_incollege = NULL) => 0.0312086869, 0.0312086869),
(k_inq_per_ssn_i = NULL) => 0.0019658985, 0.0019658985);

// Tree: 243 
woFDN_FLAPS__lgt_243 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < c_info and c_info <= 27.85) => 
      map(
      (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
         map(
         (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.0056402233,
         (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0499156412,
         (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0086480747, 0.0032500971),
      (r_L77_Add_PO_Box_i > 0.5) => -0.1080545375,
      (r_L77_Add_PO_Box_i = NULL) => 0.0012811572, 0.0012811572),
   (c_info > 27.85) => 0.1392534405,
   (c_info = NULL) => 0.0178799476, 0.0023503075),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < c_young and c_young <= 23.5) => 0.0253579661,
   (c_young > 23.5) => 0.1829828911,
   (c_young = NULL) => 0.0763542654, 0.0763542654),
(f_adls_per_phone_c6_i = NULL) => 0.0033479170, 0.0033479170);

// Tree: 244 
woFDN_FLAPS__lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 56.05) => 
      map(
      (NULL < c_apt20 and c_apt20 <= 177.5) => -0.0634634810,
      (c_apt20 > 177.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.6079119526) => -0.0674515102,
         (f_add_curr_nhood_MFD_pct_i > 0.6079119526) => 0.0224806195,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0126298695, -0.0126298695),
      (c_apt20 = NULL) => -0.0515858082, -0.0515858082),
   (c_fammar_p > 56.05) => -0.0067663308,
   (c_fammar_p = NULL) => 0.0103738894, -0.0097266826),
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 23.55) => 0.0109415390,
   (c_hh4_p > 23.55) => 0.0862437862,
   (c_hh4_p = NULL) => 0.0159708748, 0.0159708748),
(f_curraddrcrimeindex_i = NULL) => -0.0043827349, -0.0030180126);

// Tree: 245 
woFDN_FLAPS__lgt_245 := map(
(NULL < c_transport and c_transport <= 46.65) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 48352) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 
         map(
         (NULL < c_pop_25_34_p and c_pop_25_34_p <= 7.35) => 0.0729823474,
         (c_pop_25_34_p > 7.35) => 0.0035808540,
         (c_pop_25_34_p = NULL) => 0.0122263958, 0.0122263958),
      (C_INC_75K_P > 27.85) => 0.1236360660,
      (C_INC_75K_P = NULL) => 0.0147960877, 0.0147960877),
   (f_prevaddrmedianincome_d > 48352) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 6.5) => -0.0752532485,
      (f_mos_inq_banko_om_fseen_d > 6.5) => -0.0044035235,
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0074434646, -0.0074434646),
   (f_prevaddrmedianincome_d = NULL) => -0.0174990770, -0.0015808314),
(c_transport > 46.65) => 0.0854994407,
(c_transport = NULL) => -0.0009567695, -0.0009352958);

// Tree: 246 
woFDN_FLAPS__lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.385) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0898394349,
   (c_pop_45_54_p > 3.35) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 24.75) => 0.0007985617,
      (c_hval_40k_p > 24.75) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 57.35) => 0.1590055478,
         (c_low_hval > 57.35) => -0.0084082951,
         (c_low_hval = NULL) => 0.0618285470, 0.0618285470),
      (c_hval_40k_p = NULL) => 0.0016754583, 0.0016754583),
   (c_pop_45_54_p = NULL) => 0.0003791712, 0.0003791712),
(c_hhsize > 4.385) => 0.0946539302,
(c_hhsize = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 0.0342728835,
   (r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0701738100,
   (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0211205705, -0.0211205705), 0.0004753033);

// Tree: 247 
woFDN_FLAPS__lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 187) => -0.0054724878,
      (f_fp_prevaddrcrimeindex_i > 187) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 4.85) => -0.0220557478,
         (c_femdiv_p > 4.85) => 0.1013847538,
         (c_femdiv_p = NULL) => 0.0475695597, 0.0475695597),
      (f_fp_prevaddrcrimeindex_i = NULL) => -0.0037383635, -0.0037383635),
   (r_D33_eviction_count_i > 3.5) => 0.0675526799,
   (r_D33_eviction_count_i = NULL) => -0.0033284158, -0.0033284158),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0835142296,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.95) => -0.0534230686,
   (c_retail > 9.95) => 0.0398868322,
   (c_retail = NULL) => -0.0029158746, -0.0029158746), -0.0036407738);

// Tree: 248 
woFDN_FLAPS__lgt_248 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 40.45) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 11.5) => 0.0021974879,
   (f_rel_under100miles_cnt_d > 11.5) => -0.0221054919,
   (f_rel_under100miles_cnt_d = NULL) => 0.0064155388, -0.0019727314),
(c_famotf18_p > 40.45) => 
   map(
   (NULL < f_hh_college_attendees_d and f_hh_college_attendees_d <= 0.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 95.5) => -0.0774409155,
      (c_easiqlife > 95.5) => 
         map(
         (NULL < c_hval_80k_p and c_hval_80k_p <= 12.75) => 0.0642243529,
         (c_hval_80k_p > 12.75) => -0.0578699318,
         (c_hval_80k_p = NULL) => 0.0218651113, 0.0218651113),
      (c_easiqlife = NULL) => -0.0292627441, -0.0292627441),
   (f_hh_college_attendees_d > 0.5) => -0.1354074628,
   (f_hh_college_attendees_d = NULL) => -0.0468073257, -0.0468073257),
(c_famotf18_p = NULL) => 0.0316925274, -0.0025134913);

// Tree: 249 
woFDN_FLAPS__lgt_249 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 31422.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -6112) => -0.0739232413,
   (f_addrchangevaluediff_d > -6112) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 11.25) => 0.1174901791,
      (c_pop_25_34_p > 11.25) => 
         map(
         (NULL < c_med_hhinc and c_med_hhinc <= 24268) => -0.0818368761,
         (c_med_hhinc > 24268) => 
            map(
            (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 115.5) => -0.0501217646,
            (r_C21_M_Bureau_ADL_FS_d > 115.5) => 0.1004360733,
            (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0412423934, 0.0412423934),
         (c_med_hhinc = NULL) => 0.0009233224, 0.0009233224),
      (c_pop_25_34_p = NULL) => 0.0388753222, 0.0388753222),
   (f_addrchangevaluediff_d = NULL) => 0.0241803920, 0.0261100207),
(f_curraddrmedianincome_d > 31422.5) => -0.0027517398,
(f_curraddrmedianincome_d = NULL) => -0.0124400277, -0.0000387827);

// Tree: 250 
woFDN_FLAPS__lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => -0.0022849094,
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 2.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 18.5) => 0.1127798112,
      (c_many_cars > 18.5) => 0.0076459055,
      (c_many_cars = NULL) => 0.0163404395, 0.0163404395),
   (f_crim_rel_under25miles_cnt_i > 2.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3343807873) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.45) => 0.1296884081,
         (c_pop_35_44_p > 13.45) => -0.0522210567,
         (c_pop_35_44_p = NULL) => 0.0305884758, 0.0305884758),
      (f_add_curr_mobility_index_i > 0.3343807873) => 0.1386126112,
      (f_add_curr_mobility_index_i = NULL) => 0.0612049420, 0.0612049420),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0231424770, 0.0231424770),
(C_INC_50K_P = NULL) => -0.0011246215, 0.0002987490);

// Tree: 251 
woFDN_FLAPS__lgt_251 := map(
(NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 2110) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 1.85) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 45.15) => 0.0216639793,
      (c_civ_emp > 45.15) => -0.0644771139,
      (c_civ_emp = NULL) => -0.0390638412, -0.0390638412),
   (C_INC_125K_P > 1.85) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 4.5) => 0.0111532189,
      (k_inq_ssns_per_addr_i > 4.5) => -0.0687849205,
      (k_inq_ssns_per_addr_i = NULL) => 0.0105043815, 0.0105043815),
   (C_INC_125K_P = NULL) => -0.0292521525, 0.0075337180),
(f_liens_unrel_SC_total_amt_i > 2110) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2950816721) => -0.0430255081,
   (f_add_curr_mobility_index_i > 0.2950816721) => -0.1006374724,
   (f_add_curr_mobility_index_i = NULL) => -0.0658238255, -0.0658238255),
(f_liens_unrel_SC_total_amt_i = NULL) => -0.0279018380, 0.0061083016);

// Tree: 252 
woFDN_FLAPS__lgt_252 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 0.0031447859,
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 51.6) => 
         map(
         (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0135805657,
         (f_addrs_per_ssn_i > 5.5) => 
            map(
            (NULL < f_corrrisktype_i and f_corrrisktype_i <= 4.5) => 0.0273713055,
            (f_corrrisktype_i > 4.5) => 0.0773085616,
            (f_corrrisktype_i = NULL) => 0.0451505232, 0.0451505232),
         (f_addrs_per_ssn_i = NULL) => 0.0269399439, 0.0269399439),
      (c_hval_750k_p > 51.6) => 0.1442024801,
      (c_hval_750k_p = NULL) => 0.0100585032, 0.0306936776),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0135992814, 0.0135992814),
(f_phone_ver_insurance_d > 3.5) => -0.0109236973,
(f_phone_ver_insurance_d = NULL) => -0.0074558176, 0.0014533266);

// Tree: 253 
woFDN_FLAPS__lgt_253 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 5.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 31.5) => 0.0008263934,
   (f_rel_under500miles_cnt_d > 31.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 41.5) => -0.1349042127,
      (f_mos_inq_banko_cm_fseen_d > 41.5) => -0.0356723370,
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0626430520, -0.0626430520),
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 102.5) => -0.0277395985,
      (c_many_cars > 102.5) => 0.0968729740,
      (c_many_cars = NULL) => 0.0057647252, 0.0057647252), -0.0000841502),
(r_D34_unrel_liens_ct_i > 5.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 33.85) => -0.1226844935,
   (c_hh2_p > 33.85) => -0.0217459207,
   (c_hh2_p = NULL) => -0.0746185065, -0.0746185065),
(r_D34_unrel_liens_ct_i = NULL) => -0.0124117245, -0.0010664981);

// Tree: 254 
woFDN_FLAPS__lgt_254 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 37.45) => -0.0130989255,
(c_fammar18_p > 37.45) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 135.5) => 0.0022138255,
   (c_serv_empl > 135.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 26.05) => 
         map(
         (NULL < c_robbery and c_robbery <= 132.5) => 
            map(
            (NULL < f_historical_count_d and f_historical_count_d <= 6.5) => 0.0454444867,
            (f_historical_count_d > 6.5) => 0.2312385268,
            (f_historical_count_d = NULL) => 0.0622846597, 0.0622846597),
         (c_robbery > 132.5) => -0.0220668527,
         (c_robbery = NULL) => 0.0345012239, 0.0345012239),
      (c_famotf18_p > 26.05) => 0.1366221747,
      (c_famotf18_p = NULL) => 0.0415537757, 0.0415537757),
   (c_serv_empl = NULL) => 0.0100171472, 0.0100171472),
(c_fammar18_p = NULL) => 0.0356053351, -0.0019506955);

// Tree: 255 
woFDN_FLAPS__lgt_255 := map(
(NULL < c_pop_12_17_p and c_pop_12_17_p <= 13.75) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
      map(
      (NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 53.5) => -0.0605126752,
      (f_mos_inq_banko_am_lseen_d > 53.5) => 0.0040810093,
      (f_mos_inq_banko_am_lseen_d = NULL) => 0.0014506223, 0.0014506223),
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 153) => -0.0152030617,
      (r_A50_pb_average_dollars_d > 153) => 0.1362919895,
      (r_A50_pb_average_dollars_d = NULL) => 0.0654089838, 0.0654089838),
   (f_hh_lienholders_i = NULL) => -0.0098086460, 0.0019271307),
(c_pop_12_17_p > 13.75) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 20.75) => 0.0707276510,
   (c_oldhouse > 20.75) => -0.0642526104,
   (c_oldhouse = NULL) => -0.0418480998, -0.0418480998),
(c_pop_12_17_p = NULL) => 0.0100314528, 0.0004245147);

// Tree: 256 
woFDN_FLAPS__lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 72.5) => -0.0234226891,
(r_C13_max_lres_d > 72.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 33.5) => 
      map(
      (NULL < c_med_hval and c_med_hval <= 774776) => 
         map(
         (NULL < c_highrent and c_highrent <= 26.65) => 0.0435790863,
         (c_highrent > 26.65) => -0.0227031422,
         (c_highrent = NULL) => 0.0158349460, 0.0158349460),
      (c_med_hval > 774776) => 0.1658681661,
      (c_med_hval = NULL) => 0.0245008088, 0.0245008088),
   (c_born_usa > 33.5) => 0.0022950744,
   (c_born_usa = NULL) => -0.0549164352, 0.0049520020),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 112) => -0.0494472626,
   (c_preschl > 112) => 0.0668472451,
   (c_preschl = NULL) => 0.0041493366, 0.0041493366), -0.0014196751);

// Tree: 257 
woFDN_FLAPS__lgt_257 := map(
(NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 786.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 27204.5) => 
      map(
      (NULL < c_transport and c_transport <= 7.15) => -0.0051690969,
      (c_transport > 7.15) => 
         map(
         (NULL < c_bargains and c_bargains <= 146.5) => 0.0171354652,
         (c_bargains > 146.5) => 0.1226556807,
         (c_bargains = NULL) => 0.0413253535, 0.0413253535),
      (c_transport = NULL) => -0.0011817407, -0.0011817407),
   (f_addrchangeincomediff_d > 27204.5) => -0.0531556376,
   (f_addrchangeincomediff_d = NULL) => 0.0087616839, 0.0002911497),
(f_liens_unrel_O_total_amt_i > 786.5) => -0.0622013219,
(f_liens_unrel_O_total_amt_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0751775883,
   (k_nap_lname_verd_d > 0.5) => -0.0175797109,
   (k_nap_lname_verd_d = NULL) => 0.0283734465, 0.0283734465), -0.0005218120);

// Tree: 258 
woFDN_FLAPS__lgt_258 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 13.5) => -0.0043923816,
   (f_inq_count_i > 13.5) => 0.0407414026,
   (f_inq_count_i = NULL) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 3.35) => -0.0730522777,
      (c_hval_200k_p > 3.35) => 0.0441900535,
      (c_hval_200k_p = NULL) => -0.0139029935, -0.0139029935), -0.0032048286),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 11.5) => -0.0730243457,
   (r_C13_Curr_Addr_LRes_d > 11.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 486) => 0.1429185182,
      (c_hh00 > 486) => 0.0277519200,
      (c_hh00 = NULL) => 0.0704062156, 0.0704062156),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0301326097, 0.0301326097),
(k_nap_contradictory_i = NULL) => -0.0026424153, -0.0026424153);

// Tree: 259 
woFDN_FLAPS__lgt_259 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
   map(
   (NULL < r_D31_bk_chapter_n and r_D31_bk_chapter_n <= 9) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.40099696835) => -0.0435889126,
      (f_add_curr_mobility_index_i > 0.40099696835) => 0.0879252382,
      (f_add_curr_mobility_index_i = NULL) => -0.0326966363, -0.0326966363),
   (r_D31_bk_chapter_n > 9) => -0.0484794685,
   (r_D31_bk_chapter_n = NULL) => 
      map(
      (NULL < C_INC_50K_P and C_INC_50K_P <= 30.05) => -0.0016127325,
      (C_INC_50K_P > 30.05) => 0.0921740716,
      (C_INC_50K_P = NULL) => -0.0502929849, -0.0023094321), -0.0056651656),
(r_D33_eviction_count_i > 4.5) => -0.0805772540,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.05) => -0.0235349249,
   (c_pop_55_64_p > 11.05) => 0.0697281985,
   (c_pop_55_64_p = NULL) => 0.0169513922, 0.0169513922), -0.0057516148);

// Tree: 260 
woFDN_FLAPS__lgt_260 := map(
(NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 1.25) => 0.0562628399,
   (c_rnt500_p > 1.25) => 
      map(
      (NULL < c_retired and c_retired <= 2.7) => 0.0472718018,
      (c_retired > 2.7) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 3.5) => -0.0484122034,
         (f_srchvelocityrisktype_i > 3.5) => -0.1169810719,
         (f_srchvelocityrisktype_i = NULL) => -0.0601866555, -0.0601866555),
      (c_retired = NULL) => -0.0469409082, -0.0469409082),
   (c_rnt500_p = NULL) => -0.0316740816, -0.0316740816),
(C_INC_150K_P > 0.55) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 117.85) => -0.0039565484,
   (c_oldhouse > 117.85) => 0.0188512711,
   (c_oldhouse = NULL) => 0.0035253200, 0.0035253200),
(C_INC_150K_P = NULL) => -0.0141255949, 0.0012362292);

// Tree: 261 
woFDN_FLAPS__lgt_261 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 23.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 
      map(
      (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0067596801,
      (k_inf_nothing_found_i > 0.5) => 
         map(
         (NULL < c_highinc and c_highinc <= 36.15) => 0.0055802658,
         (c_highinc > 36.15) => 0.0748690167,
         (c_highinc = NULL) => 0.0181096521, 0.0165776909),
      (k_inf_nothing_found_i = NULL) => 0.0028922534, 0.0028922534),
   (f_inq_HighRiskCredit_count_i > 16.5) => 0.0685027753,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0031963214, 0.0031963214),
(f_srchphonesrchcount_i > 23.5) => -0.1002382211,
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 4.6) => 0.0672581226,
   (C_INC_200K_P > 4.6) => -0.0325766034,
   (C_INC_200K_P = NULL) => 0.0137752337, 0.0137752337), 0.0028797056);

// Tree: 262 
woFDN_FLAPS__lgt_262 := map(
(NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 1.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 146.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 80.5) => 
         map(
         (NULL < c_child and c_child <= 22.75) => -0.0163390670,
         (c_child > 22.75) => 
            map(
            (NULL < c_totsales and c_totsales <= 10914.5) => 0.1490111486,
            (c_totsales > 10914.5) => -0.0024409764,
            (c_totsales = NULL) => 0.0971808658, 0.0971808658),
         (c_child = NULL) => 0.0542189023, 0.0542189023),
      (f_mos_liens_unrel_CJ_lseen_d > 80.5) => 0.0062196517,
      (f_mos_liens_unrel_CJ_lseen_d = NULL) => 0.0078931888, 0.0078931888),
   (f_fp_prevaddrburglaryindex_i > 146.5) => -0.0185314192,
   (f_fp_prevaddrburglaryindex_i = NULL) => 0.0035066785, 0.0035066785),
(f_srchaddrsrchcountwk_i > 1.5) => -0.0795548843,
(f_srchaddrsrchcountwk_i = NULL) => -0.0221175709, 0.0029067090);

// Tree: 263 
woFDN_FLAPS__lgt_263 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 49.95) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 4.95) => -0.0084599325,
   (c_hval_250k_p > 4.95) => 
      map(
      (NULL < c_cartheft and c_cartheft <= 135.5) => 0.0028090884,
      (c_cartheft > 135.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
            map(
            (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.2) => 0.0272001102,
            (c_pop_45_54_p > 14.2) => 0.2077291181,
            (c_pop_45_54_p = NULL) => 0.0958519864, 0.0958519864),
         (r_C12_Num_NonDerogs_d > 1.5) => 0.0271865509,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0376037430, 0.0376037430),
      (c_cartheft = NULL) => 0.0094802262, 0.0094802262),
   (c_hval_250k_p = NULL) => 0.0023021198, 0.0023021198),
(c_hval_500k_p > 49.95) => 0.0844391129,
(c_hval_500k_p = NULL) => 0.0026266234, 0.0029441777);

// Tree: 264 
woFDN_FLAPS__lgt_264 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -24240) => -0.0516817507,
(f_addrchangeincomediff_d > -24240) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 0.0022474443,
   (r_D32_criminal_count_i > 10.5) => 0.1115882975,
   (r_D32_criminal_count_i = NULL) => 0.0029672431, 0.0029672431),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 151.5) => 0.0020953595,
   (c_easiqlife > 151.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
         map(
         (NULL < c_pop_75_84_p and c_pop_75_84_p <= 1.65) => 0.1961189611,
         (c_pop_75_84_p > 1.65) => 0.0547678184,
         (c_pop_75_84_p = NULL) => 0.0913362732, 0.0913362732),
      (f_phone_ver_insurance_d > 3.5) => 0.0096218476,
      (f_phone_ver_insurance_d = NULL) => 0.0533042932, 0.0533042932),
   (c_easiqlife = NULL) => 0.0035693846, 0.0090817851), 0.0035107268);

// Tree: 265 
woFDN_FLAPS__lgt_265 := map(
(NULL < c_low_ed and c_low_ed <= 76.05) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 19.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 73.05) => 0.0056164992,
      (c_low_ed > 73.05) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 15.1) => 0.0109937076,
         (c_rnt1000_p > 15.1) => 0.1509670470,
         (c_rnt1000_p = NULL) => 0.0612194353, 0.0612194353),
      (c_low_ed = NULL) => 0.0064373849, 0.0064373849),
   (f_rel_homeover300_count_d > 19.5) => -0.0654557988,
   (f_rel_homeover300_count_d = NULL) => 0.0049648896, 0.0052391752),
(c_low_ed > 76.05) => 
   map(
   (NULL < c_trailer and c_trailer <= 173.5) => -0.0544696997,
   (c_trailer > 173.5) => 0.1011595697,
   (c_trailer = NULL) => -0.0319597305, -0.0319597305),
(c_low_ed = NULL) => -0.0071958602, 0.0037946375);

// Tree: 266 
woFDN_FLAPS__lgt_266 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0048306970,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 163.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 130) => -0.0110010974,
      (r_C13_Curr_Addr_LRes_d > 130) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 125) => 0.0215768773,
         (c_ab_av_edu > 125) => 0.2464332966,
         (c_ab_av_edu = NULL) => 0.1097558653, 0.1097558653),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0210749708, 0.0210749708),
   (c_totcrime > 163.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 19.75) => 0.2092371657,
      (c_high_ed > 19.75) => 0.0468543308,
      (c_high_ed = NULL) => 0.1167542267, 0.1167542267),
   (c_totcrime = NULL) => -0.0092800802, 0.0324939766),
(r_L70_Add_Standardized_i = NULL) => -0.0018353073, -0.0018353073);

// Tree: 267 
woFDN_FLAPS__lgt_267 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 99) => 0.0339790110,
      (c_rich_fam > 99) => 0.1473878768,
      (c_rich_fam = NULL) => 0.0898110680, 0.0898110680),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0065771282,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0063202182, 0.0080553111),
(r_Phn_Cell_n > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 40.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 4.15) => 0.0092549875,
      (c_hh7p_p > 4.15) => 0.1375975329,
      (c_hh7p_p = NULL) => 0.0250039811, 0.0250039811),
   (f_mos_inq_banko_om_fseen_d > 40.5) => -0.0223105838,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0178234448, -0.0178234448),
(r_Phn_Cell_n = NULL) => -0.0041098463, -0.0041098463);

//Adjustment trees FA: 6/2019

adj_FLAPS__tree_0 :=  0.163855267651009;

// Tree: 1
adj_FLAPS__tree_1 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i < 3.5) => map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d < 21517.5) => map(
      (NULL < f_inputaddractivephonelist_d and f_inputaddractivephonelist_d < 0.5) => 0.183332361517891, 
      (f_inputaddractivephonelist_d >= 0.5) => -0.0279742157898046, 
      (f_inputaddractivephonelist_d = NULL) => 0.0756602202146065, 0.0756602202146065), 
   (r_A46_Curr_AVM_AutoVal_d >= 21517.5) => map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P < 59.25) => -0.0070814213298003, 
      (C_RENTOCC_P >= 59.25) => map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i < 0.0295682016) => 0.10853087118508, 
         (f_add_input_nhood_VAC_pct_i >= 0.0295682016) => -0.020065992029323, 
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0526117564628593, 0.0526117564628593), 
      (C_RENTOCC_P = NULL) => 0.084472284190992, -0.00214081322062784), 
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.00503214728466964, 0.00157834147809342), 
(f_srchfraudsrchcountyr_i >= 3.5) => map(
   (NULL < c_unemp and c_unemp < 8.05) => -0.0229743152912442, 
   (c_unemp >= 8.05) => -0.171581316069175, 
   (c_unemp = NULL) => -0.0409220206992069, -0.0409220206992069), 
(f_srchfraudsrchcountyr_i = NULL) => map(
   (NULL < c_high_ed and c_high_ed < 33.7) => 0.0798365361703904, 
   (c_high_ed >= 33.7) => -0.0596205071872524, 
   (c_high_ed = NULL) => 0.0255131530020063, 0.0255131530020063), 0.000869831459313212);

// Tree: 2
adj_FLAPS__tree_2 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => map(
   (NULL < c_bel_edu and c_bel_edu < 99.5) => 0.000778729271649572, 
   (c_bel_edu >= 99.5) => 0.198427442194092, 
   (c_bel_edu = NULL) => 0.112354615598835, 0.112354615598835), 
(f_attr_arrest_recency_d >= 79.5) => map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d < -99113) => map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d < 5.5) => map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i < 101.5) => -0.0232080841086061, 
         (f_fp_prevaddrcrimeindex_i >= 101.5) => 0.126003777576166, 
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.0234206226678852, 0.0234206226678852), 
      (r_C14_Addr_Stability_v2_d >= 5.5) => 0.153343985546812, 
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0621125332431141, 0.0621125332431141), 
   (f_addrchangevaluediff_d >= -99113) => -0.00936216226446402, 
   (f_addrchangevaluediff_d = NULL) => map(
      (NULL < c_lux_prod and c_lux_prod < 66.5) => 0.0367195656603145, 
      (c_lux_prod >= 66.5) => -0.0110834359108314, 
      (c_lux_prod = NULL) => -0.0212527235119888, -0.00178157986733792), -0.00646338054054102), 
(f_attr_arrest_recency_d = NULL) => map(
   (NULL < c_bel_edu and c_bel_edu < 71.5) => -0.0449708542932644, 
   (c_bel_edu >= 71.5) => 0.0684745378727438, 
   (c_bel_edu = NULL) => 0.0198550840873117, 0.0198550840873117), -0.00543934631066116);

// Tree: 3
adj_FLAPS__tree_3 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i < 7.5) => -0.00512386250240073, 
(f_addrchangecrimediff_i >= 7.5) => map(
   (NULL < C_INC_15K_P and C_INC_15K_P < 23.35) => 0.018886837346081, 
   (C_INC_15K_P >= 23.35) => map(
      (NULL < c_rape and c_rape < 167.5) => 0.205280103269253, 
      (c_rape >= 167.5) => 0.029388753563438, 
      (c_rape = NULL) => 0.121580081685106, 0.121580081685106), 
   (C_INC_15K_P = NULL) => 0.0404049304518017, 0.0404049304518017), 
(f_addrchangecrimediff_i = NULL) => map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d < 877) => map(
      (NULL < c_hh2_p and c_hh2_p < 26.45) => map(
         (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i < 0.5) => 0.00285501437010574, 
         (k_inq_per_ssn_i >= 0.5) => 0.0764652439557234, 
         (k_inq_per_ssn_i = NULL) => 0.0344022556210848, 0.0344022556210848), 
      (c_hh2_p >= 26.45) => -0.010109989459435, 
      (c_hh2_p = NULL) => -0.02561460480206, -0.00156277487514778), 
   (f_M_Bureau_ADL_FS_noTU_d >= 877) => 0.125518381018075, 
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p < 8.15) => -0.0471488897121975, 
      (c_pop_55_64_p >= 8.15) => 0.0701307339065852, 
      (c_pop_55_64_p = NULL) => 0.0276168703447764, 0.0276168703447764), 0.00128169600372157), -0.00198537485930037);

// Tree: 4
adj_FLAPS__tree_4 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => map(
   (NULL < c_no_car and c_no_car < 121) => 0.0115710494384064, 
   (c_no_car >= 121) => 0.165821936926364, 
   (c_no_car = NULL) => 0.0730394482118032, 0.0730394482118032), 
(f_attr_arrest_recency_d >= 79.5) => map(
   (NULL < f_divrisktype_i and f_divrisktype_i < 5.5) => map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 1.5) => 0.0319563844522797, 
      (f_corrssnaddrcount_d >= 1.5) => -0.00314199549816915, 
      (f_corrssnaddrcount_d = NULL) => -0.00148732242644509, -0.00148732242644509), 
   (f_divrisktype_i >= 5.5) => map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i < 11.5) => 0.174570845170186, 
      (f_addrs_per_ssn_i >= 11.5) => -0.0825549604105004, 
      (f_addrs_per_ssn_i = NULL) => 0.0779628835358241, 0.0779628835358241), 
   (f_divrisktype_i = NULL) => -0.000752773172946132, -0.000752773172946132), 
(f_attr_arrest_recency_d = NULL) => map(
   (NULL < c_preschl and c_preschl < 126.5) => map(
      (NULL < c_hh1_p and c_hh1_p < 22.55) => 0.0517101853542913, 
      (c_hh1_p >= 22.55) => -0.0789277318060157, 
      (c_hh1_p = NULL) => -0.0244095459044703, -0.0244095459044703), 
   (c_preschl >= 126.5) => 0.0934628403257147, 
   (c_preschl = NULL) => 0.0088877383413447, 0.0088877383413447), -0.0001447457098793);

// Tree: 5
adj_FLAPS__tree_5 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i < 17.5) => map(
   (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p < 4.75) => -0.0250305589316534, 
      (c_pop_65_74_p >= 4.75) => 0.16306733129639, 
      (c_pop_65_74_p = NULL) => 0.0783514876058971, 0.0783514876058971), 
   (f_attr_arrest_recency_d >= 79.5) => map(
      (NULL < C_INC_15K_P and C_INC_15K_P < 3.55) => -0.0299201699252172, 
      (C_INC_15K_P >= 3.55) => map(
         (NULL < f_liens_rel_CJ_total_amt_i and f_liens_rel_CJ_total_amt_i < 1205) => 0.0035864284780403, 
         (f_liens_rel_CJ_total_amt_i >= 1205) => map(
            (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 3.5) => -0.0330766582978137, 
            (f_srchfraudsrchcount_i >= 3.5) => -0.181326199251853, 
            (f_srchfraudsrchcount_i = NULL) => -0.0757333658364759, -0.0757333658364759), 
         (f_liens_rel_CJ_total_amt_i = NULL) => 0.00233525315105538, 0.00233525315105538), 
      (C_INC_15K_P = NULL) => 0.0126658573617719, -0.00572958832909401), 
   (f_attr_arrest_recency_d = NULL) => -0.0051441402081477, -0.0051441402081477), 
(r_L79_adls_per_addr_curr_i >= 17.5) => 0.14710843841864, 
(r_L79_adls_per_addr_curr_i = NULL) => map(
   (NULL < c_hval_80k_p and c_hval_80k_p < 1.45) => -0.0360642085743402, 
   (c_hval_80k_p >= 1.45) => 0.081828806987355, 
   (c_hval_80k_p = NULL) => 0.00448498149146575, 0.00448498149146575), -0.00466155358028328);

// Tree: 6
adj_FLAPS__tree_6 := map(
(NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i < 30) => map(
   (NULL < c_lowinc and c_lowinc < 70.25) => map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i < 7.5) => map(
         (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i < 4.5) => -0.00246138042697716, 
         (r_D33_eviction_count_i >= 4.5) => -0.0954931655313686, 
         (r_D33_eviction_count_i = NULL) => -0.00277058227834453, -0.00277058227834453), 
      (f_assocsuspicousidcount_i >= 7.5) => map(
         (NULL < f_sourcerisktype_i and f_sourcerisktype_i < 6.5) => map(
            (NULL < c_pop_65_74_p and c_pop_65_74_p < 2.15) => 0.126122124187478, 
            (c_pop_65_74_p >= 2.15) => 0.0111570818069996, 
            (c_pop_65_74_p = NULL) => 0.0261833388875553, 0.0261833388875553), 
         (f_sourcerisktype_i >= 6.5) => 0.124428404253294, 
         (f_sourcerisktype_i = NULL) => 0.0367752161217054, 0.0367752161217054), 
      (f_assocsuspicousidcount_i = NULL) => -0.000780044001272412, -0.000780044001272412), 
   (c_lowinc >= 70.25) => map(
      (NULL < c_rental and c_rental < 181.5) => 0.0311994673127894, 
      (c_rental >= 181.5) => 0.184400085831376, 
      (c_rental = NULL) => 0.0680109233525912, 0.0680109233525912), 
   (c_lowinc = NULL) => -0.0140127808042089, -6.09554423206251e-05), 
(r_C12_NonDerog_Recency_i >= 30) => 0.150387013097293, 
(r_C12_NonDerog_Recency_i = NULL) => -0.00619586812078219, 0.000332355103219493);

// Tree: 7
adj_FLAPS__tree_7 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 79.5) => 0.0893449923331927, 
(f_attr_arrest_recency_d >= 79.5) => map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 4.5) => 0.0016638603634485, 
   (f_srchfraudsrchcount_i >= 4.5) => map(
      (NULL < c_old_homes and c_old_homes < 162.5) => map(
         (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d < 12.5) => map(
            (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i < 0.5) => -0.158123383678441, 
            (f_inq_QuizProvider_count_i >= 0.5) => -0.00417377786843741, 
            (f_inq_QuizProvider_count_i = NULL) => -0.0891114914187844, -0.0891114914187844), 
         (f_mos_inq_banko_cm_lseen_d >= 12.5) => -0.00793510747475755, 
         (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0160318061312555, -0.0160318061312555), 
      (c_old_homes >= 162.5) => map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i < 0.1991548099) => 0.0240148084752992, 
         (f_add_input_nhood_MFD_pct_i >= 0.1991548099) => -0.136909497171588, 
         (f_add_input_nhood_MFD_pct_i = NULL) => -0.0870323731991613, -0.0870323731991613), 
      (c_old_homes = NULL) => -0.0253181284308695, -0.0253181284308695), 
   (f_srchfraudsrchcount_i = NULL) => -0.000274947928092824, -0.000274947928092824), 
(f_attr_arrest_recency_d = NULL) => map(
   (NULL < c_rnt750_p and c_rnt750_p < 10.25) => -0.0775577608001979, 
   (c_rnt750_p >= 10.25) => 0.0689210019299077, 
   (c_rnt750_p = NULL) => 0.00976611698121121, 0.00976611698121121), 0.000445358074995534);

// Tree: 8
adj_FLAPS__tree_8 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i < 1.5) => map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d < 21798) => map(
      (NULL < c_rnt1000_p and c_rnt1000_p < 2.05) => -0.0276365527722743, 
      (c_rnt1000_p >= 2.05) => 0.205297128626885, 
      (c_rnt1000_p = NULL) => 0.0935519166043154, 0.0935519166043154), 
   (r_A46_Curr_AVM_AutoVal_d >= 21798) => map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i < 7.5) => -0.00737945925149796, 
      (f_inq_HighRiskCredit_count24_i >= 7.5) => 0.0869574596184389, 
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.00690980680714786, -0.00690980680714786), 
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.00620546629752181, -0.00050491502802557), 
(r_D33_eviction_count_i >= 1.5) => map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d < 30.5) => -0.137002500703316, 
   (f_mos_inq_banko_om_lseen_d >= 30.5) => map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d < 1.5) => -0.0510690975298575, 
      (f_rel_incomeover75_count_d >= 1.5) => 0.0427480507206296, 
      (f_rel_incomeover75_count_d = NULL) => -0.00261408689499053, -0.00261408689499053), 
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0416076162901524, -0.0416076162901524), 
(r_D33_eviction_count_i = NULL) => map(
   (NULL < c_old_homes and c_old_homes < 48.5) => 0.080750236266903, 
   (c_old_homes >= 48.5) => -0.0410247880043521, 
   (c_old_homes = NULL) => -0.00427611204083726, -0.00427611204083726), -0.00137424213962878);

// Tree: 9
adj_FLAPS__tree_9 := map(
(NULL < f_divrisktype_i and f_divrisktype_i < 4.5) => map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d < 0.5) => map(
      (NULL < k_comb_age_d and k_comb_age_d < 32.5) => -0.0129568650657548, 
      (k_comb_age_d >= 32.5) => map(
         (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d < 230158.5) => 0.00432668157425887, 
         (f_prevaddrmedianvalue_d >= 230158.5) => 0.0652321323883177, 
         (f_prevaddrmedianvalue_d = NULL) => 0.0304740216651221, 0.0304740216651221), 
      (k_comb_age_d = NULL) => 0.0124215747913782, 0.0124215747913782), 
   (k_nap_phn_verd_d >= 0.5) => -0.0116427330875441, 
   (k_nap_phn_verd_d = NULL) => -0.0026225090152055, -0.0026225090152055), 
(f_divrisktype_i >= 4.5) => map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i < 0.1984840542) => 0.151819774766039, 
   (f_add_input_nhood_MFD_pct_i >= 0.1984840542) => 0.016385804913821, 
   (f_add_input_nhood_MFD_pct_i = NULL) => 0.0565143885737376, 0.0565143885737376), 
(f_divrisktype_i = NULL) => map(
   (NULL < c_hh3_p and c_hh3_p < 13.05) => -0.0753575215497896, 
   (c_hh3_p >= 13.05) => map(
      (NULL < c_blue_empl and c_blue_empl < 74.5) => -0.0222345584690939, 
      (c_blue_empl >= 74.5) => 0.110240898607278, 
      (c_blue_empl = NULL) => 0.0440031700690921, 0.0440031700690921), 
   (c_hh3_p = NULL) => -0.000124115923342923, -0.000124115923342923), -0.00165520770203227);

// Tree: 10
adj_FLAPS__tree_10 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d < 21939) => map(
   (NULL < c_rental and c_rental < 98.5) => -0.00327521023423288, 
   (c_rental >= 98.5) => 0.164998830089151, 
   (c_rental = NULL) => 0.0900897411709994, 0.0900897411709994), 
(r_A46_Curr_AVM_AutoVal_d >= 21939) => map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 1.5) => map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i < 0.0523238562) => map(
         (NULL < c_rnt1000_p and c_rnt1000_p < 27.7) => 0.0354980123818416, 
         (c_rnt1000_p >= 27.7) => 0.162506294073715, 
         (c_rnt1000_p = NULL) => 0.0743780986140478, 0.0743780986140478), 
      (f_add_curr_nhood_VAC_pct_i >= 0.0523238562) => -0.0497698778073171, 
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0486361297497753, 0.0486361297497753), 
   (f_corrssnaddrcount_d >= 1.5) => map(
      (NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d < 99.5) => 0.0805085461289756, 
      (f_attr_arrest_recency_d >= 99.5) => -0.00711205196609591, 
      (f_attr_arrest_recency_d = NULL) => -0.00618291049393298, -0.00618291049393298), 
   (f_corrssnaddrcount_d = NULL) => -0.00422361834263346, -0.00422361834263346), 
(r_A46_Curr_AVM_AutoVal_d = NULL) => map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d < 2.5) => -0.0921933493275584, 
   (r_C10_M_Hdr_FS_d >= 2.5) => 0.00078322005041517, 
   (r_C10_M_Hdr_FS_d = NULL) => 0.0211577947614648, 0.000537196911274637), -0.00138173072152949);

// Tree: 11
adj_FLAPS__tree_11 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d < 1.5) => -0.109414631655583, 
(r_C21_M_Bureau_ADL_FS_d >= 1.5) => map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i < 1435) => map(
      (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i < 19.5) => -0.0109501388109629, 
      (f_srchphonesrchcount_i >= 19.5) => 0.125144792208565, 
      (f_srchphonesrchcount_i = NULL) => -0.0103342332695881, -0.0103342332695881), 
   (r_P88_Phn_Dst_to_Inp_Add_i >= 1435) => map(
      (NULL < c_hval_250k_p and c_hval_250k_p < 10.4) => -0.0546588625170117, 
      (c_hval_250k_p >= 10.4) => 0.183384532844235, 
      (c_hval_250k_p = NULL) => 0.0299091858350101, 0.0299091858350101), 
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i < 7.5) => 0.00813649468598967, 
      (k_inq_per_addr_i >= 7.5) => map(
         (NULL < c_ab_av_edu and c_ab_av_edu < 104.5) => 0.130155187121935, 
         (c_ab_av_edu >= 104.5) => -0.00815344859750324, 
         (c_ab_av_edu = NULL) => 0.0705964444676315, 0.0705964444676315), 
      (k_inq_per_addr_i = NULL) => 0.0106940435708968, 0.0106940435708968), -0.00423809519761458), 
(r_C21_M_Bureau_ADL_FS_d = NULL) => map(
   (NULL < c_low_ed and c_low_ed < 48.55) => -0.0530237195672569, 
   (c_low_ed >= 48.55) => 0.0564034829548291, 
   (c_low_ed = NULL) => -0.0161238489493441, -0.0161238489493441), -0.00469325791037568);

// Tree: 12
adj_FLAPS__tree_12 := map(
(NULL < r_C20_email_verification_d and r_C20_email_verification_d < 4.5) => map(
   (NULL < k_comb_age_d and k_comb_age_d < 44.5) => 0.0128219950529174, 
   (k_comb_age_d >= 44.5) => map(
      (NULL < c_burglary and c_burglary < 78) => 0.29503368693678, 
      (c_burglary >= 78) => 0.00428112167275001, 
      (c_burglary = NULL) => 0.138474613333072, 0.138474613333072), 
   (k_comb_age_d = NULL) => 0.0442351496229559, 0.0442351496229559), 
(r_C20_email_verification_d >= 4.5) => -0.0766130827433241, 
(r_C20_email_verification_d = NULL) => map(
   (NULL < c_exp_prod and c_exp_prod < 38.5) => map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d < 3.5) => map(
         (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d < 30) => map(
            (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d < 6.5) => 0.0499581943045022, 
            (f_rel_ageover40_count_d >= 6.5) => 0.165726860579712, 
            (f_rel_ageover40_count_d = NULL) => 0.065430208320181, 0.065430208320181), 
         (r_D31_attr_bankruptcy_recency_d >= 30) => -0.0972968890067359, 
         (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0550433723205905, 0.0550433723205905), 
      (f_phone_ver_insurance_d >= 3.5) => -0.0159092250624399, 
      (f_phone_ver_insurance_d = NULL) => 0.0254394677708202, 0.0254394677708202), 
   (c_exp_prod >= 38.5) => -0.00544422478827285, 
   (c_exp_prod = NULL) => -0.00812668907028771, -0.00271654521262722), -0.00204979266267207);

// Tree: 13
adj_FLAPS__tree_13 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i < 38.5) => map(
   (NULL < k_comb_age_d and k_comb_age_d < 76.5) => -0.00184181424386601, 
   (k_comb_age_d >= 76.5) => map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i < 1.5) => map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d < 494.5) => map(
            (NULL < f_util_adl_count_n and f_util_adl_count_n < 1.5) => -0.0575508896367053, 
            (f_util_adl_count_n >= 1.5) => 0.0816932523346461, 
            (f_util_adl_count_n = NULL) => -0.0109793691800709, -0.0109793691800709), 
         (r_C10_M_Hdr_FS_d >= 494.5) => 0.150744371117306, 
         (r_C10_M_Hdr_FS_d = NULL) => 0.0162774409824084, 0.0162774409824084), 
      (k_inq_per_addr_i >= 1.5) => 0.139045597805689, 
      (k_inq_per_addr_i = NULL) => 0.0342363320284998, 0.0342363320284998), 
   (k_comb_age_d = NULL) => -0.00104003493265429, -0.00104003493265429), 
(f_srchaddrsrchcount_i >= 38.5) => 0.104301726047, 
(f_srchaddrsrchcount_i = NULL) => map(
   (NULL < c_pop_85p_p and c_pop_85p_p < 1.75) => map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i < 0.0338161815) => -0.0273416393630978, 
      (f_add_input_nhood_VAC_pct_i >= 0.0338161815) => 0.103605287353112, 
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0265155643669563, 0.0265155643669563), 
   (c_pop_85p_p >= 1.75) => -0.0968188822694103, 
   (c_pop_85p_p = NULL) => -0.010415089145628, -0.010415089145628), -0.000754711197056651);

// Tree: 14
adj_FLAPS__tree_14 := map(
(NULL < c_exp_prod and c_exp_prod < 23.5) => map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i < 6.5) => map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p < 8.55) => 0.00948915162592489, 
      (c_pop_45_54_p >= 8.55) => 0.104083095684266, 
      (c_pop_45_54_p = NULL) => 0.060218968399148, 0.060218968399148), 
   (r_L79_adls_per_addr_curr_i >= 6.5) => -0.0669033893178121, 
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0466368677547189, 0.0466368677547189), 
(c_exp_prod >= 23.5) => map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i < 5.5) => -0.00185277858572094, 
   (f_srchfraudsrchcount_i >= 5.5) => map(
      (NULL < c_rich_old and c_rich_old < 143.5) => -0.0549007521103039, 
      (c_rich_old >= 143.5) => map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i < 0.01905417085) => 0.110323820882831, 
         (f_add_input_nhood_BUS_pct_i >= 0.01905417085) => -0.0177898338352743, 
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.022089903041957, 0.022089903041957), 
      (c_rich_old = NULL) => -0.0315781324752159, -0.0315781324752159), 
   (f_srchfraudsrchcount_i = NULL) => map(
      (NULL < c_robbery and c_robbery < 107.5) => 0.0607631513282263, 
      (c_robbery >= 107.5) => -0.068273004830009, 
      (c_robbery = NULL) => 0.00481740530157887, 0.00481740530157887), -0.00328841101761281), 
(c_exp_prod = NULL) => -0.00467424998786349, -0.00109661472867957);

// Tree: 15
adj_FLAPS__tree_15 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d < 30) => map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i < 136.5) => 0.126640401493878, 
   (f_curraddrmurderindex_i >= 136.5) => -0.0460505919185805, 
   (f_curraddrmurderindex_i = NULL) => 0.0635417692854796, 0.0635417692854796), 
(r_D33_Eviction_Recency_d >= 30) => map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d < 0.5) => map(
      (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d < 0.5) => map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 2.5) => 0.145387114627159, 
         (f_corrssnaddrcount_d >= 2.5) => 0.0363541602805703, 
         (f_corrssnaddrcount_d = NULL) => 0.0662920223214979, 0.0662920223214979), 
      (f_rel_under100miles_cnt_d >= 0.5) => map(
         (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d < 111.5) => -0.0690348914182311, 
         (f_mos_liens_unrel_SC_fseen_d >= 111.5) => map(
            (NULL < c_urban_p and c_urban_p < 98.55) => -0.0200873242354249, 
            (c_urban_p >= 98.55) => 0.0188147591843922, 
            (c_urban_p = NULL) => -0.0352271231100717, 0.0055248182603306), 
         (f_mos_liens_unrel_SC_fseen_d = NULL) => 0.00357243399178045, 0.00357243399178045), 
      (f_rel_under100miles_cnt_d = NULL) => 0.00202934580334548, 0.00578938419534766), 
   (f_corrphonelastnamecount_d >= 0.5) => -0.0167361202783347, 
   (f_corrphonelastnamecount_d = NULL) => -0.00686403956742061, -0.00686403956742061), 
(r_D33_Eviction_Recency_d = NULL) => -0.0144542684471085, -0.00635819759487695);

// Tree: 16
adj_FLAPS__tree_16 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d < 4.5) => map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d < 0.5) => map(
      (NULL < c_exp_prod and c_exp_prod < 36.5) => 0.0867593524748027, 
      (c_exp_prod >= 36.5) => map(
         (NULL < c_hh00 and c_hh00 < 499.5) => -0.0200886921265646, 
         (c_hh00 >= 499.5) => 0.0339740119980223, 
         (c_hh00 = NULL) => 0.017028985332107, 0.017028985332107), 
      (c_exp_prod = NULL) => -0.0620733231080428, 0.0194352653679009), 
   (f_phone_ver_experian_d >= 0.5) => -0.0162465194964168, 
   (f_phone_ver_experian_d = NULL) => map(
      (NULL < c_unemp and c_unemp < 6.45) => -0.000782066556323642, 
      (c_unemp >= 6.45) => map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d < 1.5) => 0.0211532738409373, 
         (r_C14_Addr_Stability_v2_d >= 1.5) => map(
            (NULL < c_cpiall and c_cpiall < 209.3) => 0.163268379975364, 
            (c_cpiall >= 209.3) => 0.0366823489870545, 
            (c_cpiall = NULL) => 0.0661953843017447, 0.0661953843017447), 
         (r_C14_Addr_Stability_v2_d = NULL) => 0.0543520136422777, 0.0543520136422777), 
      (c_unemp = NULL) => 0.0553365264823032, 0.012700395407729), 0.00199561603749899), 
(f_corrssnaddrcount_d >= 4.5) => -0.0196157477107025, 
(f_corrssnaddrcount_d = NULL) => 0.0122343586320248, -0.00693704097111136);

// Tree: 17
adj_FLAPS__tree_17 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i < 1.5) => map(
   (NULL < r_C22_stl_recency_d and r_C22_stl_recency_d < 9) => map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d < 48.5) => 0.00291386486581267, 
      (f_rel_homeover50_count_d >= 48.5) => 0.119461482945618, 
      (f_rel_homeover50_count_d = NULL) => 0.000289332591953896, 0.00352769534664828), 
   (r_C22_stl_recency_d >= 9) => 0.0948198915760125, 
   (r_C22_stl_recency_d = NULL) => 0.00392807630198436, 0.00392807630198436), 
(r_D31_ALL_Bk_i >= 1.5) => map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d < 9) => -0.102270150167381, 
   (r_I60_inq_hiRiskCred_recency_d >= 9) => map(
      (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i < 0.5) => -0.0356460386548599, 
      (f_inq_QuizProvider_count24_i >= 0.5) => map(
         (NULL < c_hval_175k_p and c_hval_175k_p < 3.45) => -0.0341171514848466, 
         (c_hval_175k_p >= 3.45) => 0.194311400996749, 
         (c_hval_175k_p = NULL) => 0.0910219685702882, 0.0910219685702882), 
      (f_inq_QuizProvider_count24_i = NULL) => -0.0270418916785504, -0.0270418916785504), 
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0295752633970669, -0.0295752633970669), 
(r_D31_ALL_Bk_i = NULL) => map(
   (NULL < c_child and c_child < 25.8) => -0.036239452161316, 
   (c_child >= 25.8) => 0.0779944956030516, 
   (c_child = NULL) => 0.00139055416106391, 0.00139055416106391), 0.000819894244631229);


// Final Score Sum 

   woFDN_FLAPS__lgt := sum(
      woFDN_FLAPS__lgt_0, woFDN_FLAPS__lgt_1, woFDN_FLAPS__lgt_2, woFDN_FLAPS__lgt_3, woFDN_FLAPS__lgt_4, 
      woFDN_FLAPS__lgt_5, woFDN_FLAPS__lgt_6, woFDN_FLAPS__lgt_7, woFDN_FLAPS__lgt_8, woFDN_FLAPS__lgt_9, 
      woFDN_FLAPS__lgt_10, woFDN_FLAPS__lgt_11, woFDN_FLAPS__lgt_12, woFDN_FLAPS__lgt_13, woFDN_FLAPS__lgt_14, 
      woFDN_FLAPS__lgt_15, woFDN_FLAPS__lgt_16, woFDN_FLAPS__lgt_17, woFDN_FLAPS__lgt_18, woFDN_FLAPS__lgt_19, 
      woFDN_FLAPS__lgt_20, woFDN_FLAPS__lgt_21, woFDN_FLAPS__lgt_22, woFDN_FLAPS__lgt_23, woFDN_FLAPS__lgt_24, 
      woFDN_FLAPS__lgt_25, woFDN_FLAPS__lgt_26, woFDN_FLAPS__lgt_27, woFDN_FLAPS__lgt_28, woFDN_FLAPS__lgt_29, 
      woFDN_FLAPS__lgt_30, woFDN_FLAPS__lgt_31, woFDN_FLAPS__lgt_32, woFDN_FLAPS__lgt_33, woFDN_FLAPS__lgt_34, 
      woFDN_FLAPS__lgt_35, woFDN_FLAPS__lgt_36, woFDN_FLAPS__lgt_37, woFDN_FLAPS__lgt_38, woFDN_FLAPS__lgt_39, 
      woFDN_FLAPS__lgt_40, woFDN_FLAPS__lgt_41, woFDN_FLAPS__lgt_42, woFDN_FLAPS__lgt_43, woFDN_FLAPS__lgt_44, 
      woFDN_FLAPS__lgt_45, woFDN_FLAPS__lgt_46, woFDN_FLAPS__lgt_47, woFDN_FLAPS__lgt_48, woFDN_FLAPS__lgt_49, 
      woFDN_FLAPS__lgt_50, woFDN_FLAPS__lgt_51, woFDN_FLAPS__lgt_52, woFDN_FLAPS__lgt_53, woFDN_FLAPS__lgt_54, 
      woFDN_FLAPS__lgt_55, woFDN_FLAPS__lgt_56, woFDN_FLAPS__lgt_57, woFDN_FLAPS__lgt_58, woFDN_FLAPS__lgt_59, 
      woFDN_FLAPS__lgt_60, woFDN_FLAPS__lgt_61, woFDN_FLAPS__lgt_62, woFDN_FLAPS__lgt_63, woFDN_FLAPS__lgt_64, 
      woFDN_FLAPS__lgt_65, woFDN_FLAPS__lgt_66, woFDN_FLAPS__lgt_67, woFDN_FLAPS__lgt_68, woFDN_FLAPS__lgt_69, 
      woFDN_FLAPS__lgt_70, woFDN_FLAPS__lgt_71, woFDN_FLAPS__lgt_72, woFDN_FLAPS__lgt_73, woFDN_FLAPS__lgt_74, 
      woFDN_FLAPS__lgt_75, woFDN_FLAPS__lgt_76, woFDN_FLAPS__lgt_77, woFDN_FLAPS__lgt_78, woFDN_FLAPS__lgt_79, 
      woFDN_FLAPS__lgt_80, woFDN_FLAPS__lgt_81, woFDN_FLAPS__lgt_82, woFDN_FLAPS__lgt_83, woFDN_FLAPS__lgt_84, 
      woFDN_FLAPS__lgt_85, woFDN_FLAPS__lgt_86, woFDN_FLAPS__lgt_87, woFDN_FLAPS__lgt_88, woFDN_FLAPS__lgt_89, 
      woFDN_FLAPS__lgt_90, woFDN_FLAPS__lgt_91, woFDN_FLAPS__lgt_92, woFDN_FLAPS__lgt_93, woFDN_FLAPS__lgt_94, 
      woFDN_FLAPS__lgt_95, woFDN_FLAPS__lgt_96, woFDN_FLAPS__lgt_97, woFDN_FLAPS__lgt_98, woFDN_FLAPS__lgt_99, 
      woFDN_FLAPS__lgt_100, woFDN_FLAPS__lgt_101, woFDN_FLAPS__lgt_102, woFDN_FLAPS__lgt_103, woFDN_FLAPS__lgt_104, 
      woFDN_FLAPS__lgt_105, woFDN_FLAPS__lgt_106, woFDN_FLAPS__lgt_107, woFDN_FLAPS__lgt_108, woFDN_FLAPS__lgt_109, 
      woFDN_FLAPS__lgt_110, woFDN_FLAPS__lgt_111, woFDN_FLAPS__lgt_112, woFDN_FLAPS__lgt_113, woFDN_FLAPS__lgt_114, 
      woFDN_FLAPS__lgt_115, woFDN_FLAPS__lgt_116, woFDN_FLAPS__lgt_117, woFDN_FLAPS__lgt_118, woFDN_FLAPS__lgt_119, 
      woFDN_FLAPS__lgt_120, woFDN_FLAPS__lgt_121, woFDN_FLAPS__lgt_122, woFDN_FLAPS__lgt_123, woFDN_FLAPS__lgt_124, 
      woFDN_FLAPS__lgt_125, woFDN_FLAPS__lgt_126, woFDN_FLAPS__lgt_127, woFDN_FLAPS__lgt_128, woFDN_FLAPS__lgt_129, 
      woFDN_FLAPS__lgt_130, woFDN_FLAPS__lgt_131, woFDN_FLAPS__lgt_132, woFDN_FLAPS__lgt_133, woFDN_FLAPS__lgt_134, 
      woFDN_FLAPS__lgt_135, woFDN_FLAPS__lgt_136, woFDN_FLAPS__lgt_137, woFDN_FLAPS__lgt_138, woFDN_FLAPS__lgt_139, 
      woFDN_FLAPS__lgt_140, woFDN_FLAPS__lgt_141, woFDN_FLAPS__lgt_142, woFDN_FLAPS__lgt_143, woFDN_FLAPS__lgt_144, 
      woFDN_FLAPS__lgt_145, woFDN_FLAPS__lgt_146, woFDN_FLAPS__lgt_147, woFDN_FLAPS__lgt_148, woFDN_FLAPS__lgt_149, 
      woFDN_FLAPS__lgt_150, woFDN_FLAPS__lgt_151, woFDN_FLAPS__lgt_152, woFDN_FLAPS__lgt_153, woFDN_FLAPS__lgt_154, 
      woFDN_FLAPS__lgt_155, woFDN_FLAPS__lgt_156, woFDN_FLAPS__lgt_157, woFDN_FLAPS__lgt_158, woFDN_FLAPS__lgt_159, 
      woFDN_FLAPS__lgt_160, woFDN_FLAPS__lgt_161, woFDN_FLAPS__lgt_162, woFDN_FLAPS__lgt_163, woFDN_FLAPS__lgt_164, 
      woFDN_FLAPS__lgt_165, woFDN_FLAPS__lgt_166, woFDN_FLAPS__lgt_167, woFDN_FLAPS__lgt_168, woFDN_FLAPS__lgt_169, 
      woFDN_FLAPS__lgt_170, woFDN_FLAPS__lgt_171, woFDN_FLAPS__lgt_172, woFDN_FLAPS__lgt_173, woFDN_FLAPS__lgt_174, 
      woFDN_FLAPS__lgt_175, woFDN_FLAPS__lgt_176, woFDN_FLAPS__lgt_177, woFDN_FLAPS__lgt_178, woFDN_FLAPS__lgt_179, 
      woFDN_FLAPS__lgt_180, woFDN_FLAPS__lgt_181, woFDN_FLAPS__lgt_182, woFDN_FLAPS__lgt_183, woFDN_FLAPS__lgt_184, 
      woFDN_FLAPS__lgt_185, woFDN_FLAPS__lgt_186, woFDN_FLAPS__lgt_187, woFDN_FLAPS__lgt_188, woFDN_FLAPS__lgt_189, 
      woFDN_FLAPS__lgt_190, woFDN_FLAPS__lgt_191, woFDN_FLAPS__lgt_192, woFDN_FLAPS__lgt_193, woFDN_FLAPS__lgt_194, 
      woFDN_FLAPS__lgt_195, woFDN_FLAPS__lgt_196, woFDN_FLAPS__lgt_197, woFDN_FLAPS__lgt_198, woFDN_FLAPS__lgt_199, 
      woFDN_FLAPS__lgt_200, woFDN_FLAPS__lgt_201, woFDN_FLAPS__lgt_202, woFDN_FLAPS__lgt_203, woFDN_FLAPS__lgt_204, 
      woFDN_FLAPS__lgt_205, woFDN_FLAPS__lgt_206, woFDN_FLAPS__lgt_207, woFDN_FLAPS__lgt_208, woFDN_FLAPS__lgt_209, 
      woFDN_FLAPS__lgt_210, woFDN_FLAPS__lgt_211, woFDN_FLAPS__lgt_212, woFDN_FLAPS__lgt_213, woFDN_FLAPS__lgt_214, 
      woFDN_FLAPS__lgt_215, woFDN_FLAPS__lgt_216, woFDN_FLAPS__lgt_217, woFDN_FLAPS__lgt_218, woFDN_FLAPS__lgt_219, 
      woFDN_FLAPS__lgt_220, woFDN_FLAPS__lgt_221, woFDN_FLAPS__lgt_222, woFDN_FLAPS__lgt_223, woFDN_FLAPS__lgt_224, 
      woFDN_FLAPS__lgt_225, woFDN_FLAPS__lgt_226, woFDN_FLAPS__lgt_227, woFDN_FLAPS__lgt_228, woFDN_FLAPS__lgt_229, 
      woFDN_FLAPS__lgt_230, woFDN_FLAPS__lgt_231, woFDN_FLAPS__lgt_232, woFDN_FLAPS__lgt_233, woFDN_FLAPS__lgt_234, 
      woFDN_FLAPS__lgt_235, woFDN_FLAPS__lgt_236, woFDN_FLAPS__lgt_237, woFDN_FLAPS__lgt_238, woFDN_FLAPS__lgt_239, 
      woFDN_FLAPS__lgt_240, woFDN_FLAPS__lgt_241, woFDN_FLAPS__lgt_242, woFDN_FLAPS__lgt_243, woFDN_FLAPS__lgt_244, 
      woFDN_FLAPS__lgt_245, woFDN_FLAPS__lgt_246, woFDN_FLAPS__lgt_247, woFDN_FLAPS__lgt_248, woFDN_FLAPS__lgt_249, 
      woFDN_FLAPS__lgt_250, woFDN_FLAPS__lgt_251, woFDN_FLAPS__lgt_252, woFDN_FLAPS__lgt_253, woFDN_FLAPS__lgt_254, 
      woFDN_FLAPS__lgt_255, woFDN_FLAPS__lgt_256, woFDN_FLAPS__lgt_257, woFDN_FLAPS__lgt_258, woFDN_FLAPS__lgt_259, 
      woFDN_FLAPS__lgt_260, woFDN_FLAPS__lgt_261, woFDN_FLAPS__lgt_262, woFDN_FLAPS__lgt_263, woFDN_FLAPS__lgt_264, 
      woFDN_FLAPS__lgt_265, woFDN_FLAPS__lgt_266, woFDN_FLAPS__lgt_267); 

      adjusted_tree_score := sum(adj_FLAPS__tree_0, adj_FLAPS__tree_1, adj_FLAPS__tree_2, adj_FLAPS__tree_3, 
      adj_FLAPS__tree_4, adj_FLAPS__tree_5, adj_FLAPS__tree_6, adj_FLAPS__tree_7, adj_FLAPS__tree_8,
      adj_FLAPS__tree_9, adj_FLAPS__tree_10, adj_FLAPS__tree_11, adj_FLAPS__tree_12, adj_FLAPS__tree_13, 
      adj_FLAPS__tree_14, adj_FLAPS__tree_15, adj_FLAPS__tree_16, adj_FLAPS__tree_17);
      
// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
    
		FP3_woFDN_LGT := woFDN_FLAPS__lgt + adjusted_tree_score;
			
self.final_score_0	:= 	woFDN_FLAPS__lgt_0	;
self.final_score_1	:= 	woFDN_FLAPS__lgt_1	;
self.final_score_2	:= 	woFDN_FLAPS__lgt_2	;
self.final_score_3	:= 	woFDN_FLAPS__lgt_3	;
self.final_score_4	:= 	woFDN_FLAPS__lgt_4	;
self.final_score_5	:= 	woFDN_FLAPS__lgt_5	;
self.final_score_6	:= 	woFDN_FLAPS__lgt_6	;
self.final_score_7	:= 	woFDN_FLAPS__lgt_7	;
self.final_score_8	:= 	woFDN_FLAPS__lgt_8	;
self.final_score_9	:= 	woFDN_FLAPS__lgt_9	;
self.final_score_10	:= 	woFDN_FLAPS__lgt_10	;
self.final_score_11	:= 	woFDN_FLAPS__lgt_11	;
self.final_score_12	:= 	woFDN_FLAPS__lgt_12	;
self.final_score_13	:= 	woFDN_FLAPS__lgt_13	;
self.final_score_14	:= 	woFDN_FLAPS__lgt_14	;
self.final_score_15	:= 	woFDN_FLAPS__lgt_15	;
self.final_score_16	:= 	woFDN_FLAPS__lgt_16	;
self.final_score_17	:= 	woFDN_FLAPS__lgt_17	;
self.final_score_18	:= 	woFDN_FLAPS__lgt_18	;
self.final_score_19	:= 	woFDN_FLAPS__lgt_19	;
self.final_score_20	:= 	woFDN_FLAPS__lgt_20	;
self.final_score_21	:= 	woFDN_FLAPS__lgt_21	;
self.final_score_22	:= 	woFDN_FLAPS__lgt_22	;
self.final_score_23	:= 	woFDN_FLAPS__lgt_23	;
self.final_score_24	:= 	woFDN_FLAPS__lgt_24	;
self.final_score_25	:= 	woFDN_FLAPS__lgt_25	;
self.final_score_26	:= 	woFDN_FLAPS__lgt_26	;
self.final_score_27	:= 	woFDN_FLAPS__lgt_27	;
self.final_score_28	:= 	woFDN_FLAPS__lgt_28	;
self.final_score_29	:= 	woFDN_FLAPS__lgt_29	;
self.final_score_30	:= 	woFDN_FLAPS__lgt_30	;
self.final_score_31	:= 	woFDN_FLAPS__lgt_31	;
self.final_score_32	:= 	woFDN_FLAPS__lgt_32	;
self.final_score_33	:= 	woFDN_FLAPS__lgt_33	;
self.final_score_34	:= 	woFDN_FLAPS__lgt_34	;
self.final_score_35	:= 	woFDN_FLAPS__lgt_35	;
self.final_score_36	:= 	woFDN_FLAPS__lgt_36	;
self.final_score_37	:= 	woFDN_FLAPS__lgt_37	;
self.final_score_38	:= 	woFDN_FLAPS__lgt_38	;
self.final_score_39	:= 	woFDN_FLAPS__lgt_39	;
self.final_score_40	:= 	woFDN_FLAPS__lgt_40	;
self.final_score_41	:= 	woFDN_FLAPS__lgt_41	;
self.final_score_42	:= 	woFDN_FLAPS__lgt_42	;
self.final_score_43	:= 	woFDN_FLAPS__lgt_43	;
self.final_score_44	:= 	woFDN_FLAPS__lgt_44	;
self.final_score_45	:= 	woFDN_FLAPS__lgt_45	;
self.final_score_46	:= 	woFDN_FLAPS__lgt_46	;
self.final_score_47	:= 	woFDN_FLAPS__lgt_47	;
self.final_score_48	:= 	woFDN_FLAPS__lgt_48	;
self.final_score_49	:= 	woFDN_FLAPS__lgt_49	;
self.final_score_50	:= 	woFDN_FLAPS__lgt_50	;
self.final_score_51	:= 	woFDN_FLAPS__lgt_51	;
self.final_score_52	:= 	woFDN_FLAPS__lgt_52	;
self.final_score_53	:= 	woFDN_FLAPS__lgt_53	;
self.final_score_54	:= 	woFDN_FLAPS__lgt_54	;
self.final_score_55	:= 	woFDN_FLAPS__lgt_55	;
self.final_score_56	:= 	woFDN_FLAPS__lgt_56	;
self.final_score_57	:= 	woFDN_FLAPS__lgt_57	;
self.final_score_58	:= 	woFDN_FLAPS__lgt_58	;
self.final_score_59	:= 	woFDN_FLAPS__lgt_59	;
self.final_score_60	:= 	woFDN_FLAPS__lgt_60	;
self.final_score_61	:= 	woFDN_FLAPS__lgt_61	;
self.final_score_62	:= 	woFDN_FLAPS__lgt_62	;
self.final_score_63	:= 	woFDN_FLAPS__lgt_63	;
self.final_score_64	:= 	woFDN_FLAPS__lgt_64	;
self.final_score_65	:= 	woFDN_FLAPS__lgt_65	;
self.final_score_66	:= 	woFDN_FLAPS__lgt_66	;
self.final_score_67	:= 	woFDN_FLAPS__lgt_67	;
self.final_score_68	:= 	woFDN_FLAPS__lgt_68	;
self.final_score_69	:= 	woFDN_FLAPS__lgt_69	;
self.final_score_70	:= 	woFDN_FLAPS__lgt_70	;
self.final_score_71	:= 	woFDN_FLAPS__lgt_71	;
self.final_score_72	:= 	woFDN_FLAPS__lgt_72	;
self.final_score_73	:= 	woFDN_FLAPS__lgt_73	;
self.final_score_74	:= 	woFDN_FLAPS__lgt_74	;
self.final_score_75	:= 	woFDN_FLAPS__lgt_75	;
self.final_score_76	:= 	woFDN_FLAPS__lgt_76	;
self.final_score_77	:= 	woFDN_FLAPS__lgt_77	;
self.final_score_78	:= 	woFDN_FLAPS__lgt_78	;
self.final_score_79	:= 	woFDN_FLAPS__lgt_79	;
self.final_score_80	:= 	woFDN_FLAPS__lgt_80	;
self.final_score_81	:= 	woFDN_FLAPS__lgt_81	;
self.final_score_82	:= 	woFDN_FLAPS__lgt_82	;
self.final_score_83	:= 	woFDN_FLAPS__lgt_83	;
self.final_score_84	:= 	woFDN_FLAPS__lgt_84	;
self.final_score_85	:= 	woFDN_FLAPS__lgt_85	;
self.final_score_86	:= 	woFDN_FLAPS__lgt_86	;
self.final_score_87	:= 	woFDN_FLAPS__lgt_87	;
self.final_score_88	:= 	woFDN_FLAPS__lgt_88	;
self.final_score_89	:= 	woFDN_FLAPS__lgt_89	;
self.final_score_90	:= 	woFDN_FLAPS__lgt_90	;
self.final_score_91	:= 	woFDN_FLAPS__lgt_91	;
self.final_score_92	:= 	woFDN_FLAPS__lgt_92	;
self.final_score_93	:= 	woFDN_FLAPS__lgt_93	;
self.final_score_94	:= 	woFDN_FLAPS__lgt_94	;
self.final_score_95	:= 	woFDN_FLAPS__lgt_95	;
self.final_score_96	:= 	woFDN_FLAPS__lgt_96	;
self.final_score_97	:= 	woFDN_FLAPS__lgt_97	;
self.final_score_98	:= 	woFDN_FLAPS__lgt_98	;
self.final_score_99	:= 	woFDN_FLAPS__lgt_99	;
self.final_score_100	:= 	woFDN_FLAPS__lgt_100	;
self.final_score_101	:= 	woFDN_FLAPS__lgt_101	;
self.final_score_102	:= 	woFDN_FLAPS__lgt_102	;
self.final_score_103	:= 	woFDN_FLAPS__lgt_103	;
self.final_score_104	:= 	woFDN_FLAPS__lgt_104	;
self.final_score_105	:= 	woFDN_FLAPS__lgt_105	;
self.final_score_106	:= 	woFDN_FLAPS__lgt_106	;
self.final_score_107	:= 	woFDN_FLAPS__lgt_107	;
self.final_score_108	:= 	woFDN_FLAPS__lgt_108	;
self.final_score_109	:= 	woFDN_FLAPS__lgt_109	;
self.final_score_110	:= 	woFDN_FLAPS__lgt_110	;
self.final_score_111	:= 	woFDN_FLAPS__lgt_111	;
self.final_score_112	:= 	woFDN_FLAPS__lgt_112	;
self.final_score_113	:= 	woFDN_FLAPS__lgt_113	;
self.final_score_114	:= 	woFDN_FLAPS__lgt_114	;
self.final_score_115	:= 	woFDN_FLAPS__lgt_115	;
self.final_score_116	:= 	woFDN_FLAPS__lgt_116	;
self.final_score_117	:= 	woFDN_FLAPS__lgt_117	;
self.final_score_118	:= 	woFDN_FLAPS__lgt_118	;
self.final_score_119	:= 	woFDN_FLAPS__lgt_119	;
self.final_score_120	:= 	woFDN_FLAPS__lgt_120	;
self.final_score_121	:= 	woFDN_FLAPS__lgt_121	;
self.final_score_122	:= 	woFDN_FLAPS__lgt_122	;
self.final_score_123	:= 	woFDN_FLAPS__lgt_123	;
self.final_score_124	:= 	woFDN_FLAPS__lgt_124	;
self.final_score_125	:= 	woFDN_FLAPS__lgt_125	;
self.final_score_126	:= 	woFDN_FLAPS__lgt_126	;
self.final_score_127	:= 	woFDN_FLAPS__lgt_127	;
self.final_score_128	:= 	woFDN_FLAPS__lgt_128	;
self.final_score_129	:= 	woFDN_FLAPS__lgt_129	;
self.final_score_130	:= 	woFDN_FLAPS__lgt_130	;
self.final_score_131	:= 	woFDN_FLAPS__lgt_131	;
self.final_score_132	:= 	woFDN_FLAPS__lgt_132	;
self.final_score_133	:= 	woFDN_FLAPS__lgt_133	;
self.final_score_134	:= 	woFDN_FLAPS__lgt_134	;
self.final_score_135	:= 	woFDN_FLAPS__lgt_135	;
self.final_score_136	:= 	woFDN_FLAPS__lgt_136	;
self.final_score_137	:= 	woFDN_FLAPS__lgt_137	;
self.final_score_138	:= 	woFDN_FLAPS__lgt_138	;
self.final_score_139	:= 	woFDN_FLAPS__lgt_139	;
self.final_score_140	:= 	woFDN_FLAPS__lgt_140	;
self.final_score_141	:= 	woFDN_FLAPS__lgt_141	;
self.final_score_142	:= 	woFDN_FLAPS__lgt_142	;
self.final_score_143	:= 	woFDN_FLAPS__lgt_143	;
self.final_score_144	:= 	woFDN_FLAPS__lgt_144	;
self.final_score_145	:= 	woFDN_FLAPS__lgt_145	;
self.final_score_146	:= 	woFDN_FLAPS__lgt_146	;
self.final_score_147	:= 	woFDN_FLAPS__lgt_147	;
self.final_score_148	:= 	woFDN_FLAPS__lgt_148	;
self.final_score_149	:= 	woFDN_FLAPS__lgt_149	;
self.final_score_150	:= 	woFDN_FLAPS__lgt_150	;
self.final_score_151	:= 	woFDN_FLAPS__lgt_151	;
self.final_score_152	:= 	woFDN_FLAPS__lgt_152	;
self.final_score_153	:= 	woFDN_FLAPS__lgt_153	;
self.final_score_154	:= 	woFDN_FLAPS__lgt_154	;
self.final_score_155	:= 	woFDN_FLAPS__lgt_155	;
self.final_score_156	:= 	woFDN_FLAPS__lgt_156	;
self.final_score_157	:= 	woFDN_FLAPS__lgt_157	;
self.final_score_158	:= 	woFDN_FLAPS__lgt_158	;
self.final_score_159	:= 	woFDN_FLAPS__lgt_159	;
self.final_score_160	:= 	woFDN_FLAPS__lgt_160	;
self.final_score_161	:= 	woFDN_FLAPS__lgt_161	;
self.final_score_162	:= 	woFDN_FLAPS__lgt_162	;
self.final_score_163	:= 	woFDN_FLAPS__lgt_163	;
self.final_score_164	:= 	woFDN_FLAPS__lgt_164	;
self.final_score_165	:= 	woFDN_FLAPS__lgt_165	;
self.final_score_166	:= 	woFDN_FLAPS__lgt_166	;
self.final_score_167	:= 	woFDN_FLAPS__lgt_167	;
self.final_score_168	:= 	woFDN_FLAPS__lgt_168	;
self.final_score_169	:= 	woFDN_FLAPS__lgt_169	;
self.final_score_170	:= 	woFDN_FLAPS__lgt_170	;
self.final_score_171	:= 	woFDN_FLAPS__lgt_171	;
self.final_score_172	:= 	woFDN_FLAPS__lgt_172	;
self.final_score_173	:= 	woFDN_FLAPS__lgt_173	;
self.final_score_174	:= 	woFDN_FLAPS__lgt_174	;
self.final_score_175	:= 	woFDN_FLAPS__lgt_175	;
self.final_score_176	:= 	woFDN_FLAPS__lgt_176	;
self.final_score_177	:= 	woFDN_FLAPS__lgt_177	;
self.final_score_178	:= 	woFDN_FLAPS__lgt_178	;
self.final_score_179	:= 	woFDN_FLAPS__lgt_179	;
self.final_score_180	:= 	woFDN_FLAPS__lgt_180	;
self.final_score_181	:= 	woFDN_FLAPS__lgt_181	;
self.final_score_182	:= 	woFDN_FLAPS__lgt_182	;
self.final_score_183	:= 	woFDN_FLAPS__lgt_183	;
self.final_score_184	:= 	woFDN_FLAPS__lgt_184	;
self.final_score_185	:= 	woFDN_FLAPS__lgt_185	;
self.final_score_186	:= 	woFDN_FLAPS__lgt_186	;
self.final_score_187	:= 	woFDN_FLAPS__lgt_187	;
self.final_score_188	:= 	woFDN_FLAPS__lgt_188	;
self.final_score_189	:= 	woFDN_FLAPS__lgt_189	;
self.final_score_190	:= 	woFDN_FLAPS__lgt_190	;
self.final_score_191	:= 	woFDN_FLAPS__lgt_191	;
self.final_score_192	:= 	woFDN_FLAPS__lgt_192	;
self.final_score_193	:= 	woFDN_FLAPS__lgt_193	;
self.final_score_194	:= 	woFDN_FLAPS__lgt_194	;
self.final_score_195	:= 	woFDN_FLAPS__lgt_195	;
self.final_score_196	:= 	woFDN_FLAPS__lgt_196	;
self.final_score_197	:= 	woFDN_FLAPS__lgt_197	;
self.final_score_198	:= 	woFDN_FLAPS__lgt_198	;
self.final_score_199	:= 	woFDN_FLAPS__lgt_199	;
self.final_score_200	:= 	woFDN_FLAPS__lgt_200	;
self.final_score_201	:= 	woFDN_FLAPS__lgt_201	;
self.final_score_202	:= 	woFDN_FLAPS__lgt_202	;
self.final_score_203	:= 	woFDN_FLAPS__lgt_203	;
self.final_score_204	:= 	woFDN_FLAPS__lgt_204	;
self.final_score_205	:= 	woFDN_FLAPS__lgt_205	;
self.final_score_206	:= 	woFDN_FLAPS__lgt_206	;
self.final_score_207	:= 	woFDN_FLAPS__lgt_207	;
self.final_score_208	:= 	woFDN_FLAPS__lgt_208	;
self.final_score_209	:= 	woFDN_FLAPS__lgt_209	;
self.final_score_210	:= 	woFDN_FLAPS__lgt_210	;
self.final_score_211	:= 	woFDN_FLAPS__lgt_211	;
self.final_score_212	:= 	woFDN_FLAPS__lgt_212	;
self.final_score_213	:= 	woFDN_FLAPS__lgt_213	;
self.final_score_214	:= 	woFDN_FLAPS__lgt_214	;
self.final_score_215	:= 	woFDN_FLAPS__lgt_215	;
self.final_score_216	:= 	woFDN_FLAPS__lgt_216	;
self.final_score_217	:= 	woFDN_FLAPS__lgt_217	;
self.final_score_218	:= 	woFDN_FLAPS__lgt_218	;
self.final_score_219	:= 	woFDN_FLAPS__lgt_219	;
self.final_score_220	:= 	woFDN_FLAPS__lgt_220	;
self.final_score_221	:= 	woFDN_FLAPS__lgt_221	;
self.final_score_222	:= 	woFDN_FLAPS__lgt_222	;
self.final_score_223	:= 	woFDN_FLAPS__lgt_223	;
self.final_score_224	:= 	woFDN_FLAPS__lgt_224	;
self.final_score_225	:= 	woFDN_FLAPS__lgt_225	;
self.final_score_226	:= 	woFDN_FLAPS__lgt_226	;
self.final_score_227	:= 	woFDN_FLAPS__lgt_227	;
self.final_score_228	:= 	woFDN_FLAPS__lgt_228	;
self.final_score_229	:= 	woFDN_FLAPS__lgt_229	;
self.final_score_230	:= 	woFDN_FLAPS__lgt_230	;
self.final_score_231	:= 	woFDN_FLAPS__lgt_231	;
self.final_score_232	:= 	woFDN_FLAPS__lgt_232	;
self.final_score_233	:= 	woFDN_FLAPS__lgt_233	;
self.final_score_234	:= 	woFDN_FLAPS__lgt_234	;
self.final_score_235	:= 	woFDN_FLAPS__lgt_235	;
self.final_score_236	:= 	woFDN_FLAPS__lgt_236	;
self.final_score_237	:= 	woFDN_FLAPS__lgt_237	;
self.final_score_238	:= 	woFDN_FLAPS__lgt_238	;
self.final_score_239	:= 	woFDN_FLAPS__lgt_239	;
self.final_score_240	:= 	woFDN_FLAPS__lgt_240	;
self.final_score_241	:= 	woFDN_FLAPS__lgt_241	;
self.final_score_242	:= 	woFDN_FLAPS__lgt_242	;
self.final_score_243	:= 	woFDN_FLAPS__lgt_243	;
self.final_score_244	:= 	woFDN_FLAPS__lgt_244	;
self.final_score_245	:= 	woFDN_FLAPS__lgt_245	;
self.final_score_246	:= 	woFDN_FLAPS__lgt_246	;
self.final_score_247	:= 	woFDN_FLAPS__lgt_247	;
self.final_score_248	:= 	woFDN_FLAPS__lgt_248	;
self.final_score_249	:= 	woFDN_FLAPS__lgt_249	;
self.final_score_250	:= 	woFDN_FLAPS__lgt_250	;
self.final_score_251	:= 	woFDN_FLAPS__lgt_251	;
self.final_score_252	:= 	woFDN_FLAPS__lgt_252	;
self.final_score_253	:= 	woFDN_FLAPS__lgt_253	;
self.final_score_254	:= 	woFDN_FLAPS__lgt_254	;
self.final_score_255	:= 	woFDN_FLAPS__lgt_255	;
self.final_score_256	:= 	woFDN_FLAPS__lgt_256	;
self.final_score_257	:= 	woFDN_FLAPS__lgt_257	;
self.final_score_258	:= 	woFDN_FLAPS__lgt_258	;
self.final_score_259	:= 	woFDN_FLAPS__lgt_259	;
self.final_score_260	:= 	woFDN_FLAPS__lgt_260	;
self.final_score_261	:= 	woFDN_FLAPS__lgt_261	;
self.final_score_262	:= 	woFDN_FLAPS__lgt_262	;
self.final_score_263	:= 	woFDN_FLAPS__lgt_263	;
self.final_score_264	:= 	woFDN_FLAPS__lgt_264	;
self.final_score_265	:= 	woFDN_FLAPS__lgt_265	;
self.final_score_266	:= 	woFDN_FLAPS__lgt_266	;
self.final_score_267	:= 	woFDN_FLAPS__lgt_267	;
self.final_adj_score0 :=  adj_FLAPS__tree_0     ;
self.final_adj_score1 :=  adj_FLAPS__tree_1     ;
self.final_adj_score2 :=  adj_FLAPS__tree_2     ;
self.final_adj_score3 :=  adj_FLAPS__tree_3     ;
self.final_adj_score4 :=  adj_FLAPS__tree_4     ;
self.final_adj_score5 :=  adj_FLAPS__tree_5     ;
self.final_adj_score6 :=  adj_FLAPS__tree_6     ;
self.final_adj_score7 :=  adj_FLAPS__tree_7     ;
self.final_adj_score8 :=  adj_FLAPS__tree_8     ;
self.final_adj_score9 :=  adj_FLAPS__tree_9     ;
self.final_adj_score10 :=  adj_FLAPS__tree_10   ;
self.final_adj_score11 :=  adj_FLAPS__tree_11   ;
self.final_adj_score12 :=  adj_FLAPS__tree_12   ;
self.final_adj_score13 :=  adj_FLAPS__tree_13   ;
self.final_adj_score14 :=  adj_FLAPS__tree_14   ;
self.final_adj_score15 :=  adj_FLAPS__tree_15   ;
self.final_adj_score16 :=  adj_FLAPS__tree_16   ;
self.final_adj_score17 :=  adj_FLAPS__tree_17   ;
// self.woFDN_submodel_lgt	:= 	woFDN_FLAPS__lgt	;
self.orig_FDN_FLAPS__LGT := woFDN_FLAPS__lgt;
self.adj_FDN_FLAPS__LGT := adjusted_tree_score;
self.FP3_woFDN_LGT		:= 	FP3_woFDN_LGT	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
