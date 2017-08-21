import lib_fileservices,_control,lib_stringlib;

export fsprayFEIN_RawFiles(string filedate):=function

spray:= FileServices.SprayFixed(_control.IPAddress.edata10,'/prod_data_build_10/production_data/dnb_feinv2/data_files/'+filedate+'/*FEIN*TXT',732,'thor400_20','~thor_data400::in::dnbfeinv2::'+filedate+'::raw',-1,,,true,true);
spray_main :=if(NOT FileServices.FileExists('~thor_data400::in::dnbfeinv2::'+fileDate+'::raw'),spray); 
CreateSuperfiles :=FileServices.CreateSuperFile('~thor_data400::raw_base::dnbfeinv2',false);
								
CreateSuperIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::raw_base::dnbfeinv2'),CreateSuperfiles); 
		super_main :=sequential(FileServices.StartSuperFileTransaction()
		        ,FileServices.clearsuperfile('~thor_data400::raw_base::dnbfeinv2',true)
				,FileServices.AddSuperFile('~thor_data400::raw_base::dnbfeinv2', 
				                          '~thor_data400::in::dnbfeinv2::'+filedate+'::raw'), 
				FileServices.FinishSuperFileTransaction());

add_super := if(FileServices.FindSuperFileSubName('~thor_data400::raw_base::dnbfeinv2', '~thor_data400::in::dnbfeinv2::'+fileDate+'::raw') = 0,super_main); 
//" filedate" raw logical file doexn't exists spray and delete the old raw file from raw_base and add new raw logical file to--raw_base::dnbfeinv2 
clear     :=if(FileServices.FileExists('~thor_data400::in::dnbfeinv2::' + filedate + '::raw')
				, if(FileServices.FindSuperFileSubName('~thor_data400::raw_base::dnbfeinv2', '~thor_data400::in::dnbfeinv2::'+filedate+'::raw') = 0
														,sequential(FileServices.clearsuperfile('~thor_data400::raw_base::dnbfeinv2',false)
																	,FileServices.AddSuperFile('~thor_data400::raw_base::dnbfeinv2', '~thor_data400::in::dnbfeinv2::'+filedate+'::raw')
																	) 
					)
				,sequential(spray,add_super ));
do_super := sequential(CreateSuperIfNotExist,clear);

return do_super;

end;