import ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild(string buildname,string Buildvs,boolean runcreatebuild = true) := function

	tokenval := orbit3.GetToken();

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval		
									).retcode;
									
	
									
	Update_build := Orbit3.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									'PRODUCTION'
						
									).retcode;
																


	return sequential
							(
									if(_Control.ThisEnvironment.Name <> 'Prod', 
									if( runcreatebuild,
									if( create_build.Status = 'Success',
									   if ( Update_build.Status = 'Success',
									           FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';sudhir.kasavajjala@lexisnexisrisk.com' + ';gregory.rose@lexisnexis.com' + ';darren.knowles@lexisnexisrisk.com',
												buildname+'Orbit Create and Update Build:'+Buildvs+':SUCCESS',
												buildname+'Create build Success')
									          ,
									           FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';sudhir.kasavajjala@lexisnexisrisk.com' + ';gregory.rose@lexisnexis.com' + ';darren.knowles@lexisnexisrisk.com',
												buildname+'  Orbit Create and Update Build:'+Buildvs+':FAILED',
												buildname+'Update build to On Developemnt failed. Reason: ' + Update_build.Message)
									        ),
													 fileservices.sendemail(
												_control.MyInfo.EmailAddressNotify + ';sudhir.kasavajjala@lexisnexisrisk.com' + ';gregory.rose@lexisnexis.com' + ';darren.knowles@lexisnexisrisk.com',
												buildname +'  Orbit Create  Build:'+Buildvs+':FAILED',
												buildname +' Create build failed . Reason: ' + create_build.Message)
										),
									Output('Dont run build')
									),
									output('Not a prod environment')
									),
				
								);

end;