IMPORT versioncontrol, _control, ut, tools,HMS_STLIC;
EXPORT Build_all(string pversion, boolean pUseProd = false) := FUNCTION

	spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));

	chkFile(string pVersion, boolean pUseProd ) := FUNCTION
		 isErrorFile := if(exists(topn(HMS_STLIC.Files(pVersion,pUseProd).license_input(ln_key[3] <> '_'),1,ln_key)),true,false);
				return if(isErrorFile,FAIL('Input File Error for ' + pversion));
	END;

	checkspray_ := chkFile(pVersion,pUseProd):failure(HMS_STLIC.Send_Email(pversion,pUseProd).InputFileError);

	built := sequential(
						spray_
						,checkspray_ 
						,Build_Base.build_base_statelicense(pVersion,pUseProd).statelicense_all
						,Build_Keys.Build_Keys_statelicense(pversion,pUseProd).statelicense_all
						,Scrub_HMsStlic(pversion,pUseProd).ScrubIt
						,Promote.Promote_statelicense(pversion,pUseProd).buildfiles.Built2QA
						,Build_Strata(pversion,pUseProd).all
						// Archive processed files in history	
						,HMS_STLIC.Consolidate_In_File(pVersion,pUseProd)
						
						// Build Rollup for AMS Replacement
						,Build_Base.build_base_stlicrollup(pVersion,pUseProd).stlicrollup_all
						,Build_Keys.Build_Keys_stlicrollup(pversion,pUseProd).Stlicrollup_All
						,Promote.Promote_stlicrollup(pversion,pUseProd).buildfiles.Built2QA
					
						//Archive
						,FileServices.StartSuperFileTransaction(),
						parallel(
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).address_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).license_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).entity_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).csr_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).dea_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).education_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).language_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).npi_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).phone_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).specialty_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).disciplinaryact_lInputHistTemplate),
									FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).stliclookup_lInputHistTemplate)
					),
					parallel(
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).address_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_address::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).license_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_license::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).entity_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_entity::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).csr_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_csr::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).dea_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_dea::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).education_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_education::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).language_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_language::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).npi_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_npi::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).phone_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_phone::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).specialty_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_specialty::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).disciplinaryact_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_disciplinaryact::' + pVersion),
									FileServices.AddSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).stliclookup_lInputHistTemplate,HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_stliclookup::' + pVersion)
				
					),
					// FileServices.ClearSuperFile(HMS_STLIC.Filenames(pVersion,pUseProd).address_lInputTemplate),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_address', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_address::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_csr', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_csr::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_dea', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_dea::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_education', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_education::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_entity', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_entity::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_language', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_language::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_license', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_license::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_npi', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_npi::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_disciplinaryact', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_disciplinaryact::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_phone', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_phone::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_specialty', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_specialty::' + pVersion),
					FileServices.RemoveSuperFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_stliclookup', HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::' + HMS_STLIC._Dataset().name + '::hms_stliclookup::' + pVersion),
					// FileServices.DeleteLogicalFile(HMS_STLIC._Dataset(pUseProd).thor_cluster_files + 'in::'   + HMS_STLIC._Dataset().name + '::hms_address::' + pversion),
					FileServices.FinishSuperFileTransaction()
						// End Archive sequential
						
					): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

	);


	return built;
END;