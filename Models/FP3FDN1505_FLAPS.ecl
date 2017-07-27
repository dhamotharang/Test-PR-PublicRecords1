
export FP3FDN1505_FLAPS( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLAPS__lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FLAPS__lgt_1 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 0.4486687841,
(nf_vf_hi_risk_index > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0439342261,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 50.45) => 0.2264437761,
         (c_fammar_p > 50.45) => 0.0296722476,
         (c_fammar_p = NULL) => -0.0363853074, 0.0472357873),
      (f_inq_Communications_count_i > 0.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.1719507651,
         (f_srchvelocityrisktype_i > 5.5) => 0.4917209224,
         (f_srchvelocityrisktype_i = NULL) => 0.2953324011, 0.2953324011),
      (f_inq_Communications_count_i = NULL) => 0.0830519761, 0.0830519761),
   (nf_seg_FraudPoint_3_0 = '') => -0.0127276703, -0.0127276703),
(nf_vf_hi_risk_index = NULL) => 0.3050346590, -0.0016766067);

// Tree: 2 
wFDN_FLAPS__lgt_2 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < nf_vf_level and nf_vf_level <= 3.5) => 0.1060133123,
      (nf_vf_level > 3.5) => 0.4476289267,
      (nf_vf_level = NULL) => 0.1423890490, 0.1423890490),
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0373751325,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.1968172917,
      (f_inq_HighRiskCredit_count_i = NULL) => -0.0322735387, -0.0322735387),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0227215633, -0.0227215633),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.1649415792,
   (f_hh_payday_loan_users_i > 0.5) => 0.4909201589,
   (f_hh_payday_loan_users_i = NULL) => 0.2194986637, 0.2194986637),
(f_varrisktype_i = NULL) => 0.2066919836, -0.0070410436);

// Tree: 3 
wFDN_FLAPS__lgt_3 := map(
(nf_seg_FraudPoint_3_0 in ['4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0338809461,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog']) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.1778473129,
      (f_inq_Communications_count_i > 0.5) => 0.3435544353,
      (f_inq_Communications_count_i = NULL) => 0.2322397271, 0.2322397271),
   (nf_vf_hi_risk_index > 5.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 549) => 
         map(
         (NULL < f_inq_count_i and f_inq_count_i <= 8.5) => 0.1024398010,
         (f_inq_count_i > 8.5) => 0.3173998418,
         (f_inq_count_i = NULL) => 0.1564526031, 0.1564526031),
      (r_I60_inq_comm_recency_d > 549) => 0.0223527346,
      (r_I60_inq_comm_recency_d = NULL) => 0.0409764033, 0.0409764033),
   (nf_vf_hi_risk_index = NULL) => 0.1307394319, 0.0662057492),
(nf_seg_FraudPoint_3_0 = '') => -0.0076224895, -0.0076224895);

// Tree: 4 
wFDN_FLAPS__lgt_4 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0363689891,
   (f_corrrisktype_i > 7.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 28) => 0.0590186160,
      (c_famotf18_p > 28) => 0.2646253968,
      (c_famotf18_p = NULL) => -0.0413202204, 0.0683513704),
   (f_corrrisktype_i = NULL) => -0.0239544283, -0.0239544283),
(f_srchvelocityrisktype_i > 4.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 0.0197020863,
      (f_assocrisktype_i > 3.5) => 0.1668361806,
      (f_assocrisktype_i = NULL) => 0.0689532884, 0.0689532884),
   (f_inq_Communications_count_i > 1.5) => 0.2424928925,
   (f_inq_Communications_count_i = NULL) => 0.0894644669, 0.0894644669),
(f_srchvelocityrisktype_i = NULL) => 0.1352653814, -0.0079992598);

// Tree: 5 
wFDN_FLAPS__lgt_5 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2037244754,
   (f_phone_ver_experian_d > 0.5) => 0.0021924161,
   (f_phone_ver_experian_d = NULL) => 0.1129830737, 0.1003669307),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 2.5) => 0.3492746985,
      (f_M_Bureau_ADL_FS_all_d > 2.5) => -0.0355035705,
      (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0333067688, -0.0333067688),
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 58.85) => 0.1316242753,
      (c_fammar_p > 58.85) => 0.0191037596,
      (c_fammar_p = NULL) => 0.0213924502, 0.0407956347),
   (nf_seg_FraudPoint_3_0 = '') => -0.0179598881, -0.0179598881),
(nf_vf_hi_risk_hit_type = NULL) => 0.1002323971, -0.0067861411);

// Tree: 6 
wFDN_FLAPS__lgt_6 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 0.1570218555,
      (r_F01_inp_addr_address_score_d > 95) => 0.0126644383,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0298286612, 0.0298286612),
   (f_phone_ver_experian_d > 0.5) => -0.0518100128,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => -0.0242061019,
      (f_assocrisktype_i > 7.5) => 0.2034122195,
      (f_assocrisktype_i = NULL) => -0.0099473530, -0.0099473530), -0.0166204048),
(f_inq_HighRiskCredit_count_i > 2.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 0.2272811601,
   (nf_vf_hi_risk_index > 5.5) => 0.1011739079,
   (nf_vf_hi_risk_index = NULL) => 0.1323854528, 0.1323854528),
(f_inq_HighRiskCredit_count_i = NULL) => 0.0764638236, -0.0110044906);

// Tree: 7 
wFDN_FLAPS__lgt_7 := map(
(NULL < nf_vf_level and nf_vf_level <= 1.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 0.0133953534,
      (k_inq_per_phone_i > 2.5) => 0.2521036118,
      (k_inq_per_phone_i = NULL) => 0.0193762046, 0.0193762046),
   (f_phone_ver_experian_d > 0.5) => -0.0513696242,
   (f_phone_ver_experian_d = NULL) => -0.0072778115, -0.0198247284),
(nf_vf_level > 1.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0406780582,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1483469303,
   (nf_seg_FraudPoint_3_0 = '') => 0.0778414932, 0.0778414932),
(nf_vf_level = NULL) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0361108554) => -0.0504390075,
   (f_add_input_nhood_VAC_pct_i > 0.0361108554) => 0.2229447338,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0611015590, 0.0611015590), -0.0103501034);

// Tree: 8 
wFDN_FLAPS__lgt_8 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 2.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 142.5) => 0.0277504562,
         (f_prevaddrageoldest_d > 142.5) => 
            map(
            (NULL < C_OWNOCC_P and C_OWNOCC_P <= 55.8) => 0.3812783712,
            (C_OWNOCC_P > 55.8) => 0.1344894189,
            (C_OWNOCC_P = NULL) => 0.2578838951, 0.2578838951),
         (f_prevaddrageoldest_d = NULL) => 0.0679963676, 0.0679963676),
      (r_F01_inp_addr_address_score_d > 25) => -0.0242909367,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0193354378, -0.0193354378),
   (nf_vf_hi_summary > 2.5) => 0.1015565393,
   (nf_vf_hi_summary = NULL) => -0.0149816567, -0.0149816567),
(f_inq_Communications_count_i > 1.5) => 0.1394862020,
(f_inq_Communications_count_i = NULL) => 0.0417837776, -0.0095141355);

// Tree: 9 
wFDN_FLAPS__lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.1403673509,
      (r_F01_inp_addr_address_score_d > 75) => 0.0483317415,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0584150168, 0.0584150168),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0287199123,
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2098659528,
         (f_phone_ver_experian_d > 0.5) => 0.0399220946,
         (f_phone_ver_experian_d = NULL) => 0.0522178645, 0.0864385345),
      (k_inq_per_phone_i = NULL) => -0.0236502580, -0.0236502580),
   (c_fammar_p = NULL) => -0.0422452290, -0.0120899929),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1405742788,
(f_inq_PrepaidCards_count_i = NULL) => 0.0989076434, -0.0068561297);

// Tree: 10 
wFDN_FLAPS__lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0551097978,
         (f_phone_ver_experian_d > 0.5) => -0.0452392867,
         (f_phone_ver_experian_d = NULL) => 0.0151255228, 0.0120733863),
      (f_corrphonelastnamecount_d > 0.5) => -0.0414575231,
      (f_corrphonelastnamecount_d = NULL) => -0.0180107828, -0.0180107828),
   (f_rel_felony_count_i > 1.5) => 0.1083601829,
   (f_rel_felony_count_i = NULL) => -0.0124578366, -0.0124578366),
(f_srchfraudsrchcount_i > 8.5) => 0.1200596811,
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => -0.0734176190,
   (f_addrs_per_ssn_i > 4.5) => 0.1587549748,
   (f_addrs_per_ssn_i = NULL) => 0.0366642143, 0.0366642143), -0.0081328735);

// Tree: 11 
wFDN_FLAPS__lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.75) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 2.5) => 0.0332965131,
      (f_rel_felony_count_i > 2.5) => 0.1990303335,
      (f_rel_felony_count_i = NULL) => 0.0408474698, 0.0408474698),
   (c_fammar_p > 59.75) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 2.5) => 0.2266166630,
      (f_M_Bureau_ADL_FS_noTU_d > 2.5) => -0.0246430178,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0005208296, -0.0228398111),
   (c_fammar_p = NULL) => -0.0460408013, -0.0142482668),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1656408308,
   (f_phone_ver_experian_d > 0.5) => 0.0449486537,
   (f_phone_ver_experian_d = NULL) => 0.1722236049, 0.1093710314),
(k_inq_ssns_per_addr_i = NULL) => -0.0084985320, -0.0084985320);

// Tree: 12 
wFDN_FLAPS__lgt_12 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.95) => 0.1193169376,
      (c_fammar_p > 44.95) => 
         map(
         (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 0.1272872592,
         (f_corrssnaddrcount_d > 1.5) => 0.0096359809,
         (f_corrssnaddrcount_d = NULL) => 0.0172623202, 0.0172623202),
      (c_fammar_p = NULL) => -0.0541739666, 0.0214096064),
   (k_nap_phn_verd_d > 0.5) => -0.0357470205,
   (k_nap_phn_verd_d = NULL) => -0.0137785133, -0.0137785133),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.0931661613,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0342994925,
   (f_addrs_per_ssn_i > 3.5) => 0.1542440114,
   (f_addrs_per_ssn_i = NULL) => 0.0647657383, 0.0647657383), -0.0097092731);

// Tree: 13 
wFDN_FLAPS__lgt_13 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.1180228835,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 51.45) => 0.0576039044,
      (c_fammar_p > 51.45) => 
         map(
         (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
            map(
            (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0431119772,
            (f_phone_ver_experian_d > 0.5) => -0.0300496841,
            (f_phone_ver_experian_d = NULL) => -0.0122694452, 0.0039334197),
         (f_phone_ver_insurance_d > 3.5) => -0.0453665138,
         (f_phone_ver_insurance_d = NULL) => -0.0212152978, -0.0212152978),
      (c_fammar_p = NULL) => -0.0541443938, -0.0157130812),
   (r_D33_Eviction_Recency_d = NULL) => -0.0132573410, -0.0132573410),
(f_assocsuspicousidcount_i > 13.5) => 0.2319444015,
(f_assocsuspicousidcount_i = NULL) => 0.0456034099, -0.0106631456);

// Tree: 14 
wFDN_FLAPS__lgt_14 := map(
(NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 1.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0192891283,
      (f_srchcomponentrisktype_i > 1.5) => 0.0800133351,
      (f_srchcomponentrisktype_i = NULL) => -0.0161477798, -0.0161477798),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.1041733563,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0131818693, -0.0131818693),
(nf_vf_hi_summary > 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0476353811,
   (r_C23_inp_addr_occ_index_d > 2) => 
      map(
      (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 3.5) => 0.1951553871,
      (f_corrssnaddrcount_d > 3.5) => 0.0608436454,
      (f_corrssnaddrcount_d = NULL) => 0.1338031100, 0.1338031100),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0802502692, 0.0802502692),
(nf_vf_hi_summary = NULL) => 0.0232479815, -0.0081155471);

// Tree: 15 
wFDN_FLAPS__lgt_15 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 61.05) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 0.0316072143,
      (k_comb_age_d > 68.5) => 0.2830736869,
      (k_comb_age_d = NULL) => 0.0438275072, 0.0438275072),
   (c_fammar_p > 61.05) => -0.0252168361,
   (c_fammar_p = NULL) => -0.0192165445, -0.0143237787),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 93928.5) => 0.1622161762,
      (r_L80_Inp_AVM_AutoVal_d > 93928.5) => 0.0870824584,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0054038668, 0.0437448436),
   (f_rel_felony_count_i > 0.5) => 0.1566640296,
   (f_rel_felony_count_i = NULL) => 0.0664584730, 0.0664584730),
(f_varrisktype_i = NULL) => 0.0458009851, -0.0093889997);

// Tree: 16 
wFDN_FLAPS__lgt_16 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 39.5) => 0.0163037430,
         (k_comb_age_d > 39.5) => 0.1310097149,
         (k_comb_age_d = NULL) => 0.0582228689, 0.0582228689),
      (r_F01_inp_addr_address_score_d > 25) => -0.0141604100,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0104582236, -0.0104582236),
   (f_inq_Communications_count_i > 3.5) => 0.1592245947,
   (f_inq_Communications_count_i = NULL) => -0.0093560153, -0.0093560153),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 6.5) => 0.0584627835,
   (r_D30_Derog_Count_i > 6.5) => 0.1884359791,
   (r_D30_Derog_Count_i = NULL) => 0.0676183539, 0.0676183539),
(f_varrisktype_i = NULL) => 0.0170196274, -0.0047401984);

// Tree: 17 
wFDN_FLAPS__lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0295780770,
      (f_varrisktype_i > 2.5) => 0.0331848006,
      (f_varrisktype_i = NULL) => -0.0158442523, -0.0237770532),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 0.0418839221,
      (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => 0.2492963152,
      (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.1098293612, 0.1098293612),
   (k_nap_contradictory_i = NULL) => -0.0215871722, -0.0215871722),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0406837051,
   (f_hh_payday_loan_users_i > 0.5) => 0.1199962860,
   (f_hh_payday_loan_users_i = NULL) => 0.0535204234, 0.0535204234),
(k_inq_per_addr_i = NULL) => -0.0133096461, -0.0133096461);

// Tree: 18 
wFDN_FLAPS__lgt_18 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0160675116,
(f_corrrisktype_i > 6.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 65.5) => -0.0345726890,
      (c_unempl > 65.5) => 0.0531212202,
      (c_unempl = NULL) => -0.0510809957, 0.0240002103),
   (f_hh_lienholders_i > 1.5) => 
      map(
      (NULL < c_hval_500k_p and c_hval_500k_p <= 2) => 0.2067846132,
      (c_hval_500k_p > 2) => 0.0441963006,
      (c_hval_500k_p = NULL) => 0.1262098742, 0.1262098742),
   (f_hh_lienholders_i = NULL) => 0.0335205459, 0.0335205459),
(f_corrrisktype_i = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0758376013,
   (f_addrs_per_ssn_i > 3.5) => 0.1122585526,
   (f_addrs_per_ssn_i = NULL) => 0.0223718950, 0.0223718950), -0.0060302995);

// Tree: 19 
wFDN_FLAPS__lgt_19 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0153036977,
      (f_rel_felony_count_i > 1.5) => 0.1300300261,
      (f_rel_felony_count_i = NULL) => 0.0546979834, 0.0223968334),
   (k_nap_phn_verd_d > 0.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => 0.0542343405,
      (r_I60_inq_hiRiskCred_recency_d > 549) => -0.0348277036,
      (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0291516472, -0.0291516472),
   (k_nap_phn_verd_d = NULL) => -0.0092719065, -0.0092719065),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1438069871,
   (f_phone_ver_experian_d > 0.5) => 0.0381967229,
   (f_phone_ver_experian_d = NULL) => 0.0615729321, 0.0735428989),
(k_inq_per_phone_i = NULL) => -0.0049891700, -0.0049891700);

// Tree: 20 
wFDN_FLAPS__lgt_20 := map(
(NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0177180761,
   (k_inq_per_addr_i > 3.5) => 0.0606970288,
   (k_inq_per_addr_i = NULL) => -0.0114840571, -0.0114840571),
(f_divrisktype_i > 1.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -580) => 0.1586028512,
   (f_addrchangeincomediff_d > -580) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 12.5) => 0.0244435564,
      (f_assocsuspicousidcount_i > 12.5) => 0.1813211619,
      (f_assocsuspicousidcount_i = NULL) => 0.0311321365, 0.0311321365),
   (f_addrchangeincomediff_d = NULL) => 0.1061284075, 0.0538722210),
(f_divrisktype_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 96.5) => -0.0651061616,
   (c_burglary > 96.5) => 0.0864641497,
   (c_burglary = NULL) => 0.0127272415, 0.0127272415), -0.0021740859);

// Tree: 21 
wFDN_FLAPS__lgt_21 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 155.5) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 5.5) => 0.0581531586,
      (f_rel_criminal_count_i > 5.5) => 0.1647038408,
      (f_rel_criminal_count_i = NULL) => 0.0713564650, 0.0713564650),
   (c_relig_indx > 155.5) => -0.0234346208,
   (c_relig_indx = NULL) => 0.0008056755, 0.0441298307),
(f_corrssnaddrcount_d > 2.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0230355349,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.45) => -0.0001412617,
      (c_hval_125k_p > 4.45) => 0.0918373048,
      (c_hval_125k_p = NULL) => 0.0351598411, 0.0351598411),
   (k_inq_per_addr_i = NULL) => -0.0167299296, -0.0167299296),
(f_corrssnaddrcount_d = NULL) => -0.0080858965, -0.0110491551);

// Tree: 22 
wFDN_FLAPS__lgt_22 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1946618152,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => -0.0209190804,
      (f_assocrisktype_i > 3.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
            map(
            (NULL < c_hval_150k_p and c_hval_150k_p <= 19.7) => 0.0593576300,
            (c_hval_150k_p > 19.7) => 0.2088749609,
            (c_hval_150k_p = NULL) => -0.0260186495, 0.0649986826),
         (r_C12_Num_NonDerogs_d > 3.5) => -0.0081214798,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0275056890, 0.0275056890),
      (f_assocrisktype_i = NULL) => -0.0095609575, -0.0095609575),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0084765888, -0.0084765888),
(r_D33_eviction_count_i > 2.5) => 0.1560587906,
(r_D33_eviction_count_i = NULL) => -0.0052898143, -0.0067080953);

// Tree: 23 
wFDN_FLAPS__lgt_23 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 0.0178125636,
      (k_inq_per_phone_i > 5.5) => 0.1786493949,
      (k_inq_per_phone_i = NULL) => 0.0203597533, 0.0203597533),
   (f_phone_ver_experian_d > 0.5) => -0.0334564365,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_business and c_business <= 2.5) => 0.1492113976,
      (c_business > 2.5) => 
         map(
         (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0219647310,
         (f_assocrisktype_i > 8.5) => 0.1404487795,
         (f_assocrisktype_i = NULL) => -0.0148547834, -0.0148547834),
      (c_business = NULL) => -0.0787533284, -0.0037117409), -0.0099651903),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.1151737761,
(f_inq_PrepaidCards_count24_i = NULL) => 0.0205458527, -0.0082795446);

// Tree: 24 
wFDN_FLAPS__lgt_24 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 127.5) => 0.1710270233,
   (r_D32_Mos_Since_Fel_LS_d > 127.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 8.95) => 0.0084857320,
         (c_unemp > 8.95) => 0.0964637534,
         (c_unemp = NULL) => -0.0356158536, 0.0110156600),
      (f_corrphonelastnamecount_d > 0.5) => -0.0318304460,
      (f_corrphonelastnamecount_d = NULL) => -0.0127711445, -0.0127711445),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0116496847, -0.0116496847),
(f_inq_Communications_count_i > 1.5) => 
   map(
   (NULL < c_hval_300k_p and c_hval_300k_p <= 3.1) => 0.0177411321,
   (c_hval_300k_p > 3.1) => 0.1323955287,
   (c_hval_300k_p = NULL) => 0.0744183621, 0.0744183621),
(f_inq_Communications_count_i = NULL) => 0.0172741719, -0.0083704654);

// Tree: 25 
wFDN_FLAPS__lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 3.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 345.5) => 0.0008179667,
      (f_prevaddrageoldest_d > 345.5) => 0.2371972692,
      (f_prevaddrageoldest_d = NULL) => 0.0042015811, 0.0042015811),
   (f_assocrisktype_i > 3.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 8.5) => 0.0447552081,
      (f_phones_per_addr_curr_i > 8.5) => 0.1531034827,
      (f_phones_per_addr_curr_i = NULL) => 0.0608958385, 0.0608958385),
   (f_assocrisktype_i = NULL) => 0.0440276361, 0.0196635463),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0246036601,
   (r_D33_eviction_count_i > 3.5) => 0.1308774719,
   (r_D33_eviction_count_i = NULL) => -0.0235890040, -0.0235890040),
(k_nap_phn_verd_d = NULL) => -0.0070995020, -0.0070995020);

// Tree: 26 
wFDN_FLAPS__lgt_26 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 27.05) => 
      map(
      (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0123594579,
      (f_srchcomponentrisktype_i > 1.5) => 0.0640638065,
      (f_srchcomponentrisktype_i = NULL) => -0.0096744099, -0.0096744099),
   (c_famotf18_p > 27.05) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.45) => 0.0204214500,
      (c_pop_6_11_p > 10.45) => 0.1054960706,
      (c_pop_6_11_p = NULL) => 0.0401132247, 0.0401132247),
   (c_famotf18_p = NULL) => 0.0021344469, -0.0049668295),
(r_D30_Derog_Count_i > 11.5) => 0.1190434244,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 78) => -0.0632752663,
   (c_burglary > 78) => 0.0732233685,
   (c_burglary = NULL) => 0.0049740511, 0.0049740511), -0.0032073394);

// Tree: 27 
wFDN_FLAPS__lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 0.0318927350,
   (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32887732625) => 0.2347124607,
      (f_add_input_mobility_index_i > 0.32887732625) => 0.0376579134,
      (f_add_input_mobility_index_i = NULL) => 0.1493639944, 0.1493639944),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0497811809, 0.0497811809),
(c_fammar_p > 50.45) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0223930507,
      (k_inq_ssns_per_addr_i > 1.5) => 0.0336893529,
      (k_inq_ssns_per_addr_i = NULL) => -0.0152628830, -0.0152628830),
   (r_D33_eviction_count_i > 0.5) => 0.0678845100,
   (r_D33_eviction_count_i = NULL) => -0.0049236307, -0.0123323311),
(c_fammar_p = NULL) => -0.0052754257, -0.0070584906);

// Tree: 28 
wFDN_FLAPS__lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1518563551,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62814) => 0.1617090645,
         (f_addrchangevaluediff_d > -62814) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33752.5) => 0.0880028211,
            (f_curraddrmedianincome_d > 33752.5) => -0.0026089183,
            (f_curraddrmedianincome_d = NULL) => 0.0056455673, 0.0056455673),
         (f_addrchangevaluediff_d = NULL) => 0.0249241118, 0.0150381114),
      (f_phone_ver_experian_d > 0.5) => -0.0349358330,
      (f_phone_ver_experian_d = NULL) => 0.0010882742, -0.0114382294),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0105054929, -0.0105054929),
(r_D33_eviction_count_i > 2.5) => 0.1108396780,
(r_D33_eviction_count_i = NULL) => 0.0130181180, -0.0089761216);

// Tree: 29 
wFDN_FLAPS__lgt_29 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1104131693,
      (r_C10_M_Hdr_FS_d > 2.5) => 
         map(
         (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => -0.0128258474,
         (f_inq_PrepaidCards_count_i > 2.5) => 0.1167447499,
         (f_inq_PrepaidCards_count_i = NULL) => -0.0122594433, -0.0122594433),
      (r_C10_M_Hdr_FS_d = NULL) => -0.0116086885, -0.0116086885),
   (k_comb_age_d > 67.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 182.5) => 0.0591562244,
      (c_sub_bus > 182.5) => 0.2826113430,
      (c_sub_bus = NULL) => 0.0751173043, 0.0751173043),
   (k_comb_age_d = NULL) => -0.0245281754, -0.0057155969),
(k_nap_contradictory_i > 0.5) => 0.1019166697,
(k_nap_contradictory_i = NULL) => -0.0038743512, -0.0038743512);

// Tree: 30 
wFDN_FLAPS__lgt_30 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0118792820,
   (f_varrisktype_i > 4.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 43117) => 0.1313346982,
      (f_curraddrmedianincome_d > 43117) => 0.0103739583,
      (f_curraddrmedianincome_d = NULL) => 0.0462841779, 0.0462841779),
   (f_varrisktype_i = NULL) => -0.0103484128, -0.0103484128),
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 613) => 0.1758748595,
   (c_popover25 > 613) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1113770847,
      (r_Phn_Cell_n > 0.5) => -0.0164759002,
      (r_Phn_Cell_n = NULL) => 0.0428974233, 0.0428974233),
   (c_popover25 = NULL) => 0.0628601377, 0.0628601377),
(f_srchaddrsrchcount_i = NULL) => -0.0061541086, -0.0079217438);

// Tree: 31 
wFDN_FLAPS__lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.35) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1031208893,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0091367273,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0085693675, -0.0085693675),
      (c_unemp > 8.35) => 0.0462244596,
      (c_unemp = NULL) => -0.0324787400, -0.0054590554),
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 82.45) => 0.3226792482,
      (c_fammar_p > 82.45) => 0.0313280547,
      (c_fammar_p = NULL) => 0.1770036515, 0.1770036515),
   (k_comb_age_d = NULL) => -0.0034903481, -0.0034903481),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1675303383,
(f_inq_PrepaidCards_count_i = NULL) => 0.0059341146, -0.0026881264);

// Tree: 32 
wFDN_FLAPS__lgt_32 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 15.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => -0.0078486623,
      (f_assocsuspicousidcount_i > 14.5) => 0.1130519287,
      (f_assocsuspicousidcount_i = NULL) => -0.0070170763, -0.0070170763),
   (f_inq_PrepaidCards_count24_i > 0.5) => 0.0947431559,
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0058829788, -0.0058829788),
(f_srchaddrsrchcount_i > 15.5) => 
   map(
   (NULL < c_employees and c_employees <= 23.5) => 0.1865661400,
   (c_employees > 23.5) => 0.0475820165,
   (c_employees = NULL) => 0.0689343260, 0.0689343260),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0525639076,
   (c_assault > 90) => 0.0975227362,
   (c_assault = NULL) => 0.0135759693, 0.0135759693), -0.0035768800);

// Tree: 33 
wFDN_FLAPS__lgt_33 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 7.5) => -0.0084402905,
   (r_D30_Derog_Count_i > 7.5) => 0.0637346609,
   (r_D30_Derog_Count_i = NULL) => -0.0262055939, -0.0065216859),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.55) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0022808282,
      (f_corrrisktype_i > 6.5) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 133.5) => 0.0421629748,
         (c_for_sale > 133.5) => 0.2200892855,
         (c_for_sale = NULL) => 0.0964088012, 0.0964088012),
      (f_corrrisktype_i = NULL) => 0.0283727688, 0.0283727688),
   (c_unemp > 7.55) => 0.1577769483,
   (c_unemp = NULL) => 0.0468590802, 0.0468590802),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0038621160, -0.0038621160);

// Tree: 34 
wFDN_FLAPS__lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1018209472,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -2.5) => 0.1311883817,
         (f_addrchangecrimediff_i > -2.5) => 0.0291588721,
         (f_addrchangecrimediff_i = NULL) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.35) => 0.0165862966,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.35) => 0.2434802640,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0270383622, 0.0524113826), 0.0412976972),
      (f_corrphonelastnamecount_d > 0.5) => -0.0159151033,
      (f_corrphonelastnamecount_d = NULL) => 0.0165778458, 0.0165778458),
   (f_phone_ver_experian_d > 0.5) => -0.0197328775,
   (f_phone_ver_experian_d = NULL) => -0.0127395952, -0.0064105177),
(r_C10_M_Hdr_FS_d = NULL) => -0.0079924194, -0.0057762840);

// Tree: 35 
wFDN_FLAPS__lgt_35 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 1.5) => 
   map(
   (NULL < c_urban_p and c_urban_p <= 95.35) => -0.0503360452,
   (c_urban_p > 95.35) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 84.5) => 0.1532174503,
      (c_rest_indx > 84.5) => 0.0424990704,
      (c_rest_indx = NULL) => 0.0730605603, 0.0730605603),
   (c_urban_p = NULL) => 0.0776571263, 0.0449775869),
(f_corrssnaddrcount_d > 1.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0121829321,
      (r_P85_Phn_Disconnected_i > 0.5) => 0.1174518264,
      (r_P85_Phn_Disconnected_i = NULL) => -0.0097359392, -0.0097359392),
   (f_hh_tot_derog_i > 5.5) => 0.0729745109,
   (f_hh_tot_derog_i = NULL) => -0.0073138627, -0.0073138627),
(f_corrssnaddrcount_d = NULL) => -0.0000207548, -0.0046717807);

// Tree: 36 
wFDN_FLAPS__lgt_36 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0244174376,
   (f_hh_criminals_i > 0.5) => 0.0167987758,
   (f_hh_criminals_i = NULL) => -0.0110648427, -0.0110648427),
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < k_inq_addrs_per_ssn_i and k_inq_addrs_per_ssn_i <= 1.5) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 57.5) => 0.1853490458,
      (c_rest_indx > 57.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 46.35) => -0.0136691098,
         (c_fammar18_p > 46.35) => 0.1497066453,
         (c_fammar18_p = NULL) => 0.0229075518, 0.0229075518),
      (c_rest_indx = NULL) => 0.0447343158, 0.0447343158),
   (k_inq_addrs_per_ssn_i > 1.5) => 0.1382671000,
   (k_inq_addrs_per_ssn_i = NULL) => 0.0623200253, 0.0623200253),
(f_srchcomponentrisktype_i = NULL) => -0.0139816104, -0.0082887345);

// Tree: 37 
wFDN_FLAPS__lgt_37 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0106614763,
(f_hh_lienholders_i > 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 14.35) => 0.0148510186,
      (c_hh5_p > 14.35) => 0.1057994660,
      (c_hh5_p = NULL) => 0.0235680433, 0.0235680433),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 3.3) => 0.1592326928,
      (c_rnt500_p > 3.3) => 0.0144300185,
      (c_rnt500_p = NULL) => 0.0780349315, 0.0780349315),
   (f_varrisktype_i = NULL) => 0.0265862898, 0.0265862898),
(f_hh_lienholders_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0825283817,
   (r_S66_adlperssn_count_i > 1.5) => 0.0672919306,
   (r_S66_adlperssn_count_i = NULL) => 0.0055339392, 0.0055339392), 0.0010574288);

// Tree: 38 
wFDN_FLAPS__lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
         map(
         (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => -0.0309162515,
         (f_crim_rel_under25miles_cnt_i > 0.5) => 0.0043341601,
         (f_crim_rel_under25miles_cnt_i = NULL) => 0.0403803428, -0.0159980134),
      (f_assocsuspicousidcount_i > 15.5) => 0.1212249667,
      (f_assocsuspicousidcount_i = NULL) => -0.0152916251, -0.0152916251),
   (f_inq_Other_count_i > 0.5) => 0.0276656275,
   (f_inq_Other_count_i = NULL) => -0.0057085362, -0.0057085362),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1223438766,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1262) => 0.0695826495,
   (c_popover18 > 1262) => -0.0646640128,
   (c_popover18 = NULL) => -0.0005107406, -0.0005107406), -0.0050137083);

// Tree: 39 
wFDN_FLAPS__lgt_39 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0029402987,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0759669431,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0042880355, -0.0055369827),
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 3.15) => 0.0617716777,
         (c_hh7p_p > 3.15) => 0.2827314201,
         (c_hh7p_p = NULL) => 0.1112283709, 0.1112283709),
      (f_inq_count_i > 2.5) => 0.0143477879,
      (f_inq_count_i = NULL) => 0.0329248894, 0.0329248894),
   (k_comb_age_d > 68.5) => 0.2844680329,
   (k_comb_age_d = NULL) => 0.0436816686, 0.0436816686),
(k_inq_per_ssn_i = NULL) => 0.0003684794, 0.0003684794);

// Tree: 40 
wFDN_FLAPS__lgt_40 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0362193975,
      (r_Phn_Cell_n > 0.5) => -0.0131520097,
      (r_Phn_Cell_n = NULL) => 0.0101997997, 0.0101997997),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 5.15) => 0.1773026995,
      (c_pop_55_64_p > 5.15) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 11.5) => 0.0183743203,
         (f_rel_under25miles_cnt_d > 11.5) => 0.1276194480,
         (f_rel_under25miles_cnt_d = NULL) => 0.0375692343, 0.0375692343),
      (c_pop_55_64_p = NULL) => 0.0564383519, 0.0564383519),
   (f_inq_Communications_count_i = NULL) => 0.0143630410, 0.0143630410),
(f_historical_count_d > 0.5) => -0.0170279624,
(f_historical_count_d = NULL) => 0.0178349499, -0.0012326469);

// Tree: 41 
wFDN_FLAPS__lgt_41 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 14.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1403047183,
   (f_phone_ver_experian_d > 0.5) => -0.0414902597,
   (f_phone_ver_experian_d = NULL) => 0.0806277172, 0.0602129925),
(r_D32_Mos_Since_Crim_LS_d > 14.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0124577258,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0355738596,
         (r_Phn_Cell_n > 0.5) => 0.2193789625,
         (r_Phn_Cell_n = NULL) => 0.0997072948, 0.0997072948),
      (f_inq_count24_i > 2.5) => -0.0121667708,
      (f_inq_count24_i = NULL) => 0.0375153222, 0.0375153222),
   (k_inq_per_phone_i = NULL) => -0.0099131408, -0.0099131408),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0166095729, -0.0081022012);

// Tree: 42 
wFDN_FLAPS__lgt_42 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 222) => 
   map(
   (NULL < c_rape and c_rape <= 98.5) => 0.2004726589,
   (c_rape > 98.5) => -0.0089581030,
   (c_rape = NULL) => 0.1014690260, 0.1014690260),
(r_D32_Mos_Since_Fel_LS_d > 222) => 
   map(
   (NULL < c_employees and c_employees <= 40.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.75) => 0.0203073774,
      (c_unemp > 9.75) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 34.5) => 0.1863889014,
         (f_prevaddrlenofres_d > 34.5) => 0.0282034940,
         (f_prevaddrlenofres_d = NULL) => 0.0949700621, 0.0949700621),
      (c_unemp = NULL) => 0.0279169429, 0.0279169429),
   (c_employees > 40.5) => -0.0086497599,
   (c_employees = NULL) => -0.0391309523, -0.0048847730),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0089664515, -0.0040004782);

