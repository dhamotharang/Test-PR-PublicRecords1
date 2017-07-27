import lib_fileservices,_control,lib_stringlib;

export fSprayInputs(string filedate)	:=	function
	CreateNewSuper			:=	FileServices.CreateSuperFile('~thor_data400::in::mxd_mxdocket::sprayed::new',false);
	CreateUpdateSuper		:=	FileServices.CreateSuperFile('~thor_data400::in::mxd_mxdocket::sprayed::update',false);
	CreateDeleteSuper		:=	FileServices.CreateSuperFile('~thor_data400::in::mxd_mxdocket::sprayed::delete',false);	
								
	CreateNewSuperfileIfNotExist 		:= 	if(NOT FileServices.SuperFileExists('~thor_data400::in::mxd_mxdocket::sprayed::new'),CreateNewSuper); 
	CreateUpdateSuperfileIfNotExist	:= 	if(NOT FileServices.SuperFileExists('~thor_data400::in::mxd_mxdocket::sprayed::update'),CreateUpdateSuper);
	CreateDeleteSuperfileIfNotExist	:= 	if(NOT FileServices.SuperFileExists('~thor_data400::in::mxd_mxdocket::sprayed::delete'),CreateDeleteSuper);	

	doNew						:=	if(COUNT(FileServices.RemoteDirectory(_control.IPAddress.edata10,
												'/data_build_4/MXD_Docket/'+filedate+'/','mexicocourt_new_*.txt')(size>0)) >0,
														sequential(	FileServices.SprayVariable(	_control.IPAddress.edata10,
																																		'/data_build_4/MXD_Docket/'+filedate+'/mexicocourt_new_*.txt',,'|',,,'thor40_241',
																																		MXD_MXDocket._Dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate + '::new',
																																		-1,,,true,,true
																																	 ),
																				FileServices.ClearSuperfile('~thor_data400::in::mxd_mxdocket::sprayed::new'),
																				FileServices.AddSuperFile(	'~thor_data400::in::mxd_mxdocket::sprayed::new', 
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::new'
																																	),
																				FileServices.AddSuperFile(	'~thor_data400::in::MXD_MXDocket::AllNew',
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::new'
																																	)														
																			)
													);
																			
	doUpdate				:=	if(COUNT(FileServices.RemoteDirectory(_control.IPAddress.edata10,
												'/data_build_4/MXD_Docket/'+filedate+'/','mexicocourt_change_*.txt')(size>0)) >0,
														sequential(	FileServices.SprayVariable(	_control.IPAddress.edata10,
																																		'/data_build_4/MXD_Docket/'+filedate+'/mexicocourt_change_*.txt',,'|',,,'thor40_241',
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate + '::update',
																																		-1,,,true,,true
																																	 ),
																				FileServices.ClearSuperfile('~thor_data400::in::mxd_mxdocket::sprayed::update'),
																				FileServices.AddSuperFile(	'~thor_data400::in::mxd_mxdocket::sprayed::update', 
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::update'
																																	),
																				FileServices.AddSuperFile(	'~thor_data400::in::MXD_MXDocket::AllUpdate',
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::update'
																																	)	
																			)
													);
					
	doDelete				:=	if(COUNT(FileServices.RemoteDirectory(_control.IPAddress.edata10,
												'/data_build_4/MXD_Docket/'+filedate+'/','mexicocourt_delete_*.txt')(size>0)) >0,
														sequential(	FileServices.SprayVariable(	_control.IPAddress.edata10,
																																		'/data_build_4/MXD_Docket/'+filedate+'/mexicocourt_delete_*.txt',,'|',,,'thor40_241',
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate + '::delete',
																																		-1,,,true,,true
																																	 ),
																				FileServices.ClearSuperfile('~thor_data400::in::mxd_mxdocket::sprayed::delete'),
																				FileServices.AddSuperFile(	'~thor_data400::in::mxd_mxdocket::sprayed::delete', 
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::delete'
																																 ),
																				FileServices.AddSuperFile(	'~thor_data400::in::MXD_MXDocket::AllDelete',
																																		MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::delete'
																																 )
																			)
													);
										 	
	doSeq:= sequential(	parallel(	CreateNewSuperfileIfNotExist,
																CreateUpdateSuperfileIfNotExist,
																CreateDeleteSuperfileIfNotExist
															 ),
											parallel(	sequential(	if (	fileservices.findsuperfilesubname('~thor_data400::in::mxd_mxdocket::sprayed::new', MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::new') > 0,
																									fileservices.removesuperfile('~thor_data400::in::mxd_mxdocket::sprayed::new', MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::new')
																								)
																						,doNew
																					 ),
																sequential(	if (	fileservices.findsuperfilesubname('~thor_data400::in::mxd_mxdocket::sprayed::update', MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::update') > 0,
																									fileservices.removesuperfile('~thor_data400::in::mxd_mxdocket::sprayed::update', MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::update')
																								)
																						,doUpdate
																					),	
																sequential(	if (	fileservices.findsuperfilesubname('~thor_data400::in::mxd_mxdocket::sprayed::delete', MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::delete') > 0,
																									fileservices.removesuperfile('~thor_data400::in::mxd_mxdocket::sprayed::delete', MXD_MXDocket._dataset.thor_cluster_Files+'in::'+ MXD_MXDocket._dataset.name + '::'+filedate+ '::delete')
																								)
																						,doDelete
																					)
																)
											);									 
	return doSeq;
end;
