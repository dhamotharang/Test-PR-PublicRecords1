export proc_build_BK_all(filedate)
 :=
  macro

	import BankruptcyV2,RoxieKeyBuild,orbit_report;

	//BankruptcyV2.proc_BK_stats(filedate,zRunStatsReference);
	
	//BankruptcyV3.proc_BK_stats(filedate,zRunStatsReferenceV3);
	
	//Proc_Build_Base				:= BankruptcyV2.proc_build_base		       : success(output('Bankruptcy Base Files created successfully.'));
	Proc_Build_Keys				:= BankruptcyV2.proc_build_keys(filedate)  : success(output('Keys created successfully.'));
	Proc_Accept_to_QA			:= BankruptcyV2.Proc_Accept_SK_To_QA	   : success(BankruptcyV2.Mac_Email_Local(filedate)), failure(FileServices.sendemail('akayttala@seisint.com', 'BankruptcyV2 Build Failure', failmessage));
	//proc_BK_Stats			    := zRunStatsReference					   : success(output(' V2 Stats created successfully.'));
	// proc_BK_Stats_v3		    := zRunStatsReferenceV3					   : success(output(' V3 Stats created successfully.'));
	// new_records_sample_for_qa	:= BankruptcyV2.New_records_sample        : success(BankruptcyV2.Email_notification_lists(filedate));
	// boolean_build := bankruptcyv2.Proc_Build_Boolean_Key(filedate);
	// Stats_For_DR := bankruptcyv2.BK_Stats_Metadata;
	// orbit_report.Bankruptcy_Stats(orbitreport);
	// dops_update := Roxiekeybuild.updateversion('BankruptcyV2Keys',filedate,'avenkatachalam@seisint.com,cbrodeur@seisint.com');
	// Mapping_BK_Search_V1		:= BankruptcyV2.Mapping_BK_Search_V1(filedate);
	// Mapping_BK_Main_V1			:= BankruptcyV2.Mapping_BK_Main_V1(filedate) : success(FileServices.sendemail('cguyton@seisint.com;akayttala@seisint.com', 'BankruptcyV2 Despray Complete', 'BankruptcyV2 Despray Complete'));
	
	sequential(
		// Proc_Build_Base
		// notify('BANKRUPTCY BASE BUILD COMPLETE','*')
		Proc_Build_Keys
		,Proc_Accept_to_QA
		,notify('Yogurt:BANKRUPTCY ROXIE KEY BUILD COMPLETE','*')
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//AUTOMATIC DOPS UPDATE PROCESS - DEACTIVATE WHEN RUNNING THE BUILD MANUALLY (i.e. LAYOUT CHANGES)																																//
		,Roxiekeybuild.updateversion('BankruptcyV2Keys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com','Y','N',,'Y',,,'N')//
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		,if(ut.Weekday((integer)filedate[1..8]) <> 'SATURDAY' and ut.Weekday((integer)filedate[1..8]) <> 'SUNDAY',
					 Orbit3.proc_Orbit3_CreateBuild ('Bankruptcy',filedate,'N|B'),
					 output('No Orbit Entry Needed for weekend builds'))
		
		//,boolean_build
		// ,dops_update
		// ,new_records_sample_for_qa
		// ,proc_BK_Stats
		// ,proc_BK_Stats_v3		
		// ,Stats_For_DR
		// ,orbitreport
		
		
		//,parallel(Mapping_BK_Main_V1, Mapping_BK_Search_V1)
	) : when(event('Yogurt:BANKRUPTCY BASE BUILD COMPLETE','*'),count(1));

  endmacro
 ;