import versioncontrol, _control, ut, tools, pfs, lib_fileservices;

export Build_All(string pversion, boolean pUseProd = false) := function
    mailTarget := 'yoga.raghavaraju@LexisNexis.com;Russell.Streur@lexisnexis.com;kathy.bardeen@lexisnexis.com;Edward.O\'Hare@lexisnexis.com;Jose.Bello@lexisnexis.com;';

    send_email (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

    fileSpray := VersionControl.fSprayInputFiles(pfs.fspray(pversion, pUseProd));
    
    buildAll := sequential(
                    fileSpray, 
                    Process_Files(pversion, pUseProd),

					// Archive the processed file to history - (1) move the in file to the history superfile
                    // and then (2) clear out the contents of the input superfile
                    FileServices.StartSuperFileTransaction(),
                    FileServices.AddSuperFile(Filenames(pversion, pUseProd).pfs_lInputHistTemplate, Filenames(pversion, pUseProd).pfs_lInputTemplate,,true),
                    FileServices.ClearSuperFile(Filenames(pversion, pUseProd).pfs_lInputTemplate),
                    FileServices.FinishSuperFileTransaction()
   				):  success(send_email('PFS Build Completed', pversion + '_PFS build for metrics counts and files completed successfully')),
                    failure(send_email('PFS Build Failure', pversion + '_PFS build for metrics counts and files failed'));
    
    return buildAll;
end;

