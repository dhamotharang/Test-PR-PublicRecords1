import ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild(string buildname,string Buildvs,string Envmt = 'N', boolean runcreatebuild = true) := function

	tokenval := orbit3.GetToken();

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval,		
									).retcode;
									
	
									
	Update_build := Orbit3.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									'BUILD_AVAILABLE_FOR_USE',
									Orbit3.Constants(Envmt).platform_upd
						                                  
									).retcode;
																


	return sequential
							(
									if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
									if( runcreatebuild,
									if( create_build.Status = 'Success',
									   if ( Update_build.Status = 'Success',
									           fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify,
												buildname +' Orbit Create and Update Build:'+Buildvs+':SUCCESS for Env : '+Orbit3.Constants(Envmt).which_env,
												buildname +' Create build Success for Env :'+Orbit3.Constants(Envmt).which_env)
									          ,
									           fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify,
												buildname +'  Orbit Create and Update Build:'+Buildvs+':FAILED for Env : '+Orbit3.Constants(Envmt).which_env,
												buildname +' Update build failed for Env:'+Orbit3.Constants(Envmt).which_env +'. Reason: ' + Update_build.Message)
									        ),
													
													 fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify,
												buildname +'  Orbit Create  Build:'+Buildvs+':FAILED for Env : '+Orbit3.Constants(Envmt).which_env,
												buildname +' Create build failed for Env:'+Orbit3.Constants(Envmt).which_env +'. Reason: ' + create_build.Message)
									  ),
									Output('Dont run build')
									),
									output('Not a prod environment')
									),
				
								);
								
end;