// Tree: 43 
wFDN_FLAPS__lgt_43 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0078273320,
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 7.5) => 0.1598684083,
   (r_C21_M_Bureau_ADL_FS_d > 7.5) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 9.5) => 0.0149226652,
      (f_rel_ageover20_count_d > 9.5) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 4.5) => 
            map(
            (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 43.5) => 0.1412141036,
            (f_mos_inq_banko_om_fseen_d > 43.5) => 0.0512026727,
            (f_mos_inq_banko_om_fseen_d = NULL) => 0.0730773718, 0.0730773718),
         (r_A50_pb_total_orders_d > 4.5) => -0.0718248080,
         (r_A50_pb_total_orders_d = NULL) => 0.0452115680, 0.0452115680),
      (f_rel_ageover20_count_d = NULL) => 0.0287219599, 0.0287219599),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0326571101, 0.0326571101),
(f_phones_per_addr_curr_i = NULL) => 0.0018400217, -0.0022087838);

// Tree: 44 
wFDN_FLAPS__lgt_44 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 7.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -12084.5) => 0.1182362198,
      (f_addrchangeincomediff_d > -12084.5) => -0.0146140865,
      (f_addrchangeincomediff_d = NULL) => 0.0244074025, 0.0159068780),
   (f_rel_homeover100_count_d > 7.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.49536460945) => 
         map(
         (NULL < c_wholesale and c_wholesale <= 0.55) => 0.1022696385,
         (c_wholesale > 0.55) => -0.0575670223,
         (c_wholesale = NULL) => 0.0385708954, 0.0385708954),
      (f_add_input_nhood_MFD_pct_i > 0.49536460945) => 0.1776940725,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0745970369, 0.0734116673),
   (f_rel_homeover100_count_d = NULL) => 0.0381684322, 0.0381684322),
(f_corrssnaddrcount_d > 2.5) => -0.0085182736,
(f_corrssnaddrcount_d = NULL) => 0.0050637960, -0.0040506525);

// Tree: 45 
wFDN_FLAPS__lgt_45 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0104944256,
   (f_corrrisktype_i > 7.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 216188.5) => 0.0992420912,
      (r_L80_Inp_AVM_AutoVal_d > 216188.5) => 0.0271610154,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 3.35) => -0.0396883448,
         (c_femdiv_p > 3.35) => 0.0412723370,
         (c_femdiv_p = NULL) => -0.0502745810, 0.0042368336), 0.0241105771),
   (f_corrrisktype_i = NULL) => -0.0061724804, -0.0061724804),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 14.5) => 0.2436629877,
   (c_born_usa > 14.5) => 0.0566633899,
   (c_born_usa = NULL) => 0.0688902867, 0.0688902867),
(k_comb_age_d = NULL) => 0.0038118372, -0.0013302859);

// Tree: 46 
wFDN_FLAPS__lgt_46 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1161071351,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 2.75) => -0.0228285885,
      (c_hh5_p > 2.75) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134) => 0.0352994610,
         (f_prevaddrageoldest_d > 134) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 134) => 0.0527204334,
            (c_span_lang > 134) => 0.2048118266,
            (c_span_lang = NULL) => 0.1287661300, 0.1287661300),
         (f_prevaddrageoldest_d = NULL) => 0.0492536398, 0.0492536398),
      (c_hh5_p = NULL) => 0.0504032833, 0.0250756993),
   (r_F01_inp_addr_address_score_d > 85) => -0.0042206237,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0014404576, -0.0014404576),
(f_attr_arrest_recency_d = NULL) => -0.0149197515, -0.0007493176);

// Tree: 47 
wFDN_FLAPS__lgt_47 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => -0.0050247426,
   (f_assocsuspicousidcount_i > 13.5) => 0.0942907952,
   (f_assocsuspicousidcount_i = NULL) => -0.0041985884, -0.0041985884),
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 23.1) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 57.25) => 0.0144420293,
      (c_low_ed > 57.25) => 0.1544327733,
      (c_low_ed = NULL) => 0.0424401781, 0.0424401781),
   (c_hval_500k_p > 23.1) => 0.2922004393,
   (c_hval_500k_p = NULL) => 0.0660395728, 0.0660395728),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 90) => 0.0484973810,
   (c_very_rich > 90) => -0.0637193642,
   (c_very_rich = NULL) => -0.0136226030, -0.0136226030), 0.0000533498);

// Tree: 48 
wFDN_FLAPS__lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0070305085,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 28.45) => -0.0289893056,
      (c_low_ed > 28.45) => 0.1194217742,
      (c_low_ed = NULL) => 0.0712464498, 0.0712464498),
   (k_nap_contradictory_i = NULL) => -0.0057063109, -0.0057063109),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 29.55) => 0.0121554542,
   (c_rnt1000_p > 29.55) => 
      map(
      (NULL < c_totsales and c_totsales <= 3474) => 0.2164730014,
      (c_totsales > 3474) => 0.0649395878,
      (c_totsales = NULL) => 0.1245018544, 0.1245018544),
   (c_rnt1000_p = NULL) => 0.0437072841, 0.0437072841),
(k_inq_per_phone_i = NULL) => -0.0032677684, -0.0032677684);

// Tree: 49 
wFDN_FLAPS__lgt_49 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
      map(
      (NULL < f_hh_criminals_i and f_hh_criminals_i <= 3.5) => -0.0013364414,
      (f_hh_criminals_i > 3.5) => 0.1334412368,
      (f_hh_criminals_i = NULL) => 0.0001835636, 0.0001835636),
   (f_varrisktype_i > 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 33) => 0.1576794405,
      (r_C10_M_Hdr_FS_d > 33) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 103.5) => -0.0285426036,
         (c_sub_bus > 103.5) => 0.0673200013,
         (c_sub_bus = NULL) => 0.0304860940, 0.0304860940),
      (r_C10_M_Hdr_FS_d = NULL) => 0.0587776982, 0.0587776982),
   (f_varrisktype_i = NULL) => 0.0027824578, 0.0027824578),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0708560895,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0137347805, -0.0001206239);

// Tree: 50 
wFDN_FLAPS__lgt_50 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 7.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => -0.0010893851,
   (r_L79_adls_per_addr_curr_i > 3.5) => 0.1806280527,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0706153336, 0.0706153336),
(r_C10_M_Hdr_FS_d > 7.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.65) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 158.5) => -0.0145557783,
      (f_prevaddrageoldest_d > 158.5) => 0.0357107185,
      (f_prevaddrageoldest_d = NULL) => -0.0031022611, -0.0031022611),
   (c_unemp > 8.65) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 204.35) => 0.1468292821,
      (c_housingcpi > 204.35) => 0.0232234446,
      (c_housingcpi = NULL) => 0.0443512257, 0.0443512257),
   (c_unemp = NULL) => 0.0037685303, -0.0001107124),
(r_C10_M_Hdr_FS_d = NULL) => 0.0279628075, 0.0011797030);

// Tree: 51 
wFDN_FLAPS__lgt_51 := map(
(NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 126.5) => -0.0091869354,
(r_pb_order_freq_d > 126.5) => -0.0301165263,
(r_pb_order_freq_d = NULL) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 1.5) => -0.0000592996,
   (f_crim_rel_under25miles_cnt_i > 1.5) => 
      map(
      (NULL < c_employees and c_employees <= 53.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => -0.0236965747,
         (f_corrrisktype_i > 3.5) => 0.1531883672,
         (f_corrrisktype_i = NULL) => 0.1072735525, 0.1072735525),
      (c_employees > 53.5) => 0.0333200454,
      (c_employees = NULL) => 0.0502917975, 0.0502917975),
   (f_crim_rel_under25miles_cnt_i = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 200784) => 0.1497842055,
      (r_L80_Inp_AVM_AutoVal_d > 200784) => -0.0079899594,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0325283612, 0.0114566202), 0.0111423387), -0.0055528574);

// Tree: 52 
wFDN_FLAPS__lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 72.5) => -0.0105921155,
      (k_comb_age_d > 72.5) => 0.0751517626,
      (k_comb_age_d = NULL) => -0.0072713723, -0.0072713723),
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.45) => 0.0300192778,
      (c_unemp > 9.45) => 0.1385690362,
      (c_unemp = NULL) => 0.0367223505, 0.0367223505),
   (f_phones_per_addr_curr_i = NULL) => -0.0151419231, -0.0034469461),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.0239476548,
   (f_inq_count_i > 2.5) => 0.2472790205,
   (f_inq_count_i = NULL) => 0.0904912862, 0.0904912862),
(r_P85_Phn_Disconnected_i = NULL) => -0.0015511489, -0.0015511489);

// Tree: 53 
wFDN_FLAPS__lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => -0.0130612982,
(c_easiqlife > 129.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 16.8) => 0.0389250698,
      (c_blue_col > 16.8) => 0.2413938380,
      (c_blue_col = NULL) => 0.0742078310, 0.0742078310),
   (f_prevaddrlenofres_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 61.5) => -0.0011959792,
         (f_prevaddrlenofres_d > 61.5) => 0.0844928038,
         (f_prevaddrlenofres_d = NULL) => 0.0427144799, 0.0427144799),
      (f_phone_ver_experian_d > 0.5) => -0.0050177349,
      (f_phone_ver_experian_d = NULL) => -0.0063911540, 0.0113356649),
   (f_prevaddrlenofres_d = NULL) => 0.0163800439, 0.0163800439),
(c_easiqlife = NULL) => -0.0100958422, -0.0021028873);

// Tree: 54 
wFDN_FLAPS__lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1473808712,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < c_unempl and c_unempl <= 190.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 222.35) => -0.0125480538,
      (c_housingcpi > 222.35) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 0.0167779540,
         (k_inq_per_phone_i > 5.5) => 0.1391957713,
         (k_inq_per_phone_i = NULL) => 0.0189565052, 0.0189565052),
      (c_housingcpi = NULL) => -0.0049488858, -0.0049488858),
   (c_unempl > 190.5) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 140.5) => -0.0230290980,
      (f_fp_prevaddrburglaryindex_i > 140.5) => 0.1662796598,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0746301818, 0.0746301818),
   (c_unempl = NULL) => -0.0124215179, -0.0043241843),
(f_attr_arrest_recency_d = NULL) => 0.0165967801, -0.0035493278);

// Tree: 55 
wFDN_FLAPS__lgt_55 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2398) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0022492044,
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 0.0127121913,
         (f_crim_rel_under25miles_cnt_i > 0.5) => 0.1255716875,
         (f_crim_rel_under25miles_cnt_i = NULL) => 0.0637541746, 0.0637541746),
      (k_inq_per_phone_i = NULL) => 0.0008183535, 0.0008183535),
   (f_addrchangeincomediff_d > 2398) => 
      map(
      (NULL < f_rel_ageover20_count_d and f_rel_ageover20_count_d <= 17.5) => 0.0484837481,
      (f_rel_ageover20_count_d > 17.5) => 0.1568036628,
      (f_rel_ageover20_count_d = NULL) => 0.0664878756, 0.0664878756),
   (f_addrchangeincomediff_d = NULL) => 0.0062035300, 0.0058603159),
(f_phone_ver_insurance_d > 3.5) => -0.0229745998,
(f_phone_ver_insurance_d = NULL) => -0.0096808669, -0.0082445571);

// Tree: 56 
wFDN_FLAPS__lgt_56 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00563981495) => 0.1914296055,
   (f_add_curr_nhood_MFD_pct_i > 0.00563981495) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 163.5) => 0.0088830109,
      (c_rich_wht > 163.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0309677935) => 0.0269636483,
         (f_add_curr_nhood_VAC_pct_i > 0.0309677935) => 0.2174876332,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1026685430, 0.1026685430),
      (c_rich_wht = NULL) => 0.0259451981, 0.0259451981),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0207331672, 0.0340564758),
(f_corrssnaddrcount_d > 2.5) => -0.0053857639,
(f_corrssnaddrcount_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0656496665,
   (f_addrs_per_ssn_i > 5.5) => 0.0561668024,
   (f_addrs_per_ssn_i = NULL) => -0.0047414320, -0.0047414320), -0.0016896702);

// Tree: 57 
wFDN_FLAPS__lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => 
      map(
      (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0077235727,
      (f_adls_per_phone_c6_i > 1.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 68.5) => -0.0170851001,
         (r_pb_order_freq_d > 68.5) => 0.2003695182,
         (r_pb_order_freq_d = NULL) => 0.0939555560, 0.0939555560),
      (f_adls_per_phone_c6_i = NULL) => -0.0062395153, -0.0062395153),
   (c_lar_fam > 181.5) => 0.1221663233,
   (c_lar_fam = NULL) => -0.0157403733, -0.0052165296),
(r_D30_Derog_Count_i > 11.5) => 0.0702514315,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_very_rich and c_very_rich <= 83.5) => 0.0557276679,
   (c_very_rich > 83.5) => -0.0635001981,
   (c_very_rich = NULL) => -0.0115290770, -0.0115290770), -0.0043025375);

// Tree: 58 
wFDN_FLAPS__lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0087262446,
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 55.95) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 62.55) => 0.2421771941,
         (r_C12_source_profile_d > 62.55) => 0.0564431414,
         (r_C12_source_profile_d = NULL) => 0.1204182040, 0.1204182040),
      (c_low_ed > 55.95) => -0.0723851381,
      (c_low_ed = NULL) => 0.0792209087, 0.0792209087),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0069381075, -0.0069381075),
(k_inq_per_phone_i > 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','6: Other']) => 0.0270362688,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','5: Vuln Vic/Friendly']) => 0.1820591308,
   (nf_seg_FraudPoint_3_0 = '') => 0.0399751848, 0.0399751848),
(k_inq_per_phone_i = NULL) => -0.0045896691, -0.0045896691);

// Tree: 59 
wFDN_FLAPS__lgt_59 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => -0.0141708401,
(r_L79_adls_per_addr_curr_i > 3.5) => 
   map(
   (NULL < c_professional and c_professional <= 10.45) => 
      map(
      (NULL < r_nas_addr_verd_d and r_nas_addr_verd_d <= 0.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 61.5) => 0.1780144721,
         (r_I60_inq_recency_d > 61.5) => 0.0274593953,
         (r_I60_inq_recency_d = NULL) => 0.1007731719, 0.1007731719),
      (r_nas_addr_verd_d > 0.5) => 0.0283571071,
      (r_nas_addr_verd_d = NULL) => 0.0312812109, 0.0312812109),
   (c_professional > 10.45) => -0.0253510922,
   (c_professional = NULL) => 0.0177857891, 0.0177857891),
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 91.5) => -0.0784346786,
   (c_burglary > 91.5) => 0.0413844970,
   (c_burglary = NULL) => -0.0146776861, -0.0146776861), -0.0046375716);

// Tree: 60 
wFDN_FLAPS__lgt_60 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 50) => 0.2510185054,
   (f_curraddrmurderindex_i > 50) => 0.0184597412,
   (f_curraddrmurderindex_i = NULL) => 0.0787527541, 0.0787527541),
(f_mos_liens_unrel_SC_fseen_d > 93.5) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 6.45) => 0.1264620464,
      (c_hh5_p > 6.45) => -0.0108095933,
      (c_hh5_p = NULL) => 0.0606468767, 0.0606468767),
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0042942570,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0035203334, -0.0035203334),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 10.85) => -0.0705644762,
   (c_retail > 10.85) => 0.0387179843,
   (c_retail = NULL) => -0.0164642482, -0.0164642482), -0.0020534543);

// Tree: 61 
wFDN_FLAPS__lgt_61 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 36.55) => 0.1739913955,
   (r_C12_source_profile_d > 36.55) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0164775574) => -0.0259977661,
      (f_add_input_nhood_BUS_pct_i > 0.0164775574) => 0.0565545496,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0306471739, 0.0306471739),
   (r_C12_source_profile_d = NULL) => 0.0603648784, 0.0603648784),
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 18.65) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -69530) => 0.1292674943,
      (f_addrchangevaluediff_d > -69530) => 0.0150440716,
      (f_addrchangevaluediff_d = NULL) => 0.0402981795, 0.0214762180),
   (c_hh1_p > 18.65) => -0.0135248096,
   (c_hh1_p = NULL) => -0.0248892858, -0.0018087140),
(r_D33_Eviction_Recency_d = NULL) => -0.0219778477, -0.0007778824);

// Tree: 62 
wFDN_FLAPS__lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0086274616,
   (f_prevaddrageoldest_d > 152.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 34.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 4.5) => 0.1842745780,
         (f_corraddrnamecount_d > 4.5) => 0.0656793846,
         (f_corraddrnamecount_d = NULL) => 0.0819571562, 0.0819571562),
      (c_born_usa > 34.5) => 0.0101270163,
      (c_born_usa = NULL) => -0.0015091896, 0.0222005465),
   (f_prevaddrageoldest_d = NULL) => -0.0011580984, -0.0011580984),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 0.0402011405,
   (f_assocrisktype_i > 8.5) => 0.1327060793,
   (f_assocrisktype_i = NULL) => 0.0589856683, 0.0589856683),
(f_assoccredbureaucountnew_i = NULL) => 0.0380790084, 0.0003887076);

// Tree: 63 
wFDN_FLAPS__lgt_63 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0058360342,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1442258036) => 
      map(
      (NULL < f_divssnidmsrcurelcount_i and f_divssnidmsrcurelcount_i <= 1.5) => 0.0137363494,
      (f_divssnidmsrcurelcount_i > 1.5) => 0.1514553879,
      (f_divssnidmsrcurelcount_i = NULL) => 0.0216490712, 0.0216490712),
   (f_add_curr_nhood_VAC_pct_i > 0.1442258036) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 18.5) => 0.2468575147,
      (c_high_ed > 18.5) => 0.0461407685,
      (c_high_ed = NULL) => 0.1410533384, 0.1410533384),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0313994197, 0.0313994197),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.05) => -0.0622755493,
   (c_pop_35_44_p > 16.05) => 0.0451293064,
   (c_pop_35_44_p = NULL) => -0.0146362988, -0.0146362988), -0.0012523835);

// Tree: 64 
wFDN_FLAPS__lgt_64 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => -0.0012390116,
   (k_inq_per_ssn_i > 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 302) => 0.0336224472,
      (r_C13_Curr_Addr_LRes_d > 302) => 0.1988584883,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0394006400, 0.0394006400),
   (k_inq_per_ssn_i = NULL) => 0.0124998665, 0.0124998665),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 1.5) => 0.0077512018,
      (r_C14_addrs_5yr_i > 1.5) => 0.1581403358,
      (r_C14_addrs_5yr_i = NULL) => 0.0472473380, 0.0472473380),
   (k_estimated_income_d > 28500) => -0.0178918515,
   (k_estimated_income_d = NULL) => -0.0154064533, -0.0154064533),
(k_nap_phn_verd_d = NULL) => -0.0047147139, -0.0047147139);

// Tree: 65 
wFDN_FLAPS__lgt_65 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0053380445,
(f_prevaddrageoldest_d > 151.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => 0.0027818104,
   (f_corrrisktype_i > 3.5) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 45.45) => 
         map(
         (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 0.0388862330,
         (f_srchaddrsrchcountmo_i > 0.5) => 0.2183748894,
         (f_srchaddrsrchcountmo_i = NULL) => 0.0480861541, 0.0480861541),
      (c_hval_750k_p > 45.45) => 0.2510352767,
      (c_hval_750k_p = NULL) => 0.0603512568, 0.0603512568),
   (f_corrrisktype_i = NULL) => 0.0239572210, 0.0239572210),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0780038823,
   (k_nap_lname_verd_d > 0.5) => -0.0454216140,
   (k_nap_lname_verd_d = NULL) => 0.0173371129, 0.0173371129), 0.0017919739);

// Tree: 66 
wFDN_FLAPS__lgt_66 := map(
(NULL < c_hh3_p and c_hh3_p <= 23.25) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 132.5) => -0.0191096953,
   (c_span_lang > 132.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 0.5) => 
         map(
         (NULL < c_hhsize and c_hhsize <= 2.605) => -0.0047023305,
         (c_hhsize > 2.605) => 0.1564538009,
         (c_hhsize = NULL) => 0.0758757352, 0.0758757352),
      (f_prevaddrlenofres_d > 0.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0023542446,
         (f_srchvelocityrisktype_i > 4.5) => 0.0439511153,
         (f_srchvelocityrisktype_i = NULL) => 0.0046594337, 0.0046594337),
      (f_prevaddrlenofres_d = NULL) => 0.0082917953, 0.0082917953),
   (c_span_lang = NULL) => -0.0088295563, -0.0088295563),
(c_hh3_p > 23.25) => 0.0377563291,
(c_hh3_p = NULL) => -0.0047111286, -0.0016557624);

// Tree: 67 
wFDN_FLAPS__lgt_67 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 99) => -0.0021405222,
(f_addrchangecrimediff_i > 99) => 0.0981407890,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 131314.5) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 1884.5) => 0.0255506678,
         (c_popover18 > 1884.5) => 0.2091156829,
         (c_popover18 = NULL) => 0.0563714605, 0.0563714605),
      (r_L80_Inp_AVM_AutoVal_d > 131314.5) => -0.0031961158,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 5.5) => -0.0308501497,
         (f_srchaddrsrchcount_i > 5.5) => 0.0683935605,
         (f_srchaddrsrchcount_i = NULL) => -0.0401437614, -0.0227169575), -0.0052375409),
   (k_nap_contradictory_i > 0.5) => 0.1106416509,
   (k_nap_contradictory_i = NULL) => -0.0018556939, -0.0018556939), -0.0014916559);

// Tree: 68 
wFDN_FLAPS__lgt_68 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 306.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0054174851,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 5.5) => -0.0187029272,
      (f_addrs_per_ssn_i > 5.5) => 0.2296511051,
      (f_addrs_per_ssn_i = NULL) => 0.1062088642, 0.1062088642),
   (f_nae_nothing_found_i = NULL) => -0.0038161904, -0.0038161904),
(r_C13_Curr_Addr_LRes_d > 306.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0453708501,
   (f_corrrisktype_i > 6.5) => 0.1753390728,
   (f_corrrisktype_i = NULL) => 0.0542133608, 0.0542133608),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0916277579,
   (f_addrs_per_ssn_i > 3.5) => 0.0470450187,
   (f_addrs_per_ssn_i = NULL) => -0.0217366785, -0.0217366785), -0.0004291223);

// Tree: 69 
wFDN_FLAPS__lgt_69 := map(
(NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 22.5) => 
   map(
   (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62445.5) => 
      map(
      (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 0.0997653773,
      (f_rel_incomeover100_count_d > 0.5) => -0.0239378649,
      (f_rel_incomeover100_count_d = NULL) => 0.0408165399, 0.0408165399),
   (f_addrchangevaluediff_d > -62445.5) => -0.0097040179,
   (f_addrchangevaluediff_d = NULL) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => -0.0321618192,
      (r_L79_adls_per_addr_curr_i > 1.5) => 
         map(
         (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 0.0224771287,
         (f_srchcomponentrisktype_i > 1.5) => 0.1542155197,
         (f_srchcomponentrisktype_i = NULL) => 0.0277200337, 0.0277200337),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0029857422, 0.0029857422), -0.0058316266),
(f_srchssnsrchcount_i > 22.5) => 0.0729295542,
(f_srchssnsrchcount_i = NULL) => -0.0148392119, -0.0054158576);

// Tree: 70 
wFDN_FLAPS__lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 4.75) => -0.0863853445,
   (c_pop_35_44_p > 4.75) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 56.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 3.35) => -0.0135565607,
         (c_hh7p_p > 3.35) => 0.0274438581,
         (c_hh7p_p = NULL) => -0.0080731196, -0.0080731196),
      (f_phones_per_addr_curr_i > 56.5) => 0.1150155546,
      (f_phones_per_addr_curr_i = NULL) => -0.0058546030, -0.0067092199),
   (c_pop_35_44_p = NULL) => -0.0085946748, -0.0085946748),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < c_med_inc and c_med_inc <= 45.5) => 0.1722615914,
   (c_med_inc > 45.5) => 0.0404112971,
   (c_med_inc = NULL) => 0.0490280694, 0.0490280694),
(c_hval_750k_p = NULL) => 0.0227566814, -0.0035507773);

// Tree: 71 
wFDN_FLAPS__lgt_71 := map(
(NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 0.1102379435,
      (r_I60_inq_banking_recency_d > 9) => 0.0249580155,
      (r_I60_inq_banking_recency_d = NULL) => 0.0309161756, 0.0309161756),
   (f_phone_ver_experian_d > 0.5) => -0.0055057806,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 621.5) => 0.1103106167,
      (c_popover18 > 621.5) => -0.0014628270,
      (c_popover18 = NULL) => -0.0422299755, 0.0049953632), 0.0100902299),
(k_inf_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => 0.0893124460,
   (r_D33_Eviction_Recency_d > 79.5) => -0.0204109326,
   (r_D33_Eviction_Recency_d = NULL) => -0.0186007753, -0.0186007753),
(k_inf_phn_verd_d = NULL) => -0.0006601326, -0.0006601326);

// Tree: 72 
wFDN_FLAPS__lgt_72 := map(
(NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < nf_altlexid_phone_hi_no_hi_lexid and nf_altlexid_phone_hi_no_hi_lexid <= 0.5) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => -0.0014964293,
      (f_inq_PrepaidCards_count_i > 2.5) => 0.0960495945,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0010851149, -0.0010851149),
   (nf_altlexid_phone_hi_no_hi_lexid > 0.5) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 140) => 0.0076340965,
      (c_oldhouse > 140) => 0.1542202688,
      (c_oldhouse = NULL) => 0.0638715588, 0.0638715588),
   (nf_altlexid_phone_hi_no_hi_lexid = NULL) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0997017091,
      (r_S66_adlperssn_count_i > 1.5) => 0.0363319761,
      (r_S66_adlperssn_count_i = NULL) => -0.0213463064, -0.0213463064), -0.0004449909),
(r_P85_Phn_Not_Issued_i > 0.5) => -0.0734044423,
(r_P85_Phn_Not_Issued_i = NULL) => -0.0021934870, -0.0021934870);

// Tree: 73 
wFDN_FLAPS__lgt_73 := map(
(NULL < c_pop_12_17_p and c_pop_12_17_p <= 10.15) => -0.0055119833,
(c_pop_12_17_p > 10.15) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 13.5) => 0.1681067539,
   (r_C10_M_Hdr_FS_d > 13.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 76.5) => 
         map(
         (NULL < f_historical_count_d and f_historical_count_d <= 1.5) => 
            map(
            (NULL < c_med_hhinc and c_med_hhinc <= 32414) => 0.2001187059,
            (c_med_hhinc > 32414) => 0.0809163448,
            (c_med_hhinc = NULL) => 0.0986264099, 0.0986264099),
         (f_historical_count_d > 1.5) => -0.0038721373,
         (f_historical_count_d = NULL) => 0.0491966372, 0.0491966372),
      (f_mos_inq_banko_cm_lseen_d > 76.5) => 0.0054997283,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0154623288, 0.0154623288),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0185888416, 0.0185888416),
(c_pop_12_17_p = NULL) => 0.0011611858, 0.0004303577);

// Tree: 74 
wFDN_FLAPS__lgt_74 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
   map(
   (NULL < nf_vf_hi_additional_entries and nf_vf_hi_additional_entries <= 0.5) => -0.0037577950,
   (nf_vf_hi_additional_entries > 0.5) => -0.0846851814,
   (nf_vf_hi_additional_entries = NULL) => -0.0043832742, -0.0043832742),
(f_util_adl_count_n > 6.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 2.75) => -0.0008075028,
      (c_hval_125k_p > 2.75) => 
         map(
         (NULL < c_hh2_p and c_hh2_p <= 31.65) => 0.0478997818,
         (c_hh2_p > 31.65) => 0.2382133351,
         (c_hh2_p = NULL) => 0.1484719848, 0.1484719848),
      (c_hval_125k_p = NULL) => 0.0735300558, 0.0735300558),
   (f_phone_ver_experian_d > 0.5) => -0.0125376046,
   (f_phone_ver_experian_d = NULL) => 0.0901897499, 0.0268532704),
(f_util_adl_count_n = NULL) => 0.0225632393, -0.0021761431);

// Tree: 75 
wFDN_FLAPS__lgt_75 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 69) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 66.5) => 
      map(
      (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 0.5) => -0.0124000534,
      (f_inq_QuizProvider_count24_i > 0.5) => 
         map(
         (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 152.5) => 0.1654902662,
         (f_mos_liens_unrel_CJ_fseen_d > 152.5) => 0.0254045648,
         (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0346620987, 0.0346620987),
      (f_inq_QuizProvider_count24_i = NULL) => -0.0091350148, -0.0091350148),
   (k_comb_age_d > 66.5) => 
      map(
      (NULL < c_no_car and c_no_car <= 185.5) => 0.0301488448,
      (c_no_car > 185.5) => 0.1709816948,
      (c_no_car = NULL) => 0.0377816560, 0.0377816560),
   (k_comb_age_d = NULL) => -0.0246490089, -0.0056451325),
(f_bus_addr_match_count_d > 69) => 0.2139661223,
(f_bus_addr_match_count_d = NULL) => -0.0046409975, -0.0046409975);

// Tree: 76 
wFDN_FLAPS__lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0114081257,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => -0.0027608787,
         (f_prevaddrlenofres_d > 123.5) => 
            map(
            (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0435480491,
            (f_rel_homeover500_count_d > 3.5) => 0.1849102898,
            (f_rel_homeover500_count_d = NULL) => 0.0664382150, 0.0664382150),
         (f_prevaddrlenofres_d = NULL) => 0.0161602659, 0.0161602659),
      (f_nae_nothing_found_i > 0.5) => 0.2045137640,
      (f_nae_nothing_found_i = NULL) => 0.0191928896, 0.0191928896),
   (f_inq_Communications_count24_i > 1.5) => 0.1264793884,
   (f_inq_Communications_count24_i = NULL) => 0.0214376343, 0.0214376343),
(c_rnt1250_p = NULL) => 0.0010199082, -0.0020248545);

// Tree: 77 
wFDN_FLAPS__lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 26998.5) => 
      map(
      (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 6.5) => 0.0030774329,
      (f_rel_homeover50_count_d > 6.5) => 
         map(
         (NULL < c_pop00 and c_pop00 <= 1440) => 0.0295452758,
         (c_pop00 > 1440) => 0.1635668810,
         (c_pop00 = NULL) => 0.0848557795, 0.0848557795),
      (f_rel_homeover50_count_d = NULL) => 0.0407385136, 0.0407385136),
   (f_curraddrmedianincome_d > 26998.5) => -0.0044435604,
   (f_curraddrmedianincome_d = NULL) => 0.0017179267, -0.0017160470),
(c_transport > 29.05) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.1986025185,
   (f_phone_ver_insurance_d > 2.5) => 0.0312814292,
   (f_phone_ver_insurance_d = NULL) => 0.0962604930, 0.0962604930),
(c_transport = NULL) => -0.0017701567, -0.0001030588);

// Tree: 78 
wFDN_FLAPS__lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 18.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0202381534,
         (f_varrisktype_i > 2.5) => 0.1971779825,
         (f_varrisktype_i = NULL) => 0.1036365442, 0.1036365442),
      (r_C13_max_lres_d > 18.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0088437587,
         (c_easiqlife > 132.5) => 0.0222359251,
         (c_easiqlife = NULL) => 0.0021255719, 0.0021601112),
      (r_C13_max_lres_d = NULL) => 0.0035172796, 0.0035172796),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0576250363,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0272584735, 0.0010904667),
(r_L77_Add_PO_Box_i > 0.5) => -0.1054718052,
(r_L77_Add_PO_Box_i = NULL) => -0.0013961263, -0.0013961263);

// Tree: 79 
wFDN_FLAPS__lgt_79 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0078341508,
   (k_inq_per_ssn_i > 2.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.45) => -0.0056024581,
      (c_incollege > 6.45) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 14111.5) => 
            map(
            (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.95) => 0.0406095441,
            (c_pop_75_84_p > 2.95) => 0.3113911746,
            (c_pop_75_84_p = NULL) => 0.1624612779, 0.1624612779),
         (r_A49_Curr_AVM_Chg_1yr_i > 14111.5) => 0.0615766596,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0319319828, 0.0623121761),
      (c_incollege = NULL) => 0.0246225308, 0.0246225308),
   (k_inq_per_ssn_i = NULL) => -0.0039555164, -0.0039555164),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1053874404,
(f_inq_PrepaidCards_count_i = NULL) => -0.0055585561, -0.0035381716);

// Tree: 80 
wFDN_FLAPS__lgt_80 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0092661967,
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1035971224,
      (r_D32_Mos_Since_Crim_LS_d > 10.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => -0.0456764324,
         (f_mos_inq_banko_cm_fseen_d > 25.5) => 
            map(
            (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 0.0665097382,
            (f_corrssnaddrcount_d > 2.5) => 0.0154555703,
            (f_corrssnaddrcount_d = NULL) => 0.0196550216, 0.0196550216),
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0140232957, 0.0140232957),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0164955608, 0.0164955608),
   (f_hh_lienholders_i = NULL) => 0.0095668780, -0.0008682083),
(c_bel_edu > 196.5) => -0.0826382802,
(c_bel_edu = NULL) => 0.0354284609, -0.0009115376);

// Tree: 81 
wFDN_FLAPS__lgt_81 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0067790709,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 28.15) => 
         map(
         (NULL < c_unempl and c_unempl <= 126.5) => 0.0459671488,
         (c_unempl > 126.5) => -0.0680725727,
         (c_unempl = NULL) => 0.0146892640, 0.0146892640),
      (c_rnt1000_p > 28.15) => 
         map(
         (NULL < c_professional and c_professional <= 2.45) => 0.2154228375,
         (c_professional > 2.45) => 0.0598201644,
         (c_professional = NULL) => 0.1016488399, 0.1016488399),
      (c_rnt1000_p = NULL) => 0.0417368913, 0.0417368913),
   (k_inq_per_phone_i = NULL) => -0.0044359043, -0.0044359043),
(f_srchphonesrchcount_i > 22.5) => -0.1061016279,
(f_srchphonesrchcount_i = NULL) => -0.0148706966, -0.0049859051);

