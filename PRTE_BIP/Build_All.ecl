import prte, tools, versioncontrol;

export Build_All(string	pversion) := module

	Spray_Input_Files									:=  PRTE_BIP.SprayFiles(pversion).fSprayBaseFiles;
	Build_ALL_BIP_BH_Prepped_Files		:=  PRTE_BIP.PRTE_BIP_BH_Sources_Prepped;
	tools.mac_WriteFile(PRTE_BIP.Filenames('abl_full_file',pversion).base.new	,PRTE_BIP.PRTE_BIP_BH_Sources	,Build_ABL_File	,pShouldExport := false);
	Build_PRTE_BIP_Base_File					:=  PRTE_BIP.FN_Build_PRTE_BIP_BH_Base('business_header',pversion);
	Build_PRTE_BIP_Header_Keys				:=  PRTE_BIP.PRTE_Proc_Build_BIP_Header_keys(pversion);			

	full_build 												:= sequential( Spray_Input_Files
																									,Promote_Files().Input_Sprayed2Using
																									,Build_ALL_BIP_BH_Prepped_Files
																									,Build_ABL_File
																									,Build_PRTE_BIP_Base_File
																									,Promote('business_header',pversion).buildfiles.new2built
																									,Promote('abl_full_file',pversion).buildfiles.new2built
																									,Build_PRTE_BIP_Header_Keys
																									,Promote_Files().Input_Using2Used																									 
																									,Promote('business_header',pversion).buildfiles.built2qa
																									,Promote('abl_full_file',pversion).buildfiles.built2qa
																								 )
																								 :success(PRTE_BIP.send_email('business_header',pversion).buildsuccess)
																								 ,failure(PRTE_BIP.send_email('business_header',pversion).buildfailure);	

  export All 	:= if(VersionControl.IsValidVersion(pversion)
										,if (not nothor(FileServices.FileExists(PRTE_BIP.Filenames('business_header',pversion).base.new))
												,full_build
												,output('File: ' + PRTE_BIP.Filenames('business_header',pversion).base.new + ' already exists, skipping build')
												)
										,output('PRTE_BIP.Build_All - No Valid version parameter passed, skipping build')
									 );						
						
end;