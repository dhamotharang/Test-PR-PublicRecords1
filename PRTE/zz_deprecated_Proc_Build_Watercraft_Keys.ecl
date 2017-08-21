/*2013-02-12T23:43:45Z (ayeesha_prod kayttala)
added fcra keys

2014-08-19 - (BPetro) - renamed for deprecation and note added
... please use PRTE2_WaterCraft.BWR_BuildMaster_Rebuild for future builds.

*/
import	_control, PRTE_CSV,watercraft, doxie, ut, fcra,data_services;

export	Proc_Build_Watercraft_Keys(string pIndexVersion)	:=
function

rKeyWatercraft__autokey__address	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__address;
	end;

	rKeyWatercraft__autokey__addressb2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__addressb2;
	end;

	rKeyWatercraft__autokey__citystname	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__citystname;
	end;

	rKeyWatercraft__autokey__citystnameb2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__citystnameb2;
	end;

	rKeyWatercraft__autokey__fein2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__fein2;
	end;

	rKeyWatercraft__autokey__name	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__name;
	end;

	rKeyWatercraft__autokey__nameb2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__nameb2;
	end;

	rKeyWatercraft__autokey__namewords2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__namewords2;
	end;

	rKeyWatercraft__autokey__payload	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__payload;
	end;

	rKeyWatercraft__autokey__phone2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__phone2;
	end;

	rKeyWatercraft__autokey__phoneb2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__phoneb2;
	end;

	rKeyWatercraft__autokey__ssn2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__ssn2;
	end;

	rKeyWatercraft__autokey__stname	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__stname;
	end;

	rKeyWatercraft__autokey__stnameb2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__stnameb2;
	end;

	rKeyWatercraft__autokey__zip	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__zip;
	end;

	rKeyWatercraft__autokey__zipb2	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__autokey__zipb2;
	end;

	rKeyWatercraft__bdid	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__bdid;
	end;

	rKeyWatercraft__cid	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__cid;
		unsigned8 persistent_record_id := 0 ; 
	end;

	rKeyWatercraft__did	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__did;
	end;

	rKeyWatercraft__hullnum	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__hullnum;
	end;

	rKeyWatercraft__sid	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__sid;
		unsigned8 persistent_record_id := 0 ; 
	end;

	rKeyWatercraft__vslnam	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__vslnam
	end;

	rKeyWatercraft__wid	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__wid;
		unsigned8 persistent_record_id := 0 ; 
	end;
	
	rKeyWatercraft__LinkIDs	:=
	record
		PRTE_CSV.Watercraft.rCSVWatercraft__LinkIDs;
	end;
	
	dKeyWatercraft__autokey__address			:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__address, rKeyWatercraft__autokey__address);
	dKeyWatercraft__autokey__addressb2		:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__addressb2, rKeyWatercraft__autokey__addressb2);
	dKeyWatercraft__autokey__citystname		:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__citystname, rKeyWatercraft__autokey__citystname);
	dKeyWatercraft__autokey__citystnameb2	:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__citystnameb2, rKeyWatercraft__autokey__citystnameb2);
	dKeyWatercraft__autokey__fein2				:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__fein2, rKeyWatercraft__autokey__fein2);
	dKeyWatercraft__autokey__name					:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__name, rKeyWatercraft__autokey__name);
	dKeyWatercraft__autokey__nameb2				:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__nameb2, rKeyWatercraft__autokey__nameb2);
	dKeyWatercraft__autokey__namewords2		:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__namewords2, rKeyWatercraft__autokey__namewords2);
	dKeyWatercraft__autokey__payload			:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__payload, rKeyWatercraft__autokey__payload);
	dKeyWatercraft__autokey__phone2				:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__phone2, rKeyWatercraft__autokey__phone2);
	dKeyWatercraft__autokey__phoneb2			:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__phoneb2, rKeyWatercraft__autokey__phoneb2);
	dKeyWatercraft__autokey__ssn2					:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__ssn2, rKeyWatercraft__autokey__ssn2);
	dKeyWatercraft__autokey__stname				:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__stname, rKeyWatercraft__autokey__stname);
	dKeyWatercraft__autokey__stnameb2			:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__stnameb2, rKeyWatercraft__autokey__stnameb2);
	dKeyWatercraft__autokey__zip					:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__zip, rKeyWatercraft__autokey__zip);
	dKeyWatercraft__autokey__zipb2				:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__autokey__zipb2, rKeyWatercraft__autokey__zipb2);
	dKeyWatercraft__bdid									:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__bdid, rKeyWatercraft__bdid);
	dKeyWatercraft__cid										:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__cid, transform(rKeyWatercraft__cid, self.hull_number := stringlib.stringtouppercase(left.hull_number), self:= left));
	dKeyWatercraft__did										:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__did, rKeyWatercraft__did);
	dKeyWatercraft__hullnum								:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__hullnum, transform(rKeyWatercraft__hullnum, self.hull_number := stringlib.stringtouppercase(left.hull_number), self:= left));
	dKeyWatercraft__sid										:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__sid, rKeyWatercraft__sid);
	dKeyWatercraft__vslnam								:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__vslnam, rKeyWatercraft__vslnam);
	dKeyWatercraft__wid										:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__wid,  transform(rKeyWatercraft__wid, self.hull_number := stringlib.stringtouppercase(left.hull_number), self:= left));
  dKeyWatercraft__LinkIDs								:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__LinkIDs, rKeyWatercraft__LinkIDs);
	
