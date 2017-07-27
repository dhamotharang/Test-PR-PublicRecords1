import versioncontrol, _control;

export Build_All(
    string	pversion
   ,string	pDirectory	= '/hds_180/CourtLink/20090804'
   ,string	pServerIP	= _control.IPAddress.edata12
   ,string	pFilename	= 'docket.txt'
   ,string	pGroupName	= _Dataset().groupname                                                    
   ,boolean	pIsTesting	= false
   ,boolean pOverwrite	= false                                                                                            
) := module
	lfileversion   := regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');
	
	export spray_files := if(	pDirectory != '' and 
								(not(_Flags.ExistCurrentSprayed) or 
								pOverwrite)
									, fSprayFiles(
													pServerIP
													,pDirectory 
													,pFilename 
													,lfileversion
													,pGroupName
													,pIsTesting
													,pOverwrite
												  )
							 );
							 
   shared dUpdate 		:= Update_Base(files().input.using,files().base.qa,pversion);
   
   VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).base.new 
                                          ,dUpdate
                                          ,Build_Base_File
										);
										
   all_superfiles := filenames().dAll_filenames;
   
   export full_build := sequential(
								nothor(apply(all_superfiles, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
								,nothor(apply(filenames().Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)))
								,spray_files
								,Promote().Input.Sprayed2Using
								,Build_Base_File
								,Promote().Input.Using2Used
								,Promote(pversion).New2Built
								,Promote().Built2QA
								,parallel(
											sequential(
														courtLink.proc_Build_Keys(pversion),
														CourtLink.Proc_Build_AutoKeys(pversion)
													  ),
											CourtLink.Out_Strata_Population_Stats(pversion)
										 )
									) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);
   
   export All := if(VersionControl.IsValidVersion(pversion)
						,full_build
						,output('No Valid version parameter passed, skipping build')
					);
end;
