import	_control, PRTE_CSV, hygenics_search;

export Proc_Build_Corrections_Keys (string pIndexVersion)	:=

function 

rkey__corrections__autokey__address	:=
	record
		PRTE_CSV.Corrections.rthor_data400__key__corrections__autokey__address;
	end;
	dKeycorrections__autokey__address			:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__autokey__address, rkey__corrections__autokey__address);
	kKeycorrections__autokey__address			:=	index(dKeycorrections__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeycorrections__autokey__address}, '~prte::key::corrections::' + pIndexVersion + '::autokey::address');

rKeycorrections__autokey__citystname	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections__autokey__citystname;
	end;
	dKeycorrections__autokey__citystname	:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__autokey__citystname, rKeycorrections__autokey__citystname);
	kKeycorrections__autokey__citystname	:=	index(dKeycorrections__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections__autokey__citystname}, '~prte::key::corrections::' + pIndexVersion + '::autokey::citystname');

rKeycorrections__autokey__name	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections__autokey__name;
	end;
	dKeycorrections__autokey__name				:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__autokey__name, rKeycorrections__autokey__name);
	kKeycorrections__autokey__name				:=	index(dKeycorrections__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections__autokey__name}, '~prte::key::corrections::' + pIndexVersion + '::autokey::name');

rKeycorrections__autokey__payload	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections__autokey__payload;
	end;
	dKeycorrections__autokey__payload			:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__autokey__payload, rKeycorrections__autokey__payload);
	kKeycorrections__autokey__payload			:=	index(dKeycorrections__autokey__payload, {fakeid}, {dKeycorrections__autokey__payload}, '~prte::key::corrections::' + pIndexVersion + '::autokey::payload');

rKeycorrections__autokey__ssn2	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections__autokey__ssn2;
	end;
	dKeycorrections__autokey__ssn2				:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__autokey__ssn2, rKeycorrections__autokey__ssn2);
	kKeycorrections__autokey__ssn2				:=	index(dKeycorrections__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeycorrections__autokey__ssn2}, '~prte::key::corrections::' + pIndexVersion + '::autokey::ssn2');

rKeycorrections__autokey__stname	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections__autokey__stname;
	end;
	dKeycorrections__autokey__stname			:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__autokey__stname, rKeycorrections__autokey__stname);
	kKeycorrections__autokey__stname			:=	index(dKeycorrections__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections__autokey__stname}, '~prte::key::corrections::' + pIndexVersion + '::autokey::stname');

rKeycorrections__autokey__zip	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections__autokey__zip;
	end;
	dKeycorrections__autokey__zip					:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__autokey__zip, rKeycorrections__autokey__zip);
	kKeycorrections__autokey__zip					:=	index(dKeycorrections__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections__autokey__zip}, '~prte::key::corrections::' + pIndexVersion + '::autokey::zip');

rkey__corrections__fdid_public	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections__fdid_public;
	end;
	
	dKeycorrections__fdid_public					:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections__fdid_public, rkey__corrections__fdid_public);
	kKeycorrections__fdid_public					:=	index(dKeycorrections__fdid_public,{sdid }, {offender_key}, '~prte::key::corrections::' + pIndexVersion + '::fdid_public');

rkey__corrections__activity__public	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_activity__public;
	end;
	
	dKeycorrections__activity__public			:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_activity__public, rkey__corrections__activity__public);
	kKeycorrections__activity__public			:=	index(dKeycorrections__activity__public,{ok}, {dKeycorrections__activity__public}, '~prte::key::corrections_activity::' + pIndexVersion + '::public');

rkey__corrections__court_offenses__public	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_court_offenses__public;
	end;
	
	dKeycorrections__court_offenses__public		:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_court_offenses, rkey__corrections__court_offenses__public);
	kKeycorrections__court_offenses__public		:=	index(dKeycorrections__court_offenses__public,{ofk}, {dKeycorrections__court_offenses__public}, '~prte::key::corrections_court_offenses::' + pIndexVersion + '::public');

