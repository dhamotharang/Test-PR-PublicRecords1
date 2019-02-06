import versioncontrol,_Control;

export Stats_Coverage(

	 string																			pversion
	,dataset(Layout_Corporate_Direct_Corp_base) pCorpBase					= files().base.corp.qa
	,string																			pDesprayDirectory = '/data/data_build_4/corporate_filings/logs/base_file_coverages'
	,boolean																		pOverwrite				= false
	,boolean																		pIsTesting				= false
	,string																			landing_zone			:= _Control.IPAddress.bctlpedata10

) :=
function
	
	dCorp := pCorpBase;

	Corp_REC := record
		dCorp.corp_state_origin;
		dCorp.corp_vendor;
		dCorp.corp_process_date;
		CountGroup               			:= count(group);
	end;

	Corp_REC2 := record
		dCorp.corp_state_origin;
		dCorp.corp_process_date;
	end;

	Corp_REC_string := record
		dCorp.corp_state_origin	;
		string1 pipe1 := '|';
		dCorp.corp_process_date	;
		string1 lf	:= '\n'		;
	end;

	corpStats := sort(table(dCorp,corp_rec,corp_state_origin,corp_vendor,corp_process_date,few),corp_state_origin,corp_vendor,corp_process_date);
	corpStats_despray := sort(table(dCorp,corp_rec2,corp_state_origin,corp_process_date,few),corp_state_origin,corp_process_date);

	corpStats_string := project(corpStats_despray
		,transform(Corp_REC_string, 
			self := left;
		)
	);

	Corp_Recent := record
		dCorp.corp_state_origin;
		dCorp.corp_vendor;
		unsigned4 latest_process_date	:= max(group	,(unsigned6)trim(dCorp.corp_process_date,left,right));
		CountGroup               			:= count(group);
	end;

	Corp_Recent_string := record
		dCorp.corp_state_origin			;
		dCorp.corp_vendor						;
		string10 latest_process_date;
		string10 CountGroup					;
		string1 lf	:= '\n'		;
	end;

	corpStatsRecent := sort(table(dCorp,corp_Recent,corp_state_origin,corp_vendor,few),corp_state_origin,corp_vendor);

	corpStatsRecent_string := project(corpStatsRecent
		,transform(Corp_Recent_string, 
			self.CountGroup := (string10)left.countgroup;
			self.latest_process_date := (string10)left.latest_process_date;
			self := left;
		)
	);

	versioncontrol.macBuildNewLogicalFile(filenames(pversion).stats.coverage.new,corpStats_string,total_coverage_out,,,pOverwrite);
	
	myfilestodespray := dataset([
		
		 {	 filenames(pversion).stats.coverage.new	,landing_zone,pDesprayDirectory + '/corpv2_base_file_coverage_stats_' + pversion + '.dict' }
                                                                                                                           
	], versioncontrol.Layout_DKCs.Input);

	return 
		sequential(
			parallel(
				 total_coverage_out
				,output(corpStatsRecent_string		,named('LatestProcessDatePerState'	),all)			
			)
			// ,versioncontrol.fDesprayFiles(myfilestodespray,,,'Corp2DesprayCoverageFileInfo',pOverwrite,pIsTesting)
		);
	


end;