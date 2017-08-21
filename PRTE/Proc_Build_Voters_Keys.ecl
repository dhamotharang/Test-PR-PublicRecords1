 import	_control, PRTE_CSV;

export	Proc_Build_Voters_Keys(string pIndexVersion)	:=
function


	rKeyVoters__autokey__address	:=
	record 
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__address;
	end;

	rKeyVoters__autokey__citystname	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__citystname;
	end;

	rKeyVoters__autokey__name	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__name
	end;
	
	rKeyVoters__autokey__payload	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__payload;
	end;

	rKeyVoters__autokey__phone2	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__phone2;
	end;

	rKeyVoters__autokey__ssn2	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__ssn2;
	end;
	
	rKeyVoters__autokey__stname	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__stname;
	end;
	
	rKeyVoters__autokey__zip	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__autokey__zip;
	end;
	
	rKeyVoters__did	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__did;
	end;

	rKeyVoters__history_vtid	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__history_vtid;
	end;
	
	rKeyVoters__vtid	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__vtid;  
	end;
	
	rKeyVoters__states	:=
	record
		PRTE_CSV.Voters.rthor_data400__key__voters__States;  
	end;																
	
dKeyVoters__autokey__address 		:= project(PRTE_CSV.Voters.dthor_data400__key__voters__autokey__address, rKeyVoters__autokey__address); 
dKeyVoters__autokey__citystname 	:= project( PRTE_CSV.Voters.dthor_data400__key__voters__autokey__citystname, rKeyVoters__autokey__citystname); 
dKeyVoters__autokey__name 			:= project(PRTE_CSV.Voters.dthor_data400__key__voters__autokey__name, rKeyVoters__autokey__name); 
dKeyVoters__autokey__payload 		:= project( PRTE_CSV.Voters.dthor_data400__key__voters__autokey__payload, rKeyVoters__autokey__payload); 
dKeyVoters__autokey__phone2 		:= project( PRTE_CSV.Voters.dthor_data400__key__voters__autokey__phone2, rKeyVoters__autokey__phone2); 
dKeyVoters__autokey__ssn2 			:= project( PRTE_CSV.Voters.dthor_data400__key__voters__autokey__ssn2, rKeyVoters__autokey__ssn2); 
dKeyVoters__autokey__stname 		:= project( PRTE_CSV.Voters.dthor_data400__key__voters__autokey__stname, rKeyVoters__autokey__stname); 
dKeyVoters__autokey__zip 			:= project( PRTE_CSV.Voters.dthor_data400__key__voters__autokey__zip, rKeyVoters__autokey__zip); 
dKeyVoters__did 					:= project( PRTE_CSV.Voters.dthor_data400__key__voters__did, rKeyVoters__did); 
dKeyVoters__history_vtid 			:= project( PRTE_CSV.Voters.dthor_data400__key__voters__history_vtid, rKeyVoters__history_vtid); 
dKeyVoters__vtid 					:= project(PRTE_CSV.Voters.dthor_data400__key__voters__vtid, rKeyVoters__vtid);
dKeyVoters__States 							:= project(PRTE_CSV.Voters.dthor_data400__key__voters__states, rKeyVoters__states); 


kKeyVoters__autokey__address 	:= index(dKeyVoters__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyVoters__autokey__address}, '~prte::key::Voters::' + pIndexVersion + '::autokey::address');
kKeyVoters__autokey__citystname := index(dKeyVoters__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyVoters__autokey__citystname}, '~prte::key::Voters::' + pIndexVersion + '::autokey::citystname');
kKeyVoters__autokey__name 		:= index(dKeyVoters__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyVoters__autokey__name}, '~prte::key::Voters::' + pIndexVersion + '::autokey::name');
kKeyVoters__autokey__payload 	:= index(dKeyVoters__autokey__payload, {fakeid}, {dKeyVoters__autokey__payload}, '~prte::key::Voters::' + pIndexVersion + '::autokey::payload');
kKeyVoters__autokey__phone2 	:= index(dKeyVoters__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyVoters__autokey__phone2}, '~prte::key::Voters::' + pIndexVersion + '::autokey::phone2');
kKeyVoters__autokey__ssn2 		:= index(dKeyVoters__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyVoters__autokey__ssn2}, '~prte::key::Voters::' + pIndexVersion + '::autokey::ssn2');
kKeyVoters__autokey__stname 	:= index(dKeyVoters__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyVoters__autokey__stname}, '~prte::key::Voters::' + pIndexVersion + '::autokey::stname');
kKeyVoters__autokey__zip 		:= index(dKeyVoters__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyVoters__autokey__zip}, '~prte::key::Voters::' + pIndexVersion + '::autokey::zip');
kKeyVoters__did 				:= index(dKeyVoters__did, {did}, {dKeyVoters__did}, '~prte::key::Voters::' + pIndexVersion + '::did');
kKeyVoters__history_vtid 		:= index(dKeyVoters__history_vtid, {vtid}, {dKeyVoters__history_vtid}, '~prte::key::Voters::' + pIndexVersion + '::history_vtid');
kKeyVoters__vtid 				:= index(dKeyVoters__vtid, {vtid}, {dKeyVoters__vtid}, '~prte::key::Voters::' + pIndexVersion + '::vtid');
kKeyVoters__state 						:= index(dKeyVoters__states, {state}, {dKeyVoters__states}, '~prte::key::VotersV2::' + pIndexVersion + '::bocashell_voters_source_states_lookup');
kKeyVoters__state_fcra 				:= index(dKeyVoters__states, {state}, {dKeyVoters__states}, '~prte::key::VotersV2::fcra::' + pIndexVersion + '::bocashell_voters_source_states_lookup');

	return	sequential(
														parallel(
																build(kKeyVoters__autokey__address		, update),
																build(kKeyVoters__autokey__citystname	, update),
																build(kKeyVoters__autokey__name		 	, update),
																build(kKeyVoters__autokey__payload	 	, update),
																build(kKeyVoters__autokey__phone2		, update),
																build(kKeyVoters__autokey__ssn2			, update),
																build(kKeyVoters__autokey__stname		, update),
																build(kKeyVoters__autokey__zip		    , update),
																build(kKeyVoters__did					, update),
																build(kKeyVoters__history_vtid			, update),
																build(kKeyVoters__vtid	 , update),
																build(kKeyVoters__state	 , update),
																build(kKeyVoters__state_fcra	 , update)
																),

   											PRTE.UpdateVersion('VotersV2Keys',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																),
																	
												PRTE.UpdateVersion('VotersV2Keys',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'F',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								);
								 

end;