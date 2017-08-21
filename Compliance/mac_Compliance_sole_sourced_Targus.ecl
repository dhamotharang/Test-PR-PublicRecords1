//Results from "mac_Compliance_sole_sourced_PHdr_extract_V2" are required.
//Then see the EXAMPLE below the macro

EXPORT mac_Compliance_sole_sourced_TARGUS(infile,eval_case = '',row_ID = 0, source_field,outfile) := 
  MACRO
	
//		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
		rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;
	
		PHdr_extract := DATASET('~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv'
																,rec_PHdr_extract
																,CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------

//Sole-sourced from:
//h.	Targus 

set_TARGUS := [mdr.sourcetools.src_Targus_White_pages	//    := 'WP';
							 ,mdr.sourcetools.src_Targus_Gateway		//    := 'TG';
							];


rec_criteria := 
	RECORD
		rec_PHdr_extract;
		Compliance.Layout_has_PII;
		
		boolean src_is_TARGUS;
		boolean src_is_not_TARGUS;
		
	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_TARGUS					:= LE.src IN set_TARGUS;
	 self.src_is_not_TARGUS     := self.src_is_TARGUS = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 self.has_DOD              := IF(LE.DOD_from_LNDMF <> '',true,false);
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

//----------------

set_name_TARGUS := 'TARGUS';

//segment_name := 'CORE';
segment_name := '_All_SEGMENTS_';

//----------------

// Make sure to use Header data, not Key (Best) data, for sole-sourced //

layout_no_Header_KEY := Header.layout_header_v2 - [did,src,dt_last_seen,dt_vendor_last_reported];

rec_infile_slim := {infile} - layout_no_Header_KEY;

rec_infile_sole_source := 
	RECORD
		rec_infile_slim;
		unsigned6 result_rid;
	END;
		
infile_slim := PROJECT(infile, transform({rec_infile_sole_source}, self.result_rid := left.rid; self := left)
											);

infile_slim_sample := output(infile_slim, named('infile_slim'+'_sample'));

//---------------------------------------------------------------

#OPTION('multiplePersistInstances',FALSE); 

is_TARGUS := infile_slim.source_field IN set_TARGUS;
					

	//--- 1. Sole-sourced DIDs

PHDR_extract_DIDs_TARGUS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_TARGUS = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_TARGUS_sample := output(choosen(PHDR_extract_DIDs_TARGUS, 200), named('sample'+'_'+'PHDR_extract_DIDs_TARGUS'));

PHDR_extract_DIDs_nonTARGUS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_TARGUS = true), hash(did)), did, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_nonTARGUS_sample := output(choosen(PHDR_extract_DIDs_nonTARGUS, 200), named('sample'+'_'+'PHDR_extract_DIDs_nonTARGUS'));

PHDR_extract_DIDs_src_TARGUS := JOIN(sort(distribute(PHDR_extract_DIDs_TARGUS, hash(did)), did, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DIDs_nonTARGUS, hash(did)), did, local,skew(1.0))	
																	 ,left.did = right.did
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDs'+'_'+set_name_TARGUS+'_'+eval_case)
																	;

sample_extract_DIDs_TARGUS := OUTPUT(PHDR_extract_DIDs_src_TARGUS, named('PHDR_extract_DIDs'+'_'+set_name_TARGUS+'_'+eval_case+'_sample'));
count_extract_DIDs_TARGUS  := OUTPUT(count(PHDR_extract_DIDs_src_TARGUS), named('PHDR_extract_DIDs'+'_'+set_name_TARGUS+'_'+eval_case+'_count'));


