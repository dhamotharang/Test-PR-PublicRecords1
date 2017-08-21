import lib_stringlib, lib_fileservices, _control, prof_license, ut;

export File_infutor_spray(string filedate,string filename) := function

ThorName:=if(_Control.ThisEnvironment.Name='Dataland','thor40_241','thor400_44');

spray    := FileServices.SprayVariable(_control.IPAddress.edata12,
						'/hds_4/prolic/infutor/in/'+filedate+'/'+filename,
						4096,
						'\\t',
						'\\n,\\r\\n', 
						'"',
						ThorName,
						'~thor_data400::in::prolic_infutor_'+filedate+'_raw',,,,true);
 

bckup_old:= if ( FileServices.fileexists('~thor_data400::in::prolic_infutor'),
          sequential(	
 
              if ( FileServices.FindSuperFileSubName('~thor_data400::in::prolic::allSources','~thor_data400::in::prolic_infutor') <> 0,
              
							            FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allSources',
																							'~thor_data400::in::prolic_infutor'),output('AllSRC SF does not contain infutor LF in it')),
																							
													 if ( FileServices.FindSuperFileSubName( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_infutor_old') <> 0,
													       
																             FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old',
																							'~thor_data400::in::prolic_infutor_old'),output('Old file does not exists in SF for infutor')),
																							Sequential(
																							FileServices.StartSuperFileTransaction(),
																							if( FileServices.fileexists('~thor_data400::in::prolic_infutor_old'),FileServices.DeleteLogicalFile('~thor_data400::in::prolic_infutor_old'),output('Old file does not exists for infutor')),
																							
																							FileServices.Copy('~thor_data400::in::prolic_infutor',ThorName,'~thor_data400::in::prolic_infutor_old'),
																							FileServices.AddSuperFile('~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_infutor_old'),
																							FileServices.FinishSuperfileTransaction()),
	                                              							
                   ));

spray_and_bckup:=sequential(
                 spray,bckup_old); 

return spray_and_bckup;									

end;



									