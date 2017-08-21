import	_control, PRTE_CSV;

export Proc_Build_Hunting_Fishing_Keys(string pIndexVersion) := function
	
	rKeyHunting_Fishing__autokey__address	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__address;
	end;
	
	rKeyHunting_Fishing__autokey__citystname	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__citystname;
	end;

	rKeyHunting_Fishing__autokey__name	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__name;
	end;
	
	rKeyHunting_Fishing__autokey__payload	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__payload;
	end;
	
	rKeyHunting_Fishing__autokey__ssn2	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__ssn2;
	end;

	rKeyHunting_Fishing__autokey__stname	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__stname;
	end;
	
	rKeyHunting_Fishing__autokey__zip	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__zip;
	end;
	
	rKeyHunting_Fishing__did	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__did;
	end;

	rKeyHunting_Fishing__rid	:=
	record
		PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__rid;
	end;
		                                                         
	dKeyHunting_Fishing__autokey__address			:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__address, rKeyHunting_Fishing__autokey__address);	
	dKeyHunting_Fishing__autokey__citystname	:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__citystname, rKeyHunting_Fishing__autokey__citystname);
	dKeyHunting_Fishing__autokey__name				:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__name, rKeyHunting_Fishing__autokey__name);
	dKeyHunting_Fishing__autokey__payload			:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__payload, rKeyHunting_Fishing__autokey__payload);	
	dKeyHunting_Fishing__autokey__ssn2				:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__ssn2, rKeyHunting_Fishing__autokey__ssn2);
	dKeyHunting_Fishing__autokey__stname			:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__stname, rKeyHunting_Fishing__autokey__stname);
	dKeyHunting_Fishing__autokey__zip					:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__zip, rKeyHunting_Fishing__autokey__zip);	
	dKeyHunting_Fishing__did									:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__did, rKeyHunting_Fishing__did);
	dKeyHunting_Fishing__rid					 				:= 	project(PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__rid, rKeyHunting_Fishing__rid);	

	
	kKeyHunting_Fishing__autokey__address			:=	index(dKeyHunting_Fishing__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyHunting_Fishing__autokey__address}, '~prte::key::hunting_fishing::' + pIndexVersion + '::autokey::address');																						
	kKeyHunting_Fishing__autokey__citystname	:=	index(dKeyHunting_Fishing__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__citystname}, '~prte::key::hunting_fishing::' + pIndexVersion + '::autokey::citystname');																													
	kKeyHunting_Fishing__autokey__name				:=	index(dKeyHunting_Fishing__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__name}, '~prte::key::hunting_fishing::' + pIndexVersion + '::autokey::name');
	kKeyHunting_Fishing__autokey__payload			:=	index(dKeyHunting_Fishing__autokey__payload, {fakeid}, {dKeyHunting_Fishing__autokey__payload}, '~prte::key::hunting_fishing::' + pIndexVersion + '::autokey::payload');	
	kKeyHunting_Fishing__autokey__ssn2				:=	index(dKeyHunting_Fishing__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyHunting_Fishing__autokey__ssn2}, '~prte::key::hunting_fishing::' + pIndexVersion + '::autokey::ssn2');
	kKeyHunting_Fishing__autokey__stname			:=	index(dKeyHunting_Fishing__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__stname}, '~prte::key::hunting_fishing::' + pIndexVersion + '::autokey::stname');																											
	kKeyHunting_Fishing__autokey__zip					:=	index(dKeyHunting_Fishing__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__zip}, '~prte::key::hunting_fishing::' + pIndexVersion + '::autokey::zip');
	kKeyHunting_Fishing__did									:=	index(dKeyHunting_Fishing__did, {did}, {dKeyHunting_Fishing__did}, '~prte::key::hunting_fishing::' + pIndexVersion + '::did');
	kKeyHunting_Fishing__rid									:=	index(dKeyHunting_Fishing__rid, {rid,persistent_record_id}, {dKeyHunting_Fishing__rid}, '~prte::key::hunting_fishing::' + pIndexVersion + '::rid');
	
	//fcra keys
	kKeyHunting_Fishing__autokey__address_fcra		:=	index(dKeyHunting_Fishing__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyHunting_Fishing__autokey__address}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::autokey::address');																						
	kKeyHunting_Fishing__autokey__citystname_fcra	:=	index(dKeyHunting_Fishing__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__citystname}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::autokey::citystname');																													
	kKeyHunting_Fishing__autokey__name_fcra				:=	index(dKeyHunting_Fishing__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__name}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::autokey::name');
	kKeyHunting_Fishing__autokey__payload_fcra		:=	index(dKeyHunting_Fishing__autokey__payload, {fakeid}, {dKeyHunting_Fishing__autokey__payload}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::autokey::payload');	
	kKeyHunting_Fishing__autokey__ssn2_fcra				:=	index(dKeyHunting_Fishing__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyHunting_Fishing__autokey__ssn2}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::autokey::ssn2');
	kKeyHunting_Fishing__autokey__stname_fcra			:=	index(dKeyHunting_Fishing__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__stname}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::autokey::stname');																											
	kKeyHunting_Fishing__autokey__zip_fcra				:=	index(dKeyHunting_Fishing__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyHunting_Fishing__autokey__zip}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::autokey::zip');
	kKeyHunting_Fishing__did_fcra									:=	index(dKeyHunting_Fishing__did, {did}, {dKeyHunting_Fishing__did}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::did');
	kKeyHunting_Fishing__rid_fcra									:=	index(dKeyHunting_Fishing__rid, {rid,persistent_record_id}, {dKeyHunting_Fishing__rid}, '~prte::key::hunting_fishing::fcra::' + pIndexVersion + '::rid');
	
	return	sequential(
											parallel(																
																build(kKeyHunting_Fishing__autokey__address			, update),																
																build(kKeyHunting_Fishing__autokey__citystname	, update),																
																build(kKeyHunting_Fishing__autokey__name				, update),																
																build(kKeyHunting_Fishing__autokey__payload			, update),																
																build(kKeyHunting_Fishing__autokey__ssn2				, update),
																build(kKeyHunting_Fishing__autokey__stname			, update),																
																build(kKeyHunting_Fishing__autokey__zip					, update),																	
																build(kKeyHunting_Fishing__did						    	, update),
																build(kKeyHunting_Fishing__rid					    		, update),
																build(kKeyHunting_Fishing__autokey__address_fcra		, update),																
																build(kKeyHunting_Fishing__autokey__citystname_fcra	, update),																
																build(kKeyHunting_Fishing__autokey__name_fcra				, update),																
																build(kKeyHunting_Fishing__autokey__payload_fcra		, update),																
																build(kKeyHunting_Fishing__autokey__ssn2_fcra				, update),
																build(kKeyHunting_Fishing__autokey__stname_fcra			, update),																
																build(kKeyHunting_Fishing__autokey__zip_fcra				, update),																	
																build(kKeyHunting_Fishing__did_fcra						    	, update),
																build(kKeyHunting_Fishing__rid_fcra					    		, update)
														),
											PRTE.UpdateVersion('EmergesKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
											PRTE.UpdateVersion('FCRA_EmergesKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
