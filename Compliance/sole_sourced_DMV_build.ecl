//Data sourced exclusively from a State DMV (as compared with other Person Header sources)


hdr_prod 			:= DATASET('~thor_data400::base::header_prod', Header.layout_header_v2, flat);	//Header.File_Headers;	 no TU sources
hdr_tu_True   := DATASET('~thor_data400::base::TransunionCred_did',header.Layout_Header, flat);	//Header.file_tn_did; TU True CHdr records used in HDR
hdr_tu_CP   	:= DATASET('~thor_data400::base::tucs_did',header.Layout_Header, flat);	// Header.File_TUCS_did; TU legacy CP (external source)
hdr_tu_LN   	:= DATASET('~thor_data400::base::transunion_did',header.Layout_Header, flat);	//Header.File_Transunion_did;		//TU legacy LN (external source)


PHDR_GLB    := hdr_prod + hdr_tu_True + hdr_tu_CP + hdr_tu_LN; 

/*
//count(PHDR_GLB);

tbl_PHDR_sources := TABLE(PHDR_GLB, 
													{src,
													 MDR.sourceTools.fTranslateSource(src),
													 rec_count := count(group)}
													 ,src, few);

output(sort(tbl_PHDR_sources, src), all);
*/
//-----------------------------------------------------------------------------

file_segments := watchdog.file_best;

/*
tbl_wdog_segments := TABLE(file_segments, 
													{adl_ind,
													 rec_count := count(group)}
													 ,adl_ind, few);

output(sort(tbl_wdog_segments, adl_ind, skew(1.0)), all);
*/
//----------------------

rec_PHDR_slim :=
	RECORD
		unsigned6 did;
		string2 src;

		qstring9 ssn;
		integer4 dob;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring5 name_suffix;
		qstring10 prim_range;
		string2 predir;
		qstring28 prim_name;
		qstring4 suffix;
		string2 postdir;
		qstring10 unit_desig;
		qstring8 sec_range;
		qstring25 city_name;
		string2 st;
		qstring5 zip;
		qstring4 zip4;
		string	DID_segment := '';
	END;	
		

rec_PHDR_slim xfmSegments(PHDR_GLB LE, file_segments RI) :=
		TRANSFORM
			SELF.DID_segment := RI.adl_ind;
			SELF := LE;
		END;
		
PHDR_slim := JOIN(sort(distribute(PHDR_GLB(DID <> 0), hash(DID)), DID, local,skew(1.0))
									,sort(distribute(file_segments(DID <> 0), hash(DID)), DID, local,skew(1.0))         
									,LEFT.did = RIGHT.did
									,xfmSegments(LEFT,RIGHT)
									
									,skew(1.0)
									);
																
PHDR_slim_sort := SORT(distribute(PHDR_slim, hash(did)), did, local,skew(1.0));//:PERSIST('~thor400_92::persist::ckelly::PHDR_with_segments');

//output(PHDR_slim_sort);

/*
wdog := watchdog.file_best(adl_ind='CORE');

rec_PHDR_slim xfmCoreOnly(PHDR_GLB LE, wdog RI) :=
		TRANSFORM
			SELF.DID_segment := RI.adl_ind;
			SELF := LE;
		END;
		
PHDR_slim_CORE := JOIN(sort(distribute(PHDR_GLB(DID <> 0), hash(DID)), DID, local,skew(1.0))
													,sort(distribute(wdog, hash(DID)), DID, local,skew(1.0))         
													,LEFT.did = RIGHT.did
													,xfmCoreOnly(LEFT,RIGHT)
													
													,skew(1.0)
													);
																
PHDR_slim_CORE_only := SORT(distribute(PHDR_slim_CORE, hash(did)), did, local,skew(1.0)):PERSIST('~thor400_92::persist::ckelly::PHDR_slim_CORE_only');

//output(PHDR_slim_CORE_only);
*/														
//-----------------------------------------------------------------------------

