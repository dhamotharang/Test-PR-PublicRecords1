import ut,OrbitPR,_Control;
export Proc_OrbitPR_CreateBuild_sp(string buildname,
                                  string Buildvs,
                                  string Envmt = 'N', 
                                  string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', 
                                  string email_list = '',
                                  boolean skipcreatebuild = false,
                                  boolean skipupdatebuild = false,
                                  boolean runcreatebuild = true,
                                  boolean is_npf = false,
								  boolean isswitch = orbitPR.EnvironmentVariables.switchtonewversion, 
                                  string wuid) := function

  	string Envmt_isnpf  := if ( is_npf = true, '',Envmt);

	
	tokenval := OrbitPR.GetToken(,,isswitch);

	create_build := OrbitPR.CreateBuild(buildname,
									Buildvs,
									tokenval,
									isswitch		
									).retcode;
									
	
	
									
	Update_build := if ( isswitch = true , OrbitPR.UpdateBuildInstance(buildname,
									                                                                 Buildvs,
									                                                                 tokenval,
									                                                                 BuildStatus,
																									 isswitch
						                                  
									                                                                 ).retcode,
										                                   OrbitPR.UpdateBuildInstanceold(buildname,
									                                                                   Buildvs,
									                                                                   tokenval,
									                                                                   BuildStatus,
																                                       OrbitPR.Constants(Envmt_isnpf).platform_upd
						                                  
									                                                                  ).retcode
	                        );
																
sendemail(string keyword = '',string status = '') := function 
		
		description := map ( keyword = 'CREATE' and status = 'FAIL'   => create_build.Message,
		                                              keyword = 'CREATE' and status =   'SKIP'  => 'User_Skipped_create_build_instance',
		                     keyword = 'UPDATE' and  status = 'FAIL' => Update_build.Message,
						keyword = 'UPDATE' and  status = 'ABORT' => 'Update_aborted_as_build_has_been_assigned_to_QA',
						keyword = 'UPDATE' and  status = 'SKIP' => 'User_Skipped_Update_build_instance', 
												 keyword = 'NO_ITEMS_FOUND' and status = 'FAIL' => 'No Build Components found to Add in Orbit',
												 'N/A'
												 );
	   	 emailtoall :=  fileservices.sendemail(
												Send_Email(Buildvs,email_list,buildname,Buildvs ).emaillist,
												' Orbit for Build : '+buildname+',version: '+Buildvs+',Env : '+OrbitPR.Constants(Envmt_isnpf).which_env,
												'BuildName:'+buildname+'\n'+
												'---------------------'+'\n'+
												'Buildversion:'+Buildvs+'\n'+
 										  	'---------------------'+'\n'+
												'Reason:'+keyword+'\n'+
												'---------------------'+'\n'+
												'Status:'+status+'\n'+
												'---------------------'+'\n'+
												'Description:'+description+'\n'+
												'---------------------'+'\n'+
												'Spawn Workunit:'+workunit + '\n' + 
												'---------------------'+'\n'+
												'Build Workunit:'+wuid);
												
		verifystatus := if ( status not in [  'FAIL' , 'ABORT' ] , emailtoall , Sequential ( emailtoall,
									                                                                             Output( 'Orbit Build Instance Update failed .Build Name :'+buildname+ ' Build Version: '+Buildvs+' Reason:'+description )
																					          )
							);
							
		return verifystatus;
	   end;

	return sequential
							(
								
									if( runcreatebuild,
								    Sequential
								         (
									        if ( skipcreatebuild , 
											                sendemail('CREATE','SKIP'),
														 
													           if( create_build.Status = 'Success',
															        sendemail('CREATE','SUCCESS'),
																			sendemail('CREATE','FAIL')
																  )
												),
														
											if ( skipupdatebuild ,
																				sendemail('UPDATE','SKIP')	,
												
													    

                                                                               if ( Update_build.Status = 'Success', 
                                                                                    sendemail('UPDATE','SUCCESS'),
                                                                                     sendemail('UPDATE','FAIL')      
													                                                                           
													                               )

													                      
																  
												)
														

										)


											,
									Output('Dont run build')
									)
								   
				
								);
								
end;
																	                                                                                                                                                                           