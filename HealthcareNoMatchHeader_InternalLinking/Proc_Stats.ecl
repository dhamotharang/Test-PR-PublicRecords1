IMPORT STD;
EXPORT Proc_Stats (  
                    STRING  pSrc
                    , STRING  pIter = '1'
                    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header)  pInputFile
                   ) :=  MODULE
                  
  EXPORT  Iteration_Stats := FUNCTION
    pThreshold  :=  HealthcareNoMatchHeader_InternalLinking.Config.MatchThreshold;

    dBasefileNoMatchDups  :=  GROUP(SORT(DISTRIBUTE(pInputFile,HASH(nomatch_id)),nomatch_id,dob,LOCAL),nomatch_id,LOCAL);
    dBasefileLexIDDups    :=  GROUP(SORT(DISTRIBUTE(pInputFile(LexID>0),HASH(LexID)),LexID,dob,LOCAL),LexID,LOCAL);

    dNoMatchSingletons    :=  HAVING(dBasefileNoMatchDups,COUNT(ROWS(LEFT))=1);
    dNoMatchNonSingletons :=  HAVING(dBasefileNoMatchDups,COUNT(ROWS(LEFT))>1);

    rClusterDifferences :=  RECORD
      UNSIGNED8 nomatch_id;
      BOOLEAN   HasNoLexID      :=  FALSE;
      BOOLEAN   HasUniqueLexID  :=  FALSE;
      BOOLEAN   MultipleLexIDs  :=  FALSE;
      BOOLEAN   MultipleNames   :=  FALSE;
      BOOLEAN   MultipleDOBs    :=  FALSE;
      BOOLEAN   MultipleAddr    :=  FALSE;
      UNSIGNED  ClusterCount    :=  0;
    END;


    rClusterDifferences tClusterDifferences(dNoMatchNonSingletons l, DATASET(RECORDOF(dNoMatchNonSingletons)) dAllRows) :=  TRANSFORM
      SELF.nomatch_id     :=  l.nomatch_id;
      SELF.HasNoLexID     :=  COUNT(dAllRows)=COUNT(dAllRows(LexID=0));
      SELF.HasUniqueLexID :=  COUNT(dAllRows)=COUNT(dAllRows(LexID>0)) AND COUNT(DEDUP(SORT(dAllRows,LexID),LexID))=1;
      SELF.MultipleLexIDs :=  COUNT(DEDUP(SORT(dAllRows(LexID>0),LexID),LexID))>1;
      SELF.MultipleNames  :=  COUNT(DEDUP(SORT(dAllRows,input_full_name),input_full_name))>1;
      SELF.MultipleDOBs   :=  COUNT(DEDUP(SORT(dAllRows(dob>0),dob),dob))>1;
      SELF.MultipleAddr   :=  COUNT(DEDUP(SORT(dAllRows,prim_name),prim_name))>1  OR
                              COUNT(DEDUP(SORT(dAllRows,prim_range),prim_range))>1  OR
                              COUNT(DEDUP(SORT(dAllRows,sec_range),sec_range))>1  OR
                              COUNT(DEDUP(SORT(dAllRows,city_name),city_name))>1  OR
                              COUNT(DEDUP(SORT(dAllRows,st),st))>1  OR
                              COUNT(DEDUP(SORT(dAllRows,zip),zip))>1;
      SELF.ClusterCount   :=  COUNT(dAllRows);
    END;

    results := ROLLUP(dNoMatchNonSingletons, GROUP, tClusterDifferences(LEFT,ROWS(LEFT)));
    rStats  :=  RECORD
      STRING50  Name;
      STRING    val1;
      STRING    val2  :=  '';
    END;

    dStats  :=  DATASET([
                  {'Threshold',pThreshold},
                  {'Iteration',pIter},
                  {'WorkUnit',WorkUnit},
                  {'Source',pSrc},
                  {'','records','pcnt'},
                  {'Total Record Count',COUNT(pInputFile)},
                  {'Total LexIDs Appended',COUNT(pInputFile(LexID>0)),REALFORMAT(ROUND(100*COUNT(pInputFile(LexID>0))/COUNT(pInputFile),2),6,2)},
                  {'Total Minors',COUNT(pInputFile(Std.Date.AdjustDate(Std.Date.Today(),-18,0,0)<=dob)),REALFORMAT(ROUND(100*COUNT(pInputFile(Std.Date.AdjustDate(Std.Date.Today(),-18,0,0)<=dob))/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons',COUNT(dNoMatchSingletons),REALFORMAT(ROUND(100*COUNT(dNoMatchSingletons)/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons with No LexID',COUNT(dNoMatchSingletons(LexID=0)),REALFORMAT(ROUND(100*COUNT(dNoMatchSingletons(LexID=0))/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons with LexID',COUNT(dNoMatchSingletons(LexID>0)),REALFORMAT(ROUND(100*COUNT(dNoMatchSingletons(LexID>0))/COUNT(pInputFile),2),6,2)},
                  {'','clusters','records'},
                  {'Total Non-Singletons',COUNT(results),SUM(results,results.ClusterCount)},
                  {'','clusters','pcnt'},
                  // {'Total Non-Singleton Records',SUM(results,results.ClusterCount)},
                  {'Clusters with No LexID',COUNT(results(HasNoLexID)),REALFORMAT(ROUND(100*COUNT(results(HasNoLexID))/COUNT(results),2),6,2)},
                  {'Clusters with Unique LexID',COUNT(results(HasUniqueLexID)),REALFORMAT(ROUND(100*COUNT(results(HasUniqueLexID))/COUNT(results),2),6,2)},
                  {'','clusters','records'},
                  {'Clusters with Different Field Values',COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr
                                                                )),
                                                          SUM(results(
                                                              MultipleLexIDs  OR
                                                              MultipleNames   OR
                                                              MultipleDOBs    OR
                                                              MultipleAddr
                                                            ),results.ClusterCount)},
                  {'','clusters','pcnt'},
                  {'Clusters with Multiple LexIDs',COUNT(results(MultipleLexIDs)),REALFORMAT(ROUND(100*COUNT(results(MultipleLexIDs))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr
                                                                )),2),6,2)},
                  {'Clusters with Multiple Names',COUNT(results(MultipleNames)),REALFORMAT(ROUND(100*COUNT(results(MultipleNames))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr
                                                                )),2),6,2)},
                  {'Clusters with Multiple DOBs',COUNT(results(MultipleDOBs)),REALFORMAT(ROUND(100*COUNT(results(MultipleDOBs))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr
                                                                )),2),6,2)},
                  {'Clusters with Multiple Addresses',COUNT(results(MultipleAddr)),REALFORMAT(ROUND(100*COUNT(results(MultipleAddr))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr
                                                                )),2),6,2)}
                ],rStats);
    Stats             :=  OUTPUT(dStats,NAMED('Stats'),OVERWRITE);
    ClusterSizeCounts :=  OUTPUT(SORT(TABLE(SORT(results,ClusterCount),{ClusterCount,cnt:=COUNT(GROUP)},ClusterCount,FEW),-ClusterCount),NAMED('ClusterSizeCounts'),OVERWRITE);

    dClustersWithDifferences  :=  JOIN(
                                    DISTRIBUTE(pInputFile,HASH(nomatch_id)),
                                    DISTRIBUTE(results
                                      (
                                        MultipleLexIDs  OR
                                        MultipleNames   OR
                                        MultipleDOBs    OR
                                        MultipleAddr
                                      ),HASH(nomatch_id)),
                                    LEFT.nomatch_id = RIGHT.nomatch_id,
                                    TRANSFORM(
                                      {
                                        RECORDOF(LEFT),
                                        RECORDOF(RIGHT) - nomatch_id
                                      },
                                      SELF  :=  RIGHT;
                                      SELF  :=  LEFT;
                                    ),
                                    LOCAL
                                  );
                                  

    SampleClustersWithDifferences         :=  OUTPUT(CHOOSEN(dClustersWithDifferences,2000),NAMED('SampleClustersWithDifferences'),OVERWRITE);
    SampleClustersWithLexIDDifferences    :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleLexIDs),500),NAMED('SampleClustersWithLexIDDifferences'),OVERWRITE);
    SampleClustersWithNameDifferences     :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleNames),500),NAMED('SampleClustersWithNameDifferences'),OVERWRITE);
    SampleClustersWithDOBDifferences      :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleDOBs),500),NAMED('SampleClustersWithDOBDifferences'),OVERWRITE);
    SampleClustersWithAddressDifferences  :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleaddr),500),NAMED('SampleClustersWithAddressDifferences'),OVERWRITE);

    RETURN  SEQUENTIAL(
              Stats
              ,ClusterSizeCounts
              ,SampleClustersWithDifferences
              ,SampleClustersWithLexIDDifferences
              ,SampleClustersWithNameDifferences
              ,SampleClustersWithDOBDifferences
              ,SampleClustersWithAddressDifferences
            );
  END; // Iteration_Stats
 
  EXPORT  CRK_Stats := FUNCTION
    pThreshold  :=  HealthcareNoMatchHeader_InternalLinking.Config.MatchThreshold;
    pSrcName    :=  IF(pInputFile[1].gcid_name<>'',pInputFile[1].gcid_name,'No Source Name Provided');
    dBasefileCRKDups  :=  GROUP(SORT(DISTRIBUTE(pInputFile,HASH(CRK)),CRK,nomatch_id,-lexid,LOCAL),CRK,LOCAL);

    dCRKSingletons    :=  HAVING(dBasefileCRKDups,COUNT(ROWS(LEFT))=1);
    dCRKNonSingletons :=  HAVING(dBasefileCRKDups,COUNT(ROWS(LEFT))>1);

    rClusterDifferences :=  RECORD
      STRING50  crk;
      BOOLEAN   HasNoLexID                    :=  FALSE;
      BOOLEAN   HasUniqueLexID                :=  FALSE;
      BOOLEAN   MultipleLexIDs                :=  FALSE;
      BOOLEAN   MultipleNames                 :=  FALSE;
      BOOLEAN   MultipleDOBs                  :=  FALSE;
      BOOLEAN   MultipleAddr                  :=  FALSE;
      BOOLEAN   MultipleNoMatchIDs            :=  FALSE;
      BOOLEAN   LexIDClustersWithNoLexIDRecs  :=  FALSE;
      UNSIGNED  ClusterCount                  :=  0;
    END;


    rClusterDifferences tClusterDifferences(dCRKNonSingletons l, DATASET(RECORDOF(dCRKNonSingletons)) dAllRows) :=  TRANSFORM
      SELF.crk                :=  l.crk;
      SELF.HasNoLexID         :=  COUNT(dAllRows)=COUNT(dAllRows(LexID=0));
      SELF.HasUniqueLexID     :=  COUNT(dAllRows)=COUNT(dAllRows(LexID>0)) AND COUNT(DEDUP(SORT(dAllRows,LexID),LexID))=1;
      SELF.MultipleLexIDs     :=  COUNT(DEDUP(SORT(dAllRows(LexID>0),LexID),LexID))>1;
      SELF.MultipleNames      :=  COUNT(DEDUP(SORT(dAllRows,fname),fname))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,mname),mname))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,lname),lname))>1;
      SELF.MultipleDOBs       :=  COUNT(DEDUP(SORT(dAllRows(dob>0),dob),dob))>1;
      SELF.MultipleAddr       :=  COUNT(DEDUP(SORT(dAllRows,prim_name),prim_name))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,prim_range),prim_range))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,sec_range),sec_range))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,city_name),city_name))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,st),st))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,zip),zip))>1;
      SELF.MultipleNoMatchIDs :=  COUNT(DEDUP(SORT(dAllRows,nomatch_id),nomatch_id))>1;
      SELF.LexIDClustersWithNoLexIDRecs :=  COUNT(dAllRows(LexID=0))>0 AND COUNT(dAllRows(LexID>0))>0;
      SELF.ClusterCount       :=  COUNT(dAllRows);
    END;

    results := ROLLUP(dCRKNonSingletons, GROUP, tClusterDifferences(LEFT,ROWS(LEFT)));
    rStats  :=  RECORD
      STRING50  Name;
      STRING    val1;
      STRING    val2  :=  '';
    END;

    dStats  :=  DATASET([
                  {'Threshold',pThreshold},
                  {'WorkUnit',WorkUnit},
                  {'Source',pSrc},
                  {'Source name',pSrcName},
                  {'','records','pcnt'},
                  {'Total Record Count',COUNT(pInputFile)},
                  {'Total LexIDs Appended',COUNT(pInputFile(LexID>0)),REALFORMAT(ROUND(100*COUNT(pInputFile(LexID>0))/COUNT(pInputFile),2),6,2)},
                  {'Total Minors',COUNT(pInputFile(Std.Date.AdjustDate(Std.Date.Today(),-18,0,0)<=dob)),REALFORMAT(ROUND(100*COUNT(pInputFile(Std.Date.AdjustDate(Std.Date.Today(),-18,0,0)<=dob))/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons',COUNT(dCRKSingletons),REALFORMAT(ROUND(100*COUNT(dCRKSingletons)/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons with No LexID',COUNT(dCRKSingletons(LexID=0)),REALFORMAT(ROUND(100*COUNT(dCRKSingletons(LexID=0))/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons with LexID',COUNT(dCRKSingletons(LexID>0)),REALFORMAT(ROUND(100*COUNT(dCRKSingletons(LexID>0))/COUNT(pInputFile),2),6,2)},
                  {'Total Records with No LexID in a LexID Cluster',COUNT(dCRKNonSingletons(LexID=0 AND crk[1]='L')),REALFORMAT(ROUND(100*COUNT(dCRKNonSingletons(LexID=0 AND crk[1]='L'))/COUNT(pInputFile),2),6,2)},
                  {'','clusters','records'},
                  {'Total Non-Singletons',COUNT(results),SUM(results,results.ClusterCount)},
                  {'','clusters','pcnt'},
                  // {'Total Non-Singleton Records',SUM(results,results.ClusterCount)},
                  {'Clusters with No LexID',COUNT(results(HasNoLexID)),REALFORMAT(ROUND(100*COUNT(results(HasNoLexID))/COUNT(results),2),6,2)},
                  {'Clusters with Unique LexID',COUNT(results(HasUniqueLexID)),REALFORMAT(ROUND(100*COUNT(results(HasUniqueLexID))/COUNT(results),2),6,2)},
                  {'Clusters with Multiple NoMatchIDs',COUNT(results(MultipleNoMatchIDs)),REALFORMAT(ROUND(100*COUNT(results(MultipleNoMatchIDs))/COUNT(results),2),6,2)},
                  {'','clusters','records'},
                  {'Clusters with Multiple Field Values',COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),
                                                          SUM(results(
                                                              MultipleLexIDs  OR
                                                              MultipleNames   OR
                                                              MultipleDOBs    OR
                                                              MultipleAddr    OR
                                                              MultipleNoMatchIDs
                                                            ),results.ClusterCount)},
                  {'','clusters','pcnt'},
                  {'Clusters with Multiple LexIDs',COUNT(results(MultipleLexIDs)),REALFORMAT(ROUND(100*COUNT(results(MultipleLexIDs))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)},
                  {'Clusters with Multiple Names',COUNT(results(MultipleNames)),REALFORMAT(ROUND(100*COUNT(results(MultipleNames))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)},
                  {'Clusters with Multiple DOBs',COUNT(results(MultipleDOBs)),REALFORMAT(ROUND(100*COUNT(results(MultipleDOBs))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)},
                  {'Clusters with Multiple Addresses',COUNT(results(MultipleAddr)),REALFORMAT(ROUND(100*COUNT(results(MultipleAddr))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)}
                ],rStats);
    Stats             :=  OUTPUT(dStats,NAMED('Stats'),OVERWRITE);
    ClusterSizeCounts :=  OUTPUT(SORT(TABLE(SORT(results,ClusterCount),{ClusterCount,cnt:=COUNT(GROUP)},ClusterCount,FEW),-ClusterCount),NAMED('ClusterSizeCounts'),OVERWRITE);

    dClustersWithDifferences  :=  JOIN(
                                    DISTRIBUTE(pInputFile,HASH(crk)),
                                    DISTRIBUTE(results
                                      (
                                        MultipleLexIDs  OR
                                        MultipleNames   OR
                                        MultipleDOBs    OR
                                        MultipleAddr    OR
                                        MultipleNoMatchIDs
                                      ),HASH(crk)),
                                    LEFT.crk = RIGHT.crk,
                                    TRANSFORM(
                                      {
                                        RECORDOF(LEFT),
                                        RECORDOF(RIGHT) - crk
                                      },
                                      SELF  :=  RIGHT;
                                      SELF  :=  LEFT;
                                    ),
                                    LOCAL
                                  );
                                  

    SampleClustersWithDifferences         :=  OUTPUT(CHOOSEN(dClustersWithDifferences,2000),NAMED('SampleClustersWithDifferences'),OVERWRITE);
    SampleClustersWithLexIDDifferences    :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleLexIDs),500),NAMED('SampleClustersWithLexIDDifferences'),OVERWRITE);
    SampleClustersWithNameDifferences     :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleNames),500),NAMED('SampleClustersWithNameDifferences'),OVERWRITE);
    SampleClustersWithDOBDifferences      :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleDOBs),500),NAMED('SampleClustersWithDOBDifferences'),OVERWRITE);
    SampleClustersWithAddressDifferences  :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleaddr),500),NAMED('SampleClustersWithAddressDifferences'),OVERWRITE);
    SampleClustersWithMultipleNoMatchIDs  :=  OUTPUT(CHOOSEN(dClustersWithDifferences(MultipleNoMatchIDs),500),NAMED('SampleClustersWithMultipleNoMatchIDs'),OVERWRITE);
    SampleLexIDClustersWithNoLexIDRecords :=  OUTPUT(CHOOSEN(dClustersWithDifferences(LexIDClustersWithNoLexIDRecs),500),NAMED('SampleLexIDClustersWithNoLexIDRecords'),OVERWRITE);

    RETURN  SEQUENTIAL(
              Stats
              ,ClusterSizeCounts
              ,SampleClustersWithDifferences
              ,SampleClustersWithLexIDDifferences
              ,SampleClustersWithNameDifferences
              ,SampleClustersWithDOBDifferences
              ,SampleClustersWithAddressDifferences
              ,SampleClustersWithMultipleNoMatchIDs
              ,SampleLexIDClustersWithNoLexIDRecords
            );
  END; // CRK_Stats
  
  
  
  /*************************************/
  /* NoMatchID Stats - Stats based on  */
  /* NoMatchID Field (Not CRK Field)   */
  /*************************************/
 
  EXPORT  NoMatchID_Stats := FUNCTION
    pThreshold  :=  HealthcareNoMatchHeader_InternalLinking.Config.MatchThreshold;
    pSrcName    :=  IF(pInputFile[1].gcid_name<>'',pInputFile[1].gcid_name,'No Source Name Provided');
    dBasefileNoMatchIDDups  :=  GROUP(SORT(DISTRIBUTE(pInputFile,HASH(nomatch_id)),nomatch_id,-lexid,LOCAL),nomatch_id,LOCAL);

    dNoMatchIDSingletons    :=  HAVING(dBasefileNoMatchIDDups,COUNT(ROWS(LEFT))=1);
    dNoMatchIDNonSingletons :=  HAVING(dBasefileNoMatchIDDups,COUNT(ROWS(LEFT))>1);

    rClusterDifferences :=  RECORD
      UNSIGNED8 nomatch_id;
      BOOLEAN   HasNoLexID                    :=  FALSE;
      BOOLEAN   HasUniqueLexID                :=  FALSE;
      BOOLEAN   MultipleLexIDs                :=  FALSE;
      BOOLEAN   MultipleNames                 :=  FALSE;
      BOOLEAN   MultipleDOBs                  :=  FALSE;
      BOOLEAN   MultipleAddr                  :=  FALSE;
      BOOLEAN   MultipleNoMatchIDs            :=  FALSE;
      BOOLEAN   LexIDClustersWithNoLexIDRecs  :=  FALSE;
      UNSIGNED  ClusterCount                  :=  0;
    END;


    rClusterDifferences tClusterDifferences(dNoMatchIDNonSingletons l, DATASET(RECORDOF(dNoMatchIDNonSingletons)) dAllRows) :=  TRANSFORM
      SELF.nomatch_id         :=  l.nomatch_id;
      SELF.HasNoLexID         :=  COUNT(dAllRows)=COUNT(dAllRows(LexID=0));
      SELF.HasUniqueLexID     :=  COUNT(dAllRows)=COUNT(dAllRows(LexID>0)) AND COUNT(DEDUP(SORT(dAllRows,LexID),LexID))=1;
      SELF.MultipleLexIDs     :=  COUNT(DEDUP(SORT(dAllRows(LexID>0),LexID),LexID))>1;
      SELF.MultipleNames      :=  COUNT(DEDUP(SORT(dAllRows,fname),fname))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,mname),mname))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,lname),lname))>1;
      SELF.MultipleDOBs       :=  COUNT(DEDUP(SORT(dAllRows(dob>0),dob),dob))>1;
      SELF.MultipleAddr       :=  COUNT(DEDUP(SORT(dAllRows,prim_name),prim_name))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,prim_range),prim_range))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,sec_range),sec_range))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,city_name),city_name))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,st),st))>1  OR
                                  COUNT(DEDUP(SORT(dAllRows,zip),zip))>1;
      SELF.MultipleNoMatchIDs :=  COUNT(DEDUP(SORT(dAllRows,nomatch_id),nomatch_id))>1;
      SELF.LexIDClustersWithNoLexIDRecs :=  COUNT(dAllRows(LexID=0))>0 AND COUNT(dAllRows(LexID>0))>0;
      SELF.ClusterCount       :=  COUNT(dAllRows);
    END;

    results := ROLLUP(dNoMatchIDNonSingletons, GROUP, tClusterDifferences(LEFT,ROWS(LEFT)));
    rStats  :=  RECORD
      STRING50  Name;
      STRING    val1;
      STRING    val2  :=  '';
    END;

    dStats  :=  DATASET([
                  {'Threshold',pThreshold},
                  {'WorkUnit',WorkUnit},
                  {'Source',pSrc},
                  {'Source name',pSrcName},
                  {'','records','pcnt'},
                  {'Total Record Count',COUNT(pInputFile)},
                  {'Total LexIDs Appended',COUNT(pInputFile(LexID>0)),REALFORMAT(ROUND(100*COUNT(pInputFile(LexID>0))/COUNT(pInputFile),2),6,2)},
                  {'Total Minors',COUNT(pInputFile(Std.Date.AdjustDate(Std.Date.Today(),-18,0,0)<=dob)),REALFORMAT(ROUND(100*COUNT(pInputFile(Std.Date.AdjustDate(Std.Date.Today(),-18,0,0)<=dob))/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons',COUNT(dNoMatchIDSingletons),REALFORMAT(ROUND(100*COUNT(dNoMatchIDSingletons)/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons with No LexID',COUNT(dNoMatchIDSingletons(LexID=0)),REALFORMAT(ROUND(100*COUNT(dNoMatchIDSingletons(LexID=0))/COUNT(pInputFile),2),6,2)},
                  {'Total Singletons with LexID',COUNT(dNoMatchIDSingletons(LexID>0)),REALFORMAT(ROUND(100*COUNT(dNoMatchIDSingletons(LexID>0))/COUNT(pInputFile),2),6,2)},
                  {'Total Records with No LexID in a LexID Cluster',COUNT(dNoMatchIDNonSingletons(LexID=0 AND crk[1]='L')),REALFORMAT(ROUND(100*COUNT(dNoMatchIDNonSingletons(LexID=0 AND crk[1]='L'))/COUNT(pInputFile),2),6,2)},
                  {'','clusters','records'},
                  {'Total Non-Singletons',COUNT(results),SUM(results,results.ClusterCount)},
                  {'','clusters','pcnt'},
                  // {'Total Non-Singleton Records',SUM(results,results.ClusterCount)},
                  {'Clusters with No LexID',COUNT(results(HasNoLexID)),REALFORMAT(ROUND(100*COUNT(results(HasNoLexID))/COUNT(results),2),6,2)},
                  {'Clusters with Unique LexID',COUNT(results(HasUniqueLexID)),REALFORMAT(ROUND(100*COUNT(results(HasUniqueLexID))/COUNT(results),2),6,2)},
                  {'Clusters with Multiple NoMatchIDs',COUNT(results(MultipleNoMatchIDs)),REALFORMAT(ROUND(100*COUNT(results(MultipleNoMatchIDs))/COUNT(results),2),6,2)},
                  {'','clusters','records'},
                  {'Clusters with Multiple Field Values',COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),
                                                          SUM(results(
                                                              MultipleLexIDs  OR
                                                              MultipleNames   OR
                                                              MultipleDOBs    OR
                                                              MultipleAddr    OR
                                                              MultipleNoMatchIDs
                                                            ),results.ClusterCount)},
                  {'','clusters','pcnt'},
                  {'Clusters with Multiple LexIDs',COUNT(results(MultipleLexIDs)),REALFORMAT(ROUND(100*COUNT(results(MultipleLexIDs))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)},
                  {'Clusters with Multiple Names',COUNT(results(MultipleNames)),REALFORMAT(ROUND(100*COUNT(results(MultipleNames))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)},
                  {'Clusters with Multiple DOBs',COUNT(results(MultipleDOBs)),REALFORMAT(ROUND(100*COUNT(results(MultipleDOBs))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)},
                  {'Clusters with Multiple Addresses',COUNT(results(MultipleAddr)),REALFORMAT(ROUND(100*COUNT(results(MultipleAddr))/COUNT(results(
                                                                  MultipleLexIDs  OR
                                                                  MultipleNames   OR
                                                                  MultipleDOBs    OR
                                                                  MultipleAddr    OR
                                                                  MultipleNoMatchIDs
                                                                )),2),6,2)}
                ],rStats);
    Stats             :=  OUTPUT(dStats,NAMED('Stats'),OVERWRITE);
    ClusterSizeCounts :=  OUTPUT(SORT(TABLE(SORT(results,ClusterCount),{ClusterCount,cnt:=COUNT(GROUP)},ClusterCount,FEW),-ClusterCount),NAMED('ClusterSizeCounts'),OVERWRITE);

    dClustersWithDifferences  :=  JOIN(
                                    DISTRIBUTE(pInputFile,HASH(nomatch_id)),
                                    DISTRIBUTE(results
                                      (
                                        MultipleLexIDs  OR
                                        MultipleNames   OR
                                        MultipleDOBs    OR
                                        MultipleAddr    OR
                                        MultipleNoMatchIDs
                                      ),HASH(nomatch_id)),
                                    LEFT.nomatch_id = RIGHT.nomatch_id,
                                    TRANSFORM(
                                      {
                                        RECORDOF(LEFT),
                                        RECORDOF(RIGHT) - nomatch_id
                                      },
                                      SELF  :=  RIGHT;
                                      SELF  :=  LEFT;
                                    ),
                                    LOCAL
                                  );
                                  

    SampleClustersWithDifferences         :=  OUTPUT(CHOOSEN(dClustersWithDifferences,2000),NAMED('SampleClustersWithDifferences'),OVERWRITE);
    SampleClustersWithLexIDDifferences    :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleLexIDs),500),NAMED('SampleClustersWithLexIDDifferences'),OVERWRITE);
    SampleClustersWithNameDifferences     :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleNames),500),NAMED('SampleClustersWithNameDifferences'),OVERWRITE);
    SampleClustersWithDOBDifferences      :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleDOBs),500),NAMED('SampleClustersWithDOBDifferences'),OVERWRITE);
    SampleClustersWithAddressDifferences  :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleaddr),500),NAMED('SampleClustersWithAddressDifferences'),OVERWRITE);
    SampleClustersWithMultipleNoMatchIDs  :=  OUTPUT(CHOOSEN(dClustersWithDifferences(MultipleNoMatchIDs),500),NAMED('SampleClustersWithMultipleNoMatchIDs'),OVERWRITE);
    SampleLexIDClustersWithNoLexIDRecords :=  OUTPUT(CHOOSEN(dClustersWithDifferences(LexIDClustersWithNoLexIDRecs),500),NAMED('SampleLexIDClustersWithNoLexIDRecords'),OVERWRITE);

    RETURN  SEQUENTIAL(
              Stats
              ,ClusterSizeCounts
              ,SampleClustersWithDifferences
              ,SampleClustersWithLexIDDifferences
              ,SampleClustersWithNameDifferences
              ,SampleClustersWithDOBDifferences
              ,SampleClustersWithAddressDifferences
              ,SampleClustersWithMultipleNoMatchIDs
              ,SampleLexIDClustersWithNoLexIDRecords
            );
  END; // NoMatchID_Stats
END;
