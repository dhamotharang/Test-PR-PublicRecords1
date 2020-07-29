IMPORT Address,  Cortera, data_services, doxie, Tools, ut, mdr, prte2;

EXPORT proc_createExecLinkID (DATASET(Prte2_Cortera.Layouts.base) dCortera) := FUNCTION

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
 
 
  LayoutFullCortera := RECORD
    Cortera.Layout_Header_Out;
    Cortera.Layout_ExecLinkID;
  END;
	
 LayoutFullCortera_Ext := RECORD
    LayoutFullCortera;
    string9 Executive_LINK_SSN;
		string8 Executive_LINK_DOB;
		string Cust_name;
  END;
	
  LayoutFullCortera_Ext xExecutives(RECORDOF(dCortera) l, UNSIGNED c) := TRANSFORM, 
    SKIP(fNameIsBlank(l, c) = TRUE)
    SELF.Executive_Name := CHOOSE(c, l.EXECUTIVE_NAME1, l.EXECUTIVE_NAME2, l.EXECUTIVE_NAME3, l.EXECUTIVE_NAME4, l.EXECUTIVE_NAME5,
      l.EXECUTIVE_NAME6, l.EXECUTIVE_NAME7, l.EXECUTIVE_NAME8, l.EXECUTIVE_NAME9, l.EXECUTIVE_NAME10);
    SELF.Executive_Title := CHOOSE(c, l.TITLE1, l.TITLE2, l.TITLE3, l.TITLE4, l.TITLE5,l.TITLE6, l.TITLE7, l.TITLE8, l.TITLE9, l.TITLE10);
      
		 SELF.Executive_Link_SSN:=CHOOSE(c,l.EXECUTIVE1_LINK_SSN,l.EXECUTIVE2_LINK_SSN,l.EXECUTIVE3_LINK_SSN,l.EXECUTIVE4_LINK_SSN,l.EXECUTIVE5_LINK_SSN,l.EXECUTIVE6_LINK_SSN,
	                                    	l.EXECUTIVE7_LINK_SSN,l.EXECUTIVE8_LINK_SSN,l.EXECUTIVE9_LINK_SSN,l.EXECUTIVE10_LINK_SSN);
		
     SELF.Executive_Link_DOB:=CHOOSE(c,l.EXECUTIVE1_LINK_DOB,l.EXECUTIVE2_LINK_DOB,l.EXECUTIVE3_LINK_DOB,l.EXECUTIVE4_LINK_DOB,l.EXECUTIVE5_LINK_DOB,l.EXECUTIVE6_LINK_DOB,
	                                    	l.EXECUTIVE7_LINK_DOB,l.EXECUTIVE8_LINK_DOB,l.EXECUTIVE9_LINK_DOB,l.EXECUTIVE10_LINK_DOB);	 
	 
     self.Cust_Name:=l.cust_name;	
		 self.Ln_entity_type:= 'P';
		 		 
	   SELF.Name_Sequence := c;
    SELF := l;
    SELF := [];
  END;

  dExecutives := NORMALIZE(dCortera, 10, xExecutives(LEFT, COUNTER));

  dExecutivesDedup := 
   DEDUP(SORT(DISTRIBUTE(dExecutives,HASH32(link_id)),RECORD, LOCAL),RECORD, EXCEPT Name_Sequence, ALL, LOCAL);
	 
	  addGlobalSID := mdr.macGetGlobalSID(dExecutivesDedup,'Cortera','','global_sid');
		
		D1 := project(addGlobalSID,
    Transform(Cortera.Layout_ExecLinkID,
   
		CleanName:= Address.CleanPersonFML73_fields(left.executive_name);
                SELF.fname := CleanName.fname;
                SELF.mname := CleanName.mname;
                SELF.lname := CleanName.lname;
                SELF.name_suffix := CleanName.name_suffix;
                SELF.did :=  prte2.fn_AppendFakeID.did(self.fname, self.lname, left.Executive_LINK_SSN, left.Executive_LINK_DOB, left.cust_name);                
														
								SELF:=Left;
    ));
		 	
  return d1;
END;