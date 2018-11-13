IMPORT Address, AutoKeyI, BIPV2, BIPV2_Best, Business_Risk_BIP, Doxie;

// Will need to pass in some additional input params
EXPORT SmallBusiness_BIP_Append_Inputs (DATASET(LNSmallBusiness.BIP_Layouts.InputWSeq) Input,
                        BIPV2.mod_sources.iParams linkingOptions) := FUNCTION

  // Get values missing from the input from global.
    mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
      EXPORT unsigned1 glb :=linkingOptions.glbpurpose;
      EXPORT unsigned1 dppa := linkingOptions.dppapurpose;
      EXPORT string DataRestrictionMask := linkingOptions.DataRestrictionMask;
      EXPORT boolean ln_branded := linkingOptions.lnbranded;
    END;

    ds_SearchInput := PROJECT(Input(SeleID <> 0), TRANSFORM(BIPV2.IDFunctions.rec_SearchInput, 
        SELF.inSeleid      := (STRING)LEFT.SeleID,
        SELF.acctno        := (STRING)LEFT.seq,
        SELF               := []));

    ds_linkIDs := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_SearchInput).Data2_;		

    ds_linkIDs_deduped := DEDUP(SORT(ds_linkIDs, AcctNo, -weight, UltID, OrgID, SeleID, ProxID, PowID), AcctNo);

    // By fulling populating the linkIDs here, we will search by these in the business shell. The combined service does not fully populate these, so 
    // behavior here will be slightly different than in the combined service.
    Input_with_LinkIDs := JOIN(Input, ds_linkIDs_deduped, LEFT.Seq = (UNSIGNED)RIGHT.AcctNo, TRANSFORM(RECORDOF(LEFT),
                              SELF.UltID := IF(LEFT.UltID > 0, LEFT.UltID, RIGHT.UltID);
                              SELF.OrgID := IF(LEFT.OrgID > 0, LEFT.OrgID, RIGHT.OrgID);
                              SELF.SeleID := IF(LEFT.SeleID > 0, LEFT.SeleID, RIGHT.SeleID);
                              SELF.ProxID := IF(LEFT.ProxID > 0, LEFT.ProxID, RIGHT.ProxID),
                              SELF.PowID := IF(LEFT.PowID > 0, LEFT.PowID, RIGHT.PowID);
                              SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

    ds_in_ids := PROJECT(Input_with_LinkIDs(SeleID <> 0), TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, SELF.uniqueid := (UNSIGNED)LEFT.Seq, SELF := LEFT));

    ds_best := 
      BIPV2_Best.Key_LinkIds.KFetch2( ds_in_ids,
                                     BIPV2.IDconstants.Fetch_Level_SELEID,
                                     0,
                                     linkingOptions,
                                     TRUE, //IncludeStatus
                                     Business_Risk_BIP.Constants.Limit_Default,
                                     Business_Risk_BIP.Constants.DefaultJoinType
                                    )(proxid = 0);	
                  

      ds_SBA_InputFromSeleID := JOIN(Input_with_LinkIDs, ds_best, LEFT.seq=RIGHT.uniqueid, 
          TRANSFORM( LNSmallBusiness.BIP_Layouts.Inputwseq,
                     UseBest := LEFT.SeleID <> 0;
                     SELF.Bus_Phone10         := IF(UseBest,(STRING10)RIGHT.Company_phone[1].company_phone, LEFT.Bus_Phone10);
                     SELF.Bus_Company_Name    := IF(UseBest,RIGHT.Company_name[1].Company_Name, LEFT.Bus_Company_Name);   
                     SELF.Bus_Street_Address1 := IF(UseBest,(STRING120)Address.Addr1FromComponents(RIGHT.company_address[1].company_prim_range,
                                                                                        RIGHT.company_address[1].company_predir, 
                                                                                        RIGHT.company_address[1].company_prim_name,
                                                                                        RIGHT.company_address[1].company_addr_suffix, 
                                                                                        RIGHT.company_address[1].company_postdir, '', ''), LEFT.Bus_Street_Address1);
                     SELF.Bus_City            := IF(UseBest,RIGHT.company_address[1].company_p_city_name, LEFT.Bus_City);
                     SELF.Bus_State           := IF(UseBest,RIGHT.company_address[1].company_st, LEFT.Bus_State);
                     SELF.Bus_Zip             := IF(UseBest,RIGHT.company_address[1].company_zip5, LEFT.Bus_Zip);

                     SELF                     := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

      
      //GET Person Best Record for Auth Rep1

    Rep_LexIDs := PROJECT(Input(Rep_1_LexID<>0), TRANSFORM(Doxie.layout_references, SELF.DID := LEFT.Rep_1_LexID)) + 
                  PROJECT(Input(Rep_2_LexID<>0), TRANSFORM(Doxie.layout_references, SELF.DID := LEFT.Rep_2_LexID)) +
                  PROJECT(Input(Rep_3_LexID<>0), TRANSFORM(Doxie.layout_references, SELF.DID := LEFT.Rep_3_LexID));
                  
    Unique_Rep_LexIDs := DEDUP(SORT(Rep_LexIDs, DID), DID);
    
		  authRep_BestRecs := doxie.best_records(Unique_Rep_LexIDs,
                                             FALSE,  // IsFCRA
                                             FALSE,  // doSuppress
                                             FALSE,  // doTimeZone
                                             FALSE,  // useNonBlankKey
                                             FALSE,  // checkRNA
                                             FALSE,  // includeDOD
                                             FALSE,  // include_minors
                                             FALSE,   // getSSNBest
                                             mod_access
                                            );

       
      ds_SBA_Company_add_Rep1Info  :=  
        JOIN(ds_SBA_InputFromSeleID, authRep_BestRecs, 
                    LEFT.Rep_1_LexID = RIGHT.DID AND LEFT.Rep_1_LexID > 0,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.InputwSeq,
                     Rep1_Matched := RIGHT.DID > 0;
                     SELF.Rep_1_First_Name      := IF(Rep1_Matched, RIGHT.fname, LEFT.Rep_1_First_Name);
                     SELF.Rep_1_Middle_Name     := IF(Rep1_Matched, RIGHT.mname, LEFT.Rep_1_Middle_Name);
                     SELF.Rep_1_Last_Name       := IF(Rep1_Matched, RIGHT.lname, LEFT.Rep_1_Last_Name);
                     SELF.Rep_1_Suffix          := IF(Rep1_Matched, RIGHT.name_suffix, LEFT.Rep_1_Suffix);
                     SELF.Rep_1_DOB             := IF(Rep1_Matched, (STRING8)RIGHT.DOB, LEFT.Rep_1_DOB);
                     SELF.Rep_1_SSN             := IF(Rep1_Matched, RIGHT.ssn, LEFT.Rep_1_SSN);
                     SELF.Rep_1_Street_Address1 := IF(Rep1_Matched, (STRING120) Address.Addr1FromComponents(RIGHT.prim_range, 
                                                                                           RIGHT.predir, 
                                                                                           RIGHT.prim_Name,
                                                                                           RIGHT.suffix, 
                                                                                           RIGHT.postdir, '', ''), LEFT.Rep_1_Street_Address1);  
                     SELF.Rep_1_City            := IF(Rep1_Matched, RIGHT.city_name, LEFT.Rep_1_City);
                     SELF.Rep_1_State           := IF(Rep1_Matched, RIGHT.st, LEFT.Rep_1_State);
                     SELF.Rep_1_Zip             := IF(Rep1_Matched, RIGHT.zip, LEFT.Rep_1_Zip);
                     SELF.Rep_1_Phone10         := IF(Rep1_Matched, RIGHT.phone, LEFT.Rep_1_Phone10);
                     SELF.Rep_1_Age             := IF(Rep1_Matched, (STRING3)RIGHT.age, LEFT.Rep_1_Age);
                     SELF.Rep_1_DL_Number       := IF(Rep1_Matched, RIGHT.dl_number, LEFT.Rep_1_DL_Number);
                  
                     SELF                       := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
      
      
      ds_SBA_Company_add_Rep2Info  :=  
        JOIN(ds_SBA_Company_add_Rep1Info, authRep_BestRecs, 
                    LEFT.Rep_2_LexID = RIGHT.DID AND LEFT.Rep_2_LexID > 0,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.InputwSeq,
                     Rep2_Matched := RIGHT.DID > 0;
                     SELF.Rep_2_First_Name      := IF(Rep2_Matched, RIGHT.fname, LEFT.Rep_2_First_Name);
                     SELF.Rep_2_Middle_Name     := IF(Rep2_Matched, RIGHT.mname, LEFT.Rep_2_Middle_Name);
                     SELF.Rep_2_Last_Name       := IF(Rep2_Matched, RIGHT.lname, LEFT.Rep_2_Last_Name);
                     SELF.Rep_2_Suffix          := IF(Rep2_Matched, RIGHT.name_suffix, LEFT.Rep_2_Suffix);
                     SELF.Rep_2_DOB             := IF(Rep2_Matched, (STRING8)RIGHT.DOB, LEFT.Rep_2_DOB);
                     SELF.Rep_2_SSN             := IF(Rep2_Matched, RIGHT.ssn, LEFT.Rep_2_SSN);
                     SELF.Rep_2_Street_Address1 := IF(Rep2_Matched, (STRING120) Address.Addr1FromComponents(RIGHT.prim_range, 
                                                                                           RIGHT.predir, 
                                                                                           RIGHT.prim_Name,
                                                                                           RIGHT.suffix, 
                                                                                           RIGHT.postdir, '', ''), LEFT.Rep_2_Street_Address1);  
                     SELF.Rep_2_City            := IF(Rep2_Matched, RIGHT.city_name, LEFT.Rep_2_City);
                     SELF.Rep_2_State           := IF(Rep2_Matched, RIGHT.st, LEFT.Rep_2_State);
                     SELF.Rep_2_Zip             := IF(Rep2_Matched, RIGHT.zip, LEFT.Rep_2_Zip);
                     SELF.Rep_2_Phone10         := IF(Rep2_Matched, RIGHT.phone, LEFT.Rep_2_Phone10);
                     SELF.Rep_2_Age             := IF(Rep2_Matched, (STRING3)RIGHT.age, LEFT.Rep_2_Age);
                     SELF.Rep_2_DL_Number       := IF(Rep2_Matched, RIGHT.dl_number, LEFT.Rep_2_DL_Number);
                     SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

      ds_SBA_Company_add_Rep3Info  :=  
        JOIN(ds_SBA_Company_add_Rep2Info, authRep_BestRecs, 
                    LEFT.Rep_3_LexID = RIGHT.DID AND LEFT.Rep_3_LexID > 0,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.InputwSeq,
                     Rep3_Matched := RIGHT.DID > 0;
                     SELF.Rep_3_First_Name      := IF(Rep3_Matched, RIGHT.fname, LEFT.Rep_3_First_Name);
                     SELF.Rep_3_Middle_Name     := IF(Rep3_Matched, RIGHT.mname, LEFT.Rep_3_Middle_Name);
                     SELF.Rep_3_Last_Name       := IF(Rep3_Matched, RIGHT.lname, LEFT.Rep_3_Last_Name);
                     SELF.Rep_3_Suffix          := IF(Rep3_Matched, RIGHT.name_suffix, LEFT.Rep_3_Suffix);
                     SELF.Rep_3_DOB             := IF(Rep3_Matched, (STRING8)RIGHT.DOB, LEFT.Rep_3_DOB);
                     SELF.Rep_3_SSN             := IF(Rep3_Matched, RIGHT.ssn, LEFT.Rep_3_SSN);
                     SELF.Rep_3_Street_Address1 := IF(Rep3_Matched, (STRING120) Address.Addr1FromComponents(RIGHT.prim_range, 
                                                                                           RIGHT.predir, 
                                                                                           RIGHT.prim_Name,
                                                                                           RIGHT.suffix, 
                                                                                           RIGHT.postdir, '', ''), LEFT.Rep_3_Street_Address1);  
                     SELF.Rep_3_City            := IF(Rep3_Matched, RIGHT.city_name, LEFT.Rep_3_City);
                     SELF.Rep_3_State           := IF(Rep3_Matched, RIGHT.st, LEFT.Rep_3_State);
                     SELF.Rep_3_Zip             := IF(Rep3_Matched, RIGHT.zip, LEFT.Rep_3_Zip);
                     SELF.Rep_3_Phone10         := IF(Rep3_Matched, RIGHT.phone, LEFT.Rep_3_Phone10);
                     SELF.Rep_3_Age             := IF(Rep3_Matched, (STRING3)RIGHT.age, LEFT.Rep_3_Age);
                     SELF.Rep_3_DL_Number       := IF(Rep3_Matched, RIGHT.dl_number, LEFT.Rep_3_DL_Number);   
                     SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
                                  
                                  
    // OUTPUT(ds_SBA_Company_add_Rep3Info, NAMED('ds_SBA_Company_add_Rep3Info'));
    RETURN ds_SBA_Company_add_Rep3Info;

  END;