IMPORT  STD, SALT311, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest;
EXPORT  Proc_PrecisionResults(
    STRING	pSrc
    , STRING  pVersion
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInput = HealthcareNoMatchHeader_Ingest.Files(pSrc).CRK
    , UNSIGNED  pSampleSize = 50
    , SET OF STRING pSetReviewers = ['Reviewer1', 'Reviewer2', 'Reviewer3']
    , pThreshold  = HealthcareNoMatchHeader_InternalLinking.Config.MatchThreshold
	)	:=	FUNCTION

  pReviewerCnt  :=  IF(COUNT(pSetReviewers)>10,10,COUNT(pSetReviewers));

  dInputGrp :=  GROUP(SORT(DISTRIBUTE(pInput,HASH( crk)),crk,LOCAL),crk,LOCAL);
  dSamples  :=  HAVING(dInputGrp,COUNT(ROWS(LEFT)) > 1);

  nomatchidCompareService(STRING nomatch_idonestr, STRING nomatch_idtwostr, STRING RIDonestr, STRING RIDtwostr, STRING pSrc, STRING pVersion) := FUNCTION
    UNSIGNED8 nomatch_idone0 := (UNSIGNED8)SALT311.utWord(nomatch_idonestr,1); // Allow for two token on a line input
    UNSIGNED8 nomatch_idtwo0 := (UNSIGNED8)(IF(nomatch_idtwostr='*',SALT311.utWord(nomatch_idonestr,2),nomatch_idtwostr));
    UNSIGNED8 RIDone0 := (UNSIGNED8)SALT311.utWord(RIDonestr,1); // Allow for two token on a line input
    UNSIGNED8 RIDtwo0 := (UNSIGNED8)(IF(RIDtwostr='*',SALT311.utWord(RIDonestr,2),RIDtwostr));
    UNSIGNED8 nomatch_idone := IF( nomatch_idone0>=nomatch_idtwo0, nomatch_idone0, nomatch_idtwo0 );
    UNSIGNED8 nomatch_idtwo := IF( nomatch_idone0>=nomatch_idtwo0, nomatch_idtwo0, nomatch_idone0 );
    UNSIGNED8 RIDone := IF( nomatch_idone0>=nomatch_idtwo0, RIDone0, RIDtwo0 );
    UNSIGNED8 RIDtwo := IF( nomatch_idone0>=nomatch_idtwo0, RIDtwo0, RIDone0 );
    BFile := HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).AllRecords;
    odl := PROJECT(CHOOSEN(HealthcareNoMatchHeader_InternalLinking.Keys(pSrc,pVersion,BFile).Candidates(nomatch_id=nomatch_idone),100000),HealthcareNoMatchHeader_InternalLinking.match_candidates(pSrc,pVersion,BFile).layout_candidates);
    odr := PROJECT(CHOOSEN(HealthcareNoMatchHeader_InternalLinking.Keys(pSrc,pVersion,BFile).Candidates(nomatch_id=nomatch_idTwo),100000),HealthcareNoMatchHeader_InternalLinking.match_candidates(pSrc,pVersion,BFile).layout_candidates);
    k := HealthcareNoMatchHeader_InternalLinking.Keys(pSrc,pVersion,BFile).Specificities_Key;
    s := GLOBAL(PROJECT(k,HealthcareNoMatchHeader_InternalLinking.Layout_Specificities.R)[1]);
    odlv := HealthcareNoMatchHeader_InternalLinking.Debug(pSrc,pVersion, BFile, s).RolledEntities(odl);
    odrv := HealthcareNoMatchHeader_InternalLinking.Debug(pSrc,pVersion, BFile, s).RolledEntities(odr);
    odl_match := IF(RIDone > 0, odl(RID = RIDone), odl);
    odr_match := IF(RIDtwo > 0, odr(RID = RIDtwo), odr);
    mtch0 := HealthcareNoMatchHeader_InternalLinking.Debug(pSrc,pVersion, BFile, s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,nomatch_idone,nomatch_idtwo,0,0}],HealthcareNoMatchHeader_InternalLinking.match_candidates(pSrc,pVersion,BFile).layout_matches));
    mtch1 := IF(RIDone > 0, mtch0(RID1 = RIDone OR RID2 = RIDone), mtch0);
    mtch2 := IF(RIDtwo > 0, mtch1(RID1 = RIDtwo OR RID2 = RIDtwo), mtch1);
    mtch  := CHOOSEN(SORT(mtch2,-Conf),20);
    score := TABLE(mtch, {nomatch_id1, nomatch_id2, RID1, RID2, conf, SSN_score, DOB_score,DOB_score_prop, LEXID_score,LEXID_score_prop, SUFFIX_score,SUFFIX_score_prop, FNAME_score,FNAME_score_prop, MNAME_score,MNAME_score_prop, LNAME_score,LNAME_score_prop, GENDER_score, PRIM_NAME_score, PRIM_RANGE_score, SEC_RANGE_score, CITY_NAME_score, ST_score, ZIP_score, MAINNAME_score,MAINNAME_score_prop, ADDR1_score, LOCALE_score, ADDRESS_score, FULLNAME_score,FULLNAME_score_prop});
    RETURN SORT(score,-Conf);
  END;

  rCompare := record
    unsigned6 nomatch_id1;
    unsigned6 nomatch_id2;
    unsigned6 rid1;
    unsigned6 rid2;
    integer2 conf;
    integer2 ssn_score;
    integer2 dob_score;
    integer2 dob_score_prop;
    integer2 lexid_score;
    integer2 lexid_score_prop;
    integer2 suffix_score;
    integer2 suffix_score_prop;
    integer2 fname_score;
    integer2 fname_score_prop;
    integer2 mname_score;
    integer2 mname_score_prop;
    integer2 lname_score;
    integer2 lname_score_prop;
    integer2 gender_score;
    integer2 prim_name_score;
    integer2 prim_range_score;
    integer2 sec_range_score;
    integer2 city_name_score;
    integer2 st_score;
    integer2 zip_score;
    integer2 mainname_score;
    integer2 mainname_score_prop;
    integer2 addr1_score;
    integer2 locale_score;
    integer2 address_score;
    integer2 fullname_score;
    integer2 fullname_score_prop;
  end;
  
  rClusterCompares  :=  RECORD
    STRING10  nomatch_id;
    STRING3   Conf;
    DATASET(RECORDOF(dSamples)) dRecords;
    rCompare  dCompare;
  END;

  rClusterCompares tClusterCompares(dSamples l, DATASET(RECORDOF(dSamples)) dAllRows, STRING8 src, STRING version) :=  TRANSFORM
    SELF.nomatch_id   :=  (STRING)l.nomatch_id;
    SELF.dRecords     :=  dAllRows;
    SELF.dCompare     :=  nomatchidCompareService((STRING)dAllRows[1].nomatch_id,(STRING)dAllRows[2].nomatch_id,(STRING)dAllRows[1].rid,(STRING)dAllRows[2].rid,src,version)[1];
    SELF.Conf         :=  (STRING)SELF.dCompare.Conf;
  END;
  
  dPrecisionResults       :=  ROLLUP(dSamples, GROUP, tClusterCompares(LEFT,ROWS(LEFT),pSrc,pVersion));
  dPrecisionResults_lteq  :=  dPrecisionResults((INTEGER)conf BETWEEN 1 AND pThreshold);
  dPrecisionResults_gt    :=  dPrecisionResults((INTEGER)conf > pThreshold);
  
  totalSamples            :=  pSampleSize * pReviewerCnt;
  countkmatchsample_lteq  :=  COUNT(dPrecisionResults_lteq);
  countkmatchsample_gt    :=  COUNT(dPrecisionResults_gt);
  sampleslteqthreshold    :=  IF((UNSIGNED)(totalsamples * .667)  >= countkmatchsample_lteq  ,countkmatchsample_lteq   ,(unsigned)(totalsamples * .667)      );
  samplesabovethreshold   :=  IF((totalSamples - sampleslteqthreshold) >  countkmatchsample_gt  ,countkmatchsample_gt   ,(totalSamples - sampleslteqthreshold) );
  samplerecslteq          :=  IFF(sampleslteqthreshold    != 0 ,ENTH (dPrecisionResults_lteq,sampleslteqthreshold     ) ,dataset([],recordof(dPrecisionResults_lteq))) : independent;
  samplerecsgt            :=  IFF(samplesabovethreshold != 0 ,ENTH (dPrecisionResults_gt,samplesabovethreshold  ) ,dataset([],recordof(dPrecisionResults_gt))) : independent;

  allsamplerecs           := SORT(samplerecslteq + samplerecsgt,drecords[1].nomatch_id + drecords[2].nomatch_id);
  
  runPrecisionResults  := PARALLEL(
                             OUTPUT(COUNT(dPrecisionResults   ) ,named('TotalMatchSamples'   ))
                            ,OUTPUT(count(dPrecisionResults_lteq) ,named('TotalMatchSamplesLessThanOrEqualToThreshold'))
                            ,OUTPUT(count(dPrecisionResults_gt) ,named('TotalMatchSamplesGreaterThanThreshold'))
                            ,OUTPUT('-----------------------------------' ,named('_'))
                            ,OUTPUT(allsamplerecs ,named('AllSamplesCombined'),all)
                            // ,OUTPUT('-----------------------------------' ,named('__'))
                            ,IF(pReviewerCnt>=1,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('___'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*0)+1),NAMED(pSetReviewers[1]+'_Candidates'))))
                            ,IF(pReviewerCnt>=2,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('_____'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*1)+1),NAMED(pSetReviewers[2]+'_Candidates'))))
                            ,IF(pReviewerCnt>=3,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('______'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*2)+1),NAMED(pSetReviewers[3]+'_Candidates'))))
                            ,IF(pReviewerCnt>=4,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('_______'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*3)+1),NAMED(pSetReviewers[4]+'_Candidates'))))
                            ,IF(pReviewerCnt>=5,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('________'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*4)+1),NAMED(pSetReviewers[5]+'_Candidates'))))
                            ,IF(pReviewerCnt>=6,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('_________'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*5)+1),NAMED(pSetReviewers[6]+'_Candidates'))))
                            ,IF(pReviewerCnt>=7,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('__________'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*6)+1),NAMED(pSetReviewers[7]+'_Candidates'))))
                            ,IF(pReviewerCnt>=8,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('___________'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*7)+1),NAMED(pSetReviewers[8]+'_Candidates'))))
                            ,IF(pReviewerCnt>=9,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('____________'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*8)+1),NAMED(pSetReviewers[9]+'_Candidates'))))
                            ,IF(pReviewerCnt=10,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('_____________'))
                                ,OUTPUT(CHOOSEN(allsamplerecs,pSampleSize,(pSampleSize*9)+1),NAMED(pSetReviewers[10]+'_Candidates'))))
                            ,IF(COUNT(pSetReviewers)>10,
                              SEQUENTIAL(
                                OUTPUT('-----------------------------------' ,named('______________'))
                                ,OUTPUT('Maximum of 10 reviewers supported',NAMED('TooManyReviewers'))))
                          );
  
  RETURN  runPrecisionResults;
END;