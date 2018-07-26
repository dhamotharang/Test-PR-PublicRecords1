import ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild_npf(string buildname,string Buildvs,string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', boolean runcreatebuild = true) := function

	tokenval := orbit3.GetToken();

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval		
									).retcode;
									
	
									
	Update_build := Orbit3.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									BuildStatus
						
									).retcode;
																


	return sequential
							(
									if(_Control.ThisEnvironment.Name <> 'Prod', 
									if( runcreatebuild,
									if( create_build.Status = 'Success',
									   if ( Update_build.Status = 'Success',
									           FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';sudhir.kasavajjala@lexisnexis.com',
												buildname+'Orbit Create and Update Build:'+Buildvs+':SUCCESS',
												buildname+'Create build Success')
									          ,
									           FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';sudhir.kasavajjala@lexisnexis.com',
												buildname+'  Orbit Create and Update Build:'+Buildvs+':FAILED',
												buildname+'Create build failed. Reason: ' + create_build.Message)
									        )),
									Output('Dont run build')
									),
									output('Not a prod environment')
									),
				
								);

end;