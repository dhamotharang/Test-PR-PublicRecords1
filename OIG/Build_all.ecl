import versioncontrol, _control, ut,Roxiekeybuild, lib_stringlib, OIG, Orbit3;

export Build_all(string    pVersion,string filedate) := function 
                     
    current_Keybase      := OIG.Proc_Oig_KeyBase(pVersion);
    Previous_Keybase     := OIG.Files().KeyBase.qa ;
    
    // There were garbage records introduced by a corrupted raw_input file and as a result carried over
    // into the base files. The corruption had no delimiters, so all of the records had only the lastname
    // populated - generally with non-allowable characters. The most efficient method of eliminating the 
    // defective records is to examine the fields such that we remove those records that have data in 
    // just the first field in the record corresponding to the update_raw file and null everywhere else.
    // A final check is for unprintable characters in the lastname (this was the most obvious 'junk' record).
    Filtered_Keybase     := Previous_Keybase(not (lastname  != ''     and
                                                  firstname  = ''     and
                                                  midname    = ''     and
                                                  busname    = ''     and
                                                  general    = ''     and
                                                  specialty  = ''     and
                                                  upin1      = ''     and
                                                  npi        = ''     and
                                                  dob        = ''     and
                                                  address1   = ''     and
                                                  city       = ''     and
                                                  state      = ''     and
                                                  zip5       = ''     and
                                                  sanctype   = ''     and
                                                  sancdate   = ''     and
                                                  reindate   = ''     and
                                                  waiverdate = ''     and
                                                  wvrstate   = '')    and
                                                  not regexfind ('[^[:print:]]', lastname));
                                     
    Test                 := count(nothor(fileservices.superfilecontents(OIG.filenames().Keybuild.qa))) > 0;
    Full_keybase         := sort(if(Test,current_Keybase + Filtered_Keybase, current_Keybase),RECORD);
    
    OIG.Layouts.KeyBuild   rollupXform(OIG.Layouts.KeyBuild  l, OIG.Layouts.KeyBuild  r) := transform
        self.dt_vendor_first_reported  := if(l.dt_vendor_first_reported > r.dt_vendor_first_reported, r.dt_vendor_first_reported, l.dt_vendor_first_reported);
        self.dt_vendor_last_reported   := if(l.dt_vendor_last_reported  < r.dt_vendor_last_reported,  r.dt_vendor_last_reported,  l.dt_vendor_last_reported);
        self.dt_first_seen             := if(l.dt_first_seen > r.dt_first_seen, r.dt_first_seen, l.dt_first_seen);
        self.dt_last_seen              := if(l.dt_last_seen  < r.dt_last_seen,  r.dt_last_seen,  l.dt_last_seen);
        self.NPI                       := if(l.NPI='' or l.NPI='0000000000',  r.NPI,  l.NPI);//added to 
        self.WAIVERDATE                := if(l.WAIVERDATE='',  r.WAIVERDATE,  l.WAIVERDATE);// accomodate layout change
        self.WVRSTATE                  := if(l.WVRSTATE='',  r.WVRSTATE,  l.WVRSTATE);// as per Bug 135721
        self                           := l;
    end;

    new_Keybase                        := rollup(Full_keybase, rollupXform(LEFT,RIGHT), RECORD,EXCEPT dt_vendor_first_reported,dt_vendor_last_reported,dt_first_seen,dt_last_seen,NPI,WAIVERDATE,WVRSTATE);
    
    CreateSuper                        := FileServices.CreateSuperFile(OIG.Cluster+'temp::oig::qa::data',false);
            
    CreateTempKeyBuildIfNotExist       := if(NOT nothor(FileServices.SuperFileExists(OIG.Cluster+'temp::oig::qa::data')),CreateSuper);     

    //Build the KeyBuild Temp file

    VersionControl.macBuildNewLogicalFile(OIG.Cluster+'temp::oig::'+pVersion+'::data',New_Keybase
                                                                                ,Build_KeyBuild_File);
    KeyBuild_main         := sequential(FileServices.StartSuperFileTransaction()
                                                                 ,FileServices.clearsuperfile(OIG.Cluster+'temp::oig::qa::data',true)
                                                                 ,FileServices.AddSuperFile(OIG.Cluster+'temp::oig::qa::data',OIG.Cluster+'temp::oig::'+pVersion+'::data') 
                                                                 ,FileServices.FinishSuperFileTransaction());

    Add_KeyBuildFile      := if(FileServices.FindSuperFileSubName(OIG.Cluster+'temp::oig::qa::data', OIG.Cluster+'temp::oig::'+pVersion+'::data') = 0,KeyBuild_main); 
    
    Base                  := project(new_Keybase ,TRANSFORM(OIG.Layouts.Base,SELF := LEFT;));

    VersionControl.macBuildNewLogicalFile(OIG.Filenames(pversion).base.new,Base,Build_Base_File);
                        
    dops_update           := Roxiekeybuild.updateversion('OIGKeys',pVersion,'saritha.myana@lexisnexis.com;Randy.Reyes@lexisnexisrisk.com;Manuel.Tarectecan@lexisnexisrisk.com;Abednego.Escobal@lexisnexisrisk.com',,'N'); 
    
    orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('OIG',(string)pVersion,'N');
	
    full_build            := sequential (nothor(apply(OIG.filenames().Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
                                         ,nothor(apply(OIG.Keynames(pversion).dall_filenames, apply(dSuperfiles,VersionControl.mUtilities.createsupers(OIG.Keynames(pversion).dall_filenames))))
                                         ,CreateTempKeyBuildIfNotExist
                                         ,OIG.fSprayFiles(filedate)
                                         ,Build_KeyBuild_File
                                         ,Build_Base_File
                                         ,Add_KeyBuildFile
                                         ,OIG.Proc_Build_AutoKeys(pversion)
                                         ,OIG.Proc_Build_RoxieKeys(pversion)
                                         ,OIG.Promote(pversion).New2Built
                                         ,OIG.Promote(pversion).Built2Qa
                                         ,output(choosen(OIG.Files().base.qa (addr_type='B' and bdid<> 0), 1000), named ('Sample_Basefile_BusinessRecords'))
                                         ,output(choosen(OIG.Files().base.qa(addr_type='P'and did<> 0) , 1000), named ('Sample_Basefile_PeopleRecords'))
                                         ,output(choosen(OIG.Files().KeyBase.qa (addr_type='B' and bdid<> 0), 1000), named ('Sample_KeyBasefile_BusinessRecords'))
                                         ,output(choosen(OIG.Files().KeyBase.qa(addr_type='P'and did<> 0) , 1000), named ('Sample_KeyBasefile_PeopleRecords'))
                                         ,OIG.Out_base_OIG_stats_pop(pVersion)
                                         ,dops_update
                                         ,orbit_update
                                         ): success(OIG.send_email(pversion).buildsuccess), failure(OIG.send_email(pversion).buildfailure);
                                                                     

return  if(VersionControl.IsValidVersion(pversion)
                     ,full_build
                     ,output('No Valid version parameter passed, skipping  the build')
                    );
end;