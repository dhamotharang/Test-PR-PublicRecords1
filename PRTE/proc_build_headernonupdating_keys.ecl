import	_control, PRTE_CSV,header,ut,doxie,NID;

export	proc_build_headernonupdating_keys(string pIndexVersion)	:=
function
	
	rKeyHeader__fname_ngram	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__fname_ngram;
	end;

	rKeyHeader__lname_ngram	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__lname_ngram;
	end;

	rKeyHeader__phonetic_fname_top10	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__phonetic_fname_top10;
	end;

	rKeyHeader__phonetic_lname	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__phonetic_lname;
	end;

	rKeyHeader__phonetic_lname_top10	:=
	record
		PRTE_CSV.Header.rthor_data400__key__header__phonetic_lname_top10;
	end;

	// ge data
	
	header_proj_out := PRTE.Get_Header_Base;
	
dKeyHeader__fname_ngram := project(PRTE_CSV.Header.dthor_data400__key__header__fname_ngram, rKeyHeader__fname_ngram);
prte.header_ds_macro(prKeyHeader__fname_ngram,rKeyHeader__fname_ngram,header_proj_out,dKeyHeader__fname_ngram1);

dKeyHeader__lname_ngram := project(PRTE_CSV.Header.dthor_data400__key__header__lname_ngram, rKeyHeader__lname_ngram);
prte.header_ds_macro(prKeyHeader__lname_ngram,rKeyHeader__lname_ngram,header_proj_out,dKeyHeader__lname_ngram1);

dKeyHeader__phonetic_fname_top10 := project(PRTE_CSV.Header.dthor_data400__key__header__phonetic_fname_top10, rKeyHeader__phonetic_fname_top10);
prte.header_ds_macro(prKeyHeader__phonetic_fname_top10,rKeyHeader__phonetic_fname_top10,header_proj_out,dKeyHeader__phonetic_fname_top101);
dKeyHeader__phonetic_lname := project(PRTE_CSV.Header.dthor_data400__key__header__phonetic_lname, rKeyHeader__phonetic_lname);
prte.header_ds_macro(prKeyHeader__phonetic_lname,rKeyHeader__phonetic_lname,header_proj_out,dKeyHeader__phonetic_lname1);
dKeyHeader__phonetic_lname_top10 := project(PRTE_CSV.Header.dthor_data400__key__header__phonetic_lname_top10, rKeyHeader__phonetic_lname_top10);
prte.header_ds_macro(prKeyHeader__phonetic_lname_top10,rKeyHeader__phonetic_lname_top10,header_proj_out,dKeyHeader__phonetic_lname_top101);


fulldKeyHeader__fname_ngram := dKeyHeader__fname_ngram + dKeyHeader__fname_ngram1;
kKeyHeader__fname_ngram := index(fulldKeyHeader__fname_ngram, {ngram}, {fulldKeyHeader__fname_ngram}, '~prte::key::header::' + pIndexVersion + '::fname_ngram');

fulldKeyHeader__lname_ngram := dKeyHeader__lname_ngram + dKeyHeader__lname_ngram1;
kKeyHeader__lname_ngram := index(fulldKeyHeader__lname_ngram, {ngram}, {fulldKeyHeader__lname_ngram}, '~prte::key::header::' + pIndexVersion + '::lname_ngram');

fulldKeyHeader__phonetic_fname_top10 := dKeyHeader__phonetic_fname_top10 + dKeyHeader__phonetic_fname_top101;
kKeyHeader__phonetic_fname_top10 := index(fulldKeyHeader__phonetic_fname_top10, {ph_fname}, {fulldKeyHeader__phonetic_fname_top10}, '~prte::key::header::' + pIndexVersion + '::phonetic_fname_top10');
fulldKeyHeader__phonetic_lname_top10 := dKeyHeader__phonetic_lname_top10 + dKeyHeader__phonetic_lname_top101;
kKeyHeader__phonetic_lname_top10 := index(fulldKeyHeader__phonetic_lname_top10, {ph_lname}, {fulldKeyHeader__phonetic_lname_top10}, '~prte::key::header::' + pIndexVersion + '::phonetic_lname_top10');

arecord5:= 
RECORD
 string12 geolink;
  string10 lat;
  string11 long;
  unsigned8 __internal_fpos__;
 END;
 
addrfraud_key_1 := buildindex(index(dataset([],arecord5),{geolink},{dataset([],arecord5)},'keyname'),'~prte::key::'+ pIndexVersion +'::geoblk_info_geolink',update);
arecord6:= 
RECORD
  integer4 lat1000;
  qstring12 geolink;
  real4 lat;
  real4 lon;
  unsigned8 __internal_fpos__;
 END;
addrfraud_key_2 := buildindex(index(dataset([],arecord6),{lat1000},{dataset([],arecord6)},'keyname'),'~prte::key::'+ pIndexVersion +'::geoblk_latlon',update);
arecord7:= 
RECORD
  string12 geolink1;
  string12 geolink2;
  real4 distance;
  unsigned8 __internal_fpos__;
 END;
addrfraud_key_3 := buildindex(index(dataset([],arecord7),{geolink1,geolink2},{dataset([],arecord7)},'keyname'),'~prte::key::'+ pIndexVersion +'::geolink_to_geolink::geolink1geolink2',update);
arecord8:= 
RECORD
  string12 geolink1;
  unsigned2 dist_100th;
  string12 geolink2;
  unsigned8 __internal_fpos__;
 END;
addrfraud_key_4 := buildindex(index(dataset([],arecord8),{geolink1,dist_100th},{dataset([],arecord8)},'keyname'),'~prte::key::'+ pIndexVersion +'::geolink_to_geolink::geolink_dist_100th',update);






	return	sequential(
											parallel(
																
																build(kKeyHeader__fname_ngram			, update)
																,build(kKeyHeader__lname_ngram			, update)
																
																,build(kKeyHeader__phonetic_fname_top10			, update)
																,build(kKeyHeader__phonetic_lname_top10			, update)
																
															 ,addrfraud_key_1, addrfraud_key_2,
															 addrfraud_key_3,addrfraud_key_4),
															 
															 
											PRTE.UpdateVersion('HeaderNonUpdatingKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 'wenhong.ma@lexisnexis.com;anantha.venkatachalam@lexisnexis.com',	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );


end;
