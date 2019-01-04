import wk_ut,tools,std;
/*
so, basically I need to:
  total up matchesperformed for all iterations
  also total up # matches per confidence level
  get percentage of total matches per confidence level(cumulative)
  how many records checked total
  then, find out how many bad & questionable(pass into function/macro) matches:  bads + questionable/2
    Error rate:
      divide (bads + r/2) / # of checked(for conf level)
      if no checked recs, then percentage for previous conf level / 2.
    NumErrors:
      Error Rate * num matches for that conf level
    Precision:
      total up all numerrors for all conf levels
      divide above by total number of matches
      1 - above result
*/
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 1. Create Summary Report, output it to file first
// --    probably execute within iteration(maybe have to kick off separately in own workunit?)
////////////////////////////////////////////////////////////////////////////////////////////////////////
pversion                := '20130330'                                                           ;
jobowner                := 'lbentley_prod'                                                      ;
wk_from                 := 'W20130406-143708'                                                   ;
wk_to                   := 'W20130502-232519'                                                   ;
jobwildcard             := 'BIPV2*'                                                             ;
jobregex                := '^(?!.*?(BIPV2[ _]Proxid[ _]dev).*).*$'                              ;
FilesReadRegexFilter    := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID|dot).*$'    ;
FilesWrittenRegexFilter := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID.*base).*$'  ;
OutputFilename          := BIPV2_ProxID.filenames(pversion).wkhistory.logical                   ;
NumRecords              := 150                                                                  ;
lOverwrite              := true                                                                 ; 
archived                := false                                                                ;
ShouldRestore           := false                                                                ;
OutputEcl               := false                                                                ;
createsummaryreport := wk_ut.mac_CreateSummaryReport ( 
   pversion
  ,wk_from 
  ,wk_to
  ,jobowner
  ,''
  ,[jobwildcard,jobregex]
  ,['MatchesPerformed','PreClusterCount','PostClusterCount']
  ,[
     'ConfidenceLevels'  ,'{UNSIGNED2 Conf,UNSIGNED MatchesFound}'
    ,'ValidityStatistics','{INTEGER PatchingError0, INTEGER DidsNoRid0, INTEGER DidsAboveRid0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0}'
    ,'RuleEfficacy'      ,'{UNSIGNED2 RuleNumber;STRING Rule;UNSIGNED MatchesFound ;}'
   ]
  ,['AllSamplesCands']
  ,['Iteration']
  ,['regexfind(\'iter ([[:digit:]]+)\',left.job,1,nocase)']
  ,pNumRecords              := NumRecords
  ,pFilesReadRegexFilter    := FilesReadRegexFilter   
  ,pFilesWrittenRegexFilter := FilesWrittenRegexFilter
  ,pOutputFilename          := OutputFilename
  ,pOverwrite               := lOverwrite    
  ,parchived                := archived      
  ,pOutputEcl               := OutputEcl     
  ,pShouldRestore           := ShouldRestore 
); 
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 2. Filter for only latest completed workunit per iteration
////////////////////////////////////////////////////////////////////////////////////////////////////////
dWks := sort(dedup(sort(BIPV2_ProxID.Files(pversion).wkhistory.logical(iteration != '',version = pversion,(unsigned)matchesperformed != 0                  ),iteration,-wuid),iteration),(unsigned)iteration);
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 3. Take above dataset combined with Feedback from Review Samples(checked, bads & questionables) and create dataset with raw materials for precision calculation
// --    Run after get feedback from review samples.  Total up all iterations at once, then pass all in, or do one at a time and make sure to only pass in 1 at a time.
// --    use <version>_<iteration> to pass in.  i.e. 20130521_35.  If they are in the qa superfile, u can just filter the superfile for that version to get them all.
////////////////////////////////////////////////////////////////////////////////////////////////////////
checked           := 178;
bads              := 4;
quests            := 0;
dsetupprecision   := wk_ut.mac_SetupPrecision(dWks,checked,bads,quests);
w1                := tools.macf_writefile(BIPV2_ProxID.filenames(pversion).precision.logical ,dsetupprecision ,pOverwrite := true);
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 4. Execute below.  Passing in empty set because it will output the code with the set that should be passed in.
// --    Once all iterations for the build are finished, run this on the above dataset to construct the set to pass into the second call to this macro.
////////////////////////////////////////////////////////////////////////////////////////////////////////
setprecision := wk_ut.mac_SALT_Precision(dsetupprecision,[],false);
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 5. Copy the output of the above call, and paste it below and run it.  It will output the precision worksheet and the precision itself.
////////////////////////////////////////////////////////////////////////////////////////////////////////
setiters := ['20130521','35','20130521','34','20130521','33','20130521','32','20130521','31','20130521','30','20130330','29','20130330','27','20130330','26','20130330','25','20130212','24','20130212','23','20130212','22','20130212','21','20130212','20','20130212','19','20130212','18','20130212','17','20130212','16','20130212','15','20130212','14','20130212','13','20130212','12','20130212','11','20130212','10','20130212','9','20130212','8','20130212','7','20130212','6','20130212','5','20130212','4','20130212','3','20130212','2','20130212','1'];
doprecision := wk_ut.mac_SALT_Precision(BIPV2_ProxID.files(pversion).precision.logical,setiters,false);
sequential(
   createsummaryreport
  ,w1  
  ,setprecision
  ,doprecision
  ,parallel(
     BIPV2_ProxID.Promote(pversion,'precision|wkhistory').new2qamult
  )
);
