import lib_fileservices, _control, orbit_report, RoxieKeybuild, Scrubs, Scrubs_DNB_FEIN, std, tools, dops;

export proc_Spray_Build_all(string filedate) := function

sprayFile := FileServices.SprayFixed(_control.IPAddress.bctlpedata12,								
								'/data/prod_data_build_10/production_data/dnb_feinv2/data_files/'+filedate+'/*FEIN*TXT',
								732,
								'thor400_44','~thor_data400::in::dnbfeinv2::'+filedate+'::raw',
								-1,,,true,true);	  

CreateSuperfiles :=FileServices.CreateSuperFile('~thor_data400::in::dnbfeinv2::fein',false);
								
CreateSuperIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::in::dnbfeinv2::fein'),CreateSuperfiles); 

super_main :=sequential(FileServices.StartSuperFileTransaction()
		        ,FileServices.clearsuperfile('~thor_data400::in::dnbfeinv2::fein',true)
				,FileServices.AddSuperFile('~thor_data400::in::dnbfeinv2::fein', 
				                          '~thor_data400::in::dnbfeinv2::'+filedate+'::raw'), 
				FileServices.FinishSuperFileTransaction());

add_super := if(FileServices.FindSuperFileSubName('~thor_data400::in::dnbfeinv2::fein', '~thor_data400::in::dnbfeinv2::'+fileDate+'::raw') = 0,super_main); 

checkLogical :=if(FileServices.FileExists('~thor_data400::in::dnbfeinv2::' + filedate + '::raw'),
				  if(FileServices.FindSuperFileSubName('~thor_data400::in::dnbfeinv2::fein', '~thor_data400::in::dnbfeinv2::'+filedate+'::raw') = 0,
													    sequential(FileServices.clearsuperfile('~thor_data400::in::dnbfeinv2::fein',false),
																   FileServices.AddSuperFile('~thor_data400::in::dnbfeinv2::fein', 
																							 '~thor_data400::in::dnbfeinv2::'+filedate+'::raw'))),																	 				
				  sequential(sprayFile,add_super));
				
// Thor Build
dnb_feinv2.proc_build_all(filedate,doBuild);


// generate XML report.
orbit_report.FEIN_Stats(getretval);				
				
do_all := sequential(CreateSuperIfNotExist,checkLogical,dobuild,getretval) :
					 success(Send_Email(filedate).Build_Success), failure(Send_Email(filedate).Build_Failure);

return do_all;

end;

