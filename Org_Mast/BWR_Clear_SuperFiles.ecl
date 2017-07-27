
IMPORT versioncontrol, _control, ut, tools, lib_fileservices,RoxieKeyBuild, Org_Mast;
pversion := '20160216';
pUseProd := false;

SEQUENTIAL(
			FileServices.StartSuperFileTransaction()			
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).aha_lInputHistTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lInputHistTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lInputHistTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lInputHistTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputHistTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).organization_lInputHistTemplate, true)
			
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).aha_lInputHistTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lInputHistTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lInputHistTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputHistTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputHistTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lInputHistTemplate)

			,FileServices.AddSuperFile(Org_Mast.Filenames(pversion,pUseProd).aha_lInputHistTemplate,Org_Mast.Filenames(pversion,pUseProd).aha_lInputTemplate,,true)
			,FileServices.AddSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lInputHistTemplate,      					Org_Mast.Filenames(pversion,pUseProd).dea_lInputTemplate,,true)
			,FileServices.AddSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lInputHistTemplate,      					Org_Mast.Filenames(pversion,pUseProd).npi_lInputTemplate,,true)
			,FileServices.AddSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputHistTemplate,      					Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate,,true)
			,FileServices.AddSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate,      		Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputTemplate,,true)
			,FileServices.AddSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputHistTemplate,      Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputTemplate,,true)
			,FileServices.AddSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lInputHistTemplate,      Org_Mast.Filenames(pversion,pUseProd).organization_lInputTemplate,,true)

			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).aha_lInputTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lInputTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lInputTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputTemplate, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).organization_lInputTemplate, true)

			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).aha_lInputTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lInputTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lInputTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputTemplate)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lInputTemplate)
			
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).aha_lBaseTemplate_built, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lBaseTemplate_built, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lBaseTemplate_built, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_built, true)
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
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_Delete)
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lBaseTemplate_Delete)
			
			

			,FileServices.FinishSuperFileTransaction()
);
