import	_control, PRTE_CSV;

export Proc_Build_CrashCarrier_Keys(string pIndexVersion) := function
			
	rKeyCrashCarrier__linkids	:=
	record
		PRTE_CSV.CrashCarrier.rthor_data400__key__CrashCarrier__linkids;
	end;
	
	dKeyCrashCarrier__linkids	:= 	project(PRTE_CSV.CrashCarrier.dthor_data400__key__CrashCarrier__linkids, rKeyCrashCarrier__linkids);	
													
	kKeyCrashCarrier__linkids	:=	index(dKeyCrashCarrier__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyCrashCarrier__linkids}, 	'~prte::key::CrashCarrier::' + pIndexVersion + '::linkids');

	return	sequential(
											parallel(																																
															  build(kKeyCrashCarrier__linkids						    , update)
																																															
															 ),
											PRTE.UpdateVersion('CrashCarrierKeys',	 								//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;