rkey__corrections__offenders_docnum_public	:= 
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders__docnum_public;
	end;
	
	dKeycorrections__offenders_docnum_public					:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__docnum_public, rkey__corrections__offenders_docnum_public);
	kKeycorrections__offenders_docnum_public					:=	index(dKeycorrections__offenders_docnum_public,{docnum, state}, {dKeycorrections__offenders_docnum_public}, '~prte::key::corrections_offenders::' + pIndexVersion + '::docnum_public');

rkey__corrections__offenders_offenderkey_public	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders__offenderkey_public;
	end;
	
	dKeycorrections__offenders_offenderkey_public					:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__offenderkey_public, rkey__corrections__offenders_offenderkey_public);
	kKeycorrections__offenders_offenderkey_public					:=	index(dKeycorrections__offenders_offenderkey_public,{ofk}, {dKeycorrections__offenders_offenderkey_public}, '~prte::key::corrections_offenders::' + pIndexVersion + '::offenderkey_public');

rkey__corrections__offenders_public	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders__public;
	end;
	
	dKeycorrections__offenders_public									:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__public, rkey__corrections__offenders_public);
	kKeycorrections__offenders_public									:=	index(dKeycorrections__offenders_public,{sdid}, {dKeycorrections__offenders_public}, '~prte::key::corrections_offenders::' + pIndexVersion + '::public');

rkey__corrections__offenses_public	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenses__public;
	end;
	
	dKeycorrections__offenses_public									:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenses__public, rkey__corrections__offenses_public);
	kKeycorrections__offenses_public									:=	index(dKeycorrections__offenses_public,{ok}, {dKeycorrections__offenses_public}, '~prte::key::corrections_offenses::' + pIndexVersion + '::public');

rkey__corrections_public__address	:=
	record
		PRTE_CSV.Corrections.rthor_data400__key__corrections_public__address;
	end;
	dKeycorrections_public__address										:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_public__address, rkey__corrections_public__address);
	kKeycorrections_public__address										:=	index(dKeycorrections_public__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeycorrections_public__address}, '~prte::key::corrections_public::' + pIndexVersion + '::address');

rKeycorrections_public__citystname	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_public__citystname;
	end;
	dKeycorrections_public__citystname								:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_public__citystname, rKeycorrections_public__citystname);
	kKeycorrections_public__citystname								:=	index(dKeycorrections_public__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections_public__citystname}, '~prte::key::corrections_public::' + pIndexVersion + '::citystname');

rKeycorrections_public__name	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_public__name;
	end;
	dKeycorrections_public__name											:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_public__name, rKeycorrections_public__name);
	kKeycorrections_public__name											:=	index(dKeycorrections_public__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections_public__name}, '~prte::key::corrections_public::' + pIndexVersion + '::name');

rKeycorrections_public__phone	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_public__phone;
	end;
	
	dKeycorrections_public__phone											:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_public__phone, rKeycorrections_public__phone);
	kKeycorrections_public__phone											:=	index(dKeycorrections_public__phone, {p7,p3,dph_lname,pfname,st,did}, {dKeycorrections_public__phone}, '~prte::key::corrections_public::' + pIndexVersion + '::phone');

rKeycorrections_public__ssn	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_public__ssn;
	end;
	dKeycorrections_public__ssn												:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_public__ssn, rKeycorrections_public__ssn);
	kKeycorrections_public__ssn												:=	index(dKeycorrections_public__ssn, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeycorrections_public__ssn}, '~prte::key::corrections_public::' + pIndexVersion + '::ssn');

rKeycorrections_public__stname	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_public__stname;
	end;
	dKeycorrections_public__stname										:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_public__stname, rKeycorrections_public__stname);
	kKeycorrections_public__stname										:=	index(dKeycorrections_public__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections_public__stname}, '~prte::key::corrections_public::' + pIndexVersion + '::stname');

rKeycorrections_public__zip	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_public__zip;
	end;
	dKeycorrections_public__zip												:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_public__zip, rKeycorrections_public__zip);
	kKeycorrections_public__zip												:=	index(dKeycorrections_public__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeycorrections_public__zip}, '~prte::key::corrections_public::' + pIndexVersion + '::zip');

rKeycorrections_punishment__public	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_punishment__public;
	end;
	dKeycorrections_punishment__public								:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_punishment__public, rKeycorrections_punishment__public);
	kKeycorrections_punishment__public								:=	index(dKeycorrections_punishment__public, {ok,pt}, {dKeycorrections_punishment__public}, '~prte::key::corrections_punishment::' + pIndexVersion + '::public');

