import lib_fileservices,_control;

export fspray_SICCodes (string filedate):= function 

do_spray			:=	FileServices.SprayFixed(_control.IPAddress.edata10,'/data_build_4/magnify/data/'+filedate+'/SICCodes.txt',127,'thor400_88','~thor_data400::in::Magnify::'+filedate+'::SICCodes',-1,,,true,true);
sprayIfNotExist 	:=  if(NOT FileServices.FileExists('~thor_data400::in::Magnify::'+filedate+'::SICCodes'),do_spray); 

CreateSuperfiles :=FileServices.CreateSuperFile('~thor_data400::raw_base::Magnify_SICCodes',false);
								
CreateSuperIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::raw_base::Magnify_SICCodes'),CreateSuperfiles); 
		super_main :=sequential(FileServices.StartSuperFileTransaction()
		        ,FileServices.clearsuperfile('~thor_data400::raw_base::Magnify_SICCodes',true)
				,FileServices.AddSuperFile('~thor_data400::raw_base::Magnify_SICCodes', 
				                          '~thor_data400::in::Magnify::'+filedate+'::SICCodes'), 
				FileServices.FinishSuperFileTransaction());

add_super := if(FileServices.FindSuperFileSubName('~thor_data400::raw_base::Magnify_SICCodes', '~thor_data400::in::Magnify::'+filedate+'::SICCodes') = 0,super_main); 
clear     :=if(FileServices.FileExists('~thor_data400::in::Magnify::'+filedate+'::SICCodes')
				, if(FileServices.FindSuperFileSubName('~thor_data400::raw_base::Magnify_SICCodes', '~thor_data400::in::Magnify::'+filedate+'::SICCodes') = 0
														,sequential(FileServices.clearsuperfile('~thor_data400::raw_base::Magnify_SICCodes',false)
																	,FileServices.AddSuperFile('~thor_data400::raw_base::Magnify_SICCodes', '~thor_data400::in::Magnify::'+filedate+'::SICCodes')
																	) 
					)
				,sequential(do_spray,add_super ));
do_super := sequential(CreateSuperIfNotExist,clear);

return do_super;

end;