// Tree: 82 
wFDN_FLAPS__lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0036024364,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0160300143,
      (f_mos_inq_banko_cm_fseen_d > 46.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 37.4) => 0.0350112156,
         (c_fammar18_p > 37.4) => 0.2065438882,
         (c_fammar18_p = NULL) => 0.1029559755, 0.1029559755),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0583362293, 0.0583362293),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0023679440, -0.0023679440),
(r_I60_inq_hiRiskCred_count12_i > 2.5) => 
   map(
   (NULL < f_divrisktype_i and f_divrisktype_i <= 1.5) => -0.1211720581,
   (f_divrisktype_i > 1.5) => 0.0128512099,
   (f_divrisktype_i = NULL) => -0.0635839351, -0.0635839351),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0079710437, -0.0028927372);

// Tree: 83 
wFDN_FLAPS__lgt_83 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0116119205,
(f_srchaddrsrchcount_i > 1.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.1089300889,
   (r_C10_M_Hdr_FS_d > 8.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0615956427,
         (f_corrphonelastnamecount_d > 0.5) => -0.0071351182,
         (f_corrphonelastnamecount_d = NULL) => 0.0309585818, 0.0309585818),
      (f_phone_ver_experian_d > 0.5) => 
         map(
         (NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 90) => 0.1409667431,
         (f_mos_liens_unrel_CJ_lseen_d > 90) => -0.0102241807,
         (f_mos_liens_unrel_CJ_lseen_d = NULL) => -0.0051792823, -0.0051792823),
      (f_phone_ver_experian_d = NULL) => -0.0021616815, 0.0064627364),
   (r_C10_M_Hdr_FS_d = NULL) => 0.0082398387, 0.0082398387),
(f_srchaddrsrchcount_i = NULL) => -0.0045575564, -0.0027872534);

// Tree: 84 
wFDN_FLAPS__lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 308.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 67.5) => -0.0040789416,
   (f_bus_addr_match_count_d > 67.5) => 0.1787950332,
   (f_bus_addr_match_count_d = NULL) => -0.0031044799, -0.0031044799),
(r_C13_Curr_Addr_LRes_d > 308.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 159.9) => 0.0389683087,
   (c_oldhouse > 159.9) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 5.55) => 0.0422770330,
      (c_rnt1250_p > 5.55) => 0.2528222310,
      (c_rnt1250_p = NULL) => 0.1508916193, 0.1508916193),
   (c_oldhouse = NULL) => 0.0584466749, 0.0584466749),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0603004058,
   (k_nap_lname_verd_d > 0.5) => -0.0395612510,
   (k_nap_lname_verd_d = NULL) => 0.0099764213, 0.0099764213), 0.0005929086);

// Tree: 85 
wFDN_FLAPS__lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0094973612,
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0084877115,
      (f_hh_lienholders_i > 0.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 38.5) => 
            map(
            (NULL < c_retired and c_retired <= 10.05) => 0.1495054067,
            (c_retired > 10.05) => 0.0267478084,
            (c_retired = NULL) => 0.0923855446, 0.0923855446),
         (k_comb_age_d > 38.5) => 0.0018933875,
         (k_comb_age_d = NULL) => 0.0467745783, 0.0467745783),
      (f_hh_lienholders_i = NULL) => 0.0101459362, 0.0101459362),
   (r_F01_inp_addr_not_verified_i > 0.5) => 0.1227824875,
   (r_F01_inp_addr_not_verified_i = NULL) => 0.0165038685, 0.0165038685),
(f_util_adl_count_n = NULL) => 0.0071607880, -0.0061400969);

// Tree: 86 
wFDN_FLAPS__lgt_86 := map(
(NULL < f_vf_LexID_addr_hi_risk_ct_i and f_vf_LexID_addr_hi_risk_ct_i <= 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => -0.0017313598,
   (f_phones_per_addr_curr_i > 13.5) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 128.5) => 
         map(
         (NULL < c_cpiall and c_cpiall <= 222.95) => -0.0191352880,
         (c_cpiall > 222.95) => 0.1027273009,
         (c_cpiall = NULL) => 0.0122953345, 0.0122953345),
      (f_curraddrcrimeindex_i > 128.5) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 40.05) => 0.1743741447,
         (c_hh1_p > 40.05) => 0.0249669006,
         (c_hh1_p = NULL) => 0.1153725579, 0.1153725579),
      (f_curraddrcrimeindex_i = NULL) => 0.0391190309, 0.0391190309),
   (f_phones_per_addr_curr_i = NULL) => 0.0002875344, 0.0002875344),
(f_vf_LexID_addr_hi_risk_ct_i > 0.5) => -0.0665906372,
(f_vf_LexID_addr_hi_risk_ct_i = NULL) => -0.0140070550, -0.0009251177);

// Tree: 87 
wFDN_FLAPS__lgt_87 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 32.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 8284.5) => -0.0054751936,
   (f_addrchangeincomediff_d > 8284.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 58391.5) => 0.1038413229,
      (f_curraddrmedianincome_d > 58391.5) => 0.0040499131,
      (f_curraddrmedianincome_d = NULL) => 0.0434349005, 0.0434349005),
   (f_addrchangeincomediff_d = NULL) => -0.0086270170, -0.0045007580),
(f_rel_under500miles_cnt_d > 32.5) => -0.0736108357,
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 200784) => 0.1007179355,
   (r_L80_Inp_AVM_AutoVal_d > 200784) => -0.0243305052,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 1.15) => 0.0708488574,
      (c_rnt1000_p > 1.15) => -0.0698108494,
      (c_rnt1000_p = NULL) => -0.0344726965, -0.0344726965), -0.0058193979), -0.0054456350);

// Tree: 88 
wFDN_FLAPS__lgt_88 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0052929077,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 12.25) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 27.05) => 0.0017809131,
         (c_famotf18_p > 27.05) => 0.0617839344,
         (c_famotf18_p = NULL) => 0.0077323826, 0.0077323826),
      (c_hval_175k_p > 12.25) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 7.75) => 0.2236987207,
         (C_INC_50K_P > 7.75) => 0.0571497183,
         (C_INC_50K_P = NULL) => 0.0747266891, 0.0747266891),
      (c_hval_175k_p = NULL) => 0.0229535733, 0.0229535733),
   (k_inq_per_ssn_i = NULL) => 0.0004978913, 0.0004978913),
(f_srchphonesrchcountmo_i > 2.5) => -0.1027400192,
(f_srchphonesrchcountmo_i = NULL) => -0.0050079722, 0.0000479917);

// Tree: 89 
wFDN_FLAPS__lgt_89 := map(
(NULL < c_newhouse and c_newhouse <= 8.95) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0051568787,
      (f_rel_felony_count_i > 1.5) => 0.0535520687,
      (f_rel_felony_count_i = NULL) => 0.0223834834, 0.0075441341),
   (f_nae_nothing_found_i > 0.5) => 0.1623688341,
   (f_nae_nothing_found_i = NULL) => 0.0092455044, 0.0092455044),
(c_newhouse > 8.95) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 29.5) => -0.0128600393,
   (f_rel_under100miles_cnt_d > 29.5) => -0.0861735359,
   (f_rel_under100miles_cnt_d = NULL) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 0.65) => 0.1133755959,
      (c_bigapt_p > 0.65) => -0.0357174642,
      (c_bigapt_p = NULL) => 0.0139802225, 0.0139802225), -0.0134439561),
(c_newhouse = NULL) => 0.0156222838, -0.0031553854);

// Tree: 90 
wFDN_FLAPS__lgt_90 := map(
(NULL < f_mos_liens_unrel_CJ_lseen_d and f_mos_liens_unrel_CJ_lseen_d <= 250) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.15) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 8.75) => -0.0338642949,
      (c_hval_200k_p > 8.75) => 0.1179069056,
      (c_hval_200k_p = NULL) => 0.0025014206, 0.0025014206),
   (c_hval_80k_p > 0.15) => -0.0746381304,
   (c_hval_80k_p = NULL) => -0.0366717328, -0.0366717328),
(f_mos_liens_unrel_CJ_lseen_d > 250) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.1137337949,
   (r_D32_Mos_Since_Fel_LS_d > 117) => 
      map(
      (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => -0.0006086541,
      (f_srchphonesrchcountwk_i > 0.5) => 0.0860174668,
      (f_srchphonesrchcountwk_i = NULL) => 0.0002069646, 0.0002069646),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0007485357, 0.0007485357),
(f_mos_liens_unrel_CJ_lseen_d = NULL) => -0.0290850510, -0.0019781335);

// Tree: 91 
wFDN_FLAPS__lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.45) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 121.5) => -0.0399228931,
      (c_lar_fam > 121.5) => 0.1226965459,
      (c_lar_fam = NULL) => 0.0259482721, 0.0259482721),
   (c_retired > 15.45) => 0.2203880527,
   (c_retired = NULL) => 0.0768297100, 0.0768297100),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => -0.0090333385,
   (c_food > 65.55) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => 0.0173065045,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => 0.1250782553,
      (nf_seg_FraudPoint_3_0 = '') => 0.0543839417, 0.0543839417),
   (c_food = NULL) => -0.0056690613, -0.0067200241),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0052027704, -0.0051920772);

// Tree: 92 
wFDN_FLAPS__lgt_92 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 94.35) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0019489362,
      (k_comb_age_d > 70.5) => 0.0636938914,
      (k_comb_age_d = NULL) => -0.0217160155, 0.0010589171),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 128159.5) => 0.1369741084,
      (f_prevaddrmedianvalue_d > 128159.5) => 
         map(
         (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0960213170,
         (r_C14_Addr_Stability_v2_d > 3.5) => 0.0943672428,
         (r_C14_Addr_Stability_v2_d = NULL) => -0.0062445977, -0.0062445977),
      (f_prevaddrmedianvalue_d = NULL) => 0.0427714301, 0.0427714301),
   (k_nap_contradictory_i = NULL) => 0.0017291336, 0.0017291336),
(C_RENTOCC_P > 94.35) => -0.1391366413,
(C_RENTOCC_P = NULL) => -0.0448294138, -0.0000381759);

// Tree: 93 
wFDN_FLAPS__lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0015467441,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_serv_empl and c_serv_empl <= 115.5) => 0.0045083910,
         (c_serv_empl > 115.5) => 0.1484122204,
         (c_serv_empl = NULL) => 0.0770970483, 0.0770970483),
      (r_D33_eviction_count_i = NULL) => 0.0022774172, 0.0022774172),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 55.5) => 0.1068742305,
      (r_pb_order_freq_d > 55.5) => -0.0520363670,
      (r_pb_order_freq_d = NULL) => 0.1321682137, 0.0795311424),
   (f_curraddrcartheftindex_i = NULL) => 0.0014073027, 0.0036865846),
(c_cartheft > 189.5) => -0.0582940067,
(c_cartheft = NULL) => 0.0008422453, 0.0016171697);

// Tree: 94 
wFDN_FLAPS__lgt_94 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.75) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 0.85) => -0.0092628670,
   (c_hh7p_p > 0.85) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 0.1634414689,
         (r_C21_M_Bureau_ADL_FS_d > 6.5) => 0.0400494239,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0450329475, 0.0450329475),
      (f_property_owners_ct_d > 0.5) => 0.0032473330,
      (f_property_owners_ct_d = NULL) => 0.0150687660, 0.0150687660),
   (c_hh7p_p = NULL) => -0.0005076842, -0.0005076842),
(c_famotf18_p > 54.75) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => 0.1150013687,
   (f_rel_incomeover75_count_d > 0.5) => -0.0039604932,
   (f_rel_incomeover75_count_d = NULL) => 0.0656757186, 0.0656757186),
(c_famotf18_p = NULL) => 0.0105663887, 0.0004220104);

// Tree: 95 
wFDN_FLAPS__lgt_95 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => -0.0089617881,
(f_hh_collections_ct_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 51.35) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 40.5) => 0.1424612195,
         (f_mos_inq_banko_cm_fseen_d > 40.5) => 0.0356543109,
         (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0605087487, 0.0605087487),
      (k_nap_fname_verd_d > 0.5) => -0.0110727137,
      (k_nap_fname_verd_d = NULL) => 0.0103009061, 0.0103009061),
   (c_rnt1000_p > 51.35) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.0815609269,
      (f_srchvelocityrisktype_i > 2.5) => 0.2444267051,
      (f_srchvelocityrisktype_i = NULL) => 0.1587078745, 0.1587078745),
   (c_rnt1000_p = NULL) => 0.0246506893, 0.0246506893),
(f_hh_collections_ct_i = NULL) => -0.0211300934, -0.0059048838);

// Tree: 96 
wFDN_FLAPS__lgt_96 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 45599.5) => 
   map(
   (NULL < c_construction and c_construction <= 40.1) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.55) => -0.0021249714,
      (c_pop_35_44_p > 14.55) => 0.0457644268,
      (c_pop_35_44_p = NULL) => 0.0151970981, 0.0151970981),
   (c_construction > 40.1) => 0.1550283506,
   (c_construction = NULL) => -0.0173571570, 0.0173571940),
(f_curraddrmedianincome_d > 45599.5) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 19.35) => -0.0600187233,
   (C_OWNOCC_P > 19.35) => -0.0069340364,
   (C_OWNOCC_P = NULL) => -0.0093472324, -0.0093472324),
(f_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.26693968695) => -0.0674315743,
   (f_add_input_mobility_index_i > 0.26693968695) => 0.0383093196,
   (f_add_input_mobility_index_i = NULL) => -0.0076649820, -0.0076649820), -0.0027992893);

// Tree: 97 
wFDN_FLAPS__lgt_97 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0003223256,
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1506858589,
      (r_A50_pb_average_dollars_d > 99) => -0.0106326876,
      (r_A50_pb_average_dollars_d = NULL) => 0.0628131547, 0.0628131547),
   (r_D33_eviction_count_i = NULL) => 
      map(
      (NULL < c_health and c_health <= 9.05) => 0.0428154049,
      (c_health > 9.05) => -0.0768563705,
      (c_health = NULL) => -0.0127464908, -0.0127464908), 0.0008146499),
(k_inq_adls_per_addr_i > 3.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => -0.0872412384,
   (f_corrphonelastnamecount_d > 0.5) => -0.0237641260,
   (f_corrphonelastnamecount_d = NULL) => -0.0546382079, -0.0546382079),
(k_inq_adls_per_addr_i = NULL) => -0.0003132048, -0.0003132048);

// Tree: 98 
wFDN_FLAPS__lgt_98 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 23.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => -0.0071377065,
   (f_hh_lienholders_i > 1.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 66.5) => 
         map(
         (NULL < c_families and c_families <= 298) => 0.1770046798,
         (c_families > 298) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 157.5) => 0.0069232444,
            (f_prevaddrlenofres_d > 157.5) => 0.2205698353,
            (f_prevaddrlenofres_d = NULL) => 0.0445574678, 0.0445574678),
         (c_families = NULL) => 0.0730195282, 0.0730195282),
      (c_no_labfor > 66.5) => 0.0013626813,
      (c_no_labfor = NULL) => 0.0254705682, 0.0254705682),
   (f_hh_lienholders_i = NULL) => -0.0034778067, -0.0034778067),
(f_srchphonesrchcount_i > 23.5) => -0.0942106481,
(f_srchphonesrchcount_i = NULL) => 0.0174728809, -0.0037302503);

// Tree: 99 
wFDN_FLAPS__lgt_99 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.38111460565) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 117) => 0.0929629190,
   (r_D32_Mos_Since_Fel_LS_d > 117) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0108017754,
      (f_util_add_curr_conv_n > 0.5) => 
         map(
         (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 0.0166958654,
         (f_prevaddroccupantowned_i > 0.5) => 0.0792503573,
         (f_prevaddroccupantowned_i = NULL) => 0.0223208033, 0.0223208033),
      (f_util_add_curr_conv_n = NULL) => 0.0077530173, 0.0077530173),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0527520169, 0.0085526787),
(f_add_input_mobility_index_i > 0.38111460565) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 31.5) => -0.0307657378,
   (f_phones_per_addr_curr_i > 31.5) => 0.0727494535,
   (f_phones_per_addr_curr_i = NULL) => -0.0249297165, -0.0249297165),
(f_add_input_mobility_index_i = NULL) => 0.0058832669, 0.0029319182);

// Tree: 100 
wFDN_FLAPS__lgt_100 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < c_transport and c_transport <= 26.6) => 
      map(
      (NULL < c_assault and c_assault <= 182.5) => 0.0025853649,
      (c_assault > 182.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0327247020,
         (f_rel_under25miles_cnt_d > 5.5) => 0.1602478690,
         (f_rel_under25miles_cnt_d = NULL) => 0.0735504641, 0.0735504641),
      (c_assault = NULL) => 0.0060843218, 0.0060843218),
   (c_transport > 26.6) => 0.1644146400,
   (c_transport = NULL) => 0.0023211437, 0.0087866721),
(f_historical_count_d > 0.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 39.35) => -0.0145848719,
   (c_famotf18_p > 39.35) => -0.0777415819,
   (c_famotf18_p = NULL) => 0.0840794172, -0.0158240860),
(f_historical_count_d = NULL) => 0.0104884572, -0.0035486762);

// Tree: 101 
wFDN_FLAPS__lgt_101 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0040281997,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 7.5) => -0.0212418436,
      (f_addrs_per_ssn_i > 7.5) => 0.2340484531,
      (f_addrs_per_ssn_i = NULL) => 0.0663725778, 0.0663725778),
   (f_nae_nothing_found_i = NULL) => -0.0030714059, -0.0030714059),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 303) => -0.0079884198,
   (r_C13_max_lres_d > 303) => 0.2419893236,
   (r_C13_max_lres_d = NULL) => 0.0983453964, 0.0983453964),
(k_comb_age_d = NULL) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 3.5) => -0.0787179988,
   (f_addrs_per_ssn_i > 3.5) => 0.0584436551,
   (f_addrs_per_ssn_i = NULL) => -0.0054074596, -0.0054074596), -0.0020214359);

// Tree: 102 
wFDN_FLAPS__lgt_102 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 51.5) => -0.0117389638,
   (f_phones_per_addr_curr_i > 51.5) => 
      map(
      (NULL < c_professional and c_professional <= 6.45) => -0.0085264464,
      (c_professional > 6.45) => 0.2458707438,
      (c_professional = NULL) => 0.1161780586, 0.1161780586),
   (f_phones_per_addr_curr_i = NULL) => -0.0179960180, -0.0100586272),
(k_inq_per_ssn_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 44) => -0.1195208718,
   (f_mos_inq_banko_am_fseen_d > 44) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 21.5) => 0.0229359679,
      (f_rel_under25miles_cnt_d > 21.5) => -0.0571208596,
      (f_rel_under25miles_cnt_d = NULL) => 0.0312925712, 0.0206253272),
   (f_mos_inq_banko_am_fseen_d = NULL) => 0.0170353217, 0.0170353217),
(k_inq_per_ssn_i = NULL) => 0.0009797274, 0.0009797274);

// Tree: 103 
wFDN_FLAPS__lgt_103 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 32.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 27500) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 701.5) => 
         map(
         (NULL < c_no_teens and c_no_teens <= 76) => 0.2019109093,
         (c_no_teens > 76) => 0.0308780231,
         (c_no_teens = NULL) => 0.0971420733, 0.0971420733),
      (c_popover25 > 701.5) => -0.0140331901,
      (c_popover25 = NULL) => 0.1058676238, 0.0445430068),
   (k_estimated_income_d > 27500) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 123.5) => 0.0592714497,
      (f_mos_liens_unrel_SC_fseen_d > 123.5) => -0.0047046524,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0033033224, -0.0033033224),
   (k_estimated_income_d = NULL) => -0.0009938701, -0.0009938701),
(f_srchaddrsrchcount_i > 32.5) => -0.0863586263,
(f_srchaddrsrchcount_i = NULL) => -0.0040533139, -0.0016032448);

// Tree: 104 
wFDN_FLAPS__lgt_104 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 773816) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => -0.0026440131,
   (k_inq_per_phone_i > 6.5) => 0.0549136880,
   (k_inq_per_phone_i = NULL) => -0.0019231376, -0.0019231376),
(f_prevaddrmedianvalue_d > 773816) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 0.5) => 0.0258641627,
   (f_bus_addr_match_count_d > 0.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 1065.5) => 0.0554976107,
      (c_popover18 > 1065.5) => 0.4527259868,
      (c_popover18 = NULL) => 0.2541117987, 0.2541117987),
   (f_bus_addr_match_count_d = NULL) => 0.1168199876, 0.1168199876),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.55) => 0.0472752809,
   (c_construction > 4.55) => -0.0537763478,
   (c_construction = NULL) => -0.0093484766, -0.0093484766), 0.0004948644);

// Tree: 105 
wFDN_FLAPS__lgt_105 := map(
(NULL < f_corrrisktype_i and f_corrrisktype_i <= 5.5) => -0.0106559861,
(f_corrrisktype_i > 5.5) => 
   map(
   (NULL < c_cpiall and c_cpiall <= 208.5) => 
      map(
      (NULL < c_larceny and c_larceny <= 152) => 
         map(
         (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.9051541561) => -0.0239309517,
         (f_add_input_nhood_SFD_pct_d > 0.9051541561) => 0.1490890265,
         (f_add_input_nhood_SFD_pct_d = NULL) => 0.0547712767, 0.0547712767),
      (c_larceny > 152) => 
         map(
         (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 3.5) => 0.0659273328,
         (r_C12_source_profile_index_d > 3.5) => 0.2324744708,
         (r_C12_source_profile_index_d = NULL) => 0.1445745924, 0.1445745924),
      (c_larceny = NULL) => 0.0799628562, 0.0799628562),
   (c_cpiall > 208.5) => 0.0096384274,
   (c_cpiall = NULL) => 0.0053395385, 0.0165057184),
(f_corrrisktype_i = NULL) => -0.0127734207, -0.0025204833);

// Tree: 106 
wFDN_FLAPS__lgt_106 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 36.15) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 55.5) => -0.0121367414,
      (k_comb_age_d > 55.5) => 0.0220741012,
      (k_comb_age_d = NULL) => -0.0045832555, -0.0045832555),
   (c_hh3_p > 36.15) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.2186205567,
      (r_Phn_Cell_n > 0.5) => -0.0017443262,
      (r_Phn_Cell_n = NULL) => 0.0978989252, 0.0978989252),
   (c_hh3_p = NULL) => -0.0290136004, -0.0041997448),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_empl and c_blue_empl <= 126.5) => -0.0238996395,
   (c_blue_empl > 126.5) => 0.3406772989,
   (c_blue_empl = NULL) => 0.1734401712, 0.1734401712),
(f_historical_count_d = NULL) => 0.0007747579, -0.0026231199);

// Tree: 107 
wFDN_FLAPS__lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 99.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 163.5) => 0.0121471166,
   (c_span_lang > 163.5) => 0.1801654262,
   (c_span_lang = NULL) => 0.0806468890, 0.0806468890),
(f_attr_arrest_recency_d > 99.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 111.5) => -0.0034554577,
   (f_addrchangecrimediff_i > 111.5) => 0.1000777154,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 51000) => 0.0119691693,
      (r_A49_Curr_AVM_Chg_1yr_i > 51000) => 0.1375530744,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0060815195, 0.0044933665), -0.0013080951),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_femdiv_p and c_femdiv_p <= 4.3) => 0.0680100101,
   (c_femdiv_p > 4.3) => -0.0388623388,
   (c_femdiv_p = NULL) => 0.0145738356, 0.0145738356), -0.0003367313);

// Tree: 108 
wFDN_FLAPS__lgt_108 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => -0.0012862018,
   (f_srchaddrsrchcountmo_i > 0.5) => 0.0399535774,
   (f_srchaddrsrchcountmo_i = NULL) => 0.0010143300, 0.0010143300),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_retired and c_retired <= 15.9) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 9.5) => 0.0154843377,
      (f_rel_under500miles_cnt_d > 9.5) => 0.1511709453,
      (f_rel_under500miles_cnt_d = NULL) => 0.0918080545, 0.0918080545),
   (c_retired > 15.9) => -0.0432750451,
   (c_retired = NULL) => 0.0506958068, 0.0506958068),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 74.5) => -0.0873367573,
   (c_assault > 74.5) => 0.0257648717,
   (c_assault = NULL) => -0.0297387055, -0.0297387055), 0.0014649394);

// Tree: 109 
wFDN_FLAPS__lgt_109 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 21.5) => 0.0072864048,
   (f_srchssnsrchcount_i > 21.5) => 0.1003978457,
   (f_srchssnsrchcount_i = NULL) => 0.0076954315, 0.0076954315),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 21.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.0021128114,
      (f_srchvelocityrisktype_i > 2.5) => -0.1372999668,
      (f_srchvelocityrisktype_i = NULL) => -0.0855681812, -0.0855681812),
   (f_mos_inq_banko_cm_lseen_d > 21.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 20.5) => 0.0714788819,
      (f_prevaddrlenofres_d > 20.5) => -0.0370037463,
      (f_prevaddrlenofres_d = NULL) => -0.0045873397, -0.0045873397),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0304946914, -0.0304946914),
(r_D33_eviction_count_i = NULL) => 0.0220419569, 0.0063382483);

// Tree: 110 
wFDN_FLAPS__lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 103.5) => -0.0086315280,
(f_prevaddrageoldest_d > 103.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 12.5) => 0.0008154775,
   (r_P88_Phn_Dst_to_Inp_Add_i > 12.5) => 0.0513306446,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 69375) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 242.5) => 0.1372497068,
         (f_M_Bureau_ADL_FS_all_d > 242.5) => 0.0178770595,
         (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0544550135, 0.0544550135),
      (r_A49_Curr_AVM_Chg_1yr_i > 69375) => 0.2217529470,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 11.55) => -0.0204095470,
         (C_INC_35K_P > 11.55) => 0.1264203793,
         (C_INC_35K_P = NULL) => 0.0289485356, 0.0289485356), 0.0556549106), 0.0155627007),
(f_prevaddrageoldest_d = NULL) => -0.0313366164, -0.0001696121);

// Tree: 111 
wFDN_FLAPS__lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 36.5) => 0.1157105820,
(f_mos_liens_unrel_SC_fseen_d > 36.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.4) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 0.5) => 0.1047567613,
         (f_rel_under100miles_cnt_d > 0.5) => 
            map(
            (NULL < c_rest_indx and c_rest_indx <= 113.5) => 0.0463358478,
            (c_rest_indx > 113.5) => -0.0274679757,
            (c_rest_indx = NULL) => 0.0593160969, 0.0161555713),
         (f_rel_under100miles_cnt_d = NULL) => 0.0217347816, 0.0217347816),
      (r_C12_source_profile_d > 81.4) => 0.1682892548,
      (r_C12_source_profile_d = NULL) => 0.0308243963, 0.0308243963),
   (f_corrssnaddrcount_d > 2.5) => -0.0002752936,
   (f_corrssnaddrcount_d = NULL) => 0.0026546940, 0.0026546940),
(f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0329321324, 0.0031355175);

// Tree: 112 
wFDN_FLAPS__lgt_112 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_adl_util_inf_n and f_adl_util_inf_n <= 0.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0072220794) => 0.0844196184,
      (f_add_input_nhood_MFD_pct_i > 0.0072220794) => 0.0057193558,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0041037434, 0.0106535099),
   (f_adl_util_inf_n > 0.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 51930.5) => 0.2116545199,
      (f_prevaddrmedianincome_d > 51930.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.1026225475,
         (f_util_adl_count_n > 4.5) => 0.1357201985,
         (f_util_adl_count_n = NULL) => 0.0073817968, 0.0073817968),
      (f_prevaddrmedianincome_d = NULL) => 0.0817637123, 0.0817637123),
   (f_adl_util_inf_n = NULL) => 0.0126814512, 0.0126814512),
(f_phone_ver_insurance_d > 3.5) => -0.0151836700,
(f_phone_ver_insurance_d = NULL) => 0.0272769880, -0.0006356719);

// Tree: 113 
wFDN_FLAPS__lgt_113 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33176) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 9.25) => 
         map(
         (NULL < c_robbery and c_robbery <= 165.5) => 
            map(
            (NULL < c_highinc and c_highinc <= 0.45) => -0.0740040587,
            (c_highinc > 0.45) => 0.0534916743,
            (c_highinc = NULL) => 0.0395171758, 0.0395171758),
         (c_robbery > 165.5) => -0.0482081806,
         (c_robbery = NULL) => 0.0147326334, 0.0147326334),
      (c_femdiv_p > 9.25) => 0.1269749825,
      (c_femdiv_p = NULL) => 0.0063124182, 0.0259038940),
   (f_curraddrmedianincome_d > 33176) => -0.0040683068,
   (f_curraddrmedianincome_d = NULL) => 0.0266559559, -0.0004495106),
(r_L77_Add_PO_Box_i > 0.5) => -0.1015659210,
(r_L77_Add_PO_Box_i = NULL) => -0.0026814850, -0.0026814850);

// Tree: 114 
wFDN_FLAPS__lgt_114 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 10.2) => -0.1097596053,
   (c_pop_45_54_p > 10.2) => 
      map(
      (NULL < f_inputaddractivephonelist_d and f_inputaddractivephonelist_d <= 0.5) => 0.0239102804,
      (f_inputaddractivephonelist_d > 0.5) => -0.0849579007,
      (f_inputaddractivephonelist_d = NULL) => -0.0175957136, -0.0175957136),
   (c_pop_45_54_p = NULL) => -0.0464710960, -0.0464710960),
(nf_vf_hi_risk_index > 3.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00532387285) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.1736429945,
      (f_hh_members_ct_d > 1.5) => 0.0207673388,
      (f_hh_members_ct_d = NULL) => 0.0409041859, 0.0409041859),
   (f_add_input_nhood_MFD_pct_i > 0.00532387285) => -0.0096327181,
   (f_add_input_nhood_MFD_pct_i = NULL) => 0.0009910318, -0.0045608772),
(nf_vf_hi_risk_index = NULL) => 0.0006479520, -0.0052921291);

// Tree: 115 
wFDN_FLAPS__lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13229074905) => -0.0084340482,
   (f_add_curr_nhood_BUS_pct_i > 0.13229074905) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0048540274,
      (c_easiqlife > 132.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01879119585) => 
            map(
            (NULL < c_hval_500k_p and c_hval_500k_p <= 0.65) => 0.3209220923,
            (c_hval_500k_p > 0.65) => 0.0794010525,
            (c_hval_500k_p = NULL) => 0.1426028199, 0.1426028199),
         (f_add_input_nhood_VAC_pct_i > 0.01879119585) => 0.0383096087,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0760101952, 0.0760101952),
      (c_easiqlife = NULL) => 0.0283210383, 0.0283210383),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0095934050, -0.0041841949),
(c_pop_0_5_p > 21.15) => 0.1718372831,
(c_pop_0_5_p = NULL) => 0.0167425476, -0.0029142380);

// Tree: 116 
wFDN_FLAPS__lgt_116 := map(
(NULL < C_OWNOCC_P and C_OWNOCC_P <= 1.45) => -0.0916690018,
(C_OWNOCC_P > 1.45) => 
   map(
   (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
      map(
      (NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 71.5) => -0.1238667739,
      (f_mos_liens_rel_SC_lseen_d > 71.5) => -0.0009626811,
      (f_mos_liens_rel_SC_lseen_d = NULL) => 
         map(
         (NULL < c_robbery and c_robbery <= 86) => 0.0702691517,
         (c_robbery > 86) => -0.0522156515,
         (c_robbery = NULL) => 0.0084321637, 0.0084321637), -0.0013908597),
   (f_adls_per_phone_c6_i > 1.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.22459745345) => -0.0546857594,
      (f_add_input_mobility_index_i > 0.22459745345) => 0.2130314509,
      (f_add_input_mobility_index_i = NULL) => 0.0920293219, 0.0920293219),
   (f_adls_per_phone_c6_i = NULL) => -0.0000431238, -0.0000431238),
(C_OWNOCC_P = NULL) => 0.0145063903, -0.0008382410);

// Tree: 117 
wFDN_FLAPS__lgt_117 := map(
(NULL < c_hh3_p and c_hh3_p <= 24.05) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 3.5) => -0.0561145224,
   (f_mos_inq_banko_om_lseen_d > 3.5) => -0.0003000165,
   (f_mos_inq_banko_om_lseen_d = NULL) => -0.0208723455, -0.0029722100),
(c_hh3_p > 24.05) => 
   map(
   (NULL < c_young and c_young <= 27.85) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 47595.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 9.15) => 0.1779085692,
         (c_newhouse > 9.15) => 0.0168620494,
         (c_newhouse = NULL) => 0.1045865765, 0.1045865765),
      (f_curraddrmedianincome_d > 47595.5) => 0.0353842638,
      (f_curraddrmedianincome_d = NULL) => 0.0497019837, 0.0497019837),
   (c_young > 27.85) => -0.0235789743,
   (c_young = NULL) => 0.0304889009, 0.0304889009),
(c_hh3_p = NULL) => 0.0082638348, 0.0015482165);

// Tree: 118 
wFDN_FLAPS__lgt_118 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
   map(
   (NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 191.5) => -0.0886044349,
   (f_mos_liens_unrel_FT_fseen_d > 191.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => -0.0054799495,
         (C_INC_25K_P > 27.65) => 0.0995888266,
         (C_INC_25K_P = NULL) => -0.0035810595, -0.0047554744),
      (k_comb_age_d > 84.5) => 0.0935793934,
      (k_comb_age_d = NULL) => -0.0041245083, -0.0041245083),
   (f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0050606115, -0.0050606115),
(f_inq_Communications_count_i > 3.5) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 3.5) => 0.0027363625,
   (c_hval_175k_p > 3.5) => 0.1318674964,
   (c_hval_175k_p = NULL) => 0.0690789634, 0.0690789634),
(f_inq_Communications_count_i = NULL) => -0.0148449799, -0.0045110298);

// Tree: 119 
wFDN_FLAPS__lgt_119 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0716308260,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 101.5) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => -0.0544996236,
         (f_srchfraudsrchcount_i > 4.5) => -0.1360886994,
         (f_srchfraudsrchcount_i = NULL) => -0.0666149388, -0.0666149388),
      (c_medi_indx > 101.5) => -0.0139217879,
      (c_medi_indx = NULL) => -0.0419944060, -0.0419944060),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 0.0062313664,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0030100600, 0.0030100600),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0312505478,
   (c_rich_nfam > 124) => -0.0814277888,
   (c_rich_nfam = NULL) => -0.0236683053, -0.0236683053), 0.0039589173);

