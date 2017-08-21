import	_control, PRTE_CSV;

export Proc_Build_FCC_Keys(string pIndexVersion)	:=

function 

  rKeyfcc__autokey__address				:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__address;
	end;
	dKeyfcc__autokey__address				:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__address, rKeyfcc__autokey__address);
  kKeyfcc__autokey__address				:=	index(dKeyfcc__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyfcc__autokey__address}, '~prte::key::fcc::' + pIndexVersion + '::autokey::address');

  rKeyfcc__autokey__addressb2			:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__addressb2;
	end;
	dKeyfcc__autokey__addressb2			:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__addressb2, rKeyfcc__autokey__addressb2);
	kKeyfcc__autokey__addressb2			:=	index(dKeyfcc__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyfcc__autokey__addressb2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::addressb2');

  rKeyfcc__autokey__citystname		:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__citystname;
	end;
	dKeyfcc__autokey__citystname		:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__citystname, rKeyfcc__autokey__citystname);
	kKeyfcc__autokey__citystname		:=	index(dKeyfcc__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyfcc__autokey__citystname}, '~prte::key::fcc::' + pIndexVersion + '::autokey::citystname');

  rKeyfcc__autokey__citystnameb2	:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__citystnameb2;
	end;
	dKeyfcc__autokey__citystnameb2	:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__citystnameb2, rKeyfcc__autokey__citystnameb2);
	kKeyfcc__autokey__citystnameb2	:=	index(dKeyfcc__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyfcc__autokey__citystnameb2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::citystnameb2');

	rKeyfcc__autokey__name					:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__name;
	end;
	dKeyfcc__autokey__name					:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__name, rKeyfcc__autokey__name);
  kKeyfcc__autokey__name					:=	index(dKeyfcc__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyfcc__autokey__name}, '~prte::key::fcc::' + pIndexVersion + '::autokey::name');

	rKeyfcc__autokey__nameb2				:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__nameb2;
	end;
	dKeyfcc__autokey__nameb2				:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__nameb2, rKeyfcc__autokey__nameb2);
	kKeyfcc__autokey__nameb2				:=	index(dKeyfcc__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyfcc__autokey__nameb2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::nameb2');

	rKeyfcc__autokey__namewords2		:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__namewords2;
	end;
	dKeyfcc__autokey__namewords2		:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__namewords2, rKeyfcc__autokey__namewords2);
	kKeyfcc__autokey__namewords2		:=	index(dKeyfcc__autokey__namewords2, {word,state,seq,bdid}, {dKeyfcc__autokey__namewords2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::namewords2');
	
	rKeyfcc__autokey__payload				:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__payload;
	end;
	dKeyfcc__autokey__payload				:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__payload, rKeyfcc__autokey__payload);
  kKeyfcc__autokey__payload				:=	index(dKeyfcc__autokey__payload, {fakeid}, {dKeyfcc__autokey__payload}, '~prte::key::fcc::' + pIndexVersion + '::autokey::payload');

	rKeyfcc__autokey__phone2				:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__phone2;
	end;
	dKeyfcc__autokey__phone2				:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__phone2, rKeyfcc__autokey__phone2);
	kKeyfcc__autokey__phone2				:=	index(dKeyfcc__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyfcc__autokey__phone2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::phone2');

	rKeyfcc__autokey__phoneb2				:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__phoneb2;
	end;
	dKeyfcc__autokey__phoneb2				:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__phoneb2, rKeyfcc__autokey__phoneb2);
	kKeyfcc__autokey__phoneb2				:=	index(dKeyfcc__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyfcc__autokey__phoneb2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::phoneb2');

	rKeyfcc__autokey__stname				:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__stname;
	end;
	dKeyfcc__autokey__stname				:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__stname, rKeyfcc__autokey__stname);
	kKeyfcc__autokey__stname				:=	index(dKeyfcc__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyfcc__autokey__stname}, '~prte::key::fcc::' + pIndexVersion + '::autokey::stname');

	rKeyfcc__autokey__stnameb2			:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__stnameb2;
	end;
	dKeyfcc__autokey__stnameb2			:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__stnameb2, rKeyfcc__autokey__stnameb2);
	kKeyfcc__autokey__stnameb2			:=	index(dKeyfcc__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyfcc__autokey__stnameb2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::stnameb2');

	rKeyfcc__autokey__zip						:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__zip;
	end;
	dKeyfcc__autokey__zip						:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__zip, rKeyfcc__autokey__zip);
	kKeyfcc__autokey__zip						:=	index(dKeyfcc__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyfcc__autokey__zip}, '~prte::key::fcc::' + pIndexVersion + '::autokey::zip');

	rKeyfcc__autokey__zipb2					:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__autokey__zipb2;
	end;
	dKeyfcc__autokey__zipb2					:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__autokey__zipb2, rKeyfcc__autokey__zipb2);
	kKeyfcc__autokey__zipb2					:=	index(dKeyfcc__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyfcc__autokey__zipb2}, '~prte::key::fcc::' + pIndexVersion + '::autokey::zipb2');

	rKeyfcc__bdid										:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__bdid;
	end;
	dKeyfcc__bdid										:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__bdid, rKeyfcc__bdid);
	kKeyfcc__bdid										:=	index(dKeyfcc__bdid, {bdid}, {dKeyfcc__bdid}, '~prte::key::fcc::' + pIndexVersion + '::bdid');

	rKeyfcc__dictindx3							:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__dictindx3;
	end;
	dKeyfcc__dictindx3							:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__dictindx3, rKeyfcc__dictindx3);
	kKeyfcc__dictindx3							:=	index(dKeyfcc__dictindx3, {word,nominal,suffix,freq,docfreq}, {dKeyfcc__dictindx3}, '~prte::key::fcc::' + pIndexVersion + '::dictindx3');

	rKeyfcc__did	:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__did;
	end;
	dKeyfcc__did										:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__did, rKeyfcc__did);
	kKeyfcc__did										:=	index(dKeyfcc__did, {did}, {dKeyfcc__did}, '~prte::key::fcc::' + pIndexVersion + '::did');

	rKeyfcc__docref									:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__docref;
	end;
	dKeyfcc__docref									:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__docref, rKeyfcc__docref);
	kKeyfcc__docref									:=	index(dKeyfcc__docref, {src}, {dKeyfcc__docref}, '~prte::key::fcc::' + pIndexVersion + '::docref');

	rKeyfcc__dtldictx								:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__dtldictx;
	end;
	dKeyfcc__dtldictx								:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__dtldictx, rKeyfcc__dtldictx);
	kKeyfcc__dtldictx								:=	index(dKeyfcc__dtldictx, {word,nominal,suffix,freq,docfreq}, {dKeyfcc__dtldictx}, '~prte::key::fcc::' + pIndexVersion + '::dtldictx');

	rKeyfcc__exkeyi									:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__exkeyi;
	end;
	dKeyfcc__exkeyi									:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__exkeyi, rKeyfcc__exkeyi);
	kKeyfcc__exkeyi									:=	index(dKeyfcc__exkeyi, {hashkey,part,src,doc}, {dKeyfcc__exkeyi}, '~prte::key::fcc::' + pIndexVersion + '::exkeyi');

	rKeyfcc__exkeyo									:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__exkeyo;
	end;
	dKeyfcc__exkeyo									:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__exkeyo, rKeyfcc__exkeyo);
	kKeyfcc__exkeyo									:=	index(dKeyfcc__exkeyo, {src,doc}, {dKeyfcc__exkeyo}, '~prte::key::fcc::' + pIndexVersion + '::exkeyo');
	
	rKeyfcc__linkids								:=
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__linkids;
	end;
	dKeyfcc__linkids								:= 	project(PRTE_CSV.fcc.dthor_data400__key__fcc__linkids, rKeyfcc__linkids);
	kKeyfcc__linkids								:=	index(dKeyfcc__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyfcc__linkids}, '~prte::key::fcc::' + pIndexVersion + '::linkids');

	rKeyfcc__nidx3 									:= 
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__nidx3;
	end;	
	dKeyfcc__nidx3 									:= project(PRTE_CSV.fcc.dthor_data400__key__fcc__nidx3,rKeyfcc__nidx3);
	kKeyfcc__nidx3 									:= index(dKeyfcc__nidx3, {typ,nominal,lseg,part,src,doc,seg,kwp,wip,suffix}, {dKeyfcc__nidx3}, '~prte::key::fcc::'+ pIndexVersion +'::nidx3');

	rKeyfcc__seq 										:= 
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__seq;
	end;	
	dKeyfcc__seq 										:= project(PRTE_CSV.fcc.dthor_data400__key__fcc__seq,rKeyfcc__seq);
	kKeyfcc__seq 										:= index(dKeyfcc__seq, {fcc_seq}, {dKeyfcc__seq},'~prte::key::fcc::'+ pIndexVersion +'::seq');

	rKeyfcc__xdstat2 								:= 
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__xdstat2;
	end;	
	dKeyfcc__xdstat2 								:= project(PRTE_CSV.fcc.dthor_data400__key__fcc__xdstat2,rKeyfcc__xdstat2);
	kKeyfcc__xdstat2 								:= index(dKeyfcc__xdstat2, {f}, {dKeyfcc__xdstat2}, '~prte::key::fcc::'+ pIndexVersion +'::xdstat2');
	
	rKeyfcc_xseglist 								:= 
	record
		PRTE_CSV.fcc.rthor_data400__key__fcc__xseglist;
	end;
	dKeyfcc__xseglist 							:= project(PRTE_CSV.fcc.dthor_data400__key__fcc__xseglist,rKeyfcc_xseglist);
	kKeyfcc__xseglist 							:= index(dKeyfcc__xseglist, {f}, {dKeyfcc__xseglist}, '~prte::key::fcc::'+ pIndexVersion +'::xseglist');

