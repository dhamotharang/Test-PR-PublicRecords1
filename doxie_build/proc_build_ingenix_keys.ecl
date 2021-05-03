import ut, doxie_files, ingenix_natlprof, autokey, doxie,Roxiekeybuild;


export proc_build_ingenix_keys(string filedate) := function

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_provider_did,
                          '~thor_data400::key::ing_provider_did','~thor_data400::key::ing_provider::'+filedate + '::did',
                          bld_did_key);
		
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_provider_id,
                          '~thor_data400::key::ing_provider_id','~thor_data400::key::ing_provider::' +filedate+ '::id',
                          bld_pid_key);		

// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Ingenix_NatlProf.key_ProviderSanctions_id,
                          // '~thor_data400::key::ing_ProviderSanctions_id','~thor_data400::key::ing_ProviderSanctions::' +filedate+ '::id',
                          // bld_PSanc_pid_key);					 

// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_provider_license,
                          // '~thor_data400::key::ing_provider_license','~thor_data400::key::ing_provider::' + filedate + '::license',
                          // bld_lic_key);	
					 
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_license_providerid,
                          '~thor_data400::key::ingenix_license_providerid','~thor_data400::key::ingenix_license::' + filedate +  '::providerid',
                          bld_lic_pid_key);	
					 
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_language_providerid,
                          '~thor_data400::key::ingenix_language_providerid','~thor_data400::key::ingenix_language::' + filedate + '::providerid',
                          bld_language_key);	
			
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_UPIN_providerid,
                          '~thor_data400::key::ingenix_UPIN_providerid','~thor_data400::key::ingenix_UPIN::' + filedate + '::providerid',
                          bld_upin_key);
																
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_NPI_providerid,
                          '~thor_data400::key::ingenix_NPI_providerid','~thor_data400::key::ingenix_NPI::' + filedate + '::providerid',
                          bld_NPI_key);
			
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_ProviderID_UPIN,
                          '~thor_data400::key::ingenix_ProviderID_UPIN','~thor_data400::key::ingenix_ProviderID_UPIN::' + filedate + '::providerid',
                          bld_ProviderID_UPIN_key);													
			
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_DEA_providerid,
                          '~thor_data400::key::ingenix_DEA_providerid', '~thor_data400::key::ingenix_DEA::' +filedate + '::providerid',
                          bld_dea_key);	

//Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Ingenix_NatlProf.key_DEA_DEANumber,
//                          '~thor_data400::key::ingenix_DEA_DEANumber', '~thor_data400::key::ingenix_DEA::' +filedate + '::DEANumber',
//                          bld_dea_DEANumber_key);

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_degree_providerid,
                          '~thor_data400::key::ingenix_degree_providerid','~thor_data400::key::ingenix_degree::'+ filedate + '::providerid',
                          bld_degree_key);

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_speciality_providerid,
                          '~thor_data400::key::ingenix_speciality_providerid','~thor_data400::key::ingenix_speciality::'+ filedate +'::providerid',
                          bld_speciality_key);	

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_group_providerid,
                          '~thor_data400::key::ingenix_group_providerid','~thor_data400::key::ingenix_group::'+ filedate + '::providerid',
                          bld_group_key);	
													
//Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_group_linkids.key,
//                          '~thor_data400::key::ingenix_group_linkids','~thor_data400::key::ingenix_group::'+ filedate + '::linkids',
//                          bld_group_linkids_key);														

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_hospital_providerid,
                          '~thor_data400::key::ingenix_hospital_providerid','~thor_data400::key::ingenix_hospital::'+ filedate + '::providerid',
                          bld_hospital_key);	

//Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_hospital_linkids.key,
//                          '~thor_data400::key::ingenix_hospital_linkids','~thor_data400::key::ingenix_hospital::'+ filedate + '::linkids',
//                          bld_hospital_linkids_key);	

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_residency_providerid,
                          '~thor_data400::key::ingenix_residency_providerid','~thor_data400::key::ingenix_residency::'+ filedate + '::providerid',
                          bld_residency_key);	

// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_residency_linkids.key,
                          // '~thor_data400::key::ingenix_residency_linkids','~thor_data400::key::ingenix_residency::'+ filedate + '::linkids',
                          // bld_residency_linkids_key);	

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_medschool_providerid,
                          '~thor_data400::key::ingenix_medschool_providerid','~thor_data400::key::ingenix_medschool::'+ filedate + '::providerid',
                          bld_medschool_key);	

// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_medschool_linkids.key,
                          // '~thor_data400::key::ingenix_medschool_linkids','~thor_data400::key::ingenix_medschool::'+ filedate + '::linkids',
                          // bld_medschool_linkids_key);	
					 
// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_provider_taxid,
                          // '~thor_data400::key::ingenix_provider_taxid','~thor_data400::key::ingenix_provider::' + filedate + '::taxid',
                          // bld_prov_taxid_key);
					 					 
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_sanctions_did,
                          '~thor_data400::key::ingenix_sanctions_did','~thor_data400::key::ingenix_sanctions::'+ filedate + '::did',
                          bld_san_did_key);	
						  
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Ingenix_NatlProf.key_sanctions_bdid,
                          '~thor_data400::key::ingenix_sanctions_bdid','~thor_data400::key::ingenix_sanctions::'+ filedate + '::bdid',
                          bld_san_bdid_key);

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Ingenix_NatlProf.Key_Sanctions_LinkIds.key,
                          '~thor_data400::key::ingenix_sanctions_linkids','~thor_data400::key::ingenix_sanctions::'+ filedate + '::linkids',
                          bld_san_linkids_key);													
						  
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_sanctions_sancid,
                          '~thor_data400::key::ingenix_sanctions_sancid', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::sancid',
                          bld_san_sancid_key);	
					 
// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_sanctions_taxid_name,
                          // '~thor_data400::key::ingenix_sanctions_taxid_name','~thor_data400::key::ingenix_sanctions::'+ filedate +'::taxid_name',
                          // bld_san_taxid_name_key);	
					 					 
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_upin_sancid,
                          '~thor_data400::key::ingenix_sanctions_upin','~thor_data400::key::ingenix_sanctions::'+ filedate +'::upin',
                          bld_san_upin_key);					 

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_license_sancid,
                          '~thor_data400::key::ingenix_sanctions_license','~thor_data400::key::ingenix_sanctions::'+ filedate +'::license',
                          bld_san_license_key);	
													
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_sanctions_busname,
                          '~thor_data400::key::ingenix_sanctions_busname','~thor_data400::key::ingenix_sanctions::'+ filedate + '::busname',
                          bld_san_busname_key);
													
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_sanctions_tin,
                          '~thor_data400::key::ingenix_sanctions_tin','~thor_data400::key::ingenix_sanctions::'+ filedate + '::tin',
                          bld_san_tin_key);	
						  
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_ProviderID_NPI,
                          '~thor_data400::key::ingenix_ProviderID_NPI','~thor_data400::key::ingenix_ProviderID_NPI::' + filedate + '::npi',
                          bld_ProviderID_NPI_key);		

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_lnpid,
                          '~thor_data400::key::ingenix_sanctions_lnpid','~thor_data400::key::ingenix_sanctions::' + filedate + '::lnpid',
                          bld_san_lnpid_key);		

Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(ingenix_natlprof.key_pid_gk,
                          '~thor_data400::key::ingenix_PID','~thor_data400::key::ingenix_PID::' + filedate + '::group_key',
                          bld_pid_gk_key);		

f_prov := ingenix_natlprof.Basefile_Provider_Did;
xl_prov := RECORD
	f_prov;
	unsigned6 fdid;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('PROV'))| ut.bit_set(0,0);
END;
xl_prov xpand_prov(f_prov le,integer prov_cntr) :=  TRANSFORM 
	SELF.fdid := prov_cntr + autokey.did_adder('PROV'); 
	SELF := le; 
END;
DS_prov := PROJECT(f_prov,xpand_prov(LEFT,COUNTER));
DS_prov_slim_rec := record
	unsigned6 fdid;
	unsigned6 providerid;
end;
DS_prov_slim_rec slim_it(DS_prov l) := transform
     self.providerid := (unsigned6)l.providerid;
	self := l;
end;
DS_prov_slim := project(DS_prov, slim_it(left));
prov_fdids_key := index(DS_prov_slim,{fdid},{ProviderID},'~thor_data400::key::ingenix_providers_fdids');
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(prov_fdids_key,'~thor_data400::key::ingenix_providers_fdids','~thor_data400::key::ingenix_providers::' + filedate + '::fdids',bld_prov_fdids_key); 

f := Ingenix_NatlProf.Basefile_Sanctions_Bdid;
xl := RECORD
	f;
	unsigned6 fdid;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('SANC'))| ut.bit_set(0,0);
END;
xl xpand(f le,integer cntr) :=  TRANSFORM 
	SELF.fdid := cntr + autokey.did_adder('SANC'); 
	SELF := le; 
