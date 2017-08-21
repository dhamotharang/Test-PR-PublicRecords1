import lib_fileservices,_control,lib_stringlib,tools,OIG;

export fSprayFiles(string filedate):=function

spray:= FileServices.SprayVariable(_control.IPAddress.bctlpedata11
												   ,'/data/data_build_4/oig/data/'+filedate+'/UPDATED.csv'
												   ,
												   ,
												   ,'\\n,\\r\\n'
													 ,
												   ,'thor400_44'
												   ,OIG.Cluster + 'in::OIG::'+filedate+'::Update_raw'
												   ,-1
												   ,
												   ,
												   ,true
												   ,true
													 ,true);
spray_main :=if(NOT FileServices.FileExists(OIG.Cluster + 'in::OIG::'+fileDate+'::Update_raw'),spray); 
CreateSuperfiles :=FileServices.CreateSuperFile(OIG.Cluster + 'raw_base::OIG',false);
								
CreateSuperIfNotExist := if(NOT FileServices.SuperFileExists(OIG.Cluster + 'raw_base::OIG'),CreateSuperfiles); 
		super_main :=sequential(FileServices.StartSuperFileTransaction()
		        ,FileServices.clearsuperfile(OIG.Cluster + 'raw_base::OIG',true)
				,FileServices.AddSuperFile(OIG.Cluster + 'raw_base::OIG', 
				                          OIG.Cluster + 'in::OIG::'+filedate+'::Update_raw'), 
				FileServices.FinishSuperFileTransaction());

add_super := if(FileServices.FindSuperFileSubName(OIG.Cluster + 'raw_base::OIG', OIG.Cluster + 'in::OIG::'+fileDate+'::Update_raw') = 0,super_main); 
// if raw logical file is already exists on thor , First clear the  superfile and then add logical file to the raw base.
// else spray the new version file and clear the superfile and then add logical file to raw base .
clear     :=if( FileServices.FileExists(OIG.Cluster + 'in::OIG::' + filedate + '::Update_raw')
				, if(FileServices.FindSuperFileSubName(OIG.Cluster + 'raw_base::OIG', OIG.Cluster + 'in::OIG::'+filedate+'::Update_raw') = 0
				,sequential(FileServices.clearsuperfile(OIG.Cluster + 'raw_base::OIG',false)
				,FileServices.AddSuperFile(OIG.Cluster + 'raw_base::OIG', OIG.Cluster + 'in::OIG::'+filedate+'::Update_raw')
							) 
				)
				,sequential(spray_main,add_super ));
				
do_super := sequential(CreateSuperIfNotExist,clear);

return do_super;

end;