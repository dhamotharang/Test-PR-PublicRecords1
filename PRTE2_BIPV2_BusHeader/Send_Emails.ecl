import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= false
	,dataset(lay_builds)	pBIPV2FullKeys					= keynames(pversion).dall_filenames
	,string								pEmailList							= 'Edward.Blaushield@lexisnexisrisk.com'
	,string								pRoxieEmailList					= 'Edward.Blaushield@lexisnexisrisk.com'
	,string								pBuildName							= 'PRTE2_BIPV2_BusHeader BizlinkFull'
	,string								pBuildMessage						= 'Base Files Finished'
	,string							  pUseVersion							= 'qa'
	,string							  pEnvironment						= 'N'		//	'N' - nonfcra, 'F' - FCRA, 'BN' = BIPV2
) :=
tools.mod_SendEmails(pversion ,pBIPV2FullKeys		  ,pEmailList ,pRoxieEmailList ,pBuildName ,'BIPV2FullKeys'     ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);
