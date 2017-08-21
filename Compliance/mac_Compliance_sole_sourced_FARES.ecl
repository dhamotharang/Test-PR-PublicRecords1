//Results from "mac_Compliance_sole_sourced_PHdr_extract_V2" are required.
//Then see the EXAMPLE below the macro

IMPORT Compliance,LN_PropertyV2,Data_Services,ut;

EXPORT mac_Compliance_sole_sourced_FARES(infile,eval_case = '',row_ID = 0, source_field,outfile) := 
  MACRO

//		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
		rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;

	
		PHdr_extract := DATASET('~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv'
																,rec_PHdr_extract
																,CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------

//Sole-sourced from:
//f.	FARES 

set_FARES := [mdr.sourcetools.src_Fares_Deeds_from_Asrs			//     := 'FB';
							,mdr.sourcetools.src_LnPropV2_Fares_Asrs			//     := 'FA';
							,mdr.sourcetools.src_LnPropV2_Fares_Deeds			//     := 'FP';
							,mdr.sourcetools.src_Foreclosures							//     := 'FR';
							,mdr.sourcetools.src_Foreclosures_Delinquent	//	   := 'NT';  // aka Notice of Default/Delinquency (NOD)
						 ];

rec_criteria := 
	RECORD
		rec_PHdr_extract;
		Compliance.Layout_has_PII;
		
		boolean src_is_FARES;
		boolean src_is_not_FARES;
		
	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_FARES					:= LE.src IN set_FARES;
	 self.src_is_not_FARES      := self.src_is_FARES = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 self.has_DOD              := IF(LE.DOD_from_LNDMF <> '',true,false);
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

//----------------

set_name_FARES := 'FARES';

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

//-------

#OPTION('multiplePersistInstances',FALSE); 

is_FARES := infile_slim.source_field IN set_FARES;

//---------------------------------------------------------------

	//--- 1. Sole-sourced DIDs

PHDR_extract_DIDs_FARES := DEDUP(sort(distribute(PHdr_extract_plus(src_is_FARES = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_FARES_sample := output(choosen(PHDR_extract_DIDs_FARES, 200), named('sample'+'_'+'PHDR_extract_DIDs_FARES'));

PHDR_extract_DIDs_nonFARES := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_FARES = true), hash(did)), did, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_nonFARES_sample := output(choosen(PHDR_extract_DIDs_nonFARES, 200), named('sample'+'_'+'PHDR_extract_DIDs_nonFARES'));

PHDR_extract_DIDs_src_FARES := JOIN(sort(distribute(PHDR_extract_DIDs_FARES, hash(did)), did, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DIDs_nonFARES, hash(did)), did, local,skew(1.0))	
																	 ,left.did = right.did
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDs'+'_'+set_name_FARES+'_'+eval_case)
																	;

sample_extract_DIDs_FARES := OUTPUT(PHDR_extract_DIDs_src_FARES, named('PHDR_extract_DIDs'+'_'+set_name_FARES+'_'+eval_case+'_sample'));
count_extract_DIDs_FARES  := OUTPUT(count(PHDR_extract_DIDs_src_FARES), named('PHDR_extract_DIDs'+'_'+set_name_FARES+'_'+eval_case+'_count'));


DIDs_solesrc_FARES := JOIN(sort(distribute(infile_slim(is_FARES), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
													,sort(distribute(PHDR_extract_DIDs_src_FARES, hash(did)), did,src,rid, local,skew(1.0))
													,(unsigned6) left.did = right.did
														AND left.src = right.src
														AND left.result_rid = right.rid

													,skew(1.0)
												 );	
									 
eval_DIDs_sole_sourced_FARES := OUTPUT(sort(distribute(DIDs_solesrc_FARES, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDs_FARES' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDs
		sole_sourced_unique_DIDs_FARES := DEDUP(sort(distribute(DIDs_solesrc_FARES, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Sole_sourced_DID_values := OUTPUT(COUNT(sole_sourced_unique_DIDs_FARES), named('Sole_sourced_DID_values_'+set_name_FARES+'_'+eval_case));


//By Source: Sole-Sourced DIDs:
DIDs_by_Source_FARES := DEDUP(sort(distribute(DIDs_solesrc_FARES, hash(source_field,did))
																, source_field,did, local,skew(1.0))
														, source_field,did, all,local);
										
tbl_DIDs_by_Source_FARES := OUTPUT(TABLE(DIDs_by_Source_FARES,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidsBySource' + '_FARES'));

//By Search: Sole-Sourced DIDAddrs:
DIDs_by_Search_FARES := DEDUP(sort(distribute(DIDs_solesrc_FARES, hash(row_ID,did))
																, row_ID,did, local,skew(1.0))
														, row_ID,did, all,local);
										
tbl_DIDs_by_Search_FARES := OUTPUT(TABLE(DIDs_by_Search_FARES, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsBySearch' + '_FARES'));

//----------------------------------------------------

	//--- 2. Sole-sourced Names - at the DID level
		
PHDR_extract_Names_FARES := DEDUP(sort(distribute(PHdr_extract_plus(src_is_FARES = true), hash(did)), did,lname,fname,mname,name_suffix, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_FARES_sample := output(choosen(PHDR_extract_Names_FARES, 200), named('sample'+'_'+'PHDR_extract_Names_FARES'));

PHDR_extract_Names_nonFARES := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_FARES = true), hash(did)), did,lname,fname,mname,name_suffix, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_nonFARES_sample := output(choosen(PHDR_extract_Names_nonFARES, 200), named('sample'+'_'+'PHDR_extract_Names_nonFARES'));

PHDR_extract_DidNames_src_FARES := JOIN(sort(distribute(PHDR_extract_Names_FARES, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_Names_nonFARES, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))	
																			 ,left.did = right.did
																				AND trim(left.lname, all) = trim(right.lname, all)
																				AND trim(left.fname, all) = trim(right.fname, all)
																				AND trim(left.mname, all) = trim(right.mname, all)
																				AND trim(left.name_suffix, all) = trim(right.name_suffix, all)
																			 ,LEFT ONLY
																			 ,skew(1.0)
																			)
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidNames'+'_'+set_name_FARES+'_'+eval_case)
																			;

sample_extract_DIDNames_FARES := OUTPUT(PHDR_extract_DidNames_src_FARES, named('PHDR_extract_DidNames'+'_'+set_name_FARES+'_'+eval_case+'_sample'));
count_extract_DIDNames_FARES  := OUTPUT(count(PHDR_extract_DidNames_src_FARES), named('PHDR_extract_DidNames'+'_'+set_name_FARES+'_'+eval_case+'_count'));


DIDNames_solesrc_FARES := JOIN(sort(distribute(infile_slim(is_FARES), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDNames_src_FARES, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
																AND left.result_rid = right.rid

															,skew(1.0)
														 );	
									 
eval_DIDNames_sole_sourced_FARES := OUTPUT(sort(distribute(DIDNames_solesrc_FARES, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDNames_FARES' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDNames
		sole_sourced_unique_DIDNames_FARES := DEDUP(sort(distribute(DIDNames_solesrc_FARES, hash(did))
																								, did,lname,fname,mname,name_suffix, local,skew(1.0))
																						, did,lname,fname,mname,name_suffix, all,local);

		Sole_sourced_Name_values := OUTPUT(COUNT(sole_sourced_unique_DIDNames_FARES), named('Sole_sourced_Name_values_'+set_name_FARES+'_'+eval_case));

		DIDs_with_unique_DIDNames_FARES := DEDUP(sort(distribute(DIDNames_solesrc_FARES, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Name_values := OUTPUT(COUNT(DIDs_with_unique_DIDNames_FARES), named('DIDs_with_unique_DIDNames_'+set_name_FARES+'_'+eval_case));

//By Source: Sole-Sourced DIDNames:
DIDNames_by_Source_FARES := DEDUP(sort(distribute(DIDNames_solesrc_FARES, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDNames_by_Source_FARES := OUTPUT(TABLE(DIDNames_by_Source_FARES,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidNamesBySource' + '_FARES'));

//By Search: Sole-Sourced DIDNames:
DIDNames_by_Search_FARES := DEDUP(sort(distribute(DIDNames_solesrc_FARES, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDNames_by_Search_FARES := OUTPUT(TABLE(DIDNames_by_Search_FARES, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidNamesBySearch' + '_FARES'));

//---------------------------

	//--- 3. Sole-sourced Addresses - at the DID level
		
PHDR_extract_Addrs_FARES := DEDUP(sort(distribute(PHdr_extract_plus(src_is_FARES = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_FARES_sample := output(choosen(PHDR_extract_Addrs_FARES, 200), named('sample'+'_'+'PHDR_extract_Addrs_FARES'));

PHDR_extract_Addrs_nonFARES := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_FARES = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_nonFARES_sample := output(choosen(PHDR_extract_Addrs_nonFARES, 200), named('sample'+'_'+'PHDR_extract_Addrs_nonFARES'));

PHDR_extract_DidAddrs_src_FARES := JOIN(sort(distribute(PHDR_extract_Addrs_FARES, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_Addrs_nonFARES, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))	
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
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidAddrs'+'_'+set_name_FARES+'_'+eval_case)
																			;

sample_extract_DIDAddrs_FARES := OUTPUT(PHDR_extract_DidAddrs_src_FARES, named('PHDR_extract_DidAddrs'+'_'+set_name_FARES+'_'+eval_case+'_sample'));
count_extract_DIDAddrs_FARES  := OUTPUT(count(PHDR_extract_DidAddrs_src_FARES), named('PHDR_extract_DidAddrs'+'_'+set_name_FARES+'_'+eval_case+'_count'));


DIDAddrs_solesrc_FARES := JOIN(sort(distribute(infile_slim(is_FARES), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
																,sort(distribute(PHDR_extract_DIDAddrs_src_FARES, hash(did)), did,src,rid, local,skew(1.0))
																,(unsigned6) left.did = right.did
																	AND left.src = right.src
																	AND left.result_rid = right.rid

																,skew(1.0)
															 );	
									 
eval_DIDAddrs_sole_sourced_FARES := OUTPUT(sort(distribute(DIDAddrs_solesrc_FARES, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDAddrs_FARES' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDAddrs
		sole_sourced_unique_DIDAddrs_FARES := DEDUP(sort(distribute(DIDAddrs_solesrc_FARES, hash(did))
																								, did, zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																						, did, zip,prim_range,predir,prim_name,postdir,sec_range, all,local);

		Sole_sourced_Address_values := OUTPUT(COUNT(sole_sourced_unique_DIDAddrs_FARES), named('Sole_sourced_Address_values_'+set_name_FARES+'_'+eval_case));

		DIDs_with_unique_DIDAddrs_FARES := DEDUP(sort(distribute(DIDAddrs_solesrc_FARES, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Addr_values := OUTPUT(COUNT(DIDs_with_unique_DIDAddrs_FARES), named('DIDs_with_unique_DIDAddrs_'+set_name_FARES+'_'+eval_case));

//By Source: Sole-Sourced DIDAddrs:
DIDAddrs_by_Source_FARES := DEDUP(sort(distribute(DIDAddrs_solesrc_FARES, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDAddrs_by_Source_FARES := OUTPUT(TABLE(DIDAddrs_by_Source_FARES,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidAddrsBySource' + '_FARES'));

//By Search: Sole-Sourced DIDAddrs:
DIDAddrs_by_Search_FARES := DEDUP(sort(distribute(DIDAddrs_solesrc_FARES, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDAddrs_by_Search_FARES := OUTPUT(TABLE(DIDAddrs_by_Search_FARES, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidAddrsBySearch' + '_FARES'));

//---------------------------------------------------------------

	//--- 4. Sole-sourced SSNs - at the DID level
		
PHDR_extract_SSNs_FARES := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_FARES = true), hash(did)), did,SSN, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_FARES_sample := output(choosen(PHDR_extract_SSNs_FARES, 200), named('sample'+'_'+'PHDR_extract_SSNs_FARES'));

PHDR_extract_SSNs_nonFARES := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_not_FARES = true), hash(did)), did,SSN, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_nonFARES_sample := output(choosen(PHDR_extract_SSNs_nonFARES, 200), named('sample'+'_'+'PHDR_extract_SSNs_nonFARES'));

PHDR_extract_DidSSNs_src_FARES := JOIN(sort(distribute(PHDR_extract_SSNs_FARES, hash(did)), did,SSN, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_SSNs_nonFARES, hash(did)), did,SSN, local,skew(1.0))	
																		 ,left.did = right.did
																		 AND (unsigned6) left.SSN = (unsigned6) right.SSN
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidSSNs'+'_'+set_name_FARES+'_'+eval_case)
																		;

sample_extract_DIDSSNs_FARES := OUTPUT(PHDR_extract_DidSSNs_src_FARES, named('PHDR_extract_DidSSNs'+'_'+set_name_FARES+'_'+eval_case+'_sample'));
count_extract_DIDSSNs_FARES  := OUTPUT(count(PHDR_extract_DidSSNs_src_FARES), named('PHDR_extract_DidSSNs'+'_'+set_name_FARES+'_'+eval_case+'_count'));


DIDSSNs_solesrc_FARES := JOIN(sort(distribute(infile_slim(is_FARES), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDSSNs_src_FARES, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDSSNs_sole_sourced_FARES := OUTPUT(sort(distribute(DIDSSNs_solesrc_FARES, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDSSNs_FARES' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDSSNs
		sole_sourced_unique_DIDSSNs_FARES := DEDUP(sort(distribute(DIDSSNs_solesrc_FARES, hash(did))
																								, did, SSN, local,skew(1.0))
																						, did, SSN, all,local);

		Sole_sourced_SSN_values := OUTPUT(COUNT(sole_sourced_unique_DIDSSNs_FARES), named('Sole_sourced_SSN_values_'+set_name_FARES+'_'+eval_case));

		DIDs_with_unique_DIDSSNs_FARES := DEDUP(sort(distribute(DIDSSNs_solesrc_FARES, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_SSN_values := OUTPUT(COUNT(DIDs_with_unique_DIDSSNs_FARES), named('DIDs_with_unique_DIDSSNs_'+set_name_FARES+'_'+eval_case));

//By Source: Sole-Sourced DIDSSNs:
DIDSSNs_by_Source_FARES := DEDUP(sort(distribute(DIDSSNs_solesrc_FARES, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDSSNs_by_Source_FARES := OUTPUT(TABLE(DIDSSNs_by_Source_FARES,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidSSNsBySource' + '_FARES'));

//By Search: Sole-Sourced DIDSSNs:
DIDSSNs_by_Search_FARES := DEDUP(sort(distribute(DIDSSNs_solesrc_FARES, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDSSNs_by_Search_FARES := OUTPUT(TABLE(DIDSSNs_by_Search_FARES, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidSSNsBySearch' + '_FARES'));

//---------------------------------------------------------------

	//--- 5. Sole-sourced DOBs - at the DID level
		
PHDR_extract_DOBs_FARES := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_FARES = true), hash(did)), did,DOB, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_FARES_sample := output(choosen(PHDR_extract_DOBs_FARES, 200), named('sample'+'_'+'PHDR_extract_DOBs_FARES'));

PHDR_extract_DOBs_nonFARES := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_not_FARES = true), hash(did)), did,DOB, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_nonFARES_sample := output(choosen(PHDR_extract_DOBs_nonFARES, 200), named('sample'+'_'+'PHDR_extract_DOBs_nonFARES'));

PHDR_extract_DidDOBs_src_FARES := JOIN(sort(distribute(PHDR_extract_DOBs_FARES, hash(did)), did,DOB, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_DOBs_nonFARES, hash(did)), did,DOB, local,skew(1.0))	
																			 ,left.did = right.did
																			 AND (unsigned6) left.DOB = (unsigned6) right.DOB
																			 ,LEFT ONLY
																			 ,skew(1.0)
																			)
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDOBs'+'_'+set_name_FARES+'_'+eval_case)
																			;

sample_extract_DIDDOBs_FARES := OUTPUT(PHDR_extract_DidDOBs_src_FARES, named('PHDR_extract_DidDOBs'+'_'+set_name_FARES+'_'+eval_case+'_sample'));
count_extract_DIDDOBs_FARES  := OUTPUT(count(PHDR_extract_DidDOBs_src_FARES), named('PHDR_extract_DidDOBs'+'_'+set_name_FARES+'_'+eval_case+'_count'));


DIDDOBs_solesrc_FARES := JOIN(sort(distribute(infile_slim(is_FARES), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDOBs_src_FARES, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDDOBs_sole_sourced_FARES := OUTPUT(sort(distribute(DIDDOBs_solesrc_FARES, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDOBs_FARES' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDOBs
		sole_sourced_unique_DIDDOBs_FARES := DEDUP(sort(distribute(DIDDOBs_solesrc_FARES, hash(did))
																								, did, DOB, local,skew(1.0))
																						, did, DOB, all,local);

		Sole_sourced_DOB_values := OUTPUT(COUNT(sole_sourced_unique_DIDDOBs_FARES), named('Sole_sourced_DOB_values_'+set_name_FARES+'_'+eval_case));

		DIDs_with_unique_DIDDOBs_FARES := DEDUP(sort(distribute(DIDDOBs_solesrc_FARES, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOB_values := OUTPUT(COUNT(DIDs_with_unique_DIDDOBs_FARES), named('DIDs_with_unique_DIDDOBs_'+set_name_FARES+'_'+eval_case));

//By Source: Sole-Sourced DIDDOBs:
DIDDOBs_by_Source_FARES := DEDUP(sort(distribute(DIDDOBs_solesrc_FARES, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDDOBs_by_Source_FARES := OUTPUT(TABLE(DIDDOBs_by_Source_FARES,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidDOBsBySource' + '_FARES'));

//By Search: Sole-Sourced DIDDOBs:
DIDDOBs_by_Search_FARES := DEDUP(sort(distribute(DIDDOBs_solesrc_FARES, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDDOBs_by_Search_FARES := OUTPUT(TABLE(DIDDOBs_by_Search_FARES, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDOBsBySearch' + '_FARES'));

//---------------------------------------------------------------

	//--- 6. Sole-sourced DLs - at the DID level
		
PHDR_extract_DLs_FARES := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_FARES = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_FARES_sample := output(choosen(PHDR_extract_DLs_FARES, 200), named('sample'+'_'+'PHDR_extract_DLs_FARES'));

PHDR_extract_DLs_nonFARES := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_not_FARES = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_nonFARES_sample := output(choosen(PHDR_extract_DLs_nonFARES, 200), named('sample'+'_'+'PHDR_extract_DLs_nonFARES'));

PHDR_extract_DidDLs_src_FARES := JOIN(sort(distribute(PHDR_extract_DLs_FARES, hash(did)), did,vendor_id, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_DLs_nonFARES, hash(did)), did,vendor_id, local,skew(1.0))	
																		 ,left.did = right.did
																			AND trim(left.vendor_id, all) = trim(right.vendor_id, all)
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDLs'+'_'+set_name_FARES+'_'+eval_case)
																		;

sample_extract_DIDDLs_FARES := OUTPUT(PHDR_extract_DidDLs_src_FARES, named('PHDR_extract_DidDLs'+'_'+set_name_FARES+'_'+eval_case+'_sample'));
count_extract_DIDDLs_FARES  := OUTPUT(count(PHDR_extract_DidDLs_src_FARES), named('PHDR_extract_DidDLs'+'_'+set_name_FARES+'_'+eval_case+'_count'));


DIDDLs_solesrc_FARES := JOIN(sort(distribute(infile_slim(is_FARES), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDLs_src_FARES, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
															AND left.result_rid = right.rid

														,skew(1.0)
													 );	
									 
eval_DIDDLs_sole_sourced_FARES := OUTPUT(sort(distribute(DIDDLs_solesrc_FARES, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDLs_FARES' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDLs
		sole_sourced_unique_DIDDLs_FARES := DEDUP(sort(distribute(DIDDLs_solesrc_FARES, hash(did))
																								, did, vendor_id, local,skew(1.0))
																						, did, vendor_id, all,local);

		Sole_sourced_DL_values := OUTPUT(COUNT(sole_sourced_unique_DIDDLs_FARES), named('Sole_sourced_DL_values_'+set_name_FARES+'_'+eval_case));

		DIDs_with_unique_DIDDLs_FARES := DEDUP(sort(distribute(DIDDLs_solesrc_FARES, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DL_values := OUTPUT(COUNT(DIDs_with_unique_DIDDLs_FARES), named('DIDs_with_unique_DIDDLs_'+set_name_FARES+'_'+eval_case));

//By Source: Sole-Sourced DIDDLs:
DIDDLs_by_Source_FARES := DEDUP(sort(distribute(DIDDLs_solesrc_FARES, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDDLs_by_Source_FARES := OUTPUT(TABLE(DIDDLs_by_Source_FARES,
																				{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																					source_field, few)
																, all, named('SoleSourcedDidDLsBySource' + '_FARES'));

//By Search: Sole-Sourced DIDDLs:
DIDDLs_by_Search_FARES := DEDUP(sort(distribute(DIDDLs_solesrc_FARES, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDDLs_by_Search_FARES := OUTPUT(TABLE(DIDDLs_by_Search_FARES, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDLsBySearch' + '_FARES'));

//--------------------------------------------------------------------------------------

rec_All_sole_sourced :=
	RECORD
		DIDs_solesrc_FARES;
		string sole_source_category := '';
	END;
	

All_sole_sourced_FARES := project(DIDs_solesrc_FARES, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDs_' + 'FARES', self := left))
													+
												  project(DIDNames_solesrc_FARES , transform(rec_All_sole_sourced, self.sole_source_category := 'DIDNames_' + 'FARES', self := left))
													+
												  project(DIDAddrs_solesrc_FARES, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDAddrs_' + 'FARES', self := left))
													+
												  project(DIDSSNs_solesrc_FARES, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDSSNs_' + 'FARES', self := left))
													+
												  project(DIDDOBs_solesrc_FARES, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDOBs_' + 'FARES', self := left))
												 +
												  project(DIDDLs_solesrc_FARES, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDLs_' + 'FARES', self := left))
												 :PERSIST('~thor400_92::persist::ckelly::ALL_sole_sourced_'+set_name_FARES+'_'+eval_case)
												 ;

eval_ALL_sole_sourced_FARES := OUTPUT(sort(distribute(All_sole_sourced_FARES, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_ALL_FARES' + '_' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
All_sole_sourced_rows_count := OUTPUT(COUNT(All_sole_sourced_FARES), named('All_sole_sourced_rows_count' + '_FARES'));
Database_records := DEDUP(sort(distribute(All_sole_sourced_FARES,hash(did)), did,rid, local), did,rid, all,local);
Database_records_involving_sole_sourced_data := OUTPUT(COUNT(Database_records), named('Total_Number_of_database_records_involving_any_sole_sourced_data' + '_FARES'));



//By Source: Sole-Sourced DIDs - All:
All_DIDs_by_Source_FARES := DEDUP(sort(distribute(All_sole_sourced_FARES, hash(source_field,did))
																			, source_field,did, local,skew(1.0))
																	, source_field,did, all,local);
										
Number_of_Sources_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Source_FARES,
																															{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																																source_field, few)
																											, all, named('Number_of_Sources_involving_sole_sourced_data' + '_FARES'));

//By Search: Sole-Sourced DIDs - All:
All_DIDs_by_Search_FARES := DEDUP(sort(distribute(All_sole_sourced_FARES, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
Number_of_Searches_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Search_FARES, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('Number_of_Searches_involving_sole_sourced_data' + '_FARES'));

//------------ Unique Count: Sole-sourced DIDs - ALL
		sole_sourced_unique_DID_ALL_FARES := DEDUP(sort(distribute(All_sole_sourced_FARES, hash(did))
																									, did, local,skew(1.0))
																							, did, all,local);

		Total_LexIDs_involving_any_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DID_ALL_FARES), named('Total_LexIDs_involving_any_sole_sourced_data' + '_FARES'));

//--------------------------------------------------------------------------------
/*
// Sole-sourced Fares in Real Property dataset

// Search RP Search, using DIDs from PHDR Results: 

qry_RPROP := DEDUP(sort(distribute(infile(srch_dataset = 'Real_Prop'), hash(append_row_id)), append_row_id, did, local), append_row_id, did, all,local);

//-----

Prop_Search_Mnthly := DATASET(Data_Services.foreign_prod+'thor_data400::base::ln_propertyv2::search',
															LN_PropertyV2.Layout_DID_Out, flat);

rSource := 
	RECORD
		string source_val;
		string which_prop_file;
		LN_PropertyV2.Layout_DID_Out;
	END;

rSource TwoSourcesMonthly(LN_PropertyV2.Layout_DID_Out pInput) :=
	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  //Source A is Fares
		SELF.which_prop_file := 'SEARCH_MONTHLY';
		SELF := pInput;
	END;

File_Base_Search_Mnthly := PROJECT(Prop_Search_Mnthly, TwoSourcesMonthly(LEFT)); 

Prop_Search_Fast := DATASET(Data_Services.foreign_prod+'thor_data400::base::property_fast::search_father',
															LN_PropertyV2.Layout_DID_Out, flat);
															
rSource TwoSourcesFast(LN_PropertyV2.Layout_DID_Out pInput) :=
	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  //Source A is Fares
		SELF.which_prop_file := 'SEARCH_FAST';
		SELF := pInput;
	END;

File_Base_Search_Fast := PROJECT(Prop_Search_Fast, TwoSourcesFast(LEFT)); 

Prop_Search := File_Base_Search_Mnthly + File_Base_Search_Fast;

//-----

rs_RPROP_results := JOIN(sort(distribute(Prop_Search, hash(did)), did, local),
															sort(distribute(qry_RPROP, hash(append_row_id)), append_row_id, did, local),
															LEFT.did = RIGHT.did,
															Compliance.xfmRPROP(LEFT, RIGHT)
															,MANY LOOKUP
															,skew(1.0)
															);

//save as CSV
RPROP_results_save := OUTPUT(SORT(rs_RPROP_results, append_row_id, skew(1.0)),,'~thor400_dev::persist::compliance::RPROP_results_' + eval_case +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//Should only report Property owned by DID
results_RPROP := rs_RPROP_results(pflag1 IN ['B', 'O', 'C'] AND pflag2 = 'P');


//-----	This is for determining sole-sourced FARES:
//Count number of sources per DID. If less than two and equals Source A, then sole-sourced Fares.

rs_from_RPROP_Search_Sources := DEDUP(sort(distribute(results_RPROP(did > 0, RawAID > 0), hash(append_row_id))
																					,append_row_id, did, RawAID, source_value, -dt_last_seen, local)
																			,append_row_id, did, RawAID, source_value, all,local);

tbl_from_RPROP_Search_Sources := TABLE(rs_from_RPROP_Search_Sources, {append_row_id, did, RawAID, source_count := count(group)}, append_row_id,did,RawAID, few);
tbl_from_RPROP_Search_OneSource := tbl_from_RPROP_Search_Sources(source_count = 1);

rs_from_RPROP_Search_join := JOIN(sort(distribute(rs_from_RPROP_Search_Sources, hash(append_row_id)), append_row_id, did, RawAID, local),
																				sort(distribute(tbl_from_RPROP_Search_OneSource, hash(append_row_id)), append_row_id, did, RawAID, local),
																				LEFT.append_row_id = RIGHT.append_row_id
																				 AND LEFT.did = RIGHT.did
																				 AND LEFT.RawAID = RIGHT.RawAID,
																				TRANSFORM(left)
																				,skew(1.0)
																				);

rs_from_RPROP_Search_FARESonly := rs_from_RPROP_Search_join(source_value = 'Source A');

count_from_RPROP_Search_FARESonly := OUTPUT(COUNT(rs_from_RPROP_Search_FARESonly), named('count_'+'from_RPROP_Search_FARESonly_' + eval_case));
from_RPROP_Search_FARESonly := OUTPUT(sort(distribute(choosen(rs_from_RPROP_Search_FARESonly,1000), hash(append_row_id)), append_row_id, local,skew(1.0)), ALL, named('from_RPROP_Search_FARESonly_sample_' + eval_case));
*/
//--------------------------------------------------

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
											
											,eval_ALL_sole_sourced_FARES
											,eval_DIDs_sole_sourced_FARES
											,eval_DIDNames_sole_sourced_FARES
											,eval_DIDAddrs_sole_sourced_FARES
											,eval_DIDSSNs_sole_sourced_FARES
											,eval_DIDDOBs_sole_sourced_FARES
											,eval_DIDDLs_sole_sourced_FARES
											
											,tbl_DIDs_by_Source_FARES
											,tbl_DIDs_by_Search_FARES
											
											,tbl_DIDNames_by_Source_FARES
											,tbl_DIDNames_by_Search_FARES
											
											,tbl_DIDAddrs_by_Source_FARES
											,tbl_DIDAddrs_by_Search_FARES
											
											,tbl_DIDSSNs_by_Source_FARES
											,tbl_DIDSSNs_by_Search_FARES
											
											,tbl_DIDDOBs_by_Source_FARES
											,tbl_DIDDOBs_by_Search_FARES
											
											,tbl_DIDDLs_by_Source_FARES
											,tbl_DIDDLs_by_Search_FARES
											
											//For research if necessary:
											,infile_slim_sample,
											PHDR_extract_DIDs_FARES_sample,
											PHDR_extract_DIDs_nonFARES_sample,
											PHDR_extract_Names_FARES_sample,
											PHDR_extract_Names_nonFARES_sample,
											PHDR_extract_Addrs_FARES_sample,
											PHDR_extract_Addrs_nonFARES_sample,
											PHDR_extract_SSNs_FARES_sample,
											PHDR_extract_SSNs_nonFARES_sample,
											PHDR_extract_DOBs_FARES_sample,
											PHDR_extract_DOBs_nonFARES_sample,
											PHDR_extract_DLs_FARES_sample,
											PHDR_extract_DLs_nonFARES_sample,
											
											sample_extract_DIDs_FARES,count_extract_DIDs_FARES,
											sample_extract_DIDNames_FARES,count_extract_DIDNames_FARES,
											sample_extract_DIDAddrs_FARES,count_extract_DIDAddrs_FARES,
											sample_extract_DIDSSNs_FARES,count_extract_DIDSSNs_FARES,
											sample_extract_DIDDOBs_FARES,count_extract_DIDDOBs_FARES,
											sample_extract_DIDDLs_FARES,count_extract_DIDDLs_FARES
		
										 
											
//											,RPROP_results_save
//											,count_from_RPROP_Search_FARESonly
//											,from_RPROP_Search_FARESonly
												
												);
											 
	ENDMACRO;
//---------------------------------------------------------------------------------------------------------
