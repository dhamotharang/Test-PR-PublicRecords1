import VersionControl, _control;
export Send_Email(string pversion) :=
module
   shared SuccessSubject := if(VersionControl.IsValidVersion(pversion)
                                             ,_Dataset().name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
                                             ,_Dataset().name + ' Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
                                          );
   shared SuccessBody      := if(VersionControl.IsValidVersion(pversion)
                                             ,workunit
                                             ,workunit + '\nPlease pass in a version date parameter to ' + _Dataset().name + '.Build_All and then resubmit through querybuilder.' +
                                              '\nSee ' + _Dataset().name + '._bwr_Build_All attribute for more details.'
                                          );
   
   export BuildSuccess  := fileservices.sendemail(
                                       Email_Notification_Lists.BuildSuccess,
                                       SuccessSubject,
                                       SuccessBody);
   export BuildFailure  := fileservices.sendemail(
                                       Email_Notification_Lists.BuildFailure,
                                       _Dataset().name + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
                                       workunit + '\n' + failmessage);
/*
   export Roxie :=
   module
   
      export QA := versioncontrol.fSendRoxieEmail( 
                   Email_Notification_Lists.roxie
                  ,_Dataset().name
                  ,keynames('').dAll_superkeynames(regexfind('^(.*)::[qQ][aA]::(.*)$', name))
                  ,pversion
                  );
      
      export Prod := versioncontrol.fSendRoxieEmail( 
                   Email_Notification_Lists.roxie
                  ,_Dataset().name
                  ,keynames('').dAll_superkeynames(regexfind('^(.*)::[pP][rR][oO][dD]::(.*)$', name))
                  ,pversion
                  );
   
   
   end;
*/
end;