DIDs_solesrc_TARGUS := JOIN(sort(distribute(infile_slim(is_TARGUS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDs_src_TARGUS, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
																AND left.result_rid = right.rid

															,skew(1.0)
														 );	
									 
eval_DIDs_sole_sourced_TARGUS := OUTPUT(sort(distribute(DIDs_solesrc_TARGUS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDs_TARGUS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDs
		sole_sourced_unique_DIDs_TARGUS := DEDUP(sort(distribute(DIDs_solesrc_TARGUS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Sole_sourced_DID_values := OUTPUT(COUNT(sole_sourced_unique_DIDs_TARGUS), named('Sole_sourced_DID_values_'+set_name_TARGUS+'_'+eval_case));


//By Source: Sole-Sourced DIDs:
DIDs_by_Source_TARGUS := DEDUP(sort(distribute(DIDs_solesrc_TARGUS, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDs_by_Source_TARGUS := OUTPUT(TABLE(DIDs_by_Source_TARGUS,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidsBySource' + '_TARGUS'));

//By Search: Sole-Sourced DIDAddrs:
DIDs_by_Search_TARGUS := DEDUP(sort(distribute(DIDs_solesrc_TARGUS, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDs_by_Search_TARGUS := OUTPUT(TABLE(DIDs_by_Search_TARGUS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsBySearch' + '_TARGUS'));

//----------------------------------------------------

	//--- 2. Sole-sourced Names - at the DID level
		
PHDR_extract_Names_TARGUS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_TARGUS = true), hash(did)), did,lname,fname,mname,name_suffix, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_TARGUS_sample := output(choosen(PHDR_extract_Names_TARGUS, 200), named('sample'+'_'+'PHDR_extract_Names_TARGUS'));

PHDR_extract_Names_nonTARGUS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_TARGUS = true), hash(did)), did,lname,fname,mname,name_suffix, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_nonTARGUS_sample := output(choosen(PHDR_extract_Names_nonTARGUS, 200), named('sample'+'_'+'PHDR_extract_Names_nonTARGUS'));

PHDR_extract_DidNames_src_TARGUS := JOIN(sort(distribute(PHDR_extract_Names_TARGUS, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_Names_nonTARGUS, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))	
																			 ,left.did = right.did
																				AND trim(left.lname, all) = trim(right.lname, all)
																				AND trim(left.fname, all) = trim(right.fname, all)
																				AND trim(left.mname, all) = trim(right.mname, all)
																				AND trim(left.name_suffix, all) = trim(right.name_suffix, all)
																			 ,LEFT ONLY
																			 ,skew(1.0)
																			)
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidNames'+'_'+set_name_TARGUS+'_'+eval_case)
																			;

sample_extract_DIDNames_TARGUS := OUTPUT(PHDR_extract_DidNames_src_TARGUS, named('PHDR_extract_DidNames'+'_'+set_name_TARGUS+'_'+eval_case+'_sample'));
count_extract_DIDNames_TARGUS  := OUTPUT(count(PHDR_extract_DidNames_src_TARGUS), named('PHDR_extract_DidNames'+'_'+set_name_TARGUS+'_'+eval_case+'_count'));


DIDNames_solesrc_TARGUS := JOIN(sort(distribute(infile_slim(is_TARGUS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
																,sort(distribute(PHDR_extract_DIDNames_src_TARGUS, hash(did)), did,src,rid, local,skew(1.0))
																,(unsigned6) left.did = right.did
																	AND left.src = right.src
																	AND left.result_rid = right.rid

																,skew(1.0)
															 );	
									 
eval_DIDNames_sole_sourced_TARGUS := OUTPUT(sort(distribute(DIDNames_solesrc_TARGUS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDNames_TARGUS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDNames
		sole_sourced_unique_DIDNames_TARGUS := DEDUP(sort(distribute(DIDNames_solesrc_TARGUS, hash(did))
																										, did,lname,fname,mname,name_suffix, local,skew(1.0))
																								, did,lname,fname,mname,name_suffix, all,local);

		Sole_sourced_Name_values := OUTPUT(COUNT(sole_sourced_unique_DIDNames_TARGUS), named('Sole_sourced_Name_values_'+set_name_TARGUS+'_'+eval_case));

		DIDs_with_unique_DIDNames_TARGUS := DEDUP(sort(distribute(DIDNames_solesrc_TARGUS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Name_values := OUTPUT(COUNT(DIDs_with_unique_DIDNames_TARGUS), named('DIDs_with_unique_DIDNames_'+set_name_TARGUS+'_'+eval_case));

//By Source: Sole-Sourced DIDNames:
DIDNames_by_Source_TARGUS := DEDUP(sort(distribute(DIDNames_solesrc_TARGUS, hash(source_field,did))
																			, source_field,did, local,skew(1.0))
																	, source_field,did, all,local);
										
tbl_DIDNames_by_Source_TARGUS := OUTPUT(TABLE(DIDNames_by_Source_TARGUS,
																								{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																									source_field, few)
																				, all, named('SoleSourcedDidNamesBySource' + '_TARGUS'));

//By Search: Sole-Sourced DIDNames:
DIDNames_by_Search_TARGUS := DEDUP(sort(distribute(DIDNames_solesrc_TARGUS, hash(row_ID,did))
																				, row_ID,did, local,skew(1.0))
																		, row_ID,did, all,local);
										
tbl_DIDNames_by_Search_TARGUS := OUTPUT(TABLE(DIDNames_by_Search_TARGUS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidNamesBySearch' + '_TARGUS'));

//---------------------------

	//--- 3. Sole-sourced Addresses - at the DID level
		
PHDR_extract_Addrs_TARGUS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_TARGUS = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_TARGUS_sample := output(choosen(PHDR_extract_Addrs_TARGUS, 200), named('sample'+'_'+'PHDR_extract_Addrs_TARGUS'));

PHDR_extract_Addrs_nonTARGUS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_TARGUS = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_nonTARGUS_sample := output(choosen(PHDR_extract_Addrs_nonTARGUS, 200), named('sample'+'_'+'PHDR_extract_Addrs_nonTARGUS'));

PHDR_extract_DidAddrs_src_TARGUS := JOIN(sort(distribute(PHDR_extract_Addrs_TARGUS, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_Addrs_nonTARGUS, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))	
																			 ,left.did = right.did
																			 AND trim(left.zip, all) = trim(right.zip, all)
																			 AND trim(left.prim_range, all) = trim(right.prim_range, all)
																			 AND trim(left.predir, all) = trim(right.predir, all)
																			 AND trim(left.prim_name, all) = trim(right.prim_name, all)
																			 AND trim(left.postdir, all) = trim(right.postdir, all)
																			 AND (trim(left.sec_range, all) = trim(right.sec_range, all) OR (unsigned3) left.sec_range = (unsigned3) right.sec_range)
																			 ,LEFT ONLY
																			 ,skew(1.0)
																			)
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidAddrs'+'_'+set_name_TARGUS+'_'+eval_case)
																			;

sample_extract_DIDAddrs_TARGUS := OUTPUT(PHDR_extract_DidAddrs_src_TARGUS, named('PHDR_extract_DidAddrs'+'_'+set_name_TARGUS+'_'+eval_case+'_sample'));
count_extract_DIDAddrs_TARGUS  := OUTPUT(count(PHDR_extract_DidAddrs_src_TARGUS), named('PHDR_extract_DidAddrs'+'_'+set_name_TARGUS+'_'+eval_case+'_count'));


DIDAddrs_solesrc_TARGUS := JOIN(sort(distribute(infile_slim(is_TARGUS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
																	,sort(distribute(PHDR_extract_DIDAddrs_src_TARGUS, hash(did)), did,src,rid, local,skew(1.0))
																	,(unsigned6) left.did = right.did
																		AND left.src = right.src
																		AND left.result_rid = right.rid

																	,skew(1.0)
																 );	
									 
eval_DIDAddrs_sole_sourced_TARGUS := OUTPUT(sort(distribute(DIDAddrs_solesrc_TARGUS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDAddrs_TARGUS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDAddrs
		sole_sourced_unique_DIDAddrs_TARGUS := DEDUP(sort(distribute(DIDAddrs_solesrc_TARGUS, hash(did))
																											, did, zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																									, did, zip,prim_range,predir,prim_name,postdir,sec_range, all,local);

		Sole_sourced_Address_values := OUTPUT(COUNT(sole_sourced_unique_DIDAddrs_TARGUS), named('Sole_sourced_Address_values_'+set_name_TARGUS+'_'+eval_case));

		DIDs_with_unique_DIDAddrs_TARGUS := DEDUP(sort(distribute(DIDAddrs_solesrc_TARGUS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Addr_values := OUTPUT(COUNT(DIDs_with_unique_DIDAddrs_TARGUS), named('DIDs_with_unique_DIDAddrs_'+set_name_TARGUS+'_'+eval_case));

//By Source: Sole-Sourced DIDAddrs:
DIDAddrs_by_Source_TARGUS := DEDUP(sort(distribute(DIDAddrs_solesrc_TARGUS, hash(source_field,did))
																			, source_field,did, local,skew(1.0))
																	, source_field,did, all,local);
										
tbl_DIDAddrs_by_Source_TARGUS := OUTPUT(TABLE(DIDAddrs_by_Source_TARGUS,
																									{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																										source_field, few)
																					, all, named('SoleSourcedDidAddrsBySource' + '_TARGUS'));

//By Search: Sole-Sourced DIDAddrs:
DIDAddrs_by_Search_TARGUS := DEDUP(sort(distribute(DIDAddrs_solesrc_TARGUS, hash(row_ID,did))
																			, row_ID,did, local,skew(1.0))
																	, row_ID,did, all,local);
										
tbl_DIDAddrs_by_Search_TARGUS := OUTPUT(TABLE(DIDAddrs_by_Search_TARGUS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidAddrsBySearch' + '_TARGUS'));

//---------------------------------------------------------------

	//--- 4. Sole-sourced SSNs - at the DID level
		
PHDR_extract_SSNs_TARGUS := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_TARGUS = true), hash(did)), did,SSN, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_TARGUS_sample := output(choosen(PHDR_extract_SSNs_TARGUS, 200), named('sample'+'_'+'PHDR_extract_SSNs_TARGUS'));

PHDR_extract_SSNs_nonTARGUS := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_not_TARGUS = true), hash(did)), did,SSN, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_nonTARGUS_sample := output(choosen(PHDR_extract_SSNs_nonTARGUS, 200), named('sample'+'_'+'PHDR_extract_SSNs_nonTARGUS'));

PHDR_extract_DidSSNs_src_TARGUS := JOIN(sort(distribute(PHDR_extract_SSNs_TARGUS, hash(did)), did,SSN, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_SSNs_nonTARGUS, hash(did)), did,SSN, local,skew(1.0))	
																			 ,left.did = right.did
																			 AND (unsigned6) left.SSN = (unsigned6) right.SSN
																			 ,LEFT ONLY
																			 ,skew(1.0)
																			)
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidSSNs'+'_'+set_name_TARGUS+'_'+eval_case)
																			;

sample_extract_DIDSSNs_TARGUS := OUTPUT(PHDR_extract_DidSSNs_src_TARGUS, named('PHDR_extract_DidSSNs'+'_'+set_name_TARGUS+'_'+eval_case+'_sample'));
count_extract_DIDSSNs_TARGUS  := OUTPUT(count(PHDR_extract_DidSSNs_src_TARGUS), named('PHDR_extract_DidSSNs'+'_'+set_name_TARGUS+'_'+eval_case+'_count'));


DIDSSNs_solesrc_TARGUS := JOIN(sort(distribute(infile_slim(is_TARGUS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDSSNs_src_TARGUS, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
																AND left.result_rid = right.rid

															,skew(1.0)
														 );	
									 
eval_DIDSSNs_sole_sourced_TARGUS := OUTPUT(sort(distribute(DIDSSNs_solesrc_TARGUS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDSSNs_TARGUS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDSSNs
		sole_sourced_unique_DIDSSNs_TARGUS := DEDUP(sort(distribute(DIDSSNs_solesrc_TARGUS, hash(did))
																								, did, SSN, local,skew(1.0))
																						, did, SSN, all,local);

		Sole_sourced_SSN_values := OUTPUT(COUNT(sole_sourced_unique_DIDSSNs_TARGUS), named('Sole_sourced_SSN_values_'+set_name_TARGUS+'_'+eval_case));

		DIDs_with_unique_DIDSSNs_TARGUS := DEDUP(sort(distribute(DIDSSNs_solesrc_TARGUS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_SSN_values := OUTPUT(COUNT(DIDs_with_unique_DIDSSNs_TARGUS), named('DIDs_with_unique_DIDSSNs_'+set_name_TARGUS+'_'+eval_case));

//By Source: Sole-Sourced DIDSSNs:
DIDSSNs_by_Source_TARGUS := DEDUP(sort(distribute(DIDSSNs_solesrc_TARGUS, hash(source_field,did))
																			, source_field,did, local,skew(1.0))
																	, source_field,did, all,local);
										
tbl_DIDSSNs_by_Source_TARGUS := OUTPUT(TABLE(DIDSSNs_by_Source_TARGUS,
																								{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																									source_field, few)
																				, all, named('SoleSourcedDidSSNsBySource' + '_TARGUS'));

//By Search: Sole-Sourced DIDSSNs:
DIDSSNs_by_Search_TARGUS := DEDUP(sort(distribute(DIDSSNs_solesrc_TARGUS, hash(row_ID,did))
																			, row_ID,did, local,skew(1.0))
																	, row_ID,did, all,local);
										
tbl_DIDSSNs_by_Search_TARGUS := OUTPUT(TABLE(DIDSSNs_by_Search_TARGUS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidSSNsBySearch' + '_TARGUS'));

//---------------------------------------------------------------

	//--- 5. Sole-sourced DOBs - at the DID level
		
PHDR_extract_DOBs_TARGUS := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_TARGUS = true), hash(did)), did,DOB, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_TARGUS_sample := output(choosen(PHDR_extract_DOBs_TARGUS, 200), named('sample'+'_'+'PHDR_extract_DOBs_TARGUS'));

PHDR_extract_DOBs_nonTARGUS := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_not_TARGUS = true), hash(did)), did,DOB, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_nonTARGUS_sample := output(choosen(PHDR_extract_DOBs_nonTARGUS, 200), named('sample'+'_'+'PHDR_extract_DOBs_nonTARGUS'));

PHDR_extract_DidDOBs_src_TARGUS := JOIN(sort(distribute(PHDR_extract_DOBs_TARGUS, hash(did)), did,DOB, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_DOBs_nonTARGUS, hash(did)), did,DOB, local,skew(1.0))	
																			 ,left.did = right.did
																			 AND (unsigned6) left.DOB = (unsigned6) right.DOB
																			 ,LEFT ONLY
																			 ,skew(1.0)
																			)
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDOBs'+'_'+set_name_TARGUS+'_'+eval_case)
																			;

sample_extract_DIDDOBs_TARGUS := OUTPUT(PHDR_extract_DidDOBs_src_TARGUS, named('PHDR_extract_DidDOBs'+'_'+set_name_TARGUS+'_'+eval_case+'_sample'));
count_extract_DIDDOBs_TARGUS  := OUTPUT(count(PHDR_extract_DidDOBs_src_TARGUS), named('PHDR_extract_DidDOBs'+'_'+set_name_TARGUS+'_'+eval_case+'_count'));


DIDDOBs_solesrc_TARGUS := JOIN(sort(distribute(infile_slim(is_TARGUS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDDOBs_src_TARGUS, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
																AND left.result_rid = right.rid

															,skew(1.0)
														 );	
									 
eval_DIDDOBs_sole_sourced_TARGUS := OUTPUT(sort(distribute(DIDDOBs_solesrc_TARGUS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDOBs_TARGUS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDOBs
		sole_sourced_unique_DIDDOBs_TARGUS := DEDUP(sort(distribute(DIDDOBs_solesrc_TARGUS, hash(did))
																										, did, DOB, local,skew(1.0))
																								, did, DOB, all,local);

		Sole_sourced_DOB_values := OUTPUT(COUNT(sole_sourced_unique_DIDDOBs_TARGUS), named('Sole_sourced_DOB_values_'+set_name_TARGUS+'_'+eval_case));

		DIDs_with_unique_DIDDOBs_TARGUS := DEDUP(sort(distribute(DIDDOBs_solesrc_TARGUS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOB_values := OUTPUT(COUNT(DIDs_with_unique_DIDDOBs_TARGUS), named('DIDs_with_unique_DIDDOBs_'+set_name_TARGUS+'_'+eval_case));

//By Source: Sole-Sourced DIDDOBs:
DIDDOBs_by_Source_TARGUS := DEDUP(sort(distribute(DIDDOBs_solesrc_TARGUS, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDDOBs_by_Source_TARGUS := OUTPUT(TABLE(DIDDOBs_by_Source_TARGUS,
																								{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																									source_field, few)
																				, all, named('SoleSourcedDidDOBsBySource' + '_TARGUS'));

//By Search: Sole-Sourced DIDDOBs:
DIDDOBs_by_Search_TARGUS := DEDUP(sort(distribute(DIDDOBs_solesrc_TARGUS, hash(row_ID,did))
																			, row_ID,did, local,skew(1.0))
																	, row_ID,did, all,local);
										
tbl_DIDDOBs_by_Search_TARGUS := OUTPUT(TABLE(DIDDOBs_by_Search_TARGUS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDOBsBySearch' + '_TARGUS'));

//---------------------------------------------------------------

	//--- 6. Sole-sourced DLs - at the DID level
		
PHDR_extract_DLs_TARGUS := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_TARGUS = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_TARGUS_sample := output(choosen(PHDR_extract_DLs_TARGUS, 200), named('sample'+'_'+'PHDR_extract_DLs_TARGUS'));

PHDR_extract_DLs_nonTARGUS := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_not_TARGUS = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_nonTARGUS_sample := output(choosen(PHDR_extract_DLs_nonTARGUS, 200), named('sample'+'_'+'PHDR_extract_DLs_nonTARGUS'));

PHDR_extract_DidDLs_src_TARGUS := JOIN(sort(distribute(PHDR_extract_DLs_TARGUS, hash(did)), did,vendor_id, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_DLs_nonTARGUS, hash(did)), did,vendor_id, local,skew(1.0))	
																		 ,left.did = right.did
																			AND trim(left.vendor_id, all) = trim(right.vendor_id, all)
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDLs'+'_'+set_name_TARGUS+'_'+eval_case)
																		;

sample_extract_DIDDLs_TARGUS := OUTPUT(PHDR_extract_DidDLs_src_TARGUS, named('PHDR_extract_DidDLs'+'_'+set_name_TARGUS+'_'+eval_case+'_sample'));
count_extract_DIDDLs_TARGUS  := OUTPUT(count(PHDR_extract_DidDLs_src_TARGUS), named('PHDR_extract_DidDLs'+'_'+set_name_TARGUS+'_'+eval_case+'_count'));


DIDDLs_solesrc_TARGUS := JOIN(sort(distribute(infile_slim(is_TARGUS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDDLs_src_TARGUS, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
																AND left.result_rid = right.rid

															,skew(1.0)
														 );	
									 
eval_DIDDLs_sole_sourced_TARGUS := OUTPUT(sort(distribute(DIDDLs_solesrc_TARGUS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDLs_TARGUS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDLs
		sole_sourced_unique_DIDDLs_TARGUS := DEDUP(sort(distribute(DIDDLs_solesrc_TARGUS, hash(did))
																										, did, vendor_id, local,skew(1.0))
																								, did, vendor_id, all,local);

		Sole_sourced_DL_values := OUTPUT(COUNT(sole_sourced_unique_DIDDLs_TARGUS), named('Sole_sourced_DL_values_'+set_name_TARGUS+'_'+eval_case));

		DIDs_with_unique_DIDDLs_TARGUS := DEDUP(sort(distribute(DIDDLs_solesrc_TARGUS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DL_values := OUTPUT(COUNT(DIDs_with_unique_DIDDLs_TARGUS), named('DIDs_with_unique_DIDDLs_'+set_name_TARGUS+'_'+eval_case));

//By Source: Sole-Sourced DIDDLs:
DIDDLs_by_Source_TARGUS := DEDUP(sort(distribute(DIDDLs_solesrc_TARGUS, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDDLs_by_Source_TARGUS := OUTPUT(TABLE(DIDDLs_by_Source_TARGUS,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidDLsBySource' + '_TARGUS'));

//By Search: Sole-Sourced DIDDLs:
DIDDLs_by_Search_TARGUS := DEDUP(sort(distribute(DIDDLs_solesrc_TARGUS, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDDLs_by_Search_TARGUS := OUTPUT(TABLE(DIDDLs_by_Search_TARGUS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDLsBySearch' + '_TARGUS'));

//--------------------------------------------------------------------------------------

rec_All_sole_sourced :=
	RECORD
		DIDs_solesrc_TARGUS;
		string sole_source_category := '';
	END;
	

All_sole_sourced_TARGUS := project(DIDs_solesrc_TARGUS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDs_' + 'TARGUS', self := left))
													+
												  project(DIDNames_solesrc_TARGUS , transform(rec_All_sole_sourced, self.sole_source_category := 'DIDNames_' + 'TARGUS', self := left))
													+
												  project(DIDAddrs_solesrc_TARGUS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDAddrs_' + 'TARGUS', self := left))
													+
												  project(DIDSSNs_solesrc_TARGUS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDSSNs_' + 'TARGUS', self := left))
													+
												  project(DIDDOBs_solesrc_TARGUS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDOBs_' + 'TARGUS', self := left))
												 +
												  project(DIDDLs_solesrc_TARGUS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDLs_' + 'TARGUS', self := left))
												 :PERSIST('~thor400_92::persist::ckelly::ALL_sole_sourced_'+set_name_TARGUS+'_'+eval_case)
												 ;

eval_ALL_sole_sourced_TARGUS := OUTPUT(sort(distribute(All_sole_sourced_TARGUS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_ALL_TARGUS' + '_' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
All_sole_sourced_rows_count := OUTPUT(COUNT(All_sole_sourced_TARGUS), named('All_sole_sourced_rows_count' + '_TARGUS'));
Database_records := DEDUP(sort(distribute(All_sole_sourced_TARGUS,hash(did)), did,rid, local), did,rid, all,local);
Database_records_involving_sole_sourced_data := OUTPUT(COUNT(Database_records), named('Total_Number_of_database_records_involving_any_sole_sourced_data' + '_TARGUS'));



//By Source: Sole-Sourced DIDs - All:
All_DIDs_by_Source_TARGUS := DEDUP(sort(distribute(All_sole_sourced_TARGUS, hash(source_field,did))
																			, source_field,did, local,skew(1.0))
																	, source_field,did, all,local);
												
Number_of_Sources_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Source_TARGUS,
																																{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																																	source_field, few)
																												, all, named('Number_of_Sources_involving_sole_sourced_data' + '_TARGUS'));

//By Search: Sole-Sourced DIDs - All:
All_DIDs_by_Search_TARGUS := DEDUP(sort(distribute(All_sole_sourced_TARGUS, hash(row_ID,did))
																			, row_ID,did, local,skew(1.0))
																	, row_ID,did, all,local);
										
Number_of_Searches_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Search_TARGUS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('Number_of_Searches_involving_sole_sourced_data' + '_TARGUS'));

//------------ Unique Count: Sole-sourced DIDs - ALL
		sole_sourced_unique_DID_ALL_TARGUS := DEDUP(sort(distribute(All_sole_sourced_TARGUS, hash(did))
																										, did, local,skew(1.0))
																								, did, all,local);

		Total_LexIDs_involving_any_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DID_ALL_TARGUS), named('Total_LexIDs_involving_any_sole_sourced_data' + '_TARGUS'));

//---------------------

outfile := 	PARALLEL(	Number_of_Searches_involving_sole_sourced_data
											,Number_of_Sources_involving_sole_sourced_data
											,Total_LexIDs_involving_any_sole_sourced_data
											,Database_records_involving_sole_sourced_data
											,All_sole_sourced_rows_count
											
											,Sole_sourced_DID_values
											,Sole_sourced_Name_values
											,Sole_sourced_Address_values
											,Sole_sourced_SSN_values
											,Sole_sourced_DOB_values
											,Sole_sourced_DL_values
											
											,DIDs_with_unique_Name_values
											,DIDs_with_unique_Addr_values
											,DIDs_with_unique_SSN_values
											,DIDs_with_unique_DOB_values
											,DIDs_with_unique_DL_values
											
											,eval_ALL_sole_sourced_TARGUS
											,eval_DIDs_sole_sourced_TARGUS
											,eval_DIDNames_sole_sourced_TARGUS
											,eval_DIDAddrs_sole_sourced_TARGUS
											,eval_DIDSSNs_sole_sourced_TARGUS
											,eval_DIDDOBs_sole_sourced_TARGUS
											,eval_DIDDLs_sole_sourced_TARGUS
											
											,tbl_DIDs_by_Source_TARGUS
											,tbl_DIDs_by_Search_TARGUS
											
											,tbl_DIDNames_by_Source_TARGUS
											,tbl_DIDNames_by_Search_TARGUS
											
											,tbl_DIDAddrs_by_Source_TARGUS
											,tbl_DIDAddrs_by_Search_TARGUS
											
											,tbl_DIDSSNs_by_Source_TARGUS
											,tbl_DIDSSNs_by_Search_TARGUS
											
											,tbl_DIDDOBs_by_Source_TARGUS
											,tbl_DIDDOBs_by_Search_TARGUS
											
											,tbl_DIDDLs_by_Source_TARGUS
											,tbl_DIDDLs_by_Search_TARGUS
											
											//For research if necessary:
											,infile_slim_sample,
											PHDR_extract_DIDs_TARGUS_sample,
											PHDR_extract_DIDs_nonTARGUS_sample,
											PHDR_extract_Names_TARGUS_sample,
											PHDR_extract_Names_nonTARGUS_sample,
											PHDR_extract_Addrs_TARGUS_sample,
											PHDR_extract_Addrs_nonTARGUS_sample,
											PHDR_extract_SSNs_TARGUS_sample,
											PHDR_extract_SSNs_nonTARGUS_sample,
											PHDR_extract_DOBs_TARGUS_sample,
											PHDR_extract_DOBs_nonTARGUS_sample,
											PHDR_extract_DLs_TARGUS_sample,
											PHDR_extract_DLs_nonTARGUS_sample,
											
											sample_extract_DIDs_TARGUS,count_extract_DIDs_TARGUS,
											sample_extract_DIDNames_TARGUS,count_extract_DIDNames_TARGUS,
											sample_extract_DIDAddrs_TARGUS,count_extract_DIDAddrs_TARGUS,
											sample_extract_DIDSSNs_TARGUS,count_extract_DIDSSNs_TARGUS,
											sample_extract_DIDDOBs_TARGUS,count_extract_DIDDOBs_TARGUS,
											sample_extract_DIDDLs_TARGUS,count_extract_DIDDLs_TARGUS
		
										 );
											 
	ENDMACRO;
//---------------------------------------------------------------------------------------------------------