// FCRA 
states := fcra.compliance.watercrafts.restricted_states;
	dKeyWatercraft__wid_fcra										:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__wid(state_origin NOT IN states),  transform(rKeyWatercraft__wid, self.hull_number := stringlib.stringtouppercase(left.hull_number), self:= left));
	dKeyWatercraft__sid_fcra										:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__sid(state_origin NOT IN states), rKeyWatercraft__sid);
	dKeyWatercraft__cid_fcra									  := 	project(PRTE_CSV.Watercraft.dCSVWatercraft__cid(state_origin NOT IN states), transform(rKeyWatercraft__cid, self.hull_number := stringlib.stringtouppercase(left.hull_number), self:= left));
	dKeyWatercraft__did_fcra										:= 	project(PRTE_CSV.Watercraft.dCSVWatercraft__did(state_origin NOT IN states), rKeyWatercraft__did);

	kKeyWatercraft__autokey__address			:=	index(dKeyWatercraft__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyWatercraft__autokey__address}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::address');
	kKeyWatercraft__autokey__addressb2		:=	index(dKeyWatercraft__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyWatercraft__autokey__addressb2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::addressb2');
	kKeyWatercraft__autokey__citystname		:=	index(dKeyWatercraft__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyWatercraft__autokey__citystname}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::citystname');
	kKeyWatercraft__autokey__citystnameb2	:=	index(dKeyWatercraft__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyWatercraft__autokey__citystnameb2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyWatercraft__autokey__fein2				:=	index(dKeyWatercraft__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeyWatercraft__autokey__fein2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::fein2');
	kKeyWatercraft__autokey__name					:=	index(dKeyWatercraft__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyWatercraft__autokey__name}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::name');
	kKeyWatercraft__autokey__nameb2				:=	index(dKeyWatercraft__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyWatercraft__autokey__nameb2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::nameb2');
	kKeyWatercraft__autokey__namewords2		:=	index(dKeyWatercraft__autokey__namewords2, {word,state,seq,bdid}, {dKeyWatercraft__autokey__namewords2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::namewords2');
	kKeyWatercraft__autokey__payload			:=	index(dKeyWatercraft__autokey__payload, {fakeid}, {dKeyWatercraft__autokey__payload}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::payload');
	kKeyWatercraft__autokey__phone2				:=	index(dKeyWatercraft__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyWatercraft__autokey__phone2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::phone2');
	kKeyWatercraft__autokey__phoneb2			:=	index(dKeyWatercraft__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyWatercraft__autokey__phoneb2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::phoneb2');
	kKeyWatercraft__autokey__ssn2					:=	index(dKeyWatercraft__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyWatercraft__autokey__ssn2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::ssn2');
	kKeyWatercraft__autokey__stname				:=	index(dKeyWatercraft__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyWatercraft__autokey__stname}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::stname');
	kKeyWatercraft__autokey__stnameb2			:=	index(dKeyWatercraft__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyWatercraft__autokey__stnameb2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::stnameb2');
	kKeyWatercraft__autokey__zip					:=	index(dKeyWatercraft__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyWatercraft__autokey__zip}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::zip');
	kKeyWatercraft__autokey__zipb2				:=	index(dKeyWatercraft__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyWatercraft__autokey__zipb2}, '~prte::key::watercraft::' + pIndexVersion + '::autokey::zipb2');
	kKeyWatercraft__bdid									:=	index(dKeyWatercraft__bdid, {l_bdid}, {dKeyWatercraft__bdid}, '~prte::key::watercraft::' + pIndexVersion + '::bdid');
	kKeyWatercraft__cid										:=	index(dKeyWatercraft__cid, {state_origin,watercraft_key,sequence_key}, {dKeyWatercraft__cid}, '~prte::key::watercraft::' + pIndexVersion + '::cid');
	kKeyWatercraft__did										:=	index(dKeyWatercraft__did, {l_did}, {dKeyWatercraft__did}, '~prte::key::watercraft::' + pIndexVersion + '::did');
	kKeyWatercraft__hullnum								:=	index(dKeyWatercraft__hullnum, {hull_number}, {dKeyWatercraft__hullnum}, '~prte::key::watercraft::' + pIndexVersion + '::hullnum');
	kKeyWatercraft__sid										:=	index(dKeyWatercraft__sid, {state_origin,watercraft_key,sequence_key}, {dKeyWatercraft__sid}, '~prte::key::watercraft::' + pIndexVersion + '::sid');
	kKeyWatercraft__vslnam								:=	index(dKeyWatercraft__vslnam, {vessel_name}, {dKeyWatercraft__vslnam}, '~prte::key::watercraft::' + pIndexVersion + '::vslnam');
	kKeyWatercraft__wid										:=	index(dKeyWatercraft__wid, {state_origin,watercraft_key,sequence_key}, {dKeyWatercraft__wid}, '~prte::key::watercraft::' + pIndexVersion + '::wid');
  kKeyWatercraft__LinkIDs								:=	index(dKeyWatercraft__LinkIDs,{ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, {dKeyWatercraft__LinkIDs}, '~prte::key::watercraft::' + pIndexVersion + '::linkids');
  
  kKeyWatercraft__sid_fcra										:=	index(dKeyWatercraft__sid_fcra, {state_origin,watercraft_key,sequence_key}, {dKeyWatercraft__sid_fcra}, '~prte::key::watercraft::fcra::' + pIndexVersion + '::sid');
	kKeyWatercraft__wid_fcra									  :=	index(dKeyWatercraft__wid_fcra, {state_origin,watercraft_key,sequence_key}, {dKeyWatercraft__wid_fcra}, '~prte::key::watercraft::fcra::' + pIndexVersion + '::wid');
	kKeyWatercraft__cid_fcra									  :=	index(dKeyWatercraft__cid_fcra, {state_origin,watercraft_key,sequence_key}, {dKeyWatercraft__cid_fcra}, '~prte::key::watercraft::fcra::' + pIndexVersion + '::cid');
	kKeyWatercraft__did_fcra										:=	index(dKeyWatercraft__did_fcra, {l_did}, {dKeyWatercraft__did_fcra}, '~prte::key::watercraft::fcra::' + pIndexVersion + '::did');
  
 
	
	
	arecord7:= 
RECORD
  string10 official_number;
  string2 state_origin;
  string30 watercraft_key;
  string30 sequence_key;
  unsigned8 __internal_fpos__;
 END;
	return	sequential(
											parallel(
																build(kKeyWatercraft__autokey__address			, update),
																build(kKeyWatercraft__autokey__addressb2		, update),
																build(kKeyWatercraft__autokey__citystname	, update),
																build(kKeyWatercraft__autokey__citystnameb2, update),
																build(kKeyWatercraft__autokey__fein2				, update),
																build(kKeyWatercraft__autokey__name				, update),
																build(kKeyWatercraft__autokey__nameb2			, update),
																build(kKeyWatercraft__autokey__namewords2	, update),
																build(kKeyWatercraft__autokey__payload			, update),
																build(kKeyWatercraft__autokey__phone2			, update),
																build(kKeyWatercraft__autokey__phoneb2			, update),
																build(kKeyWatercraft__autokey__ssn2				, update),
																build(kKeyWatercraft__autokey__stname			, update),
																build(kKeyWatercraft__autokey__stnameb2		, update),
																build(kKeyWatercraft__autokey__zip					, update),
																build(kKeyWatercraft__autokey__zipb2				, update),
																build(kKeyWatercraft__bdid					    		, update),
																build(kKeyWatercraft__cid						    	, update),
																build(kKeyWatercraft__did						    	, update),
																build(kKeyWatercraft__hullnum				   		, update),
																build(kKeyWatercraft__sid						    	, update),
																build(kKeyWatercraft__vslnam				   			, update),
																build(kKeyWatercraft__wid						    	, update), 
																buildindex(index(dataset([],arecord7),{official_number},{dataset([],arecord7)},'keyname'),'~prte::key::watercraft::' + pIndexVersion + '::offnum',update);
																build(kKeyWatercraft__wid_fcra						    	, update), 
                                build(kKeyWatercraft__cid_fcra						    	, update),
																build(kKeyWatercraft__did_fcra						    	, update),
																build(kKeyWatercraft__sid_fcra						    	, update),
																build(kKeyWatercraft__LinkIDs			    	  , update)
															 ),
											PRTE.UpdateVersion('WatercraftKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
											PRTE.UpdateVersion('FCRA_WatercraftKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;


