EXPORT Proc_Stats(  
                    STRING pSrc
                    , STRING  pIter
                    ,DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header)	pInputFile
                  ):= FUNCTION
                  
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
                {'Total Record Count',COUNT(pInputFile)},
                {'','records','pcnt'},
                {'Total Singletons',COUNT(dNoMatchSingletons),REALFORMAT(ROUND(100*COUNT(dNoMatchSingletons)/COUNT(pInputFile),2),5,2)},
                {'Total Singletons with No LexID',COUNT(dNoMatchSingletons(LexID=0)),REALFORMAT(ROUND(100*COUNT(dNoMatchSingletons(LexID=0))/COUNT(pInputFile),2),5,2)},
                {'Total Singletons with LexID',COUNT(dNoMatchSingletons(LexID>0)),REALFORMAT(ROUND(100*COUNT(dNoMatchSingletons(LexID>0))/COUNT(pInputFile),2),5,2)},
                {'','clusters','records'},
                {'Total Non-Singletons',COUNT(results),SUM(results,results.ClusterCount)},
                {'','clusters','pcnt'},
                // {'Total Non-Singleton Records',SUM(results,results.ClusterCount)},
                {'Clusters with No LexID',COUNT(results(HasNoLexID)),REALFORMAT(ROUND(100*COUNT(results(HasNoLexID))/COUNT(results),2),5,2)},
                {'Clusters with Unique LexID',COUNT(results(HasUniqueLexID)),REALFORMAT(ROUND(100*COUNT(results(HasUniqueLexID))/COUNT(results),2),5,2)},
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
                                                              )),2),5,2)},
                {'Clusters with Multiple Names',COUNT(results(MultipleNames)),REALFORMAT(ROUND(100*COUNT(results(MultipleNames))/COUNT(results(
                                                                MultipleLexIDs  OR
                                                                MultipleNames   OR
                                                                MultipleDOBs    OR
                                                                MultipleAddr
                                                              )),2),5,2)},
                {'Clusters with Multiple DOBs',COUNT(results(MultipleDOBs)),REALFORMAT(ROUND(100*COUNT(results(MultipleDOBs))/COUNT(results(
                                                                MultipleLexIDs  OR
                                                                MultipleNames   OR
                                                                MultipleDOBs    OR
                                                                MultipleAddr
                                                              )),2),5,2)},
                {'Clusters with Multiple Addresses',COUNT(results(MultipleAddr)),REALFORMAT(ROUND(100*COUNT(results(MultipleAddr))/COUNT(results(
                                                                MultipleLexIDs  OR
                                                                MultipleNames   OR
                                                                MultipleDOBs    OR
                                                                MultipleAddr
                                                              )),2),5,2)}
              ],rStats);
  Stats             :=  OUTPUT(dStats,NAMED('Stats'));
  ClusterSizeCounts :=  OUTPUT(SORT(TABLE(SORT(results,ClusterCount),{ClusterCount,cnt:=COUNT(GROUP)},ClusterCount,FEW),-ClusterCount),NAMED('ClusterSizeCounts'));

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
                                

  SampleClustersWithDifferences         :=  OUTPUT(CHOOSEN(dClustersWithDifferences,2000),NAMED('SampleClustersWithDifferences'));
  SampleClustersWithLexIDDifferences    :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleLexIDs),500),NAMED('SampleClustersWithLexIDDifferences'));
  SampleClustersWithNameDifferences     :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleNames),500),NAMED('SampleClustersWithNameDifferences'));
  SampleClustersWithDOBDifferences      :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleDOBs),500),NAMED('SampleClustersWithDOBDifferences'));
  SampleClustersWithAddressDifferences  :=  OUTPUT(CHOOSEN(dClustersWithDifferences(multipleaddr),500),NAMED('SampleClustersWithAddressDifferences'));

  RETURN  SEQUENTIAL(
            Stats
            ,ClusterSizeCounts
            ,SampleClustersWithDifferences
            ,SampleClustersWithLexIDDifferences
            ,SampleClustersWithNameDifferences
            ,SampleClustersWithDOBDifferences
            ,SampleClustersWithAddressDifferences
          );
END;

