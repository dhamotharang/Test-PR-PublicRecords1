import tools,_control;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		    = false
	,boolean							pShouldUpdateRoxiePage	    = true
	,dataset(lay_builds)	pBIPV2FullKeys					    = keynames(pversion).BIPV2FullKeys
	,dataset(lay_builds)	pBIPV2WeeklyKeys		  	    = keynames(pversion).BIPV2WeeklyKeys
	,dataset(lay_builds)	pBIPV2DatalandKeys    	    = keynames(pversion).BIPV2DatalandKeys
	,string								pEmailList							    = BIPV2_Build.mod_email.emailList
	,string								pRoxieEmailList					    = BIPV2_Build.mod_email.emailList
	,dataset(lay_builds)	pBIPV2FullKeys_Alpha        = keynames(pversion).BIPV2FullKeys_Alpha
	,dataset(lay_builds)	pBIPV2SuppressionKeys_Alpha = keynames(pversion).BIPV2SuppressionKeys_Alpha
	,string								pBuildName							    = 'BIPV2'
	,string								pBuildMessage						    = 'Base Files Finished'
	,string							  pUseVersion							    = 'qa'
	,string							  pEnvironment						    = 'N'		//	'N' - nonfcra, 'F' - FCRA, 'BN' = BIPV2
) :=
module
 
	export BIPV2FullKeys              := tools.mod_SendEmails(pversion ,pBIPV2FullKeys		          ,pEmailList ,pRoxieEmailList ,pBuildName                ,'BIPV2FullKeys'         ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);
	export BIPV2WeeklyKeys            := tools.mod_SendEmails(pversion ,pBIPV2WeeklyKeys		        ,pEmailList ,pRoxieEmailList ,'BIPV2 Weekly Keys Build' ,'BIPV2WeeklyKeys'       ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);
	export BIPV2DatalandKeys          := tools.mod_SendEmails(pversion ,pBIPV2DatalandKeys	        ,pEmailList ,pRoxieEmailList ,pBuildName                ,'BIPV2DatalandKeys'     ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment);
	export BIPV2FullKeys_Alpha        := tools.mod_SendEmails(pversion ,pBIPV2FullKeys_Alpha    	  ,pEmailList ,pRoxieEmailList ,'BIPV2 Full Build'        ,'BIPV2FullKeys'         ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment,,'A');
	export BIPV2SuppressionKeys_Alpha := tools.mod_SendEmails(pversion ,pBIPV2SuppressionKeys_Alpha ,pEmailList ,pRoxieEmailList ,'BIPV2Suppression'        ,'BIPV2SuppressionKeys'  ,pBuildMessage  ,pShouldUpdateRoxiePage	,pUseVersion,pEnvironment,,'A');

end;