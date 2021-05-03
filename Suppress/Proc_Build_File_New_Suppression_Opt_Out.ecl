IMPORT	versioncontrol;
EXPORT Proc_Build_File_New_Suppression_Opt_Out(String pVersion, string pHostname, string pTarget, string pContact ='\' \'') := FUNCTION
       

	clear_exemption_input_files	:= SEQUENTIAL(
										  FileServices.StartSuperFileTransaction()
										 ,FileServices.clearsuperfile($.Filenames().Exemptions.Input_PR.sprayed, TRUE)
										 ,FileServices.clearsuperfile($.Filenames().Exemptions.Input_HC.sprayed, TRUE)
										 ,FileServices.clearsuperfile($.Filenames().Exemptions.Input_Ins.sprayed, TRUE)
										 ,FileServices.finishSuperFileTransaction()	                            
									);
	// Spray and process exemptions extract from Orbit
	spray_exemption_input_files := SEQUENTIAL(
			$.fSprayFiles.Exemptions_File(pVersion,
										 ,pFilename:=$.Constants.Exemptions(pVersion).FileToSpray_PR
										 ,pDestPath:=$.FileNames().Exemptions.lGlobalSidPRTemplate
										 ,pGroupName:=$.Constants.Exemptions(pVersion).GroupName
										 ,pServerIP:= pHostname
										 ,pDirectory:= pTarget);
			$.fSprayFiles.Exemptions_File(pVersion,
										 ,pFilename:=$.Constants.Exemptions(pVersion).FileToSpray_INS
										 ,pDestPath:=Suppress.FileNames().Exemptions.lGlobalSidInsTemplate
										 ,pGroupName:=$.Constants.Exemptions(pVersion).GroupName
										 ,pServerIP:= pHostname
										 ,pDirectory:= pTarget);
			$.fSprayFiles.Exemptions_File(pVersion,
										 ,pFilename:=$.Constants.Exemptions(pVersion).FileToSpray_HC
										 ,pDestPath:=Suppress.FileNames().Exemptions.lGlobalSidHCTemplate
										 ,pGroupName:=$.Constants.Exemptions(pVersion).GroupName
										 ,pServerIP:= pHostname
										 ,pDirectory:= pTarget);
									);									 
	build_global_sid_base		:= $.Proc_Build_Base_Global_Sid(pVersion);

	// Spray process opt out input file and process sprayed opt out file and minor file
	clear_opt_out_input_file	:= SEQUENTIAL(
										  FileServices.StartSuperFileTransaction()
										 ,FileServices.clearsuperfile($.Filenames().OptOut.input.sprayed, TRUE)
										 ,FileServices.finishSuperFileTransaction()		                            
									);
	spray_opt_out_input_file	:= $.fSprayFiles.OptOutSrc(pVersion,
										 ,pFilename:=$.Constants.OptOut(pVersion).FileToSpray
										 ,pGroupName:=$.Constants.OptOut(pVersion).GroupName
										 ,pDirectory:=pTarget
										 ,pServerIP:= pHostname);
																	
	build_opt_out_base 			:= $.Proc_Build_Base_OptOut(pVersion);

	RETURN SEQUENTIAL(clear_exemption_input_files
						,clear_opt_out_input_file
						,spray_exemption_input_files
						,build_global_sid_base
						,spray_opt_out_input_file
						,build_opt_out_base
						,Proc_Build_Key_New_Suppression_Opt_Out(pVersion)
					 );

END;