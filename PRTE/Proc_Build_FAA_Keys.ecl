import	_control, PRTE_CSV;

export Proc_Build_FAA_Keys (
														 string		pIndexVersion					= ''
													  ,boolean	pUseOtherEnvironment	= false
)	:=

function

// NON-FCRA FAA Keys
	kKeyfaa__aircraft_info								:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_info,{code}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_info}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_info.old);
	kKeyfaa__engine_info									:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__engine_info,{code}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__engine_info}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.engine_info.old);
	kKeyfaa__aircraft_id									:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_id,{aircraft_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_id}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_id.old);
	kKeyfaa__aircraft_reg_bdid						:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_reg_bdid,{ bd }, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_reg_bdid}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_bdid.old);
	kKeyfaa__aircraft_reg_did							:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_reg_did,{ did }, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_reg_did}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_did.old);
	kKeyfaa__aircraft_reg_nnum						:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_reg_nnum,{n_number,aircraft_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_reg_nnum}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_reg_nnum.old);
	kKeyfaa__airmen_certs									:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_certs,{uid}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_certs}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_certs.old);
	kKeyfaa__airmen_did										:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_did,{did , airmen_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_did}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_did.old);
	kKeyfaa__airmen_id										:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_id,{unique_id, airmen_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_id}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_id.old);
	kKeyfaa__airmen_rid										:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_rid,{airmen_id,unique_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_rid}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.airmen_rid.old);
	kkeyfaa__aircraft_linkids							:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_linkids}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_NonFCRA.aircraft_linkids.old);

// FCRA FAA Keys
	kKeyfaa__aircraft_info_fcra	        	:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_info,{code}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_info}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_info.old);
	kKeyfaa__engine_info_fcra							:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__engine_info,{code}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__engine_info}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.engine_info.old);
	kKeyfaa__aircraft_id_fcra							:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_id,{aircraft_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__aircraft_id}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_id.old);
	kKeyfaa__aircraft_reg_did_fcra				:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__fcra__aircraft_reg_did,{ did }, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__fcra__aircraft_reg_did}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraft_reg_did.old);
  kKeyfaa__aircraftreg_did_fcra	      	:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__fcra__aircraftreg_did,{ did }, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__fcra__aircraftreg_did}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.aircraftreg_did.old);
	kKeyfaa__airmen_did_fcra							:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_did,{did , airmen_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_did}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_did.old);
	kKeyfaa__airmen_rid_fcra							:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_rid,{airmen_id,unique_id}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_rid}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_rid.old);
	kKeyfaa__airmen_certs_fcra						:=	index(prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_certs,{uid}, {prte_csv.FAA(pIndexVersion).dthor_data400__key__faa__airmen_certs}, PRTE_CSV.FAA_Keyfilenames(pIndexVersion,pUseOtherEnvironment).FAA_Keys_FCRA.airmen_certs.old);

	return	sequential(	prte_csv.FAA(pIndexVersion).ds_Autokeys,
											prte_csv.FAA(pIndexVersion).ds_Airmen_Autokeys,
											parallel(
																build(kKeyfaa__aircraft_info									, update),
																build(kKeyfaa__engine_info										, update),
																build(kKeyfaa__aircraft_id										, update),
                                build(kKeyfaa__aircraft_reg_bdid							, update),
																build(kKeyfaa__aircraft_reg_did								, update),
																build(kKeyfaa__aircraft_reg_nnum							, update),
																build(kKeyfaa__airmen_certs										, update),
																build(kKeyfaa__airmen_did											, update),
																build(kKeyfaa__airmen_id											, update),
																build(kKeyfaa__airmen_rid											, update),
																build(kKeyfaa__aircraftreg_did_fcra						, update), 
																build(kKeyfaa__aircraft_info_fcra							, update),
																build(kKeyfaa__aircraft_id_fcra								, update),
																build(kKeyfaa__aircraft_reg_did_fcra					, update),
																build(kKeyfaa__engine_info_fcra								, update),
															  build(kKeyfaa__airmen_did_fcra								, update),
																build(kKeyfaa__airmen_rid_fcra								, update),
																build(kKeyfaa__airmen_certs_fcra							, update),
															  build(kkeyfaa__aircraft_linkids								, update)

																  ),
													  
											PRTE.UpdateVersion('FAAKeys',														//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				) , 
											PRTE.UpdateVersion('FCRA_FAAKeys',											//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				) 
										 );

end: DEPRECATED('Use PRTE2_FAA.Proc_Buid_Keys');

