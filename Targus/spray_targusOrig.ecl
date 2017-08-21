import lib_fileservices,_control;

export spray_targusOrig(string versionDate) := function

	sprayConsumerEnhanced := if(fileservices.fileexists('~thor_data400::in::white_pages_enh_'+ versionDate),
								output('Consumer Enhanced file sprayed in previous run'),
								FileServices.SprayFixed(_control.IPAddress.bctlpedata11, '/data/hds_2/telephones/whitepages/targus/data/'+ versionDate +'/ConsEnh.all',411, 'thor400_44', 
														'~thor_data400::in::white_pages_enh_'+ versionDate, , , ,true,true,true));

	sprayConsumerPlus := if(fileservices.fileexists('~thor_data400::in::white_pages_plus_'+ versionDate),
							output('Consumer Plus file sprayed in previous run'),
							FileServices.SprayFixed(_control.IPAddress.bctlpedata11, '/data/hds_2/telephones/whitepages/targus/data/'+ versionDate +'/ConsPlus.all',411, 'thor400_44', 
													'~thor_data400::in::white_pages_plus_'+ versionDate, , , ,true,true,true));
								
	addSuper := sequential(
							 FileServices.StartSuperFileTransaction(),
							 FileServices.AddSuperFile('~thor_data400::in::white_pages_plus_delete','~thor_data400::in::white_pages_plus_father',, true),
							 FileServices.ClearSuperFile('~thor_data400::in::white_pages_plus_father'),
							 FileServices.AddSuperFile('~thor_data400::in::white_pages_plus_father','~thor_data400::in::white_pages_plus',, true),
							 FileServices.ClearSuperFile('~thor_data400::in::white_pages_plus'),
							 FileServices.AddSuperFile('~thor_data400::in::white_pages_plus','~thor_data400::in::white_pages_plus_'+versionDate),
							 
							 FileServices.AddSuperFile('~thor_data400::in::white_pages_enhanced_delete','~thor_data400::in::white_pages_enhanced_father',, true),
							 FileServices.ClearSuperFile('~thor_data400::in::white_pages_enhanced_father'),
							 FileServices.AddSuperFile('~thor_data400::in::white_pages_enhanced_father','~thor_data400::in::white_pages_enhanced',, true),
							 FileServices.ClearSuperFile('~thor_data400::in::white_pages_enhanced'),
							 FileServices.AddSuperFile('~thor_data400::in::white_pages_enhanced','~thor_data400::in::white_pages_enh_'+versionDate),
							 FileServices.FinishSuperFileTransaction(),
							 
							 FileServices.ClearSuperFile('~thor_data400::in::white_pages_plus_delete',true),
							 FileServices.ClearSuperFile('~thor_data400::in::white_pages_enhanced_delete',true)
							);
							  
	return sequential(sprayConsumerEnhanced,sprayConsumerPlus,addSuper);
end;