// Tree: 120 
wFDN_FLAPS__lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1920.5) => -0.0065712663,
(c_popover18 > 1920.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 22.75) => 0.0017475216,
      (c_hval_150k_p > 22.75) => 0.1628766605,
      (c_hval_150k_p = NULL) => 0.0120011941, 0.0120011941),
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 3.35) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 11.25) => -0.0353104753,
         (c_famotf18_p > 11.25) => 0.1306650436,
         (c_famotf18_p = NULL) => 0.0363864325, 0.0363864325),
      (c_hval_60k_p > 3.35) => 0.2589730299,
      (c_hval_60k_p = NULL) => 0.0714645496, 0.0714645496),
   (f_rel_felony_count_i = NULL) => 0.0209117613, 0.0209117613),
(c_popover18 = NULL) => -0.0260422073, -0.0019126688);

// Tree: 121 
wFDN_FLAPS__lgt_121 := map(
(NULL < nf_vf_lexid_hi_summary and nf_vf_lexid_hi_summary <= 5.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0013530861,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 69.25) => 
         map(
         (NULL < c_fammar_p and c_fammar_p <= 42.85) => -0.0110250290,
         (c_fammar_p > 42.85) => 0.1943801284,
         (c_fammar_p = NULL) => 0.1147567808, 0.1147567808),
      (c_fammar_p > 69.25) => -0.0298565996,
      (c_fammar_p = NULL) => 0.0553791014, 0.0553791014),
   (f_curraddrcrimeindex_i = NULL) => 0.0000414430, 0.0000414430),
(nf_vf_lexid_hi_summary > 5.5) => -0.0624333439,
(nf_vf_lexid_hi_summary = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 100) => 0.0786205825,
   (c_robbery > 100) => -0.0303656270,
   (c_robbery = NULL) => 0.0206279206, 0.0206279206), -0.0005697884);

// Tree: 122 
wFDN_FLAPS__lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0032017183,
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.1273327211,
      (r_S66_adlperssn_count_i > 1.5) => -0.0219206570,
      (r_S66_adlperssn_count_i = NULL) => 0.0671858374, 0.0671858374),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => -0.0154866257, -0.0021765954),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_hval_1001k_p and c_hval_1001k_p <= 1.95) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 9.5) => -0.0333238589,
      (f_rel_under500miles_cnt_d > 9.5) => 0.1133310715,
      (f_rel_under500miles_cnt_d = NULL) => 0.0213463223, 0.0213463223),
   (c_hval_1001k_p > 1.95) => 0.2361095000,
   (c_hval_1001k_p = NULL) => 0.0707608587, 0.0707608587),
(r_P85_Phn_Disconnected_i = NULL) => -0.0008081197, -0.0008081197);

// Tree: 123 
wFDN_FLAPS__lgt_123 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 1.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0010677133,
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 180.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -3.5) => 0.1173376190,
         (f_addrchangecrimediff_i > -3.5) => 0.0112864291,
         (f_addrchangecrimediff_i = NULL) => 0.0404352452, 0.0231072413),
      (c_born_usa > 180.5) => 0.1573015835,
      (c_born_usa = NULL) => 0.0300206573, 0.0300206573),
   (f_inq_Communications_count_i = NULL) => 0.0036577605, 0.0036577605),
(f_vf_AltLexID_addr_hi_risk_ct_i > 1.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 120.5) => -0.0833872569,
   (c_exp_prod > 120.5) => 0.0415269816,
   (c_exp_prod = NULL) => -0.0466892886, -0.0466892886),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 0.0175429628, 0.0030666186);

// Tree: 124 
wFDN_FLAPS__lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.65) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 685435.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 452) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 101.5) => 
            map(
            (NULL < nf_vf_level and nf_vf_level <= 5.5) => -0.0036204489,
            (nf_vf_level > 5.5) => -0.0793927593,
            (nf_vf_level = NULL) => -0.0054966863, -0.0054966863),
         (c_ab_av_edu > 101.5) => 0.0228250768,
         (c_ab_av_edu = NULL) => 0.0065178048, 0.0065178048),
      (r_C13_Curr_Addr_LRes_d > 452) => 0.1574041787,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0077767941, 0.0077767941),
   (f_prevaddrmedianvalue_d > 685435.5) => 0.1385845978,
   (f_prevaddrmedianvalue_d = NULL) => 0.0156983593, 0.0092639180),
(c_high_ed > 42.65) => -0.0269483081,
(c_high_ed = NULL) => -0.0315094642, -0.0018980923);

// Tree: 125 
wFDN_FLAPS__lgt_125 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 16.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0024734957,
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.9) => 
         map(
         (NULL < f_adl_util_conv_n and f_adl_util_conv_n <= 0.5) => -0.0547151844,
         (f_adl_util_conv_n > 0.5) => 0.1401117127,
         (f_adl_util_conv_n = NULL) => 0.0263328048, 0.0263328048),
      (c_pop_55_64_p > 11.9) => 0.2176355138,
      (c_pop_55_64_p = NULL) => 0.0832937238, 0.0832937238),
   (f_nae_nothing_found_i = NULL) => -0.0012382501, -0.0012382501),
(f_inq_count24_i > 16.5) => -0.1111953157,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2611569633) => -0.0514539063,
   (f_add_input_mobility_index_i > 0.2611569633) => 0.0683237290,
   (f_add_input_mobility_index_i = NULL) => 0.0089649009, 0.0089649009), -0.0017698659);

// Tree: 126 
wFDN_FLAPS__lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 3.5) => -0.0573221080,
      (f_mos_inq_banko_cm_lseen_d > 3.5) => 0.0042755061,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0027120895, 0.0027120895),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 10) => 
         map(
         (NULL < c_pop_85p_p and c_pop_85p_p <= 0.85) => 0.0684030669,
         (c_pop_85p_p > 0.85) => -0.0843655186,
         (c_pop_85p_p = NULL) => -0.0037376540, -0.0037376540),
      (c_highrent > 10) => 0.1503166788,
      (c_highrent = NULL) => 0.0456759999, 0.0456759999),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0046422822, 0.0032063500),
(r_L72_Add_Vacant_i > 0.5) => 0.1035140592,
(r_L72_Add_Vacant_i = NULL) => 0.0038945268, 0.0038945268);

// Tree: 127 
wFDN_FLAPS__lgt_127 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => -0.0044294383,
      (f_prevaddroccupantowned_i > 0.5) => 
         map(
         (NULL < c_old_homes and c_old_homes <= 143.5) => 0.0086362619,
         (c_old_homes > 143.5) => 0.1009941508,
         (c_old_homes = NULL) => 0.0316726548, 0.0316726548),
      (f_prevaddroccupantowned_i = NULL) => -0.0018870783, -0.0018870783),
   (k_inq_adls_per_phone_i > 2.5) => -0.0774291162,
   (k_inq_adls_per_phone_i = NULL) => -0.0024729096, -0.0024729096),
(f_assocsuspicousidcount_i > 16.5) => 0.0962830419,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0812595735,
   (r_S66_adlperssn_count_i > 1.5) => 0.0470530390,
   (r_S66_adlperssn_count_i = NULL) => -0.0092244226, -0.0092244226), -0.0020431144);

// Tree: 128 
wFDN_FLAPS__lgt_128 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 3.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 8.5) => 0.1552585186,
   (f_mos_inq_banko_om_lseen_d > 8.5) => 0.0220198575,
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0295659186, 0.0295659186),
(f_prevaddrlenofres_d > 3.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 47.5) => -0.0193310152,
   (r_C13_Curr_Addr_LRes_d > 47.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 870) => 0.0001827431,
      (r_P88_Phn_Dst_to_Inp_Add_i > 870) => 0.1408553433,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0623162351,
         (f_phone_ver_experian_d > 0.5) => -0.0223908231,
         (f_phone_ver_experian_d = NULL) => 0.0142245546, 0.0280388130), 0.0076151454),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0030734194, -0.0030734194),
(f_prevaddrlenofres_d = NULL) => 0.0208091392, 0.0001813842);

// Tree: 129 
wFDN_FLAPS__lgt_129 := map(
(NULL < c_hhsize and c_hhsize <= 4.005) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 13.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 196.5) => 0.0028886091,
         (c_bel_edu > 196.5) => -0.1227393985,
         (c_bel_edu = NULL) => 0.0020675111, 0.0020675111),
      (r_L79_adls_per_addr_curr_i > 13.5) => 0.1118949436,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0034884499, 0.0027865046),
   (c_pop_18_24_p > 11.15) => -0.0276824480,
   (c_pop_18_24_p = NULL) => -0.0040246139, -0.0040246139),
(c_hhsize > 4.005) => 
   map(
   (NULL < c_med_age and c_med_age <= 26.65) => 0.2206428957,
   (c_med_age > 26.65) => 0.0008041303,
   (c_med_age = NULL) => 0.0740837188, 0.0740837188),
(c_hhsize = NULL) => 0.0183507444, -0.0022842314);

// Tree: 130 
wFDN_FLAPS__lgt_130 := map(
(NULL < c_lar_fam and c_lar_fam <= 181.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 12.45) => -0.0900819710,
   (c_white_col > 12.45) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 3503) => -0.0090728742,
      (f_addrchangeincomediff_d > 3503) => 0.0329587560,
      (f_addrchangeincomediff_d = NULL) => 
         map(
         (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 3.5) => -0.0106597674,
         (f_bus_addr_match_count_d > 3.5) => 0.0904785961,
         (f_bus_addr_match_count_d = NULL) => 0.0021484887, 0.0021484887), -0.0049672566),
   (c_white_col = NULL) => -0.0055715474, -0.0055715474),
(c_lar_fam > 181.5) => 
   map(
   (NULL < C_INC_15K_P and C_INC_15K_P <= 7.65) => -0.0563531319,
   (C_INC_15K_P > 7.65) => 0.1560589694,
   (C_INC_15K_P = NULL) => 0.0723814750, 0.0723814750),
(c_lar_fam = NULL) => 0.0285931130, -0.0039550687);

// Tree: 131 
wFDN_FLAPS__lgt_131 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 813323.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 0.0005271783,
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0758517071,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0002185019, 0.0002185019),
(f_prevaddrmedianvalue_d > 813323.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 7.65) => 
      map(
      (NULL < c_rich_asian and c_rich_asian <= 178.5) => 0.0709103209,
      (c_rich_asian > 178.5) => 0.3302868194,
      (c_rich_asian = NULL) => 0.1794865296, 0.1794865296),
   (c_pop_0_5_p > 7.65) => -0.0532567307,
   (c_pop_0_5_p = NULL) => 0.1039363613, 0.1039363613),
(f_prevaddrmedianvalue_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.35) => -0.0497519926,
   (c_hh4_p > 11.35) => 0.0474342778,
   (c_hh4_p = NULL) => 0.0001087896, 0.0001087896), 0.0017791425);

// Tree: 132 
wFDN_FLAPS__lgt_132 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 213.25) => -0.0032246816,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 213.25) => 0.2184304886,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0100670569,
   (f_phones_per_addr_curr_i > 4.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -86580) => 0.1005592452,
      (f_addrchangevaluediff_d > -86580) => 0.0067250825,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1142708007) => 
            map(
            (NULL < c_cpiall and c_cpiall <= 218.4) => -0.0016927964,
            (c_cpiall > 218.4) => 0.1087668434,
            (c_cpiall = NULL) => 0.0260330168, 0.0260330168),
         (f_add_curr_nhood_VAC_pct_i > 0.1142708007) => 0.2309654215,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0486073265, 0.0486073265), 0.0196454541),
   (f_phones_per_addr_curr_i = NULL) => 0.0033458408, 0.0000391614), -0.0005479050);

// Tree: 133 
wFDN_FLAPS__lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 87.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 60.4) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 4.5) => 0.2275577615,
      (c_hval_200k_p > 4.5) => 0.0473735474,
      (c_hval_200k_p = NULL) => 0.1383576555, 0.1383576555),
   (r_C12_source_profile_d > 60.4) => -0.0097089871,
   (r_C12_source_profile_d = NULL) => 0.0599296622, 0.0599296622),
(f_mos_liens_unrel_SC_fseen_d > 87.5) => 
   map(
   (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 14.5) => -0.0125218279,
      (f_phones_per_addr_curr_i > 14.5) => 0.1312908478,
      (f_phones_per_addr_curr_i = NULL) => -0.0113648947, -0.0113648947),
   (f_bus_name_nover_i > 0.5) => 0.0169603958,
   (f_bus_name_nover_i = NULL) => 0.0001286278, 0.0001286278),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 0.0027331329, 0.0011865218);

// Tree: 134 
wFDN_FLAPS__lgt_134 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 44.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0019807668,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -13.5) => -0.0791284215,
      (f_addrchangecrimediff_i > -13.5) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 11.7) => 0.0469681600,
         (c_pop_6_11_p > 11.7) => 0.2628126797,
         (c_pop_6_11_p = NULL) => 0.0641951874, 0.0641951874),
      (f_addrchangecrimediff_i = NULL) => 0.0258802058, 0.0410229482),
   (r_L70_Add_Standardized_i = NULL) => 0.0017283643, 0.0017283643),
(f_rel_count_i > 44.5) => -0.0693595623,
(f_rel_count_i = NULL) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 92.85) => 0.0556217348,
   (c_occunit_p > 92.85) => -0.0522370133,
   (c_occunit_p = NULL) => -0.0060118355, -0.0060118355), 0.0007118238);

// Tree: 135 
wFDN_FLAPS__lgt_135 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0041721998,
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < c_rest_indx and c_rest_indx <= 59.5) => 0.1324747039,
   (c_rest_indx > 59.5) => 
      map(
      (NULL < c_hval_175k_p and c_hval_175k_p <= 11.15) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0605456790,
         (r_C23_inp_addr_occ_index_d > 2) => 0.0754296604,
         (r_C23_inp_addr_occ_index_d = NULL) => -0.0189587195, -0.0189587195),
      (c_hval_175k_p > 11.15) => 0.1122877793,
      (c_hval_175k_p = NULL) => 0.0135985515, 0.0135985515),
   (c_rest_indx = NULL) => 0.0320269507, 0.0320269507),
(f_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.5) => -0.0459470799,
   (c_pop_35_44_p > 15.5) => 0.0647070275,
   (c_pop_35_44_p = NULL) => 0.0060122401, 0.0060122401), -0.0027428206);

// Tree: 136 
wFDN_FLAPS__lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 7.25) => 0.0197702063,
   (c_hh7p_p > 7.25) => 0.1476938745,
   (c_hh7p_p = NULL) => 0.0819214115, 0.0265216046),
(f_hh_members_ct_d > 1.5) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0238490036,
      (f_rel_homeover500_count_d > 14.5) => 0.1728907344,
      (f_rel_homeover500_count_d = NULL) => -0.0222027712, -0.0222027712),
   (f_hh_criminals_i > 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 0.0077408297,
      (k_inq_per_addr_i > 6.5) => 0.0670985212,
      (k_inq_per_addr_i = NULL) => 0.0107581790, 0.0107581790),
   (f_hh_criminals_i = NULL) => -0.0105489290, -0.0105489290),
(f_hh_members_ct_d = NULL) => -0.0084361666, -0.0035014996);

// Tree: 137 
wFDN_FLAPS__lgt_137 := map(
(NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 2.5) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 7.85) => -0.0419421577,
   (c_sfdu_p > 7.85) => 0.0026136955,
   (c_sfdu_p = NULL) => 0.0199212504, 0.0007768238),
(f_inq_HighRiskCredit_count24_i > 2.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 15.25) => -0.1173188955,
   (C_INC_75K_P > 15.25) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 100.5) => -0.0739972789,
      (c_blue_empl > 100.5) => 0.0572735461,
      (c_blue_empl = NULL) => -0.0029671750, -0.0029671750),
   (C_INC_75K_P = NULL) => -0.0370527840, -0.0370527840),
(f_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 0.1) => -0.0626181930,
   (c_hval_80k_p > 0.1) => 0.0402823795,
   (c_hval_80k_p = NULL) => -0.0152657171, -0.0152657171), 0.0000005104);

// Tree: 138 
wFDN_FLAPS__lgt_138 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 75.45) => 0.0020778755,
   (c_low_ed > 75.45) => -0.0442816852,
   (c_low_ed = NULL) => -0.0236340970, -0.0000256059),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < f_vardobcountnew_i and f_vardobcountnew_i <= 0.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.35) => 0.1197243361,
      (C_INC_200K_P > 0.35) => -0.0329977907,
      (C_INC_200K_P = NULL) => 0.0057105824, 0.0057105824),
   (f_vardobcountnew_i > 0.5) => 0.1551741671,
   (f_vardobcountnew_i = NULL) => 0.0491032360, 0.0491032360),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_robbery and c_robbery <= 100) => 0.0312636810,
   (c_robbery > 100) => -0.0677973361,
   (c_robbery = NULL) => -0.0177764265, -0.0177764265), 0.0010252891);

// Tree: 139 
wFDN_FLAPS__lgt_139 := map(
(NULL < c_incollege and c_incollege <= 15.05) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.6203628135) => 0.1375580527,
      (f_add_curr_nhood_SFD_pct_d > 0.6203628135) => -0.0018108946,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0596983056, 0.0596983056),
   (r_C21_M_Bureau_ADL_FS_d > 6.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 8.5) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 4.15) => -0.0082833228,
         (C_INC_200K_P > 4.15) => 0.1862129779,
         (C_INC_200K_P = NULL) => 0.0786423982, 0.0786423982),
      (r_D32_Mos_Since_Crim_LS_d > 8.5) => -0.0008261208,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0004238673, 0.0004238673),
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0033674378, 0.0013608728),
(c_incollege > 15.05) => -0.0515246218,
(c_incollege = NULL) => -0.0301008129, -0.0024020752);

// Tree: 140 
wFDN_FLAPS__lgt_140 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.45) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00863938945) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.2952305822,
         (r_Phn_Cell_n > 0.5) => 0.0134692358,
         (r_Phn_Cell_n = NULL) => 0.1475331022, 0.1475331022),
      (f_add_input_nhood_MFD_pct_i > 0.00863938945) => 
         map(
         (NULL < c_hh1_p and c_hh1_p <= 13.05) => 0.1115238013,
         (c_hh1_p > 13.05) => 0.0099298637,
         (c_hh1_p = NULL) => 0.0173343522, 0.0173343522),
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0194542368, 0.0246918629),
   (f_hh_members_ct_d > 1.5) => -0.0036017360,
   (f_hh_members_ct_d = NULL) => -0.0106312315, 0.0015765633),
(c_hval_80k_p > 41.45) => -0.0969570905,
(c_hval_80k_p = NULL) => -0.0256298014, 0.0001462150);

// Tree: 141 
wFDN_FLAPS__lgt_141 := map(
(NULL < c_cpiall and c_cpiall <= 208.9) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.25) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 49419.5) => 0.1754537880,
      (f_prevaddrmedianvalue_d > 49419.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 194.5) => 0.0001416804,
         (c_new_homes > 194.5) => 0.1242980474,
         (c_new_homes = NULL) => 0.0100948334, 0.0100948334),
      (f_prevaddrmedianvalue_d = NULL) => 0.0151403282, 0.0151403282),
   (c_unemp > 11.25) => 0.1336724449,
   (c_unemp = NULL) => 0.0185588918, 0.0185588918),
(c_cpiall > 208.9) => 
   map(
   (NULL < nf_vf_hi_summary and nf_vf_hi_summary <= 5.5) => -0.0055825771,
   (nf_vf_hi_summary > 5.5) => -0.0765608690,
   (nf_vf_hi_summary = NULL) => -0.0123267482, -0.0066465588),
(c_cpiall = NULL) => -0.0271919289, -0.0035530842);

// Tree: 142 
wFDN_FLAPS__lgt_142 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 1.5) => 0.1295086408,
      (f_phone_ver_insurance_d > 1.5) => -0.0038773490,
      (f_phone_ver_insurance_d = NULL) => 0.0615079401, 0.0615079401),
   (r_C13_max_lres_d > 17.5) => 0.0010858024,
   (r_C13_max_lres_d = NULL) => 0.0018546469, 0.0018546469),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => -0.0984050633,
   (nf_vf_hi_risk_index > 5.5) => -0.0263582941,
   (nf_vf_hi_risk_index = NULL) => -0.0428413188, -0.0428413188),
(r_C16_Inv_SSN_Per_ADL_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 5.65) => -0.0411329830,
   (c_hval_250k_p > 5.65) => 0.0621372430,
   (c_hval_250k_p = NULL) => 0.0087216089, 0.0087216089), 0.0000093143);

// Tree: 143 
wFDN_FLAPS__lgt_143 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 9.55) => -0.0943859558,
      (c_newhouse > 9.55) => 
         map(
         (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0386552737,
         (f_curraddractivephonelist_d > 0.5) => -0.0696416206,
         (f_curraddractivephonelist_d = NULL) => -0.0097933369, -0.0097933369),
      (c_newhouse = NULL) => -0.0456306040, -0.0456306040),
   (nf_vf_hi_risk_index > 3.5) => 0.0010315162,
   (nf_vf_hi_risk_index = NULL) => 0.0002567461, 0.0002567461),
(f_inq_QuizProvider_count_i > 6.5) => 0.0992427479,
(f_inq_QuizProvider_count_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1281) => 0.0510810699,
   (c_popover18 > 1281) => -0.0628835532,
   (c_popover18 = NULL) => -0.0078328454, -0.0078328454), 0.0009196275);

// Tree: 144 
wFDN_FLAPS__lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 11.5) => -0.0044387130,
   (f_srchssnsrchcount_i > 11.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 23) => 0.0008531806,
      (c_rnt1000_p > 23) => 0.1297954510,
      (c_rnt1000_p = NULL) => 0.0440625585, 0.0440625585),
   (f_srchssnsrchcount_i = NULL) => -0.0148138255, -0.0037768864),
(c_rnt2001_p > 49) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0226955466,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 9.45) => 0.0179802212,
      (c_pop_12_17_p > 9.45) => 0.3700050730,
      (c_pop_12_17_p = NULL) => 0.1697150711, 0.1697150711),
   (k_inf_nothing_found_i = NULL) => 0.0789802491, 0.0789802491),
(c_rnt2001_p = NULL) => 0.0112193827, -0.0014667280);

// Tree: 145 
wFDN_FLAPS__lgt_145 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0065461028,
(k_comb_age_d > 56.5) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 250.95) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0115492483,
      (k_inq_per_addr_i > 3.5) => 0.0796503886,
      (k_inq_per_addr_i = NULL) => 0.0162417822, 0.0162417822),
   (c_housingcpi > 250.95) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 377.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 73.2) => 0.0412557668,
         (r_C12_source_profile_d > 73.2) => 0.3866258834,
         (r_C12_source_profile_d = NULL) => 0.2204572424, 0.2204572424),
      (f_M_Bureau_ADL_FS_all_d > 377.5) => -0.0546008809,
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.1073777917, 0.1073777917),
   (c_housingcpi = NULL) => 0.0228859980, 0.0228754796),
(k_comb_age_d = NULL) => -0.0059927321, -0.0006613647);

// Tree: 146 
wFDN_FLAPS__lgt_146 := map(
(NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => -0.0055246615,
   (f_curraddrcrimeindex_i > 189) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 208.95) => 0.1837048095,
      (c_housingcpi > 208.95) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 12.75) => -0.0301770828,
         (c_pop_55_64_p > 12.75) => 0.1902848230,
         (c_pop_55_64_p = NULL) => 0.0468616501, 0.0468616501),
      (c_housingcpi = NULL) => 0.0683104211, 0.0683104211),
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0487116914,
      (c_high_hval > 3.7) => 0.0700946688,
      (c_high_hval = NULL) => 0.0123264386, 0.0123264386), -0.0034841696),
(r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1018406697,
(r_L71_Add_HiRisk_Comm_i = NULL) => -0.0027285874, -0.0027285874);

// Tree: 147 
wFDN_FLAPS__lgt_147 := map(
(NULL < f_prevaddrcartheftindex_i and f_prevaddrcartheftindex_i <= 194.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 17.65) => 
         map(
         (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 90) => -0.0281875387,
         (r_A50_pb_average_dollars_d > 90) => 0.0678691264,
         (r_A50_pb_average_dollars_d = NULL) => 0.0314781810, 0.0314781810),
      (c_hh2_p > 17.65) => -0.0005067976,
      (c_hh2_p = NULL) => -0.0416682822, 0.0005551743),
   (k_inq_adls_per_phone_i > 2.5) => -0.0662965196,
   (k_inq_adls_per_phone_i = NULL) => 0.0000145654, 0.0000145654),
(f_prevaddrcartheftindex_i > 194.5) => -0.0768432302,
(f_prevaddrcartheftindex_i = NULL) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 3.35) => -0.0178047255,
   (c_hval_200k_p > 3.35) => 0.0766909900,
   (c_hval_200k_p = NULL) => 0.0224721368, 0.0224721368), -0.0009160826);

// Tree: 148 
wFDN_FLAPS__lgt_148 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0048397901,
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_highinc and c_highinc <= 3.85) => -0.0605214396,
   (c_highinc > 3.85) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 131.5) => 
         map(
         (NULL < c_mil_emp and c_mil_emp <= 0.85) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 41285.5) => 0.1605180420,
            (f_curraddrmedianincome_d > 41285.5) => 0.0665994144,
            (f_curraddrmedianincome_d = NULL) => 0.0804955379, 0.0804955379),
         (c_mil_emp > 0.85) => -0.0539226853,
         (c_mil_emp = NULL) => 0.0647882399, 0.0647882399),
      (c_mort_indx > 131.5) => -0.0610587252,
      (c_mort_indx = NULL) => 0.0398455982, 0.0398455982),
   (c_highinc = NULL) => 0.0247828574, 0.0247828574),
(k_inq_per_phone_i = NULL) => -0.0032985250, -0.0032985250);

// Tree: 149 
wFDN_FLAPS__lgt_149 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 68.5) => -0.1056853498,
   (f_mos_inq_banko_cm_fseen_d > 68.5) => 
      map(
      (NULL < C_RENTOCC_P and C_RENTOCC_P <= 60.85) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 138.5) => -0.0137348807,
         (f_curraddrcartheftindex_i > 138.5) => 0.0938630284,
         (f_curraddrcartheftindex_i = NULL) => 0.0187809709, 0.0187809709),
      (C_RENTOCC_P > 60.85) => -0.0943778945,
      (C_RENTOCC_P = NULL) => -0.0116673985, -0.0116673985),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0384161677, -0.0384161677),
(nf_vf_hi_risk_index > 4.5) => 0.0052430484,
(nf_vf_hi_risk_index = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91.5) => 0.0596231180,
   (c_many_cars > 91.5) => -0.0604728714,
   (c_many_cars = NULL) => 0.0006474089, 0.0006474089), 0.0039795466);

// Tree: 150 
wFDN_FLAPS__lgt_150 := map(
(NULL < c_low_hval and c_low_hval <= 10.35) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 27.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 48) => 0.0628572213,
         (r_D33_Eviction_Recency_d > 48) => 0.0026697843,
         (r_D33_Eviction_Recency_d = NULL) => 0.0034737071, 0.0034737071),
      (r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.1085639303,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0028806077, 0.0028806077),
   (f_srchaddrsrchcount_i > 27.5) => 0.0834811389,
   (f_srchaddrsrchcount_i = NULL) => 0.0112348163, 0.0036658052),
(c_low_hval > 10.35) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 55.5) => -0.0198324547,
   (f_addrchangecrimediff_i > 55.5) => 0.0862094570,
   (f_addrchangecrimediff_i = NULL) => -0.0447143005, -0.0234351876),
(c_low_hval = NULL) => 0.0106577948, -0.0017254886);

// Tree: 151 
wFDN_FLAPS__lgt_151 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 10.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 3.5) => 
      map(
      (NULL < nf_altlexid_phone_hi_no_hi_lexid and nf_altlexid_phone_hi_no_hi_lexid <= 0.5) => -0.0019588660,
      (nf_altlexid_phone_hi_no_hi_lexid > 0.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 123) => -0.0218215447,
         (c_cartheft > 123) => 0.1385066440,
         (c_cartheft = NULL) => 0.0491963107, 0.0491963107),
      (nf_altlexid_phone_hi_no_hi_lexid = NULL) => -0.0013384297, -0.0013384297),
   (k_inq_adls_per_phone_i > 3.5) => -0.0916883092,
   (k_inq_adls_per_phone_i = NULL) => -0.0017430030, -0.0017430030),
(r_C14_addrs_10yr_i > 10.5) => 0.1086340675,
(r_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 99.5) => -0.0560401283,
   (c_no_car > 99.5) => 0.0437947289,
   (c_no_car = NULL) => -0.0099625019, -0.0099625019), -0.0013634738);

// Tree: 152 
wFDN_FLAPS__lgt_152 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37763534975) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 15.5) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 153.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 16.75) => 0.0630079367,
         (c_hh4_p > 16.75) => 0.2542587242,
         (c_hh4_p = NULL) => 0.1221218165, 0.1221218165),
      (c_asian_lang > 153.5) => -0.0152525614,
      (c_asian_lang = NULL) => 0.0595552682, 0.0595552682),
   (r_C10_M_Hdr_FS_d > 15.5) => 0.0027314033,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0508307592, 0.0047729062),
(f_add_input_mobility_index_i > 0.37763534975) => 
   map(
   (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 28.5) => -0.0275407466,
   (r_A50_pb_total_orders_d > 28.5) => 0.1716348882,
   (r_A50_pb_total_orders_d = NULL) => -0.0225241961, -0.0225241961),
(f_add_input_mobility_index_i = NULL) => 0.0523609230, 0.0004044091);

// Tree: 153 
wFDN_FLAPS__lgt_153 := map(
(NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 1670.5) => 
   map(
   (NULL < c_hval_60k_p and c_hval_60k_p <= 34.55) => 0.0038779833,
   (c_hval_60k_p > 34.55) => -0.0815441741,
   (c_hval_60k_p = NULL) => -0.0018978542, 0.0030653370),
(f_liens_unrel_CJ_total_amt_i > 1670.5) => 
   map(
   (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 138.5) => 
      map(
      (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 10.5) => 0.0218927989,
      (f_rel_homeover150_count_d > 10.5) => -0.0640985815,
      (f_rel_homeover150_count_d = NULL) => -0.0054177683, -0.0054177683),
   (f_fp_prevaddrburglaryindex_i > 138.5) => -0.1004117761,
   (f_fp_prevaddrburglaryindex_i = NULL) => -0.0265626139, -0.0265626139),
(f_liens_unrel_CJ_total_amt_i = NULL) => 
   map(
   (NULL < c_unattach and c_unattach <= 97) => 0.0458590311,
   (c_unattach > 97) => -0.0664409962,
   (c_unattach = NULL) => -0.0149272222, -0.0149272222), 0.0014975657);

// Tree: 154 
wFDN_FLAPS__lgt_154 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 5.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 11.05) => -0.0042295923,
   (c_hh6_p > 11.05) => 
      map(
      (NULL < c_transport and c_transport <= 2.9) => 
         map(
         (NULL < c_lowinc and c_lowinc <= 34.15) => -0.0551398180,
         (c_lowinc > 34.15) => 0.0859537401,
         (c_lowinc = NULL) => 0.0033132275, 0.0033132275),
      (c_transport > 2.9) => 0.1893576555,
      (c_transport = NULL) => 0.0343206321, 0.0343206321),
   (c_hh6_p = NULL) => 0.0153616572, -0.0027483944),
(f_dl_addrs_per_adl_i > 5.5) => 0.1083401317,
(f_dl_addrs_per_adl_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 8.35) => -0.0738134655,
   (c_famotf18_p > 8.35) => 0.0333505125,
   (c_famotf18_p = NULL) => -0.0175962967, -0.0175962967), -0.0023038820);

// Tree: 155 
wFDN_FLAPS__lgt_155 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 34701) => 0.0000018362,
(f_addrchangevaluediff_d > 34701) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 1.85) => 0.1252039070,
   (C_INC_200K_P > 1.85) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3344839322) => -0.0208710235,
      (f_add_curr_mobility_index_i > 0.3344839322) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 780) => 0.1417474542,
         (c_hh00 > 780) => -0.0343736584,
         (c_hh00 = NULL) => 0.0553803701, 0.0553803701),
      (f_add_curr_mobility_index_i = NULL) => 0.0044649028, 0.0044649028),
   (C_INC_200K_P = NULL) => 0.0262168383, 0.0262168383),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 80.5) => -0.0531093386,
   (c_span_lang > 80.5) => 0.0040944467,
   (c_span_lang = NULL) => 0.0273107406, -0.0107212603), -0.0016040255);

// Tree: 156 
wFDN_FLAPS__lgt_156 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 1.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 34.65) => -0.0007194475,
   (c_hval_20k_p > 34.65) => 0.1014876307,
   (c_hval_20k_p = NULL) => -0.0107702863, -0.0004314973),
(f_vf_AltLexID_addr_hi_risk_ct_i > 1.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37065572755) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 1.65) => -0.1196894451,
      (c_hh7p_p > 1.65) => -0.0063179669,
      (c_hh7p_p = NULL) => -0.0735310576, -0.0735310576),
   (f_add_input_mobility_index_i > 0.37065572755) => -0.0113839842,
   (f_add_input_mobility_index_i = NULL) => -0.0563210988, -0.0563210988),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 2.15) => -0.0446532398,
   (c_high_hval > 2.15) => 0.0523690622,
   (c_high_hval = NULL) => 0.0034208738, 0.0034208738), -0.0012598369);

// Tree: 157 
wFDN_FLAPS__lgt_157 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21894) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 13.2) => 0.1837157597,
   (c_blue_col > 13.2) => -0.0292986979,
   (c_blue_col = NULL) => 0.0657970421, 0.0657970421),
(r_A46_Curr_AVM_AutoVal_d > 21894) => 0.0057549895,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => -0.0133908410,
   (f_util_adl_count_n > 4.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0155465000,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.0737234897,
      (nf_seg_FraudPoint_3_0 = '') => 0.0331688950, 0.0331688950),
   (f_util_adl_count_n = NULL) => 
      map(
      (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0661900722,
      (k_nap_lname_verd_d > 0.5) => -0.0621456793,
      (k_nap_lname_verd_d = NULL) => -0.0046158597, -0.0046158597), -0.0068991654), 0.0007196864);

