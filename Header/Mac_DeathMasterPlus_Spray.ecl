export MAC_DeathMasterPlus_Spray(sourceIP,sourcePath,fileDate,runStates=FALSE,emailTarget='\' \'') := 
macro
	#workunit('name','Death Master Build');
	#uniquename(sprayIP);
	#uniquename(DMRecordSize);
	#uniquename(DMSupplementalRecordSize);
	#uniquename(DMRawRecordSize);
	#uniquename(sprayDeathMaster);
	#uniquename(sprayDMSupplemental);
	#uniquename(sprayDMRaw);
	#uniquename(spraySSADeletes);
	#uniquename(sprayFiles);
	#uniquename(processStateFiles);
	#uniquename(addDMSuper);
	#uniquename(addDMSupplementalSuper);
	#uniquename(addDMRawSuper);
	#uniquename(buildAll);
	#uniquename(addHeaderKeyBuilding);
	#uniquename(clearHeaderKeyBuilding);
	#uniquename(sendSuccMsg);
	#uniquename(sendFailMsg);
	#uniquename(updateVersion);
	#uniquename(extractIncremental);
	
	%sprayIP% := map(
									sourceIP = 'edata10' => _control.IPAddress.edata10,
									sourceIP = 'edata11' => _control.IPAddress.edata11,
									sourceIP = 'edata11b' => _control.IPAddress.edata11b,
									//sourceIP = 'edata14' => _control.IPAddress.edata14, --decommissioned
									sourceIP = 'edata14a' => _control.IPAddress.edata14a,
									sourceIP = 'edata12' => _control.IPAddress.edata12,
									sourceIP
									);
									
	%DMRecordSize% :=210;
	%DMSupplementalRecordSize% := 2106;
	%DMRawRecordSize% := 102;

	%sprayDeathMaster% := if (fileservices.fileexists('~thor_data400::in::death_master_plus_'+fileDate),
														output('Death Master spray completed in previous run'),
														FileServices.SprayFixed(%sprayIP%,sourcePath+'death_master_plus.d00',%DMRecordSize%,_control.TargetGroup.ADL_400,'~thor_data400::in::death_master_plus_'+fileDate ,-1,,,true,true));
														
	%sprayDMSupplemental% := if (fileservices.fileexists('~thor_data400::in::death_master_supplemental_'+fileDate),
															 output('Death Master Supplemental spray completed in previous run'),
															 FileServices.SprayFixed(%sprayIP%,sourcePath+'death_master_supplemental.d00',%DMSupplementalRecordSize%,_control.TargetGroup.ADL_400,'~thor_data400::in::death_master_supplemental_'+fileDate ,-1,,,true,true));

	%sprayDMRaw% := if (fileservices.fileexists('~thor_data400::in::ssa_deathm_raw_'+fileDate),
											output('Death Master Raw file spray completed in previous run'),
											FileServices.SprayFixed(%sprayIP%,sourcePath+'death_master_raw.d00',%DMRawRecordSize%,_control.TargetGroup.ADL_400,'~thor_data400::in::ssa_deathm_raw_'+fileDate ,-1,,,true,true));

	%spraySSADeletes%			:=	Death_Master.Spray_DeathMasterDelete(fileDate);
											
	%sprayFiles% := sequential(%sprayDeathMaster%,%sprayDMSupplemental%,%sprayDMRaw%,%spraySSADeletes%);

	%processStateFiles% := if (runStates,Death_Master.proc_build_state_data(fileDate,runStates,runStates));
	
	%addHeaderKeyBuilding% := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderProdKey_Building')>0,
															 output('Nothing added to thor_data400::Base::HeaderProdKey_Building'),
															 fileservices.addsuperfile('~thor_data400::Base::HeaderProdKey_Building','~thor_data400::Base::Header_prod',,true));

	%addDMSuper% := sequential(
															 FileServices.StartSuperFileTransaction(),
															 FileServices.AddSuperFile('~thor_data400::base::death_master_plus_delete','~thor_data400::base::death_master_plus_father',, true),
															 FileServices.ClearSuperFile('~thor_data400::base::death_master_plus_father'),
															 FileServices.FinishSuperFileTransaction(),
															 FileServices.StartSuperFileTransaction(),
															 FileServices.AddSuperFile('~thor_data400::base::death_master_plus_father','~thor_data400::base::death_master_plus',, true),
															 FileServices.ClearSuperFile('~thor_data400::base::death_master_plus'),
															 FileServices.FinishSuperFileTransaction(),
															 FileServices.StartSuperFileTransaction(),
															 FileServices.AddSuperFile('~thor_data400::base::death_master_plus','~thor_data400::in::death_master_plus_'+filedate),
															 FileServices.AddSuperFile('~thor_data400::base::death_master_plus','~thor_data400::Base::Death_Master_Texas_Plus_20100930'),
															 FileServices.AddSuperFile('~thor_data400::base::death_master_plus','~thor_data400::Base::Death_Master_Plus_States'), 
															 FileServices.FinishSuperFileTransaction(),
															 FileServices.ClearSuperFile('~thor_data400::base::death_master_plus_delete',true)
															);
															
	%addDMSupplementalSuper% := sequential(
																					 FileServices.StartSuperFileTransaction(),
																					 FileServices.AddSuperFile('~thor_data400::base::death_master_supplemental_delete','~thor_data400::base::death_master_supplemental_father',, true),
																					 FileServices.ClearSuperFile('~thor_data400::base::death_master_supplemental_father'),
																					 FileServices.FinishSuperFileTransaction(),
																					 FileServices.StartSuperFileTransaction(),
																					 FileServices.AddSuperFile('~thor_data400::base::death_master_supplemental_father','~thor_data400::base::death_master_supplemental',, true),
																					 FileServices.ClearSuperFile('~thor_data400::base::death_master_supplemental'),
																					 FileServices.FinishSuperFileTransaction(),
																					 FileServices.StartSuperFileTransaction(),
																					 FileServices.AddSuperFile('~thor_data400::base::death_master_supplemental','~thor_data400::in::death_master_supplemental_'+filedate), 
																					 FileServices.AddSuperFile('~thor_data400::base::death_master_supplemental','~thor_data400::Base::Death_Master_Texas_Supplement_20100930'), 
																					 FileServices.AddSuperFile('~thor_data400::base::death_master_supplemental','~thor_data400::Base::Death_Master_Supplemental_States'), 
																					 FileServices.FinishSuperFileTransaction(),
																					 FileServices.ClearSuperFile('~thor_data400::base::death_master_supplemental_delete',true)
																					);
																					
	%addDMRawSuper% := sequential(
																	FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile('~thor_data400::in::ssa_deathm_raw_delete','~thor_data400::in::ssa_deathm_raw_grandfather',, true),
																	FileServices.ClearSuperFile('~thor_data400::in::ssa_deathm_raw_grandfather'),
																	FileServices.FinishSuperFileTransaction(),
																	FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile('~thor_data400::in::ssa_deathm_raw_grandfather','~thor_data400::in::ssa_deathm_raw_father',, true),
																	FileServices.ClearSuperFile('~thor_data400::in::ssa_deathm_raw_father'),
																	FileServices.FinishSuperFileTransaction(),
																	FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile('~thor_data400::in::ssa_deathm_raw_father','~thor_data400::in::ssa_deathm_raw',, true),						
																	FileServices.ClearSuperFile('~thor_data400::in::ssa_deathm_raw'),
																	FileServices.FinishSuperFileTransaction(),
																	FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile('~thor_data400::in::ssa_deathm_raw','~thor_data400::in::ssa_deathm_raw_'+fileDate),
																	FileServices.FinishSuperFileTransaction(),
																	FileServices.ClearSuperFile('~thor_data400::in::ssa_deathm_raw_delete',true)
																	);
																	
	%buildAll% := header.proc_deathmaster_buildall(fileDate);

	RoxieKeyBuild.Mac_Daily_Email_Local('DEATH MASTER','SUCC',fileDate,%sendSuccMsg%,if(emailTarget<>' ',emailTarget,Death_Master.Spray_Notification_Email_Address));
	RoxieKeyBuild.Mac_Daily_Email_Local('DEATH MASTER','FAIL',fileDate,%sendFailMsg%,if(emailTarget<>' ',emailTarget,Death_Master.Spray_Notification_Email_Address));

	%clearHeaderKeyBuilding% := FileServices.ClearSuperFile('~thor_data400::Base::HeaderProdKey_Building');

	%updateVersion% := parallel(RoxieKeyBuild.updateversion('DeathMasterKeys',filedate,if(emailTarget<>' ',emailTarget,Death_Master.Spray_Notification_Email_Address,,'N|B')),
															RoxieKeyBuild.updateversion('FCRA_DeathMasterKeys',filedate,if(emailTarget<>' ',emailTarget,Death_Master.Spray_Notification_Email_Address,,'F')));
	
	%extractIncremental%	:=	OUTPUT(Death_Master.proc_compid_incremental_extract(fileDate));
	
	sequential(
							%sprayFiles%,
							%processStateFiles%,
							%addDMSuper%,
							%addDMSupplementalSuper%,
							%addDMRawSuper%,
							%addHeaderKeyBuilding%,
							%buildAll%,
							%clearHeaderKeyBuilding%,
							%updateVersion%,
							%extractIncremental%
						 ) : success(%sendSuccMsg%), failure(%sendFailMsg%);
endmacro;