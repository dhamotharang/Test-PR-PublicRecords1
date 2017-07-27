IMPORT versioncontrol, _control, ut, tools, lib_fileservices,RoxieKeyBuild, Org_Mast;

EXPORT Build_all(string pversion, boolean pUseProd = false) := FUNCTION

	// wl := nothor(WorkunitServices.WorkunitList('',jobname:='Org_Mast Build*'))(state in ['blocked','running','wait']);
  // if(exists(wl),fail('Org_Mast Build is running'));

	spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd));

	built := SEQUENTIAL(

      CreateSuperFiles(pversion, pUseProd).CreateSF_All;

			spray_

			,Build_base.build_base_aha(pversion,pUseProd).aha_all
			,Build_base.build_base_dea(pversion,pUseProd).dea_all
			,Build_base.build_base_npi(pversion,pUseProd).npi_all
			,Build_base.build_base_pos(pversion,pUseProd).pos_all
			,Build_base.build_base_crosswalk(pversion,pUseProd).crosswalk_all
			,Build_base.build_base_affiliations(pversion,pUseProd).affiliations_all
			,Build_base.build_base_organization(pversion,pUseProd).organization_all
			// NOTE - The relationship table is built separateley because it takes different dates for constituent files.
			// It is built with Build_Relationship_Base attribute
			//,Build_base.build_base_Affiliate_Relationship(pversion,pUseProd).Affiliate_Relationship_all
			
      // The following keys are fully built and promoted in _BWR_Build_Relationship_Base
			,parallel(
					Org_mast.Build_Keys.Build_Keys_Facilities(pversion,pUseProd).FacilitiesKey,
					 Org_mast.Build_Keys.Build_Keys_Relationship_Key1(pversion,pUseProd).Relationship_Key1,
					 Org_mast.Build_Keys.Build_Keys_Relationship_Key2(pversion,pUseProd).Relationship_Key2
					)
			// after the keys have been built, the files can be moved to the appropriate superfiles
			,Promote.promote_aha(pversion,pUseProd).buildfiles.Built2QA
			,Promote.promote_dea(pversion,pUseProd).buildfiles.Built2QA
			,Promote.promote_npi(pversion,pUseProd).buildfiles.Built2QA
			,Promote.promote_pos(pversion,pUseProd).buildfiles.Built2QA
			,Promote.promote_crosswalk(pversion,pUseProd).buildfiles.Built2QA
			,Promote.promote_affiliations(pversion,pUseProd).buildfiles.Built2QA
			,Promote.promote_organization(pversion,pUseProd).buildfiles.Built2QA
			,Promote.Promote_Key1(pversion,pUseProd).buildfiles.Built2QA		
			,Promote.Promote_Key2(pversion,pUseProd).buildfiles.Built2QA			
			// Note that the Relationship table is not moved to superfile becuase it is always rebuilt from the corresponding base files.
			//,Scrub_code(pversion).all

			,Build_Strata(pversion,pUseProd).all
			Archive processed files in history
		
			,sequential(
				FileServices.StartSuperFileTransaction()
				
				,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).aha_lInputHistTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).dea_lInputHistTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).npi_lInputHistTemplate, true)
				//,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).pos_lInputHistTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).affiliations_lInputHistTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).organization_lInputHistTemplate, true)
				
				,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).aha_lInputHistTemplate)
				,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).dea_lInputHistTemplate)
				,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).npi_lInputHistTemplate)
				//,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).pos_lInputHistTemplate)
				,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate)
				,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).affiliations_lInputHistTemplate)
				,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).organization_lInputHistTemplate)

				,FileServices.AddSuperFile(Filenames(pversion,pUseProd).aha_lInputHistTemplate,      					Filenames(pversion,pUseProd).aha_lInputTemplate,,true)
				,FileServices.AddSuperFile(Filenames(pversion,pUseProd).dea_lInputHistTemplate,      					Filenames(pversion,pUseProd).dea_lInputTemplate,,true)
				,FileServices.AddSuperFile(Filenames(pversion,pUseProd).npi_lInputHistTemplate,      					Filenames(pversion,pUseProd).npi_lInputTemplate,,true)
				//,FileServices.AddSuperFile(Filenames(pversion,pUseProd).pos_lInputHistTemplate,      					Filenames(pversion,pUseProd).pos_lInputTemplate,,true)
				,FileServices.AddSuperFile(Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate,      		Filenames(pversion,pUseProd).crosswalk_lInputTemplate,,true)
				,FileServices.AddSuperFile(Filenames(pversion,pUseProd).affiliations_lInputHistTemplate,      Filenames(pversion,pUseProd).affiliations_lInputTemplate,,true)
				,FileServices.AddSuperFile(Filenames(pversion,pUseProd).organization_lInputHistTemplate,      Filenames(pversion,pUseProd).organization_lInputTemplate,,true)

				,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).aha_lInputTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lInputTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lInputTemplate, true)
				//,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputTemplate, true)
				,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).organization_lInputTemplate, true)

				//,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).aha_lInputTemplate)
				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lInputTemplate)
				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lInputTemplate)
				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate)
				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputTemplate)
				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputTemplate)
				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lInputTemplate)
				
			
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lBaseTemplate_built, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lBaseTemplate_built, true)
			//,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_built, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lBaseTemplate_built, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_built, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_qa, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).organization_lBaseTemplate_built, true)
						
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).aha_lBaseTemplate_built)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lBaseTemplate_built)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lBaseTemplate_built)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_built)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lBaseTemplate_built)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_built)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_qa)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lBaseTemplate_built)
			
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).aha_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lBaseTemplate_Delete)
			//,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lBaseTemplate_Delete)
							
				,FileServices.FinishSuperFileTransaction()
			)
		): SUCCESS(Send_Email(pversion,pUseProd).BuildSuccess), FAILURE(Send_Email(pversion,pUseProd).BuildFailure);
    RETURN built;

END;
