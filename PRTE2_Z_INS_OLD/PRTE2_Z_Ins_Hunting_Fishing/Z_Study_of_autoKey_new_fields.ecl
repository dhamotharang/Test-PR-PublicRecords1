// EXPORT Z_Study_of_autoKey_new_fields := 'todo';

import	_control, PRTE_CSV;

export proc_build_keys(string pIndexVersion, boolean isUpdateVersion=TRUE) := FUNCTION

	finalMasterLayout := RECORD
			PRTE_CSV.Hunting_Fishing.rthor_data400__key__emerges__hunters_doxie_did and NOT __filepos;
	END;
	
	rKeyHunting_Fishing__autokey__address 		:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__address;
	rKeyHunting_Fishing__autokey__citystname 	:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__citystname;
	rKeyHunting_Fishing__autokey__name				:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__name;
	rKeyHunting_Fishing__autokey__payload			:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__payload;
	rKeyHunting_Fishing__autokey__ssn2				:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__ssn2;
	rKeyHunting_Fishing__autokey__stname			:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__stname;
	rKeyHunting_Fishing__autokey__zip					:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__autokey__zip;
	rKeyHunting_Fishing__did									:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__did;
	rKeyHunting_Fishing__rid									:= PRTE_CSV.Hunting_Fishing.rthor_data400__key__Hunting_Fishing__rid;

	// NOTE: IF Boca wants us to help them move toward a single CSV, then this might just be a ONE-TIME thing followed by OUTPUT(blah)
	DS1	:= 	PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__payload;
	DS2	:= 	JOIN(DS1,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__address
									, LEFT.did = RIGHT.did	);
	DS3	:= 	JOIN(DS2,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__citystname
									, LEFT.did = RIGHT.did	);
	DS4	:= 	JOIN(DS3,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__name
									, LEFT.did = RIGHT.did	);
	DS5	:= 	JOIN(DS4,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__ssn2
									, LEFT.did = RIGHT.did	);
	DS6	:= 	JOIN(DS5,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__stname
									, LEFT.did = RIGHT.did	);
	DS7	:= 	JOIN(DS6,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__autokey__zip
									, LEFT.did = RIGHT.did	);
	DS8	:= 	JOIN(DS7,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__did
									, LEFT.did = RIGHT.did	);
	DS9	:= 	JOIN(DS8,PRTE_CSV.Hunting_Fishing.dthor_data400__key__Hunting_Fishing__rid
									, LEFT.did = (unsigned6) RIGHT.did_out	);			// Or should this join on RID? Payload has RID if it is populated.
									// , LEFT.rid = RIGHT.rid	);			// ?????

	DSFinal := PROJECT( DS9, finalMasterLayout);
	DSAlpharetta := PRTE2_Hunting_Fishing.Files.HuntFish_Alpha_SF_DS;
	DSBuild := DSFinal + DSAlpharetta;
	
	dKeyHunting_Fishing__autokey__address			:= 	project( DSBuild, rKeyHunting_Fishing__autokey__address);	
	// city_code
	// dph_lname
	// pfname
	// states
	// lname1
	// lname2
	// lname3
	// lookups
	dKeyHunting_Fishing__autokey__citystname	:= 	project( DSBuild, rKeyHunting_Fishing__autokey__citystname);
	// (unsigned) dob
	// city_code	dph_lname	pfname	states	lname1 lname2	lname3 
	// fname1
	// fname2
	// fname3
	// city1	city2	city3	rel_fname1	rel_fname2	rel_fname3
	// lookups
	
	dKeyHunting_Fishing__autokey__name				:= 	project( DSBuild, rKeyHunting_Fishing__autokey__name);
	// (unsigned) dob
	// city_code	dph_lname	pfname	states	lname1 lname2	lname3 
	// minit
	// yob
	// s4
	// city1	city2	city3	rel_fname1	rel_fname2	rel_fname3
	// lookups

	dKeyHunting_Fishing__autokey__payload			:= 	project( DSBuild, rKeyHunting_Fishing__autokey__payload);	
	// fakeid
	// zero
	// blank
	// rid
	// persistent_record_id
	// s1,s2,s3,s4,s5,s6,s7,s8,s9
	// dph_lname	pfname	lookups
	
	dKeyHunting_Fishing__autokey__ssn2				:= 	project( DSBuild, rKeyHunting_Fishing__autokey__ssn2);
	// s1,s2,s3,s4,s5,s6,s7,s8,s9
	// dph_lname	pfname	lookups
	
	dKeyHunting_Fishing__autokey__stname			:= 	project( DSBuild, rKeyHunting_Fishing__autokey__stname);
	// (UNSIGNED) zip dob	
	// city_code	dph_lname	pfname	states	lname1 lname2	lname3 
	// minit
	// yob
	// s4
	// city1	city2	city3	rel_fname1	rel_fname2	rel_fname3
	// lookups

	
	dKeyHunting_Fishing__autokey__zip					:= 	project( DSBuild, rKeyHunting_Fishing__autokey__zip);	
	// (UNSIGNED) zip dob	
	// dph_lname	pfname	states	lname1 lname2	lname3 
	// minit
	// yob
	// s4
	// city1	city2	city3	rel_fname1	rel_fname2	rel_fname3
	// lookups
	
	
	dKeyHunting_Fishing__did									:= 	project( DSBuild, rKeyHunting_Fishing__did);
	// rid
	
	dKeyHunting_Fishing__rid					 				:= 	project( DSBuild, rKeyHunting_Fishing__rid);	
	// rid
	// persistent_record_id
	// __internal_fpos__
	
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

	UpdateVersionSteps := sequential(
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
  doUpdateSteps := IF( isUpdateVersion, UpdateVersionSteps, OUTPUT('DOPS Update is being bypassed during this build') );
	
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
										 );

end;
