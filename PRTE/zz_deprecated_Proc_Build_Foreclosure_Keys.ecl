/*
2014-08-19 - (BPetro) - renamed for deprecation and note added
... please use PRTE2_Foreclosure.BWR_Build_Foreclosure for future builds.

*/
import	_control, PRTE_CSV;

export	Proc_Build_Foreclosure_Keys(string pIndexVersion)	:=
function


	rKeyForeclosure__autokey__address	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__address;
	end;
	
	rKeyForeclosure__autokey__addressb2	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__addressb2;
	end;
	
	rKeyForeclosure__autokey__citystname	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__citystname;
	end;
	
	rKeyForeclosure__autokey__citystnameb2	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__citystnameb2;
	end;	
	
	rKeyForeclosure__autokey__name	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__name;
	end;

	rKeyForeclosure__autokey__nameb2	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__nameb2;
	end;

	rKeyForeclosure__autokey__namewords2	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__namewords2;
	end;
	
	rKeyForeclosure__autokey__payload	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__payload;
	end;
	
	rKeyForeclosure__autokey__ssn2	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__ssn2;
	end;
	
	rKeyForeclosure__autokey__stname	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__stname;
	end;
	
	rKeyForeclosure__autokey__stnameb2	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__stnameb2;
	end;
	
	rKeyForeclosure__autokey__zip	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__zip;
	end;	
	
	rKeyForeclosure__autokey__zipb2	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__autokey__zipb2;
	end;
	
	rKeyForeclosure__address := 
	record
 		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__address;
	end;
	
	rKeyForeclosure__bdid	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__bdid;
	end;	
	
	rKeyForeclosure__did	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__did;
	end;		
	
	rKeyForeclosure__fid	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__fid;
	end;	
	
	rKeyForeclosure__linkids	:=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__linkids;
	end;	

	rKeyForeclosure__index_fips :=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__index_fips;
	end;

	rKeyForeclosure__index_geo11 :=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__index_geo11;
	end;

	rKeyForeclosure__index_geo12 :=
	record
		PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__index_geo12;
	end;

	dKeyForeclosure__autokey__address				:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__address, rKeyForeclosure__autokey__address);
	dKeyForeclosure__autokey__addressb2			:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__addressb2, rKeyForeclosure__autokey__addressb2);
	dKeyForeclosure__autokey__citystname		:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__citystname, rKeyForeclosure__autokey__citystname);
	dKeyForeclosure__autokey__citystnameb2	:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__citystnameb2, rKeyForeclosure__autokey__citystnameb2);
	dKeyForeclosure__autokey__name					:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__name, rKeyForeclosure__autokey__name);
	dKeyForeclosure__autokey__nameb2				:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__nameb2, rKeyForeclosure__autokey__nameb2);
	dKeyForeclosure__autokey__namewords2		:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__namewords2, rKeyForeclosure__autokey__namewords2);
	dKeyForeclosure__autokey__payload				:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__payload, rKeyForeclosure__autokey__payload);
	dKeyForeclosure__autokey__ssn2					:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__ssn2, rKeyForeclosure__autokey__ssn2);
	dKeyForeclosure__autokey__stname				:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__stname, rKeyForeclosure__autokey__stname);
	dKeyForeclosure__autokey__stnameb2			:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__stnameb2, rKeyForeclosure__autokey__stnameb2);
	dKeyForeclosure__autokey__zip						:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__zip, rKeyForeclosure__autokey__zip);
	dKeyForeclosure__autokey__zipb2					:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__zipb2, rKeyForeclosure__autokey__zipb2);
	dKeyForeclosure__bdid										:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__bdid, rKeyForeclosure__bdid);
	dKeyForeclosure__address								:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__address, rKeyForeclosure__address);
	dKeyForeclosure__did										:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__did, rKeyForeclosure__did);
	dKeyForeclosure__fid										:= 	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__fid, rKeyForeclosure__fid);
	dKeyForeclosure__linkids								:=  project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__linkids, rKeyForeclosure__linkids);
	dKeyForeclosure__index_fips							:=	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__index_fips, rKeyForeclosure__index_fips);
	dKeyForeclosure__index_geo11						:=	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__index_geo11, rKeyForeclosure__index_geo11);
	dKeyForeclosure__index_geo12						:=	project(PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__index_geo12, rKeyForeclosure__index_geo12);	

	kKeyForeclosure__autokey__address				:=	index(dKeyForeclosure__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyForeclosure__autokey__address}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::address');
	kKeyForeclosure__autokey__addressb2			:=	index(dKeyForeclosure__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyForeclosure__autokey__addressb2}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::addressb2');
	kKeyForeclosure__autokey__citystname		:=	index(dKeyForeclosure__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyForeclosure__autokey__citystname}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::citystname');
	kKeyForeclosure__autokey__citystnameb2	:=	index(dKeyForeclosure__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyForeclosure__autokey__citystnameb2}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyForeclosure__autokey__name					:=	index(dKeyForeclosure__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyForeclosure__autokey__name}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::name');
	kKeyForeclosure__autokey__nameb2				:=	index(dKeyForeclosure__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyForeclosure__autokey__nameb2}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::nameb2');
	kKeyForeclosure__autokey__namewords2		:=	index(dKeyForeclosure__autokey__namewords2, {word,state,seq,bdid}, {dKeyForeclosure__autokey__namewords2}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::namewords2');
	kKeyForeclosure__autokey__payload				:=	index(dKeyForeclosure__autokey__payload, {fakeid}, {dKeyForeclosure__autokey__payload}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::payload');		
	kKeyForeclosure__autokey__ssn2					:=	index(dKeyForeclosure__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyForeclosure__autokey__ssn2}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::ssn2');
	kKeyForeclosure__autokey__stname				:=	index(dKeyForeclosure__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyForeclosure__autokey__stname}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::stname');
	kKeyForeclosure__autokey__stnameb2			:=	index(dKeyForeclosure__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyForeclosure__autokey__stnameb2}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::stnameb2');
	kKeyForeclosure__autokey__zip						:=	index(dKeyForeclosure__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyForeclosure__autokey__zip}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::zip');
	kKeyForeclosure__autokey__zipb2					:=	index(dKeyForeclosure__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyForeclosure__autokey__zipb2}, '~prte::key::foreclosure::' + pIndexVersion + '::autokey::zipb2');	
	kKeyForeclosure__address								:=	index(dKeyForeclosure__address, {situs1_zip,situs1_prim_range,situs1_prim_name,situs1_addr_suffix,situs1_predir}, {dKeyForeclosure__address}, '~prte::key::foreclosure::' + pIndexVersion + '::address');		
	kKeyForeclosure__bdid										:=	index(dKeyForeclosure__bdid, {bdid}, {dKeyForeclosure__bdid}, '~prte::key::foreclosure::' + pIndexVersion + '::bdid');	
	kKeyForeclosure__did										:=	index(dKeyForeclosure__did, {did}, {dKeyForeclosure__did}, '~prte::key::foreclosure::' + pIndexVersion + '::did');	
	kKeyForeclosure__fid										:=	index(dKeyForeclosure__fid, {fid}, {dKeyForeclosure__fid}, '~prte::key::foreclosure::' + pIndexVersion + '::fid');	
	kKeyForeclosure__linkids		  					:=  index(dKeyForeclosure__linkids, {ultid,orgid,proxid,powid,empid,dotid,ultscore,orgscore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,proxweight,powweight,empweight,dotweight}, {dKeyForeclosure__linkids}, '~prte::key::foreclosure::' + pIndexVersion + '::linkids');	
	kKeyForeclosure__indexfips		 					:=  index(dKeyForeclosure__index_fips, {fips}, {dKeyForeclosure__index_fips}, '~prte::key::foreclosure::' + pIndexVersion + '::index_fips');	
	kKeyForeclosure__indexgeo11	 						:=  index(dKeyForeclosure__index_geo11, {geo11}, {dKeyForeclosure__index_geo11}, '~prte::key::foreclosure::' + pIndexVersion + '::index_geo11');	
	kKeyForeclosure__indexgeo12	 						:=  index(dKeyForeclosure__index_geo12, {geo12}, {dKeyForeclosure__index_geo12}, '~prte::key::foreclosure::' + pIndexVersion + '::index_geo12');	
	
	
	
	
	return	sequential(
											parallel(
																build(kKeyForeclosure__autokey__address, update),
																build(kKeyForeclosure__autokey__addressb2, update),
																build(kKeyForeclosure__autokey__citystname, update),
																build(kKeyForeclosure__autokey__citystnameb2, update),
																build(kKeyForeclosure__autokey__name, update),
																build(kKeyForeclosure__autokey__nameb2, update),
																build(kKeyForeclosure__autokey__namewords2, update),
																build(kKeyForeclosure__autokey__payload, update),
																build(kKeyForeclosure__autokey__ssn2, update),
																build(kKeyForeclosure__autokey__stname, update),
																build(kKeyForeclosure__autokey__stnameb2, update),
																build(kKeyForeclosure__autokey__zip, update),
																build(kKeyForeclosure__autokey__zipb2, update),
																build(kKeyForeclosure__address, update),
																build(kKeyForeclosure__bdid, update),
																build(kKeyForeclosure__did, update),
																build(kKeyForeclosure__fid, update),
																build(kKeyForeclosure__linkids, update),																
																build(kKeyForeclosure__indexfips, update),	
																build(kKeyForeclosure__indexgeo11, update),	
																build(kKeyForeclosure__indexgeo12, update)																																	
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