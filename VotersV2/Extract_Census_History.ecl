IMPORT VotersV2;

// DF-26929 - This function is only to separate the MA Census History records from the Voter History records
EXPORT Extract_Census_History(DATASET(VotersV2.Layouts_Voters.Layout_Voters_base_new) pVoteReg,
                              DATASET(VotersV2.Layout_Voters_VoteHistory) pVoteHist) := MODULE

  SHARED VoteHistSort := SORT(DISTRIBUTE(pVoteHist, vtid), vtid, LOCAL);

  slimVoteRegLayout := RECORD
    pVoteReg.vtid;
  END;
 
  VoteCensusSlim := PROJECT(pVoteReg(source_state = 'MA'), TRANSFORM(slimVoteRegLayout, SELF := LEFT)); 
  SHARED VoteCensusSort := DEDUP(SORT(DISTRIBUTE(VoteCensusSlim, vtid), vtid, LOCAL), LOCAL);
  
  // DF-26929 - Keeping only MA Census History records
  EXPORT VoteHistCensus := JOIN(VoteHistSort,
                                VoteCensusSort,
                                LEFT.vtid = RIGHT.vtid,
                                TRANSFORM(RECORDOF(pVoteHist), SELF := LEFT),
                                LOCAL);
 
  // DF-26929 - Keeping only Voter History records after filtering out MA Census History records
  EXPORT VoteHistOnly := JOIN(VoteHistSort,
                              VoteCensusSort,
                              LEFT.vtid = RIGHT.vtid,
                              TRANSFORM(RECORDOF(pVoteHist), SELF := LEFT),
                              LEFT ONLY,
                              LOCAL);
 
END;