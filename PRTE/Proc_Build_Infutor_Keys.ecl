import prte_csv, _control;

export Proc_Build_Infutor_Keys (string pIndexVersion)	:=
function

	rKeyInfutor__teaser__bestdid	:=
	record
		PRTE_CSV.Infutor.rthor_data400__key__Infutor__teaser__bestdid;
	end;	

	rKeyInfutor__teaser__did	:=
	record
		PRTE_CSV.Infutor.rthor_data400__key__Infutor__teaser__did;
	end;
	
	rKeyInfutor__teaser__search	:=
	record
		PRTE_CSV.Infutor.rthor_data400__key__Infutor__teaser__search;
	end;
	
	rKeyInfutor__adl__infutor__knowx	:=
	record
		PRTE_CSV.Infutor.rthor_data400__key__Infutor__adl__infutor__knowx;
	end;
	
	payload := PRTE.Get_Header_Base.payload;
	
	Prte.header_ds_macro(prKeyHeader_infutor_teaser_bestdid,,,,,rKeyInfutor__teaser__bestdid,payload,dKeyHeader__infutor_teaser_bestdid);
	Prte.header_ds_macro(prKeyHeader_infutor_teaser_did,,,,,rKeyInfutor__teaser__did,payload,dKeyHeader__infutor_teaser_did);
	Prte.header_ds_macro(prKeyHeader_infutor_teaser_search,,,,,rKeyInfutor__teaser__search,payload,dKeyHeader__infutor_teaser_search);
	Prte.header_ds_macro(prKeyHeader_infutor_teaser_knowx,,,,,rKeyInfutor__adl__infutor__knowx,payload,dKeyHeader__infutor_teaser_knowx);

	fulldKeyHeader__infutor_teaser_bestdid  := dedup(dKeyHeader__infutor_teaser_bestdid,all);
	kKeyHeader__infutor_teaser_bestdid := index(fulldKeyHeader__infutor_teaser_bestdid, {did}, {fulldKeyHeader__infutor_teaser_bestdid}, '~prte::key::infutor::' + pIndexVersion + '::best.did');

	fulldKeyHeader__infutor_teaser_did 	:= dedup(dKeyHeader__infutor_teaser_did,all);
	kKeyHeader__infutor_teaser_did := index(fulldKeyHeader__infutor_teaser_did, {did}, {fulldKeyHeader__infutor_teaser_did}, '~prte::key::header::' + pIndexVersion + '::teaser_did');

	fulldKeyHeader__infutor_teaser_search := dedup(dKeyHeader__infutor_teaser_search,all);
	kKeyHeader__infutor_teaser_search := index(fulldKeyHeader__infutor_teaser_search, {dph_lname,lname,iscurrent,st,pfname,fname,zip,yob,minit}, {fulldKeyHeader__infutor_teaser_search}, '~prte::key::header::' + pIndexVersion + '::teaser_search');

	fulldKeyHeader__infutor_teaser_knowx 	:= dedup(dKeyHeader__infutor_teaser_knowx,all);
	kKeyHeader__infutor_teaser_knowx := index(fulldKeyHeader__infutor_teaser_knowx, {s_did}, {fulldKeyHeader__infutor_teaser_knowx}, '~prte::key::header::' + pIndexVersion + '::adl.infutor.knowx');


return	sequential(
											parallel(
																build(kKeyHeader__infutor_teaser_bestdid	, update),
																build(kKeyHeader__infutor_teaser_did			, update),
																build(kKeyHeader__infutor_teaser_search		, update),
																build(kKeyHeader__infutor_teaser_knowx		, update)
															)
                       ,PRTE.UpdateVersion('InfutorKeys',													//	Package name
      																				 pIndexVersion,												//	Package version
      																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
      																				 'B',																	//	B = Boca, A = Alpharetta
      																				 'N',																	//	N = Non-FCRA, F = FCRA
      																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
      																				)															
										 );
end;