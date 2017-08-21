//Results from "mac_Compliance_sole_sourced_PHdr_extract_V2" are required.
//Then see the EXAMPLE below the macro

EXPORT mac_Compliance_sole_sourced_EQ(infile,eval_case = '',row_ID = 0, source_field, outfile) := 
  MACRO


//		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
		rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;
	
	
		PHdr_extract := DATASET('~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv'
																,rec_PHdr_extract
																,CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------

//Sole-sourced from:
//b.	Equifax 

set_Utility := ['UT',	//Utilities (Equifax/NCTUE)
								'UW',	//	Util Work Phone (Equifax/NCTUE)
								'ZK',	//	Z type Util Work Phone (Equifax/NCTUE)
								'ZT',	//	Z type Utilities (Equifax/NCTUE)
								'ZU'	//	Daily Z Type Utilites (Equifax/NCTUE)
								];


rec_criteria := 
	RECORD
		rec_PHdr_extract;
		Compliance.Layout_has_PII;
		
		boolean src_is_EQ;
		boolean src_is_not_EQ;
		
	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_EQ						:= LE.src IN mdr.sourcetools.set_Equifax OR LE.src IN set_Utility;//Sept 2014: Added Utility sources
	 self.src_is_not_EQ       := self.src_is_EQ = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 self.has_DOD              := IF(LE.DOD_from_LNDMF <> '',true,false);
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

//----------------

set_name_EQ := 'EQ';

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

is_EQ := infile_slim.source_field IN mdr.sourcetools.set_Equifax OR infile_slim.source_field IN set_Utility;
					

	//--- 1. Sole-sourced DIDs

PHDR_extract_DIDs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EQ = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_EQ_sample := output(choosen(PHDR_extract_DIDs_EQ, 200), named('sample'+'_'+'PHDR_extract_DIDs_EQ'));


PHDR_extract_DIDs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EQ = true), hash(did)), did, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_nonEQ_sample := output(choosen(PHDR_extract_DIDs_nonEQ, 200), named('sample'+'_'+'PHDR_extract_DIDs_nonEQ'));

PHDR_extract_DIDs_src_EQ := JOIN(sort(distribute(PHDR_extract_DIDs_EQ, hash(did)), did, local,skew(1.0))
																 ,sort(distribute(PHDR_extract_DIDs_nonEQ, hash(did)), did, local,skew(1.0))	
																 ,left.did = right.did
																 ,LEFT ONLY
																 ,skew(1.0)
																)
																:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDs'+'_'+set_name_EQ+'_'+eval_case)
																;

