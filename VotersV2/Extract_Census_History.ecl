IMPORT VotersV2;

EXPORT Extract_Census_History(DATASET(VotersV2.Layouts_Voters.Layout_Voters_base_new) pVoteReg,
                              DATASET(VotersV2.Layout_Voters_VoteHistory) pVoteHist) := MODULE

  SHARED VoteHistSort := SORT(DISTRIBUTE(pVoteHist, vtid), vtid, LOCAL);

  slimVoteRegLayout := RECORD
    pVoteReg.vtid;
  END;
 
  VoteCensusSlim := PROJECT(pVoteReg(source_state = 'MA'), TRANSFORM(slimVoteRegLayout, SELF := LEFT)); 
  SHARED VoteCensusSort := DEDUP(SORT(DISTRIBUTE(VoteCensusSlim, vtid), vtid, LOCAL), LOCAL);
  
  EXPORT VoteHistCensus := JOIN(VoteHistSort,
                                VoteCensusSort,
                                LEFT.vtid = RIGHT.vtid,
                                TRANSFORM(RECORDOF(pVoteHist), SELF := LEFT),
                                LOCAL);
  
  EXPORT VoteHistOnly := JOIN(VoteHistSort,
                              VoteCensusSort,
                              LEFT.vtid = RIGHT.vtid,
                              TRANSFORM(RECORDOF(pVoteHist), SELF := LEFT),
                              LEFT ONLY,
                              LOCAL);
 
END;