return	sequential(
											parallel(
																build(kKeyfcc__autokey__address				, update),
																build(kKeyfcc__autokey__addressb2			, update),
																build(kKeyfcc__autokey__citystname		, update),
																build(kKeyfcc__autokey__citystnameb2	, update),																
																build(kKeyfcc__autokey__name					, update),
																build(kKeyfcc__autokey__nameb2				, update),
																build(kKeyfcc__autokey__namewords2		, update),
																build(kKeyfcc__autokey__payload				, update),
																build(kKeyfcc__autokey__phone2				, update),
																build(kKeyfcc__autokey__phoneb2				, update),
																build(kKeyfcc__autokey__stname				, update),
																build(kKeyfcc__autokey__stnameb2			, update),
																build(kKeyfcc__autokey__zip						, update),
																build(kKeyfcc__autokey__zipb2					, update),
																build(kKeyfcc__bdid										, update),
																build(kKeyfcc__dictindx3							, update),
																build(kKeyfcc__did										, update),																
																build(kKeyfcc__docref									, update),
																build(kKeyfcc__dtldictx								, update),
																build(kKeyfcc__exkeyi									, update),
																build(kKeyfcc__exkeyo									, update),
																build(kKeyfcc__linkids								, update),																		
																build(kKeyfcc__nidx3									, update),																
																build(kKeyfcc__seq										, update),	
																build(kKeyfcc__xdstat2								, update),																	
																build(kKeyfcc__xseglist								, update)																
					 ),
											PRTE.UpdateVersion('FCCKeys',														//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
