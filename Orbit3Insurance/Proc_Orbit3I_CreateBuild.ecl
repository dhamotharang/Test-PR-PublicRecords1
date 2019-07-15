import ut,_Control;
export Proc_Orbit3I_CreateBuild(string buildname,string Buildvs,string Envmt = 'N', string email_list = '', boolean skipcreatebuild = false,boolean skipupdatebuild = false,boolean runcreatebuild = true) := function

	tokenval := Orbit3Insurance.GetToken();

	create_build :=  Orbit3Insurance.CreateBuild(
									tokenval,
									trim(buildname),
									Buildvs

	                                   
									);
	
	rbuildupdate					:=	Orbit3Insurance.Layouts.OrbitUpdateBuildInstanceLayout;
	dsbuildup							:=	Dataset([{'',trim(buildname),Buildvs,'','','','','','','','',''}],rbuildupdate);	
	
	Update_build	:=	Orbit3Insurance.UpdateBuildInstance(tokenval,
																										dsbuildup,
																								'BUILD_AVAILABLE_FOR_USE',
									                                                                            Orbit3Insurance.Constants(Envmt).platform_upd									
																						        );
	emailto := 'Sudhir.Kasavajjala@lexisnexisrisk.com;  alp-qadata.team@lexisnexis.com';
	
emaillist := if ( email_list <> '',  email_list + ';' +  emailto,
                                                       emailto
					);
					
sendemail(string keyword = '',string status = '') := function 
		
		error_description := map ( keyword = 'CREATE' and status in ['FAIL','SKIP'] => create_build.Message,
		                     keyword = 'UPDATE' and status in ['FAIL','SKIP'] => Update_build.Message,
												 keyword = 'NO_ITEMS_FOUND' and status = 'FAIL' => 'No Build Components found to Add in Orbit',
												 'N/A'
												 );
	   	 emailtoall :=  fileservices.sendemail(
												emaillist,
												' Orbit for Build : '+buildname+',version: '+Buildvs+',Env : '+Orbit3Insurance.Constants(Envmt).which_env,
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
														)
											),
									Output('Dont run build')
								   )
				
								);
								
end;

	
								
