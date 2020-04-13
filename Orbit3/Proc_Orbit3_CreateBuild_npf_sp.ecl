import ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild_npf_sp(string buildname,string Buildvs,string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', string email_list = '',boolean skipcreatebuild = false,boolean skipupdatebuild = false,   boolean runcreatebuild = true, string wuid) := function

	tokenval := orbit3.GetToken();

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval		
									).retcode;
									
	get_build:= Orbit3.GetBuildInstance(buildname,
									Buildvs,
									tokenval,		
									).retcode ;
									
	Update_build := Orbit3.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									BuildStatus
						
									).retcode;
																
sendemail(string keyword = '',string status = '') := function 
		
		description := map ( keyword = 'CREATE' and status = 'FAIL'   => create_build.Message,
		                                              keyword = 'CREATE' and status =   'SKIP'  => 'User_Skipped_create_build_instance',
		                     keyword = 'UPDATE' and  status = 'FAIL' => Update_build.Message,
						keyword = 'UPDATE' and  status = 'ABORT' => 'Assigned_to_QA_as_Status_is_not_BUILD_IN_PROGRESS',
						keyword = 'UPDATE' and  status = 'SKIP' => 'User_Skipped_Update_build_instance', 
												 keyword = 'NO_ITEMS_FOUND' and status = 'FAIL' => 'No Build Components found to Add in Orbit',
												 'N/A'
												 );
	   	 emailtoall :=  fileservices.sendemail(
												Send_Email(Buildvs,email_list).emaillist,
												' Orbit for Build : '+buildname+',version: '+Buildvs ,
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
									                                                                             FAIL( 'Orbit Build Instance Update Aborted .Build Name :'+buildname+ ' Build Version: '+Buildvs+' Reason:'+description )
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
												
													              if (  get_build.Status =  'Success' and get_build.BuildInstanceStatus = 'BUILD_IN_PROGRESS',
																	                                                                                                                                                                                  if ( Update_build.Status = 'Success', 
													                                                                                                                                                                                                               sendemail('UPDATE','SUCCESS'),
																					                                                                                                                                                                      sendemail('UPDATE','FAIL')
																																																			 ),
																																																			sendemail('UPDATE','ABORT')
																					 )
														)
											),
									Output('Dont run build')
								   )
				
								);
								
end;