//PHDR_CORE := DATASET('~thor400_92::persist::ckelly::PHDR_slim_CORE_only', rec_PHDR_slim, flat);


//set_direct_DMV := [
//										'FD', 'FV'	//FL 	//src_FL_DL, src_FL_Veh
//										,'GD',			//LA	//src_LA_DL
//										'CD',				//MI	//src_MI_DL
//										'MD', 'SV',	//MO	//src_MO_DL, src_MO_Veh
//										'OD','OV',	//OH	//src_OH_DL, src_OH_Veh
//										'TD', 'TV'	//TX	//src_TX_DL, src_TX_Veh
//									];

//set_direct_DMV_name := 'FL_LA_MI_MO_OH_TX';
set_direct_DMV_name := 'all_DMVs';


rec_criteria := 
	RECORD
		rec_PHDR_slim;
		
		boolean src_is_dmv;
		boolean src_is_not_dmv;
		boolean has_ssn;
		boolean has_dob;
		
		string  translate_src := '';
	END;

rec_criteria xfmPHDR(PHDR_slim_sort LE) :=   
	TRANSFORM
//	 self.src_is_dmv                   := LE.src in set_direct_DMV;
	 self.src_is_dmv                   := LE.src in mdr.sourcetools.set_direct_dl or LE.src in mdr.sourcetools.set_direct_vehicles;
	 self.src_is_not_dmv               := self.src_is_dmv=false;
	 self.has_ssn                      := ut.full_ssn(LE.ssn)=true;
	 self.has_dob                      := IF(LE.dob <> 0,true,false);
	 self.translate_src                := MDR.sourceTools.fTranslateSource(LE.src);
	 
	 self                              := LE;
	 
	END;

PHDR_plus  := PROJECT(PHDR_slim_sort, xfmPHDR(LEFT));

output(PHDR_plus(src_is_dmv = true));
//output(PHDR_plus(src_is_dmv = true and ssn <> ''));
//output(PHDR_plus(src_is_dmv = true and dob <> 0));

segment_name := 'CORE';
//segment_name := '_All_SEGMENTS_';

//PHDR_DMV_DIDs := DEDUP(sort(distribute(PHDR_plus(src_is_dmv = true), hash(src,did)), src,did, local, skew(1.0)), src,did, all,local);
PHDR_DMV_DIDs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND src_is_dmv = true), hash(src,did)), src,did, local, skew(1.0)), src,did, all,local);

tbl_PHDR_DMV_DIDs := TABLE(PHDR_DMV_DIDs, {DID_segment, translate_src, did_count := count(group)}, DID_segment,translate_src, few);
output(sort(tbl_PHDR_DMV_DIDs, DID_segment,translate_src, skew(1.0)),ALL,named('PHDR_DMV_DIDs_byState'+segment_name+set_direct_DMV_name));

//---------------------------------------------------------------

	//--- 1. DIDs sourced only from direct DMV

PHDR_dids_DMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND src_is_dmv = true), hash(did)), did, local, skew(1.0)), did, all,local);
//output(choosen(PHDR_dids_DMV, 200));

PHDR_dids_nonDMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND src_is_not_dmv = true), hash(did)), did, local, skew(1.0)), did, all,local);
//output(choosen(PHDR_dids_nonDMV, 200));

