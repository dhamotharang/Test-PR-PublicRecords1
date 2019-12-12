IMPORT	versioncontrol;
EXPORT Proc_Build_File_New_Suppression_Opt_Out(String pVersion) := FUNCTION

	// Spray and process exemptions extract from Orbit
	spray_exemption_input_files := SEQUENTIAL(
			$.fSprayFiles.Exemptions_File(pVersion,
										 ,pFilename:=$.Constants.Exemptions(pVersion).FileToSpray_PR
										 ,pDestPath:=$.FileNames().Exemptions.lGlobalSidPRTemplate
										 ,pGroupName:=$.Constants.Exemptions(pVersion).GroupName);
			$.fSprayFiles.Exemptions_File(pVersion,
										 ,pFilename:=$.Constants.Exemptions(pVersion).FileToSpray_INS
										 ,pDestPath:=Suppress.FileNames().Exemptions.lGlobalSidInsTemplate
										 ,pGroupName:=$.Constants.Exemptions(pVersion).GroupName);
			$.fSprayFiles.Exemptions_File(pVersion,
										 ,pFilename:=$.Constants.Exemptions(pVersion).FileToSpray_HC
										 ,pDestPath:=Suppress.FileNames().Exemptions.lGlobalSidHCTemplate
										 ,pGroupName:=$.Constants.Exemptions(pVersion).GroupName);
									);									 
	build_global_sid_base		:= $.Proc_Build_Base_Global_Sid(pVersion);

	// Spray process opt out input file and process sprayed opt out file and minor file
	spray_opt_out_input_file	:= $.fSprayFiles.OptOutSrc(pVersion,
										 ,pFilename:=$.Constants.OptOut(pVersion).FileToSpray
										 ,pGroupName:=$.Constants.OptOut(pVersion).GroupName);
																	
	build_opt_out_base 			:= $.Proc_Build_Base_OptOut(pVersion);

	RETURN SEQUENTIAL(	spray_exemption_input_files, 
						build_global_sid_base, 
						spray_opt_out_input_file, 
						build_opt_out_base
					 );

END;