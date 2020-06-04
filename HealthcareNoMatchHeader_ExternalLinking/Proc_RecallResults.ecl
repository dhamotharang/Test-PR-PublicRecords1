IMPORT  STD, SALT311, HealthcareNoMatchHeader_ExternalLinking, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest;
EXPORT  Proc_RecallResults(
    STRING	pSrc
    , STRING  pVersion
    , DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInput = HealthcareNoMatchHeader_Ingest.Files(pSrc).CRK
    , UNSIGNED  pSampleSize = 50
    , SET OF STRING pSetReviewers = ['Reviewer1', 'Reviewer2', 'Reviewer3']
    , UNSIGNED  pWeight  = HealthcareNoMatchHeader_InternalLinking.Config.MatchThreshold
    , STRING  pServiceRoxieIP = '10.173.3.1'
	)	:=	FUNCTION

  pReviewerCnt  :=  IF(COUNT(pSetReviewers)>10,10,COUNT(pSetReviewers));
  dSamples      :=  pInput;
  
  fFragHunter   :=  HealthcareNoMatchHeader_ExternalLinking.fragHunter(pSrc,pVersion,,pWeight);
  dFragments    :=  fFragHunter.vFrags;
  
  rClusterCompares  :=  RECORD
    STRING10  nomatch_id1;
    STRING10  nomatch_id2;
    STRING3   weight;
		STRING		hyperlink__html;
  END;
		
  // Strings to create a Hyperlink
  pHyperlinkPreamble	:=	'<a href="http://';
  pHyperlinkIP				:=	pServiceRoxieIP;
  pHyperlinkService		:=	':8002/WsEcl/xslt/query/roxie_devoneway_1_eclcc/'
                          +'healthcarenomatchheader_internallinking.nomatch_idcompareservice'
                          +'?nomatch_idone=@nomatch_id1@&nomatch_idtwo=@nomatch_id2@">Compare: @nomatch_id1@, @nomatch_id2@</a>';
  pHyperLink					:=	pHyperlinkPreamble+pHyperlinkIP+pHyperlinkService;

  rClusterCompares tClusterCompares(dFragments l, STRING8 src, STRING version) :=  TRANSFORM
    SELF.nomatch_id1  :=  (STRING)l.nomatch_id;
    SELF.nomatch_id2  :=  (STRING)l.NoMatchIDSource;
    SELF.weight       :=  (STRING)l.weight;
    SELF.hyperlink__html := STD.Str.FindReplace(STD.Str.FindReplace(pHyperLink,'@nomatch_id1@',(STRING)SELF.nomatch_id1),'@nomatch_id2@',(STRING)SELF.nomatch_id2);
  END;
   
  dFragmentResults  :=  PROJECT(dFragments, tClusterCompares(LEFT,pSrc,pVersion));
  
  totalSamples      :=  pSampleSize * pReviewerCnt;
  allsamplerecs     :=  SORT(ENTH(dFragmentResults,totalSamples),nomatch_id1 + nomatch_id2) : independent;
  
  runRecallResults  :=  SEQUENTIAL(
                          HealthcareNoMatchHeader_ExternalLinking.Proc_GoExternal(pSrc,pVersion,UNGROUP(dSamples)),
                          OUTPUT(SORT(dFragments,nomatchidSource,nomatch_id,-weight),,'~	ushc::healthcarenomatchheader::recall_testing::'+pSrc+'::'+pVersion,COMPRESSED,OVERWRITE),
                          PARALLEL(
                               OUTPUT(COUNT(dFragmentResults   ) ,named('TotalMatchSamples'   ))
                              ,OUTPUT('-----------------------------------' ,named('_'))
                              ,OUTPUT(allsamplerecs ,named('AllSamplesCombined'),all)
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
                            )
                          );
  
  RETURN  runRecallResults;
END;