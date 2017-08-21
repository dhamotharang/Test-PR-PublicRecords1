import	_control, PRTE_CSV;

export	Proc_Build_telcordia_tpm_Keys(string pIndexVersion)	:=
function

	
	rkey__telcordia__npa_st	:=
	record
		PRTE_CSV.telcordia.rthor_data400__key__telcordia__npa_st;
	end;
	
	rkey__telcordia__tpm	:=
	record
		PRTE_CSV.telcordia.rthor_data400__key__telcordia__tpm;
	end;

	rkey__telcordia__tpm_slim	:=
	record
		PRTE_CSV.XML_Telcordia.rthor_data400__key__telcordia__tpm_slim;
	end;

	dkey__telcordia__npa_st			:= 	project(PRTE_CSV.telcordia.dthor_data400__key__telcordia__20081015__npa_st, rkey__telcordia__npa_st);
	dkey__telcordia__tpm			:= 	project(PRTE_CSV.telcordia.dthor_data400__key__telcordia__20081015__tpm, rkey__telcordia__tpm);
    dkey__telcordia__tpm_slim			:= 	project(PRTE_CSV.XML_Telcordia.dthor_data400__key__telcordia__tpm_slim, rkey__telcordia__tpm_slim);


    kkey__telcordia__npa_st			:=	index(dkey__telcordia__npa_st, {npa,st}, {groupCount}, '~prte::key::telcordia::' + pIndexVersion + '::npa_st');
    kkey__telcordia__tpm			:=	index(dkey__telcordia__tpm, {npa,nxx,tb}, {dkey__telcordia__tpm}, '~prte::key::telcordia::' + pIndexVersion + '::tpm');
    kkey__telcordia__tpm_slim			:=	index(dkey__telcordia__tpm_slim, {npa,nxx,tb}, {dkey__telcordia__tpm_slim}, '~prte::key::telcordia::' + pIndexVersion + '::tpm_slim');

return	sequential(
											parallel(
																build(kkey__telcordia__npa_st			, update), 
																build(kkey__telcordia__tpm			, update),
																build(kkey__telcordia__tpm_slim			, update)

																	 ),
											PRTE.UpdateVersion('TelcordiaTpmKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;