import tools,_Control;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

export mod_SendEmails(
	
	 string								pversion
	,dataset(lay_builds)	pBuildFilenames
	,string								pEmailList
	,string								pRoxieEmailList
	,string								pBuildName
	,string								pPackageName
	,string								pBuildMessage						= ''
	,boolean							pShouldUpdateRoxiePage	= true
	,string							  pUseVersion							= 'qa'

) :=
module

	export BuildSuccess	:= fun_SendEmail(
													 pEmailList
													,pBuildName + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
													,workunit
												);

	export BuildFailure	:= fun_SendEmail(
													 pEmailList
													,pBuildName + ' Build ' + pversion + ' Failed on ' + _Control.ThisEnvironment.Name
													,workunit + '\n' + failmessage
												);

	export BuildMessage := fun_SendEmail(
													 pEmailList
													,pBuildName + ': ' + pBuildMessage + ' : ' + pversion + ' on ' + _Control.ThisEnvironment.Name
													,workunit
												);

	export Roxie	:= Tools.fCheckRoxiePackage(pRoxieEmailList,pPackageName	,pBuildFilenames	,pversion,pUseVersion,pShouldUpdateRoxiePage);
	

end;