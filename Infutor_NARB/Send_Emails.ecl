IMPORT tools, dx_Infutor_NARB;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,BOOLEAN							pUseOtherEnvironment 		= FALSE
	,BOOLEAN							pShouldUpdateRoxiePage	= TRUE   
	,DATASET(lay_builds)	pBuildFilenames					= dx_Infutor_NARB.keynames(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pEmailList							= Infutor_NARB.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).BuildSuccess
	,STRING								pRoxieEmailList					= Infutor_NARB.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).Roxie
	,STRING								pBuildName							= Infutor_NARB._Constants().Name
	,STRING								pPackageName						= 'InfutorNARBKeys'
	,STRING								pBuildMessage						= 'Base Files Finished'
) := tools.mod_SendEmails(pversion
		                     ,pBuildFilenames					
		                     ,pEmailList							
		                     ,pRoxieEmailList					
		                     ,pBuildName							
		                     ,pPackageName			
		                     ,pBuildMessage
		                     ,pShouldUpdateRoxiePage
												 ,
												 ,'N'); // Non-FCRA