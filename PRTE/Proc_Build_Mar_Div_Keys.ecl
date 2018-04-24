import	_control, PRTE_CSV;

export	Proc_Build_Mar_Div_Keys(string pIndexVersion)	:=
function

	rKeyMar_Div__autokey__address	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__autokey__address;
	end;
	
	rKeyMar_Div__autokey__citystname	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__autokey__citystname;
	end;	
	
	rKeyMar_Div__autokey__name	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__autokey__name;
	end;		
	
	rKeyMar_Div__autokey__payload	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__autokey__payload;
	end;
	
	rKeyMar_Div__autokey__stname	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__autokey__stname;
	end;	
	
	rKeyMar_Div__autokey__zip	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__autokey__zip;
	end;	

	rKeyMar_Div__did	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__did;
	end;	
	
	rKeyMar_Div__filing_nbr	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__filing_nbr;
	end;	
	
	rKeyMar_Div__id_main	:=
	record
		// PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__id_main;
		unsigned6 record_id;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
	string1 filing_type;
	string25 filing_subtype;
	string5 vendor;
	string25 source_file;
	string8 process_date;
	string2 state_origin;
	string2 number_of_children;
	string8 marriage_filing_dt;
	string8 marriage_dt;
	string30 marriage_city;
	string35 marriage_county;
	string10 place_of_marriage;
	string10 type_of_ceremony;
	string25 marriage_filing_number;
	string30 marriage_docket_volume;
	string8 divorce_filing_dt;
	string8 divorce_dt;
	string30 divorce_docket_volume;
	string25 divorce_filing_number;
	string30 divorce_city;
	string35 divorce_county;
	string50 grounds_for_divorce;
	string1 marriage_duration_cd;
	string3 marriage_duration;
	unsigned8 persistent_record_id := 0;
	unsigned8 __internal_fpos__;
	end;		

	rKeyMar_Div__id_search	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__id_search;
	end;
	
	rKeyMar_Div__did_fcra	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__did;
	end;	
	
	rKeyMar_Div__id_main_fcra	:=
	record
	unsigned6 record_id;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_vendor_last_reported;
	string1 filing_type;
	string25 filing_subtype;
	string5 vendor;
	string25 source_file;
	string8 process_date;
	string2 state_origin;
	string2 number_of_children;
	string8 marriage_filing_dt;
	string8 marriage_dt;
	string30 marriage_city;
	string35 marriage_county;
	string10 place_of_marriage;
	string10 type_of_ceremony;
	string25 marriage_filing_number;
	string30 marriage_docket_volume;
	string8 divorce_filing_dt;
	string8 divorce_dt;
	string30 divorce_docket_volume;
	string25 divorce_filing_number;
	string30 divorce_city;
	string35 divorce_county;
	string50 grounds_for_divorce;
	string1 marriage_duration_cd;
	string3 marriage_duration;
	unsigned8 persistent_record_id := 0;
	unsigned8 __internal_fpos__;
	end;		
	
	rKeyMar_Div__id_search_fcra	:=
	record
		PRTE_CSV.Mar_Div.rthor_data400__key__mar_div__id_search;
	end;
	
	dKeyMar_Div__autokey__address			:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__autokey__address, rKeyMar_Div__autokey__address);
	dKeyMar_Div__autokey__citystname	:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__autokey__citystname, rKeyMar_Div__autokey__citystname);
	dKeyMar_Div__autokey__name				:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__autokey__name, rKeyMar_Div__autokey__name);
	dKeyMar_Div__autokey__payload			:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__autokey__payload, rKeyMar_Div__autokey__payload);
	dKeyMar_Div__autokey__stname			:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__autokey__stname, rKeyMar_Div__autokey__stname);
	dKeyMar_Div__autokey__zip					:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__autokey__zip, rKeyMar_Div__autokey__zip);
	dKeyMar_Div__did									:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__did, rKeyMar_Div__did);
	dKeyMar_Div__filing_nbr						:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__filing_nbr, rKeyMar_Div__filing_nbr);
	dKeyMar_Div__id_main							:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__id_main, rKeyMar_Div__id_main);
	dKeyMar_Div__id_search						:= 	project(PRTE_CSV.Mar_Div.dthor_data400__key__Mar_Div__id_search, rKeyMar_Div__id_search);
	
	kKeyMar_Div__autokey__address				:=	index(dKeyMar_Div__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyMar_Div__autokey__address}, '~prte::key::mar_div::' + pIndexVersion + '::autokey::address');
	kKeyMar_Div__autokey__citystname		:=	index(dKeyMar_Div__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyMar_Div__autokey__citystname}, '~prte::key::mar_div::' + pIndexVersion + '::autokey::citystname');
	kKeyMar_Div__autokey__name					:=	index(dKeyMar_Div__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyMar_Div__autokey__name}, '~prte::key::mar_div::' + pIndexVersion + '::autokey::name');
	kKeyMar_Div__autokey__payload				:=	index(dKeyMar_Div__autokey__payload, {fakeid}, {dKeyMar_Div__autokey__payload}, '~prte::key::mar_div::' + pIndexVersion + '::autokey::payload');
	kKeyMar_Div__autokey__stname				:=	index(dKeyMar_Div__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyMar_Div__autokey__stname}, '~prte::key::mar_div::' + pIndexVersion + '::autokey::stname');
	kKeyMar_Div__autokey__zip						:=	index(dKeyMar_Div__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyMar_Div__autokey__zip}, '~prte::key::mar_div::' + pIndexVersion + '::autokey::zip');
	kKeyMar_Div__did										:=	index(dKeyMar_Div__did, {did}, {dKeyMar_Div__did}, '~prte::key::mar_div::' + pIndexVersion + '::did');
	kKeyMar_Div__filing_nbr							:=	index(dKeyMar_Div__filing_nbr, {filing_number,filing_type,filing_subtype,state_origin,county}, {dKeyMar_Div__filing_nbr}, '~prte::key::mar_div::' + pIndexVersion + '::filing_nbr');	
	kKeyMar_Div__id_main								:=	index(dKeyMar_Div__id_main, {record_id}, {dKeyMar_Div__id_main}, '~prte::key::mar_div::' + pIndexVersion + '::id_main');	
	kKeyMar_Div__id_search							:=	index(dKeyMar_Div__id_search, {record_id,which_party}, {dKeyMar_Div__id_search}, '~prte::key::mar_div::' + pIndexVersion + '::id_search');	

