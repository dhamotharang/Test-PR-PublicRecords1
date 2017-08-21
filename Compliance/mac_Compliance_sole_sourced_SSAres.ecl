//Results from "mac_Compliance_sole_sourced_PHdr_extract_V2" are required.
//Then see the EXAMPLE below the macro
//August 2016: SSA sole-source analysis required

EXPORT mac_Compliance_sole_sourced_SSAres(infile,eval_case = '',row_ID = 0, source_field,outfile) := 
  MACRO
	
//		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
		rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;
	
		PHdr_extract := DATASET('~thor400_92::in::compliance::sole_sourced_PHDR_extract_wLNDMF_'+eval_case + '.csv'
																,rec_PHdr_extract
																,CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------

//Sole-sourced from:
//k.	SSA restricted

rec_criteria := 
	RECORD
		rec_PHdr_extract;
		Compliance.Layout_has_PII;
		
		boolean src_is_SSAres;
		boolean src_is_not_SSAres;
		
	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_SSAres			 := LE.src ='D$' AND LE.rec_src_from_LNDMF = 'SSA';
	 self.src_is_not_SSAres  := self.src_is_SSAres = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 self.has_DOD              := IF(LE.DOD_from_LNDMF <> '',true,false);
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

PHDR_extract_plus_sample := OUTPUT(PHdr_extract_plus(src_is_SSAres = true), named('PHDR_extract_plus'+'_'+'src_is_SSAres'+'_sample'));

//----------------

set_name_SSAres := 'SSAres';

//segment_name := 'CORE';
segment_name := '_All_SEGMENTS_';

//----------------

// Make sure to use Header data, not Key (Best) data, for sole-sourced //

layout_no_Header_KEY := Header.layout_header_v2 - [did,src,vendor_id,dt_last_seen,dt_vendor_last_reported];

rec_infile_slim := {infile} - layout_no_Header_KEY;

rec_infile_sole_source := 
	RECORD
		rec_infile_slim;
		unsigned6 result_rid;
	END;
		
infile_slim := PROJECT(infile, transform({rec_infile_sole_source}, self.result_rid := left.rid; self := left)
											);


//only want result_all rows that might be sole-sourced for: SSAres
is_SSAres := infile_slim.source_field IN mdr.sourcetools.set_Death_Restricted;

infile_slim_sample := output(infile_slim(is_SSAres), named('infile_slim'+'_'+'is_SSAres'+'_sample'));

//---------------------------------------------------------------

#OPTION('multiplePersistInstances',FALSE); 

	//--- 1. Sole-sourced DIDs

PHDR_extract_DIDs_SSAres := DEDUP(sort(distribute(PHdr_extract_plus(src_is_SSAres = true), hash(did)), did, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_SSAres_sample := output(choosen(PHDR_extract_DIDs_SSAres, 200), named('sample'+'_'+'PHDR_extract_DIDs_SSAres'));

PHDR_extract_DIDs_nonSSAres := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_SSAres = true), hash(did)), did, local, skew(1.0)), did, all,local);
PHDR_extract_DIDs_nonSSAres_sample := output(choosen(PHDR_extract_DIDs_nonSSAres, 200), named('sample'+'_'+'PHDR_extract_DIDs_nonSSAres'));

PHDR_extract_DIDs_src_SSAres := JOIN(sort(distribute(PHDR_extract_DIDs_SSAres, hash(did)), did, local,skew(1.0))
																			 ,sort(distribute(PHDR_extract_DIDs_nonSSAres, hash(did)), did, local,skew(1.0))	
																			 ,left.did = right.did
																			 ,LEFT ONLY
																			 ,skew(1.0)
																			)
																			:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DIDs'+'_'+set_name_SSAres+'_'+eval_case)
																			;

sample_extract_DIDs_SSAres := OUTPUT(PHDR_extract_DIDs_src_SSAres, named('PHDR_extract_DIDs'+'_'+set_name_SSAres+'_'+eval_case+'_sample'));
count_extract_DIDs_SSAres  := OUTPUT(count(PHDR_extract_DIDs_src_SSAres), named('PHDR_extract_DIDs'+'_'+set_name_SSAres+'_'+eval_case+'_count'));


