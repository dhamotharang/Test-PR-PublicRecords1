import	_control;

export Proc_Build_MXDocket_keys(string pVersion) := function

docket_idx:= RECORD
  unsigned8 rec_id;
  unicode60 geography;
  unsigned4 date_pub;
  unicode100 court;
  unicode100 court_local;
  unicode100 docket;
  unicode50 docket_num;
  unsigned3 docket_year;
  unicode400 caption;
  unicode150 nature;
  unsigned1 nature_type;
  unicode250 comment;
  unsigned4 date_hearing;
  string3 state;
  unsigned8 __internal_fpos__;
 END;
 
docket_idx_key := buildindex(index(dataset([],docket_idx),{rec_id},{geography, date_pub, court, court_local, docket, docket_num, docket_year, caption, nature, nature_type, comment, date_hearing, state},'keyname'),'~prte::key::mxd_mxdocket::'+ pVersion +'::docket_idx',update);

docket_mph_search_idx:= RECORD
  unsigned1 search_type;
  string10 n1_m1;
  string10 n1_m2;
  string10 n2_m1;
  string10 n2_m2;
  string10 n3_m1;
  string10 n3_m2;
  string1 minit;
  unsigned1 nature_type;
  unsigned2 year;
  string3 state;
  string1 gender;
  unsigned8 entity_id;
  unsigned8 rec_id;
 END;

docket_mph_search_idx_key := buildindex(index(dataset([],docket_mph_search_idx),{search_type, n1_m1, n1_m2, n2_m1, n2_m2, n3_m1, n3_m2, minit, nature_type, year, state, gender},{entity_id, rec_id},'keyname'),'~prte::key::mxd_mxdocket::'+ pVersion +'::docket_mph_search_idx',update);

docket_party_idx:= RECORD
  unsigned8 entity_id;
  unsigned8 rec_id;
  unsigned1 partytype;
  string1 partynumber;
  unicode50 firstname;
  unicode50 middlename1;
  unicode20 middlename2;
  unicode20 middlename3;
  unicode20 middlename4;
  unicode20 middlename5;
  unicode50 lastname;
  unicode50 matronymic;
  unicode50 husbandslastname;
  unicode50 patronymic;
  unicode50	partyalias;
  string1 gender;
  unicode200 partyoriginal;
  unsigned8 __internal_fpos__;
 END;


docket_party_idx_key := buildindex(index(dataset([],docket_party_idx),{entity_id, rec_id},															 
																	{partytype, partynumber, firstname, middlename1, middlename2, middlename3, middlename4, middlename5,lastname, matronymic, husbandslastname, patronymic,partyalias, gender, partyoriginal},'keyname'),'~prte::key::mxd_mxdocket::'+ pVersion +'::docket_party_idx',update);
														
docket_search_idx:= RECORD
  unsigned1 search_type;
  string50 n1;
  string50 n2;
  string50 n3;
  string1 minit;
  unsigned1 nature_type;
  unsigned2 year;
  string3 state;
  string1 gender;
  unsigned8 entity_id;
  unsigned8 rec_id;
 END;

docket_search_idx_key := buildindex(index(dataset([],docket_search_idx),{search_type, n1, n2, n3, minit, nature_type, year, state, gender},															 
																	{entity_id, rec_id},'keyname'),'~prte::key::mxd_mxdocket::'+ pVersion +'::docket_search_idx',update);

docket_num_idx := Record
  string30		docket_num;  
  string3			state;	
  unsigned3	docket_year;
  unsigned8	entity_id;
  unsigned8	rec_id;
End;
docket_num_idx_key := buildindex(index(dataset([],docket_num_idx), {docket_num, state, docket_year},
																	{entity_id, rec_id},'keyname'), '~prte::key::mxd_mxdocket::'+ pVersion +'::docket_num_idx', update);


return	sequential(
						parallel(
											docket_idx_key,
											docket_mph_search_idx_key,
											docket_party_idx_key,
											docket_search_idx_key,
											docket_num_idx_key
											),	 
						PRTE.UpdateVersion('MXDocketKeys',		//	Package name
																pVersion,					//	Package version
																'uma.pamarthy@lexisnexis.com;anantha.venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'N',									//	N = Non-FCRA, F = FCRA
																'N'									//	N = Do not also include boolean, Y = Include boolean, too
															)
						);
end;