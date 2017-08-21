//Change D$ records into the PHeader Key format	//
//See doxie.header_pre_keybuild	//

IMPORT Compliance, header, Census_data, Gong, Watchdog, did_add, ut, doxie_build,mdr;

/*
head0 := doxie_build.file_header_building; 
head:=project(head0,transform({head0}
												,self.ssn:=if(mdr.sourceTools.sourceIsUtility(left.src),'',left.ssn)
												,self.valid_ssn:=if(mdr.sourceTools.sourceIsUtility(left.src),'',left.valid_ssn)
												,self:=left)
												);
*/

file_Death_restricted_as_Header := Compliance.Death_restricted_as_Header(Header.File_DID_Death_MasterV3_ssa);
head := file_Death_restricted_as_Header(did > 0);

/* **************** get County Name from County Code ****************** */
xHead_Layout :=
RECORD
	head;
	string1 valid_dob := '';
	unsigned6 hhid := 0;
	STRING18 county_name := '';
	STRING120 listed_name := '';
	STRING10 listed_phone := '';
	unsigned4 dod := 0;
	STRING1 death_code := '';
	unsigned4 lookup_did := 0;
END;

xHead_Layout getCountyName(head le, Census_data.File_Fips2County ri) :=
TRANSFORM
	SELF.county_name := ri.county_name;
	SELF := le;
END;

with_county := JOIN(head, Census_data.File_Fips2County, 
										LEFT.county = RIGHT.county_fips 
										AND LEFT.st = RIGHT.state_code, 
										getCountyName(LEFT, RIGHT)
										,lookup
										,LEFT OUTER);

/* ******************  Combine lookups, hhid, death, and best matches into 1 ******************** */
Combined_Layout :=
	RECORD
	//	doxie.exp_lookups;
		unsigned6 did := 0;
		
		Header.File_HHID_Current.hhid_relat;
		
	//	header.File_Did_Death_Master.dod8;
	//	header.File_Did_Death_Master.VorP_code;
		Header.File_DID_Death_MasterV3_ssa.dod8;
		Header.File_DID_Death_MasterV3_ssa.VorP_code;

		Watchdog.File_Best.prim_range;
		Watchdog.File_Best.prim_name;
		Watchdog.File_Best.sec_range;
		Watchdog.File_Best.zip;
		Watchdog.File_Best.dob;
		Watchdog.File_Best.ssn;
	END;

//Combined_Layout startLookups(doxie.exp_lookups le, Header.File_HHID_Current ri) :=
Combined_Layout startLookups(Header.File_DID_Death_MasterV3_ssa le, Header.File_HHID_Current ri) :=
	TRANSFORM
		SELF.did := IF((unsigned6) le.did <> 0, (unsigned6) le.did, ri.did);
		SELF := ri;
		SELF := le;
		
//		SELF.dod8 := '';
//		SELF.VorP_code := '';
		
		SELF.prim_range := '';
		SELF.prim_name := '';
		SELF.sec_range := '';
		SELF.zip := '';
		SELF.dob := 0;
//		SELF.ssn := '';
	END;

//with_lookups := JOIN(DISTRIBUTE(doxie.exp_lookups, HASH((unsigned6)did)), 
with_lookups := JOIN(DISTRIBUTE(Header.File_DID_Death_MasterV3_ssa, HASH((unsigned6)did)), 
										 DISTRIBUTE(Header.File_HHID_Current(ver = 1), HASH((unsigned6)did)), 
										 (unsigned6) LEFT.did = RIGHT.did
										 ,startLookups(LEFT, RIGHT)
										 ,FULL OUTER
										 ,LOCAL
										 );

//Combined_Layout getDeath(Combined_Layout le, header.File_Did_Death_Master ri) :=
Combined_Layout getDeath(Combined_Layout le, Header.File_DID_Death_MasterV3_ssa ri) :=
TRANSFORM
	SELF.did := IF(le.did <> 0, le.did, (unsigned6)ri.did);
	SELF.dod8 := ri.dod8;
	SELF.VorP_code := ri.VorP_code;
	SELF := le;
END;

//dedup death by did; many dids have more than one VorP_code - a value in this field means death was verified
//death0:=sort(DISTRIBUTE(header.File_Did_Death_Master((unsigned6)did != 0), HASH((unsigned6)did)),did,local);
death0:=sort(DISTRIBUTE(header.File_DID_Death_MasterV3_ssa((unsigned6)did != 0), HASH((unsigned6)did)),did,local);

death:=ROLLUP(death0
							,left.did=right.did
							,TRANSFORM({death0}
								,self.dod8:=MAX(left.dod8,right.dod8)
								,self.VorP_code:=MAX(left.VorP_code,right.VorP_code)
								,self:=left)
							,local
							);

with_death := JOIN(with_lookups, death
									,LEFT.did = (unsigned6)RIGHT.did
									,getDeath(LEFT, RIGHT)
									,FULL OUTER
									,LOCAL
									);

Combined_Layout getBest(Combined_Layout le, Watchdog.File_Best ri) :=
	TRANSFORM
		SELF.did := IF(le.did <> 0, le.did, (unsigned6)ri.did);
		SELF.prim_range := ri.prim_range;
		SELF.prim_name := ri.prim_name;
		SELF.sec_range := ri.sec_range;
		SELF.zip := ri.zip;
		SELF.dob := ri.dob;
		SELF.ssn := ri.ssn;
		SELF := le;
	END;

