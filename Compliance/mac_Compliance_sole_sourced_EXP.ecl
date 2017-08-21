//Results from "mac_Compliance_sole_sourced_PHdr_extract_V2" are required.
//Then see the EXAMPLE below the macro

EXPORT mac_Compliance_sole_sourced_EXP(infile,eval_case = '',row_ID = 0, source_field,outfile) := 
  MACRO
	

//		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
		rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;

	
		PHdr_extract := DATASET('~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv'
																,rec_PHdr_extract
																,CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------

//Sole-sourced from:
//c.	Experian 

set_EXP := 			[mdr.sourcetools.set_Experian_DL
								,mdr.sourcetools.set_Experian_FEIN 
								,mdr.sourcetools.set_Experian_vehicles 
								,mdr.sourcetools.set_FBNV2_Experian_Direct 
								,mdr.sourcetools.set_Experian_Credit_Header 
								,mdr.sourcetools.set_Experian_Phones
								,mdr.sourcetools.set_Experian_CRDB
								];




rec_criteria := 
	RECORD
		rec_PHdr_extract;
		Compliance.Layout_has_PII;
		
		boolean src_is_EXP;
		boolean src_is_not_EXP;

	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_EXP					:= LE.src IN set_EXP;
	 self.src_is_not_EXP       := self.src_is_EXP = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 self.has_DOD              := IF(LE.DOD_from_LNDMF <> '',true,false);
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

//----------------

set_name_EXP := 'EXP';

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

is_EXP := infile_slim.source_field IN set_EXP;

	//--- 1. Sole-sourced DIDs

PHDR_extract_DIDs_EXP := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EXP = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_EXP_sample := output(choosen(PHDR_extract_DIDs_EXP, 200), named('sample'+'_'+'PHDR_extract_DIDs_EXP'));

PHDR_extract_DIDs_nonEXP := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EXP = true), hash(did)), did, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_nonEXP_sample := output(choosen(PHDR_extract_DIDs_nonEXP, 200), named('sample'+'_'+'PHDR_extract_DIDs_nonEXP'));

PHDR_extract_DIDs_src_EXP := JOIN(sort(distribute(PHDR_extract_DIDs_EXP, hash(did)), did, local,skew(1.0))
																 ,sort(distribute(PHDR_extract_DIDs_nonEXP, hash(did)), did, local,skew(1.0))	
																 ,left.did = right.did
																 ,LEFT ONLY
																 ,skew(1.0)
																)
																:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDs'+'_'+set_name_EXP+'_'+eval_case)
																;

sample_extract_DIDs_EXP := OUTPUT(PHDR_extract_DIDs_src_EXP, named('PHDR_extract_DIDs'+'_'+set_name_EXP+'_'+eval_case+'_sample'));
count_extract_DIDs_EXP  := OUTPUT(count(PHDR_extract_DIDs_src_EXP), named('PHDR_extract_DIDs'+'_'+set_name_EXP+'_'+eval_case+'_count'));


