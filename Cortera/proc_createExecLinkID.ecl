IMPORT AID, Address, Census_Data, Cortera, Cortera_Tradeline, data_services, did_add, doxie, nid, Tools, ut;

EXPORT proc_createExecLinkID (DATASET(Cortera.Layout_Header_Out) dCortera) := FUNCTION

  fNameIsBlank (l, c) := FUNCTIONMACRO
    BOOLEAN bIsBlank :=  MAP (
      c = 1 => FALSE,
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
  
  LayoutFullCortera := RECORD
    Cortera.Layout_Header_Out;
    Cortera.Layout_ExecLinkID;
  END;

  LayoutFullCortera xExecutives(RECORDOF(dCortera) l, UNSIGNED c) := TRANSFORM, 
    SKIP(c > 1 AND fNameIsBlank(l, c) = TRUE)
    SELF.Executive_Name := CHOOSE(c, l.EXECUTIVE_NAME1, l.EXECUTIVE_NAME2, l.EXECUTIVE_NAME3, l.EXECUTIVE_NAME4, l.EXECUTIVE_NAME5,
      l.EXECUTIVE_NAME6, l.EXECUTIVE_NAME7, l.EXECUTIVE_NAME8, l.EXECUTIVE_NAME9, l.EXECUTIVE_NAME10);
    SELF.Executive_Title := CHOOSE(c, l.TITLE1, l.TITLE2, l.TITLE3, l.TITLE4, l.TITLE5,l.TITLE6, l.TITLE7, l.TITLE8, l.TITLE9, l.TITLE10);
    SELF.Name_Sequence := c;
    SELF := l;
    SELF := [];
  END;

  dExecutives := NORMALIZE(dCortera, 10, xExecutives(LEFT, COUNTER));

  dExecutivesDedup := 
    DEDUP(
      SORT(
        DISTRIBUTE(dExecutives,HASH32(link_id)
        ),RECORD, LOCAL
      ),RECORD, EXCEPT Name_Sequence, ALL, LOCAL
    );

  nid.mac_cleanfullnames(dExecutivesDedup, dExecutiveCleanName, EXECUTIVE_NAME, nid, ln_entity_type, title, fname, mname, lname, name_suffix,,,,,,,,,,TRUE, cname, TRUE);

  matchset := ['A', 'Z'];

  did_add.MAC_Match_Flex(dExecutiveCleanName, matchset, '', '', fname, mname, lname, name_suffix, 
    prim_range, prim_name, sec_range, zip, st, '' , did, LayoutFullCortera, TRUE, DID_Score,75, dExecutiveCleanNameWDID);

  addGlobalSID := mdr.macGetGlobalSID(dExecutiveCleanNameWDID,'Cortera','','global_sid');

  RETURN PROJECT(addGlobalSID, Cortera.Layout_ExecLinkID);
END;