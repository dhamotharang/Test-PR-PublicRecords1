/* Notes.........
Purpose : To Create and Load Receive Item and Add to build instance
Required Parameters

Build Name : Should match with Master build name
Build version : Orbit build instance version date
Environment : Default : 'N' => 'NonFCRA'
                        'F' => 'FCRA
                         'N|B' => 'NonFCRA and Boolean'
ItemName : Receive Instance Name


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
export proc_CreateBuild_Item_AddItem(string buildname,string Buildvs,string Envmt = 'N', dataset(Orbit3.Layouts.InputItem) dsitem   ,  boolean skipcreatebuild = false, boolean skipupdatebuild = false, boolean skipaddcomponents = false, boolean runcreateloaditem = true,boolean runaddcomponentsonly = false) := function

	tokenval := orbit3.GetToken() :independent ;
	string wuid := workunit:independent ;
	
	
	create_build := orbit3.CreateBuild(buildname,
									                  Buildvs,
									                  tokenval,		
									                 ).retcode  ;
									
	
		get_buildinst := Orbit3.GetBuildInstance(buildname,
									                                  Buildvs,
									                                  tokenval,		
									                                 ).retcode;
		
		string buildid := get_buildinst.BuildId;
								
									
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
	

// run add items
 


 fn_add_update_receive(  string ItemName, string SourceName,string ReceiveDate,string FilePathName, string ReceiveIDIn ) := function

		
	add_receive := Orbit3.AddReceiveFile(	
	                                                                  tokenval,
										                        ReceiveIDIn,
															FilePathName							
									                            ).retcode;
																							
 string getFilePathName := 	trim(add_receive.FilePathName);
 
 	
	
	
	Update_receive := Orbit3.UpdateReceive(	
	                                                                         ItemName,
				                                                          tokenval,
				                                                           SourceName,
															        ReceiveIDIn,
															       ReceiveDate
																					                 
									                            ).retcode;
	
		
	    add_items := Orbit3.AddItemtoBuild (tokenval,
															buildname,
															Buildvs,
															 buildid,
															[ReceiveIDIn] 
														 ).retcode; 
	
shared	sendemailitem(string keyword = '',string status = '' ) := function 
		
		error_description := map (  keyword = 'RECEIVEITEM_ALREADY_EXIST_IN_ORBIT' and status in ['FAIL','SKIP'] => 'Receive ID --'+ReceiveIDIn+' Already exists in Orbit for ItemName --'+ItemName,
		                                               keyword = 'CREATE_AND_ADD_ITEM_TO_BUILD' and status in ['FAIL','SKIP'] => add_items.Message,
												keyword='ADD_ITEM_ONLY_TO_BUILD_INSTANCE'  and status in ['FAIL','SKIP'] => add_items.Message,
		                                               keyword = 'CREATE' and status in ['FAIL','SKIP'] => create_build.Message,
		                                               keyword = 'UPDATE' and status in ['FAIL','SKIP'] => Update_build_1.Message,
								               keyword = 'UPDATE_ITEM_STATUS_TO_LOADED' and status in ['FAIL','SKIP'] => Update_receive.Message,
                                                          keyword = 'ADD_RECEIVEITEM_IN_ORBIT' and status in ['FAIL','SKIP'] => add_receive.Message,
					                               keyword = 'NO_ITEMS_PASSED' and status = 'FAIL' => 'No Item paramters  passed ',
											keyword = 'NO_ITEMS_FOUND' and status = 'FAIL' => 'No Build Components found to Add in Orbit',
												               'N/A'
												              );
	   return	 fileservices.sendemail(
												'sudhir.kasavajjala@lexisnexis.com',
												' Orbit for Build : '+buildname+',version: '+Buildvs+',Env : '+Orbit3.Constants(Envmt).which_env,
												'BuildName:'+buildname+'\n'+
												'---------------------'+'\n'+
												'Buildversion:'+Buildvs+'\n'+
 										  	'---------------------'+'\n'+
												'ItemName:'+ItemName+'\n'+
												'-----------------------'+'\n'+
												'SourceName:'+SourceName+'\n'+
												'-----------------------'+'\n'+
												'FilePathName:'+getFilePathName+'\n'+
												'-----------------------'+'\n'+

												'Reason:'+keyword+'\n'+
												'---------------------'+'\n'+
												'Status:'+status+'\n'+
												'---------------------'+'\n'+
												'ReceiveID:'+ReceiveIDIn+'\n'+
												'---------------------'+'\n'+
												'Error Description:'+error_description+'\n'+
												'---------------------'+'\n'+
												'Workunit:'+wuid);
	   end;	
														 
	return	
	                                       
	                Sequential(

                                	if( add_receive.Status = 'Success',  
																	                      sendemailitem('ADD_RECEIVEITEM_IN_ORBIT','SUCCESS') ,
																					 sendemailitem('ADD_RECEIVEITEM_IN_ORBIT','FAIL') 
							        ),

	                                 if( Update_receive.Status = 'Success',  
																						sendemailitem('UPDATE_ITEM_STATUS_TO_LOADED','SUCCESS') ,  
																						sendemailitem('UPDATE_ITEM_STATUS_TO_LOADED','FAIL') 
									                                                             
				                     ),

	
	                                if ( add_items.Status = 'Success',
									                                                     sendemailitem('CREATE_AND_ADD_ITEM_TO_BUILD_INSTANCE','SUCCESS') ,
									                                                     sendemailitem('CREATE_AND_ADD_ITEM_TO_BUILD_INSTANCE','FAIL') 
								   )	
								
			                     );
																															 
	end;
			
//Create Receive Item and Change Status to LOADED and add the item to build instance	
fn_create_load_item (  string ItemName, string SourceName,string ReceiveDateTape,string FilePathName ) := function 

//Test whether receiveInstance exists
get_receive := Orbit3.GetReceiveInstanceID(	FilePathName,
	                                                                                 tokenval
				                                                              ).retcode ;
																																			
OldReceiveID := trim(get_receive.ReceiveInstanceId);

ReceiveDateTapefmt := ReceiveDateTape[1..4] + '-'+ ReceiveDateTape[5..6] + '-'+ ReceiveDateTape[7..8];
	
	string ReceiveDate := ReceiveDateTapefmt[1..10]+'T'+ut.GetTimeDate()[11..12]+':'+ut.GetTimeDate()[13..14]+':'+ut.GetTimeDate()[15..16]+'Z'   ;


	create_receive := Orbit3.CreateReceive(	
	                                                                      ItemName,
				                                                      tokenval,
				                                                       SourceName,
											                  ReceiveDate 
									                            ).retcode ;
																							
																							
 string NewReceiveID := trim(create_receive.ReceiveInstanceId)  ;
 
 string  ReceiveIDIn := if ( OldReceiveID <> '', OldReceiveID, NewReceiveID);
 
  sendemailitemcreate(string keyword = '',string status = '') := function 
		
		error_description := map ( 
							                    keyword = 'CREATE_RECEIVEITEM_IN_ORBIT' and status in ['FAIL','SKIP'] => create_receive.Message,
                                                    
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
												'SourceName:'+SourceName+'\n'+
												'-----------------------'+'\n'+
												'FilePathName:'+FilePathName+'\n'+
												'-----------------------'+'\n'+

												'Reason:'+keyword+'\n'+
												'---------------------'+'\n'+
												'Status:'+status+'\n'+
												'---------------------'+'\n'+
												'ReceiveID:'+ReceiveIDIn+'\n'+
												'---------------------'+'\n'+
												'Error Description:'+error_description+'\n'+
												'---------------------'+'\n'+
												'Workunit:'+wuid);
	   end;	

   return   Sequential ( if ( OldReceiveID =  '',  
															
																if( create_receive.Status = 'Success',  
																				        sendemailitemcreate('CREATE_RECEIVEITEM_IN_ORBIT','SUCCESS'),  
																					  sendemailitemcreate( 'CREATE_RECEIVEITEM_IN_ORBIT','FAIL')
									                                            )
								    ),
 
               fn_add_update_receive ( ItemName,  SourceName, ReceiveDate, FilePathName,  ReceiveIDIn)
						 )
						;
 end;
 

	
create_add_item := apply ( global(dsitem,few), fn_create_load_item(  ItemName,SourceName,ReceiveDateTape,FilePathName)
                                           
																					 
						                  );

//Add Items Only
//***************/															
fn_add_item (  string FilePathName ) := function 

