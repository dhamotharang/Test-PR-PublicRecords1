import	_control, PRTE_CSV;

export Proc_Build_Official_Records_Keys(string pIndexVersion) := function
	
	rKeyOfficial_Records__autokey__address	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__address;
	end;

	rKeyOfficial_Records__autokey__addressb2	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__addressb2;
	end;

	rKeyOfficial_Records__autokey__citystname	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__citystname;
	end;

	rKeyOfficial_Records__autokey__citystnameb2	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__citystnameb2;
	end;	

	rKeyOfficial_Records__autokey__name	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__name;
	end;

	rKeyOfficial_Records__autokey__nameb2	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__nameb2;
	end;

	rKeyOfficial_Records__autokey__namewords2	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__namewords2;
	end;

	rKeyOfficial_Records__autokey__payload	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__payload;
	end;
	
	rKeyOfficial_Records__autokey__stname	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__stname;
	end;

	rKeyOfficial_Records__autokey__stnameb2	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__stnameb2;
	end;

	rKeyOfficial_Records__autokey__zip	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__zip;
	end;

	rKeyOfficial_Records__autokey__zipb2	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records__autokey__zipb2;
	end;

	rKeyOfficial_Records_Document__orid	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records_Document__orid;
	end;

	rKeyOfficial_Records_Party__orid	:=
	record
		PRTE_CSV.Official_Records.rthor_200__key__Official_Records_Party__orid;
	end;
		
	dKeyOfficial_Records__autokey__address			:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__address, rKeyOfficial_Records__autokey__address);
	dKeyOfficial_Records__autokey__addressb2		:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__addressb2, rKeyOfficial_Records__autokey__addressb2);
	dKeyOfficial_Records__autokey__citystname		:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__citystname, rKeyOfficial_Records__autokey__citystname);
	dKeyOfficial_Records__autokey__citystnameb2	:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__citystnameb2, rKeyOfficial_Records__autokey__citystnameb2);	
	dKeyOfficial_Records__autokey__name					:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__name, rKeyOfficial_Records__autokey__name);
	dKeyOfficial_Records__autokey__nameb2				:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__nameb2, rKeyOfficial_Records__autokey__nameb2);
	dKeyOfficial_Records__autokey__namewords2		:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__namewords2, rKeyOfficial_Records__autokey__namewords2);	
	dKeyOfficial_Records__autokey__payload			:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__payload, rKeyOfficial_Records__autokey__payload);		
	dKeyOfficial_Records__autokey__stname				:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__stname, rKeyOfficial_Records__autokey__stname);
	dKeyOfficial_Records__autokey__stnameb2			:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__stnameb2, rKeyOfficial_Records__autokey__stnameb2);
	dKeyOfficial_Records__autokey__zip					:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__zip, rKeyOfficial_Records__autokey__zip);
	dKeyOfficial_Records__autokey__zipb2				:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records__autokey__zipb2, rKeyOfficial_Records__autokey__zipb2);
	dKeyOfficial_Records_Document__orid				:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records_Document__orid, rKeyOfficial_Records_Document__orid);	
	dKeyOfficial_Records_Party__orid					:= 	project(PRTE_CSV.Official_Records.dthor_200__key__Official_Records_Party__orid, rKeyOfficial_Records_Party__orid);	
	
	kKeyOfficial_Records__autokey__address			:=	index(dKeyOfficial_Records__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyOfficial_Records__autokey__address}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::address');
	kKeyOfficial_Records__autokey__addressb2		:=	index(dKeyOfficial_Records__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyOfficial_Records__autokey__addressb2}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::addressb2');
	kKeyOfficial_Records__autokey__citystname		:=	index(dKeyOfficial_Records__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyOfficial_Records__autokey__citystname}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::citystname');
	kKeyOfficial_Records__autokey__citystnameb2	:=	index(dKeyOfficial_Records__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyOfficial_Records__autokey__citystnameb2}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyOfficial_Records__autokey__name					:=	index(dKeyOfficial_Records__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyOfficial_Records__autokey__name}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::name');
	kKeyOfficial_Records__autokey__nameb2				:=	index(dKeyOfficial_Records__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyOfficial_Records__autokey__nameb2}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::nameb2');
	kKeyOfficial_Records__autokey__namewords2		:=	index(dKeyOfficial_Records__autokey__namewords2, {word,state,seq,bdid}, {dKeyOfficial_Records__autokey__namewords2}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::namewords2');
	kKeyOfficial_Records__autokey__payload			:=	index(dKeyOfficial_Records__autokey__payload, {fakeid}, {dKeyOfficial_Records__autokey__payload}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::payload');	
	kKeyOfficial_Records__autokey__stname				:=	index(dKeyOfficial_Records__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyOfficial_Records__autokey__stname}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::stname');
	kKeyOfficial_Records__autokey__stnameb2			:=	index(dKeyOfficial_Records__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyOfficial_Records__autokey__stnameb2}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::stnameb2');
	kKeyOfficial_Records__autokey__zip					:=	index(dKeyOfficial_Records__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyOfficial_Records__autokey__zip}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::zip');
	kKeyOfficial_Records__autokey__zipb2				:=	index(dKeyOfficial_Records__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyOfficial_Records__autokey__zipb2}, '~prte::key::Official_Records::' + pIndexVersion + '::autokey::zipb2');
	kKeyOfficial_Records_Document__orid						:=	index(dKeyOfficial_Records_Document__orid, {official_record_key}, {dKeyOfficial_Records_Document__orid}, '~prte::key::Official_Records_Document::' + pIndexVersion + '::orid');
	kKeyOfficial_Records_Party__orid						:=	index(dKeyOfficial_Records_Party__orid, {official_record_key}, {dKeyOfficial_Records_Party__orid}, '~prte::key::Official_Records_Party::' + pIndexVersion + '::orid');

	return	sequential(
											parallel(																
																build(kKeyOfficial_Records__autokey__address			, update),
																build(kKeyOfficial_Records__autokey__addressb2		, update),
																build(kKeyOfficial_Records__autokey__citystname	, update),
																build(kKeyOfficial_Records__autokey__citystnameb2, update),																
																build(kKeyOfficial_Records__autokey__name				, update),
																build(kKeyOfficial_Records__autokey__nameb2			, update),
																build(kKeyOfficial_Records__autokey__namewords2	, update),
																build(kKeyOfficial_Records__autokey__payload			, update),																																
																build(kKeyOfficial_Records__autokey__stname			, update),
																build(kKeyOfficial_Records__autokey__stnameb2		, update),
																build(kKeyOfficial_Records__autokey__zip					, update),
																build(kKeyOfficial_Records__autokey__zipb2				, update),
																build(kKeyOfficial_Records_Document__orid					    		, update),																
																build(kKeyOfficial_Records_Party__orid						    	, update)
																																																
															 ),
											PRTE.UpdateVersion('OfficialRecordsKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