// Tree: 158 
wFDN_FLAPS__lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 10.5) => -0.0011963004,
      (f_inq_HighRiskCredit_count24_i > 10.5) => 0.0795380376,
      (f_inq_HighRiskCredit_count24_i = NULL) => -0.0008695730, -0.0008695730),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.0231777311,
      (r_C20_email_count_i > 0.5) => -0.1172530039,
      (r_C20_email_count_i = NULL) => -0.0595417429, -0.0595417429),
   (r_I60_inq_comm_count12_i = NULL) => -0.0015548091, -0.0015548091),
(r_D33_eviction_count_i > 3.5) => 0.0825099422,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 100.5) => 0.0469345527,
   (c_rental > 100.5) => -0.0398147744,
   (c_rental = NULL) => 0.0027094056, 0.0027094056), -0.0010211351);

// Tree: 159 
wFDN_FLAPS__lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => -0.0002871554,
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 2.95) => -0.0278109750,
      (c_rnt1000_p > 2.95) => 0.0943608569,
      (c_rnt1000_p = NULL) => 0.0509037623, 0.0509037623),
   (f_inq_PrepaidCards_count24_i = NULL) => 0.0003424120, 0.0003424120),
(f_rel_homeover500_count_d > 19.5) => 0.1151792739,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.14038461535) => 
      map(
      (NULL < c_burglary and c_burglary <= 94.5) => -0.0659070511,
      (c_burglary > 94.5) => 0.0469990556,
      (c_burglary = NULL) => -0.0199568914, -0.0199568914),
   (f_add_input_nhood_BUS_pct_i > 0.14038461535) => 0.1085606528,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0038128111, 0.0038128111), 0.0009805231);

// Tree: 160 
wFDN_FLAPS__lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 74.6) => -0.0074863845,
(r_C12_source_profile_d > 74.6) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 
      map(
      (NULL < c_pop_65_74_p and c_pop_65_74_p <= 1.05) => 0.1761572244,
      (c_pop_65_74_p > 1.05) => 0.0151522227,
      (c_pop_65_74_p = NULL) => -0.0216873402, 0.0171964795),
   (f_srchaddrsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 3.55) => -0.0178449203,
      (c_unemp > 3.55) => 0.1664761620,
      (c_unemp = NULL) => 0.0955834380, 0.0955834380),
   (f_srchaddrsrchcountmo_i = NULL) => 0.0211527327, 0.0211527327),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 92) => -0.0539183926,
   (c_burglary > 92) => 0.0563608680,
   (c_burglary = NULL) => 0.0022423420, 0.0022423420), -0.0014077864);

// Tree: 161 
wFDN_FLAPS__lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 
      map(
      (NULL < c_mort_indx and c_mort_indx <= 106.5) => -0.0712463188,
      (c_mort_indx > 106.5) => 
         map(
         (NULL < c_incollege and c_incollege <= 8.15) => -0.0134775485,
         (c_incollege > 8.15) => 0.2253816853,
         (c_incollege = NULL) => 0.0465373344, 0.0465373344),
      (c_mort_indx = NULL) => -0.0284745178, -0.0284745178),
   (f_inq_HighRiskCredit_count_i > 1.5) => -0.1075718460,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0374824818, -0.0374824818),
(f_mos_inq_banko_cm_fseen_d > 25.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 4.5) => -0.0043305687,
   (f_hh_tot_derog_i > 4.5) => 0.0354817106,
   (f_hh_tot_derog_i = NULL) => -0.0023936290, -0.0023936290),
(f_mos_inq_banko_cm_fseen_d = NULL) => -0.0045951128, -0.0041844454);

// Tree: 162 
wFDN_FLAPS__lgt_162 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0011341475,
(r_D30_Derog_Count_i > 8.5) => 
   map(
   (NULL < c_rental and c_rental <= 119) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 1469.5) => 0.1664331872,
      (r_A50_pb_total_dollars_d > 1469.5) => 0.0201945519,
      (r_A50_pb_total_dollars_d = NULL) => 0.0947110540, 0.0947110540),
   (c_rental > 119) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 4.65) => 0.0384850150,
      (c_hval_150k_p > 4.65) => -0.0903954838,
      (c_hval_150k_p = NULL) => -0.0288843367, -0.0288843367),
   (c_rental = NULL) => 0.0382591800, 0.0382591800),
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.45) => -0.0386028239,
   (c_pop_55_64_p > 9.45) => 0.0622075130,
   (c_pop_55_64_p = NULL) => 0.0177826188, 0.0177826188), -0.0000470193);

// Tree: 163 
wFDN_FLAPS__lgt_163 := map(
(NULL < C_INC_75K_P and C_INC_75K_P <= 31.55) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0152510813,
   (c_pop_35_44_p > 14.75) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 23.85) => 
         map(
         (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0046439201,
         (r_P85_Phn_Disconnected_i > 0.5) => 0.0846767561,
         (r_P85_Phn_Disconnected_i = NULL) => 0.0062871388, 0.0062871388),
      (C_INC_25K_P > 23.85) => 0.1417256726,
      (C_INC_25K_P = NULL) => 0.0078418317, 0.0078418317),
   (c_pop_35_44_p = NULL) => -0.0038234448, -0.0038234448),
(C_INC_75K_P > 31.55) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.02412548745) => 0.1451661036,
   (f_add_input_nhood_BUS_pct_i > 0.02412548745) => -0.0128110958,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0526751792, 0.0526751792),
(C_INC_75K_P = NULL) => 0.0068040822, -0.0024722810);

// Tree: 164 
wFDN_FLAPS__lgt_164 := map(
(NULL < c_hval_1001k_p and c_hval_1001k_p <= 23.15) => 0.0014145929,
(c_hval_1001k_p > 23.15) => 
   map(
   (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 112115) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 4.45) => 0.3301038828,
      (C_INC_35K_P > 4.45) => 
         map(
         (NULL < c_rich_fam and c_rich_fam <= 160.5) => -0.0428788228,
         (c_rich_fam > 160.5) => 0.1793519228,
         (c_rich_fam = NULL) => 0.0580112090, 0.0580112090),
      (C_INC_35K_P = NULL) => 0.1364309316, 0.1364309316),
   (f_prevaddrmedianincome_d > 112115) => -0.0241078423,
   (f_prevaddrmedianincome_d = NULL) => 0.0558125473, 0.0558125473),
(c_hval_1001k_p = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2067873879) => 0.1372713687,
   (f_add_curr_mobility_index_i > 0.2067873879) => -0.0843578141,
   (f_add_curr_mobility_index_i = NULL) => 0.0655198993, 0.0287762371), 0.0040341909);

// Tree: 165 
wFDN_FLAPS__lgt_165 := map(
(NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 25.05) => 
      map(
      (NULL < f_liens_rel_O_total_amt_i and f_liens_rel_O_total_amt_i <= 29.5) => 
         map(
         (NULL < c_retail and c_retail <= 44.6) => 0.0090307256,
         (c_retail > 44.6) => 
            map(
            (NULL < c_span_lang and c_span_lang <= 124.5) => 0.2012159538,
            (c_span_lang > 124.5) => -0.0125755520,
            (c_span_lang = NULL) => 0.1011965359, 0.1011965359),
         (c_retail = NULL) => 0.0110024951, 0.0110024951),
      (f_liens_rel_O_total_amt_i > 29.5) => -0.1119033167,
      (f_liens_rel_O_total_amt_i = NULL) => 0.0125864911, 0.0097260426),
   (c_pop_55_64_p > 25.05) => 0.1707745446,
   (c_pop_55_64_p = NULL) => 0.0107552178, 0.0111971929),
(k_inf_lname_verd_d > 0.5) => -0.0234861059,
(k_inf_lname_verd_d = NULL) => -0.0002618300, -0.0002618300);

// Tree: 166 
wFDN_FLAPS__lgt_166 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 10698.5) => -0.0016660892,
   (f_addrchangeincomediff_d > 10698.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 34.5) => 0.1409590724,
      (c_born_usa > 34.5) => 0.0087582637,
      (c_born_usa = NULL) => 0.0363479977, 0.0363479977),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0020360269,
      (k_nap_contradictory_i > 0.5) => 0.0978918464,
      (k_nap_contradictory_i = NULL) => 0.0041800164, 0.0041800164), 0.0006508458),
(c_asian_lang > 194.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 0.5) => -0.0696408392,
   (f_inq_Other_count24_i > 0.5) => 0.0682879366,
   (f_inq_Other_count24_i = NULL) => -0.0475927449, -0.0475927449),
(c_asian_lang = NULL) => 0.0124847758, -0.0011795569);

// Tree: 167 
wFDN_FLAPS__lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 194) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.3) => 
         map(
         (NULL < f_corraddrphonecount_d and f_corraddrphonecount_d <= 1.5) => 0.0181737101,
         (f_corraddrphonecount_d > 1.5) => 
            map(
            (NULL < c_exp_prod and c_exp_prod <= 72.5) => 0.2447890006,
            (c_exp_prod > 72.5) => 0.0276547690,
            (c_exp_prod = NULL) => 0.1362218848, 0.1362218848),
         (f_corraddrphonecount_d = NULL) => 0.0349823221, 0.0349823221),
      (r_C12_source_profile_d > 75.3) => 0.1619556147,
      (r_C12_source_profile_d = NULL) => 0.0470630318, 0.0470630318),
   (f_liens_unrel_CJ_total_amt_i > 194) => -0.0769329409,
   (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0380596477, 0.0380596477),
(c_many_cars > 22.5) => -0.0071445815,
(c_many_cars = NULL) => 0.0145792678, -0.0027348319);

// Tree: 168 
wFDN_FLAPS__lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0067444881,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1894.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 13.5) => 0.0082368857,
      (f_corraddrnamecount_d > 13.5) => 0.1958882940,
      (f_corraddrnamecount_d = NULL) => 0.0251982038, 0.0251982038),
   (c_popover18 > 1894.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.55) => 0.0040895066,
      (c_hh6_p > 1.55) => 
         map(
         (NULL < c_unattach and c_unattach <= 89.5) => 0.1087375794,
         (c_unattach > 89.5) => 0.3070257163,
         (c_unattach = NULL) => 0.2059750312, 0.2059750312),
      (c_hh6_p = NULL) => 0.1268736853, 0.1268736853),
   (c_popover18 = NULL) => 0.0451368590, 0.0451368590),
(c_hval_150k_p = NULL) => -0.0037133094, -0.0031096870);

// Tree: 169 
wFDN_FLAPS__lgt_169 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 36.85) => -0.0043014921,
(c_hval_500k_p > 36.85) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 47) => 0.2139220526,
      (c_rich_wht > 47) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 4.25) => -0.0533571957,
         (c_femdiv_p > 4.25) => 0.1921049022,
         (c_femdiv_p = NULL) => 0.0682478803, 0.0682478803),
      (c_rich_wht = NULL) => 0.1152979235, 0.1152979235),
   (f_rel_incomeover100_count_d > 0.5) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0059791935) => 0.1438805470,
      (f_add_input_nhood_VAC_pct_i > 0.0059791935) => -0.0828532733,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0109922811, -0.0109922811),
   (f_rel_incomeover100_count_d = NULL) => 0.0481144716, 0.0481144716),
(c_hval_500k_p = NULL) => -0.0016229568, -0.0027826732);

// Tree: 170 
wFDN_FLAPS__lgt_170 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 96.5) => -0.0140966315,
   (c_easiqlife > 96.5) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
         map(
         (NULL < c_highrent and c_highrent <= 99.95) => 0.0057002995,
         (c_highrent > 99.95) => 0.0919736927,
         (c_highrent = NULL) => 0.0087174112, 0.0087174112),
      (r_P85_Phn_Disconnected_i > 0.5) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 2.5) => 0.1755839893,
         (f_hh_members_ct_d > 2.5) => 0.0138526345,
         (f_hh_members_ct_d = NULL) => 0.0818266822, 0.0818266822),
      (r_P85_Phn_Disconnected_i = NULL) => 0.0100298971, 0.0100298971),
   (c_easiqlife = NULL) => -0.0335678314, 0.0003777859),
(f_util_adl_count_n > 13.5) => 0.1332301729,
(f_util_adl_count_n = NULL) => 0.0076513653, 0.0014689526);

// Tree: 171 
wFDN_FLAPS__lgt_171 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 35.85) => -0.1248853730,
      (c_civ_emp > 35.85) => -0.0064674383,
      (c_civ_emp = NULL) => -0.0357231767, -0.0096094621),
   (f_util_add_input_conv_n > 0.5) => 
      map(
      (NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 0.0112662359,
      (f_inq_QuizProvider_count_i > 6.5) => 0.1369685813,
      (f_inq_QuizProvider_count_i = NULL) => 0.0125806996, 0.0125806996),
   (f_util_add_input_conv_n = NULL) => 0.0027842909, 0.0027842909),
(f_assocsuspicousidcount_i > 15.5) => 0.0766762879,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 11.05) => -0.0641254360,
   (c_blue_col > 11.05) => 0.0339828237,
   (c_blue_col = NULL) => -0.0173635552, -0.0173635552), 0.0030374599);

// Tree: 172 
wFDN_FLAPS__lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.55) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < f_srchssnsrchcount_i and f_srchssnsrchcount_i <= 16.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
            map(
            (NULL < c_unemp and c_unemp <= 8.8) => 0.0124250656,
            (c_unemp > 8.8) => 0.0964474329,
            (c_unemp = NULL) => 0.0299231571, 0.0299231571),
         (k_estimated_income_d > 28500) => -0.0012870440,
         (k_estimated_income_d = NULL) => 0.0001966375, 0.0001966375),
      (f_srchssnsrchcount_i > 16.5) => -0.0523130907,
      (f_srchssnsrchcount_i = NULL) => 0.0102171467, -0.0001702037),
   (c_manufacturing > 16.55) => -0.0536000491,
   (c_manufacturing = NULL) => -0.0042881691, -0.0042881691),
(c_pop_0_5_p > 20.55) => 0.1297004397,
(c_pop_0_5_p = NULL) => 0.0020716941, -0.0035441704);

// Tree: 173 
wFDN_FLAPS__lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.55) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0120958404,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 0.5) => 0.0082296314,
      (f_divsrchaddrsuspidcount_i > 0.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 29.5) => 0.2350884002,
         (c_bel_edu > 29.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 4.5) => 0.1168803418,
            (f_prevaddrlenofres_d > 4.5) => 0.0102617126,
            (f_prevaddrlenofres_d = NULL) => 0.0292741255, 0.0292741255),
         (c_bel_edu = NULL) => 0.0599012497, 0.0599012497),
      (f_divsrchaddrsuspidcount_i = NULL) => 0.0116874413, 0.0116874413),
   (k_inf_nothing_found_i = NULL) => -0.0023209907, -0.0023209907),
(c_low_hval > 71.55) => -0.1077068183,
(c_low_hval = NULL) => -0.0364065968, -0.0037443666);

// Tree: 174 
wFDN_FLAPS__lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 14.5) => 
   map(
   (NULL < c_info and c_info <= 27.55) => 
      map(
      (NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
         map(
         (NULL < nf_altlexid_phone_hi_no_hi_lexid and nf_altlexid_phone_hi_no_hi_lexid <= 0.5) => 0.0096124412,
         (nf_altlexid_phone_hi_no_hi_lexid > 0.5) => 0.1120479210,
         (nf_altlexid_phone_hi_no_hi_lexid = NULL) => 0.0109999241, 0.0109999241),
      (f_dl_addrs_per_adl_i > 0.5) => -0.0139374460,
      (f_dl_addrs_per_adl_i = NULL) => 0.0011484039, 0.0011484039),
   (c_info > 27.55) => 0.1958492944,
   (c_info = NULL) => -0.0008192211, 0.0021342478),
(f_srchphonesrchcount_i > 14.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 93.75) => -0.1472946539,
   (c_occunit_p > 93.75) => 0.0102444255,
   (c_occunit_p = NULL) => -0.0761479729, -0.0761479729),
(f_srchphonesrchcount_i = NULL) => -0.0315497675, 0.0010548135);

// Tree: 175 
wFDN_FLAPS__lgt_175 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 158.5) => -0.0095152879,
(r_C13_Curr_Addr_LRes_d > 158.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
      map(
      (NULL < c_femdiv_p and c_femdiv_p <= 11.15) => 0.0044673632,
      (c_femdiv_p > 11.15) => 0.1780183616,
      (c_femdiv_p = NULL) => 0.0086224961, 0.0086224961),
   (r_F03_input_add_not_most_rec_i > 0.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 136.5) => 0.0532775741,
      (c_serv_empl > 136.5) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 101) => 0.3657118007,
         (f_curraddrburglaryindex_i > 101) => 0.1029531055,
         (f_curraddrburglaryindex_i = NULL) => 0.2310203687, 0.2310203687),
      (c_serv_empl = NULL) => 0.1080739279, 0.1080739279),
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0229520572, 0.0229520572),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0050905172, -0.0022441528);

// Tree: 176 
wFDN_FLAPS__lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0020180414,
   (f_util_adl_count_n > 4.5) => 
      map(
      (NULL < r_F00_nas_ssn_no_addr_verd_i and r_F00_nas_ssn_no_addr_verd_i <= 0.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 22.5) => 0.1712747795,
         (k_comb_age_d > 22.5) => 
            map(
            (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0676059100,
            (f_phone_ver_experian_d > 0.5) => -0.0009691549,
            (f_phone_ver_experian_d = NULL) => -0.0407755789, 0.0161813744),
         (k_comb_age_d = NULL) => 0.0237061218, 0.0237061218),
      (r_F00_nas_ssn_no_addr_verd_i > 0.5) => 0.1626428057,
      (r_F00_nas_ssn_no_addr_verd_i = NULL) => 0.0302485170, 0.0302485170),
   (f_util_adl_count_n = NULL) => 0.0113687834, 0.0055561549),
(c_pop_18_24_p > 11.15) => -0.0248452113,
(c_pop_18_24_p = NULL) => 0.0277848830, -0.0008545762);

// Tree: 177 
wFDN_FLAPS__lgt_177 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 104.5) => -0.0055315287,
(f_prevaddrageoldest_d > 104.5) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < c_ab_av_edu and c_ab_av_edu <= 120.5) => 0.0072971719,
      (c_ab_av_edu > 120.5) => 
         map(
         (NULL < c_hval_300k_p and c_hval_300k_p <= 9.45) => 
            map(
            (NULL < c_unempl and c_unempl <= 77.5) => 0.0693059203,
            (c_unempl > 77.5) => 0.1802442579,
            (c_unempl = NULL) => 0.1254875371, 0.1254875371),
         (c_hval_300k_p > 9.45) => 0.0105725020,
         (c_hval_300k_p = NULL) => 0.0870422140, 0.0870422140),
      (c_ab_av_edu = NULL) => 0.0265199588, 0.0404399644),
   (f_phone_ver_insurance_d > 3.5) => -0.0055697056,
   (f_phone_ver_insurance_d = NULL) => 0.0148846705, 0.0148846705),
(f_prevaddrageoldest_d = NULL) => -0.0169650038, 0.0016679100);

// Tree: 178 
wFDN_FLAPS__lgt_178 := map(
(NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0105172255,
(f_phones_per_addr_c6_i > 0.5) => 
   map(
   (NULL < c_hh1_p and c_hh1_p <= 42.25) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -1) => 
         map(
         (NULL < c_families and c_families <= 347.5) => 0.1977555302,
         (c_families > 347.5) => 0.0376732962,
         (c_families = NULL) => 0.0933540732, 0.0933540732),
      (f_addrchangecrimediff_i > -1) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 23.95) => 0.0037232280,
         (c_hh3_p > 23.95) => 0.0810485776,
         (c_hh3_p = NULL) => 0.0146575595, 0.0146575595),
      (f_addrchangecrimediff_i = NULL) => 0.0400564639, 0.0231970938),
   (c_hh1_p > 42.25) => -0.0284948986,
   (c_hh1_p = NULL) => 0.0858459507, 0.0147072213),
(f_phones_per_addr_c6_i = NULL) => -0.0015370440, -0.0015370440);

// Tree: 179 
wFDN_FLAPS__lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.0378273066,
   (k_estimated_income_d > 26500) => -0.0025106231,
   (k_estimated_income_d = NULL) => -0.0010142806, -0.0010142806),
(f_rel_incomeover50_count_d > 22.5) => -0.0631506108,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 16.85) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 158.5) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 10.7) => 0.0502440046,
         (c_hh4_p > 10.7) => 0.1632942854,
         (c_hh4_p = NULL) => 0.1189437906, 0.1189437906),
      (c_asian_lang > 158.5) => -0.0183513178,
      (c_asian_lang = NULL) => 0.0609747448, 0.0609747448),
   (c_pop_45_54_p > 16.85) => -0.0898218761,
   (c_pop_45_54_p = NULL) => 0.0206968200, 0.0206968200), -0.0017582872);

// Tree: 180 
wFDN_FLAPS__lgt_180 := map(
(NULL < k_inq_adls_per_ssn_i and k_inq_adls_per_ssn_i <= 1.5) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 78.5) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 94.25) => -0.0114937934,
         (c_occunit_p > 94.25) => 0.0341022612,
         (c_occunit_p = NULL) => 0.0044392817, 0.0044392817),
      (f_addrchangecrimediff_i > 78.5) => 0.1082402755,
      (f_addrchangecrimediff_i = NULL) => 0.0038338792, 0.0053256964),
   (f_rel_incomeover100_count_d > 0.5) => -0.0130105246,
   (f_rel_incomeover100_count_d = NULL) => 
      map(
      (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.7261866328) => -0.0194117690,
      (f_add_curr_nhood_SFD_pct_d > 0.7261866328) => 0.1647680159,
      (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0113533056, 0.0281254242), -0.0012402098),
(k_inq_adls_per_ssn_i > 1.5) => 0.1146262421,
(k_inq_adls_per_ssn_i = NULL) => -0.0007286985, -0.0007286985);

// Tree: 181 
wFDN_FLAPS__lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 20.5) => 
   map(
   (NULL < C_INC_35K_P and C_INC_35K_P <= 9.35) => -0.0125626769,
   (C_INC_35K_P > 9.35) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0614611819) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 4.55) => -0.0342632737,
         (c_hval_250k_p > 4.55) => 
            map(
            (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 0.5) => -0.0024846835,
            (k_inq_ssns_per_addr_i > 0.5) => 0.1929288296,
            (k_inq_ssns_per_addr_i = NULL) => 0.0989513385, 0.0989513385),
         (c_hval_250k_p = NULL) => 0.0331155456, 0.0331155456),
      (f_add_input_nhood_VAC_pct_i > 0.0614611819) => 0.1865721705,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0730142681, 0.0730142681),
   (C_INC_35K_P = NULL) => 0.0257880667, 0.0257880667),
(r_C21_M_Bureau_ADL_FS_d > 20.5) => -0.0047253524,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0162577421, -0.0026353998);

// Tree: 182 
wFDN_FLAPS__lgt_182 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 6.5) => 
   map(
   (NULL < c_burglary and c_burglary <= 178.5) => 0.0023572506,
   (c_burglary > 178.5) => -0.0402492203,
   (c_burglary = NULL) => 0.0201984773, 0.0000913432),
(f_hh_tot_derog_i > 6.5) => 
   map(
   (NULL < c_rnt1500_p and c_rnt1500_p <= 7.6) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 5.75) => 0.1686820314,
      (c_newhouse > 5.75) => 0.0191970016,
      (c_newhouse = NULL) => 0.0858592446, 0.0858592446),
   (c_rnt1500_p > 7.6) => -0.0953102260,
   (c_rnt1500_p = NULL) => 0.0401093783, 0.0401093783),
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0482330142,
   (k_nap_lname_verd_d > 0.5) => -0.0670725240,
   (k_nap_lname_verd_d = NULL) => -0.0103806344, -0.0103806344), 0.0006263836);

// Tree: 183 
wFDN_FLAPS__lgt_183 := map(
(NULL < c_transport and c_transport <= 26.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
      map(
      (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => -0.0050836023,
      (k_inq_adls_per_addr_i > 3.5) => -0.0472949228,
      (k_inq_adls_per_addr_i = NULL) => -0.0059416708, -0.0059416708),
   (f_srchfraudsrchcountyr_i > 7.5) => -0.0692404680,
   (f_srchfraudsrchcountyr_i = NULL) => -0.0057584212, -0.0064041524),
(c_transport > 26.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0199296434) => 0.1903122517,
      (f_add_curr_nhood_VAC_pct_i > 0.0199296434) => 0.0136152834,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1065448001, 0.1065448001),
   (r_C12_Num_NonDerogs_d > 3.5) => -0.0075745433,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0538043864, 0.0538043864),
(c_transport = NULL) => 0.0163170882, -0.0046749934);

// Tree: 184 
wFDN_FLAPS__lgt_184 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
   map(
   (NULL < c_robbery and c_robbery <= 13) => -0.0379082580,
   (c_robbery > 13) => 
      map(
      (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 10.5) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 0.0033805801,
         (f_phones_per_addr_curr_i > 50.5) => 0.0657903373,
         (f_phones_per_addr_curr_i = NULL) => 0.0057369943, 0.0043205061),
      (k_inq_per_ssn_i > 10.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.1299120993,
         (r_L79_adls_per_addr_curr_i > 2.5) => -0.0036837431,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0621318557, 0.0621318557),
      (k_inq_per_ssn_i = NULL) => 0.0050193190, 0.0050193190),
   (c_robbery = NULL) => 0.0013199883, 0.0013199883),
(C_RENTOCC_P > 92.2) => -0.0886220003,
(C_RENTOCC_P = NULL) => 0.0225794882, 0.0011035477);

// Tree: 185 
wFDN_FLAPS__lgt_185 := map(
(NULL < c_high_ed and c_high_ed <= 4.25) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < c_retired and c_retired <= 11.45) => 
         map(
         (NULL < f_util_add_input_conv_n and f_util_add_input_conv_n <= 0.5) => -0.0526505587,
         (f_util_add_input_conv_n > 0.5) => 
            map(
            (NULL < f_curraddractivephonelist_d and f_curraddractivephonelist_d <= 0.5) => 0.0141305067,
            (f_curraddractivephonelist_d > 0.5) => 0.1761386076,
            (f_curraddractivephonelist_d = NULL) => 0.0898352267, 0.0898352267),
         (f_util_add_input_conv_n = NULL) => 0.0400916685, 0.0400916685),
      (c_retired > 11.45) => 0.2170943541,
      (c_retired = NULL) => 0.0929721389, 0.0929721389),
   (r_C12_Num_NonDerogs_d > 3.5) => -0.0315915452,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0442161514, 0.0442161514),
(c_high_ed > 4.25) => 0.0011504919,
(c_high_ed = NULL) => -0.0055418494, 0.0023462982);

// Tree: 186 
wFDN_FLAPS__lgt_186 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3972388293) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.75) => 0.0059457450,
      (c_pop_6_11_p > 15.75) => 0.1532937253,
      (c_pop_6_11_p = NULL) => -0.0362465245, 0.0062882841),
   (f_add_input_mobility_index_i > 0.3972388293) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 59.05) => -0.0377112399,
      (c_rnt750_p > 59.05) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.70505102105) => -0.0092597988,
         (f_add_input_nhood_MFD_pct_i > 0.70505102105) => 0.1642107376,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0496975077, 0.0496975077),
      (c_rnt750_p = NULL) => 0.0479045895, -0.0255348220),
   (f_add_input_mobility_index_i = NULL) => -0.0047559860, 0.0016766507),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0687279552,
(f_inq_PrepaidCards_count_i = NULL) => 0.0296968356, 0.0021807712);

// Tree: 187 
wFDN_FLAPS__lgt_187 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < r_C20_email_domain_free_count_i and r_C20_email_domain_free_count_i <= 3.5) => -0.0024601884,
   (r_C20_email_domain_free_count_i > 3.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0162261612,
      (r_D30_Derog_Count_i > 1.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2921335638) => 0.0511056176,
         (f_add_curr_mobility_index_i > 0.2921335638) => 0.1866707191,
         (f_add_curr_mobility_index_i = NULL) => 0.1059772063, 0.1059772063),
      (r_D30_Derog_Count_i = NULL) => 0.0440950676, 0.0440950676),
   (r_C20_email_domain_free_count_i = NULL) => -0.0008886219, -0.0008886219),
(f_rel_incomeover50_count_d > 22.5) => -0.0677573290,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 100.5) => 0.0441396025,
   (c_no_teens > 100.5) => -0.0463553850,
   (c_no_teens = NULL) => -0.0142629134, -0.0142629134), -0.0025259572);

// Tree: 188 
wFDN_FLAPS__lgt_188 := map(
(nf_seg_FraudPoint_3_0 in ['3: Derog','6: Other']) => -0.0121266107,
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 
   map(
   (NULL < k_nap_nothing_found_i and k_nap_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 0.0158222309,
      (f_inq_HighRiskCredit_count_i > 2.5) => 0.0896598116,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0275659910, 0.0168942675),
   (k_nap_nothing_found_i > 0.5) => 
      map(
      (NULL < c_highinc and c_highinc <= 20.65) => 
         map(
         (NULL < c_occunit_p and c_occunit_p <= 94.65) => -0.0307172871,
         (c_occunit_p > 94.65) => 0.0987479241,
         (c_occunit_p = NULL) => -0.0071781578, -0.0071781578),
      (c_highinc > 20.65) => -0.0928099446,
      (c_highinc = NULL) => 0.0001334553, -0.0259028396),
   (k_nap_nothing_found_i = NULL) => 0.0127866249, 0.0127866249),
(nf_seg_FraudPoint_3_0 = '') => 0.0008671589, 0.0008671589);

// Tree: 189 
wFDN_FLAPS__lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => -0.0009338458,
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0671039847,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0032892398, -0.0032892398),
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < c_burglary and c_burglary <= 45.5) => 0.1903480725,
      (c_burglary > 45.5) => -0.0376989687,
      (c_burglary = NULL) => 0.0784759391, 0.0784759391),
   (f_rel_homeover500_count_d = NULL) => 0.0077791732, -0.0024091197),
(f_phones_per_addr_curr_i > 44.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 0.0021821716,
   (f_rel_under25miles_cnt_d > 5.5) => 0.1532202747,
   (f_rel_under25miles_cnt_d = NULL) => 0.0584197632, 0.0584197632),
(f_phones_per_addr_curr_i = NULL) => -0.0022553833, -0.0014680090);

// Tree: 190 
wFDN_FLAPS__lgt_190 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 51.15) => -0.0052892151,
   (c_hh2_p > 51.15) => 0.0606846728,
   (c_hh2_p = NULL) => -0.0169913748, -0.0028655388),
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 0.1) => 0.0381493470,
      (c_hh5_p > 0.1) => -0.0671521537,
      (c_hh5_p = NULL) => -0.0541467891, -0.0541467891),
   (f_srchcomponentrisktype_i > 1.5) => 0.0524885625,
   (f_srchcomponentrisktype_i = NULL) => -0.0407945067, -0.0407945067),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 11.15) => -0.0533610991,
   (c_blue_col > 11.15) => 0.0413905125,
   (c_blue_col = NULL) => -0.0064280578, -0.0064280578), -0.0046399201);

// Tree: 191 
wFDN_FLAPS__lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 18.5) => -0.0056853631,
   (f_srchfraudsrchcount_i > 18.5) => 0.0530081992,
   (f_srchfraudsrchcount_i = NULL) => -0.0208415118, -0.0052622064),
(c_totcrime > 163.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 152.5) => 0.0109403449,
      (c_exp_prod > 152.5) => 0.1717939681,
      (c_exp_prod = NULL) => 0.0222362454, 0.0222362454),
   (f_util_adl_count_n > 3.5) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 116144.5) => 0.1689785606,
      (f_curraddrmedianvalue_d > 116144.5) => 0.0442630058,
      (f_curraddrmedianvalue_d = NULL) => 0.0895226829, 0.0895226829),
   (f_util_adl_count_n = NULL) => 0.0349163643, 0.0349163643),
(c_totcrime = NULL) => -0.0337307187, -0.0016940560);

// Tree: 192 
wFDN_FLAPS__lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 120) => 0.0717737062,
(r_D32_Mos_Since_Fel_LS_d > 120) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 11.5) => 0.0000661477,
   (f_rel_under100miles_cnt_d > 11.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 48.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 58.5) => -0.1117683288,
         (c_many_cars > 58.5) => -0.0268982655,
         (c_many_cars = NULL) => -0.0573062561, -0.0573062561),
      (c_lux_prod > 48.5) => -0.0087831920,
      (c_lux_prod = NULL) => -0.0172515196, -0.0172515196),
   (f_rel_under100miles_cnt_d = NULL) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1982.5) => -0.0133741811,
      (c_med_yearblt > 1982.5) => 0.1467236976,
      (c_med_yearblt = NULL) => 0.0344811630, 0.0344811630), -0.0024326813),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0050870760, -0.0020522632);

// Tree: 193 
wFDN_FLAPS__lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0080146819,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 14.35) => 0.2209760600,
      (C_INC_75K_P > 14.35) => 0.0408171774,
      (C_INC_75K_P = NULL) => 0.0914868632, 0.0914868632),
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < c_highrent and c_highrent <= 92.25) => 0.0059198978,
      (c_highrent > 92.25) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 10.55) => 0.2889193473,
         (C_INC_150K_P > 10.55) => -0.0495293796,
         (C_INC_150K_P = NULL) => 0.1134274149, 0.1134274149),
      (c_highrent = NULL) => 0.0102865063, 0.0102865063),
   (f_hh_members_ct_d = NULL) => 0.0175091795, 0.0175091795),
(f_prevaddrageoldest_d = NULL) => -0.0147648126, -0.0021033453);

// Tree: 194 
wFDN_FLAPS__lgt_194 := map(
(nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 3.15) => -0.0616254215,
   (c_hh5_p > 3.15) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 140.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 0.05) => -0.1148022140,
         (c_hval_250k_p > 0.05) => -0.0195966068,
         (c_hval_250k_p = NULL) => -0.0374659669, -0.0374659669),
      (c_oldhouse > 140.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => -0.0012457346,
         (f_corrrisktype_i > 7.5) => 0.0938719224,
         (f_corrrisktype_i = NULL) => 0.0508808910, 0.0508808910),
      (c_oldhouse = NULL) => -0.0063157800, -0.0063157800),
   (c_hh5_p = NULL) => -0.0056059153, -0.0266123614),
(nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0019884115,
(nf_seg_FraudPoint_3_0 = '') => -0.0000160101, -0.0000160101);

