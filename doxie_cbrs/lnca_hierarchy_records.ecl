IMPORT DCAV2,ut,iesp;
/* This module will accept a record set a bdids and use the first one to create the entire hierarchy of
the passed bdid. The logic will first find the ulitmate parent of the bdid, and then drill down from the highest
point and capture all of the companies under the ultimate parent.
Do to the multiple levels of parent/child nested datasets cannot be created currently within ECL,
for this reason hierarchy info is returned as an XML string that ESP will parse.
*/
      
doxie_cbrs.mac_Selection_Declare()
  
EXPORT lnca_hierarchy_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE
  
  
  UNSIGNED2 MaxTreeDepth := 9; // Depth is actually 10, but ultimate parent is retrieved outside the loop.
  UNSIGNED3 MaxStringLen := 200000;
  UNSIGNED1 HierLenError := 200; // Error code to indicate that the output length has been exceeded.
    
  // A constant fake group Id is added to every company record within the hierarchy so that
  // the records can be grouped on a common value. Value has no meaning whatsover.
  STRING1 Fake_groupID := 'A';
  
  slim_hierRec := RECORD
    STRING9 enterprise_num;
    STRING9 parent_enterprise_number;
    STRING2 child_level;
    INTEGER grpLevel;
    UNSIGNED1 numPrecEndTags := 0;
    UNSIGNED2 sub_group_id1 := 0;
    UNSIGNED2 sub_group_id2 := 0;
    UNSIGNED2 sub_group_id3 := 0;
    UNSIGNED2 sub_group_id4 := 0;
    UNSIGNED2 sub_group_id5 := 0;
    UNSIGNED2 sub_group_id6 := 0;
    UNSIGNED2 sub_group_id7 := 0;
    UNSIGNED2 sub_group_id8 := 0;
    UNSIGNED2 sub_group_id9 := 0;
  END;

  full_HierRec := RECORD
    STRING9 enterprise_num;
    STRING9 parent_enterprise_number;
    STRING2 child_level := '0';
    INTEGER grpLevel := 0;
    UNSIGNED1 numPrecEndTags := 0;
    BOOLEAN lastRec := FALSE;
    STRING1 dummyGroupField := Fake_groupId;
    UNSIGNED2 sub_group_id1 := 0;
    UNSIGNED2 sub_group_id2 := 0;
    UNSIGNED2 sub_group_id3 := 0;
    UNSIGNED2 sub_group_id4 := 0;
    UNSIGNED2 sub_group_id5 := 0;
    UNSIGNED2 sub_group_id6 := 0;
    UNSIGNED2 sub_group_id7 := 0;
    UNSIGNED2 sub_group_id8 := 0;
    UNSIGNED2 sub_group_id9 := 0;
    UNSIGNED6 bdid;
    STRING105 name;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 p_city_name;
    STRING25 v_city_name;
    STRING2 st;
    STRING5 z5;
  END;

  hierXMLRec := RECORD
    STRING company;
    STRING9 enterprise_num;
    STRING9 parent_enterprise_number;
    STRING2 child_level;
    INTEGER grpLevel;
    STRING1 dummyGroupField;
    UNSIGNED1 numPrecEndTags := 0;
    UNSIGNED2 sub_group_id1 := 0;
    UNSIGNED2 sub_group_id2 := 0;
    UNSIGNED2 sub_group_id3 := 0;
    UNSIGNED2 sub_group_id4 := 0;
    UNSIGNED2 sub_group_id5 := 0;
    UNSIGNED2 sub_group_id6 := 0;
    UNSIGNED2 sub_group_id7 := 0;
    UNSIGNED2 sub_group_id8 := 0;
    UNSIGNED2 sub_group_id9 := 0;
  END;
  endTags := [ '</Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
                '</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>'];

  XMLOutRec := RECORD
    STRING200000 hierarchy;
    STRING1 dummyGroupField;
    UNSIGNED1 hier_err_code := 0;
  END;

  lncaFirmRec := RECORD
    UNSIGNED6 bdid;
    STRING1 dummyGroupField;
    STRING70 Type_orig;
    STRING105 name;
    STRING107 Note;
    STRING2 Incorp;
    STRING5 percent_owned;
    STRING12 Earnings;
    STRING12 Sales;
    STRING15 Sales_Desc;
    STRING12 assets;
    STRING12 liabilities;
    STRING12 Net_Worth_;
    STRING6 FYE;
    STRING9 EMP_NUM;
    STRING1 Import_orig;
    STRING1 Export_orig;
    STRING1502 Bus_Desc;
    STRING4 Sic1;
    STRING97 Text1;
    STRING4 Sic2;
    STRING97 Text2;
    STRING4 Sic3;
    STRING97 Text3;
    STRING4 Sic4;
    STRING97 Text4;
    STRING4 Sic5;
    STRING97 Text5;
    STRING4 Sic6;
    STRING97 Text6;
    STRING4 Sic7;
    STRING97 Text7;
    STRING4 Sic8;
    STRING97 Text8;
    STRING4 Sic9;
    STRING97 Text9;
    STRING4 Sic10;
    STRING97 Text10;
    STRING46 Name_1;
    STRING63 Title_1;
    STRING3 code_1;
    STRING45 Name_2;
    STRING65 Title_2;
    STRING3 code_2;
    STRING44 Name_3;
    STRING65 Title_3;
    STRING3 code_3;
    STRING36 Name_4;
    STRING65 Title_4;
    STRING3 code_4;
    STRING43 Name_5;
    STRING65 Title_5;
    STRING3 code_5;
    STRING43 Name_6;
    STRING65 Title_6;
    STRING3 code_6;
    STRING42 Name_7;
    STRING65 Title_7;
    STRING3 code_7;
    STRING40 Name_8;
    STRING65 Title_8;
    STRING3 code_8;
    STRING37 Name_9;
    STRING61 Title_9;
    STRING3 code_9;
    STRING38 Name_10;
    STRING65 Title_10;
    STRING3 code_10;
    STRING11 Ticker_Symbol;
    STRING7 Exchange1;
    STRING6 Exchange2;
    STRING6 Exchange3;
    STRING6 Exchange4;
    STRING60 CBSA;
    STRING5000 Competitors;
    STRING7 Naics1;
    STRING150 Naics_Text1;
    STRING7 Naics2;
    STRING150 Naics_Text2;
    STRING7 Naics3;
    STRING150 Naics_Text3;
    STRING7 Naics4;
    STRING150 Naics_Text4;
  END;

  lncaOutRec := RECORD
    STRING200000 hierarchy := '';
    UNSIGNED1 hier_err_code := 0;
    lncaFirmRec;
  END;
  
  // Get enterprise number of the passed bdid
  dca_by_bdid :=
    JOIN(
      bdids, DCAV2.Keys().bdid.qa,
      KEYED(LEFT.bdid = RIGHT.bdid),
      TRANSFORM(RIGHT),
      INNER,
      LIMIT(ut.limits.default, SKIP)
    );
  
  // Get "all" lnca info of the passed company
  comp_lnca_info :=
    JOIN(
      dca_by_bdid, DCAV2.Keys().EntNum.qa,
      KEYED(LEFT.enterprise_num = RIGHT.enterprise_num),
      TRANSFORM(lncaOutRec,SELF := RIGHT, SELF.dummyGroupField := Fake_groupID, SELF := []),
      INNER,
      KEEP(1),
      LIMIT(ut.limits.default, SKIP)
    );
        
  /* The loop function will join the passed in hierarchy dataset with the hierarchy keyed file
     n number of times, with n being the maximum known tree depth, at the time of developement it
     was ten(note the loop count is 9, since the first level has already been populated via from the
     ulitmate parent. For each iteration, only the records added during the previous join will be used
     as part of the Join logic. Reason being is that the key file is a hierarchy keyed file and the
     function is going down each branch, so we want to exclude the previous
     grandparents, great grandparents and so on. */
  fn_loopHierarchy(DATASET(slim_hierRec) hier, INTEGER cnt) := FUNCTION
        // Join only using the previously added records, (grplevel = cnt -1). For each loop call all of
        // records from each previously retrieved level are passed, records are appended during each interation of the loop.
        ChildRecs := JOIN(hier(grpLevel = cnt -1), DCAV2.Keys().HierP2CNew.qa,
             KEYED(LEFT.enterprise_num = RIGHT.parent_enterprise_number) AND
             KEYED(LEFT.enterprise_num != RIGHT.enterprise_num), // Sometimes a company is listed as a parent of itself, this will exclude
             TRANSFORM(slim_hierRec,
                      SELF.grpLevel := cnt,
                      SELF := RIGHT),
                      INNER,
                      LIMIT(ut.limits.default, SKIP));
                      
        // Remove dups from the data
        ChildRecsDedup := DEDUP(ChildRecs,RECORD,ALL);
        
        // Assign the sub_group_ids for the newly added records based on the level
        slim_hierRec Add_sub_id(slim_hierRec l, slim_hierRec r) := TRANSFORM
            SELF.sub_group_id1 := IF(r.grpLevel = 1,l.sub_group_id1+1,0);
            SELF.sub_group_id2 := IF(r.grpLevel = 2,l.sub_group_id2+1,0);
            SELF.sub_group_id3 := IF(r.grpLevel = 3,l.sub_group_id3+1,0);
            SELF.sub_group_id4 := IF(r.grpLevel = 4,l.sub_group_id4+1,0);
            SELF.sub_group_id5 := IF(r.grpLevel = 5,l.sub_group_id5+1,0);
            SELF.sub_group_id6 := IF(r.grpLevel = 6,l.sub_group_id6+1,0);
            SELF.sub_group_id7 := IF(r.grpLevel = 7,l.sub_group_id7+1,0);
            SELF.sub_group_id8 := IF(r.grpLevel = 8,l.sub_group_id8+1,0);
            SELF.sub_group_id9 := IF(r.grpLevel = 9,l.sub_group_id9+1,0);
            SELF := r;
        END;
        
        ChildSubId := ITERATE(ChildRecsDedup,Add_sub_id(LEFT,RIGHT));
        
        /* Join against passed in hier recs to pass on the previous assigned sub group level numbers for the added company records.
           In order to keep the complete ancestory of each company subgroupids are used. Note, the ultimate
           doesn't have a sub_group_id value, since all children are its ancestors.
           Example:
           Company Name          sub_group_id1 sub_group_id2 sub_group_id3 sub_group_id4
           Reed Elsevier               0             0             0             0
           Lexis Nexis Group           1             0             0             0
           Lexis Nexis                 1             1             0             0
           Risk Solutions              1             2             0             0
           Lexis Doc Service           1             1             1             0
           Michie                      1             1             2             0
           Dolan                       1             2             1             0
           Riskwise                    1             2             2             0
           Michie Docs                 1             1             2             1
           RiskWise Insurance          1             2             2             1 */
           
        ChildParentIds := JOIN(ChildSubId, hier,
                                LEFT.parent_enterprise_number = RIGHT.enterprise_num,
                                TRANSFORM(slim_hierRec,
                                    SELF.sub_group_id1 := IF(LEFT.grpLevel = 1,LEFT.sub_group_id1,RIGHT.sub_group_id1),
                                    SELF.sub_group_id2 := IF(LEFT.grpLevel = 2,LEFT.sub_group_id2,RIGHT.sub_group_id2),
                                    SELF.sub_group_id3 := IF(LEFT.grpLevel = 3,LEFT.sub_group_id3,RIGHT.sub_group_id3),
                                    SELF.sub_group_id4 := IF(LEFT.grpLevel = 4,LEFT.sub_group_id4,RIGHT.sub_group_id4),
                                    SELF.sub_group_id5 := IF(LEFT.grpLevel = 5,LEFT.sub_group_id5,RIGHT.sub_group_id5),
                                    SELF.sub_group_id6 := IF(LEFT.grpLevel = 6,LEFT.sub_group_id6,RIGHT.sub_group_id6),
                                    SELF.sub_group_id7 := IF(LEFT.grpLevel = 7,LEFT.sub_group_id7,RIGHT.sub_group_id7),
                                    SELF.sub_group_id8 := IF(LEFT.grpLevel = 8,LEFT.sub_group_id8,RIGHT.sub_group_id8),
                                    SELF.sub_group_id9 := IF(LEFT.grpLevel = 9,LEFT.sub_group_id9,RIGHT.sub_group_id9),
                                    SELF := LEFT));
        
        // Added the newly found child records to the previous parent, grandparents etc records.
        RETURN(hier + ChildParentIds);
  END;
  
  /* Get the ultimate parent number to use as the starting point for the hierarchy tree. Sometimes there are multiple
     for a bdid in the dca key file, use the one with a level of 0. */
  ultimateEntNumber := IF(dca_by_bdid[1].level = '0', dca_by_bdid[1].enterprise_num,dca_by_bdid[1].ultimate_enterprise_number);

  // Create the seed record default the group level, child level and num end tags to zero
  ultParent := DATASET([ {ultimateEntNumber,'',0,0}
                        ], slim_hierRec);
  
  // Construct record set of the hierarchy from the ultimate parent on down.
  hierSet := LOOP(ultParent,MaxTreeDepth,fn_loopHierarchy(ROWS(LEFT),COUNTER));
  
  // Get the full company information (name,address etc) from the enterprise numbers.
  fullHierSet := JOIN(
                    hierSet, DCAV2.Keys().EntNum.qa,
                    KEYED(LEFT.enterprise_num = RIGHT.enterprise_num),
                    TRANSFORM(full_HierRec,
                              SELF.parent_enterprise_number := LEFT.parent_enterprise_number,
                              SELF := LEFT,
                              SELF := RIGHT),
                    INNER,
                    KEEP(1),
                    LIMIT(ut.limits.default, SKIP)
                    );
  
  // Emtpy record to append to end of hierarchy to force closing tags.
  emptyRec := PROJECT(ultParent,TRANSFORM(full_HierRec,
                                          SELF.enterprise_num := LEFT.enterprise_num,
                                          SELF.dummyGroupField := Fake_groupID,
                                          SELF.lastRec := TRUE,
                                          SELF := []));
                                          
  hierSetSrt := SORT(fullhierSet+emptyRec,lastrec,sub_group_id1,sub_group_id2,sub_group_id3,sub_group_id4,
                              sub_group_id5,sub_group_id6,sub_group_id7,sub_group_id8,
                              sub_group_id9,RECORD);
  
  full_HierRec xfm_MarkEndTag(full_HierRec l, full_HierRec r, INTEGER cnt) := TRANSFORM
      // Don't set preceding tag count for first record.
      SELF.numPrecEndTags := IF (cnt > 1,(l.grpLevel - r.grpLevel +1),0); // Set the number of end tags needed for the record via the
                                                                           // group levels, calculation isn't necessary for top parent record.
      SELF := r;
  END;

  hierSetTag := ITERATE(hierSetSrt,xfm_MarkEndTag(LEFT,RIGHT,COUNTER));
  
  // This transform will create an xml string for each company row in the record set.
  // NOTE, no encoding is being done on the XML since the system by defaults encodes the results
  // from the services.
  hierXMLRec xfm_createXML(full_HierRec l) := TRANSFORM
    precXML := IF(l.numPrecEndTags > 0,(endTags[l.numPrecEndTags]),'');
      SELF.company := precXML +
                      IF(l.lastRec, '', // For last rec, no content to output, just preceding closing tags.
                        ('<Company>' +
                                  '<UniqueID>' + XMLENCODE(TRIM((STRING)l.bdid)) + '</UniqueID>' +
                                  '<Name>' + XMLENCODE(TRIM(l.name)) + '</Name>' +
                                  '<Address>' +
                                    '<StreetNumber>' + XMLENCODE(TRIM(l.prim_range)) + '</StreetNumber>' +
                                    '<StreetPreDirection>' + XMLENCODE(TRIM(l.predir)) + '</StreetPreDirection>' +
                                    '<StreetName>' + XMLENCODE(TRIM(l.prim_name)) + '</StreetName>' +
                                    '<StreetSuffix>' + XMLENCODE(TRIM(l.addr_suffix)) + '</StreetSuffix>' +
                                    '<StreetPostDirection>' + XMLENCODE(TRIM(l.postdir)) + '</StreetPostDirection>' +
                                    '<UnitDesignation>' + XMLENCODE(TRIM(l.unit_desig)) + '</UnitDesignation>' +
                                    '<UnitNumber>' + XMLENCODE(TRIM(l.sec_range)) + '</UnitNumber>' +
                                    '<City>' + XMLENCODE(TRIM(l.p_city_name)) + '</City>' +
                                    '<State>' + XMLENCODE(TRIM(l.st)) + '</State>' +
                                    '<Zip5>' + XMLENCODE(TRIM(l.z5)) + '</Zip5>' +
                                  '</Address>' +
                                  '<Subsidiaries>'));
      SELF := l;
  END;
  
  // At the time of development returning a nested parent/child dataset structure up to 9 levels deep was
  // not possible, it was determined that the best solution was to return a string of XML.
  hierSetXML := PROJECT(hierSetTag,xfm_createXML(LEFT));
  
  UNSIGNED3 combStrLength := SUM(hierSetXML, LENGTH(hierSetXML.company));
  
  // Roll up each XML row in the recordset into one large string.
  XMLOutRec roll_Recs(XMLOutRec l, hierXMLRec r) := TRANSFORM
    SELF.hierarchy := TRIM(l.hierarchy) + r.company;
    SELF.dummyGroupField := r.dummyGroupField;
    SELF := [];
  END;
  
  // Create dataset record to roll the record's into with the same group id (fake_groupid)
  tempOut := DATASET([{'',Fake_groupID}], XMLOutRec);
  
  // Dataset with error message when hierarchy string exceeds 200,000 characters, which is the limit for the
  // output string. 200,000 choosen since if this length is exceeded it probably indicates a data issue.
  LenErrRec := DATASET([{'','',HierLenError}], XMLOutRec);
  
  // If the hierachy length is less than the maximum value then output, otherwise output empty string with rtn code.
  outXML := IF(combStrLength < MaxStringLen,
                  DENORMALIZE(tempOut,HierSetXML,LEFT.dummyGroupField = RIGHT.dummyGroupField,roll_Recs(LEFT,RIGHT)),
                  LenErrRec);
  
  //Combine the hierarchy info with the lnca firmographic info of the passed company, outRec will be empty if
  // no bdid was found no output will be built. Check is needed because a dummyGroupId will always exist.
  outRec := IF(EXISTS(dca_by_bdid),DENORMALIZE(outXML,comp_lnca_info,LEFT.dummyGroupField = RIGHT.dummyGroupField,GROUP,
                                                TRANSFORM(lncaOutRec,SELF := LEFT, SELF := RIGHT, SELF := [])));
  
  // Transform into IESP output layout
  iesp.lncafirmographics.t_LNCARecord format_iesp(lncaOutRec l) := TRANSFORM
      SELF.Hierarchy := l.hierarchy;
      SELF.HierarchyErrorCode := l.hier_err_code;
      SELF.CompanyType := l.Type_orig;
      SELF.BusinessName := l.name;
      SELF.Note := l.Note;
      SELF.Incorp := l.Incorp;
      SELF.PercentageOwned := (INTEGER) l.percent_owned;
      SELF.Earnings := (INTEGER) l.Earnings;
      SELF.Sales := (INTEGER) l.Sales;
      SELF.SalesDescription := l.Sales_Desc;
      SELF.Assets := (INTEGER) l.assets;
      SELF.Liabilities := (INTEGER) l.Liabilities;
      SELF.NetWorth := (INTEGER) l.Net_Worth_;
      SELF.FiscalYearEnd := iesp.ECL2ESP.toDatestring8(l.FYE);
      SELF.NumberOfEmployees := (INTEGER) l.EMP_NUM;
      SELF.Imports := l.Import_orig;
      SELF.Exports := l.Export_orig;
      SELF.BusinessDescription := l.Bus_Desc;
      SELF.CoreBasedStatisticalArea := l.CBSA;
      SELF.Competitors := l.Competitors;
      
      sicRecs := DATASET([{(INTEGER) l.Sic1,l.Text1},{(INTEGER) l.Sic2,l.Text2},
                           {(INTEGER) l.Sic3,l.Text3},{(INTEGER) l.Sic4,l.Text4},
                          {(INTEGER) l.Sic5,l.Text5},{(INTEGER) l.Sic6,l.Text6},
                          {(INTEGER) l.Sic7,l.Text7},{(INTEGER) l.Sic8,l.Text8},
                          {(INTEGER) l.Sic9,l.Text9},{(INTEGER) l.Sic10,l.Text10}],iesp.lncafirmographics.t_lncaSICCode);
      SELF.SICCodes := CHOOSEN(sicRecs,iesp.constants.LNCA.MaxSICCodes);
      
      execTrans(STRING ExecName, STRING Title, STRING code) :=
                    TRANSFORM(iesp.lncafirmographics.t_lncaExecutive,
                            SELF.Name := iesp.ECL2ESP.SetName('','','','','',ExecName);
                            SELF.Title := Title;
                            SELF.code := code);
      
      execRecs := DATASET([ execTrans(l.Name_1,l.Title_1,l.code_1),
                            execTrans(l.Name_2,l.Title_2,l.code_2),
                            execTrans(l.Name_3,l.Title_3,l.code_3),
                            execTrans(l.Name_4,l.Title_4,l.code_4),
                            execTrans(l.Name_5,l.Title_5,l.code_5),
                            execTrans(l.Name_6,l.Title_6,l.code_6),
                            execTrans(l.Name_7,l.Title_7,l.code_7),
                            execTrans(l.Name_8,l.Title_8,l.code_8),
                            execTrans(l.Name_9,l.Title_9,l.code_9),
                            execTrans(l.Name_10,l.Title_10,l.code_10)]);
      SELF.Executives := CHOOSEN(execRecs,iesp.constants.LNCA.MaxExecutives);
      
      ExchngRecs := DATASET([{l.Exchange1},{l.Exchange2},{l.Exchange3},{l.Exchange4}],iesp.share.t_StringArrayItem);
      SELF.Exchanges := CHOOSEN(ExchngRecs,iesp.constants.LNCA.MaxExchanges);
      
      naicRecs := DATASET([{(INTEGER) l.Naics1,l.Naics_Text1},{(INTEGER) l.Naics2,l.Naics_Text2},
                            {(INTEGER) l.Naics3,l.Naics_Text3},{(INTEGER) l.Naics4,l.Naics_Text4} ],iesp.lncafirmographics.t_lncaSICCode);
      SELF.NAICSCodes := CHOOSEN(naicRecs,iesp.constants.LNCA.MaxNAICSCodes);
  END;
  
  SHARED lnca_out := PROJECT(CHOOSEN(outRec(Include_LNCA_val),iesp.constants.LNCA.MaxLNCA),format_iesp(LEFT));

  EXPORT records := lnca_out;
  EXPORT records_count := COUNT(lnca_out);
END;
