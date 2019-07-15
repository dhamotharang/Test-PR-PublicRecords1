import ut,_Control;
export Proc_Orbit3I_CreateBuild_Sample(string buildname,string Buildvs,string Envmt = 'N', boolean runcreatebuild = true) := function

	tokenval := Orbit3Insurance.GetToken();

	createbuild1 :=  Orbit3Insurance.CreateBuild(
									tokenval,
									orbitIConstants('ecrashCRU_Delta').masterbuildname,
									orbitIConstants('ecrashCRU_Delta').buildname,
									Buildvs,
									workunit,
									'BuildAvailableForUse',
									1,
									'N/A',
									orbitIConstants('ecrashCRU_Delta').platform,
									trim(orbitIConstants('ecrashCRU_Delta').platformstatus,left,right)
									);
	
	rbuildupdate					:=	Orbit3Insurance.Layouts.OrbitUpdateBuildInstanceLayout;
	dsbuildup							:=	Dataset([{'',orbitIConstants('ecrashCRU_Delta').buildname,Buildvs,'','','','','','','','',''}],rbuildupdate);	
	
	UpdateBuild	:=	Orbit3Insurance.UpdateBuildInstance(tokenval
																										, dsbuildup
																										,orbitIConstants('ecrashCRU_Delta').buildstatus
																										,orbitIConstants('ecrashCRU_Delta').platform
																										,orbitIConstants('ecrashCRU_Delta').platformstatus
																										, workunit																										
																						        );
emaillist := 'Sudhir.Kasavajjala@lexisnexisrisk.com;  alp-qadata.team@lexisnexis.com';

	return sequential
							(
									if(_Control.ThisEnvironment.Name <> 'Prod_Thor', 
									  if( runcreatebuild,
									    if( createbuild1.CreateBuildResponse.CreateBuildResult.Status = 'Success',
									      if ( UpdateBuild.UpdateBuildInstanceResponse.UpdateBuildInstanceResult.Status = 'Success', 
									                 fileservices.sendemail(
												                              emaillist,
												                               buildname +' Orbit Create and Update Build:'+Buildvs+':SUCCESS for Env : '+Orbit3Insurance.Constants(Envmt).which_env,
												                               buildname +' Create and Update build Success for Env :NonFCRA')
									                                     ,
									               fileservices.sendemail(
												                              emaillist,
												                              buildname +'  Orbit Create and Update Build:'+Buildvs+':FAILED for Env : '+Orbit3Insurance.Constants(Envmt).which_env,
												                              buildname +' Create and Update build failed for Env:'+Orbit3Insurance.Constants(Envmt).which_env +'. Reason: ' + UpdateBuild.UpdateBuildInstanceResponse.UpdateBuildInstanceResult.Message
									                                     )
													   ),
																											 
																 fileservices.sendemail(
												                              emaillist,
												                              buildname +'  Orbit Create  Build:'+Buildvs+':FAILED for Env : '+Orbit3Insurance.Constants(Envmt).which_env,
												                              buildname +' Create  build failed for Env:'+Orbit3Insurance.Constants(Envmt).which_env +'. Reason: ' + createbuild1.CreateBuildResponse.CreateBuildResult.Result.RecordResponseCreateBuild.Message
									                                     )
						          ),	
													
											
									Output('Dont run build')
									),
									output('Not a prod environment')
									),
				
								);
								
end;