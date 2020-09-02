IMPORT	Orbit_report,header,Death_Master,Obituaries,UtilFile,RoxieKeyBuild,Orbit3;
EXPORT	proc_deathmaster_buildall(string	filedate, string emailTarget='')	:=
FUNCTION

		// Calls for Header Superfile
	addHeaderKeyBuilding		:= IF(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderProdKey_Building')>0,
														 OUTPUT('Nothing added to thor_data400::Base::HeaderProdKey_Building'),
														 fileservices.addsuperfile('~thor_data400::Base::HeaderProdKey_Building','~thor_data400::Base::Header_prod',,true));
	clearHeaderKeyBuilding	:= FileServices.ClearSuperFile('~thor_data400::Base::HeaderProdKey_Building');

		// Calls to email PASS/FAIL results
	RoxieKeyBuild.Mac_Daily_Email_Local('DEATH MASTER','SUCC',fileDate,sendSuccMsg,IF(emailTarget<>'',emailTarget,Death_Master.Spray_Notification_Email_Address));
	RoxieKeyBuild.Mac_Daily_Email_Local('DEATH MASTER','FAIL',fileDate,sendFailMsg,IF(emailTarget<>'',emailTarget,Death_Master.Spray_Notification_Email_Address));

		// Call to create Orbit Report
	Orbit_report.DM_Stats(getretval);
	
	// Call to update Keys
	//updateVersion := PARALLEL(RoxieKeyBuild.updateversion('DeathMasterKeys',filedate,IF(emailTarget<>' ',emailTarget,Death_Master.Spray_Notification_Email_Address)),
		//												RoxieKeyBuild.updateversion('FCRA_DeathMasterKeys',filedate,IF(emailTarget<>' ',emailTarget,Death_Master.Spray_Notification_Email_Address)));

// Call to update dops Keys
    updateDops := PARALLEL(//RoxieKeyBuild.updateversion('DeathMasterKeys',filedate,IF(emailTarget<>'',emailTarget,Death_Master.Spray_Notification_Email_Address),,'N|B'),
                             //RoxieKeyBuild.updateversion('FCRA_DeathMasterKeys',filedate,IF(emailTarget<>'',emailTarget,Death_Master.Spray_Notification_Email_Address),,'F'),
                             RoxieKeyBuild.updateversion('DeathMasterSsaKeys',filedate,IF(emailTarget<>'',emailTarget,Death_Master.Spray_Notification_Email_Address),,'N|B'),
                             RoxieKeyBuild.updateversion('FCRA_DeathMasterSsaKeys',filedate,IF(emailTarget<>'',emailTarget,Death_Master.Spray_Notification_Email_Address),,'F'));


		// Call to extract Death Master data to separate files for Compid process
	extractIncremental			:=	OUTPUT(Death_Master.proc_compid_incremental_extract(fileDate));
	
  result	:=	SEQUENTIAL(	
											addHeaderKeyBuilding
											,Death_Master.Proc_Build_Base_Supp_Plus(filedate)
											,Obituaries.proc_tributes_obits_buildall(filedate)
											,header.proc_deathmaster_buildfile(filedate)
											//,Header.proc_deathmaster_buildkey(filedate) //Keys no longer being used by any queries DF-27068
											,Header.proc_deathmaster_buildkey_ssa(filedate)
											//,Death_Master.proc_autokeybuild(filedate) //Keys no longer being used by any queries DF-27068
											,Death_Master.proc_autokeybuild_ssa(filedate)
											//,Death_master.Proc_Build_Boolean_key(filedate)
											,Death_master.Proc_Build_Boolean_key_ssa(filedate)
											,Header.out_base_dev_stats_deaths(filedate)
											,Header.out_base_dev_stats_deaths_ssa(filedate)
											,Header.deaths_coverage
											,IF(_control.thisenvironment.name<>'Dataland',UtilFile.pro_monitor().death_despray,OUTPUT('Not a Prod environment. death_despray not run.'))
											//,Death_Master.Proc_Create_Relationships(filedate)
											,Death_Master.Proc_Create_Relationships_SSA(filedate)
											,getretval
											,clearHeaderKeyBuilding
											,extractIncremental
											,updateDops																					
											//,Orbit3.proc_Orbit3_CreateBuild ('Death Master',filedate, 'N|B')
											,Orbit3.proc_Orbit3_CreateBuild ('Death Master SSA',filedate, 'N|B')
											//,Orbit3.proc_Orbit3_CreateBuild ('FCRA_Death Master',filedate,'F')
											,Orbit3.proc_Orbit3_CreateBuild ('FCRA_Death Master SSA',filedate,'F')
												): SUCCESS(sendSuccMsg), FAILURE(sendFailMsg);
	RETURN result;
	
END;