import	_control, PRTE_CSV;

export Proc_Build_Civil_Court_Keys(string pIndexVersion) := function
	
	rKeyCivil_Court__autokey__address	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__address;
	end;

	rKeyCivil_Court__autokey__addressb2	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__addressb2;
	end;

	rKeyCivil_Court__autokey__citystname	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__citystname;
	end;

	rKeyCivil_Court__autokey__citystnameb2	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__citystnameb2;
	end;	

	rKeyCivil_Court__autokey__name	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__name;
	end;

	rKeyCivil_Court__autokey__nameb2	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__nameb2;
	end;

	rKeyCivil_Court__autokey__namewords2	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__namewords2;
	end;

	rKeyCivil_Court__autokey__payload	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__payload;
	end;
	
	rKeyCivil_Court__autokey__stname	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__stname;
	end;

	rKeyCivil_Court__autokey__stnameb2	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__stnameb2;
	end;

	rKeyCivil_Court__autokey__zip	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__zip;
	end;

	rKeyCivil_Court__autokey__zipb2	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court__autokey__zipb2;
	end;

	rKeyCivil_Court_Case_Activity__caseid	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court_Case_Activity__caseid;
	end;

	rKeyCivil_Court_Matter__caseid	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court_Matter__caseid;
	end;
		
	rKeyCivil_Court_Party__caseid	:=
	record
		PRTE_CSV.Civil_Court.rthor_data400__key__Civil_Court_Party__caseid;
	end;
		
	dKeyCivil_Court__autokey__address			:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__address, rKeyCivil_Court__autokey__address);
	dKeyCivil_Court__autokey__addressb2		:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__addressb2, rKeyCivil_Court__autokey__addressb2);
	dKeyCivil_Court__autokey__citystname		:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__citystname, rKeyCivil_Court__autokey__citystname);
	dKeyCivil_Court__autokey__citystnameb2	:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__citystnameb2, rKeyCivil_Court__autokey__citystnameb2);	
	dKeyCivil_Court__autokey__name					:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__name, rKeyCivil_Court__autokey__name);
	dKeyCivil_Court__autokey__nameb2				:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__nameb2, rKeyCivil_Court__autokey__nameb2);
	dKeyCivil_Court__autokey__namewords2		:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__namewords2, rKeyCivil_Court__autokey__namewords2);	
	dKeyCivil_Court__autokey__payload			:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__payload, rKeyCivil_Court__autokey__payload);		
	dKeyCivil_Court__autokey__stname				:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__stname, rKeyCivil_Court__autokey__stname);
	dKeyCivil_Court__autokey__stnameb2			:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__stnameb2, rKeyCivil_Court__autokey__stnameb2);
	dKeyCivil_Court__autokey__zip					:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__zip, rKeyCivil_Court__autokey__zip);
	dKeyCivil_Court__autokey__zipb2				:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court__autokey__zipb2, rKeyCivil_Court__autokey__zipb2);
	dKeyCivil_Court_Case_Activity__caseid				:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court_Case_Activity__caseid, rKeyCivil_Court_Case_Activity__caseid);	
	dKeyCivil_Court_Matter__caseid					:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court_Matter__caseid, rKeyCivil_Court_Matter__caseid);	
	dKeyCivil_Court_Party__caseid					:= 	project(PRTE_CSV.Civil_Court.dthor_data400__key__Civil_Court_Party__caseid, rKeyCivil_Court_Party__caseid);	
	
	kKeyCivil_Court__autokey__address			:=	index(dKeyCivil_Court__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyCivil_Court__autokey__address}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::address');
	kKeyCivil_Court__autokey__addressb2		:=	index(dKeyCivil_Court__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyCivil_Court__autokey__addressb2}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::addressb2');
	kKeyCivil_Court__autokey__citystname		:=	index(dKeyCivil_Court__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCivil_Court__autokey__citystname}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::citystname');
	kKeyCivil_Court__autokey__citystnameb2	:=	index(dKeyCivil_Court__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyCivil_Court__autokey__citystnameb2}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyCivil_Court__autokey__name					:=	index(dKeyCivil_Court__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCivil_Court__autokey__name}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::name');
	kKeyCivil_Court__autokey__nameb2				:=	index(dKeyCivil_Court__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyCivil_Court__autokey__nameb2}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::nameb2');
	kKeyCivil_Court__autokey__namewords2		:=	index(dKeyCivil_Court__autokey__namewords2, {word,state,seq,bdid}, {dKeyCivil_Court__autokey__namewords2}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::namewords2');
	kKeyCivil_Court__autokey__payload			:=	index(dKeyCivil_Court__autokey__payload, {fakeid}, {dKeyCivil_Court__autokey__payload}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::payload');	
	kKeyCivil_Court__autokey__stname				:=	index(dKeyCivil_Court__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCivil_Court__autokey__stname}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::stname');
	kKeyCivil_Court__autokey__stnameb2			:=	index(dKeyCivil_Court__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyCivil_Court__autokey__stnameb2}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::stnameb2');
	kKeyCivil_Court__autokey__zip					:=	index(dKeyCivil_Court__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCivil_Court__autokey__zip}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::zip');
	kKeyCivil_Court__autokey__zipb2				:=	index(dKeyCivil_Court__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyCivil_Court__autokey__zipb2}, '~prte::key::civil_court::' + pIndexVersion + '::autokey::zipb2');
	kKeyCivil_Court_Case_Activity__caseid						:=	index(dKeyCivil_Court_Case_Activity__caseid, {case_key}, {dKeyCivil_Court_Case_Activity__caseid}, '~prte::key::civil_court_case_activity::' + pIndexVersion + '::caseid');
	kKeyCivil_Court_Matter__caseid						:=	index(dKeyCivil_Court_Matter__caseid, {case_key}, {dKeyCivil_Court_Matter__caseid}, '~prte::key::civil_court_matter::' + pIndexVersion + '::caseid');
	kKeyCivil_Court_Party__caseid						:=	index(dKeyCivil_Court_Party__caseid, {case_key}, {dKeyCivil_Court_Party__caseid}, '~prte::key::civil_court_party::' + pIndexVersion + '::caseid');

	return	sequential(
											parallel(																
																build(kKeyCivil_Court__autokey__address			, update),
																build(kKeyCivil_Court__autokey__addressb2		, update),
																build(kKeyCivil_Court__autokey__citystname	, update),
																build(kKeyCivil_Court__autokey__citystnameb2, update),																
																build(kKeyCivil_Court__autokey__name				, update),
																build(kKeyCivil_Court__autokey__nameb2			, update),
																build(kKeyCivil_Court__autokey__namewords2	, update),
																build(kKeyCivil_Court__autokey__payload			, update),																																
																build(kKeyCivil_Court__autokey__stname			, update),
																build(kKeyCivil_Court__autokey__stnameb2		, update),
																build(kKeyCivil_Court__autokey__zip					, update),
																build(kKeyCivil_Court__autokey__zipb2				, update),
																build(kKeyCivil_Court_Case_Activity__caseid					    		, update),																
																build(kKeyCivil_Court_Matter__caseid						    	, update),
																build(kKeyCivil_Court_Party__caseid						    	, update)													
																																																
															 ),
											PRTE.UpdateVersion('CivilCourtKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
