IMPORT versioncontrol, _control, ut, tools,HMS_CSR;
EXPORT Build_all(string pversion, boolean pUseProd = false) := FUNCTION

	spray_  		 := VersionControl.fSprayInputFiles(HMS_CSR.fSpray(pversion,pUseProd));

	chkFile(string pVersion, boolean pUseProd ) := FUNCTION
		 isErrorFile := if(exists(topn(HMS_CSR.Files(pVersion,pUseProd).csr_input(ln_key[3] <> '_'),1,ln_key)),true,false);
				return if(isErrorFile,FAIL('Input File Error for ' + pversion));
	END;

	checkspray_ := chkFile(pVersion,pUseProd):failure(HMS_CSR.Send_Email(pversion,pUseProd).InputFileError);
	
	superFile := FileServices.SuperFileExists('~thor400_data::base::hms_csr::hms_csrcredential');

	if(not superFile,FileServices.CreateSuperFile('~thor400_data::base::hms_csr::hms_csrcredential',,1));
	
	built := sequential(
						spray_
						// ,checkspray_ 
						,HMS_CSR.Build_Base.build_base_csrcredential(pVersion,pUseProd).csrcredential_all
						// ,Build_Keys.Build_Keys_csrcredential(pversion,pUseProd).CsrCredential_All
						,HMS_CSR.Scrub_HmsCsr(pversion,pUseProd).ScrubIt
						,HMS_CSR.Promote.Promote_csrcredential(pversion,pUseProd).buildfiles.Built2QA
						,HMS_CSR.Build_Strata(pversion,pUseProd).all
						// Archive processed files in history	
						,HMS_CSR.Consolidate_In_File(pVersion,pUseProd)
					
														
						//Archive
						,FileServices.StartSuperFileTransaction(),
						
						//Clean Up Base Files
						FileServices.RemoveOwnedSubFiles('~thor400_data::base::hms_csr::hms_csrcredential',true),
						FileServices.AddSuperFile('~thor400_data::base::hms_csr::hms_csrcredential','~thor400_data::base::hms_csr::hms_csrcredential::' + pVersion),
						
						//Clean Up Input Files
						 parallel(
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).address_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).license_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).entity_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).csr_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).dea_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).education_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).language_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).npi_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).phone_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).specialty_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).disciplinaryact_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).medicaid_lInputHistTemplate)//,
									// FileServices.ClearSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).taxonomy_lInputHistTemplate)
					),
					parallel(
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).address_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_address::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).license_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_license::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).entity_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_entity::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).csr_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_csr::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).dea_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_dea::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).education_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_education::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).language_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_language::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).npi_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_npi::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).phone_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_phone::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).specialty_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_specialty::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).disciplinaryact_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_disciplinaryact::' + pVersion),
									FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).medicaid_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_medicaid::' + pVersion)//,
									// FileServices.AddSuperFile(HMS_CSR.Filenames(pVersion,pUseProd).taxonomy_lInputHistTemplate,HMS_CSR._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_CSR._Dataset().name + '::hms_taxonomy::' + pVersion)
				
					),
					
					parallel(
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_address_consolidated','~thor400_data::in::hms_csr::hms_address::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_csr_consolidated','~thor400_data::in::hms_csr::hms_csr::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_dea_consolidated','~thor400_data::in::hms_csr::hms_dea::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_disciplinaryact_consolidated','~thor400_data::in::hms_csr::hms_disciplinaryact::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_education_consolidated','~thor400_data::in::hms_csr::hms_education::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_entity_consolidated','~thor400_data::in::hms_csr::hms_entity::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_language_consolidated','~thor400_data::in::hms_csr::hms_language::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_license_consolidated','~thor400_data::in::hms_csr::hms_license::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_medicaid_consolidated','~thor400_data::in::hms_csr::hms_medicaid::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_npi_consolidated','~thor400_data::in::hms_csr::hms_npi::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_phone_consolidated','~thor400_data::in::hms_csr::hms_phone::' + pVersion),
										FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_specialty_consolidated','~thor400_data::in::hms_csr::hms_specialty::' + pVersion)//,
										// FileServices.AddSuperFile('~thor400_data::in::hms_csr::hms_taxonomy_consolidated','~thor400_data::in::hms_csr::hms_taxonomy::' + pVersion),
						),
								
						parallel(
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_address_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_csr_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_dea_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_disciplinaryact_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_education_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_entity_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_language_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_license_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_medicaid_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_npi_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_phone_consolidated',true),
								FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_specialty_consolidated',true)//,
								// FileServices.RemoveOwnedSubFiles('~thor400_data::in::hms_csr::hms_taxonomy_consolidated',true)
						),
					
					FileServices.FinishSuperFileTransaction()
						// End Archive sequential

						
					): success(HMS_CSR.Send_Email(pversion,pUseProd).BuildSuccess), failure(HMS_CSR.send_email(pversion,pUseProd).BuildFailure

	);


	return built;
END;