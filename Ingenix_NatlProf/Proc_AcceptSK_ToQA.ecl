import autokey, PromoteSupers, roxiekeybuild;
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ing_provider_did',  'Q', mv_did_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ing_provider_id', 'Q',mv_pid_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ing_providersanctions_id', 'Q',mv_psanc_pid_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ing_provider_license', 'Q', mv_lic_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_license_providerid',  'Q',mv_lic_pid_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_language_providerid',  'Q',mv_language_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_UPIN_providerid', 'Q', mv_upin_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_DEA_providerid',  'Q',mv_dea_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_DEA_DEANumber',  'Q',mv_dea_DEANumber_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_degree_providerid', 'Q',mv_degree_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_speciality_providerid', 'Q',mv_speciality_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_group_LinkIDs', 'Q',mv_group_LinkIDs_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_group_providerid', 'Q',mv_group_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_hospital_LinkIDs', 'Q',mv_hospital_LinkIDs_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_hospital_providerid',  'Q',mv_hospital_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_residency_LinkIDs', 'Q',mv_residency_LinkIDs_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_residency_providerid','Q',mv_residency_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_medschool_LinkIDs', 'Q',mv_medschool_LinkIDs_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_medschool_providerid','Q',mv_medschool_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_provider_taxid', 'Q', mv_prov_taxid_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_did', 'Q', mv_san_did_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_bdid', 'Q', mv_san_bdid_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_LinkIDs', 'Q', mv_san_LinkIDs_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_sancid', 'Q',mv_san_sancid_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_upin',  'Q',mv_san_upin_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_license', 'Q',mv_san_license_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_taxid',  'Q',mv_san_taxid_key, 2);
// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_taxid_name', 'Q',mv_san_taxid_name_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_busname', 'Q', mv_san_busname_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_tin', 'Q', mv_san_tin_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_NPI_providerid', 'Q', mv_NPI_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_providerID_UPIN', 'Q', mv_ProviderId_UPIN_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_providerID_NPI', 'Q', mv_ProviderId_NPI_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_lnpid', 'Q', mv_san_lnpid_key, 2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_PID', 'Q', mv_pid_gk_key, 2);


prov_auto_skip_set := ['S'];
autokey.MAC_AcceptSK_to_QA('~thor_data400::key::ingenix_providers_', mv_prov_autokey,false,prov_auto_skip_set);

PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_providers_fdids', 'Q', mv_prov_fdids_key, 2);

// auto_skip_set := ['P','S'];				  
// autokey.MAC_AcceptSK_to_QA('~thor_data400::key::ingenix_sanctions_', mv_san_autokey,false,auto_skip_set);

// PromoteSupers.mac_sk_move_v2('~thor_data400::key::ingenix_sanctions_fdids', 'Q', mv_san_fdids_key, 2);


export Proc_AcceptSK_ToQA :=  parallel(	mv_did_key, mv_pid_key, 
																				// mv_psanc_pid_key, 
																				// mv_lic_key,
																				mv_lic_pid_key,
																				mv_language_key, mv_upin_key,
																				mv_dea_key, 
																				// mv_dea_DEANumber_key,
																				mv_degree_key, mv_speciality_key,
																				// mv_group_LinkIDs_key, 
																				mv_group_key,
																				// mv_hospital_LinkIDs_key, 
																				mv_hospital_key, 
																				// mv_residency_LinkIDs_key, 
																				mv_residency_key,
																				// mv_medschool_LinkIDs_key, 
																				mv_medschool_key,
																				// mv_prov_taxid_key, 
																				mv_san_did_key, 
																				mv_san_bdid_key, mv_san_LinkIDs_key,
																				mv_san_sancid_key, mv_san_upin_key, mv_san_license_key,
																				// mv_san_taxid_key, 
																				// mv_san_autokey,
																				// mv_san_fdids_key, 
																				// mv_san_taxid_name_key,
																				mv_NPI_key, mv_san_lnpid_key, 
																				mv_prov_autokey, mv_prov_fdids_key,
																				mv_ProviderId_UPIN_key, mv_ProviderId_NPI_key,
																				mv_san_busname_key, mv_san_tin_key, mv_pid_gk_key
																			);
					  