END;
DS := PROJECT(f,xpand(LEFT,COUNTER));
sanc_fdids_key := index(DS,{fdid},{sanc_id},'~thor_data400::key::ingenix_sanctions_fdids');
// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(sanc_fdids_key,'~thor_data400::key::ingenix_sanctions_fdids','~thor_data400::key::ingenix_sanctions::' + filedate + '::fdids',bld_san_fdids_key); 
DS_TIN := DS(SANC_TIN<>'');
sanc_taxid_key := index(DS_TIN,{l_taxid := (string10)SANC_TIN},{fdid},'~thor_data400::key::ingenix_sanctions_taxid');
// Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(sanc_taxid_key ,'~thor_data400::key::ingenix_sanctions_taxid','~thor_data400::key::ingenix_sanctions::' + filedate + '::taxid',bld_san_taxid_key); 

prov_auto_skip_set := ['S'];
Ingenix_natlprof.Mac_Build_Local(DS_prov,Prov_Clean_fname,Prov_Clean_mname,Prov_Clean_lname,
				 zero,
				 BirthDate,
				 PhoneNumber,
				 Prov_Clean_prim_name, 
				 Prov_Clean_prim_range, 
				 Prov_Clean_st, 
				 Prov_Clean_v_city_name, 
				 Prov_Clean_zip, 
				 Prov_Clean_sec_range,
				 zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 lookups,
				 fdid,
				 '~thor_data400::key::ingenix_providers_','ingenix_providers', filedate, bld_prov_auto,false,
				 prov_auto_skip_set)

auto_skip_set := ['P','S'];
Ingenix_natlprof.Mac_Build_Local(DS,Prov_Clean_fname,Prov_Clean_mname,Prov_Clean_lname,
				 zero,
				 SANC_DOB,
				 zero,
				 ProvCo_Address_Clean_prim_name, 
				 ProvCo_Address_Clean_prim_range, 
				 ProvCo_Address_Clean_st, 
				 ProvCo_Address_Clean_v_city_name, 
				 ProvCo_Address_Clean_zip, 
				 ProvCo_Address_Clean_sec_range,
				 zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 lookups,
				 fdid,
				 '~thor_data400::key::ingenix_sanctions_','ingenix_sanctions', filedate,bld_sanc_auto,false,
				 auto_skip_set)

	
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ing_provider_did', '~thor_data400::key::ing_provider::'+filedate + '::did', mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ing_provider_id', '~thor_data400::key::ing_provider::' +filedate+ '::id',mv_pid_key);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ing_ProviderSanctions_id', '~thor_data400::key::ing_ProviderSanctions::' +filedate+ '::id',mv_PSanc_pid_key);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ing_provider_license', '~thor_data400::key::ing_provider::' + filedate + '::license',mv_lic_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_license_providerid', '~thor_data400::key::ingenix_license::' + filedate +  '::providerid', mv_lic_pid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_language_providerid', '~thor_data400::key::ingenix_language::' + filedate + '::providerid', mv_language_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_UPIN_providerid', '~thor_data400::key::ingenix_UPIN::' + filedate + '::providerid', mv_upin_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_ProviderID_UPIN', '~thor_data400::key::ingenix_ProviderID_UPIN::' + filedate + '::providerid', mv_ProviderID_UPIN_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_NPI_providerid', '~thor_data400::key::ingenix_NPI::' + filedate + '::providerid', mv_npi_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_DEA_providerid', '~thor_data400::key::ingenix_DEA::' +filedate + '::providerid', mv_dea_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_DEA_DEANumber', '~thor_data400::key::ingenix_DEA::' +filedate + '::DEANumber', mv_dea_DEANumber_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_degree_providerid', '~thor_data400::key::ingenix_degree::'+ filedate + '::providerid', mv_degree_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_speciality_providerid', '~thor_data400::key::ingenix_speciality::'+ filedate +'::providerid', mv_speciality_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_group_linkids', '~thor_data400::key::ingenix_group::'+ filedate + '::linkids', mv_group_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_group_providerid', '~thor_data400::key::ingenix_group::'+ filedate + '::providerid', mv_group_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_hospital_linkids', '~thor_data400::key::ingenix_hospital::'+ filedate + '::linkids', mv_hospital_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_hospital_providerid', '~thor_data400::key::ingenix_hospital::'+ filedate + '::providerid', mv_hospital_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_residency_linkids', '~thor_data400::key::ingenix_residency::'+ filedate + '::linkids',mv_residency_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_residency_providerid', '~thor_data400::key::ingenix_residency::'+ filedate + '::providerid',mv_residency_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_medschool_linkids', '~thor_data400::key::ingenix_medschool::'+ filedate + '::linkids',mv_medschool_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_medschool_providerid', '~thor_data400::key::ingenix_medschool::'+ filedate + '::providerid',mv_medschool_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_provider_taxid', '~thor_data400::key::ingenix_provider::' + filedate + '::taxid', mv_prov_taxid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_did', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::did', mv_san_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_bdid', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::bdid', mv_san_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_linkIDs', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::linkIDs', mv_san_linkIDs_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_sancid', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::sancid', mv_san_sancid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_upin', '~thor_data400::key::ingenix_sanctions::'+ filedate +'::upin', mv_san_upin_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_license', '~thor_data400::key::ingenix_sanctions::'+ filedate +'::license', mv_san_license_key);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_taxid', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::taxid', mv_san_taxid_key);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_taxid_name', '~thor_data400::key::ingenix_sanctions::'+ filedate +'::taxid_name', mv_san_taxid_name_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_providers_fdids', '~thor_data400::key::ingenix_providers::' + filedate + '::fdids', mv_prov_fdids_key);					  
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_fdids', '~thor_data400::key::ingenix_sanctions::' + filedate + '::fdids', mv_san_fdids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_busname', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::busname', mv_san_busname_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_tin', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::tin', mv_san_tin_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ing_provider_search_id', '~thor_data400::key::ing_provider::' + filedate + '::search_id', mv_prov_search_id_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_ProviderID_NPI', '~thor_data400::key::ingenix_ProviderID_NPI::' + filedate + '::npi', mv_ProviderID_NPI_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_sanctions_lnpid', '~thor_data400::key::ingenix_sanctions::'+ filedate + '::lnpid', mv_san_lnpid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ingenix_pid', '~thor_data400::key::ingenix_pid::'+ filedate + '::group_key', mv_pid_gk_key);