//Test whether receiveInstance exists
get_receive := Orbit3.GetReceiveInstanceID(	FilePathName,
	                                                                                 tokenval
				                                                              ).retcode ;
																																			
OldReceiveID := trim(get_receive.ReceiveInstanceId);

   add_items := Orbit3.AddItemtoBuild (tokenval,
															buildname,
															Buildvs,
															 buildid,
															[OldReceiveID] 
														 ).retcode; 
														 
 sendemailitemadd(string keyword = '',string status = '') := function 
		
		error_description := map ( 
							                    keyword = 'ADD_ITEM_ONLY_TO_BUILD_INSTANCE' and status in ['FAIL','SKIP'] => add_items.Message,
                                                    
												               'N/A'
												              );
	   return	 fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify +'; sudhir.kasavajjala@lexisnexis.com',
												' Orbit for Build : '+buildname+',version: '+Buildvs+',Env : '+Orbit3.Constants(Envmt).which_env,
												'BuildName:'+buildname+'\n'+
												'---------------------'+'\n'+
												'Buildversion:'+Buildvs+'\n'+
 										  	'---------------------'+'\n'+
		
												'FilePathName:'+FilePathName+'\n'+
												'-----------------------'+'\n'+

												'Reason:'+keyword+'\n'+
												'---------------------'+'\n'+
												'Status:'+status+'\n'+
												'---------------------'+'\n'+
												'ReceiveID:'+OldReceiveID+'\n'+
												'---------------------'+'\n'+
												'Error Description:'+error_description+'\n'+
												'---------------------'+'\n'+
												'Workunit:'+wuid);
	   end;	
