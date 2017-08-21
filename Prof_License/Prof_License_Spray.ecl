#workunit('name','Spray Professional Licenses'); 

import lib_stringlib, lib_fileservices, _control, prof_license, ut;

 

fSprayOrig(string pState)

 := if ( FileServices.fileexists('~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))),
          sequential(	
 
              if ( FileServices.FindSuperFileSubName('~thor_data400::in::prolic::allSources','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))) <> 0,
              
							            FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allSources',
																							'~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))),output('AllSRC SF does not contain '+pstate+'LF in it')),
																							
													 if ( FileServices.FindSuperFileSubName( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_old') <> 0,
													       
																             FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old',
																							'~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_old'),output('Old file does not exists in SF for state '+pState)),
																							Sequential(
																							
																							if( FileServices.fileexists('~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_old'),Sequential(   FileServices.StartSuperFileTransaction(),
																							                                                                                                              FileServices.DeleteLogicalFile('~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_old'),
																																																																														FileServices.FinishSuperfileTransaction()),
																																																																														output('Old file does not exists for state '+pstate)),
																							
																							FileServices.Copy('~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)),'thor400_60','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_old',,,,,true),
																							FileServices.StartSuperFileTransaction(),
																							FileServices.AddSuperFile('~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_' + lib_stringlib.StringLib.stringtolowercase(trim(pState))+'_old'),
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
																						
																						
																						
	
																						
																						
																						
	fSprayOrig('ak');
	fSprayOrig('al');
	fSprayOrig('ar');
	fSprayOrig('az');
	fSprayOrig('ca');
	fSprayOrig('co');
	fSprayOrig('ct');
	fSprayOrig('dc');
	fSprayOrig('de');
	fSprayOrig('fl');
	fSprayOrig('ga');
	fSprayOrig('hi');
	fSprayOrig('ia');
	fSprayOrig('id');
	fSprayOrig('il');
	fSprayOrig('in');
	fSprayOrig('irs_enrolled_agents');
	fSprayOrig('ks');
	fSprayOrig('ky');
	fSprayOrig('la');
	fSprayOrig('ma');
	fSprayOrig('md');
	fSprayOrig('me');
	fSprayOrig('mi');
	fSprayOrig('mn');
	fSprayOrig('mo');
	fSprayOrig('ms');
	fSprayOrig('nc');
	fSprayOrig('nd');
	fSprayOrig('ne');
	fSprayOrig('nh');
	fSprayOrig('nj');
	fSprayOrig('nm');
	fSprayOrig('nv');
	fSprayOrig('ny');
	fSprayOrig('oh');
	fSprayOrig('ok');
	fSprayOrig('or');
	fSprayOrig('pa');
	fSprayOrig('ri');
	fSprayOrig('sc');
	fSprayOrig('sd');
	fSprayOrig('sec_brokers_ct');
	fSprayOrig('sec_brokers_fl');
	fSprayOrig('tn');
	fSprayOrig('tx');
//	fSprayOrig('ut');
	fSprayOrig('va');
	fSprayOrig('vt');
	fSprayOrig('wi');
	fSprayOrig('wv');
	fSprayOrig('wy');

