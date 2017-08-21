// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import DriversV2, lib_stringlib, ut, versioncontrol;

export Proc_Build_DL_MN_RESTRICTED_In_Files(string pversion = '') := module

	//////////////////////////////////////////////////////////////////
  // -- Read Alpharetta Files and create logical files
  //////////////////////////////////////////////////////////////////
	VersionControl.macBuildNewLogicalFile(Filenames(pversion,'mn_restricted_address').input.logical,Files_MN_RESTRICTED_In().addr_alpha,create_addr_logical_file);	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion,'mn_restricted_license').input.logical,Files_MN_RESTRICTED_In().license_alpha,create_license_logical_file);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion,'mn_restricted_misc').input.logical,Files_MN_RESTRICTED_In().misc_alpha,create_misc_logical_file);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion,'mn_restricted_oper').input.logical,Files_MN_RESTRICTED_In().operator_alpha,create_operator_logical_file);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion,'mn_restricted_restrict').input.logical,Files_MN_RESTRICTED_In().restriction_alpha,create_restriction_logical_file);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion,'mn_restricted_viol').input.logical,Files_MN_RESTRICTED_In().violation_alpha,create_violation_logical_file);
		
	//////////////////////////////////////////////////////////////////
  // -- Move using files to used superfiles
  //////////////////////////////////////////////////////////////////	
	export promote_using2used := sequential
		(
		DriversV2.Promote(pversion,'mn_restricted_address').Input.Using2Used,
		DriversV2.Promote(pversion,'mn_restricted_license').Input.Using2Used,
		DriversV2.Promote(pversion,'mn_restricted_misc').Input.Using2Used,
		DriversV2.Promote(pversion,'mn_restricted_oper').Input.Using2Used,
		DriversV2.Promote(pversion,'mn_restricted_restrict').Input.Using2Used,
		DriversV2.Promote(pversion,'mn_restricted_viol').Input.Using2Used,
		);	

		full_build 	:=    
		sequential(
				parallel(
							sequential(create_addr_logical_file,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_address').Input.Using),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_address').Input.Delete,true),
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_address').Input.Delete,Driversv2.Filenames(pversion,'mn_restricted_address').Input.used,addcontents := true);												
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_address').Input.Using,Driversv2.Filenames(pversion,'mn_restricted_address').Input.logical),
												FileServices.FinishSuperFileTransaction(),
												),
							sequential(create_license_logical_file,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_license').Input.Using),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_license').Input.Delete,true),
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_license').Input.Delete,Driversv2.Filenames(pversion,'mn_restricted_license').Input.used,addcontents := true);												
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_license').Input.Using,Driversv2.Filenames(pversion,'mn_restricted_license').Input.logical),						
												FileServices.FinishSuperFileTransaction(),
												),
							sequential(create_misc_logical_file,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_misc').Input.Using),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_misc').Input.Delete,true),
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_misc').Input.Delete,Driversv2.Filenames(pversion,'mn_restricted_misc').Input.used,addcontents := true);												
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_misc').Input.Using,Driversv2.Filenames(pversion,'mn_restricted_misc').Input.logical),
												FileServices.FinishSuperFileTransaction(),
												),
							sequential(create_operator_logical_file,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_oper').Input.Using),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_oper').Input.Delete,true),
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_oper').Input.Delete,Driversv2.Filenames(pversion,'mn_restricted_oper').Input.used,addcontents := true);											
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_oper').Input.Using,Driversv2.Filenames(pversion,'mn_restricted_oper').Input.logical),
												FileServices.FinishSuperFileTransaction(),
												),
							sequential(create_restriction_logical_file,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_restrict').Input.Using),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_restrict').Input.Delete,true),
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_restrict').Input.Delete,Driversv2.Filenames(pversion,'mn_restricted_restrict').Input.used,addcontents := true);												
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_restrict').Input.Using,Driversv2.Filenames(pversion,'mn_restricted_restrict').Input.logical),												
												FileServices.FinishSuperFileTransaction(),
												),
							sequential(create_violation_logical_file,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_viol').Input.Using),
												FileServices.ClearSuperFile(Filenames(,'mn_restricted_viol').Input.Delete,true),
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_viol').Input.Delete,Driversv2.Filenames(pversion,'mn_restricted_viol').Input.used,addcontents := true);												
												FileServices.AddSuperFile(Driversv2.Filenames(,'mn_restricted_viol').Input.Using,Driversv2.Filenames(pversion,'mn_restricted_viol').Input.logical),												
												FileServices.FinishSuperFileTransaction(),
												)
				),
				sequential(FileServices.StartSuperFileTransaction(),
									 FileServices.ClearSuperFile(Filenames(,'mn_restricted_raw_common_base').Base.Built),
									 FileServices.ClearSuperFile(Filenames(,'mn_restricted_raw_common_base').Base.Delete,true),									 
							 		 FileServices.FinishSuperFileTransaction(),
									 Driversv2.Preprocess_MN_RESTRICTED_Raw_Update(pversion,false).build_MN_RESTRICTED_Raw,
									 DriversV2.Promote(pversion,'mn_restricted_raw_common_base').New2QA,
									 promote_using2used
									)
				);	 

	export all := if(VersionControl.IsValidVersion(pversion[1..8]) //*** Eliminating any post characters before validating pversion
								  ,if( not fileservices.fileexists(DriversV2.Filenames(pversion,'mn_restricted_raw_common_base').Base.Logical)
											,full_build
											,output('Proc_Build_DL_MN_RESTRICTED_In_Files: File version '
															+pversion+' already exists.  File: '
															+DriversV2.Filenames(pversion,'mn_restricted_raw_common_base').Base.Logical
															+' has already been built.  Please check the version passed, skipping build')
										)	
									,output('Proc_Build_DL_MN_RESTRICTED_In_Files: No Valid version parameter passed, skipping build')
									);
		
end;