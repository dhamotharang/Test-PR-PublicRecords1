import std, _control, GlobalWatchLists_Preprocess;

sfOFAC_NSP 	:= GlobalWatchLists_Preprocess.root + 'ofac::new_plc';
sfOFAC_SDN 	:= GlobalWatchLists_Preprocess.root + 'ofac';

CreateSuperfiles := SEQUENTIAL(if(NOT STD.File.SuperFileExists(sfOFAC_NSP),
																	STD.File.CreateSuperFile(sfOFAC_NSP));
															if(NOT STD.File.SuperFileExists(sfOFAC_SDN),
																STD.File.CreateSuperFile(sfOFAC_SDN));
																);

EXPORT SprayOFACRandom := SEQUENTIAL(CreateSuperFiles,
																		FileServices.StartSuperFileTransaction( ),
																				IF(NOT STD.File.FileExists(sfOFAC_NSP +'::'+ Versions.OFAC_PLC_Version), FileServices.ClearSuperFile(sfOFAC_NSP, false)),
																				IF(NOT STD.File.FileExists(sfOFAC_SDN +'::'+ Versions.OFAC_Version), FileServices.ClearSuperFile(sfOFAC_SDN, false)),
																		FileServices.FinishSuperFileTransaction( ),
																		
																		PARALLEL(
																						IF(NOT STD.File.FileExists(sfOFAC_NSP +'::'+ Versions.OFAC_PLC_Version)
																							,sprayFile('ofac' + '/' + 'weekly_files' + '/', Versions.OFAC_PLC_Version +'.'+'nsp.out', '', 'ofac::new_plc::' + Versions.OFAC_PLC_Version)
																							,OUTPUT('OFAC_NSP - Excluded from Spray')),
																						IF(NOT STD.File.FileExists(sfOFAC_SDN +'::'+ Versions.OFAC_Version)
																							,sprayFile('ofac' + '/' + 'weekly_files' + '/', Versions.OFAC_Version +'.'+'sdn.out', '', 'ofac::' + Versions.OFAC_Version)
																							,OUTPUT('OFAC_SDN - Excluded from Spray'));
																						 ),
																							
																		FileServices.StartSuperFileTransaction( ),
																				IF(STD.File.FileExists(sfOFAC_NSP +'::'+ Versions.OFAC_PLC_Version) and STD.File.GetSuperFileSubCount(sfOFAC_NSP) = 0
																						,FileServices.AddSuperFile(sfOFAC_NSP, sfOFAC_NSP + '::' + Versions.OFAC_PLC_Version)
																						,OUTPUT('OFAC_NSP - Excluded from Spray')),
																				IF(STD.File.FileExists(sfOFAC_SDN +'::'+ Versions.OFAC_Version) and STD.File.GetSuperFileSubCount(sfOFAC_SDN) = 0
																						,FileServices.AddSuperFile(sfOFAC_SDN, sfOFAC_SDN + '::' + Versions.OFAC_Version)
																						,OUTPUT('OFAC_SDN - Excluded from Spray')),
																		FileServices.FinishSuperFileTransaction( )
																		);