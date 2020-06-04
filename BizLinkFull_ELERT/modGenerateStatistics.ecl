IMPORT STD AS pkgSTD;
EXPORT modGenerateStatistics(STRING sVersion, STRING sInPrefix = '', STRING sEmailTo, DATASET(modLayouts.profileRec) dProfile, UNSIGNED iExpireTime, DATASET(modLayouts.lHyperlinkProfile) dHyperLinkProfile, BOOLEAN bRunBaseline, STRING sMode, BOOLEAN bStatsProxidLevel=TRUE) := MODULE
   //Change Field names to match your data. -ZRS 4/8/2019    
  Export lJoinedRec := RECORD
    BIzLinkFull_ELERT.modLayouts.lSampleLayout;
    
    //ORIG Data
    UNSIGNED  iTimestampOrig;
    UNSIGNED  iProxidInOrig;
    UNSIGNED  iProxidOutOrig;
    UNSIGNED  iSeleidInOrig;
    UNSIGNED  iSeleidOutOrig;
    UNSIGNED  iOrgidInOrig;
    UNSIGNED  iOrgidOutOrig;
    UNSIGNED  iUltidInOrig;
    UNSIGNED  iUltidOutOrig;
    // UNSIGNED  iDidXlinkDistanceOrig;
    // STRING    sDidXlinkMatchDetailOrig;
    // UNSIGNED  iDidXlinkKeysUsedOrig;
    // UNSIGNED  iDidXlinkKeysFailedOrig;
    UNSIGNED  iProxXlinkWeightOrig;
    UNSIGNED  iProxXlinkScoreOrig;
    UNSIGNED  iSeleXlinkWeightOrig;
    UNSIGNED  iSeleXlinkScoreOrig;
    UNSIGNED  iOrgXlinkWeightOrig;
    UNSIGNED  iOrgXlinkScoreOrig;
    UNSIGNED  iUltXlinkWeightOrig;
    UNSIGNED  iUltXlinkScoreOrig;
    // STRING    sDidXlinkSegmentationOrig;
    // BOOLEAN   bDidXlinkAmbiguousOrig;
    // BOOLEAN   bDidXlinkTooManyResultsOrig;
    // BOOLEAN   bDidXlinkUsedSegmentationOrig;
    STRING    sErrorCodeOrig;
    INTEGER  iCallLatencyOrig;
    
    //NEW Data
    UNSIGNED  iTimestampNew;    
    UNSIGNED  iProxidInNew;
    UNSIGNED  iProxidOutNew;
    UNSIGNED  iSeleidInNew;
    UNSIGNED  iSeleidOutNew;
    UNSIGNED  iOrgidInNew;
    UNSIGNED  iOrgidOutNew;
    UNSIGNED  iUltidInNew;
    UNSIGNED  iUltidOutNew;
    // UNSIGNED  iDidXlinkDistanceNew;
    // STRING    sDidXlinkMatchDetailNew;
    // UNSIGNED  iDidXlinkKeysUsedNew;
    // UNSIGNED  iDidXlinkKeysFailedNew;
    UNSIGNED  iProxXlinkWeightNew;
    UNSIGNED  iProxXlinkScoreNew;
    UNSIGNED  iSeleXlinkWeightNew;
    UNSIGNED  iSeleXlinkScoreNew;
    UNSIGNED  iOrgXlinkWeightNew;
    UNSIGNED  iOrgXlinkScoreNew;
    UNSIGNED  iUltXlinkWeightNew;
    UNSIGNED  iUltXlinkScoreNew;
    // STRING    sDidXlinkSegmentationNew;
    // BOOLEAN   bDidXlinkAmbiguousNew;
    // BOOLEAN   bDidXlinkTooManyResultsNew;
    // BOOLEAN   bDidXlinkUsedSegmentationNew;
    STRING    sErrorCodeNew;
    INTEGER  iCallLatencyNew;
    
    STRING sMeowServiceOrig;
    STRING sHeaderServiceOrig;
    STRING sMeowServiceNew;
    STRING sHeaderServiceNew;
  END;

  SHARED lJoinedRec tJoinedTrans(modLayouts.lSampleLayout rOrig, modLayouts.lSampleLayout rNew, DATASET(modLayouts.lHyperlinkProfile) dHyperLinkProfile) := TRANSFORM
    rData := IF(rNew.uniqueID=0,rOrig,rNew);

    //ORIG Data
    SELF.iTimestampOrig := rOrig.timestamp;
    SELF.iProxidInOrig := 0;
    SELF.iProxidOutOrig := rOrig.proxid;
    SELF.iSeleidInOrig := 0;
    SELF.iSeleidOutOrig := rOrig.seleid;
    SELF.iOrgIdInOrig := 0;
    SELF.iOrgIdOutOrig := rOrig.orgid;
    SELF.iUltIdInOrig := 0;
    SELF.iUltIdOutOrig := rOrig.ultid;
    // SELF.iDidXlinkDistanceOrig := rOrig.lnpid_xlink_distance;
    // SELF.sDidXlinkMatchDetailOrig := rOrig.lnpid_xlink_matchdetail;
    // SELF.iDidXlinkKeysUsedOrig := rOrig.lnpid_xlink_keysused;
    // SELF.iDidXlinkKeysFailedOrig := rOrig.lnpid_xlink_keysfailed;
    SELF.iProxXlinkWeightOrig := rOrig.proxweight;
    SELF.iProxXlinkScoreOrig  := rOrig.proxscore;    
		SELF.iSeleXlinkWeightOrig := rOrig.seleweight;
    SELF.iSeleXlinkScoreOrig  := rOrig.selescore;
		SELF.iOrgXlinkWeightOrig  := rOrig.orgweight;
    SELF.iOrgXlinkScoreOrig   := rOrig.orgscore;
		SELF.iUltXlinkWeightOrig  := rOrig.ultweight;
    SELF.iUltXlinkScoreOrig   := rOrig.ultscore;
    // SELF.sDidXlinkSegmentationOrig := rOrig.lnpid_xlink_segmentation;
    // SELF.bDidXlinkAmbiguousOrig := rOrig.lnpid_xlink_ambiguous;
    // SELF.bDidXlinkTooManyResultsOrig := rOrig.lnpid_xlink_toomanyresults;
    // SELF.bDidXlinkUsedSegmentationOrig := rOrig.lnpid_xlink_usedsegmentation;
    SELF.sErrorCodeOrig := rOrig.errorcode;
    SELF.sErrorCodeNew := rNew.errorcode;
    SELF.iCallLatencyOrig := rOrig.transaction_time;
    SELF.iCallLatencyNew := rNew.transaction_time;
    
    //NEW Data
    SELF.iTimestampNew := rNew.timestamp;
    SELF.iProxidInNew := 0;
    SELF.iProxidOutNew := rNew.proxid;
    SELF.iSeleidInNew := 0;
    SELF.iSeleidOutNew := rNew.seleid;
    SELF.iOrgIdInNew := 0;
    SELF.iOrgIdOutNew := rNew.orgid;
    SELF.iUltIdInNew := 0;
    SELF.iUltIdOutNew := rNew.ultid;
    SELF.iProxXlinkWeightNew := rNew.proxweight;
    SELF.iProxXlinkScoreNew  := rNew.proxscore;    
		SELF.iSeleXlinkWeightNew := rNew.seleweight;
    SELF.iSeleXlinkScoreNew  := rNew.selescore;
		SELF.iOrgXlinkWeightNew  := rNew.orgweight;
    SELF.iOrgXlinkScoreNew   := rNew.orgscore;
		SELF.iUltXlinkWeightNew  := rNew.ultweight;
    SELF.iUltXlinkScoreNew   := rNew.ultscore;
		SELF                     := rnew;
		SELF                     := [];
  END;
  
  SHARED modLayouts.lStatsRec tGetStats(DATASET(lJoinedRec) dRows, UNSIGNED iVersion) := TRANSFORM
    dRowsNoError := dRows(sErrorCodeOrig = '' AND sErrorCodeNew = '');
    SELF.iTimestamp := iVersion;
    SELF.sSource := dRows[1].src_category; 
    SELF.iMode := dRows[1].mode;
    SELF.iCompareMode := dRows[1].compareMode;
    SELF.sDescription := dRows[1].description;    
    SELF.sProfileBucket := dRows[1].profile_Bucket;
    SELF.iTotalCnt := COUNT(dRowsNoError);
    SELF.iProdHits := IF(bStatsProxidLevel,COUNT(dRowsNoError(input_proxid<>0)),COUNT(dRowsNoError(input_seleid<>0)));  
    SELF.nProdHits := SELF.iProdHits/SELF.iTotalCnt*100;  
    SELF.iBaselineHits := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutOrig<>0)),COUNT(dRowsNoError(iSeleidOutOrig<>0)));
    SELF.nBaselineHits := SELF.iBaselineHits/SELF.iTotalCnt*100;
    SELF.iNewHits := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutNew<>0)),COUNT(dRowsNoError(iSeleidOutNew<>0)));
    SELF.nNewHits := SELF.iNewHits/SELF.iTotalCnt*100;
    SELF.iAllEqual := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutOrig=iProxidOutNew)),COUNT(dRowsNoError(iSeleidOutOrig=iSeleidOutNew)));
    SELF.nAllEqual := SELF.iAllEqual/SELF.iTotalCnt*100;
    SELF.iNoneEqual := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutOrig<>iProxidOutNew)),COUNT(dRowsNoError(iSeleidOutOrig<>iSeleidOutNew)));
    SELF.nNoneEqual := SELF.iNoneEqual/SELF.iTotalCnt*100;
    SELF.iEqualNonZero := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutOrig<>0 AND iProxidOutNew<>0 AND iProxidOutOrig=iProxidOutNew)),COUNT(dRowsNoError(iSeleidOutOrig<>0 AND iSeleidOutNew<>0 AND iSeleidOutOrig=iSeleidOutNew)));
    SELF.nEqualNonZero := SELF.iEqualNonZero/SELF.iTotalCnt*100;
    SELF.iDiffNonZero := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutOrig<>0 AND iProxidOutNew<>0 AND iProxidOutOrig<>iProxidOutNew)),COUNT(dRowsNoError(iSeleidOutOrig<>0 AND iSeleidOutNew<>0 AND iSeleidOutOrig<>iSeleidOutNew)));
    SELF.nDiffNonZero := SELF.iDiffNonZero/SELF.iTotalCnt*100;
    SELF.iToZero := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutOrig<>0 AND iProxidOutNew=0)),COUNT(dRowsNoError(iSeleidOutOrig<>0 AND iSeleidOutNew=0)));
    SELF.nToZero := SELF.iToZero/SELF.iTotalCnt*100;
    SELF.iFromZero := IF(bStatsProxidLevel,COUNT(dRowsNoError(iProxidOutOrig=0 AND iProxidOutNew<>0)),COUNT(dRowsNoError(iSeleidOutOrig=0 AND iSeleidOutNew<>0)));
    SELF.nFromZero := SELF.iFromZero/SELF.iTotalCnt*100;
    // Orig Header Accuracy
    SELF.iHeaderOrigAccuracy := IF(bStatsProxidLevel, count(dRowsNoError(input_proxid != 0 AND iProxidOutOrig = input_proxid AND iProxidOutOrig != 0)), count(dRowsNoError(input_seleid != 0 AND iSeleidOutOrig = input_seleid AND iSeleidOutOrig != 0)));
    SELF.nHeaderOrigAccuracy := SELF.iHeaderOrigAccuracy/SELF.iBaselineHits*100;
    SELF.iHeaderOrigDiff := IF(bStatsProxidLevel, count(dRowsNoError(input_proxid != 0 and iProxidOutOrig != input_proxid and iProxidOutOrig != 0)), count(dRowsNoError(input_seleid != 0 and iSeleidOutOrig != input_seleid and iSeleidOutOrig != 0)));    
    SELF.nHeaderOrigDiff := SELF.iHeaderOrigDiff/SELF.iBaselineHits*100;
    // New Header Accuracy
    SELF.iHeaderNewAccuracy := IF(bStatsProxidLevel, count(dRowsNoError(input_proxid != 0 AND iProxidOutNew = input_proxid AND iProxidOutNew != 0)), count(dRowsNoError(input_seleid != 0 AND iSeleidOutNew = input_seleid AND iSeleidOutNew!= 0)));
    SELF.nHeaderNewAccuracy := SELF.iHeaderNewAccuracy/SELF.iNewHits*100;
    SELF.iHeaderNewDiff := IF(bStatsProxidLevel, count(dRowsNoError(input_proxid != 0 and iProxidOutNew != input_proxid and iProxidOutNew != 0)), count(dRowsNoError(input_seleid != 0 and iSeleidOutNew != input_seleid and iSeleidOutNew != 0)));    
    SELF.nHeaderNewDiff := SELF.iHeaderNewDiff/SELF.iNewHits*100;

    SELF.nBaselineLatency := AVE(dRowsNoError, iCallLatencyOrig);
    SELF.nNewLatency := AVE(dRowsNoError, iCallLatencyNew);
    //Only include examples where both old and new returned a value
    SELF.iErrorsOrig := COUNT(dRows(sErrorCodeOrig <> ''));
    SELF.nErrorsOrig := SELF.iErrorsOrig/COUNT(dRows)*100;
    SELF.iErrorsNew := COUNT(dRows(sErrorCodeNew <> ''));
    SELF.nErrorsNew := SELF.iErrorsNew/COUNT(dRows)*100;
  END;
  SHARED dOrigData    := DISTRIBUTE(modFiles(sInPrefix).dOrigResults,HASH(uniqueid))(uniqueid<>0);  
  SHARED dNewData     := DISTRIBUTE(modFiles(sInPrefix).dNewResults,HASH(uniqueid))(uniqueid<>0);    
  SHARED dJoined_pre  := DISTRIBUTE(JOIN(dOrigData,dNewData,LEFT.uniqueid=RIGHT.uniqueid AND LEFT.mode=RIGHT.mode AND LEFT.comparemode=RIGHT.comparemode AND LEFT.description=RIGHT.description AND LEFT.profile_bucket=RIGHT.profile_bucket,tJoinedTrans(LEFT,RIGHT,dHyperLinkProfile),FULL OUTER,LOCAL),HASH(profile_bucket,Mode)); 
  SHARED dJoined_base := DISTRIBUTE(JOIN(dOrigData,CHOOSEN(dNewData,0),LEFT.uniqueid=RIGHT.uniqueid AND LEFT.mode=RIGHT.mode AND LEFT.comparemode=RIGHT.comparemode AND LEFT.description=RIGHT.description AND LEFT.profile_bucket=RIGHT.profile_bucket,tJoinedTrans(LEFT,RIGHT,dHyperLinkProfile),FULL OUTER,LOCAL),HASH(profile_bucket,Mode)); 
  EXPORT dJoined      := IF(bRunBaseline,dJoined_base,dJoined_pre);
  
  EXPORT dStats := SORT(ROLLUP(GROUP(SORT(dJoined,profile_bucket,Mode,CompareMode,profile_bucket,LOCAL),profile_bucket,Mode,CompareMode,profile_bucket,LOCAL),GROUP,tGetStats(ROWS(LEFT),(UNSIGNED)sVersion)),sProfileBucket,iMode,iCompareMode);  
  
  SHARED dDiffNoneZero := IF(bStatsProxidLevel,dJoined(iProxidOutOrig<>0 AND iProxidOutNew<>0 AND iProxidOutOrig<>iProxidOutNew AND sErrorCodeOrig = '' AND sErrorCodeNew = ''),dJoined(iSeleidOutOrig<>0 AND iSeleidOutNew<>0 AND iSeleidOutOrig<>iSeleidOutNew AND sErrorCodeOrig = '' AND sErrorCodeNew = ''));
  SHARED dToZero := IF(bStatsProxidLevel,dJoined(iProxidOutOrig<>0 AND iProxidOutNew=0 AND sErrorCodeOrig = '' AND sErrorCodeNew = ''),dJoined(iSeleidOutOrig<>0 AND iSeleidOutNew=0 AND sErrorCodeOrig = '' AND sErrorCodeNew = ''));
  SHARED dFromZero := IF(bStatsProxidLevel,dJoined(iProxidOutOrig=0 AND iProxidOutNew<>0 AND sErrorCodeOrig = '' AND sErrorCodeNew = ''),dJoined(iSeleidOutOrig=0 AND iSeleidOutNew<>0 AND sErrorCodeOrig = '' AND sErrorCodeNew = ''));
  SHARED dToError := dJoined(sErrorCodeOrig = '' AND sErrorCodeNew <> '');
  SHARED dFromError := dJoined(sErrorCodeOrig <> '' AND sErrorCodeNew = '');
  SHARED dBothError := dJoined(sErrorCodeOrig <> '' AND sErrorCodeNew <> '');
  SHARED modLayouts.lReadableStatsRec fCreateCSVStats(modLayouts.lStatsRec dRec) := FUNCTION
    RETURN DATASET([{dRec.sProfileBucket,dRec.sDescription,''},
                  {'Total Cnts',(STRING)dRec.iTotalCnt,''},
                  {'Orig Append',(STRING)dRec.iBaselineHits,(STRING)dRec.nBaselineHits},
                  {'New Append',(STRING)dRec.iNewHits,(STRING)dRec.nNewHits},
                  {'All Equal',(STRING)dRec.iAllEqual,(STRING)dRec.nAllEqual},
                  {'Non-Equal',(STRING)dRec.iNoneEqual,(STRING)dRec.nNoneEqual},
                  {'Equal Non-Zero',(STRING)dRec.iEqualNonZero,(STRING)dRec.nEqualNonZero},
                  {'Diff Non-Zero',(STRING)dRec.iDiffNonZero,(STRING)dRec.nDiffNonZero},
                  {'To Zero',(STRING)dRec.iToZero,(STRING)dRec.nToZero},
                  {'Orig Latency',(STRING)dRec.nBaselineLatency,'ms'},
                  {'New Latency',(STRING)dRec.nNewLatency,'ms'},
                  {'From Zero',(STRING)dRec.iFromZero,(STRING)dRec.nFromZero},
                  {'Orig Errors',(STRING)dRec.iErrorsOrig,(STRING)dRec.nErrorsOrig},
                  {'New Errors',(STRING)dRec.iErrorsNew,(STRING)dRec.nErrorsNew},
                  {'','',''}], modLayouts.lReadableStatsRec);
  END;
    
  SHARED fBuildCSV(DATASET(modLayouts.lStatsRec) dInput) := FUNCTION
    // lParentRec := RECORD
      // DATASET(modLayouts.lReadableStatsRec) dChild;
    // END;
    
    // lParentRec tConvert(modLayouts.lStatsRec dRec) := TRANSFORM
      // SELF.dChild := fCreateCSVStats(dRec);
    // END;
    
    // modLayouts.lReadableStatsRec tNorm(modLayouts.lReadableStatsRec dRec) := TRANSFORM
      // SELF := dRec;
    // END;
    // dParents := PROJECT(dInput,tConvert(LEFT));
    // dChildren := NORMALIZE(dParents,LEFT.dChild,tNorm(RIGHT));
		convertToString(inField) := macro
			SELF.inField := (string) drec.infield;
		endmacro;
		modLayouts.lReadableStatsHorizRec tNorm(modLayouts.lStatsRec dRec) := TRANSFORM
			convertToString(iMode); // 1
			convertToString(iCompareMode);  
			convertToString(sProfileBucket);
			convertToString(sDescription);
			convertToString(iTotalCnt); // 5
			convertToString(iProdHits);
			convertToString(nProdHits);
			convertToString(iBaselineHits);
			convertToString(nBaselineHits);
			convertToString(iNewHits);
			convertToString(nNewHits); 
			convertToString(iAllEqual); // 10
			convertToString(nAllEqual);
			convertToString(iNoneEqual);
			convertToString(nNoneEqual);
			convertToString(iEqualNonZero);
			convertToString(nEqualNonZero); // 15
			convertToString(iDiffNonZero);
			convertToString(nDiffNonZero);
			convertToString(iToZero);
			convertToString(nToZero);
			convertToString(iFromZero); // 20
			convertToString(nFromZero);
            convertToString(iHeaderOrigAccuracy);
            convertToString(nHeaderOrigAccuracy); // 25
            convertToString(iHeaderOrigDiff);
            convertToString(nHeaderOrigDiff);
            convertToString(iHeaderNewAccuracy);
            convertToString(nHeaderNewAccuracy);
            convertToString(iHeaderNewDiff); // 30
            convertToString(nHeaderNewDiff);
			convertToString(nBaselineLatency);
			convertToString(nNewLatency);
			convertToString(iErrorsOrig);
			convertToString(nErrorsOrig); // 35
			convertToString(iErrorsNew);
			convertToString(nErrorsNew); // 37
		END;
		dConverted := project(dInput, tNorm(LEFT));
		headerRec := dataset([{
			'bMode', // 1
			'nMode',  
			'ProfileBucket',
			'Description',
			'TotalCnt', // 5
			'ProdHits',
			'ProdHits%',
			'BaselineHits',
			'BaselineHits%',
			'NewHits',
			'NewHits%',
			'AllEqual', // 10
			'AllEqual%',
			'NoneEqual',
			'NoneEqual%',
			'EqualNonZero',
			'EqualNonZero%', // 15
			'DiffNonZero',
			'DiffNonZero%',
			'ToZero',
			'ToZero%',
			'FromZero', // 20
		    'FromZero%',
            'HeaderOrigAccuracy',
            'HeaderOrigAccuracy%', // 25
            'HeaderOrigDiff',
            'HeaderOrigDiff%',
            'HeaderNewAccuracy',
            'HeaderNewAccuracy%',
            'HeaderNewDiff', // 30
            'HeaderNewDiff%',
            'BaselineLatency',
			'NewLatency',
			'ErrorsOrig',
			'ErrorsOrig%', // 35
			'ErrorsNew',
			'ErrorsNew%'}], // 37
			modLayouts.lReadableStatsHorizRec);
			
    RETURN modCSV.macConvertToCSV(headerRec +dConverted,TRUE);
  END;
  
  SHARED fEmailAsCSV(dInput, sCSVName, sTo, sSubject, sBody) := FUNCTIONMACRO
    dOutCSV := fBuildCSV(dInput);
    RETURN pkgSTD.System.Email.SendEmailAttachData(sTo, sSubject, sBody, (DATA)modCSV.macAttachData(dOutCSV), 'text/csv', sCSVName+'.csv');
  ENDMACRO; 
  
  EXPORT fGenerateStatistics() := FUNCTION 
    aOutput := OUTPUT(dStats,,modFilenames(sInPrefix).kStatsLF(sVersion),COMPRESSED,EXPIRE(iExpireTime),OVERWRITE);
    aPromoteSuperfile := modSuperfiles(sInPrefix).macUpdateSF(modFilenames(sInPrefix).kStatsLF(sVersion),modFilenames(sInPrefix).kStatsSF);
    aOutputDiffNoneExamples := OUTPUT(CHOOSEN(dDiffNoneZero,1000),,NAMED('DiffNoneZero_Examples'));
    aOutputToZeroExamples := OUTPUT(CHOOSEN(dToZero,1000),,NAMED('ToZero_Examples'));
    aOutputFromZeroExamples := OUTPUT(CHOOSEN(dFromZero,1000),,NAMED('FromZero_Examples'));
    aOutpuToError := OUTPUT(CHOOSEN(dToError,1000),,NAMED('ToError_Examples'));
    aOutputFromError := OUTPUT(CHOOSEN(dFromError,1000),,NAMED('FromError_Examples'));
    aOutputBothError := OUTPUT(CHOOSEN(dBothError,1000),,NAMED('BothError_Examples'));
    sHyperlink := 'http://'+modConstants.sESP+':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid='+WORKUNIT+'#/stub/Summary';
    aEmailCSV := fEmailAsCSV(dStats,'BizLinkFull_ELERT_Stats_'+sVersion+'',sEmailTo,'BIP Header ELERT '+sVersion+' Completed','For examples please see ' + WORKUNIT + ' at: '+ sHyperlink);
    
    RETURN SEQUENTIAL(pkgSTD.File.StartSuperFileTransaction(),
                        aOutput,
                        aPromoteSuperfile,
                        pkgSTD.File.FinishSuperFileTransaction(),
                        aOutputDiffNoneExamples,
                        aOutputToZeroExamples,
                        aOutputFromZeroExamples,
                        aOutpuToError,
                        aOutputFromError,
                        aOutputBothError,
                        aEmailCSV
                        );
  END;

 /*  EXPORT createProfileStats(inInput, id, score, weight) := functionmacro
    // PROFILE BELOW IS FOR ID FUNCTIONS INPUT ONLY
    inputWithProfile := project(inInput,
                                transform({recordof(left), string fields},
                                          tmp := regexreplace(' ', IF(left.company_name!='','company:','')
                                                                  +IF(left.prim_range != '', 'primrange:', '')                                                                  
                                                                  +IF(left.sec_range != '', 'secrange:', '')                                                                  
                                                                  +IF(left.prim_name != '', 'primname:', '')                                                                  
                                                                  +IF(left.city != '', 'city:', '')                                                                  
                                                                  +IF(left.state != '', 'st:', '')                                                                  
                                                                  +IF(left.zip5 != '', 'zip:', '')                                                                  
                                                                  +IF(left.phone10!='','phone:','')
                                                                  +IF(left.fein!='','fein:','')
                                                                  +IF(left.contact_fname!='','contactfname:','')
                                                                  +IF(left.contact_lname!='','contactlname:','')
                                                                  +IF(left.contact_ssn!='','contactssn:','')
                                                                  +IF(left.contact_did!=0,'contactdid:','')
                                                                  +IF(left.sic_code!='','sic:','')
                                                                  +IF(left.email!='','email:','')
                                                                  +IF(left.url!='','url:',''), '');                                                                  
                                          self.fields := tmp[1.. length(tmp)-1],
                                          self := left));

    statsWithProfile := project(inputWithProfile,
                                transform({recordof(left), unsigned total_cnt, unsigned append_cnt, real append_rate, unsigned low_score, unsigned low_weight, unsigned no_hit, unsigned ambig},
                                          toKeep := left.score >= 75 and left.weight >= 44;

                                          self.fields := left.fields,
                                          self.total_cnt := 1,
                                          self.append_cnt := if(toKeep, 1, 0),
                                          self.append_rate := 0,
                                          self.low_score := if(left.score < 75 and left.score != 0, 1, 0),
                                          self.low_weight := if(left.weight < 44 and left.weight != 0, 1, 0),
                                          self.ambig := if(left.score < 75 and left.score != 0 and left.weight >= 44, 1, 0),
                                          self.no_hit := if(left.weight = 0 and left.score = 0, 1, 0),
                                          self := left));                                                              

    rollProfiles := rollup(sort(distribute(statsWithProfile, hash64(fields)), fields, id, local),
                           left.fields = right.fields,
                           transform(recordof(left),
                                     self.total_cnt := left.total_cnt + right.total_cnt,
                                     self.append_cnt := left.append_cnt + right.append_cnt,
                                     self.low_score := left.low_score + right.low_score,
                                     self.low_weight := left.low_weight + right.low_weight,
                                     self.no_hit := left.no_hit + right.no_hit,
                                     self.ambig := left.ambig + right.ambig,
                                     self := left), local);

    roll4Overall := project(rollup(rollProfiles,
                            true,
                            transform(recordof(left),
                                      self.total_cnt := left.total_cnt + right.total_cnt,
                                      self.append_cnt := left.append_cnt + right.append_cnt,
                                      self.low_score := left.low_score + right.low_score,
                                      self.low_weight := left.low_weight + right.low_weight,
                                      self.no_hit := left.no_hit + right.no_hit,
                                      self.ambig := left.ambig + right.ambig,
                                      self := left)), 
                            transform(recordof(left), 
                                      self.fields := 'OVERALL STATS', 
                                      self := left));                                   

    withRate := project(rollProfiles & roll4Overall,
                        transform({string fields, unsigned total_cnt, real per_of_batch, unsigned append_cnt, real append_rate, real low_score_per, real low_weight_per, real no_hit_rate, real ambig_rate},
                                  self.append_rate := left.append_cnt/left.total_cnt,
                                  self.low_score_per := left.low_score/left.total_cnt,
                                  self.low_weight_per := left.low_weight/left.total_cnt,
                                  self.no_hit_rate := left.no_hit/left.total_cnt,
                                  self.per_of_batch := left.total_cnt/count(inInput),
                                  self.ambig_rate := left.ambig/left.total_cnt,
                                  self := left));

    withKeysUsed := project(statsWithProfile,
                            transform({recordof(left), string keys_used, string keys_failed},
                                      self.keys_used := BizLinkFull.Process_Biz_Layouts.KeysUsedToText(left.keysUsed),
                                      self.keys_failed := BizLinkFull.Process_Biz_Layouts.KeysUsedToText(left.keysFailed),
                                      self := left));         

    normKeysUsed := normalize(withKeysUsed,
                              count(std.str.SplitWords(left.keys_used, ',')),
                              transform(recordof(left),
                                        tmp := std.str.SplitWords(left.keys_used, ',')[counter];
                                        self.keys_used := tmp,
                                        self := left));   

    normKeysUsedResolved := normalize(withKeysUsed(append_cnt = 1),
                                      count(std.str.SplitWords(left.keys_used, ',')),
                                      transform(recordof(left),
                                                tmp := std.str.SplitWords(left.keys_used, ',')[counter];
                                                self.keys_used := tmp,
                                                self := left));                                      

    normKeysFailed := normalize(withKeysUsed,
                                count(std.str.SplitWords(left.keys_failed, ',')),
                                transform(recordof(left),
                                          self.keys_failed := std.str.SplitWords(left.keys_failed, ',')[counter],
                                          self := left));   

    keysUsed := table(normKeysUsed,
                      {string fields := normKeysUsed.fields,
                       string keysUsed := normKeysUsed.keys_used,
                       unsigned cnt := count(group),
                       real p_of_t := 0},
                      fields, keys_used, skew(1.0));                    

    keysUsed4Overall := table(normKeysUsed,
                              {string fields := 'OVERALL STATS',
                               string keysUsed := normKeysUsed.keys_used,
                               unsigned cnt := count(group),
                               real p_of_t := 0},
                              keys_used, skew(1.0));

    keysUsedWithPofT := join(keysUsed & keysUsed4Overall, withRate,
                             left.fields = right.fields,
                             transform(recordof(left),
                                       self.p_of_t := round(left.cnt/right.total_cnt, 3),
                                       self := left),
                             lookup);               

    keysUsedReso := table(normKeysUsedResolved,
                          {string fields := normKeysUsedResolved.fields,
                           string keysUsed := normKeysUsedResolved.keys_used,
                           unsigned cnt := count(group),
                           real p_of_t := 0},
                          fields, keys_used, skew(1.0));    

    keysUsedReso4Overall := table(normKeysUsedResolved,
                                  {string fields := 'OVERALL STATS',
                                   string keysUsed := normKeysUsedResolved.keys_used,
                                   unsigned cnt := count(group),
                                   real p_of_t := 0},
                                  keys_used, skew(1.0));                         

    keysUsedResoWithPofT := join(keysUsedReso & keysUsedReso4Overall, withRate,
                                 left.fields = right.fields,
                                 transform(recordof(left),
                                           self.p_of_t := round(left.cnt/right.total_cnt, 3),
                                           self := left),
                                 lookup);                            

    keysFailed := table(normKeysFailed,
                        {string fields := normKeysFailed.fields,
                         string keysFailed := normKeysFailed.keys_failed,
                         unsigned cnt := count(group),
                         real p_of_t := 0},
                        fields, keys_failed, skew(1.0));  

    keysFailed4Overall := table(normKeysFailed,
                                {string fields := 'OVERALL STATS',
                                 string keysFailed := normKeysFailed.keys_failed,
                                 unsigned cnt := count(group),
                                 real p_of_t := 0},
                                keys_failed, skew(1.0));                      

    keysFailedWithPofT := join(keysFailed & keysFailed4Overall, withRate,
                               left.fields = right.fields,
                               transform(recordof(left),
                                         self.p_of_t := round(left.cnt/right.total_cnt, 3),
                                         self := left),
                               lookup);                      

    reallyAllData := project(withRate,
                             transform(allStatsDataLayout,
                                       self.keysUsedResoDs := project(sort(keysUsedResoWithPofT(fields = left.fields), -cnt), recordof(allStatsDataLayout.keysUsedDs)),
                                       self.keysUsedDs := project(sort(keysUsedWithPofT(fields = left.fields), -cnt), recordof(allStatsDataLayout.keysUsedDs)),
                                       self.keysFailedDs := project(sort(keysFailedWithPofT(fields = left.fields), -cnt), recordof(allStatsDataLayout.keysFailedDs)),
                                       self := left));

    // return when(outStats, outs);
    return output(sort(reallyAllData, -total_cnt), named('stats'), all);
  endmacro;

  EXPORT baseDetailed := createProfileStats(if(sMode = 'ORIG', dOrigData, dNewData), uniqueId, proxScore, proxWeight); */

END;