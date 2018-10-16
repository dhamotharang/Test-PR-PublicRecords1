import ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild_npf(string buildname,string Buildvs,string BuildStatus = 'BUILD_AVAILABLE_FOR_USE', boolean skipcreatebuild = false,boolean skipupdatebuild = false,  boolean runcreatebuild = true, boolean runaddcomponentsonly = false) := function

	tokenval := orbit3.GetToken();

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval		
									).retcode;
									
	get_buildinst := Orbit3.GetBuildInstance(buildname,
									Buildvs,
									tokenval,		
									).retcode ;
									
	Update_build := Orbit3.UpdateBuildInstance(buildname,
									Buildvs,
									tokenval,
									BuildStatus
						
									).retcode;
																
get_build_candidates := 	Orbit3.GetBuildCandidates(buildname,
									Buildvs,
									tokenval,
									get_buildinst.BuildId) ; //( Name = 'OFAC*' and version = Buildvs[5..6]+'-'+Buildvs[7..8]+'-'+Buildvs[1..4]);
									
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
		
			sendemail(string keyword = '',string status = '') := function 
		
		error_description := map ( keyword = 'CREATE' and status in ['FAIL','SKIP'] => create_build.Message,
		                     keyword = 'UPDATE' and status in ['FAIL','SKIP'] => Update_build.Message,
												 keyword = 'NO_ITEMS_FOUND' and status = 'FAIL' => 'No Build Components found to Add in Orbit',
												 'N/A'
												 );
	   	 emailtoall :=  fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify +'; sudhir.kasavajjala@lexisnexis.com',
												' Orbit for Build : '+buildname+',version: '+Buildvs,
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
												
		verifystatus := if ( status <> 'FAIL' , emailtoall , Sequential ( emailtoall,
									                                                                             FAIL( 'Orbit Build Instance Update Aborted .Build Name :'+buildname+ ' Build Version: '+Buildvs+' Reason:'+error_description )
																					          )
							);
							
		return verifystatus;
	   end;
		
		run_additem :=  sequential( 
												       output(choosen(get_new_build_candidates,all) , named('List_of_Build_Items_to_add_'+buildname),EXTEND),
															 if ( count( get_new_build_candidates) > 0 ,Sequential(add_components,sendemail('ADD_ITEMS','SUCCESS')),sendemail('NO_ITEMS_FOUND','FAIL'))
										 
									      );
		

	return sequential
							(
									if(_Control.ThisEnvironment.Name <> 'Prod', 
									if( runcreatebuild,
									  	if ( runaddcomponentsonly, 
								                     if ( get_buildinst.Status = 'Success',
									                                 run_additem,
																									 Output('Build Instance does not exist in Orbit for Build Name -- '+buildname +', Build Version --'+Buildvs)
													 ),
                                                            	Sequential(	
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
											),							
									Output('Dont run build')
									),
									output('Not a prod environment')
									),
				
								);

end;