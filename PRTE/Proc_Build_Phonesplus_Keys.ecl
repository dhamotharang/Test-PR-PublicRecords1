import	_control, PRTE_CSV;

export	Proc_Build_Phonesplus_Keys(string pIndexVersion)	:=
function

	rKeyPhonesplus__did	:=
	record
		PRTE_CSV.Phonesplus.rthor_data400__key__phonesplus__did;
	end;
	
	dKeyPhonesplus__did			:= 	project(PRTE_CSV.Phonesplus.dthor_data400__key__phonesplus__did, rKeyPhonesplus__did);
	
	kKeyPhonesplus__did			:=	index(dKeyPhonesplus__did, {l_did}, {dKeyPhonesplus__did}, '~prte::key::phonesplus::' + pIndexVersion + '::did');
	
	return	sequential(
											parallel(
																build(kKeyPhonesplus__did			, update)
															 ),
											PRTE.UpdateVersion('PhonesplusKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
