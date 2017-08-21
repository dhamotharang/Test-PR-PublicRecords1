import	_control, PRTE_CSV;

export	Proc_Build_Targus_Keys(string pIndexVersion)	:=
function

	rKeyTargus__address	:=
	record
		PRTE_CSV.Targus.rthor_data400__key__targus__address;
	end;
	
	rKeyTargus__did	:=
	record
		PRTE_CSV.Targus.rthor_data400__key__targus__did;
	end;	
	
	rKeyTargus__p7_p3_st	:=
	record
		PRTE_CSV.Targus.rthor_data400__key__targus__p7_p3_st;
	end;
	
	dKeyTargus__address		:= 	project(PRTE_CSV.Targus.dthor_data400__key__targus__address, rKeyTargus__address);
	dKeyTargus__did				:= 	project(PRTE_CSV.Targus.dthor_data400__key__targus__did, rKeyTargus__did);
	dKeyTargus__p7_p3_st	:= 	project(PRTE_CSV.Targus.dthor_data400__key__targus__p7_p3_st, rKeyTargus__p7_p3_st);	
	
	kKeyTargus__address		:=	index(dKeyTargus__address, {prim_name, zip, prim_range, sec_range, predir, suffix}, {dKeyTargus__address}, '~prte::key::targus::' + pIndexVersion + '::address');	
	kKeyTargus__did				:=	index(dKeyTargus__did, {did}, {dKeyTargus__did}, '~prte::key::targus::' + pIndexVersion + '::did');	
	kKeyTargus__p7_p3_st	:=	index(dKeyTargus__p7_p3_st, {p7, p3, st}, {dKeyTargus__p7_p3_st}, '~prte::key::targus::' + pIndexVersion + '::p7.p3.st');	

	return	sequential(
											parallel(
																build(kKeyTargus__address, update),
																build(kKeyTargus__did, update),
																build(kKeyTargus__p7_p3_st, update)
															 ),
											PRTE.UpdateVersion('TargusKeys',												//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;		