// Tree: 195 
wFDN_FLAPS__lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 40.05) => 
   map(
   (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 1.5) => 
      map(
      (NULL < c_construction and c_construction <= 9.55) => -0.0097469028,
      (c_construction > 9.55) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 9.55) => 
            map(
            (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.04279820495) => 0.2440090014,
            (f_add_curr_nhood_MFD_pct_i > 0.04279820495) => 0.0502561383,
            (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1152653226, 0.1152653226),
         (c_pop_18_24_p > 9.55) => 0.2584682387,
         (c_pop_18_24_p = NULL) => 0.1547893275, 0.1547893275),
      (c_construction = NULL) => 0.0541258574, 0.0541258574),
   (f_corrssnnamecount_d > 1.5) => 0.0006650994,
   (f_corrssnnamecount_d = NULL) => -0.0211600783, 0.0032659643),
(c_hval_80k_p > 40.05) => -0.1135788267,
(c_hval_80k_p = NULL) => 0.0183102414, 0.0025487881);

// Tree: 196 
wFDN_FLAPS__lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 22.5) => -0.0936545047,
(f_mos_inq_banko_am_lseen_d > 22.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 4.5) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 25.75) => -0.0274931455,
      (c_vacant_p > 25.75) => 0.1395026325,
      (c_vacant_p = NULL) => -0.0758314455, -0.0235275812),
   (f_addrs_per_ssn_i > 4.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 23.15) => 0.0036594584,
      (C_INC_25K_P > 23.15) => 0.0602257877,
      (C_INC_25K_P = NULL) => 0.0327141917, 0.0053214681),
   (f_addrs_per_ssn_i = NULL) => -0.0016366021, -0.0016366021),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.595) => 0.0723872144,
   (c_hhsize > 2.595) => -0.0398040435,
   (c_hhsize = NULL) => 0.0099503404, 0.0099503404), -0.0033395943);

// Tree: 197 
wFDN_FLAPS__lgt_197 := map(
(NULL < c_hh4_p and c_hh4_p <= 10.95) => -0.0153916316,
(c_hh4_p > 10.95) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -13203.5) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -20771) => 0.0288075479,
      (f_addrchangeincomediff_d > -20771) => 0.1743080793,
      (f_addrchangeincomediff_d = NULL) => 0.0782587089, 0.0782587089),
   (f_addrchangeincomediff_d > -13203.5) => 0.0077022505,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 10.45) => -0.0146271373,
      (c_hh5_p > 10.45) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 154.5) => 0.0327933846,
         (c_easiqlife > 154.5) => 0.1860324996,
         (c_easiqlife = NULL) => 0.0533057071, 0.0533057071),
      (c_hh5_p = NULL) => 0.0018900380, 0.0018900380), 0.0079170966),
(c_hh4_p = NULL) => -0.0051665233, -0.0007398219);

// Tree: 198 
wFDN_FLAPS__lgt_198 := map(
(NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 24.5) => -0.0365342919,
(r_A50_pb_average_dollars_d > 24.5) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 27.1) => -0.0449081100,
      (c_fammar_p > 27.1) => 0.0075225317,
      (c_fammar_p = NULL) => -0.0230729560, 0.0059710886),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_rnt250_p and c_rnt250_p <= 2) => 
         map(
         (NULL < C_INC_25K_P and C_INC_25K_P <= 6.35) => 0.0396721127,
         (C_INC_25K_P > 6.35) => 0.1597296690,
         (C_INC_25K_P = NULL) => 0.0979857829, 0.0979857829),
      (c_rnt250_p > 2) => -0.0235237275,
      (c_rnt250_p = NULL) => 0.0552324366, 0.0552324366),
   (k_nap_contradictory_i = NULL) => 0.0067532252, 0.0067532252),
(r_A50_pb_average_dollars_d = NULL) => -0.0004917074, 0.0018264499);

// Tree: 199 
wFDN_FLAPS__lgt_199 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
      map(
      (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0097345454,
      (f_hh_collections_ct_i > 1.5) => 
         map(
         (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 16.5) => -0.0551578018,
            (f_prevaddrlenofres_d > 16.5) => 0.1356929047,
            (f_prevaddrlenofres_d = NULL) => 0.0840041717, 0.0840041717),
         (f_corraddrnamecount_d > 1.5) => 0.0083421269,
         (f_corraddrnamecount_d = NULL) => 0.0126299405, 0.0126299405),
      (f_hh_collections_ct_i = NULL) => -0.0034977458, -0.0034977458),
   (f_rel_felony_count_i > 4.5) => 0.0823764129,
   (f_rel_felony_count_i = NULL) => 0.0069555762, -0.0030371206),
(C_INC_25K_P > 27.65) => 0.0718508606,
(C_INC_25K_P = NULL) => -0.0422810380, -0.0033995939);

// Tree: 200 
wFDN_FLAPS__lgt_200 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 10.5) => 
      map(
      (NULL < c_food and c_food <= 68.85) => -0.0008096982,
      (c_food > 68.85) => 
         map(
         (NULL < c_hh4_p and c_hh4_p <= 19.55) => 0.0405848477,
         (c_hh4_p > 19.55) => 0.2338704474,
         (c_hh4_p = NULL) => 0.0861562492, 0.0861562492),
      (c_food = NULL) => 0.0016057499, 0.0016057499),
   (f_rel_homeover300_count_d > 10.5) => -0.0389242597,
   (f_rel_homeover300_count_d = NULL) => -0.0032108725, -0.0013279084),
(f_addrchangecrimediff_i > 98.5) => 0.0644446841,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 248.5) => -0.0065759943,
   (f_liens_unrel_CJ_total_amt_i > 248.5) => -0.0754260910,
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0018545961, -0.0112758611), -0.0031807904);

// Tree: 201 
wFDN_FLAPS__lgt_201 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0053445190,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_finance and c_finance <= 5.55) => 0.0031283754,
   (c_finance > 5.55) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 3.75) => 
         map(
         (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
            map(
            (NULL < c_no_labfor and c_no_labfor <= 70.5) => 0.2616081337,
            (c_no_labfor > 70.5) => 0.0036287271,
            (c_no_labfor = NULL) => 0.0938313168, 0.0938313168),
         (f_srchfraudsrchcount_i > 1.5) => 0.2692430311,
         (f_srchfraudsrchcount_i = NULL) => 0.1497960066, 0.1497960066),
      (c_rnt2000_p > 3.75) => -0.0153596429,
      (c_rnt2000_p = NULL) => 0.0996016425, 0.0996016425),
   (c_finance = NULL) => 0.0830891597, 0.0384955631),
(r_L70_Add_Standardized_i = NULL) => -0.0017018350, -0.0017018350);

// Tree: 202 
wFDN_FLAPS__lgt_202 := map(
(NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 14.5) => 
   map(
   (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 1.5) => 
      map(
      (NULL < C_INC_200K_P and C_INC_200K_P <= 0.75) => -0.1021885524,
      (C_INC_200K_P > 0.75) => -0.0450060588,
      (C_INC_200K_P = NULL) => -0.0552387156, -0.0552387156),
   (f_phones_per_addr_c6_i > 1.5) => 0.0645317353,
   (f_phones_per_addr_c6_i = NULL) => -0.0411753465, -0.0411753465),
(f_mos_inq_banko_om_fseen_d > 14.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 36.5) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 70.85) => -0.0276463468,
      (c_sfdu_p > 70.85) => 0.0991614032,
      (c_sfdu_p = NULL) => 0.0461824241, 0.0461824241),
   (f_mos_inq_banko_om_fseen_d > 36.5) => -0.0008326869,
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0021538552, 0.0021538552),
(f_mos_inq_banko_om_fseen_d = NULL) => -0.0042970377, -0.0005538932);

// Tree: 203 
wFDN_FLAPS__lgt_203 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -116.5) => 0.0966169360,
(f_addrchangecrimediff_i > -116.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 75.35) => 
      map(
      (NULL < f_inq_Auto_count24_i and f_inq_Auto_count24_i <= 1.5) => 0.0009605632,
      (f_inq_Auto_count24_i > 1.5) => -0.0546587803,
      (f_inq_Auto_count24_i = NULL) => -0.0019169996, -0.0019169996),
   (c_rnt1000_p > 75.35) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 71.35) => 0.0230118963,
      (r_C12_source_profile_d > 71.35) => 0.3197538464,
      (r_C12_source_profile_d = NULL) => 0.1224976368, 0.1224976368),
   (c_rnt1000_p = NULL) => 0.0002883008, 0.0002883008),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_rnt750_p and c_rnt750_p <= 55.45) => -0.0018559267,
   (c_rnt750_p > 55.45) => -0.0727244380,
   (c_rnt750_p = NULL) => -0.0122536411, -0.0092195747), -0.0014702358);

// Tree: 204 
wFDN_FLAPS__lgt_204 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0867621779,
(c_pop_45_54_p > 3.35) => 
   map(
   (NULL < r_L70_inp_addr_dirty_i and r_L70_inp_addr_dirty_i <= 0.5) => 
      map(
      (NULL < c_young and c_young <= 13.95) => -0.0271525557,
      (c_young > 13.95) => 
         map(
         (NULL < r_S65_SSN_Problem_i and r_S65_SSN_Problem_i <= 1.5) => 0.0116035553,
         (r_S65_SSN_Problem_i > 1.5) => -0.0588472327,
         (r_S65_SSN_Problem_i = NULL) => 0.0097953207, 0.0097953207),
      (c_young = NULL) => 0.0037623843, 0.0037623843),
   (r_L70_inp_addr_dirty_i > 0.5) => -0.0579151171,
   (r_L70_inp_addr_dirty_i = NULL) => 
      map(
      (NULL < c_medi_indx and c_medi_indx <= 101.5) => 0.0622122151,
      (c_medi_indx > 101.5) => -0.0434166273,
      (c_medi_indx = NULL) => 0.0089304096, 0.0089304096), 0.0029839521),
(c_pop_45_54_p = NULL) => -0.0039987684, 0.0017103220);

// Tree: 205 
wFDN_FLAPS__lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5922.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 18) => 0.0640251634,
   (r_D33_Eviction_Recency_d > 18) => 
      map(
      (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 5.5) => 0.0029645650,
      (f_crim_rel_under25miles_cnt_i > 5.5) => -0.0373032132,
      (f_crim_rel_under25miles_cnt_i = NULL) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 832.5) => -0.0709281216,
         (c_hh00 > 832.5) => 0.0960412729,
         (c_hh00 = NULL) => -0.0218701036, -0.0218701036), 0.0013455309),
   (r_D33_Eviction_Recency_d = NULL) => 0.0016609568, 0.0016609568),
(f_liens_unrel_ST_total_amt_i > 5922.5) => 0.1563028339,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1256) => 0.0586271812,
   (c_popover18 > 1256) => -0.0342393093,
   (c_popover18 = NULL) => 0.0092119844, 0.0092119844), 0.0023511503);

// Tree: 206 
wFDN_FLAPS__lgt_206 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184.5) => 
   map(
   (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 2.5) => -0.0146348519,
   (f_crim_rel_under500miles_cnt_i > 2.5) => -0.1501107919,
   (f_crim_rel_under500miles_cnt_i = NULL) => -0.0692296337, -0.0692296337),
(f_mos_liens_unrel_FT_lseen_d > 184.5) => 
   map(
   (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 3.5) => 
      map(
      (NULL < f_acc_damage_amt_total_i and f_acc_damage_amt_total_i <= 275) => 0.0021421449,
      (f_acc_damage_amt_total_i > 275) => 0.0794652873,
      (f_acc_damage_amt_total_i = NULL) => 0.0038877053, 0.0038877053),
   (r_A50_pb_total_orders_d > 3.5) => -0.0254654111,
   (r_A50_pb_total_orders_d = NULL) => -0.0043587183, -0.0043587183),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.05) => 0.0591468799,
   (c_pop_18_24_p > 8.05) => -0.0680078507,
   (c_pop_18_24_p = NULL) => -0.0038010066, -0.0038010066), -0.0050392880);

// Tree: 207 
wFDN_FLAPS__lgt_207 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 9.5) => 
      map(
      (NULL < r_Phn_PCS_n and r_Phn_PCS_n <= 0.5) => 0.0047530386,
      (r_Phn_PCS_n > 0.5) => -0.0308901356,
      (r_Phn_PCS_n = NULL) => 0.0004643280, 0.0004643280),
   (k_inq_per_phone_i > 9.5) => 0.0860594642,
   (k_inq_per_phone_i = NULL) => 0.0008887207, 0.0008887207),
(f_srchfraudsrchcountyr_i > 3.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 19.85) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 104.5) => -0.0277518652,
      (f_curraddrburglaryindex_i > 104.5) => -0.1207081255,
      (f_curraddrburglaryindex_i = NULL) => -0.0732814621, -0.0732814621),
   (c_pop_25_34_p > 19.85) => 0.0329395450,
   (c_pop_25_34_p = NULL) => -0.0456239169, -0.0456239169),
(f_srchfraudsrchcountyr_i = NULL) => -0.0206759191, -0.0002917012);

// Tree: 208 
wFDN_FLAPS__lgt_208 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 2.5) => -0.0023525862,
   (f_srchcomponentrisktype_i > 2.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 881.5) => 
         map(
         (NULL < c_rental and c_rental <= 132.5) => -0.0499348532,
         (c_rental > 132.5) => 0.0907120845,
         (c_rental = NULL) => 0.0007329877, 0.0007329877),
      (c_hh00 > 881.5) => 0.1784662641,
      (c_hh00 = NULL) => 0.0459891461, 0.0459891461),
   (f_srchcomponentrisktype_i = NULL) => -0.0014909968, -0.0014909968),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0677557898,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_med_hval and c_med_hval <= 189293.5) => -0.0611526369,
   (c_med_hval > 189293.5) => 0.0432143666,
   (c_med_hval = NULL) => -0.0056782837, -0.0056782837), -0.0018221549);

// Tree: 209 
wFDN_FLAPS__lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.75) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 65.5) => -0.0296687826,
   (r_A50_pb_average_dollars_d > 65.5) => 
      map(
      (NULL < c_rape and c_rape <= 23.5) => 0.2133257425,
      (c_rape > 23.5) => 
         map(
         (NULL < c_rnt1500_p and c_rnt1500_p <= 4.05) => 
            map(
            (NULL < c_sub_bus and c_sub_bus <= 177.5) => 0.0419685922,
            (c_sub_bus > 177.5) => 0.1744566822,
            (c_sub_bus = NULL) => 0.0725764018, 0.0725764018),
         (c_rnt1500_p > 4.05) => -0.0236659016,
         (c_rnt1500_p = NULL) => 0.0358471962, 0.0358471962),
      (c_rape = NULL) => 0.0540501240, 0.0540501240),
   (r_A50_pb_average_dollars_d = NULL) => 0.0288594159, 0.0288594159),
(c_hh2_p > 17.75) => 0.0005675712,
(c_hh2_p = NULL) => 0.0165169287, 0.0026986279);

// Tree: 210 
wFDN_FLAPS__lgt_210 := map(
(NULL < c_families and c_families <= 110.5) => -0.0714842219,
(c_families > 110.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 241387.5) => 0.1273619365,
      (r_A46_Curr_AVM_AutoVal_d > 241387.5) => -0.0184513022,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < c_rental and c_rental <= 136.5) => -0.0401309139,
         (c_rental > 136.5) => 0.1091900792,
         (c_rental = NULL) => 0.0303233575, 0.0303233575), 0.0400534863),
   (r_C10_M_Hdr_FS_d > 10.5) => -0.0024767636,
   (r_C10_M_Hdr_FS_d = NULL) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 32.45) => 0.0545403897,
      (c_hh2_p > 32.45) => -0.0574839072,
      (c_hh2_p = NULL) => -0.0009171830, -0.0009171830), -0.0016144717),
(c_families = NULL) => 0.0097061017, -0.0025483900);

// Tree: 211 
wFDN_FLAPS__lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 
   map(
   (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 18.5) => -0.0002585105,
   (f_rel_under100miles_cnt_d > 18.5) => -0.0419960503,
   (f_rel_under100miles_cnt_d = NULL) => 0.0123850677, -0.0024750348),
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_robbery and c_robbery <= 167) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 166.5) => 
         map(
         (NULL < c_pop_45_54_p and c_pop_45_54_p <= 18.05) => 0.0044951052,
         (c_pop_45_54_p > 18.05) => 0.1366183836,
         (c_pop_45_54_p = NULL) => 0.0341381484, 0.0341381484),
      (c_serv_empl > 166.5) => 0.1288282258,
      (c_serv_empl = NULL) => 0.0476653024, 0.0476653024),
   (c_robbery > 167) => -0.0625845505,
   (c_robbery = NULL) => 0.0331933646, 0.0331933646),
(f_srchaddrsrchcount_i = NULL) => -0.0172286199, -0.0014273228);

// Tree: 212 
wFDN_FLAPS__lgt_212 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 22.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0047953418) => -0.0361009356,
   (f_add_curr_nhood_BUS_pct_i > 0.0047953418) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 14.5) => 
         map(
         (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 10.5) => 0.0006019233,
         (f_rel_ageover40_count_d > 10.5) => 0.0530784264,
         (f_rel_ageover40_count_d = NULL) => 0.0116457262, 0.0031332682),
      (f_assocsuspicousidcount_i > 14.5) => 0.0873732954,
      (f_assocsuspicousidcount_i = NULL) => 0.0035935079, 0.0035935079),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0187448124, -0.0016855866),
(f_srchaddrsrchcount_i > 22.5) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.4304599763) => 0.0099945426,
   (f_add_curr_nhood_MFD_pct_i > 0.4304599763) => 0.0468023971,
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0231218194, 0.0231218194),
(f_srchaddrsrchcount_i = NULL) => 0.0210353028, -0.0011469600);

// Tree: 213 
wFDN_FLAPS__lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 149006.5) => 
   map(
   (NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 1803.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 176.5) => 
         map(
         (NULL < c_families and c_families <= 1338) => 0.0063131470,
         (c_families > 1338) => 0.1678962294,
         (c_families = NULL) => 0.0127229379, 0.0127229379),
      (c_sub_bus > 176.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 106) => 0.0241083325,
         (c_no_labfor > 106) => 0.1753715361,
         (c_no_labfor = NULL) => 0.0813722596, 0.0813722596),
      (c_sub_bus = NULL) => 0.0166715431, 0.0166715431),
   (f_liens_unrel_SC_total_amt_i > 1803.5) => 0.1604603465,
   (f_liens_unrel_SC_total_amt_i = NULL) => 0.0195507743, 0.0195507743),
(r_A46_Curr_AVM_AutoVal_d > 149006.5) => -0.0091422879,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0033739290, 0.0019178639);

// Tree: 214 
wFDN_FLAPS__lgt_214 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 59128.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 1.5) => -0.0200667703,
   (f_hh_lienholders_i > 1.5) => -0.0897831767,
   (f_hh_lienholders_i = NULL) => -0.0337128111, -0.0337128111),
(r_L80_Inp_AVM_AutoVal_d > 59128.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 4.5) => 0.1439199879,
   (r_D32_Mos_Since_Crim_LS_d > 4.5) => 0.0047550417,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0058742742, 0.0058742742),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 0.0050203288,
   (f_inq_Communications_count24_i > 1.5) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 172.95) => 0.0041352244,
      (c_oldhouse > 172.95) => 0.1199045384,
      (c_oldhouse = NULL) => 0.0556763573, 0.0556763573),
   (f_inq_Communications_count24_i = NULL) => -0.0395066264, 0.0059095144), 0.0042605819);

// Tree: 215 
wFDN_FLAPS__lgt_215 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 42) => 0.1324258723,
(f_mos_liens_unrel_FT_fseen_d > 42) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1327013824) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => -0.0039571008,
      (c_unempl > 191.5) => 0.0844966405,
      (c_unempl = NULL) => 0.0854290449, -0.0028075451),
   (f_add_curr_nhood_BUS_pct_i > 0.1327013824) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 0.0183798750,
      (f_srchvelocityrisktype_i > 5.5) => 
         map(
         (NULL < c_hval_125k_p and c_hval_125k_p <= 2.35) => 0.0254100375,
         (c_hval_125k_p > 2.35) => 0.1641568216,
         (c_hval_125k_p = NULL) => 0.0947834296, 0.0947834296),
      (f_srchvelocityrisktype_i = NULL) => 0.0251491459, 0.0251491459),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0261217291, -0.0008950594),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0121273075, -0.0004274558);

// Tree: 216 
wFDN_FLAPS__lgt_216 := map(
(NULL < c_no_teens and c_no_teens <= 111.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 6.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 405) => 0.0037937046,
      (r_C21_M_Bureau_ADL_FS_d > 405) => 
         map(
         (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.35) => 0.0059942386,
         (c_pop_35_44_p > 14.35) => 0.2244988708,
         (c_pop_35_44_p = NULL) => 0.1160213938, 0.1160213938),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0229176446, 0.0062475963),
   (r_L79_adls_per_addr_c6_i > 6.5) => 
      map(
      (NULL < c_rental and c_rental <= 111) => 0.2022764089,
      (c_rental > 111) => 0.0342366165,
      (c_rental = NULL) => 0.1100775848, 0.1100775848),
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0079241880, 0.0079241880),
(c_no_teens > 111.5) => -0.0129903913,
(c_no_teens = NULL) => 0.0133304866, -0.0008422979);

// Tree: 217 
wFDN_FLAPS__lgt_217 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -33052.5) => -0.0762503504,
(f_addrchangeincomediff_d > -33052.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0073814658,
   (f_sourcerisktype_i > 5.5) => 
      map(
      (NULL < c_health and c_health <= 2.35) => 
         map(
         (NULL < c_hh00 and c_hh00 <= 442.5) => 
            map(
            (NULL < c_mort_indx and c_mort_indx <= 89.5) => 0.0420067838,
            (c_mort_indx > 89.5) => 0.1979197814,
            (c_mort_indx = NULL) => 0.1136802215, 0.1136802215),
         (c_hh00 > 442.5) => 0.0229840737,
         (c_hh00 = NULL) => 0.0644911905, 0.0644911905),
      (c_health > 2.35) => 0.0016118021,
      (c_health = NULL) => 0.0187288391, 0.0187288391),
   (f_sourcerisktype_i = NULL) => -0.0001185497, -0.0001185497),
(f_addrchangeincomediff_d = NULL) => 0.0000131965, -0.0008447300);

// Tree: 218 
wFDN_FLAPS__lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 188.5) => 0.0272662133,
   (c_exp_homes > 188.5) => 0.2572425227,
   (c_exp_homes = NULL) => 0.0391861416, 0.0444943676),
(f_rel_incomeover25_count_d > 1.5) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0042736077,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 5.5) => 0.1656840195,
         (f_rel_under100miles_cnt_d > 5.5) => 0.0052525635,
         (f_rel_under100miles_cnt_d = NULL) => 0.0793793088, 0.0793793088),
      (f_phone_ver_experian_d > 0.5) => 0.0005596130,
      (f_phone_ver_experian_d = NULL) => 0.0145315414, 0.0310058614),
   (r_L70_Add_Standardized_i = NULL) => -0.0016532844, -0.0016532844),
(f_rel_incomeover25_count_d = NULL) => -0.0279043994, 0.0007118458);

// Tree: 219 
wFDN_FLAPS__lgt_219 := map(
(NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => -0.0048944174,
(f_hh_collections_ct_i > 1.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 34.15) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 3.5) => -0.0654504166,
      (nf_vf_hi_risk_index > 3.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 22.25) => 0.0060847656,
         (c_hval_250k_p > 22.25) => 
            map(
            (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => 0.0584025138,
            (r_D34_UnRel_Lien60_Count_i > 0.5) => 0.1732193571,
            (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0693272508, 0.0693272508),
         (c_hval_250k_p = NULL) => 0.0162643368, 0.0162643368),
      (nf_vf_hi_risk_index = NULL) => 0.0142071152, 0.0142071152),
   (c_hval_100k_p > 34.15) => 0.1094072518,
   (c_hval_100k_p = NULL) => 0.0963940558, 0.0178018857),
(f_hh_collections_ct_i = NULL) => -0.0140875336, 0.0013879125);

// Tree: 220 
wFDN_FLAPS__lgt_220 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 23.5) => -0.1070540913,
(f_mos_inq_banko_am_lseen_d > 23.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0059269415,
      (r_L70_Add_Standardized_i > 0.5) => 0.0338617988,
      (r_L70_Add_Standardized_i = NULL) => -0.0025030620, -0.0025030620),
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 119.5) => -0.0308301832,
      (c_easiqlife > 119.5) => 0.1547802754,
      (c_easiqlife = NULL) => 0.0674341773, 0.0674341773),
   (k_comb_age_d = NULL) => -0.0018107265, -0.0018107265),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 117.5) => -0.0326353217,
   (c_preschl > 117.5) => 0.0731740553,
   (c_preschl = NULL) => 0.0159329169, 0.0159329169), -0.0035413162);

// Tree: 221 
wFDN_FLAPS__lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 11.25) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 46) => 0.0075072018,
   (c_famotf18_p > 46) => 0.1007505017,
   (c_famotf18_p = NULL) => 0.0081664160, 0.0081664160),
(C_INC_25K_P > 11.25) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 2.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 41.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 27.6) => 0.0133606295,
         (c_hh3_p > 27.6) => 0.1360638207,
         (c_hh3_p = NULL) => 0.0242131229, 0.0242131229),
      (c_many_cars > 41.5) => -0.0280314032,
      (c_many_cars = NULL) => -0.0137365504, -0.0137365504),
   (f_inq_count24_i > 2.5) => -0.0548585390,
   (f_inq_count24_i = NULL) => -0.0216864563, -0.0216864563),
(C_INC_25K_P = NULL) => -0.0160019474, 0.0000806557);

// Tree: 222 
wFDN_FLAPS__lgt_222 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 61.5) => -0.0038473504,
(f_addrchangecrimediff_i > 61.5) => 
   map(
   (NULL < c_health and c_health <= 11.15) => -0.0077333817,
   (c_health > 11.15) => 0.1548999857,
   (c_health = NULL) => 0.0571319498, 0.0571319498),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 130.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.85) => -0.0184378081,
      (c_unemp > 9.85) => -0.0999505931,
      (c_unemp = NULL) => -0.0218209587, -0.0218209587),
   (c_span_lang > 130.5) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 46.25) => 0.0158600331,
      (c_hh2_p > 46.25) => 0.1813515517,
      (c_hh2_p = NULL) => 0.0248314998, 0.0248314998),
   (c_span_lang = NULL) => 0.0127515874, -0.0014410844), -0.0024699561);

// Tree: 223 
wFDN_FLAPS__lgt_223 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 27204.5) => 0.0019213269,
(f_addrchangeincomediff_d > 27204.5) => -0.0527924342,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.37369805445) => -0.0181983487,
   (f_add_curr_nhood_MFD_pct_i > 0.37369805445) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 17.25) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0866976471,
         (f_hh_members_ct_d > 1.5) => -0.0197465769,
         (f_hh_members_ct_d = NULL) => 0.0138995858, 0.0138995858),
      (c_blue_col > 17.25) => 0.1325539599,
      (c_blue_col = NULL) => 0.0316784171, 0.0316784171),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < c_robbery and c_robbery <= 164) => -0.0073886567,
      (c_robbery > 164) => 0.1312935344,
      (c_robbery = NULL) => -0.0260528003, 0.0019554160), -0.0015961191), 0.0002831499);

// Tree: 224 
wFDN_FLAPS__lgt_224 := map(
(NULL < c_incollege and c_incollege <= 4.25) => -0.0142966343,
(c_incollege > 4.25) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 16.15) => 
      map(
      (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0033333569,
      (k_inf_nothing_found_i > 0.5) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 8.5) => 0.0984956752,
         (f_M_Bureau_ADL_FS_noTU_d > 8.5) => 
            map(
            (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 2.5) => 0.0210701058,
            (r_I61_inq_collection_count12_i > 2.5) => 0.1142080194,
            (r_I61_inq_collection_count12_i = NULL) => 0.0228791756, 0.0228791756),
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0251092760, 0.0251092760),
      (k_inf_nothing_found_i = NULL) => 0.0078995202, 0.0078995202),
   (c_pop_65_74_p > 16.15) => 0.1533955616,
   (c_pop_65_74_p = NULL) => 0.0099141333, 0.0099141333),
(c_incollege = NULL) => 0.0111459692, 0.0025763078);

// Tree: 225 
wFDN_FLAPS__lgt_225 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 14799) => -0.0887719040,
(r_A46_Curr_AVM_AutoVal_d > 14799) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 42.5) => -0.0020982049,
   (r_P88_Phn_Dst_to_Inp_Add_i > 42.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 3.55) => 0.2140371338,
      (c_incollege > 3.55) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 21.1) => -0.0484367790,
         (c_lowrent > 21.1) => 0.1576842981,
         (c_lowrent = NULL) => -0.0036278492, -0.0036278492),
      (c_incollege = NULL) => 0.0425886883, 0.0425886883),
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_rape and c_rape <= 127) => 0.0436196592,
      (c_rape > 127) => -0.0370778761,
      (c_rape = NULL) => 0.0289174889, 0.0289174889), 0.0074147615),
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0079577625, 0.0002279501);

// Tree: 226 
wFDN_FLAPS__lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 13.5) => -0.0087119699,
   (f_addrs_per_ssn_i > 13.5) => -0.1435413523,
   (f_addrs_per_ssn_i = NULL) => -0.0748048044, -0.0748048044),
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 54.5) => 0.1263441869,
      (r_C12_source_profile_d > 54.5) => -0.0215161546,
      (r_C12_source_profile_d = NULL) => 0.0542171910, 0.0542171910),
   (r_D33_Eviction_Recency_d > 30) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 181.5) => 0.0031197990,
      (c_asian_lang > 181.5) => -0.0298173010,
      (c_asian_lang = NULL) => -0.0022261298, -0.0017140990),
   (r_D33_Eviction_Recency_d = NULL) => -0.0011623226, -0.0011623226),
(r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0046564300, -0.0017861582);

// Tree: 227 
wFDN_FLAPS__lgt_227 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 14.5) => 
   map(
   (NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 1.5) => -0.0075543902,
   (k_inq_per_ssn_i > 1.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 8.45) => 0.0099576808,
      (c_unemp > 8.45) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.5216695986) => 0.1534660778,
         (f_add_curr_nhood_MFD_pct_i > 0.5216695986) => -0.0164115190,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0964748840, 0.0964748840),
      (c_unemp = NULL) => 0.0158951360, 0.0158951360),
   (k_inq_per_ssn_i = NULL) => -0.0027147631, -0.0027147631),
(r_D30_Derog_Count_i > 14.5) => 0.0712387464,
(r_D30_Derog_Count_i = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0690952466,
   (r_S66_adlperssn_count_i > 1.5) => 0.0438128420,
   (r_S66_adlperssn_count_i = NULL) => -0.0035357113, -0.0035357113), -0.0021747685);

// Tree: 228 
wFDN_FLAPS__lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 9.5) => -0.0014158080,
(f_assocsuspicousidcount_i > 9.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 278.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 4.5) => 0.0570003178,
      (f_rel_homeover300_count_d > 4.5) => 
         map(
         (NULL < c_newhouse and c_newhouse <= 6.15) => 0.0105902558,
         (c_newhouse > 6.15) => -0.1096778599,
         (c_newhouse = NULL) => -0.0509870194, -0.0509870194),
      (f_rel_homeover300_count_d = NULL) => -0.0088456195, -0.0088456195),
   (f_M_Bureau_ADL_FS_noTU_d > 278.5) => 
      map(
      (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 1.5) => -0.0296868806,
      (f_inq_Collection_count_i > 1.5) => -0.1407832771,
      (f_inq_Collection_count_i = NULL) => -0.0986432646, -0.0986432646),
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0460475011, -0.0460475011),
(f_assocsuspicousidcount_i = NULL) => -0.0081020104, -0.0027031419);

// Tree: 229 
wFDN_FLAPS__lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 11.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 473.75) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 19.45) => -0.0057808363,
         (c_hval_150k_p > 19.45) => 0.0317476551,
         (c_hval_150k_p = NULL) => -0.0019083329, -0.0019083329),
      (c_newhouse > 473.75) => 0.1505759708,
      (c_newhouse = NULL) => 0.0135314914, -0.0008351440),
   (f_crim_rel_under100miles_cnt_i > 11.5) => 0.0820612092,
   (f_crim_rel_under100miles_cnt_i = NULL) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','5: Vuln Vic/Friendly','6: Other']) => -0.0962545069,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity']) => 0.0800919817,
      (nf_seg_FraudPoint_3_0 = '') => -0.0088615568, -0.0088615568), -0.0004015912),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0663798521,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0254257816, -0.0033386848);

// Tree: 230 
wFDN_FLAPS__lgt_230 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < nf_vf_level and nf_vf_level <= 1.5) => 0.0056703656,
   (nf_vf_level > 1.5) => 
      map(
      (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => -0.0584498386,
      (f_phones_per_addr_c6_i > 0.5) => 
         map(
         (NULL < f_divsrchaddrsuspidcount_i and f_divsrchaddrsuspidcount_i <= 0.5) => 
            map(
            (NULL < c_low_ed and c_low_ed <= 19.2) => -0.1029164863,
            (c_low_ed > 19.2) => 0.0468400961,
            (c_low_ed = NULL) => 0.0250897353, 0.0250897353),
         (f_divsrchaddrsuspidcount_i > 0.5) => -0.0477156531,
         (f_divsrchaddrsuspidcount_i = NULL) => 0.0061858801, 0.0061858801),
      (f_phones_per_addr_c6_i = NULL) => -0.0268796933, -0.0268796933),
   (nf_vf_level = NULL) => -0.0046599617, 0.0025809868),
(f_bus_addr_match_count_d > 52.5) => 0.1461664538,
(f_bus_addr_match_count_d = NULL) => 0.0033167421, 0.0033167421);

// Tree: 231 
wFDN_FLAPS__lgt_231 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -268669.5) => -0.0960266970,
(f_addrchangevaluediff_d > -268669.5) => 0.0005501059,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 54.7) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 22.75) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 130500) => 0.0047310881,
         (k_estimated_income_d > 130500) => 0.1666980103,
         (k_estimated_income_d = NULL) => 0.0308281448, 0.0101386232),
      (c_blue_col > 22.75) => 
         map(
         (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 1.5) => 0.0404905245,
         (f_hh_tot_derog_i > 1.5) => 0.2261647031,
         (f_hh_tot_derog_i = NULL) => 0.1099604553, 0.1099604553),
      (c_blue_col = NULL) => 0.0165093318, 0.0165093318),
   (c_lowinc > 54.7) => -0.0591429330,
   (c_lowinc = NULL) => -0.0138454448, 0.0081428594), 0.0018348716);

