import	_control, PRTE_CSV;

export Proc_Build_Ccw_Keys(string pIndexVersion) := function
	
	rKeyCcw__autokey__address	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__autokey__address;
	end;
	
	rKeyCcw__autokey__citystname	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__autokey__citystname;
	end;

	rKeyCcw__autokey__name	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__autokey__name;
	end;
	
	rKeyCcw__autokey__payload	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__autokey__payload;
	end;
	
	rKeyCcw__autokey__ssn2	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__autokey__ssn2;
	end;

	rKeyCcw__autokey__stname	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__autokey__stname;
	end;
	
	rKeyCcw__autokey__zip	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__autokey__zip;
	end;
	
	rKeyCcw__did	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__did;
	end;

	rKeyCcw__rid	:=
	record
		PRTE_CSV.Ccw.rthor_data400__key__Ccw__rid;
	end;
		                                                         
	dKeyCcw__autokey__address			:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__autokey__address, rKeyCcw__autokey__address);	
	dKeyCcw__autokey__citystname		:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__autokey__citystname, rKeyCcw__autokey__citystname);
	dKeyCcw__autokey__name					:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__autokey__name, rKeyCcw__autokey__name);
	dKeyCcw__autokey__payload			:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__autokey__payload, rKeyCcw__autokey__payload);	
	dKeyCcw__autokey__ssn2					:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__autokey__ssn2, rKeyCcw__autokey__ssn2);
	dKeyCcw__autokey__stname				:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__autokey__stname, rKeyCcw__autokey__stname);
	dKeyCcw__autokey__zip					:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__autokey__zip, rKeyCcw__autokey__zip);	
	dKeyCcw__did							:= 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__did, rKeyCcw__did);
	dKeyCcw__rid					 := 	project(PRTE_CSV.Ccw.dthor_data400__key__Ccw__rid, rKeyCcw__rid);	

	
	kKeyCcw__autokey__address			:=	index(dKeyCcw__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyCcw__autokey__address}, '~prte::key::ccw::' + pIndexVersion + '::autokey::address');																						
	kKeyCcw__autokey__citystname		:=	index(dKeyCcw__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__citystname}, '~prte::key::ccw::' + pIndexVersion + '::autokey::citystname');																													
	kKeyCcw__autokey__name					:=	index(dKeyCcw__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__name}, '~prte::key::ccw::' + pIndexVersion + '::autokey::name');
	kKeyCcw__autokey__payload			:=	index(dKeyCcw__autokey__payload, {fakeid}, {dKeyCcw__autokey__payload}, '~prte::key::ccw::' + pIndexVersion + '::autokey::payload');	
	kKeyCcw__autokey__ssn2					:=	index(dKeyCcw__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyCcw__autokey__ssn2}, '~prte::key::ccw::' + pIndexVersion + '::autokey::ssn2');
	kKeyCcw__autokey__stname				:=	index(dKeyCcw__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__stname}, '~prte::key::ccw::' + pIndexVersion + '::autokey::stname');																											
	kKeyCcw__autokey__zip					:=	index(dKeyCcw__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__zip}, '~prte::key::ccw::' + pIndexVersion + '::autokey::zip');
	kKeyCcw__did						:=	index(dKeyCcw__did, {did_out6}, {dKeyCcw__did}, '~prte::key::ccw::' + pIndexVersion + '::did');
	// kKeyCcw__rid						:=	index(dKeyCcw__rid, {rid}, {dKeyCcw__rid}, '~prte::key::ccw::' + pIndexVersion + '::rid');
  kKeyCcw__rid						:=	index(dKeyCcw__rid, {rid,persistent_record_id}, {dKeyCcw__rid}, '~prte::key::ccw::' + pIndexVersion + '::rid');

//FCRA keys
	kKeyCcw__autokey__address_fcra			:=	index(dKeyCcw__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyCcw__autokey__address}, '~prte::key::ccw::fcra::' + pIndexVersion + '::autokey::address');																						
	kKeyCcw__autokey__citystname_fcra		:=	index(dKeyCcw__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__citystname}, '~prte::key::ccw::fcra::' + pIndexVersion + '::autokey::citystname');																													
	kKeyCcw__autokey__name_fcra					:=	index(dKeyCcw__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__name}, '~prte::key::ccw::fcra::' + pIndexVersion + '::autokey::name');
	kKeyCcw__autokey__payload_fcra			:=	index(dKeyCcw__autokey__payload, {fakeid}, {dKeyCcw__autokey__payload}, '~prte::key::ccw::fcra::' + pIndexVersion + '::autokey::payload');	
	kKeyCcw__autokey__ssn2_fcra					:=	index(dKeyCcw__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyCcw__autokey__ssn2}, '~prte::key::ccw::fcra::' + pIndexVersion + '::autokey::ssn2');
	kKeyCcw__autokey__stname_fcra				:=	index(dKeyCcw__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__stname}, '~prte::key::ccw::fcra::' + pIndexVersion + '::autokey::stname');																											
	kKeyCcw__autokey__zip_fcra					:=	index(dKeyCcw__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyCcw__autokey__zip}, '~prte::key::ccw::fcra::' + pIndexVersion + '::autokey::zip');
	kKeyCcw__did_fcra										:=	index(dKeyCcw__did, {did_out6}, {dKeyCcw__did}, '~prte::key::ccw::fcra::' + pIndexVersion + '::did');
	// kKeyCcw__rid_fcra										:=	index(dKeyCcw__rid, {rid}, {dKeyCcw__rid}, '~prte::key::ccw::fcra::' + pIndexVersion + '::rid');
  kKeyCcw__rid_fcra					        	:=	index(dKeyCcw__rid, {rid,persistent_record_id}, {dKeyCcw__rid}, '~prte::key::ccw::fcra::' + pIndexVersion + '::rid');
		
	return	sequential(
											parallel(																
																build(kKeyCcw__autokey__address			, update),																
																build(kKeyCcw__autokey__citystname	, update),																
																build(kKeyCcw__autokey__name				, update),																
																build(kKeyCcw__autokey__payload			, update),																
																build(kKeyCcw__autokey__ssn2				, update),
																build(kKeyCcw__autokey__stname			, update),																
																build(kKeyCcw__autokey__zip					, update),																	
																build(kKeyCcw__did						    	, update),
																build(kKeyCcw__rid					    		, update),
																
																build(kKeyCcw__autokey__address_fcra			, update),																
																build(kKeyCcw__autokey__citystname_fcra		, update),																
																build(kKeyCcw__autokey__name_fcra					, update),																
																build(kKeyCcw__autokey__payload_fcra			, update),																
																build(kKeyCcw__autokey__ssn2_fcra					, update),
																build(kKeyCcw__autokey__stname_fcra				, update),																
																build(kKeyCcw__autokey__zip_fcra					, update),																	
																build(kKeyCcw__did_fcra						    		, update),
																build(kKeyCcw__rid_fcra					    			, update)
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