// address pieces with most permissions because this is only an indicator, try ssn and dob
with_best_try := JOIN(with_death, Watchdog.File_Best
											,LEFT.did = RIGHT.did
											,getBest(LEFT, RIGHT)
											,FULL OUTER
											,LOCAL
											);
/*
// dob/ssn with least permissions to check
Combined_Layout checkBest(Combined_Layout le, Watchdog.File_Best_nonglb_nonutility ri) :=
	TRANSFORM
		SELF.ssn := IF(le.ssn=ri.ssn,le.ssn,'');
		SELF.dob := IF(le.dob=ri.dob,le.dob,0);
		SELF := le;
	END;

with_best := JOIN(with_best_try, Watchdog.File_Best_nonglb
									,LEFT.did = RIGHT.did
									,checkBest(LEFT, RIGHT)
									,LEFT OUTER
									,LOCAL
									);
*/

addrMatch1 := 
	MACRO
		DID_Add.Address_Match_Score(LE.prim_range, LE.prim_name, LE.sec_range, LE.zip, 
								RI.prim_range, RI.prim_name, RI.sec_range, RI.zip) > 75 AND
		DID_Add.Address_Match_Score(LE.prim_range, LE.prim_name, LE.sec_range, LE.zip, 
								RI.prim_range, RI.prim_name, RI.sec_range, RI.zip) < 255 AND le.prim_range=ri.prim_range
	ENDMACRO;
		
xHead_Layout getHHid(xHead_Layout le, Combined_Layout ri) :=
	TRANSFORM
		SELF.did := le.did;
		SELF.hhid := ri.hhid_relat;
		
		SELF.dod := (unsigned)ri.dod8;
		SELF.death_code := ri.VorP_code;
		
		SELF.TNT := 'D';	//D = Dead
		self.dob := IF(le.dob=0,ri.dob,le.dob);
		self.valid_dob := IF(le.dob=0 and ri.dob<>0,'M',le.valid_dob);
		self.ssn := IF((unsigned)le.ssn=0,ri.ssn,le.ssn);
		self.valid_ssn := IF((unsigned)le.ssn=0 and (unsigned)ri.ssn<>0,'M',le.valid_ssn);
/*	
		SELF.lookup_did := 	  doxie.lookup_setter(ri.sex_cnt,			'SEX') |
							doxie.lookup_setter(ri.crim_cnt, 		'CRIM') |
							doxie.lookup_setter(ri.ccw_cnt, 			'CCW') |
							doxie.lookup_setter(ri.veh_cnt, 			'VEH') |
							doxie.lookup_setter(ri.dl_cnt, 			'DL') |
							doxie.lookup_setter(ri.rel_count, 		'REL') |
							doxie.lookup_setter(ri.fire_count, 		'FIRE') |
							doxie.lookup_setter(ri.faa_count, 		'FAA') |
							doxie.lookup_setter(ri.vess_count, 		'VESS') |
							doxie.lookup_setter(ri.prof_count, 		'PROF') |
							doxie.lookup_setter(ri.bus_count, 		'BUS') | 
							doxie.lookup_setter(ri.prop_count, 		'PROP') | 
							doxie.lookup_setter(ri.bk_count, 		'BK') |
							doxie.lookup_setter(ri.paw_count, 		'PAW') | 
							doxie.lookup_setter(ri.bc_count, 		'BC') | 
							doxie.lookup_setter(ri.prop_asses_count, 	'PROP_ASSES') | 
							doxie.lookup_setter(ri.prop_deeds_count, 	'PROP_DEEDS') |
							doxie.lookup_setter(ri.prov_count, 	'PROV') | 
							doxie.lookup_setter(ri.sanc_count, 	'SANC') |  ut.bit_set(0,0);
*/
		SELF := le;
	END;

//with_appends := JOIN(with_county, with_best, 
with_appends := JOIN(with_county, with_best_try, 
										 LEFT.did = RIGHT.did
										 ,getHHid(LEFT, RIGHT)
										 ,LEFT OUTER
										 ,LOCAL
										 );

/*
set_external_srcs:=['TN','TS','TU','LT'];
segmented_h := Header.fn_ADLSegmentation_v2(head(src not in set_external_srcs)).core_check;

xHead_Layout get_lookups(with_appends le, segmented_h ri) :=
TRANSFORM
	SELF.lookup_did := le.lookup_did | ut.bit_set(0,doxie.lookup_bit(ri.ind));
	self := le;
END;

with_segmented := JOIN(with_appends,segmented_h,left.did=right.did,get_lookups(LEFT,RIGHT), LOCAL): PERSIST('persist::header_pre_keybuild');
*/

Layout_as_PHDR_key := {with_appends} - [DOD_from_LNDMF];

Layout_as_PHDR_key xfm_as_PHDR_key(with_appends LE) :=
	TRANSFORM
		SELF.dod := (unsigned4) LE.DOD_from_LNDMF;
		SELF := LE;
	END;
	
//export header_pre_keybuild := with_segmented;
EXPORT Death_restricted_as_PHDR_Key := PROJECT(with_appends,xfm_as_PHDR_key(LEFT));

//--------------------------------------------------------------------------------------------
//OUTPUT(Death_restricted_as_PHDR_Key);
//OUTPUT(COUNT(Death_restricted_as_PHDR_Key));