PHDR_Dids_src_DMV := JOIN(sort(distribute(PHDR_dids_DMV, hash(did)), did, local,skew(1.0))
													 ,sort(distribute(PHDR_dids_nonDMV, hash(did)), did, local,skew(1.0))	
													 ,left.did = right.did
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::DIDs_direct_DMV_sourced_'+segment_name+set_direct_DMV_name+'_'+ut.GetDate[1..6])
													;

OUTPUT(PHDR_Dids_src_DMV, named('DIDs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_sample'));
OUTPUT(count(PHDR_Dids_src_DMV), named('DIDs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_count'));


PHDR_All_dids := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE'), hash(did)), did, local, skew(1.0)), did, all,local);
OUTPUT(count(PHDR_All_dids), named('PHDR_All_dids_count'));


tbl_PHDR_Dids_sole_src_DMV := TABLE(PHDR_Dids_src_DMV, {DID_segment, translate_src, did_count := count(group)}, DID_segment,translate_src, few);
output(sort(tbl_PHDR_Dids_sole_src_DMV, DID_segment,translate_src, skew(1.0)), ALL,named('tbl_PHDR_Dids_sole_src_DMV'+segment_name+set_direct_DMV_name));


//---------------------------------------------------------------

	//--- 2. Names sourced only from direct DMV - at the DID level
		
PHDR_Names_DMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND src_is_dmv = true), hash(did,fname,lname)), did,fname,lname, local, skew(1.0)), did,fname,lname, all,local);
//output(choosen(PHDR_Names_DMV, 200));

PHDR_Names_nonDMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND src_is_not_dmv = true), hash(did,fname,lname)), did,fname,lname, local, skew(1.0)), did,fname,lname, all,local);
//output(choosen(PHDR_Names_nonDMV, 200));

PHDR_Names_src_DMV := JOIN(sort(distribute(PHDR_Names_DMV, hash(did,fname,lname)), did,fname,lname, local,skew(1.0))
													 ,sort(distribute(PHDR_Names_nonDMV, hash(did,fname,lname)), did,fname,lname, local,skew(1.0))	
													 ,left.did = right.did
													  AND left.fname = right.fname
														AND left.lname = right.lname
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::DidNames_direct_DMV_sourced_'+segment_name+set_direct_DMV_name+'_'+ut.GetDate[1..6])
													;

OUTPUT(PHDR_Names_src_DMV, named('Names_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_sample'));
OUTPUT(count(PHDR_Names_src_DMV), named('Names_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_count'));	

PHDR_All_DidNames := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE'), hash(did,fname,lname)), did,fname,lname, local, skew(1.0)), did,fname,lname, all,local);
OUTPUT(count(PHDR_All_DidNames), named('PHDR_All_DidNames_count'));

tbl_PHDR_DidNames_sole_src_DMV := TABLE(PHDR_Names_src_DMV, {DID_segment, translate_src, did_count := count(group)}, DID_segment, translate_src,few);
output(sort(tbl_PHDR_DidNames_sole_src_DMV, DID_segment, translate_src,skew(1.0)), ALL,named('tbl_PHDR_DidNames_sole_src_DMV'+segment_name+set_direct_DMV_name));

//---------------------------

	//--- 3. Addresses sourced only from direct DMV - at the DID level
		
PHDR_Addrs_DMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND src_is_dmv = true), hash(did,prim_range,prim_name,sec_range,zip)), did,prim_range,prim_name,sec_range,zip, local, skew(1.0)), did,prim_range,prim_name,sec_range,zip, all,local);
//output(choosen(PHDR_Addrs_DMV, 200));

PHDR_Addrs_nonDMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND src_is_not_dmv = true), hash(did,prim_range,prim_name,sec_range,zip)), did,prim_range,prim_name,sec_range,zip, local, skew(1.0)), did,prim_range,prim_name,sec_range,zip, all,local);
//output(choosen(PHDR_Addrs_nonDMV, 200));