email_success := fileservices.sendemail('kevin.reeder@lexisnexis.com',
										'Ingenix Build Succeeded - ' + filedate,
										'keys have been built and ready to be deployed to QA.');
													
build_ingenix_keys := 
       sequential(parallel(	bld_did_key, 
														bld_pid_key, 
														 // bld_PSanc_pid_key,
														 // bld_lic_key, 
														bld_lic_pid_key,
														bld_language_key, 
														bld_upin_key,
														bld_dea_key, 
														 // bld_dea_DEANumber_key,
														bld_degree_key,
														bld_speciality_key, 
														 // bld_group_linkids_key, 
														bld_group_key,
														 // bld_hospital_linkids_key, 
														bld_hospital_key,
														 // bld_residency_linkids_key, 
														bld_residency_key,
														 // bld_medschool_linkids_key, 
														bld_medschool_key, 
														 // bld_prov_taxid_key,
														bld_san_did_key,  
														bld_san_bdid_key,
														bld_san_Linkids_key,
														bld_san_sancid_key,
														bld_san_upin_key, 
														bld_san_license_key,
														 // bld_san_taxid_key,
														//bld_sanc_auto//, <---------------------------------
														 // bld_san_taxid_name_key,
														bld_npi_key,
														 // bld_san_fdids_key,
														bld_prov_auto,
														bld_prov_fdids_key,bld_ProviderID_UPIN_key,
														bld_ProviderID_NPI_key,bld_san_busname_key, bld_san_tin_key,
														bld_san_lnpid_key,bld_pid_gk_key),
                  parallel(	mv_did_key, 
														mv_pid_key, 
														// mv_PSanc_pid_key, 
														// mv_lic_key, 
														mv_lic_pid_key,
														mv_language_key, 
														mv_upin_key,
														mv_dea_key, 
														// mv_dea_DEANumber_key, 
														mv_degree_key,
														mv_speciality_key, 
														// mv_group_linkids_key, 
														mv_group_key,
														// mv_hospital_linkids_key, 
														mv_hospital_key,
														// mv_residency_linkids_key, 
														mv_residency_key,
														// mv_medschool_linkids_key, 
														mv_medschool_key, 
														// mv_prov_taxid_key,
														mv_san_did_key, 
														mv_san_bdid_key, 
														mv_san_LinkIDS_key,
														mv_san_sancid_key,
														mv_san_upin_key,
														mv_san_license_key,
														// mv_san_taxid_key,
														mv_npi_key,
														// mv_san_fdids_key, 
														// mv_san_taxid_name_key,
														mv_prov_fdids_key,mv_ProviderID_UPIN_key,
														mv_ProviderID_NPI_key,mv_san_busname_key,mv_san_tin_key,
														mv_san_lnpid_key,mv_pid_gk_key
														,email_success 
														)
									);

return build_ingenix_keys;

end;