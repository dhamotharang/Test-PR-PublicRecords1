import _control, PRTE_CSV;

export	Proc_Build_GlobalWatchlists_Keys(string pIndexVersion)	:=
function

	rKeyGlobalWatchlists__countries	:=
	record
		PRTE_CSV.GlobalWatchlists.rthor_data400__key__globalwatchlists__countries;
	end;

	rKeyGlobalWatchlists__globalwatchlists_key	:=
	record
		PRTE_CSV.GlobalWatchlists.rthor_data400__key__globalwatchlists__globalwatchlists_key;
	end;

	rKeyGlobalWatchlists__seq	:=
	record
		PRTE_CSV.GlobalWatchlists.rthor_data400__key__globalwatchlists__seq;
	end;

	dKeyGlobalWatchlists__countries				:= 	project(PRTE_CSV.GlobalWatchlists.dthor_data400__key__globalwatchlists__countries, rKeyGlobalWatchlists__countries);
	dKeyGlobalWatchlists__globalwatchlists_key	:= 	project(PRTE_CSV.GlobalWatchlists.dthor_data400__key__globalwatchlists__globalwatchlists_key, rKeyGlobalWatchlists__globalwatchlists_key);
	dKeyGlobalWatchlists__seq					:= 	project(PRTE_CSV.GlobalWatchlists.dthor_data400__key__globalwatchlists__seq, rKeyGlobalWatchlists__seq);
	
	kKeyGlobalWatchlists__countries				:=	index(dKeyGlobalWatchlists__countries, {country}, {dKeyGlobalWatchlists__countries}, '~prte::key::globalwatchlists::' + pIndexVersion + '::countries');
	kKeyGlobalWatchlists__globalwatchlists_key	:=	index(dKeyGlobalWatchlists__globalwatchlists_key, {pty_key}, {dKeyGlobalWatchlists__globalwatchlists_key}, '~prte::key::globalwatchlists::' + pIndexVersion + '::globalwatchlists_key');
	kKeyGlobalWatchlists__seq					:=	index(dKeyGlobalWatchlists__seq, {seq}, {dKeyGlobalWatchlists__seq}, '~prte::key::globalwatchlists::' + pIndexVersion + '::seq');
	
	return	sequential(
						parallel(
									build(kKeyGlobalWatchlists__countries, update),
									build(kKeyGlobalWatchlists__globalwatchlists_key, update),
									build(kKeyGlobalWatchlists__seq, update)
								),
																
									PRTE.UpdateVersion('GlobalWatchListKeys',				//	Package name
														pIndexVersion,						//	Package version
														_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
														'B',								//	B = Boca, A = Alpharetta
														'N',								//	N = Non-FCRA, F = FCRA
														'N'									//	N = Do not also include boolean, Y = Include boolean, too
														)
														);

end;
