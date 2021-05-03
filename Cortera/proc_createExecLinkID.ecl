IMPORT AID, Address, Census_Data, Cortera, Cortera_Tradeline, data_services, did_add, doxie, nid, Tools, ut;

EXPORT proc_createExecLinkID (DATASET(Cortera.Layout_Header_Out) dCortera) := FUNCTION

  fNameIsBlank (l, c) := FUNCTIONMACRO
    BOOLEAN bIsBlank :=  MAP (
      c = 1 AND l.EXECUTIVE_NAME1 = '' => TRUE,
      c = 2 AND l.EXECUTIVE_NAME2 = '' => TRUE,
      c = 3 AND l.EXECUTIVE_NAME3 = '' => TRUE,
      c = 4 AND l.EXECUTIVE_NAME4 = '' => TRUE,
      c = 5 AND l.EXECUTIVE_NAME5 = '' => TRUE,
      c = 6 AND l.EXECUTIVE_NAME6 = '' => TRUE,
      c = 7 AND l.EXECUTIVE_NAME7 = '' => TRUE,
      c = 8 AND l.EXECUTIVE_NAME8 = '' => TRUE,
      c = 9 AND l.EXECUTIVE_NAME9 = '' => TRUE,
      c = 10 AND l.EXECUTIVE_NAME10 = '' => TRUE,
      FALSE);
    RETURN bIsBlank;
  ENDMACRO;
  
  Cortera.Layout_Executives xExecutives(RECORDOF(dCortera) l, UNSIGNED c) := TRANSFORM, 
    SKIP(fNameIsBlank(l, c) = TRUE)
		
    SELF.Executive_Name		:= CHOOSE(c, l.EXECUTIVE_NAME1, l.EXECUTIVE_NAME2, l.EXECUTIVE_NAME3, l.EXECUTIVE_NAME4, l.EXECUTIVE_NAME5,
																			 l.EXECUTIVE_NAME6, l.EXECUTIVE_NAME7, l.EXECUTIVE_NAME8, l.EXECUTIVE_NAME9, l.EXECUTIVE_NAME10);
    SELF.Executive_Title	:= CHOOSE(c, l.TITLE1, l.TITLE2, l.TITLE3, l.TITLE4, l.TITLE5,l.TITLE6, l.TITLE7, l.TITLE8, l.TITLE9, l.TITLE10);
    SELF.Name_Sequence 		:= c;
    SELF 									:= l;
    SELF 									:= [];
  END;

  dExecutives := NORMALIZE(dCortera, 10, xExecutives(LEFT, COUNTER));

  dExecutivesDedup := 
    DEDUP(
      SORT(
        DISTRIBUTE(dExecutives,HASH32(link_id)
        ),RECORD, LOCAL
      ),RECORD, EXCEPT Name_Sequence, ALL, LOCAL
    );

	// Name cleaning using NID name cleaner
  nid.mac_cleanfullnames(dExecutivesDedup, dExecutiveCleanName, EXECUTIVE_NAME, nid, ln_entity_type, title, fname, mname, lname, name_suffix,,,,,,,,,,TRUE, cname, TRUE);
	
	// Match to Headers by Contact Name and Address and phone
  matchset := ['A','P','Z'];
	
	// Appending lexids.
  did_add.MAC_Match_Flex(dExecutiveCleanName, 			// Input Dataset
												 matchset, 									// Matchset - what fields to match on
												 '',												// ssn
												 '',												// dob
												 fname,											// fname
												 mname,											// mname
												 lname,											// lname
												 name_suffix, 							// name_suffix
												 prim_range,								// prim_range
												 prim_name,									// prim_name
												 sec_range,									// sec_range
												 zip,												// zip5
												 st, 												// st
												 clean_phone,								// phone10
												 did,												// Did
												 cortera.Layout_Executives,	// output layout
												 TRUE,											// Does output record have the score
												 DID_Score,									// did score field
												 75,												// Default - score threshold
												 dExecutiveCleanNameWDID		// output dataset
												);

	//Appending global_sid's for CCPA.
	addGlobalSID := mdr.macGetGlobalSID(dExecutiveCleanNameWDID,'Cortera','','global_sid');

  RETURN addGlobalSID;
END;