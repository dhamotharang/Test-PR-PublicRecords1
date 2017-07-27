import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,dataset(lay_builds)	pFilenames    					= filenames(pversion,pUseOtherEnvironment).dall_filenames
	,string								pEmailList							= 'laverne.bentley@lexisnexis.com,charles.morton@lexisnexis.com'
	,string								pRoxieEmailList					= 'laverne.bentley@lexisnexis.com'
	,string								pBuildName							= 'BIPV2_PostProcess'
	,string								pBuildMessage						= 'Base Files Finished'
) :=
  tools.mod_SendEmails(pversion ,pFilenames		  ,pEmailList ,pRoxieEmailList ,pBuildName ,'No Package'     ,pBuildMessage  ,false	);
