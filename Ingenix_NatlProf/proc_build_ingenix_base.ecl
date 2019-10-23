import PromoteSupers,Enclarity,Enclarity_facility_sanctions;

Export proc_build_ingenix_base(string filedate, boolean pUseProd = true) := function

//build provider did file
// Provider_did
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).Provider_did,
																	'~thor_data400::base::ingenix_providers_did',bld_prov_did,pCompress:=true);
				   
//build provider group bdid file
// Group_BDID
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).Group_BDID,
																	'~thor_data400::base::ingenix_providers_group_bdid', bld_prov_grp,pCompress:=true);
				   
//build provider hospital bdid file
// Hospital_BDID
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).Hospital_BDID,
																	'~thor_data400::base::ingenix_providers_hospital_bdid', bld_prov_hsp,pCompress:=true);
				  
//build provider residency bdid file
// Residency_BDID
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).Residency_BDID,
																	'~thor_data400::base::ingenix_providers_residency_bdid', bld_prov_rsd,pCompress:=true);

//build provider medschool bdid file
// Medschool_BDID
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).Medschool_BDID,
																	'~thor_data400::base::ingenix_providers_medschool_bdid', bld_prov_med,pCompress:=true);
				  
//build sanction did file
// update_BWR_Sanctions_Did_File - Enclarity backfill + Enclarity Facility Sanctions
d1a:=Enclarity.As_Ingenix(filedate,pUseProd).update_BWR_Sanctions_Did_File;
d1b:=Enclarity_Facility_Sanctions.As_Ingenix(filedate,pUseProd).update_BWR_Sanctions_Did_File;
d1:=d1a + d1b;
PromoteSupers.MAC_SF_BuildProcess(d1,'~thor_data400::base::ingenix_sanctions_did',bld_sanc_did,pCompress:=true);

//build sanction bdid file
// Sanctioned_providers_Bdid - Enclarity backfill + Enclarity Facility Sanctions
d2a:=Enclarity.As_Ingenix(filedate,pUseProd).Sanctioned_providers_Bdid;
d2b:=Enclarity_Facility_Sanctions.As_Ingenix(filedate,pUseProd).Sanctioned_facilities_bdid;
d2:=d2a + d2b;
PromoteSupers.MAC_SF_BuildProcess(d2,'~thor_data400::base::ingenix_sanctions_bdid', bld_sanc_bdid,pCompress:=true);

//build provider license file
// update_providerlicense
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).update_providerlicense,
																	'~thor_data400::base::ingenix_providerlicense',bld_prov_lic,pCompress:=true);
					   
//build provider language file
// update_language
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).update_language,
																	'~thor_data400::base::ingenix_language', bld_prov_language,pCompress:=true);
					   
//build provider UPIN file
// update_UPIN
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).update_UPIN,
																	'~thor_data400::base::ingenix_UPIN', bld_prov_UPIN,pCompress:=true);	
					   
//build provider DEA file
// update_DEA
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).update_DEA,
																	'~thor_data400::base::ingenix_DEA', bld_prov_DEA,pCompress:=true);

//build provider degree file
// update_degree
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).update_degree,
																	'~thor_data400::base::ingenix_degree', bld_prov_degree,pCompress:=true);	
					   
//build provider speciality file
// File_in_Provider_Speciality_Joined
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).File_in_Provider_Speciality_Joined,
																	'~thor_data400::base::ingenix_speciality', bld_prov_speciality,pCompress:=true);	
											 
//build provider NPI file
// update_NPI
PromoteSupers.MAC_SF_BuildProcess(Enclarity.As_Ingenix(filedate,pUseProd).update_NPI,
																	'~thor_data400::base::ingenix_NPI', bld_prov_NPI,pCompress:=true);												 
					   
//build NewProviderSaction file					   
// update_ProviderSanctions
d3a:=Enclarity.As_Ingenix(filedate,pUseProd).update_ProviderSanctions;
d3b:=Enclarity_Facility_Sanctions.As_Ingenix(filedate,pUseProd).update_ProviderSanctions;
d3:=d3a + d3b;
PromoteSupers.MAC_SF_BuildProcess(d3,'~thor_data400::base::ingenix_ProviderSanctions', bld_ProviderSanctions,pCompress:=true);						   
					 					   
return parallel(	 bld_prov_did, 
									 bld_prov_grp, 
									 bld_ProviderSanctions,        
									 bld_prov_hsp, 
									 bld_prov_rsd, 
									 bld_prov_med, 
									 bld_prov_lic,
									 sequential(bld_sanc_did, bld_sanc_bdid),
									 bld_prov_language, 
									 bld_prov_UPIN, 
									 bld_prov_DEA, 
									 bld_prov_NPI,
									 bld_prov_degree, 
									 bld_prov_speciality
								);
end;