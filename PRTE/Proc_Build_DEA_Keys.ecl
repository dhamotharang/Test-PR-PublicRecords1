import	_control, PRTE_CSV;

export Proc_Build_DEA_Keys(string pIndexVersion) := function
	
	rKeyDEA__autokey__address	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__address;
	end;

	rKeyDEA__autokey__addressb2	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__addressb2;
	end;

	rKeyDEA__autokey__citystname	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__citystname;
	end;

	rKeyDEA__autokey__citystnameb2	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__citystnameb2;
	end;	

	rKeyDEA__autokey__name	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__name;
	end;

	rKeyDEA__autokey__nameb2	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__nameb2;
	end;

	rKeyDEA__autokey__namewords2	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__namewords2;
	end;

	rKeyDEA__autokey__payload	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__payload;
	end;
	
	rKeyDEA__autokey__ssn2	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__ssn2;
	end;
	
	rKeyDEA__autokey__stname	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__stname;
	end;

	rKeyDEA__autokey__stnameb2	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__stnameb2;
	end;

	rKeyDEA__autokey__zip	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__zip;
	end;

	rKeyDEA__autokey__zipb2	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__autokey__zipb2;
	end;	

	rKeyDEA__bdid	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__bdid;
	end;
		
	rKeyDEA__did	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__did;
	end;
		
		
	rKeyDEA__reg_num	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__DEA__reg_num;
	end;		
		
	rKeyDEA__linkids	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__dea__linkids;
	end;		

	rKeyDEA__lnpid	:=
	record
		PRTE_CSV.DEA.rthor_data400__key__dea__lnpid;
	end;		

	dKeyDEA__autokey__address			  := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__address, rKeyDEA__autokey__address);
	dKeyDEA__autokey__addressb2		  := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__addressb2, rKeyDEA__autokey__addressb2);
	dKeyDEA__autokey__citystname		:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__citystname, rKeyDEA__autokey__citystname);
	dKeyDEA__autokey__citystnameb2	:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__citystnameb2, rKeyDEA__autokey__citystnameb2);	
	dKeyDEA__autokey__name					:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__name, rKeyDEA__autokey__name);
	dKeyDEA__autokey__nameb2				:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__nameb2, rKeyDEA__autokey__nameb2);
	dKeyDEA__autokey__namewords2		:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__namewords2, rKeyDEA__autokey__namewords2);	
	dKeyDEA__autokey__payload			  := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__payload, rKeyDEA__autokey__payload);		
	dKeyDEA__autokey__ssn2  				:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__ssn2, rKeyDEA__autokey__ssn2);
	dKeyDEA__autokey__stname				:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__stname, rKeyDEA__autokey__stname);
	dKeyDEA__autokey__stnameb2			:= 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__stnameb2, rKeyDEA__autokey__stnameb2);
	dKeyDEA__autokey__zip					  := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__zip, rKeyDEA__autokey__zip);
	dKeyDEA__autokey__zipb2				  := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__autokey__zipb2, rKeyDEA__autokey__zipb2);
	dKeyDEA__bdid					          := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__bdid, rKeyDEA__bdid);	
	dKeyDEA__did					          := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__did, rKeyDEA__did);	
	dKeyDEA__reg_num            	  := 	project(PRTE_CSV.DEA.dthor_data400__key__DEA__reg_num, rKeyDEA__reg_num);	
	dKeyDEA__linkids            	  := 	project(PRTE_CSV.DEA.dthor_data400__key__dea__linkids, rKeyDEA__linkids);	
	dKeyDEA__lnpid            	  	:= 	project(PRTE_CSV.DEA.dthor_data400__key__dea__lnpid, rKeyDEA__lnpid);	
	
	kKeyDEA__autokey__address			  :=	index(dKeyDEA__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyDEA__autokey__address}, '~prte::key::dea::' + pIndexVersion + '::autokey::address');
	kKeyDEA__autokey__addressb2		  :=	index(dKeyDEA__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyDEA__autokey__addressb2}, '~prte::key::dea::' + pIndexVersion + '::autokey::addressb2');
	kKeyDEA__autokey__citystname		:=	index(dKeyDEA__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDEA__autokey__citystname}, '~prte::key::dea::' + pIndexVersion + '::autokey::citystname');
	kKeyDEA__autokey__citystnameb2	:=	index(dKeyDEA__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyDEA__autokey__citystnameb2}, '~prte::key::dea::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyDEA__autokey__name					:=	index(dKeyDEA__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDEA__autokey__name}, '~prte::key::dea::' + pIndexVersion + '::autokey::name');
	kKeyDEA__autokey__nameb2				:=	index(dKeyDEA__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyDEA__autokey__nameb2}, '~prte::key::dea::' + pIndexVersion + '::autokey::nameb2');
	kKeyDEA__autokey__namewords2		:=	index(dKeyDEA__autokey__namewords2, {word,state,seq,bdid}, {dKeyDEA__autokey__namewords2}, '~prte::key::dea::' + pIndexVersion + '::autokey::namewords2');
	kKeyDEA__autokey__payload			  :=	index(dKeyDEA__autokey__payload, {fakeid}, {dKeyDEA__autokey__payload}, '~prte::key::dea::' + pIndexVersion + '::autokey::payload');	
	kKeyDEA__autokey__ssn2				  :=	index(dKeyDEA__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyDEA__autokey__ssn2}, '~prte::key::dea::' + pIndexVersion + '::autokey::ssn2');
	kKeyDEA__autokey__stname				:=	index(dKeyDEA__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDEA__autokey__stname}, '~prte::key::dea::' + pIndexVersion + '::autokey::stname');
	kKeyDEA__autokey__stnameb2			:=	index(dKeyDEA__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyDEA__autokey__stnameb2}, '~prte::key::dea::' + pIndexVersion + '::autokey::stnameb2');
	kKeyDEA__autokey__zip					  :=	index(dKeyDEA__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyDEA__autokey__zip}, '~prte::key::dea::' + pIndexVersion + '::autokey::zip');
	kKeyDEA__autokey__zipb2				  :=	index(dKeyDEA__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyDEA__autokey__zipb2}, '~prte::key::dea::' + pIndexVersion + '::autokey::zipb2');	
	kKeyDEA__bdid						        :=	index(dKeyDEA__bdid, {bd}, {dKeyDEA__bdid}, '~prte::key::dea::' + pIndexVersion + '::bdid');
	kKeyDEA__did						        :=	index(dKeyDEA__did, {my_did}, {dKeyDEA__did}, '~prte::key::dea::' + pIndexVersion + '::did');
	kKeyDEA__reg_num						    :=	index(dKeyDEA__reg_num, {dea_registration_number}, {dKeyDEA__reg_num}, '~prte::key::dea::' + pIndexVersion + '::reg_num');
	kKeyDEA__linkids						    :=	index(dKeyDEA__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dKeyDEA__linkids}, '~prte::key::dea::' + pIndexVersion + '::linkids');
	kKeyDEA__lnpid							    :=	index(dKeyDEA__lnpid, {lnpid}, {dKeyDEA__lnpid}, '~prte::key::dea::' + pIndexVersion + '::lnpid');

	return	sequential(
											parallel(																
																build(kKeyDEA__autokey__address			, update),
																build(kKeyDEA__autokey__addressb2		, update),
																build(kKeyDEA__autokey__citystname	, update),
																build(kKeyDEA__autokey__citystnameb2, update),																
																build(kKeyDEA__autokey__name				, update),
																build(kKeyDEA__autokey__nameb2			, update),
																build(kKeyDEA__autokey__namewords2	, update),
																build(kKeyDEA__autokey__payload			, update),																																
																build(kKeyDEA__autokey__stname			, update),
																build(kKeyDEA__autokey__ssn2			  , update),
																build(kKeyDEA__autokey__stnameb2		, update),
																build(kKeyDEA__autokey__zip					, update),
																build(kKeyDEA__autokey__zipb2				, update),																
																build(kKeyDEA__bdid				    	    , update),
																build(kKeyDEA__did						    	, update),
																build(kKeyDEA__reg_num				    	, update),																																															
																build(kKeyDEA__linkids				    	, update),
																build(kKeyDEA__lnpid					    	, update)
															 ),
											PRTE.UpdateVersion('DEAKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
