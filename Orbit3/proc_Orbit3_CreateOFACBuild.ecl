
import ut,Orbit3,_Control;
export proc_Orbit3_CreateOFACBuild(string buildname,string Buildvs,string Envmt = 'N', boolean skipcreatebuild = false,boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false) := function

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
									
		get_build_candidates := 	Orbit3.GetBuildCandidates(buildname,
									Buildvs,
									tokenval,
									create_build.BuildId) ( Name = 'OFAC*' and version = Buildvs[5..6]+'-'+Buildvs[7..8]+'-'+Buildvs[1..4]) : GLOBAL(FEW);
									
		 get_new_build_candidates := project(get_build_candidates,transform( Orbit3.Layouts.OrbitBuildInstancenewLayout , self := left));
									
	
											
	fn_add_components ( string ComponentType,string DataType,string Family,string Id,string Name,string Status,string Version ) := function
	
	return Orbit3.AddComponentstoBuild(tokenval,
	                            buildname,
									            Buildvs,
									            _Control.MyInfo.EmailAddressNotify,
						                  dataset([{ComponentType,DataType,Family,Id,Name,Status,Version}],Orbit3.Layouts.OrbitBuildInstanceLayout) 
															);
															
	
															
	end;
									           
											
		add_components := 		apply(global(get_new_build_candidates,few), Sequential(fn_add_components( ComponentType,DataType,Family,Id,Name,Status,Version)));
		
		
		
		send_email(string keyword,string status) := function 
		
		error_description := map ( keyword = 'CREATE' and status in ['FAIL','SKIP'] => 'Build Instance Already Exists in Orbit',
		                     keyword = 'UPDATE' and status = 'FAIL' => 'Build Instance Already Exists and Updated to On Develelopment in Orbit',
												 keyword = 'UPDATE' and status = 'SKIP' => 'Build Instance did not get Updated to On Develelopment as skipupdatebuild parameter is passed true',
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
												
			
		
	
	run_additem :=  sequential( 
												       output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add'),EXTEND),
															 if ( count( get_new_build_candidates) > 0 ,Sequential(add_components,send_email('ADD_ITEMS','SUCCESS')),send_email('NO_ITEMS_FOUND','FAIL'))
										 
									      );
												

																																																																
	return 
		if( runcreatebuild,
							
								if ( runaddcomponentsonly,
									       run_additem,
											     
	                      Sequential
								         (
									        if ( skipcreatebuild , 
											                send_email('CREATE','SKIP'),
														 
													           if( create_build.Status = 'Success',
															        send_email('CREATE','SUCCESS'),
																			send_email('CREATE','FAIL')
																			)
															),
														
													if ( skipupdatebuild ,
																				Sequential(send_email('UPDATE','SKIP'),Update_build_1.Status)	,
												
													              if ( Update_build.Status = 'Success', 
													                 send_email('UPDATE','SUCCESS'),
																					 send_email('UPDATE','FAIL')
																					 )
														),
													 if ( skipaddcomponents,	
										                        Sequential( Output('Skipping_Add_Components'),output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add')),send_email('SKIP_ADD_ITEMS','SUCCESS')),
														     
										                                   run_additem
																																
															)
						              )
											 ),
													       
															Output('Run_Create_build_is_false')
													)
											
												
						
								;
								
end;