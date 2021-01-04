IMPORT Address, Ut, lib_stringlib, _Control, Header, Header_Slimsort, didville, ut, DID_Add, driversv2;

EXPORT Fn_AppendADL( DATASET(FLAccidents_Ecrash.Layout_Basefile) pDataset ) := FUNCTION

//Add unique id
	lUniqueId := {FLAccidents_Ecrash.Layout_Basefile , STRING15 temp_ssn, UNSIGNED8 unique_id};

	lUniqueId padSSN(pDataset L, UNSIGNED8 cnt) := TRANSFORM
		SELF.temp_ssn := MAP(LENGTH(L.ssn) = 7 => '00' + L.ssn,
		                     LENGTH(L.ssn) = 8 => '0' + L.ssn,
												 L.ssn);
    SELF.unique_id		:= cnt	;						
    SELF := L;
  END;
	dAddUniqueId := PROJECT(pDataset, padSSN(LEFT, COUNTER));

// slim layout 
	dSlim := PROJECT(dAddUniqueId, Layout_Infiles_Fixed.DidSlim);
 
//append DID 
	did_matchset := ['A','D','S','Z','G','4'];

	did_add.MAC_Match_Flex(dSlim,did_matchset,
                        temp_ssn,date_of_birth,fname,mname,lname,suffix,
				                prim_range,prim_name,sec_range,z5,st,nophone,
				                did,FLAccidents_Ecrash.Layout_Infiles_Fixed.DidSlim,true,did_score,75,dDidOut);
					 
	dDidOut_dist := DISTRIBUTE(dDidOut(did <> 0), unique_id );
	dDidOut_sort := SORT(dDidOut_dist, unique_id, -did_score, LOCAL);
	dDidOut_dedup := DEDUP(dDidOut_sort, unique_id, LOCAL);
		
	dAddUniqueId_dist := DISTRIBUTE(dAddUniqueId , unique_id);
			 
	Layout_Basefile tAssignDIDs(dAddUniqueId_dist l, FLAccidents_Ecrash.Layout_Infiles_Fixed.DidSlim r) := TRANSFORM
    SELF.did				:= IF(r.did 			<> 0, r.did				, 0);
		SELF.did_score	:= IF(r.did_score <> 0, r.did_score	, 0);
		SELF 						:= l;
  END;
	dAssignDids := JOIN(dAddUniqueId_dist, dDidOut_dedup,
											LEFT.unique_id = RIGHT.unique_id,
											tAssignDIDs(LEFT, RIGHT),
											LEFT OUTER, LOCAL);		
// return dAssignDids;		
  eCrashNoDID := dAssignDids(did = 0 AND Drivers_License_Number <> '');
  eCrashDID := dAssignDids(did <> 0 OR Drivers_License_Number = '');

//splitting streams above to reduce skewing and process run time.
  dsDL := driversv2.File_DL(did <> 0 AND REGEXFIND('[1-9]', dl_number) AND LENGTH(lname)> 1 AND dl_number <> '1111111');

//create dl/DID table
  temp_SlimDL_layout := RECORD
		dsDL.lname;
		dsDL.fname;
		dsDL.mname;
		dsDL.dl_number;
		dsDL.orig_state;
		dsDL.did;
  END;
  tblDL := TABLE(dsDL, temp_SlimDL_layout, lname, fname, mname, dl_number, orig_state, did, FEW):PERSIST('~thor_200::persist::tbl_dl');
	
// #############################################################################################
// Join eCrash reports with no DID with DL file to append DID.
// #############################################################################################	
  utblDLByDlnLn := DEDUP(tblDL, dl_number, lname, ALL);
  eCrashNoDID tGetDIDDlnLn(eCrashNoDID L, utblDLByDlnLn R) := TRANSFORM
    SELF.did := MAP(L.Drivers_License_Number = R.dl_number AND
                    ut.NNEQ(L.Drivers_License_jurisdiction, R.orig_state) AND 
                    (REGEXFIND(REGEXREPLACE(' +', R.lname, ' '),
										           REGEXREPLACE(' +', L.fname + ' ' + L.mname + ' ' + L.lname, ' ')) OR 
                     REGEXFIND(TRIM(R.lname, ALL), REGEXREPLACE(' +', L.fname + ' ' + L.mname + ' ' + L.lname, ' '))
										 ) => R.did,
										L.did);    
    SELF := L;    
  END;    
  jeCrashDID_DlnLn := JOIN(eCrashNoDID, utblDLByDlnLn,
                           LEFT.Drivers_License_Number = RIGHT.dl_number AND
                           ut.NNEQ(LEFT.Drivers_License_jurisdiction, RIGHT.orig_state) AND
                           (REGEXFIND(REGEXREPLACE(' +', RIGHT.lname, ' '),
								                      REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname, ' ')) OR  
                            REGEXFIND(TRIM(RIGHT.lname, ALL), REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname, ' '))),
                            tGetDIDDlnLn(LEFT, RIGHT), LEFT OUTER, HASH);
													
  utblDLByDlnFn := DEDUP(tblDL, dl_number, fname, ALL);
  jeCrashDID_DlnLn tGetDIDDlnFn(jeCrashDID_DlnLn L, utblDLByDlnFn R) := TRANSFORM
    SELF.did := MAP(L.did = 0 AND 
	                  L.Drivers_License_Number = R.dl_number AND
									  ut.NNEQ(L.Drivers_License_jurisdiction, R.orig_state) AND
									  ut.NNEQ((STRING)L.mname[1],(STRING)R.mname[1]) AND 
									  (REGEXFIND(REGEXREPLACE(' +', R.fname, ' '),
                               REGEXREPLACE(' +', L.fname + ' ' + L.mname + ' ' + L.lname, ' ')) OR 
                    REGEXFIND(TRIM(R.fname, ALL), REGEXREPLACE(' +', L.fname + ' ' + L.mname + ' ' + L.lname,' ')))
                    => R.did,
									  L.did);
    SELF := L;    
  END;    
  jeCrashDID_DL := JOIN(jeCrashDID_DlnLn, utblDLByDlnFn,
                        LEFT.did = 0 AND 
                        LEFT.Drivers_License_Number = RIGHT.dl_number AND
                        ut.NNEQ(LEFT.Drivers_License_jurisdiction,RIGHT.orig_state) AND
                        ut.NNEQ((STRING)LEFT.mname[1],(STRING)RIGHT.mname[1]) AND
												(REGEXFIND(
                        REGEXREPLACE(' +', RIGHT.fname, ' '),
                        REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname, ' ')) OR 
                        REGEXFIND(
                        TRIM(RIGHT.fname, ALL),
                        REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname, ' '))),
                        tGetDIDDlnFn(LEFT, RIGHT), LEFT OUTER, HASH);
  RETURN eCrashDID + jeCrashDID_DL;
END;