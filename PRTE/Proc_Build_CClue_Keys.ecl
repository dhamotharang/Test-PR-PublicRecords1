import	_control, PRTE_CSV;

export Proc_Build_CClue_Keys(string pIndexVersion) := function
			
	rKeyCClue__linkids	:=
	record
		PRTE_CSV.CClue.rthor_data400__key__CClue__linkids;
	end;
	
	dKeyCClue__linkids	:= 	project(PRTE_CSV.CClue.dthor_data400__key__CClue__linkids, rKeyCClue__linkids);	
													
	kKeyCClue__linkids	:=	index(dKeyCClue__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyCClue__linkids}, 	'~prte::key::CClue::' + pIndexVersion + '::linkids');

	return	sequential(
											parallel(																																
															  build(kKeyCClue__linkids						    , update)
																																															
															 ),
											PRTE.UpdateVersion('CClueKeys',	 												//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;