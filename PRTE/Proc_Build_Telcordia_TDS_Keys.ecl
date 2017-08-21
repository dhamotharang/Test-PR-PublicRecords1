import	_control, PRTE_CSV;

export	Proc_Build_Telcordia_TDS_Keys(string pIndexVersion)	:=
function

	rkey__telcordia__tds	:=
	record
		PRTE_CSV.telcordia.rthor_data400__key__telcordia__tds;
	end;
	
	
	dkey__telcordia__tds			:= 	project(PRTE_CSV.telcordia.dthor_data400__key__telcordia__20080915__tds, rkey__telcordia__tds);
	
	kkey__telcordia__tds			:=	index(dkey__telcordia__tds, {npa,nxx}, {dkey__telcordia__tds}, '~prte::key::telcordia::' + pIndexVersion + '::tds');
   
return	sequential(
											parallel(
																build(kkey__telcordia__tds			, update)
															
																	 ),
											PRTE.UpdateVersion('TelcordiaTdsKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;