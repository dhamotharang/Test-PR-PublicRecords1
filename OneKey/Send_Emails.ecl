IMPORT tools, OneKey;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(STRING pversion
                  ,BOOLEAN pUseOtherEnvironment          = FALSE
                  ,BOOLEAN pShouldUpdateRoxiePage        = TRUE
                  // ,DATASET(lay_builds) pBuildFilenames   = OneKey.Keynames(pversion,pUseOtherEnvironment).dAll_filenames  //Placeholder for/when keys built
                  ,DATASET(lay_builds) pBuildFilenames   = OneKey.Filenames(pversion,pUseOtherEnvironment).dAll_Basefilenames
                  ,STRING pEmailList                     = OneKey.Email_Notification_Lists(not pShouldUpdateRoxiePage).BuildSuccess
                  ,STRING pRoxieEmailList                = OneKey.Email_Notification_Lists(not pShouldUpdateRoxiePage).Roxie
                  ,STRING pBuildName                     = OneKey._Constants().Name
                  ,STRING pPackageName                   = 'NoKeysForOneKey'
                  ,STRING pBuildMessage                  = 'Base Files Finished' + 'Remember to Update Dops196'
                  ,STRING pUseVersion                    = 'qa'
                  ,STRING pEnvironment                   = 'N') := 

  tools.mod_SendEmails(pversion
                      ,pBuildFilenames					
                      ,pEmailList							
                      ,pRoxieEmailList					
                      ,pBuildName							
                      ,pPackageName			
                      ,pBuildMessage
                      ,pShouldUpdateRoxiePage	
                      ,pUseVersion
                      ,pEnvironment);
