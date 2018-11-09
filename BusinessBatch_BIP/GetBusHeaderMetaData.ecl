IMPORT BIPV2,Business_Risk_BIP, BusinessBatch_BIP, Codes, MDR, STD, TopBusiness_BIPV2;
EXPORT GetBusHeaderMetaData := MODULE

  SHARED Rec_top3LinkIds  := RECORD
    UNSIGNED6 ULTID;
    UNSIGNED6 ORGID;
    UNSIGNED6 SELEID;		
  END;
	
	SHARED acctnoLayout := RECORD
    STRING20 acctno;
	END;
	
	SHARED rec_DBALayoutSlim := RECORD
		Rec_top3LinkIds;
		STRING120 DBA_name;
		String2 SOURCE;
		STRING50  Business_Status;
	END;
	
  SHARED rec_DBALayout := RECORD
    Rec_top3LinkIds;
    STRING50  Business_Status;
    STRING120 dba_name_var1 := '';
    STRING120 dba_name_var2 := '';
    STRING120 dba_name_var3 := '';
    STRING120 dba_name_var4 := '';
    STRING120 dba_name_var5 := '';
    STRING120 dba_name_var6 := '';
    STRING120 dba_name_var7 := '';
    STRING120 dba_name_var8 := '';
    STRING120 dba_name_var9 := '';
    STRING120 dba_name_var10 := '';				
		unsigned4 dt_last_seen;
	END;
	
	SHARED rec_SicCodeLayout1 := RECORD
    acctnoLayout;
    Rec_top3LinkIds;
    STRING8  siccode;
    STRING120 sicCodeDescription;
    UNSIGNED4 cnt;
	END;

  SHARED rec_NAICSCodeLayout1 := RECORD
    acctnoLayout;
    Rec_top3LinkIds;
    STRING8  NAICScode;
    STRING120 NAICSCodeDescription;
    UNSIGNED4 cnt;		 
  END;
	
  SHARED rec_SicCodeLayout := RECORD
     Rec_top3LinkIds;
		 STRING8  BestSicCode := '';
		 STRING80 BestSicDescription := '';
		 STRING8  sic_code_var1 := '';
		 STRING80 SIC_Description_var1 := '';
		 STRING8  sic_code_var2 := '';
		 STRING80 SIC_Description_var2 := '';
		 STRING8  sic_code_var3 := '';
		 STRING80 SIC_Description_var3 := '';
		 STRING8  sic_code_var4 := '';
     STRING80 SIC_Description_var4 := '';
		 STRING8  sic_code_var5 := '';
		 STRING80 SIC_Description_var5 := '';
		 STRING8  sic_code_var6 := '';
		 STRING80 SIC_Description_var6 := '';
		 STRING8  sic_code_var7 := '';
		 STRING80 SIC_Description_var7 := '';
		 STRING8  sic_code_var8 := '';
		 STRING80 SIC_Description_var8 := '';
		 STRING8  sic_code_var9 := '';
		 STRING80 SIC_Description_var9 := '';		
  END;
	
  SHARED rec_NAICSCodeLayout := RECORD
     Rec_top3LinkIds;
		 STRING8   BestNaicsCode := '';
		 STRING120 BestNaicsDescription := '';
		 STRING8   naics_code_var1 := '';
		 STRING120 naics_description_var1 := '';
		 STRING8   naics_code_var2 := '';
		 STRING120 naics_description_var2 := '';
		 STRING8   naics_code_var3 := '';
		 STRING120 naics_description_var3 := '';
		 STRING8   naics_code_var4 := '';
		 STRING120 naics_description_var4 := '';
		 STRING8   naics_code_var5 := '';
		 STRING120 naics_description_var5 := '';
		 STRING8   naics_code_var6 := '';
		 STRING120 naics_description_var6 := '';
		 STRING8   naics_code_var7 := '';
		 STRING120 naics_description_var7 := '';
		 STRING8   naics_code_var8 := '';
		 STRING120 naics_description_var8 := '';
		 STRING8   naics_code_var9 := '';
		 STRING120 naics_description_var9 := '';
	END;
	
	SHARED rec_CodesLayout := RECORD
    acctnoLayout;
    rec_SicCodeLayout;
    rec_naicsCodeLayout - [ultid, orgid, seleid];		 
	END;
	
	SHARED rec_MetaDataLayout := RECORD
    acctnoLayout;
    rec_SicCodeLayout;
    rec_naicsCodeLayout - [ultid, orgid, seleid];	
    rec_DBALayout  - [ultid, orgid, seleid];	
	END;		 
	
  SHARED rec_SicCodeLayoutWAcctnoSlim := RECORD
    acctnoLayout;
    STRING120 dba_name;
    rec_SicCodeLayout;
    UNSIGNED4 dt_last_seen;
	END;

  EXPORT fullView(DATASET( BusinessBatch_BIP.Layouts.BestLayoutWithFeinVars) BatchInputIn,
                   BusinessBatch_Bip.iParam.BatchParams inMod) :=  MODULE

    CurDate := (STRING8)STD.Date.Today();
		 
    FETCH_LEVEL := BIPV2.IDconstants.Fetch_Level_SELEID;	
                   
    
    ds_recsLinkidsOnly := PROJECT(BatchInputIn
                                 ,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
                                             SELF := LEFT,
                                             SELF := []));													
    
    ds_LinkidsInWithAcctnoSorted := SORT(BatchInputIn, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), SELEID, RECORD);
    
    // filter out blank sic code and naics 
    // JIRA 10621 - conditionally filter out Experian Records
    ds_IndustryRecs := TopBusiness_BIPV2.Key_Industry_Linkids.KeyFetch(ds_recsLinkidsOnly, FETCH_LEVEL)
                       ( ( siccode <> '' OR naics <> '' ) AND 
                         ( IF(inMod.ExcludeExperian, source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source), TRUE)) );
                                                          
                                                          
    ds_IndustryRecsSicCode := ds_IndustryRecs(siccode <> '');
    ds_IndustryRecsNaicsCode := ds_IndustryRecs(naics <> '');
    
    ds_IndustryRecsSicCodeStats := SORT(TABLE(ds_IndustryRecsSicCode, {ultid, orgid, seleid,siccode, UNSIGNED2 cnt:= COUNT(GROUP)},
                                         ultid, orgid, seleid,siccode), seleid, -cnt);
                                               
    // NOTE: we only output NAICS code if we have a description for it.  Thus when debugging some of these
    // NACIS codes are ignored 
    ds_IndustryRecsNAICSCodeStats := SORT(TABLE(ds_IndustryRecsNaicsCode, {ultid, orgid, seleid,naics, UNSIGNED2 cnt:= COUNT(GROUP)},
                                           ultid, orgid, seleid, naics), seleid, -cnt);
																																											
    ds_IndustryRecsSicCodeLinkidsSlim := DEDUP(SORT(ds_IndustryRecsSicCode, #expand(BIPV2.IDmacros.mac_ListTop3Linkids())), 
                                                #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
    
    rec_layout_siccode := RECORD
      Rec_top3LinkIds;
      STRING4  siccode;
      STRING80 SICDescription;
      UNSIGNED4 cnt;
    END;			
	
    // per product for this service.  If we don't have a code then don't display the sic code
    // thus inner join by default.
    ds_sicCodeDescriptions := JOIN(ds_IndustryRecsSicCodeStats, Codes.Key_SIC4,
                                    LEFT.siccode = RIGHT.sic4_code,
                                    TRANSFORM(rec_layout_siccode,
                                              SELF.ultid          := LEFT.ULTID,
                                              SELF.orgid          := LEFT.ORGID,
                                              SELF.seleid         := LEFT.SELEID,
                                              SELF.CNT            := LEFT.CNT,
                                              SELF.siccode        := LEFT.siccode,                                             
                                              SELF.sicdescription := STD.str.ToTitleCase(STD.str.ToLowerCase(RIGHT.SIC4_Description))),																							
                                    KEEP(1));
					 
    // add the linkids into the result set.
    // 
    //
    // ensure that we only display sic codes that we have descriptions for.
    ds_sicCodeWLinkIds := SORT(JOIN (ds_sicCodeDescriptions, ds_IndustryRecsSicCodeLinkidsSlim,
                                LEFT.ULTID = RIGHT.ULTID AND
                                LEFT.ORGID = RIGHT.ORGID AND
                                LEFT.SELEID = RIGHT.SELEID,			                                                     
                                TRANSFORM(rec_SicCodeLayout1,																                             
                                          SELF.siccode            := LEFT.sicCode,
                                          SELF.siccodedescription := LEFT.sicDescription,
                                          SELF.cnt := LEFT.cnt,
                                          SELF.Acctno := '',
                                          SELF := RIGHT)), // copies over the linkds (ult,org, sele) from left side.																			
                                SELEID, -CNT, RECORD);																	

    // and change rec_sicCodeLayout1 to have descriptions in there as well.
    //
    ds_IndustryRecsSicCodeLinkds :=  PROJECT(ds_IndustryRecsSicCodeLinkidsSlim,
                                              TRANSFORM(rec_SicCodeLayout,
                                                         SELF.ULTID := LEFT.ULTID,
                                                         SELF.ORGID := LEFT.ORGID,
                                                         SELF.SELEID := LEFT.SELEID,
                                                         SELF := []
                                                         ));
																								 
    rec_SicCodeLayout denormSic(rec_SicCodeLayout L, ds_sicCodeWLinkIds R, INTEGER C) := TRANSFORM
      SELF.BestSicCode :=  IF (C=1, R.siccode, L.BestSicCode);
      SELF.BestSicDescription := IF (C=1, R.SICCodeDescription, L.BestSicDescription);																		

      SELF.sic_code_var1 := IF (C=2, R.siccode, L.sic_code_var1);
      SELF.SIC_Description_var1 := IF (C=2, R.SICCodeDescription, L.SIC_Description_var1);

      SELF.sic_code_var2 := IF (C=3, R.siccode, L.sic_code_var2);
      SELF.SIC_Description_var2 := IF (C=3, R.SICCodeDescription, L.SIC_Description_var2);

      SELF.sic_code_var3 := IF (C=4, R.siccode, L.sic_code_var3);
      SELF.SIC_Description_var3 := IF (C=4, R.SICCodeDescription, L.SIC_Description_var3);

      SELF.sic_code_var4 := IF (C=5, R.siccode, L.sic_code_var4);
      SELF.SIC_Description_var4 := IF (C=5, R.SICCodeDescription, L.SIC_Description_var4);

      SELF.sic_code_var5 := IF (C=6, R.siccode, L.sic_code_var5);
      SELF.SIC_Description_var5 := IF (C=6, R.SICCodeDescription, L.SIC_Description_var5);

      SELF.sic_code_var6 := IF (C=7, R.siccode, L.sic_code_var6);
      SELF.Sic_Description_var6 := IF (C=7, R.SICCodeDescription, L.SIC_Description_var6);

      SELF.sic_code_var7 := IF (C=8, R.siccode, L.sic_code_var7);
      SELF.Sic_Description_var7 := IF (C=8, R.SICCodeDescription, L.SIC_Description_var7);

      SELF.sic_code_var8 := IF (C=9, R.siccode, L.sic_code_var8);
      SELF.Sic_Description_var8 := IF (C=9, R.SICCodeDescription, L.SIC_Description_var8);

      SELF.sic_code_var9 := IF (C=10, R.siccode, L.sic_code_var9);
      SELF.Sic_Description_var9 := IF (C=10, R.SICCodeDescription, L.SIC_Description_var9);
      SELF := L;																																																																						
    END;
		                                          
    ds_IndustryRecsDenormSicCode := DENORMALIZE(ds_IndustryRecsSicCodeLinkds,  ds_sicCodeWLinkIds,	                                         													 
	                                 BIPV2.IDmacros.mac_JoinTop3Linkids(),
																	 denormSic(LEFT,RIGHT,COUNTER));
    
    //////////////////////////////
    // now do work to get NAICS codes and descriptions.
    //////////////////////////////	                                   
																								
    ds_IndustryRecsNaicsCodeLinkidsSlim := DEDUP(SORT(ds_IndustryRecsNaicsCode, #expand(BIPV2.IDmacros.mac_ListTop3Linkids())), 
                                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));																																																		
    
    rec_layout_Naicscode := RECORD
      Rec_top3LinkIds;
      STRING6  NaicsCode;
      STRING80 NaicsDescription;
      UNSIGNED4 cnt;
    END;				
			
    // per product for this service.  If we don't have NAICS description then don't display the naics sic code
    // thus inner join by default.
    ds_NaicsCodeDescriptions := JOIN(ds_IndustryRecsNAICSCodeStats, Codes.Key_NAICS,
                                      LEFT.naics = RIGHT.NAICS_code,
                                      TRANSFORM(rec_layout_NaicsCode,
                                                SELF.ultid            := LEFT.ULTID,
                                                SELF.orgid            := LEFT.ORGID, 
                                                SELF.seleid           := LEFT.SELEID,																	
                                                SELF.CNT              := LEFT.cnt,
                                                SELF.NaicsCode        := LEFT.Naics,
                                                SELF.NAICSdescription := STD.str.ToTitleCase(STD.str.ToLowerCase(RIGHT.NAICS_Description))),
                                      KEEP(1));

    // ensure that we only display naics codes for naics codes we have descriptions for.				                                    
    ds_NaicsCodeWLinkIds := SORT(JOIN ( ds_NaicsCodeDescriptions, ds_IndustryRecsNaicsCodeLinkidsSlim,		
                                        LEFT.ULTID = RIGHT.ULTID AND
                                        LEFT.ORGID = RIGHT.ORGID AND
                                        LEFT.SELEID = RIGHT.SELEID,			                            			                             
                                        TRANSFORM(rec_NAICSCodeLayout1,																                              
                                                  SELF.NaicsCode        := LEFT.NaicsCode,
                                                  SELF.NaicsCodeDescription := LEFT.NaicsDescription,
                                                  SELF.cnt := LEFT.cnt,
                                                  SELF.Acctno := '',
                                                  SELF := RIGHT)),   // copies over the linkds (ult,org, sele) from RIGHT side.
                                  seleid, -cnt,RECORD);
																																																																																																				
    ds_IndustryRecsNAICSCodeLinkids := PROJECT(ds_IndustryRecsNaicsCodeLinkidsSlim,
                                                TRANSFORM(rec_NAICSCodeLayout,
                                                         SELF.ULTID := LEFT.ULTID,
                                                         SELF.ORGID := LEFT.ORGID,
                                                         SELF.SELEID := LEFT.SELEID,
                                                         SELF := []));
																								 
    rec_NAICSCodeLayout denormNaics(rec_NAICSCodeLayout L, ds_NaicsCodeWLinkIds R, INTEGER C) := TRANSFORM
      SELF.BestNaicsCode :=  IF (C=1, R.naicsCode, L.BestNaicsCode);
      SELF.BestNaicsDescription := IF (C=1, R.NAICSCodeDescription, L.BestNaicsDescription);																			
      SELF.naics_code_Var1 := IF (C=2, R.naicsCode, L.naics_code_var1);
      SELF.naics_description_var1 := IF (C=2, R.NaicsCodeDescription, L.Naics_Description_var1);
      SELF.naics_code_var2 := IF (C=3, R.naicsCode, L.naics_code_var2);
      SELF.naics_description_var2 := IF (C=3, R.NaicsCodeDescription, L.Naics_Description_var2);
      SELF.naics_code_var3 := IF (C=4, R.naicsCode, L.naics_code_var3);
      SELF.naics_description_var3 := IF (C=4, R.NaicsCodeDescription, L.Naics_Description_var3);
      SELF.naics_code_var4 := IF (C=5, R.naicsCode, L.naics_code_var4);
      SELF.naics_description_var4 := IF (C=5, R.NaicsCodeDescription, L.Naics_Description_var4);
      SELF.naics_code_var5 := IF (C=6, R.naicsCode, L.naics_code_var5);
      SELF.naics_description_var5 := IF (C=6, R.NaicsCodeDescription, L.Naics_Description_var5);
      SELF.naics_code_var6 := IF (C=7, R.naicsCode, L.naics_code_var6);
      SELF.naics_description_var6 := IF (C=7, R.NaicsCodeDescription, L.Naics_Description_var6);
      SELF.naics_code_var7 := IF (C=8, R.naicsCode, L.naics_code_var7);
      SELF.naics_description_var7 := IF (C=8, R.NaicsCodeDescription, L.Naics_Description_var7);
      SELF.naics_code_var8 := IF (C=9, R.naicsCode, L.naics_code_var8);
      SELF.naics_description_var8 := IF (C=9, R.NaicsCodeDescription, L.Naics_Description_var8);
      SELF.naics_code_var9 := IF (C=10, R.naicsCode, L.naics_code_var9);
      SELF.naics_description_var9 := IF (C=10, R.NaicsCodeDescription, L.Naics_Description_var9);
      SELF := L;																																																																						
    END;
	                                               
    ds_IndustryRecsDenormNAICSCode := DENORMALIZE(ds_IndustryRecsNAICSCodeLinkids,	                                          
                                                  ds_NaicsCodeWLinkIds,
                                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),	                                 
                                                  denormNaics(LEFT,RIGHT,COUNTER));
  
    // passing in param TRUE ,  removes all source = D recs from kfetch		
    // JIRA RR-10621 conditionally removing Experian based on inMod.ExcludeExperian boolean
    ds_busHeaderRecsSlim := BIPV2.Key_BH_Linking_Ids.kfetch(ds_recsLinkidsOnly,FETCH_LEVEL,,,
                                                            BusinessBatch_BIP.Constants.DEFAULTS.MaxBHLinkidsDBA
                                                            ,TRUE)(source <> MDR.sourceTools.src_Dunn_Bradstreet AND
                                                                   ( IF(inMod.ExcludeExperian, source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source), TRUE)));
		// slim layout before dedup/sort to reduce footprint.																															 
    ds_busHeaderRecsMetaDataSlimDBA := PROJECT(ds_busHeaderRecsSlim, TRANSFORM(rec_DBALayoutSlim, self.business_status := ''; SELF := LEFT));
		ds_busHeaderRecsMetaData := DEDUP(SORT (ds_busHeaderRecsMetaDataSlimDBA(dba_name <> '' AND source <> ''),
                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), dba_name,RECORD),
                                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), dba_name);
																		     																		 																		    		
    ds_busHeaderRecsLinkIDs := PROJECT(DEDUP(SORT(ds_busHeaderRecsSlim,
                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),                                           
																						  -dt_last_seen, -dt_vendor_last_reported, RECORD),
                                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
                                      TRANSFORM(rec_DBALayout,
                                         SELF.ultid := LEFT.ULTID,
                                         SELF.ORGID := LEFT.ORGID,
                                         SELF.SELEID := LEFT.SELEID,                                         
																				 // these mapping are done per jira RQ 12825
																				 // 'I' means inactive and if set that way in bip v2 bus header key 
																				 // then it means (dt_last_seen > current date - 2 years)
																		     SELF.Business_Status :=Map(
																									trim(LEFT.seleid_status_public,left,right) = 'I' //and ((unsigned4) (left.dt_last_seen) >  ((unsigned4) (curDate) - 00020000) ) 
																									                                                 => 'No Filings',
																									//trim(LEFT.seleid_status_public,left,right) = 'I' and ((unsigned4) (left.dt_last_seen) <  ((unsigned4) (curDate) - 00020000) )  => 'Inactive', 
																									trim(LEFT.seleid_status_public,left,right) = 'D' => 'Defunct',
																								  trim(LEFT.seleid_status_public,left,right) = ''  => 'Active',
																									''); 
                                              SELF := []));
																				
    rec_DBALayout denormDbaName(rec_DBALayout L, ds_busHeaderRecsMetaData  R, INTEGER C) := TRANSFORM																		
      SELF.dba_name_Var1 := IF (C=1, R.dba_name, L.dba_name_var1);
      SELF.dba_name_var2 := IF (C=2, R.dba_name, L.dba_name_var2);
      SELF.dba_name_var3 := IF (C=3, R.dba_name, L.dba_name_var3);
      SELF.dba_name_var4 := IF (C=4, R.dba_name, L.dba_name_var4);
      SELF.dba_name_var5 := IF (C=5, R.dba_name, L.dba_name_var5);
      SELF.dba_name_Var6 := IF (C=6, R.dba_name, L.dba_name_var6);
      SELF.dba_name_var7 := IF (C=7, R.dba_name, L.dba_name_var7);
      SELF.dba_name_var8 := IF (C=8, R.dba_name, L.dba_name_var8);
      SELF.dba_name_var9 := IF (C=9, R.dba_name, L.dba_name_var9);
      SELF.dba_name_var10 := IF (C=10, R.dba_name, L.dba_name_var10);
      SELF := L;																																																																						
    END;
		
    ds_BHRecsDenorm := DENORMALIZE( ds_busHeaderRecsLinkIDs,
                                    ds_busHeaderRecsMetaData, 
                                    BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                    denormDbaName(LEFT,RIGHT,COUNTER));																				
 																					                                      
    // joins to put the sic code information together with the DS that contains the acctno and....
    ds_SicCodeRecsWAcctno := JOIN(ds_LinkidsInWithAcctnoSorted, ds_IndustryRecsDenormSicCode,	                                                          
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  TRANSFORM(rec_SicCodeLayoutWAcctnoSlim,
                                            SELF.acctno := LEFT.acctno,
																						SELF := LEFT,
                                            SELF := RIGHT,
                                            SELF := []), LEFT OUTER);
																		
    // the join to add in the naics code to the previous DS																		
    ds_AllCodesRecsWAcctno := JOIN(ds_SicCodeRecsWAcctno,  ds_IndustryRecsDenormNAICSCode,
	                                BIPV2.IDmacros.mac_JoinTop3Linkids(),
																	TRANSFORM(rec_CodesLayout,
                                            SELF.acctno := LEFT.acctno,
                                            SELF := LEFT,
                                            SELF := RIGHT,
                                            SELF := []), LEFT OUTER);
   																		
    ds_allMetadata := JOIN(ds_AllCodesRecsWAcctno,  ds_BHRecsDenorm,
                            BIPV2.IDmacros.mac_JoinTop3Linkids(),
                            TRANSFORM(rec_MetaDataLayout, 
                                      SELF.acctno := LEFT.acctno;
                                      SELF := LEFT,
                                      SELF := RIGHT,
                                      SELF := []), LEFT OUTER);  			
    
    // set all the fields in here
    // join back to the acctno at the end.
	 ds_resultsTmp := PROJECT(JOIN(BatchInputIn,  ds_allMetadata,
                                      LEFT.acctno = RIGHT.acctno AND
                                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                      TRANSFORM(BusinessBatch_BIP.Layouts.BusHeaderMetaDataTmp,
                                                SELF.best_sic_code := RIGHT.BestSicCode,
                                                SELF.Best_sic_description := RIGHT.BestSicDescription,
                                                SELF.Best_Naics_code := RIGHT.BestNaicsCode,
                                                SELF.Best_Naics_description := RIGHT.BestNaicsDescription,
                                                SELF := LEFT,
                                                SELF := RIGHT,
                                                SELF := []),
                                      LEFT OUTER),                                
                            BusinessBatch_BIP.Layouts.BusHeaderMetaDataFinal);	  	
										 
		// output(BatchInputIn, named('BatchInputIn'));
		 //output(ds_LinkidsInWithAcctnoSorted, named('ds_LinkidsInWithAcctnoSorted'));
		// output(ds_BusHeaderRecs, named('ds_BusHeaderRecs'));
		// output(ds_busHeaderREcsNew, named('ds_bushederRecsnew'));
		// output(ds_BusHeaderRecsDBASicCode, named('ds_BusHeaderRecsDBASicCode'));
		// output(ds_BusHeaderRecsWAcctno, named('ds_BusHeaderRecsWAcctno'));	
		// output(ds_BusHeaderRecsWAcctnoSlim, named('ds_BusHeaderRecsWAcctnoSlim'));
		// output(ds_BHSLim, named('ds_BHSlim'));
		//output(BusHeaderMetaDataOut, named('BusHeaderMetaDataOut'));
		// output(ds_nameAddressOut, named('ds_name_addressOut'));
		// output(ds_IndustryRecs, named('ds_IndustryRecs'));
		// output(ds_IndustryRecsSicCodeStats, named('ds_IndustryRecsSicCodeStats'));
		// output(ds_sicCodeDescriptions , named('ds_sicCodeDescriptions'));


		// output(ds_IndustryRecsNaicsCodeStats, named('ds_IndustryRecsNaicsCodeStats'));
		// output(ds_IndustryRecsSicCodeSlim, named('ds_IndustryRecsSicCodeSlim'));

		// output(ds_IndustryRecsSicCodeLinkds, named('ds_IndustryRecsSicCodeLinkds'));
		// output(ds_sicCodeWLinkIds, named('ds_sicCodeWLinkIds'));
		// output(ds_IndustryRecsSicCodeSlimWAcctno, named('ds_IndustryRecsSicCodeSlimWAcctno'));
		//output(ds_IndustryRecsDenormSicCode, named('ds_IndustryRecsDenormSicCode'));
		// output(ds_IndustryRecsSicCodeSlim, named('ds_IndustryRecsSicCodeSlim'));
		// output(ds_IndustryRecsSicCodeSlimWAcctno, named('ds_IndustryRecsSicCodeSlimWAcctno'));
		// output(ds_IndustryRecsNAICSCodeSlim, named('ds_IndustryRecsNAICSCodeSlim'));
		// output(ds_IndustryRecsNAICSCodeLinkids, named('ds_IndustryRecsNAICSCodeLinkids'));
   //output(ds_busHeaderRecsLinkIDs , named('ds_busHeaderRecsLinkIDs'));
	 //output(ds_BHRecsDenorm, named('ds_BHRecsDenorm'));
		// output(ds_IndustryRecsNAICSCodeSlimWAcctno, named('ds_IndustryRecsNAICSCodeSlimWAcctno'));
		// output(ds_NaicsCodeDescriptions, named('ds_NaicsCodeDescriptions'));
		// output(ds_NaicsCodeDescriptions, named('ds_NaicsCodeDescriptions'));
		// output(ds_NaicsCodeWLinkIds, named('ds_NaicsCodeWLinkIds'));
		//output(ds_IndustryRecsDenormSicCode, named('ds_IndustryRecsDenormSicCode'));
		//output(ds_IndustryRecsDenormNAICSCode, named('ds_IndustryRecsDenormNAICSCode'));
		//output(ds_busHeaderRecsSlim, named('ds_busHeaderRecsSlim'));
		// output(count(ds_busHeaderRecsLinkIDs(business_status != '')),named('cnt_ds_busHeaderRecsLinkIDs'));
		// output(ds_IndustryRecsDenorm, named('ds_IndustryRecsDenorm'));
	 //output(ds_SicCodeRecsWAcctno, named('ds_SicCodeRecsWAcctno'));

		// output(ds_AllCodesRecsWAcctno, named('ds_AllCodesRecsWAcctno'));
		// output(ds_allMetadata, named('ds_allMetadata'));
	//output(ds_resultsTmp, named('ds_resultsTmp'));
    
    EXPORT ds_results := ds_resultsTmp;
  END;
END;