rKeycorrections_offenders_bocashell_did	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders__bocashell_did
	end;
	dKeycorrections_offenders_bocashell_did						:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__bocashell_did, rKeycorrections_offenders_bocashell_did);
	kKeycorrections_offenders_bocashell_did						:=	index(dKeycorrections_offenders_bocashell_did, {did}, {dKeycorrections_offenders_bocashell_did}, '~prte::key::corrections_offenders::' + pIndexVersion + '::bocashell_did');

rKeycorrections_offenders_risk_bocashell_did	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders_risk__bocashell_did
	end;
	dKeycorrections_offenders_risk_bocashell_did			:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders_risk__bocashell_did, rKeycorrections_offenders_risk_bocashell_did);
	kKeycorrections_offenders_risk_bocashell_did			:=	index(dKeycorrections_offenders_risk_bocashell_did, {did}, {dKeycorrections_offenders_risk_bocashell_did}, '~prte::key::corrections_offenders_risk::' + pIndexVersion + '::bocashell_did');

rKeycorrections_offenders_risk_did	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders_risk__did
	end;
	dKeycorrections_offenders_risk_did								:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders_risk__did, rKeycorrections_offenders_risk_did);
	kKeycorrections_offenders_risk_did								:=	index(dKeycorrections_offenders_risk_did, {sdid}, {dKeycorrections_offenders_risk_did}, '~prte::key::corrections_offenders_risk::' + pIndexVersion + '::did');

rKeycorrections_offenders_casenumber	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders__casenumber_public
	end;	
	dKeycorrections_offenders_casenumber        			:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__casenumber_public, rKeycorrections_offenders_casenumber);
	kKeycorrections_offenders_casenumber					    :=	index(dKeycorrections_offenders_casenumber, {case_num},  {offender_key,file_indicator}, '~prte::key::corrections_Offenders::' + pIndexVersion + '::casenumber_public');
	
	
rKeycorrections_offenders_bocashell_did_fcra	:=
	record
		PRTE_CSV.corrections.rthor_data400__key__corrections_offenders_bocashell_did_fcra
	end;
	
//FCRA Keys

	dKeycriminal_offenders_did_fcra												:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__public(vendor not in hygenics_search.sCourt_Vendors_To_Omit), rkey__corrections__offenders_public);
	kKeycriminal_offenders_did_fcra												:=	index(dKeycriminal_offenders_did_fcra, {sdid}, {dKeycriminal_offenders_did_fcra}, '~prte::key::criminal_offenders::fcra::' + pIndexVersion + '::did');
	
	dKeycriminal__offenders_docnum_public_fcra						:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__docnum_public(vendor not in hygenics_search.sCourt_Vendors_To_Omit), rkey__corrections__offenders_docnum_public);
	kKeycriminal__offenders_docnum_public_fcra						:=	index(dKeycriminal__offenders_docnum_public_fcra, {docnum, state}, {dKeycriminal__offenders_docnum_public_fcra}, '~prte::key::criminal_offenders::fcra::' + pIndexVersion + '::docnum');
	
	dKeycriminal__offenses__offender_key_fcra							:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenses__public(vendor not in hygenics_search.sCourt_Vendors_To_Omit), rkey__corrections__offenses_public);
	kKeycriminal__offenses__offender_key_fcra							:=	index(dKeycriminal__offenses__offender_key_fcra, {ok}, {dKeycriminal__offenses__offender_key_fcra}, '~prte::key::criminal_offenses::fcra::' + pIndexVersion + '::offender_key');
	
	dKeycriminal_punishment__offender_key_type_fcra				:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_punishment__public(vendor not in hygenics_search.sCourt_Vendors_To_Omit), rKeycorrections_punishment__public);
	kKeycriminal_punishment__offender_key_type_fcra				:=	index(dKeycriminal_punishment__offender_key_type_fcra, {ok, pt}, {dKeycriminal_punishment__offender_key_type_fcra}, '~prte::key::criminal_punishment::fcra::' + pIndexVersion + '::offender_key.punishment_type');
	
	dKeycorrections__activity__public_fcra								:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_activity__public(vendor not in hygenics_search.sCourt_Vendors_To_Omit), rkey__corrections__activity__public);
	kKeycorrections__activity__public_fcra								:=	index(dKeycorrections__activity__public_fcra, {ok}, {dKeycorrections__activity__public_fcra}, '~prte::key::life_eir::fcra::' + pIndexVersion + '::court_activity');
	
	dKeycorrections__court_offenses__public_fcra					:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_court_offenses(vendor not in hygenics_search.sCourt_Vendors_To_Omit), rkey__corrections__court_offenses__public);
	kKeycorrections__court_offenses__public_fcra					:=	index(dKeycorrections__court_offenses__public_fcra, {ofk}, {dKeycorrections__court_offenses__public_fcra}, '~prte::key::life_eir::fcra::' + pIndexVersion + '::court_offenses');
	
	dKeycorrections_offenders_offenderkey__public_fcra		:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders__offenderkey_public(vendor not in hygenics_search.sCourt_Vendors_To_Omit), rkey__corrections__offenders_offenderkey_public);
	kKeycorrections_offenders_offenderkey__public_fcra		:=	index(dKeycorrections_offenders_offenderkey__public_fcra, {ofk}, {dKeycorrections_offenders_offenderkey__public_fcra}, '~prte::key::life_eir::fcra::' + pIndexVersion + '::offenders_offenderkey');
	
	dKeycorrections_offenders_bocashell_did_fcra					:= 	project(PRTE_CSV.corrections.dthor_data400__key__corrections_offenders_bocashell_did_fcra, rKeycorrections_offenders_bocashell_did_fcra);
	kKeycorrections_offenders_bocashell_did_fcra					:=	index(dKeycorrections_offenders_bocashell_did_fcra, {did}, {dKeycorrections_offenders_bocashell_did_fcra}, '~prte::key::corrections_offenders::fcra::' + pIndexVersion + '::bocashell_did');
	
	

