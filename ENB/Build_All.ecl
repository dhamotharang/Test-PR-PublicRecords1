import versioncontrol, _control;
export Build_All(
    string     pversion
   ,string     pDirectory                    = '/prod_data_build_13/eval_data/experian_national_business/'
   ,string     pServerIP                        = _control.IPAddress.edata10
   ,string     pFilename                        = '*txt'
   ,string     pGroupName                    = _dataset.groupname                                                    
   ,boolean pIsTesting                    = false
   ,boolean pOverwrite                    = false                                                                                            
) :=
module
   lfileversion   := regexreplace('^.*?/([^/]*)[/]?$', pDirectory, '$1');
   
	 export spray_files := if(pDirectory != '', fSprayFiles(
       pDirectory 
      ,lfileversion
      ,pServerIP
      ,pFilename 
      ,pGroupName
      ,pIsTesting
      ,pOverwrite
   ));
   
	 shared dUpdateCompanies	:= Update_Companies	(files().input.using,files().base.Companies.qa	,pversion);
	 shared dUpdateContacts 	:= Update_Contacts	(files().input.using,files().base.Contacts.qa		,pversion);

   VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).base.Companies.new 
                                          ,dUpdateCompanies
                                          ,Build_Companies_Base_File
   );
	 
   VersionControl.macBuildNewLogicalFile(
                                           Filenames(pversion).base.Contacts.new 
                                          ,dUpdateContacts
                                          ,Build_Contacts_Base_File
   );

   all_superfiles := filenames().dAll_filenames;
   
   export full_build := sequential(
       nothor(apply(all_superfiles, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
      ,spray_files
      ,Promote().Input.Sprayed2Using
      ,Build_Companies_Base_File
			,Build_Contacts_Base_File
      ,Promote().Input.Using2Used
      ,Promote(pversion).Base.New2Built
      ,Promote().Base.Built2QA2Father
      ,Strata_Population_Stats(pversion).all
   ) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);
   
   export All :=
   if(VersionControl.IsValidVersion(pversion)
      ,full_build
      ,output('No Valid version parameter passed, skipping build')
   );
end;
