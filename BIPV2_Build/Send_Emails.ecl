import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= true
	,dataset(lay_builds)	pBIPV2FullKeys					= keynames(pversion).BIPV2FullKeys
	,dataset(lay_builds)	pBIPV2WeeklyKeys		  	= keynames(pversion).BIPV2WeeklyKeys
	,dataset(lay_builds)	pBIPV2DatalandKeys    	= keynames(pversion).BIPV2DatalandKeys
	,string								pEmailList							= 'laverne.bentley@lexisnexis.com,5615731227@txt.att.net'
	,string								pRoxieEmailList					= 'laverne.bentley@lexisnexis.com,5615731227@txt.att.net'
	,string								pBuildName							= 'BIPV2'
	,string								pBuildMessage						= 'Base Files Finished'
	,string							  pUseVersion							= 'qa'
	,string							  pEnvironment						= 'N'		//	'N' - nonfcra, 'F' - FCRA, 'BN' = BIPV2
) :=
module
 
	export BIPV2FullKeys      := tools.mod_SendEmails(pversion ,pBIPV2FullKeys		  ,pEmailList ,pRoxieEmailList ,pBuildName ,'BIPV2FullKeys'     ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);
	export BIPV2WeeklyKeys    := tools.mod_SendEmails(pversion ,pBIPV2WeeklyKeys		,pEmailList ,pRoxieEmailList ,pBuildName ,'BIPV2WeeklyKeys'   ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);
	export BIPV2DatalandKeys  := tools.mod_SendEmails(pversion ,pBIPV2DatalandKeys	,pEmailList ,pRoxieEmailList ,pBuildName ,'BIPV2DatalandKeys' ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);

end;