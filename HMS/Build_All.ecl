IMPORT versioncontrol, _control, ut, tools, lib_fileservices,RoxieKeyBuild;

EXPORT Build_all(string pversion, boolean pUseProd = false) := FUNCTION

	// wl := nothor(WorkunitServices.WorkunitList('',jobname:='HMS Build*'))(state in ['blocked','running','wait']);
  // if(exists(wl),fail('HMS Build is running'));

	spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));

	built := sequential(		//sequential OUTER

			HMS.CreateSuperFiles(pversion, pUseProd).CreateSF_All;
			
			spray_,

			PARALLEL(
					sequential(
							Build_base.build_base_individual_state_licenses(pversion,pUseProd).individual_state_licenses_all,
							Build_base.build_base_individual_state_csr(pversion,pUseProd).individual_state_csr_all,
							Build_base.build_base_individual_dea(pversion,pUseProd).individual_dea_all,
							Build_base.build_base_individual_sanctions(pversion,pUseProd).individual_sanctions_all,
							Build_Base.build_base_individual_gsa_sanctions(pversion,pUseProd).individual_gsa_sanctions_all,
							Build_base.build_base_Individual_Address_Faxes(pversion,pUseProd).Individual_Address_Faxes_all,
							Build_base.build_base_Individual_Certifications(pversion,pUseProd).Individual_Certifications_all,
							Build_base.build_base_Individual_Covered_Recipients(pversion,pUseProd).Individual_Covered_Recipients_all,
							Build_base.build_base_Individual_Education(pversion,pUseProd).Individual_Education_all,
							Build_base.build_base_Individual_Languages(pversion,pUseProd).Individual_Languages_all,
							Build_base.build_base_Individual_Specialty(pversion,pUseProd).Individual_Specialty_all,
							Build_base.build_base_Individual_Address_Phones(pversion,pUseProd).Individual_Address_Phones_all,
							Build_base.build_base_Piid_Migration(pversion,pUseProd).Piid_Migration_all,
							Build_base.build_base_individual_addresses(pversion,pUseProd).individual_addresses_all,
							//last
							Build_base.build_base_individual(pversion,pUseProd).individual_all,
							Build_Keys.Build_Keys_Provider( pversion, pUseProd).ProviderKey;							
							)//,  //END sequential
					// this one can be done in parallel with the others
					,Build_Base.build_base_state_license_types(pversion,pUseProd).state_license_types_all
					)  //END PARALLEL

      // If there were keys for this project, they would be built here
			//			,Build_Keys.Build_Keys_Provider(pversion,pUseProd).ProviderKey
			
			// The files can be moved to the appropriate superfiles 
			,PARALLEL(				
					Promote.promote_individual(pversion,pUseProd).buildfiles.Built2QA,
					Promote.promote_individual_addresses(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_state_licenses(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_dea(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_state_csr(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_sanctions(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_gsa_sanctions(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_state_license_types(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_address_faxes(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_certifications(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_covered_recipients(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_education(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_languages(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_individual_specialty(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_piid_migration(pversion,pUseProd).buildfiles.Built2QA ,
					Promote.Promote_individual_address_phones(pversion,pUseProd).buildfiles.Built2QA,
					Promote.Promote_Providerkeys(pversion,pUseProd).buildfiles.Built2QA					
			)    
				,Scrub_code(pversion).Scrubbed_Output					
				,Build_Strata(pversion,pUseProd).all
			
			//Archive processed files in history
			,SEQUENTIAL(
				FileServices.StartSuperFileTransaction(),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_addresses_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_state_licenses_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_dea_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_state_csr_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_sanctions_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_gsa_sanctions_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).state_license_types_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_address_faxes_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_certifications_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_covered_recipients_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_education_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_languages_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_specialty_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_address_phones_lInputHistTemplate, true),
				FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).piid_migration_lInputHistTemplate, true),
				
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_state_licenses_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_state_csr_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_dea_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_addresses_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_sanctions_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_gsa_sanctions_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).state_license_types_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_address_faxes_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_address_phones_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_certifications_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_covered_recipients_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_education_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_languages_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_specialty_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).piid_migration_lInputHistTemplate),
				FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_lInputHistTemplate),

				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_state_licenses_lInputHistTemplate,      Filenames(pversion,pUseProd).individual_state_licenses_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_state_csr_lInputHistTemplate,           Filenames(pversion,pUseProd).individual_state_csr_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_dea_lInputHistTemplate,                 Filenames(pversion,pUseProd).individual_dea_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_addresses_lInputHistTemplate,           Filenames(pversion,pUseProd).individual_addresses_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_sanctions_lInputHistTemplate,           Filenames(pversion,pUseProd).individual_sanctions_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_gsa_sanctions_lInputHistTemplate,       Filenames(pversion,pUseProd).individual_gsa_sanctions_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).state_license_types_lInputHistTemplate,            Filenames(pversion,pUseProd).state_license_types_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_address_faxes_lInputHistTemplate,       Filenames(pversion,pUseProd).individual_address_faxes_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_address_phones_lInputHistTemplate,      Filenames(pversion,pUseProd).individual_address_phones_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_certifications_lInputHistTemplate,      Filenames(pversion,pUseProd).individual_certifications_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_covered_recipients_lInputHistTemplate,  Filenames(pversion,pUseProd).individual_covered_recipients_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_education_lInputHistTemplate,           Filenames(pversion,pUseProd).individual_education_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_languages_lInputHistTemplate,           Filenames(pversion,pUseProd).individual_languages_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_specialty_lInputHistTemplate,           Filenames(pversion,pUseProd).individual_specialty_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).piid_migration_lInputHistTemplate,                 Filenames(pversion,pUseProd).piid_migration_lInputTemplate,,true),
				FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_lInputHistTemplate,                     Filenames(pversion,pUseProd).individual_lInputTemplate,,true),           

				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_state_licenses_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_state_csr_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_dea_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_addresses_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_sanctions_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_gsa_sanctions_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).state_license_types_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_address_faxes_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_address_phones_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_certifications_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_covered_recipients_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_education_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_languages_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_specialty_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).piid_migration_lInputTemplate, true),
				FileServices.RemoveOwnedSubFiles(HMS.Filenames(pversion,pUseProd).individual_lInputTemplate, true),

				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_state_licenses_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_state_csr_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_dea_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_addresses_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_sanctions_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_gsa_sanctions_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).state_license_types_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_address_faxes_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_address_phones_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_certifications_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_covered_recipients_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_education_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_languages_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_specialty_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).piid_migration_lInputTemplate),
				FileServices.ClearSuperFile(HMS.Filenames(pversion,pUseProd).individual_lInputTemplate),

				FileServices.FinishSuperFileTransaction()
			) //END SEQUENTIAL

			)         // END SEQUENTIAL OUTER
			: SUCCESS(Send_Email(pversion,pUseProd).BuildSuccess), FAILURE(Send_Email(pversion,pUseProd).BuildFailure);
    RETURN built;

END;
