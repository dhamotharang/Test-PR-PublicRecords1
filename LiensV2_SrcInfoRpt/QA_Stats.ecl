IMPORT LiensV2_SrcInfoRpt, LiensV2, tools, STD;
EXPORT QA_Stats( STRING		pVersion			=	(STRING)STD.Date.Today()
                ,STRING		pEmailList = LiensV2_SrcInfoRpt.Email_Notification_Lists().BuildSuccess
               ) := FUNCTION

 dSuppressedJurisdictionsPrevious :=	LiensV2_SrcInfoRpt.Files(LiensV2_SrcInfoRpt.Filenames().Base.SuppressedJurisdictions.Father).SuppressedJurisdictions;
 dSuppressedJurisdictionsCurrent  := LiensV2_SrcInfoRpt.Files().SuppressedJurisdictions;

 // Duplicate code from LiensV2_SrcInfoRpt.fn_SuppressedFCRALiensMain
 dFCRAMain	:=	LiensV2.file_liens_main(
                                       tmsid[..2]	IN	['HG']
                                      );

 rFCRAMainWithCourtID	:=	RECORD
  dFCRAMain,
  STRING7	CourtID;
  STRING2	FILETYPEID;
 END;

 dFCRAMainWithCourtID	:=	PROJECT(dFCRAMain,
                          TRANSFORM(
                           rFCRAMainWithCourtID,
                           SELF.CourtID		  :=	LEFT.tmsid[LENGTH(TRIM(LEFT.tmsid,LEFT,RIGHT))-6..];
                           SELF.FILETYPEID	:=	LEFT.rmsid[LENGTH(TRIM(LEFT.rmsid,LEFT,RIGHT))-1..];
                           SELF						:=	LEFT;
                          )
                         );

 dSuppressedFCRALiensMainPrevious	:=	JOIN(
                                      DISTRIBUTE(dFCRAMainWithCourtID,HASH(CourtID,FILETYPEID)),
                                      DISTRIBUTE(dSuppressedJurisdictionsPrevious,HASH(LNCourtID,FILETYPEID)),
                                       LEFT.CourtID		=	RIGHT.LNCourtID	AND
                                       LEFT.FILETYPEID	=	RIGHT.FILETYPEID,
                                      TRANSFORM(LEFT),
                                      LOCAL
                                     );

 dSuppressedFCRALiensMainCurrent	:=	JOIN(
                                     DISTRIBUTE(dFCRAMainWithCourtID,HASH(CourtID,FILETYPEID)),
                                     DISTRIBUTE(dSuppressedJurisdictionsCurrent,HASH(LNCourtID,FILETYPEID)),
                                      LEFT.CourtID		=	RIGHT.LNCourtID	AND
                                      LEFT.FILETYPEID	=	RIGHT.FILETYPEID,
                                     TRANSFORM(LEFT),
                                     LOCAL
                                    );

 dLostJurisdictions	:=	JOIN(
                        DISTRIBUTE(dSuppressedFCRALiensMainPrevious,HASH(tmsid,rmsid)),
                        DISTRIBUTE(dSuppressedFCRALiensMainCurrent,HASH(tmsid,rmsid)),
                         LEFT.tmsid	=	RIGHT.tmsid	AND
                         LEFT.rmsid	=	RIGHT.rmsid,
                        TRANSFORM(LEFT),
                        LEFT ONLY,
                        LOCAL
                       );

 dGainedJurisdictions	:=	JOIN(
                          DISTRIBUTE(dSuppressedFCRALiensMainPrevious,HASH(tmsid,rmsid)),
                          DISTRIBUTE(dSuppressedFCRALiensMainCurrent,HASH(tmsid,rmsid)),
                             LEFT.tmsid	=	RIGHT.tmsid	AND
                             LEFT.rmsid	=	RIGHT.rmsid,
                            TRANSFORM(RIGHT),
                            RIGHT ONLY,
                            LOCAL
                         );

 dLostJurisdictionsDist	  :=	SORT(DISTRIBUTE(dLostJurisdictions,HASH(courtid,filetypeid)),courtid,filetypeid,LOCAL);
 dGainedJurisdictionsDist	:=	SORT(DISTRIBUTE(dGainedJurisdictions,HASH(courtid,filetypeid)),courtid,filetypeid,LOCAL);

 dLostTable			:=	TABLE(dLostJurisdictionsDist,{courtid,filetypeid,cnt:=COUNT(GROUP)},courtid,filetypeid);
 dGainedTable	:=	TABLE(dGainedJurisdictionsDist,{courtid,filetypeid,cnt:=COUNT(GROUP)},courtid,filetypeid);

 PreviousRecordSuppressionCount        := COUNT(dSuppressedFCRALiensMainPrevious);
 CurrentRecordSuppressionCount         := COUNT(dSuppressedFCRALiensMainCurrent);
 JurisdictionsLostFromSuppressionList  := SORT(dLostTable,-cnt);
 JurisdictionsAddedToSuppressionList   := SORT(dGainedTable,-cnt);
 JurisdictionsLostFromSuppressionCount := COUNT(dLostTable);
 JurisdictionsAddedToSuppressionCount  := COUNT(dGainedTable);
 
 outputPrevCnt   := OUTPUT(PreviousRecordSuppressionCount,NAMED('PreviousRecordSuppressionCount'));
 outputCurrCnt   := OUTPUT(CurrentRecordSuppressionCount,NAMED('CurrentRecordSuppressionCount'));

 outputLostTbl   := OUTPUT(CHOOSEN(JurisdictionsLostFromSuppressionList,2000),NAMED('JurisdictionsLostFromSuppressionList'));
 outputGainedTbl := OUTPUT(CHOOSEN(JurisdictionsAddedToSuppressionList,2000),NAMED('JurisdictionsAddedToSuppressionList'));

 outputLostCnt   := OUTPUT(JurisdictionsLostFromSuppressionCount,NAMED('JurisdictionsLostFromSuppressionCount'));
 outputGainedCnt := OUTPUT(JurisdictionsAddedToSuppressionCount,NAMED('JurisdictionsAddedToSuppressionCount'));

 pBuildName       := LiensV2_SrcInfoRpt._Dataset().Name;
 pStatsString     := '\n'+
                     'Previous Record Suppression Count '+'\t'+PreviousRecordSuppressionCount+'\n'+
                     'Current Record Suppression Count '+'\t'+CurrentRecordSuppressionCount+'\n'+
                     'Jurisdictions Lost '+'\t'+'\t'+'\t'+'\t'+JurisdictionsLostFromSuppressionCount+'\n'+
                     'Jurisdictions Gained '+'\t'+'\t'+'\t'+JurisdictionsAddedToSuppressionCount;
 StatsEmail       := tools.fun_SendEmail(
                       pEmailList
                      ,pBuildName + ' Build ' + pversion + ' Statistics'
                      ,pStatsString
                     );


	Stats := SEQUENTIAL(
  outputPrevCnt,
  outputCurrCnt,
  outputLostTbl,
  outputGainedTbl,
  outputLostCnt,
  outputGainedCnt,
  StatsEmail
 );

	RETURN Stats;

END;													