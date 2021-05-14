import tools,_Control,dops,orbit3,Orbit3Insurance;

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
  ,string               pl_inloc                = dops.constants.location
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
                        
	export Roxie	:= Tools.fCheckRoxiePackage(pRoxieEmailList,pPackageName	,pBuildFilenames	,pversion,pUseVersion,pShouldUpdateRoxiePage,pEnvironment,pupdateflag,pl_inloc);
	
  // -- Orbit build instance creation/Update to on-development.  NEED TO WAIT UNTIL WE HAVE ACCESS
  platform_name := map(pEnvironment = 'N'  => 'Non FCRA Roxie' 
                      ,pEnvironment = 'F'  => 'FCRA Roxie'
                      ,                        ''
                   );
                   
  export updateOrbit            := Orbit3.proc_Orbit3_CreateBuild           (pBuildName,pversion,pEnvironment,pEmailList);

  export updateOrbit_Insurance  := Orbit3Insurance.Proc_Orbit3I_CreateBuild (pBuildName,pversion,pEnvironment,pEmailList);
  
  // export updateOrbit_raw := orbit.CreateBuild(pBuildName,pBuildName,pversion,platform_name,orbit.GetToken());

  // export updateOrbit := if (updateOrbit_raw.retdesc = 'Success'
      // ,fileservices.sendemail(
         // pEmailList                                                                
        // ,'Boca Prod '+ pBuildName + ' OrbitI Create Build:'+pversion+':SUCCESS'
        // ,'OrbitI Create build successful: ' + pversion)
      // ,fileservices.sendemail(
          // pEmailList                                                                  
        // ,'Boca Prod '+ pBuildName + ' OrbitI Create Build:'+pversion+':FAILED'
        // ,'OrbitI Create build failed. Reason: ' + updateOrbit_raw.CreateBuildResponse.CreateBuildResult.result.RecordResponseCreateBuild.message)
   // );

end;