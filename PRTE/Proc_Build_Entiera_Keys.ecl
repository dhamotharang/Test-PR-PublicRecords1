import	_control, PRTE_CSV;

export	Proc_Build_Entiera_Keys(string pIndexVersion)	:=
function

	rKeyEntiera__key__did	:=
	record
		PRTE_CSV.Entiera.rthor_200__key__entiera__did;
	end;

	dKeyEntiera__did	:= 	project(PRTE_CSV.Entiera.dthor_200__key__entiera__did, rKeyEntiera__key__did);

	kKeyEntiera__did	:=	index(dKeyEntiera__did, {did}, {dKeyEntiera__did}, '~prte::key::entiera::' + pIndexVersion + '::did');

	return	sequential(
											build(kKeyEntiera__did, update),
											PRTE.UpdateVersion('EntieraKeys',												//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										);
end;	