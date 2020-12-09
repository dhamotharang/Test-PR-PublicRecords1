// See also: AlloyMediaConsumer._BWR_Build
IMPORT STD,_control,tris_lnssi_build,VersionControl,BuildLogger,Orbit3,Roxiekeybuild, scrubs_tris_lnssi;

EXPORT proc_build_all(string filedate,string moreEmails='') := function

    eml := _control.MyInfo.EmailAddressNotify + moreEmails; // add more starting with ','
    bldnm:=tris_lnssi_build.constants.build_name;
    
    string  dataset_name	:= bldnm;
    string  emailList  		:= eml;

    // setup info for logger and notification
    #stored('dataset_name',dataset_name);
    #stored('emailList'   ,emailList);
    #stored('job_name'    ,STD.System.Job.Name());
    #stored('version'     ,filedate);

    successEmail:= STD.System.Email.SendEmail(emailList,'success: '+bldnm,'See:'+workunit);
    failureEmail:= STD.System.Email.SendEmail(emailList,'FAILURE: '+bldnm,failmessage+'\r\n'+
                                                                        'See:'+workunit);

    #WORKUNIT('name',bldnm+' '+filedate);
    
    
    archive_old_inputs := sequential(
                            std.file.createsuperfile(tris_lnssi_build.constants.archive_filename,,true),
                            std.file.addsuperfile(
                                tris_lnssi_build.constants.archive_filename,
                                tris_lnssi_build.constants.input_filename,    ,true),
                            std.file.clearsuperfile(tris_lnssi_build.constants.input_filename)
                           );
    
    pUseProd:=false;    
    spray_new  		 := VersionControl.fSprayInputFiles(            // this will spray the source directory EVEN IF it's the old data
                    tris_lnssi_build.fSpray(filedate,pUseProd));  // only the version you supply matters
		update_dops := RoxieKeyBuild.updateversion('TrisISPKeys',(filedate),'Darren.Knowles@lexisnexisrisk.com;Gabriel.Marcan@lexisnexisrisk.com',,'N');
		update_orbit := Orbit3.proc_Orbit3_CreateBuild_AddItem('TRIS_LNSSI',(filedate),'N');

    actions := sequential(
    
        BuildLogger.BuildStart()
        ,archive_old_inputs
        ,spray_new 
        ,scrubs_tris_lnssi.fn_runscrubs(filedate) // call to the scrubs function to make a new Scrubs report
        ,tris_lnssi_build.proc_build_base(filedate) // run ingest on the input file and update base file
        ,tris_lnssi_build.proc_build_keys(filedate)
				,update_dops
				,update_orbit
        ,BuildLogger.BuildEnd()

    ): success(successEmail),failure(failureEmail);

    return actions;

end;