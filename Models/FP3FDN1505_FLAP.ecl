
export FP3FDN1505_FLAP( dataset(Models.Layout_FP31505) allVars ) := FUNCTION

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

   wFDN_FLAP___lgt_0 :=  -2.2064558179;

// Tree: 1 
wFDN_FLAP___lgt_1 := map(
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
wFDN_FLAP___lgt_2 := map(
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
wFDN_FLAP___lgt_3 := map(
(NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.2150002247,
      (f_phone_ver_experian_d > 0.5) => -0.0135930119,
      (f_phone_ver_experian_d = NULL) => 0.0936087999, 0.0968923135),
   (f_inq_Communications_count_i > 0.5) => 0.3100854888,
   (f_inq_Communications_count_i = NULL) => 0.1435725253, 0.1435725253),
(nf_vf_hi_risk_hit_type > 3.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 0.0051983911,
      (f_phone_ver_insurance_d > 3.5) => -0.0553499035,
      (f_phone_ver_insurance_d = NULL) => -0.0250811807, -0.0250811807),
   (f_inq_Communications_count_i > 1.5) => 0.1613851265,
   (f_inq_Communications_count_i = NULL) => -0.0197582087, -0.0197582087),
(nf_vf_hi_risk_hit_type = NULL) => 0.1045520761, -0.0048021689);

// Tree: 4 
wFDN_FLAP___lgt_4 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => -0.0301966346,
      (f_assocsuspicousidcount_i > 15.5) => 0.3595076076,
      (f_assocsuspicousidcount_i = NULL) => -0.0281277414, -0.0281277414),
   (f_corrrisktype_i > 8.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 22.75) => 0.0516626738,
      (c_famotf18_p > 22.75) => 0.2059683373,
      (c_famotf18_p = NULL) => -0.0388255913, 0.0673758430),
   (f_corrrisktype_i = NULL) => -0.0137505210, -0.0137505210),
(f_srchfraudsrchcount_i > 8.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.1578395652,
   (f_varrisktype_i > 4.5) => 0.3101650275,
   (f_varrisktype_i = NULL) => 0.1946240422, 0.1946240422),
(f_srchfraudsrchcount_i = NULL) => 0.1109604541, -0.0068126411);

// Tree: 5 
wFDN_FLAP___lgt_5 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 5.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < nf_vf_hi_risk_hit_type and nf_vf_hi_risk_hit_type <= 3.5) => 0.1782124499,
      (nf_vf_hi_risk_hit_type > 3.5) => 0.0123384597,
      (nf_vf_hi_risk_hit_type = NULL) => 0.0248115377, 0.0248115377),
   (f_phone_ver_experian_d > 0.5) => -0.0517964291,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => -0.0174299658,
      (f_assocrisktype_i > 8.5) => 0.2421185201,
      (f_assocrisktype_i = NULL) => -0.0058896388, -0.0058896388), -0.0174278128),
(f_srchvelocityrisktype_i > 5.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 0.0812456945,
   (f_varrisktype_i > 4.5) => 0.2121182972,
   (f_varrisktype_i = NULL) => 0.1002299342, 0.1002299342),
(f_srchvelocityrisktype_i = NULL) => 0.0860409979, -0.0059164925);

// Tree: 6 
wFDN_FLAP___lgt_6 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 4.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 59.9) => 0.2594823822,
      (c_fammar_p > 59.9) => 0.0567268817,
      (c_fammar_p = NULL) => 0.1355001336, 0.1355001336),
   (nf_vf_hi_risk_index > 4.5) => 
      map(
      (NULL < r_D32_felony_count_i and r_D32_felony_count_i <= 0.5) => -0.0238333178,
      (r_D32_felony_count_i > 0.5) => 0.2122014107,
      (r_D32_felony_count_i = NULL) => -0.0210087292, -0.0210087292),
   (nf_vf_hi_risk_index = NULL) => -0.0170956816, -0.0170956816),
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0999146288,
   (f_inq_Communications_count_i > 0.5) => 0.2415363041,
   (f_inq_Communications_count_i = NULL) => 0.1452778217, 0.1452778217),
(r_D33_eviction_count_i = NULL) => 0.0695573308, -0.0093532411);

// Tree: 7 
wFDN_FLAP___lgt_7 := map(
(NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 6.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => 0.2476169165,
   (r_F01_inp_addr_address_score_d > 75) => 0.0659350686,
   (r_F01_inp_addr_address_score_d = NULL) => 0.0870359131, 0.0870359131),
(nf_vf_hi_risk_index > 6.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0051770052,
         (f_rel_felony_count_i > 1.5) => 0.1744141094,
         (f_rel_felony_count_i = NULL) => 0.0151239265, 0.0151239265),
      (k_inq_per_phone_i > 2.5) => 0.2721020684,
      (k_inq_per_phone_i = NULL) => 0.0224602822, 0.0224602822),
   (f_phone_ver_experian_d > 0.5) => -0.0500258427,
   (f_phone_ver_experian_d = NULL) => -0.0141562013, -0.0191060960),
(nf_vf_hi_risk_index = NULL) => 0.0469467305, -0.0097215238);

// Tree: 8 
wFDN_FLAP___lgt_8 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0573050238,
      (f_rel_felony_count_i > 1.5) => 0.2552386391,
      (f_rel_felony_count_i = NULL) => 0.0743885799, 0.0743885799),
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => -0.0336470760,
      (f_inq_PrepaidCards_count_i > 0.5) => 0.1401529790,
      (f_inq_PrepaidCards_count_i = NULL) => -0.0303717124, -0.0303717124),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0208950567, -0.0208950567),
(f_varrisktype_i > 2.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0501722466,
   (f_rel_felony_count_i > 0.5) => 0.1759670923,
   (f_rel_felony_count_i = NULL) => 0.0750567543, 0.0750567543),
(f_varrisktype_i = NULL) => 0.0314623596, -0.0098421428);

// Tree: 9 
wFDN_FLAP___lgt_9 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 59.25) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => 0.1650155035,
      (k_estimated_income_d > 26500) => 0.0384068879,
      (k_estimated_income_d = NULL) => 0.0589763549, 0.0589763549),
   (c_fammar_p > 59.25) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0286348201,
      (k_inq_per_phone_i > 2.5) => 0.0907380005,
      (k_inq_per_phone_i = NULL) => -0.0234015535, -0.0234015535),
   (c_fammar_p = NULL) => -0.0428442953, -0.0117663358),
(f_inq_PrepaidCards_count_i > 0.5) => 0.1383528058,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 120.5) => 0.0177924493,
   (c_cartheft > 120.5) => 0.2273251253,
   (c_cartheft = NULL) => 0.1006309491, 0.1006309491), -0.0061385056);

// Tree: 10 
wFDN_FLAP___lgt_10 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 8.5) => 
   map(
   (NULL < r_F01_inp_addr_not_verified_i and r_F01_inp_addr_not_verified_i <= 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 5.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2702654098,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0248997078,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0233403037, -0.0233403037),
      (r_D30_Derog_Count_i > 5.5) => 0.0921560279,
      (r_D30_Derog_Count_i = NULL) => -0.0184305821, -0.0184305821),
   (r_F01_inp_addr_not_verified_i > 0.5) => 
      map(
      (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 0.5) => 0.0604937253,
      (f_inq_Communications_count24_i > 0.5) => 0.2424337843,
      (f_inq_Communications_count24_i = NULL) => 0.0779484713, 0.0779484713),
   (r_F01_inp_addr_not_verified_i = NULL) => -0.0114047600, -0.0114047600),
(f_srchfraudsrchcount_i > 8.5) => 0.1150215388,
(f_srchfraudsrchcount_i = NULL) => 0.0197706497, -0.0073585723);

// Tree: 11 
wFDN_FLAP___lgt_11 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.2721727823,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0233914688,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0218455739, -0.0218455739),
   (f_inq_Communications_count_i > 0.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 1.5) => 0.0514669135,
      (r_D33_eviction_count_i > 1.5) => 0.2208398653,
      (r_D33_eviction_count_i = NULL) => 0.0619619010, 0.0619619010),
   (f_inq_Communications_count_i = NULL) => 0.0121549084, -0.0141609015),
(k_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1748032443,
   (f_phone_ver_experian_d > 0.5) => 0.0359399687,
   (f_phone_ver_experian_d = NULL) => 0.1796511202, 0.1115930850),
(k_inq_ssns_per_addr_i = NULL) => -0.0083118789, -0.0083118789);

// Tree: 12 
wFDN_FLAP___lgt_12 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 44.95) => 0.1186265192,
      (c_fammar_p > 44.95) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
            map(
            (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -6811.5) => 0.2115236706,
            (f_addrchangeincomediff_d > -6811.5) => 0.0529676598,
            (f_addrchangeincomediff_d = NULL) => 0.0373347273, 0.0579356020),
         (f_phone_ver_experian_d > 0.5) => -0.0482813283,
         (f_phone_ver_experian_d = NULL) => 0.0029450155, 0.0171125419),
      (c_fammar_p = NULL) => -0.0597679607, 0.0213436362),
   (k_nap_phn_verd_d > 0.5) => -0.0362057067,
   (k_nap_phn_verd_d = NULL) => -0.0141673503, -0.0141673503),
(f_inq_HighRiskCredit_count_i > 2.5) => 0.0987441724,
(f_inq_HighRiskCredit_count_i = NULL) => 0.0412036689, -0.0099171942);

// Tree: 13 
wFDN_FLAP___lgt_13 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 3.5) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 52.45) => 0.0577754566,
   (c_fammar_p > 52.45) => -0.0196902192,
   (c_fammar_p = NULL) => -0.0489412204, -0.0136403016),
(f_varrisktype_i > 3.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 3.5) => 0.0337931204,
   (f_srchfraudsrchcount_i > 3.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1836540148,
      (f_phone_ver_experian_d > 0.5) => 0.0358748166,
      (f_phone_ver_experian_d = NULL) => 0.1413366620, 0.1258405773),
   (f_srchfraudsrchcount_i = NULL) => 0.0648706595, 0.0648706595),
(f_varrisktype_i = NULL) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 78.35) => 0.1330399340,
   (c_fammar_p > 78.35) => -0.0480279540,
   (c_fammar_p = NULL) => 0.0575949807, 0.0575949807), -0.0084772571);

// Tree: 14 
wFDN_FLAP___lgt_14 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.1061002833,
(r_I60_inq_PrepaidCards_recency_d > 549) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 0.0338709249,
      (r_L79_adls_per_addr_curr_i > 1.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 169.5) => 0.0859149166,
         (r_C10_M_Hdr_FS_d > 169.5) => 0.3197401109,
         (r_C10_M_Hdr_FS_d = NULL) => 0.1885698800, 0.1885698800),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0873202830, 0.0873202830),
   (r_C12_source_profile_index_d > 0.5) => 
      map(
      (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0240313101,
      (f_srchvelocityrisktype_i > 4.5) => 0.0441073479,
      (f_srchvelocityrisktype_i = NULL) => -0.0161640512, -0.0161640512),
   (r_C12_source_profile_index_d = NULL) => -0.0131346603, -0.0131346603),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0146697704, -0.0093624705);

// Tree: 15 
wFDN_FLAP___lgt_15 := map(
(NULL < c_fammar_p and c_fammar_p <= 61.05) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
      map(
      (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0123024070,
      (f_idverrisktype_i > 1.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0537280028,
         (r_L79_adls_per_addr_c6_i > 4.5) => 0.1854564912,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0656725877, 0.0656725877),
      (f_idverrisktype_i = NULL) => 0.0347320455, 0.0347320455),
   (k_comb_age_d > 68.5) => 0.3091743537,
   (k_comb_age_d = NULL) => 0.0471698249, 0.0471698249),
(c_fammar_p > 61.05) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 549) => 0.0891579906,
   (r_I60_inq_PrepaidCards_recency_d > 549) => -0.0221160592,
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0394394151, -0.0193048317),
(c_fammar_p = NULL) => -0.0340158919, -0.0088587841);

// Tree: 16 
wFDN_FLAP___lgt_16 := map(
(NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 3.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 50.2) => 0.0332909657,
         (c_low_ed > 50.2) => 0.1242827533,
         (c_low_ed = NULL) => 0.0668471138, 0.0668471138),
      (r_F01_inp_addr_address_score_d > 25) => -0.0120932234,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0080507037, -0.0080507037),
   (f_inq_Communications_count_i > 3.5) => 0.1559137098,
   (f_inq_Communications_count_i = NULL) => -0.0068779888, -0.0068779888),
(f_varrisktype_i > 4.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 0.1208288385,
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0365724685,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0860833373, 0.0860833373),
(f_varrisktype_i = NULL) => 0.0188976292, -0.0038278569);

// Tree: 17 
wFDN_FLAP___lgt_17 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 22500) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 78.5) => 0.1766665890,
      (c_rest_indx > 78.5) => 0.0256108110,
      (c_rest_indx = NULL) => 0.0683876685, 0.0683876685),
   (k_estimated_income_d > 22500) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.1336365624,
      (r_D33_Eviction_Recency_d > 30) => -0.0266437733,
      (r_D33_Eviction_Recency_d = NULL) => -0.0254243963, -0.0254243963),
   (k_estimated_income_d = NULL) => -0.0117474392, -0.0211273939),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => 0.0423801622,
   (f_hh_payday_loan_users_i > 0.5) => 0.1219124129,
   (f_hh_payday_loan_users_i = NULL) => 0.0547263239, 0.0547263239),
(k_inq_per_addr_i = NULL) => -0.0127676385, -0.0127676385);

// Tree: 18 
wFDN_FLAP___lgt_18 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => 0.0443309799,
         (f_srchaddrsrchcount_i > 14.5) => 0.1906176613,
         (f_srchaddrsrchcount_i = NULL) => 0.0495087174, 0.0495087174),
      (f_phone_ver_experian_d > 0.5) => -0.0352203248,
      (f_phone_ver_experian_d = NULL) => 0.0207730968, 0.0157829766),
   (f_corrphonelastnamecount_d > 0.5) => -0.0300045566,
   (f_corrphonelastnamecount_d = NULL) => -0.0097489677, -0.0097489677),
(r_D33_eviction_count_i > 2.5) => 0.1274712298,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 98.5) => 0.1067421277,
   (c_many_cars > 98.5) => -0.0683920342,
   (c_many_cars = NULL) => 0.0327016690, 0.0327016690), -0.0077449105);

// Tree: 19 
wFDN_FLAP___lgt_19 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => 
   map(
   (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0119238361,
         (f_rel_felony_count_i > 1.5) => 0.1294981516,
         (f_rel_felony_count_i = NULL) => 0.0175380097, 0.0175380097),
      (k_inq_per_phone_i > 2.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0342999086,
         (r_Phn_Cell_n > 0.5) => 0.3898836171,
         (r_Phn_Cell_n = NULL) => 0.1657112791, 0.1657112791),
      (k_inq_per_phone_i = NULL) => 0.0224795058, 0.0224795058),
   (k_nap_phn_verd_d > 0.5) => -0.0339306963,
   (k_nap_phn_verd_d = NULL) => -0.0125625696, -0.0125625696),
(f_srchvelocityrisktype_i > 4.5) => 0.0510466847,
(f_srchvelocityrisktype_i = NULL) => 0.0061300528, -0.0042595882);

// Tree: 20 
wFDN_FLAP___lgt_20 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => -0.0170159011,
   (f_varrisktype_i > 2.5) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 2.5) => 0.0347140701,
      (f_divrisktype_i > 2.5) => 0.1774109073,
      (f_divrisktype_i = NULL) => 0.0482716391, 0.0482716391),
   (f_varrisktype_i = NULL) => 0.0004984251, -0.0107502233),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 0.0422631697,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1641811274,
      (f_phone_ver_experian_d > 0.5) => 0.0354361698,
      (f_phone_ver_experian_d = NULL) => 0.1971919752, 0.1163018717),
   (f_rel_felony_count_i = NULL) => 0.0563204822, 0.0563204822),
(k_inq_per_addr_i = NULL) => -0.0032896979, -0.0032896979);

// Tree: 21 
wFDN_FLAP___lgt_21 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 4.5) => -0.0231947266,
   (f_srchaddrsrchcount_i > 4.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0716344005,
      (f_phone_ver_experian_d > 0.5) => -0.0025118982,
      (f_phone_ver_experian_d = NULL) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 715.5) => 0.1988025561,
         (c_popover18 > 715.5) => -0.0088921757,
         (c_popover18 = NULL) => 0.0204559929, 0.0204559929), 0.0226353455),
   (f_srchaddrsrchcount_i = NULL) => -0.0153870180, -0.0153870180),
(f_assocrisktype_i > 7.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 144.5) => 0.1680862671,
   (f_M_Bureau_ADL_FS_all_d > 144.5) => 0.0319138674,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0528260574, 0.0528260574),
(f_assocrisktype_i = NULL) => 0.0030018409, -0.0106322087);

// Tree: 22 
wFDN_FLAP___lgt_22 := map(
(NULL < f_assocrisktype_i and f_assocrisktype_i <= 8.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0240000734,
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 0.0187539180,
      (k_inq_per_phone_i > 5.5) => 0.1360140937,
      (k_inq_per_phone_i = NULL) => 0.0212614513, 0.0212614513),
   (f_hh_lienholders_i = NULL) => -0.0104983562, -0.0104983562),
(f_assocrisktype_i > 8.5) => 
   map(
   (NULL < r_C12_source_profile_index_d and r_C12_source_profile_index_d <= 1.5) => 0.1960166584,
   (r_C12_source_profile_index_d > 1.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0436703669,
      (r_D33_eviction_count_i > 0.5) => 0.1565090118,
      (r_D33_eviction_count_i = NULL) => 0.0597031959, 0.0597031959),
   (r_C12_source_profile_index_d = NULL) => 0.0717702893, 0.0717702893),
(f_assocrisktype_i = NULL) => -0.0024495208, -0.0064400404);

// Tree: 23 
wFDN_FLAP___lgt_23 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 5.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0438178343,
      (f_corrphonelastnamecount_d > 0.5) => -0.0209888970,
      (f_corrphonelastnamecount_d = NULL) => 0.0158676329, 0.0158676329),
   (k_inq_per_phone_i > 5.5) => 0.1738661466,
   (k_inq_per_phone_i = NULL) => 0.0184370262, 0.0184370262),
(f_phone_ver_experian_d > 0.5) => -0.0313063190,
(f_phone_ver_experian_d = NULL) => 
   map(
   (NULL < c_business and c_business <= 2.5) => 0.1279127536,
   (c_business > 2.5) => 
      map(
      (NULL < f_assocrisktype_i and f_assocrisktype_i <= 7.5) => -0.0179966388,
      (f_assocrisktype_i > 7.5) => 0.1096912066,
      (f_assocrisktype_i = NULL) => 0.0378569029, -0.0086498775),
   (c_business = NULL) => -0.0802637590, -0.0006963638), -0.0084344161);

// Tree: 24 
wFDN_FLAP___lgt_24 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => -0.0259876399,
      (f_corrrisktype_i > 8.5) => 0.0244366092,
      (f_corrrisktype_i = NULL) => 0.0001279434, -0.0189642322),
   (c_unemp > 8.95) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0338879573,
      (f_rel_criminal_count_i > 2.5) => 0.1527392393,
      (f_rel_criminal_count_i = NULL) => 0.0741363994, 0.0741363994),
   (c_unemp = NULL) => -0.0324217128, -0.0150951649),
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 2.5) => 0.0165414124,
   (f_srchvelocityrisktype_i > 2.5) => 0.0792152561,
   (f_srchvelocityrisktype_i = NULL) => 0.0457922965, 0.0457922965),
(k_inq_per_addr_i = NULL) => -0.0085384229, -0.0085384229);

// Tree: 25 
wFDN_FLAP___lgt_25 := map(
(NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
      map(
      (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0375237542,
         (f_phone_ver_experian_d > 0.5) => -0.0320863188,
         (f_phone_ver_experian_d = NULL) => 0.0003917527, 0.0103049699),
      (f_srchaddrsrchcountmo_i > 1.5) => 0.1818565589,
      (f_srchaddrsrchcountmo_i = NULL) => 0.0125477228, 0.0125477228),
   (f_inq_Communications_count_i > 1.5) => 0.1056235897,
   (f_inq_Communications_count_i = NULL) => 0.0357262368, 0.0171252487),
(k_nap_phn_verd_d > 0.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => -0.0242805377,
   (r_D33_eviction_count_i > 3.5) => 0.1244184551,
   (r_D33_eviction_count_i = NULL) => -0.0232903536, -0.0232903536),
(k_nap_phn_verd_d = NULL) => -0.0078632865, -0.0078632865);

// Tree: 26 
wFDN_FLAP___lgt_26 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 27.05) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => -0.0078622143,
   (r_D30_Derog_Count_i > 11.5) => 0.1062490915,
   (r_D30_Derog_Count_i = NULL) => -0.0020889669, -0.0063239302),
(c_famotf18_p > 27.05) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 
      map(
      (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.05) => 0.0447263835,
      (c_pop_6_11_p > 10.05) => 
         map(
         (NULL < c_pop_0_5_p and c_pop_0_5_p <= 8.5) => 0.2638353241,
         (c_pop_0_5_p > 8.5) => 0.0771336130,
         (c_pop_0_5_p = NULL) => 0.1428442711, 0.1428442711),
      (c_pop_6_11_p = NULL) => 0.0747487798, 0.0747487798),
   (k_estimated_income_d > 36500) => 0.0046354292,
   (k_estimated_income_d = NULL) => 0.0408050149, 0.0408050149),
(c_famotf18_p = NULL) => -0.0015473856, -0.0019328392);

// Tree: 27 
wFDN_FLAP___lgt_27 := map(
(NULL < c_fammar_p and c_fammar_p <= 50.45) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.1312148297) => 
      map(
      (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 21.5) => 0.0234247252,
      (f_rel_under500miles_cnt_d > 21.5) => 0.1741069032,
      (f_rel_under500miles_cnt_d = NULL) => 0.0333754350, 0.0333754350),
   (f_add_curr_nhood_VAC_pct_i > 0.1312148297) => 0.1255595993,
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0471717045, 0.0471717045),
(c_fammar_p > 50.45) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 0.0596804157,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1553529288,
      (r_C10_M_Hdr_FS_d > 2.5) => -0.0141273752,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0132841119, -0.0132841119),
   (r_D33_Eviction_Recency_d = NULL) => -0.0058437432, -0.0106741225),
(c_fammar_p = NULL) => -0.0148860362, -0.0060020420);

// Tree: 28 
wFDN_FLAP___lgt_28 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1623898435,
   (r_C10_M_Hdr_FS_d > 2.5) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62814) => 0.1442869660,
         (f_addrchangevaluediff_d > -62814) => 0.0108162773,
         (f_addrchangevaluediff_d = NULL) => 0.0229005191, 0.0177607631),
      (f_phone_ver_experian_d > 0.5) => -0.0331289819,
      (f_phone_ver_experian_d = NULL) => -0.0020685541, -0.0100888721),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0091968610, -0.0091968610),
(r_D33_eviction_count_i > 2.5) => 0.1079097929,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_burglary and c_burglary <= 98.5) => -0.0492122704,
   (c_burglary > 98.5) => 0.0966575418,
   (c_burglary = NULL) => 0.0190672161, 0.0190672161), -0.0075186058);

// Tree: 29 
wFDN_FLAP___lgt_29 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 67.5) => 
         map(
         (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1286344367,
         (r_C10_M_Hdr_FS_d > 2.5) => -0.0130626097,
         (r_C10_M_Hdr_FS_d = NULL) => -0.0124405312, -0.0124405312),
      (k_comb_age_d > 67.5) => 0.0709466469,
      (k_comb_age_d = NULL) => -0.0065037341, -0.0065037341),
   (f_inq_PrepaidCards_count_i > 2.5) => 0.1444342926,
   (f_inq_PrepaidCards_count_i = NULL) => -0.0285421691, -0.0060956064),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 82.5) => 0.1935114188,
   (c_many_cars > 82.5) => 0.0462327944,
   (c_many_cars = NULL) => 0.1180583305, 0.1180583305),
(k_nap_contradictory_i = NULL) => -0.0039423651, -0.0039423651);

// Tree: 30 
wFDN_FLAP___lgt_30 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 15.5) => -0.0173941177,
   (f_addrchangecrimediff_i > 15.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.75) => 0.0859332711,
      (c_pop_45_54_p > 17.75) => -0.0659940315,
      (c_pop_45_54_p = NULL) => 0.0529389579, 0.0529389579),
   (f_addrchangecrimediff_i = NULL) => 0.0014212126, -0.0108853935),
(f_srchaddrsrchcount_i > 12.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 62.5) => 0.0368705110,
   (k_comb_age_d > 62.5) => 0.2325267995,
   (k_comb_age_d = NULL) => 0.0560029525, 0.0560029525),
(f_srchaddrsrchcount_i = NULL) => 
   map(
   (NULL < c_med_yearblt and c_med_yearblt <= 1966.5) => 0.0932260016,
   (c_med_yearblt > 1966.5) => -0.0370669040,
   (c_med_yearblt = NULL) => 0.0138746832, 0.0138746832), -0.0077176407);

// Tree: 31 
wFDN_FLAP___lgt_31 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 9.05) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0108838130,
         (k_comb_age_d > 68.5) => 0.0721559323,
         (k_comb_age_d = NULL) => -0.0055083280, -0.0055083280),
      (f_assocsuspicousidcount_i > 15.5) => 0.1219153552,
      (f_assocsuspicousidcount_i = NULL) => -0.0047850148, -0.0047850148),
   (c_unemp > 9.05) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 2.5) => 0.0203286393,
      (f_rel_criminal_count_i > 2.5) => 0.1087368541,
      (f_rel_criminal_count_i = NULL) => 0.0488189942, 0.0488189942),
   (c_unemp = NULL) => -0.0364905218, -0.0028585344),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1701069968,
(f_inq_PrepaidCards_count_i = NULL) => 0.0038690996, -0.0020856943);

// Tree: 32 
wFDN_FLAP___lgt_32 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.255) => -0.0119964388,
   (c_hhsize > 4.255) => 0.1627416812,
   (c_hhsize = NULL) => -0.0072921408, -0.0102001831),
(f_phones_per_addr_curr_i > 7.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 0.0271440578,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
      map(
      (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 9.5) => 0.0323512516,
      (f_rel_homeover100_count_d > 9.5) => 0.1279504908,
      (f_rel_homeover100_count_d = NULL) => 0.0808469822, 0.0808469822),
   (nf_seg_FraudPoint_3_0 = '') => 0.0400081394, 0.0400081394),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0328806737,
   (c_assault > 90) => 0.1079671650,
   (c_assault = NULL) => 0.0282224328, 0.0282224328), -0.0027995990);

// Tree: 33 
wFDN_FLAP___lgt_33 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 82.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0172949771,
      (nf_seg_FraudPoint_3_0 in ['3: Derog']) => 0.0237336543,
      (nf_seg_FraudPoint_3_0 = '') => -0.0107559955, -0.0107559955),
   (k_comb_age_d > 82.5) => 0.1785400537,
   (k_comb_age_d = NULL) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 76.6) => 0.0824290690,
      (c_fammar_p > 76.6) => -0.0827672936,
      (c_fammar_p = NULL) => -0.0099688965, -0.0099688965), -0.0088936923),
(r_L79_adls_per_addr_c6_i > 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 7.75) => 0.0385138830,
   (c_unemp > 7.75) => 0.1624449180,
   (c_unemp = NULL) => 0.0554226117, 0.0554226117),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0056892852, -0.0056892852);

// Tree: 34 
wFDN_FLAP___lgt_34 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 2.5) => 0.1150370537,
(r_C10_M_Hdr_FS_d > 2.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 43.5) => -0.0042741467,
   (r_pb_order_freq_d > 43.5) => -0.0253136124,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 4.5) => 0.0051600934,
         (r_L79_adls_per_addr_c6_i > 4.5) => 0.0834463459,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0102921726, 0.0102921726),
      (f_inq_Communications_count_i > 1.5) => 0.0926530211,
      (f_inq_Communications_count_i = NULL) => 0.0135873190, 0.0135873190), -0.0051488134),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 11.35) => -0.0491423620,
   (c_hh4_p > 11.35) => 0.0714923566,
   (c_hh4_p = NULL) => 0.0163993355, 0.0163993355), -0.0042954054);

// Tree: 35 
wFDN_FLAP___lgt_35 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 34.5) => 
         map(
         (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 134.5) => 0.0016601484,
         (f_prevaddrageoldest_d > 134.5) => 0.1030376215,
         (f_prevaddrageoldest_d = NULL) => 0.0245328523, 0.0245328523),
      (c_born_usa > 34.5) => -0.0180076868,
      (c_born_usa = NULL) => 0.0108448434, -0.0082158305),
   (f_hh_tot_derog_i > 5.5) => 0.0810666919,
   (f_hh_tot_derog_i = NULL) => 
      map(
      (NULL < c_lowrent and c_lowrent <= 6.75) => 0.0682434368,
      (c_lowrent > 6.75) => -0.0560934739,
      (c_lowrent = NULL) => 0.0111156670, 0.0111156670), -0.0055140861),
(r_P85_Phn_Disconnected_i > 0.5) => 0.1175087996,
(r_P85_Phn_Disconnected_i = NULL) => -0.0030701155, -0.0030701155);

// Tree: 36 
wFDN_FLAP___lgt_36 := map(
(NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0204243538,
(f_hh_criminals_i > 0.5) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 59.05) => 
         map(
         (NULL < c_food and c_food <= 31.05) => 0.0238424951,
         (c_food > 31.05) => 0.1245211726,
         (c_food = NULL) => 0.0519216859, 0.0519216859),
      (c_fammar_p > 59.05) => 0.0019948004,
      (c_fammar_p = NULL) => 0.0094130535, 0.0094130535),
   (f_srchcomponentrisktype_i > 1.5) => 0.0932630433,
   (f_srchcomponentrisktype_i = NULL) => 0.0157488508, 0.0157488508),
(f_hh_criminals_i = NULL) => 
   map(
   (NULL < c_larceny and c_larceny <= 70) => -0.0749137132,
   (c_larceny > 70) => 0.0581430695,
   (c_larceny = NULL) => 0.0023450638, 0.0023450638), -0.0087289564);

// Tree: 37 
wFDN_FLAP___lgt_37 := map(
(NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_housingcpi and c_housingcpi <= 222.35) => 
         map(
         (NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 0.5) => 0.0161318962,
         (f_srchphonesrchcountmo_i > 0.5) => 0.1725918338,
         (f_srchphonesrchcountmo_i = NULL) => 0.0211520012, 0.0211520012),
      (c_housingcpi > 222.35) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 314) => 0.0830697000,
         (r_C13_max_lres_d > 314) => 0.3113857163,
         (r_C13_max_lres_d = NULL) => 0.1049086233, 0.1049086233),
      (c_housingcpi = NULL) => 0.0222474890, 0.0416225722),
   (f_phone_ver_experian_d > 0.5) => -0.0094554619,
   (f_phone_ver_experian_d = NULL) => 0.0084207136, 0.0170103948),
(f_corrphonelastnamecount_d > 0.5) => -0.0145587731,
(f_corrphonelastnamecount_d = NULL) => -0.0016429832, -0.0006730531);

// Tree: 38 
wFDN_FLAP___lgt_38 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0147368685,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < c_employees and c_employees <= 71.5) => 0.0768062648,
      (c_employees > 71.5) => 
         map(
         (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -67556) => 0.1445517573,
         (f_addrchangevaluediff_d > -67556) => 0.0004850679,
         (f_addrchangevaluediff_d = NULL) => 0.0334238226, 0.0105640407),
      (c_employees = NULL) => 0.0244451625, 0.0244451625),
   (f_inq_Other_count_i = NULL) => -0.0058344343, -0.0058344343),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1285910561,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_hh00 and c_hh00 <= 557) => 0.0788165903,
   (c_hh00 > 557) => -0.0393946096,
   (c_hh00 = NULL) => 0.0122680629, 0.0122680629), -0.0049356239);

// Tree: 39 
wFDN_FLAP___lgt_39 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => -0.0066485430,
   (f_srchfraudsrchcountmo_i > 0.5) => 0.0691814803,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0031905515, -0.0043429813),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_hval_80k_p and c_hval_80k_p <= 9.7) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 0.0924171016,
         (r_L79_adls_per_addr_curr_i > 4.5) => 0.2831465046,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.1500794792, 0.1500794792),
      (f_srchfraudsrchcount_i > 1.5) => 0.0292066024,
      (f_srchfraudsrchcount_i = NULL) => 0.0694196292, 0.0694196292),
   (c_hval_80k_p > 9.7) => -0.0513428744,
   (c_hval_80k_p = NULL) => 0.0495842421, 0.0495842421),
(k_inq_per_phone_i = NULL) => -0.0016774417, -0.0016774417);

// Tree: 40 
wFDN_FLAP___lgt_40 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 1.5) => -0.0142005395,
   (f_hh_tot_derog_i > 1.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0002978760,
      (f_sourcerisktype_i > 4.5) => 0.0484941668,
      (f_sourcerisktype_i = NULL) => 0.0200458533, 0.0200458533),
   (f_hh_tot_derog_i = NULL) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 9.55) => -0.0446962492,
      (C_INC_125K_P > 9.55) => 0.0642237973,
      (C_INC_125K_P = NULL) => 0.0055016853, 0.0055016853), -0.0036049150),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 196) => 0.0098403944,
   (f_M_Bureau_ADL_FS_all_d > 196) => 0.1596311437,
   (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0674522211, 0.0674522211),
(k_nap_contradictory_i = NULL) => -0.0023557435, -0.0023557435);

// Tree: 41 
wFDN_FLAP___lgt_41 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1714076830,
   (f_phone_ver_experian_d > 0.5) => -0.0373183655,
   (f_phone_ver_experian_d = NULL) => 0.0799545342, 0.0736528437),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0135563289,
   (k_inq_per_phone_i > 1.5) => 
      map(
      (NULL < f_inq_count24_i and f_inq_count24_i <= 1.5) => 0.0885074906,
      (f_inq_count24_i > 1.5) => 0.0005885436,
      (f_inq_count24_i = NULL) => 0.0303055825, 0.0303055825),
   (k_inq_per_phone_i = NULL) => -0.0092412844, -0.0092412844),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 51.5) => 0.0795612555,
   (c_born_usa > 51.5) => -0.0372005026,
   (c_born_usa = NULL) => 0.0122748186, 0.0122748186), -0.0075843174);

// Tree: 42 
wFDN_FLAP___lgt_42 := map(
(NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 125) => 0.1365112517,
   (r_D32_Mos_Since_Fel_LS_d > 125) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => -0.0069691524,
      (k_comb_age_d > 81.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 123.5) => -0.0072085876,
         (c_easiqlife > 123.5) => 0.2759966055,
         (c_easiqlife = NULL) => 0.1257244622, 0.1257244622),
      (k_comb_age_d = NULL) => -0.0053796836, -0.0053796836),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => -0.0045982319, -0.0045982319),
(f_inq_PrepaidCards_count24_i > 0.5) => 0.0719546522,
(f_inq_PrepaidCards_count24_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 15.6) => -0.0394111843,
   (c_hh4_p > 15.6) => 0.0745561220,
   (c_hh4_p = NULL) => 0.0031139300, 0.0031139300), -0.0034213143);

// Tree: 43 
wFDN_FLAP___lgt_43 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 87.5) => 0.2200255518,
   (c_lux_prod > 87.5) => 0.0121940654,
   (c_lux_prod = NULL) => 0.0829938025, 0.0829938025),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0082420279,
   (f_phones_per_addr_curr_i > 7.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -74516.5) => 0.1244473283,
      (f_addrchangevaluediff_d > -74516.5) => 0.0153652629,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 0.0051602354,
         (r_L79_adls_per_addr_c6_i > 3.5) => 0.1250005205,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0412071813, 0.0412071813), 0.0245706037),
   (f_phones_per_addr_curr_i = NULL) => -0.0037465645, -0.0037465645),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0051589400, -0.0024843322);

// Tree: 44 
wFDN_FLAP___lgt_44 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0215273506,
      (c_easiqlife > 132.5) => 0.0140214102,
      (c_easiqlife = NULL) => -0.0223172826, -0.0094212580),
   (r_L79_adls_per_addr_curr_i > 5.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 0.1752830821,
      (r_C10_M_Hdr_FS_d > 10.5) => 0.0256247233,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0317669764, 0.0317669764),
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0052346962, -0.0052346962),
(f_inq_PrepaidCards_count_i > 2.5) => 0.1010814186,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 0.1) => -0.0531797349,
   (c_hval_125k_p > 0.1) => 0.0579913897,
   (c_hval_125k_p = NULL) => 0.0091076328, 0.0091076328), -0.0045665488);

// Tree: 45 
wFDN_FLAP___lgt_45 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 2.05) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 41.5) => -0.0028591163,
      (k_comb_age_d > 41.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0324615512,
         (f_corrrisktype_i > 8.5) => 0.1772643021,
         (f_corrrisktype_i = NULL) => 0.0995652651, 0.0995652651),
      (k_comb_age_d = NULL) => 0.0367994322, 0.0367994322),
   (f_corraddrnamecount_d > 2.5) => -0.0113471197,
   (f_corraddrnamecount_d = NULL) => -0.0044559714, -0.0065042101),
(c_hh7p_p > 2.05) => 
   map(
   (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 21.5) => 0.0247017826,
   (f_srchaddrsrchcount_i > 21.5) => 0.1439006899,
   (f_srchaddrsrchcount_i = NULL) => 0.0269814234, 0.0269814234),
(c_hh7p_p = NULL) => -0.0581235560, -0.0004198529);

// Tree: 46 
wFDN_FLAP___lgt_46 := map(
(NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 2.5) => -0.0043851206,
(f_crim_rel_under25miles_cnt_i > 2.5) => 
   map(
   (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 4.5) => 0.0037643892,
   (f_sourcerisktype_i > 4.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 10.45) => 
         map(
         (NULL < c_low_ed and c_low_ed <= 67.95) => 0.0250343440,
         (c_low_ed > 67.95) => 0.1538081822,
         (c_low_ed = NULL) => 0.0449750690, 0.0449750690),
      (c_hval_150k_p > 10.45) => 0.1590863684,
      (c_hval_150k_p = NULL) => 0.0675240084, 0.0675240084),
   (f_sourcerisktype_i = NULL) => 0.0306084328, 0.0306084328),
(f_crim_rel_under25miles_cnt_i = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 192767.5) => 0.1306892531,
   (r_L80_Inp_AVM_AutoVal_d > 192767.5) => -0.0508955839,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0334408136, -0.0117867388), -0.0002256775);

// Tree: 47 
wFDN_FLAP___lgt_47 := map(
(NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 98.5) => 
      map(
      (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 0.0875854645,
      (r_I60_inq_PrepaidCards_recency_d > 61.5) => -0.0060914082,
      (r_I60_inq_PrepaidCards_recency_d = NULL) => -0.0051103937, -0.0051103937),
   (f_addrchangecrimediff_i > 98.5) => 0.1151823597,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 14.55) => 0.0491654167,
      (c_high_ed > 14.55) => -0.0225156762,
      (c_high_ed = NULL) => -0.0028680454, -0.0042840342), -0.0041528762),
(f_srchfraudsrchcountmo_i > 0.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 15.45) => 0.0383377504,
   (C_INC_125K_P > 15.45) => 0.2280869754,
   (C_INC_125K_P = NULL) => 0.0600842908, 0.0600842908),
(f_srchfraudsrchcountmo_i = NULL) => -0.0045609632, -0.0018839221);

// Tree: 48 
wFDN_FLAP___lgt_48 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 29850) => 0.0807313177,
   (r_A46_Curr_AVM_AutoVal_d > 29850) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 7.5) => 0.1395312943,
      (f_M_Bureau_ADL_FS_noTU_d > 7.5) => -0.0019648124,
      (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0000637131, -0.0000637131),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0163337059, -0.0061089410),
(k_inq_per_phone_i > 2.5) => 
   map(
   (NULL < c_rnt1000_p and c_rnt1000_p <= 29.55) => 0.0097399907,
   (c_rnt1000_p > 29.55) => 
      map(
      (NULL < c_rest_indx and c_rest_indx <= 77.5) => 0.2020012879,
      (c_rest_indx > 77.5) => 0.0717270247,
      (c_rest_indx = NULL) => 0.1101315763, 0.1101315763),
   (c_rnt1000_p = NULL) => 0.0379343808, 0.0379343808),
(k_inq_per_phone_i = NULL) => -0.0039354196, -0.0039354196);

// Tree: 49 
wFDN_FLAP___lgt_49 := map(
(NULL < f_hh_tot_derog_i and f_hh_tot_derog_i <= 5.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 4.5) => -0.0008690849,
      (f_varrisktype_i > 4.5) => 
         map(
         (NULL < c_rnt500_p and c_rnt500_p <= 6.85) => 0.1322415523,
         (c_rnt500_p > 6.85) => 0.0249406817,
         (c_rnt500_p = NULL) => 0.0818758376, 0.0818758376),
      (f_varrisktype_i = NULL) => 0.0009087764, 0.0009087764),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0697504780,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0019858109, -0.0019858109),
(f_hh_tot_derog_i > 5.5) => 0.0701121176,
(f_hh_tot_derog_i = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 8.95) => -0.0344798400,
   (C_INC_125K_P > 8.95) => 0.0772997712,
   (C_INC_125K_P = NULL) => 0.0209403034, 0.0209403034), 0.0003205837);

// Tree: 50 
wFDN_FLAP___lgt_50 := map(
(NULL < c_unemp and c_unemp <= 8.65) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 8.5) => 0.0819004589,
   (r_C10_M_Hdr_FS_d > 8.5) => -0.0039810636,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0133808847, -0.0025408213),
(c_unemp > 8.65) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 204.35) => 
      map(
      (NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 0.5) => 0.2224045276,
      (f_property_owners_ct_d > 0.5) => 0.0524179214,
      (f_property_owners_ct_d = NULL) => 0.1263815592, 0.1263815592),
   (c_housingcpi > 204.35) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 22.65) => -0.0152431326,
      (c_rnt1000_p > 22.65) => 0.0973382331,
      (c_rnt1000_p = NULL) => 0.0236583903, 0.0236583903),
   (c_housingcpi = NULL) => 0.0416113226, 0.0416113226),
(c_unemp = NULL) => -0.0094119599, -0.0000372094);

// Tree: 51 
wFDN_FLAP___lgt_51 := map(
(NULL < c_employees and c_employees <= 71.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 166.5) => 
      map(
      (NULL < c_unemp and c_unemp <= 9.05) => 0.0055149689,
      (c_unemp > 9.05) => 0.0703239080,
      (c_unemp = NULL) => 0.0113458205, 0.0113458205),
   (f_curraddrcrimeindex_i > 166.5) => 0.0936049200,
   (f_curraddrcrimeindex_i = NULL) => 0.0206984385, 0.0206984385),
(c_employees > 71.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 38.5) => -0.0115257442,
   (f_phones_per_addr_curr_i > 38.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 67) => 0.0183232073,
      (r_C12_source_profile_d > 67) => 0.2407946419,
      (r_C12_source_profile_d = NULL) => 0.0829458621, 0.0829458621),
   (f_phones_per_addr_curr_i = NULL) => -0.0394436908, -0.0097932455),
(c_employees = NULL) => -0.0162671702, -0.0035810516);

// Tree: 52 
wFDN_FLAP___lgt_52 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0056425086,
   (k_comb_age_d > 70.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 175) => 0.0610068741,
      (c_sub_bus > 175) => 0.2363639842,
      (c_sub_bus = NULL) => 0.0786043306, 0.0786043306),
   (k_comb_age_d = NULL) => -0.0110372225, -0.0017524243),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 63.5) => 0.1993963141,
      (c_old_homes > 63.5) => -0.0272777795,
      (c_old_homes = NULL) => 0.0436447896, 0.0436447896),
   (f_inq_count_i > 2.5) => 0.2273505339,
   (f_inq_count_i = NULL) => 0.0978530420, 0.0978530420),
(r_P85_Phn_Disconnected_i = NULL) => 0.0002577452, 0.0002577452);

// Tree: 53 
wFDN_FLAP___lgt_53 := map(
(NULL < c_easiqlife and c_easiqlife <= 129.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 56.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 191.5) => -0.0169523417,
      (c_unempl > 191.5) => 0.0774666746,
      (c_unempl = NULL) => -0.0158561843, -0.0158561843),
   (f_phones_per_addr_curr_i > 56.5) => 0.1464387679,
   (f_phones_per_addr_curr_i = NULL) => 0.0188678217, -0.0143441098),
(c_easiqlife > 129.5) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 2.5) => 
      map(
      (NULL < c_blue_empl and c_blue_empl <= 132.5) => 0.0401571378,
      (c_blue_empl > 132.5) => 0.2027118726,
      (c_blue_empl = NULL) => 0.0712399553, 0.0712399553),
   (f_prevaddrlenofres_d > 2.5) => 0.0132798060,
   (f_prevaddrlenofres_d = NULL) => 0.0231180706, 0.0181778373),
(c_easiqlife = NULL) => -0.0228268969, -0.0024974913);

// Tree: 54 
wFDN_FLAP___lgt_54 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 48) => 0.1411464738,
(f_attr_arrest_recency_d > 48) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 141.5) => 0.0060470796,
      (f_prevaddrageoldest_d > 141.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 10.75) => 0.0675585514,
         (C_INC_35K_P > 10.75) => 0.2161744228,
         (C_INC_35K_P = NULL) => 0.1359481559, 0.1359481559),
      (f_prevaddrageoldest_d = NULL) => 0.0286546849, 0.0286546849),
   (r_F01_inp_addr_address_score_d > 25) => -0.0065215444,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0045449081, -0.0045449081),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0522517107,
   (k_nap_lname_verd_d > 0.5) => -0.0692619046,
   (k_nap_lname_verd_d = NULL) => 0.0004172314, 0.0004172314), -0.0038802468);

// Tree: 55 
wFDN_FLAP___lgt_55 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 1792) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 58.5) => -0.0087523317,
      (k_comb_age_d > 58.5) => 0.0631363274,
      (k_comb_age_d = NULL) => 0.0036567320, 0.0036567320),
   (f_addrchangeincomediff_d > 1792) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 11.85) => 0.0461196443,
      (c_hval_150k_p > 11.85) => 0.1997799665,
      (c_hval_150k_p = NULL) => 0.0736291649, 0.0736291649),
   (f_addrchangeincomediff_d = NULL) => 0.0096773654, 0.0093923765),
(f_phone_ver_insurance_d > 3.5) => -0.0228643594,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 7.45) => 0.0380839212,
   (c_construction > 7.45) => -0.0867028675,
   (c_construction = NULL) => -0.0074463936, -0.0074463936), -0.0063896735);

// Tree: 56 
wFDN_FLAP___lgt_56 := map(
(NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
   map(
   (NULL < c_food and c_food <= 62.6) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0062877367,
      (r_L70_Add_Standardized_i > 0.5) => 0.0867172277,
      (r_L70_Add_Standardized_i = NULL) => 0.0124109696, 0.0124109696),
   (c_food > 62.6) => 0.1176248480,
   (c_food = NULL) => 0.0496151606, 0.0174266115),
(f_phone_ver_experian_d > 0.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => -0.0205651375,
   (f_inq_HighRiskCredit_count_i > 1.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 37.75) => 0.0032550535,
      (c_fammar18_p > 37.75) => 0.1452172944,
      (c_fammar18_p = NULL) => 0.0688315201, 0.0688315201),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0174905667, -0.0174905667),
(f_phone_ver_experian_d = NULL) => -0.0101289143, -0.0044163843);

// Tree: 57 
wFDN_FLAP___lgt_57 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 11.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 178.5) => -0.0083723407,
      (c_lar_fam > 178.5) => 0.0897681817,
      (c_lar_fam = NULL) => -0.0236661690, -0.0071173266),
   (k_comb_age_d > 81.5) => 
      map(
      (NULL < c_popover25 and c_popover25 <= 1295) => 0.1726037608,
      (c_popover25 > 1295) => -0.0746826080,
      (c_popover25 = NULL) => 0.0868105308, 0.0868105308),
   (k_comb_age_d = NULL) => -0.0059678731, -0.0059678731),
(r_D30_Derog_Count_i > 11.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 95.5) => 0.1419090131,
   (c_rich_wht > 95.5) => 0.0209981925,
   (c_rich_wht = NULL) => 0.0745836698, 0.0745836698),
(r_D30_Derog_Count_i = NULL) => -0.0047631959, -0.0048349583);

// Tree: 58 
wFDN_FLAP___lgt_58 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0068083203,
(k_inq_per_phone_i > 2.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','6: Other']) => 
      map(
      (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < c_famotf18_p and c_famotf18_p <= 8.1) => 0.1553041656,
         (c_famotf18_p > 8.1) => 0.0086722765,
         (c_famotf18_p = NULL) => 0.0641770029, 0.0641770029),
      (f_phone_ver_experian_d > 0.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 45.5) => 0.0554366810,
         (k_comb_age_d > 45.5) => -0.0986016287,
         (k_comb_age_d = NULL) => -0.0018072854, -0.0018072854),
      (f_phone_ver_experian_d = NULL) => -0.0199618866, 0.0153921327),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','5: Vuln Vic/Friendly']) => 0.2079864645,
   (nf_seg_FraudPoint_3_0 = '') => 0.0326801279, 0.0326801279),
(k_inq_per_phone_i = NULL) => -0.0048315631, -0.0048315631);

// Tree: 59 
wFDN_FLAP___lgt_59 := map(
(NULL < f_divaddrsuspidcountnew_i and f_divaddrsuspidcountnew_i <= 2.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => -0.0063916847,
   (f_nae_nothing_found_i > 0.5) => 0.0966309141,
   (f_nae_nothing_found_i = NULL) => -0.0050018777, -0.0050018777),
(f_divaddrsuspidcountnew_i > 2.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 12.95) => -0.0328799704,
   (c_pop_35_44_p > 12.95) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.3487641756) => 0.1872365329,
      (f_add_input_nhood_MFD_pct_i > 0.3487641756) => 0.0584223575,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.1196488483, 0.1196488483),
   (c_pop_35_44_p = NULL) => 0.0625126458, 0.0625126458),
(f_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.15) => 0.0512684823,
   (c_hh3_p > 13.15) => -0.0915286786,
   (c_hh3_p = NULL) => -0.0219003109, -0.0219003109), -0.0035304584);

// Tree: 60 
wFDN_FLAP___lgt_60 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 93.5) => 
   map(
   (NULL < c_popover25 and c_popover25 <= 1415.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52.15) => 0.1177301545,
      (r_C12_source_profile_d > 52.15) => -0.0510063767,
      (r_C12_source_profile_d = NULL) => 0.0045888966, 0.0045888966),
   (c_popover25 > 1415.5) => 0.2067542872,
   (c_popover25 = NULL) => 0.0640007665, 0.0640007665),
(f_mos_liens_unrel_SC_fseen_d > 93.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 63.5) => -0.0077625167,
   (f_addrchangecrimediff_i > 63.5) => 0.0577655209,
   (f_addrchangecrimediff_i = NULL) => 0.0025205683, -0.0045029464),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_retail and c_retail <= 13.65) => -0.0588147095,
   (c_retail > 13.65) => 0.0777406713,
   (c_retail = NULL) => -0.0050527485, -0.0050527485), -0.0031810431);

// Tree: 61 
wFDN_FLAP___lgt_61 := map(
(NULL < c_hh1_p and c_hh1_p <= 18.65) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 47546) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.02140577035) => 
         map(
         (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => 
            map(
            (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => 0.0307083168,
            (f_rel_homeover300_count_d > 1.5) => 0.1426410177,
            (f_rel_homeover300_count_d = NULL) => 0.0840276101, 0.0840276101),
         (f_rel_felony_count_i > 0.5) => 0.2216005030,
         (f_rel_felony_count_i = NULL) => 0.1057693752, 0.1057693752),
      (f_add_input_nhood_VAC_pct_i > 0.02140577035) => -0.0001388244,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0575292903, 0.0575292903),
   (f_curraddrmedianincome_d > 47546) => 0.0142190257,
   (f_curraddrmedianincome_d = NULL) => 0.0210314220, 0.0210314220),
(c_hh1_p > 18.65) => -0.0112763186,
(c_hh1_p = NULL) => -0.0375040441, -0.0008283548);

// Tree: 62 
wFDN_FLAP___lgt_62 := map(
(NULL < f_assoccredbureaucountnew_i and f_assoccredbureaucountnew_i <= 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0092162728,
   (f_prevaddrageoldest_d > 152.5) => 0.0287623610,
   (f_prevaddrageoldest_d = NULL) => 0.0001376897, 0.0001376897),
(f_assoccredbureaucountnew_i > 0.5) => 
   map(
   (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 0.5) => -0.0281237555,
   (f_rel_incomeover75_count_d > 0.5) => 
      map(
      (NULL < c_many_cars and c_many_cars <= 89) => 0.1999013348,
      (c_many_cars > 89) => 0.0474976838,
      (c_many_cars = NULL) => 0.1133083513, 0.1133083513),
   (f_rel_incomeover75_count_d = NULL) => 0.0670605901, 0.0670605901),
(f_assoccredbureaucountnew_i = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 121.5) => -0.0044827909,
   (c_relig_indx > 121.5) => 0.0885915065,
   (c_relig_indx = NULL) => 0.0371557106, 0.0371557106), 0.0019337674);

// Tree: 63 
wFDN_FLAP___lgt_63 := map(
(NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0286281026) => -0.0431153681,
   (f_add_input_nhood_BUS_pct_i > 0.0286281026) => 0.1068353498,
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0433592790, 0.0433592790),
(r_I60_inq_PrepaidCards_recency_d > 61.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 1.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 99835) => 0.0350745290,
      (f_addrchangevaluediff_d > 99835) => 0.1824350453,
      (f_addrchangevaluediff_d = NULL) => -0.0036541510, 0.0297285257),
   (f_corraddrnamecount_d > 1.5) => -0.0047750690,
   (f_corraddrnamecount_d = NULL) => -0.0022395183, -0.0022395183),
(r_I60_inq_PrepaidCards_recency_d = NULL) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 127) => -0.0579203637,
   (c_cartheft > 127) => 0.0475590520,
   (c_cartheft = NULL) => -0.0205163156, -0.0205163156), -0.0018625448);

// Tree: 64 
wFDN_FLAP___lgt_64 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 271.5) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 8.5) => 0.0602815585,
   (r_C21_M_Bureau_ADL_FS_d > 8.5) => -0.0074471198,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0057953452, -0.0057953452),
(f_prevaddrageoldest_d > 271.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => 
      map(
      (NULL < k_inf_contradictory_i and k_inf_contradictory_i <= 0.5) => 0.0170333554,
      (k_inf_contradictory_i > 0.5) => 0.1711262996,
      (k_inf_contradictory_i = NULL) => 0.0340525761, 0.0340525761),
   (f_inq_Collection_count_i > 3.5) => 0.1790538997,
   (f_inq_Collection_count_i = NULL) => 0.0462131247, 0.0462131247),
(f_prevaddrageoldest_d = NULL) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 124) => 0.0727197529,
   (c_rich_nfam > 124) => -0.0497361072,
   (c_rich_nfam = NULL) => 0.0109940348, 0.0109940348), -0.0011017607);

// Tree: 65 
wFDN_FLAP___lgt_65 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 151.5) => -0.0078670865,
   (f_prevaddrageoldest_d > 151.5) => 
      map(
      (NULL < r_C20_email_verification_d and r_C20_email_verification_d <= 3.5) => 0.2387733458,
      (r_C20_email_verification_d > 3.5) => -0.0397254720,
      (r_C20_email_verification_d = NULL) => 0.0258172768, 0.0295234876),
   (f_prevaddrageoldest_d = NULL) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 99.5) => -0.0712008864,
      (c_span_lang > 99.5) => 0.0599700157,
      (c_span_lang = NULL) => 0.0064522876, 0.0064522876), 0.0013671535),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 14.5) => 0.1468626452,
   (r_P88_Phn_Dst_to_Inp_Add_i > 14.5) => -0.0140984607,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0761373108, 0.0761373108),
(k_nap_contradictory_i = NULL) => 0.0026344443, 0.0026344443);

// Tree: 66 
wFDN_FLAP___lgt_66 := map(
(NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 23.25) => 
      map(
      (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => -0.0085009365,
      (f_assocsuspicousidcount_i > 16.5) => 0.1031953856,
      (f_assocsuspicousidcount_i = NULL) => -0.0166098917, -0.0080048680),
   (c_hh3_p > 23.25) => 
      map(
      (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -3931) => 0.1360010062,
      (f_addrchangeincomediff_d > -3931) => 0.0287450038,
      (f_addrchangeincomediff_d = NULL) => 0.0354298937, 0.0338879841),
   (c_hh3_p = NULL) => -0.0189181950, -0.0018536609),
(k_nap_contradictory_i > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 46) => 0.0301579382,
   (k_comb_age_d > 46) => 0.1397915157,
   (k_comb_age_d = NULL) => 0.0595718249, 0.0595718249),
(k_nap_contradictory_i = NULL) => -0.0007786543, -0.0007786543);

// Tree: 67 
wFDN_FLAP___lgt_67 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 0.0066383754,
      (f_util_adl_count_n > 4.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.1050465077,
         (f_phone_ver_experian_d > 0.5) => 0.0168992097,
         (f_phone_ver_experian_d = NULL) => 0.0885526853, 0.0558371613),
      (f_util_adl_count_n = NULL) => 0.0117026005, 0.0117026005),
   (f_historical_count_d > 0.5) => -0.0151409090,
   (f_historical_count_d = NULL) => -0.0019907363, -0.0019907363),
(r_D33_eviction_count_i > 3.5) => 0.0741434440,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 7.65) => -0.0807553469,
   (c_famotf18_p > 7.65) => 0.0437635559,
   (c_famotf18_p = NULL) => -0.0052596342, -0.0052596342), -0.0015307173);

// Tree: 68 
wFDN_FLAP___lgt_68 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 0.5) => 
      map(
      (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 2.5) => 0.0068950967,
      (f_hh_lienholders_i > 2.5) => 
         map(
         (NULL < C_INC_50K_P and C_INC_50K_P <= 17.75) => 0.0384257929,
         (C_INC_50K_P > 17.75) => 0.1988042057,
         (C_INC_50K_P = NULL) => 0.0823188322, 0.0823188322),
      (f_hh_lienholders_i = NULL) => 0.0093408588, 0.0093408588),
   (f_inq_PrepaidCards_count_i > 0.5) => 0.0762922038,
   (f_inq_PrepaidCards_count_i = NULL) => 0.0115284538, 0.0115284538),
(f_historical_count_d > 0.5) => -0.0153545977,
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_construction and c_construction <= 4.7) => 0.0487024940,
   (c_construction > 4.7) => -0.0697734952,
   (c_construction = NULL) => -0.0137499654, -0.0137499654), -0.0023628849);

// Tree: 69 
wFDN_FLAP___lgt_69 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62436.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 3.5) => 
      map(
      (NULL < c_rich_fam and c_rich_fam <= 142.5) => 0.0533526021,
      (c_rich_fam > 142.5) => -0.1088907171,
      (c_rich_fam = NULL) => 0.0133278185, 0.0133278185),
   (f_util_adl_count_n > 3.5) => 0.1735022644,
   (f_util_adl_count_n = NULL) => 0.0454755066, 0.0454755066),
(f_addrchangevaluediff_d > -62436.5) => -0.0076950159,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 15.5) => -0.0035573458,
   (f_inq_count_i > 15.5) => 0.1277601403,
   (f_inq_count_i = NULL) => 
      map(
      (NULL < c_rich_old and c_rich_old <= 100.5) => -0.0551262084,
      (c_rich_old > 100.5) => 0.0584661396,
      (c_rich_old = NULL) => -0.0068070753, -0.0068070753), -0.0006983149), -0.0049006261);

// Tree: 70 
wFDN_FLAP___lgt_70 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 38.65) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 1.5) => 
      map(
      (NULL < f_prevaddroccupantowned_i and f_prevaddroccupantowned_i <= 0.5) => 0.0166695009,
      (f_prevaddroccupantowned_i > 0.5) => 0.1335568300,
      (f_prevaddroccupantowned_i = NULL) => 0.0298173212, 0.0298173212),
   (f_prevaddrlenofres_d > 1.5) => -0.0109153570,
   (f_prevaddrlenofres_d = NULL) => 0.0003684702, -0.0081916277),
(c_hval_750k_p > 38.65) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0062729609,
   (r_C14_Addr_Stability_v2_d > 3.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 76500) => 0.2132571292,
      (k_estimated_income_d > 76500) => 0.0677430154,
      (k_estimated_income_d = NULL) => 0.0861958922, 0.0861958922),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0473434329, 0.0473434329),
(c_hval_750k_p = NULL) => 0.0100590874, -0.0035856372);

// Tree: 71 
wFDN_FLAP___lgt_71 := map(
(NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 0.5) => 0.0007473238,
(f_inq_Communications_count_i > 0.5) => 
   map(
   (NULL < f_current_count_d and f_current_count_d <= 0.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 8.05) => 0.0228409113,
      (C_INC_25K_P > 8.05) => 
         map(
         (NULL < c_unempl and c_unempl <= 99.5) => 0.2258082367,
         (c_unempl > 99.5) => 
            map(
            (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 71) => 0.1312096633,
            (f_mos_inq_banko_cm_fseen_d > 71) => 0.0120887186,
            (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0568956795, 0.0568956795),
         (c_unempl = NULL) => 0.1042803902, 0.1042803902),
      (C_INC_25K_P = NULL) => 0.0648071734, 0.0648071734),
   (f_current_count_d > 0.5) => -0.0073599718,
   (f_current_count_d = NULL) => 0.0309549171, 0.0309549171),
(f_inq_Communications_count_i = NULL) => -0.0206534580, 0.0031747792);

// Tree: 72 
wFDN_FLAP___lgt_72 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 15.5) => 
   map(
   (NULL < r_P85_Phn_Not_Issued_i and r_P85_Phn_Not_Issued_i <= 0.5) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0301460841,
         (f_phone_ver_experian_d > 0.5) => -0.0217995124,
         (f_phone_ver_experian_d = NULL) => 0.0107700756, 0.0080890788),
      (f_corrphonelastnamecount_d > 0.5) => -0.0154283167,
      (f_corrphonelastnamecount_d = NULL) => -0.0053665710, -0.0053665710),
   (r_P85_Phn_Not_Issued_i > 0.5) => -0.0704546934,
   (r_P85_Phn_Not_Issued_i = NULL) => -0.0069089436, -0.0069089436),
(f_assocsuspicousidcount_i > 15.5) => 0.0891440084,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => -0.0533550150,
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.0429347103,
   (r_L79_adls_per_addr_c6_i = NULL) => -0.0216360467, -0.0216360467), -0.0066065481);

// Tree: 73 
wFDN_FLAP___lgt_73 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 190.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 1.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 86.5) => 
         map(
         (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 13.5) => 0.0132867566,
         (k_inq_per_addr_i > 13.5) => 0.1275644017,
         (k_inq_per_addr_i = NULL) => 0.0145260185, 0.0145260185),
      (c_no_teens > 86.5) => -0.0146350466,
      (c_no_teens = NULL) => -0.0071112148, -0.0021209928),
   (f_inq_PrepaidCards_count24_i > 1.5) => 0.1168717439,
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0016347127, -0.0016347127),
(f_curraddrcrimeindex_i > 190.5) => 0.0735005539,
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 101) => -0.0587927452,
   (c_span_lang > 101) => 0.0551398641,
   (c_span_lang = NULL) => 0.0055661334, 0.0055661334), 0.0001791854);

// Tree: 74 
wFDN_FLAP___lgt_74 := map(
(NULL < f_vf_AltLexID_phn_hi_risk_ct_i and f_vf_AltLexID_phn_hi_risk_ct_i <= 0.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0196819080,
   (f_util_add_curr_conv_n > 0.5) => 
      map(
      (NULL < f_prevaddrstatus_i and f_prevaddrstatus_i <= 2.5) => 0.0363448318,
      (f_prevaddrstatus_i > 2.5) => -0.0052153508,
      (f_prevaddrstatus_i = NULL) => -0.0027879098, 0.0063728511),
   (f_util_add_curr_conv_n = NULL) => -0.0051594449, -0.0051594449),
(f_vf_AltLexID_phn_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < c_rich_wht and c_rich_wht <= 149.5) => 0.0092269777,
   (c_rich_wht > 149.5) => 0.1934128465,
   (c_rich_wht = NULL) => 0.0580926164, 0.0580926164),
(f_vf_AltLexID_phn_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.3) => -0.0474670901,
   (c_pop_6_11_p > 7.3) => 0.0702902505,
   (c_pop_6_11_p = NULL) => 0.0206569912, 0.0206569912), -0.0038901683);

// Tree: 75 
wFDN_FLAP___lgt_75 := map(
(NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 2.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
      map(
      (NULL < f_inq_QuizProvider_count24_i and f_inq_QuizProvider_count24_i <= 0.5) => -0.0096745451,
      (f_inq_QuizProvider_count24_i > 0.5) => 
         map(
         (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 152.5) => 0.1664065764,
         (f_mos_liens_unrel_CJ_fseen_d > 152.5) => 0.0252385098,
         (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0348121765, 0.0348121765),
      (f_inq_QuizProvider_count24_i = NULL) => -0.0067703568, -0.0067703568),
   (f_bus_addr_match_count_d > 52.5) => 0.1490297783,
   (f_bus_addr_match_count_d = NULL) => -0.0057115935, -0.0057115935),
(nf_vf_hi_addr_add_entries > 2.5) => 0.0900386005,
(nf_vf_hi_addr_add_entries = NULL) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 1.05) => 0.0388459272,
   (c_wholesale > 1.05) => -0.0788406163,
   (c_wholesale = NULL) => -0.0182834628, -0.0182834628), -0.0054088096);

// Tree: 76 
wFDN_FLAP___lgt_76 := map(
(NULL < c_rnt1250_p and c_rnt1250_p <= 15.45) => -0.0108523213,
(c_rnt1250_p > 15.45) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 123.5) => 0.0014016939,
      (f_prevaddrlenofres_d > 123.5) => 
         map(
         (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 3.5) => 0.0430336919,
         (f_rel_homeover500_count_d > 3.5) => 
            map(
            (NULL < c_rich_wht and c_rich_wht <= 107.5) => 0.0297384183,
            (c_rich_wht > 107.5) => 0.3173752832,
            (c_rich_wht = NULL) => 0.1962650243, 0.1962650243),
         (f_rel_homeover500_count_d = NULL) => 0.0678643556, 0.0678643556),
      (f_prevaddrlenofres_d = NULL) => 0.0197041305, 0.0197041305),
   (f_nae_nothing_found_i > 0.5) => 0.1946192364,
   (f_nae_nothing_found_i = NULL) => 0.0224379557, 0.0224379557),
(c_rnt1250_p = NULL) => 0.0000973205, -0.0013788813);

// Tree: 77 
wFDN_FLAP___lgt_77 := map(
(NULL < c_transport and c_transport <= 29.05) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 14.75) => -0.0143147903,
   (c_pop_35_44_p > 14.75) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 20037.5) => 
         map(
         (NULL < c_exp_prod and c_exp_prod <= 98.5) => 0.2074048811,
         (c_exp_prod > 98.5) => 0.0241739138,
         (c_exp_prod = NULL) => 0.0989841904, 0.0989841904),
      (f_curraddrmedianincome_d > 20037.5) => 0.0104038112,
      (f_curraddrmedianincome_d = NULL) => 0.0493712258, 0.0132264023),
   (c_pop_35_44_p = NULL) => -0.0004446693, -0.0004446693),
(c_transport > 29.05) => 
   map(
   (NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 2.5) => 0.1956515927,
   (f_phone_ver_insurance_d > 2.5) => 0.0383774889,
   (f_phone_ver_insurance_d = NULL) => 0.0986913442, 0.0986913442),
(c_transport = NULL) => -0.0131656363, 0.0008878602);

// Tree: 78 
wFDN_FLAP___lgt_78 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 23.5) => 
         map(
         (NULL < f_varrisktype_i and f_varrisktype_i <= 2.5) => 0.0039488533,
         (f_varrisktype_i > 2.5) => 
            map(
            (NULL < c_civ_emp and c_civ_emp <= 63.15) => 0.2532445120,
            (c_civ_emp > 63.15) => 0.0764836535,
            (c_civ_emp = NULL) => 0.1587688807, 0.1587688807),
         (f_varrisktype_i = NULL) => 0.0714643540, 0.0714643540),
      (r_C13_max_lres_d > 23.5) => 0.0029964870,
      (r_C13_max_lres_d = NULL) => 0.0045481997, 0.0045481997),
   (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0605762521,
   (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0191531811, 0.0020347149),
(r_L77_Add_PO_Box_i > 0.5) => -0.1041338892,
(r_L77_Add_PO_Box_i = NULL) => -0.0004426920, -0.0004426920);

// Tree: 79 
wFDN_FLAP___lgt_79 := map(
(NULL < c_hval_750k_p and c_hval_750k_p <= 41.45) => 
   map(
   (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => -0.0096918434,
   (r_I61_inq_collection_count12_i > 0.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 2.5) => -0.0005343380,
      (f_srchfraudsrchcount_i > 2.5) => 0.0627315689,
      (f_srchfraudsrchcount_i = NULL) => 0.0184569790, 0.0184569790),
   (r_I61_inq_collection_count12_i = NULL) => -0.0085076782, -0.0070053423),
(c_hval_750k_p > 41.45) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => -0.0154487431,
   (r_C14_Addr_Stability_v2_d > 3.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 7.55) => 0.0583278273,
      (c_hh6_p > 7.55) => 0.1856381388,
      (c_hh6_p = NULL) => 0.0742095966, 0.0742095966),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0358288114, 0.0358288114),
(c_hval_750k_p = NULL) => -0.0112899301, -0.0041364754);

// Tree: 80 
wFDN_FLAP___lgt_80 := map(
(NULL < c_bel_edu and c_bel_edu <= 196.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => -0.0092795543,
   (f_hh_lienholders_i > 0.5) => 
      map(
      (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
         map(
         (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1124058074,
         (r_D32_Mos_Since_Crim_LS_d > 10.5) => 
            map(
            (NULL < c_fammar18_p and c_fammar18_p <= 43.75) => -0.0012739130,
            (c_fammar18_p > 43.75) => 0.0591769187,
            (c_fammar18_p = NULL) => 0.0137649143, 0.0137649143),
         (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0164491975, 0.0164491975),
      (f_adls_per_phone_c6_i > 1.5) => 0.1783219183,
      (f_adls_per_phone_c6_i = NULL) => 0.0187261256, 0.0187261256),
   (f_hh_lienholders_i = NULL) => 0.0077619959, -0.0003129892),
(c_bel_edu > 196.5) => -0.0842572327,
(c_bel_edu = NULL) => 0.0227192551, -0.0006935705);

// Tree: 81 
wFDN_FLAP___lgt_81 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 22.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0062230885,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < c_no_teens and c_no_teens <= 103.5) => 
         map(
         (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 2.5) => 0.1719622674,
         (f_hh_members_ct_d > 2.5) => 
            map(
            (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => -0.0088316972,
            (f_inq_Collection_count_i > 3.5) => 0.1428336688,
            (f_inq_Collection_count_i = NULL) => 0.0294325007, 0.0294325007),
         (f_hh_members_ct_d = NULL) => 0.0733226193, 0.0733226193),
      (c_no_teens > 103.5) => -0.0049685200,
      (c_no_teens = NULL) => 0.0362029473, 0.0362029473),
   (k_inq_per_phone_i = NULL) => -0.0041657182, -0.0041657182),
(f_srchphonesrchcount_i > 22.5) => -0.1110007893,
(f_srchphonesrchcount_i = NULL) => -0.0285949401, -0.0049320118);

// Tree: 82 
wFDN_FLAP___lgt_82 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 3.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 2.5) => -0.0031488851,
   (f_inq_HighRiskCredit_count_i > 2.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 46.5) => -0.0306923507,
      (f_mos_inq_banko_cm_fseen_d > 46.5) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 37.4) => 
            map(
            (NULL < c_retail and c_retail <= 9.75) => 0.1067047442,
            (c_retail > 9.75) => -0.0372867341,
            (c_retail = NULL) => 0.0394190067, 0.0394190067),
         (c_fammar18_p > 37.4) => 0.1451401208,
         (c_fammar18_p = NULL) => 0.0822947919, 0.0822947919),
      (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0418277656, 0.0418277656),
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0021290720, -0.0021290720),
(r_I60_inq_hiRiskCred_count12_i > 3.5) => -0.0852289048,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0005602509, -0.0027122197);

// Tree: 83 
wFDN_FLAP___lgt_83 := map(
(NULL < c_young and c_young <= 33.65) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.6794437421) => 0.0096852594,
   (f_add_curr_nhood_MFD_pct_i > 0.6794437421) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.70305604645) => 0.1632140488,
         (f_add_input_nhood_MFD_pct_i > 0.70305604645) => 0.0524886761,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0903839908, 0.0903839908),
      (f_corraddrnamecount_d > 3.5) => 0.0186689251,
      (f_corraddrnamecount_d = NULL) => 0.0354223850, 0.0354223850),
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0135500385, 0.0069319809),
(c_young > 33.65) => 
   map(
   (NULL < r_I60_inq_banking_count12_i and r_I60_inq_banking_count12_i <= 1.5) => -0.0375487747,
   (r_I60_inq_banking_count12_i > 1.5) => 0.1322292166,
   (r_I60_inq_banking_count12_i = NULL) => -0.0304884814, -0.0304884814),
(c_young = NULL) => -0.0032935107, 0.0020946325);

// Tree: 84 
wFDN_FLAP___lgt_84 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 309.5) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => -0.0031731004,
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.35) => -0.0254800149,
      (c_pop_45_54_p > 14.35) => 0.2530463086,
      (c_pop_45_54_p = NULL) => 0.1071515677, 0.1071515677),
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0021729530, -0.0021729530),
(r_C13_Curr_Addr_LRes_d > 309.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 159.9) => 0.0375541415,
   (c_oldhouse > 159.9) => 0.1395221494,
   (c_oldhouse = NULL) => 0.0551200588, 0.0551200588),
(r_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 9.95) => -0.0405906499,
   (C_INC_125K_P > 9.95) => 0.0826069316,
   (C_INC_125K_P = NULL) => 0.0081565946, 0.0081565946), 0.0012257233);

// Tree: 85 
wFDN_FLAP___lgt_85 := map(
(NULL < f_util_adl_count_n and f_util_adl_count_n <= 4.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 24.5) => -0.0548571010,
      (f_mos_inq_banko_om_fseen_d > 24.5) => -0.0049869073,
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0083014731, -0.0083014731),
   (k_inq_adls_per_phone_i > 2.5) => -0.0994059708,
   (k_inq_adls_per_phone_i = NULL) => -0.0090180440, -0.0090180440),
(f_util_adl_count_n > 4.5) => 
   map(
   (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 8.5) => 0.0209203503,
   (f_inq_Collection_count_i > 8.5) => 0.0973650064,
   (f_inq_Collection_count_i = NULL) => 0.0272947625, 0.0272947625),
(f_util_adl_count_n = NULL) => 
   map(
   (NULL < c_med_age and c_med_age <= 37.25) => 0.0654304039,
   (c_med_age > 37.25) => -0.0453321933,
   (c_med_age = NULL) => 0.0080569723, 0.0080569723), -0.0042603163);

// Tree: 86 
wFDN_FLAP___lgt_86 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 13.5) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 44.5) => -0.0037309568,
   (f_rel_under500miles_cnt_d > 44.5) => -0.1212515765,
   (f_rel_under500miles_cnt_d = NULL) => 0.0237750651, -0.0038950676),
(f_phones_per_addr_curr_i > 13.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 128.5) => 0.0059186708,
   (f_curraddrcrimeindex_i > 128.5) => 
      map(
      (NULL < c_rnt500_p and c_rnt500_p <= 2.2) => 0.2641518026,
      (c_rnt500_p > 2.2) => 0.0624407069,
      (c_rnt500_p = NULL) => 0.1217674997, 0.1217674997),
   (f_curraddrcrimeindex_i = NULL) => 0.0371649637, 0.0371649637),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 11.25) => -0.0478108902,
   (c_pop_55_64_p > 11.25) => 0.0679714866,
   (c_pop_55_64_p = NULL) => -0.0014979395, -0.0014979395), -0.0018139624);

// Tree: 87 
wFDN_FLAP___lgt_87 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 112) => -0.0053983521,
(f_addrchangecrimediff_i > 112) => 0.1166589196,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 5.5) => 
      map(
      (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 396) => -0.0081235790,
      (f_M_Bureau_ADL_FS_all_d > 396) => 
         map(
         (NULL < c_hval_1001k_p and c_hval_1001k_p <= 1.15) => 0.0221501540,
         (c_hval_1001k_p > 1.15) => 0.3431799010,
         (c_hval_1001k_p = NULL) => 0.1219051601, 0.1219051601),
      (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0007209162, 0.0007209162),
   (f_srchphonesrchcount_i > 5.5) => -0.0845228506,
   (f_srchphonesrchcount_i = NULL) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 13.4) => 0.0968553343,
      (c_hh3_p > 13.4) => -0.0350507182,
      (c_hh3_p = NULL) => 0.0200903365, 0.0200903365), -0.0014882939), -0.0040180995);

// Tree: 88 
wFDN_FLAP___lgt_88 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < c_rich_fam and c_rich_fam <= 107) => -0.0132249253,
   (c_rich_fam > 107) => 0.1277613672,
   (c_rich_fam = NULL) => 0.0576154779, 0.0576154779),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < f_crim_rel_under100miles_cnt_i and f_crim_rel_under100miles_cnt_i <= 0.5) => -0.0144070825,
   (f_crim_rel_under100miles_cnt_i > 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 72.5) => 0.0103728817,
      (k_comb_age_d > 72.5) => 0.1084313214,
      (k_comb_age_d = NULL) => 0.0137807807, 0.0137807807),
   (f_crim_rel_under100miles_cnt_i = NULL) => -0.0318779032, -0.0015807227),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 92.5) => -0.0474877577,
   (c_assault > 92.5) => 0.0510477049,
   (c_assault = NULL) => -0.0022147073, -0.0022147073), -0.0006213276);

// Tree: 89 
wFDN_FLAP___lgt_89 := map(
(NULL < c_newhouse and c_newhouse <= 8.95) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.1224166732,
      (r_D32_Mos_Since_Crim_LS_d > 10.5) => 0.0079749705,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0164851338, 0.0101664932),
   (f_nae_nothing_found_i > 0.5) => 0.1374859642,
   (f_nae_nothing_found_i = NULL) => 0.0115656083, 0.0115656083),
(c_newhouse > 8.95) => 
   map(
   (NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 29.5) => -0.0130795832,
   (f_rel_under500miles_cnt_d > 29.5) => -0.0735460120,
   (f_rel_under500miles_cnt_d = NULL) => 
      map(
      (NULL < c_med_yearblt and c_med_yearblt <= 1985.5) => -0.0363315880,
      (c_med_yearblt > 1985.5) => 0.0815635419,
      (c_med_yearblt = NULL) => 0.0096604682, 0.0096604682), -0.0138080919),
(c_newhouse = NULL) => 0.0113933317, -0.0024764860);

// Tree: 90 
wFDN_FLAP___lgt_90 := map(
(NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 4.5) => 
      map(
      (NULL < c_pop_25_34_p and c_pop_25_34_p <= 0.65) => 0.1435645553,
      (c_pop_25_34_p > 0.65) => -0.0033584343,
      (c_pop_25_34_p = NULL) => -0.0040504079, -0.0024163456),
   (k_inq_adls_per_addr_i > 4.5) => -0.0956863768,
   (k_inq_adls_per_addr_i = NULL) => -0.0033180862, -0.0033180862),
(f_srchphonesrchcountwk_i > 0.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 0.5) => -0.0098337456,
   (f_assoccredbureaucount_i > 0.5) => 0.1357563968,
   (f_assoccredbureaucount_i = NULL) => 0.0733606215, 0.0733606215),
(f_srchphonesrchcountwk_i = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 118) => -0.0629117957,
   (c_for_sale > 118) => 0.0521226533,
   (c_for_sale = NULL) => -0.0154372612, -0.0154372612), -0.0026968802);

// Tree: 91 
wFDN_FLAP___lgt_91 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly']) => 
      map(
      (NULL < c_med_age and c_med_age <= 34.35) => -0.1225631237,
      (c_med_age > 34.35) => 0.1044806406,
      (c_med_age = NULL) => 0.0082756557, 0.0082756557),
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','6: Other']) => 0.1410029278,
   (nf_seg_FraudPoint_3_0 = '') => 0.0664228416, 0.0664228416),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < c_food and c_food <= 65.55) => -0.0091371350,
   (c_food > 65.55) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['3: Derog','4: Recent Activity','6: Other']) => 0.0190352919,
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','5: Vuln Vic/Friendly']) => 0.1466730571,
      (nf_seg_FraudPoint_3_0 = '') => 0.0538722049, 0.0538722049),
   (c_food = NULL) => -0.0061696983, -0.0068459364),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0059575980, -0.0054835898);

// Tree: 92 
wFDN_FLAP___lgt_92 := map(
(NULL < C_RENTOCC_P and C_RENTOCC_P <= 89.95) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 69.5) => -0.0010866609,
      (k_comb_age_d > 69.5) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.00684151405) => 0.2267089796,
         (f_add_curr_nhood_MFD_pct_i > 0.00684151405) => 0.0619688719,
         (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0342782733, 0.0554490870),
      (k_comb_age_d = NULL) => -0.0264383788, 0.0018217101),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 9.55) => 0.1555905286,
      (c_newhouse > 9.55) => 0.0056817903,
      (c_newhouse = NULL) => 0.0629333687, 0.0629333687),
   (k_nap_contradictory_i = NULL) => 0.0028164116, 0.0028164116),
(C_RENTOCC_P > 89.95) => -0.0823925861,
(C_RENTOCC_P = NULL) => -0.0456464086, 0.0006051124);

// Tree: 93 
wFDN_FLAP___lgt_93 := map(
(NULL < c_cartheft and c_cartheft <= 189.5) => 
   map(
   (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 187.5) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0018036494,
      (r_D33_eviction_count_i > 2.5) => 
         map(
         (NULL < c_food and c_food <= 16.8) => 0.1764388351,
         (c_food > 16.8) => 0.0074646429,
         (c_food = NULL) => 0.0875050497, 0.0875050497),
      (r_D33_eviction_count_i = NULL) => 0.0026414815, 0.0026414815),
   (f_curraddrcartheftindex_i > 187.5) => 
      map(
      (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 55.5) => 0.0896535531,
      (r_pb_order_freq_d > 55.5) => -0.0233237279,
      (r_pb_order_freq_d = NULL) => 0.1327059957, 0.0820153905),
   (f_curraddrcartheftindex_i = NULL) => 0.0140203002, 0.0042556535),
(c_cartheft > 189.5) => -0.0603312659,
(c_cartheft = NULL) => -0.0020597528, 0.0020270899);

// Tree: 94 
wFDN_FLAP___lgt_94 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 164.5) => 
   map(
   (NULL < c_span_lang and c_span_lang <= 147.5) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.00096365865) => 0.1703313065,
      (f_add_curr_nhood_VAC_pct_i > 0.00096365865) => -0.0113513569,
      (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0249851758, 0.0249851758),
   (c_span_lang > 147.5) => 0.1431457313,
   (c_span_lang = NULL) => 0.0515239102, 0.0515239102),
(f_mos_liens_unrel_SC_fseen_d > 164.5) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.0256635821,
   (f_hh_members_ct_d > 1.5) => -0.0067891654,
   (f_hh_members_ct_d = NULL) => -0.0002927344, -0.0002927344),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => -0.0384447492,
   (r_L79_adls_per_addr_c6_i > 1.5) => 0.0654829266,
   (r_L79_adls_per_addr_c6_i = NULL) => -0.0015473495, -0.0015473495), 0.0012305487);

// Tree: 95 
wFDN_FLAP___lgt_95 := map(
(NULL < c_rnt1000_p and c_rnt1000_p <= 43.75) => -0.0097888224,
(c_rnt1000_p > 43.75) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
      map(
      (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 29862) => 0.1537204342,
      (f_curraddrmedianincome_d > 29862) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 30.65) => 0.0009760149,
         (C_INC_75K_P > 30.65) => 0.1870216732,
         (C_INC_75K_P = NULL) => 0.0080463044, 0.0080463044),
      (f_curraddrmedianincome_d = NULL) => 0.0133796717, 0.0133796717),
   (f_hh_collections_ct_i > 2.5) => 
      map(
      (NULL < c_fammar18_p and c_fammar18_p <= 32.55) => 0.2689136618,
      (c_fammar18_p > 32.55) => 0.0538794035,
      (c_fammar18_p = NULL) => 0.1305795211, 0.1305795211),
   (f_hh_collections_ct_i = NULL) => 0.0252508823, 0.0252508823),
(c_rnt1000_p = NULL) => -0.0100430498, -0.0054742657);

// Tree: 96 
wFDN_FLAP___lgt_96 := map(
(NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0136058498,
(k_inf_nothing_found_i > 0.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 0.0053439907,
      (k_inq_per_addr_i > 6.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2282203897) => 0.2024593874,
         (f_add_curr_mobility_index_i > 0.2282203897) => 0.0276200555,
         (f_add_curr_mobility_index_i = NULL) => 0.0965273216, 0.0965273216),
      (k_inq_per_addr_i = NULL) => 0.0084279206, 0.0084279206),
   (f_srchfraudsrchcountmo_i > 0.5) => 
      map(
      (NULL < c_hval_150k_p and c_hval_150k_p <= 8.85) => 0.0615325453,
      (c_hval_150k_p > 8.85) => 0.2223010547,
      (c_hval_150k_p = NULL) => 0.1086543497, 0.1086543497),
   (f_srchfraudsrchcountmo_i = NULL) => -0.0067959595, 0.0115663250),
(k_inf_nothing_found_i = NULL) => -0.0030666760, -0.0030666760);

// Tree: 97 
wFDN_FLAP___lgt_97 := map(
(NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 
      map(
      (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 12.5) => -0.0009936632,
      (f_hh_members_ct_d > 12.5) => 
         map(
         (NULL < c_retired and c_retired <= 10.95) => 0.1925023104,
         (c_retired > 10.95) => -0.0164493330,
         (c_retired = NULL) => 0.0911451699, 0.0911451699),
      (f_hh_members_ct_d = NULL) => 0.0001060266, 0.0001060266),
   (r_D33_eviction_count_i > 2.5) => 
      map(
      (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 99) => 0.1432567068,
      (r_A50_pb_average_dollars_d > 99) => -0.0057308690,
      (r_A50_pb_average_dollars_d = NULL) => 0.0615538426, 0.0615538426),
   (r_D33_eviction_count_i = NULL) => -0.0101019281, 0.0005926689),
(k_inq_adls_per_addr_i > 3.5) => -0.0531684853,
(k_inq_adls_per_addr_i = NULL) => -0.0005007783, -0.0005007783);

// Tree: 98 
wFDN_FLAP___lgt_98 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.25) => -0.0393189745,
(c_pop_45_54_p > 7.25) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0016426164,
   (f_rel_homeover500_count_d > 14.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02989906365) => 0.0560982527,
      (f_add_curr_nhood_BUS_pct_i > 0.02989906365) => 0.0426099281,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0492873165, 0.0492873165),
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 5.35) => -0.0803487733,
      (c_pop_12_17_p > 5.35) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 56.5) => 0.1684800653,
         (c_no_labfor > 56.5) => 0.0321283924,
         (c_no_labfor = NULL) => 0.0689989978, 0.0689989978),
      (c_pop_12_17_p = NULL) => 0.0253269059, 0.0253269059), -0.0005063757),
(c_pop_45_54_p = NULL) => -0.0115730537, -0.0032421542);

// Tree: 99 
wFDN_FLAP___lgt_99 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 116.5) => 0.0972049064,
(r_D32_Mos_Since_Fel_LS_d > 116.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.37732321285) => 
      map(
      (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => -0.0097937312,
      (f_util_add_curr_conv_n > 0.5) => 
         map(
         (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 6.5) => 0.0202274773,
         (k_inq_per_phone_i > 6.5) => 0.0917420087,
         (k_inq_per_phone_i = NULL) => 0.0211844844, 0.0211844844),
      (f_util_add_curr_conv_n = NULL) => 0.0075591360, 0.0075591360),
   (f_add_input_mobility_index_i > 0.37732321285) => -0.0243336932,
   (f_add_input_mobility_index_i = NULL) => 0.0399748953, 0.0023655532),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_employees and c_employees <= 423.5) => -0.0606511132,
   (c_employees > 423.5) => 0.0551786872,
   (c_employees = NULL) => -0.0079226220, -0.0079226220), 0.0027201353);

// Tree: 100 
wFDN_FLAP___lgt_100 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.1016496314,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < f_historical_count_d and f_historical_count_d <= 0.5) => 
      map(
      (NULL < c_transport and c_transport <= 26.6) => 
         map(
         (NULL < f_vf_AltLexID_phn_hi_risk_ct_i and f_vf_AltLexID_phn_hi_risk_ct_i <= 0.5) => 0.0038098066,
         (f_vf_AltLexID_phn_hi_risk_ct_i > 0.5) => 0.0963775510,
         (f_vf_AltLexID_phn_hi_risk_ct_i = NULL) => 0.0055422730, 0.0055422730),
      (c_transport > 26.6) => 0.1593172976,
      (c_transport = NULL) => 0.0104710608, 0.0084306782),
   (f_historical_count_d > 0.5) => -0.0201174458,
   (f_historical_count_d = NULL) => -0.0060921567, -0.0060921567),
(f_attr_arrest_recency_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.15) => -0.0546813251,
   (c_pop_35_44_p > 15.15) => 0.0705046466,
   (c_pop_35_44_p = NULL) => 0.0084205468, 0.0084205468), -0.0051923795);

// Tree: 101 
wFDN_FLAP___lgt_101 := map(
(NULL < r_D31_ALL_Bk_i and r_D31_ALL_Bk_i <= 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 42.35) => 0.0098870012,
   (c_high_ed > 42.35) => -0.0222327520,
   (c_high_ed = NULL) => 0.0244307443, 0.0008724904),
(r_D31_ALL_Bk_i > 1.5) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 25.8) => -0.0513014966,
   (c_high_hval > 25.8) => 
      map(
      (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 425371.5) => 0.1729699752,
      (f_curraddrmedianvalue_d > 425371.5) => -0.0167871910,
      (f_curraddrmedianvalue_d = NULL) => 0.0468016466, 0.0468016466),
   (c_high_hval = NULL) => -0.0354566591, -0.0354566591),
(r_D31_ALL_Bk_i = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 0.85) => -0.0528170302,
   (c_hval_150k_p > 0.85) => 0.0623327557,
   (c_hval_150k_p = NULL) => 0.0081446212, 0.0081446212), -0.0024421717);

// Tree: 102 
wFDN_FLAP___lgt_102 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 9.5) => -0.0044048038,
   (f_phones_per_addr_curr_i > 9.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 9.95) => -0.0212960097,
      (c_hh4_p > 9.95) => 0.0565405013,
      (c_hh4_p = NULL) => 0.0265813286, 0.0265813286),
   (f_phones_per_addr_curr_i = NULL) => -0.0163326523, -0.0018080143),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_health and c_health <= 7.65) => -0.0178280881,
   (c_health > 7.65) => 
      map(
      (NULL < c_old_homes and c_old_homes <= 100.5) => 0.2604517689,
      (c_old_homes > 100.5) => 0.0278735135,
      (c_old_homes = NULL) => 0.1579596563, 0.1579596563),
   (c_health = NULL) => 0.0648131622, 0.0648131622),
(r_P85_Phn_Disconnected_i = NULL) => -0.0004319995, -0.0004319995);

// Tree: 103 
wFDN_FLAP___lgt_103 := map(
(NULL < f_accident_count_i and f_accident_count_i <= 2.5) => 
   map(
   (NULL < c_rnt2001_p and c_rnt2001_p <= 90.05) => 
      map(
      (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 10.5) => -0.0035821010,
      (f_srchfraudsrchcountyr_i > 10.5) => -0.0907859204,
      (f_srchfraudsrchcountyr_i = NULL) => -0.0039603625, -0.0039603625),
   (c_rnt2001_p > 90.05) => 0.1725951434,
   (c_rnt2001_p = NULL) => 0.0512717133, -0.0015953023),
(f_accident_count_i > 2.5) => 
   map(
   (NULL < c_work_home and c_work_home <= 74.5) => 0.2414251387,
   (c_work_home > 74.5) => 0.0198988849,
   (c_work_home = NULL) => 0.0823178846, 0.0823178846),
(f_accident_count_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0456673679,
   (k_nap_lname_verd_d > 0.5) => -0.0598495787,
   (k_nap_lname_verd_d = NULL) => 0.0008226656, 0.0008226656), -0.0003608463);

// Tree: 104 
wFDN_FLAP___lgt_104 := map(
(NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 1.5) => -0.0036940705,
(k_inq_per_phone_i > 1.5) => 
   map(
   (NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 1.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','6: Other']) => 0.0295944983,
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly']) => 
         map(
         (NULL < c_very_rich and c_very_rich <= 88) => 0.0099951112,
         (c_very_rich > 88) => 0.1501849857,
         (c_very_rich = NULL) => 0.0968291379, 0.0968291379),
      (nf_seg_FraudPoint_3_0 = '') => 0.0534067665, 0.0534067665),
   (f_srchfraudsrchcountyr_i > 1.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 136.5) => -0.0394105910,
      (c_exp_prod > 136.5) => 0.0664822302,
      (c_exp_prod = NULL) => -0.0112758875, -0.0112758875),
   (f_srchfraudsrchcountyr_i = NULL) => 0.0283699851, 0.0283699851),
(k_inq_per_phone_i = NULL) => -0.0005142059, -0.0005142059);

// Tree: 105 
wFDN_FLAP___lgt_105 := map(
(NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 83.1) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < c_assault and c_assault <= 148.5) => 0.0132564062,
         (c_assault > 148.5) => 0.0796019768,
         (c_assault = NULL) => 0.0150263566, 0.0260067819),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0826426759,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => 0.0159171937, 0.0159171937),
   (r_C12_source_profile_d > 83.1) => 0.1820430049,
   (r_C12_source_profile_d = NULL) => 0.0203551049, 0.0203551049),
(f_corraddrnamecount_d > 3.5) => -0.0064443959,
(f_corraddrnamecount_d = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 90) => -0.0630520985,
   (c_assault > 90) => 0.0626839153,
   (c_assault = NULL) => -0.0012318917, -0.0012318917), -0.0016425824);

// Tree: 106 
wFDN_FLAP___lgt_106 := map(
(NULL < c_hh3_p and c_hh3_p <= 34.65) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => -0.0051514127,
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_rnt1500_p and c_rnt1500_p <= 1.6) => 
         map(
         (NULL < c_retail and c_retail <= 15.45) => 0.0403574058,
         (c_retail > 15.45) => 0.1906657503,
         (c_retail = NULL) => 0.1023894210, 0.1023894210),
      (c_rnt1500_p > 1.6) => -0.0387235724,
      (c_rnt1500_p = NULL) => 0.0475882585, 0.0475882585),
   (k_nap_contradictory_i = NULL) => -0.0042621296, -0.0042621296),
(c_hh3_p > 34.65) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1859403573,
   (r_Phn_Cell_n > 0.5) => -0.0253667433,
   (r_Phn_Cell_n = NULL) => 0.0790996885, 0.0790996885),
(c_hh3_p = NULL) => -0.0282873727, -0.0036416264);

// Tree: 107 
wFDN_FLAP___lgt_107 := map(
(NULL < f_attr_arrest_recency_d and f_attr_arrest_recency_d <= 79.5) => 0.0961360103,
(f_attr_arrest_recency_d > 79.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 10.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.19658503275) => -0.0280334669,
      (f_add_input_mobility_index_i > 0.19658503275) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.1811005331) => 
            map(
            (NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 158.5) => -0.0427875435,
            (f_M_Bureau_ADL_FS_all_d > 158.5) => 0.1252729809,
            (f_M_Bureau_ADL_FS_all_d = NULL) => 0.0669274404, 0.0669274404),
         (f_add_curr_mobility_index_i > 0.1811005331) => 0.0009285445,
         (f_add_curr_mobility_index_i = NULL) => 0.0396034544, 0.0029915685),
      (f_add_input_mobility_index_i = NULL) => 0.1233608087, -0.0028009299),
   (r_D32_criminal_count_i > 10.5) => 0.0822748953,
   (r_D32_criminal_count_i = NULL) => -0.0022471577, -0.0022471577),
(f_attr_arrest_recency_d = NULL) => -0.0072669503, -0.0016088844);

// Tree: 108 
wFDN_FLAP___lgt_108 := map(
(NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 1.5) => -0.0001858957,
(f_srchcomponentrisktype_i > 1.5) => 
   map(
   (NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 4.75) => 
         map(
         (NULL < c_employees and c_employees <= 42) => 0.1391316238,
         (c_employees > 42) => 
            map(
            (NULL < c_lowrent and c_lowrent <= 0.7) => 0.0602599736,
            (c_lowrent > 0.7) => -0.0684025828,
            (c_lowrent = NULL) => -0.0066970711, -0.0066970711),
         (c_employees = NULL) => 0.0144989602, 0.0144989602),
      (c_hval_125k_p > 4.75) => 0.1220420089,
      (c_hval_125k_p = NULL) => 0.0581476932, 0.0581476932),
   (k_inf_lname_verd_d > 0.5) => -0.0433276887,
   (k_inf_lname_verd_d = NULL) => 0.0284238119, 0.0284238119),
(f_srchcomponentrisktype_i = NULL) => -0.0186781346, 0.0014668903);

// Tree: 109 
wFDN_FLAP___lgt_109 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 27.5) => -0.0847156600,
   (f_mos_inq_banko_cm_lseen_d > 27.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 151.5) => -0.0317528221,
      (c_serv_empl > 151.5) => 0.0762101492,
      (c_serv_empl = NULL) => -0.0023083753, -0.0023083753),
   (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0309019361, -0.0309019361),
(r_D33_Eviction_Recency_d > 549) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 4.95) => 
      map(
      (NULL < c_unattach and c_unattach <= 76.5) => 0.2065863915,
      (c_unattach > 76.5) => 0.0298558758,
      (c_unattach = NULL) => 0.0589233948, 0.0589233948),
   (c_high_ed > 4.95) => 0.0061273785,
   (c_high_ed = NULL) => -0.0195840333, 0.0075755811),
(r_D33_Eviction_Recency_d = NULL) => 0.0129820265, 0.0060893919);

// Tree: 110 
wFDN_FLAP___lgt_110 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 101.5) => -0.0088925922,
(f_prevaddrageoldest_d > 101.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 12.5) => 0.0023580824,
   (r_P88_Phn_Dst_to_Inp_Add_i > 12.5) => 0.0549344580,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 10.65) => 
         map(
         (NULL < f_bus_name_nover_i and f_bus_name_nover_i <= 0.5) => 0.0419009507,
         (f_bus_name_nover_i > 0.5) => 
            map(
            (NULL < c_bargains and c_bargains <= 46.5) => -0.0173363311,
            (c_bargains > 46.5) => 0.2274612602,
            (c_bargains = NULL) => 0.1464755909, 0.1464755909),
         (f_bus_name_nover_i = NULL) => 0.0813015942, 0.0813015942),
      (c_pop_18_24_p > 10.65) => -0.0274527194,
      (c_pop_18_24_p = NULL) => 0.0560043952, 0.0560043952), 0.0169943622),
(f_prevaddrageoldest_d = NULL) => -0.0132650757, 0.0005356364);

// Tree: 111 
wFDN_FLAP___lgt_111 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.75) => 0.1987308938,
   (r_C12_source_profile_d > 57.75) => -0.0188329221,
   (r_C12_source_profile_d = NULL) => 0.0857970046, 0.0857970046),
(f_mos_liens_unrel_SC_fseen_d > 57.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 24.5) => -0.0260363302,
      (f_mos_inq_banko_cm_lseen_d > 24.5) => 0.1374152348,
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0624374527, 0.0624374527),
   (r_D33_Eviction_Recency_d > 30) => 0.0025261844,
   (r_D33_Eviction_Recency_d = NULL) => 0.0030526115, 0.0030526115),
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_no_labfor and c_no_labfor <= 87.5) => -0.0855582791,
   (c_no_labfor > 87.5) => 0.0244059739,
   (c_no_labfor = NULL) => -0.0314352483, -0.0314352483), 0.0035020261);

// Tree: 112 
wFDN_FLAP___lgt_112 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.0072220794) => 0.0899485271,
   (f_add_input_nhood_MFD_pct_i > 0.0072220794) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 820864.5) => 0.0032915439,
      (f_prevaddrmedianvalue_d > 820864.5) => 0.2372642371,
      (f_prevaddrmedianvalue_d = NULL) => 0.0063823973, 0.0063823973),
   (f_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.1869015788) => 0.0278663055,
      (f_add_curr_nhood_MFD_pct_i > 0.1869015788) => 0.1193704888,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0076758177, 0.0066695856), 0.0121172907),
(f_phone_ver_insurance_d > 3.5) => -0.0152273344,
(f_phone_ver_insurance_d = NULL) => 
   map(
   (NULL < c_rental and c_rental <= 129.5) => 0.0875300890,
   (c_rental > 129.5) => -0.0107719753,
   (c_rental = NULL) => 0.0447211255, 0.0447211255), -0.0006454890);

// Tree: 113 
wFDN_FLAP___lgt_113 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 30022.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24466.5) => -0.0084298806,
      (f_prevaddrmedianincome_d > 24466.5) => 
         map(
         (NULL < c_med_age and c_med_age <= 32.95) => 0.0152058813,
         (c_med_age > 32.95) => 0.1120532350,
         (c_med_age = NULL) => 0.0709602214, 0.0709602214),
      (f_prevaddrmedianincome_d = NULL) => 0.0260875551, 0.0260875551),
   (f_curraddrmedianincome_d > 30022.5) => -0.0038294027,
   (f_curraddrmedianincome_d = NULL) => 
      map(
      (NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => 0.0673646199,
      (f_phones_per_addr_c6_i > 0.5) => -0.0447096660,
      (f_phones_per_addr_c6_i = NULL) => 0.0259458620, 0.0259458620), -0.0008356657),
(r_L77_Add_PO_Box_i > 0.5) => -0.1016787820,
(r_L77_Add_PO_Box_i = NULL) => -0.0030616076, -0.0030616076);

// Tree: 114 
wFDN_FLAP___lgt_114 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 30.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 117.5) => -0.0158109026,
   (c_lar_fam > 117.5) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 46.55) => 0.0676940427,
      (c_civ_emp > 46.55) => 0.0053568779,
      (c_civ_emp = NULL) => 0.0083093977, 0.0083093977),
   (c_lar_fam = NULL) => 0.0274218977, -0.0060107700),
(f_rel_under500miles_cnt_d > 30.5) => -0.0628320433,
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 7.5) => -0.0598136404,
   (r_P88_Phn_Dst_to_Inp_Add_i > 7.5) => 0.0046309188,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 110) => 0.1795462452,
      (c_asian_lang > 110) => 0.0069075166,
      (c_asian_lang = NULL) => 0.0688193365, 0.0688193365), 0.0105834165), -0.0066135768);

// Tree: 115 
wFDN_FLAP___lgt_115 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 21.15) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0748538200,
      (r_D33_Eviction_Recency_d > 30) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 64.35) => 0.0013504793,
         (C_RENTOCC_P > 64.35) => -0.0350917753,
         (C_RENTOCC_P = NULL) => -0.0021944518, -0.0021944518),
      (r_D33_Eviction_Recency_d = NULL) => -0.0016479200, -0.0016479200),
   (r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0925430175,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 
      map(
      (NULL < c_asian_lang and c_asian_lang <= 130.5) => -0.0559144691,
      (c_asian_lang > 130.5) => 0.0443417155,
      (c_asian_lang = NULL) => -0.0050381963, -0.0050381963), -0.0020614343),
(c_pop_0_5_p > 21.15) => 0.1575049114,
(c_pop_0_5_p = NULL) => 0.0104886482, -0.0010751755);

// Tree: 116 
wFDN_FLAP___lgt_116 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13468999415) => -0.0067217863,
(f_add_curr_nhood_BUS_pct_i > 0.13468999415) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 33439.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 0.2) => 0.0277549268,
      (c_hval_200k_p > 0.2) => 0.1812264828,
      (c_hval_200k_p = NULL) => 0.0950797132, 0.0950797132),
   (f_curraddrmedianincome_d > 33439.5) => 0.0132439196,
   (f_curraddrmedianincome_d = NULL) => 0.0252653154, 0.0252653154),
(f_add_curr_nhood_BUS_pct_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 128.5) => -0.0445738638,
   (c_asian_lang > 128.5) => 
      map(
      (NULL < c_health and c_health <= 12.4) => 0.1179995198,
      (c_health > 12.4) => -0.0307836857,
      (c_health = NULL) => 0.0634764818, 0.0634764818),
   (c_asian_lang = NULL) => -0.0106118779, 0.0064287021), -0.0022111596);

// Tree: 117 
wFDN_FLAP___lgt_117 := map(
(NULL < c_hh3_p and c_hh3_p <= 24.05) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1524707674,
      (r_Phn_Cell_n > 0.5) => 0.0021306696,
      (r_Phn_Cell_n = NULL) => 0.0573188068, 0.0573188068),
   (r_C21_M_Bureau_ADL_FS_d > 6.5) => -0.0056337256,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => 
      map(
      (NULL < c_hval_125k_p and c_hval_125k_p <= 1.2) => -0.0964136108,
      (c_hval_125k_p > 1.2) => 0.0229661584,
      (c_hval_125k_p = NULL) => -0.0300915168, -0.0300915168), -0.0049769831),
(c_hh3_p > 24.05) => 
   map(
   (NULL < C_INC_100K_P and C_INC_100K_P <= 11.25) => 0.0735026610,
   (C_INC_100K_P > 11.25) => 0.0094214168,
   (C_INC_100K_P = NULL) => 0.0277246963, 0.0277246963),
(c_hh3_p = NULL) => 0.0027505420, -0.0006299417);

// Tree: 118 
wFDN_FLAP___lgt_118 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 195) => -0.0882703785,
(f_mos_liens_unrel_FT_fseen_d > 195) => 
   map(
   (NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 0.5) => -0.0102012401,
   (f_inq_Other_count_i > 0.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 45.4) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 21.55) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 95.5) => 0.0530514106,
            (c_born_usa > 95.5) => -0.0073356632,
            (c_born_usa = NULL) => 0.0265658519, 0.0265658519),
         (c_pop_55_64_p > 21.55) => 0.2590653675,
         (c_pop_55_64_p = NULL) => 0.0323612944, 0.0323612944),
      (c_high_ed > 45.4) => -0.0291886346,
      (c_high_ed = NULL) => 0.0158672347, 0.0158672347),
   (f_inq_Other_count_i = NULL) => -0.0042457421, -0.0042457421),
(f_mos_liens_unrel_FT_fseen_d = NULL) => -0.0089768647, -0.0052571159);

// Tree: 119 
wFDN_FLAP___lgt_119 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 0.0675036459,
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 21.5) => 
      map(
      (NULL < c_trailer_p and c_trailer_p <= 1.85) => -0.0253860820,
      (c_trailer_p > 1.85) => -0.1040122293,
      (c_trailer_p = NULL) => -0.0498279180, -0.0498279180),
   (f_mos_inq_banko_om_fseen_d > 21.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 12.5) => 0.0084212419,
      (f_inq_HighRiskCredit_count_i > 12.5) => -0.0696291046,
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0079321536, 0.0079321536),
   (f_mos_inq_banko_om_fseen_d = NULL) => 0.0041109005, 0.0041109005),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0254181418,
   (r_Phn_Cell_n > 0.5) => -0.0818956137,
   (r_Phn_Cell_n = NULL) => -0.0196946472, -0.0196946472), 0.0049356939);

// Tree: 120 
wFDN_FLAP___lgt_120 := map(
(NULL < c_popover18 and c_popover18 <= 1906.5) => -0.0067097346,
(c_popover18 > 1906.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 124606) => 
      map(
      (NULL < c_hh1_p and c_hh1_p <= 13.85) => 0.2835989694,
      (c_hh1_p > 13.85) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 123.5) => 0.0029299775,
         (c_sub_bus > 123.5) => 0.2265470073,
         (c_sub_bus = NULL) => 0.0526226508, 0.0526226508),
      (c_hh1_p = NULL) => 0.1083524021, 0.1083524021),
   (r_L80_Inp_AVM_AutoVal_d > 124606) => 0.0122774240,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0095164413,
      (f_rel_felony_count_i > 0.5) => 0.0950950368,
      (f_rel_felony_count_i = NULL) => 0.0067592162, 0.0067592162), 0.0240041313),
(c_popover18 = NULL) => -0.0298504517, -0.0013743765);

// Tree: 121 
wFDN_FLAP___lgt_121 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0031365027,
   (k_comb_age_d > 68.5) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 11.55) => 
         map(
         (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.04391073875) => 0.1034229605,
         (f_add_input_nhood_MFD_pct_i > 0.04391073875) => -0.0216769385,
         (f_add_input_nhood_MFD_pct_i = NULL) => 0.0630018550, 0.0234132839),
      (c_pop_0_5_p > 11.55) => 0.1632168544,
      (c_pop_0_5_p = NULL) => 0.0375464317, 0.0375464317),
   (k_comb_age_d = NULL) => -0.0006830470, -0.0006830470),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0778944632,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.32304782865) => 0.0462367356,
   (f_add_input_mobility_index_i > 0.32304782865) => -0.0624502604,
   (f_add_input_mobility_index_i = NULL) => 0.0006583179, 0.0006583179), -0.0002761903);

// Tree: 122 
wFDN_FLAP___lgt_122 := map(
(NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 19.5) => -0.0010490097,
   (f_srchphonesrchcount_i > 19.5) => -0.0769403037,
   (f_srchphonesrchcount_i = NULL) => 
      map(
      (NULL < k_nap_phn_verd_d and k_nap_phn_verd_d <= 0.5) => 0.0362491066,
      (k_nap_phn_verd_d > 0.5) => -0.0937716367,
      (k_nap_phn_verd_d = NULL) => -0.0059869310, -0.0059869310), -0.0015624835),
(r_P85_Phn_Disconnected_i > 0.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 115.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 6.45) => -0.0731172659,
      (c_incollege > 6.45) => 0.1183269246,
      (c_incollege = NULL) => 0.0078783531, 0.0078783531),
   (c_exp_prod > 115.5) => 0.2004918091,
   (c_exp_prod = NULL) => 0.0896964583, 0.0896964583),
(r_P85_Phn_Disconnected_i = NULL) => 0.0001497457, 0.0001497457);

// Tree: 123 
wFDN_FLAP___lgt_123 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 132.5) => -0.0063596654,
   (c_easiqlife > 132.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 9.5) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 25.85) => 0.0077648022,
         (C_INC_75K_P > 25.85) => 0.0727625019,
         (C_INC_75K_P = NULL) => 0.0139347966, 0.0139347966),
      (r_C14_addrs_10yr_i > 9.5) => 0.1402529522,
      (r_C14_addrs_10yr_i = NULL) => 0.0519394649, 0.0158815186),
   (c_easiqlife = NULL) => -0.0137559335, 0.0012540072),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 9.35) => 0.0336812557,
   (c_low_hval > 9.35) => 0.2831127305,
   (c_low_hval = NULL) => 0.1101939780, 0.1101939780),
(f_adls_per_phone_c6_i = NULL) => 0.0026624546, 0.0026624546);

// Tree: 124 
wFDN_FLAP___lgt_124 := map(
(NULL < c_high_ed and c_high_ed <= 42.55) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 435.5) => 
      map(
      (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 685435.5) => 
         map(
         (NULL < f_util_adl_count_n and f_util_adl_count_n <= 13.5) => 0.0033626421,
         (f_util_adl_count_n > 13.5) => 0.1431385786,
         (f_util_adl_count_n = NULL) => 0.0042165365, 0.0042165365),
      (f_prevaddrmedianvalue_d > 685435.5) => 0.1286051395,
      (f_prevaddrmedianvalue_d = NULL) => 0.0055608874, 0.0055608874),
   (r_C13_Curr_Addr_LRes_d > 435.5) => 0.1433417865,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0077348188, 0.0070416275),
(c_high_ed > 42.55) => 
   map(
   (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 50.5) => -0.0543498105,
   (f_prevaddrlenofres_d > 50.5) => 0.0010415486,
   (f_prevaddrlenofres_d = NULL) => -0.0240759936, -0.0240759936),
(c_high_ed = NULL) => -0.0315908232, -0.0026658053);

// Tree: 125 
wFDN_FLAP___lgt_125 := map(
(NULL < f_liens_unrel_SC_total_amt_i and f_liens_unrel_SC_total_amt_i <= 5291.5) => 
   map(
   (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 281.5) => -0.0079026340,
      (f_prevaddrageoldest_d > 281.5) => 0.0391449830,
      (f_prevaddrageoldest_d = NULL) => -0.0040314579, -0.0040314579),
   (f_nae_nothing_found_i > 0.5) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 2.5) => 0.0108232878,
      (f_inq_count_i > 2.5) => 0.2001308962,
      (f_inq_count_i = NULL) => 0.0746117210, 0.0746117210),
   (f_nae_nothing_found_i = NULL) => -0.0028711383, -0.0028711383),
(f_liens_unrel_SC_total_amt_i > 5291.5) => 0.1076265625,
(f_liens_unrel_SC_total_amt_i = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.24828402115) => -0.0790537649,
   (f_add_input_mobility_index_i > 0.24828402115) => 0.0392320951,
   (f_add_input_mobility_index_i = NULL) => -0.0020123166, -0.0020123166), -0.0023380583);

// Tree: 126 
wFDN_FLAP___lgt_126 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 3.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 83500) => -0.0692566751,
      (k_estimated_income_d > 83500) => 0.0645984719,
      (k_estimated_income_d = NULL) => -0.0434389168, -0.0434389168),
   (f_mos_inq_banko_cm_lseen_d > 3.5) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 114.5) => -0.0044471588,
      (c_serv_empl > 114.5) => 0.0188463226,
      (c_serv_empl = NULL) => 0.0034940803, 0.0043780124),
   (f_mos_inq_banko_cm_lseen_d = NULL) => 
      map(
      (NULL < c_totsales and c_totsales <= 12027.5) => -0.0710776996,
      (c_totsales > 12027.5) => 0.0533671467,
      (c_totsales = NULL) => -0.0150214625, -0.0150214625), 0.0029013221),
(r_L72_Add_Vacant_i > 0.5) => 0.1050492013,
(r_L72_Add_Vacant_i = NULL) => 0.0036021237, 0.0036021237);

// Tree: 127 
wFDN_FLAP___lgt_127 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < f_inq_Communications_count_i and f_inq_Communications_count_i <= 1.5) => -0.0028829557,
   (f_inq_Communications_count_i > 1.5) => 
      map(
      (NULL < c_employees and c_employees <= 32.5) => 0.1778926443,
      (c_employees > 32.5) => 
         map(
         (NULL < c_health and c_health <= 25.4) => -0.0131436951,
         (c_health > 25.4) => 0.1239152603,
         (c_health = NULL) => 0.0071760919, 0.0071760919),
      (c_employees = NULL) => 0.0360412094, 0.0360412094),
   (f_inq_Communications_count_i = NULL) => -0.0074915421, -0.0016469218),
(k_inq_adls_per_phone_i > 2.5) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 113.5) => -0.0359629330,
   (c_for_sale > 113.5) => -0.1399606079,
   (c_for_sale = NULL) => -0.0874469305, -0.0874469305),
(k_inq_adls_per_phone_i = NULL) => -0.0023571308, -0.0023571308);

// Tree: 128 
wFDN_FLAP___lgt_128 := map(
(NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 4.5) => 
   map(
   (NULL < c_lux_prod and c_lux_prod <= 134.5) => 
      map(
      (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 1.5) => 0.0241877577,
      (f_assoccredbureaucount_i > 1.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 143446.5) => 0.0206661563,
         (f_curraddrmedianvalue_d > 143446.5) => 0.2167246847,
         (f_curraddrmedianvalue_d = NULL) => 0.1268645258, 0.1268645258),
      (f_assoccredbureaucount_i = NULL) => 0.0465609056, 0.0465609056),
   (c_lux_prod > 134.5) => -0.0197049533,
   (c_lux_prod = NULL) => 0.0444956461, 0.0205519286),
(f_prevaddrlenofres_d > 4.5) => -0.0026158772,
(f_prevaddrlenofres_d = NULL) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 1.15) => 0.0774387376,
   (c_wholesale > 1.15) => -0.0388693968,
   (c_wholesale = NULL) => 0.0247366142, 0.0247366142), 0.0002168540);

// Tree: 129 
wFDN_FLAP___lgt_129 := map(
(NULL < c_bel_edu and c_bel_edu <= 198.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.005) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 21111.5) => 0.1234231727,
         (r_A46_Curr_AVM_AutoVal_d > 21111.5) => -0.0017584379,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0069725513, 0.0026106931),
      (c_pop_18_24_p > 11.15) => -0.0272672954,
      (c_pop_18_24_p = NULL) => -0.0040676270, -0.0040676270),
   (c_hhsize > 4.005) => 
      map(
      (NULL < c_med_age and c_med_age <= 26.65) => 0.2068253878,
      (c_med_age > 26.65) => 0.0022587265,
      (c_med_age = NULL) => 0.0751628026, 0.0751628026),
   (c_hhsize = NULL) => -0.0028613328, -0.0028613328),
(c_bel_edu > 198.5) => -0.1286695195,
(c_bel_edu = NULL) => 0.0120655010, -0.0030527883);

// Tree: 130 
wFDN_FLAP___lgt_130 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 2620) => -0.0095818955,
(f_addrchangeincomediff_d > 2620) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0398019802) => 
      map(
      (NULL < C_INC_201K_P and C_INC_201K_P <= 5.45) => 0.1962493732,
      (C_INC_201K_P > 5.45) => -0.0355158676,
      (C_INC_201K_P = NULL) => 0.0824737095, 0.0824737095),
   (f_add_curr_nhood_MFD_pct_i > 0.0398019802) => 0.0429947006,
   (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0583733370, 0.0349819529),
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => -0.0028122646,
   (f_bus_addr_match_count_d > 6.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => 0.0001089387,
      (f_corrrisktype_i > 6.5) => 0.2103953671,
      (f_corrrisktype_i = NULL) => 0.0934647971, 0.0934647971),
   (f_bus_addr_match_count_d = NULL) => 0.0043158180, 0.0043158180), -0.0043637816);

// Tree: 131 
wFDN_FLAP___lgt_131 := map(
(NULL < c_med_hval and c_med_hval <= 774793.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 12.05) => -0.0956193714,
   (c_white_col > 12.05) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 29947) => 0.0583779268,
      (r_L80_Inp_AVM_AutoVal_d > 29947) => 0.0009634285,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0044573710, -0.0006502965),
   (c_white_col = NULL) => -0.0013018581, -0.0013018581),
(c_med_hval > 774793.5) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 32.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 98) => 0.0488638924,
      (r_C13_Curr_Addr_LRes_d > 98) => 0.2990968464,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.1432914222, 0.1432914222),
   (c_born_usa > 32.5) => 0.0123406978,
   (c_born_usa = NULL) => 0.0599322703, 0.0599322703),
(c_med_hval = NULL) => 0.0007438713, 0.0008833986);

// Tree: 132 
wFDN_FLAP___lgt_132 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 12.5) => 
   map(
   (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 13.5) => 
      map(
      (NULL < f_srchphonesrchcountwk_i and f_srchphonesrchcountwk_i <= 0.5) => -0.0004316945,
      (f_srchphonesrchcountwk_i > 0.5) => 0.0831877930,
      (f_srchphonesrchcountwk_i = NULL) => 0.0004273398, 0.0004273398),
   (f_assocsuspicousidcount_i > 13.5) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 0.95) => 0.1539038672,
      (c_bigapt_p > 0.95) => 0.0240996673,
      (c_bigapt_p = NULL) => 0.0820479709, 0.0820479709),
   (f_assocsuspicousidcount_i = NULL) => 0.0012116465, 0.0012116465),
(f_srchphonesrchcount_i > 12.5) => 
   map(
   (NULL < c_no_car and c_no_car <= 77.5) => 0.0252699686,
   (c_no_car > 77.5) => -0.1375453878,
   (c_no_car = NULL) => -0.0600677354, -0.0600677354),
(f_srchphonesrchcount_i = NULL) => 0.0009886336, 0.0004988036);

// Tree: 133 
wFDN_FLAP___lgt_133 := map(
(NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 124.5) => 
   map(
   (NULL < c_rape and c_rape <= 66) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.28762863355) => 0.2146941157,
      (f_add_curr_mobility_index_i > 0.28762863355) => 0.0400221518,
      (f_add_curr_mobility_index_i = NULL) => 0.1404241468, 0.1404241468),
   (c_rape > 66) => 
      map(
      (NULL < f_varrisktype_i and f_varrisktype_i <= 1.5) => -0.0411082884,
      (f_varrisktype_i > 1.5) => 0.0807748817,
      (f_varrisktype_i = NULL) => -0.0037471156, -0.0037471156),
   (c_rape = NULL) => 0.0526868953, 0.0526868953),
(f_mos_liens_unrel_SC_fseen_d > 124.5) => 0.0007192002,
(f_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.75) => 0.0613914115,
   (c_hh3_p > 13.75) => -0.0451433051,
   (c_hh3_p = NULL) => -0.0026958789, -0.0026958789), 0.0020239664);

// Tree: 134 
wFDN_FLAP___lgt_134 := map(
(NULL < f_rel_count_i and f_rel_count_i <= 35.5) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 17.65) => 0.0059954358,
   (c_manufacturing > 17.65) => -0.0462215812,
   (c_manufacturing = NULL) => 0.0236267688, 0.0028940185),
(f_rel_count_i > 35.5) => 
   map(
   (NULL < c_health and c_health <= 0.45) => -0.1334841777,
   (c_health > 0.45) => 
      map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i <= 0.5) => 0.0899191796,
      (r_C20_email_count_i > 0.5) => -0.0497330244,
      (r_C20_email_count_i = NULL) => -0.0124121768, -0.0124121768),
   (c_health = NULL) => -0.0467906462, -0.0467906462),
(f_rel_count_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0441587454,
   (k_nap_lname_verd_d > 0.5) => -0.0663755831,
   (k_nap_lname_verd_d = NULL) => -0.0085798558, -0.0085798558), 0.0014669978);

// Tree: 135 
wFDN_FLAP___lgt_135 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 19.85) => -0.0053740706,
(c_hval_150k_p > 19.85) => 
   map(
   (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 9363) => -0.0190591591,
      (r_A49_Curr_AVM_Chg_1yr_i > 9363) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 127.5) => 0.0341608719,
         (c_easiqlife > 127.5) => 0.3154789335,
         (c_easiqlife = NULL) => 0.1273246456, 0.1273246456),
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0065842882, 0.0163272602),
   (k_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 17.35) => 0.0571153588,
      (c_hh4_p > 17.35) => 0.2705956640,
      (c_hh4_p = NULL) => 0.1278133820, 0.1278133820),
   (k_inq_ssns_per_addr_i = NULL) => 0.0308035357, 0.0308035357),
(c_hval_150k_p = NULL) => 0.0074494353, -0.0016984334);

// Tree: 136 
wFDN_FLAP___lgt_136 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 22687) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.05909051235) => 0.1743361860,
      (f_add_input_nhood_BUS_pct_i > 0.05909051235) => 0.0166256976,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0733837133, 0.1010561973),
   (f_curraddrmedianincome_d > 22687) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 72) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 134.5) => 0.1349018086,
         (c_relig_indx > 134.5) => -0.0084416518,
         (c_relig_indx = NULL) => 0.0769793491, 0.0769793491),
      (r_D32_Mos_Since_Crim_LS_d > 72) => 0.0064097116,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0137038842, 0.0137038842),
   (f_curraddrmedianincome_d = NULL) => 0.0199092398, 0.0199092398),
(f_hh_members_ct_d > 1.5) => -0.0080879571,
(f_hh_members_ct_d = NULL) => -0.0098490693, -0.0024534709);

// Tree: 137 
wFDN_FLAP___lgt_137 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 190159.5) => -0.0047166043,
(f_addrchangevaluediff_d > 190159.5) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 29.85) => 0.1928005660,
   (c_hh2_p > 29.85) => -0.0295843756,
   (c_hh2_p = NULL) => 0.0675922375, 0.0675922375),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 21.5) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
         map(
         (NULL < c_construction and c_construction <= 19.55) => -0.0174150586,
         (c_construction > 19.55) => 0.0492996814,
         (c_construction = NULL) => 0.0029427419, -0.0060509509),
      (k_nap_contradictory_i > 0.5) => 0.0912673787,
      (k_nap_contradictory_i = NULL) => -0.0031719085, -0.0031719085),
   (f_bus_addr_match_count_d > 21.5) => 0.1687444943,
   (f_bus_addr_match_count_d = NULL) => 0.0003614138, 0.0003614138), -0.0028501234);

// Tree: 138 
wFDN_FLAP___lgt_138 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 3.55) => -0.0864308101,
(c_pop_35_44_p > 3.55) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 192) => 0.0004633637,
   (f_curraddrcrimeindex_i > 192) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0635819257) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.02872283395) => 0.0374993857,
         (f_add_input_nhood_BUS_pct_i > 0.02872283395) => 0.1998825267,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.1150336783, 0.1150336783),
      (f_add_input_nhood_BUS_pct_i > 0.0635819257) => -0.0166372034,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0564401359, 0.0564401359),
   (f_curraddrcrimeindex_i = NULL) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 63.05) => 0.0553305798,
      (c_civ_emp > 63.05) => -0.0513953730,
      (c_civ_emp = NULL) => 0.0070718881, 0.0070718881), 0.0014578310),
(c_pop_35_44_p = NULL) => -0.0306588250, -0.0003589908);

// Tree: 139 
wFDN_FLAP___lgt_139 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 6.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02591901475) => -0.0340285075,
   (f_add_curr_nhood_BUS_pct_i > 0.02591901475) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.5022253036) => 0.0207433785,
      (f_add_input_nhood_MFD_pct_i > 0.5022253036) => 0.0927562860,
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0529596792, 0.0529596792),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0236484424, 0.0236484424),
(r_C21_M_Bureau_ADL_FS_d > 6.5) => 
   map(
   (NULL < c_lar_fam and c_lar_fam <= 181.5) => -0.0022626180,
   (c_lar_fam > 181.5) => 0.0801336566,
   (c_lar_fam = NULL) => -0.0369762412, -0.0021730205),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 16.5) => -0.0613422761,
   (c_pop_35_44_p > 16.5) => 0.0514577528,
   (c_pop_35_44_p = NULL) => -0.0190422653, -0.0190422653), -0.0019815026);

// Tree: 140 
wFDN_FLAP___lgt_140 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 41.45) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
      map(
      (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 7.5) => 
         map(
         (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 1.5) => 0.0015534854,
         (f_srchaddrsrchcountmo_i > 1.5) => 0.0616623995,
         (f_srchaddrsrchcountmo_i = NULL) => 0.0023499949, 0.0023499949),
      (f_inq_HighRiskCredit_count_i > 7.5) => 
         map(
         (NULL < c_no_labfor and c_no_labfor <= 72) => -0.1162388978,
         (c_no_labfor > 72) => 0.0026358400,
         (c_no_labfor = NULL) => -0.0568015289, -0.0568015289),
      (f_inq_HighRiskCredit_count_i = NULL) => 0.0018514034, 0.0018514034),
   (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0639131811,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0066433576, 0.0021398825),
(c_hval_80k_p > 41.45) => -0.0975153448,
(c_hval_80k_p = NULL) => -0.0183891420, 0.0008523689);

// Tree: 141 
wFDN_FLAP___lgt_141 := map(
(NULL < c_cpiall and c_cpiall <= 208.9) => 
   map(
   (NULL < c_unemp and c_unemp <= 11.25) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 194.5) => -0.0021490147,
         (c_new_homes > 194.5) => 
            map(
            (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 73323.5) => 0.3026545871,
            (f_curraddrmedianincome_d > 73323.5) => 0.0221318716,
            (f_curraddrmedianincome_d = NULL) => 0.1325738856, 0.1325738856),
         (c_new_homes = NULL) => 0.0081271465, 0.0081271465),
      (k_inq_ssns_per_addr_i > 2.5) => 0.1113273860,
      (k_inq_ssns_per_addr_i = NULL) => 0.0131958047, 0.0131958047),
   (c_unemp > 11.25) => 0.1223674604,
   (c_unemp = NULL) => 0.0163444049, 0.0163444049),
(c_cpiall > 208.9) => -0.0065109228,
(c_cpiall = NULL) => -0.0251956501, -0.0037057156);

// Tree: 142 
wFDN_FLAP___lgt_142 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -56.5) => 
   map(
   (NULL < c_cartheft and c_cartheft <= 77.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 123.5) => -0.0636831315,
      (c_rich_wht > 123.5) => 0.0926739709,
      (c_rich_wht = NULL) => 0.0024275896, 0.0024275896),
   (c_cartheft > 77.5) => 0.1617270967,
   (c_cartheft = NULL) => 0.0453759861, 0.0453759861),
(f_addrchangecrimediff_i > -56.5) => -0.0041741752,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 6.5) => -0.0019008550,
   (f_bus_addr_match_count_d > 6.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 35.5) => 0.1894900049,
      (c_born_usa > 35.5) => 0.0302641999,
      (c_born_usa = NULL) => 0.0697304251, 0.0697304251),
   (f_bus_addr_match_count_d = NULL) => 0.0039839378, 0.0039839378), -0.0015141605);

// Tree: 143 
wFDN_FLAP___lgt_143 := map(
(NULL < c_unempl and c_unempl <= 60.5) => -0.0227129291,
(c_unempl > 60.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 5.65) => -0.0682194133,
   (c_pop_35_44_p > 5.65) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 3.5) => 
         map(
         (NULL < r_F03_address_match_d and r_F03_address_match_d <= 2.5) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 92.9) => -0.0371772835,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i > 92.9) => 0.0741568775,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0316371836, 0.0385466437),
         (r_F03_address_match_d > 2.5) => 0.0074075118,
         (r_F03_address_match_d = NULL) => 0.0152090795, 0.0152090795),
      (r_C14_addrs_10yr_i > 3.5) => -0.0135817057,
      (r_C14_addrs_10yr_i = NULL) => 0.0213027638, 0.0089250108),
   (c_pop_35_44_p = NULL) => 0.0063159440, 0.0063159440),
(c_unempl = NULL) => 0.0110867181, -0.0005093084);

// Tree: 144 
wFDN_FLAP___lgt_144 := map(
(NULL < c_rnt2001_p and c_rnt2001_p <= 49) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1374593187,
   (f_mos_liens_unrel_FT_lseen_d > 39.5) => -0.0042092776,
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 70.95) => 0.0435250834,
      (c_fammar_p > 70.95) => -0.0594724668,
      (c_fammar_p = NULL) => -0.0187525051, -0.0187525051), -0.0037555390),
(c_rnt2001_p > 49) => 
   map(
   (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0235642929,
   (k_inf_nothing_found_i > 0.5) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 9.45) => 0.0162069876,
      (c_pop_12_17_p > 9.45) => 0.4146855410,
      (c_pop_12_17_p = NULL) => 0.1879649848, 0.1879649848),
   (k_inf_nothing_found_i = NULL) => 0.0865031716, 0.0865031716),
(c_rnt2001_p = NULL) => 0.0086173981, -0.0013254889);

// Tree: 145 
wFDN_FLAP___lgt_145 := map(
(NULL < c_med_hhinc and c_med_hhinc <= 21102.5) => -0.0716951169,
(c_med_hhinc > 21102.5) => 
   map(
   (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 3.5) => 
      map(
      (NULL < c_low_hval and c_low_hval <= 74.55) => 0.0018351696,
      (c_low_hval > 74.55) => -0.1246908194,
      (c_low_hval = NULL) => 0.0012006360, 0.0012006360),
   (f_hh_lienholders_i > 3.5) => 
      map(
      (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 3.5) => 0.1414558440,
      (f_rel_incomeover75_count_d > 3.5) => -0.0306968383,
      (f_rel_incomeover75_count_d = NULL) => 0.0640538628, 0.0640538628),
   (f_hh_lienholders_i = NULL) => 
      map(
      (NULL < c_civ_emp and c_civ_emp <= 62.65) => 0.0562512158,
      (c_civ_emp > 62.65) => -0.0644335200,
      (c_civ_emp = NULL) => -0.0026878412, -0.0026878412), 0.0018229935),
(c_med_hhinc = NULL) => 0.0114215732, 0.0009414960);

// Tree: 146 
wFDN_FLAP___lgt_146 := map(
(NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 189) => 
   map(
   (NULL < r_L71_Add_HiRisk_Comm_i and r_L71_Add_HiRisk_Comm_i <= 0.5) => -0.0050073211,
   (r_L71_Add_HiRisk_Comm_i > 0.5) => 0.1043961847,
   (r_L71_Add_HiRisk_Comm_i = NULL) => -0.0042361792, -0.0042361792),
(f_curraddrcrimeindex_i > 189) => 
   map(
   (NULL < c_housingcpi and c_housingcpi <= 208.95) => 0.1942559925,
   (c_housingcpi > 208.95) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 13.25) => -0.0222314034,
      (c_pop_55_64_p > 13.25) => 0.1827512370,
      (c_pop_55_64_p = NULL) => 0.0395648338, 0.0395648338),
   (c_housingcpi = NULL) => 0.0635852000, 0.0635852000),
(f_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < c_high_hval and c_high_hval <= 3.7) => -0.0389777797,
   (c_high_hval > 3.7) => 0.0617397268,
   (c_high_hval = NULL) => 0.0095158345, 0.0095158345), -0.0023346909);

// Tree: 147 
wFDN_FLAP___lgt_147 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => 
   map(
   (NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 0.0036531514,
   (k_inq_adls_per_phone_i > 2.5) => -0.0861717588,
   (k_inq_adls_per_phone_i = NULL) => 0.0029554385, 0.0029554385),
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 72.5) => -0.1279423053,
   (c_easiqlife > 72.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 17.15) => -0.0386841248,
      (c_pop_45_54_p > 17.15) => 0.0713186031,
      (c_pop_45_54_p = NULL) => -0.0146878494, -0.0146878494),
   (c_easiqlife = NULL) => -0.0311954177, -0.0311954177),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 38.45) => 0.0759896572,
   (c_low_ed > 38.45) => -0.0289824212,
   (c_low_ed = NULL) => 0.0182550141, 0.0182550141), 0.0016779029);

// Tree: 148 
wFDN_FLAP___lgt_148 := map(
(NULL < f_mos_inq_banko_am_fseen_d and f_mos_inq_banko_am_fseen_d <= 61.5) => -0.0660067775,
(f_mos_inq_banko_am_fseen_d > 61.5) => 
   map(
   (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 2.5) => -0.0009620781,
   (k_inq_per_phone_i > 2.5) => 
      map(
      (NULL < C_INC_150K_P and C_INC_150K_P <= 1.15) => -0.0735733939,
      (C_INC_150K_P > 1.15) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 131.5) => 
            map(
            (NULL < c_pop_75_84_p and c_pop_75_84_p <= 5.15) => 0.0534193555,
            (c_pop_75_84_p > 5.15) => 0.1715697085,
            (c_pop_75_84_p = NULL) => 0.0708826872, 0.0708826872),
         (c_mort_indx > 131.5) => -0.0458127526,
         (c_mort_indx = NULL) => 0.0479333057, 0.0479333057),
      (C_INC_150K_P = NULL) => 0.0329178436, 0.0329178436),
   (k_inq_per_phone_i = NULL) => 0.0007935487, 0.0007935487),
(f_mos_inq_banko_am_fseen_d = NULL) => -0.0135301974, -0.0022733070);

// Tree: 149 
wFDN_FLAP___lgt_149 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => 0.0060288423,
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 4.95) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 73.35) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 82) => -0.0362959231,
         (c_born_usa > 82) => 0.0540678568,
         (c_born_usa = NULL) => -0.0019624553, -0.0019624553),
      (c_low_ed > 73.35) => -0.1097045209,
      (c_low_ed = NULL) => -0.0145198056, -0.0145198056),
   (c_wholesale > 4.95) => -0.1121267952,
   (c_wholesale = NULL) => -0.0319095566, -0.0319095566),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 150.5) => 0.0524636088,
   (c_asian_lang > 150.5) => -0.0714280299,
   (c_asian_lang = NULL) => 0.0050932763, 0.0050932763), 0.0044289227);

// Tree: 150 
wFDN_FLAP___lgt_150 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -282387.5) => -0.0941020111,
(f_addrchangevaluediff_d > -282387.5) => 
   map(
   (NULL < r_C14_Addrs_Per_ADL_c6_i and r_C14_Addrs_Per_ADL_c6_i <= 1.5) => -0.0007741935,
   (r_C14_Addrs_Per_ADL_c6_i > 1.5) => 
      map(
      (NULL < c_unempl and c_unempl <= 97.5) => -0.0465125454,
      (c_unempl > 97.5) => 0.1762671443,
      (c_unempl = NULL) => 0.0770459380, 0.0770459380),
   (r_C14_Addrs_Per_ADL_c6_i = NULL) => 0.0001762936, 0.0001762936),
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 4.5) => -0.0142330155,
   (f_crim_rel_under25miles_cnt_i > 4.5) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 9.6) => -0.0581670437,
      (c_rnt1000_p > 9.6) => 0.1495037449,
      (c_rnt1000_p = NULL) => 0.0629742497, 0.0629742497),
   (f_crim_rel_under25miles_cnt_i = NULL) => 0.0097796157, -0.0088488683), -0.0023134156);

// Tree: 151 
wFDN_FLAP___lgt_151 := map(
(NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => -0.0115761055,
(k_inf_nothing_found_i > 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0043163039,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 3.17) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 12.15) => 0.1975929659,
         (C_RENTOCC_P > 12.15) => 
            map(
            (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 50.5) => -0.0466591045,
            (r_C13_max_lres_d > 50.5) => 0.0743610817,
            (r_C13_max_lres_d = NULL) => 0.0425544943, 0.0425544943),
         (C_RENTOCC_P = NULL) => 0.0799265364, 0.0799265364),
      (c_hhsize > 3.17) => -0.0576039295,
      (c_hhsize = NULL) => 0.0565055066, 0.0565055066),
   (k_inq_per_addr_i = NULL) => 0.0093752078, 0.0093752078),
(k_inf_nothing_found_i = NULL) => -0.0029032363, -0.0029032363);

// Tree: 152 
wFDN_FLAP___lgt_152 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.30747629165) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 190.5) => 0.0086731882,
      (f_prevaddrmurderindex_i > 190.5) => 0.1020962225,
      (f_prevaddrmurderindex_i = NULL) => 0.0099752127, 0.0099752127),
   (f_add_input_mobility_index_i > 0.30747629165) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 179.5) => -0.0070271712,
      (c_serv_empl > 179.5) => -0.0601929983,
      (c_serv_empl = NULL) => 0.0555557271, -0.0129913414),
   (f_add_input_mobility_index_i = NULL) => 0.0916022279, 0.0031165874),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0820015797,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 82.5) => 0.0722758999,
   (c_no_car > 82.5) => -0.0423388048,
   (c_no_car = NULL) => 0.0057818727, 0.0057818727), 0.0027868072);

// Tree: 153 
wFDN_FLAP___lgt_153 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00501882845) => 
   map(
   (NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 0.1910096973,
   (f_hh_members_ct_d > 1.5) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 7.65) => -0.0008374952,
      (c_pop_75_84_p > 7.65) => 0.2244181456,
      (c_pop_75_84_p = NULL) => 0.0212825350, 0.0212825350),
   (f_hh_members_ct_d = NULL) => 0.0440245384, 0.0440245384),
(f_add_input_nhood_MFD_pct_i > 0.00501882845) => 
   map(
   (NULL < f_hh_criminals_i and f_hh_criminals_i <= 0.5) => -0.0103647498,
   (f_hh_criminals_i > 0.5) => 
      map(
      (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.15231900665) => 0.0080749212,
      (f_add_curr_nhood_BUS_pct_i > 0.15231900665) => 0.0703738491,
      (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0489166755, 0.0162506458),
   (f_hh_criminals_i = NULL) => -0.0326127918, -0.0024573887),
(f_add_input_nhood_MFD_pct_i = NULL) => -0.0091249286, -0.0011483195);

// Tree: 154 
wFDN_FLAP___lgt_154 := map(
(NULL < f_rel_under500miles_cnt_d and f_rel_under500miles_cnt_d <= 31.5) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => -0.0023937901,
   (f_util_adl_count_n > 6.5) => 0.0401480608,
   (f_util_adl_count_n = NULL) => 0.0005717069, 0.0005717069),
(f_rel_under500miles_cnt_d > 31.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 11.45) => -0.0210551198,
   (C_INC_25K_P > 11.45) => -0.1249048069,
   (C_INC_25K_P = NULL) => -0.0528458403, -0.0528458403),
(f_rel_under500miles_cnt_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 229750) => 0.0781188880,
   (r_L80_Inp_AVM_AutoVal_d > 229750) => -0.0778847180,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_employees and c_employees <= 198.5) => 0.0503226605,
      (c_employees > 198.5) => -0.0751026470,
      (c_employees = NULL) => -0.0199155117, -0.0199155117), -0.0080313162), -0.0005423272);

// Tree: 155 
wFDN_FLAP___lgt_155 := map(
(NULL < c_unempl and c_unempl <= 190.5) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 15.5) => -0.0021919196,
   (f_srchphonesrchcount_i > 15.5) => 
      map(
      (NULL < C_INC_15K_P and C_INC_15K_P <= 8.2) => 0.0028528671,
      (C_INC_15K_P > 8.2) => -0.1238420271,
      (C_INC_15K_P = NULL) => -0.0575887338, -0.0575887338),
   (f_srchphonesrchcount_i = NULL) => 
      map(
      (NULL < c_burglary and c_burglary <= 98.5) => -0.0363700556,
      (c_burglary > 98.5) => 0.0861234610,
      (c_burglary = NULL) => 0.0159860442, 0.0159860442), -0.0025000780),
(c_unempl > 190.5) => 
   map(
   (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 131) => -0.0138434836,
   (f_curraddrburglaryindex_i > 131) => 0.1555364801,
   (f_curraddrburglaryindex_i = NULL) => 0.0651048046, 0.0651048046),
(c_unempl = NULL) => 0.0159815488, -0.0014453007);

// Tree: 156 
wFDN_FLAP___lgt_156 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 1.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 35.7) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0108976363,
      (r_C14_Addr_Stability_v2_d > 5.5) => 
         map(
         (NULL < f_corrrisktype_i and f_corrrisktype_i <= 8.5) => 0.0090104835,
         (f_corrrisktype_i > 8.5) => 0.0519520179,
         (f_corrrisktype_i = NULL) => 0.0118842632, 0.0118842632),
      (r_C14_Addr_Stability_v2_d = NULL) => -0.0010328784, -0.0010328784),
   (c_hval_20k_p > 35.7) => 0.1055876354,
   (c_hval_20k_p = NULL) => -0.0079010839, -0.0006770988),
(f_vf_AltLexID_addr_hi_risk_ct_i > 1.5) => 
   map(
   (NULL < c_hh7p_p and c_hh7p_p <= 1.65) => -0.0934705014,
   (c_hh7p_p > 1.65) => 0.0093263049,
   (c_hh7p_p = NULL) => -0.0543862990, -0.0543862990),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 0.0037569700, -0.0014513586);

// Tree: 157 
wFDN_FLAP___lgt_157 := map(
(NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 809865.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 8.5) => 
      map(
      (NULL < c_hval_80k_p and c_hval_80k_p <= 39.6) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 20986.5) => 0.0709510419,
         (r_A46_Curr_AVM_AutoVal_d > 20986.5) => 0.0016073958,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0046914388, -0.0005250010),
      (c_hval_80k_p > 39.6) => -0.0924026050,
      (c_hval_80k_p = NULL) => 0.0067263099, -0.0013952096),
   (f_inq_HighRiskCredit_count24_i > 8.5) => 0.0661919690,
   (f_inq_HighRiskCredit_count24_i = NULL) => -0.0009889508, -0.0009889508),
(f_prevaddrmedianvalue_d > 809865.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 72262.5) => 0.2445510176,
   (r_A49_Curr_AVM_Chg_1yr_i > 72262.5) => 0.0832305949,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0440997363, 0.1094228099),
(f_prevaddrmedianvalue_d = NULL) => -0.0007889591, 0.0008501883);

// Tree: 158 
wFDN_FLAP___lgt_158 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
      map(
      (NULL < f_srchunvrfddobcount_i and f_srchunvrfddobcount_i <= 0.5) => -0.0026052702,
      (f_srchunvrfddobcount_i > 0.5) => 
         map(
         (NULL < c_oldhouse and c_oldhouse <= 24.05) => 0.2286987195,
         (c_oldhouse > 24.05) => 0.0244246000,
         (c_oldhouse = NULL) => 0.0521040200, 0.0521040200),
      (f_srchunvrfddobcount_i = NULL) => -0.0009083760, -0.0009083760),
   (r_I60_inq_comm_count12_i > 1.5) => 
      map(
      (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 204) => -0.1722846998,
      (r_A50_pb_total_dollars_d > 204) => -0.0036908397,
      (r_A50_pb_total_dollars_d = NULL) => -0.0613974630, -0.0613974630),
   (r_I60_inq_comm_count12_i = NULL) => -0.0016314305, -0.0016314305),
(r_D33_eviction_count_i > 3.5) => 0.0680531908,
(r_D33_eviction_count_i = NULL) => 0.0029479175, -0.0011568098);

// Tree: 159 
wFDN_FLAP___lgt_159 := map(
(NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 19.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 22.5) => 
      map(
      (NULL < c_popover18 and c_popover18 <= 2091.5) => -0.0046197582,
      (c_popover18 > 2091.5) => 0.0315489990,
      (c_popover18 = NULL) => 0.0088395069, 0.0006862089),
   (k_inq_per_addr_i > 22.5) => 0.1050314147,
   (k_inq_per_addr_i = NULL) => 0.0011215852, 0.0011215852),
(f_rel_homeover500_count_d > 19.5) => 0.1165828127,
(f_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < c_easiqlife and c_easiqlife <= 110.5) => -0.0431055456,
   (c_easiqlife > 110.5) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1077154997,
      (r_Phn_Cell_n > 0.5) => -0.0065683782,
      (r_Phn_Cell_n = NULL) => 0.0457616080, 0.0457616080),
   (c_easiqlife = NULL) => 0.0043235532, 0.0043235532), 0.0018665373);

// Tree: 160 
wFDN_FLAP___lgt_160 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.65) => -0.0061703528,
(r_C12_source_profile_d > 75.65) => 
   map(
   (NULL < f_srchaddrsrchcountmo_i and f_srchaddrsrchcountmo_i <= 0.5) => 
      map(
      (NULL < c_high_ed and c_high_ed <= 5.25) => 0.1377041367,
      (c_high_ed > 5.25) => 
         map(
         (NULL < c_rnt1000_p and c_rnt1000_p <= 27.3) => -0.0093172825,
         (c_rnt1000_p > 27.3) => 0.0806181979,
         (c_rnt1000_p = NULL) => 0.0144876880, 0.0144876880),
      (c_high_ed = NULL) => 0.0191961744, 0.0191961744),
   (f_srchaddrsrchcountmo_i > 0.5) => 0.1209734946,
   (f_srchaddrsrchcountmo_i = NULL) => 0.0243205559, 0.0243205559),
(r_C12_source_profile_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 128) => -0.0387407397,
   (c_no_car > 128) => 0.0613411774,
   (c_no_car = NULL) => -0.0004114948, -0.0004114948), -0.0012740804);

// Tree: 161 
wFDN_FLAP___lgt_161 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 25.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 1.5) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 29.15) => 
         map(
         (NULL < c_larceny and c_larceny <= 167) => -0.0299309328,
         (c_larceny > 167) => 0.1571337698,
         (c_larceny = NULL) => -0.0091005838, -0.0091005838),
      (c_famotf18_p > 29.15) => -0.0983919021,
      (c_famotf18_p = NULL) => -0.0233544273, -0.0233544273),
   (f_inq_HighRiskCredit_count_i > 1.5) => -0.1147326569,
   (f_inq_HighRiskCredit_count_i = NULL) => -0.0338593261, -0.0338593261),
(f_mos_inq_banko_cm_fseen_d > 25.5) => -0.0014407180,
(f_mos_inq_banko_cm_fseen_d = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 14.95) => 0.0419839438,
   (c_hh3_p > 14.95) => -0.0585263389,
   (c_hh3_p = NULL) => -0.0091229796, -0.0091229796), -0.0031519854);

// Tree: 162 
wFDN_FLAP___lgt_162 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 
   map(
   (NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0050333550,
   (f_hh_payday_loan_users_i > 0.5) => 0.0292057435,
   (f_hh_payday_loan_users_i = NULL) => -0.0019679130, -0.0019679130),
(f_phones_per_addr_curr_i > 50.5) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 21.85) => 
      map(
      (NULL < c_pop_18_24_p and c_pop_18_24_p <= 8.45) => 0.1186348519,
      (c_pop_18_24_p > 8.45) => -0.0575906850,
      (c_pop_18_24_p = NULL) => 0.0137066696, 0.0137066696),
   (C_INC_75K_P > 21.85) => 0.2453628977,
   (C_INC_75K_P = NULL) => 0.0804337353, 0.0804337353),
(f_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_hval_250k_p and c_hval_250k_p <= 8.1) => -0.0308141688,
   (c_hval_250k_p > 8.1) => 0.0600966989,
   (c_hval_250k_p = NULL) => 0.0111929218, 0.0111929218), -0.0005853567);

// Tree: 163 
wFDN_FLAP___lgt_163 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => -0.0035442105,
(k_comb_age_d > 68.5) => 
   map(
   (NULL < C_INC_200K_P and C_INC_200K_P <= 3.65) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.03622665655) => 
         map(
         (NULL < r_A50_pb_total_orders_d and r_A50_pb_total_orders_d <= 3.5) => 0.2995529634,
         (r_A50_pb_total_orders_d > 3.5) => 0.0459252097,
         (r_A50_pb_total_orders_d = NULL) => 0.1972837079, 0.1972837079),
      (f_add_input_nhood_VAC_pct_i > 0.03622665655) => 0.0133843651,
      (f_add_input_nhood_VAC_pct_i = NULL) => 0.0966088852, 0.0966088852),
   (C_INC_200K_P > 3.65) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 5.15) => 0.0857879813,
      (c_newhouse > 5.15) => -0.0608279479,
      (c_newhouse = NULL) => -0.0096043910, -0.0096043910),
   (C_INC_200K_P = NULL) => 0.0290956591, 0.0290956591),
(k_comb_age_d = NULL) => -0.0090237378, -0.0016196178);

// Tree: 164 
wFDN_FLAP___lgt_164 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 0.0006313154,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 163.5) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 7.15) => 0.0002065140,
      (c_rnt2001_p > 7.15) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 55) => 0.0111796798,
         (c_many_cars > 55) => 0.2579027412,
         (c_many_cars = NULL) => 0.1345412105, 0.1345412105),
      (c_rnt2001_p = NULL) => 0.0174664871, 0.0174664871),
   (c_totcrime > 163.5) => 
      map(
      (NULL < c_hval_200k_p and c_hval_200k_p <= 2.9) => 0.0338207136,
      (c_hval_200k_p > 2.9) => 0.2878829124,
      (c_hval_200k_p = NULL) => 0.1272500383, 0.1272500383),
   (c_totcrime = NULL) => 0.0518258065, 0.0363177222),
(r_L70_Add_Standardized_i = NULL) => 0.0036527739, 0.0036527739);

// Tree: 165 
wFDN_FLAP___lgt_165 := map(
(NULL < k_inf_lname_verd_d and k_inf_lname_verd_d <= 0.5) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 25.05) => 
      map(
      (NULL < c_retail and c_retail <= 44.6) => 0.0071547979,
      (c_retail > 44.6) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 124.5) => 0.1962672616,
         (c_span_lang > 124.5) => -0.0092121125,
         (c_span_lang = NULL) => 0.1006130702, 0.1006130702),
      (c_retail = NULL) => 0.0091454625, 0.0091454625),
   (c_pop_55_64_p > 25.05) => 0.1505812932,
   (c_pop_55_64_p = NULL) => -0.0012764750, 0.0101054414),
(k_inf_lname_verd_d > 0.5) => 
   map(
   (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 76) => 0.0024541725,
   (f_curraddrcrimeindex_i > 76) => -0.0486860234,
   (f_curraddrcrimeindex_i = NULL) => -0.0206117008, -0.0206117008),
(k_inf_lname_verd_d = NULL) => -0.0000432021, -0.0000432021);

// Tree: 166 
wFDN_FLAP___lgt_166 := map(
(NULL < c_asian_lang and c_asian_lang <= 194.5) => 
   map(
   (NULL < c_info and c_info <= 23.35) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 13.85) => 
         map(
         (NULL < C_INC_75K_P and C_INC_75K_P <= 30.15) => -0.0154916623,
         (C_INC_75K_P > 30.15) => 
            map(
            (NULL < f_hh_lienholders_i and f_hh_lienholders_i <= 0.5) => 0.0166737576,
            (f_hh_lienholders_i > 0.5) => 0.1553114019,
            (f_hh_lienholders_i = NULL) => 0.0663210221, 0.0663210221),
         (C_INC_75K_P = NULL) => -0.0130736323, -0.0130736323),
      (c_pop_35_44_p > 13.85) => 0.0125850875,
      (c_pop_35_44_p = NULL) => 0.0014578148, 0.0014578148),
   (c_info > 23.35) => 0.1320985256,
   (c_info = NULL) => 0.0023827048, 0.0023827048),
(c_asian_lang > 194.5) => -0.0503263929,
(c_asian_lang = NULL) => 0.0084703102, 0.0002361729);

// Tree: 167 
wFDN_FLAP___lgt_167 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 194) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 57.25) => 
         map(
         (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 2.5) => 
            map(
            (NULL < C_OWNOCC_P and C_OWNOCC_P <= 53.25) => 0.0101317840,
            (C_OWNOCC_P > 53.25) => 0.1662481435,
            (C_OWNOCC_P = NULL) => 0.0302816862, 0.0302816862),
         (f_hh_collections_ct_i > 2.5) => 0.1393044554,
         (f_hh_collections_ct_i = NULL) => 0.0397719910, 0.0397719910),
      (c_rnt750_p > 57.25) => 0.1673761331,
      (c_rnt750_p = NULL) => 0.0481270241, 0.0481270241),
   (f_liens_unrel_CJ_total_amt_i > 194) => -0.0736775532,
   (f_liens_unrel_CJ_total_amt_i = NULL) => 0.0390671795, 0.0390671795),
(c_many_cars > 22.5) => -0.0075815680,
(c_many_cars = NULL) => 0.0038293141, -0.0032790742);

// Tree: 168 
wFDN_FLAP___lgt_168 := map(
(NULL < c_hval_150k_p and c_hval_150k_p <= 23.15) => -0.0064657134,
(c_hval_150k_p > 23.15) => 
   map(
   (NULL < c_popover18 and c_popover18 <= 1894.5) => 
      map(
      (NULL < c_fammar_p and c_fammar_p <= 45.15) => 0.1125961967,
      (c_fammar_p > 45.15) => 0.0043846700,
      (c_fammar_p = NULL) => 0.0144185491, 0.0144185491),
   (c_popover18 > 1894.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 1.55) => -0.0068336737,
      (c_hh6_p > 1.55) => 
         map(
         (NULL < c_unattach and c_unattach <= 89.5) => 0.0910735376,
         (c_unattach > 89.5) => 0.2909272263,
         (c_unattach = NULL) => 0.1890787119, 0.1890787119),
      (c_hh6_p = NULL) => 0.1123177187, 0.1123177187),
   (c_popover18 = NULL) => 0.0336166661, 0.0336166661),
(c_hval_150k_p = NULL) => -0.0126617645, -0.0038500441);

// Tree: 169 
wFDN_FLAP___lgt_169 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 36.25) => -0.0044208047,
(c_hval_500k_p > 36.25) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 0.5) => 
      map(
      (NULL < c_rich_wht and c_rich_wht <= 47) => 0.2071484415,
      (c_rich_wht > 47) => 
         map(
         (NULL < c_femdiv_p and c_femdiv_p <= 4.25) => -0.0533853819,
         (c_femdiv_p > 4.25) => 0.1830375358,
         (c_femdiv_p = NULL) => 0.0584933202, 0.0584933202),
      (c_rich_wht = NULL) => 0.1068510103, 0.1068510103),
   (f_rel_incomeover100_count_d > 0.5) => 
      map(
      (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0059791935) => 0.1363168487,
      (f_add_input_nhood_VAC_pct_i > 0.0059791935) => -0.0648476849,
      (f_add_input_nhood_VAC_pct_i = NULL) => -0.0015949192, -0.0015949192),
   (f_rel_incomeover100_count_d = NULL) => 0.0484107038, 0.0484107038),
(c_hval_500k_p = NULL) => 0.0015065464, -0.0027517257);

// Tree: 170 
wFDN_FLAP___lgt_170 := map(
(NULL < c_easiqlife and c_easiqlife <= 96.5) => -0.0118420259,
(c_easiqlife > 96.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < f_nae_nothing_found_i and f_nae_nothing_found_i <= 0.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 0.0299177327,
         (k_estimated_income_d > 36500) => -0.0003075954,
         (k_estimated_income_d = NULL) => 0.0051999413, 0.0054923361),
      (f_nae_nothing_found_i > 0.5) => 0.1117430401,
      (f_nae_nothing_found_i = NULL) => 0.0067519523, 0.0067519523),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < c_rnt750_p and c_rnt750_p <= 2.85) => -0.0414523672,
      (c_rnt750_p > 2.85) => 0.1379130404,
      (c_rnt750_p = NULL) => 0.0748258970, 0.0748258970),
   (r_P85_Phn_Disconnected_i = NULL) => 0.0080140316, 0.0080140316),
(c_easiqlife = NULL) => -0.0334208853, -0.0000453712);

// Tree: 171 
wFDN_FLAP___lgt_171 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 37.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 1.95) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 19.5) => 
         map(
         (NULL < C_INC_35K_P and C_INC_35K_P <= 12.75) => 0.0334066623,
         (C_INC_35K_P > 12.75) => 0.1563705729,
         (C_INC_35K_P = NULL) => 0.0515359568, 0.0515359568),
      (f_addrchangecrimediff_i > 19.5) => 0.1592591347,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_pop_55_64_p and c_pop_55_64_p <= 8.55) => 0.1266454608,
         (c_pop_55_64_p > 8.55) => -0.0645921192,
         (c_pop_55_64_p = NULL) => 0.0078768585, 0.0078768585), 0.0481689779),
   (c_hval_100k_p > 1.95) => -0.0034795437,
   (c_hval_100k_p = NULL) => 0.0399652685, 0.0224342932),
(f_mos_inq_banko_cm_lseen_d > 37.5) => -0.0023564088,
(f_mos_inq_banko_cm_lseen_d = NULL) => -0.0083104218, 0.0011501589);

// Tree: 172 
wFDN_FLAP___lgt_172 := map(
(NULL < c_pop_0_5_p and c_pop_0_5_p <= 20.75) => 
   map(
   (NULL < c_manufacturing and c_manufacturing <= 16.55) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 7.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 10.55) => 0.0007342326,
         (c_hh7p_p > 10.55) => 0.0671169138,
         (c_hh7p_p = NULL) => 0.0019244333, 0.0019244333),
      (r_L79_adls_per_addr_curr_i > 7.5) => 
         map(
         (NULL < c_transport and c_transport <= 5.55) => -0.0566976591,
         (c_transport > 5.55) => 0.0826170349,
         (c_transport = NULL) => -0.0401125765, -0.0401125765),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0038169283, 0.0003977651),
   (c_manufacturing > 16.55) => -0.0510520656,
   (c_manufacturing = NULL) => -0.0035663135, -0.0035663135),
(c_pop_0_5_p > 20.75) => 0.1416406548,
(c_pop_0_5_p = NULL) => 0.0012997961, -0.0028255348);

// Tree: 173 
wFDN_FLAP___lgt_173 := map(
(NULL < c_low_hval and c_low_hval <= 71.55) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 0.5) => -0.0060504958,
   (f_rel_felony_count_i > 0.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => 
         map(
         (NULL < c_easiqlife and c_easiqlife <= 112.5) => 0.2039342276,
         (c_easiqlife > 112.5) => 0.0485676919,
         (c_easiqlife = NULL) => 0.1133037484, 0.1133037484),
      (r_C12_Num_NonDerogs_d > 1.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0630616625) => -0.0071187743,
         (f_add_curr_nhood_BUS_pct_i > 0.0630616625) => 0.0492241716,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0113245459, 0.0113245459),
      (r_C12_Num_NonDerogs_d = NULL) => 0.0182150325, 0.0182150325),
   (f_rel_felony_count_i = NULL) => -0.0178519444, -0.0026790587),
(c_low_hval > 71.55) => -0.1112071983,
(c_low_hval = NULL) => -0.0375741782, -0.0041404734);

// Tree: 174 
wFDN_FLAP___lgt_174 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 14.5) => 
   map(
   (NULL < c_info and c_info <= 27.55) => 
      map(
      (NULL < c_incollege and c_incollege <= 4.05) => -0.0172957900,
      (c_incollege > 4.05) => 
         map(
         (NULL < c_new_homes and c_new_homes <= 146.5) => 0.0210556784,
         (c_new_homes > 146.5) => -0.0132320632,
         (c_new_homes = NULL) => 0.0090561569, 0.0090561569),
      (c_incollege = NULL) => 0.0016131406, 0.0016131406),
   (c_info > 27.55) => 0.1967972226,
   (c_info = NULL) => 0.0025661009, 0.0026725340),
(f_srchphonesrchcount_i > 14.5) => 
   map(
   (NULL < c_occunit_p and c_occunit_p <= 93.75) => -0.1449087753,
   (c_occunit_p > 93.75) => 0.0155937155,
   (c_occunit_p = NULL) => -0.0724237794, -0.0724237794),
(f_srchphonesrchcount_i = NULL) => -0.0271693595, 0.0015796429);

// Tree: 175 
wFDN_FLAP___lgt_175 := map(
(NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.2843546681) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => -0.0024203121,
   (k_comb_age_d > 56.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 175.5) => 0.0212415925,
      (c_sub_bus > 175.5) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 6.5) => 0.2516574883,
         (f_rel_homeover150_count_d > 6.5) => 0.0041120060,
         (f_rel_homeover150_count_d = NULL) => 0.1383234120, 0.1383234120),
      (c_sub_bus = NULL) => 0.0329287795, 0.0329287795),
   (k_comb_age_d = NULL) => 0.0052685765, 0.0052685765),
(f_add_curr_mobility_index_i > 0.2843546681) => -0.0171455914,
(f_add_curr_mobility_index_i = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 132) => -0.0257297443,
   (c_totcrime > 132) => 0.0919105533,
   (c_totcrime = NULL) => 0.0357633526, 0.0188569516), -0.0024780543);

// Tree: 176 
wFDN_FLAP___lgt_176 := map(
(NULL < c_pop_18_24_p and c_pop_18_24_p <= 11.15) => 
   map(
   (NULL < f_util_adl_count_n and f_util_adl_count_n <= 6.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 33.5) => 0.0518790955,
      (c_exp_prod > 33.5) => 0.0002721562,
      (c_exp_prod = NULL) => 0.0031086039, 0.0031086039),
   (f_util_adl_count_n > 6.5) => 
      map(
      (NULL < c_pop_55_64_p and c_pop_55_64_p <= 17.45) => 
         map(
         (NULL < c_robbery and c_robbery <= 165.5) => 0.0186045845,
         (c_robbery > 165.5) => 0.1808121372,
         (c_robbery = NULL) => 0.0335864544, 0.0335864544),
      (c_pop_55_64_p > 17.45) => 0.2230222611,
      (c_pop_55_64_p = NULL) => 0.0501659253, 0.0501659253),
   (f_util_adl_count_n = NULL) => 0.0167411781, 0.0062918477),
(c_pop_18_24_p > 11.15) => -0.0231003191,
(c_pop_18_24_p = NULL) => 0.0167334228, -0.0001583338);

// Tree: 177 
wFDN_FLAP___lgt_177 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 46.05) => 
      map(
      (NULL < c_sfdu_p and c_sfdu_p <= 0.85) => -0.0763632061,
      (c_sfdu_p > 0.85) => 0.0028451685,
      (c_sfdu_p = NULL) => 0.0015634796, 0.0015634796),
   (c_hval_100k_p > 46.05) => 0.0960718249,
   (c_hval_100k_p = NULL) => 0.0193677845, 0.0025090096),
(k_comb_age_d > 81.5) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 1.5) => -0.0066935915,
   (f_rel_homeover300_count_d > 1.5) => 0.1697044497,
   (f_rel_homeover300_count_d = NULL) => 0.0585965925, 0.0585965925),
(k_comb_age_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 128) => -0.0492197986,
   (c_no_car > 128) => 0.0382189010,
   (c_no_car = NULL) => -0.0149169241, -0.0149169241), 0.0029888917);

// Tree: 178 
wFDN_FLAP___lgt_178 := map(
(NULL < f_phones_per_addr_c6_i and f_phones_per_addr_c6_i <= 0.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 13.75) => -0.0208799599,
   (c_rnt1250_p > 13.75) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 8.5) => 0.1174888132,
      (f_mos_inq_banko_cm_lseen_d > 8.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 119242.5) => 
            map(
            (NULL < c_born_usa and c_born_usa <= 37.5) => 0.1802217584,
            (c_born_usa > 37.5) => 0.0352527242,
            (c_born_usa = NULL) => 0.0765868703, 0.0765868703),
         (r_L80_Inp_AVM_AutoVal_d > 119242.5) => 0.0009022110,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0029441544, 0.0079995175),
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0122950871, 0.0122950871),
   (c_rnt1250_p = NULL) => -0.0212462541, -0.0115013909),
(f_phones_per_addr_c6_i > 0.5) => 0.0179461200,
(f_phones_per_addr_c6_i = NULL) => -0.0010177520, -0.0010177520);

// Tree: 179 
wFDN_FLAP___lgt_179 := map(
(NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 22.5) => 
   map(
   (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 37.5) => 
      map(
      (NULL < c_health and c_health <= 2.25) => 0.0166787541,
      (c_health > 2.25) => -0.0076120555,
      (c_health = NULL) => -0.0002199998, -0.0011049436),
   (f_rel_educationover8_count_d > 37.5) => 0.0921045507,
   (f_rel_educationover8_count_d = NULL) => -0.0006869291, -0.0006869291),
(f_rel_incomeover50_count_d > 22.5) => -0.0568917603,
(f_rel_incomeover50_count_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 229700) => 0.1012478408,
   (r_L80_Inp_AVM_AutoVal_d > 229700) => -0.0218460515,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_retail and c_retail <= 12.1) => -0.0564693805,
      (c_retail > 12.1) => 0.0601326539,
      (c_retail = NULL) => -0.0084223111, -0.0084223111), 0.0149218839), -0.0014456885);

// Tree: 180 
wFDN_FLAP___lgt_180 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 10.65) => 0.0017565491,
   (c_hval_150k_p > 10.65) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 16.7) => 0.0598195545,
         (c_hval_250k_p > 16.7) => 0.2925548579,
         (c_hval_250k_p = NULL) => 0.1030000039, 0.1030000039),
      (k_comb_age_d > 26.5) => 0.0263499007,
      (k_comb_age_d = NULL) => 0.0431253535, 0.0431253535),
   (c_hval_150k_p = NULL) => 0.0525316266, 0.0111191449),
(f_dl_addrs_per_adl_i > 0.5) => -0.0146969651,
(f_dl_addrs_per_adl_i = NULL) => 
   map(
   (NULL < c_for_sale and c_for_sale <= 112) => -0.0423929302,
   (c_for_sale > 112) => 0.0652171009,
   (c_for_sale = NULL) => 0.0039907039, 0.0039907039), 0.0008096796);

// Tree: 181 
wFDN_FLAP___lgt_181 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 17.5) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 130) => 
      map(
      (NULL < c_vacant_p and c_vacant_p <= 13.5) => 
         map(
         (NULL < c_lar_fam and c_lar_fam <= 142.5) => 
            map(
            (NULL < C_INC_125K_P and C_INC_125K_P <= 9.75) => 0.0288879285,
            (C_INC_125K_P > 9.75) => 0.1981339916,
            (C_INC_125K_P = NULL) => 0.0914528238, 0.0914528238),
         (c_lar_fam > 142.5) => -0.0684536467,
         (c_lar_fam = NULL) => 0.0455337360, 0.0455337360),
      (c_vacant_p > 13.5) => 0.1728728290,
      (c_vacant_p = NULL) => 0.0696060577, 0.0696060577),
   (c_ab_av_edu > 130) => -0.0310371089,
   (c_ab_av_edu = NULL) => 0.0281170872, 0.0281170872),
(r_C21_M_Bureau_ADL_FS_d > 17.5) => -0.0051536206,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0192746714, -0.0031918817);

// Tree: 182 
wFDN_FLAP___lgt_182 := map(
(NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => -0.0038077732,
(k_inq_per_addr_i > 3.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0365790614) => 
      map(
      (NULL < c_construction and c_construction <= 11.65) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 140) => 0.0019678647,
         (c_born_usa > 140) => 0.1595198168,
         (c_born_usa = NULL) => 0.0239683625, 0.0239683625),
      (c_construction > 11.65) => 0.1144654930,
      (c_construction = NULL) => 0.0530270741, 0.0530270741),
   (f_add_curr_nhood_BUS_pct_i > 0.0365790614) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 15.5) => 0.0198549137,
      (f_rel_educationover8_count_d > 15.5) => -0.0864579686,
      (f_rel_educationover8_count_d = NULL) => -0.0053289010, -0.0053289010),
   (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0568376942, 0.0257393573),
(k_inq_per_addr_i = NULL) => -0.0005980021, -0.0005980021);

// Tree: 183 
wFDN_FLAP___lgt_183 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 7.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < c_transport and c_transport <= 26.65) => -0.0046684174,
      (c_transport > 26.65) => 0.0648818877,
      (c_transport = NULL) => 0.0238889051, -0.0026740616),
   (k_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 12.25) => -0.0175676180,
      (C_INC_25K_P > 12.25) => -0.1171382236,
      (C_INC_25K_P = NULL) => -0.0452035412, -0.0452035412),
   (k_inq_adls_per_addr_i = NULL) => -0.0035219843, -0.0035219843),
(f_srchfraudsrchcountyr_i > 7.5) => -0.0779927629,
(f_srchfraudsrchcountyr_i = NULL) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.95) => -0.0659444917,
   (c_pop_75_84_p > 2.95) => 0.0376533566,
   (c_pop_75_84_p = NULL) => -0.0106403772, -0.0106403772), -0.0041538248);

// Tree: 184 
wFDN_FLAP___lgt_184 := map(
(NULL < f_property_owners_ct_d and f_property_owners_ct_d <= 5.5) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 92.2) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 0.0021287590,
      (f_phones_per_addr_curr_i > 50.5) => 
         map(
         (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 4.5) => -0.0054993933,
         (f_rel_under25miles_cnt_d > 4.5) => 0.1345796900,
         (f_rel_under25miles_cnt_d = NULL) => 0.0543004493, 0.0543004493),
      (f_phones_per_addr_curr_i = NULL) => 0.0028942821, 0.0028942821),
   (C_RENTOCC_P > 92.2) => -0.0876253928,
   (C_RENTOCC_P = NULL) => 0.0272268255, 0.0027057330),
(f_property_owners_ct_d > 5.5) => -0.1269799096,
(f_property_owners_ct_d = NULL) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3120802696) => 0.0431284314,
   (f_add_input_mobility_index_i > 0.3120802696) => -0.0794475153,
   (f_add_input_mobility_index_i = NULL) => -0.0045399923, -0.0045399923), 0.0020083534);

// Tree: 185 
wFDN_FLAP___lgt_185 := map(
(NULL < c_high_ed and c_high_ed <= 4.25) => 
   map(
   (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.15703172865) => 
      map(
      (NULL < c_hh2_p and c_hh2_p <= 33.65) => -0.0686219684,
      (c_hh2_p > 33.65) => 0.1145064326,
      (c_hh2_p = NULL) => -0.0148777638, -0.0148777638),
   (f_add_curr_nhood_MFD_pct_i > 0.15703172865) => 
      map(
      (NULL < f_rel_educationover12_count_d and f_rel_educationover12_count_d <= 2.5) => 0.0118127247,
      (f_rel_educationover12_count_d > 2.5) => 0.1292045787,
      (f_rel_educationover12_count_d = NULL) => 0.0855588894, 0.0855588894),
   (f_add_curr_nhood_MFD_pct_i = NULL) => 0.0646637804, 0.0364666965),
(c_high_ed > 4.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 0.0010126200,
   (f_rel_felony_count_i > 4.5) => 0.0765113704,
   (f_rel_felony_count_i = NULL) => 0.0060384008, 0.0014853434),
(c_high_ed = NULL) => -0.0092703861, 0.0023321386);

// Tree: 186 
wFDN_FLAP___lgt_186 := map(
(NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.3923820453) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 15.75) => 
      map(
      (NULL < c_white_col and c_white_col <= 20.45) => 0.0406943697,
      (c_white_col > 20.45) => 0.0038116965,
      (c_white_col = NULL) => 0.0058552905, 0.0058552905),
   (c_pop_6_11_p > 15.75) => 0.1490754907,
   (c_pop_6_11_p = NULL) => -0.0044579157, 0.0064902647),
(f_add_input_mobility_index_i > 0.3923820453) => 
   map(
   (NULL < c_bargains and c_bargains <= 117.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => -0.1114901980,
      (k_estimated_income_d > 30500) => -0.0521815878,
      (k_estimated_income_d = NULL) => -0.0600655118, -0.0600655118),
   (c_bargains > 117.5) => -0.0038869911,
   (c_bargains = NULL) => 0.0203760268, -0.0225962212),
(f_add_input_mobility_index_i = NULL) => -0.0121119515, 0.0020048148);

// Tree: 187 
wFDN_FLAP___lgt_187 := map(
(NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 7.5) => 
   map(
   (NULL < f_vf_LexID_addr_lo_risk_ct_d and f_vf_LexID_addr_lo_risk_ct_d <= 3.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 78.65) => -0.0029397353,
      (c_high_hval > 78.65) => 
         map(
         (NULL < k_inf_nothing_found_i and k_inf_nothing_found_i <= 0.5) => 0.0023041393,
         (k_inf_nothing_found_i > 0.5) => 
            map(
            (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 5.5) => 0.2057861161,
            (f_rel_incomeover50_count_d > 5.5) => 0.0454223541,
            (f_rel_incomeover50_count_d = NULL) => 0.1276087821, 0.1276087821),
         (k_inf_nothing_found_i = NULL) => 0.0474358262, 0.0474358262),
      (c_high_hval = NULL) => -0.0220833666, -0.0005500346),
   (f_vf_LexID_addr_lo_risk_ct_d > 3.5) => -0.0932131017,
   (f_vf_LexID_addr_lo_risk_ct_d = NULL) => -0.0009471192, -0.0009471192),
(f_rel_bankrupt_count_i > 7.5) => -0.0790141541,
(f_rel_bankrupt_count_i = NULL) => 0.0114404176, -0.0017713547);

// Tree: 188 
wFDN_FLAP___lgt_188 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 11.5) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 4.5) => 0.0002363366,
   (f_hh_collections_ct_i > 4.5) => 
      map(
      (NULL < c_pop_45_54_p and c_pop_45_54_p <= 11.7) => -0.0629936754,
      (c_pop_45_54_p > 11.7) => 
         map(
         (NULL < c_sub_bus and c_sub_bus <= 127) => 0.0395282632,
         (c_sub_bus > 127) => 0.2102141718,
         (c_sub_bus = NULL) => 0.1273569346, 0.1273569346),
      (c_pop_45_54_p = NULL) => 0.0626865351, 0.0626865351),
   (f_hh_collections_ct_i = NULL) => 0.0010369156, 0.0010369156),
(r_L79_adls_per_addr_curr_i > 11.5) => -0.0649670130,
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 1.9) => 0.0463526850,
   (c_hval_100k_p > 1.9) => -0.0490978069,
   (c_hval_100k_p = NULL) => 0.0027611217, 0.0027611217), 0.0003651288);

// Tree: 189 
wFDN_FLAP___lgt_189 := map(
(NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 44.5) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
      map(
      (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 14.5) => -0.0049795534,
      (f_rel_homeover500_count_d > 14.5) => 0.0811350613,
      (f_rel_homeover500_count_d = NULL) => 0.0148997635, -0.0038459086),
   (r_D34_unrel_liens_ct_i > 7.5) => 0.0950899561,
   (r_D34_unrel_liens_ct_i = NULL) => -0.0033568019, -0.0033568019),
(f_phones_per_addr_curr_i > 44.5) => 
   map(
   (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 5.5) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.54491947855) => -0.0409409669,
      (f_add_curr_nhood_MFD_pct_i > 0.54491947855) => 0.0373304608,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0056835670, -0.0056835670),
   (f_rel_under25miles_cnt_d > 5.5) => 0.1265415342,
   (f_rel_under25miles_cnt_d = NULL) => 0.0432886927, 0.0432886927),
(f_phones_per_addr_curr_i = NULL) => -0.0077697040, -0.0026842249);

// Tree: 190 
wFDN_FLAP___lgt_190 := map(
(NULL < c_hh2_p and c_hh2_p <= 51.15) => -0.0084584375,
(c_hh2_p > 51.15) => 
   map(
   (NULL < c_rape and c_rape <= 14.5) => 0.2652818727,
   (c_rape > 14.5) => 
      map(
      (NULL < f_varmsrcssnunrelcount_i and f_varmsrcssnunrelcount_i <= 0.5) => 0.1643310701,
      (f_varmsrcssnunrelcount_i > 0.5) => 
         map(
         (NULL < c_hh3_p and c_hh3_p <= 12.8) => -0.0637160825,
         (c_hh3_p > 12.8) => 
            map(
            (NULL < c_mort_indx and c_mort_indx <= 100.5) => 0.2390878514,
            (c_mort_indx > 100.5) => -0.0184803067,
            (c_mort_indx = NULL) => 0.0935058490, 0.0935058490),
         (c_hh3_p = NULL) => -0.0132118308, -0.0132118308),
      (f_varmsrcssnunrelcount_i = NULL) => 0.0218190555, 0.0218190555),
   (c_rape = NULL) => 0.0474721953, 0.0474721953),
(c_hh2_p = NULL) => -0.0229252206, -0.0065747685);

// Tree: 191 
wFDN_FLAP___lgt_191 := map(
(NULL < c_totcrime and c_totcrime <= 163.5) => 
   map(
   (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 18.5) => -0.0053810049,
   (f_srchfraudsrchcount_i > 18.5) => 0.0615991972,
   (f_srchfraudsrchcount_i = NULL) => -0.0206776223, -0.0048918979),
(c_totcrime > 163.5) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 1.5) => 0.0145582130,
   (f_assoccredbureaucount_i > 1.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 155.5) => 
         map(
         (NULL < c_employees and c_employees <= 272.5) => -0.0435996904,
         (c_employees > 272.5) => 0.1767115450,
         (c_employees = NULL) => 0.0402751454, 0.0402751454),
      (c_born_usa > 155.5) => 0.1667834395,
      (c_born_usa = NULL) => 0.0787193620, 0.0787193620),
   (f_assoccredbureaucount_i = NULL) => 0.0283348482, 0.0283348482),
(c_totcrime = NULL) => -0.0314033302, -0.0020068982);

// Tree: 192 
wFDN_FLAP___lgt_192 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 94.5) => 0.0855420322,
(r_D32_Mos_Since_Fel_LS_d > 94.5) => 
   map(
   (NULL < c_unempl and c_unempl <= 165.5) => -0.0002593679,
   (c_unempl > 165.5) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.33755250655) => -0.0826832523,
         (f_add_curr_mobility_index_i > 0.33755250655) => -0.0299773915,
         (f_add_curr_mobility_index_i = NULL) => -0.0683089266, -0.0683089266),
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
         map(
         (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 124.5) => -0.0581185135,
         (f_fp_prevaddrburglaryindex_i > 124.5) => 0.0331097806,
         (f_fp_prevaddrburglaryindex_i = NULL) => -0.0190002779, -0.0190002779),
      (nf_seg_FraudPoint_3_0 = '') => -0.0316714539, -0.0316714539),
   (c_unempl = NULL) => 0.0023870434, -0.0023688923),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0090969634, -0.0018831778);

// Tree: 193 
wFDN_FLAP___lgt_193 := map(
(NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 152.5) => -0.0079993839,
(f_prevaddrageoldest_d > 152.5) => 
   map(
   (NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 230.5) => 
      map(
      (NULL < c_finance and c_finance <= 1.35) => 0.2483833366,
      (c_finance > 1.35) => 0.0316063950,
      (c_finance = NULL) => 0.1338596693, 0.1338596693),
   (f_mos_liens_unrel_OT_fseen_d > 230.5) => 
      map(
      (NULL < f_adl_per_email_i and f_adl_per_email_i <= 0.5) => 0.1771074427,
      (f_adl_per_email_i > 0.5) => -0.0358742003,
      (f_adl_per_email_i = NULL) => 
         map(
         (NULL < c_rnt2001_p and c_rnt2001_p <= 48.3) => 0.0043762745,
         (c_rnt2001_p > 48.3) => 0.1460632621,
         (c_rnt2001_p = NULL) => 0.0087845446, 0.0087845446), 0.0116200380),
   (f_mos_liens_unrel_OT_fseen_d = NULL) => 0.0159406119, 0.0159406119),
(f_prevaddrageoldest_d = NULL) => -0.0142014361, -0.0024196511);

// Tree: 194 
wFDN_FLAP___lgt_194 := map(
(NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 331.5) => 
   map(
   (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.8657834043) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.74257692535) => 0.0055369024,
      (f_add_input_nhood_MFD_pct_i > 0.74257692535) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.01511877155) => 0.2011384839,
         (f_add_input_nhood_BUS_pct_i > 0.01511877155) => 0.0455441289,
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0651269425, 0.0651269425),
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0089764430, 0.0089764430),
   (f_add_input_nhood_MFD_pct_i > 0.8657834043) => -0.0440479529,
   (f_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0065691750,
      (f_srchaddrsrchcount_i > 14.5) => 0.1150627510,
      (f_srchaddrsrchcount_i = NULL) => -0.0026209135, -0.0026209135), 0.0035099154),
(f_M_Bureau_ADL_FS_noTU_d > 331.5) => -0.0276832007,
(f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0071612984, -0.0022605578);

// Tree: 195 
wFDN_FLAP___lgt_195 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 35.65) => 
   map(
   (NULL < f_srchcomponentrisktype_i and f_srchcomponentrisktype_i <= 4.5) => 
      map(
      (NULL < k_inq_per_phone_i and k_inq_per_phone_i <= 10.5) => 
         map(
         (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -48.5) => 0.0547894651,
         (f_addrchangecrimediff_i > -48.5) => 0.0028947832,
         (f_addrchangecrimediff_i = NULL) => 
            map(
            (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 1.5) => -0.0340154704,
            (f_srchaddrsrchcount_i > 1.5) => 0.0373769479,
            (f_srchaddrsrchcount_i = NULL) => -0.0053587766, -0.0053587766), 0.0020798933),
      (k_inq_per_phone_i > 10.5) => 0.1060237291,
      (k_inq_per_phone_i = NULL) => 0.0026092891, 0.0026092891),
   (f_srchcomponentrisktype_i > 4.5) => -0.0687671249,
   (f_srchcomponentrisktype_i = NULL) => 0.0062721440, 0.0020984120),
(c_hval_80k_p > 35.65) => -0.0820521775,
(c_hval_80k_p = NULL) => 0.0224083882, 0.0013910511);

// Tree: 196 
wFDN_FLAP___lgt_196 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 43.5) => -0.0851438864,
(f_mos_inq_banko_am_lseen_d > 43.5) => 
   map(
   (NULL < r_C16_Inv_SSN_Per_ADL_c6_i and r_C16_Inv_SSN_Per_ADL_c6_i <= 0.5) => 
      map(
      (NULL < c_hval_60k_p and c_hval_60k_p <= 44.35) => 
         map(
         (NULL < c_white_col and c_white_col <= 13.45) => 0.0870979241,
         (c_white_col > 13.45) => 0.0004105239,
         (c_white_col = NULL) => 0.0010951527, 0.0010951527),
      (c_hval_60k_p > 44.35) => -0.1181690900,
      (c_hval_60k_p = NULL) => 0.0198317269, 0.0009860226),
   (r_C16_Inv_SSN_Per_ADL_c6_i > 0.5) => -0.0703028121,
   (r_C16_Inv_SSN_Per_ADL_c6_i = NULL) => -0.0004684939, -0.0004684939),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 0.85) => -0.0468350115,
   (c_hval_150k_p > 0.85) => 0.0397123491,
   (c_hval_150k_p = NULL) => -0.0005973805, -0.0005973805), -0.0025662154);

// Tree: 197 
wFDN_FLAP___lgt_197 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -62436.5) => 
   map(
   (NULL < f_prevaddrmedianvalue_d and f_prevaddrmedianvalue_d <= 454824.5) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 2.5) => 0.0442379413,
      (r_C14_addrs_5yr_i > 2.5) => 0.1842497466,
      (r_C14_addrs_5yr_i = NULL) => 0.0889225600, 0.0889225600),
   (f_prevaddrmedianvalue_d > 454824.5) => -0.0469076115,
   (f_prevaddrmedianvalue_d = NULL) => 0.0411478100, 0.0411478100),
(f_addrchangevaluediff_d > -62436.5) => -0.0004706613,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < r_I60_inq_retail_recency_d and r_I60_inq_retail_recency_d <= 9) => 0.1357474408,
   (r_I60_inq_retail_recency_d > 9) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 6.5) => -0.0019239546,
      (f_srchfraudsrchcount_i > 6.5) => -0.0631094847,
      (f_srchfraudsrchcount_i = NULL) => -0.0047415585, -0.0047415585),
   (r_I60_inq_retail_recency_d = NULL) => -0.0053426031, -0.0014374368), 0.0002594799);

// Tree: 198 
wFDN_FLAP___lgt_198 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 39.25) => 0.0051716860,
(c_famotf18_p > 39.25) => 
   map(
   (NULL < f_hh_workers_paw_d and f_hh_workers_paw_d <= 1.5) => 
      map(
      (NULL < f_rel_incomeover50_count_d and f_rel_incomeover50_count_d <= 3.5) => 
         map(
         (NULL < C_INC_125K_P and C_INC_125K_P <= 4.65) => 
            map(
            (NULL < C_INC_25K_P and C_INC_25K_P <= 17.55) => -0.0732223658,
            (C_INC_25K_P > 17.55) => 0.0408499799,
            (C_INC_25K_P = NULL) => -0.0221690082, -0.0221690082),
         (C_INC_125K_P > 4.65) => 0.1204876349,
         (C_INC_125K_P = NULL) => 0.0209759277, 0.0209759277),
      (f_rel_incomeover50_count_d > 3.5) => -0.0725704601,
      (f_rel_incomeover50_count_d = NULL) => -0.0126423054, -0.0126423054),
   (f_hh_workers_paw_d > 1.5) => -0.1163123324,
   (f_hh_workers_paw_d = NULL) => -0.0344154853, -0.0344154853),
(c_famotf18_p = NULL) => -0.0301415404, 0.0030349126);

// Tree: 199 
wFDN_FLAP___lgt_199 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 27.65) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 55.85) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0769703126,
      (r_D33_Eviction_Recency_d > 30) => 0.0007582598,
      (r_D33_Eviction_Recency_d = NULL) => 0.0021925850, 0.0013561477),
   (c_lowinc > 55.85) => 
      map(
      (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 152.5) => -0.0696113374,
      (f_curraddrmurderindex_i > 152.5) => 
         map(
         (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 58) => 0.0728825048,
         (f_mos_inq_banko_cm_fseen_d > 58) => -0.0391178260,
         (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0091234354, -0.0091234354),
      (f_curraddrmurderindex_i = NULL) => -0.0375399573, -0.0375399573),
   (c_lowinc = NULL) => -0.0007766607, -0.0007766607),
(C_INC_25K_P > 27.65) => 0.0811432288,
(C_INC_25K_P = NULL) => -0.0402691772, -0.0010923082);

// Tree: 200 
wFDN_FLAP___lgt_200 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 109.5) => 
   map(
   (NULL < c_food and c_food <= 68.85) => -0.0050239143,
   (c_food > 68.85) => 
      map(
      (NULL < f_rel_ageover30_count_d and f_rel_ageover30_count_d <= 13.5) => 
         map(
         (NULL < C_INC_200K_P and C_INC_200K_P <= 4.45) => 
            map(
            (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 0.5) => 0.0879232012,
            (r_P88_Phn_Dst_to_Inp_Add_i > 0.5) => 0.1001111768,
            (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0939591510, 0.0939591510),
         (C_INC_200K_P > 4.45) => -0.0037927517,
         (C_INC_200K_P = NULL) => 0.0542474405, 0.0542474405),
      (f_rel_ageover30_count_d > 13.5) => -0.0860772815,
      (f_rel_ageover30_count_d = NULL) => 0.0253863275, 0.0253863275),
   (c_food = NULL) => -0.0041116385, -0.0041116385),
(f_addrchangecrimediff_i > 109.5) => 0.0810094560,
(f_addrchangecrimediff_i = NULL) => -0.0093005800, -0.0049332580);

// Tree: 201 
wFDN_FLAP___lgt_201 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => 0.0025257624,
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => 
   map(
   (NULL < c_no_move and c_no_move <= 143.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 22.5) => -0.1305703690,
      (f_mos_inq_banko_cm_lseen_d > 22.5) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.05334379135) => -0.0570620852,
         (f_add_curr_nhood_BUS_pct_i > 0.05334379135) => -0.0227789117,
         (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0441147165, -0.0441147165),
      (f_mos_inq_banko_cm_lseen_d = NULL) => -0.0566006532, -0.0566006532),
   (c_no_move > 143.5) => 0.0504223022,
   (c_no_move = NULL) => -0.0411685042, -0.0411685042),
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 7.85) => -0.0740122305,
   (c_pop_6_11_p > 7.85) => 0.0369520536,
   (c_pop_6_11_p = NULL) => -0.0167403419, -0.0167403419), 0.0004253201);

// Tree: 202 
wFDN_FLAP___lgt_202 := map(
(NULL < f_mos_inq_banko_am_lseen_d and f_mos_inq_banko_am_lseen_d <= 47.5) => -0.0750838654,
(f_mos_inq_banko_am_lseen_d > 47.5) => 
   map(
   (NULL < c_rich_nfam and c_rich_nfam <= 182.5) => -0.0014981972,
   (c_rich_nfam > 182.5) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 7.55) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.9622917995) => 0.0532649069,
         (f_add_curr_nhood_SFD_pct_d > 0.9622917995) => 0.3116433522,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.0927179031, 0.0927179031),
      (C_INC_125K_P > 7.55) => 0.0128924144,
      (C_INC_125K_P = NULL) => 0.0333699207, 0.0333699207),
   (c_rich_nfam = NULL) => 0.0193676861, 0.0026903287),
(f_mos_inq_banko_am_lseen_d = NULL) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 2.615) => -0.0472918000,
   (c_hhsize > 2.615) => 0.0546528728,
   (c_hhsize = NULL) => 0.0040818933, 0.0040818933), 0.0001743814);

// Tree: 203 
wFDN_FLAP___lgt_203 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 310.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 119.5) => -0.0027862854,
   (f_addrchangecrimediff_i > 119.5) => 0.0800303061,
   (f_addrchangecrimediff_i = NULL) => -0.0112557029, -0.0042945387),
(r_C13_Curr_Addr_LRes_d > 310.5) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 45.6) => 
      map(
      (NULL < C_INC_100K_P and C_INC_100K_P <= 7.35) => 0.1457190242,
      (C_INC_100K_P > 7.35) => 
         map(
         (NULL < f_inq_Collection_count_i and f_inq_Collection_count_i <= 3.5) => -0.0066425511,
         (f_inq_Collection_count_i > 3.5) => 0.1278399545,
         (f_inq_Collection_count_i = NULL) => 0.0049354130, 0.0049354130),
      (C_INC_100K_P = NULL) => 0.0166851833, 0.0166851833),
   (c_hval_750k_p > 45.6) => 0.1691841914,
   (c_hval_750k_p = NULL) => 0.0274396972, 0.0274396972),
(r_C13_Curr_Addr_LRes_d = NULL) => 0.0135409181, -0.0022599044);

// Tree: 204 
wFDN_FLAP___lgt_204 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 2.25) => -0.1180011384,
(c_pop_35_44_p > 2.25) => 
   map(
   (NULL < C_RENTOCC_P and C_RENTOCC_P <= 80.75) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 107.5) => 0.0059606202,
      (f_addrchangecrimediff_i > 107.5) => 0.0843566551,
      (f_addrchangecrimediff_i = NULL) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 16.5) => 0.0535236025,
         (c_born_usa > 16.5) => -0.0130573362,
         (c_born_usa = NULL) => -0.0061418619, -0.0061418619), 0.0037022207),
   (C_RENTOCC_P > 80.75) => 
      map(
      (NULL < c_hval_750k_p and c_hval_750k_p <= 38.15) => -0.0739040385,
      (c_hval_750k_p > 38.15) => 0.1036539489,
      (c_hval_750k_p = NULL) => -0.0462155405, -0.0462155405),
   (C_RENTOCC_P = NULL) => 0.0020657056, 0.0020657056),
(c_pop_35_44_p = NULL) => -0.0068115790, 0.0011023685);

// Tree: 205 
wFDN_FLAP___lgt_205 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 5132.5) => 
   map(
   (NULL < c_low_ed and c_low_ed <= 77.35) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 12.55) => 0.0023570410,
      (c_hh6_p > 12.55) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 103) => 0.1896753398,
         (c_many_cars > 103) => -0.0132722903,
         (c_many_cars = NULL) => 0.0933612103, 0.0933612103),
      (c_hh6_p = NULL) => 0.0037173769, 0.0037173769),
   (c_low_ed > 77.35) => -0.0430267707,
   (c_low_ed = NULL) => -0.0051626182, 0.0021697851),
(f_liens_unrel_ST_total_amt_i > 5132.5) => 0.1316198002,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 3.45) => -0.0467258876,
   (c_pop_75_84_p > 3.45) => 0.0457976433,
   (c_pop_75_84_p = NULL) => 0.0013572072, 0.0013572072), 0.0027622694);

// Tree: 206 
wFDN_FLAP___lgt_206 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.6) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 6.95) => -0.0554723341,
      (c_pop_12_17_p > 6.95) => 0.0686420361,
      (c_pop_12_17_p = NULL) => 0.0005382535, 0.0005382535),
   (c_hval_20k_p > 0.6) => 0.1624973111,
   (c_hval_20k_p = NULL) => 0.0366725452, 0.0366725452),
(r_C10_M_Hdr_FS_d > 10.5) => 
   map(
   (NULL < f_liens_rel_OT_total_amt_i and f_liens_rel_OT_total_amt_i <= 1374) => -0.0046044523,
   (f_liens_rel_OT_total_amt_i > 1374) => -0.0855030300,
   (f_liens_rel_OT_total_amt_i = NULL) => -0.0055272748, -0.0055272748),
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 27.75) => -0.0593487485,
   (c_high_ed > 27.75) => 0.0466341006,
   (c_high_ed = NULL) => -0.0034818203, -0.0034818203), -0.0046536374);

// Tree: 207 
wFDN_FLAP___lgt_207 := map(
(NULL < f_srchfraudsrchcountyr_i and f_srchfraudsrchcountyr_i <= 3.5) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 2.5) => -0.0021367496,
   (r_D34_unrel_liens_ct_i > 2.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 12782.5) => 0.0962595936,
      (r_A49_Curr_AVM_Chg_1yr_i > 12782.5) => -0.0940883058,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0407982053, 0.0419957959),
   (r_D34_unrel_liens_ct_i = NULL) => -0.0005747267, -0.0005747267),
(f_srchfraudsrchcountyr_i > 3.5) => 
   map(
   (NULL < c_pop_25_34_p and c_pop_25_34_p <= 20.85) => 
      map(
      (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 41) => 0.0101573521,
      (f_prevaddrmurderindex_i > 41) => -0.0980840241,
      (f_prevaddrmurderindex_i = NULL) => -0.0712765804, -0.0712765804),
   (c_pop_25_34_p > 20.85) => 0.0569879256,
   (c_pop_25_34_p = NULL) => -0.0435564125, -0.0435564125),
(f_srchfraudsrchcountyr_i = NULL) => 0.0012072918, -0.0014963282);

// Tree: 208 
wFDN_FLAP___lgt_208 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 0.5) => -0.0024743268,
   (f_srchphonesrchcountmo_i > 0.5) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 9.85) => 0.1368984358,
      (c_hh3_p > 9.85) => 
         map(
         (NULL < f_idverrisktype_i and f_idverrisktype_i <= 1.5) => -0.0338076482,
         (f_idverrisktype_i > 1.5) => 
            map(
            (NULL < c_bargains and c_bargains <= 104.5) => 0.1367049464,
            (c_bargains > 104.5) => -0.0022641673,
            (c_bargains = NULL) => 0.0681990453, 0.0681990453),
         (f_idverrisktype_i = NULL) => 0.0124701489, 0.0124701489),
      (c_hh3_p = NULL) => 0.0349454154, 0.0349454154),
   (f_srchphonesrchcountmo_i = NULL) => -0.0013076778, -0.0013076778),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0814983737,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0009313150, -0.0016413618);

// Tree: 209 
wFDN_FLAP___lgt_209 := map(
(NULL < c_hh2_p and c_hh2_p <= 17.65) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.05821185275) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 25.45) => -0.0456390505,
      (c_famotf18_p > 25.45) => 0.1095226672,
      (c_famotf18_p = NULL) => -0.0079511914, -0.0079511914),
   (f_add_input_nhood_BUS_pct_i > 0.05821185275) => 
      map(
      (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.45) => -0.0156876993,
      (c_pop_75_84_p > 2.45) => 
         map(
         (NULL < C_INC_150K_P and C_INC_150K_P <= 4.55) => 0.0368117355,
         (C_INC_150K_P > 4.55) => 0.2112314738,
         (C_INC_150K_P = NULL) => 0.0952423479, 0.0952423479),
      (c_pop_75_84_p = NULL) => 0.0454307840, 0.0454307840),
   (f_add_input_nhood_BUS_pct_i = NULL) => 0.0178856847, 0.0178856847),
(c_hh2_p > 17.65) => 0.0003886466,
(c_hh2_p = NULL) => 0.0146886563, 0.0017903331);

// Tree: 210 
wFDN_FLAP___lgt_210 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 7.5) => -0.0002237134,
(f_srchfraudsrchcount_i > 7.5) => 
   map(
   (NULL < c_hval_100k_p and c_hval_100k_p <= 2.75) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.3525300516) => -0.0293515531,
      (f_add_curr_mobility_index_i > 0.3525300516) => 0.0765077011,
      (f_add_curr_mobility_index_i = NULL) => 0.0004061174, 0.0004061174),
   (c_hval_100k_p > 2.75) => 
      map(
      (NULL < c_hval_250k_p and c_hval_250k_p <= 11.75) => -0.0405101758,
      (c_hval_250k_p > 11.75) => -0.1474902701,
      (c_hval_250k_p = NULL) => -0.0686338088, -0.0686338088),
   (c_hval_100k_p = NULL) => -0.0321820716, -0.0321820716),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_born_usa and c_born_usa <= 85) => 0.0572179102,
   (c_born_usa > 85) => -0.0439477418,
   (c_born_usa = NULL) => 0.0074924203, 0.0074924203), -0.0011827937);

// Tree: 211 
wFDN_FLAP___lgt_211 := map(
(NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 14.5) => -0.0038701558,
(f_srchaddrsrchcount_i > 14.5) => 
   map(
   (NULL < c_robbery and c_robbery <= 167) => 
      map(
      (NULL < c_highrent and c_highrent <= 1.7) => 
         map(
         (NULL < c_retail and c_retail <= 10.75) => 0.0428450276,
         (c_retail > 10.75) => 0.1655638449,
         (c_retail = NULL) => 0.0935160231, 0.0935160231),
      (c_highrent > 1.7) => 
         map(
         (NULL < c_hval_400k_p and c_hval_400k_p <= 19.75) => -0.0393388180,
         (c_hval_400k_p > 19.75) => 0.0849235343,
         (c_hval_400k_p = NULL) => 0.0106039456, 0.0106039456),
      (c_highrent = NULL) => 0.0459099127, 0.0459099127),
   (c_robbery > 167) => -0.0663732413,
   (c_robbery = NULL) => 0.0311710739, 0.0311710739),
(f_srchaddrsrchcount_i = NULL) => -0.0045117338, -0.0027145130);

// Tree: 212 
wFDN_FLAP___lgt_212 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 18.5) => 
   map(
   (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0047953418) => -0.0355845168,
   (f_add_curr_nhood_BUS_pct_i > 0.0047953418) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 4.48) => 
         map(
         (NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 9.5) => 0.0025454653,
         (f_rel_ageover40_count_d > 9.5) => 0.0449388884,
         (f_rel_ageover40_count_d = NULL) => 0.0076414278, 0.0053587056),
      (c_hhsize > 4.48) => -0.1153863353,
      (c_hhsize = NULL) => -0.0004346205, 0.0047309770),
   (f_add_curr_nhood_BUS_pct_i = NULL) => -0.0156261958, -0.0004800006),
(f_srchfraudsrchcount_i > 18.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 14.2) => 0.0053393608,
   (c_pop_45_54_p > 14.2) => 0.1196938216,
   (c_pop_45_54_p = NULL) => 0.0579626525, 0.0579626525),
(f_srchfraudsrchcount_i = NULL) => 0.0007399659, 0.0000584951);

// Tree: 213 
wFDN_FLAP___lgt_213 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125511) => 
   map(
   (NULL < c_families and c_families <= 1369) => 
      map(
      (NULL < c_retired and c_retired <= 4.75) => 
         map(
         (NULL < c_food and c_food <= 25.75) => 
            map(
            (NULL < f_crim_rel_under25miles_cnt_i and f_crim_rel_under25miles_cnt_i <= 0.5) => 0.0719602616,
            (f_crim_rel_under25miles_cnt_i > 0.5) => 0.2442489298,
            (f_crim_rel_under25miles_cnt_i = NULL) => 0.1672092814, 0.1672092814),
         (c_food > 25.75) => -0.0445875315,
         (c_food = NULL) => 0.0864748527, 0.0864748527),
      (c_retired > 4.75) => 0.0089631785,
      (c_retired = NULL) => 0.0173856412, 0.0173856412),
   (c_families > 1369) => 0.1785464865,
   (c_families = NULL) => 0.0228302643, 0.0228302643),
(r_A46_Curr_AVM_AutoVal_d > 125511) => -0.0067859114,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0039891707, 0.0023979700);

// Tree: 214 
wFDN_FLAP___lgt_214 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 10.5) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 76.5) => 
      map(
      (NULL < c_oldhouse and c_oldhouse <= 65.75) => 0.0504639511,
      (c_oldhouse > 65.75) => 0.2682418728,
      (c_oldhouse = NULL) => 0.1503620803, 0.1503620803),
   (c_totcrime > 76.5) => -0.0092357713,
   (c_totcrime = NULL) => 0.0691253360, 0.0691253360),
(r_D32_Mos_Since_Crim_LS_d > 10.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 59128.5) => -0.0391694677,
   (r_L80_Inp_AVM_AutoVal_d > 59128.5) => 0.0054177047,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0050881989, 0.0034399248),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 
   map(
   (NULL < c_pop_65_74_p and c_pop_65_74_p <= 6.65) => 0.0393445911,
   (c_pop_65_74_p > 6.65) => -0.0663053487,
   (c_pop_65_74_p = NULL) => -0.0050461399, -0.0050461399), 0.0044983287);

// Tree: 215 
wFDN_FLAP___lgt_215 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 125594) => 
   map(
   (NULL < f_rel_homeover200_count_d and f_rel_homeover200_count_d <= 13.5) => 
      map(
      (NULL < c_assault and c_assault <= 74.5) => 
         map(
         (NULL < c_unemp and c_unemp <= 7.15) => 
            map(
            (NULL < c_transport and c_transport <= 8.95) => 0.0296115370,
            (c_transport > 8.95) => 0.1881925448,
            (c_transport = NULL) => 0.0409064806, 0.0409064806),
         (c_unemp > 7.15) => 0.1728581499,
         (c_unemp = NULL) => 0.0564887129, 0.0564887129),
      (c_assault > 74.5) => -0.0054466636,
      (c_assault = NULL) => 0.0206244944, 0.0206244944),
   (f_rel_homeover200_count_d > 13.5) => 0.1338776288,
   (f_rel_homeover200_count_d = NULL) => 0.0238602982, 0.0238602982),
(r_A46_Curr_AVM_AutoVal_d > 125594) => -0.0030893861,
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0027657366, 0.0012593781);

// Tree: 216 
wFDN_FLAP___lgt_216 := map(
(NULL < k_inq_adls_per_phone_i and k_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 184) => -0.0791695094,
   (f_mos_liens_unrel_FT_lseen_d > 184) => 
      map(
      (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 197.5) => 
         map(
         (NULL < c_popover18 and c_popover18 <= 1908.5) => -0.0044462691,
         (c_popover18 > 1908.5) => 
            map(
            (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 0.5) => 0.0195692946,
            (f_srchfraudsrchcountmo_i > 0.5) => 0.1131494693,
            (f_srchfraudsrchcountmo_i = NULL) => 0.0236096074, 0.0236096074),
         (c_popover18 = NULL) => 0.0284755074, 0.0015336221),
      (f_curraddrburglaryindex_i > 197.5) => 0.1125652463,
      (f_curraddrburglaryindex_i = NULL) => 0.0021847279, 0.0021847279),
   (f_mos_liens_unrel_FT_lseen_d = NULL) => 0.0006502318, 0.0012088232),
(k_inq_adls_per_phone_i > 2.5) => -0.0735940757,
(k_inq_adls_per_phone_i = NULL) => 0.0006073336, 0.0006073336);

// Tree: 217 
wFDN_FLAP___lgt_217 := map(
(NULL < C_INC_50K_P and C_INC_50K_P <= 13.55) => -0.0099145033,
(C_INC_50K_P > 13.55) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 3.5) => 0.0039244651,
   (k_inq_per_addr_i > 3.5) => 
      map(
      (NULL < C_OWNOCC_P and C_OWNOCC_P <= 79.75) => 
         map(
         (NULL < c_business and c_business <= 3.5) => 0.1139452730,
         (c_business > 3.5) => 
            map(
            (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 66.05) => -0.0165979226,
            (r_C12_source_profile_d > 66.05) => 0.0795878337,
            (r_C12_source_profile_d = NULL) => 0.0104901902, 0.0104901902),
         (c_business = NULL) => 0.0258939651, 0.0258939651),
      (C_OWNOCC_P > 79.75) => 0.2165405021,
      (C_OWNOCC_P = NULL) => 0.0494305746, 0.0494305746),
   (k_inq_per_addr_i = NULL) => 0.0091149628, 0.0091149628),
(C_INC_50K_P = NULL) => 0.0219019203, -0.0017549389);

// Tree: 218 
wFDN_FLAP___lgt_218 := map(
(NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 1.5) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 10.5) => 0.1676474622,
   (c_many_cars > 10.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 10.05) => -0.0023616645,
      (c_hh5_p > 10.05) => 
         map(
         (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 63.5) => 0.0106865655,
         (f_fp_prevaddrcrimeindex_i > 63.5) => 0.1994648801,
         (f_fp_prevaddrcrimeindex_i = NULL) => 0.1068908989, 0.1068908989),
      (c_hh5_p = NULL) => 0.0168313534, 0.0168313534),
   (c_many_cars = NULL) => 0.0593082036, 0.0374111943),
(f_rel_incomeover25_count_d > 1.5) => -0.0015968245,
(f_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < c_sfdu_p and c_sfdu_p <= 37.75) => -0.0810636425,
   (c_sfdu_p > 37.75) => 0.0187850650,
   (c_sfdu_p = NULL) => -0.0195289739, -0.0195289739), 0.0003631682);

// Tree: 219 
wFDN_FLAP___lgt_219 := map(
(NULL < c_femdiv_p and c_femdiv_p <= 15.45) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 12.5) => 
      map(
      (NULL < f_divrisktype_i and f_divrisktype_i <= 3.5) => 0.0019064910,
      (f_divrisktype_i > 3.5) => -0.0559375291,
      (f_divrisktype_i = NULL) => 0.0010028276, 0.0010028276),
   (r_L79_adls_per_addr_curr_i > 12.5) => 
      map(
      (NULL < f_sourcerisktype_i and f_sourcerisktype_i <= 5.5) => -0.0048471781,
      (f_sourcerisktype_i > 5.5) => 0.1313180942,
      (f_sourcerisktype_i = NULL) => 0.0663585147, 0.0663585147),
   (r_L79_adls_per_addr_curr_i = NULL) => 
      map(
      (NULL < c_finance and c_finance <= 2.55) => 0.0591510239,
      (c_finance > 2.55) => -0.0634374087,
      (c_finance = NULL) => -0.0021431924, -0.0021431924), 0.0015489036),
(c_femdiv_p > 15.45) => 0.1114514937,
(c_femdiv_p = NULL) => 0.0077789023, 0.0022948635);

// Tree: 220 
wFDN_FLAP___lgt_220 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 4.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 2.5) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 120.5) => -0.0646200244,
      (c_sub_bus > 120.5) => 0.0967422502,
      (c_sub_bus = NULL) => 0.0114942561, 0.0114942561),
   (r_C14_Addr_Stability_v2_d > 2.5) => -0.0733217755,
   (r_C14_Addr_Stability_v2_d = NULL) => -0.0495908651, -0.0495908651),
(f_mos_inq_banko_cm_lseen_d > 4.5) => 
   map(
   (NULL < c_food and c_food <= 62.1) => -0.0026506752,
   (c_food > 62.1) => 0.0472641539,
   (c_food = NULL) => -0.0248446787, -0.0010117352),
(f_mos_inq_banko_cm_lseen_d = NULL) => 
   map(
   (NULL < c_no_car and c_no_car <= 128.5) => -0.0307915907,
   (c_no_car > 128.5) => 0.0641494396,
   (c_no_car = NULL) => 0.0069247090, 0.0069247090), -0.0023842449);

// Tree: 221 
wFDN_FLAP___lgt_221 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 11.25) => 
   map(
   (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 19.5) => 0.1337936891,
   (f_mos_liens_unrel_CJ_fseen_d > 19.5) => 0.0058479811,
   (f_mos_liens_unrel_CJ_fseen_d = NULL) => -0.0090505346, 0.0064241625),
(C_INC_25K_P > 11.25) => 
   map(
   (NULL < C_OWNOCC_P and C_OWNOCC_P <= 11.95) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 959.5) => 0.1621548296,
      (c_pop00 > 959.5) => 0.0132917168,
      (c_pop00 = NULL) => 0.0350553298, 0.0350553298),
   (C_OWNOCC_P > 11.95) => 
      map(
      (NULL < f_inq_count_i and f_inq_count_i <= 5.5) => -0.0153306601,
      (f_inq_count_i > 5.5) => -0.0693420200,
      (f_inq_count_i = NULL) => -0.0231802601, -0.0231802601),
   (C_OWNOCC_P = NULL) => -0.0169582758, -0.0169582758),
(C_INC_25K_P = NULL) => -0.0073444353, 0.0002089415);

// Tree: 222 
wFDN_FLAP___lgt_222 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.85) => 
   map(
   (NULL < f_rel_homeover100_count_d and f_rel_homeover100_count_d <= 0.5) => -0.0460990844,
   (f_rel_homeover100_count_d > 0.5) => -0.0006029636,
   (f_rel_homeover100_count_d = NULL) => 
      map(
      (NULL < c_hh4_p and c_hh4_p <= 9.85) => -0.0474496219,
      (c_hh4_p > 9.85) => 
         map(
         (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0440962154,
         (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog']) => 
            map(
            (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01598914905) => 0.0302416132,
            (f_add_input_nhood_VAC_pct_i > 0.01598914905) => 0.1452012314,
            (f_add_input_nhood_VAC_pct_i = NULL) => 0.0914297970, 0.0914297970),
         (nf_seg_FraudPoint_3_0 = '') => 0.0448203219, 0.0448203219),
      (c_hh4_p = NULL) => 0.0036911974, 0.0036911974), -0.0022106336),
(c_hh6_p > 17.85) => -0.0914023036,
(c_hh6_p = NULL) => 0.0179265710, -0.0022882720);

// Tree: 223 
wFDN_FLAP___lgt_223 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44948.5) => -0.0530244271,
(r_A46_Curr_AVM_AutoVal_d > 44948.5) => 0.0026748700,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 76.5) => 
      map(
      (NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 10.5) => -0.0271593934,
      (f_mos_inq_banko_cm_lseen_d > 10.5) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.1235132921) => 0.0374120848,
         (f_add_input_nhood_BUS_pct_i > 0.1235132921) => 
            map(
            (NULL < c_bel_edu and c_bel_edu <= 73.5) => -0.0270243811,
            (c_bel_edu > 73.5) => 0.2203435965,
            (c_bel_edu = NULL) => 0.1228408900, 0.1228408900),
         (f_add_input_nhood_BUS_pct_i = NULL) => 0.0518433379, 0.0518433379),
      (f_mos_inq_banko_cm_lseen_d = NULL) => 0.0300609660, 0.0300609660),
   (f_mos_inq_banko_cm_fseen_d > 76.5) => -0.0059100520,
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0037148124, 0.0018316445), 0.0008389594);

// Tree: 224 
wFDN_FLAP___lgt_224 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 10.5) => 
   map(
   (NULL < c_hval_20k_p and c_hval_20k_p <= 0.65) => 
      map(
      (NULL < c_famotf18_p and c_famotf18_p <= 7.9) => -0.0499072626,
      (c_famotf18_p > 7.9) => 
         map(
         (NULL < c_young and c_young <= 31.9) => 0.1226528495,
         (c_young > 31.9) => -0.0168150589,
         (c_young = NULL) => 0.0592583457, 0.0592583457),
      (c_famotf18_p = NULL) => 0.0110481532, 0.0110481532),
   (c_hval_20k_p > 0.65) => 0.1749482503,
   (c_hval_20k_p = NULL) => 0.0452762859, 0.0452762859),
(r_C10_M_Hdr_FS_d > 10.5) => 0.0020335699,
(r_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < c_serv_empl and c_serv_empl <= 91.5) => -0.0264257005,
   (c_serv_empl > 91.5) => 0.0641616803,
   (c_serv_empl = NULL) => 0.0139199397, 0.0139199397), 0.0030325068);

// Tree: 225 
wFDN_FLAP___lgt_225 := map(
(NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 289973.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 75.5) => -0.0112440132,
      (r_P88_Phn_Dst_to_Inp_Add_i > 75.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 66500) => 0.1328287656,
         (k_estimated_income_d > 66500) => -0.0522712380,
         (k_estimated_income_d = NULL) => 0.0520578550, 0.0520578550),
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0264608918, 0.0001905511),
   (r_L80_Inp_AVM_AutoVal_d > 289973.5) => 0.0276289947,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0104581656, 0.0000412236),
(f_adls_per_phone_c6_i > 1.5) => 
   map(
   (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 240.5) => 0.2685160051,
   (f_M_Bureau_ADL_FS_noTU_d > 240.5) => 0.0201994930,
   (f_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0957109470, 0.0957109470),
(f_adls_per_phone_c6_i = NULL) => 0.0013308982, 0.0013308982);

// Tree: 226 
wFDN_FLAP___lgt_226 := map(
(NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 201.5) => -0.0827425707,
(r_D32_Mos_Since_Fel_LS_d > 201.5) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 181.5) => 
      map(
      (NULL < c_bargains and c_bargains <= 135.5) => -0.0048487637,
      (c_bargains > 135.5) => 
         map(
         (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 5.5) => 0.0163511227,
         (r_C14_addrs_5yr_i > 5.5) => 0.1467427911,
         (r_C14_addrs_5yr_i = NULL) => 0.0187574751, 0.0187574751),
      (c_bargains = NULL) => 0.0024141701, 0.0024141701),
   (c_asian_lang > 181.5) => -0.0297224334,
   (c_asian_lang = NULL) => 0.0091179495, -0.0020459424),
(r_D32_Mos_Since_Fel_LS_d = NULL) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 23.25) => -0.0725927370,
   (c_lowinc > 23.25) => 0.0271167810,
   (c_lowinc = NULL) => -0.0130762030, -0.0130762030), -0.0028067663);

// Tree: 227 
wFDN_FLAP___lgt_227 := map(
(NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= 27800) => 0.0009390843,
(f_addrchangeincomediff_d > 27800) => -0.0640975796,
(f_addrchangeincomediff_d = NULL) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 51500) => 
      map(
      (NULL < c_finance and c_finance <= 3.75) => 
         map(
         (NULL < c_rich_blk and c_rich_blk <= 122) => 0.0175551478,
         (c_rich_blk > 122) => 0.1358151327,
         (c_rich_blk = NULL) => 0.0510838028, 0.0510838028),
      (c_finance > 3.75) => -0.0418547731,
      (c_finance = NULL) => 0.0149063706, 0.0149063706),
   (r_A49_Curr_AVM_Chg_1yr_i > 51500) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 82.5) => 0.0154434466,
      (f_prevaddrageoldest_d > 82.5) => 0.2791932555,
      (f_prevaddrageoldest_d = NULL) => 0.1331888970, 0.1331888970),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0039435898, 0.0061614805), 0.0011681909);

// Tree: 228 
wFDN_FLAP___lgt_228 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 8.5) => -0.0006570571,
(f_assocsuspicousidcount_i > 8.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 284.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 186.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 121.5) => 
            map(
            (NULL < f_prevaddrlenofres_d and f_prevaddrlenofres_d <= 18.5) => 0.0540643048,
            (f_prevaddrlenofres_d > 18.5) => -0.0783756690,
            (f_prevaddrlenofres_d = NULL) => -0.0180926464, -0.0180926464),
         (r_C13_max_lres_d > 121.5) => 0.0917606705,
         (r_C13_max_lres_d = NULL) => 0.0212795601, 0.0212795601),
      (r_C13_max_lres_d > 186.5) => -0.0870655684,
      (r_C13_max_lres_d = NULL) => 0.0013315400, 0.0013315400),
   (r_C10_M_Hdr_FS_d > 284.5) => -0.1043659519,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0448574046, -0.0448574046),
(f_assocsuspicousidcount_i = NULL) => -0.0087512984, -0.0024632961);

// Tree: 229 
wFDN_FLAP___lgt_229 := map(
(NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
   map(
   (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 10656) => 
      map(
      (NULL < f_liens_unrel_CJ_total_amt_i and f_liens_unrel_CJ_total_amt_i <= 7982.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 159.5) => 0.0057916080,
         (r_pb_order_freq_d > 159.5) => -0.0325958905,
         (r_pb_order_freq_d = NULL) => 
            map(
            (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 5.5) => -0.0009728276,
            (f_rel_criminal_count_i > 5.5) => 0.0464789955,
            (f_rel_criminal_count_i = NULL) => 0.0037552652, 0.0037552652), -0.0017837400),
      (f_liens_unrel_CJ_total_amt_i > 7982.5) => 0.1405201955,
      (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0011605461, -0.0011605461),
   (f_liens_unrel_CJ_total_amt_i > 10656) => -0.0631739055,
   (f_liens_unrel_CJ_total_amt_i = NULL) => -0.0019952224, -0.0019952224),
(r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0626886324,
(r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0309146005, -0.0047272439);

// Tree: 230 
wFDN_FLAP___lgt_230 := map(
(NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 52.5) => 
   map(
   (NULL < f_inq_count24_i and f_inq_count24_i <= 14.5) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 197.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 16.5) => 
            map(
            (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.1012752165,
            (r_Phn_Cell_n > 0.5) => 0.0043372997,
            (r_Phn_Cell_n = NULL) => 0.0354071448, 0.0354071448),
         (r_C21_M_Bureau_ADL_FS_d > 16.5) => -0.0000718999,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0015002116, 0.0015002116),
      (f_fp_prevaddrcrimeindex_i > 197.5) => -0.0922251351,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0009557365, 0.0009557365),
   (f_inq_count24_i > 14.5) => -0.0886548321,
   (f_inq_count24_i = NULL) => -0.0124206051, 0.0001150971),
(f_bus_addr_match_count_d > 52.5) => 0.1416438320,
(f_bus_addr_match_count_d = NULL) => 0.0008737848, 0.0008737848);

// Tree: 231 
wFDN_FLAP___lgt_231 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 6.5) => -0.0012085857,
(f_srchvelocityrisktype_i > 6.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 37.5) => -0.0620720649,
   (f_mos_inq_banko_cm_fseen_d > 37.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 27.5) => 0.1422336963,
      (k_comb_age_d > 27.5) => 
         map(
         (NULL < c_pop00 and c_pop00 <= 1016.5) => 0.1566138374,
         (c_pop00 > 1016.5) => 
            map(
            (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 41) => 0.0747760617,
            (f_fp_prevaddrcrimeindex_i > 41) => -0.0319457638,
            (f_fp_prevaddrcrimeindex_i = NULL) => 0.0039060994, 0.0039060994),
         (c_pop00 = NULL) => 0.0288583442, 0.0288583442),
      (k_comb_age_d = NULL) => 0.0537038244, 0.0537038244),
   (f_mos_inq_banko_cm_fseen_d = NULL) => 0.0321144680, 0.0321144680),
(f_srchvelocityrisktype_i = NULL) => 0.0180868725, 0.0003152320);

// Tree: 232 
wFDN_FLAP___lgt_232 := map(
(NULL < f_mos_liens_unrel_FT_lseen_d and f_mos_liens_unrel_FT_lseen_d <= 39.5) => 0.1493824263,
(f_mos_liens_unrel_FT_lseen_d > 39.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_pop_35_44_p and c_pop_35_44_p <= 25.45) => 0.0104290369,
      (c_pop_35_44_p > 25.45) => 0.1142815991,
      (c_pop_35_44_p = NULL) => 0.0022562202, 0.0125120970),
   (f_phone_ver_experian_d > 0.5) => -0.0127041639,
   (f_phone_ver_experian_d = NULL) => 
      map(
      (NULL < c_no_move and c_no_move <= 167.5) => -0.0208265841,
      (c_no_move > 167.5) => 
         map(
         (NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 1.5) => -0.0092224567,
         (f_assocsuspicousidcount_i > 1.5) => 0.1159275871,
         (f_assocsuspicousidcount_i = NULL) => 0.0456378365, 0.0456378365),
      (c_no_move = NULL) => -0.0118378965, -0.0149118943), -0.0047559858),
(f_mos_liens_unrel_FT_lseen_d = NULL) => -0.0007993619, -0.0040352664);

// Tree: 233 
wFDN_FLAP___lgt_233 := map(
(NULL < c_hh6_p and c_hh6_p <= 17.45) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 0.0154404312,
      (r_C14_addrs_10yr_i > 0.5) => -0.0127377781,
      (r_C14_addrs_10yr_i = NULL) => -0.0174783689, -0.0060701918),
   (r_P85_Phn_Disconnected_i > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 9173) => 0.0695049970,
      (r_A49_Curr_AVM_Chg_1yr_i > 9173) => 0.2376589951,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
         (NULL < c_retired and c_retired <= 13.05) => -0.0727651882,
         (c_retired > 13.05) => 0.0852711321,
         (c_retired = NULL) => -0.0044934978, -0.0044934978), 0.0659815160),
   (r_P85_Phn_Disconnected_i = NULL) => -0.0046753791, -0.0046753791),
(c_hh6_p > 17.45) => -0.1177114064,
(c_hh6_p = NULL) => -0.0070069866, -0.0053136847);

// Tree: 234 
wFDN_FLAP___lgt_234 := map(
(NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 4.5) => 
   map(
   (NULL < f_util_add_curr_conv_n and f_util_add_curr_conv_n <= 0.5) => 
      map(
      (NULL < f_rel_educationover8_count_d and f_rel_educationover8_count_d <= 19.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 146.5) => -0.0322607166,
         (r_C13_max_lres_d > 146.5) => 0.0090547532,
         (r_C13_max_lres_d = NULL) => -0.0115289986, -0.0115289986),
      (f_rel_educationover8_count_d > 19.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 109.65) => -0.0878910527,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 109.65) => 0.0807840133,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0816250519, -0.0625105021),
      (f_rel_educationover8_count_d = NULL) => -0.0608091564, -0.0162144567),
   (f_util_add_curr_conv_n > 0.5) => 0.0059945018,
   (f_util_add_curr_conv_n = NULL) => -0.0038625031, -0.0038625031),
(f_rel_felony_count_i > 4.5) => 0.0641691006,
(f_rel_felony_count_i = NULL) => 0.0162131828, -0.0033036712);

// Tree: 235 
wFDN_FLAP___lgt_235 := map(
(NULL < f_hh_members_ct_d and f_hh_members_ct_d <= 1.5) => 
   map(
   (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0794253224) => 0.0095803102,
   (f_add_curr_nhood_VAC_pct_i > 0.0794253224) => 
      map(
      (NULL < c_unattach and c_unattach <= 101.5) => 0.0068137156,
      (c_unattach > 101.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 20.05) => 0.2529782182,
         (C_RENTOCC_P > 20.05) => 0.0773987000,
         (C_RENTOCC_P = NULL) => 0.1100795593, 0.1100795593),
      (c_unattach = NULL) => 0.0724629990, 0.0724629990),
   (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0202622264, 0.0202622264),
(f_hh_members_ct_d > 1.5) => -0.0062017869,
(f_hh_members_ct_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 15.55) => -0.0597561857,
   (c_pop_35_44_p > 15.55) => 0.0632075316,
   (c_pop_35_44_p = NULL) => -0.0023731176, -0.0023731176), -0.0008362607);

// Tree: 236 
wFDN_FLAP___lgt_236 := map(
(NULL < c_pop_45_54_p and c_pop_45_54_p <= 7.25) => 
   map(
   (NULL < f_corraddrphonecount_d and f_corraddrphonecount_d <= 2.5) => -0.0554229406,
   (f_corraddrphonecount_d > 2.5) => 0.1450374216,
   (f_corraddrphonecount_d = NULL) => -0.0413829152, -0.0413829152),
(c_pop_45_54_p > 7.25) => 
   map(
   (NULL < f_rel_felony_count_i and f_rel_felony_count_i <= 1.5) => 0.0004633727,
   (f_rel_felony_count_i > 1.5) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 3.5) => 
         map(
         (NULL < c_cartheft and c_cartheft <= 101) => 0.0286884567,
         (c_cartheft > 101) => 0.1575203965,
         (c_cartheft = NULL) => 0.0967506136, 0.0967506136),
      (f_corraddrnamecount_d > 3.5) => 0.0128282068,
      (f_corraddrnamecount_d = NULL) => 0.0288278023, 0.0288278023),
   (f_rel_felony_count_i = NULL) => 0.0005652410, 0.0018251721),
(c_pop_45_54_p = NULL) => 0.0108693327, -0.0006235789);

// Tree: 237 
wFDN_FLAP___lgt_237 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => -0.0068040428,
(r_L79_adls_per_addr_c6_i > 3.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
      map(
      (NULL < c_new_homes and c_new_homes <= 132.5) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 131.5) => 0.0461262230,
         (c_for_sale > 131.5) => 
            map(
            (NULL < c_highrent and c_highrent <= 8.05) => 0.2153521780,
            (c_highrent > 8.05) => 0.0552662405,
            (c_highrent = NULL) => 0.1527621874, 0.1527621874),
         (c_for_sale = NULL) => 0.0756118431, 0.0756118431),
      (c_new_homes > 132.5) => -0.0108097413,
      (c_new_homes = NULL) => 0.0438860246, 0.0438860246),
   (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0431420859,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0222989737, 0.0222989737),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0044065140, -0.0044065140);

// Tree: 238 
wFDN_FLAP___lgt_238 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0075543944,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 0.1089252239,
   (nf_vf_hi_risk_index > 5.5) => 
      map(
      (NULL < c_bel_edu and c_bel_edu <= 131.5) => 
         map(
         (NULL < r_I60_inq_retpymt_recency_d and r_I60_inq_retpymt_recency_d <= 61.5) => 0.2048622842,
         (r_I60_inq_retpymt_recency_d > 61.5) => 0.0380345671,
         (r_I60_inq_retpymt_recency_d = NULL) => 0.0555953794, 0.0555953794),
      (c_bel_edu > 131.5) => 
         map(
         (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 14.5) => 0.0919912027,
         (r_pb_order_freq_d > 14.5) => -0.1192307176,
         (r_pb_order_freq_d = NULL) => -0.0625173716, -0.0468537231),
      (c_bel_edu = NULL) => -0.0006108400, 0.0235157658),
   (nf_vf_hi_risk_index = NULL) => 0.0300406804, 0.0300406804),
(r_L70_Add_Standardized_i = NULL) => -0.0044632109, -0.0044632109);

// Tree: 239 
wFDN_FLAP___lgt_239 := map(
(NULL < c_business and c_business <= 441.5) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 7.5) => -0.0068787608,
   (f_phones_per_addr_curr_i > 7.5) => 
      map(
      (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.5881386515) => 
         map(
         (NULL < c_mort_indx and c_mort_indx <= 35.5) => 0.1301118161,
         (c_mort_indx > 35.5) => 0.0103178994,
         (c_mort_indx = NULL) => 0.0145622776, 0.0145622776),
      (f_add_input_mobility_index_i > 0.5881386515) => 0.1240401265,
      (f_add_input_mobility_index_i = NULL) => 0.0191745685, 0.0191745685),
   (f_phones_per_addr_curr_i = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 9.35) => 0.0784171428,
      (c_rnt1000_p > 9.35) => -0.0349994783,
      (c_rnt1000_p = NULL) => 0.0141179560, 0.0141179560), -0.0029744236),
(c_business > 441.5) => -0.0740409414,
(c_business = NULL) => 0.0158792094, -0.0043540039);

// Tree: 240 
wFDN_FLAP___lgt_240 := map(
(NULL < c_hval_100k_p and c_hval_100k_p <= 6.95) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 49.85) => 
      map(
      (NULL < f_inq_HighRiskCredit_count24_i and f_inq_HighRiskCredit_count24_i <= 7.5) => 
         map(
         (NULL < c_robbery and c_robbery <= 13) => -0.0436114302,
         (c_robbery > 13) => 0.0129642136,
         (c_robbery = NULL) => 0.0072652136, 0.0072652136),
      (f_inq_HighRiskCredit_count24_i > 7.5) => 0.0835317788,
      (f_inq_HighRiskCredit_count24_i = NULL) => 0.0158141952, 0.0078028014),
   (c_famotf18_p > 49.85) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 151) => 0.1515564263,
      (f_fp_prevaddrburglaryindex_i > 151) => -0.0122429499,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0784317048, 0.0784317048),
   (c_famotf18_p = NULL) => 0.0087137436, 0.0087137436),
(c_hval_100k_p > 6.95) => -0.0152025342,
(c_hval_100k_p = NULL) => -0.0263534057, 0.0017885316);

// Tree: 241 
wFDN_FLAP___lgt_241 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 67.5) => -0.0015666729,
(k_comb_age_d > 67.5) => 
   map(
   (NULL < C_INC_25K_P and C_INC_25K_P <= 10.35) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 24.05) => -0.0028439481,
      (c_hh3_p > 24.05) => 0.1423248317,
      (c_hh3_p = NULL) => 0.0142205939, 0.0142205939),
   (C_INC_25K_P > 10.35) => 
      map(
      (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 0.5) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 149.5) => 0.1294879033,
         (c_for_sale > 149.5) => -0.0729117714,
         (c_for_sale = NULL) => 0.0639380087, 0.0639380087),
      (k_inq_per_addr_i > 0.5) => 0.1624465968,
      (k_inq_per_addr_i = NULL) => 0.0957638602, 0.0957638602),
   (C_INC_25K_P = NULL) => 0.0387590768, 0.0387590768),
(k_comb_age_d = NULL) => -0.0027600542, 0.0012401071);

// Tree: 242 
wFDN_FLAP___lgt_242 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0092965533,
(f_srchfraudsrchcount_i > 0.5) => 
   map(
   (NULL < c_incollege and c_incollege <= 8.45) => 0.0012234615,
   (c_incollege > 8.45) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.5670107541) => 
         map(
         (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 9) => 0.1304409299,
         (r_I60_inq_comm_recency_d > 9) => 0.0259306361,
         (r_I60_inq_comm_recency_d = NULL) => 0.0298497721, 0.0298497721),
      (f_add_curr_mobility_index_i > 0.5670107541) => 0.1795160344,
      (f_add_curr_mobility_index_i = NULL) => 0.0397784922, 0.0397784922),
   (c_incollege = NULL) => 0.0401995334, 0.0113008916),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_professional and c_professional <= 6.5) => -0.0234864889,
   (c_professional > 6.5) => 0.0842727097,
   (c_professional = NULL) => 0.0241945724, 0.0241945724), 0.0016788952);

// Tree: 243 
wFDN_FLAP___lgt_243 := map(
(NULL < c_info and c_info <= 27.85) => 
   map(
   (NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
      map(
      (NULL < r_C16_Inv_SSN_Per_ADL_i and r_C16_Inv_SSN_Per_ADL_i <= 0.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 17.5) => 
            map(
            (NULL < c_med_rent and c_med_rent <= 1084) => 0.0103984980,
            (c_med_rent > 1084) => 0.2197027883,
            (c_med_rent = NULL) => 0.0730644531, 0.0730644531),
         (r_C13_max_lres_d > 17.5) => 0.0058916294,
         (r_C13_max_lres_d = NULL) => 0.0068675199, 0.0068675199),
      (r_C16_Inv_SSN_Per_ADL_i > 0.5) => -0.0498778343,
      (r_C16_Inv_SSN_Per_ADL_i = NULL) => -0.0052310164, 0.0044268553),
   (r_L77_Add_PO_Box_i > 0.5) => -0.1014886868,
   (r_L77_Add_PO_Box_i = NULL) => 0.0025534607, 0.0025534607),
(c_info > 27.85) => 0.1509068359,
(c_info = NULL) => 0.0192137516, 0.0036595690);

// Tree: 244 
wFDN_FLAP___lgt_244 := map(
(NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 26.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 54.5) => -0.0149629475,
   (f_prevaddrageoldest_d > 54.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0102124384,
      (f_corrrisktype_i > 6.5) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 42.5) => 0.0619879854,
         (c_born_usa > 42.5) => 0.0110136640,
         (c_born_usa = NULL) => 0.0089344858, 0.0236742947),
      (f_corrrisktype_i = NULL) => 0.0029519052, 0.0029519052),
   (f_prevaddrageoldest_d = NULL) => -0.0049810820, -0.0049810820),
(f_rel_homeover300_count_d > 26.5) => -0.0818223616,
(f_rel_homeover300_count_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0426904449,
   (r_Phn_Cell_n > 0.5) => -0.0412878845,
   (r_Phn_Cell_n = NULL) => -0.0031763471, -0.0031763471), -0.0054784065);

// Tree: 245 
wFDN_FLAP___lgt_245 := map(
(NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 47829) => 
   map(
   (NULL < C_INC_75K_P and C_INC_75K_P <= 27.85) => 0.0136935282,
   (C_INC_75K_P > 27.85) => 0.1283676680,
   (C_INC_75K_P = NULL) => -0.0153276436, 0.0148603700),
(f_curraddrmedianincome_d > 47829) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 46.3) => 
      map(
      (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 6.5) => -0.0818978814,
      (f_mos_inq_banko_om_fseen_d > 6.5) => 
         map(
         (NULL < C_RENTOCC_P and C_RENTOCC_P <= 70.55) => -0.0009748269,
         (C_RENTOCC_P > 70.55) => -0.0752823901,
         (C_RENTOCC_P = NULL) => -0.0041150678, -0.0041150678),
      (f_mos_inq_banko_om_fseen_d = NULL) => -0.0074178192, -0.0074178192),
   (c_famotf18_p > 46.3) => 0.1069342050,
   (c_famotf18_p = NULL) => -0.0067874332, -0.0067874332),
(f_curraddrmedianincome_d = NULL) => -0.0064472898, -0.0009078079);

// Tree: 246 
wFDN_FLAP___lgt_246 := map(
(NULL < c_hhsize and c_hhsize <= 4.385) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 3.35) => -0.0957699211,
   (c_pop_45_54_p > 3.35) => 
      map(
      (NULL < c_hval_40k_p and c_hval_40k_p <= 21.95) => -0.0001462838,
      (c_hval_40k_p > 21.95) => 
         map(
         (NULL < c_low_hval and c_low_hval <= 69.25) => 
            map(
            (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.0255698397,
            (r_L79_adls_per_addr_c6_i > 0.5) => 0.1514252503,
            (r_L79_adls_per_addr_c6_i = NULL) => 0.0962751265, 0.0962751265),
         (c_low_hval > 69.25) => -0.0545399480,
         (c_low_hval = NULL) => 0.0577825761, 0.0577825761),
      (c_hval_40k_p = NULL) => 0.0009968917, 0.0009968917),
   (c_pop_45_54_p = NULL) => -0.0003736761, -0.0003736761),
(c_hhsize > 4.385) => 0.0869673923,
(c_hhsize = NULL) => -0.0272534474, -0.0004559101);

// Tree: 247 
wFDN_FLAP___lgt_247 := map(
(NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 21.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 3.5) => 
      map(
      (NULL < nf_vf_hi_risk_index and nf_vf_hi_risk_index <= 5.5) => 
         map(
         (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
            map(
            (NULL < f_crim_rel_under500miles_cnt_i and f_crim_rel_under500miles_cnt_i <= 3.5) => 0.0274545538,
            (f_crim_rel_under500miles_cnt_i > 3.5) => -0.0464655413,
            (f_crim_rel_under500miles_cnt_i = NULL) => 0.0078388861, 0.0078388861),
         (r_Phn_Cell_n > 0.5) => -0.0591697985,
         (r_Phn_Cell_n = NULL) => -0.0319521430, -0.0319521430),
      (nf_vf_hi_risk_index > 5.5) => -0.0005608709,
      (nf_vf_hi_risk_index = NULL) => -0.0028527956, -0.0028527956),
   (r_D33_eviction_count_i > 3.5) => 0.0700231585,
   (r_D33_eviction_count_i = NULL) => -0.0024323910, -0.0024323910),
(f_inq_HighRiskCredit_count_i > 21.5) => -0.0795670716,
(f_inq_HighRiskCredit_count_i = NULL) => -0.0062000885, -0.0027879548);

// Tree: 248 
wFDN_FLAP___lgt_248 := map(
(NULL < f_rel_under100miles_cnt_d and f_rel_under100miles_cnt_d <= 11.5) => 0.0012841095,
(f_rel_under100miles_cnt_d > 11.5) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 67.75) => 
      map(
      (NULL < c_pop_0_5_p and c_pop_0_5_p <= 12.45) => 
         map(
         (NULL < f_mos_inq_banko_om_fseen_d and f_mos_inq_banko_om_fseen_d <= 16.5) => -0.0928700924,
         (f_mos_inq_banko_om_fseen_d > 16.5) => -0.0253731224,
         (f_mos_inq_banko_om_fseen_d = NULL) => -0.0314155052, -0.0314155052),
      (c_pop_0_5_p > 12.45) => 
         map(
         (NULL < c_hval_250k_p and c_hval_250k_p <= 20.15) => 0.0144276427,
         (c_hval_250k_p > 20.15) => 0.1608397368,
         (c_hval_250k_p = NULL) => 0.0403872338, 0.0403872338),
      (c_pop_0_5_p = NULL) => -0.0221315197, -0.0221315197),
   (c_lowinc > 67.75) => -0.1300748296,
   (c_lowinc = NULL) => -0.0246452018, -0.0246452018),
(f_rel_under100miles_cnt_d = NULL) => 0.0070333251, -0.0031851126);

// Tree: 249 
wFDN_FLAP___lgt_249 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 7.5) => 
   map(
   (NULL < f_inq_HighRiskCredit_count_i and f_inq_HighRiskCredit_count_i <= 16.5) => 
      map(
      (NULL < c_born_usa and c_born_usa <= 156.5) => -0.0025776219,
      (c_born_usa > 156.5) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 52.05) => 0.0848752428,
         (c_civ_emp > 52.05) => 0.0059515279,
         (c_civ_emp = NULL) => 0.0247787500, 0.0247787500),
      (c_born_usa = NULL) => 0.0156996266, 0.0013085041),
   (f_inq_HighRiskCredit_count_i > 16.5) => 0.0623561032,
   (f_inq_HighRiskCredit_count_i = NULL) => 0.0016354917, 0.0016354917),
(r_I60_Inq_Count12_i > 7.5) => -0.0563824290,
(r_I60_Inq_Count12_i = NULL) => 
   map(
   (NULL < c_rnt500_p and c_rnt500_p <= 8) => 0.0355012336,
   (c_rnt500_p > 8) => -0.0604868920,
   (c_rnt500_p = NULL) => -0.0033024767, -0.0033024767), 0.0006656602);

// Tree: 250 
wFDN_FLAP___lgt_250 := map(
(NULL < f_M_Bureau_ADL_FS_all_d and f_M_Bureau_ADL_FS_all_d <= 10.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 193658.5) => 0.1364328762,
   (r_A46_Curr_AVM_AutoVal_d > 193658.5) => -0.0215048292,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0283636691, 0.0413252146),
(f_M_Bureau_ADL_FS_all_d > 10.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 11.5) => 
         map(
         (NULL < c_for_sale and c_for_sale <= 101.5) => 0.0194757573,
         (c_for_sale > 101.5) => 0.1568183263,
         (c_for_sale = NULL) => 0.0925933839, 0.0925933839),
      (f_rel_under25miles_cnt_d > 11.5) => -0.0590925586,
      (f_rel_under25miles_cnt_d = NULL) => 0.0444978412, 0.0444978412),
   (r_I60_inq_hiRiskCred_recency_d > 9) => -0.0028031274,
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0020023995, -0.0020023995),
(f_M_Bureau_ADL_FS_all_d = NULL) => 0.0172645481, -0.0007449291);

// Tree: 251 
wFDN_FLAP___lgt_251 := map(
(NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 
   map(
   (NULL < C_INC_125K_P and C_INC_125K_P <= 1.85) => -0.0375657260,
   (C_INC_125K_P > 1.85) => 0.0060051397,
   (C_INC_125K_P = NULL) => -0.0249726135, 0.0035116243),
(f_inq_Other_count24_i > 3.5) => 
   map(
   (NULL < c_pop_45_54_p and c_pop_45_54_p <= 12.55) => -0.0280296281,
   (c_pop_45_54_p > 12.55) => 
      map(
      (NULL < c_blue_col and c_blue_col <= 12.05) => 0.0434529805,
      (c_blue_col > 12.05) => 0.1854301041,
      (c_blue_col = NULL) => 0.1090562031, 0.1090562031),
   (c_pop_45_54_p = NULL) => 0.0603145743, 0.0603145743),
(f_inq_Other_count24_i = NULL) => 
   map(
   (NULL < c_many_cars and c_many_cars <= 91) => 0.0216384807,
   (c_many_cars > 91) => -0.0814838109,
   (c_many_cars = NULL) => -0.0250120798, -0.0250120798), 0.0041930778);

// Tree: 252 
wFDN_FLAP___lgt_252 := map(
(NULL < f_phone_ver_insurance_d and f_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 119.5) => 0.0928991048,
   (r_D32_Mos_Since_Fel_LS_d > 119.5) => 
      map(
      (NULL < f_mos_liens_unrel_CJ_fseen_d and f_mos_liens_unrel_CJ_fseen_d <= 118.5) => -0.0445879246,
      (f_mos_liens_unrel_CJ_fseen_d > 118.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 32.5) => -0.0011768682,
         (k_comb_age_d > 32.5) => 
            map(
            (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 12.5) => 0.0257812474,
            (f_srchaddrsrchcount_i > 12.5) => 0.0959677274,
            (f_srchaddrsrchcount_i = NULL) => 0.0278094357, 0.0278094357),
         (k_comb_age_d = NULL) => 0.0169131944, 0.0169131944),
      (f_mos_liens_unrel_CJ_fseen_d = NULL) => 0.0143981700, 0.0143981700),
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0150276587, 0.0150276587),
(f_phone_ver_insurance_d > 3.5) => -0.0107629579,
(f_phone_ver_insurance_d = NULL) => -0.0136142131, 0.0021319669);

// Tree: 253 
wFDN_FLAP___lgt_253 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 7.5) => -0.0001972908,
(r_D30_Derog_Count_i > 7.5) => 
   map(
   (NULL < c_rental and c_rental <= 114) => 
      map(
      (NULL < c_construction and c_construction <= 3.4) => -0.0639793891,
      (c_construction > 3.4) => 
         map(
         (NULL < c_food and c_food <= 19.2) => -0.0087178379,
         (c_food > 19.2) => 0.1364129155,
         (c_food = NULL) => 0.0512535478, 0.0512535478),
      (c_construction = NULL) => 0.0086413680, 0.0086413680),
   (c_rental > 114) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => -0.0247823895,
      (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.1462017945,
      (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0868877173, -0.0868877173),
   (c_rental = NULL) => -0.0367740988, -0.0367740988),
(r_D30_Derog_Count_i = NULL) => -0.0131858854, -0.0014251203);

// Tree: 254 
wFDN_FLAP___lgt_254 := map(
(NULL < c_unemp and c_unemp <= 13.75) => 
   map(
   (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < f_liens_unrel_FT_total_amt_i and f_liens_unrel_FT_total_amt_i <= 29586) => -0.0020583393,
      (f_liens_unrel_FT_total_amt_i > 29586) => -0.0973025581,
      (f_liens_unrel_FT_total_amt_i = NULL) => -0.0282709873, -0.0028375990),
   (k_nap_contradictory_i > 0.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 3.05) => -0.0372847919,
      (c_hh5_p > 3.05) => 
         map(
         (NULL < c_born_usa and c_born_usa <= 58.5) => 0.1641706300,
         (c_born_usa > 58.5) => 0.0316559063,
         (c_born_usa = NULL) => 0.0890789532, 0.0890789532),
      (c_hh5_p = NULL) => 0.0421060428, 0.0421060428),
   (k_nap_contradictory_i = NULL) => -0.0021386709, -0.0021386709),
(c_unemp > 13.75) => -0.0681187220,
(c_unemp = NULL) => 0.0392509090, -0.0016616975);

// Tree: 255 
wFDN_FLAP___lgt_255 := map(
(NULL < f_vf_AltLexID_addr_hi_risk_ct_i and f_vf_AltLexID_addr_hi_risk_ct_i <= 0.5) => 
   map(
   (NULL < k_inq_per_addr_i and k_inq_per_addr_i <= 6.5) => 0.0012998443,
   (k_inq_per_addr_i > 6.5) => 
      map(
      (NULL < c_families and c_families <= 700.5) => 
         map(
         (NULL < c_hval_175k_p and c_hval_175k_p <= 12.35) => 
            map(
            (NULL < c_child and c_child <= 24.45) => -0.0264685163,
            (c_child > 24.45) => 0.0945148335,
            (c_child = NULL) => 0.0366305584, 0.0366305584),
         (c_hval_175k_p > 12.35) => 0.1316173059,
         (c_hval_175k_p = NULL) => 0.0579152142, 0.0579152142),
      (c_families > 700.5) => -0.0518154896,
      (c_families = NULL) => 0.0380734979, 0.0380734979),
   (k_inq_per_addr_i = NULL) => 0.0024330468, 0.0024330468),
(f_vf_AltLexID_addr_hi_risk_ct_i > 0.5) => -0.0291614785,
(f_vf_AltLexID_addr_hi_risk_ct_i = NULL) => -0.0047337541, 0.0009136803);

// Tree: 256 
wFDN_FLAP___lgt_256 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 82.5) => -0.0214837273,
(r_C13_max_lres_d > 82.5) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 22.05) => 
      map(
      (NULL < f_vf_LexID_addr_hi_risk_ct_i and f_vf_LexID_addr_hi_risk_ct_i <= 0.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 4950) => -0.0221594204,
         (r_A49_Curr_AVM_Chg_1yr_i > 4950) => 0.0165747919,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0153507237, 0.0062429457),
      (f_vf_LexID_addr_hi_risk_ct_i > 0.5) => -0.0770012716,
      (f_vf_LexID_addr_hi_risk_ct_i = NULL) => 0.0054182537, 0.0054182537),
   (c_pop_35_44_p > 22.05) => 
      map(
      (NULL < c_retired2 and c_retired2 <= 136.5) => 0.0411986902,
      (c_retired2 > 136.5) => 0.2700053368,
      (c_retired2 = NULL) => 0.0613217503, 0.0613217503),
   (c_pop_35_44_p = NULL) => -0.0439766774, 0.0080777142),
(r_C13_max_lres_d = NULL) => 0.0158174741, 0.0003874476);

// Tree: 257 
wFDN_FLAP___lgt_257 := map(
(NULL < f_inq_PrepaidCards_count_i and f_inq_PrepaidCards_count_i <= 2.5) => 
   map(
   (NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 804) => 
      map(
      (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => -0.0024224567,
      (f_adls_per_phone_c6_i > 1.5) => 
         map(
         (NULL < c_pop_18_24_p and c_pop_18_24_p <= 9.25) => -0.0306246198,
         (c_pop_18_24_p > 9.25) => 0.2344504737,
         (c_pop_18_24_p = NULL) => 0.0733263973, 0.0733263973),
      (f_adls_per_phone_c6_i = NULL) => -0.0014770636, -0.0014770636),
   (f_liens_unrel_O_total_amt_i > 804) => -0.0731028275,
   (f_liens_unrel_O_total_amt_i = NULL) => -0.0027397984, -0.0027397984),
(f_inq_PrepaidCards_count_i > 2.5) => 0.0848440199,
(f_inq_PrepaidCards_count_i = NULL) => 
   map(
   (NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => 0.0678094830,
   (k_nap_lname_verd_d > 0.5) => -0.0280776598,
   (k_nap_lname_verd_d = NULL) => 0.0229791305, 0.0229791305), -0.0020685274);

// Tree: 258 
wFDN_FLAP___lgt_258 := map(
(NULL < C_INC_25K_P and C_INC_25K_P <= 27.05) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 4.5) => 
      map(
      (NULL < c_pop_12_17_p and c_pop_12_17_p <= 13.75) => -0.0022661747,
      (c_pop_12_17_p > 13.75) => -0.0428798618,
      (c_pop_12_17_p = NULL) => -0.0039557524, -0.0039557524),
   (f_inq_Other_count24_i > 4.5) => 0.0777193962,
   (f_inq_Other_count24_i = NULL) => 
      map(
      (NULL < C_INC_125K_P and C_INC_125K_P <= 8.95) => -0.0436575598,
      (C_INC_125K_P > 8.95) => 0.0615475383,
      (C_INC_125K_P = NULL) => 0.0089449892, 0.0089449892), -0.0031528141),
(C_INC_25K_P > 27.05) => 0.0811942184,
(C_INC_25K_P = NULL) => 
   map(
   (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.19384492965) => 0.1542694813,
   (f_add_curr_mobility_index_i > 0.19384492965) => -0.1009085472,
   (f_add_curr_mobility_index_i = NULL) => 0.0407532367, 0.0068235735), -0.0023478881);

// Tree: 259 
wFDN_FLAP___lgt_259 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
   map(
   (NULL < r_pb_order_freq_d and r_pb_order_freq_d <= 599.5) => -0.0144224735,
   (r_pb_order_freq_d > 599.5) => -0.0654943649,
   (r_pb_order_freq_d = NULL) => 
      map(
      (NULL < c_cpiall and c_cpiall <= 208.9) => 
         map(
         (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 1.5) => 0.0334861016,
         (r_D32_criminal_count_i > 1.5) => 0.1631656069,
         (r_D32_criminal_count_i = NULL) => 0.0457621305, 0.0457621305),
      (c_cpiall > 208.9) => -0.0003921281,
      (c_cpiall = NULL) => -0.0193755433, 0.0047709860), -0.0083317327),
(r_D33_eviction_count_i > 4.5) => -0.0720192523,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_hval_125k_p and c_hval_125k_p <= 0.1) => -0.0714393004,
   (c_hval_125k_p > 0.1) => 0.0416199986,
   (c_hval_125k_p = NULL) => -0.0002830983, -0.0002830983), -0.0085100473);

// Tree: 260 
wFDN_FLAP___lgt_260 := map(
(NULL < C_INC_150K_P and C_INC_150K_P <= 0.55) => 
   map(
   (NULL < c_low_hval and c_low_hval <= 10.55) => 
      map(
      (NULL < c_finance and c_finance <= 4.05) => 
         map(
         (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0226771654) => 0.0759487961,
         (f_add_input_nhood_BUS_pct_i > 0.0226771654) => -0.0615781048,
         (f_add_input_nhood_BUS_pct_i = NULL) => -0.0245056358, -0.0245056358),
      (c_finance > 4.05) => 0.1129322953,
      (c_finance = NULL) => 0.0113665286, 0.0113665286),
   (c_low_hval > 10.55) => -0.0661361557,
   (c_low_hval = NULL) => -0.0296777924, -0.0296777924),
(C_INC_150K_P > 0.55) => 
   map(
   (NULL < f_inq_Communications_count24_i and f_inq_Communications_count24_i <= 1.5) => 0.0029876643,
   (f_inq_Communications_count24_i > 1.5) => 0.0444049604,
   (f_inq_Communications_count24_i = NULL) => -0.0000378871, 0.0037657193),
(C_INC_150K_P = NULL) => -0.0100302854, 0.0016615465);

// Tree: 261 
wFDN_FLAP___lgt_261 := map(
(NULL < c_business and c_business <= 243.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 11.5) => 
      map(
      (NULL < c_families and c_families <= 480) => 0.0121903118,
      (c_families > 480) => 0.1445036953,
      (c_families = NULL) => 0.0533773572, 0.0533773572),
   (r_C10_M_Hdr_FS_d > 11.5) => 
      map(
      (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 9.5) => 
         map(
         (NULL < f_rel_homeover150_count_d and f_rel_homeover150_count_d <= 25.5) => 0.0072621683,
         (f_rel_homeover150_count_d > 25.5) => 0.1690542933,
         (f_rel_homeover150_count_d = NULL) => 0.0080672645, 0.0080672645),
      (f_rel_homeover300_count_d > 9.5) => -0.0243204328,
      (f_rel_homeover300_count_d = NULL) => -0.0830145643, 0.0041202247),
   (r_C10_M_Hdr_FS_d = NULL) => -0.0021733465, 0.0051557516),
(c_business > 243.5) => -0.0421837921,
(c_business = NULL) => 0.0045771272, 0.0019221406);

// Tree: 262 
wFDN_FLAP___lgt_262 := map(
(NULL < f_srchaddrsrchcountwk_i and f_srchaddrsrchcountwk_i <= 1.5) => 
   map(
   (NULL < c_lowinc and c_lowinc <= 76.3) => 
      map(
      (NULL < f_fp_prevaddrburglaryindex_i and f_fp_prevaddrburglaryindex_i <= 146.5) => 
         map(
         (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 30) => 0.0684664568,
         (r_D33_Eviction_Recency_d > 30) => 0.0076719349,
         (r_D33_Eviction_Recency_d = NULL) => 0.0082079674, 0.0082079674),
      (f_fp_prevaddrburglaryindex_i > 146.5) => -0.0223317064,
      (f_fp_prevaddrburglaryindex_i = NULL) => 0.0031554757, 0.0031554757),
   (c_lowinc > 76.3) => 
      map(
      (NULL < f_curraddrcrimeindex_i and f_curraddrcrimeindex_i <= 160.5) => -0.0201148681,
      (f_curraddrcrimeindex_i > 160.5) => 0.1460230568,
      (f_curraddrcrimeindex_i = NULL) => 0.0680999593, 0.0680999593),
   (c_lowinc = NULL) => -0.0073561322, 0.0035266238),
(f_srchaddrsrchcountwk_i > 1.5) => -0.0847804005,
(f_srchaddrsrchcountwk_i = NULL) => -0.0113342491, 0.0029342384);

// Tree: 263 
wFDN_FLAP___lgt_263 := map(
(NULL < c_hval_500k_p and c_hval_500k_p <= 49.95) => 
   map(
   (NULL < f_assoccredbureaucount_i and f_assoccredbureaucount_i <= 3.5) => 0.0007551569,
   (f_assoccredbureaucount_i > 3.5) => 
      map(
      (NULL < c_preschl and c_preschl <= 147.5) => 
         map(
         (NULL < c_bel_edu and c_bel_edu <= 31.5) => 0.2210391357,
         (c_bel_edu > 31.5) => 
            map(
            (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 320) => 0.0728984205,
            (r_C10_M_Hdr_FS_d > 320) => -0.0451354816,
            (r_C10_M_Hdr_FS_d = NULL) => 0.0377121624, 0.0377121624),
         (c_bel_edu = NULL) => 0.0614927839, 0.0614927839),
      (c_preschl > 147.5) => -0.0233948676,
      (c_preschl = NULL) => 0.0343777877, 0.0343777877),
   (f_assoccredbureaucount_i = NULL) => 0.0064088680, 0.0025163291),
(c_hval_500k_p > 49.95) => 0.1028349677,
(c_hval_500k_p = NULL) => -0.0032831919, 0.0031578559);

// Tree: 264 
wFDN_FLAP___lgt_264 := map(
(NULL < nf_vf_hi_addr_add_entries and nf_vf_hi_addr_add_entries <= 2.5) => 
   map(
   (NULL < f_addrchangeincomediff_d and f_addrchangeincomediff_d <= -31659) => -0.0569624565,
   (f_addrchangeincomediff_d > -31659) => 0.0039435525,
   (f_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < c_easiqlife and c_easiqlife <= 151.5) => -0.0031564067,
      (c_easiqlife > 151.5) => 
         map(
         (NULL < c_rich_wht and c_rich_wht <= 181) => 0.0544041851,
         (c_rich_wht > 181) => 0.2464143994,
         (c_rich_wht = NULL) => 0.0835575684, 0.0835575684),
      (c_easiqlife = NULL) => 0.0049682337, 0.0093956042), 0.0044276668),
(nf_vf_hi_addr_add_entries > 2.5) => 0.0990319585,
(nf_vf_hi_addr_add_entries = NULL) => 
   map(
   (NULL < c_totcrime and c_totcrime <= 117.5) => -0.0550937216,
   (c_totcrime > 117.5) => 0.0476854685,
   (c_totcrime = NULL) => -0.0147726547, -0.0147726547), 0.0045868136);

// Tree: 265 
wFDN_FLAP___lgt_265 := map(
(NULL < f_inq_Other_count_i and f_inq_Other_count_i <= 6.5) => 
   map(
   (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 37.5) => 0.0556383955,
      (c_exp_prod > 37.5) => 0.0076584416,
      (c_exp_prod = NULL) => 0.0136294161, 0.0122752985),
   (f_phone_ver_experian_d > 0.5) => -0.0056286074,
   (f_phone_ver_experian_d = NULL) => -0.0089906927, -0.0003375839),
(f_inq_Other_count_i > 6.5) => 
   map(
   (NULL < r_A50_pb_average_dollars_d and r_A50_pb_average_dollars_d <= 65) => 0.1710105846,
   (r_A50_pb_average_dollars_d > 65) => -0.0313072738,
   (r_A50_pb_average_dollars_d = NULL) => 0.0669052788, 0.0669052788),
(f_inq_Other_count_i = NULL) => 
   map(
   (NULL < c_bigapt_p and c_bigapt_p <= 0.45) => 0.0733833940,
   (c_bigapt_p > 0.45) => -0.0295845504,
   (c_bigapt_p = NULL) => 0.0186816735, 0.0186816735), 0.0004288209);

// Tree: 266 
wFDN_FLAP___lgt_266 := map(
(NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => -0.0046751323,
(r_L70_Add_Standardized_i > 0.5) => 
   map(
   (NULL < c_rich_blk and c_rich_blk <= 180.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 13) => 
         map(
         (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.7942946024) => 0.0235721677,
         (f_add_curr_nhood_MFD_pct_i > 0.7942946024) => -0.1107266183,
         (f_add_curr_nhood_MFD_pct_i = NULL) => 0.1194155733, 0.0106628150),
      (f_addrchangecrimediff_i > 13) => 0.1253822199,
      (f_addrchangecrimediff_i = NULL) => 0.0132171395, 0.0202484475),
   (c_rich_blk > 180.5) => 
      map(
      (NULL < c_lowinc and c_lowinc <= 19.9) => 0.0163125776,
      (c_lowinc > 19.9) => 0.1999002707,
      (c_lowinc = NULL) => 0.1168867051, 0.1168867051),
   (c_rich_blk = NULL) => -0.0116292793, 0.0282844482),
(r_L70_Add_Standardized_i = NULL) => -0.0020300512, -0.0020300512);

// Tree: 267 
wFDN_FLAP___lgt_267 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 0.5) => -0.0149397544,
(f_srchfraudsrchcount_i > 0.5) => 
   map(
   (NULL < f_add_input_mobility_index_i and f_add_input_mobility_index_i <= 0.6165281206) => 
      map(
      (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 0.0545031534,
         (r_C12_Num_NonDerogs_d > 2.5) => 0.0104256081,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0204168864, 0.0204168864),
      (r_Phn_Cell_n > 0.5) => -0.0126622197,
      (r_Phn_Cell_n = NULL) => 0.0040605826, 0.0040605826),
   (f_add_input_mobility_index_i > 0.6165281206) => 
      map(
      (NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 3.5) => 0.1161175839,
      (f_rel_under25miles_cnt_d > 3.5) => -0.0158009450,
      (f_rel_under25miles_cnt_d = NULL) => 0.0409116936, 0.0409116936),
   (f_add_input_mobility_index_i = NULL) => 0.0052897047, 0.0052897047),
(f_srchfraudsrchcount_i = NULL) => -0.0233469655, -0.0045591067);

// Tree: 268 
wFDN_FLAP___lgt_268 := map(
(NULL < c_retail and c_retail <= 28.75) => -0.0027964678,
(c_retail > 28.75) => 
   map(
   (NULL < f_hh_bankruptcies_i and f_hh_bankruptcies_i <= 0.5) => 
      map(
      (NULL < c_hh5_p and c_hh5_p <= 11.75) => 0.0269833167,
      (c_hh5_p > 11.75) => 
         map(
         (NULL < c_fammar18_p and c_fammar18_p <= 49.75) => 
            map(
            (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.23445023445) => 0.2896465819,
            (f_add_curr_mobility_index_i > 0.23445023445) => 0.0854655943,
            (f_add_curr_mobility_index_i = NULL) => 0.1639967434, 0.1639967434),
         (c_fammar18_p > 49.75) => -0.0535850947,
         (c_fammar18_p = NULL) => 0.1035573439, 0.1035573439),
      (c_hh5_p = NULL) => 0.0408359045, 0.0408359045),
   (f_hh_bankruptcies_i > 0.5) => -0.0413385761,
   (f_hh_bankruptcies_i = NULL) => 0.0243877971, 0.0243877971),
(c_retail = NULL) => -0.0277682835, -0.0006648365);

// Tree: 269 
wFDN_FLAP___lgt_269 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 86242) => -0.0010494331,
(f_addrchangevaluediff_d > 86242) => -0.0584447048,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_pop_35_44_p and c_pop_35_44_p <= 25.25) => 
      map(
      (NULL < c_occunit_p and c_occunit_p <= 88.95) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.65) => 0.0118942324,
         (c_pop_6_11_p > 10.65) => 
            map(
            (NULL < C_INC_35K_P and C_INC_35K_P <= 11.15) => 0.2148476255,
            (C_INC_35K_P > 11.15) => 0.0243815689,
            (C_INC_35K_P = NULL) => 0.1196145972, 0.1196145972),
         (c_pop_6_11_p = NULL) => 0.0267522137, 0.0267522137),
      (c_occunit_p > 88.95) => -0.0193453486,
      (c_occunit_p = NULL) => -0.0064614887, -0.0064614887),
   (c_pop_35_44_p > 25.25) => 0.1169340958,
   (c_pop_35_44_p = NULL) => 0.0065509315, -0.0028371382), -0.0025673626);

// Tree: 270 
wFDN_FLAP___lgt_270 := map(
(NULL < c_pop00 and c_pop00 <= 740.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['3: Derog']) => -0.1014852774,
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => -0.0336132865,
   (nf_seg_FraudPoint_3_0 = '') => -0.0469371505, -0.0469371505),
(c_pop00 > 740.5) => 
   map(
   (NULL < f_rel_homeover500_count_d and f_rel_homeover500_count_d <= 15.5) => 0.0008863669,
   (f_rel_homeover500_count_d > 15.5) => 
      map(
      (NULL < C_INC_35K_P and C_INC_35K_P <= 5.45) => -0.0084498845,
      (C_INC_35K_P > 5.45) => 0.1273948428,
      (C_INC_35K_P = NULL) => 0.0601072676, 0.0601072676),
   (f_rel_homeover500_count_d = NULL) => 
      map(
      (NULL < c_rnt1000_p and c_rnt1000_p <= 15.95) => 0.0337599205,
      (c_rnt1000_p > 15.95) => -0.0536595147,
      (c_rnt1000_p = NULL) => -0.0071933284, -0.0071933284), 0.0011952535),
(c_pop00 = NULL) => -0.0226629827, -0.0016022640);

// Tree: 271 
wFDN_FLAP___lgt_271 := map(
(NULL < c_vacant_p and c_vacant_p <= 13.85) => -0.0061328940,
(c_vacant_p > 13.85) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 8.5) => 
      map(
      (NULL < c_trailer and c_trailer <= 190.5) => -0.0186483517,
      (c_trailer > 190.5) => 0.1538219605,
      (c_trailer = NULL) => -0.0000567493, -0.0000567493),
   (r_P88_Phn_Dst_to_Inp_Add_i > 8.5) => 
      map(
      (NULL < c_incollege and c_incollege <= 2.75) => 0.2135711201,
      (c_incollege > 2.75) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0999463998,
         (r_C23_inp_addr_occ_index_d > 2) => -0.0576343179,
         (r_C23_inp_addr_occ_index_d = NULL) => 0.0194243847, 0.0194243847),
      (c_incollege = NULL) => 0.0770845054, 0.0770845054),
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0276144102, 0.0190852585),
(c_vacant_p = NULL) => 0.0267032325, -0.0017403226);

// Tree: 272 
wFDN_FLAP___lgt_272 := map(
(NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.821130781) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 16.5) => 
      map(
      (NULL < c_high_hval and c_high_hval <= 3.75) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 149.5) => 
            map(
            (NULL < f_corrrisktype_i and f_corrrisktype_i <= 7.5) => 0.0563922577,
            (f_corrrisktype_i > 7.5) => 0.1737229409,
            (f_corrrisktype_i = NULL) => 0.1163422418, 0.1163422418),
         (c_relig_indx > 149.5) => -0.0225685489,
         (c_relig_indx = NULL) => 0.0786589954, 0.0786589954),
      (c_high_hval > 3.75) => -0.0081077707,
      (c_high_hval = NULL) => 0.0357421003, 0.0357421003),
   (r_C21_M_Bureau_ADL_FS_d > 16.5) => 0.0062592971,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0188159388, 0.0071935944),
(f_add_input_nhood_MFD_pct_i > 0.821130781) => -0.0213414243,
(f_add_input_nhood_MFD_pct_i = NULL) => -0.0151516281, 0.0008060655);

// Tree: 273 
wFDN_FLAP___lgt_273 := map(
(NULL < f_liens_rel_SC_total_amt_i and f_liens_rel_SC_total_amt_i <= 944.5) => 
   map(
   (NULL < c_newhouse and c_newhouse <= 10.75) => 
      map(
      (NULL < c_trailer and c_trailer <= 193.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 866473) => 0.0068264076,
         (f_curraddrmedianvalue_d > 866473) => 0.1593026584,
         (f_curraddrmedianvalue_d = NULL) => 0.0085700664, 0.0085700664),
      (c_trailer > 193.5) => 0.2109116286,
      (c_trailer = NULL) => 0.0107185146, 0.0107185146),
   (c_newhouse > 10.75) => -0.0106568082,
   (c_newhouse = NULL) => -0.0048928538, -0.0006706929),
(f_liens_rel_SC_total_amt_i > 944.5) => -0.0864538501,
(f_liens_rel_SC_total_amt_i = NULL) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 1.2) => 0.0526505087,
   (c_wholesale > 1.2) => -0.0492576750,
   (c_wholesale = NULL) => 0.0101887655, 0.0101887655), -0.0010857674);

// Tree: 274 
wFDN_FLAP___lgt_274 := map(
(NULL < c_many_cars and c_many_cars <= 22.5) => 
   map(
   (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 262) => 
      map(
      (NULL < c_newhouse and c_newhouse <= 23.45) => 
         map(
         (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 0.5) => 0.0351553922,
         (f_inq_Collection_count24_i > 0.5) => 0.1364716775,
         (f_inq_Collection_count24_i = NULL) => 0.0474798060, 0.0474798060),
      (c_newhouse > 23.45) => -0.0229841012,
      (c_newhouse = NULL) => 0.0220700940, 0.0220700940),
   (f_prevaddrageoldest_d > 262) => 0.1455125810,
   (f_prevaddrageoldest_d = NULL) => 0.0290129984, 0.0290129984),
(c_many_cars > 22.5) => 
   map(
   (NULL < c_wholesale and c_wholesale <= 21.75) => -0.0025244403,
   (c_wholesale > 21.75) => 0.0730109218,
   (c_wholesale = NULL) => -0.0006568993, -0.0006568993),
(c_many_cars = NULL) => -0.0059205834, 0.0017034360);

// Tree: 275 
wFDN_FLAP___lgt_275 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 76.5) => 
   map(
   (NULL < c_hval_200k_p and c_hval_200k_p <= 16.65) => 
      map(
      (NULL < c_unempl and c_unempl <= 146.5) => 0.0211249375,
      (c_unempl > 146.5) => -0.0350913233,
      (c_unempl = NULL) => 0.0107172986, 0.0107172986),
   (c_hval_200k_p > 16.65) => 
      map(
      (NULL < c_bigapt_p and c_bigapt_p <= 0.85) => 0.0078276588,
      (c_bigapt_p > 0.85) => 
         map(
         (NULL < c_families and c_families <= 437) => 0.0706004818,
         (c_families > 437) => 0.2554809100,
         (c_families = NULL) => 0.1549319052, 0.1549319052),
      (c_bigapt_p = NULL) => 0.0798014103, 0.0798014103),
   (c_hval_200k_p = NULL) => 0.0888930093, 0.0195563617),
(f_mos_inq_banko_cm_fseen_d > 76.5) => -0.0086156313,
(f_mos_inq_banko_cm_fseen_d = NULL) => 0.0100832436, -0.0026898360);

// Tree: 276 
wFDN_FLAP___lgt_276 := map(
(NULL < f_srchphonesrchcountmo_i and f_srchphonesrchcountmo_i <= 2.5) => 
   map(
   (NULL < f_srchfraudsrchcountmo_i and f_srchfraudsrchcountmo_i <= 1.5) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 35.5) => 
         map(
         (NULL < f_curraddrmedianincome_d and f_curraddrmedianincome_d <= 27852.5) => 
            map(
            (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24466.5) => -0.0019674122,
            (f_prevaddrmedianincome_d > 24466.5) => 0.0781842839,
            (f_prevaddrmedianincome_d = NULL) => 0.0229412688, 0.0229412688),
         (f_curraddrmedianincome_d > 27852.5) => -0.0027438926,
         (f_curraddrmedianincome_d = NULL) => -0.0007151311, -0.0007151311),
      (f_srchaddrsrchcount_i > 35.5) => -0.0664173670,
      (f_srchaddrsrchcount_i = NULL) => -0.0010856125, -0.0010856125),
   (f_srchfraudsrchcountmo_i > 1.5) => 0.0792717699,
   (f_srchfraudsrchcountmo_i = NULL) => -0.0005582994, -0.0005582994),
(f_srchphonesrchcountmo_i > 2.5) => -0.0864328979,
(f_srchphonesrchcountmo_i = NULL) => 0.0138628346, -0.0007624838);

// Tree: 277 
wFDN_FLAP___lgt_277 := map(
(NULL < c_unempl and c_unempl <= 55.5) => -0.0278528838,
(c_unempl > 55.5) => 
   map(
   (NULL < c_hhsize and c_hhsize <= 4.495) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 24249) => -0.0451576244,
      (f_prevaddrmedianincome_d > 24249) => 
         map(
         (NULL < f_adls_per_phone_c6_i and f_adls_per_phone_c6_i <= 1.5) => 0.0062512020,
         (f_adls_per_phone_c6_i > 1.5) => 
            map(
            (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 2.5) => -0.0175227514,
            (f_componentcharrisktype_i > 2.5) => 0.2103178731,
            (f_componentcharrisktype_i = NULL) => 0.1090553733, 0.1090553733),
         (f_adls_per_phone_c6_i = NULL) => 0.0075653162, 0.0075653162),
      (f_prevaddrmedianincome_d = NULL) => -0.0050503072, 0.0048500234),
   (c_hhsize > 4.495) => -0.1057485583,
   (c_hhsize = NULL) => 0.0042848799, 0.0042848799),
(c_unempl = NULL) => 0.0013051646, -0.0023704565);

// Tree: 278 
wFDN_FLAP___lgt_278 := map(
(NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.1287581466) => -0.0074039733,
(f_add_curr_nhood_BUS_pct_i > 0.1287581466) => 
   map(
   (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.01326400185) => 
      map(
      (nf_seg_FraudPoint_3_0 in ['2: Synth ID','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
         map(
         (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 132) => 0.0107201942,
         (f_curraddrcartheftindex_i > 132) => 0.1619340585,
         (f_curraddrcartheftindex_i = NULL) => 0.0467476585, 0.0467476585),
      (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog']) => 0.1574862234,
      (nf_seg_FraudPoint_3_0 = '') => 0.0640015426, 0.0640015426),
   (f_add_input_nhood_VAC_pct_i > 0.01326400185) => 0.0054860439,
   (f_add_input_nhood_VAC_pct_i = NULL) => 0.0188296944, 0.0188296944),
(f_add_curr_nhood_BUS_pct_i = NULL) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => -0.0134894739,
   (r_D30_Derog_Count_i > 1.5) => 0.1143842996,
   (r_D30_Derog_Count_i = NULL) => 0.0028832051, 0.0044040574), -0.0034169260);

// Tree: 279 
wFDN_FLAP___lgt_279 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 4.5) => 
   map(
   (NULL < c_pop00 and c_pop00 <= 836.5) => 
      map(
      (NULL < C_INC_25K_P and C_INC_25K_P <= 21.85) => 
         map(
         (NULL < f_M_Bureau_ADL_FS_noTU_d and f_M_Bureau_ADL_FS_noTU_d <= 102.5) => 
            map(
            (NULL < c_low_ed and c_low_ed <= 40.25) => -0.0924699612,
            (c_low_ed > 40.25) => 0.1084095038,
            (c_low_ed = NULL) => 0.0039521820, 0.0039521820),
         (f_M_Bureau_ADL_FS_noTU_d > 102.5) => -0.0681155319,
         (f_M_Bureau_ADL_FS_noTU_d = NULL) => -0.0520130139, -0.0520130139),
      (C_INC_25K_P > 21.85) => 0.0820747927,
      (C_INC_25K_P = NULL) => -0.0431816277, -0.0431816277),
   (c_pop00 > 836.5) => 0.0025762387,
   (c_pop00 = NULL) => 0.0081235809, -0.0012662181),
(r_I60_inq_hiRiskCred_count12_i > 4.5) => -0.0681576436,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0159947783, -0.0018527627);

// Tree: 280 
wFDN_FLAP___lgt_280 := map(
(NULL < c_hval_200k_p and c_hval_200k_p <= 16.45) => -0.0071798290,
(c_hval_200k_p > 16.45) => 
   map(
   (NULL < c_ab_av_edu and c_ab_av_edu <= 56.5) => 0.1077731047,
   (c_ab_av_edu > 56.5) => 
      map(
      (NULL < f_add_input_nhood_MFD_pct_i and f_add_input_nhood_MFD_pct_i <= 0.00402494335) => 0.2150555911,
      (f_add_input_nhood_MFD_pct_i > 0.00402494335) => 
         map(
         (NULL < c_food and c_food <= 36.55) => -0.0196812337,
         (c_food > 36.55) => 
            map(
            (NULL < c_hval_300k_p and c_hval_300k_p <= 6.1) => -0.0480385201,
            (c_hval_300k_p > 6.1) => 0.2215774226,
            (c_hval_300k_p = NULL) => 0.0867694513, 0.0867694513),
         (c_food = NULL) => -0.0053925511, -0.0053925511),
      (f_add_input_nhood_MFD_pct_i = NULL) => 0.0484856430, 0.0168730683),
   (c_ab_av_edu = NULL) => 0.0257992881, 0.0257992881),
(c_hval_200k_p = NULL) => -0.0083509665, -0.0043205833);

// Tree: 281 
wFDN_FLAP___lgt_281 := map(
(NULL < c_for_sale and c_for_sale <= 178.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 8.95) => 0.0032613021,
   (c_unemp > 8.95) => 
      map(
      (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 8.5) => 
         map(
         (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.0404945923) => 
            map(
            (NULL < c_hval_125k_p and c_hval_125k_p <= 7.55) => -0.0260645165,
            (c_hval_125k_p > 7.55) => 0.1134198771,
            (c_hval_125k_p = NULL) => 0.0106102594, 0.0106102594),
         (f_add_curr_nhood_VAC_pct_i > 0.0404945923) => 0.1140849065,
         (f_add_curr_nhood_VAC_pct_i = NULL) => 0.0534633961, 0.0534633961),
      (f_corraddrnamecount_d > 8.5) => -0.0524578283,
      (f_corraddrnamecount_d = NULL) => 0.0233917284, 0.0233917284),
   (c_unemp = NULL) => 0.0042630659, 0.0042630659),
(c_for_sale > 178.5) => -0.0352201635,
(c_for_sale = NULL) => -0.0050977862, 0.0003414819);

// Tree: 282 
wFDN_FLAP___lgt_282 := map(
(NULL < f_hh_payday_loan_users_i and f_hh_payday_loan_users_i <= 0.5) => -0.0051605006,
(f_hh_payday_loan_users_i > 0.5) => 
   map(
   (NULL < f_idrisktype_i and f_idrisktype_i <= 2) => 
      map(
      (NULL < f_srchaddrsrchcount_i and f_srchaddrsrchcount_i <= 2.5) => -0.0207296850,
      (f_srchaddrsrchcount_i > 2.5) => 
         map(
         (NULL < f_componentcharrisktype_i and f_componentcharrisktype_i <= 4.5) => 
            map(
            (NULL < c_unemp and c_unemp <= 6.35) => 0.0571540401,
            (c_unemp > 6.35) => -0.0753870613,
            (c_unemp = NULL) => 0.0295854910, 0.0295854910),
         (f_componentcharrisktype_i > 4.5) => 0.1168247508,
         (f_componentcharrisktype_i = NULL) => 0.0505581616, 0.0505581616),
      (f_srchaddrsrchcount_i = NULL) => 0.0120045302, 0.0120045302),
   (f_idrisktype_i > 2) => 0.1757614763,
   (f_idrisktype_i = NULL) => 0.0205020323, 0.0205020323),
(f_hh_payday_loan_users_i = NULL) => -0.0065188846, -0.0028774136);

// Tree: 283 
wFDN_FLAP___lgt_283 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 0.0021492215,
(r_D33_eviction_count_i > 0.5) => 
   map(
   (NULL < c_medi_indx and c_medi_indx <= 106.5) => 
      map(
      (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.29746604175) => -0.0913218050,
      (f_add_curr_mobility_index_i > 0.29746604175) => 
         map(
         (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.05) => -0.0618270955,
         (c_pop_6_11_p > 10.05) => 0.0742802534,
         (c_pop_6_11_p = NULL) => -0.0192935490, -0.0192935490),
      (f_add_curr_mobility_index_i = NULL) => -0.0588583657, -0.0588583657),
   (c_medi_indx > 106.5) => 
      map(
      (NULL < f_corrrisktype_i and f_corrrisktype_i <= 6.5) => -0.0540906670,
      (f_corrrisktype_i > 6.5) => 0.0826751505,
      (f_corrrisktype_i = NULL) => 0.0225369896, 0.0225369896),
   (c_medi_indx = NULL) => -0.0358588765, -0.0358588765),
(r_D33_eviction_count_i = NULL) => -0.0260290619, 0.0002887775);

// Tree: 284 
wFDN_FLAP___lgt_284 := map(
(NULL < f_mos_liens_unrel_OT_fseen_d and f_mos_liens_unrel_OT_fseen_d <= 60.5) => 
   map(
   (NULL < c_exp_prod and c_exp_prod <= 89.5) => 0.1614678344,
   (c_exp_prod > 89.5) => 0.0062951405,
   (c_exp_prod = NULL) => 0.0628031157, 0.0628031157),
(f_mos_liens_unrel_OT_fseen_d > 60.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 19.95) => 
      map(
      (NULL < c_pop00 and c_pop00 <= 2355.5) => -0.0095718460,
      (c_pop00 > 2355.5) => 0.0167604772,
      (c_pop00 = NULL) => -0.0032883185, -0.0032883185),
   (c_pop_0_5_p > 19.95) => 0.1106209070,
   (c_pop_0_5_p = NULL) => -0.0306836800, -0.0032603263),
(f_mos_liens_unrel_OT_fseen_d = NULL) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 26.55) => -0.0513383675,
   (c_high_ed > 26.55) => 0.0523556468,
   (c_high_ed = NULL) => 0.0082652785, 0.0082652785), -0.0022189968);

// Tree: 285 
wFDN_FLAP___lgt_285 := map(
(NULL < f_rel_ageover40_count_d and f_rel_ageover40_count_d <= 6.5) => -0.0062258544,
(f_rel_ageover40_count_d > 6.5) => 
   map(
   (NULL < c_oldhouse and c_oldhouse <= 305.7) => 
      map(
      (NULL < c_sub_bus and c_sub_bus <= 178.5) => 0.0221301496,
      (c_sub_bus > 178.5) => 
         map(
         (NULL < f_rel_incomeover75_count_d and f_rel_incomeover75_count_d <= 7.5) => 0.2244415131,
         (f_rel_incomeover75_count_d > 7.5) => 0.0233751369,
         (f_rel_incomeover75_count_d = NULL) => 0.1144833386, 0.1144833386),
      (c_sub_bus = NULL) => 0.0287415636, 0.0287415636),
   (c_oldhouse > 305.7) => -0.0638528103,
   (c_oldhouse = NULL) => 0.0237907792, 0.0237907792),
(f_rel_ageover40_count_d = NULL) => 
   map(
   (NULL < r_Phn_Cell_n and r_Phn_Cell_n <= 0.5) => 0.0678095324,
   (r_Phn_Cell_n > 0.5) => -0.0269917352,
   (r_Phn_Cell_n = NULL) => 0.0130111118, 0.0130111118), -0.0012146185);

// Tree: 286 
wFDN_FLAP___lgt_286 := map(
(NULL < c_pop_35_44_p and c_pop_35_44_p <= 21.05) => 
   map(
   (NULL < r_D32_Mos_Since_Fel_LS_d and r_D32_Mos_Since_Fel_LS_d <= 197) => -0.0761245237,
   (r_D32_Mos_Since_Fel_LS_d > 197) => -0.0034161387,
   (r_D32_Mos_Since_Fel_LS_d = NULL) => 0.0133201554, -0.0037585222),
(c_pop_35_44_p > 21.05) => 
   map(
   (NULL < c_hval_500k_p and c_hval_500k_p <= 31.85) => 
      map(
      (NULL < c_assault and c_assault <= 147.5) => 
         map(
         (NULL < c_hval_150k_p and c_hval_150k_p <= 21.7) => -0.0033768799,
         (c_hval_150k_p > 21.7) => 0.1327805910,
         (c_hval_150k_p = NULL) => 0.0057266719, 0.0057266719),
      (c_assault > 147.5) => 0.1022609361,
      (c_assault = NULL) => 0.0197912667, 0.0197912667),
   (c_hval_500k_p > 31.85) => 0.1903593259,
   (c_hval_500k_p = NULL) => 0.0272190127, 0.0272190127),
(c_pop_35_44_p = NULL) => 0.0188907750, -0.0001974667);

// Tree: 287 
wFDN_FLAP___lgt_287 := map(
(NULL < c_hhsize and c_hhsize <= 4.255) => 
   map(
   (NULL < r_L70_inp_addr_dirty_i and r_L70_inp_addr_dirty_i <= 0.5) => -0.0033472826,
   (r_L70_inp_addr_dirty_i > 0.5) => 
      map(
      (NULL < f_rel_incomeover25_count_d and f_rel_incomeover25_count_d <= 5.5) => 0.0351470015,
      (f_rel_incomeover25_count_d > 5.5) => -0.1017484827,
      (f_rel_incomeover25_count_d = NULL) => -0.0590693023, -0.0590693023),
   (r_L70_inp_addr_dirty_i = NULL) => 
      map(
      (NULL < c_rich_old and c_rich_old <= 150.5) => -0.0467135694,
      (c_rich_old > 150.5) => 0.0500216649,
      (c_rich_old = NULL) => -0.0154889052, -0.0154889052), -0.0042884345),
(c_hhsize > 4.255) => 
   map(
   (NULL < c_lowrent and c_lowrent <= 3.5) => 0.1708730926,
   (c_lowrent > 3.5) => 0.0151948139,
   (c_lowrent = NULL) => 0.0811601863, 0.0811601863),
(c_hhsize = NULL) => 0.0241371212, -0.0028526721);

// Tree: 288 
wFDN_FLAP___lgt_288 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 16.5) => -0.0028886157,
(f_addrchangecrimediff_i > 16.5) => 
   map(
   (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 74.5) => 
         map(
         (NULL < f_curraddrmedianvalue_d and f_curraddrmedianvalue_d <= 165256.5) => 0.0025170124,
         (f_curraddrmedianvalue_d > 165256.5) => 0.1202603709,
         (f_curraddrmedianvalue_d = NULL) => 0.0638080757, 0.0638080757),
      (c_exp_prod > 74.5) => -0.0345138280,
      (c_exp_prod = NULL) => 0.0061518885, 0.0061518885),
   (r_I61_inq_collection_count12_i > 0.5) => 0.1476145924,
   (r_I61_inq_collection_count12_i = NULL) => 0.0249208959, 0.0249208959),
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < c_pop_6_11_p and c_pop_6_11_p <= 10.55) => -0.0127936926,
   (c_pop_6_11_p > 10.55) => 0.0392287164,
   (c_pop_6_11_p = NULL) => 0.0041087753, -0.0034699808), -0.0021311323);

// Tree: 289 
wFDN_FLAP___lgt_289 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
   map(
   (NULL < c_rnt1250_p and c_rnt1250_p <= 26.25) => -0.0034283709,
   (c_rnt1250_p > 26.25) => 0.0322657310,
   (c_rnt1250_p = NULL) => 0.0248040701, 0.0025675084),
(r_I60_inq_hiRiskCred_count12_i > 0.5) => 
   map(
   (NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 80) => 0.0368482959,
   (r_A50_pb_total_dollars_d > 80) => 
      map(
      (NULL < c_child and c_child <= 18.6) => 0.0338641763,
      (c_child > 18.6) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 3.5) => -0.1320249507,
         (f_phones_per_addr_curr_i > 3.5) => -0.0378383647,
         (f_phones_per_addr_curr_i = NULL) => -0.0789153339, -0.0789153339),
      (c_child = NULL) => -0.0553377360, -0.0553377360),
   (r_A50_pb_total_dollars_d = NULL) => -0.0333304604, -0.0333304604),
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0088919288, 0.0015818834);

// Tree: 290 
wFDN_FLAP___lgt_290 := map(
(NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 31.5) => 
   map(
   (NULL < nf_vf_type and nf_vf_type <= 0.5) => 
      map(
      (NULL < c_food and c_food <= 29.2) => -0.0413360459,
      (c_food > 29.2) => 
         map(
         (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.0261955234) => 0.0835153678,
         (f_add_curr_nhood_BUS_pct_i > 0.0261955234) => 0.0269348582,
         (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0481975975, 0.0481975975),
      (c_food = NULL) => -0.0185995844, -0.0185995844),
   (nf_vf_type > 0.5) => -0.1131376663,
   (nf_vf_type = NULL) => -0.0310288940, -0.0310288940),
(f_mos_inq_banko_cm_fseen_d > 31.5) => 0.0067732114,
(f_mos_inq_banko_cm_fseen_d = NULL) => 
   map(
   (NULL < c_pop_55_64_p and c_pop_55_64_p <= 9.35) => -0.0429916745,
   (c_pop_55_64_p > 9.35) => 0.0606683196,
   (c_pop_55_64_p = NULL) => 0.0172757639, 0.0172757639), 0.0046592118);

// Tree: 291 
wFDN_FLAP___lgt_291 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 6.5) => 0.0045938691,
(f_assocsuspicousidcount_i > 6.5) => 
   map(
   (NULL < c_employees and c_employees <= 13.5) => 0.0734853811,
   (c_employees > 13.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 81.5) => -0.0656213897,
      (c_exp_prod > 81.5) => 
         map(
         (NULL < c_professional and c_professional <= 9.55) => -0.0329198415,
         (c_professional > 9.55) => 
            map(
            (NULL < f_prevaddrmurderindex_i and f_prevaddrmurderindex_i <= 81) => -0.0339925079,
            (f_prevaddrmurderindex_i > 81) => 0.1744633594,
            (f_prevaddrmurderindex_i = NULL) => 0.0418096256, 0.0418096256),
         (c_professional = NULL) => -0.0125511018, -0.0125511018),
      (c_exp_prod = NULL) => -0.0318548214, -0.0318548214),
   (c_employees = NULL) => -0.0246700227, -0.0246700227),
(f_assocsuspicousidcount_i = NULL) => 0.0125562962, 0.0024353722);

// Tree: 292 
wFDN_FLAP___lgt_292 := map(
(NULL < c_med_age and c_med_age <= 30.95) => 
   map(
   (NULL < f_mos_acc_lseen_d and f_mos_acc_lseen_d <= 18.5) => 0.0951070133,
   (f_mos_acc_lseen_d > 18.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 9999.5) => -0.0805499109,
      (k_estimated_income_d > 9999.5) => -0.0199958069,
      (k_estimated_income_d = NULL) => -0.0229049336, -0.0229049336),
   (f_mos_acc_lseen_d = NULL) => -0.0185143433, -0.0185143433),
(c_med_age > 30.95) => 
   map(
   (NULL < c_pop_75_84_p and c_pop_75_84_p <= 2.75) => 
      map(
      (NULL < f_rel_criminal_count_i and f_rel_criminal_count_i <= 10.5) => 0.0201114706,
      (f_rel_criminal_count_i > 10.5) => 0.0865341835,
      (f_rel_criminal_count_i = NULL) => 0.0216897945, 0.0216897945),
   (c_pop_75_84_p > 2.75) => -0.0058723079,
   (c_pop_75_84_p = NULL) => 0.0034874056, 0.0034874056),
(c_med_age = NULL) => 0.0274168741, 0.0005112195);

// Tree: 293 
wFDN_FLAP___lgt_293 := map(
(NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 7.5) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 194.5) => -0.0032998212,
   (c_relig_indx > 194.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 14.55) => 
         map(
         (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 45.5) => -0.0243286273,
         (f_curraddrburglaryindex_i > 45.5) => 0.2179346715,
         (f_curraddrburglaryindex_i = NULL) => 0.1216131190, 0.1216131190),
      (C_INC_75K_P > 14.55) => 0.0008302213,
      (C_INC_75K_P = NULL) => 0.0482296563, 0.0482296563),
   (c_relig_indx = NULL) => 0.0220065447, -0.0009791936),
(r_D34_unrel_liens_ct_i > 7.5) => 0.0947666942,
(r_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < c_hval_750k_p and c_hval_750k_p <= 4.95) => -0.0408130241,
   (c_hval_750k_p > 4.95) => 0.0622924558,
   (c_hval_750k_p = NULL) => 0.0005915387, 0.0005915387), -0.0003793028);

// Tree: 294 
wFDN_FLAP___lgt_294 := map(
(NULL < f_inq_QuizProvider_count_i and f_inq_QuizProvider_count_i <= 6.5) => 
   map(
   (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 52) => 0.1617126453,
      (r_C12_source_profile_d > 52) => -0.0121916678,
      (r_C12_source_profile_d = NULL) => 0.0576439225, 0.0576439225),
   (f_mos_liens_unrel_SC_fseen_d > 57.5) => 
      map(
      (NULL < c_hh6_p and c_hh6_p <= 15.95) => -0.0004132446,
      (c_hh6_p > 15.95) => -0.0910785934,
      (c_hh6_p = NULL) => 0.0123295517, -0.0009053869),
   (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0003067907, -0.0003067907),
(f_inq_QuizProvider_count_i > 6.5) => 
   map(
   (NULL < c_no_car and c_no_car <= 91) => 0.1983713545,
   (c_no_car > 91) => -0.0015200910,
   (c_no_car = NULL) => 0.0879050294, 0.0879050294),
(f_inq_QuizProvider_count_i = NULL) => -0.0051417534, 0.0004291760);

// Tree: 295 
wFDN_FLAP___lgt_295 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 8118) => -0.0112688261,
(r_A49_Curr_AVM_Chg_1yr_i > 8118) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 61690.5) => 0.1032205249,
   (r_L80_Inp_AVM_AutoVal_d > 61690.5) => 0.0139594611,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < c_serv_empl and c_serv_empl <= 103.5) => 0.0051232986,
      (c_serv_empl > 103.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 129.5) => 0.0522571799,
         (r_C13_max_lres_d > 129.5) => 0.2126445412,
         (r_C13_max_lres_d = NULL) => 0.1359992535, 0.1359992535),
      (c_serv_empl = NULL) => 0.0745551432, 0.0745551432), 0.0206922357),
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < f_inq_count_i and f_inq_count_i <= 14.5) => -0.0021522898,
   (f_inq_count_i > 14.5) => 0.0774311621,
   (f_inq_count_i = NULL) => -0.0062439094, -0.0001324700), 0.0017559346);

// Tree: 296 
wFDN_FLAP___lgt_296 := map(
(NULL < f_inq_count24_i and f_inq_count24_i <= 10.5) => 
   map(
   (nf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID']) => -0.0779884751,
   (nf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly','6: Other']) => 
      map(
      (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 3.5) => 0.0005655843,
      (f_inq_Other_count24_i > 3.5) => 
         map(
         (NULL < c_hval_200k_p and c_hval_200k_p <= 1.75) => 0.2113234258,
         (c_hval_200k_p > 1.75) => 0.0090090124,
         (c_hval_200k_p = NULL) => 0.0862282541, 0.0862282541),
      (f_inq_Other_count24_i = NULL) => 0.0014829234, 0.0014829234),
   (nf_seg_FraudPoint_3_0 = '') => 0.0009025107, 0.0009025107),
(f_inq_count24_i > 10.5) => -0.0677874125,
(f_inq_count24_i = NULL) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 26) => -0.0606736823,
   (c_high_ed > 26) => 0.0305300220,
   (c_high_ed = NULL) => -0.0074715215, -0.0074715215), -0.0003207285);

// Tree: 297 
wFDN_FLAP___lgt_297 := map(
(NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 1.5) => -0.0055886065,
(k_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < f_inq_Auto_count_i and f_inq_Auto_count_i <= 1.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 73018.5) => 0.1226949705,
      (r_A46_Curr_AVM_AutoVal_d > 73018.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 10546) => 0.0324394966,
         (r_A49_Curr_AVM_Chg_1yr_i > 10546) => -0.0153626940,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
            map(
            (NULL < c_easiqlife and c_easiqlife <= 111.5) => -0.0472599460,
            (c_easiqlife > 111.5) => 0.1544756518,
            (c_easiqlife = NULL) => 0.0851290400, 0.0851290400), 0.0232948570),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0209683488, 0.0287710544),
   (f_inq_Auto_count_i > 1.5) => -0.0519875703,
   (f_inq_Auto_count_i = NULL) => 0.0168104747, 0.0168104747),
(k_inq_ssns_per_addr_i = NULL) => -0.0026803459, -0.0026803459);

// Tree: 298 
wFDN_FLAP___lgt_298 := map(
(NULL < f_mos_inq_banko_cm_lseen_d and f_mos_inq_banko_cm_lseen_d <= 35.5) => 
   map(
   (NULL < c_info and c_info <= 4.55) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 233.5) => 
         map(
         (NULL < c_rest_indx and c_rest_indx <= 153.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.02354935095) => -0.0196616308,
            (f_add_curr_nhood_BUS_pct_i > 0.02354935095) => 0.0461284133,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0201965711, 0.0201965711),
         (c_rest_indx > 153.5) => 0.1653739067,
         (c_rest_indx = NULL) => 0.0349696417, 0.0349696417),
      (r_C21_M_Bureau_ADL_FS_d > 233.5) => -0.0185151768,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0096049788, 0.0096049788),
   (c_info > 4.55) => 0.1566263050,
   (c_info = NULL) => 0.1695027942, 0.0231542382),
(f_mos_inq_banko_cm_lseen_d > 35.5) => -0.0037745667,
(f_mos_inq_banko_cm_lseen_d = NULL) => 0.0041253277, -0.0001498007);

// Tree: 299 
wFDN_FLAP___lgt_299 := map(
(NULL < c_span_lang and c_span_lang <= 182.5) => 
   map(
   (NULL < f_mos_inq_banko_om_lseen_d and f_mos_inq_banko_om_lseen_d <= 6.5) => -0.0400567275,
   (f_mos_inq_banko_om_lseen_d > 6.5) => 0.0021199687,
   (f_mos_inq_banko_om_lseen_d = NULL) => 0.0051279600, -0.0001030049),
(c_span_lang > 182.5) => 
   map(
   (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 30.5) => 
      map(
      (NULL < c_low_ed and c_low_ed <= 68.25) => -0.0291701624,
      (c_low_ed > 68.25) => 0.1581455596,
      (c_low_ed = NULL) => 0.0250797461, 0.0250797461),
   (f_curraddrmurderindex_i > 30.5) => 
      map(
      (NULL < k_inq_ssns_per_addr_i and k_inq_ssns_per_addr_i <= 2.5) => -0.0366842602,
      (k_inq_ssns_per_addr_i > 2.5) => -0.1226710070,
      (k_inq_ssns_per_addr_i = NULL) => -0.0429488645, -0.0429488645),
   (f_curraddrmurderindex_i = NULL) => -0.0309089847, -0.0309089847),
(c_span_lang = NULL) => -0.0207745828, -0.0031059988);

// Tree: 300 
wFDN_FLAP___lgt_300 := map(
(NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= -229375) => -0.0752990575,
(f_addrchangevaluediff_d > -229375) => 0.0073294114,
(f_addrchangevaluediff_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 29.45) => 
      map(
      (NULL < c_food and c_food <= 70.5) => 
         map(
         (NULL < r_I60_inq_banking_recency_d and r_I60_inq_banking_recency_d <= 9) => 
            map(
            (NULL < C_INC_125K_P and C_INC_125K_P <= 11.05) => 0.0056069812,
            (C_INC_125K_P > 11.05) => 0.1915689249,
            (C_INC_125K_P = NULL) => 0.0753427101, 0.0753427101),
         (r_I60_inq_banking_recency_d > 9) => -0.0074392708,
         (r_I60_inq_banking_recency_d = NULL) => -0.0040213380, -0.0009941010),
      (c_food > 70.5) => -0.0922173765,
      (c_food = NULL) => -0.0041847402, -0.0041847402),
   (c_hval_150k_p > 29.45) => 0.1184367095,
   (c_hval_150k_p = NULL) => -0.0023136754, -0.0000079006), 0.0051939722);

// Tree: 301 
wFDN_FLAP___lgt_301 := map(
(NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 94.5) => -0.0004015373,
(f_addrchangecrimediff_i > 94.5) => -0.0628659375,
(f_addrchangecrimediff_i = NULL) => 
   map(
   (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 4.5) => -0.0210181012,
   (f_phones_per_addr_curr_i > 4.5) => 
      map(
      (NULL < f_curraddrcartheftindex_i and f_curraddrcartheftindex_i <= 179.5) => 
         map(
         (NULL < c_ab_av_edu and c_ab_av_edu <= 146.5) => -0.0092131651,
         (c_ab_av_edu > 146.5) => 
            map(
            (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 74.5) => 0.0153428654,
            (f_prevaddrageoldest_d > 74.5) => 0.2183578513,
            (f_prevaddrageoldest_d = NULL) => 0.0734879342, 0.0734879342),
         (c_ab_av_edu = NULL) => 0.0117418490, 0.0117418490),
      (f_curraddrcartheftindex_i > 179.5) => 0.1250035219,
      (f_curraddrcartheftindex_i = NULL) => 0.0192082610, 0.0192082610),
   (f_phones_per_addr_curr_i = NULL) => 0.0122142572, -0.0069637572), -0.0023656463);

// Tree: 302 
wFDN_FLAP___lgt_302 := map(
(NULL < c_hh7p_p and c_hh7p_p <= 18.75) => 
   map(
   (NULL < c_hh2_p and c_hh2_p <= 51.75) => -0.0006635947,
   (c_hh2_p > 51.75) => 
      map(
      (NULL < c_highinc and c_highinc <= 7.55) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 257.5) => 0.0336307048,
         (r_C21_M_Bureau_ADL_FS_d > 257.5) => 0.2840355306,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.1497274877, 0.1497274877),
      (c_highinc > 7.55) => 
         map(
         (NULL < c_civ_emp and c_civ_emp <= 66.15) => -0.0230058341,
         (c_civ_emp > 66.15) => 0.1787442204,
         (c_civ_emp = NULL) => 0.0211086093, 0.0211086093),
      (c_highinc = NULL) => 0.0527686409, 0.0527686409),
   (c_hh2_p = NULL) => 0.0013078347, 0.0013078347),
(c_hh7p_p > 18.75) => -0.1157079230,
(c_hh7p_p = NULL) => -0.0369915215, -0.0001240881);

// Tree: 303 
wFDN_FLAP___lgt_303 := map(
(NULL < f_liens_unrel_O_total_amt_i and f_liens_unrel_O_total_amt_i <= 5089) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 549) => 
      map(
      (NULL < f_rel_bankrupt_count_i and f_rel_bankrupt_count_i <= 2.5) => -0.0032584953,
      (f_rel_bankrupt_count_i > 2.5) => 
         map(
         (NULL < c_many_cars and c_many_cars <= 104.5) => 0.0162274803,
         (c_many_cars > 104.5) => 0.1160474873,
         (c_many_cars = NULL) => 0.0567697601, 0.0567697601),
      (f_rel_bankrupt_count_i = NULL) => 0.0174256349, 0.0174256349),
   (r_I60_inq_hiRiskCred_recency_d > 549) => -0.0041703999,
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0025230535, -0.0025230535),
(f_liens_unrel_O_total_amt_i > 5089) => -0.1089085593,
(f_liens_unrel_O_total_amt_i = NULL) => 
   map(
   (NULL < c_civ_emp and c_civ_emp <= 61.25) => 0.0337615355,
   (c_civ_emp > 61.25) => -0.0716826445,
   (c_civ_emp = NULL) => -0.0227565450, -0.0227565450), -0.0035438741);

// Tree: 304 
wFDN_FLAP___lgt_304 := map(
(NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 1.5) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 14.95) => 
      map(
      (NULL < f_util_adl_count_n and f_util_adl_count_n <= 8.5) => 
         map(
         (NULL < f_liens_unrel_OT_total_amt_i and f_liens_unrel_OT_total_amt_i <= 1193.5) => 0.0133337786,
         (f_liens_unrel_OT_total_amt_i > 1193.5) => 0.1258443811,
         (f_liens_unrel_OT_total_amt_i = NULL) => 0.0156102577, 0.0156102577),
      (f_util_adl_count_n > 8.5) => 0.1315597183,
      (f_util_adl_count_n = NULL) => 0.0187274147, 0.0187274147),
   (c_high_ed > 14.95) => -0.0029189693,
   (c_high_ed = NULL) => 0.0046460316, 0.0018501280),
(r_I60_inq_comm_count12_i > 1.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 10.25) => -0.0925697390,
   (c_pop_0_5_p > 10.25) => 0.0314068438,
   (c_pop_0_5_p = NULL) => -0.0517879684, -0.0517879684),
(r_I60_inq_comm_count12_i = NULL) => -0.0048688015, 0.0011221323);

// Tree: 305 
wFDN_FLAP___lgt_305 := map(
(NULL < c_incollege and c_incollege <= 4.35) => 
   map(
   (NULL < c_high_ed and c_high_ed <= 5.05) => 
      map(
      (NULL < c_construction and c_construction <= 13.05) => -0.0007821474,
      (c_construction > 13.05) => 0.1788261823,
      (c_construction = NULL) => 0.0370301326, 0.0370301326),
   (c_high_ed > 5.05) => -0.0239637263,
   (c_high_ed = NULL) => -0.0190641947, -0.0190641947),
(c_incollege > 4.35) => 
   map(
   (NULL < c_exp_homes and c_exp_homes <= 196.5) => 0.0082154861,
   (c_exp_homes > 196.5) => 
      map(
      (NULL < c_rnt2001_p and c_rnt2001_p <= 25.55) => 0.0154248280,
      (c_rnt2001_p > 25.55) => 0.2092705898,
      (c_rnt2001_p = NULL) => 0.0991309524, 0.0991309524),
   (c_exp_homes = NULL) => 0.0096482514, 0.0096482514),
(c_incollege = NULL) => -0.0115191631, 0.0000661496);

// Tree: 306 
wFDN_FLAP___lgt_306 := map(
(NULL < r_A50_pb_total_dollars_d and r_A50_pb_total_dollars_d <= 15.5) => -0.0541986470,
(r_A50_pb_total_dollars_d > 15.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 7.5) => 
      map(
      (NULL < c_lux_prod and c_lux_prod <= 130.5) => 
         map(
         (NULL < f_add_input_nhood_VAC_pct_i and f_add_input_nhood_VAC_pct_i <= 0.0069436074) => 
            map(
            (NULL < f_curraddrburglaryindex_i and f_curraddrburglaryindex_i <= 141.5) => 0.0391354075,
            (f_curraddrburglaryindex_i > 141.5) => 0.1356932848,
            (f_curraddrburglaryindex_i = NULL) => 0.0578172577, 0.0578172577),
         (f_add_input_nhood_VAC_pct_i > 0.0069436074) => 0.0116231619,
         (f_add_input_nhood_VAC_pct_i = NULL) => 0.0230999559, 0.0230999559),
      (c_lux_prod > 130.5) => -0.0042904098,
      (c_lux_prod = NULL) => 0.0344253872, 0.0118393998),
   (f_corraddrnamecount_d > 7.5) => -0.0099757485,
   (f_corraddrnamecount_d = NULL) => 0.0023708435, 0.0023708435),
(r_A50_pb_total_dollars_d = NULL) => -0.0088485524, 0.0000985082);

// Tree: 307 
wFDN_FLAP___lgt_307 := map(
(NULL < f_historical_count_d and f_historical_count_d <= 16.5) => 
   map(
   (NULL < k_inq_adls_per_addr_i and k_inq_adls_per_addr_i <= 3.5) => 
      map(
      (NULL < C_INC_75K_P and C_INC_75K_P <= 16.25) => 0.0127950393,
      (C_INC_75K_P > 16.25) => -0.0104444543,
      (C_INC_75K_P = NULL) => 0.0191682556, -0.0006466106),
   (k_inq_adls_per_addr_i > 3.5) => -0.0440926370,
   (k_inq_adls_per_addr_i = NULL) => -0.0015699524, -0.0015699524),
(f_historical_count_d > 16.5) => 
   map(
   (NULL < c_blue_col and c_blue_col <= 14.95) => -0.0483187938,
   (c_blue_col > 14.95) => 0.2229468508,
   (c_blue_col = NULL) => 0.0912644991, 0.0912644991),
(f_historical_count_d = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 14.85) => -0.0541667094,
   (c_hh4_p > 14.85) => 0.0684438125,
   (c_hh4_p = NULL) => -0.0085233764, -0.0085233764), -0.0009038585);

// Tree: 308 
wFDN_FLAP___lgt_308 := map(
(NULL < c_white_col and c_white_col <= 30.95) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 160.35) => -0.0337811259,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 160.35) => 0.1101054515,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0074486218, -0.0145043670),
(c_white_col > 30.95) => 
   map(
   (NULL < f_hh_collections_ct_i and f_hh_collections_ct_i <= 1.5) => 0.0005146747,
   (f_hh_collections_ct_i > 1.5) => 
      map(
      (NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 1.5) => 0.0185280597,
      (f_srchfraudsrchcount_i > 1.5) => 
         map(
         (NULL < f_phone_ver_experian_d and f_phone_ver_experian_d <= 0.5) => 0.0320472623,
         (f_phone_ver_experian_d > 0.5) => 0.0598881127,
         (f_phone_ver_experian_d = NULL) => 0.1367027721, 0.0577667613),
      (f_srchfraudsrchcount_i = NULL) => 0.0325674459, 0.0325674459),
   (f_hh_collections_ct_i = NULL) => 0.0133271123, 0.0090694033),
(c_white_col = NULL) => 0.0166172860, 0.0033283933);

// Tree: 309 
wFDN_FLAP___lgt_309 := map(
(NULL < f_rel_under25miles_cnt_d and f_rel_under25miles_cnt_d <= 0.5) => 
   map(
   (NULL < f_corraddrnamecount_d and f_corraddrnamecount_d <= 2.5) => 0.0998013219,
   (f_corraddrnamecount_d > 2.5) => 0.0148825788,
   (f_corraddrnamecount_d = NULL) => 0.0322675184, 0.0322675184),
(f_rel_under25miles_cnt_d > 0.5) => 
   map(
   (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= 86.5) => -0.0061287461,
   (f_addrchangecrimediff_i > 86.5) => -0.0802064701,
   (f_addrchangecrimediff_i = NULL) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 344.5) => -0.0085130369,
      (r_C21_M_Bureau_ADL_FS_d > 344.5) => 
         map(
         (NULL < c_span_lang and c_span_lang <= 117.5) => 0.0050160853,
         (c_span_lang > 117.5) => 0.1708326244,
         (c_span_lang = NULL) => 0.0741063099, 0.0741063099),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0006632877, 0.0006632877), -0.0051690817),
(f_rel_under25miles_cnt_d = NULL) => -0.0146606451, -0.0039661543);

// Tree: 310 
wFDN_FLAP___lgt_310 := map(
(NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 3.5) => -0.0013140361,
(f_srchphonesrchcount_i > 3.5) => 
   map(
   (NULL < c_retired and c_retired <= 14.45) => 
      map(
      (NULL < c_hh3_p and c_hh3_p <= 23.45) => 
         map(
         (NULL < c_burglary and c_burglary <= 58) => 
            map(
            (NULL < C_INC_201K_P and C_INC_201K_P <= 5.35) => 0.1486626732,
            (C_INC_201K_P > 5.35) => 0.0275617592,
            (C_INC_201K_P = NULL) => 0.0834143359, 0.0834143359),
         (c_burglary > 58) => -0.0055245356,
         (c_burglary = NULL) => 0.0328282863, 0.0328282863),
      (c_hh3_p > 23.45) => 0.1476722191,
      (c_hh3_p = NULL) => 0.0509804572, 0.0509804572),
   (c_retired > 14.45) => -0.0357611519,
   (c_retired = NULL) => 0.0239671759, 0.0239671759),
(f_srchphonesrchcount_i = NULL) => 0.0245126309, 0.0008750075);

// Tree: 311 
wFDN_FLAP___lgt_311 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 4.5) => 
   map(
   (NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 4.5) => -0.0007403027,
   (f_srchvelocityrisktype_i > 4.5) => 
      map(
      (NULL < c_exp_prod and c_exp_prod <= 58.5) => -0.0327255978,
      (c_exp_prod > 58.5) => 
         map(
         (NULL < c_hh7p_p and c_hh7p_p <= 7.45) => 0.0252085525,
         (c_hh7p_p > 7.45) => 0.1266006451,
         (c_hh7p_p = NULL) => 0.0293106754, 0.0293106754),
      (c_exp_prod = NULL) => 0.0186445146, 0.0186445146),
   (f_srchvelocityrisktype_i = NULL) => 0.0017435371, 0.0017435371),
(r_D33_eviction_count_i > 4.5) => -0.0703343337,
(r_D33_eviction_count_i = NULL) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 12.3) => -0.0410310453,
   (c_hh4_p > 12.3) => 0.0581920810,
   (c_hh4_p = NULL) => 0.0039294338, 0.0039294338), 0.0014732251);

// Tree: 312 
wFDN_FLAP___lgt_312 := map(
(NULL < c_famotf18_p and c_famotf18_p <= 54.1) => 
   map(
   (NULL < c_fammar_p and c_fammar_p <= 48.35) => 
      map(
      (NULL < f_add_curr_nhood_VAC_pct_i and f_add_curr_nhood_VAC_pct_i <= 0.14115917195) => 
         map(
         (NULL < c_info and c_info <= 0.65) => -0.0555858836,
         (c_info > 0.65) => 0.0479081277,
         (c_info = NULL) => -0.0424951233, -0.0424951233),
      (f_add_curr_nhood_VAC_pct_i > 0.14115917195) => 0.0477906939,
      (f_add_curr_nhood_VAC_pct_i = NULL) => -0.0318314441, -0.0318314441),
   (c_fammar_p > 48.35) => 0.0033561882,
   (c_fammar_p = NULL) => 0.0011404580, 0.0011404580),
(c_famotf18_p > 54.1) => 
   map(
   (NULL < f_srchphonesrchcount_i and f_srchphonesrchcount_i <= 0.5) => -0.0016358639,
   (f_srchphonesrchcount_i > 0.5) => 0.1268234718,
   (f_srchphonesrchcount_i = NULL) => 0.0544976273, 0.0544976273),
(c_famotf18_p = NULL) => -0.0164124580, 0.0012343517);

// Tree: 313 
wFDN_FLAP___lgt_313 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 4.5) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0007352001,
   (r_D33_eviction_count_i > 2.5) => 0.0795975727,
   (r_D33_eviction_count_i = NULL) => 0.0012374217, 0.0012374217),
(f_srchfraudsrchcount_i > 4.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 259.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0060677825) => -0.0722473063,
      (f_add_input_nhood_BUS_pct_i > 0.0060677825) => 
         map(
         (NULL < f_inq_Collection_count24_i and f_inq_Collection_count24_i <= 1.5) => -0.0297241749,
         (f_inq_Collection_count24_i > 1.5) => 0.0631965120,
         (f_inq_Collection_count24_i = NULL) => -0.0083607134, -0.0083607134),
      (f_add_input_nhood_BUS_pct_i = NULL) => -0.0166721731, -0.0166721731),
   (r_C10_M_Hdr_FS_d > 259.5) => -0.0656113878,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0374487561, -0.0374487561),
(f_srchfraudsrchcount_i = NULL) => 0.0160340972, -0.0014034335);

// Tree: 314 
wFDN_FLAP___lgt_314 := map(
(NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 6006) => 
   map(
   (NULL < c_trailer_p and c_trailer_p <= 54.35) => 
      map(
      (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 1.5) => 
         map(
         (NULL < c_lowrent and c_lowrent <= 80.1) => -0.0312160194,
         (c_lowrent > 80.1) => 0.0935649157,
         (c_lowrent = NULL) => -0.0261943476, -0.0261943476),
      (f_phones_per_addr_curr_i > 1.5) => 0.0016224057,
      (f_phones_per_addr_curr_i = NULL) => -0.0040133391, -0.0040133391),
   (c_trailer_p > 54.35) => 0.1007062329,
   (c_trailer_p = NULL) => -0.0223001113, -0.0037427901),
(f_liens_unrel_ST_total_amt_i > 6006) => 0.1112789960,
(f_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < c_hh3_p and c_hh3_p <= 13.75) => 0.0582264895,
   (c_hh3_p > 13.75) => -0.0247587882,
   (c_hh3_p = NULL) => 0.0099792350, 0.0099792350), -0.0030999475);

// Tree: 315 
wFDN_FLAP___lgt_315 := map(
(NULL < f_mos_liens_unrel_FT_fseen_d and f_mos_liens_unrel_FT_fseen_d <= 270.5) => 
   map(
   (NULL < c_pop_0_5_p and c_pop_0_5_p <= 6.75) => 0.0147797067,
   (c_pop_0_5_p > 6.75) => -0.1069547558,
   (c_pop_0_5_p = NULL) => -0.0584058928, -0.0584058928),
(f_mos_liens_unrel_FT_fseen_d > 270.5) => 
   map(
   (NULL < f_inq_Other_count24_i and f_inq_Other_count24_i <= 2.5) => -0.0025940876,
   (f_inq_Other_count24_i > 2.5) => 
      map(
      (NULL < f_add_input_nhood_SFD_pct_d and f_add_input_nhood_SFD_pct_d <= 0.8488023952) => -0.0065210883,
      (f_add_input_nhood_SFD_pct_d > 0.8488023952) => 0.1005252648,
      (f_add_input_nhood_SFD_pct_d = NULL) => 0.0418660258, 0.0418660258),
   (f_inq_Other_count24_i = NULL) => -0.0011697526, -0.0011697526),
(f_mos_liens_unrel_FT_fseen_d = NULL) => 
   map(
   (NULL < c_hval_150k_p and c_hval_150k_p <= 0.65) => -0.0624132804,
   (c_hval_150k_p > 0.65) => 0.0301118128,
   (c_hval_150k_p = NULL) => -0.0100541191, -0.0100541191), -0.0020370472);

// Tree: 316 
wFDN_FLAP___lgt_316 := map(
(NULL < f_assocsuspicousidcount_i and f_assocsuspicousidcount_i <= 16.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
      map(
      (NULL < f_mos_liens_unrel_SC_fseen_d and f_mos_liens_unrel_SC_fseen_d <= 57.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 57.95) => 0.1256817445,
         (r_C12_source_profile_d > 57.95) => -0.0384512874,
         (r_C12_source_profile_d = NULL) => 0.0405300212, 0.0405300212),
      (f_mos_liens_unrel_SC_fseen_d > 57.5) => -0.0058670826,
      (f_mos_liens_unrel_SC_fseen_d = NULL) => -0.0053682294, -0.0053682294),
   (k_comb_age_d > 84.5) => 0.0598293105,
   (k_comb_age_d = NULL) => -0.0048817196, -0.0048817196),
(f_assocsuspicousidcount_i > 16.5) => 0.0794778642,
(f_assocsuspicousidcount_i = NULL) => 
   map(
   (NULL < c_relig_indx and c_relig_indx <= 93.5) => -0.0421666179,
   (c_relig_indx > 93.5) => 0.0452975724,
   (c_relig_indx = NULL) => 0.0087453735, 0.0087453735), -0.0043273397);

// Tree: 317 
wFDN_FLAP___lgt_317 := map(
(NULL < f_mos_liens_rel_SC_lseen_d and f_mos_liens_rel_SC_lseen_d <= 105.5) => -0.1049587286,
(f_mos_liens_rel_SC_lseen_d > 105.5) => 
   map(
   (NULL < c_hh6_p and c_hh6_p <= 1.25) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 3.655) => 
         map(
         (NULL < f_phones_per_addr_curr_i and f_phones_per_addr_curr_i <= 50.5) => 0.0048712962,
         (f_phones_per_addr_curr_i > 50.5) => 
            map(
            (NULL < c_easiqlife and c_easiqlife <= 126.5) => 0.1624835427,
            (c_easiqlife > 126.5) => 0.0095468891,
            (c_easiqlife = NULL) => 0.0743505559, 0.0743505559),
         (f_phones_per_addr_curr_i = NULL) => 0.0062277741, 0.0062277741),
      (c_hhsize > 3.655) => 0.1371203079,
      (c_hhsize = NULL) => 0.0073655967, 0.0073655967),
   (c_hh6_p > 1.25) => -0.0145666913,
   (c_hh6_p = NULL) => 0.0182378842, -0.0031655903),
(f_mos_liens_rel_SC_lseen_d = NULL) => 0.0126226505, -0.0035788135);

// Tree: 318 
wFDN_FLAP___lgt_318 := map(
(NULL < f_srchvelocityrisktype_i and f_srchvelocityrisktype_i <= 1.5) => 
   map(
   (NULL < C_INC_150K_P and C_INC_150K_P <= 13.85) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 84.05) => -0.0982091598,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 84.05) => 0.0148032066,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < c_rnt750_p and c_rnt750_p <= 50.65) => 0.0079392757,
         (c_rnt750_p > 50.65) => 0.1105919641,
         (c_rnt750_p = NULL) => 0.0233459327, 0.0233459327), 0.0126574890),
   (C_INC_150K_P > 13.85) => 
      map(
      (NULL < f_add_curr_nhood_MFD_pct_i and f_add_curr_nhood_MFD_pct_i <= 0.0650319829) => 0.3883299822,
      (f_add_curr_nhood_MFD_pct_i > 0.0650319829) => 0.0983076654,
      (f_add_curr_nhood_MFD_pct_i = NULL) => -0.0086600339, 0.1550890977),
   (C_INC_150K_P = NULL) => -0.0522590886, 0.0179828156),
(f_srchvelocityrisktype_i > 1.5) => -0.0107531223,
(f_srchvelocityrisktype_i = NULL) => -0.0015812037, -0.0022105819);

// Tree: 319 
wFDN_FLAP___lgt_319 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 5.5) => 
   map(
   (NULL < f_inq_PrepaidCards_count24_i and f_inq_PrepaidCards_count24_i <= 0.5) => 
      map(
      (NULL < c_span_lang and c_span_lang <= 182.5) => -0.0002238914,
      (c_span_lang > 182.5) => -0.0297755120,
      (c_span_lang = NULL) => 0.0108957913, -0.0023137831),
   (f_inq_PrepaidCards_count24_i > 0.5) => 
      map(
      (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0456597222) => 0.0159103686,
      (f_add_input_nhood_BUS_pct_i > 0.0456597222) => 0.0525725874,
      (f_add_input_nhood_BUS_pct_i = NULL) => 0.0345033510, 0.0345033510),
   (f_inq_PrepaidCards_count24_i = NULL) => -0.0018856425, -0.0018856425),
(r_I60_inq_hiRiskCred_count12_i > 5.5) => -0.0638469445,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < f_add_input_nhood_BUS_pct_i and f_add_input_nhood_BUS_pct_i <= 0.0550782827) => -0.0639241228,
   (f_add_input_nhood_BUS_pct_i > 0.0550782827) => 0.0329179000,
   (f_add_input_nhood_BUS_pct_i = NULL) => -0.0162840955, -0.0162840955), -0.0023632904);

// Tree: 320 
wFDN_FLAP___lgt_320 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 5.5) => 0.0012611064,
(f_srchfraudsrchcount_i > 5.5) => 
   map(
   (NULL < f_mos_inq_banko_cm_fseen_d and f_mos_inq_banko_cm_fseen_d <= 42.5) => -0.0659093779,
   (f_mos_inq_banko_cm_fseen_d > 42.5) => 
      map(
      (NULL < r_C20_email_count_i and r_C20_email_count_i <= 6.5) => 
         map(
         (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 2.5) => -0.0578902039,
         (r_C14_addrs_5yr_i > 2.5) => 0.0301764172,
         (r_C14_addrs_5yr_i = NULL) => -0.0302872331, -0.0302872331),
      (r_C20_email_count_i > 6.5) => 0.0802052595,
      (r_C20_email_count_i = NULL) => -0.0175701726, -0.0175701726),
   (f_mos_inq_banko_cm_fseen_d = NULL) => -0.0289400001, -0.0289400001),
(f_srchfraudsrchcount_i = NULL) => 
   map(
   (NULL < c_work_home and c_work_home <= 116.5) => 0.0578504039,
   (c_work_home > 116.5) => -0.0525266764,
   (c_work_home = NULL) => 0.0013581974, 0.0013581974), -0.0003876070);

// Tree: 321 
wFDN_FLAP___lgt_321 := map(
(NULL < C_INC_15K_P and C_INC_15K_P <= 27.75) => 
   map(
   (NULL < f_rel_incomeover100_count_d and f_rel_incomeover100_count_d <= 11.5) => -0.0071983493,
   (f_rel_incomeover100_count_d > 11.5) => 0.0821373578,
   (f_rel_incomeover100_count_d = NULL) => 0.0285340620, -0.0054075759),
(C_INC_15K_P > 27.75) => 
   map(
   (NULL < c_hh4_p and c_hh4_p <= 20.4) => 
      map(
      (NULL < f_fp_prevaddrcrimeindex_i and f_fp_prevaddrcrimeindex_i <= 82) => 0.1000189328,
      (f_fp_prevaddrcrimeindex_i > 82) => -0.0013825443,
      (f_fp_prevaddrcrimeindex_i = NULL) => 0.0151246729, 0.0151246729),
   (c_hh4_p > 20.4) => 0.1298182047,
   (c_hh4_p = NULL) => 0.0285234500, 0.0285234500),
(C_INC_15K_P = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 0.0696798632,
   (r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0620099408,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0017109321, 0.0017109321), -0.0035219416);

// Tree: 322 
wFDN_FLAP___lgt_322 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 43.35) => 
   map(
   (NULL < c_asian_lang and c_asian_lang <= 196.5) => 
      map(
      (NULL < f_addrchangevaluediff_d and f_addrchangevaluediff_d <= 247248) => 0.0036669338,
      (f_addrchangevaluediff_d > 247248) => 0.0895678822,
      (f_addrchangevaluediff_d = NULL) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 159.5) => -0.0081505553,
         (r_C13_Curr_Addr_LRes_d > 159.5) => 
            map(
            (NULL < f_add_curr_nhood_BUS_pct_i and f_add_curr_nhood_BUS_pct_i <= 0.13451778185) => 0.0257807666,
            (f_add_curr_nhood_BUS_pct_i > 0.13451778185) => 0.1849907426,
            (f_add_curr_nhood_BUS_pct_i = NULL) => 0.0450674858, 0.0450674858),
         (r_C13_Curr_Addr_LRes_d = NULL) => -0.0179290665, 0.0007889736), 0.0036963006),
   (c_asian_lang > 196.5) => -0.0614622831,
   (c_asian_lang = NULL) => 0.0016829438, 0.0016829438),
(c_hval_80k_p > 43.35) => -0.1102321967,
(c_hval_80k_p = NULL) => 0.0173396522, 0.0012554846);

// Tree: 323 
wFDN_FLAP___lgt_323 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
   (NULL < c_white_col and c_white_col <= 14.15) => 
      map(
      (NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => -0.1104907262,
      (k_inf_phn_verd_d > 0.5) => 0.0430548429,
      (k_inf_phn_verd_d = NULL) => -0.0550437152, -0.0550437152),
   (c_white_col > 14.15) => 
      map(
      (NULL < c_unempl and c_unempl <= 190.5) => 0.0038734750,
      (c_unempl > 190.5) => 
         map(
         (NULL < f_add_curr_mobility_index_i and f_add_curr_mobility_index_i <= 0.28057135475) => -0.0080237952,
         (f_add_curr_mobility_index_i > 0.28057135475) => 0.1659152314,
         (f_add_curr_mobility_index_i = NULL) => 0.0822275865, 0.0822275865),
      (c_unempl = NULL) => 0.0045713183, 0.0045713183),
   (c_white_col = NULL) => 0.0391778232, 0.0045152646),
(r_L77_Add_PO_Box_i > 0.5) => -0.0908928368,
(r_L77_Add_PO_Box_i = NULL) => 0.0022663862, 0.0022663862);

// Tree: 324 
wFDN_FLAP___lgt_324 := map(
(NULL < f_srchfraudsrchcount_i and f_srchfraudsrchcount_i <= 5.5) => 
   map(
   (NULL < c_famotf18_p and c_famotf18_p <= 40.45) => 
      map(
      (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 2.5) => 0.0067133299,
      (r_D33_eviction_count_i > 2.5) => 0.0771980224,
      (r_D33_eviction_count_i = NULL) => 0.0071763863, 0.0071763863),
   (c_famotf18_p > 40.45) => -0.0392953049,
   (c_famotf18_p = NULL) => 0.0009189735, 0.0057587449),
(f_srchfraudsrchcount_i > 5.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 26.5) => 0.0489440753,
   (k_comb_age_d > 26.5) => 
      map(
      (NULL < c_hhsize and c_hhsize <= 3.105) => -0.0249851786,
      (c_hhsize > 3.105) => -0.1001216064,
      (c_hhsize = NULL) => -0.0385301809, -0.0385301809),
   (k_comb_age_d = NULL) => -0.0262152276, -0.0262152276),
(f_srchfraudsrchcount_i = NULL) => -0.0207397660, 0.0036919864);

// Tree: 325 
wFDN_FLAP___lgt_325 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 86.55) => -0.0415274102,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 86.55) => 
   map(
   (NULL < r_I60_inq_PrepaidCards_recency_d and r_I60_inq_PrepaidCards_recency_d <= 61.5) => -0.0875880802,
   (r_I60_inq_PrepaidCards_recency_d > 61.5) => 
      map(
      (NULL < f_addrchangecrimediff_i and f_addrchangecrimediff_i <= -22.5) => 0.0926070361,
      (f_addrchangecrimediff_i > -22.5) => 0.0126868066,
      (f_addrchangecrimediff_i = NULL) => 0.0088012786, 0.0136010531),
   (r_I60_inq_PrepaidCards_recency_d = NULL) => 0.0125805576, 0.0125805576),
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < f_rel_homeover300_count_d and f_rel_homeover300_count_d <= 18.5) => -0.0057172363,
   (f_rel_homeover300_count_d > 18.5) => -0.0658856732,
   (f_rel_homeover300_count_d = NULL) => 
      map(
      (NULL < c_lar_fam and c_lar_fam <= 124.5) => -0.0044412040,
      (c_lar_fam > 124.5) => 0.0833983530,
      (c_lar_fam = NULL) => 0.0195150389, 0.0195150389), -0.0054382567), -0.0003402831);

// Tree: 326 
wFDN_FLAP___lgt_326 := map(
(NULL < f_dl_addrs_per_adl_i and f_dl_addrs_per_adl_i <= 4.5) => 
   map(
   (NULL < f_liens_unrel_ST_total_amt_i and f_liens_unrel_ST_total_amt_i <= 3749.5) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0018617216,
      (r_P85_Phn_Disconnected_i > 0.5) => 0.0498610178,
      (r_P85_Phn_Disconnected_i = NULL) => -0.0008423468, -0.0008423468),
   (f_liens_unrel_ST_total_amt_i > 3749.5) => 0.1081613430,
   (f_liens_unrel_ST_total_amt_i = NULL) => -0.0002947227, -0.0002947227),
(f_dl_addrs_per_adl_i > 4.5) => 
   map(
   (NULL < c_unemp and c_unemp <= 4.55) => -0.0168385455,
   (c_unemp > 4.55) => 0.1346566826,
   (c_unemp = NULL) => 0.0560116188, 0.0560116188),
(f_dl_addrs_per_adl_i = NULL) => 
   map(
   (NULL < c_assault and c_assault <= 92.5) => -0.0597296812,
   (c_assault > 92.5) => 0.0670938120,
   (c_assault = NULL) => -0.0050980226, -0.0050980226), 0.0004662508);

// Tree: 327 
wFDN_FLAP___lgt_327 := map(
(NULL < c_hval_80k_p and c_hval_80k_p <= 50.1) => 
   map(
   (NULL < f_rel_ageover50_count_d and f_rel_ageover50_count_d <= 4.5) => 
      map(
      (NULL < c_no_labfor and c_no_labfor <= 128.5) => -0.0057209306,
      (c_no_labfor > 128.5) => 
         map(
         (NULL < c_relig_indx and c_relig_indx <= 158.5) => 0.0337500824,
         (c_relig_indx > 158.5) => -0.0412824881,
         (c_relig_indx = NULL) => 0.0190333571, 0.0190333571),
      (c_no_labfor = NULL) => -0.0001603221, -0.0001603221),
   (f_rel_ageover50_count_d > 4.5) => -0.0782559787,
   (f_rel_ageover50_count_d = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 196497) => 0.0778812155,
      (r_L80_Inp_AVM_AutoVal_d > 196497) => -0.0495968957,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0192541675, -0.0032517606), -0.0018270652),
(c_hval_80k_p > 50.1) => -0.1337398428,
(c_hval_80k_p = NULL) => -0.0101911819, -0.0025349416);

// Tree: 328 
wFDN_FLAP___lgt_328 := map(
(NULL < c_exp_homes and c_exp_homes <= 115.5) => -0.0036971974,
(c_exp_homes > 115.5) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 24.5) => 0.0133128287,
   (r_P88_Phn_Dst_to_Inp_Add_i > 24.5) => 
      map(
      (NULL < f_prevaddrageoldest_d and f_prevaddrageoldest_d <= 21.5) => -0.0490924710,
      (f_prevaddrageoldest_d > 21.5) => 
         map(
         (NULL < f_add_curr_nhood_SFD_pct_d and f_add_curr_nhood_SFD_pct_d <= 0.947712329) => 0.2659563042,
         (f_add_curr_nhood_SFD_pct_d > 0.947712329) => 0.0110592605,
         (f_add_curr_nhood_SFD_pct_d = NULL) => 0.1683009433, 0.1683009433),
      (f_prevaddrageoldest_d = NULL) => 0.0739905650, 0.0739905650),
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < f_corrphonelastnamecount_d and f_corrphonelastnamecount_d <= 0.5) => 0.0571744884,
      (f_corrphonelastnamecount_d > 0.5) => -0.0580073584,
      (f_corrphonelastnamecount_d = NULL) => 0.0290876398, 0.0290876398), 0.0216683734),
(c_exp_homes = NULL) => 0.0112437441, 0.0041384393);

// Tree: 329 
wFDN_FLAP___lgt_329 := map(
(NULL < c_bel_edu and c_bel_edu <= 183.5) => 0.0027127171,
(c_bel_edu > 183.5) => 
   map(
   (NULL < f_bus_addr_match_count_d and f_bus_addr_match_count_d <= 3.5) => 
      map(
      (NULL < f_prevaddrmedianincome_d and f_prevaddrmedianincome_d <= 53081.5) => 
         map(
         (NULL < C_OWNOCC_P and C_OWNOCC_P <= 26.75) => -0.0320299804,
         (C_OWNOCC_P > 26.75) => 0.0709187976,
         (C_OWNOCC_P = NULL) => 0.0381423704, 0.0381423704),
      (f_prevaddrmedianincome_d > 53081.5) => 
         map(
         (NULL < f_curraddrmurderindex_i and f_curraddrmurderindex_i <= 72.5) => 0.0224692707,
         (f_curraddrmurderindex_i > 72.5) => 0.2748197643,
         (f_curraddrmurderindex_i = NULL) => 0.1486445175, 0.1486445175),
      (f_prevaddrmedianincome_d = NULL) => 0.0575969738, 0.0575969738),
   (f_bus_addr_match_count_d > 3.5) => -0.0583947238,
   (f_bus_addr_match_count_d = NULL) => 0.0436071355, 0.0436071355),
(c_bel_edu = NULL) => -0.0206960013, 0.0042983978);

// Final Score Sum 

   wFDN_FLAP___lgt := sum(
      wFDN_FLAP___lgt_0, wFDN_FLAP___lgt_1, wFDN_FLAP___lgt_2, wFDN_FLAP___lgt_3, wFDN_FLAP___lgt_4, 
      wFDN_FLAP___lgt_5, wFDN_FLAP___lgt_6, wFDN_FLAP___lgt_7, wFDN_FLAP___lgt_8, wFDN_FLAP___lgt_9, 
      wFDN_FLAP___lgt_10, wFDN_FLAP___lgt_11, wFDN_FLAP___lgt_12, wFDN_FLAP___lgt_13, wFDN_FLAP___lgt_14, 
      wFDN_FLAP___lgt_15, wFDN_FLAP___lgt_16, wFDN_FLAP___lgt_17, wFDN_FLAP___lgt_18, wFDN_FLAP___lgt_19, 
      wFDN_FLAP___lgt_20, wFDN_FLAP___lgt_21, wFDN_FLAP___lgt_22, wFDN_FLAP___lgt_23, wFDN_FLAP___lgt_24, 
      wFDN_FLAP___lgt_25, wFDN_FLAP___lgt_26, wFDN_FLAP___lgt_27, wFDN_FLAP___lgt_28, wFDN_FLAP___lgt_29, 
      wFDN_FLAP___lgt_30, wFDN_FLAP___lgt_31, wFDN_FLAP___lgt_32, wFDN_FLAP___lgt_33, wFDN_FLAP___lgt_34, 
      wFDN_FLAP___lgt_35, wFDN_FLAP___lgt_36, wFDN_FLAP___lgt_37, wFDN_FLAP___lgt_38, wFDN_FLAP___lgt_39, 
      wFDN_FLAP___lgt_40, wFDN_FLAP___lgt_41, wFDN_FLAP___lgt_42, wFDN_FLAP___lgt_43, wFDN_FLAP___lgt_44, 
      wFDN_FLAP___lgt_45, wFDN_FLAP___lgt_46, wFDN_FLAP___lgt_47, wFDN_FLAP___lgt_48, wFDN_FLAP___lgt_49, 
      wFDN_FLAP___lgt_50, wFDN_FLAP___lgt_51, wFDN_FLAP___lgt_52, wFDN_FLAP___lgt_53, wFDN_FLAP___lgt_54, 
      wFDN_FLAP___lgt_55, wFDN_FLAP___lgt_56, wFDN_FLAP___lgt_57, wFDN_FLAP___lgt_58, wFDN_FLAP___lgt_59, 
      wFDN_FLAP___lgt_60, wFDN_FLAP___lgt_61, wFDN_FLAP___lgt_62, wFDN_FLAP___lgt_63, wFDN_FLAP___lgt_64, 
      wFDN_FLAP___lgt_65, wFDN_FLAP___lgt_66, wFDN_FLAP___lgt_67, wFDN_FLAP___lgt_68, wFDN_FLAP___lgt_69, 
      wFDN_FLAP___lgt_70, wFDN_FLAP___lgt_71, wFDN_FLAP___lgt_72, wFDN_FLAP___lgt_73, wFDN_FLAP___lgt_74, 
      wFDN_FLAP___lgt_75, wFDN_FLAP___lgt_76, wFDN_FLAP___lgt_77, wFDN_FLAP___lgt_78, wFDN_FLAP___lgt_79, 
      wFDN_FLAP___lgt_80, wFDN_FLAP___lgt_81, wFDN_FLAP___lgt_82, wFDN_FLAP___lgt_83, wFDN_FLAP___lgt_84, 
      wFDN_FLAP___lgt_85, wFDN_FLAP___lgt_86, wFDN_FLAP___lgt_87, wFDN_FLAP___lgt_88, wFDN_FLAP___lgt_89, 
      wFDN_FLAP___lgt_90, wFDN_FLAP___lgt_91, wFDN_FLAP___lgt_92, wFDN_FLAP___lgt_93, wFDN_FLAP___lgt_94, 
      wFDN_FLAP___lgt_95, wFDN_FLAP___lgt_96, wFDN_FLAP___lgt_97, wFDN_FLAP___lgt_98, wFDN_FLAP___lgt_99, 
      wFDN_FLAP___lgt_100, wFDN_FLAP___lgt_101, wFDN_FLAP___lgt_102, wFDN_FLAP___lgt_103, wFDN_FLAP___lgt_104, 
      wFDN_FLAP___lgt_105, wFDN_FLAP___lgt_106, wFDN_FLAP___lgt_107, wFDN_FLAP___lgt_108, wFDN_FLAP___lgt_109, 
      wFDN_FLAP___lgt_110, wFDN_FLAP___lgt_111, wFDN_FLAP___lgt_112, wFDN_FLAP___lgt_113, wFDN_FLAP___lgt_114, 
      wFDN_FLAP___lgt_115, wFDN_FLAP___lgt_116, wFDN_FLAP___lgt_117, wFDN_FLAP___lgt_118, wFDN_FLAP___lgt_119, 
      wFDN_FLAP___lgt_120, wFDN_FLAP___lgt_121, wFDN_FLAP___lgt_122, wFDN_FLAP___lgt_123, wFDN_FLAP___lgt_124, 
      wFDN_FLAP___lgt_125, wFDN_FLAP___lgt_126, wFDN_FLAP___lgt_127, wFDN_FLAP___lgt_128, wFDN_FLAP___lgt_129, 
      wFDN_FLAP___lgt_130, wFDN_FLAP___lgt_131, wFDN_FLAP___lgt_132, wFDN_FLAP___lgt_133, wFDN_FLAP___lgt_134, 
      wFDN_FLAP___lgt_135, wFDN_FLAP___lgt_136, wFDN_FLAP___lgt_137, wFDN_FLAP___lgt_138, wFDN_FLAP___lgt_139, 
      wFDN_FLAP___lgt_140, wFDN_FLAP___lgt_141, wFDN_FLAP___lgt_142, wFDN_FLAP___lgt_143, wFDN_FLAP___lgt_144, 
      wFDN_FLAP___lgt_145, wFDN_FLAP___lgt_146, wFDN_FLAP___lgt_147, wFDN_FLAP___lgt_148, wFDN_FLAP___lgt_149, 
      wFDN_FLAP___lgt_150, wFDN_FLAP___lgt_151, wFDN_FLAP___lgt_152, wFDN_FLAP___lgt_153, wFDN_FLAP___lgt_154, 
      wFDN_FLAP___lgt_155, wFDN_FLAP___lgt_156, wFDN_FLAP___lgt_157, wFDN_FLAP___lgt_158, wFDN_FLAP___lgt_159, 
      wFDN_FLAP___lgt_160, wFDN_FLAP___lgt_161, wFDN_FLAP___lgt_162, wFDN_FLAP___lgt_163, wFDN_FLAP___lgt_164, 
      wFDN_FLAP___lgt_165, wFDN_FLAP___lgt_166, wFDN_FLAP___lgt_167, wFDN_FLAP___lgt_168, wFDN_FLAP___lgt_169, 
      wFDN_FLAP___lgt_170, wFDN_FLAP___lgt_171, wFDN_FLAP___lgt_172, wFDN_FLAP___lgt_173, wFDN_FLAP___lgt_174, 
      wFDN_FLAP___lgt_175, wFDN_FLAP___lgt_176, wFDN_FLAP___lgt_177, wFDN_FLAP___lgt_178, wFDN_FLAP___lgt_179, 
      wFDN_FLAP___lgt_180, wFDN_FLAP___lgt_181, wFDN_FLAP___lgt_182, wFDN_FLAP___lgt_183, wFDN_FLAP___lgt_184, 
      wFDN_FLAP___lgt_185, wFDN_FLAP___lgt_186, wFDN_FLAP___lgt_187, wFDN_FLAP___lgt_188, wFDN_FLAP___lgt_189, 
      wFDN_FLAP___lgt_190, wFDN_FLAP___lgt_191, wFDN_FLAP___lgt_192, wFDN_FLAP___lgt_193, wFDN_FLAP___lgt_194, 
      wFDN_FLAP___lgt_195, wFDN_FLAP___lgt_196, wFDN_FLAP___lgt_197, wFDN_FLAP___lgt_198, wFDN_FLAP___lgt_199, 
      wFDN_FLAP___lgt_200, wFDN_FLAP___lgt_201, wFDN_FLAP___lgt_202, wFDN_FLAP___lgt_203, wFDN_FLAP___lgt_204, 
      wFDN_FLAP___lgt_205, wFDN_FLAP___lgt_206, wFDN_FLAP___lgt_207, wFDN_FLAP___lgt_208, wFDN_FLAP___lgt_209, 
      wFDN_FLAP___lgt_210, wFDN_FLAP___lgt_211, wFDN_FLAP___lgt_212, wFDN_FLAP___lgt_213, wFDN_FLAP___lgt_214, 
      wFDN_FLAP___lgt_215, wFDN_FLAP___lgt_216, wFDN_FLAP___lgt_217, wFDN_FLAP___lgt_218, wFDN_FLAP___lgt_219, 
      wFDN_FLAP___lgt_220, wFDN_FLAP___lgt_221, wFDN_FLAP___lgt_222, wFDN_FLAP___lgt_223, wFDN_FLAP___lgt_224, 
      wFDN_FLAP___lgt_225, wFDN_FLAP___lgt_226, wFDN_FLAP___lgt_227, wFDN_FLAP___lgt_228, wFDN_FLAP___lgt_229, 
      wFDN_FLAP___lgt_230, wFDN_FLAP___lgt_231, wFDN_FLAP___lgt_232, wFDN_FLAP___lgt_233, wFDN_FLAP___lgt_234, 
      wFDN_FLAP___lgt_235, wFDN_FLAP___lgt_236, wFDN_FLAP___lgt_237, wFDN_FLAP___lgt_238, wFDN_FLAP___lgt_239, 
      wFDN_FLAP___lgt_240, wFDN_FLAP___lgt_241, wFDN_FLAP___lgt_242, wFDN_FLAP___lgt_243, wFDN_FLAP___lgt_244, 
      wFDN_FLAP___lgt_245, wFDN_FLAP___lgt_246, wFDN_FLAP___lgt_247, wFDN_FLAP___lgt_248, wFDN_FLAP___lgt_249, 
      wFDN_FLAP___lgt_250, wFDN_FLAP___lgt_251, wFDN_FLAP___lgt_252, wFDN_FLAP___lgt_253, wFDN_FLAP___lgt_254, 
      wFDN_FLAP___lgt_255, wFDN_FLAP___lgt_256, wFDN_FLAP___lgt_257, wFDN_FLAP___lgt_258, wFDN_FLAP___lgt_259, 
      wFDN_FLAP___lgt_260, wFDN_FLAP___lgt_261, wFDN_FLAP___lgt_262, wFDN_FLAP___lgt_263, wFDN_FLAP___lgt_264, 
      wFDN_FLAP___lgt_265, wFDN_FLAP___lgt_266, wFDN_FLAP___lgt_267, wFDN_FLAP___lgt_268, wFDN_FLAP___lgt_269, 
      wFDN_FLAP___lgt_270, wFDN_FLAP___lgt_271, wFDN_FLAP___lgt_272, wFDN_FLAP___lgt_273, wFDN_FLAP___lgt_274, 
      wFDN_FLAP___lgt_275, wFDN_FLAP___lgt_276, wFDN_FLAP___lgt_277, wFDN_FLAP___lgt_278, wFDN_FLAP___lgt_279, 
      wFDN_FLAP___lgt_280, wFDN_FLAP___lgt_281, wFDN_FLAP___lgt_282, wFDN_FLAP___lgt_283, wFDN_FLAP___lgt_284, 
      wFDN_FLAP___lgt_285, wFDN_FLAP___lgt_286, wFDN_FLAP___lgt_287, wFDN_FLAP___lgt_288, wFDN_FLAP___lgt_289, 
      wFDN_FLAP___lgt_290, wFDN_FLAP___lgt_291, wFDN_FLAP___lgt_292, wFDN_FLAP___lgt_293, wFDN_FLAP___lgt_294, 
      wFDN_FLAP___lgt_295, wFDN_FLAP___lgt_296, wFDN_FLAP___lgt_297, wFDN_FLAP___lgt_298, wFDN_FLAP___lgt_299, 
      wFDN_FLAP___lgt_300, wFDN_FLAP___lgt_301, wFDN_FLAP___lgt_302, wFDN_FLAP___lgt_303, wFDN_FLAP___lgt_304, 
      wFDN_FLAP___lgt_305, wFDN_FLAP___lgt_306, wFDN_FLAP___lgt_307, wFDN_FLAP___lgt_308, wFDN_FLAP___lgt_309, 
      wFDN_FLAP___lgt_310, wFDN_FLAP___lgt_311, wFDN_FLAP___lgt_312, wFDN_FLAP___lgt_313, wFDN_FLAP___lgt_314, 
      wFDN_FLAP___lgt_315, wFDN_FLAP___lgt_316, wFDN_FLAP___lgt_317, wFDN_FLAP___lgt_318, wFDN_FLAP___lgt_319, 
      wFDN_FLAP___lgt_320, wFDN_FLAP___lgt_321, wFDN_FLAP___lgt_322, wFDN_FLAP___lgt_323, wFDN_FLAP___lgt_324, 
      wFDN_FLAP___lgt_325, wFDN_FLAP___lgt_326, wFDN_FLAP___lgt_327, wFDN_FLAP___lgt_328, wFDN_FLAP___lgt_329); 

// *** Here begins the code to populate the output of the transform.  Note the variable names from each sub model must
//     be transformed to their "final_score" equivalent name so that all sub models can use the same layout.
			
		FP3_wFDN_LGT := wFDN_FLAP___lgt;
			
self.final_score_0	:= 	wFDN_FLAP___lgt_0	;
self.final_score_1	:= 	wFDN_FLAP___lgt_1	;
self.final_score_2	:= 	wFDN_FLAP___lgt_2	;
self.final_score_3	:= 	wFDN_FLAP___lgt_3	;
self.final_score_4	:= 	wFDN_FLAP___lgt_4	;
self.final_score_5	:= 	wFDN_FLAP___lgt_5	;
self.final_score_6	:= 	wFDN_FLAP___lgt_6	;
self.final_score_7	:= 	wFDN_FLAP___lgt_7	;
self.final_score_8	:= 	wFDN_FLAP___lgt_8	;
self.final_score_9	:= 	wFDN_FLAP___lgt_9	;
self.final_score_10	:= 	wFDN_FLAP___lgt_10	;
self.final_score_11	:= 	wFDN_FLAP___lgt_11	;
self.final_score_12	:= 	wFDN_FLAP___lgt_12	;
self.final_score_13	:= 	wFDN_FLAP___lgt_13	;
self.final_score_14	:= 	wFDN_FLAP___lgt_14	;
self.final_score_15	:= 	wFDN_FLAP___lgt_15	;
self.final_score_16	:= 	wFDN_FLAP___lgt_16	;
self.final_score_17	:= 	wFDN_FLAP___lgt_17	;
self.final_score_18	:= 	wFDN_FLAP___lgt_18	;
self.final_score_19	:= 	wFDN_FLAP___lgt_19	;
self.final_score_20	:= 	wFDN_FLAP___lgt_20	;
self.final_score_21	:= 	wFDN_FLAP___lgt_21	;
self.final_score_22	:= 	wFDN_FLAP___lgt_22	;
self.final_score_23	:= 	wFDN_FLAP___lgt_23	;
self.final_score_24	:= 	wFDN_FLAP___lgt_24	;
self.final_score_25	:= 	wFDN_FLAP___lgt_25	;
self.final_score_26	:= 	wFDN_FLAP___lgt_26	;
self.final_score_27	:= 	wFDN_FLAP___lgt_27	;
self.final_score_28	:= 	wFDN_FLAP___lgt_28	;
self.final_score_29	:= 	wFDN_FLAP___lgt_29	;
self.final_score_30	:= 	wFDN_FLAP___lgt_30	;
self.final_score_31	:= 	wFDN_FLAP___lgt_31	;
self.final_score_32	:= 	wFDN_FLAP___lgt_32	;
self.final_score_33	:= 	wFDN_FLAP___lgt_33	;
self.final_score_34	:= 	wFDN_FLAP___lgt_34	;
self.final_score_35	:= 	wFDN_FLAP___lgt_35	;
self.final_score_36	:= 	wFDN_FLAP___lgt_36	;
self.final_score_37	:= 	wFDN_FLAP___lgt_37	;
self.final_score_38	:= 	wFDN_FLAP___lgt_38	;
self.final_score_39	:= 	wFDN_FLAP___lgt_39	;
self.final_score_40	:= 	wFDN_FLAP___lgt_40	;
self.final_score_41	:= 	wFDN_FLAP___lgt_41	;
self.final_score_42	:= 	wFDN_FLAP___lgt_42	;
self.final_score_43	:= 	wFDN_FLAP___lgt_43	;
self.final_score_44	:= 	wFDN_FLAP___lgt_44	;
self.final_score_45	:= 	wFDN_FLAP___lgt_45	;
self.final_score_46	:= 	wFDN_FLAP___lgt_46	;
self.final_score_47	:= 	wFDN_FLAP___lgt_47	;
self.final_score_48	:= 	wFDN_FLAP___lgt_48	;
self.final_score_49	:= 	wFDN_FLAP___lgt_49	;
self.final_score_50	:= 	wFDN_FLAP___lgt_50	;
self.final_score_51	:= 	wFDN_FLAP___lgt_51	;
self.final_score_52	:= 	wFDN_FLAP___lgt_52	;
self.final_score_53	:= 	wFDN_FLAP___lgt_53	;
self.final_score_54	:= 	wFDN_FLAP___lgt_54	;
self.final_score_55	:= 	wFDN_FLAP___lgt_55	;
self.final_score_56	:= 	wFDN_FLAP___lgt_56	;
self.final_score_57	:= 	wFDN_FLAP___lgt_57	;
self.final_score_58	:= 	wFDN_FLAP___lgt_58	;
self.final_score_59	:= 	wFDN_FLAP___lgt_59	;
self.final_score_60	:= 	wFDN_FLAP___lgt_60	;
self.final_score_61	:= 	wFDN_FLAP___lgt_61	;
self.final_score_62	:= 	wFDN_FLAP___lgt_62	;
self.final_score_63	:= 	wFDN_FLAP___lgt_63	;
self.final_score_64	:= 	wFDN_FLAP___lgt_64	;
self.final_score_65	:= 	wFDN_FLAP___lgt_65	;
self.final_score_66	:= 	wFDN_FLAP___lgt_66	;
self.final_score_67	:= 	wFDN_FLAP___lgt_67	;
self.final_score_68	:= 	wFDN_FLAP___lgt_68	;
self.final_score_69	:= 	wFDN_FLAP___lgt_69	;
self.final_score_70	:= 	wFDN_FLAP___lgt_70	;
self.final_score_71	:= 	wFDN_FLAP___lgt_71	;
self.final_score_72	:= 	wFDN_FLAP___lgt_72	;
self.final_score_73	:= 	wFDN_FLAP___lgt_73	;
self.final_score_74	:= 	wFDN_FLAP___lgt_74	;
self.final_score_75	:= 	wFDN_FLAP___lgt_75	;
self.final_score_76	:= 	wFDN_FLAP___lgt_76	;
self.final_score_77	:= 	wFDN_FLAP___lgt_77	;
self.final_score_78	:= 	wFDN_FLAP___lgt_78	;
self.final_score_79	:= 	wFDN_FLAP___lgt_79	;
self.final_score_80	:= 	wFDN_FLAP___lgt_80	;
self.final_score_81	:= 	wFDN_FLAP___lgt_81	;
self.final_score_82	:= 	wFDN_FLAP___lgt_82	;
self.final_score_83	:= 	wFDN_FLAP___lgt_83	;
self.final_score_84	:= 	wFDN_FLAP___lgt_84	;
self.final_score_85	:= 	wFDN_FLAP___lgt_85	;
self.final_score_86	:= 	wFDN_FLAP___lgt_86	;
self.final_score_87	:= 	wFDN_FLAP___lgt_87	;
self.final_score_88	:= 	wFDN_FLAP___lgt_88	;
self.final_score_89	:= 	wFDN_FLAP___lgt_89	;
self.final_score_90	:= 	wFDN_FLAP___lgt_90	;
self.final_score_91	:= 	wFDN_FLAP___lgt_91	;
self.final_score_92	:= 	wFDN_FLAP___lgt_92	;
self.final_score_93	:= 	wFDN_FLAP___lgt_93	;
self.final_score_94	:= 	wFDN_FLAP___lgt_94	;
self.final_score_95	:= 	wFDN_FLAP___lgt_95	;
self.final_score_96	:= 	wFDN_FLAP___lgt_96	;
self.final_score_97	:= 	wFDN_FLAP___lgt_97	;
self.final_score_98	:= 	wFDN_FLAP___lgt_98	;
self.final_score_99	:= 	wFDN_FLAP___lgt_99	;
self.final_score_100	:= 	wFDN_FLAP___lgt_100	;
self.final_score_101	:= 	wFDN_FLAP___lgt_101	;
self.final_score_102	:= 	wFDN_FLAP___lgt_102	;
self.final_score_103	:= 	wFDN_FLAP___lgt_103	;
self.final_score_104	:= 	wFDN_FLAP___lgt_104	;
self.final_score_105	:= 	wFDN_FLAP___lgt_105	;
self.final_score_106	:= 	wFDN_FLAP___lgt_106	;
self.final_score_107	:= 	wFDN_FLAP___lgt_107	;
self.final_score_108	:= 	wFDN_FLAP___lgt_108	;
self.final_score_109	:= 	wFDN_FLAP___lgt_109	;
self.final_score_110	:= 	wFDN_FLAP___lgt_110	;
self.final_score_111	:= 	wFDN_FLAP___lgt_111	;
self.final_score_112	:= 	wFDN_FLAP___lgt_112	;
self.final_score_113	:= 	wFDN_FLAP___lgt_113	;
self.final_score_114	:= 	wFDN_FLAP___lgt_114	;
self.final_score_115	:= 	wFDN_FLAP___lgt_115	;
self.final_score_116	:= 	wFDN_FLAP___lgt_116	;
self.final_score_117	:= 	wFDN_FLAP___lgt_117	;
self.final_score_118	:= 	wFDN_FLAP___lgt_118	;
self.final_score_119	:= 	wFDN_FLAP___lgt_119	;
self.final_score_120	:= 	wFDN_FLAP___lgt_120	;
self.final_score_121	:= 	wFDN_FLAP___lgt_121	;
self.final_score_122	:= 	wFDN_FLAP___lgt_122	;
self.final_score_123	:= 	wFDN_FLAP___lgt_123	;
self.final_score_124	:= 	wFDN_FLAP___lgt_124	;
self.final_score_125	:= 	wFDN_FLAP___lgt_125	;
self.final_score_126	:= 	wFDN_FLAP___lgt_126	;
self.final_score_127	:= 	wFDN_FLAP___lgt_127	;
self.final_score_128	:= 	wFDN_FLAP___lgt_128	;
self.final_score_129	:= 	wFDN_FLAP___lgt_129	;
self.final_score_130	:= 	wFDN_FLAP___lgt_130	;
self.final_score_131	:= 	wFDN_FLAP___lgt_131	;
self.final_score_132	:= 	wFDN_FLAP___lgt_132	;
self.final_score_133	:= 	wFDN_FLAP___lgt_133	;
self.final_score_134	:= 	wFDN_FLAP___lgt_134	;
self.final_score_135	:= 	wFDN_FLAP___lgt_135	;
self.final_score_136	:= 	wFDN_FLAP___lgt_136	;
self.final_score_137	:= 	wFDN_FLAP___lgt_137	;
self.final_score_138	:= 	wFDN_FLAP___lgt_138	;
self.final_score_139	:= 	wFDN_FLAP___lgt_139	;
self.final_score_140	:= 	wFDN_FLAP___lgt_140	;
self.final_score_141	:= 	wFDN_FLAP___lgt_141	;
self.final_score_142	:= 	wFDN_FLAP___lgt_142	;
self.final_score_143	:= 	wFDN_FLAP___lgt_143	;
self.final_score_144	:= 	wFDN_FLAP___lgt_144	;
self.final_score_145	:= 	wFDN_FLAP___lgt_145	;
self.final_score_146	:= 	wFDN_FLAP___lgt_146	;
self.final_score_147	:= 	wFDN_FLAP___lgt_147	;
self.final_score_148	:= 	wFDN_FLAP___lgt_148	;
self.final_score_149	:= 	wFDN_FLAP___lgt_149	;
self.final_score_150	:= 	wFDN_FLAP___lgt_150	;
self.final_score_151	:= 	wFDN_FLAP___lgt_151	;
self.final_score_152	:= 	wFDN_FLAP___lgt_152	;
self.final_score_153	:= 	wFDN_FLAP___lgt_153	;
self.final_score_154	:= 	wFDN_FLAP___lgt_154	;
self.final_score_155	:= 	wFDN_FLAP___lgt_155	;
self.final_score_156	:= 	wFDN_FLAP___lgt_156	;
self.final_score_157	:= 	wFDN_FLAP___lgt_157	;
self.final_score_158	:= 	wFDN_FLAP___lgt_158	;
self.final_score_159	:= 	wFDN_FLAP___lgt_159	;
self.final_score_160	:= 	wFDN_FLAP___lgt_160	;
self.final_score_161	:= 	wFDN_FLAP___lgt_161	;
self.final_score_162	:= 	wFDN_FLAP___lgt_162	;
self.final_score_163	:= 	wFDN_FLAP___lgt_163	;
self.final_score_164	:= 	wFDN_FLAP___lgt_164	;
self.final_score_165	:= 	wFDN_FLAP___lgt_165	;
self.final_score_166	:= 	wFDN_FLAP___lgt_166	;
self.final_score_167	:= 	wFDN_FLAP___lgt_167	;
self.final_score_168	:= 	wFDN_FLAP___lgt_168	;
self.final_score_169	:= 	wFDN_FLAP___lgt_169	;
self.final_score_170	:= 	wFDN_FLAP___lgt_170	;
self.final_score_171	:= 	wFDN_FLAP___lgt_171	;
self.final_score_172	:= 	wFDN_FLAP___lgt_172	;
self.final_score_173	:= 	wFDN_FLAP___lgt_173	;
self.final_score_174	:= 	wFDN_FLAP___lgt_174	;
self.final_score_175	:= 	wFDN_FLAP___lgt_175	;
self.final_score_176	:= 	wFDN_FLAP___lgt_176	;
self.final_score_177	:= 	wFDN_FLAP___lgt_177	;
self.final_score_178	:= 	wFDN_FLAP___lgt_178	;
self.final_score_179	:= 	wFDN_FLAP___lgt_179	;
self.final_score_180	:= 	wFDN_FLAP___lgt_180	;
self.final_score_181	:= 	wFDN_FLAP___lgt_181	;
self.final_score_182	:= 	wFDN_FLAP___lgt_182	;
self.final_score_183	:= 	wFDN_FLAP___lgt_183	;
self.final_score_184	:= 	wFDN_FLAP___lgt_184	;
self.final_score_185	:= 	wFDN_FLAP___lgt_185	;
self.final_score_186	:= 	wFDN_FLAP___lgt_186	;
self.final_score_187	:= 	wFDN_FLAP___lgt_187	;
self.final_score_188	:= 	wFDN_FLAP___lgt_188	;
self.final_score_189	:= 	wFDN_FLAP___lgt_189	;
self.final_score_190	:= 	wFDN_FLAP___lgt_190	;
self.final_score_191	:= 	wFDN_FLAP___lgt_191	;
self.final_score_192	:= 	wFDN_FLAP___lgt_192	;
self.final_score_193	:= 	wFDN_FLAP___lgt_193	;
self.final_score_194	:= 	wFDN_FLAP___lgt_194	;
self.final_score_195	:= 	wFDN_FLAP___lgt_195	;
self.final_score_196	:= 	wFDN_FLAP___lgt_196	;
self.final_score_197	:= 	wFDN_FLAP___lgt_197	;
self.final_score_198	:= 	wFDN_FLAP___lgt_198	;
self.final_score_199	:= 	wFDN_FLAP___lgt_199	;
self.final_score_200	:= 	wFDN_FLAP___lgt_200	;
self.final_score_201	:= 	wFDN_FLAP___lgt_201	;
self.final_score_202	:= 	wFDN_FLAP___lgt_202	;
self.final_score_203	:= 	wFDN_FLAP___lgt_203	;
self.final_score_204	:= 	wFDN_FLAP___lgt_204	;
self.final_score_205	:= 	wFDN_FLAP___lgt_205	;
self.final_score_206	:= 	wFDN_FLAP___lgt_206	;
self.final_score_207	:= 	wFDN_FLAP___lgt_207	;
self.final_score_208	:= 	wFDN_FLAP___lgt_208	;
self.final_score_209	:= 	wFDN_FLAP___lgt_209	;
self.final_score_210	:= 	wFDN_FLAP___lgt_210	;
self.final_score_211	:= 	wFDN_FLAP___lgt_211	;
self.final_score_212	:= 	wFDN_FLAP___lgt_212	;
self.final_score_213	:= 	wFDN_FLAP___lgt_213	;
self.final_score_214	:= 	wFDN_FLAP___lgt_214	;
self.final_score_215	:= 	wFDN_FLAP___lgt_215	;
self.final_score_216	:= 	wFDN_FLAP___lgt_216	;
self.final_score_217	:= 	wFDN_FLAP___lgt_217	;
self.final_score_218	:= 	wFDN_FLAP___lgt_218	;
self.final_score_219	:= 	wFDN_FLAP___lgt_219	;
self.final_score_220	:= 	wFDN_FLAP___lgt_220	;
self.final_score_221	:= 	wFDN_FLAP___lgt_221	;
self.final_score_222	:= 	wFDN_FLAP___lgt_222	;
self.final_score_223	:= 	wFDN_FLAP___lgt_223	;
self.final_score_224	:= 	wFDN_FLAP___lgt_224	;
self.final_score_225	:= 	wFDN_FLAP___lgt_225	;
self.final_score_226	:= 	wFDN_FLAP___lgt_226	;
self.final_score_227	:= 	wFDN_FLAP___lgt_227	;
self.final_score_228	:= 	wFDN_FLAP___lgt_228	;
self.final_score_229	:= 	wFDN_FLAP___lgt_229	;
self.final_score_230	:= 	wFDN_FLAP___lgt_230	;
self.final_score_231	:= 	wFDN_FLAP___lgt_231	;
self.final_score_232	:= 	wFDN_FLAP___lgt_232	;
self.final_score_233	:= 	wFDN_FLAP___lgt_233	;
self.final_score_234	:= 	wFDN_FLAP___lgt_234	;
self.final_score_235	:= 	wFDN_FLAP___lgt_235	;
self.final_score_236	:= 	wFDN_FLAP___lgt_236	;
self.final_score_237	:= 	wFDN_FLAP___lgt_237	;
self.final_score_238	:= 	wFDN_FLAP___lgt_238	;
self.final_score_239	:= 	wFDN_FLAP___lgt_239	;
self.final_score_240	:= 	wFDN_FLAP___lgt_240	;
self.final_score_241	:= 	wFDN_FLAP___lgt_241	;
self.final_score_242	:= 	wFDN_FLAP___lgt_242	;
self.final_score_243	:= 	wFDN_FLAP___lgt_243	;
self.final_score_244	:= 	wFDN_FLAP___lgt_244	;
self.final_score_245	:= 	wFDN_FLAP___lgt_245	;
self.final_score_246	:= 	wFDN_FLAP___lgt_246	;
self.final_score_247	:= 	wFDN_FLAP___lgt_247	;
self.final_score_248	:= 	wFDN_FLAP___lgt_248	;
self.final_score_249	:= 	wFDN_FLAP___lgt_249	;
self.final_score_250	:= 	wFDN_FLAP___lgt_250	;
self.final_score_251	:= 	wFDN_FLAP___lgt_251	;
self.final_score_252	:= 	wFDN_FLAP___lgt_252	;
self.final_score_253	:= 	wFDN_FLAP___lgt_253	;
self.final_score_254	:= 	wFDN_FLAP___lgt_254	;
self.final_score_255	:= 	wFDN_FLAP___lgt_255	;
self.final_score_256	:= 	wFDN_FLAP___lgt_256	;
self.final_score_257	:= 	wFDN_FLAP___lgt_257	;
self.final_score_258	:= 	wFDN_FLAP___lgt_258	;
self.final_score_259	:= 	wFDN_FLAP___lgt_259	;
self.final_score_260	:= 	wFDN_FLAP___lgt_260	;
self.final_score_261	:= 	wFDN_FLAP___lgt_261	;
self.final_score_262	:= 	wFDN_FLAP___lgt_262	;
self.final_score_263	:= 	wFDN_FLAP___lgt_263	;
self.final_score_264	:= 	wFDN_FLAP___lgt_264	;
self.final_score_265	:= 	wFDN_FLAP___lgt_265	;
self.final_score_266	:= 	wFDN_FLAP___lgt_266	;
self.final_score_267	:= 	wFDN_FLAP___lgt_267	;
self.final_score_268	:= 	wFDN_FLAP___lgt_268	;
self.final_score_269	:= 	wFDN_FLAP___lgt_269	;
self.final_score_270	:= 	wFDN_FLAP___lgt_270	;
self.final_score_271	:= 	wFDN_FLAP___lgt_271	;
self.final_score_272	:= 	wFDN_FLAP___lgt_272	;
self.final_score_273	:= 	wFDN_FLAP___lgt_273	;
self.final_score_274	:= 	wFDN_FLAP___lgt_274	;
self.final_score_275	:= 	wFDN_FLAP___lgt_275	;
self.final_score_276	:= 	wFDN_FLAP___lgt_276	;
self.final_score_277	:= 	wFDN_FLAP___lgt_277	;
self.final_score_278	:= 	wFDN_FLAP___lgt_278	;
self.final_score_279	:= 	wFDN_FLAP___lgt_279	;
self.final_score_280	:= 	wFDN_FLAP___lgt_280	;
self.final_score_281	:= 	wFDN_FLAP___lgt_281	;
self.final_score_282	:= 	wFDN_FLAP___lgt_282	;
self.final_score_283	:= 	wFDN_FLAP___lgt_283	;
self.final_score_284	:= 	wFDN_FLAP___lgt_284	;
self.final_score_285	:= 	wFDN_FLAP___lgt_285	;
self.final_score_286	:= 	wFDN_FLAP___lgt_286	;
self.final_score_287	:= 	wFDN_FLAP___lgt_287	;
self.final_score_288	:= 	wFDN_FLAP___lgt_288	;
self.final_score_289	:= 	wFDN_FLAP___lgt_289	;
self.final_score_290	:= 	wFDN_FLAP___lgt_290	;
self.final_score_291	:= 	wFDN_FLAP___lgt_291	;
self.final_score_292	:= 	wFDN_FLAP___lgt_292	;
self.final_score_293	:= 	wFDN_FLAP___lgt_293	;
self.final_score_294	:= 	wFDN_FLAP___lgt_294	;
self.final_score_295	:= 	wFDN_FLAP___lgt_295	;
self.final_score_296	:= 	wFDN_FLAP___lgt_296	;
self.final_score_297	:= 	wFDN_FLAP___lgt_297	;
self.final_score_298	:= 	wFDN_FLAP___lgt_298	;
self.final_score_299	:= 	wFDN_FLAP___lgt_299	;
self.final_score_300	:= 	wFDN_FLAP___lgt_300	;
self.final_score_301	:= 	wFDN_FLAP___lgt_301	;
self.final_score_302	:= 	wFDN_FLAP___lgt_302	;
self.final_score_303	:= 	wFDN_FLAP___lgt_303	;
self.final_score_304	:= 	wFDN_FLAP___lgt_304	;
self.final_score_305	:= 	wFDN_FLAP___lgt_305	;
self.final_score_306	:= 	wFDN_FLAP___lgt_306	;
self.final_score_307	:= 	wFDN_FLAP___lgt_307	;
self.final_score_308	:= 	wFDN_FLAP___lgt_308	;
self.final_score_309	:= 	wFDN_FLAP___lgt_309	;
self.final_score_310	:= 	wFDN_FLAP___lgt_310	;
self.final_score_311	:= 	wFDN_FLAP___lgt_311	;
self.final_score_312	:= 	wFDN_FLAP___lgt_312	;
self.final_score_313	:= 	wFDN_FLAP___lgt_313	;
self.final_score_314	:= 	wFDN_FLAP___lgt_314	;
self.final_score_315	:= 	wFDN_FLAP___lgt_315	;
self.final_score_316	:= 	wFDN_FLAP___lgt_316	;
self.final_score_317	:= 	wFDN_FLAP___lgt_317	;
self.final_score_318	:= 	wFDN_FLAP___lgt_318	;
self.final_score_319	:= 	wFDN_FLAP___lgt_319	;
self.final_score_320	:= 	wFDN_FLAP___lgt_320	;
self.final_score_321	:= 	wFDN_FLAP___lgt_321	;
self.final_score_322	:= 	wFDN_FLAP___lgt_322	;
self.final_score_323	:= 	wFDN_FLAP___lgt_323	;
self.final_score_324	:= 	wFDN_FLAP___lgt_324	;
self.final_score_325	:= 	wFDN_FLAP___lgt_325	;
self.final_score_326	:= 	wFDN_FLAP___lgt_326	;
self.final_score_327	:= 	wFDN_FLAP___lgt_327	;
self.final_score_328	:= 	wFDN_FLAP___lgt_328	;
self.final_score_329	:= 	wFDN_FLAP___lgt_329	;
// self.wFDN_submodel_lgt	:= 	wFDN_FLAP___lgt	;
self.FP3_wFDN_LGT		:= 	wFDN_FLAP___lgt	;
self	:= le;
self	:= [];

end;
			
wScore := PROJECT(allVars, doScore(LEFT));

return wScore;

end;
