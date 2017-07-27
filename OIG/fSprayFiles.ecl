import lib_fileservices,_control,lib_stringlib;

export fSprayFiles(string filedate):=function

spray:= FileServices.SprayVariable(_control.IPAddress.edata10
												   ,'/data_build_4/oig/data/'+filedate+'/UPDATED.txt'
												   ,
												   ,'\t'
												   ,'\\n,\\r\\n',
												   ,'thor400_30'
												   ,Cluster + 'in::OIG::'+filedate+'::Update_raw'
												   ,-1
												   ,
												   ,
												   ,true
												   ,true);
spray_main :=if(NOT FileServices.FileExists(Cluster + 'in::OIG::'+fileDate+'::Update_raw'),spray); 
CreateSuperfiles :=FileServices.CreateSuperFile(Cluster + 'raw_base::OIG',false);
								
CreateSuperIfNotExist := if(NOT FileServices.SuperFileExists(Cluster + 'raw_base::OIG'),CreateSuperfiles); 
		super_main :=sequential(FileServices.StartSuperFileTransaction()
		        ,FileServices.clearsuperfile(Cluster + 'raw_base::OIG',true)
				,FileServices.AddSuperFile(Cluster + 'raw_base::OIG', 
				                          Cluster + 'in::OIG::'+filedate+'::Update_raw'), 
				FileServices.FinishSuperFileTransaction());

add_super := if(FileServices.FindSuperFileSubName(Cluster + 'raw_base::OIG', Cluster + 'in::OIG::'+fileDate+'::Update_raw') = 0,super_main); 
// if raw logical file is already exists on thor , First clear the  superfile and then add logical file to the raw base.
// else spray the new version file and clear the superfile and then add logical file to raw base .
clear     :=if( FileServices.FileExists(Cluster + 'in::OIG::' + filedate + '::Update_raw')
				, if(FileServices.FindSuperFileSubName(Cluster + 'raw_base::OIG', Cluster + 'in::OIG::'+filedate+'::Update_raw') = 0
				,sequential(FileServices.clearsuperfile(Cluster + 'raw_base::OIG',false)
				,FileServices.AddSuperFile(Cluster + 'raw_base::OIG', Cluster + 'in::OIG::'+filedate+'::Update_raw')
							) 
				)
				,sequential(spray_main,add_super ));
				
do_super := sequential(CreateSuperIfNotExist,clear);

return do_super;

end;