import ut,Orbit3,_Control,lib_stringlib;
export proc_Create_Receive_LoadItem(string buildname,string Buildvs,string ItemName, string UpdateType,string SourceName, boolean runcreateloaditem = true ) := function

	tokenval := orbit3.GetToken() : independent ;
	
	string ReceiveDate := ut.GetTimeDate()[1..10]+'T'+ut.GetTimeDate()[11..12]+':'+ut.GetTimeDate()[13..14]+':'+ut.GetTimeDate()[15..16]+'Z' : INDEPENDENT ;


	create_receive := Orbit3.CreateReceive(	UpdateType,
	                                     ItemName,
				                                  tokenval,
				                                  SourceName,
																					                 ReceiveDate 
									                            ).retcode : independent;
																							
	
																							
 string RecieveID := trim(create_receive.ReceiveInstanceId) ;
		
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
																							
//Create a dataset of receive instance ids in a file

BuildNamefmt := regexreplace(' ',StringLib.StringFilterout(  buildname  ,'&_.;+$@!*()~\''),'');

ds := dataset( '~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs,{string ReceiveInstanceID},thor,opt);
dAppendID := output( dataset([RecieveID],{string ReceiveInstanceID}),,'~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs,overwrite);

dnewIDfile := Sequential( output(  (ds + dataset([RecieveID],{string ReceiveInstanceID})),,'~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs+'_temp',overwrite),
                                    FileServices.Deletelogicalfile('~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs),
																		                  FileServices.RenameLogicalfile( '~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs+'_temp' ,'~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs)
																										);

return Sequential(  	if( runcreateloaditem,
									              if( create_receive.Status = 'Success',
									                 if ( add_receive.Status = 'Success',
										                   if ( Update_receive.Status = 'Success',
                                        if ( FileServices.FileExists( '~thor_data::orbit::receive_id::'+BuildNamefmt+'::'+Buildvs ) , dnewIDfile,  dAppendID )
																				                                                ,Output('Update_Receive_Item_failed')
																																		)),
																																		    Output('Create_Receive_Item_failed')
																														),
																														Output('Run_create_item_false')
																												)
																							);

end;

