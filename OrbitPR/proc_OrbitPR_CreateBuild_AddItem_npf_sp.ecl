import ut,OrbitPR,_Control;
export proc_OrbitPR_CreateBuild_AddItem_npf_sp(string buildname,string Buildvs, string email_list = '',boolean skipcreatebuild = false,boolean skipupdatebuild = false,   boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false,string wuid) := function

	tokenval := OrbitPR.GetToken()  : independent;

	create_build := OrbitPR.CreateBuild(buildname,
									Buildvs,
									tokenval		
									).retcode  : independent;
									
									
	
									
	Update_build := OrbitPR.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									'BUILD_AVAILABLE_FOR_USE',
						
									).retcode;
																
get_build_candidates := 	OrbitPR.GetBuildCandidates(buildname,
									Buildvs,
									tokenval,
									create_build.BuildId) ; //( Name = 'OFAC*' and version = Buildvs[5..6]+'-'+Buildvs[7..8]+'-'+Buildvs[1..4]);
									
		 get_new_build_candidates := project(get_build_candidates,transform( OrbitPR.Layouts.OrbitBuildInstancenewLayout , self := left));
									
	
											
	fn_add_components ( string ComponentType,string DataType,string Family,string Id,string Name,string Status,string Version ) := function
	
	return OrbitPR.AddComponentstoBuild(tokenval,
	                            buildname,
									            Buildvs,
									            _Control.MyInfo.EmailAddressNotify,
						                  dataset([{ComponentType,DataType,Family,Id,Name,Status,Version}],OrbitPR.Layouts.OrbitBuildInstanceLayout) 
															);
															
	
															
	end;
									           
											
		add_components := 		apply(global(get_new_build_candidates,few), Sequential(fn_add_components( ComponentType,DataType,Family,Id,Name,Status,Version)));
		
		
		
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
												' Orbit for Build : '+buildname+',version: '+Buildvs,
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
									                                                                             FAIL( 'Orbit Build Instance Update Aborted .Build Name :'+buildname+ ' Build Version: '+Buildvs+' Reason:'+description )
																					          )
							);
							
		return verifystatus;
	   end;
												
			
		
	
	run_additem :=  sequential( 
												       output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add_'+buildname),EXTEND),
															 if ( count( get_new_build_candidates) > 0 ,Sequential(add_components,sendemail('ADD_ITEMS','SUCCESS')),sendemail('NO_ITEMS_FOUND'))
										 
									      );
												

							
		

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
																																																			
																					 
														),
														if ( skipaddcomponents,	
										                        Sequential( Output('Skipping_Add_Components'),output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add_'+buildname),EXTEND),sendemail('SKIP_ADD_ITEMS','SUCCESS')),
														     
										                                   run_additem
																																
															)
											),
									Output('Dont run build')
								   )
				
								);
								
end;