PHDR_Addrs_src_DMV := JOIN(sort(distribute(PHDR_Addrs_DMV, hash(did,prim_range,prim_name,sec_range,zip)), did,prim_range,prim_name,sec_range,zip, local,skew(1.0))
													 ,sort(distribute(PHDR_Addrs_nonDMV, hash(did,prim_range,prim_name,sec_range,zip)), did,prim_range,prim_name,sec_range,zip, local,skew(1.0))	
													 ,left.did = right.did
													 AND left.prim_range = right.prim_range
													 AND left.prim_name = right.prim_name
													 AND left.sec_range = right.sec_range
													 AND left.zip = right.zip
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::DidAddrs_direct_DMV_sourced_'+segment_name+set_direct_DMV_name+'_'+ut.GetDate[1..6])
													;

OUTPUT(PHDR_Addrs_src_DMV, named('Addrs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_sample'));
OUTPUT(count(PHDR_Addrs_src_DMV), named('Addrs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_count'));	

PHDR_All_DidAddrs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE'), hash(did,prim_range,prim_name,sec_range,zip)), did,prim_range,prim_name,sec_range,zip, local, skew(1.0)), did,prim_range,prim_name,sec_range,zip, all,local);
OUTPUT(count(PHDR_All_DidAddrs), named('PHDR_All_DidAddrs_count'));

tbl_PHDR_DidAddrs_sole_src_DMV := TABLE(PHDR_Addrs_src_DMV, {DID_segment, translate_src, did_count := count(group)}, DID_segment, translate_src,few);
output(sort(tbl_PHDR_DidAddrs_sole_src_DMV, DID_segment,translate_src, skew(1.0)), ALL,named('tbl_PHDR_DidAddrs_sole_src_DMV'+segment_name+set_direct_DMV_name));
																																														
//---------------------------------------------------------------

	//--- 4. SSNs sourced only from direct DMV - at the DID level
		
PHDR_DidSSNs_DMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_ssn=true AND src_is_dmv=true), hash(did,SSN)), did,SSN, local, skew(1.0)), did,SSN, all,local);

//output(choosen(PHDR_DidSSNs_DMV, 200), named('DIDs_paired_with_DMV_SSN_sample'));

PHDR_DidSSNs_nonDMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_ssn=true AND src_is_not_dmv=true), hash(did,SSN)), did,SSN, local, skew(1.0)), did,SSN, all,local);

//output(choosen(PHDR_DidSSNs_nonDMV, 200), named('DIDs_paired_with_NonDMV_SSN_sample'));

PHDR_DidSSNs_src_DMV := JOIN(sort(distribute(PHDR_DidSSNs_DMV, hash(did,SSN)), did,SSN, local,skew(1.0))
																 ,sort(distribute(PHDR_DidSSNs_nonDMV, hash(did,SSN)), did,SSN, local,skew(1.0))	
																 ,left.did = right.did
																 AND left.SSN = right.SSN
																 ,LEFT ONLY
																 ,skew(1.0)
																)
																:PERSIST('~thor400_92::persist::ckelly::DidSSNs_direct_DMV_sourced_'+segment_name+set_direct_DMV_name+'_'+ut.GetDate[1..6])
																;

OUTPUT(PHDR_DidSSNs_src_DMV, named('DidSSNs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_sample'));
OUTPUT(count(PHDR_DidSSNs_src_DMV), named('DidSSNs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_count'));

tbl_PHDR_DidSSNs_sole_src_DMV := TABLE(PHDR_DidSSNs_src_DMV, {DID_segment, translate_src, did_count := count(group)}, DID_segment,translate_src, few);
output(sort(tbl_PHDR_DidSSNs_sole_src_DMV, DID_segment,translate_src, skew(1.0)), ALL,named('tbl_PHDR_DidSSNs_sole_src_DMV'+segment_name+set_direct_DMV_name));
	

	//--- 4b. Number of DIDs who would have no SSN after removal:

PHDR_SSNs_src_DMV_DIDs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_ssn=true AND src_is_dmv=true), hash(did)),did, local,skew(1.0)), did, all,local);

PHDR_SSNs_src_nonDMV_DIDs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_ssn=true AND src_is_not_dmv=true), hash(did)),did, local,skew(1.0)), did, all,local);