// Tree: 232 
wFDN_FLAPS__lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1284827090,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < c_no_teens and c_no_teens <= 10.5) => -0.0474605397,
   (c_no_teens > 10.5) => 
      map(
      (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 24.5) => 0.0002309719,
      (f_rel_homeover200_count_d > 24.5) => 
         map(
         (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 11.5) => 0.1175523924,
         (f_rel_ageover40_count_d > 11.5) => -0.0272146266,
         (f_rel_ageover40_count_d = NULL) => 0.0538234329, 0.0538234329),
      (f_rel_homeover200_count_d = NULL) => -0.0157921901, 0.0008207971),
   (c_no_teens = NULL) => 0.0004983633, -0.0011655595),
(f_mos_liens_unrel_FT_lseen_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 13.25) => -0.0578336105,
   (c_hh4_p > 13.25) => 0.0497347507,
   (c_hh4_p = NULL) => -0.0093793938, -0.0093793938), -0.0006996281);

// Tree: 233 
wFDN_FLAPS__lgt_233 := map(
(NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 0.5) => -0.0542687925,
(f_corrssnaddrcount_d > 0.5) => 
   map(
   (NULL < f_corrssnaddrcount_d and f_corrssnaddrcount_d <= 2.5) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 15.75) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 9) => 0.0915803720,
         (r_pb_order_freq_d > 9) => 0.0231975078,
         (r_pb_order_freq_d = NULL) => -0.0178135748, 0.0140000611),
      (c_hval_250k_p > 15.75) => 
         map(
         (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.0119229778,
         (f_corrssnnamecount_d > 3.5) => 0.1488513883,
         (f_corrssnnamecount_d = NULL) => 0.0872011561, 0.0872011561),
      (c_hval_250k_p = NULL) => 0.0246345098, 0.0322767634),
   (f_corrssnaddrcount_d > 2.5) => -0.0084954292,
   (f_corrssnaddrcount_d = NULL) => -0.0055660097, -0.0055660097),
(f_corrssnaddrcount_d = NULL) => 0.0056411061, -0.0066298512);

// Tree: 234 
wFDN_FLAPS__lgt_234 := map(
(NULL < f_srchssnsrchcountmo_i and f_srchssnsrchcountmo_i <= 0.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0211638096,
   (f_util_add_curr_conv_n > 0.5) => 0.0048624710,
   (f_util_add_curr_conv_n = NULL) => -0.0067509006, -0.0067509006),
(f_srchssnsrchcountmo_i > 0.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 166.5) => 
      map(
      (NULL < c_food and c_food <= 1.3) => 0.1213576185,
      (c_food > 1.3) => 
         map(
         (NULL < f_rel_homeover50_count_d and f_rel_homeover50_count_d <= 14.5) => -0.0384017244,
         (f_rel_homeover50_count_d > 14.5) => 0.0570663903,
         (f_rel_homeover50_count_d = NULL) => -0.0172217122, -0.0172217122),
      (c_food = NULL) => 0.0033933948, 0.0033933948),
   (c_relig_indx > 166.5) => 0.1703405371,
   (c_relig_indx = NULL) => 0.0280827610, 0.0280827610),
(f_srchssnsrchcountmo_i = NULL) => 0.0259432486, -0.0053252468);

// Tree: 235 
wFDN_FLAPS__lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0794253224) => 0.0100745264,
   (f_add_curr_nhood_VAC_pct_i > 0.0794253224) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 11.5) => 0.1539365426,
      (r_C13_Curr_Addr_LRes_d > 11.5) => 
         map(
         (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 5.5) => 0.0823852529,
         (r_C14_addrs_15yr_i > 5.5) => -0.0898995489,
         (r_C14_addrs_15yr_i = NULL) => 0.0503046346, 0.0503046346),
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0813441433, 0.0813441433),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0225189049, 0.0225189049),
(f_hh_members_ct_d > 1.5) => -0.0074868581,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0578216712,
   (c_pop_35_44_p > 15.55) => 0.0546128685,
   (c_pop_35_44_p = NULL) => -0.0035100715, -0.0035100715), -0.0018401232);

// Tree: 236 
wFDN_FLAPS__lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.65) => -0.0385578962,
(c_pop_45_54_p > 7.65) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 12.45) => 0.0021536107,
      (c_unemp > 12.45) => -0.0777743730,
      (c_unemp = NULL) => 0.0013999216, 0.0013999216),
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corrssnnamecount_d and f_corrssnnamecount_d <= 3.5) => 0.1387479205,
      (f_corrssnnamecount_d > 3.5) => 
         map(
         (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => -0.0090869878,
         (r_F01_inp_addr_not_verified_i > 0.5) => 0.0964186250,
         (r_F01_inp_addr_not_verified_i = NULL) => 0.0051954314, 0.0051954314),
      (f_corrssnnamecount_d = NULL) => 0.0271292343, 0.0271292343),
   (f_rel_felony_count_i = NULL) => 0.0018804714, 0.0026333883),
(c_pop_45_54_p = NULL) => 0.0098900574, -0.0001144653);

// Tree: 237 
wFDN_FLAPS__lgt_237 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => -0.0042818066,
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 19.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 125.5) => 
         map(
         (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
            map(
            (NULL < c_hh00 and c_hh00 <= 503.5) => 0.2032653591,
            (c_hh00 > 503.5) => 0.0806934974,
            (c_hh00 = NULL) => 0.1289501358, 0.1289501358),
         (r_I60_Inq_Count12_i > 0.5) => 0.0226587414,
         (r_I60_Inq_Count12_i = NULL) => 0.0764396461, 0.0764396461),
      (c_lux_prod > 125.5) => -0.0101806367,
      (c_lux_prod = NULL) => 0.0413399581, 0.0413399581),
   (f_phones_per_addr_curr_i > 19.5) => -0.0345652446,
   (f_phones_per_addr_curr_i = NULL) => 0.0196887228, 0.0196887228),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0031234357, -0.0031234357);

// Tree: 238 
wFDN_FLAPS__lgt_238 := map(
(NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 1.5) => 
   map(
   (NULL < f_addrs_per_ssn_c6_i and f_addrs_per_ssn_c6_i <= 1.5) => -0.0052242628,
   (f_addrs_per_ssn_c6_i > 1.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.85) => 0.1390403150,
      (c_pop_55_64_p > 8.85) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 68.45) => -0.0994946516,
         (C_OWNOCC_P > 68.45) => 0.1054537071,
         (C_OWNOCC_P = NULL) => -0.0009617868, -0.0009617868),
      (c_pop_55_64_p = NULL) => 0.0567791930, 0.0567791930),
   (f_addrs_per_ssn_c6_i = NULL) => -0.0043131026, -0.0043131026),
(f_srchaddrsrchcountwk_i > 1.5) => -0.0801934009,
(f_srchaddrsrchcountwk_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 85.5) => 0.0643129583,
   (c_many_cars > 85.5) => -0.0388234808,
   (c_many_cars = NULL) => 0.0094330182, 0.0094330182), -0.0045027920);

// Tree: 239 
wFDN_FLAPS__lgt_239 := map(
(NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 30.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 23.5) => -0.0025903639,
   (f_rel_homeover300_count_d > 23.5) => 0.1322118307,
   (f_rel_homeover300_count_d = NULL) => -0.0020193543, -0.0020193543),
(f_rel_homeover200_count_d > 30.5) => -0.0905223217,
(f_rel_homeover200_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 33.45) => -0.1003699347,
   (c_sfdu_p > 33.45) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < f_util_add_curr_misc_n and f_util_add_curr_misc_n <= 0.5) => 0.1220440058,
         (f_util_add_curr_misc_n > 0.5) => 0.0147658394,
         (f_util_add_curr_misc_n = NULL) => 0.0776808543, 0.0776808543),
      (k_nap_phn_verd_d > 0.5) => -0.0580207258,
      (k_nap_phn_verd_d = NULL) => 0.0275162892, 0.0275162892),
   (c_sfdu_p = NULL) => -0.0124741913, -0.0124741913), -0.0029409625);

// Tree: 240 
wFDN_FLAPS__lgt_240 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 6.75) => 
   map(
   (NULL < f_addrs_per_ssn_i and f_addrs_per_ssn_i <= 28.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 49.45) => 
         map(
         (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 5.5) => 0.0099617814,
         (f_inq_HighRiskCredit_count24_i > 5.5) => 0.0815422412,
         (f_inq_HighRiskCredit_count24_i = NULL) => 0.0030750383, 0.0104230677),
      (c_famotf18_p > 49.45) => 
         map(
         (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 27034.5) => 0.0099689117,
         (f_prevaddrmedianincome_d > 27034.5) => 0.1416210011,
         (f_prevaddrmedianincome_d = NULL) => 0.0827240137, 0.0827240137),
      (c_famotf18_p = NULL) => 0.0113841969, 0.0113841969),
   (f_addrs_per_ssn_i > 28.5) => -0.1287142315,
   (f_addrs_per_ssn_i = NULL) => 0.0104591495, 0.0104591495),
(c_hval_100k_p > 6.75) => -0.0152009857,
(c_hval_100k_p = NULL) => -0.0277130420, 0.0028898769);

// Tree: 241 
wFDN_FLAPS__lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0019606551,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 24.85) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 2.75) => 
         map(
         (NULL < c_robbery and c_robbery <= 76) => 0.2259109973,
         (c_robbery > 76) => 0.0241146737,
         (c_robbery = NULL) => 0.1035620452, 0.1035620452),
      (C_INC_150K_P > 2.75) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0432874014) => 0.1283602232,
         (f_add_input_nhood_MFD_pct_i > 0.0432874014) => -0.0272547827,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0178893889, 0.0222147593),
      (C_INC_150K_P = NULL) => 0.0370370051, 0.0370370051),
   (c_hh3_p > 24.85) => 0.1757667532,
   (c_hh3_p = NULL) => 0.0495335490, 0.0495335490),
(k_comb_age_d = NULL) => -0.0000803783, 0.0012367243);

// Tree: 242 
wFDN_FLAPS__lgt_242 := map(
(NULL < k_inq_per_ssn_i and k_inq_per_ssn_i <= 2.5) => -0.0017869279,
(k_inq_per_ssn_i > 2.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2883758142) => 
      map(
      (NULL < c_rnt2000_p and c_rnt2000_p <= 2.95) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.22196304075) => 0.0764977149,
         (f_add_curr_mobility_index_i > 0.22196304075) => 0.0022569043,
         (f_add_curr_mobility_index_i = NULL) => 0.0364051477, 0.0364051477),
      (c_rnt2000_p > 2.95) => -0.0483598444,
      (c_rnt2000_p = NULL) => 0.0094878581, 0.0094878581),
   (f_add_input_mobility_index_i > 0.2883758142) => 
      map(
      (NULL < f_inq_RetailPayments_cnt_i and f_inq_RetailPayments_cnt_i <= 0.5) => 0.0412254158,
      (f_inq_RetailPayments_cnt_i > 0.5) => 0.1748372746,
      (f_inq_RetailPayments_cnt_i = NULL) => 0.0570289690, 0.0570289690),
   (f_add_input_mobility_index_i = NULL) => 0.0298224594, 0.0298224594),
(k_inq_per_ssn_i = NULL) => 0.0020306189, 0.0020306189);

// Tree: 243 
wFDN_FLAPS__lgt_243 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < c_info and c_info <= 27.85) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 87.4) => 0.0011119837,
      (r_C12_source_profile_d > 87.4) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 92.5) => 0.2195951161,
         (c_exp_prod > 92.5) => -0.0198419364,
         (c_exp_prod = NULL) => 0.0772271389, 0.0772271389),
      (r_C12_source_profile_d = NULL) => -0.0026270541, 0.0020074635),
   (c_info > 27.85) => 0.1472259433,
   (c_info = NULL) => 0.0180715702, 0.0030991604),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < c_young and c_young <= 23.5) => 0.0288566220,
   (c_young > 23.5) => 0.1973815811,
   (c_young = NULL) => 0.0833794028, 0.0833794028),
(f_adls_per_phone_c6_i = NULL) => 0.0041813773, 0.0041813773);

// Tree: 244 
wFDN_FLAPS__lgt_244 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 121) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 56.05) => -0.0461937302,
   (c_fammar_p > 56.05) => -0.0075895004,
   (c_fammar_p = NULL) => 0.0077074411, -0.0101233395),
(f_curraddrcrimeindex_i > 121) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0098791956,
   (f_corrrisktype_i > 7.5) => 
      map(
      (NULL < c_hh00 and c_hh00 <= 870.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1116717019,
         (r_Phn_Cell_n > 0.5) => 0.0336760330,
         (r_Phn_Cell_n = NULL) => 0.0675575335, 0.0675575335),
      (c_hh00 > 870.5) => -0.0719920476,
      (c_hh00 = NULL) => 0.0439050621, 0.0439050621),
   (f_corrrisktype_i = NULL) => 0.0141971464, 0.0141971464),
(f_curraddrcrimeindex_i = NULL) => -0.0051484474, -0.0037749731);

// Tree: 245 
wFDN_FLAPS__lgt_245 := map(
(NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 16) => -0.0309158436,
(f_curraddrburglaryindex_i > 16) => 
   map(
   (NULL < c_hh5_p and c_hh5_p <= 18.65) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 52052) => 0.0599377823,
      (f_curraddrmedianvalue_d > 52052) => 0.0009196334,
      (f_curraddrmedianvalue_d = NULL) => 0.0025324950, 0.0025324950),
   (c_hh5_p > 18.65) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0248557536,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 0.1516806131,
      (nf_seg_FraudPoint_3_0 = '') => 0.0499341157, 0.0499341157),
   (c_hh5_p = NULL) => 0.0041047028, 0.0041047028),
(f_curraddrburglaryindex_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.2704474601) => 0.0324297868,
   (f_add_input_mobility_index_i > 0.2704474601) => -0.0586929812,
   (f_add_input_mobility_index_i = NULL) => -0.0107749739, -0.0107749739), -0.0011628350);

// Tree: 246 
wFDN_FLAPS__lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.255) => 
   map(
   (NULL < c_hval_40k_p and c_hval_40k_p <= 21.95) => -0.0012858576,
   (c_hval_40k_p > 21.95) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 186.5) => 
         map(
         (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 1.5) => 0.2915470849,
         (f_srchvelocityrisktype_i > 1.5) => 0.0324555664,
         (f_srchvelocityrisktype_i = NULL) => 0.1040278091, 0.1040278091),
      (f_curraddrburglaryindex_i > 186.5) => -0.0419332993,
      (f_curraddrburglaryindex_i = NULL) => 0.0645947677, 0.0645947677),
   (c_hval_40k_p = NULL) => 0.0000702866, 0.0000702866),
(c_hhsize > 4.255) => 
   map(
   (NULL < c_rnt2000_p and c_rnt2000_p <= 3.45) => -0.0253714884,
   (c_rnt2000_p > 3.45) => 0.1392498154,
   (c_rnt2000_p = NULL) => 0.0627722018, 0.0627722018),
(c_hhsize = NULL) => -0.0264864326, 0.0000364845);

// Tree: 247 
wFDN_FLAPS__lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.16390897925) => 
         map(
         (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 1.5) => -0.0563936085,
         (f_phones_per_addr_c6_i > 1.5) => 0.0078552412,
         (f_phones_per_addr_c6_i = NULL) => -0.0414482377, -0.0414482377),
      (f_add_curr_nhood_BUS_pct_i > 0.16390897925) => 0.0476212169,
      (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0320778086, -0.0320778086),
   (nf_vf_hi_risk_index > 5.5) => 0.0007660887,
   (nf_vf_hi_risk_index = NULL) => -0.0016602834, -0.0016602834),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0870218632,
(f_inq_HighRiskCredit_count_i = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 9.95) => -0.0607397586,
   (c_retail > 9.95) => 0.0419912314,
   (c_retail = NULL) => -0.0051330759, -0.0051330759), -0.0020279600);

// Tree: 248 
wFDN_FLAPS__lgt_248 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 11.5) => 0.0014957979,
(f_rel_under100miles_cnt_d > 11.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 13.85) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 40.6) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0964572291,
         (r_I60_inq_hiRiskCred_recency_d > 9) => -0.0251583811,
         (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0275641705, -0.0275641705),
      (c_famotf18_p > 40.6) => -0.1136266477,
      (c_famotf18_p = NULL) => -0.0303321373, -0.0303321373),
   (c_pop_0_5_p > 13.85) => 0.0501283204,
   (c_pop_0_5_p = NULL) => -0.0239877166, -0.0239877166),
(f_rel_under100miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 181950.5) => 0.0899694845,
   (r_L80_Inp_AVM_AutoVal_d > 181950.5) => 0.0114072085,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0196573634, 0.0071879977), -0.0028461614);

// Tree: 249 
wFDN_FLAPS__lgt_249 := map(
(NULL < f_inq_Banking_count24_i and f_inq_Banking_count24_i <= 8.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 156.5) => -0.0024797230,
   (c_born_usa > 156.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 52.05) => 
         map(
         (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 1.5) => 0.1135709321,
         (f_property_owners_ct_d > 1.5) => 0.0283504449,
         (f_property_owners_ct_d = NULL) => 0.0762170703, 0.0762170703),
      (c_civ_emp > 52.05) => 0.0052096834,
      (c_civ_emp = NULL) => 0.0221926177, 0.0221926177),
   (c_born_usa = NULL) => 0.0067485309, 0.0008664709),
(f_inq_Banking_count24_i > 8.5) => -0.1217958777,
(f_inq_Banking_count24_i = NULL) => 
   map(
   (NULL < c_white_col and c_white_col <= 42.75) => -0.0580410783,
   (c_white_col > 42.75) => 0.0320872488,
   (c_white_col = NULL) => -0.0181482122, -0.0181482122), 0.0001539260);

// Tree: 250 
wFDN_FLAPS__lgt_250 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 19.85) => -0.0029541250,
(C_INC_50K_P > 19.85) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 2.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 18.5) => 0.1105089357,
      (c_many_cars > 18.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 20.55) => 0.1035072685,
         (C_INC_50K_P > 20.55) => -0.0134516615,
         (C_INC_50K_P = NULL) => 0.0086069139, 0.0086069139),
      (c_many_cars = NULL) => 0.0170341723, 0.0170341723),
   (f_crim_rel_under25miles_cnt_i > 2.5) => 
      map(
      (NULL < c_pop_85p_p and c_pop_85p_p <= 0.95) => 0.0125096785,
      (c_pop_85p_p > 0.95) => 0.1574373678,
      (c_pop_85p_p = NULL) => 0.0726392517, 0.0726392517),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0254646199, 0.0254646199),
(C_INC_50K_P = NULL) => 0.0062760637, 0.0001104758);

// Tree: 251 
wFDN_FLAPS__lgt_251 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 1334) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 105) => 
         map(
         (NULL < c_totcrime and c_totcrime <= 79.5) => 0.0617176644,
         (c_totcrime > 79.5) => -0.0648359680,
         (c_totcrime = NULL) => -0.0484584391, -0.0484584391),
      (c_exp_prod > 105) => 
         map(
         (NULL < c_young and c_young <= 25.8) => -0.0194265448,
         (c_young > 25.8) => 0.1778444064,
         (c_young = NULL) => 0.0499584105, 0.0499584105),
      (c_exp_prod = NULL) => -0.0266715029, -0.0266715029),
   (C_INC_150K_P > 0.55) => 0.0090988344,
   (C_INC_150K_P = NULL) => -0.0177177489, 0.0066353148),
(f_liens_rel_SC_total_amt_i > 1334) => -0.1237099949,
(f_liens_rel_SC_total_amt_i = NULL) => -0.0251472315, 0.0058131048);

// Tree: 252 
wFDN_FLAPS__lgt_252 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => 0.0012189411,
   (r_C14_Addr_Stability_v2_d > 5.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 4653.5) => 0.0347008483,
         (r_A49_Curr_AVM_Chg_1yr_i > 4653.5) => 
            map(
            (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.9432010135) => 0.0431157095,
            (f_add_input_nhood_SFD_pct_d > 0.9432010135) => 0.2144136093,
            (f_add_input_nhood_SFD_pct_d = NULL) => 0.1052489528, 0.1052489528),
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0287914063, 0.0513826980),
      (f_corrphonelastnamecount_d > 0.5) => 0.0014177847,
      (f_corrphonelastnamecount_d = NULL) => 0.0312109127, 0.0312109127),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0126005581, 0.0126005581),
(f_phone_ver_insurance_d > 3.5) => -0.0096470383,
(f_phone_ver_insurance_d = NULL) => -0.0072520855, 0.0015747646);

// Tree: 253 
wFDN_FLAPS__lgt_253 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 5.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 31.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 43.55) => 0.0026208433,
      (c_famotf18_p > 43.55) => -0.0412224549,
      (c_famotf18_p = NULL) => 0.0118125968, 0.0018433634),
   (f_rel_under500miles_cnt_d > 31.5) => -0.0669467096,
   (f_rel_under500miles_cnt_d = NULL) => 0.0078997191, 0.0008687325),
(r_D34_unrel_liens_ct_i > 5.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 31.25) => -0.1306883659,
   (c_hh2_p > 31.25) => -0.0384641570,
   (c_hh2_p = NULL) => -0.0735971889, -0.0735971889),
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 102.5) => 0.0390946449,
   (c_medi_indx > 102.5) => -0.0633038638,
   (c_medi_indx = NULL) => -0.0135137633, -0.0135137633), -0.0001316086);

// Tree: 254 
wFDN_FLAPS__lgt_254 := map(
(NULL < c_fammar18_p and c_fammar18_p <= 37.45) => -0.0131963143,
(c_fammar18_p > 37.45) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 135.5) => 0.0020933274,
   (c_serv_empl > 135.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 26.05) => 
         map(
         (NULL < c_robbery and c_robbery <= 132.5) => 
            map(
            (NULL < c_rnt750_p and c_rnt750_p <= 54.15) => 0.0443661534,
            (c_rnt750_p > 54.15) => 0.2115246558,
            (c_rnt750_p = NULL) => 0.0601451270, 0.0601451270),
         (c_robbery > 132.5) => -0.0214403926,
         (c_robbery = NULL) => 0.0332727452, 0.0332727452),
      (c_famotf18_p > 26.05) => 0.1437355623,
      (c_famotf18_p = NULL) => 0.0409013928, 0.0409013928),
   (c_serv_empl = NULL) => 0.0097911464, 0.0097911464),
(c_fammar18_p = NULL) => 0.0388321199, -0.0020236679);

// Tree: 255 
wFDN_FLAPS__lgt_255 := map(
(NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0763535132,
   (f_mos_liens_unrel_FT_lseen_d > 184) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0002766928,
      (f_inq_Other_count24_i > 3.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 9.55) => 0.0144343599,
         (c_pop_18_24_p > 9.55) => 0.1628738443,
         (c_pop_18_24_p = NULL) => 0.0649669503, 0.0649669503),
      (f_inq_Other_count24_i = NULL) => 0.0012704715, 0.0012704715),
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0004588316, 0.0004588316),
(f_hh_lienholders_i > 3.5) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 1538.5) => -0.0331183989,
   (c_pop00 > 1538.5) => 0.1353351201,
   (c_pop00 = NULL) => 0.0631407548, 0.0631407548),
(f_hh_lienholders_i = NULL) => -0.0036058139, 0.0010200292);

// Tree: 256 
wFDN_FLAPS__lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 72.5) => -0.0242832433,
(r_C13_max_lres_d > 72.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 1.85) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 35.5) => -0.0599396820,
      (f_mos_inq_banko_cm_fseen_d > 35.5) => 
         map(
         (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0033064958,
         (f_inq_HighRiskCredit_count_i > 2.5) => 0.0726052804,
         (f_inq_HighRiskCredit_count_i = NULL) => -0.0015922472, -0.0015922472),
      (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0063138635, -0.0063138635),
   (c_rnt1250_p > 1.85) => 0.0222363651,
   (c_rnt1250_p = NULL) => -0.0532791516, 0.0065581814),
(r_C13_max_lres_d = NULL) => 
   map(
   (NULL < c_preschl and c_preschl <= 112) => -0.0466260667,
   (c_preschl > 112) => 0.0621484721,
   (c_preschl = NULL) => 0.0035048077, 0.0035048077), -0.0003885603);

// Tree: 257 
wFDN_FLAPS__lgt_257 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 37500) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0035026377) => 0.2263157224,
   (f_add_input_nhood_MFD_pct_i > 0.0035026377) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0012484138,
      (f_corrrisktype_i > 7.5) => 
         map(
         (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 0.0210502550,
         (f_bus_name_nover_i > 0.5) => 0.0999530482,
         (f_bus_name_nover_i = NULL) => 0.0477379645, 0.0477379645),
      (f_corrrisktype_i = NULL) => 0.0081327549, 0.0081327549),
   (f_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < c_transport and c_transport <= 0.1) => -0.0559749553,
      (c_transport > 0.1) => 0.1384645770,
      (c_transport = NULL) => 0.0287782090, 0.0103641166), 0.0125134573),
(k_estimated_income_d > 37500) => -0.0074570090,
(k_estimated_income_d = NULL) => 0.0333752759, -0.0026334526);

// Tree: 258 
wFDN_FLAPS__lgt_258 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 111607.5) => -0.0061220668,
(f_addrchangevaluediff_d > 111607.5) => 
   map(
   (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 190797) => 0.1375178371,
   (f_curraddrmedianvalue_d > 190797) => -0.0021228122,
   (f_curraddrmedianvalue_d = NULL) => 0.0403765158, 0.0403765158),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 121051) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.221422329) => -0.0206007361,
      (f_add_curr_nhood_MFD_pct_i > 0.221422329) => 0.1278235531,
      (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0816899798, 0.0471492811),
   (r_L80_Inp_AVM_AutoVal_d > 121051) => -0.0021177966,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 43000) => 0.0074309317,
      (r_A49_Curr_AVM_Chg_1yr_i > 43000) => 0.1615694462,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0160165364, -0.0059955388), 0.0020655145), -0.0035650461);

// Tree: 259 
wFDN_FLAPS__lgt_259 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
   map(
   (NULL < c_old_homes and c_old_homes <= 160.5) => -0.0006790328,
   (c_old_homes > 160.5) => 
      map(
      (NULL < nf_vf_type and nf_vf_type <= 2.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 8.55) => -0.0290946643,
         (c_hh7p_p > 8.55) => 0.1053056560,
         (c_hh7p_p = NULL) => -0.0236481674, -0.0236481674),
      (nf_vf_type > 2.5) => -0.1073423244,
      (nf_vf_type = NULL) => -0.0270457003, -0.0270457003),
   (c_old_homes = NULL) => -0.0440336353, -0.0053666787),
(r_D33_eviction_count_i > 4.5) => -0.0781381186,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.05) => -0.0263134541,
   (c_pop_55_64_p > 11.05) => 0.0695080032,
   (c_pop_55_64_p = NULL) => 0.0152834576, 0.0152834576), -0.0054649154);

// Tree: 260 
wFDN_FLAPS__lgt_260 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 27.75) => -0.0034152241,
(c_hval_750k_p > 27.75) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 76.5) => 0.0041761817,
   (f_curraddrmurderindex_i > 76.5) => 
      map(
      (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 2.5) => 
         map(
         (NULL < c_employees and c_employees <= 41.5) => 0.1233181918,
         (c_employees > 41.5) => 0.0125738210,
         (c_employees = NULL) => 0.0279610036, 0.0279610036),
      (f_bus_addr_match_count_d > 2.5) => 
         map(
         (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.2646580856,
         (k_nap_phn_verd_d > 0.5) => 0.1100361588,
         (k_nap_phn_verd_d = NULL) => 0.1654867809, 0.1654867809),
      (f_bus_addr_match_count_d = NULL) => 0.0583592318, 0.0583592318),
   (f_curraddrmurderindex_i = NULL) => 0.0248293373, 0.0248293373),
(c_hval_750k_p = NULL) => -0.0088361898, 0.0003254756);

// Tree: 261 
wFDN_FLAPS__lgt_261 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 23.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 9.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 0.0063970298,
      (f_inq_HighRiskCredit_count_i > 16.5) => 0.0824669003,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0067412984, 0.0067412984),
   (f_rel_homeover300_count_d > 9.5) => -0.0276358305,
   (f_rel_homeover300_count_d = NULL) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 11.5) => 0.0969073266,
      (f_M_Bureau_ADL_FS_all_d > 11.5) => -0.0648474638,
      (f_M_Bureau_ADL_FS_all_d = NULL) => -0.0149529513, -0.0149529513), 0.0035223896),
(f_srchphonesrchcount_i > 23.5) => -0.1014778500,
(f_srchphonesrchcount_i = NULL) => 
   map(
   (NULL < c_hval_175k_p and c_hval_175k_p <= 2.4) => -0.0474408850,
   (c_hval_175k_p > 2.4) => 0.0579743069,
   (c_hval_175k_p = NULL) => 0.0099727463, 0.0099727463), 0.0031607483);

// Tree: 262 
wFDN_FLAPS__lgt_262 := map(
(NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 1.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0008274255,
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 229) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 178.5) => 
            map(
            (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0564501080,
            (f_phone_ver_experian_d > 0.5) => -0.0056101766,
            (f_phone_ver_experian_d = NULL) => 0.0628891149, 0.0352124643),
         (c_span_lang > 178.5) => -0.0440030915,
         (c_span_lang = NULL) => 0.0235831072, 0.0235831072),
      (r_C13_Curr_Addr_LRes_d > 229) => -0.1023737137,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0154426664, 0.0154426664),
   (f_inq_Communications_count_i = NULL) => 0.0021642565, 0.0021642565),
(f_srchaddrsrchcountwk_i > 1.5) => -0.0797247889,
(f_srchaddrsrchcountwk_i = NULL) => -0.0260360300, 0.0015475126);

// Tree: 263 
wFDN_FLAPS__lgt_263 := map(
(NULL < c_retail and c_retail <= 33.25) => 0.0014470937,
(c_retail > 33.25) => 
   map(
   (NULL < c_larceny and c_larceny <= 157.5) => 
      map(
      (NULL < c_rnt1250_p and c_rnt1250_p <= 19.5) => -0.0067124067,
      (c_rnt1250_p > 19.5) => 
         map(
         (NULL < c_popover25 and c_popover25 <= 1225) => 0.2284953012,
         (c_popover25 > 1225) => 0.0064423417,
         (c_popover25 = NULL) => 0.0782033591, 0.0782033591),
      (c_rnt1250_p = NULL) => 0.0143878745, 0.0143878745),
   (c_larceny > 157.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0378057654) => 0.2334230558,
      (f_add_curr_nhood_VAC_pct_i > 0.0378057654) => 0.0261427658,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.1287567707, 0.1287567707),
   (c_larceny = NULL) => 0.0298269260, 0.0298269260),
(c_retail = NULL) => 0.0069259408, 0.0032806857);

// Tree: 264 
wFDN_FLAPS__lgt_264 := map(
(NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 2.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -31659) => -0.0651989552,
   (f_addrchangeincomediff_d > -31659) => 
      map(
      (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 0.0017726294,
      (r_D32_criminal_count_i > 10.5) => 0.1108260033,
      (r_D32_criminal_count_i = NULL) => 0.0024894121, 0.0024894121),
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 151.5) => -0.0008255285,
      (c_easiqlife > 151.5) => 
         map(
         (NULL < c_unattach and c_unattach <= 84.5) => -0.0164482064,
         (c_unattach > 84.5) => 0.1123479111,
         (c_unattach = NULL) => 0.0729839502, 0.0729839502),
      (c_easiqlife = NULL) => 0.0083310055, 0.0100382229), 0.0033724712),
(nf_vf_hi_addr_add_entries > 2.5) => 0.0951482525,
(nf_vf_hi_addr_add_entries = NULL) => -0.0090283553, 0.0036323563);

// Tree: 265 
wFDN_FLAPS__lgt_265 := map(
(NULL < c_exp_homes and c_exp_homes <= 196.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 4.5) => 0.0004676121,
   (k_inq_per_phone_i > 4.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => -0.0091779141,
      (r_Phn_Cell_n > 0.5) => 0.0949529832,
      (r_Phn_Cell_n = NULL) => 0.0342782871, 0.0342782871),
   (k_inq_per_phone_i = NULL) => 0.0011742616, 0.0011742616),
(c_exp_homes > 196.5) => 
   map(
   (NULL < c_rnt2001_p and c_rnt2001_p <= 22.65) => -0.0202595682,
   (c_rnt2001_p > 22.65) => 
      map(
      (NULL < c_rich_old and c_rich_old <= 193.5) => 0.0510511988,
      (c_rich_old > 193.5) => 0.3026978441,
      (c_rich_old = NULL) => 0.1572146273, 0.1572146273),
   (c_rnt2001_p = NULL) => 0.0677896451, 0.0677896451),
(c_exp_homes = NULL) => -0.0051037507, 0.0023935437);

// Tree: 266 
wFDN_FLAPS__lgt_266 := map(
(NULL < c_med_rent and c_med_rent <= 1970) => 
   map(
   (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0061781449,
   (r_L70_Add_Standardized_i > 0.5) => 
      map(
      (NULL < c_totcrime and c_totcrime <= 163.5) => 0.0094332208,
      (c_totcrime > 163.5) => 0.1279207733,
      (c_totcrime = NULL) => 0.0290287367, 0.0290287367),
   (r_L70_Add_Standardized_i = NULL) => -0.0035259321, -0.0035259321),
(c_med_rent > 1970) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 107.5) => -0.0000995485,
   (r_C13_Curr_Addr_LRes_d > 107.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 38.5) => 0.2668706323,
      (c_born_usa > 38.5) => 0.0255318536,
      (c_born_usa = NULL) => 0.1070228698, 0.1070228698),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0474418129, 0.0474418129),
(c_med_rent = NULL) => -0.0116379497, -0.0023036424);

// Tree: 267 
wFDN_FLAPS__lgt_267 := map(
(NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 25.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 0.5) => 0.2056541453,
      (f_phone_ver_insurance_d > 0.5) => 0.0254776325,
      (f_phone_ver_insurance_d = NULL) => 0.0799496015, 0.0799496015),
   (r_C13_max_lres_d > 25.5) => 0.0056282087,
   (r_C13_max_lres_d = NULL) => -0.0056140891, 0.0074044817),