//fcra keys	
	kKeyMar_Div__did_fcra								:=	index(dKeyMar_Div__did, {did}, {dKeyMar_Div__did}, '~prte::key::mar_div::fcra::' + pIndexVersion + '::did');
	kKeyMar_Div__id_main_fcra						:=	index(dKeyMar_Div__id_main, {record_id}, {dKeyMar_Div__id_main}, '~prte::key::mar_div::fcra::' + pIndexVersion + '::id_main');	
	kKeyMar_Div__id_search_fcra					:=	index(dKeyMar_Div__id_search, {record_id,which_party}, {dKeyMar_Div__id_search}, '~prte::key::mar_div::fcra::' + pIndexVersion + '::id_search');	
	
return	sequential(
											parallel(
																build(kKeyMar_Div__autokey__address, update),
																build(kKeyMar_Div__autokey__citystname, update),
																build(kKeyMar_Div__autokey__name, update),
																build(kKeyMar_Div__autokey__payload, update),
																build(kKeyMar_Div__autokey__stname, update),
																build(kKeyMar_Div__autokey__zip, update),
																build(kKeyMar_Div__did, update),
																build(kKeyMar_Div__filing_nbr, update),
																build(kKeyMar_Div__id_main, update),
																build(kKeyMar_Div__id_search, update),
																build(kKeyMar_Div__did_fcra, update),
																build(kKeyMar_Div__id_main_fcra, update),
																build(kKeyMar_Div__id_search_fcra, update)
															 ),
											PRTE.UpdateVersion('MDV2Keys',													//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
											PRTE.UpdateVersion('FCRA_MDV2Keys',													//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end: DEPRECATED('Use PRTE2_Marriage_Divorce.proc_build_keys');;	