sample_extract_DIDs_EQ := OUTPUT(PHDR_extract_DIDs_src_EQ, named('PHDR_extract_DIDs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDs_EQ  := OUTPUT(count(PHDR_extract_DIDs_src_EQ), named('PHDR_extract_DIDs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


DIDs_solesrc_EQ := JOIN(sort(distribute(infile_slim(is_EQ), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
												,sort(distribute(PHDR_extract_DIDs_src_EQ, hash(did)), did,src,rid, local,skew(1.0))
												,(unsigned6) left.did = right.did
													AND left.src = right.src
													AND left.result_rid = right.rid

												,skew(1.0)
											 );	
									 
eval_DIDs_sole_sourced_EQ := OUTPUT(sort(distribute(DIDs_solesrc_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDs
		sole_sourced_unique_DIDs_EQ := DEDUP(sort(distribute(DIDs_solesrc_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Sole_sourced_DID_values := OUTPUT(COUNT(sole_sourced_unique_DIDs_EQ), named('Sole_sourced_DID_values_'+set_name_EQ+'_'+eval_case));


//By Source: Sole-Sourced DIDs:
DIDs_by_Source_EQ := DEDUP(sort(distribute(DIDs_solesrc_EQ, hash(source_field,did))
															, source_field,did, local,skew(1.0))
													, source_field,did, all,local);
										
tbl_DIDs_by_Source_EQ := OUTPUT(TABLE(DIDs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDAddrs:
DIDs_by_Search_EQ := DEDUP(sort(distribute(DIDs_solesrc_EQ, hash(row_ID,did))
															, row_ID,did, local,skew(1.0))
													, row_ID,did, all,local);
										
tbl_DIDs_by_Search_EQ := OUTPUT(TABLE(DIDs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsBySearch' + '_EQ'));

//----------------------------------------------------

	//--- 2. Sole-sourced Names - at the DID level
		
PHDR_extract_Names_EQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EQ = true), hash(did)), did,lname,fname,mname,name_suffix, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_EQ_sample := output(choosen(PHDR_extract_Names_EQ, 200), named('sample'+'_'+'PHDR_extract_Names_EQ'));

PHDR_extract_Names_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EQ = true), hash(did)), did,lname,fname,mname,name_suffix, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_nonEQ_sample := output(choosen(PHDR_extract_Names_nonEQ, 200), named('sample'+'_'+'PHDR_extract_Names_nonEQ'));

PHDR_extract_DidNames_src_EQ := JOIN(sort(distribute(PHDR_extract_Names_EQ, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_Names_nonEQ, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))	
																	 ,left.did = right.did
																		AND trim(left.lname, all) = trim(right.lname, all)
																		AND trim(left.fname, all) = trim(right.fname, all)
																		AND trim(left.mname, all) = trim(right.mname, all)
																		AND trim(left.name_suffix, all) = trim(right.name_suffix, all)
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidNames'+'_'+set_name_EQ+'_'+eval_case)
																	;

sample_extract_DIDNames_EQ := OUTPUT(PHDR_extract_DidNames_src_EQ, named('PHDR_extract_DidNames'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDNames_EQ  := OUTPUT(count(PHDR_extract_DidNames_src_EQ), named('PHDR_extract_DidNames'+'_'+set_name_EQ+'_'+eval_case+'_count'));


DIDNames_solesrc_EQ := JOIN(sort(distribute(infile_slim(is_EQ), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
													,sort(distribute(PHDR_extract_DIDNames_src_EQ, hash(did)), did,src,rid, local,skew(1.0))
													,(unsigned6) left.did = right.did
														AND left.src = right.src
														AND left.result_rid = right.rid

													,skew(1.0)
												 );	
									 
eval_DIDNames_sole_sourced_EQ := OUTPUT(sort(distribute(DIDNames_solesrc_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDNames_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDNames
		sole_sourced_unique_DIDNames_EQ := DEDUP(sort(distribute(DIDNames_solesrc_EQ, hash(did))
																								, did,lname,fname,mname,name_suffix, local,skew(1.0))
																						, did,lname,fname,mname,name_suffix, all,local);

		Sole_sourced_Name_values := OUTPUT(COUNT(sole_sourced_unique_DIDNames_EQ), named('Sole_sourced_Name_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDNames_EQ := DEDUP(sort(distribute(DIDNames_solesrc_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Name_values := OUTPUT(COUNT(DIDs_with_unique_DIDNames_EQ), named('DIDs_with_unique_DIDNames_'+set_name_EQ+'_'+eval_case));

//By Source: Sole-Sourced DIDNames:
DIDNames_by_Source_EQ := DEDUP(sort(distribute(DIDNames_solesrc_EQ, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDNames_by_Source_EQ := OUTPUT(TABLE(DIDNames_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidNamesBySource' + '_EQ'));

//By Search: Sole-Sourced DIDNames:
DIDNames_by_Search_EQ := DEDUP(sort(distribute(DIDNames_solesrc_EQ, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDNames_by_Search_EQ := OUTPUT(TABLE(DIDNames_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidNamesBySearch' + '_EQ'));

//---------------------------

	//--- 3. Sole-sourced Addresses - at the DID level
		
PHDR_extract_Addrs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EQ = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_EQ_sample := output(choosen(PHDR_extract_Addrs_EQ, 200), named('sample'+'_'+'PHDR_extract_Addrs_EQ'));

PHDR_extract_Addrs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EQ = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_nonEQ_sample := output(choosen(PHDR_extract_Addrs_nonEQ, 200), named('sample'+'_'+'PHDR_extract_Addrs_nonEQ'));

PHDR_extract_DidAddrs_src_EQ := JOIN(sort(distribute(PHDR_extract_Addrs_EQ, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_Addrs_nonEQ, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))	
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
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidAddrs'+'_'+set_name_EQ+'_'+eval_case)
																	;

sample_extract_DIDAddrs_EQ := OUTPUT(PHDR_extract_DidAddrs_src_EQ, named('PHDR_extract_DidAddrs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDAddrs_EQ  := OUTPUT(count(PHDR_extract_DidAddrs_src_EQ), named('PHDR_extract_DidAddrs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


DIDAddrs_solesrc_EQ := JOIN(sort(distribute(infile_slim(is_EQ), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDAddrs_src_EQ, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDAddrs_sole_sourced_EQ := OUTPUT(sort(distribute(DIDAddrs_solesrc_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDAddrs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDAddrs
		sole_sourced_unique_DIDAddrs_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(did))
																								, did, zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																						, did, zip,prim_range,predir,prim_name,postdir,sec_range, all,local);

		Sole_sourced_Address_values := OUTPUT(COUNT(sole_sourced_unique_DIDAddrs_EQ), named('Sole_sourced_Address_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDAddrs_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Addr_values := OUTPUT(COUNT(DIDs_with_unique_DIDAddrs_EQ), named('DIDs_with_unique_DIDAddrs_'+set_name_EQ+'_'+eval_case));

//By Source: Sole-Sourced DIDAddrs:
DIDAddrs_by_Source_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDAddrs_by_Source_EQ := OUTPUT(TABLE(DIDAddrs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidAddrsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDAddrs:
DIDAddrs_by_Search_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDAddrs_by_Search_EQ := OUTPUT(TABLE(DIDAddrs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidAddrsBySearch' + '_EQ'));

//---------------------------------------------------------------

	//--- 4. Sole-sourced SSNs - at the DID level
		
PHDR_extract_SSNs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_EQ = true), hash(did)), did,SSN, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_EQ_sample := output(choosen(PHDR_extract_SSNs_EQ, 200), named('sample'+'_'+'PHDR_extract_SSNs_EQ'));

PHDR_extract_SSNs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_not_EQ = true), hash(did)), did,SSN, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_nonEQ_sample := output(choosen(PHDR_extract_SSNs_nonEQ, 200), named('sample'+'_'+'PHDR_extract_SSNs_nonEQ'));

PHDR_extract_DidSSNs_src_EQ := JOIN(sort(distribute(PHDR_extract_SSNs_EQ, hash(did)), did,SSN, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_SSNs_nonEQ, hash(did)), did,SSN, local,skew(1.0))	
																	 ,left.did = right.did
																	 AND (unsigned6) left.SSN = (unsigned6) right.SSN
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidSSNs'+'_'+set_name_EQ+'_'+eval_case)
																	;

sample_extract_DIDSSNs_EQ := OUTPUT(PHDR_extract_DidSSNs_src_EQ, named('PHDR_extract_DidSSNs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDSSNs_EQ  := OUTPUT(count(PHDR_extract_DidSSNs_src_EQ), named('PHDR_extract_DidSSNs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


DIDSSNs_solesrc_EQ := JOIN(sort(distribute(infile_slim(is_EQ), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
													,sort(distribute(PHDR_extract_DIDSSNs_src_EQ, hash(did)), did,src,rid, local,skew(1.0))
													,(unsigned6) left.did = right.did
														AND left.src = right.src
														AND left.result_rid = right.rid

													,skew(1.0)
												 );	
									 
eval_DIDSSNs_sole_sourced_EQ := OUTPUT(sort(distribute(DIDSSNs_solesrc_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDSSNs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDSSNs
		sole_sourced_unique_DIDSSNs_EQ := DEDUP(sort(distribute(DIDSSNs_solesrc_EQ, hash(did))
																								, did, SSN, local,skew(1.0))
																						, did, SSN, all,local);

		Sole_sourced_SSN_values := OUTPUT(COUNT(sole_sourced_unique_DIDSSNs_EQ), named('Sole_sourced_SSN_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDSSNs_EQ := DEDUP(sort(distribute(DIDSSNs_solesrc_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_SSN_values := OUTPUT(COUNT(DIDs_with_unique_DIDSSNs_EQ), named('DIDs_with_unique_DIDSSNs_'+set_name_EQ+'_'+eval_case));

//By Source: Sole-Sourced DIDSSNs:
DIDSSNs_by_Source_EQ := DEDUP(sort(distribute(DIDSSNs_solesrc_EQ, hash(source_field,did))
																, source_field,did, local,skew(1.0))
														, source_field,did, all,local);
										
tbl_DIDSSNs_by_Source_EQ := OUTPUT(TABLE(DIDSSNs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidSSNsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDSSNs:
DIDSSNs_by_Search_EQ := DEDUP(sort(distribute(DIDSSNs_solesrc_EQ, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDSSNs_by_Search_EQ := OUTPUT(TABLE(DIDSSNs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidSSNsBySearch' + '_EQ'));

//---------------------------------------------------------------

	//--- 5. Sole-sourced DOBs - at the DID level
		
PHDR_extract_DOBs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_EQ = true), hash(did)), did,DOB, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_EQ_sample := output(choosen(PHDR_extract_DOBs_EQ, 200), named('sample'+'_'+'PHDR_extract_DOBs_EQ'));

PHDR_extract_DOBs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_not_EQ = true), hash(did)), did,DOB, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_nonEQ_sample := output(choosen(PHDR_extract_DOBs_nonEQ, 200), named('sample'+'_'+'PHDR_extract_DOBs_nonEQ'));

PHDR_extract_DidDOBs_src_EQ := JOIN(sort(distribute(PHDR_extract_DOBs_EQ, hash(did)), did,DOB, local,skew(1.0))
													 ,sort(distribute(PHDR_extract_DOBs_nonEQ, hash(did)), did,DOB, local,skew(1.0))	
													 ,left.did = right.did
													 AND (unsigned6) left.DOB = (unsigned6) right.DOB
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDOBs'+'_'+set_name_EQ+'_'+eval_case)
													;

sample_extract_DIDDOBs_EQ := OUTPUT(PHDR_extract_DidDOBs_src_EQ, named('PHDR_extract_DidDOBs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDDOBs_EQ  := OUTPUT(count(PHDR_extract_DidDOBs_src_EQ), named('PHDR_extract_DidDOBs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


DIDDOBs_solesrc_EQ := JOIN(sort(distribute(infile_slim(is_EQ), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
													,sort(distribute(PHDR_extract_DIDDOBs_src_EQ, hash(did)), did,src,rid, local,skew(1.0))
													,(unsigned6) left.did = right.did
														AND left.src = right.src
														AND left.result_rid = right.rid

													,skew(1.0)
												 );	
									 
eval_DIDDOBs_sole_sourced_EQ := OUTPUT(sort(distribute(DIDDOBs_solesrc_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDOBs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDOBs
		sole_sourced_unique_DIDDOBs_EQ := DEDUP(sort(distribute(DIDDOBs_solesrc_EQ, hash(did))
																								, did, DOB, local,skew(1.0))
																						, did, DOB, all,local);

		Sole_sourced_DOB_values := OUTPUT(COUNT(sole_sourced_unique_DIDDOBs_EQ), named('Sole_sourced_DOB_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDDOBs_EQ := DEDUP(sort(distribute(DIDDOBs_solesrc_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOB_values := OUTPUT(COUNT(DIDs_with_unique_DIDDOBs_EQ), named('DIDs_with_unique_DIDDOBs_'+set_name_EQ+'_'+eval_case));

//By Source: Sole-Sourced DIDDOBs:
DIDDOBs_by_Source_EQ := DEDUP(sort(distribute(DIDDOBs_solesrc_EQ, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDDOBs_by_Source_EQ := OUTPUT(TABLE(DIDDOBs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidDOBsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDDOBs:
DIDDOBs_by_Search_EQ := DEDUP(sort(distribute(DIDDOBs_solesrc_EQ, hash(row_ID,did))
																, row_ID,did, local,skew(1.0))
														, row_ID,did, all,local);
										
tbl_DIDDOBs_by_Search_EQ := OUTPUT(TABLE(DIDDOBs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDOBsBySearch' + '_EQ'));

//---------------------------------------------------------------

	//--- 6. Sole-sourced DLs - at the DID level
		
PHDR_extract_DLs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_EQ = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_EQ_sample := output(choosen(PHDR_extract_DLs_EQ, 200), named('sample'+'_'+'PHDR_extract_DLs_EQ'));

PHDR_extract_DLs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_not_EQ = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_nonEQ_sample := output(choosen(PHDR_extract_DLs_nonEQ, 200), named('sample'+'_'+'PHDR_extract_DLs_nonEQ'));

PHDR_extract_DidDLs_src_EQ := JOIN(sort(distribute(PHDR_extract_DLs_EQ, hash(did)), did,vendor_id, local,skew(1.0))
																 ,sort(distribute(PHDR_extract_DLs_nonEQ, hash(did)), did,vendor_id, local,skew(1.0))	
																 ,left.did = right.did
																	AND trim(left.vendor_id, all) = trim(right.vendor_id, all)
																 ,LEFT ONLY
																 ,skew(1.0)
																)
																:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDLs'+'_'+set_name_EQ+'_'+eval_case)
																;

sample_extract_DIDDLs_EQ := OUTPUT(PHDR_extract_DidDLs_src_EQ, named('PHDR_extract_DidDLs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDDLs_EQ  := OUTPUT(count(PHDR_extract_DidDLs_src_EQ), named('PHDR_extract_DidDLs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


DIDDLs_solesrc_EQ := JOIN(sort(distribute(infile_slim(is_EQ), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
													,sort(distribute(PHDR_extract_DIDDLs_src_EQ, hash(did)), did,src,rid, local,skew(1.0))
													,(unsigned6) left.did = right.did
														AND left.src = right.src
														AND left.result_rid = right.rid

													,skew(1.0)
												 );	
									 
eval_DIDDLs_sole_sourced_EQ := OUTPUT(sort(distribute(DIDDLs_solesrc_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDLs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDLs
		sole_sourced_unique_DIDDLs_EQ := DEDUP(sort(distribute(DIDDLs_solesrc_EQ, hash(did))
																								, did, vendor_id, local,skew(1.0))
																						, did, vendor_id, all,local);

		Sole_sourced_DL_values := OUTPUT(COUNT(sole_sourced_unique_DIDDLs_EQ), named('Sole_sourced_DL_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDDLs_EQ := DEDUP(sort(distribute(DIDDLs_solesrc_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DL_values := OUTPUT(COUNT(DIDs_with_unique_DIDDLs_EQ), named('DIDs_with_unique_DIDDLs_'+set_name_EQ+'_'+eval_case));

//By Source: Sole-Sourced DIDDLs:
DIDDLs_by_Source_EQ := DEDUP(sort(distribute(DIDDLs_solesrc_EQ, hash(source_field,did))
																, source_field,did, local,skew(1.0))
														, source_field,did, all,local);
										
tbl_DIDDLs_by_Source_EQ := OUTPUT(TABLE(DIDDLs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidDLsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDDLs:
DIDDLs_by_Search_EQ := DEDUP(sort(distribute(DIDDLs_solesrc_EQ, hash(row_ID,did))
																, row_ID,did, local,skew(1.0))
														, row_ID,did, all,local);
										
tbl_DIDDLs_by_Search_EQ := OUTPUT(TABLE(DIDDLs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDLsBySearch' + '_EQ'));

//--------------------------------------------------------------------------------------

rec_All_sole_sourced :=
	RECORD
		DIDs_solesrc_EQ;
		string sole_source_category := '';
	END;
	

All_sole_sourced_EQ := project(DIDs_solesrc_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDs_' + 'EQ', self := left))
													+
												  project(DIDNames_solesrc_EQ , transform(rec_All_sole_sourced, self.sole_source_category := 'DIDNames_' + 'EQ', self := left))
													+
												  project(DIDAddrs_solesrc_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDAddrs_' + 'EQ', self := left))
													+
												  project(DIDSSNs_solesrc_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDSSNs_' + 'EQ', self := left))
													+
												  project(DIDDOBs_solesrc_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDOBs_' + 'EQ', self := left))
												 +
												  project(DIDDLs_solesrc_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDLs_' + 'EQ', self := left))
												 :PERSIST('~thor400_92::persist::ckelly::ALL_sole_sourced_'+set_name_EQ+'_'+eval_case)
												 ;

eval_ALL_sole_sourced_EQ := OUTPUT(sort(distribute(All_sole_sourced_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_ALL_EQ' + '_' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
All_sole_sourced_rows_count := OUTPUT(COUNT(All_sole_sourced_EQ), named('All_sole_sourced_rows_count' + '_EQ'));
Database_records := DEDUP(sort(distribute(All_sole_sourced_EQ,hash(did)), did,rid, local), did,rid, all,local);
Database_records_involving_sole_sourced_data := OUTPUT(COUNT(Database_records), named('Total_Number_of_database_records_involving_any_sole_sourced_data' + '_EQ'));



//By Source: Sole-Sourced DIDs - All:
All_DIDs_by_Source_EQ := DEDUP(sort(distribute(All_sole_sourced_EQ, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
Number_of_Sources_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Source_EQ,
																													{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																														source_field, few)
																									, all, named('Number_of_Sources_involving_sole_sourced_data' + '_EQ'));

//By Search: Sole-Sourced DIDs - All:
All_DIDs_by_Search_EQ := DEDUP(sort(distribute(All_sole_sourced_EQ, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
Number_of_Searches_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('Number_of_Searches_involving_sole_sourced_data' + '_EQ'));

//------------ Unique Count: Sole-sourced DIDs - ALL
		sole_sourced_unique_DID_ALL_EQ := DEDUP(sort(distribute(All_sole_sourced_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Total_LexIDs_involving_any_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DID_ALL_EQ), named('Total_LexIDs_involving_any_sole_sourced_data' + '_EQ'));

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
											
											,eval_ALL_sole_sourced_EQ
											,eval_DIDs_sole_sourced_EQ
											,eval_DIDNames_sole_sourced_EQ
											,eval_DIDAddrs_sole_sourced_EQ
											,eval_DIDSSNs_sole_sourced_EQ
											,eval_DIDDOBs_sole_sourced_EQ
											,eval_DIDDLs_sole_sourced_EQ
											
											,tbl_DIDs_by_Source_EQ
											,tbl_DIDs_by_Search_EQ
											
											,tbl_DIDNames_by_Source_EQ
											,tbl_DIDNames_by_Search_EQ
											
											,tbl_DIDAddrs_by_Source_EQ
											,tbl_DIDAddrs_by_Search_EQ
											
											,tbl_DIDSSNs_by_Source_EQ
											,tbl_DIDSSNs_by_Search_EQ
											
											,tbl_DIDDOBs_by_Source_EQ
											,tbl_DIDDOBs_by_Search_EQ
											
											,tbl_DIDDLs_by_Source_EQ
											,tbl_DIDDLs_by_Search_EQ
											
											//For research if necessary:
											,infile_slim_sample,
											PHDR_extract_DIDs_EQ_sample,
											PHDR_extract_DIDs_nonEQ_sample,
											PHDR_extract_Names_EQ_sample,
											PHDR_extract_Names_nonEQ_sample,
											PHDR_extract_Addrs_EQ_sample,
											PHDR_extract_Addrs_nonEQ_sample,
											PHDR_extract_SSNs_EQ_sample,
											PHDR_extract_SSNs_nonEQ_sample,
											PHDR_extract_DOBs_EQ_sample,
											PHDR_extract_DOBs_nonEQ_sample,
											PHDR_extract_DLs_EQ_sample,
											PHDR_extract_DLs_nonEQ_sample,
											
											sample_extract_DIDs_EQ,count_extract_DIDs_EQ,
											sample_extract_DIDNames_EQ,count_extract_DIDNames_EQ,
											sample_extract_DIDAddrs_EQ,count_extract_DIDAddrs_EQ,
											sample_extract_DIDSSNs_EQ,count_extract_DIDSSNs_EQ,
											sample_extract_DIDDOBs_EQ,count_extract_DIDDOBs_EQ,
											sample_extract_DIDDLs_EQ,count_extract_DIDDLs_EQ
		
										 );
											 
	ENDMACRO;
//---------------------------------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*

EXPORT mac_Compliance_sole_sourced_EQ(infile,eval_case = '',row_ID = 0, source_field, outfile) := 
  MACRO


		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
	
//		PHdr_extract := DATASET(ut.foreign_prod+'thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case
//																,rec_PHdr_extract, THOR);

		PHdr_extract := DATASET(ut.foreign_dataland+'thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv'
																,rec_PHdr_extract
																,csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------

//Sole-sourced from:
//b.	Equifax 

set_Utility := ['UT',	//Utilities (Equifax/NCTUE)
								'UW',	//	Util Work Phone (Equifax/NCTUE)
								'ZK',	//	Z type Util Work Phone (Equifax/NCTUE)
								'ZT',	//	Z type Utilities (Equifax/NCTUE)
								'ZU'	//	Daily Z Type Utilites (Equifax/NCTUE)
								];


rec_criteria := 
	RECORD
		rec_PHdr_extract;
		
		boolean src_is_EQ;
		boolean src_is_not_EQ;
		
		boolean has_ssn;
		boolean has_dob;
		boolean has_DL;

	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_EQ						:= LE.src IN mdr.sourcetools.set_Equifax OR LE.src IN set_Utility;//Sept 2014: Added Utility sources
	 self.src_is_not_EQ       := self.src_is_EQ = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

//----------------

set_name_EQ := 'EQ';

//segment_name := 'CORE';
segment_name := '_All_SEGMENTS_';

//----------------

// Make sure to use Header data, not Key (Best) data, for sole-sourced //

layout_no_Header_KEY := Header.layout_header_v2 - [did,src,dt_last_seen,dt_vendor_last_reported];

rec_infile_slim := {infile} - layout_no_Header_KEY;

infile_slim := PROJECT(infile, rec_infile_slim);

//---------------------------------------------------------------
#OPTION('multiplePersistInstances',FALSE); 

is_EQ := infile_slim.source_field IN mdr.sourcetools.set_Equifax OR infile_slim.source_field IN set_Utility;
					

	//--- 1. Sole-sourced DIDs

PHDR_extract_DIDs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EQ = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
//output(choosen(PHDR_dids_EQ, 200));

PHDR_extract_dids_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EQ = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
//output(choosen(PHDR_dids_nonEQ, 200));

PHDR_extract_Dids_src_EQ := JOIN(sort(distribute(PHDR_extract_dids_EQ, hash(did)), did, local,skew(1.0))
													 ,sort(distribute(PHDR_extract_dids_nonEQ, hash(did)), did, local,skew(1.0))	
													 ,left.did = right.did
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDs'+'_'+set_name_EQ+'_'+eval_case)
													;

sample_extract_DIDs_EQ := OUTPUT(PHDR_extract_Dids_src_EQ, named('PHDR_extract_Dids_src_EQ'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDs_EQ  := OUTPUT(count(PHDR_extract_Dids_src_EQ), named('PHDR_extract_Dids_src_EQ'+'_'+set_name_EQ+'_'+eval_case+'_count'));


results_all_DIDs_by_row_and_src := DEDUP(sort(distribute(infile_slim(did <> 0), hash(row_ID))
																							,row_ID,did,-dt_last_seen,-dt_vendor_last_reported,source_field, local, skew(1.0))
																				,row_ID,did, source_field, all,local);

output(TOPN(results_all_DIDs_by_row_and_src, 1000,row_ID),  named('results_all_DIDs_by_row_and_src'+'_sample'));

//------------ per Search:
rec_infile_join := rec_infile_slim - [dt_last_seen,dt_vendor_last_reported];

srch_results_sole_source_DIDs_EQ := JOIN(sort(distribute(results_all_DIDs_by_row_and_src(is_EQ), hash(row_ID)), row_ID,did,src, local,skew(1.0))
																		,sort(distribute(PHDR_extract_Dids_src_EQ, hash(did)), did,src, local,skew(1.0))
																		,(unsigned6) left.did = right.did
																			AND left.src = right.src
																		,transform({rec_infile_join,PHDR_extract}, self.dt_last_seen := right.dt_last_seen; self.dt_vendor_last_reported := right.dt_vendor_last_reported; self := left; self := right)

																		,skew(1.0)
																	 );	

srch_results_sole_sourced_DIDs_EQ := OUTPUT(sort(distribute(srch_results_sole_source_DIDs_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//eval_DID_dedup := DEDUP(sort(distribute(infile_slim(did <> 0), hash(row_ID))
//											,row_ID,did,-dt_last_seen,-dt_vendor_last_reported, local, skew(1.0))
//								,row_ID,did, all,local);
													 
//srch_results_sole_source_DIDs_EQ := JOIN(sort(distribute(eval_DID_dedup(is_EQ), hash(row_ID)), row_ID,did, local,skew(1.0))
//										,sort(distribute(PHDR_extract_Dids_src_EQ, hash(did)), did, local,skew(1.0))
//										,(unsigned6) left.did = right.did
//											AND left.source_field = right.src
//										,skew(1.0)
//									 );	


//------------ Unique Count: Sole-sourced DIDs (ADD THIS TO RESULTS TABLE)
sole_sourced_unique_DIDs_EQ := DEDUP(sort(distribute(srch_results_sole_source_DIDs_EQ, hash(did))
																						, did,-dt_last_seen,-dt_vendor_last_reported, local,skew(1.0))
																				, did, all,local);

DIDs_created_from_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DIDs_EQ), named('DIDs_created_from_sole_sourced_data_'+set_name_EQ+'_'+eval_case));


//Sole-Sourced DIDs By Source:
DIDs_by_Source_EQ := DEDUP(sort(distribute(srch_results_sole_source_DIDs_EQ, hash(source_field,did))
												, source_field,did,-dt_last_seen,-dt_vendor_last_reported, local,skew(1.0))
										, source_field,did, all,local);
										
tbl_DIDs_by_Source_EQ := OUTPUT(TABLE(DIDs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidsBySource' + '_EQ'));


////------------ Sole-Sourced DIDs By Search:
DIDs_by_Search_EQ := DEDUP(sort(distribute(srch_results_sole_source_DIDs_EQ, hash(row_ID,did))
												, row_ID,did,-dt_last_seen,-dt_vendor_last_reported, local,skew(1.0))
										, row_ID,did, all,local);
										
tbl_DIDs_by_Search_EQ := OUTPUT(TABLE(DIDs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsBySearch' + '_EQ'));

//----------------------------------------------------

	//--- 2. Sole-sourced Names - at the DID level
		
PHDR_extract_Names_EQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EQ = true), hash(did,fname,lname)), did,fname,lname, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,fname,lname, all,local);
//output(choosen(PHDR_Names_EQ, 200));

PHDR_extract_Names_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EQ = true), hash(did,fname,lname)), did,fname,lname, local, skew(1.0)), did,fname,lname, all,local);
//output(choosen(PHDR_Names_nonEQ, 200));

PHDR_extract_DIDNames_src_EQ := JOIN(sort(distribute(PHDR_extract_Names_EQ, hash(did)), did,fname,lname, local,skew(1.0))
													 ,sort(distribute(PHDR_extract_Names_nonEQ, hash(did,fname,lname)), did,fname,lname, local,skew(1.0))	
													 ,left.did = right.did
													  AND left.fname = right.fname
														AND left.lname = right.lname
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDNames'+'_'+set_name_EQ+'_'+eval_case)
													;

sample_extract_DIDNames_EQ := OUTPUT(PHDR_extract_DidNames_src_EQ, named('PHDR_extract_DIDNames'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDNames_EQ  := OUTPUT(count(PHDR_extract_DidNames_src_EQ), named('PHDR_extract_DIDNames'+'_'+set_name_EQ+'_'+eval_case+'_count'));


results_all_DIDNames_by_row_and_src := DEDUP(sort(distribute(infile_slim(did <> 0), hash(row_ID))
																							,row_ID,did,-dt_last_seen,-dt_vendor_last_reported,source_field, local, skew(1.0))
																				,row_ID,did, source_field, all,local);

eval_DIDNames_EQ := JOIN(sort(distribute(results_all_DIDNames_by_row_and_src(is_EQ), hash(row_ID)), row_ID,did,src, local,skew(1.0))
										,sort(distribute(PHDR_extract_DidNames_src_EQ, hash(did)), did,src, local,skew(1.0))
										,(unsigned6) left.did = right.did
//											AND left.fname = right.fname
//											AND left.lname = right.lname
											AND left.src = right.src
											
										,skew(1.0)
									 );	
													 
eval_DIDNames_sole_sourced_EQ := OUTPUT(sort(distribute(eval_DIDNames_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDNames_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


//By Source: Sole-Sourced DIDNames:
DIDNames_by_Source_EQ := DEDUP(sort(distribute(eval_DIDNames_EQ, hash(source_field,did))
												, source_field,did, local,skew(1.0))
										, source_field,did, all,local);
										
tbl_DIDNames_by_Source_EQ := OUTPUT(TABLE(DIDNames_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidNamesBySource' + '_EQ'));

//By Search: Sole-Sourced DIDNames:
DIDNames_by_Search_EQ := DEDUP(sort(distribute(eval_DIDNames_EQ, hash(row_ID,did))
												, row_ID,did, local,skew(1.0))
										, row_ID,did, all,local);
										
tbl_DIDNames_by_Search_EQ := OUTPUT(TABLE(DIDNames_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsNameBySearch' + '_EQ'));


//------------ Unique Count: Sole-sourced DIDNames (ADD THIS TO RESULTS TABLE)
		sole_sourced_unique_DIDNames_EQ := DEDUP(sort(distribute(eval_DIDNames_EQ, hash(did))
																								, did, fname,lname, local,skew(1.0))
																						, did,fname,lname, all,local);

		Sole_sourced_Name_values := OUTPUT(COUNT(sole_sourced_unique_DIDNames_EQ), named('Sole_sourced_Name_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDNames_EQ := DEDUP(sort(distribute(eval_DIDNames_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Name_values := OUTPUT(COUNT(DIDs_with_unique_DIDNames_EQ), named('DIDs_with_unique_DIDNames_'+set_name_EQ+'_'+eval_case));

//---------------------------

	//--- 3. Sole-sourced Addresses - at the DID level
		
PHDR_extract_Addrs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EQ = true), hash(did,zip,prim_range,prim_name,sec_range)), did,zip,prim_range,prim_name,sec_range, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,zip,prim_range,prim_name,sec_range, all,local);
//output(choosen(PHDR_Addrs_EQ, 200));

PHDR_extract_Addrs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EQ = true), hash(did,zip,prim_range,prim_name,sec_range)), did,zip,prim_range,prim_name,sec_range, local, skew(1.0)), did,zip,prim_range,prim_name,sec_range, all,local);
//output(choosen(PHDR_Addrs_nonEQ, 200));

PHDR_extract_DidAddrs_src_EQ := JOIN(sort(distribute(PHDR_extract_Addrs_EQ, hash(did)), did,zip,prim_range,prim_name,sec_range, local,skew(1.0))
													 ,sort(distribute(PHDR_extract_Addrs_nonEQ, hash(did)), did,zip,prim_range,prim_name,sec_range, local,skew(1.0))	
													 ,left.did = right.did
													 AND trim(left.zip, all) = trim(right.zip, all)
													 AND trim(left.prim_range, all) = trim(right.prim_range, all)
													 AND trim(left.prim_name, all) = trim(right.prim_name, all)
													 AND trim(left.sec_range, all) = trim(right.sec_range, all)
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidAddrs'+'_'+set_name_EQ+'_'+eval_case)
													;

sample_extract_DIDAddrs_EQ := OUTPUT(PHDR_extract_DidAddrs_src_EQ, named('PHDR_extract_DidAddrs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDAddrs_EQ  := OUTPUT(count(PHDR_extract_DidAddrs_src_EQ), named('PHDR_extract_DidAddrs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


results_all_DIDAddrs_by_row_and_src := DEDUP(sort(distribute(infile_slim(did <> 0), hash(row_ID))
																							,row_ID,did,-dt_last_seen,-dt_vendor_last_reported,source_field, local, skew(1.0))
																				,row_ID,did, source_field, all,local);


DIDAddrs_solesrc_EQ := JOIN(sort(distribute(results_all_DIDAddrs_by_row_and_src(is_EQ), hash(row_ID)), row_ID,did,src, local,skew(1.0))
										,sort(distribute(PHDR_extract_DIDAddrs_src_EQ, hash(did)), did,src, local,skew(1.0))
										,(unsigned6) left.did = right.did
//														AND trim(left.zip, all) = trim(right.zip, all)
//													 AND trim(left.prim_range, all) = trim(right.prim_range, all)
//													 AND trim(left.prim_name, all) = trim(right.prim_name, all)
//													 AND trim(left.sec_range, all) = trim(right.sec_range, all)
													AND left.src = right.src

										,skew(1.0)
									 );	
		
eval_DIDAddrs_sole_sourced_EQ := OUTPUT(sort(distribute(DIDAddrs_solesrc_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDAddrs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


//By Source: Sole-Sourced DIDAddrs:
DIDAddrs_by_Source_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(source_field,did))
												, source_field,did, local,skew(1.0))
										, source_field,did, all,local);
										
tbl_DIDAddrs_by_Source_EQ := OUTPUT(TABLE(DIDAddrs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidAddrsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDAddrs:
DIDAddrs_by_Search_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(row_ID,did))
												, row_ID,did, local,skew(1.0))
										, row_ID,did, all,local);
										
tbl_DIDAddrs_by_Search_EQ := OUTPUT(TABLE(DIDAddrs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidAddrsBySearch' + '_EQ'));

//------------ Unique Count: Sole-sourced DIDAddrs
		sole_sourced_unique_DIDAddrs_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(did))
																								, did, zip,prim_range,prim_name,sec_range, local,skew(1.0))
																						, did, zip,prim_range,prim_name,sec_range, all,local);

		Sole_sourced_Address_values := OUTPUT(COUNT(sole_sourced_unique_DIDAddrs_EQ), named('Sole_sourced_Address_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDAddrs_EQ := DEDUP(sort(distribute(DIDAddrs_solesrc_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Addr_values := OUTPUT(COUNT(DIDs_with_unique_DIDAddrs_EQ), named('DIDs_with_unique_DIDAddrs_'+set_name_EQ+'_'+eval_case));

//---------------------------------------------------------------

	//--- 4. Sole-sourced SSNs - at the DID level
		
PHDR_extract_DidSSNs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_EQ=true), hash(did,SSN)), did,SSN, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,SSN, all,local);

//output(choosen(PHDR_extract_DidSSNs_EQ, 200), named('DIDs_paired_with_EQ_SSN_sample'));

PHDR_extract_DidSSNs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_not_EQ=true), hash(did,SSN)), did,SSN, local, skew(1.0)), did,SSN, all,local);

//output(choosen(PHDR_extract_DidSSNs_nonEQ, 200), named('DIDs_paired_with_nonEQ_SSN_sample'));

PHDR_extract_DidSSNs_src_EQ := JOIN(sort(distribute(PHDR_extract_DidSSNs_EQ, hash(did,SSN)), did,SSN, local,skew(1.0))
																 ,sort(distribute(PHDR_extract_DidSSNs_nonEQ, hash(did,SSN)), did,SSN, local,skew(1.0))	
																 ,left.did = right.did
																 AND left.SSN = right.SSN
																 ,LEFT ONLY
																 ,skew(1.0)
																)
																:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidSSNs'+'_'+set_name_EQ+'_'+eval_case)
													;

sample_extract_DIDSSNs_EQ := OUTPUT(PHDR_extract_DidSSNs_src_EQ, named('PHDR_extract_DidSSNs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDSSNs_EQ  := OUTPUT(count(PHDR_extract_DidSSNs_src_EQ), named('PHDR_extract_DidSSNs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


results_all_DIDSSNs_by_row_and_src := DEDUP(sort(distribute(infile_slim(did <> 0), hash(row_ID))
																							,row_ID,did,-dt_last_seen,-dt_vendor_last_reported,source_field, local, skew(1.0))
																				,row_ID,did, source_field, all,local);

eval_DIDSSNs_EQ := JOIN(sort(distribute(results_all_DIDSSNs_by_row_and_src(is_EQ), hash(row_ID)), row_ID,did,src, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDSSNs_src_EQ, hash(did)), did,src, local,skew(1.0))
														,(unsigned6) left.did = right.did
//															AND left.SSN = right.SSN
															AND left.src = right.src
															
														,skew(1.0)
													 );	
		

eval_DIDSSNs_sole_sourced_EQ := OUTPUT(sort(distribute(eval_DIDSSNs_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDSSNs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


//By Source: Sole-Sourced DIDSSNs:
DIDSSNs_by_Source_EQ := DEDUP(sort(distribute(eval_DIDSSNs_EQ, hash(source_field,did))
												, source_field,did, local,skew(1.0))
										, source_field,did, all,local);
										
tbl_DIDSSNs_by_Source_EQ := OUTPUT(TABLE(DIDSSNs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidSSNsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDSSNs:
DIDSSNs_by_Search_EQ := DEDUP(sort(distribute(eval_DIDSSNs_EQ, hash(row_ID,did))
												, row_ID,did, local,skew(1.0))
										, row_ID,did, all,local);
										
tbl_DIDSSNs_by_Search_EQ := OUTPUT(TABLE(DIDSSNs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidSSNsBySearch' + '_EQ'));

//------------ Unique Count: Sole-sourced DIDSSNs
		sole_sourced_unique_DIDSSNs_EQ := DEDUP(sort(distribute(eval_DIDSSNs_EQ, hash(did))
																								, did,SSN, local,skew(1.0))
																						, did,SSN, all,local);

		Sole_sourced_SSN_values := OUTPUT(COUNT(sole_sourced_unique_DIDSSNs_EQ), named('Sole_sourced_SSN_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDSSNs_EQ := DEDUP(sort(distribute(eval_DIDSSNs_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_SSN_values := OUTPUT(COUNT(DIDs_with_unique_DIDSSNs_EQ), named('DIDs_with_unique_DIDSSNs_'+set_name_EQ+'_'+eval_case));

//---------------------------------------------------------------

	//--- 5. Sole-sourced DOBs - at the DID level
		
PHDR_extract_DOBs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_EQ=true), hash(did,DOB)), did,DOB, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,DOB, all,local);
//output(choosen(PHDR_DOBs_EQ, 200));

PHDR_extract_DOBs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_not_EQ=true), hash(did,DOB)), did,DOB, local, skew(1.0)), did,DOB, all,local);
//output(choosen(PHDR_DOBs_nonEQ, 200));

PHDR_extract_DIDDOBs_src_EQ := JOIN(sort(distribute(PHDR_extract_DOBs_EQ, hash(did,DOB)), did,DOB, local,skew(1.0))
													 ,sort(distribute(PHDR_extract_DOBs_nonEQ, hash(did,DOB)), did,DOB, local,skew(1.0))	
													 ,left.did = right.did
														 AND (unsigned6) left.DOB = (unsigned6) right.DOB
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDDOBs'+'_'+set_name_EQ+'_'+eval_case)
													;

sample_extract_DIDDOBs_EQ := OUTPUT(PHDR_extract_DIDDOBs_src_EQ, named('PHDR_extract_DIDDOBs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDDOBs_EQ := OUTPUT(count(PHDR_extract_DIDDOBs_src_EQ), named('PHDR_extract_DIDDOBs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


results_all_DIDDOBs_by_row_and_src := DEDUP(sort(distribute(infile_slim(did <> 0), hash(row_ID))
																							,row_ID,did,-dt_last_seen,-dt_vendor_last_reported,src, local, skew(1.0))
																				,row_ID,did, source_field, all,local);

eval_DIDDOBs_EQ := JOIN(sort(distribute(results_all_DIDDOBs_by_row_and_src(is_EQ), hash(row_ID)), row_ID,did,src, local,skew(1.0))
										,sort(distribute(PHDR_extract_DIDDOBs_src_EQ, hash(did)), did,src, local,skew(1.0))
										,(unsigned6) left.did = right.did
//											AND (unsigned6) left.DOB = (unsigned6) right.DOB
											AND left.src = right.src
											
										,skew(1.0)
									 );	
		
eval_DIDDOBs_sole_sourced_EQ := OUTPUT(sort(distribute(eval_DIDDOBs_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDOBs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


//By Source: Sole-Sourced DIDDOBs:
DIDDOBs_by_Source_EQ := DEDUP(sort(distribute(eval_DIDDOBs_EQ, hash(source_field,did))
												, source_field,did, local,skew(1.0))
										, source_field,did, all,local);
										
tbl_DIDDOBs_by_Source_EQ := OUTPUT(TABLE(DIDDOBs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidDOBsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDDOBs:
DIDDOBs_by_Search_EQ := DEDUP(sort(distribute(eval_DIDDOBs_EQ, hash(row_ID,did))
												, row_ID,did, local,skew(1.0))
										, row_ID,did, all,local);
										
tbl_DIDDOBs_by_Search_EQ := OUTPUT(TABLE(DIDDOBs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDOBsBySearch' + '_EQ'));

//------------ Unique Count: Sole-sourced DIDDOBs
		sole_sourced_unique_DIDDOBs_EQ := DEDUP(sort(distribute(eval_DIDDOBs_EQ, hash(did))
																								, did,DOB, local,skew(1.0))
																						, did,DOB, all,local);

		Sole_sourced_DOB_values := OUTPUT(COUNT(sole_sourced_unique_DIDDOBs_EQ), named('Sole_sourced_DOB_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDDOBs_EQ := DEDUP(sort(distribute(eval_DIDDOBs_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOB_values := OUTPUT(COUNT(DIDs_with_unique_DIDDOBs_EQ), named('DIDs_with_unique_DIDDOBs_'+set_name_EQ+'_'+eval_case));

//---------------------------------------------------------------

	//--- 6. Sole-sourced DLs - at the DID level
		
PHDR_extract_DLs_EQ := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_EQ=true), hash(did,vendor_id)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);

PHDR_extract_DLs_nonEQ := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_not_EQ=true), hash(did,vendor_id)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);


PHDR_extract_DIDDLs_src_EQ := JOIN(sort(distribute(PHDR_extract_DLs_EQ, hash(did,vendor_id)), did,vendor_id, local,skew(1.0))
													 ,sort(distribute(PHDR_extract_DLs_nonEQ, hash(did,vendor_id)), did,vendor_id, local,skew(1.0))	
													 ,left.did = right.did
													 AND left.vendor_id = right.vendor_id
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDDLs'+'_'+set_name_EQ+'_'+eval_case)
													;

sample_extract_DIDDLs_EQ := OUTPUT(PHDR_extract_DIDDLs_src_EQ, named('PHDR_extract_DIDDLs'+'_'+set_name_EQ+'_'+eval_case+'_sample'));
count_extract_DIDDLs_EQ :=	OUTPUT(count(PHDR_extract_DIDDLs_src_EQ), named('PHDR_extract_DIDDLs'+'_'+set_name_EQ+'_'+eval_case+'_count'));


results_all_DIDDLs_by_row_and_src := DEDUP(sort(distribute(infile_slim(did <> 0), hash(row_ID))
																							,row_ID,did,-dt_last_seen,-dt_vendor_last_reported,source_field, local, skew(1.0))
																				,row_ID,did, source_field, all,local);

													
eval_DIDDLs_EQ := JOIN(sort(distribute(results_all_DIDDLs_by_row_and_src(is_EQ), hash(row_ID)), row_ID,did,src, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDLs_src_EQ, hash(did)), did,src, local,skew(1.0))
														,(unsigned6) left.did = right.did
//															AND left.vendor_id = right.vendor_id
															AND left.src = right.src
															
														,skew(1.0)
													 );	
		
eval_DIDDLs_sole_sourced_EQ := OUTPUT(sort(distribute(eval_DIDDLs_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDLs_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);


//By Source: Sole-Sourced DIDDLs:
DIDDLs_by_Source_EQ := DEDUP(sort(distribute(eval_DIDDLs_EQ, hash(source_field,did))
												, source_field,did, local,skew(1.0))
										, source_field,did, all,local);
										
tbl_DIDDLs_by_Source_EQ := OUTPUT(TABLE(DIDDLs_by_Source_EQ,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDIDDLsBySource' + '_EQ'));

//By Search: Sole-Sourced DIDDLs:
DIDDLs_by_Search_EQ := DEDUP(sort(distribute(eval_DIDDLs_EQ, hash(row_ID,did))
												, row_ID,did, local,skew(1.0))
										, row_ID,did, all,local);
										
tbl_DIDDLs_by_Search_EQ := OUTPUT(TABLE(DIDDLs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDIDDLsBySearch' + '_EQ'));


//------------ Unique Count: Sole-sourced DIDDLs
		sole_sourced_unique_DIDDLs_EQ := DEDUP(sort(distribute(eval_DIDDLs_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Sole_sourced_DL_values := OUTPUT(COUNT(sole_sourced_unique_DIDDLs_EQ), named('Sole_sourced_DL_values_'+set_name_EQ+'_'+eval_case));

		DIDs_with_unique_DIDDLs_EQ := DEDUP(sort(distribute(eval_DIDDLs_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DL_values := OUTPUT(COUNT(DIDs_with_unique_DIDDLs_EQ), named('DIDs_with_unique_DIDDLs_'+set_name_EQ+'_'+eval_case));

//--------------------------------------------------------------------------------------

rec_All_sole_sourced :=
	RECORD
		srch_results_sole_source_DIDs_EQ;
		string sole_source_category := '';
	END;
	

All_sole_sourced_EQ := project(srch_results_sole_source_DIDs_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDs_' + 'EQ', self := left))
													+
												  project(eval_DIDNames_EQ , transform(rec_All_sole_sourced, self.sole_source_category := 'DIDNames_' + 'EQ', self := left))
													+
												  project(DIDAddrs_solesrc_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDAddrs_' + 'EQ', self := left))
													+
												  project(eval_DIDSSNs_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDSSNs_' + 'EQ', self := left))
													+
												  project(eval_DIDDOBs_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDOBs_' + 'EQ', self := left))
												 +
												  project(eval_DIDDLs_EQ, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDLs_' + 'EQ', self := left))
												 :PERSIST('~thor400_92::persist::ckelly::ALL_sole_sourced_'+set_name_EQ+'_'+eval_case)
												 ;

eval_ALL_sole_sourced_EQ := OUTPUT(sort(distribute(All_sole_sourced_EQ, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_ALL_EQ' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
All_sole_sourced_rows_count := OUTPUT(COUNT(All_sole_sourced_EQ), named('All_sole_sourced_rows_count' + '_EQ'));
Database_records := DEDUP(sort(distribute(All_sole_sourced_EQ,hash(did)), did,rid, local), did,rid, all,local);
Database_records_involving_sole_sourced_data := OUTPUT(COUNT(Database_records), named('Total_Number_of_database_records_involving_any_sole_sourced_data' + '_EQ'));



//By Source: Sole-Sourced DIDs - All:
All_DIDs_by_Source_EQ := DEDUP(sort(distribute(All_sole_sourced_EQ, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
Number_of_Sources_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Source_EQ,
																													{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																														source_field, few)
																									, all, named('Number_of_Sources_involving_sole_sourced_data' + '_EQ'));

//By Search: Sole-Sourced DIDs - All:
All_DIDs_by_Search_EQ := DEDUP(sort(distribute(All_sole_sourced_EQ, hash(row_ID,did))
												, row_ID,did, local,skew(1.0))
										, row_ID,did, all,local);
										
Number_of_Searches_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Search_EQ, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('Number_of_Searches_involving_sole_sourced_data' + '_EQ'));

//------------ Unique Count: Sole-sourced DIDs - ALL
		sole_sourced_unique_DID_ALL_EQ := DEDUP(sort(distribute(All_sole_sourced_EQ, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Total_LexIDs_involving_any_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DID_ALL_EQ), named('Total_LexIDs_involving_any_sole_sourced_data' + '_EQ'));

//---------------------

outfile := 	parallel(sample_extract_DIDs_EQ,count_extract_DIDs_EQ,
											sample_extract_DIDNames_EQ,count_extract_DIDNames_EQ,
											sample_extract_DIDAddrs_EQ,count_extract_DIDAddrs_EQ,
											sample_extract_DIDSSNs_EQ,count_extract_DIDSSNs_EQ,
											sample_extract_DIDDOBs_EQ,count_extract_DIDDOBs_EQ,
											sample_extract_DIDDLs_EQ,count_extract_DIDDLs_EQ,
	
												Number_of_Searches_involving_sole_sourced_data
												,Number_of_Sources_involving_sole_sourced_data
												,Total_LexIDs_involving_any_sole_sourced_data
												,Database_records_involving_sole_sourced_data
												,All_sole_sourced_rows_count
												
												,DIDs_created_from_sole_sourced_data
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
												
												,eval_ALL_sole_sourced_EQ
												,srch_results_sole_sourced_DIDs_EQ
												,eval_DIDNames_sole_sourced_EQ
												,eval_DIDAddrs_sole_sourced_EQ
												,eval_DIDSSNs_sole_sourced_EQ
												,eval_DIDDOBs_sole_sourced_EQ
												,eval_DIDDLs_sole_sourced_EQ
												
												,tbl_DIDs_by_Source_EQ
												,tbl_DIDs_by_Search_EQ
												
												,tbl_DIDNames_by_Source_EQ
												,tbl_DIDNames_by_Search_EQ
												
												,tbl_DIDAddrs_by_Source_EQ
												,tbl_DIDAddrs_by_Search_EQ
												
												,tbl_DIDSSNs_by_Source_EQ
												,tbl_DIDSSNs_by_Search_EQ
												
												,tbl_DIDDOBs_by_Source_EQ
												,tbl_DIDDOBs_by_Search_EQ
												
												,tbl_DIDDLs_by_Source_EQ
												,tbl_DIDDLs_by_Search_EQ
												
												);
											 
	ENDMACRO;
*/
//---------------------------------------------------------------------------------------------------------
