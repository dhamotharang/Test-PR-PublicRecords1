import ut,_Control,Orbit3Insurance;
export Proc_Orbit3I_CreateBuild(string buildname,string Buildvs,string Envmt = 'N', boolean runcreatebuild = true) := function

	tokenval := Orbit3Insurance.GetToken();

	createbuild1 :=  Orbit3Insurance.CreateBuild(
									tokenval,
									orbit3IConstants('ecrashCRU_Delta').masterbuildname,
									orbit3IConstants('ecrashCRU_Delta').buildname,
									Buildvs,
									workunit,
									'BUILD_IN_PROGRESS',
									1,
									'N/A',
									orbit3IConstants('ecrashCRU_Delta').platform,
									trim(orbit3IConstants('ecrashCRU_Delta').platformstatus,left,right)
									);
	
	rbuildupdate					:=	Orbit3Insurance.Layouts.OrbitUpdateBuildInstanceLayout;
	dsbuildup							:=	Dataset([{'',orbit3IConstants('ecrashCRU_Delta').buildname,Buildvs,'','','','','','','','',''}],rbuildupdate);	
	
	UpdateBuild	:=	Orbit3Insurance.UpdateBuildInstance(tokenval
																										, dsbuildup
																										,orbit3IConstants('ecrashCRU_Delta').buildstatus
																										,orbit3IConstants('ecrashCRU_Delta').platform
																										,orbit3IConstants('ecrashCRU_Delta').platformstatus
																										, workunit																										
																						        );

	CreateBuildIns :=  sequential(
										  if( runcreatebuild,
									     if( createbuild1.CreateBuildResponse.CreateBuildResult.Status = 'Success',
									      if ( UpdateBuild.UpdateBuildInstanceResponse.UpdateBuildInstanceResult.Status = 'Success', 
									                 fileservices.sendemail(
												                               orbit3IConstants('ecrashCRU_Delta').orbit_createBuild_email,
												                               buildname +' Orbit Create and Update Build:'+Buildvs+':SUCCESS for Env : '+Orbit3Insurance.Constants(Envmt).which_env,
												                               buildname +' Create and Update build Success for Env :NonFCRA')
									                                     ,
									               fileservices.sendemail(
												                              orbit3IConstants('ecrashCRU_Delta').orbit_creBuildErr_email,
												                              buildname +'  Orbit Create and Update Build:'+Buildvs+':FAILED for Env : '+Orbit3Insurance.Constants(Envmt).which_env,
												                              buildname +' Create and Update build failed for Env:'+Orbit3Insurance.Constants(Envmt).which_env +'. Reason: ' + UpdateBuild.UpdateBuildInstanceResponse.UpdateBuildInstanceResult.Message
									                                     )
													   ),
																											 
																 fileservices.sendemail(
												                              orbit3IConstants('ecrashCRU_Delta').orbit_creBuildErr_email,
												                              buildname +'  Orbit Create  Build:'+Buildvs+':FAILED for Env : '+Orbit3Insurance.Constants(Envmt).which_env,
												                              buildname +' Create  build failed for Env:'+Orbit3Insurance.Constants(Envmt).which_env +'. Reason: ' + createbuild1.CreateBuildResponse.CreateBuildResult.Result.RecordResponseCreateBuild.Message
									                                     )
						          ),	
													
											
									Output('Dont run build')
									));
									
return CreateBuildIns;					
								
end;