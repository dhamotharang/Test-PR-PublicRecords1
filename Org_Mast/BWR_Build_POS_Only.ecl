IMPORT versioncontrol, _control, ut, tools, lib_fileservices,RoxieKeyBuild, Org_Mast;

//pversion := '20150319';
// pversion := '20150424';
//pversion := '20151022';
//pversion := '20160216';
pversion := '20160328';
pUseProd := false;
#workunit('name', 'POS BASE Build ' + pversion);
	 pos_lInputTemplate    :=Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 +Org_Mast. _Dataset().name + '::Org_Master_pos';//::'/*+pversion*/;
  pos_lBuiltTemplate    :=Org_Mast._Dataset(pUseProd).thor_cluster_files + 'base::' 	 +Org_Mast. _Dataset().name + '::Org_Master_pos::'/*+pversion*/+'Built';
  // pos_lQATemplate    :=Org_Mast._Dataset(pUseProd).thor_cluster_files + 'base::' 	 +Org_Mast. _Dataset().name + '::Org_Master_pos::'/*+pversion*/+'QA';
	
	  fileservices.RemoveOwnedSubFiles(pos_lInputTemplate);
	  fileservices.RemoveOwnedSubFiles(pos_lBuiltTemplate);
	  // fileservices.RemoveOwnedSubFiles(pos_lQATemplate);
	
		 // spray_  		 := VersionControl.fSprayInputFiles(Org_Mast.fSpray(pversion,pUseProd));
   	 // spray_;
		 //Org_Mast.Build_All(pversion);		 
   	 // in_pos_file						:= Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + Org_Mast._Dataset().name + '::Org_Master_pos::'+pversion;//@version@';
   	
   	 // pos									  := DATASET(in_pos_file, Org_Mast.layouts.pos_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('\"') ));
		 // pos;
   	// std_input := Org_Mast.StandardizeInputFile(pversion, pUseProd).pos;
   	// std_input;
		// sequential(
		 Org_Mast.Build_Base.Build_Base_Pos(pversion,pUseProd).POS_all;
		 // ,Org_Mast.Promote.promote_POS(pversion,pUseProd).buildfiles.Built2QA
		 // );
		// base;
		//Org_Mast.Promote.promote_pos(pversion,pUseProd).buildfiles.Built2QA;
		//sequential(
				//FileServices.StartSuperFileTransaction()		
			// Org_Mast.Build_base.build_base_organization(pversion,pUseProd).organization_all;
			// Org_Mast.Promote.promote_pos(pversion,pUseProd).buildfiles.Built2QA
			//,FileServices.FinishSuperFileTransaction()
			//);
		 // std_file := Org_Mast.Update_Base(pversion,pUseProd).pos_base;
		 // std_file;
/*	
			sequential(
				FileServices.StartSuperFileTransaction()
				
				,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lInputHistTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lInputHistTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lInputHistTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lInputHistTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputHistTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).organization_lInputHistTemplate, true)
				
				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputHistTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lInputHistTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lInputHistTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputHistTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputHistTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputHistTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lInputHistTemplate)
		
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lInputTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lInputTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputTemplate, true)
				// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).organization_lInputTemplate, true)

				,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lInputTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lInputTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lInputTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lInputTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lInputTemplate)
				// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lInputTemplate)
				
			
			// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).dea_lBaseTemplate_built, true)
			// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).npi_lBaseTemplate_built, true)
			// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_built, true)
			// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lBaseTemplate_built, true)
			// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_built, true)
			// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_qa, true)
			// ,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).organization_lBaseTemplate_built, true)
						
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_built)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lBaseTemplate_built)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lBaseTemplate_built)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_built)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lBaseTemplate_built)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_built)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_qa)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lBaseTemplate_built)
			
			,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_Delete)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).npi_lBaseTemplate_Delete)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).dea_lBaseTemplate_Delete)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).pos_lBaseTemplate_Delete)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).crosswalk_lBaseTemplate_Delete)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_Delete)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).affiliations_lBaseTemplate_Delete)
			// ,FileServices.ClearSuperFile(Org_Mast.Filenames(pversion,pUseProd).organization_lBaseTemplate_Delete)
							
				,FileServices.FinishSuperFileTransaction()
			);
*/		


/*
IMPORT versioncontrol, _control, ut, tools, lib_fileservices,RoxieKeyBuild, Org_Mast;

//pversion := '20150319';
// pversion := '20150424';
//pversion := '20151022';
pversion := '20160212';
pUseProd := false;
#workunit('name', 'POS BASE Build ' + pversion);
	POS_lInputTemplate    :=Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 +Org_Mast. _Dataset().name + '::Org_Master_POS';//::'/*+pversion*/;

	// fileservices.RemoveOwnedSubFiles(POS_lInputTemplate);
/*
		spray_  		 := VersionControl.fSprayInputFiles(Org_Mast.fSpray(pversion,pUseProd));
   	spray_;
   	in_POS_file						:= Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + Org_Mast._Dataset().name + '::Org_Master_POS::'+pversion;//@version@';
   	
   	POS									  := DATASET(in_POS_file, Org_Mast.layouts.POS_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('"') ));
		POS;
   	// std_input := Org_Mast.StandardizeInputFile(pversion, pUseProd).POS;
   	// std_input;
		// base := Org_Mast.Build_base.build_base_POS(pversion,pUseProd).POS_all;
		// base;
		// Promote.promote_POS(pversion,pUseProd).buildfiles.Built2QA;
		
		// Org_Mast.StandardizeInputFile(pversion,pUseProd).POS;
*/

/*		
IMPORT versioncontrol, _control, ut, tools, lib_fileservices,RoxieKeyBuild, Org_Mast;

//pversion := '20150319';
// pversion := '20150424';
//pversion := '20151022';
pversion := '20160212';
pUseProd := false;
#workunit('name', 'POS BASE Build ' + pversion);
	POS_lInputTemplate    :=Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 +Org_Mast. _Dataset().name + '::Org_Master_POS';//::'/*+pversion*/;

/*	 fileservices.RemoveOwnedSubFiles(POS_lInputTemplate);
	
		spray_  		 := VersionControl.fSprayInputFiles(Org_Mast.fSpray(pversion,pUseProd));
   	spray_;
   	in_POS_file						:= Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + Org_Mast._Dataset().name + '::Org_Master_POS::'+pversion;//@version@';
   	
   	POS									  := DATASET(in_POS_file, Org_Mast.layouts.POS_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('"') ));
		POS;
   	// std_input := Org_Mast.StandardizeInputFile(pversion, pUseProd).POS;
   	// std_input;
		// base := Org_Mast.Build_base.build_base_POS(pversion,pUseProd).POS_all;
		// base;
		// Promote.promote_POS(pversion,pUseProd).buildfiles.Built2QA;
		
		// Org_Mast.StandardizeInputFile(pversion,pUseProd).POS;		
*/		