PHDR_remove_DMV_noSSN := JOIN(sort(distribute(PHDR_SSNs_src_DMV_DIDs, hash(did,SSN)), did,SSN, local,skew(1.0))
																 ,sort(distribute(PHDR_SSNs_src_nonDMV_DIDs, hash(did)), did, local,skew(1.0))	
																 ,left.did = right.did
																 
																 ,LEFT ONLY
																 ,skew(1.0)
																)
																:PERSIST('~thor400_92::persist::ckelly::no_SSN_if_no_DMV_'+segment_name+set_direct_DMV_name+'_'+ut.GetDate[1..6])
																;

OUTPUT(sort(PHDR_remove_DMV_noSSN, did), named('DIDs_that_would_have_no_SSN_after_removal_'+set_direct_DMV_name+'_sample'));
OUTPUT(COUNT(PHDR_remove_DMV_noSSN), named('DIDs_that_would_have_no_SSN_after_removal_'+set_direct_DMV_name+'_count'));

tbl_remove_DMV_noSSN := TABLE(PHDR_remove_DMV_noSSN, {DID_segment, translate_src, did_count := count(group)}, DID_segment,translate_src, few);
output(sort(tbl_remove_DMV_noSSN, DID_segment,translate_src, skew(1.0)), ALL,named('tbl_remove_DMV_noSSN'+segment_name+set_direct_DMV_name));


PHDR_All_DidSSNs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_ssn=true), hash(did,SSN)), did,SSN, local, skew(1.0)), did,SSN, all,local);
OUTPUT(count(PHDR_All_DidSSNs), named('PHDR_All_DidSSNs_count'));

//---------------------------------------------------------------

	//--- 5. DOBs sourced only from direct DMV - at the DID level
		
PHDR_DOBs_DMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_dob=true AND src_is_dmv=true), hash(did,DOB)), did,DOB, local, skew(1.0)), did,DOB, all,local);
//output(choosen(PHDR_DOBs_DMV, 200));

PHDR_DOBs_nonDMV := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_dob=true AND src_is_not_dmv=true), hash(did,DOB)), did,DOB, local, skew(1.0)), did,DOB, all,local);
//output(choosen(PHDR_DOBs_nonDMV, 200));

PHDR_DOBs_src_DMV := JOIN(sort(distribute(PHDR_DOBs_DMV, hash(did,DOB)), did,DOB, local,skew(1.0))
													 ,sort(distribute(PHDR_DOBs_nonDMV, hash(did,DOB)), did,DOB, local,skew(1.0))	
													 ,left.did = right.did
													 AND left.DOB = right.DOB
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::DidDOBs_direct_DMV_sourced_'+segment_name+set_direct_DMV_name+'_'+ut.GetDate[1..6])
													;

OUTPUT(PHDR_DOBs_src_DMV, named('DOBs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_sample'));
OUTPUT(count(PHDR_DOBs_src_DMV), named('DOBs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_count'));	

tbl_PHDR_DidDOBs_sole_src_DMV := TABLE(PHDR_DOBs_src_DMV, {DID_segment, translate_src, did_count := count(group)}, DID_segment,translate_src, few);
output(sort(tbl_PHDR_DidDOBs_sole_src_DMV, DID_segment,translate_src, skew(1.0)), ALL,named('tbl_PHDR_DidDOBs_sole_src_DMV_'+segment_name+set_direct_DMV_name));


	//--- 5b. Number of DIDs who would have no DOB after removal

PHDR_DOBs_src_DMV_DIDs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_dob=true AND src_is_dmv=true), hash(did)),did, local,skew(1.0)), did, all,local);

PHDR_DOBs_src_nonDMV_DIDs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_dob=true AND src_is_not_dmv=true), hash(did)),did, local,skew(1.0)), did, all,local);


