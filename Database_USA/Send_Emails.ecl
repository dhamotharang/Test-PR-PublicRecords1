IMPORT tools, dx_Database_USA;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,STRING								pEmailList							
	,STRING								pRoxieEmailList					
	,BOOLEAN							pUseOtherEnvironment 		= FALSE
	,BOOLEAN							pShouldUpdateRoxiePage	= TRUE   
	,DATASET(lay_builds)	pBuildFilenames					= dx_Database_USA.names(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pBuildName							= Database_USA._Constants().Name
	,STRING								pPackageName						= 'DatabaseUSAKeys'
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
												 ,'N');