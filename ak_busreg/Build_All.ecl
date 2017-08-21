import versioncontrol, _control;
export Build_All(
    string     pversion
   ,string     pDirectory                    = '/prod_data_build_10/production_data/business_headers/ak_busreg/20080616'
   ,string     pServerIP                        = _control.IPAddress.edata10
   ,string     pFilename                        = 'ak_busreg*d00'
   ,string     pGroupName                    = _Dataset().groupname                                                    
   ,boolean pIsTesting                    = false
   ,boolean pOverwrite                    = false                                                                                            
) :=
module
   lfileversion   := regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');
   export spray_files := if(	pDirectory != ''
															and (not(_Flags.ExistCurrentSprayed)
																		or pOverwrite
																	)
		, fSprayFiles(
       pServerIP
      ,pDirectory 
      ,pFilename 
      ,lfileversion
      ,pGroupName
      ,pIsTesting
      ,pOverwrite
   ));
   shared dUpdate := Update_Base(files().input.using,files().base.qa,pversion);
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
      ,Strata_Population_Stats(pversion).all
   ) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);
   
   export All :=
   if(VersionControl.IsValidVersion(pversion)
      ,full_build
      ,output('No Valid version parameter passed, skipping build')
   );
end;
