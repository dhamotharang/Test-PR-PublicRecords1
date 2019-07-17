IMPORT _CONTROL, dops, Seed_Files;

EXPORT proc_build_Citizenship(STRING fileDate) := FUNCTION

    //Spray input files	
    spray_infiles	:= Seed_Files.spray_Citizenship(fileDate);
    
    //Build keys
    build_keys := Seed_Files.proc_build_Citizenship_Keys(fileDate).allkeys;

    //update DOPs
    Email_Recipients := 'Amila.De@lexisnexisrisk.com, Matthew.Ludewig@lexisnexisrisk.com';
    update_dops		:= dops.updateversion('TestseedDDReportKeys', filedate, Email_Recipients,, 'N');
    //Email
    SHARED email_list := 'Amila.De@lexisnexisrisk.com, Matthew.Ludewig@lexisnexisrisk.com';
    SucessSubject := 'SUCESS: Citizenship Test Seed  Build ' + fileDate + ' Completed on ' + _Control.ThisEnvironment.Name;
    FailureSubject:= 'FAILURE: Citizenship Test Seed  Build ' + fileDate + ' failed on ' + _Control.ThisEnvironment.Name;
    SuccessBody		:=  'Citizenship Test Seed  Build ' + fileDate + ' Completed and is ready for Cert Roxie deployment.';

    build_all := SEQUENTIAL(spray_infiles,
                            build_keys,
                            update_dops) : success(fileservices.sendemail(email_list, SucessSubject, SuccessBody)),
                                          failure(fileservices.sendemail(email_list, FailureSubject, WORKUNIT + '\n' + FAILMESSAGE));

    RETURN build_all;
END;