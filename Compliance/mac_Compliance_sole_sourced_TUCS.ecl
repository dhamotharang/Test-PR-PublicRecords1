//Results from "mac_Compliance_sole_sourced_PHdr_extract_V2" are required.
//Then see the EXAMPLE below the macro
//August 2016: TUCS has DOD, so new section for sole-sourced TUCS DODs

EXPORT mac_Compliance_sole_sourced_TUCS(infile,eval_case = '',row_ID = 0, source_field,outfile) := 
  MACRO
	
//		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
		rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;
	
		PHdr_extract := DATASET('~thor400_92::in::compliance::sole_sourced_PHDR_extract_wLNDMF_'+eval_case + '.csv'
																,rec_PHdr_extract
																,CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------

//Sole-sourced from:
//e.	TUCS_Ptrack (CP TUCS)

rec_criteria := 
	RECORD
		rec_PHdr_extract;
		Compliance.Layout_has_PII;
		
		boolean src_is_TUCS;
		boolean src_is_not_TUCS;
		
	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_TUCS						:= LE.src IN mdr.sourcetools.set_TUCS_Ptrack;
	 self.src_is_not_TUCS      := self.src_is_TUCS = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 self.has_DOD              := IF(LE.DOD_from_LNDMF <> '',true,false);
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

PHDR_extract_plus_sample := OUTPUT(PHdr_extract_plus(src_is_TUCS = true), named('PHDR_extract_plus'+'_'+'src_is_TUCS'+'_sample'));

//----------------

set_name_TUCS := 'TUCS';

//segment_name := 'CORE';
segment_name := '_All_SEGMENTS_';

//----------------

// Make sure to use Header data, not Key (Best) data, for sole-sourced //

//layout_no_Header_KEY := Header.layout_header_v2 - [did,src,dt_last_seen,dt_vendor_last_reported];
layout_no_Header_KEY := Header.layout_header_v2 - [did,src,vendor_id,dt_last_seen,dt_vendor_last_reported];

rec_infile_slim := {infile} - layout_no_Header_KEY;

rec_infile_sole_source := 
	RECORD
		rec_infile_slim;
		unsigned6 result_rid;
	END;
		
infile_slim := PROJECT(infile, transform({rec_infile_sole_source}, self.result_rid := left.rid; self := left)
											);

//only want result_all rows that might be sole-sourced for: TUCS
is_TUCS := infile_slim.source_field IN mdr.sourcetools.set_TUCS_Ptrack;

infile_slim_sample := output(infile_slim(is_TUCS), named('infile_slim'+'_'+'is_TUCS'+'_sample'));

//---------------------------------------------------------------

#OPTION('multiplePersistInstances',FALSE); 


	//--- 1. Sole-sourced DIDs

PHDR_extract_DIDs_TUCS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_TUCS = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_TUCS_sample := output(choosen(PHDR_extract_DIDs_TUCS, 200), named('sample'+'_'+'PHDR_extract_DIDs_TUCS'));

PHDR_extract_DIDs_nonTUCS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_TUCS = true), hash(did)), did, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_nonTUCS_sample := output(choosen(PHDR_extract_DIDs_nonTUCS, 200), named('sample'+'_'+'PHDR_extract_DIDs_nonTUCS'));

PHDR_extract_DIDs_src_TUCS := JOIN(sort(distribute(PHDR_extract_DIDs_TUCS, hash(did)), did, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DIDs_nonTUCS, hash(did)), did, local,skew(1.0))	
																	 ,left.did = right.did
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDs'+'_'+set_name_TUCS+'_'+eval_case)
																	;

sample_extract_DIDs_TUCS := OUTPUT(PHDR_extract_DIDs_src_TUCS, named('PHDR_extract_DIDs'+'_'+set_name_TUCS+'_'+eval_case+'_sample'));
count_extract_DIDs_TUCS  := OUTPUT(count(PHDR_extract_DIDs_src_TUCS), named('PHDR_extract_DIDs'+'_'+set_name_TUCS+'_'+eval_case+'_count'));


