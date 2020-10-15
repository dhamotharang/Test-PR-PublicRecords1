import ut,Orbit3,_Control;
export proc_Orbit3_CreateBuild_AddItem_sp(string buildname,string Buildvs,string Envmt = 'N',  string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', string email_list = '', boolean skipcreatebuild = false,boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false,boolean is_npf = false, string wuid) := function

	string Envmt_isnpf  := if ( is_npf = true, '',Envmt);

	
	tokenval := orbit3.GetToken() : independent;

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval,		
									).retcode : independent;
									
	get_buildinst := Orbit3.GetBuildInstance(buildname,
									Buildvs,
									tokenval,		
									).retcode : independent;
									
	
									
	Update_build_1 :=  if ( is_npf = false , Orbit3.UpdateBuildInstance(buildname,
									                                                                            Buildvs,
									                                                                            tokenval,
									                                                                            'BUILD_IN_PROGRESS',
									                                                                            Orbit3.Constants(Envmt_isnpf,'BUILD_IN_PROGRESS').platform_upd
						                                  
									                                                                              ).retcode
									);

	//Verify if build is platform depenedent

									
	Update_build := if ( is_npf = true , Orbit3.UpdateBuildInstance(buildname,
									                                Buildvs,
									                                  tokenval,
									                             BuildStatus
						                                  
									                             ).retcode,
										  Orbit3.UpdateBuildInstance(buildname,
									                                Buildvs,
									                                  tokenval,
									                             BuildStatus,
																 Orbit3.Constants(Envmt_isnpf).platform_upd
						                                  
									                             ).retcode
	                        );
									
		get_build_candidates := 	Orbit3.GetBuildCandidates(buildname,
									Buildvs,
									tokenval,
									get_buildinst.BuildId) ; //( Name = 'OFAC*' and version = Buildvs[5..6]+'-'+Buildvs[7..8]+'-'+Buildvs[1..4]);
									
		 
		 get_build_candidates_ofac :=  get_build_candidates (  Name = 'OFAC*' and version = Buildvs[5..6]+'-'+Buildvs[7..8]+'-'+Buildvs[1..4] );
		
		get_build_candidates_final := if (  trim(buildname) = 'Global Watch Lists' and regexfind('o',Buildvs) , get_build_candidates_ofac , get_build_candidates );
									
		 get_new_build_candidates := project(get_build_candidates_final,transform( Orbit3.Layouts.OrbitBuildInstancenewLayout , self := left));

									
	
											
	fn_add_components ( string ComponentType,string DataType,string Family,string Id,string Name,string Status,string Version ) := function
	
	return Orbit3.AddComponentstoBuild(tokenval,
	                            buildname,
									            Buildvs,
						                  dataset([{ComponentType,DataType,Family,Id,Name,Status,Version}],Orbit3.Layouts.OrbitBuildInstanceLayout) 
															);
															
	
															
	end;
									           
											
		add_components := 		apply(global(get_new_build_candidates,few), Sequential(fn_add_components( ComponentType,DataType,Family,Id,Name,Status,Version)));
		
		
		
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
												' Orbit for Build : '+buildname+',version: '+Buildvs+',Env : '+Orbit3.Constants(Envmt_isnpf).which_env,
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
												'Spawn Workunit:'+workunit+ '\n'+
												'---------------------'+'\n'+
												'Build Workunit:'+wuid);
												
		verifystatus := if ( status not in [  'FAIL' , 'ABORT' ] , emailtoall , Sequential ( emailtoall,
									                                                                             Output( 'Orbit Build Instance Update failed .Build Name :'+buildname+ ' Build Version: '+Buildvs+' Reason:'+description )
																					          )
							);
							
		return verifystatus;
	   end;
												
			
		
	
	run_additem :=  sequential( 
												       output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add_'+buildname),EXTEND),
															 if ( count( get_new_build_candidates) > 0 ,Sequential(add_components,sendemail('ADD_ITEMS','SUCCESS')),sendemail('NO_ITEMS_FOUND'))
										 
									      );
												

																																																																
	return 
		if( runcreatebuild,
							
								if ( runaddcomponentsonly, 
								       if ( get_buildinst.Status = 'Success',
									                                 run_additem,
																									 Output('Build Instance does not exist in Orbit for Build Name -- '+buildname +', Build Version --'+Buildvs)
													 ),
											     
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
																				Sequential(sendemail('UPDATE','SKIP'),Update_build_1.Status)	,
												
													              if ( get_buildinst.Status =  'Success' and get_buildinst.BuildInstanceStatus = 'BUILD_IN_PROGRESS', 
																				                                                                                                                                                             if ( Update_build.Status = 'Success', 
													                                                                                                                                                                                                          sendemail('UPDATE','SUCCESS'),
																					                                                                                                                                                                 sendemail('UPDATE','FAIL')
																																																		),
																																																		sendemail('UPDATE','ABORT')
																					 )
														),
													 if ( skipaddcomponents,	
										                        Sequential( Output('Skipping_Add_Components'),output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add_'+buildname),EXTEND),sendemail('SKIP_ADD_ITEMS','SUCCESS')),
														     
										                                   run_additem
																																
															)
						              )
											 ),
													       
															Output('Run_Create_build_is_false')
													)
											
												
						
								;
								
end;