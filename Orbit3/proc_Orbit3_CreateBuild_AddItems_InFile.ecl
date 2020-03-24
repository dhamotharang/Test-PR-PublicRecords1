﻿
import ut,Orbit3,_Control;
export proc_Orbit3_CreateBuild_AddItem_Test(string buildname,string Buildvs,string Envmt = 'N', dataset({string Name,string version}) items_list = DATASET([],{string Name,string version}), boolean skipcreatebuild = false,boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreatebuild = true, boolean runaddcomponentsonly = false) := function

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
									create_build.BuildId) ;
									
			
									
		
									
		 get_new_build_candidates := project(get_build_candidates  ,transform( Orbit3.Layouts.OrbitBuildInstancenewLayout , self := left));
		 
		 //Join with the data provided by user
		 
		 Orbit_Items_match := join ( sort(get_new_build_candidates,Name,Version), sort(items_list,Name,Version),
		                             left.Name = right.Name and
																 left.version = right.version,
											       transform(recordof(get_new_build_candidates),self := left));
                               
									
	
											
	fn_add_components ( string ComponentType,string DataType,string Family,string Id,string Name,string Status,string Version ) := function
	
	return Orbit3.AddComponentstoBuild(tokenval,
	                            buildname,
									            Buildvs,
									            _Control.MyInfo.EmailAddressNotify,
						                  dataset([{ComponentType,DataType,Family,Id,Name,Status,Version}],Orbit3.Layouts.OrbitBuildInstanceLayout) 
															);
															
	
															
	end;
									           
											
		add_components := 		apply(global(Orbit_Items_match,few), Sequential(fn_add_components( ComponentType,DataType,Family,Id,Name,Status,Version)));
		
		
		
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
												
			
		
	
	run_additem :=  sequential( 
												       output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add'),EXTEND),
															 if ( count( get_new_build_candidates) > 0 ,Sequential(add_components,sendemail('ADD_ITEMS','SUCCESS')),sendemail('NO_ITEMS_FOUND','FAIL'))
										 
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