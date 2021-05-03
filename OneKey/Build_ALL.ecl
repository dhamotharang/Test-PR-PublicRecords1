IMPORT OneKey, ut, _Control, tools, Scrubs, Scrubs_OneKey;

EXPORT Build_ALL(
   STRING                                         pversion
  ,BOOLEAN                                        pUseProd        = FALSE
  ,STRING                                         pGroupName      = OneKey._Dataset(pUseProd).groupname																		
  ,BOOLEAN                                        pIsTesting      = FALSE
  ,BOOLEAN                                        pOverwrite      = FALSE																															
  ,DATASET(OneKey.Layouts.InputA.Sprayed)         pSprayedFileA   = OneKey.Files().InputA.using
  ,DATASET(OneKey.Layouts.InputB.Sprayed)         pSprayedFileB   = OneKey.Files().InputB.using
  ,DATASET(OneKey.Layouts.Base)                   pBaseFile       = OneKey.Files().base.qa	
) := FUNCTION

  full_build :=
    SEQUENTIAL(
      OneKey.Create_Supers
     ,OneKey.Spray(pversion,,,,,,,,,pGroupName,pIsTesting,pOverwrite)
     ,OneKey.Promote().Inputfiles.Sprayed2Using
     ,Scrubs.ScrubsPlus('OneKey', 'Scrubs_OneKey', 'Scrubs_OneKey_InputA', 'InputA', pversion, OneKey.Email_Notification_Lists(pIsTesting).BuildFailure, FALSE)
     ,Scrubs.ScrubsPlus('OneKey', 'Scrubs_OneKey', 'Scrubs_OneKey_InputB', 'InputB', pversion, OneKey.Email_Notification_Lists(pIsTesting).BuildFailure, FALSE)
     ,IF(Scrubs.mac_ScrubsFailureTest('Scrubs_OneKey_InputA,Scrubs_OneKey_InputB',pversion)
        ,OUTPUT('Scrubs passed.  Continuing to the Build_Base step.')				
        ,FAIL('Scrubs failed.  Base not built.  Processing stopped.')
        )
     ,OneKey.Build_Base(pversion, pIsTesting, pSprayedFileA, pSprayedFileB, pBaseFile)
     ,OneKey.Build_Strata(pversion, pOverwrite, , , pIsTesting)
     ,OneKey.Promote().Inputfiles.using2used
     ,OneKey.Promote().Buildfiles.Built2QA
     ,OneKey.QA_Records()
    ): SUCCESS(OneKey.Send_Emails(pversion,,NOT pIsTesting).BuildSuccess), FAILURE(OneKey.Send_Emails(pversion,,NOT pIsTesting).BuildFailure);
	
  RETURN IF(tools.fun_IsValidVersion(pversion), full_build, OUTPUT('No Valid version parameter passed, skipping OneKey.Build_All'));

END;