IMPORT _Control, RoxieKeyBuild, VersionControl, ut, Orbit3;

EXPORT Build_All(STRING	pversion) := MODULE
		EXPORT spray_files := fSpray(pversion); // The vendor changed from one input file to 12 input files.  All 12 files should be in same directory 
																						// (edata10 = /data_build_4/NCPDP/data/<filedate>) to be sprayed for the build

		EXPORT dprov_info 		:= Update_Base.prov_info(Files().prov_info_input.Using, Files().prov_info_base.QA, pversion);
		EXPORT dprov_relat 		:= Update_Base.prov_relat(Files().prov_relat_input.Using, Files().prov_relat_base.QA, pversion);
		EXPORT dmedicaid 			:= Update_Base.medicaid(Files().medicaid_input.Using, Files().medicaid_base.QA, pversion);
		EXPORT dtaxonomy			:= Update_Base.taxonomy(Files().taxonomy_input.Using, Files().taxonomy_base.QA, pversion);
		EXPORT dpay_center		:= Update_Base.pay_center(Files().pay_center_input.Using, Files().pay_center_base.QA, pversion);
		EXPORT dparent_org		:= Update_Base.parent_org(Files().parent_org_input.Using, Files().parent_org_base.QA, pversion);
		EXPORT ddemographic		:= Update_Base.demographic(Files().demographic_input.Using, Files().demographic_base.QA, pversion);
		EXPORT deprescribe		:= Update_Base.eprescribe(Files().eprescribe_input.Using, Files().eprescribe_base.QA, pversion);
		EXPORT dremit					:= Update_Base.remit(Files().remit_info_input.Using, Files().remit_info_base.QA, pversion);
		EXPORT dstate_lic			:= Update_Base.state_lic(Files().state_license_input.Using, Files().state_license_base.QA, pversion);
		EXPORT dservices			:= Update_Base.services(Files().services_info_input.Using, Files().services_info_base.QA, pversion);
		EXPORT dchange_owner	:= Update_Base.change_owner(Files().change_owner_input.Using, Files().change_owner_base.QA, pversion);
		EXPORT dfinal_base		:= Update_Base.combined_base(pversion);
		EXPORT dkeybuild			:= Update_Base.keybuild(pversion);

		VersionControl.macBuildNewLogicalFile(Filenames(pversion).prov_info_base.New
																				,dprov_info
																				,Build_prov_info_File);
																				
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).prov_relat_base.New
																				,dprov_relat
																				,Build_prov_relat_File);
		
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).medicaid_base.New
																				,dmedicaid
																				,Build_medicaid_File);
																																					
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).taxonomy_base.New
																				,dtaxonomy
																				,Build_taxonomy_File);
		
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).pay_center_base.New
																				,dpay_center
																				,Build_pay_center_File);
																												
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).parent_org_base.New
																				,dparent_org
																				,Build_parent_org_File);
		
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).demographic_base.New
																				,ddemographic
																				,Build_demographic_File);
		
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).eprescribe_base.New
																				,deprescribe
																				,Build_eprescribe_File);
																				
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).remit_info_base.New
																				,dremit
																				,Build_remit_File);	
																				
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).state_lic_base.New
																				,dstate_lic
																				,Build_state_lic_File);
																		
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).services_info_base.New
																				,dservices
																				,Build_services_File);
																				
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).change_owner_base.New
																				,dchange_owner
																				,Build_change_owner_File);
																				
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).final_base.new
																				,dfinal_base
																				,Build_final_file);
																				
		VersionControl.macBuildNewLogicalFile(Filenames(pversion).keybuild_base.new
																				,dkeybuild
																				,Build_keybuild_file);

	dops_update := RoxieKeyBuild.updateversion('NCPDPKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															

  orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('NCPDP',pversion,'N');
	
	full_build := SEQUENTIAL( spray_files,
 													 Promote().Input.prov_info_Sprayed2Using,
 													 Build_prov_info_File,
													 Promote(pversion).prov_info_New2Built,
													 
 													 Promote().Input.prov_relat_Sprayed2Using,
 													 Build_prov_relat_File,
													 Promote(pversion).prov_relat_New2Built,

 													 Promote().Input.medicaid_Sprayed2Using,
													 Build_medicaid_File,
													 Promote(pversion).medicaid_New2Built,

 													 Promote().Input.taxonomy_Sprayed2Using,
 													 Build_taxonomy_File,
													 Promote(pversion).taxonomy_New2Built,

 													 Promote().Input.pay_center_Sprayed2Using,
 													 Build_pay_center_File,
													 Promote(pversion).pay_center_New2Built,

 													 Promote().Input.parent_org_Sprayed2Using,
													 Build_parent_org_File,
													 Promote(pversion).parent_org_New2Built,

 													 Promote().Input.demographic_Sprayed2Using,
 													 Build_demographic_File,
													 Promote(pversion).demographic_New2Built,

 													 Promote().Input.eprescribe_Sprayed2Using,
													 Build_eprescribe_File,
 													 Promote(pversion).eprescribe_New2Built,

 													 Promote().Input.remit_info_Sprayed2Using,
 													 Build_remit_File,
													 Promote(pversion).remit_info_New2Built,

 													 Promote().Input.state_lic_Sprayed2Using,
 													 Build_state_lic_File,
													 Promote(pversion).state_lic_New2Built,

 													 Promote().Input.services_Sprayed2Using,
													 Build_services_File,
													 Promote(pversion).services_info_New2Built,

 													 Promote().Input.change_owner_Sprayed2Using,
													 Build_change_owner_File,
													 Promote(pversion).change_owner_New2Built,

													 Build_final_file,
													 Promote(pversion).final_New2Built,
					 
													 Build_keybuild_file,
													 Promote(pversion).keybuild_New2Built,
													 
 													 Promote().Input.prov_info_Using2Used,
													 Promote().Input.prov_relat_Using2Used,
													 Promote().Input.medicaid_Using2Used,
													 Promote().Input.taxonomy_Using2Used,
													 Promote().Input.pay_center_Using2Used,
													 Promote().Input.parent_org_Using2Used,
													 Promote().Input.demographic_Using2Used,
													 Promote().Input.eprescribe_Using2Used,
													 Promote().Input.remit_info_Using2Used,
													 Promote().Input.state_lic_Using2Used,
													 Promote().Input.services_Using2Used,
 													 Promote().Input.change_owner_Using2Used,
													 Promote().prov_info_Built2QA,
													 Promote().prov_relat_Built2QA,
													 Promote().medicaid_Built2QA,
													 Promote().taxonomy_Built2QA,
													 Promote().pay_center_Built2QA,
													 Promote().parent_org_Built2QA,
													 Promote().demographic_Built2QA,
													 Promote().eprescribe_Built2QA,
													 Promote().remit_info_Built2QA,
													 Promote().state_lic_Built2QA,
													 Promote().services_info_Built2QA,
													 Promote().change_owner_Built2QA,
													 Promote().final_Built2QA,
													 Promote().keybuild_Built2QA,

													 Proc_AutokeyBuild_DBAPhys(pversion),
													 Proc_AutokeyBuild_DBAMail(pversion),
													 Proc_AutokeyBuild_ContLegalPhys(pversion),
													 Proc_AutokeyBuild_ContLegalMail(pversion),
													 Proc_Build_RoxieKeys(pversion),
													 out_STRATA_population_stats(pversion),
													 New_records_sample,
													 dops_update,
													 orbit_update
													) : SUCCESS(Send_Email(pversion).BuildSuccess), FAILURE(Send_Email(pversion).BuildFailure);

	EXPORT All := IF(VersionControl.IsValidVersion(pversion)
									 ,full_build
									 ,OUTPUT('No Valid version parameter passed, skipping build'));
END;