#workunit('name','Spray Professional Licenses'); 

import lib_stringlib, lib_fileservices, _control, prof_license, ut;

 

fSprayOrig(string pState)

 := if ( FileServices.fileexists('~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))),
          sequential(	
 
              if ( FileServices.FindSuperFileSubName('~thor_data400::in::prolic::allSources','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))) <> 0,
              
							            FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allSources',
																							'~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))),output('AllSRC SF does not contain '+pstate+'LF in it')),
																							
													 if ( FileServices.FindSuperFileSubName( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_previous') <> 0,
													       
																             FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old',
																							'~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_previous'),output('Old file does not exists in SF for state '+pState)),
																							Sequential(
																							FileServices.StartSuperFileTransaction(),
																							
																							FileServices.Copy('~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)),'thor400_60','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_previous',,,,,true),
																							FileServices.AddSuperFile('~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_previous'),
																							FileServices.FinishSuperfileTransaction()),
	                                              							
 								Sequential(
								lib_fileservices.FileServices.sprayfixed(_control.IPAddress.edata11,
																												'/hds_4/prolic/work/out/' + 'prolic_' + trim(pState,left,right) + '.d00',
																												3459,
																												'thor400_60',
																												'~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)) ,
																												,,,true,true,false
																												),
								FileServices.StartSuperFileTransaction(),
								
								FileServices.AddSuperFile('~thor_data400::in::prolic::allSources', 
																					'~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)) 
																					),
								FileServices.FinishSuperFileTransaction()
								)));
																						
																						
																						
	fSprayOrig('ca');
	