DIDs_solesrc_EXP := JOIN(sort(distribute(infile_slim(is_EXP), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
												,sort(distribute(PHDR_extract_DIDs_src_EXP, hash(did)), did,src,rid, local,skew(1.0))
												,(unsigned6) left.did = right.did
													AND left.src = right.src
													AND left.result_rid = right.rid

												,skew(1.0)
											 );	
									 
eval_DIDs_sole_sourced_EXP := OUTPUT(sort(distribute(DIDs_solesrc_EXP, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDs_EXP' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDs
		sole_sourced_unique_DIDs_EXP := DEDUP(sort(distribute(DIDs_solesrc_EXP, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Sole_sourced_DID_values := OUTPUT(COUNT(sole_sourced_unique_DIDs_EXP), named('Sole_sourced_DID_values_'+set_name_EXP+'_'+eval_case));


//By Source: Sole-Sourced DIDs:
DIDs_by_Source_EXP := DEDUP(sort(distribute(DIDs_solesrc_EXP, hash(source_field,did))
															, source_field,did, local,skew(1.0))
													, source_field,did, all,local);
										
tbl_DIDs_by_Source_EXP := OUTPUT(TABLE(DIDs_by_Source_EXP,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidsBySource' + '_EXP'));

//By Search: Sole-Sourced DIDAddrs:
DIDs_by_Search_EXP := DEDUP(sort(distribute(DIDs_solesrc_EXP, hash(row_ID,did))
																, row_ID,did, local,skew(1.0))
														, row_ID,did, all,local);
										
tbl_DIDs_by_Search_EXP := OUTPUT(TABLE(DIDs_by_Search_EXP, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsBySearch' + '_EXP'));

//----------------------------------------------------

	//--- 2. Sole-sourced Names - at the DID level
		
PHDR_extract_Names_EXP := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EXP = true), hash(did)), did,lname,fname,mname,name_suffix, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_EXP_sample := output(choosen(PHDR_extract_Names_EXP, 200), named('sample'+'_'+'PHDR_extract_Names_EXP'));

PHDR_extract_Names_nonEXP := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EXP = true), hash(did)), did,lname,fname,mname,name_suffix, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_nonEXP_sample := output(choosen(PHDR_extract_Names_nonEXP, 200), named('sample'+'_'+'PHDR_extract_Names_nonEXP'));

PHDR_extract_DidNames_src_EXP := JOIN(sort(distribute(PHDR_extract_Names_EXP, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_Names_nonEXP, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))	
																		 ,left.did = right.did
																			AND trim(left.lname, all) = trim(right.lname, all)
																			AND trim(left.fname, all) = trim(right.fname, all)
																			AND trim(left.mname, all) = trim(right.mname, all)
																			AND trim(left.name_suffix, all) = trim(right.name_suffix, all)
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidNames'+'_'+set_name_EXP+'_'+eval_case)
																		;

sample_extract_DIDNames_EXP := OUTPUT(PHDR_extract_DidNames_src_EXP, named('PHDR_extract_DidNames'+'_'+set_name_EXP+'_'+eval_case+'_sample'));
count_extract_DIDNames_EXP  := OUTPUT(count(PHDR_extract_DidNames_src_EXP), named('PHDR_extract_DidNames'+'_'+set_name_EXP+'_'+eval_case+'_count'));


DIDNames_solesrc_EXP := JOIN(sort(distribute(infile_slim(is_EXP), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDNames_src_EXP, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDNames_sole_sourced_EXP := OUTPUT(sort(distribute(DIDNames_solesrc_EXP, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDNames_EXP' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDNames
		sole_sourced_unique_DIDNames_EXP := DEDUP(sort(distribute(DIDNames_solesrc_EXP, hash(did))
																								, did,lname,fname,mname,name_suffix, local,skew(1.0))
																						, did,lname,fname,mname,name_suffix, all,local);

		Sole_sourced_Name_values := OUTPUT(COUNT(sole_sourced_unique_DIDNames_EXP), named('Sole_sourced_Name_values_'+set_name_EXP+'_'+eval_case));

		DIDs_with_unique_DIDNames_EXP := DEDUP(sort(distribute(DIDNames_solesrc_EXP, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Name_values := OUTPUT(COUNT(DIDs_with_unique_DIDNames_EXP), named('DIDs_with_unique_DIDNames_'+set_name_EXP+'_'+eval_case));

//By Source: Sole-Sourced DIDNames:
DIDNames_by_Source_EXP := DEDUP(sort(distribute(DIDNames_solesrc_EXP, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDNames_by_Source_EXP := OUTPUT(TABLE(DIDNames_by_Source_EXP,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidNamesBySource' + '_EXP'));

//By Search: Sole-Sourced DIDNames:
DIDNames_by_Search_EXP := DEDUP(sort(distribute(DIDNames_solesrc_EXP, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDNames_by_Search_EXP := OUTPUT(TABLE(DIDNames_by_Search_EXP, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidNamesBySearch' + '_EXP'));

//---------------------------

	//--- 3. Sole-sourced Addresses - at the DID level
		
PHDR_extract_Addrs_EXP := DEDUP(sort(distribute(PHdr_extract_plus(src_is_EXP = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_EXP_sample := output(choosen(PHDR_extract_Addrs_EXP, 200), named('sample'+'_'+'PHDR_extract_Addrs_EXP'));

PHDR_extract_Addrs_nonEXP := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_EXP = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_nonEXP_sample := output(choosen(PHDR_extract_Addrs_nonEXP, 200), named('sample'+'_'+'PHDR_extract_Addrs_nonEXP'));

PHDR_extract_DidAddrs_src_EXP := JOIN(sort(distribute(PHDR_extract_Addrs_EXP, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_Addrs_nonEXP, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))	
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
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidAddrs'+'_'+set_name_EXP+'_'+eval_case)
																		;

sample_extract_DIDAddrs_EXP := OUTPUT(PHDR_extract_DidAddrs_src_EXP, named('PHDR_extract_DidAddrs'+'_'+set_name_EXP+'_'+eval_case+'_sample'));
count_extract_DIDAddrs_EXP  := OUTPUT(count(PHDR_extract_DidAddrs_src_EXP), named('PHDR_extract_DidAddrs'+'_'+set_name_EXP+'_'+eval_case+'_count'));


DIDAddrs_solesrc_EXP := JOIN(sort(distribute(infile_slim(is_EXP), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDAddrs_src_EXP, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDAddrs_sole_sourced_EXP := OUTPUT(sort(distribute(DIDAddrs_solesrc_EXP, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDAddrs_EXP' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDAddrs
		sole_sourced_unique_DIDAddrs_EXP := DEDUP(sort(distribute(DIDAddrs_solesrc_EXP, hash(did))
																								, did, zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																						, did, zip,prim_range,predir,prim_name,postdir,sec_range, all,local);

		Sole_sourced_Address_values := OUTPUT(COUNT(sole_sourced_unique_DIDAddrs_EXP), named('Sole_sourced_Address_values_'+set_name_EXP+'_'+eval_case));

		DIDs_with_unique_DIDAddrs_EXP := DEDUP(sort(distribute(DIDAddrs_solesrc_EXP, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Addr_values := OUTPUT(COUNT(DIDs_with_unique_DIDAddrs_EXP), named('DIDs_with_unique_DIDAddrs_'+set_name_EXP+'_'+eval_case));

//By Source: Sole-Sourced DIDAddrs:
DIDAddrs_by_Source_EXP := DEDUP(sort(distribute(DIDAddrs_solesrc_EXP, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDAddrs_by_Source_EXP := OUTPUT(TABLE(DIDAddrs_by_Source_EXP,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidAddrsBySource' + '_EXP'));

//By Search: Sole-Sourced DIDAddrs:
DIDAddrs_by_Search_EXP := DEDUP(sort(distribute(DIDAddrs_solesrc_EXP, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDAddrs_by_Search_EXP := OUTPUT(TABLE(DIDAddrs_by_Search_EXP, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidAddrsBySearch' + '_EXP'));

//---------------------------------------------------------------

	//--- 4. Sole-sourced SSNs - at the DID level
		
PHDR_extract_SSNs_EXP := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_EXP = true), hash(did)), did,SSN, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_EXP_sample := output(choosen(PHDR_extract_SSNs_EXP, 200), named('sample'+'_'+'PHDR_extract_SSNs_EXP'));

PHDR_extract_SSNs_nonEXP := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_not_EXP = true), hash(did)), did,SSN, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_nonEXP_sample := output(choosen(PHDR_extract_SSNs_nonEXP, 200), named('sample'+'_'+'PHDR_extract_SSNs_nonEXP'));

PHDR_extract_DidSSNs_src_EXP := JOIN(sort(distribute(PHDR_extract_SSNs_EXP, hash(did)), did,SSN, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_SSNs_nonEXP, hash(did)), did,SSN, local,skew(1.0))	
																	 ,left.did = right.did
																	 AND (unsigned6) left.SSN = (unsigned6) right.SSN
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidSSNs'+'_'+set_name_EXP+'_'+eval_case)
																	;

sample_extract_DIDSSNs_EXP := OUTPUT(PHDR_extract_DidSSNs_src_EXP, named('PHDR_extract_DidSSNs'+'_'+set_name_EXP+'_'+eval_case+'_sample'));
count_extract_DIDSSNs_EXP  := OUTPUT(count(PHDR_extract_DidSSNs_src_EXP), named('PHDR_extract_DidSSNs'+'_'+set_name_EXP+'_'+eval_case+'_count'));


DIDSSNs_solesrc_EXP := JOIN(sort(distribute(infile_slim(is_EXP), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDSSNs_src_EXP, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDSSNs_sole_sourced_EXP := OUTPUT(sort(distribute(DIDSSNs_solesrc_EXP, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDSSNs_EXP' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDSSNs
		sole_sourced_unique_DIDSSNs_EXP := DEDUP(sort(distribute(DIDSSNs_solesrc_EXP, hash(did))
																								, did, SSN, local,skew(1.0))
																						, did, SSN, all,local);

		Sole_sourced_SSN_values := OUTPUT(COUNT(sole_sourced_unique_DIDSSNs_EXP), named('Sole_sourced_SSN_values_'+set_name_EXP+'_'+eval_case));

		DIDs_with_unique_DIDSSNs_EXP := DEDUP(sort(distribute(DIDSSNs_solesrc_EXP, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_SSN_values := OUTPUT(COUNT(DIDs_with_unique_DIDSSNs_EXP), named('DIDs_with_unique_DIDSSNs_'+set_name_EXP+'_'+eval_case));

//By Source: Sole-Sourced DIDSSNs:
DIDSSNs_by_Source_EXP := DEDUP(sort(distribute(DIDSSNs_solesrc_EXP, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDSSNs_by_Source_EXP := OUTPUT(TABLE(DIDSSNs_by_Source_EXP,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidSSNsBySource' + '_EXP'));

//By Search: Sole-Sourced DIDSSNs:
DIDSSNs_by_Search_EXP := DEDUP(sort(distribute(DIDSSNs_solesrc_EXP, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDSSNs_by_Search_EXP := OUTPUT(TABLE(DIDSSNs_by_Search_EXP, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidSSNsBySearch' + '_EXP'));

//---------------------------------------------------------------

	//--- 5. Sole-sourced DOBs - at the DID level
		
PHDR_extract_DOBs_EXP := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_EXP = true), hash(did)), did,DOB, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_EXP_sample := output(choosen(PHDR_extract_DOBs_EXP, 200), named('sample'+'_'+'PHDR_extract_DOBs_EXP'));

PHDR_extract_DOBs_nonEXP := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_not_EXP = true), hash(did)), did,DOB, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_nonEXP_sample := output(choosen(PHDR_extract_DOBs_nonEXP, 200), named('sample'+'_'+'PHDR_extract_DOBs_nonEXP'));

PHDR_extract_DidDOBs_src_EXP := JOIN(sort(distribute(PHDR_extract_DOBs_EXP, hash(did)), did,DOB, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_DOBs_nonEXP, hash(did)), did,DOB, local,skew(1.0))	
																		 ,left.did = right.did
																		 AND (unsigned6) left.DOB = (unsigned6) right.DOB
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDOBs'+'_'+set_name_EXP+'_'+eval_case)
																		;

sample_extract_DIDDOBs_EXP := OUTPUT(PHDR_extract_DidDOBs_src_EXP, named('PHDR_extract_DidDOBs'+'_'+set_name_EXP+'_'+eval_case+'_sample'));
count_extract_DIDDOBs_EXP  := OUTPUT(count(PHDR_extract_DidDOBs_src_EXP), named('PHDR_extract_DidDOBs'+'_'+set_name_EXP+'_'+eval_case+'_count'));


DIDDOBs_solesrc_EXP := JOIN(sort(distribute(infile_slim(is_EXP), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDOBs_src_EXP, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDDOBs_sole_sourced_EXP := OUTPUT(sort(distribute(DIDDOBs_solesrc_EXP, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDOBs_EXP' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDOBs
		sole_sourced_unique_DIDDOBs_EXP := DEDUP(sort(distribute(DIDDOBs_solesrc_EXP, hash(did))
																								, did, DOB, local,skew(1.0))
																						, did, DOB, all,local);

		Sole_sourced_DOB_values := OUTPUT(COUNT(sole_sourced_unique_DIDDOBs_EXP), named('Sole_sourced_DOB_values_'+set_name_EXP+'_'+eval_case));

		DIDs_with_unique_DIDDOBs_EXP := DEDUP(sort(distribute(DIDDOBs_solesrc_EXP, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOB_values := OUTPUT(COUNT(DIDs_with_unique_DIDDOBs_EXP), named('DIDs_with_unique_DIDDOBs_'+set_name_EXP+'_'+eval_case));

//By Source: Sole-Sourced DIDDOBs:
DIDDOBs_by_Source_EXP := DEDUP(sort(distribute(DIDDOBs_solesrc_EXP, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDDOBs_by_Source_EXP := OUTPUT(TABLE(DIDDOBs_by_Source_EXP,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidDOBsBySource' + '_EXP'));

//By Search: Sole-Sourced DIDDOBs:
DIDDOBs_by_Search_EXP := DEDUP(sort(distribute(DIDDOBs_solesrc_EXP, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDDOBs_by_Search_EXP := OUTPUT(TABLE(DIDDOBs_by_Search_EXP, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDOBsBySearch' + '_EXP'));

//---------------------------------------------------------------

	//--- 6. Sole-sourced DLs - at the DID level
		
PHDR_extract_DLs_EXP := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_EXP = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_EXP_sample := output(choosen(PHDR_extract_DLs_EXP, 200), named('sample'+'_'+'PHDR_extract_DLs_EXP'));

PHDR_extract_DLs_nonEXP := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_not_EXP = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_nonEXP_sample := output(choosen(PHDR_extract_DLs_nonEXP, 200), named('sample'+'_'+'PHDR_extract_DLs_nonEXP'));

PHDR_extract_DidDLs_src_EXP := JOIN(sort(distribute(PHDR_extract_DLs_EXP, hash(did)), did,vendor_id, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DLs_nonEXP, hash(did)), did,vendor_id, local,skew(1.0))	
																	 ,left.did = right.did
																		AND trim(left.vendor_id, all) = trim(right.vendor_id, all)
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDLs'+'_'+set_name_EXP+'_'+eval_case)
																	;

sample_extract_DIDDLs_EXP := OUTPUT(PHDR_extract_DidDLs_src_EXP, named('PHDR_extract_DidDLs'+'_'+set_name_EXP+'_'+eval_case+'_sample'));
count_extract_DIDDLs_EXP  := OUTPUT(count(PHDR_extract_DidDLs_src_EXP), named('PHDR_extract_DidDLs'+'_'+set_name_EXP+'_'+eval_case+'_count'));


DIDDLs_solesrc_EXP := JOIN(sort(distribute(infile_slim(is_EXP), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
													,sort(distribute(PHDR_extract_DIDDLs_src_EXP, hash(did)), did,src,rid, local,skew(1.0))
													,(unsigned6) left.did = right.did
														AND left.src = right.src
														AND left.result_rid = right.rid

													,skew(1.0)
												 );	
									 
eval_DIDDLs_sole_sourced_EXP := OUTPUT(sort(distribute(DIDDLs_solesrc_EXP, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDLs_EXP' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDLs
		sole_sourced_unique_DIDDLs_EXP := DEDUP(sort(distribute(DIDDLs_solesrc_EXP, hash(did))
																								, did, vendor_id, local,skew(1.0))
																						, did, vendor_id, all,local);

		Sole_sourced_DL_values := OUTPUT(COUNT(sole_sourced_unique_DIDDLs_EXP), named('Sole_sourced_DL_values_'+set_name_EXP+'_'+eval_case));

		DIDs_with_unique_DIDDLs_EXP := DEDUP(sort(distribute(DIDDLs_solesrc_EXP, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DL_values := OUTPUT(COUNT(DIDs_with_unique_DIDDLs_EXP), named('DIDs_with_unique_DIDDLs_'+set_name_EXP+'_'+eval_case));

//By Source: Sole-Sourced DIDDLs:
DIDDLs_by_Source_EXP := DEDUP(sort(distribute(DIDDLs_solesrc_EXP, hash(source_field,did))
																, source_field,did, local,skew(1.0))
														, source_field,did, all,local);
										
tbl_DIDDLs_by_Source_EXP := OUTPUT(TABLE(DIDDLs_by_Source_EXP,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidDLsBySource' + '_EXP'));

//By Search: Sole-Sourced DIDDLs:
DIDDLs_by_Search_EXP := DEDUP(sort(distribute(DIDDLs_solesrc_EXP, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDDLs_by_Search_EXP := OUTPUT(TABLE(DIDDLs_by_Search_EXP, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDLsBySearch' + '_EXP'));

//--------------------------------------------------------------------------------------

rec_All_sole_sourced :=
	RECORD
		DIDs_solesrc_EXP;
		string sole_source_category := '';
	END;
	

All_sole_sourced_EXP := project(DIDs_solesrc_EXP, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDs_' + 'EXP', self := left))
													+
												  project(DIDNames_solesrc_EXP , transform(rec_All_sole_sourced, self.sole_source_category := 'DIDNames_' + 'EXP', self := left))
													+
												  project(DIDAddrs_solesrc_EXP, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDAddrs_' + 'EXP', self := left))
													+
												  project(DIDSSNs_solesrc_EXP, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDSSNs_' + 'EXP', self := left))
													+
												  project(DIDDOBs_solesrc_EXP, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDOBs_' + 'EXP', self := left))
												 +
												  project(DIDDLs_solesrc_EXP, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDLs_' + 'EXP', self := left))
												 :PERSIST('~thor400_92::persist::ckelly::ALL_sole_sourced_'+set_name_EXP+'_'+eval_case)
												 ;

eval_ALL_sole_sourced_EXP := OUTPUT(sort(distribute(All_sole_sourced_EXP, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_ALL_EXP' + '_' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
All_sole_sourced_rows_count := OUTPUT(COUNT(All_sole_sourced_EXP), named('All_sole_sourced_rows_count' + '_EXP'));
Database_records := DEDUP(sort(distribute(All_sole_sourced_EXP,hash(did)), did,rid, local), did,rid, all,local);
Database_records_involving_sole_sourced_data := OUTPUT(COUNT(Database_records), named('Total_Number_of_database_records_involving_any_sole_sourced_data' + '_EXP'));



//By Source: Sole-Sourced DIDs - All:
All_DIDs_by_Source_EXP := DEDUP(sort(distribute(All_sole_sourced_EXP, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
Number_of_Sources_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Source_EXP,
																													{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																														source_field, few)
																									, all, named('Number_of_Sources_involving_sole_sourced_data' + '_EXP'));

//By Search: Sole-Sourced DIDs - All:
All_DIDs_by_Search_EXP := DEDUP(sort(distribute(All_sole_sourced_EXP, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
Number_of_Searches_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Search_EXP, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('Number_of_Searches_involving_sole_sourced_data' + '_EXP'));

//------------ Unique Count: Sole-sourced DIDs - ALL
		sole_sourced_unique_DID_ALL_EXP := DEDUP(sort(distribute(All_sole_sourced_EXP, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Total_LexIDs_involving_any_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DID_ALL_EXP), named('Total_LexIDs_involving_any_sole_sourced_data' + '_EXP'));

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
											
											,eval_ALL_sole_sourced_EXP
											,eval_DIDs_sole_sourced_EXP
											,eval_DIDNames_sole_sourced_EXP
											,eval_DIDAddrs_sole_sourced_EXP
											,eval_DIDSSNs_sole_sourced_EXP
											,eval_DIDDOBs_sole_sourced_EXP
											,eval_DIDDLs_sole_sourced_EXP
											
											,tbl_DIDs_by_Source_EXP
											,tbl_DIDs_by_Search_EXP
											
											,tbl_DIDNames_by_Source_EXP
											,tbl_DIDNames_by_Search_EXP
											
											,tbl_DIDAddrs_by_Source_EXP
											,tbl_DIDAddrs_by_Search_EXP
											
											,tbl_DIDSSNs_by_Source_EXP
											,tbl_DIDSSNs_by_Search_EXP
											
											,tbl_DIDDOBs_by_Source_EXP
											,tbl_DIDDOBs_by_Search_EXP
											
											,tbl_DIDDLs_by_Source_EXP
											,tbl_DIDDLs_by_Search_EXP
											
											//For research if necessary:
											,infile_slim_sample,
											PHDR_extract_DIDs_EXP_sample,
											PHDR_extract_DIDs_nonEXP_sample,
											PHDR_extract_Names_EXP_sample,
											PHDR_extract_Names_nonEXP_sample,
											PHDR_extract_Addrs_EXP_sample,
											PHDR_extract_Addrs_nonEXP_sample,
											PHDR_extract_SSNs_EXP_sample,
											PHDR_extract_SSNs_nonEXP_sample,
											PHDR_extract_DOBs_EXP_sample,
											PHDR_extract_DOBs_nonEXP_sample,
											PHDR_extract_DLs_EXP_sample,
											PHDR_extract_DLs_nonEXP_sample,
											
											sample_extract_DIDs_EXP,count_extract_DIDs_EXP,
											sample_extract_DIDNames_EXP,count_extract_DIDNames_EXP,
											sample_extract_DIDAddrs_EXP,count_extract_DIDAddrs_EXP,
											sample_extract_DIDSSNs_EXP,count_extract_DIDSSNs_EXP,
											sample_extract_DIDDOBs_EXP,count_extract_DIDDOBs_EXP,
											sample_extract_DIDDLs_EXP,count_extract_DIDDLs_EXP
		
										 );
											 
	ENDMACRO;
//---------------------------------------------------------------------------------------------------------
