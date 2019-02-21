import ut,Orbit3,_Control;
export Proc_Orbit3_CreateBuild(string buildname,string Buildvs,string Envmt = 'N', boolean skipcreatebuild = false,boolean skipupdatebuild = false,boolean runcreatebuild = true) := function

	tokenval := orbit3.GetToken();

	create_build := orbit3.CreateBuild(buildname,
									Buildvs,
									tokenval,		
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
	   	 emailtoall :=  fileservices.sendemail(
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
												
		verifystatus := if ( status <> 'FAIL' , emailtoall , Sequential ( emailtoall,
									                                                                             FAIL( 'Orbit Build Instance Update Aborted .Build Name :'+buildname+ ' Build Version: '+Buildvs+' Reason:'+error_description )
																					          )
							);
							
		return verifystatus;
	   end;

spcluster := if ( regexfind('_eclcc',tgtcluster) , 'hthor_dev_eclcc','hthor_dev');


    fswu :=  _control.fSubmitNewWorkunit(ECL1, spcluster) :   SUCCESS(fileservices.sendemail(Send_Email(Buildvs,email_list).emaillist
																			                                                                                                     ,'Orbit3  submit WU to spawn status'+ workunit
																			                                                                                                      ,'Orbit3 submit WU to spawn success -- '+ workunit
																			                                                                                                       )),
		                                                                                                                                                                                      FAILURE(fileservices.sendemail(Send_Email(Buildvs,email_list).emaillist
																			                                                                                                     ,'Orbit3 submit WU to spawn status'+ workunit
																			                                                                                                      ,'Orbit3 submit WU to spawn failed -- '+ workunit
																			                                                                                                       ));
return 	fswu;
end;