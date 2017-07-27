import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,dataset(lay_builds)	pFilenames    					= dataset([],lay_builds)
	,string								pEmailList							= 'laverne.bentley@lexisnexis.com,charles.morton@lexisnexis.com'
	,string								pRoxieEmailList					= 'laverne.bentley@lexisnexis.com'
	,string								pBuildName							= 'BIPV2_testing'
	,string								pBuildMessage						= 'Base Files Finished'
) :=
  tools.mod_SendEmails(pversion ,pFilenames		  ,pEmailList ,pRoxieEmailList ,pBuildName ,'No Package'     ,pBuildMessage  ,false	);
