/*
  Custom Forcelink for Proxid and Lgid3.  This will force the clusters together that have the same underlinkid.  MAKE SURE THIS IS CORRECT!
  A good way to make sure it is correct is to run the add candidates for the clusters you want linked, and then run the test forcelink to see if those clusters look ok to be linked(and they are the correct clusters..).
    if they don't look ok, then you can remove them with the remove forcelink bwr.

  Add Forcelink Candidates:
    BIPV2_ForceLink._BWR_Add_Candidates

  Remove ForceLink Candidates(Just removes them from the forcelink file, does not explode clusters):
    BIPV2_ForceLink._BWR_Remove_Candidates

  Test Forcelink(This will show you a deduped version of clusters to be forcelinked to get an idea if it looks right before going into the build):
    BIPV2_ForceLink._BWR_Test_ForceLink

  Initializes the forcelink files from the existing salt underlink files:   
    BIPV2_ForceLink._BWR_Initialize_Candidates

*/