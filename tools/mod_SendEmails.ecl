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
	,string							  pEnvironment						= ''		//	'N' - nonfcra, 'F' - FCRA
  ,string               pupdateflag             = 'F'

) :=
module

	export BuildSuccess	:= fun_SendEmail(
													 pEmailList
													,pBuildName + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
													,tools.fun_GetWUBrowserString()
												);

	export BuildFailure	:= fun_SendEmail(
													 pEmailList
													,pBuildName + ' Build ' + pversion + ' Failed on ' + _Control.ThisEnvironment.Name
													,tools.fun_GetWUBrowserString() + '\n' + failmessage
												);

	export BuildMessage := fun_SendEmail(
													 pEmailList
													,pBuildName + ': ' + pBuildMessage + ' : ' + pversion + ' on ' + _Control.ThisEnvironment.Name
													,tools.fun_GetWUBrowserString()
												);

	export BuildNote    := fun_SendEmail(
													 pEmailList
													,pBuildName + ': ' + pversion + ' on ' + _Control.ThisEnvironment.Name
													,tools.fun_GetWUBrowserString() + '\n' + pBuildMessage
												);
                        
	export Roxie	:= Tools.fCheckRoxiePackage(pRoxieEmailList,pPackageName	,pBuildFilenames	,pversion,pUseVersion,pShouldUpdateRoxiePage,pEnvironment,pupdateflag);
	

end;