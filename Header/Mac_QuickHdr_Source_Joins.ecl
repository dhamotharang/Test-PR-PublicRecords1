EXPORT Mac_QuickHdr_Source_Joins(dInFile,pSourcesIndex,pSources,mod_access) :=
FUNCTIONMACRO
  IMPORT bankruptcyv2_services, doxie_crs, doxie_raw, drivers, DriversV2, ExperianCred, Header, mdr, ut,
         vehiclev2_services, liensv2_services, Header_Quick, LN_PropertyV2_Services, DriversV2_Services;
  
  // uses maxlength of the report to match the other source doc layouts 
  lRID_Layout := RECORD,MAXLENGTH(doxie_crs.maxlength_report)
   UNSIGNED6 did;
   UNSIGNED6 rid;
   Header.Layout_HeaderSource;
  END;
  
  kQHSrcIndex  := #EXPAND(pSourcesIndex + '(TRUE,FALSE)');
  kHdrSrcIndex := #EXPAND(pSourcesIndex + '(FALSE,FALSE)');
  
  STRING2 srcAllDLs := 'DL';
  STRING2 srcAllVeh := 'VH';
  SET OF STRING2 setPropAssess := [MDR.sourceTools.src_Fares_Deeds_from_Asrs,MDR.sourceTools.src_LnPropV2_Lexis_Asrs];
  SET OF STRING3 setPropDeeds  := [MDR.sourceTools.src_LnPropV2_Fares_Deeds,MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs];
  
  // Join to the quick header DID payload key to get the date first/last seen for use in the transform
  rRIDSrcID_Layout :=
  RECORD(Header.Layout_RID_SrcID)
    UNSIGNED6 did;
  END;
  
  dRIDs := PROJECT(dInFile,rRIDSrcID_Layout);
  
  // Date first/last seen dates are only populated for the most recent record for the respective DID
  dQHPayload := JOIN( dRIDs,Header_Quick.Key_DID,
                      LEFT.rid >= Header.constants.QH_start_rid AND
                      (LEFT.src = MDR.sourceTools.src_Equifax OR (LEFT.src = MDR.sourceTools.src_Equifax_Weekly AND ~doxie.DataRestriction.WH)) AND
                      KEYED(LEFT.did = RIGHT.did) AND
                      RIGHT.src IN [MDR.sourceTools.src_Equifax_Quick,MDR.sourceTools.src_Equifax_Weekly]  AND
                      RIGHT.dt_last_seen > 0,
                      LIMIT(ut.limits.DEFAULT,SKIP));
  
  // Common transform for both header and quick header source joins
  lRID_Layout tSourceInfo(dInFile le,kHdrSrcIndex ri) :=
  TRANSFORM
    // Bankruptcies
    #IF(MDR.sourceTools.src_Bankruptcy IN pSources)
      SELF.bk_child    := PROJECT(doxie_raw.bk_legacy_raw(doxie_raw.ds_EmptyDIDs,
                                                          doxie_raw.ds_EmptyBDIDs,
                                                          PROJECT(ri.bk_child,
                                                                  TRANSFORM(bankruptcyv2_services.layout_tmsid_ext,
                                                                            SELF.isdeepdive := FALSE,
                                                                            SELF            := LEFT))),
                                  doxie.Layout_BK_output);
      SELF.bk_V2_child := doxie_raw.bkV2_raw( doxie_raw.ds_EmptyDIDs,
                                              doxie_raw.ds_EmptyBDIDs,
                                              PROJECT(ri.bk_child,
                                                      TRANSFORM(bankruptcyv2_services.layout_tmsid_ext,
                                                      SELF.isdeepdive := FALSE,
                                                      SELF            := LEFT)));
    
    // DL's
    #ELSEIF(srcAllDLs IN pSources)
      drivers.layout_dl tDLssn(DriversV2.Layout_DL pInput) :=
      TRANSFORM
        SELF.ssn      := IF(mod_access.dppa NOT IN [1,4,6],'',IF((INTEGER)pInput.ssn_safe=0,'',pInput.ssn_safe));
        SELF.ssn_safe := IF(mod_access.dppa NOT IN [1,4,6],'',IF((INTEGER)pInput.ssn_safe=0,'',pInput.ssn_safe));
        SELF          := pInput;
      END;
      
      SELF.dl_child     := PROJECT(ri.dl_child,tDLssn(LEFT));
      SELF.dl2_child    := doxie_Raw.DLV2_Raw(doxie_raw.ds_EmptyDIDs,
                                              DATASET([], DriversV2_Services.layouts.snum),
                                              PROJECT(ri.dl_child,
                                                      TRANSFORM(DriversV2_Services.layouts.src,
                                                                SELF := LEFT,
                                                                SELF := [])));
    
    // Equifax
    #ELSEIF(MDR.sourceTools.src_Equifax IN pSources OR MDR.sourceTools.src_Equifax_Weekly IN pSources)
      dQHPayloadFilter := dQHPayload(did = le.did AND rid = le.rid);
      rowQH := dQHPayloadFilter[1]; //dQHPayloadFilter contains only one row
      
      SELF.eq_child := PROJECT(ri.eq_child,
                                TRANSFORM (Header.Layout_EQ_src_dates,
                                            SELF.date_first_seen := IF(EXISTS(dQHPayloadFilter),(STRING)rowQH.dt_first_seen,'');
                                            SELF.date_last_seen  := IF(EXISTS(dQHPayloadFilter),(STRING)rowQH.dt_last_seen,'');
                                            SELF                 := LEFT));
    
    // Experian credit header
    #ELSEIF(MDR.sourceTools.src_Experian_Credit_Header IN pSources)
      SELF.en_child := PROJECT(ri.experian_child,ExperianCred.Layouts.Layout_SourceDoc);
    
    // Liens V2
    #ELSEIF(MDR.sourceTools.src_Liens_v2 IN pSources)
      SELF.lien_V2_child := doxie_raw.LiensV2_raw(doxie_raw.ds_EmptyDIDs,
                                                  doxie_raw.ds_EmptyBDIDs,
                                                  PROJECT(ri.lienv2_child,liensv2_services.layout_tmsid),,,,,,,,,,,,,mod_access.application_type);
    
    // Property assessments
    #ELSEIF(MDR.sourceTools.src_LnPropV2_Fares_Asrs IN pSources OR MDR.sourceTools.src_LnPropV2_Lexis_Asrs IN pSources)
      SELF.asses_child  := ri.asses_child;
    
    // Property deeds
    #ELSEIF(MDR.sourceTools.src_LnPropV2_Fares_Deeds IN pSources OR MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs IN pSources)
      SELF.deeds_child  := ri.deeds_child;
    
    // Vehicles
    #ELSEIF(srcAllVeh IN pSources)
      SELF.veh_child    := doxie_raw.veh_legacy_raw(PROJECT(ri.veh_child, vehiclev2_services.layout_vehicle_key),mod_access.date_threshold,mod_access.dppa,mod_access.glb,IncludeNonRegulatedVehicleSources);
      SELF.veh_v2_child := doxie_raw.VehV2_raw( doxie_raw.ds_EmptyDIDs,
                                                doxie_raw.ds_EmptyBDIDs,
                                                PROJECT(ri.veh_child,vehiclev2_services.layout_vehicle_key));
    
    // Transunion credit header
    #ELSEIF(MDR.sourceTools.src_TU_CreditHeader IN pSources)
      SELF.tn_child := ri.tn_child;
    #END
    SELF := le;
  END;
  
  // Header rid source join
  dHdrRidsSrcJoin := JOIN(dInFile(rid < Header.constants.QH_start_rid),
                          kHdrSrcIndex,
                            #IF(MDR.sourceTools.src_Equifax IN pSources OR MDR.sourceTools.src_Equifax_Weekly IN pSources)
                              (LEFT.src = MDR.sourceTools.src_Equifax OR (LEFT.src = MDR.sourceTools.src_Equifax_Weekly AND ~doxie.DataRestriction.WH)) AND
                              KEYED(LEFT.uid=RIGHT.uid),
                              tSourceInfo(LEFT,RIGHT),
                            #ELSE
                              KEYED(LEFT.uid=RIGHT.uid) AND
                              KEYED(LEFT.src=RIGHT.src),
                              tSourceInfo(LEFT,RIGHT),
                            #END
                          LEFT OUTER,
                          LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP));
  
  // Quick header rid source join
  dQHdrRidsSrcJoin := JOIN( dInFile(rid >= Header.constants.QH_start_rid),
                            kQHSrcIndex,
                            #IF(MDR.sourceTools.src_Equifax IN pSources OR MDR.sourceTools.src_Equifax_Weekly IN pSources)
                              (LEFT.src = MDR.sourceTools.src_Equifax OR (LEFT.src = MDR.sourceTools.src_Equifax_Weekly AND ~doxie.DataRestriction.WH)) AND
                              KEYED(LEFT.uid=RIGHT.uid),
                              tSourceInfo(LEFT,RIGHT),
                            #ELSE
                              KEYED(LEFT.uid=RIGHT.uid) AND
                              KEYED(LEFT.src=RIGHT.src),
                              tSourceInfo(LEFT,RIGHT),
                            #END
                            LEFT OUTER,
                            LIMIT(ut.limits.CRS_SOURCE_COUNT.DEFAULT,SKIP));
  
  // Merge the results
  dRidsSrcInfo := dHdrRidsSrcJoin + dQHdrRidsSrcJoin;
  
  // PropertyV2 is not contained in a single key, so we have to build a dataset to simulate one
  LN_PropertyV2_Services.SourceTools.l_in tPropIn(lRID_Layout pInput) :=
  TRANSFORM
    // child dataset contains only one row
    d_fid := pInput.deeds_child[1].ln_fares_id;
    a_fid := pInput.asses_child[1].ln_fares_id;
    
    SELF.ln_fares_id := if(pInput.src IN setPropDeeds,d_fid,a_fid);
    SELF             := pInput;
  END;

  dProp2In := PROJECT(dRidsSrcInfo(src IN MDR.sourceTools.set_lnpropertyV2),tPropIn(LEFT));
  
  dProp2SrcRecs := LN_PropertyV2_Services.SourceTools.get(dProp2In);
  
  BOOLEAN getProp2SourceInfo := MDR.sourceTools.src_LnPropV2_Fares_Asrs IN pSources OR
                                MDR.sourceTools.src_LnPropV2_Lexis_Asrs IN pSources OR
                                MDR.sourceTools.src_LnPropV2_Fares_Deeds IN pSources OR
                                MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs IN pSources;
  
  lRID_Layout tProperty2SourceInfo(dRidsSrcInfo le,dProp2SrcRecs ri) :=
  TRANSFORM
    SELF.asses2_child := ri.asses2_child;
    SELF.deeds2_child := ri.deeds2_child;
    SELF              := le;
  END;
  
  dProp2SourceInfo := JOIN( dRidsSrcInfo,
                            dProp2SrcRecs,
                            LEFT.src IN MDR.sourceTools.set_lnpropertyV2 AND
                            LEFT.uid = RIGHT.uid AND
                            LEFT.src = RIGHT.src,
                            tProperty2SourceInfo(LEFT,RIGHT),
                            LEFT OUTER,
                            LIMIT(0),KEEP(1));
  
  dRidsSrcInfoWithProp2 := IF(getProp2SourceInfo,dProp2SourceInfo,dRidsSrcInfo);
  
  // Debug
  // OUTPUT(dRIDs,NAMED('dRIDs'),EXTEND);
  // OUTPUT(dQHPayload,NAMED('dQHPayload'),EXTEND);
  // OUTPUT(dHdrRidsSrcJoin,NAMED('dHdrRidsSrcJoin'),EXTEND);
  // OUTPUT(dQHdrRidsSrcJoin,NAMED('dQHdrRidsSrcJoin'),EXTEND);
  // OUTPUT(dRidsSrcInfo,NAMED('dRidsSrcInfo'),EXTEND);
  // OUTPUT(dProp2In,NAMED('dProp2In'),EXTEND);
  // OUTPUT(dProp2SrcRecs,NAMED('dProp2SrcRecs'),EXTEND);
  // OUTPUT(dProp2SourceInfo,NAMED('dProp2SourceInfo'),EXTEND);
  
  RETURN dRidsSrcInfoWithProp2;
ENDMACRO;