return	sequential(
														parallel(
																build(kKeycorrections__autokey__address										, update),
																build(kKeycorrections__autokey__citystname								, update),
																build(kKeycorrections__autokey__name		 									, update),
																build(kKeycorrections__autokey__payload	 									, update),
																build(kKeycorrections__autokey__ssn2											, update),
																build(kKeycorrections__autokey__stname										, update),
																build(kKeycorrections__autokey__zip												, update),
																build(kKeycorrections__fdid_public												, update),
																build(kKeycorrections__activity__public										, update),
																build(kKeycorrections__court_offenses__public							, update),
																build(kKeycorrections__offenders_docnum_public						, update),
																build(kKeycorrections__offenders_offenderkey_public				, update),
																build(kKeycorrections__offenders_public										, update),
																build(kKeycorrections__offenses_public										, update),
																build(kKeycorrections_public__address											, update),
																build(kKeycorrections_public__citystname									, update),
																build(kKeycorrections_public__name												, update),
																build(kKeycorrections_public__phone												, update),
																build(kKeycorrections_public__ssn													, update),
																build(kKeycorrections_public__stname											, update),
																build(kKeycorrections_public__zip													, update),
																build(kKeycorrections_punishment__public									, update),
																build(kKeycorrections_offenders_bocashell_did							, update),
																build(kKeycorrections_offenders_risk_bocashell_did				, update),
																build(kKeycorrections_offenders_risk_did									, update),
																build(kKeycorrections_offenders_casenumber								, update), //
																build(kKeycriminal_offenders_did_fcra											, update),
																build(kKeycriminal__offenders_docnum_public_fcra					, update),
																build(kKeycriminal__offenses__offender_key_fcra						, update),	
																build(kKeycriminal_punishment__offender_key_type_fcra			, update),
																build(kKeycorrections__activity__public_fcra							, update),
																build(kKeycorrections__court_offenses__public_fcra				, update),
																build(kKeycorrections_offenders_offenderkey__public_fcra	,	update),
																build(kKeycorrections_offenders_bocashell_did_fcra				, update));//,
													
   											PRTE.UpdateVersion('DOCKeys',														//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																),
												
												PRTE.UpdateVersion('FCRA_DOCKeys',											//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'F',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								);
								 

end: DEPRECATED('Use PRTE2_DOC.proc_build_keys');;

