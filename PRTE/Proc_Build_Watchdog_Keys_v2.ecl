import	_control, PRTE2_Common, PRTE_CSV;

EXPORT Proc_Build_Watchdog_Keys_v2(string pIndexVersion,
																	string pIndexOldVersion, 
																	boolean is_test_run, STRING emailTo='') := MODULE

		// Setup the Post Processing steps for Dev, Prod-test-run, and Prod
		// Because some of us cannot Sandbox MyInfo in production, give the ability to pass in an email address (default to previous MyInfo)
		EXPORT DOPS_Emails := IF(emailTo<>'', emailTo, _control.MyInfo.EmailAddressNormal);
		EXPORT PROD_PP_STEPS := SEQUENTIAL(
								PRTE.CopyMissingKeys('WatchdogKeys',pIndexVersion,pIndexOldVersion)
								,PRTE.UpdateVersion( 'WatchdogKeys', pIndexVersion, DOPS_Emails, 'B', 'N', 'N')
											);
		EXPORT TEST_RUN_PP_STEPS := SEQUENTIAL(
								PRTE.CopyMissingKeys('WatchdogKeys',pIndexVersion,pIndexOldVersion)
								,OUTPUT('Production TEST-RUN build so skipping UpdateVersion (WatchdogKeys)')
											);
		EXPORT CHOSEN_PROD_PP_STEPS := IF(is_test_run, TEST_RUN_PP_STEPS, PROD_PP_STEPS);
		EXPORT NOT_PROD_STEP := OUTPUT('Not a production build so skipping copyMissingKeys and UpdateVersion');
		Running_in_production :=  PRTE2_Common.Constants.Running_in_production;
		EXPORT Production_Post_Processing_Actions := IF(Running_in_production, CHOSEN_PROD_PP_STEPS, NOT_PROD_STEP);

		EXPORT Build_Keys := FUNCTION
				rKeyWatchdog__best_did	:=PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_did;
				rKeyWatchdog__best_did_nonblank	:=PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_did_nonblank;
				rKeyWatchdog__best_nonen_did	:=PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_nonen_did;
				rKeyWatchdog__nonen_did_nonblank	:=PRTE_CSV.Watchdog.rthor_data400__key__watchdog__best_nonen_did_nonblank;
				rKeyWatchdog__nonglb_did	:=PRTE_CSV.Watchdog.rthor_data400__key__watchdog__nonglb_did;
				rKeyWatchdog__nonglb_did_nonblank	:=PRTE_CSV.Watchdog.rthor_data400__key__watchdog__nonglb_did_nonblank;
				rKeyWatchdog__ssn_bads	:=PRTE_CSV.Watchdog.rthor_data400__key__watchdog__ssn_bads;

				payload := PRTE.Get_Header_Base.payload;

				Prte.header_ds_macro(prKeyHeader___best_did,'self.dod := (qstring)l.dod;',,,,rKeyWatchdog__best_did,payload,dKeyWatchdog__best_did);
				fKeyWatchdog__best_did						:= 	dedup(dKeyWatchdog__best_did,did,all);
				kKeyWatchdog__best_did						:=	index(fKeyWatchdog__best_did, {fKeyWatchdog__best_did}, '~prte::key::watchdog::' + pIndexVersion + '::best.did');

				Prte.header_ds_macro(prKeyHeader___best_did_nonblank,'self.dod := (qstring)l.dod;',,,,rKeyWatchdog__best_did_nonblank,payload,dKeyWatchdog__best_did_nonblank);
				fKeyWatchdog__best_did_nonblank		:= 	dedup(dKeyWatchdog__best_did_nonblank,did,all);
				kKeyWatchdog__best_did_nonblank		:=	index(fKeyWatchdog__best_did_nonblank, {fKeyWatchdog__best_did_nonblank}, '~prte::key::watchdog::' + pIndexVersion + '::best.did_nonblank');

				Prte.header_ds_macro(prKeyHeader___best_nonen_did,'self.dod := (qstring)l.dod;',,,,rKeyWatchdog__best_nonen_did,payload,dKeyWatchdog__best_nonen_did);
				fKeyWatchdog__best_nonen_did			:= 	dedup(dKeyWatchdog__best_nonen_did,did,all);
				kKeyWatchdog__best_nonen_did			:=	index(fKeyWatchdog__best_nonen_did, {fKeyWatchdog__best_nonen_did}, '~prte::key::watchdog::' + pIndexVersion + '::best_nonen.did');

				Prte.header_ds_macro(prKeyHeader___nonen_did_nonblank,'self.dod := (qstring)l.dod;',,,,rKeyWatchdog__nonen_did_nonblank,payload,dKeyWatchdog__nonen_did_nonblank);
				fKeyWatchdog__nonen_did_nonblank	:= 	dedup(dKeyWatchdog__nonen_did_nonblank,did,all);
				kKeyWatchdog__nonen_did_nonblank	:=	index(fKeyWatchdog__nonen_did_nonblank, {fKeyWatchdog__nonen_did_nonblank}, '~prte::key::watchdog::' + pIndexVersion + '::best_nonen.did_nonblank');

				Prte.header_ds_macro(prKeyHeader___nonglb_did,'self.dod := (qstring)l.dod;',,,,rKeyWatchdog__nonglb_did,payload,dKeyWatchdog__nonglb_did);
				fKeyWatchdog__nonglb_did					:= 	dedup(dKeyWatchdog__nonglb_did,did,all);
				kKeyWatchdog__nonglb_did					:=	index(fKeyWatchdog__nonglb_did, {fKeyWatchdog__nonglb_did}, '~prte::key::watchdog::' + pIndexVersion + '::nonglb.did');

				Prte.header_ds_macro(prKeyHeader___nonglb_did_nonblank,'self.dod := (qstring)l.dod;',,,,rKeyWatchdog__nonglb_did_nonblank,payload,dKeyWatchdog__nonglb_did_nonblank);
				fKeyWatchdog__nonglb_did_nonblank	:= 	dedup(dKeyWatchdog__nonglb_did_nonblank,did,all);
				kKeyWatchdog__nonglb_did_nonblank	:=	index(fKeyWatchdog__nonglb_did_nonblank, {fKeyWatchdog__nonglb_did_nonblank}, '~prte::key::watchdog::' + pIndexVersion + '::nonglb.did_nonblank');

				Prte.header_ds_macro(prKeyHeader___ssn_bads,,,,,rKeyWatchdog__ssn_bads,payload,dKeyWatchdog__ssn_bads);
				fKeyWatchdog__ssn_bads						:= 	dedup(dKeyWatchdog__ssn_bads((integer)s_ssn>0),all);
				kKeyWatchdog__ssn_bads						:=	index(fKeyWatchdog__ssn_bads, {fKeyWatchdog__ssn_bads}, '~prte::key::watchdog::' + pIndexVersion + '::ssn_bads');

				return	sequential(
								parallel(
													build(kKeyWatchdog__best_did			, update)
													,build(kKeyWatchdog__best_did_nonblank		, update)
													,build(kKeyWatchdog__best_nonen_did	, update)
													,build(kKeyWatchdog__nonen_did_nonblank, update)
													,build(kKeyWatchdog__nonglb_did					, update)
													,build(kKeyWatchdog__nonglb_did_nonblank					, update)
													,build(kKeyWatchdog__ssn_bads			, update)
													)
								 );

		END;

END;