//***************/															
														 

return	
	                                       
					                 if ( add_items.Status = 'Success',
									                                                     sendemailitemadd('ADD_ITEM_ONLY_TO_BUILD_INSTANCE','SUCCESS') ,
									                                                      sendemailitemadd('ADD_ITEM_ONLY_TO_BUILD_INSTANCE','FAIL') 
								    );
end;

add_item_only := apply( dsitem , fn_add_item ( FilePathName )
                                         ); 
	 



	sendemailbuild(string keyword = '',string status = '') := function 
		
		error_description := map (
		                                                                             keyword = 'CREATE' and status in ['FAIL','SKIP'] => create_build.Message,
		                                                                              keyword = 'UPDATE' and status in ['FAIL','SKIP'] => Update_build_1.Message,
												 		        


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
												'Workunit:'+wuid);
	   end;
		 

	return 
									if(_Control.ThisEnvironment.Name <> 'Prod_Thor', 
									if( runcreateloaditem,
									                                    
								                                         if ( runaddcomponentsonly, 
								                                                 if ( get_buildinst.Status = 'Success',
																									       if ( count(dsitem) > 0, 
																							                                  add_item_only, 
																							                                sendemailbuild('NO_ITEMS_PASSED','FAIL')
																	                                                       ),
																									 Output('Build Instance does not exist in Orbit for Build Name -- '+buildname +', Build Version --'+Buildvs)
													                            ),
									                          Sequential (
							                                                   
									 
												                       if ( skipcreatebuild , 
											                                                           sendemailbuild('CREATE','SKIP'),
														 
													                                                 if( create_build.Status = 'Success',
															                                                       sendemailbuild('CREATE','SUCCESS'),
																			                                 sendemailbuild('CREATE','FAIL')
																			                    )
															               ),
														
													                     if ( skipupdatebuild ,
																				          Sequential(sendemailbuild('UPDATE','SKIP'),Update_build_1.Status)	,
												
													                                                                   if ( get_buildinst.Status =  'Success' and get_buildinst.BuildInstanceStatus = 'BUILD_IN_PROGRESS', 
																				                                                                                                                                                             if ( Update_build.Status = 'Success', 
													                                                                                                                                                                                                          sendemailbuild('UPDATE','SUCCESS'),
																					                                                                                                                                                                 sendemailbuild('UPDATE','FAIL')
																																																		),
																																																		sendemailbuild('UPDATE','ABORT')
																					 )
														                        ),
													                   if ( skipaddcomponents,	
										                                              Sequential ( Output('Skipping_Add_Components'),sendemailbuild('SKIP_ADD_ITEMS','SUCCESS')),
														     
										                                                   if ( count(dsitem) > 0, 
																							                                  create_add_item, 
																							                                sendemailbuild('NO_ITEMS_PASSED','FAIL')
																	                   )
																																
															                )
						                                                )
												     ),
											
													       
															Output('Run_Create_build_is_false')
													),
											
												
												
									output('Not a prod environment')
									)
				
								;
								
end;