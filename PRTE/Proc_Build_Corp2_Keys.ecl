import	_control, PRTE_CSV,BIPV2;

export Proc_Build_Corp2_Keys(string pIndexVersion) := function
	
	rKeyCorp2__ar__corp_key_record_type	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__ar__corp_key_record_type;
	end;
	
	rKeyCorp2__autokey__address	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__address;
	end;

	rKeyCorp2__autokey__addressb2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__addressb2;
	end;

	rKeyCorp2__autokey__citystname	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__citystname;
	end;

	rKeyCorp2__autokey__citystnameb2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__citystnameb2;
	end;	

	rKeyCorp2__autokey__fein2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__fein2;
	end;

	rKeyCorp2__autokey__name	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__name;
	end;

	rKeyCorp2__autokey__nameb2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__nameb2;
	end;

	rKeyCorp2__autokey__namewords2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__namewords2;
	end;

	rKeyCorp2__autokey__payload	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__payload;
	end;
	
	rKeyCorp2__autokey__phone2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__phone2;
	end;
	
	rKeyCorp2__autokey__phoneb2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__phoneb2;
	end;
	
	rKeyCorp2__autokey__ssn2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__ssn2;
	end;
	
	rKeyCorp2__autokey__stname	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__stname;
	end;

	rKeyCorp2__autokey__stnameb2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__stnameb2;
	end;

	rKeyCorp2__autokey__zip	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__zip;
	end;

	rKeyCorp2__autokey__zipb2	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__autokey__zipb2;
	end;	
	
	rKeyCorp2__cont__corp_key_record_type	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__cont__corp_key_record_type and not __internal_fpos__;
    BIPV2.IDlayouts.l_xlink_ids;	
	end;	
	
	rKeyCorp2__cont__did	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__cont__did;
	end;	

	rKeyCorp2__corp__bdid	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__corp__bdid;
	end;
		
	rKeyCorp2__corp__bdid_pl	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__corp__bdid_pl;
	end;
				
	rKeyCorp2__corp__corp_key_record_type	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__corp__corp_key_record_type and not __internal_fpos__;
		BIPV2.IDlayouts.l_xlink_ids;
	end;		
		
	rKeyCorp2__corp__st_charter_number	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__corp__st_charter_number;
	end;		
	
	rKeyCorp2__event__corp_key_record_type	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__event__corp_key_record_type;
	end;		
	
	rKeyCorp2__stock__corp_key_record_type	:=
	record
		PRTE_CSV.Corp2.rthor_data400__key__Corp2__stock__corp_key_record_type;
	end;		

	dKeyCorp2__ar__corp_key_record_type	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__ar__corp_key_record_type, rKeyCorp2__ar__corp_key_record_type);
	dKeyCorp2__autokey__address			:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__address, rKeyCorp2__autokey__address);
	dKeyCorp2__autokey__addressb2		:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__addressb2, rKeyCorp2__autokey__addressb2);
	dKeyCorp2__autokey__citystname		:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__citystname, rKeyCorp2__autokey__citystname);
	dKeyCorp2__autokey__citystnameb2	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__citystnameb2, rKeyCorp2__autokey__citystnameb2);	
	dKeyCorp2__autokey__fein2					:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__fein2, rKeyCorp2__autokey__fein2);
	dKeyCorp2__autokey__name					:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__name, rKeyCorp2__autokey__name);
	dKeyCorp2__autokey__nameb2				:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__nameb2, rKeyCorp2__autokey__nameb2);
	dKeyCorp2__autokey__namewords2		:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__namewords2, rKeyCorp2__autokey__namewords2);	
	dKeyCorp2__autokey__payload			:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__payload, rKeyCorp2__autokey__payload);		
	dKeyCorp2__autokey__phone2  				:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__phone2, rKeyCorp2__autokey__phone2);
	dKeyCorp2__autokey__phoneb2  				:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__phoneb2, rKeyCorp2__autokey__phoneb2);
	dKeyCorp2__autokey__ssn2  				:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__ssn2, rKeyCorp2__autokey__ssn2);
	dKeyCorp2__autokey__stname				:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__stname, rKeyCorp2__autokey__stname);
	dKeyCorp2__autokey__stnameb2			:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__stnameb2, rKeyCorp2__autokey__stnameb2);
	dKeyCorp2__autokey__zip					:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__zip, rKeyCorp2__autokey__zip);
	dKeyCorp2__autokey__zipb2				:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__autokey__zipb2, rKeyCorp2__autokey__zipb2);
	dKeyCorp2__cont__corp_key_record_type	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__cont__corp_key_record_type, rKeyCorp2__cont__corp_key_record_type);	
	dKeyCorp2__cont__did					:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__cont__did, rKeyCorp2__cont__did);	
	dKeyCorp2__corp__bdid            	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__corp__bdid, rKeyCorp2__corp__bdid);	
	dKeyCorp2__corp__bdid_pl           	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__corp__bdid_pl, rKeyCorp2__corp__bdid_pl);	
	dKeyCorp2__corp__corp_key_record_type            	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__corp__corp_key_record_type, rKeyCorp2__corp__corp_key_record_type);	
	dKeyCorp2__corp__st_charter_number            	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__corp__st_charter_number, rKeyCorp2__corp__st_charter_number);	
	dKeyCorp2__event__corp_key_record_type            	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__event__corp_key_record_type, rKeyCorp2__event__corp_key_record_type);	
	dKeyCorp2__stock__corp_key_record_type            	:= 	project(PRTE_CSV.Corp2.dthor_data400__key__Corp2__stock__corp_key_record_type, rKeyCorp2__stock__corp_key_record_type);	
	
	kKeyCorp2__ar__corp_key_record_type			:=	index(dKeyCorp2__ar__corp_key_record_type, {corp_key,record_type}, {dKeyCorp2__ar__corp_key_record_type}, '~prte::key::corp2::' + pIndexVersion + '::ar::corp_key.record_type');
	kKeyCorp2__autokey__address			:=	index(dKeyCorp2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyCorp2__autokey__address}, '~prte::key::corp2::' + pIndexVersion + '::autokey::address');
	kKeyCorp2__autokey__addressb2		:=	index(dKeyCorp2__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyCorp2__autokey__addressb2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::addressb2');
	kKeyCorp2__autokey__citystname		:=	index(dKeyCorp2__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCorp2__autokey__citystname}, '~prte::key::corp2::' + pIndexVersion + '::autokey::citystname');
	kKeyCorp2__autokey__citystnameb2	:=	index(dKeyCorp2__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyCorp2__autokey__citystnameb2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyCorp2__autokey__fein2					:=	index(dKeyCorp2__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeyCorp2__autokey__fein2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::fein2');
	kKeyCorp2__autokey__name					:=	index(dKeyCorp2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCorp2__autokey__name}, '~prte::key::corp2::' + pIndexVersion + '::autokey::name');
	kKeyCorp2__autokey__nameb2				:=	index(dKeyCorp2__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyCorp2__autokey__nameb2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::nameb2');
	kKeyCorp2__autokey__namewords2		:=	index(dKeyCorp2__autokey__namewords2, {word,state,seq,bdid}, {dKeyCorp2__autokey__namewords2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::namewords2');
	kKeyCorp2__autokey__payload			:=	index(dKeyCorp2__autokey__payload, {fakeid}, {dKeyCorp2__autokey__payload}, '~prte::key::corp2::' + pIndexVersion + '::autokey::payload');	
	kKeyCorp2__autokey__phone2				:=	index(dKeyCorp2__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyCorp2__autokey__phone2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::phone2');
	kKeyCorp2__autokey__phoneb2				:=	index(dKeyCorp2__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyCorp2__autokey__phoneb2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::phoneb2');
	kKeyCorp2__autokey__ssn2				:=	index(dKeyCorp2__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyCorp2__autokey__ssn2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::ssn2');
	kKeyCorp2__autokey__stname				:=	index(dKeyCorp2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCorp2__autokey__stname}, '~prte::key::corp2::' + pIndexVersion + '::autokey::stname');
	kKeyCorp2__autokey__stnameb2			:=	index(dKeyCorp2__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyCorp2__autokey__stnameb2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::stnameb2');
	kKeyCorp2__autokey__zip					:=	index(dKeyCorp2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCorp2__autokey__zip}, '~prte::key::corp2::' + pIndexVersion + '::autokey::zip');
	kKeyCorp2__autokey__zipb2				:=	index(dKeyCorp2__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyCorp2__autokey__zipb2}, '~prte::key::corp2::' + pIndexVersion + '::autokey::zipb2');	
	kKeyCorp2__cont__corp_key_record_type						:=	index(dKeyCorp2__cont__corp_key_record_type, {corp_key,record_type}, {dKeyCorp2__cont__corp_key_record_type}, '~prte::key::corp2::' + pIndexVersion + '::cont::corp_key.record_type');
	kKeyCorp2__cont__did						:=	index(dKeyCorp2__cont__did, {did}, {dKeyCorp2__cont__did}, '~prte::key::corp2::' + pIndexVersion + '::cont::did');
	kKeyCorp2__corp__bdid						:=	index(dKeyCorp2__corp__bdid, {bdid}, {dKeyCorp2__corp__bdid}, '~prte::key::corp2::' + pIndexVersion + '::corp::bdid');
	kKeyCorp2__corp__bdid_pl						:=	index(dKeyCorp2__corp__bdid_pl, {bdid}, {dKeyCorp2__corp__bdid_pl}, '~prte::key::corp2::' + pIndexVersion + '::corp::bdid.p1');
	kKeyCorp2__corp__corp_key_record_type						:=	index(dKeyCorp2__corp__corp_key_record_type, {corp_key,record_type}, {dKeyCorp2__corp__corp_key_record_type}, '~prte::key::corp2::' + pIndexVersion + '::corp::corp_key.record_type');
	kKeyCorp2__corp__st_charter_number						:=	index(dKeyCorp2__corp__st_charter_number, {corp_state_origin,corp_sos_charter_nbr}, {dKeyCorp2__corp__st_charter_number}, '~prte::key::corp2::' + pIndexVersion + '::corp::st.charter_number');
	kKeyCorp2__event__corp_key_record_type						:=	index(dKeyCorp2__event__corp_key_record_type, {corp_key,record_type}, {dKeyCorp2__event__corp_key_record_type}, '~prte::key::corp2::' + pIndexVersion + '::event::corp_key.record_type');
	kKeyCorp2__stock__corp_key_record_type						:=	index(dKeyCorp2__stock__corp_key_record_type, {corp_key,record_type}, {dKeyCorp2__stock__corp_key_record_type}, '~prte::key::corp2::' + pIndexVersion + '::stock::corp_key.record_type');

	return	sequential(
											parallel(																
																build(kKeyCorp2__ar__corp_key_record_type			, update),
																build(kKeyCorp2__autokey__address			, update),
																build(kKeyCorp2__autokey__addressb2		, update),
																build(kKeyCorp2__autokey__citystname	, update),
																build(kKeyCorp2__autokey__citystnameb2, update),																
																build(kKeyCorp2__autokey__fein2, update),
																build(kKeyCorp2__autokey__name				, update),
																build(kKeyCorp2__autokey__nameb2			, update),
																build(kKeyCorp2__autokey__namewords2	, update),
																build(kKeyCorp2__autokey__payload			, update),																																
																build(kKeyCorp2__autokey__phone2			, update),
																build(kKeyCorp2__autokey__phoneb2			, update),																
																build(kKeyCorp2__autokey__ssn2			, update),
																build(kKeyCorp2__autokey__stname			, update),
																build(kKeyCorp2__autokey__stnameb2		, update),
																build(kKeyCorp2__autokey__zip					, update),
																build(kKeyCorp2__autokey__zipb2				, update),																
																build(kKeyCorp2__cont__corp_key_record_type				    	, update),
																build(kKeyCorp2__cont__did						    	, update),
																build(kKeyCorp2__corp__bdid						    	, update),
																build(kKeyCorp2__corp__bdid_pl						    	, update),
																build(kKeyCorp2__corp__corp_key_record_type						    	, update),
																build(kKeyCorp2__corp__st_charter_number						    	, update),
																build(kKeyCorp2__event__corp_key_record_type						    	, update),
																build(kKeyCorp2__stock__corp_key_record_type				    	, update)																																															
															 ),
											PRTE.UpdateVersion('Corp2Keys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
