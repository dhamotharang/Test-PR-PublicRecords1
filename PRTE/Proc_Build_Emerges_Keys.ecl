import	_control, PRTE_CSV;

export Proc_Build_Emerges_Keys(string pIndexVersion) := function	

	rKeyEmerges__ccw_doxie_did	:=
	record
		PRTE_CSV.Emerges.rthor_data400__key__Emerges__ccw_doxie_did;
	end;
		
	rKeyEmerges__hunters_doxie_did	:=
	record
		PRTE_CSV.Emerges.rthor_data400__key__Emerges__hunters_doxie_did;
	end;		
		
	dKeyEmerges__ccw_doxie_did				:= 	project(PRTE_CSV.Emerges.dthor_data400__key__Emerges__ccw_doxie_did, rKeyEmerges__ccw_doxie_did);	
	dKeyEmerges__hunters_doxie_did		:= 	project(PRTE_CSV.Emerges.dthor_data400__key__Emerges__hunters_doxie_did, rKeyEmerges__hunters_doxie_did);	
		
	kKeyEmerges__ccw_doxie_did				:=	index(dKeyEmerges__ccw_doxie_did, {did}, {dKeyEmerges__ccw_doxie_did}, '~prte::key::Emerges::' + pIndexVersion + '::ccw_doxie_did');
	kKeyEmerges__hunters_doxie_did		:=	index(dKeyEmerges__hunters_doxie_did, {did}, {dKeyEmerges__hunters_doxie_did}, '~prte::key::Emerges::' + pIndexVersion + '::hunters_doxie_did');

//fcra keys
	kKeyEmerges__ccw_doxie_did_fcra				:=	index(dKeyEmerges__ccw_doxie_did, {did}, {dKeyEmerges__ccw_doxie_did}, '~prte::key::Emerges::' + pIndexVersion + '::ccw_doxie_did_fcra');
	kKeyEmerges__hunters_doxie_did_fcra		:=	index(dKeyEmerges__hunters_doxie_did, {did}, {dKeyEmerges__hunters_doxie_did}, '~prte::key::Emerges::' + pIndexVersion + '::hunters_doxie_did_fcra');

	return	sequential(
											parallel(																																														
																build(kKeyEmerges__ccw_doxie_did	    			, update),																																															
																build(kKeyEmerges__hunters_doxie_did    		, update),
																build(kKeyEmerges__ccw_doxie_did_fcra	   		, update),																																															
																build(kKeyEmerges__hunters_doxie_did_fcra  	, update)
															 ),
											PRTE.UpdateVersion('EmergesKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
											PRTE.UpdateVersion('FCRA_EmergesKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
