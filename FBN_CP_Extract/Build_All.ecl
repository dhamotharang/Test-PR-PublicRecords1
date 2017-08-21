import versioncontrol, _control, ut;

export Build_All(string	pversion, string bldType='')	:=	module
							 
		shared dMapExperianFiling_updates	:= ExperianUpdates.fFilingAll(pversion);
	 
		VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).Experian.base.ExpFilingBase.new 
                                          ,dMapExperianFiling_updates
                                          ,Build_Experian_Filing_Base_File
																					);
																					
		shared dMapExperianName_updates		:= ExperianUpdates.fNameAll(pversion);
	 
		VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).Experian.base.ExpNamesBase.new 
                                          ,dMapExperianName_updates
                                          ,Build_Experian_Name_Base_File
																					);
																					
		VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).Combined.Out.FilingOut.new 
                                          ,fbn_cp_extract.Files().base.EXPFilingBase.qa + 
																					 fbn_cp_extract.Files().base.FLFilingBase.qa
                                          ,Build_Filing_Output_File
																					);			
																					
		VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).Combined.Out.NamesOut.new 
                                          ,fbn_cp_extract.Files().base.EXPNamesBase.qa + 
																					 fbn_cp_extract.Files().base.FLNamesBase.qa
                                          ,Build_Names_Output_File
																					);	
																					
		
		source_dali											:=	if(VersionControl._Flags.IsDataland,
																							_control.IPAddress.dataland_dali,
																							_control.IPAddress.prod_thor_dali
																					 );
																			
		copy_Filing											:= fileservices.Copy(	Filenames(pversion).Combined.Out.FilingOut.logical,
																													'thor400_198_a',
																													'~thor_data400::out::FBN_Extract::' + pversion + '::Filing',
																													source_dali,,  
																													'http://10.194.12.2:8010/FileSpray',
																													,true,true) : success(send_email(pversion,bldType).CopyFilingSuccess), failure(send_email(pversion,bldType).CopyFilingFailure);
																															 
		copy_Name												:= fileservices.Copy(	Filenames(pversion).Combined.Out.NamesOut.logical,
																													'thor400_198_a',
																													'~thor_data400::out::FBN_Extract::' + pversion + '::Name',
																													source_dali,,
																													'http://10.194.12.2:8010/FileSpray',
																													,true,true) : success(send_email(pversion,bldType).CopyNameSuccess), failure(send_email(pversion,bldType).CopyNameFailure);																													 
   
		export full_Exp_build := sequential(
																				Build_Experian_Filing_Base_File
																				,Build_Experian_Name_Base_File
																				,Promote(pversion,bldType).New2Built
																				,Promote(,bldType).Built2QA
																				,Build_Filing_Output_File
																				,Build_Names_Output_File
																				,copy_Filing	
																				,copy_Name
																			) : success(send_email(pversion,bldType).buildsuccess), failure(send_email(pversion,bldType).buildfailure);
																			
		shared dMapFloridaFiling_updates 		:= FloridaUpdates.fFilingAll(pversion);
	 
		VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).Florida.base.FLFilingBase.new 
                                          ,dMapFloridaFiling_updates
                                          ,Build_Florida_Filing_Base_File
																					);
																					
		shared dMapFloridaName_updates	 		:= FloridaUpdates.fNameAll(pversion);
	 
		VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).Florida.base.FLNamesBase.new 
                                          ,dMapFloridaName_updates
                                          ,Build_Florida_Name_Base_File
																					);	
   
   export full_FL_build := sequential(
																				Build_Florida_Filing_Base_File
																				,Build_Florida_Name_Base_File
																				,Promote(pversion,bldType).New2Built
																				,Promote(,bldType).Built2QA
																			) : success(send_email(pversion,bldType).buildsuccess), failure(send_email(pversion,bldType).buildfailure);																			
   
   export All := if	(VersionControl.IsValidVersion(pversion)
											,if (bldType='E'
														,full_Exp_build
														,if (bldType='F'
																	,full_FL_build
																	,output('No Valid Build Type ("E" or "F") parameter passed, skipping build')
																 )
													)
											,output('No Valid version parameter passed, skipping build')
										);
end;