PHDR_remove_DMV_noDOB := JOIN(sort(distribute(PHDR_DOBs_src_DMV_DIDs, hash(did,DOB)), did,DOB, local,skew(1.0))
																 ,sort(distribute(PHDR_DOBs_src_nonDMV_DIDs, hash(did)), did, local,skew(1.0))	
																 ,left.did = right.did
																 
																 ,LEFT ONLY
																 ,skew(1.0)
																)
																:PERSIST('~thor400_92::persist::ckelly::no_DOB_if_no_DMV_'+segment_name+set_direct_DMV_name+'_'+ut.GetDate[1..6])
																;

OUTPUT(sort(PHDR_remove_DMV_noDOB, did), named('DIDs_that_would_have_no_DOB_after_removal_'+set_direct_DMV_name+'_sample'));
OUTPUT(COUNT(PHDR_remove_DMV_noDOB), named('DIDs_that_would_have_no_DOB_after_removal_'+set_direct_DMV_name+'_count'));			

tbl_remove_DMV_noDOB := TABLE(PHDR_remove_DMV_noDOB, {DID_segment, translate_src, did_count := count(group)}, DID_segment,translate_src, few);
output(sort(tbl_remove_DMV_noDOB, DID_segment,translate_src, skew(1.0)), ALL,named('tbl_remove_DMV_noDOB'+segment_name+set_direct_DMV_name));


PHDR_DidDOBs := DEDUP(sort(distribute(PHDR_plus(DID_segment = 'CORE' AND has_dob=true), hash(did,DOB)), did,DOB, local, skew(1.0)), did,DOB, all,local);
OUTPUT(count(PHDR_DidDOBs), named('PHDR_DidDOBs_count'));

//---------------------------------------------------------------

//--- 6. DL Numbers sourced only from direct DMV - at the DID level

//Base file:
File_DL2_Base := dataset(ut.foreign_prod+'~thor_200::base::dl2::drvlic', 
//                         DriversV2.Layout_DL, THOR);
                         DriversV2.Layout_DL_Extended, THOR);



DL2_DLs_DMV := DEDUP(sort(distribute(File_DL2_Base(source_code = 'AD', orig_state <> '', did <> 0, dl_number <> ''), hash(orig_state, did, dl_number))
													,orig_state, did, dl_number, local, skew(1.0)), orig_state, did, dl_number, local);
//output(choosen(DL2_DLs_DMV, 200));

DL2_DLs_nonDMV := DEDUP(sort(distribute(File_DL2_Base(source_code <> 'AD', orig_state <> '', did <> 0, dl_number <> ''), hash(orig_state, did, dl_number))
													,orig_state, did, dl_number, local, skew(1.0)), orig_state, did, dl_number, local);
//output(choosen(DL2_DLs_nonDMV, 200));

DL2_DLs_src_DMV := JOIN(sort(distribute(DL2_DLs_DMV, hash(orig_state, did, dl_number)), orig_state, did, dl_number, local,skew(1.0))
													 ,sort(distribute(DL2_DLs_nonDMV, hash(orig_state, did, dl_number)), orig_state, did, dl_number, local,skew(1.0))	
													 ,left.orig_state = right.orig_state
													 AND left.did = right.did
													 AND left.dl_number = right.dl_number
													 ,LEFT ONLY
													 ,skew(1.0)
													)
													:PERSIST('~thor400_92::persist::ckelly::DidDLs_direct_DMV_sourced_'+set_direct_DMV_name+'_'+ut.GetDate[1..6])
													;

OUTPUT(DL2_DLs_src_DMV, named('DLs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_sample'));
OUTPUT(count(DL2_DLs_src_DMV), named('DLs_sourced_only_from_direct_DMV_'+set_direct_DMV_name+'_count'));	

DL2_All_DidDLs := DEDUP(sort(distribute(File_DL2_Base(orig_state <> '', did <> 0, dl_number <> ''), hash(orig_state, did, dl_number))
													,orig_state, did, dl_number, local, skew(1.0)), orig_state, did, dl_number, local);
OUTPUT(count(DL2_All_DidDLs), named('DL2_All_DidDLs_count'));

EXPORT sole_sourced_DMV_build := '';