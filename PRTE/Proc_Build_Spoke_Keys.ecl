import	_control, PRTE_CSV;

export Proc_Build_Spoke_Keys(string pIndexVersion)	:=

function 

	rKeyspoke__bdid										:=
	record
		PRTE_CSV.spoke.rthor_data400__key__spoke__bdid;
	end;
	dKeyspoke__bdid										:= 	project(PRTE_CSV.spoke.dthor_data400__key__spoke__bdid, rKeyspoke__bdid);
	kKeyspoke__bdid										:=	index(dKeyspoke__bdid, {bdid}, {dKeyspoke__bdid}, '~prte::key::spoke::' + pIndexVersion + '::bdid');

	rKeyspoke__did	:=
	record
		PRTE_CSV.spoke.rthor_data400__key__spoke__did;
	end;
	dKeyspoke__did										:= 	project(PRTE_CSV.spoke.dthor_data400__key__spoke__did, rKeyspoke__did);
	kKeyspoke__did										:=	index(dKeyspoke__did, {did}, {dKeyspoke__did}, '~prte::key::spoke::' + pIndexVersion + '::did');

	rKeyspoke__linkids								:=
	record
		PRTE_CSV.spoke.rthor_data400__key__spoke__linkids;
	end;
	dKeyspoke__linkids								:= 	project(PRTE_CSV.spoke.dthor_data400__key__spoke__linkids, rKeyspoke__linkids);
	kKeyspoke__linkids								:=	index(dKeyspoke__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyspoke__linkids}, '~prte::key::spoke::' + pIndexVersion + '::linkids');


return	sequential(
											parallel(
																build(kKeyspoke__bdid										, update),
																build(kKeyspoke__did										, update),																
																build(kKeyspoke__linkids								, update)														
															),
											PRTE.UpdateVersion('spokeKeys',													//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;