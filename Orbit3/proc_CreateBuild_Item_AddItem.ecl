/* Notes.........
Purpose : To Create and Load Receive Item and Add to build instance
Required Parameters

Build Name : Should match with Master build name
Build version : Orbit build instance version date
Environment : Default : 'N' => 'NonFCRA'
                        'F' => 'FCRA
                         'N|B' => 'NonFCRA and Boolean'
ItemName : Receive Instance Name
Update Type : Update Type of Item 
                Ex : Update-Append,Full-Replace

SourceName : Item Source Name
               for ecrash it is "LexisNexis/SeisintLexisNexis/Seisint - s1"
                Go to Item Management in Orbit and search for Item Name and get the Source Name info

Optional Paramters:
BuildInstanceID :  Hardcoded value needed Only if you want to skip to create build instance and add item to existing build instance

                  Ex : In the QA URL : https://qa.orbit3.risk.regn.net/Orbit3/PR/Build/BuildInstanceGet/333614 -- "333614" is build instance id

skipcreatebuild : True , If you want to skip creating build instance

skipaddcomponents : True,If you don't want to add items to build instance


*/


import ut,Orbit3,_Control;
export proc_CreateBuild_Item_AddItem(string buildname,string Buildvs,string Envmt = 'N',string ItemName, string UpdateType,string SourceName , string BuildInstanceID = '', boolean skipcreatebuild = false, boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreateloaditem = true) := function

	tokenval := orbit3.GetToken() : independent ;
	
	string ReceiveDate := ut.GetTimeDate()[1..10]+'T'+ut.GetTimeDate()[11..12]+':'+ut.GetTimeDate()[13..14]+':'+ut.GetTimeDate()[15..16]+'Z' : INDEPENDENT ;


	create_receive := Orbit3.CreateReceive(	UpdateType,
	                                     ItemName,
				                                  tokenval,
				                                  SourceName,
																					                 ReceiveDate 
									                            ).retcode : independent;
																							
	
																							
 string RecieveID := create_receive.ReceiveInstanceId ;
		
	add_receive := Orbit3.AddReceiveFile(	
	                                     
				                                  tokenval,
																					                 RecieveID
									                            ).retcode;
																							
																							
	Update_receive := Orbit3.UpdateReceive(	UpdateType,
	                                     ItemName,
				                                  tokenval,
				                                  SourceName,
																					                 RecieveID,
																													         ReceiveDate
																					                 
									                            ).retcode;
									
		create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval,		
									).retcode : independent ;
									
	string buildid := if ( skipcreatebuild ,BuildInstanceID, create_build.BuildId);
									
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
	
			add_component_to_build := Orbit3.AddItemtoBuild (tokenval,
																	                             	buildname,
																	                            		Buildvs,
																	                             buildid,
																	                             [RecieveID] 
																                               ).retcode; 													

sendemail(string keyword = '',string status = '') := function 
		
		error_description := map ( keyword = 'CREATE_AND_ADD_ITEM_TO_BUILD' and status in ['FAIL','SKIP'] => add_component_to_build.Message,
		                           keyword = 'CREATE' and status in ['FAIL','SKIP'] => create_build.Message,
		                           keyword = 'UPDATE' and status in ['FAIL','SKIP'] => Update_build_1.Message,
												 		              keyword = 'UPDATE_RECEIVE_ITEM' and status in ['FAIL','SKIP'] => Update_receive.Message,
												 		              keyword = 'CREATE_RECEIVE_ITEM' and status in ['FAIL','SKIP'] => create_receive.Message,

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
												'ItemName:'+ItemName+'\n'+
												'-----------------------'+'\n'+
												'Reason:'+keyword+'\n'+
												'---------------------'+'\n'+
												'Status:'+status+'\n'+
												'---------------------'+'\n'+
												'Error Description:'+error_description+'\n'+
												'---------------------'+'\n'+
												'Workunit:'+workunit);
	   end;
												

	return sequential
							(
									if(_Control.ThisEnvironment.Name <> 'Prod_Thor', 
									if( runcreateloaditem,
									if( create_receive.Status = 'Success',
									   if ( add_receive.Status = 'Success',
										       if ( Update_receive.Status = 'Success',
													                                          Sequential(if ( skipcreatebuild , 
											                                                                            sendemail('CREATE_BUILD','SKIP'),
																			                                                                 if ( create_build.Status <> 'Success',sendemail('CREATE_BUILD','FAIL'))
																							                                                ),
																	                                                  if ( skipupdatebuild ,
																				                                                                    sendemail('UPDATE','SKIP'),
																																																						                 if ( Update_build_1.Status = 'Success'	,
												                                                               if ( Update_build.Status = 'Success', 
													                                                                           sendemail('UPDATE','SUCCESS'),
																					                                                                  sendemail('UPDATE','FAIL')
																					                                                      )
													                                                           	)
																																											                            ),
																								                                             if ( skipaddcomponents,	Sequential( Output('Skipping_Add_Component ID --'+RecieveID),sendemail('SKIP_ADD_ITEMS','SUCCESS')),
																					                                                    if ( add_component_to_build.Status = 'Success',
									                                                                                                              sendemail('CREATE_AND_ADD_ITEM_TO_BUILD','SUCCESS'),
									                                                                                                               sendemail('CREATE_AND_ADD_ITEM_TO_BUILD','FAIL')
																																		                                            )
																																																								                  )
																																																																	 ),
																																																								
									                                                      
																																																					           
																																																	          sendemail('UPDATE_RECEIVE_ITEM','FAIL')                                
									                                                         
																									                                           	)),
																																																	
									                                                   sendemail('CREATE_RECEIVE_ITEM','FAIL')                                         
									                                         
																						),
																																																
																																																								                    
																																						                             
													
									Output('Dont run build')
									),
									output('Not a prod environment')
									),
				
								);
								
end;