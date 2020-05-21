import ut,Orbit3,_Control,lib_stringlib;
export proc_GetReceiveInstance(string buildname,string Buildvs,string FilePathName, boolean runcreateloaditem = true ) := function

	tokenval := orbit3.GetToken() : independent ;
	


	get_receive := Orbit3.GetReceiveInstanceID(	FilePathName,
	                                                                                 tokenval
				                                                              ).retcode : independent;
																							
	
																							
 string RecieveID := trim(get_receive.ReceiveInstanceId) ;
		
	
																							
//Create a dataset of receive instance ids in a file

BuildNamefmt := regexreplace(' ',StringLib.StringFilterout(  buildname  ,'&_.;+$@!*()~\''),'');

ds := dataset( '~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs,{string ReceiveInstanceID},thor,opt);
dAppendID := output( dataset([RecieveID],{string ReceiveInstanceID}),,'~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs,overwrite);

dnewIDfile := Sequential( output(  (ds + dataset([RecieveID],{string ReceiveInstanceID})),,'~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs+'_temp',overwrite),
                                    FileServices.Deletelogicalfile('~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs),
																		                  FileServices.RenameLogicalfile( '~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs+'_temp' ,'~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs)
																										);

return Sequential(  	if( runcreateloaditem,
									              if( get_receive.ResultStatus = 'Success' and get_receive.ReceiveInstanceStatus = 'LOADED',
									
                                                                      if ( FileServices.FileExists( '~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs ) , dnewIDfile,  dAppendID )
					                                      ,Output('Get_Receive_ID_failed')
												 ),
																														
								Output('Run_create_item_false')
							 )
					);

end;

