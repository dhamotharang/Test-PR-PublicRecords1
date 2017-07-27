IMPORT versioncontrol, _control, ut, tools, lib_fileservices,RoxieKeyBuild, Org_Mast;

//pversion := '20150319';
// pversion := '20150424';
//pversion := '20151022';
pversion := '20160328';
pUseProd := false;
#workunit('name', 'AHA BASE Build ' + pversion);
	// aha_lInputTemplate    :=Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 +Org_Mast. _Dataset().name + '::Org_Master_aha';//::'/*+pversion*/;

	// fileservices.RemoveOwnedSubFiles(aha_lInputTemplate);
	
		// spray_  		 := VersionControl.fSprayInputFiles(Org_Mast.fSpray(pversion,pUseProd));
   	// spray_;
   	// in_aha_file						:= Org_Mast._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + Org_Mast._Dataset().name + '::Org_Master_aha::'+pversion;//@version@';
   	
   	// aha									  := DATASET(in_aha_file, Org_Mast.layouts.aha_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('"') ));
		// aha;
   	// std_input := Org_Mast.StandardizeInputFile(pversion, pUseProd).aha;
   	// std_input;
		base := Org_Mast.Build_base.build_base_aha(pversion,pUseProd).aha_all;
		// base;
		Promote.promote_aha(pversion,pUseProd).buildfiles.Built2QA;
		
		//Org_Mast.StandardizeInputFile(pversion,pUseProd).aha;