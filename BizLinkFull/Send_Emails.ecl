import tools,bipv2_build;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= true
	,dataset(lay_builds)	pBIPV2FullKeys					= keynames(pversion).dall_filenames
	,string								pEmailList							= bipv2_build.mod_email.emailList
	,string								pRoxieEmailList					= bipv2_build.mod_email.emailList
	,string								pBuildName							= 'BIPV2 Xlink'
	,string								pBuildMessage						= 'Base Files Finished'
	,string							  pUseVersion							= 'qa'
	,string							  pEnvironment						= 'N'		//	'N' - nonfcra, 'F' - FCRA, 'BN' = BIPV2
) :=
tools.mod_SendEmails(pversion ,pBIPV2FullKeys		  ,pEmailList ,pRoxieEmailList ,pBuildName ,'BIPV2FullKeys'     ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);

