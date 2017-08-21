import versioncontrol;

export Build_BH_per_Slim_File(string pversion) := module

	export Spray_Input_Files								:=  PRTE_BIP.SprayFiles(pversion).fSpraySlimFiles('slim');
	export Build_Base_File									:=	PRTE_BIP.Update_Base(files().input_slim_sprayed.using,PRTE_BIP.files('business_header').base.qa,pversion);
	VersionControl.macBuildNewLogicalFile(PRTE_BIP.Filenames('business_header',pversion).base.new,Build_Base_File,NewBase);
	export DeSpray_Updated_Input_Files			:=  PRTE_BIP.DesprayFiles(persistnames().dstandardized,Build_Base_File,pversion);

	slim_file_build 	:= sequential(
														 Spray_Input_Files
													  ,PRTE_BIP.Promote('slim',pversion).slimfiles.Sprayed2Using
														,NewBase
														,DeSpray_Updated_Input_Files
														,PRTE_BIP.Promote('slim',pversion).slimfiles.Using2Used
														,PRTE_BIP.Promote('business_header',pversion).buildfiles.New2Built
														,PRTE_BIP.Promote('business_header',pversion).buildfiles.Built2Qa
														)
														:success(PRTE_BIP.send_email('slim',pversion).buildsuccess)
														,failure(PRTE_BIP.send_email('slim',pversion).buildfailure);	

  export All 	:= if(VersionControl.IsValidVersion(pversion)
										,if (not nothor(FileServices.FileExists(PRTE_BIP.Filenames('business_header',pversion).base.new))
												,slim_file_build
												,output('File: ' + PRTE_BIP.Filenames('business_header',pversion).base.new + ' already exists, skipping build')
												)
										,output('PRTE_BIP.Build_BH_per_Slim_File - No Valid version parameter passed, skipping build')
									 );					

end;