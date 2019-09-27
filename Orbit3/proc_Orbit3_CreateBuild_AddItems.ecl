import ut,Orbit3,_Control;
export proc_Orbit3_CreateBuild_AddItems(string buildname,string Buildvs,string Envmt = 'N', boolean skipcreatebuild = false,boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false) := function

	tokenval := orbit3.GetToken() : independent;

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval,		
									).retcode : independent;
									
	
									
	Update_build_1 := Orbit3.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									'BUILD_IN_PROGRESS',
									Orbit3.Constants(Envmt,'BUILD_IN_PROGRESS').platform_upd
						                                  
									).retcode;
									
	Update_build := Orbit3.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									'BUILD_AVAILABLE_FOR_USE',
									Orbit3.Constants(Envmt).platform_upd
						                                  
									).retcode;
									
	sendemail(string keyword = '',string status = '') := function 
		
		error_description := map ( keyword = 'CREATE' and status in ['FAIL','SKIP'] => create_build.Message,
		                     keyword = 'UPDATE' and status in ['FAIL','SKIP'] => Update_build.Message,
												 keyword = 'NO_ITEMS_FOUND' and status = 'FAIL' => 'No Build Components found to Add in Orbit',
												 'N/A'
												 );
	   return	 fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify +'; sudhir.kasavajjala@lexisnexis.com',
												' Orbit for Build : '+buildname+',version: '+Buildvs+',Env : '+Orbit3.Constants(Envmt).which_env,
												'BuildName:'+buildname+'\n'+
												'---------------------'+'\n'+
												'Buildversion:'+Buildvs+'\n'+
 										  	'---------------------'+'\n'+
												'Reason:'+keyword+'\n'+
												'---------------------'+'\n'+
												'Status:'+status+'\n'+
												'---------------------'+'\n'+
												'Error Description:'+error_description+'\n'+
												'---------------------'+'\n'+
												'Workunit:'+workunit);
	   end;
		 
		 
BuildNamefmt := regexreplace(' ',StringLib.StringFilterout(  buildname  ,'&_.;+$@!*()~\''),'');
					
		 get_build_candidates := dataset( '~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs,{string ReceiveInstanceID},thor);
		 get_new_build_candidates := project(get_build_candidates,transform(recordof(get_build_candidates),self.receiveinstanceid :=   regexreplace('[^ -~]', left.receiveinstanceid,'')  ));

fn_add_components ( string ReceiveID ) := function
									
return Orbit3.AddItemtoBuild (tokenval,
																	                             	buildname,
																	                            		Buildvs,
																	                             create_build.BuildId,
																	                               [ReceiveID] //Set(get_new_build_candidates (ReceiveInstanceID <> ''), trim(ReceiveInstanceID))
																                               ).retcode; 							
		end;									
	
		add_components := apply(global(get_new_build_candidates,few),Sequential( if ( fn_add_components(trim(ReceiveInstanceID)) = 'Success', sendemail('ADD_ITEMS','SUCCESS'),sendemail('NO_ITEMS_FOUND','FAIL')
																																													                                     )
																																		                                        )
																											);
		
		
		
		
		
												
			
		
	
	run_additem :=  sequential( 
												       output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add'),EXTEND),
															    add_components 
																					
																					
										 
									      );
												

																																																																
	return 
		if( runcreatebuild,
							
								if ( runaddcomponentsonly,
									       run_additem,
											     
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
												
													              if ( Update_build.Status = 'Success', 
													                 sendemail('UPDATE','SUCCESS'),
																					 sendemail('UPDATE','FAIL')
																					 )
														),
													 if ( skipaddcomponents,	
										                        Sequential( Output('Skipping_Add_Components'),output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add')),sendemail('SKIP_ADD_ITEMS','SUCCESS')),
														     
										                                   run_additem
																																
															)
						              )
											 ),
													       
															Output('Run_Create_build_is_false')
													)
											
												
						
								;
								
end;