DIDs_solesrc_SSAres := JOIN(sort(distribute(infile_slim(is_SSAres), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDs_src_SSAres, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
//																AND left.result_rid = right.rid	//rid is not populated
																AND left.vendor_id = right.vendor_id	//vendor_id is not populated normally; replaced with state_death_id


															,skew(1.0)
														 );	
									 
eval_DIDs_sole_sourced_SSAres := OUTPUT(sort(distribute(DIDs_solesrc_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDs_SSAres' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDs
		sole_sourced_unique_DIDs_SSAres := DEDUP(sort(distribute(DIDs_solesrc_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Sole_sourced_DID_values := OUTPUT(COUNT(sole_sourced_unique_DIDs_SSAres), named('Sole_sourced_DID_values_'+set_name_SSAres+'_'+eval_case));


//By Source: Sole-Sourced DIDs:
DIDs_by_Source_SSAres := DEDUP(sort(distribute(DIDs_solesrc_SSAres, hash(source_field,did))
																, source_field,did, local,skew(1.0))
														, source_field,did, all,local);
										
tbl_DIDs_by_Source_SSAres := OUTPUT(TABLE(DIDs_by_Source_SSAres,
																					{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																						source_field, few)
																	, all, named('SoleSourcedDidsBySource' + '_SSAres'));

//By Search: Sole-Sourced DIDAddrs:
DIDs_by_Search_SSAres := DEDUP(sort(distribute(DIDs_solesrc_SSAres, hash(row_ID,did))
																, row_ID,did, local,skew(1.0))
														, row_ID,did, all,local);
										
tbl_DIDs_by_Search_SSAres := OUTPUT(TABLE(DIDs_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidsBySearch' + '_SSAres'));

//----------------------------------------------------

	//--- 2. Sole-sourced Names - at the DID level
		
PHDR_extract_Names_SSAres := DEDUP(sort(distribute(PHdr_extract_plus(src_is_SSAres = true), hash(did)), did,lname,fname,mname,name_suffix, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_SSAres_sample := output(choosen(PHDR_extract_Names_SSAres, 200), named('sample'+'_'+'PHDR_extract_Names_SSAres'));

PHDR_extract_Names_nonSSAres := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_SSAres = true), hash(did)), did,lname,fname,mname,name_suffix, local, skew(1.0)), did,lname,fname,mname,name_suffix, all,local);
PHDR_extract_Names_nonSSAres_sample := output(choosen(PHDR_extract_Names_nonSSAres, 200), named('sample'+'_'+'PHDR_extract_Names_nonSSAres'));

PHDR_extract_DidNames_src_SSAres := JOIN(sort(distribute(PHDR_extract_Names_SSAres, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_Names_nonSSAres, hash(did)), did,lname,fname,mname,name_suffix, local,skew(1.0))	
																		 ,left.did = right.did
																			AND trim(left.lname, all) = trim(right.lname, all)
																			AND trim(left.fname, all) = trim(right.fname, all)
																			AND trim(left.mname, all) = trim(right.mname, all)
																			AND trim(left.name_suffix, all) = trim(right.name_suffix, all)
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidNames'+'_'+set_name_SSAres+'_'+eval_case)
																		;

sample_extract_DIDNames_SSAres := OUTPUT(PHDR_extract_DidNames_src_SSAres, named('PHDR_extract_DidNames'+'_'+set_name_SSAres+'_'+eval_case+'_sample'));
count_extract_DIDNames_SSAres  := OUTPUT(count(PHDR_extract_DidNames_src_SSAres), named('PHDR_extract_DidNames'+'_'+set_name_SSAres+'_'+eval_case+'_count'));


DIDNames_solesrc_SSAres := JOIN(sort(distribute(infile_slim(is_SSAres), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
															,sort(distribute(PHDR_extract_DIDNames_src_SSAres, hash(did)), did,src,rid, local,skew(1.0))
															,(unsigned6) left.did = right.did
																AND left.src = right.src
//																AND left.result_rid = right.rid	//rid is not populated
																AND left.vendor_id = right.vendor_id	//vendor_id is not populated normally; replaced with state_death_id


															,skew(1.0)
														 );	
									 
eval_DIDNames_sole_sourced_SSAres := OUTPUT(sort(distribute(DIDNames_solesrc_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDNames_SSAres' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDNames
		sole_sourced_unique_DIDNames_SSAres := DEDUP(sort(distribute(DIDNames_solesrc_SSAres, hash(did))
																									, did,lname,fname,mname,name_suffix, local,skew(1.0))
																							, did,lname,fname,mname,name_suffix, all,local);

		Sole_sourced_Name_values := OUTPUT(COUNT(sole_sourced_unique_DIDNames_SSAres), named('Sole_sourced_Name_values_'+set_name_SSAres+'_'+eval_case));

		DIDs_with_unique_DIDNames_SSAres := DEDUP(sort(distribute(DIDNames_solesrc_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Name_values := OUTPUT(COUNT(DIDs_with_unique_DIDNames_SSAres), named('DIDs_with_unique_DIDNames_'+set_name_SSAres+'_'+eval_case));

//By Source: Sole-Sourced DIDNames:
DIDNames_by_Source_SSAres := DEDUP(sort(distribute(DIDNames_solesrc_SSAres, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
																
tbl_DIDNames_by_Source_SSAres := OUTPUT(TABLE(DIDNames_by_Source_SSAres,
																							{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																								source_field, few)
																			, all, named('SoleSourcedDidNamesBySource' + '_SSAres'));

//By Search: Sole-Sourced DIDNames:
DIDNames_by_Search_SSAres := DEDUP(sort(distribute(DIDNames_solesrc_SSAres, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDNames_by_Search_SSAres := OUTPUT(TABLE(DIDNames_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidNamesBySearch' + '_SSAres'));

//---------------------------

////	SSA does not provie Address info	////
/*
	//--- 3. Sole-sourced Addresses - at the DID level
		
PHDR_extract_Addrs_SSAres := DEDUP(sort(distribute(PHdr_extract_plus(src_is_SSAres = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_SSAres_sample := output(choosen(PHDR_extract_Addrs_SSAres, 200), named('sample'+'_'+'PHDR_extract_Addrs_SSAres'));

PHDR_extract_Addrs_nonSSAres := DEDUP(sort(distribute(PHdr_extract_plus(src_is_not_SSAres = true), hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local, skew(1.0)), did,zip,prim_range,predir,prim_name,postdir,sec_range, all,local);
PHDR_extract_Addrs_nonSSAres_sample := output(choosen(PHDR_extract_Addrs_nonSSAres, 200), named('sample'+'_'+'PHDR_extract_Addrs_nonSSAres'));

PHDR_extract_DidAddrs_src_SSAres := JOIN(sort(distribute(PHDR_extract_Addrs_SSAres, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_Addrs_nonSSAres, hash(did)), did,zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))	
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
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidAddrs'+'_'+set_name_SSAres+'_'+eval_case)
																		;

sample_extract_DIDAddrs_SSAres := OUTPUT(PHDR_extract_DidAddrs_src_SSAres, named('PHDR_extract_DidAddrs'+'_'+set_name_SSAres+'_'+eval_case+'_sample'));
count_extract_DIDAddrs_SSAres  := OUTPUT(count(PHDR_extract_DidAddrs_src_SSAres), named('PHDR_extract_DidAddrs'+'_'+set_name_SSAres+'_'+eval_case+'_count'));


DIDAddrs_solesrc_SSAres := JOIN(sort(distribute(infile_slim(is_SSAres), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDAddrs_src_SSAres, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
//																AND left.result_rid = right.rid	//rid is not populated
															AND left.vendor_id = right.vendor_id	//vendor_id is not populated normally; replaced with state_death_id


														,skew(1.0)
													 );	
									 
eval_DIDAddrs_sole_sourced_SSAres := OUTPUT(sort(distribute(DIDAddrs_solesrc_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDAddrs_SSAres' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDAddrs
		sole_sourced_unique_DIDAddrs_SSAres := DEDUP(sort(distribute(DIDAddrs_solesrc_SSAres, hash(did))
																									, did, zip,prim_range,predir,prim_name,postdir,sec_range, local,skew(1.0))
																							, did, zip,prim_range,predir,prim_name,postdir,sec_range, all,local);

		Sole_sourced_Address_values := OUTPUT(COUNT(sole_sourced_unique_DIDAddrs_SSAres), named('Sole_sourced_Address_values_'+set_name_SSAres+'_'+eval_case));

		DIDs_with_unique_DIDAddrs_SSAres := DEDUP(sort(distribute(DIDAddrs_solesrc_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_Addr_values := OUTPUT(COUNT(DIDs_with_unique_DIDAddrs_SSAres), named('DIDs_with_unique_DIDAddrs_'+set_name_SSAres+'_'+eval_case));

//By Source: Sole-Sourced DIDAddrs:
DIDAddrs_by_Source_SSAres := DEDUP(sort(distribute(DIDAddrs_solesrc_SSAres, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDAddrs_by_Source_SSAres := OUTPUT(TABLE(DIDAddrs_by_Source_SSAres,
																							{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																								source_field, few)
																			, all, named('SoleSourcedDidAddrsBySource' + '_SSAres'));

//By Search: Sole-Sourced DIDAddrs:
DIDAddrs_by_Search_SSAres := DEDUP(sort(distribute(DIDAddrs_solesrc_SSAres, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDAddrs_by_Search_SSAres := OUTPUT(TABLE(DIDAddrs_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidAddrsBySearch' + '_SSAres'));
*/
//---------------------------------------------------------------

	//--- 4. Sole-sourced SSNs - at the DID level
		
PHDR_extract_SSNs_SSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_SSAres = true), hash(did)), did,SSN, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_SSAres_sample := output(choosen(PHDR_extract_SSNs_SSAres, 200), named('sample'+'_'+'PHDR_extract_SSNs_SSAres'));

PHDR_extract_SSNs_nonSSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_ssn=true AND src_is_not_SSAres = true), hash(did)), did,SSN, local, skew(1.0)), did,SSN, all,local);
PHDR_extract_SSNs_nonSSAres_sample := output(choosen(PHDR_extract_SSNs_nonSSAres, 200), named('sample'+'_'+'PHDR_extract_SSNs_nonSSAres'));

PHDR_extract_DidSSNs_src_SSAres := JOIN(sort(distribute(PHDR_extract_SSNs_SSAres, hash(did)), did,SSN, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_SSNs_nonSSAres, hash(did)), did,SSN, local,skew(1.0))	
																		 ,left.did = right.did
																		 AND (unsigned6) left.SSN = (unsigned6) right.SSN
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidSSNs'+'_'+set_name_SSAres+'_'+eval_case)
																		;

sample_extract_DIDSSNs_SSAres := OUTPUT(PHDR_extract_DidSSNs_src_SSAres, named('PHDR_extract_DidSSNs'+'_'+set_name_SSAres+'_'+eval_case+'_sample'));
count_extract_DIDSSNs_SSAres  := OUTPUT(count(PHDR_extract_DidSSNs_src_SSAres), named('PHDR_extract_DidSSNs'+'_'+set_name_SSAres+'_'+eval_case+'_count'));


DIDSSNs_solesrc_SSAres := JOIN(sort(distribute(infile_slim(is_SSAres), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDSSNs_src_SSAres, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
//																AND left.result_rid = right.rid	//rid is not populated
															AND left.vendor_id = right.vendor_id	//vendor_id is not populated normally; replaced with state_death_id


														,skew(1.0)
													 );	
									 
eval_DIDSSNs_sole_sourced_SSAres := OUTPUT(sort(distribute(DIDSSNs_solesrc_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDSSNs_SSAres' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDSSNs
		sole_sourced_unique_DIDSSNs_SSAres := DEDUP(sort(distribute(DIDSSNs_solesrc_SSAres, hash(did))
																									, did, SSN, local,skew(1.0))
																							, did, SSN, all,local);

		Sole_sourced_SSN_values := OUTPUT(COUNT(sole_sourced_unique_DIDSSNs_SSAres), named('Sole_sourced_SSN_values_'+set_name_SSAres+'_'+eval_case));

		DIDs_with_unique_DIDSSNs_SSAres := DEDUP(sort(distribute(DIDSSNs_solesrc_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_SSN_values := OUTPUT(COUNT(DIDs_with_unique_DIDSSNs_SSAres), named('DIDs_with_unique_DIDSSNs_'+set_name_SSAres+'_'+eval_case));

//By Source: Sole-Sourced DIDSSNs:
DIDSSNs_by_Source_SSAres := DEDUP(sort(distribute(DIDSSNs_solesrc_SSAres, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDSSNs_by_Source_SSAres := OUTPUT(TABLE(DIDSSNs_by_Source_SSAres,
																							{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																								source_field, few)
																			, all, named('SoleSourcedDidSSNsBySource' + '_SSAres'));

//By Search: Sole-Sourced DIDSSNs:
DIDSSNs_by_Search_SSAres := DEDUP(sort(distribute(DIDSSNs_solesrc_SSAres, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDSSNs_by_Search_SSAres := OUTPUT(TABLE(DIDSSNs_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidSSNsBySearch' + '_SSAres'));

//---------------------------------------------------------------

	//--- 5. Sole-sourced DOBs - at the DID level
		
PHDR_extract_DOBs_SSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_SSAres = true), hash(did)), did,DOB, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_SSAres_sample := output(choosen(PHDR_extract_DOBs_SSAres, 200), named('sample'+'_'+'PHDR_extract_DOBs_SSAres'));

PHDR_extract_DOBs_nonSSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_dob=true AND src_is_not_SSAres = true), hash(did)), did,DOB, local, skew(1.0)), did,DOB, all,local);
PHDR_extract_DOBs_nonSSAres_sample := output(choosen(PHDR_extract_DOBs_nonSSAres, 200), named('sample'+'_'+'PHDR_extract_DOBs_nonSSAres'));

PHDR_extract_DidDOBs_src_SSAres := JOIN(sort(distribute(PHDR_extract_DOBs_SSAres, hash(did)), did,DOB, local,skew(1.0))
																		 ,sort(distribute(PHDR_extract_DOBs_nonSSAres, hash(did)), did,DOB, local,skew(1.0))	
																		 ,left.did = right.did
																		 AND (unsigned6) left.DOB = (unsigned6) right.DOB
																		 ,LEFT ONLY
																		 ,skew(1.0)
																		)
																		:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDOBs'+'_'+set_name_SSAres+'_'+eval_case)
																		;

sample_extract_DIDDOBs_SSAres := OUTPUT(PHDR_extract_DidDOBs_src_SSAres, named('PHDR_extract_DidDOBs'+'_'+set_name_SSAres+'_'+eval_case+'_sample'));
count_extract_DIDDOBs_SSAres  := OUTPUT(count(PHDR_extract_DidDOBs_src_SSAres), named('PHDR_extract_DidDOBs'+'_'+set_name_SSAres+'_'+eval_case+'_count'));


DIDDOBs_solesrc_SSAres := JOIN(sort(distribute(infile_slim(is_SSAres), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDOBs_src_SSAres, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
//																AND left.result_rid = right.rid	//rid is not populated
															AND left.vendor_id = right.vendor_id	//vendor_id is not populated normally; replaced with state_death_id


														,skew(1.0)
													 );	
									 
eval_DIDDOBs_sole_sourced_SSAres := OUTPUT(sort(distribute(DIDDOBs_solesrc_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDOBs_SSAres' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDOBs
		sole_sourced_unique_DIDDOBs_SSAres := DEDUP(sort(distribute(DIDDOBs_solesrc_SSAres, hash(did))
																									, did, DOB, local,skew(1.0))
																							, did, DOB, all,local);

		Sole_sourced_DOB_values := OUTPUT(COUNT(sole_sourced_unique_DIDDOBs_SSAres), named('Sole_sourced_DOB_values_'+set_name_SSAres+'_'+eval_case));

		DIDs_with_unique_DIDDOBs_SSAres := DEDUP(sort(distribute(DIDDOBs_solesrc_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOB_values := OUTPUT(COUNT(DIDs_with_unique_DIDDOBs_SSAres), named('DIDs_with_unique_DIDDOBs_'+set_name_SSAres+'_'+eval_case));

//By Source: Sole-Sourced DIDDOBs:
DIDDOBs_by_Source_SSAres := DEDUP(sort(distribute(DIDDOBs_solesrc_SSAres, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
										
tbl_DIDDOBs_by_Source_SSAres := OUTPUT(TABLE(DIDDOBs_by_Source_SSAres,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidDOBsBySource' + '_SSAres'));

//By Search: Sole-Sourced DIDDOBs:
DIDDOBs_by_Search_SSAres := DEDUP(sort(distribute(DIDDOBs_solesrc_SSAres, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
										
tbl_DIDDOBs_by_Search_SSAres := OUTPUT(TABLE(DIDDOBs_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDOBsBySearch' + '_SSAres'));

//---------------------------------------------------------------

	//--- 6. Sole-sourced DLs - at the DID level
		
PHDR_extract_DLs_SSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_SSAres = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_SSAres_sample := output(choosen(PHDR_extract_DLs_SSAres, 200), named('sample'+'_'+'PHDR_extract_DLs_SSAres'));

PHDR_extract_DLs_nonSSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_DL=true AND src_is_not_SSAres = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DLs_nonSSAres_sample := output(choosen(PHDR_extract_DLs_nonSSAres, 200), named('sample'+'_'+'PHDR_extract_DLs_nonSSAres'));

PHDR_extract_DidDLs_src_SSAres := JOIN(sort(distribute(PHDR_extract_DLs_SSAres, hash(did)), did,vendor_id, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DLs_nonSSAres, hash(did)), did,vendor_id, local,skew(1.0))	
																	 ,left.did = right.did
																		AND trim(left.vendor_id, all) = trim(right.vendor_id, all)	//DL is in the vendor_id field
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDLs'+'_'+set_name_SSAres+'_'+eval_case)
																	;

sample_extract_DIDDLs_SSAres := OUTPUT(PHDR_extract_DidDLs_src_SSAres, named('PHDR_extract_DidDLs'+'_'+set_name_SSAres+'_'+eval_case+'_sample'));
count_extract_DIDDLs_SSAres  := OUTPUT(count(PHDR_extract_DidDLs_src_SSAres), named('PHDR_extract_DidDLs'+'_'+set_name_SSAres+'_'+eval_case+'_count'));


DIDDLs_solesrc_SSAres := JOIN(sort(distribute(infile_slim(is_SSAres), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDLs_src_SSAres, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
//																AND left.result_rid = right.rid	//rid is not populated
															AND left.vendor_id = right.vendor_id	//vendor_id is not populated normally; replaced with state_death_id


														,skew(1.0)
													 );	
									 
eval_DIDDLs_sole_sourced_SSAres := OUTPUT(sort(distribute(DIDDLs_solesrc_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDLs_SSAres' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDLs
		sole_sourced_unique_DIDDLs_SSAres := DEDUP(sort(distribute(DIDDLs_solesrc_SSAres, hash(did))
																									, did, vendor_id, local,skew(1.0))
																							, did, vendor_id, all,local);

		Sole_sourced_DL_values := OUTPUT(COUNT(sole_sourced_unique_DIDDLs_SSAres), named('Sole_sourced_DL_values_'+set_name_SSAres+'_'+eval_case));

		DIDs_with_unique_DIDDLs_SSAres := DEDUP(sort(distribute(DIDDLs_solesrc_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DL_values := OUTPUT(COUNT(DIDs_with_unique_DIDDLs_SSAres), named('DIDs_with_unique_DIDDLs_'+set_name_SSAres+'_'+eval_case));

//By Source: Sole-Sourced DIDDLs:
DIDDLs_by_Source_SSAres := DEDUP(sort(distribute(DIDDLs_solesrc_SSAres, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDDLs_by_Source_SSAres := OUTPUT(TABLE(DIDDLs_by_Source_SSAres,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidDLsBySource' + '_SSAres'));

//By Search: Sole-Sourced DIDDLs:
DIDDLs_by_Search_SSAres := DEDUP(sort(distribute(DIDDLs_solesrc_SSAres, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDDLs_by_Search_SSAres := OUTPUT(TABLE(DIDDLs_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDLsBySearch' + '_SSAres'));

//---------------------------------------------------------------

	//--- 7. Sole-sourced DODs - at the DID level
		
PHDR_extract_DODs_SSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_DOD=true AND src_is_SSAres = true), hash(did)), did,vendor_id, -dt_last_seen,-dt_vendor_last_reported, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DODs_SSAres_sample := output(choosen(PHDR_extract_DODs_SSAres, 200), named('sample'+'_'+'PHDR_extract_DODs_SSAres'));

PHDR_extract_DODs_nonSSAres := DEDUP(sort(distribute(PHdr_extract_plus(has_DOD=true AND src_is_not_SSAres = true), hash(did)), did,vendor_id, local, skew(1.0)), did,vendor_id, all,local);
PHDR_extract_DODs_nonSSAres_sample := output(choosen(PHDR_extract_DODs_nonSSAres, 200), named('sample'+'_'+'PHDR_extract_DODs_nonSSAres'));

PHDR_extract_DidDODs_src_SSAres := JOIN(sort(distribute(PHDR_extract_DODs_SSAres, hash(did)), did,vendor_id, local,skew(1.0))
																	 ,sort(distribute(PHDR_extract_DODs_nonSSAres, hash(did)), did,vendor_id, local,skew(1.0))	
																	 ,left.did = right.did
																		AND trim(left.DOD_from_LNDMF, all) = trim(right.DOD_from_LNDMF, all)
																	 ,LEFT ONLY
																	 ,skew(1.0)
																	)
																	:PERSIST('~thor400_92::persist::ckelly::PHDR_extract_DidDODs'+'_'+set_name_SSAres+'_'+eval_case)
																	;

sample_extract_DIDDODs_SSAres := OUTPUT(PHDR_extract_DidDODs_src_SSAres, named('PHDR_extract_DidDODs'+'_'+set_name_SSAres+'_'+eval_case+'_sample'));
count_extract_DIDDODs_SSAres  := OUTPUT(count(PHDR_extract_DidDODs_src_SSAres), named('PHDR_extract_DidDODs'+'_'+set_name_SSAres+'_'+eval_case+'_count'));


DIDDODs_solesrc_SSAres := JOIN(sort(distribute(infile_slim(is_SSAres), hash(row_ID)), row_ID,did,src,result_rid, local,skew(1.0))
														,sort(distribute(PHDR_extract_DIDDODs_src_SSAres, hash(did)), did,src,rid, local,skew(1.0))
														,(unsigned6) left.did = right.did
															AND left.src = right.src
//																AND left.result_rid = right.rid	//rid is not populated
															AND left.vendor_id = right.vendor_id	//vendor_id is not populated normally; replaced with state_death_id


														,skew(1.0)
													 );	
									 
eval_DIDDODs_sole_sourced_SSAres := OUTPUT(sort(distribute(DIDDODs_solesrc_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_DIDDODs_SSAres' + '-' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//------------ Unique Count: Sole-sourced DIDDODs
		sole_sourced_unique_DIDDODs_SSAres := DEDUP(sort(distribute(DIDDODs_solesrc_SSAres, hash(did))
																									, did, vendor_id, local,skew(1.0))
																							, did, vendor_id, all,local);

		Sole_sourced_DOD_values := OUTPUT(COUNT(sole_sourced_unique_DIDDODs_SSAres), named('Sole_sourced_DOD_values_'+set_name_SSAres+'_'+eval_case));

		DIDs_with_unique_DIDDODs_SSAres := DEDUP(sort(distribute(DIDDODs_solesrc_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		DIDs_with_unique_DOD_values := OUTPUT(COUNT(DIDs_with_unique_DIDDODs_SSAres), named('DIDs_with_unique_DIDDODs_'+set_name_SSAres+'_'+eval_case));

//By Source: Sole-Sourced DIDDODs:
DIDDODs_by_Source_SSAres := DEDUP(sort(distribute(DIDDODs_solesrc_SSAres, hash(source_field,did))
																	, source_field,did, local,skew(1.0))
															, source_field,did, all,local);
										
tbl_DIDDODs_by_Source_SSAres := OUTPUT(TABLE(DIDDODs_by_Source_SSAres,
																						{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																							source_field, few)
																		, all, named('SoleSourcedDidDODsBySource' + '_SSAres'));

//By Search: Sole-Sourced DIDDODs:
DIDDODs_by_Search_SSAres := DEDUP(sort(distribute(DIDDODs_solesrc_SSAres, hash(row_ID,did))
																	, row_ID,did, local,skew(1.0))
															, row_ID,did, all,local);
										
tbl_DIDDODs_by_Search_SSAres := OUTPUT(TABLE(DIDDODs_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('SoleSourcedDidDODsBySearch' + '_SSAres'));

//--------------------------------------------------------------------------------------

rec_All_sole_sourced :=
	RECORD
		DIDs_solesrc_SSAres;
		string sole_source_category := '';
	END;
	

All_sole_sourced_SSAres := project(DIDs_solesrc_SSAres, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDs_' + 'SSAres', self := left))
													+
												  project(DIDNames_solesrc_SSAres , transform(rec_All_sole_sourced, self.sole_source_category := 'DIDNames_' + 'SSAres', self := left))
//													+
//												  project(DIDAddrs_solesrc_SSAres, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDAddrs_' + 'SSAres', self := left))
													+
												  project(DIDSSNs_solesrc_SSAres, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDSSNs_' + 'SSAres', self := left))
													+
												  project(DIDDOBs_solesrc_SSAres, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDOBs_' + 'SSAres', self := left))
												 +
												  project(DIDDLs_solesrc_SSAres, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDLs_' + 'SSAres', self := left))
												 +
												  project(DIDDODs_solesrc_SSAres, transform(rec_All_sole_sourced, self.sole_source_category := 'DIDDODs_' + 'SSAres', self := left))
												 :PERSIST('~thor400_92::persist::ckelly::ALL_sole_sourced_'+set_name_SSAres+'_'+eval_case)
												 ;

eval_ALL_sole_sourced_SSAres := OUTPUT(sort(distribute(All_sole_sourced_SSAres, hash(row_ID)),row_ID, local,skew(1.0)),,'~thor400_92::persist::compliance::sole_sourced_ALL_SSAres' + '_' + eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
All_sole_sourced_rows_count := OUTPUT(COUNT(All_sole_sourced_SSAres), named('All_sole_sourced_rows_count' + '_SSAres'));
Database_records := DEDUP(sort(distribute(All_sole_sourced_SSAres,hash(did)), did,rid, local), did,rid, all,local);
Database_records_involving_sole_sourced_data := OUTPUT(COUNT(Database_records), named('Total_Number_of_database_records_involving_any_sole_sourced_data' + '_SSAres'));



//By Source: Sole-Sourced DIDs - All:
All_DIDs_by_Source_SSAres := DEDUP(sort(distribute(All_sole_sourced_SSAres, hash(source_field,did))
																		, source_field,did, local,skew(1.0))
																, source_field,did, all,local);
											
Number_of_Sources_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Source_SSAres,
																																{source_field, did_count := count(group),mdr.sourceTools.fTranslateSource(source_field)},
																																	source_field, few)
																												, all, named('Number_of_Sources_involving_sole_sourced_data' + '_SSAres'));

//By Search: Sole-Sourced DIDs - All:
All_DIDs_by_Search_SSAres := DEDUP(sort(distribute(All_sole_sourced_SSAres, hash(row_ID,did))
																		, row_ID,did, local,skew(1.0))
																, row_ID,did, all,local);
																
Number_of_Searches_involving_sole_sourced_data := OUTPUT(TABLE(All_DIDs_by_Search_SSAres, {row_ID, srch_class, did_count := count(group)}, row_ID, srch_class, few), all, named('Number_of_Searches_involving_sole_sourced_data' + '_SSAres'));

//------------ Unique Count: Sole-sourced DIDs - ALL
		sole_sourced_unique_DID_ALL_SSAres := DEDUP(sort(distribute(All_sole_sourced_SSAres, hash(did))
																								, did, local,skew(1.0))
																						, did, all,local);

		Total_LexIDs_involving_any_sole_sourced_data := OUTPUT(COUNT(sole_sourced_unique_DID_ALL_SSAres), named('Total_LexIDs_involving_any_sole_sourced_data' + '_SSAres'));

//---------------------

outfile := 	PARALLEL(	Number_of_Searches_involving_sole_sourced_data
											,Number_of_Sources_involving_sole_sourced_data
											,Total_LexIDs_involving_any_sole_sourced_data
											,Database_records_involving_sole_sourced_data
											,All_sole_sourced_rows_count
											
											,Sole_sourced_DID_values
											,Sole_sourced_Name_values
//											,Sole_sourced_Address_values
											,Sole_sourced_SSN_values
											,Sole_sourced_DOB_values
											,Sole_sourced_DL_values
											,Sole_sourced_DOD_values
											
											,DIDs_with_unique_Name_values
//											,DIDs_with_unique_Addr_values
											,DIDs_with_unique_SSN_values
											,DIDs_with_unique_DOB_values
											,DIDs_with_unique_DL_values
											,DIDs_with_unique_DOD_values
											
											,eval_ALL_sole_sourced_SSAres
											,eval_DIDs_sole_sourced_SSAres
											,eval_DIDNames_sole_sourced_SSAres
//											,eval_DIDAddrs_sole_sourced_SSAres
											,eval_DIDSSNs_sole_sourced_SSAres
											,eval_DIDDOBs_sole_sourced_SSAres
											,eval_DIDDLs_sole_sourced_SSAres
											,eval_DIDDODs_sole_sourced_SSAres
											
											,tbl_DIDs_by_Source_SSAres
											,tbl_DIDs_by_Search_SSAres
											
											,tbl_DIDNames_by_Source_SSAres
											,tbl_DIDNames_by_Search_SSAres
											
//											,tbl_DIDAddrs_by_Source_SSAres
//											,tbl_DIDAddrs_by_Search_SSAres
											
											,tbl_DIDSSNs_by_Source_SSAres
											,tbl_DIDSSNs_by_Search_SSAres
											
											,tbl_DIDDOBs_by_Source_SSAres
											,tbl_DIDDOBs_by_Search_SSAres
											
											,tbl_DIDDLs_by_Source_SSAres
											,tbl_DIDDLs_by_Search_SSAres
											
											,tbl_DIDDODs_by_Source_SSAres
											,tbl_DIDDODs_by_Search_SSAres
											
											//For research if necessary:
											,infile_slim_sample,
											PHDR_extract_plus_sample,
											PHDR_extract_DIDs_SSAres_sample,
											PHDR_extract_DIDs_nonSSAres_sample,
											PHDR_extract_Names_SSAres_sample,
											PHDR_extract_Names_nonSSAres_sample,
//											PHDR_extract_Addrs_SSAres_sample,
//											PHDR_extract_Addrs_nonSSAres_sample,
											PHDR_extract_SSNs_SSAres_sample,
											PHDR_extract_SSNs_nonSSAres_sample,
											PHDR_extract_DOBs_SSAres_sample,
											PHDR_extract_DOBs_nonSSAres_sample,
											PHDR_extract_DLs_SSAres_sample,
											PHDR_extract_DLs_nonSSAres_sample,
											PHDR_extract_DODs_SSAres_sample,
											PHDR_extract_DODs_nonSSAres_sample,
											
											sample_extract_DIDs_SSAres,count_extract_DIDs_SSAres,
											sample_extract_DIDNames_SSAres,count_extract_DIDNames_SSAres,
//											sample_extract_DIDAddrs_SSAres,count_extract_DIDAddrs_SSAres,
											sample_extract_DIDSSNs_SSAres,count_extract_DIDSSNs_SSAres,
											sample_extract_DIDDOBs_SSAres,count_extract_DIDDOBs_SSAres,
											sample_extract_DIDDLs_SSAres,count_extract_DIDDLs_SSAres,
											sample_extract_DIDDODs_SSAres,count_extract_DIDDODs_SSAres
		
										 );
											 
	ENDMACRO;

//---------------------------------------------------------------------------------------------------------