DIDs_solesrc_TUCS := JOIN(sort(distribute(infile_slim(is_TUCS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
													,sort(distribute(PHDR_extract_DIDs_src_TUCS, hash(did)), did,src,rid, local,skew(1.0))
													,(unsigned6) left.did = right.did
														AND left.src = right.src
														AND left.result_rid = right.rid

													,skew(1.0)
												 );	
									 
eval_DIDs_sole_sourced_TUCS := OUTPUT(sort(distribute(DIDs_solesrc_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDs_TUCS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDs
		sole_sourced_unique_DIDs_TUCS := DEDUP(sort(distribute(DIDs_solesrc_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Sole_sourced_DID_values := OUTPUT(COUNT(sole_sourced_unique_DIDs_TUCS), named('Sole_sourced_DID_values_'+set_name_TUCS+'_'+eval_case));


//By Source: Sole-Sourced DIDs:
DIDs_by_Source_TUCS := DEDUP(sort(distribute(DIDs_solesrc_TUCS, hash(source_field,did))
																, source_field,did, local,skew(1.0))
														, source_field,did, all,local);
										
tbl_DIDs_by_Source_TUCS := OUTPUT(TABLE(DIDs_by_Source_TUCS,
																					{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																						source_field, few)
																	, all, named('SoleSourcedDidsBySource' + '_TUCS'));

//By Search: Sole-Sourced DIDAddrs:
DIDs_by_Search_TUCS := DEDUP(sort(distribute(DIDs_solesrc_TUCS, hash(row_ID,did))
																, row_ID,did, local,skew(1.0))
														, row_ID,did, all,local);
										
tbl_DIDs_by_Search_TUCS := OUTPUT(TABLE(DIDs_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsBySearch' + '_TUCS'));

//----------------------------------------------------

	//--- 2. Sole-sourced Names - at the DID level
		
PHDR_extract_Names_TUCS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_TUCS = true), hash(did)), did,lname,fname,mname,name_suffix, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_TUCS_sample := output(choosen(PHDR_extract_Names_TUCS, 200), named('sample'+'_'+'PHDR_extract_Names_TUCS'));

PHDR_extract_Names_nonTUCS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_TUCS = true), hash(did)), did,lname,fname,mname,name_suffix, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_nonTUCS_sample := output(choosen(PHDR_extract_Names_nonTUCS, 200), named('sample'+'_'+'PHDR_extract_Names_nonTUCS'));

PHDR_extract_DidNames_src_TUCS := JOIN(sort(distribute(PHDR_extract_Names_TUCS, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_Names_nonTUCS, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))	
																		 ,left.did = right.did
																			AND trim(left.lname, all) = trim(right.lname, all)
																			AND trim(left.fname, all) = trim(right.fname, all)
																			AND trim(left.mname, all) = trim(right.mname, all)
																			AND trim(left.name_suffix, all) = trim(right.name_suffix, all)
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidNames'+'_'+set_name_TUCS+'_'+eval_case)
																		;

sample_extract_DIDNames_TUCS := OUTPUT(PHDR_extract_DidNames_src_TUCS, named('PHDR_extract_DidNames'+'_'+set_name_TUCS+'_'+eval_case+'_sample'));
count_extract_DIDNames_TUCS  := OUTPUT(count(PHDR_extract_DidNames_src_TUCS), named('PHDR_extract_DidNames'+'_'+set_name_TUCS+'_'+eval_case+'_count'));


DIDNames_solesrc_TUCS := JOIN(sort(distribute(infile_slim(is_TUCS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDNames_src_TUCS, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
																AND left.result_rid = right.rid

															,skew(1.0)
														 );	
									 
eval_DIDNames_sole_sourced_TUCS := OUTPUT(sort(distribute(DIDNames_solesrc_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDNames_TUCS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDNames
		sole_sourced_unique_DIDNames_TUCS := DEDUP(sort(distribute(DIDNames_solesrc_TUCS, hash(did))
																									, did,lname,fname,mname,name_suffix, local,skew(1.0))
																							, did,lname,fname,mname,name_suffix, all,local);

		Sole_sourced_Name_values := OUTPUT(COUNT(sole_sourced_unique_DIDNames_TUCS), named('Sole_sourced_Name_values_'+set_name_TUCS+'_'+eval_case));

		DIDs_with_unique_DIDNames_TUCS := DEDUP(sort(distribute(DIDNames_solesrc_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Name_values := OUTPUT(COUNT(DIDs_with_unique_DIDNames_TUCS), named('DIDs_with_unique_DIDNames_'+set_name_TUCS+'_'+eval_case));

//By Source: Sole-Sourced DIDNames:
DIDNames_by_Source_TUCS := DEDUP(sort(distribute(DIDNames_solesrc_TUCS, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
																
tbl_DIDNames_by_Source_TUCS := OUTPUT(TABLE(DIDNames_by_Source_TUCS,
																							{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																								source_field, few)
																			, all, named('SoleSourcedDidNamesBySource' + '_TUCS'));

//By Search: Sole-Sourced DIDNames:
DIDNames_by_Search_TUCS := DEDUP(sort(distribute(DIDNames_solesrc_TUCS, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDNames_by_Search_TUCS := OUTPUT(TABLE(DIDNames_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidNamesBySearch' + '_TUCS'));

//---------------------------

	//--- 3. Sole-sourced Addresses - at the DID level
		
PHDR_extract_Addrs_TUCS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_TUCS = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_TUCS_sample := output(choosen(PHDR_extract_Addrs_TUCS, 200), named('sample'+'_'+'PHDR_extract_Addrs_TUCS'));

PHDR_extract_Addrs_nonTUCS := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_TUCS = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_nonTUCS_sample := output(choosen(PHDR_extract_Addrs_nonTUCS, 200), named('sample'+'_'+'PHDR_extract_Addrs_nonTUCS'));

PHDR_extract_DidAddrs_src_TUCS := JOIN(sort(distribute(PHDR_extract_Addrs_TUCS, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_Addrs_nonTUCS, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))	
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
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidAddrs'+'_'+set_name_TUCS+'_'+eval_case)
																		;

sample_extract_DIDAddrs_TUCS := OUTPUT(PHDR_extract_DidAddrs_src_TUCS, named('PHDR_extract_DidAddrs'+'_'+set_name_TUCS+'_'+eval_case+'_sample'));
count_extract_DIDAddrs_TUCS  := OUTPUT(count(PHDR_extract_DidAddrs_src_TUCS), named('PHDR_extract_DidAddrs'+'_'+set_name_TUCS+'_'+eval_case+'_count'));


DIDAddrs_solesrc_TUCS := JOIN(sort(distribute(infile_slim(is_TUCS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDAddrs_src_TUCS, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDAddrs_sole_sourced_TUCS := OUTPUT(sort(distribute(DIDAddrs_solesrc_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDAddrs_TUCS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDAddrs
		sole_sourced_unique_DIDAddrs_TUCS := DEDUP(sort(distribute(DIDAddrs_solesrc_TUCS, hash(did))
																									, did, zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																							, did, zip,prim_range,predir,prim_name,postdir,sec_range, all,local);

		Sole_sourced_Address_values := OUTPUT(COUNT(sole_sourced_unique_DIDAddrs_TUCS), named('Sole_sourced_Address_values_'+set_name_TUCS+'_'+eval_case));

		DIDs_with_unique_DIDAddrs_TUCS := DEDUP(sort(distribute(DIDAddrs_solesrc_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Addr_values := OUTPUT(COUNT(DIDs_with_unique_DIDAddrs_TUCS), named('DIDs_with_unique_DIDAddrs_'+set_name_TUCS+'_'+eval_case));

//By Source: Sole-Sourced DIDAddrs:
DIDAddrs_by_Source_TUCS := DEDUP(sort(distribute(DIDAddrs_solesrc_TUCS, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDAddrs_by_Source_TUCS := OUTPUT(TABLE(DIDAddrs_by_Source_TUCS,
																							{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																								source_field, few)
																			, all, named('SoleSourcedDidAddrsBySource' + '_TUCS'));

//By Search: Sole-Sourced DIDAddrs:
DIDAddrs_by_Search_TUCS := DEDUP(sort(distribute(DIDAddrs_solesrc_TUCS, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDAddrs_by_Search_TUCS := OUTPUT(TABLE(DIDAddrs_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidAddrsBySearch' + '_TUCS'));

//---------------------------------------------------------------

	//--- 4. Sole-sourced SSNs - at the DID level
		
PHDR_extract_SSNs_TUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_TUCS = true), hash(did)), did,SSN, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_TUCS_sample := output(choosen(PHDR_extract_SSNs_TUCS, 200), named('sample'+'_'+'PHDR_extract_SSNs_TUCS'));

PHDR_extract_SSNs_nonTUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_not_TUCS = true), hash(did)), did,SSN, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_nonTUCS_sample := output(choosen(PHDR_extract_SSNs_nonTUCS, 200), named('sample'+'_'+'PHDR_extract_SSNs_nonTUCS'));

PHDR_extract_DidSSNs_src_TUCS := JOIN(sort(distribute(PHDR_extract_SSNs_TUCS, hash(did)), did,SSN, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_SSNs_nonTUCS, hash(did)), did,SSN, local,skew(1.0))	
																		 ,left.did = right.did
																		 AND (unsigned6) left.SSN = (unsigned6) right.SSN
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidSSNs'+'_'+set_name_TUCS+'_'+eval_case)
																		;

sample_extract_DIDSSNs_TUCS := OUTPUT(PHDR_extract_DidSSNs_src_TUCS, named('PHDR_extract_DidSSNs'+'_'+set_name_TUCS+'_'+eval_case+'_sample'));
count_extract_DIDSSNs_TUCS  := OUTPUT(count(PHDR_extract_DidSSNs_src_TUCS), named('PHDR_extract_DidSSNs'+'_'+set_name_TUCS+'_'+eval_case+'_count'));


DIDSSNs_solesrc_TUCS := JOIN(sort(distribute(infile_slim(is_TUCS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDSSNs_src_TUCS, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDSSNs_sole_sourced_TUCS := OUTPUT(sort(distribute(DIDSSNs_solesrc_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDSSNs_TUCS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDSSNs
		sole_sourced_unique_DIDSSNs_TUCS := DEDUP(sort(distribute(DIDSSNs_solesrc_TUCS, hash(did))
																									, did, SSN, local,skew(1.0))
																							, did, SSN, all,local);

		Sole_sourced_SSN_values := OUTPUT(COUNT(sole_sourced_unique_DIDSSNs_TUCS), named('Sole_sourced_SSN_values_'+set_name_TUCS+'_'+eval_case));

		DIDs_with_unique_DIDSSNs_TUCS := DEDUP(sort(distribute(DIDSSNs_solesrc_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_SSN_values := OUTPUT(COUNT(DIDs_with_unique_DIDSSNs_TUCS), named('DIDs_with_unique_DIDSSNs_'+set_name_TUCS+'_'+eval_case));

//By Source: Sole-Sourced DIDSSNs:
DIDSSNs_by_Source_TUCS := DEDUP(sort(distribute(DIDSSNs_solesrc_TUCS, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDSSNs_by_Source_TUCS := OUTPUT(TABLE(DIDSSNs_by_Source_TUCS,
																							{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																								source_field, few)
																			, all, named('SoleSourcedDidSSNsBySource' + '_TUCS'));

//By Search: Sole-Sourced DIDSSNs:
DIDSSNs_by_Search_TUCS := DEDUP(sort(distribute(DIDSSNs_solesrc_TUCS, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDSSNs_by_Search_TUCS := OUTPUT(TABLE(DIDSSNs_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidSSNsBySearch' + '_TUCS'));

//---------------------------------------------------------------

	//--- 5. Sole-sourced DOBs - at the DID level
		
PHDR_extract_DOBs_TUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_TUCS = true), hash(did)), did,DOB, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_TUCS_sample := output(choosen(PHDR_extract_DOBs_TUCS, 200), named('sample'+'_'+'PHDR_extract_DOBs_TUCS'));

PHDR_extract_DOBs_nonTUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_not_TUCS = true), hash(did)), did,DOB, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_nonTUCS_sample := output(choosen(PHDR_extract_DOBs_nonTUCS, 200), named('sample'+'_'+'PHDR_extract_DOBs_nonTUCS'));

PHDR_extract_DidDOBs_src_TUCS := JOIN(sort(distribute(PHDR_extract_DOBs_TUCS, hash(did)), did,DOB, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_DOBs_nonTUCS, hash(did)), did,DOB, local,skew(1.0))	
																		 ,left.did = right.did
																		 AND (unsigned6) left.DOB = (unsigned6) right.DOB
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDOBs'+'_'+set_name_TUCS+'_'+eval_case)
																		;

sample_extract_DIDDOBs_TUCS := OUTPUT(PHDR_extract_DidDOBs_src_TUCS, named('PHDR_extract_DidDOBs'+'_'+set_name_TUCS+'_'+eval_case+'_sample'));
count_extract_DIDDOBs_TUCS  := OUTPUT(count(PHDR_extract_DidDOBs_src_TUCS), named('PHDR_extract_DidDOBs'+'_'+set_name_TUCS+'_'+eval_case+'_count'));


DIDDOBs_solesrc_TUCS := JOIN(sort(distribute(infile_slim(is_TUCS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDOBs_src_TUCS, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDDOBs_sole_sourced_TUCS := OUTPUT(sort(distribute(DIDDOBs_solesrc_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDOBs_TUCS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDOBs
		sole_sourced_unique_DIDDOBs_TUCS := DEDUP(sort(distribute(DIDDOBs_solesrc_TUCS, hash(did))
																									, did, DOB, local,skew(1.0))
																							, did, DOB, all,local);

		Sole_sourced_DOB_values := OUTPUT(COUNT(sole_sourced_unique_DIDDOBs_TUCS), named('Sole_sourced_DOB_values_'+set_name_TUCS+'_'+eval_case));

		DIDs_with_unique_DIDDOBs_TUCS := DEDUP(sort(distribute(DIDDOBs_solesrc_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOB_values := OUTPUT(COUNT(DIDs_with_unique_DIDDOBs_TUCS), named('DIDs_with_unique_DIDDOBs_'+set_name_TUCS+'_'+eval_case));

//By Source: Sole-Sourced DIDDOBs:
DIDDOBs_by_Source_TUCS := DEDUP(sort(distribute(DIDDOBs_solesrc_TUCS, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDDOBs_by_Source_TUCS := OUTPUT(TABLE(DIDDOBs_by_Source_TUCS,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidDOBsBySource' + '_TUCS'));

//By Search: Sole-Sourced DIDDOBs:
DIDDOBs_by_Search_TUCS := DEDUP(sort(distribute(DIDDOBs_solesrc_TUCS, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDDOBs_by_Search_TUCS := OUTPUT(TABLE(DIDDOBs_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDOBsBySearch' + '_TUCS'));

//---------------------------------------------------------------

	//--- 6. Sole-sourced DLs - at the DID level
		
PHDR_extract_DLs_TUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_TUCS = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_TUCS_sample := output(choosen(PHDR_extract_DLs_TUCS, 200), named('sample'+'_'+'PHDR_extract_DLs_TUCS'));

PHDR_extract_DLs_nonTUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_not_TUCS = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_nonTUCS_sample := output(choosen(PHDR_extract_DLs_nonTUCS, 200), named('sample'+'_'+'PHDR_extract_DLs_nonTUCS'));

PHDR_extract_DidDLs_src_TUCS := JOIN(sort(distribute(PHDR_extract_DLs_TUCS, hash(did)), did,vendor_id, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DLs_nonTUCS, hash(did)), did,vendor_id, local,skew(1.0))	
																	 ,left.did = right.did
																		AND trim(left.vendor_id, all) = trim(right.vendor_id, all)
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDLs'+'_'+set_name_TUCS+'_'+eval_case)
																	;

sample_extract_DIDDLs_TUCS := OUTPUT(PHDR_extract_DidDLs_src_TUCS, named('PHDR_extract_DidDLs'+'_'+set_name_TUCS+'_'+eval_case+'_sample'));
count_extract_DIDDLs_TUCS  := OUTPUT(count(PHDR_extract_DidDLs_src_TUCS), named('PHDR_extract_DidDLs'+'_'+set_name_TUCS+'_'+eval_case+'_count'));


DIDDLs_solesrc_TUCS := JOIN(sort(distribute(infile_slim(is_TUCS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDLs_src_TUCS, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDDLs_sole_sourced_TUCS := OUTPUT(sort(distribute(DIDDLs_solesrc_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDLs_TUCS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDLs
		sole_sourced_unique_DIDDLs_TUCS := DEDUP(sort(distribute(DIDDLs_solesrc_TUCS, hash(did))
																									, did, vendor_id, local,skew(1.0))
																							, did, vendor_id, all,local);

		Sole_sourced_DL_values := OUTPUT(COUNT(sole_sourced_unique_DIDDLs_TUCS), named('Sole_sourced_DL_values_'+set_name_TUCS+'_'+eval_case));

		DIDs_with_unique_DIDDLs_TUCS := DEDUP(sort(distribute(DIDDLs_solesrc_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DL_values := OUTPUT(COUNT(DIDs_with_unique_DIDDLs_TUCS), named('DIDs_with_unique_DIDDLs_'+set_name_TUCS+'_'+eval_case));

//By Source: Sole-Sourced DIDDLs:
DIDDLs_by_Source_TUCS := DEDUP(sort(distribute(DIDDLs_solesrc_TUCS, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDDLs_by_Source_TUCS := OUTPUT(TABLE(DIDDLs_by_Source_TUCS,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidDLsBySource' + '_TUCS'));

//By Search: Sole-Sourced DIDDLs:
DIDDLs_by_Search_TUCS := DEDUP(sort(distribute(DIDDLs_solesrc_TUCS, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDDLs_by_Search_TUCS := OUTPUT(TABLE(DIDDLs_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDLsBySearch' + '_TUCS'));

//---------------------------------------------------------------

	//--- 7. Sole-sourced DODs - at the DID level
		
PHDR_extract_DODs_TUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_DOD=true AND src_is_TUCS = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DODs_TUCS_sample := output(choosen(PHDR_extract_DODs_TUCS, 200), named('sample'+'_'+'PHDR_extract_DODs_TUCS'));

PHDR_extract_DODs_nonTUCS := DEDUP(sort(distribute(PHdr_extract_plus(has_DOD=true AND src_is_not_TUCS = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DODs_nonTUCS_sample := output(choosen(PHDR_extract_DODs_nonTUCS, 200), named('sample'+'_'+'PHDR_extract_DODs_nonTUCS'));

PHDR_extract_DidDODs_src_TUCS := JOIN(sort(distribute(PHDR_extract_DODs_TUCS, hash(did)), did,vendor_id, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DODs_nonTUCS, hash(did)), did,vendor_id, local,skew(1.0))	
																	 ,left.did = right.did
																		AND trim(left.DOD_from_LNDMF, all) = trim(right.DOD_from_LNDMF, all)
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDODs'+'_'+set_name_TUCS+'_'+eval_case)
																	;

sample_extract_DIDDODs_TUCS := OUTPUT(PHDR_extract_DidDODs_src_TUCS, named('PHDR_extract_DidDODs'+'_'+set_name_TUCS+'_'+eval_case+'_sample'));
count_extract_DIDDODs_TUCS  := OUTPUT(count(PHDR_extract_DidDODs_src_TUCS), named('PHDR_extract_DidDODs'+'_'+set_name_TUCS+'_'+eval_case+'_count'));


DIDDODs_solesrc_TUCS := JOIN(sort(distribute(infile_slim(is_TUCS), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDODs_src_TUCS, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid
//depending on the timing of the PHDR build, external TU source records like for TUCS may experience a change in RID

														,skew(1.0)
													 );	
									 
eval_DIDDODs_sole_sourced_TUCS := OUTPUT(sort(distribute(DIDDODs_solesrc_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDODs_TUCS' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDODs
		sole_sourced_unique_DIDDODs_TUCS := DEDUP(sort(distribute(DIDDODs_solesrc_TUCS, hash(did))
																									, did, vendor_id, local,skew(1.0))
																							, did, vendor_id, all,local);

		Sole_sourced_DOD_values := OUTPUT(COUNT(sole_sourced_unique_DIDDODs_TUCS), named('Sole_sourced_DOD_values_'+set_name_TUCS+'_'+eval_case));

		DIDs_with_unique_DIDDODs_TUCS := DEDUP(sort(distribute(DIDDODs_solesrc_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOD_values := OUTPUT(COUNT(DIDs_with_unique_DIDDODs_TUCS), named('DIDs_with_unique_DIDDODs_'+set_name_TUCS+'_'+eval_case));

//By Source: Sole-Sourced DIDDODs:
DIDDODs_by_Source_TUCS := DEDUP(sort(distribute(DIDDODs_solesrc_TUCS, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDDODs_by_Source_TUCS := OUTPUT(TABLE(DIDDODs_by_Source_TUCS,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidDODsBySource' + '_TUCS'));

//By Search: Sole-Sourced DIDDODs:
DIDDODs_by_Search_TUCS := DEDUP(sort(distribute(DIDDODs_solesrc_TUCS, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDDODs_by_Search_TUCS := OUTPUT(TABLE(DIDDODs_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDODsBySearch' + '_TUCS'));

//--------------------------------------------------------------------------------------

rec_All_sole_sourced :=
	RECORD
		DIDs_solesrc_TUCS;
		string sole_source_category := '';
	END;
	

All_sole_sourced_TUCS := project(DIDs_solesrc_TUCS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDs_' + 'TUCS', self := left))
													+
												  project(DIDNames_solesrc_TUCS , transform(rec_All_sole_sourced, self.sole_source_category := 'DIDNames_' + 'TUCS', self := left))
													+
												  project(DIDAddrs_solesrc_TUCS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDAddrs_' + 'TUCS', self := left))
													+
												  project(DIDSSNs_solesrc_TUCS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDSSNs_' + 'TUCS', self := left))
													+
												  project(DIDDOBs_solesrc_TUCS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDOBs_' + 'TUCS', self := left))
												 +
												  project(DIDDLs_solesrc_TUCS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDLs_' + 'TUCS', self := left))
												 +
												  project(DIDDODs_solesrc_TUCS, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDODs_' + 'TUCS', self := left))
												 :PERSIST('~thor400_92::persist::ckelly::ALL_sole_sourced_'+set_name_TUCS+'_'+eval_case)
												 ;

eval_ALL_sole_sourced_TUCS := OUTPUT(sort(distribute(All_sole_sourced_TUCS, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_ALL_TUCS' + '_' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
All_sole_sourced_rows_count := OUTPUT(COUNT(All_sole_sourced_TUCS), named('All_sole_sourced_rows_count' + '_TUCS'));
Database_records := DEDUP(sort(distribute(All_sole_sourced_TUCS,hash(did)), did,rid, local), did,rid, all,local);
Database_records_involving_sole_sourced_data := OUTPUT(COUNT(Database_records), named('Total_Number_of_database_records_involving_any_sole_sourced_data' + '_TUCS'));



//By Source: Sole-Sourced DIDs - All:
All_DIDs_by_Source_TUCS := DEDUP(sort(distribute(All_sole_sourced_TUCS, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
											
Number_of_Sources_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Source_TUCS,
																																{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																																	source_field, few)
																												, all, named('Number_of_Sources_involving_sole_sourced_data' + '_TUCS'));

//By Search: Sole-Sourced DIDs - All:
All_DIDs_by_Search_TUCS := DEDUP(sort(distribute(All_sole_sourced_TUCS, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
																
Number_of_Searches_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Search_TUCS, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('Number_of_Searches_involving_sole_sourced_data' + '_TUCS'));

//------------ Unique Count: Sole-sourced DIDs - ALL
		sole_sourced_unique_DID_ALL_TUCS := DEDUP(sort(distribute(All_sole_sourced_TUCS, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Total_LexIDs_involving_any_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DID_ALL_TUCS), named('Total_LexIDs_involving_any_sole_sourced_data' + '_TUCS'));

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
											,Sole_sourced_DOD_values
											
											,DIDs_with_unique_Name_values
											,DIDs_with_unique_Addr_values
											,DIDs_with_unique_SSN_values
											,DIDs_with_unique_DOB_values
											,DIDs_with_unique_DL_values
											,DIDs_with_unique_DOD_values
											
											,eval_ALL_sole_sourced_TUCS
											,eval_DIDs_sole_sourced_TUCS
											,eval_DIDNames_sole_sourced_TUCS
											,eval_DIDAddrs_sole_sourced_TUCS
											,eval_DIDSSNs_sole_sourced_TUCS
											,eval_DIDDOBs_sole_sourced_TUCS
											,eval_DIDDLs_sole_sourced_TUCS
											,eval_DIDDODs_sole_sourced_TUCS
											
											,tbl_DIDs_by_Source_TUCS
											,tbl_DIDs_by_Search_TUCS
											
											,tbl_DIDNames_by_Source_TUCS
											,tbl_DIDNames_by_Search_TUCS
											
											,tbl_DIDAddrs_by_Source_TUCS
											,tbl_DIDAddrs_by_Search_TUCS
											
											,tbl_DIDSSNs_by_Source_TUCS
											,tbl_DIDSSNs_by_Search_TUCS
											
											,tbl_DIDDOBs_by_Source_TUCS
											,tbl_DIDDOBs_by_Search_TUCS
											
											,tbl_DIDDLs_by_Source_TUCS
											,tbl_DIDDLs_by_Search_TUCS
											
											,tbl_DIDDODs_by_Source_TUCS
											,tbl_DIDDODs_by_Search_TUCS
											
											//For research if necessary:
											,infile_slim_sample,
											PHDR_extract_plus_sample,
											PHDR_extract_DIDs_TUCS_sample,
											PHDR_extract_DIDs_nonTUCS_sample,
											PHDR_extract_Names_TUCS_sample,
											PHDR_extract_Names_nonTUCS_sample,
											PHDR_extract_Addrs_TUCS_sample,
											PHDR_extract_Addrs_nonTUCS_sample,
											PHDR_extract_SSNs_TUCS_sample,
											PHDR_extract_SSNs_nonTUCS_sample,
											PHDR_extract_DOBs_TUCS_sample,
											PHDR_extract_DOBs_nonTUCS_sample,
											PHDR_extract_DLs_TUCS_sample,
											PHDR_extract_DLs_nonTUCS_sample,
											PHDR_extract_DODs_TUCS_sample,
											PHDR_extract_DODs_nonTUCS_sample,
											
											sample_extract_DIDs_TUCS,count_extract_DIDs_TUCS,
											sample_extract_DIDNames_TUCS,count_extract_DIDNames_TUCS,
											sample_extract_DIDAddrs_TUCS,count_extract_DIDAddrs_TUCS,
											sample_extract_DIDSSNs_TUCS,count_extract_DIDSSNs_TUCS,
											sample_extract_DIDDOBs_TUCS,count_extract_DIDDOBs_TUCS,
											sample_extract_DIDDLs_TUCS,count_extract_DIDDLs_TUCS,
											sample_extract_DIDDODs_TUCS,count_extract_DIDDODs_TUCS
		
										 );
											 
	ENDMACRO;
//---------------------------------------------------------------------------------------------------------