(r_Phn_Cell_n > 0.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 40.5) => 
      map(
      (NULL < c_hh7p_p and c_hh7p_p <= 4.15) => 0.0062509539,
      (c_hh7p_p > 4.15) => 0.1273821288,
      (c_hh7p_p = NULL) => 0.0211150358, 0.0211150358),
   (f_mos_inq_banko_om_fseen_d > 40.5) => -0.0220695572,
   (f_mos_inq_banko_om_fseen_d = NULL) => -0.0179740896, -0.0179740896),
(r_Phn_Cell_n = NULL) => -0.0045255475, -0.0045255475);

// Tree: 268 
wFDN_FLAPS__lgt_268 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 14.05) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 42.05) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => 0.0113056292,
      (f_srchaddrsrchcount_i > 12.5) => 
         map(
         (NULL < c_rich_old and c_rich_old <= 143.5) => 0.0252709345,
         (c_rich_old > 143.5) => 0.1686648948,
         (c_rich_old = NULL) => 0.0562625323, 0.0562625323),
      (f_srchaddrsrchcount_i = NULL) => -0.0185475382, 0.0130106013),
   (c_high_ed > 42.05) => -0.0172141272,
   (c_high_ed = NULL) => 0.0030373907, 0.0030373907),
(C_INC_25K_P > 14.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 8.5) => -0.0160624417,
   (r_D30_Derog_Count_i > 8.5) => -0.0918588204,
   (r_D30_Derog_Count_i = NULL) => -0.0187347499, -0.0187347499),
(C_INC_25K_P = NULL) => -0.0192987757, -0.0007241426);

// Tree: 269 
wFDN_FLAPS__lgt_269 := map(
(NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.92069352025) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 3.5) => -0.0196114182,
   (f_corrrisktype_i > 3.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 98) => 
            map(
            (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 79.45) => 0.0357484031,
            (r_C12_source_profile_d > 79.45) => 0.1730802482,
            (r_C12_source_profile_d = NULL) => 0.0492190246, 0.0492190246),
         (f_prevaddrmurderindex_i > 98) => -0.0001891907,
         (f_prevaddrmurderindex_i = NULL) => 0.0270509940, 0.0270509940),
      (f_phone_ver_experian_d > 0.5) => -0.0111141429,
      (f_phone_ver_experian_d = NULL) => 0.0157978978, 0.0100046892),
   (f_corrrisktype_i = NULL) => -0.0018930318, -0.0018930318),
(f_add_curr_nhood_MFD_pct_i > 0.92069352025) => -0.0325462349,
(f_add_curr_nhood_MFD_pct_i = NULL) => -0.0192414671, -0.0064118364);

// Final Score Sum 

   wFDN_FLAPS__lgt := sum(
      wFDN_FLAPS__lgt_0, wFDN_FLAPS__lgt_1, wFDN_FLAPS__lgt_2, wFDN_FLAPS__lgt_3, wFDN_FLAPS__lgt_4, 
      wFDN_FLAPS__lgt_5, wFDN_FLAPS__lgt_6, wFDN_FLAPS__lgt_7, wFDN_FLAPS__lgt_8, wFDN_FLAPS__lgt_9, 
      wFDN_FLAPS__lgt_10, wFDN_FLAPS__lgt_11, wFDN_FLAPS__lgt_12, wFDN_FLAPS__lgt_13, wFDN_FLAPS__lgt_14, 
      wFDN_FLAPS__lgt_15, wFDN_FLAPS__lgt_16, wFDN_FLAPS__lgt_17, wFDN_FLAPS__lgt_18, wFDN_FLAPS__lgt_19, 
      wFDN_FLAPS__lgt_20, wFDN_FLAPS__lgt_21, wFDN_FLAPS__lgt_22, wFDN_FLAPS__lgt_23, wFDN_FLAPS__lgt_24, 
      wFDN_FLAPS__lgt_25, wFDN_FLAPS__lgt_26, wFDN_FLAPS__lgt_27, wFDN_FLAPS__lgt_28, wFDN_FLAPS__lgt_29, 
      wFDN_FLAPS__lgt_30, wFDN_FLAPS__lgt_31, wFDN_FLAPS__lgt_32, wFDN_FLAPS__lgt_33, wFDN_FLAPS__lgt_34, 
      wFDN_FLAPS__lgt_35, wFDN_FLAPS__lgt_36, wFDN_FLAPS__lgt_37, wFDN_FLAPS__lgt_38, wFDN_FLAPS__lgt_39, 
      wFDN_FLAPS__lgt_40, wFDN_FLAPS__lgt_41, wFDN_FLAPS__lgt_42, wFDN_FLAPS__lgt_43, wFDN_FLAPS__lgt_44, 
      wFDN_FLAPS__lgt_45, wFDN_FLAPS__lgt_46, wFDN_FLAPS__lgt_47, wFDN_FLAPS__lgt_48, wFDN_FLAPS__lgt_49, 
      wFDN_FLAPS__lgt_50, wFDN_FLAPS__lgt_51, wFDN_FLAPS__lgt_52, wFDN_FLAPS__lgt_53, wFDN_FLAPS__lgt_54, 
      wFDN_FLAPS__lgt_55, wFDN_FLAPS__lgt_56, wFDN_FLAPS__lgt_57, wFDN_FLAPS__lgt_58, wFDN_FLAPS__lgt_59, 
      wFDN_FLAPS__lgt_60, wFDN_FLAPS__lgt_61, wFDN_FLAPS__lgt_62, wFDN_FLAPS__lgt_63, wFDN_FLAPS__lgt_64, 
      wFDN_FLAPS__lgt_65, wFDN_FLAPS__lgt_66, wFDN_FLAPS__lgt_67, wFDN_FLAPS__lgt_68, wFDN_FLAPS__lgt_69, 
      wFDN_FLAPS__lgt_70, wFDN_FLAPS__lgt_71, wFDN_FLAPS__lgt_72, wFDN_FLAPS__lgt_73, wFDN_FLAPS__lgt_74, 
      wFDN_FLAPS__lgt_75, wFDN_FLAPS__lgt_76, wFDN_FLAPS__lgt_77, wFDN_FLAPS__lgt_78, wFDN_FLAPS__lgt_79, 
      wFDN_FLAPS__lgt_80, wFDN_FLAPS__lgt_81, wFDN_FLAPS__lgt_82, wFDN_FLAPS__lgt_83, wFDN_FLAPS__lgt_84, 
      wFDN_FLAPS__lgt_85, wFDN_FLAPS__lgt_86, wFDN_FLAPS__lgt_87, wFDN_FLAPS__lgt_88, wFDN_FLAPS__lgt_89, 
      wFDN_FLAPS__lgt_90, wFDN_FLAPS__lgt_91, wFDN_FLAPS__lgt_92, wFDN_FLAPS__lgt_93, wFDN_FLAPS__lgt_94, 
      wFDN_FLAPS__lgt_95, wFDN_FLAPS__lgt_96, wFDN_FLAPS__lgt_97, wFDN_FLAPS__lgt_98, wFDN_FLAPS__lgt_99, 
      wFDN_FLAPS__lgt_100, wFDN_FLAPS__lgt_101, wFDN_FLAPS__lgt_102, wFDN_FLAPS__lgt_103, wFDN_FLAPS__lgt_104, 
      wFDN_FLAPS__lgt_105, wFDN_FLAPS__lgt_106, wFDN_FLAPS__lgt_107, wFDN_FLAPS__lgt_108, wFDN_FLAPS__lgt_109, 
      wFDN_FLAPS__lgt_110, wFDN_FLAPS__lgt_111, wFDN_FLAPS__lgt_112, wFDN_FLAPS__lgt_113, wFDN_FLAPS__lgt_114, 
      wFDN_FLAPS__lgt_115, wFDN_FLAPS__lgt_116, wFDN_FLAPS__lgt_117, wFDN_FLAPS__lgt_118, wFDN_FLAPS__lgt_119, 
      wFDN_FLAPS__lgt_120, wFDN_FLAPS__lgt_121, wFDN_FLAPS__lgt_122, wFDN_FLAPS__lgt_123, wFDN_FLAPS__lgt_124, 
      wFDN_FLAPS__lgt_125, wFDN_FLAPS__lgt_126, wFDN_FLAPS__lgt_127, wFDN_FLAPS__lgt_128, wFDN_FLAPS__lgt_129, 
      wFDN_FLAPS__lgt_130, wFDN_FLAPS__lgt_131, wFDN_FLAPS__lgt_132, wFDN_FLAPS__lgt_133, wFDN_FLAPS__lgt_134, 
      wFDN_FLAPS__lgt_135, wFDN_FLAPS__lgt_136, wFDN_FLAPS__lgt_137, wFDN_FLAPS__lgt_138, wFDN_FLAPS__lgt_139, 
      wFDN_FLAPS__lgt_140, wFDN_FLAPS__lgt_141, wFDN_FLAPS__lgt_142, wFDN_FLAPS__lgt_143, wFDN_FLAPS__lgt_144, 
      wFDN_FLAPS__lgt_145, wFDN_FLAPS__lgt_146, wFDN_FLAPS__lgt_147, wFDN_FLAPS__lgt_148, wFDN_FLAPS__lgt_149, 
      wFDN_FLAPS__lgt_150, wFDN_FLAPS__lgt_151, wFDN_FLAPS__lgt_152, wFDN_FLAPS__lgt_153, wFDN_FLAPS__lgt_154, 
      wFDN_FLAPS__lgt_155, wFDN_FLAPS__lgt_156, wFDN_FLAPS__lgt_157, wFDN_FLAPS__lgt_158, wFDN_FLAPS__lgt_159, 
      wFDN_FLAPS__lgt_160, wFDN_FLAPS__lgt_161, wFDN_FLAPS__lgt_162, wFDN_FLAPS__lgt_163, wFDN_FLAPS__lgt_164, 
      wFDN_FLAPS__lgt_165, wFDN_FLAPS__lgt_166, wFDN_FLAPS__lgt_167, wFDN_FLAPS__lgt_168, wFDN_FLAPS__lgt_169, 
      wFDN_FLAPS__lgt_170, wFDN_FLAPS__lgt_171, wFDN_FLAPS__lgt_172, wFDN_FLAPS__lgt_173, wFDN_FLAPS__lgt_174, 
      wFDN_FLAPS__lgt_175, wFDN_FLAPS__lgt_176, wFDN_FLAPS__lgt_177, wFDN_FLAPS__lgt_178, wFDN_FLAPS__lgt_179, 
      wFDN_FLAPS__lgt_180, wFDN_FLAPS__lgt_181, wFDN_FLAPS__lgt_182, wFDN_FLAPS__lgt_183, wFDN_FLAPS__lgt_184, 
      wFDN_FLAPS__lgt_185, wFDN_FLAPS__lgt_186, wFDN_FLAPS__lgt_187, wFDN_FLAPS__lgt_188, wFDN_FLAPS__lgt_189, 
      wFDN_FLAPS__lgt_190, wFDN_FLAPS__lgt_191, wFDN_FLAPS__lgt_192, wFDN_FLAPS__lgt_193, wFDN_FLAPS__lgt_194, 
      wFDN_FLAPS__lgt_195, wFDN_FLAPS__lgt_196, wFDN_FLAPS__lgt_197, wFDN_FLAPS__lgt_198, wFDN_FLAPS__lgt_199, 
      wFDN_FLAPS__lgt_200, wFDN_FLAPS__lgt_201, wFDN_FLAPS__lgt_202, wFDN_FLAPS__lgt_203, wFDN_FLAPS__lgt_204, 
      wFDN_FLAPS__lgt_205, wFDN_FLAPS__lgt_206, wFDN_FLAPS__lgt_207, wFDN_FLAPS__lgt_208, wFDN_FLAPS__lgt_209, 
      wFDN_FLAPS__lgt_210, wFDN_FLAPS__lgt_211, wFDN_FLAPS__lgt_212, wFDN_FLAPS__lgt_213, wFDN_FLAPS__lgt_214, 
      wFDN_FLAPS__lgt_215, wFDN_FLAPS__lgt_216, wFDN_FLAPS__lgt_217, wFDN_FLAPS__lgt_218, wFDN_FLAPS__lgt_219, 
      wFDN_FLAPS__lgt_220, wFDN_FLAPS__lgt_221, wFDN_FLAPS__lgt_222, wFDN_FLAPS__lgt_223, wFDN_FLAPS__lgt_224, 
      wFDN_FLAPS__lgt_225, wFDN_FLAPS__lgt_226, wFDN_FLAPS__lgt_227, wFDN_FLAPS__lgt_228, wFDN_FLAPS__lgt_229, 
      wFDN_FLAPS__lgt_230, wFDN_FLAPS__lgt_231, wFDN_FLAPS__lgt_232, wFDN_FLAPS__lgt_233, wFDN_FLAPS__lgt_234, 
      wFDN_FLAPS__lgt_235, wFDN_FLAPS__lgt_236, wFDN_FLAPS__lgt_237, wFDN_FLAPS__lgt_238, wFDN_FLAPS__lgt_239, 
      wFDN_FLAPS__lgt_240, wFDN_FLAPS__lgt_241, wFDN_FLAPS__lgt_242, wFDN_FLAPS__lgt_243, wFDN_FLAPS__lgt_244, 
      wFDN_FLAPS__lgt_245, wFDN_FLAPS__lgt_246, wFDN_FLAPS__lgt_247, wFDN_FLAPS__lgt_248, wFDN_FLAPS__lgt_249, 
      wFDN_FLAPS__lgt_250, wFDN_FLAPS__lgt_251, wFDN_FLAPS__lgt_252, wFDN_FLAPS__lgt_253, wFDN_FLAPS__lgt_254, 
      wFDN_FLAPS__lgt_255, wFDN_FLAPS__lgt_256, wFDN_FLAPS__lgt_257, wFDN_FLAPS__lgt_258, wFDN_FLAPS__lgt_259, 
      wFDN_FLAPS__lgt_260, wFDN_FLAPS__lgt_261, wFDN_FLAPS__lgt_262, wFDN_FLAPS__lgt_263, wFDN_FLAPS__lgt_264, 
      wFDN_FLAPS__lgt_265, wFDN_FLAPS__lgt_266, wFDN_FLAPS__lgt_267, wFDN_FLAPS__lgt_268, wFDN_FLAPS__lgt_269); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLAPS__lgt;
			
self.final_score_0	:= 	wFDN_FLAPS__lgt_0	;
self.final_score_1	:= 	wFDN_FLAPS__lgt_1	;
self.final_score_2	:= 	wFDN_FLAPS__lgt_2	;
self.final_score_3	:= 	wFDN_FLAPS__lgt_3	;
self.final_score_4	:= 	wFDN_FLAPS__lgt_4	;
self.final_score_5	:= 	wFDN_FLAPS__lgt_5	;
self.final_score_6	:= 	wFDN_FLAPS__lgt_6	;
self.final_score_7	:= 	wFDN_FLAPS__lgt_7	;
self.final_score_8	:= 	wFDN_FLAPS__lgt_8	;
self.final_score_9	:= 	wFDN_FLAPS__lgt_9	;
self.final_score_10	:= 	wFDN_FLAPS__lgt_10	;
self.final_score_11	:= 	wFDN_FLAPS__lgt_11	;
self.final_score_12	:= 	wFDN_FLAPS__lgt_12	;
self.final_score_13	:= 	wFDN_FLAPS__lgt_13	;
self.final_score_14	:= 	wFDN_FLAPS__lgt_14	;
self.final_score_15	:= 	wFDN_FLAPS__lgt_15	;
self.final_score_16	:= 	wFDN_FLAPS__lgt_16	;
self.final_score_17	:= 	wFDN_FLAPS__lgt_17	;
self.final_score_18	:= 	wFDN_FLAPS__lgt_18	;
self.final_score_19	:= 	wFDN_FLAPS__lgt_19	;
self.final_score_20	:= 	wFDN_FLAPS__lgt_20	;
self.final_score_21	:= 	wFDN_FLAPS__lgt_21	;
self.final_score_22	:= 	wFDN_FLAPS__lgt_22	;
self.final_score_23	:= 	wFDN_FLAPS__lgt_23	;
self.final_score_24	:= 	wFDN_FLAPS__lgt_24	;
self.final_score_25	:= 	wFDN_FLAPS__lgt_25	;
self.final_score_26	:= 	wFDN_FLAPS__lgt_26	;
self.final_score_27	:= 	wFDN_FLAPS__lgt_27	;
self.final_score_28	:= 	wFDN_FLAPS__lgt_28	;
self.final_score_29	:= 	wFDN_FLAPS__lgt_29	;
self.final_score_30	:= 	wFDN_FLAPS__lgt_30	;
self.final_score_31	:= 	wFDN_FLAPS__lgt_31	;
self.final_score_32	:= 	wFDN_FLAPS__lgt_32	;
self.final_score_33	:= 	wFDN_FLAPS__lgt_33	;
self.final_score_34	:= 	wFDN_FLAPS__lgt_34	;
self.final_score_35	:= 	wFDN_FLAPS__lgt_35	;
self.final_score_36	:= 	wFDN_FLAPS__lgt_36	;
self.final_score_37	:= 	wFDN_FLAPS__lgt_37	;
self.final_score_38	:= 	wFDN_FLAPS__lgt_38	;
self.final_score_39	:= 	wFDN_FLAPS__lgt_39	;
self.final_score_40	:= 	wFDN_FLAPS__lgt_40	;
self.final_score_41	:= 	wFDN_FLAPS__lgt_41	;
self.final_score_42	:= 	wFDN_FLAPS__lgt_42	;
self.final_score_43	:= 	wFDN_FLAPS__lgt_43	;
self.final_score_44	:= 	wFDN_FLAPS__lgt_44	;
self.final_score_45	:= 	wFDN_FLAPS__lgt_45	;
self.final_score_46	:= 	wFDN_FLAPS__lgt_46	;
self.final_score_47	:= 	wFDN_FLAPS__lgt_47	;
self.final_score_48	:= 	wFDN_FLAPS__lgt_48	;
self.final_score_49	:= 	wFDN_FLAPS__lgt_49	;
self.final_score_50	:= 	wFDN_FLAPS__lgt_50	;
self.final_score_51	:= 	wFDN_FLAPS__lgt_51	;
self.final_score_52	:= 	wFDN_FLAPS__lgt_52	;
self.final_score_53	:= 	wFDN_FLAPS__lgt_53	;
self.final_score_54	:= 	wFDN_FLAPS__lgt_54	;
self.final_score_55	:= 	wFDN_FLAPS__lgt_55	;
self.final_score_56	:= 	wFDN_FLAPS__lgt_56	;
self.final_score_57	:= 	wFDN_FLAPS__lgt_57	;
self.final_score_58	:= 	wFDN_FLAPS__lgt_58	;
self.final_score_59	:= 	wFDN_FLAPS__lgt_59	;
self.final_score_60	:= 	wFDN_FLAPS__lgt_60	;
self.final_score_61	:= 	wFDN_FLAPS__lgt_61	;
self.final_score_62	:= 	wFDN_FLAPS__lgt_62	;
self.final_score_63	:= 	wFDN_FLAPS__lgt_63	;
self.final_score_64	:= 	wFDN_FLAPS__lgt_64	;
self.final_score_65	:= 	wFDN_FLAPS__lgt_65	;
self.final_score_66	:= 	wFDN_FLAPS__lgt_66	;
self.final_score_67	:= 	wFDN_FLAPS__lgt_67	;
self.final_score_68	:= 	wFDN_FLAPS__lgt_68	;
self.final_score_69	:= 	wFDN_FLAPS__lgt_69	;
self.final_score_70	:= 	wFDN_FLAPS__lgt_70	;
self.final_score_71	:= 	wFDN_FLAPS__lgt_71	;
self.final_score_72	:= 	wFDN_FLAPS__lgt_72	;
self.final_score_73	:= 	wFDN_FLAPS__lgt_73	;
self.final_score_74	:= 	wFDN_FLAPS__lgt_74	;
self.final_score_75	:= 	wFDN_FLAPS__lgt_75	;
self.final_score_76	:= 	wFDN_FLAPS__lgt_76	;
self.final_score_77	:= 	wFDN_FLAPS__lgt_77	;
self.final_score_78	:= 	wFDN_FLAPS__lgt_78	;
self.final_score_79	:= 	wFDN_FLAPS__lgt_79	;
self.final_score_80	:= 	wFDN_FLAPS__lgt_80	;
self.final_score_81	:= 	wFDN_FLAPS__lgt_81	;
self.final_score_82	:= 	wFDN_FLAPS__lgt_82	;
self.final_score_83	:= 	wFDN_FLAPS__lgt_83	;
self.final_score_84	:= 	wFDN_FLAPS__lgt_84	;
self.final_score_85	:= 	wFDN_FLAPS__lgt_85	;
self.final_score_86	:= 	wFDN_FLAPS__lgt_86	;
self.final_score_87	:= 	wFDN_FLAPS__lgt_87	;
self.final_score_88	:= 	wFDN_FLAPS__lgt_88	;
self.final_score_89	:= 	wFDN_FLAPS__lgt_89	;
self.final_score_90	:= 	wFDN_FLAPS__lgt_90	;
self.final_score_91	:= 	wFDN_FLAPS__lgt_91	;
self.final_score_92	:= 	wFDN_FLAPS__lgt_92	;
self.final_score_93	:= 	wFDN_FLAPS__lgt_93	;
self.final_score_94	:= 	wFDN_FLAPS__lgt_94	;
self.final_score_95	:= 	wFDN_FLAPS__lgt_95	;
self.final_score_96	:= 	wFDN_FLAPS__lgt_96	;
self.final_score_97	:= 	wFDN_FLAPS__lgt_97	;
self.final_score_98	:= 	wFDN_FLAPS__lgt_98	;
self.final_score_99	:= 	wFDN_FLAPS__lgt_99	;
self.final_score_100	:= 	wFDN_FLAPS__lgt_100	;
self.final_score_101	:= 	wFDN_FLAPS__lgt_101	;
self.final_score_102	:= 	wFDN_FLAPS__lgt_102	;
self.final_score_103	:= 	wFDN_FLAPS__lgt_103	;
self.final_score_104	:= 	wFDN_FLAPS__lgt_104	;
self.final_score_105	:= 	wFDN_FLAPS__lgt_105	;
self.final_score_106	:= 	wFDN_FLAPS__lgt_106	;
self.final_score_107	:= 	wFDN_FLAPS__lgt_107	;
self.final_score_108	:= 	wFDN_FLAPS__lgt_108	;
self.final_score_109	:= 	wFDN_FLAPS__lgt_109	;
self.final_score_110	:= 	wFDN_FLAPS__lgt_110	;
self.final_score_111	:= 	wFDN_FLAPS__lgt_111	;
self.final_score_112	:= 	wFDN_FLAPS__lgt_112	;
self.final_score_113	:= 	wFDN_FLAPS__lgt_113	;
self.final_score_114	:= 	wFDN_FLAPS__lgt_114	;
self.final_score_115	:= 	wFDN_FLAPS__lgt_115	;
self.final_score_116	:= 	wFDN_FLAPS__lgt_116	;
self.final_score_117	:= 	wFDN_FLAPS__lgt_117	;
self.final_score_118	:= 	wFDN_FLAPS__lgt_118	;
self.final_score_119	:= 	wFDN_FLAPS__lgt_119	;
self.final_score_120	:= 	wFDN_FLAPS__lgt_120	;
self.final_score_121	:= 	wFDN_FLAPS__lgt_121	;
self.final_score_122	:= 	wFDN_FLAPS__lgt_122	;
self.final_score_123	:= 	wFDN_FLAPS__lgt_123	;
self.final_score_124	:= 	wFDN_FLAPS__lgt_124	;
self.final_score_125	:= 	wFDN_FLAPS__lgt_125	;
self.final_score_126	:= 	wFDN_FLAPS__lgt_126	;
self.final_score_127	:= 	wFDN_FLAPS__lgt_127	;
self.final_score_128	:= 	wFDN_FLAPS__lgt_128	;
self.final_score_129	:= 	wFDN_FLAPS__lgt_129	;
self.final_score_130	:= 	wFDN_FLAPS__lgt_130	;
self.final_score_131	:= 	wFDN_FLAPS__lgt_131	;
self.final_score_132	:= 	wFDN_FLAPS__lgt_132	;
self.final_score_133	:= 	wFDN_FLAPS__lgt_133	;
self.final_score_134	:= 	wFDN_FLAPS__lgt_134	;
self.final_score_135	:= 	wFDN_FLAPS__lgt_135	;
self.final_score_136	:= 	wFDN_FLAPS__lgt_136	;
self.final_score_137	:= 	wFDN_FLAPS__lgt_137	;
self.final_score_138	:= 	wFDN_FLAPS__lgt_138	;
self.final_score_139	:= 	wFDN_FLAPS__lgt_139	;
self.final_score_140	:= 	wFDN_FLAPS__lgt_140	;
self.final_score_141	:= 	wFDN_FLAPS__lgt_141	;
self.final_score_142	:= 	wFDN_FLAPS__lgt_142	;
self.final_score_143	:= 	wFDN_FLAPS__lgt_143	;
self.final_score_144	:= 	wFDN_FLAPS__lgt_144	;
self.final_score_145	:= 	wFDN_FLAPS__lgt_145	;
self.final_score_146	:= 	wFDN_FLAPS__lgt_146	;
self.final_score_147	:= 	wFDN_FLAPS__lgt_147	;
self.final_score_148	:= 	wFDN_FLAPS__lgt_148	;
self.final_score_149	:= 	wFDN_FLAPS__lgt_149	;
self.final_score_150	:= 	wFDN_FLAPS__lgt_150	;
self.final_score_151	:= 	wFDN_FLAPS__lgt_151	;
self.final_score_152	:= 	wFDN_FLAPS__lgt_152	;
self.final_score_153	:= 	wFDN_FLAPS__lgt_153	;
self.final_score_154	:= 	wFDN_FLAPS__lgt_154	;
self.final_score_155	:= 	wFDN_FLAPS__lgt_155	;
self.final_score_156	:= 	wFDN_FLAPS__lgt_156	;
self.final_score_157	:= 	wFDN_FLAPS__lgt_157	;
self.final_score_158	:= 	wFDN_FLAPS__lgt_158	;
self.final_score_159	:= 	wFDN_FLAPS__lgt_159	;
self.final_score_160	:= 	wFDN_FLAPS__lgt_160	;
self.final_score_161	:= 	wFDN_FLAPS__lgt_161	;
self.final_score_162	:= 	wFDN_FLAPS__lgt_162	;
self.final_score_163	:= 	wFDN_FLAPS__lgt_163	;
self.final_score_164	:= 	wFDN_FLAPS__lgt_164	;
self.final_score_165	:= 	wFDN_FLAPS__lgt_165	;
self.final_score_166	:= 	wFDN_FLAPS__lgt_166	;
self.final_score_167	:= 	wFDN_FLAPS__lgt_167	;
self.final_score_168	:= 	wFDN_FLAPS__lgt_168	;
self.final_score_169	:= 	wFDN_FLAPS__lgt_169	;
self.final_score_170	:= 	wFDN_FLAPS__lgt_170	;
self.final_score_171	:= 	wFDN_FLAPS__lgt_171	;
self.final_score_172	:= 	wFDN_FLAPS__lgt_172	;
self.final_score_173	:= 	wFDN_FLAPS__lgt_173	;
self.final_score_174	:= 	wFDN_FLAPS__lgt_174	;
self.final_score_175	:= 	wFDN_FLAPS__lgt_175	;
self.final_score_176	:= 	wFDN_FLAPS__lgt_176	;
self.final_score_177	:= 	wFDN_FLAPS__lgt_177	;
self.final_score_178	:= 	wFDN_FLAPS__lgt_178	;
self.final_score_179	:= 	wFDN_FLAPS__lgt_179	;
self.final_score_180	:= 	wFDN_FLAPS__lgt_180	;
self.final_score_181	:= 	wFDN_FLAPS__lgt_181	;
self.final_score_182	:= 	wFDN_FLAPS__lgt_182	;
self.final_score_183	:= 	wFDN_FLAPS__lgt_183	;
self.final_score_184	:= 	wFDN_FLAPS__lgt_184	;
self.final_score_185	:= 	wFDN_FLAPS__lgt_185	;
self.final_score_186	:= 	wFDN_FLAPS__lgt_186	;
self.final_score_187	:= 	wFDN_FLAPS__lgt_187	;
self.final_score_188	:= 	wFDN_FLAPS__lgt_188	;
self.final_score_189	:= 	wFDN_FLAPS__lgt_189	;
self.final_score_190	:= 	wFDN_FLAPS__lgt_190	;
self.final_score_191	:= 	wFDN_FLAPS__lgt_191	;
self.final_score_192	:= 	wFDN_FLAPS__lgt_192	;
self.final_score_193	:= 	wFDN_FLAPS__lgt_193	;
self.final_score_194	:= 	wFDN_FLAPS__lgt_194	;
self.final_score_195	:= 	wFDN_FLAPS__lgt_195	;
self.final_score_196	:= 	wFDN_FLAPS__lgt_196	;
self.final_score_197	:= 	wFDN_FLAPS__lgt_197	;
self.final_score_198	:= 	wFDN_FLAPS__lgt_198	;
self.final_score_199	:= 	wFDN_FLAPS__lgt_199	;
self.final_score_200	:= 	wFDN_FLAPS__lgt_200	;
self.final_score_201	:= 	wFDN_FLAPS__lgt_201	;
self.final_score_202	:= 	wFDN_FLAPS__lgt_202	;
self.final_score_203	:= 	wFDN_FLAPS__lgt_203	;
self.final_score_204	:= 	wFDN_FLAPS__lgt_204	;
self.final_score_205	:= 	wFDN_FLAPS__lgt_205	;
self.final_score_206	:= 	wFDN_FLAPS__lgt_206	;
self.final_score_207	:= 	wFDN_FLAPS__lgt_207	;
self.final_score_208	:= 	wFDN_FLAPS__lgt_208	;
self.final_score_209	:= 	wFDN_FLAPS__lgt_209	;
self.final_score_210	:= 	wFDN_FLAPS__lgt_210	;
self.final_score_211	:= 	wFDN_FLAPS__lgt_211	;
self.final_score_212	:= 	wFDN_FLAPS__lgt_212	;
self.final_score_213	:= 	wFDN_FLAPS__lgt_213	;
self.final_score_214	:= 	wFDN_FLAPS__lgt_214	;
self.final_score_215	:= 	wFDN_FLAPS__lgt_215	;
self.final_score_216	:= 	wFDN_FLAPS__lgt_216	;
self.final_score_217	:= 	wFDN_FLAPS__lgt_217	;
self.final_score_218	:= 	wFDN_FLAPS__lgt_218	;
self.final_score_219	:= 	wFDN_FLAPS__lgt_219	;
self.final_score_220	:= 	wFDN_FLAPS__lgt_220	;
self.final_score_221	:= 	wFDN_FLAPS__lgt_221	;
self.final_score_222	:= 	wFDN_FLAPS__lgt_222	;
self.final_score_223	:= 	wFDN_FLAPS__lgt_223	;
self.final_score_224	:= 	wFDN_FLAPS__lgt_224	;
self.final_score_225	:= 	wFDN_FLAPS__lgt_225	;
self.final_score_226	:= 	wFDN_FLAPS__lgt_226	;
self.final_score_227	:= 	wFDN_FLAPS__lgt_227	;
self.final_score_228	:= 	wFDN_FLAPS__lgt_228	;
self.final_score_229	:= 	wFDN_FLAPS__lgt_229	;
self.final_score_230	:= 	wFDN_FLAPS__lgt_230	;
self.final_score_231	:= 	wFDN_FLAPS__lgt_231	;
self.final_score_232	:= 	wFDN_FLAPS__lgt_232	;
self.final_score_233	:= 	wFDN_FLAPS__lgt_233	;
self.final_score_234	:= 	wFDN_FLAPS__lgt_234	;
self.final_score_235	:= 	wFDN_FLAPS__lgt_235	;
self.final_score_236	:= 	wFDN_FLAPS__lgt_236	;
self.final_score_237	:= 	wFDN_FLAPS__lgt_237	;
self.final_score_238	:= 	wFDN_FLAPS__lgt_238	;
self.final_score_239	:= 	wFDN_FLAPS__lgt_239	;
self.final_score_240	:= 	wFDN_FLAPS__lgt_240	;
self.final_score_241	:= 	wFDN_FLAPS__lgt_241	;
self.final_score_242	:= 	wFDN_FLAPS__lgt_242	;
self.final_score_243	:= 	wFDN_FLAPS__lgt_243	;
self.final_score_244	:= 	wFDN_FLAPS__lgt_244	;
self.final_score_245	:= 	wFDN_FLAPS__lgt_245	;
self.final_score_246	:= 	wFDN_FLAPS__lgt_246	;
self.final_score_247	:= 	wFDN_FLAPS__lgt_247	;
self.final_score_248	:= 	wFDN_FLAPS__lgt_248	;
self.final_score_249	:= 	wFDN_FLAPS__lgt_249	;
self.final_score_250	:= 	wFDN_FLAPS__lgt_250	;
self.final_score_251	:= 	wFDN_FLAPS__lgt_251	;
self.final_score_252	:= 	wFDN_FLAPS__lgt_252	;
self.final_score_253	:= 	wFDN_FLAPS__lgt_253	;
self.final_score_254	:= 	wFDN_FLAPS__lgt_254	;
self.final_score_255	:= 	wFDN_FLAPS__lgt_255	;
self.final_score_256	:= 	wFDN_FLAPS__lgt_256	;
self.final_score_257	:= 	wFDN_FLAPS__lgt_257	;
self.final_score_258	:= 	wFDN_FLAPS__lgt_258	;
self.final_score_259	:= 	wFDN_FLAPS__lgt_259	;
self.final_score_260	:= 	wFDN_FLAPS__lgt_260	;
self.final_score_261	:= 	wFDN_FLAPS__lgt_261	;
self.final_score_262	:= 	wFDN_FLAPS__lgt_262	;
self.final_score_263	:= 	wFDN_FLAPS__lgt_263	;
self.final_score_264	:= 	wFDN_FLAPS__lgt_264	;
self.final_score_265	:= 	wFDN_FLAPS__lgt_265	;
self.final_score_266	:= 	wFDN_FLAPS__lgt_266	;
self.final_score_267	:= 	wFDN_FLAPS__lgt_267	;
self.final_score_268	:= 	wFDN_FLAPS__lgt_268	;
self.final_score_269	:= 	wFDN_FLAPS__lgt_269	;
// self.wFDN_submodel_lgt	:= 	wFDN_FLAPS__lgt	;
self.FP3_wFDN_LGT		:= 	wFDN_FLAPS__lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
