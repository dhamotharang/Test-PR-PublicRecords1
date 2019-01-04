pversion   := '20130717a';
piteration := '36';
checked    := 105;
bads       := 2;
quests     := 0;
combo      := pversion + '_' + piteration;
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 2. Filter for only latest completed workunit per iteration
////////////////////////////////////////////////////////////////////////////////////////////////////////
dWks := sort(dedup(sort(BIPV2_ProxID.Files(combo).wkhistory.logical(iteration != '' ,version = pversion ,(unsigned)matchesperformed != 0),iteration,-wuid),iteration),(unsigned)iteration);
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 3. Take above dataset combined with Feedback from Review Samples(checked, bads & questionables) and create dataset with raw materials for precision calculation
// --    Run after get feedback from review samples.  Total up all iterations at once, then pass all in, or do one at a time and make sure to only pass in 1 at a time.
// --    use <version>_<iteration> to pass in.  i.e. 20130521_35.  If they are in the qa superfile, u can just filter the superfile for that version to get them all.
////////////////////////////////////////////////////////////////////////////////////////////////////////
dsetupprecision   := wk_ut.mac_SetupPrecision(dWks,checked,bads,quests);
writefile         := tools.macf_writefile(BIPV2_ProxID.filenames(combo).precision.logical ,dsetupprecision ,pOverwrite := true,pCompress := false);
sequential(
   writefile
  ,BIPV2_ProxID.Promote(combo,'precision').new2qamult
);
