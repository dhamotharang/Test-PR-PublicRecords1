import	_control, PRTE_CSV;

export	Proc_Build_NOD_Keys(string pIndexVersion)	:=
function

	rKeyNOD__autokey__address	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__address;
	end;
	
	rKeyNOD__autokey__addressb2	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__addressb2;
	end;
	
	rKeyNOD__autokey__citystname	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__citystname;
	end;	
	
	rKeyNOD__autokey__citystnameb2	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__citystnameb2;
	end;

	rKeyNOD__autokey__name	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__name;
	end;	
	
	rKeyNOD__autokey__nameb2	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__nameb2;
	end;		
	
	rKeyNOD__autokey__namewords2	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__namewords2;
	end;
	
	rKeyNOD__autokey__payload	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__payload;
	end;				
	
	rKeyNOD__autokey__ssn2	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__ssn2;
	end;		
	
	rKeyNOD__autokey__stname	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__stname;
	end;	
	
	rKeyNOD__autokey__stnameb2	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__stnameb2;
	end;
	
	rKeyNOD__autokey__zip	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__zip;
	end;	
	
	rKeyNOD__autokey__zipb2	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__autokey__zipb2;
	end;	
	
	rKeyNOD__bdid	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__bdid;
	end;	
	
	rKeyNOD__did	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__did;
	end;
	
	rKeyNOD__fid	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__fid;
	end;	

	rKeyNOD__fid__linkids	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__fid__linkids;
	end;	

	rKeyNOD__linkids	:=
	record
		PRTE_CSV.NOD.rthor_data400__key__nod__linkids;
	end;	
	
	dKeyNOD__autokey__address				:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__address, rKeyNOD__autokey__address);	
	dKeyNOD__autokey__addressb2			:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__addressb2, rKeyNOD__autokey__addressb2);	
	dKeyNOD__autokey__citystname		:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__citystname, rKeyNOD__autokey__citystname);
	dKeyNOD__autokey__citystnameb2	:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__citystnameb2, rKeyNOD__autokey__citystnameb2);
	dKeyNOD__autokey__name					:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__name, rKeyNOD__autokey__name);
	dKeyNOD__autokey__nameb2				:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__nameb2, rKeyNOD__autokey__nameb2);
	dKeyNOD__autokey__namewords2		:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__namewords2, rKeyNOD__autokey__namewords2);
	dKeyNOD__autokey__payload				:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__payload, rKeyNOD__autokey__payload);
	dKeyNOD__autokey__ssn2					:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__ssn2, rKeyNOD__autokey__ssn2);
	dKeyNOD__autokey__stname				:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__stname, rKeyNOD__autokey__stname);
	dKeyNOD__autokey__stnameb2			:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__stnameb2, rKeyNOD__autokey__stnameb2);
	dKeyNOD__autokey__zip						:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__zip, rKeyNOD__autokey__zip);
	dKeyNOD__autokey__zipb2					:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__autokey__zipb2, rKeyNOD__autokey__zipb2);
	dKeyNOD__bdid										:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__bdid, rKeyNOD__bdid);
	dKeyNOD__did										:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__did, rKeyNOD__did);
	dKeyNOD__fid										:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__fid, rKeyNOD__fid);
	dKeyNOD__fid__linkids						:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__fid__linkids, rKeyNOD__fid__linkids);
	dKeyNOD__linkids								:= 	project(PRTE_CSV.NOD.dthor_data400__key__nod__linkids, rKeyNOD__linkids);
	
	kKeyNOD__autokey__address				:=	index(dKeyNOD__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyNOD__autokey__address}, '~prte::key::nod::' + pIndexVersion + '::autokey::address');
	kKeyNOD__autokey__addressb2			:=	index(dKeyNOD__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyNOD__autokey__addressb2}, '~prte::key::nod::' + pIndexVersion + '::autokey::addressb2');
	kKeyNOD__autokey__citystname		:=	index(dKeyNOD__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyNOD__autokey__citystname}, '~prte::key::nod::' + pIndexVersion + '::autokey::citystname');
	kKeyNOD__autokey__citystnameb2	:=	index(dKeyNOD__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyNOD__autokey__citystnameb2}, '~prte::key::nod::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyNOD__autokey__name					:=	index(dKeyNOD__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyNOD__autokey__name}, '~prte::key::nod::' + pIndexVersion + '::autokey::name');
	kKeyNOD__autokey__nameb2				:=	index(dKeyNOD__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyNOD__autokey__nameb2}, '~prte::key::nod::' + pIndexVersion + '::autokey::nameb2');
	kKeyNOD__autokey__namewords2		:=	index(dKeyNOD__autokey__namewords2, {word,state,seq,bdid}, {dKeyNOD__autokey__namewords2}, '~prte::key::nod::' + pIndexVersion + '::autokey::namewords2');
	kKeyNOD__autokey__payload				:=	index(dKeyNOD__autokey__payload, {fakeid}, {dKeyNOD__autokey__payload}, '~prte::key::nod::' + pIndexVersion + '::autokey::payload');	
	kKeyNOD__autokey__ssn2					:=	index(dKeyNOD__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyNOD__autokey__ssn2}, '~prte::key::nod::' + pIndexVersion + '::autokey::ssn2');
	kKeyNOD__autokey__stname				:=	index(dKeyNOD__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyNOD__autokey__stname}, '~prte::key::nod::' + pIndexVersion + '::autokey::stname');
	kKeyNOD__autokey__stnameb2			:=	index(dKeyNOD__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyNOD__autokey__stnameb2}, '~prte::key::nod::' + pIndexVersion + '::autokey::stnameb2');
	kKeyNOD__autokey__zip						:=	index(dKeyNOD__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyNOD__autokey__zip}, '~prte::key::nod::' + pIndexVersion + '::autokey::zip');
	kKeyNOD__autokey__zipb2					:=	index(dKeyNOD__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyNOD__autokey__zipb2}, '~prte::key::nod::' + pIndexVersion + '::autokey::zipb2');
	kKeyNOD__bdid										:=	index(dKeyNOD__bdid, {bdid}, {dKeyNOD__bdid}, '~prte::key::nod::' + pIndexVersion + '::bdid');
	kKeyNOD__did										:=	index(dKeyNOD__did, {did}, {dKeyNOD__did}, '~prte::key::nod::' + pIndexVersion + '::did');	
	kKeyNOD__fid										:=	index(dKeyNOD__fid, {fid}, {dKeyNOD__fid}, '~prte::key::nod::' + pIndexVersion + '::fid');
	kKeyNOD__fid__linkids						:=	index(dKeyNOD__fid__linkids, {fid}, {dKeyNOD__fid__linkids}, '~prte::key::nod::' + pIndexVersion + '::fid::linkids');
	kKeyNOD__linkids								:=	index(dKeyNOD__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyNOD__linkids}, '~prte::key::nod::' + pIndexVersion + '::linkids');

	
	return	sequential(
											parallel(
																build(kKeyNOD__autokey__address, update),
																build(kKeyNOD__autokey__addressb2, update),
																build(kKeyNOD__autokey__citystname, update),
																build(kKeyNOD__autokey__citystnameb2, update),
																build(kKeyNOD__autokey__name, update),
																build(kKeyNOD__autokey__nameb2, update),
																build(kKeyNOD__autokey__namewords2, update),
																build(kKeyNOD__autokey__payload, update),
																build(kKeyNOD__autokey__ssn2, update),
																build(kKeyNOD__autokey__stname, update),
																build(kKeyNOD__autokey__stnameb2, update),
																build(kKeyNOD__autokey__zip, update),
																build(kKeyNOD__autokey__zipb2, update),
																build(kKeyNOD__bdid, update),
																build(kKeyNOD__did, update),
																build(kKeyNOD__fid, update),
																build(kKeyNOD__fid__linkids, update),
																build(kKeyNOD__linkids, update)																
															 ),
											PRTE.UpdateVersion('ForeclosureKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;	