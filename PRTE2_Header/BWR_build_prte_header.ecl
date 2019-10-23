// PRTE2_Header.constants MUST BE SANDBOXED with the _PRTE_BUILD flag set to TRUE for this PRTE builds
// PRTE2_Header.constants MUST BE SANDBOXED with the _PRTE_BUILD flag set to TRUE for this PRTE builds
// PRTE2_Header.constants MUST BE SANDBOXED with the _PRTE_BUILD flag set to TRUE for this PRTE builds

IMPORT std,PRTE2_Header;
#OPTION('multiplePersistInstances',FALSE);

filedate:='20180112'; // modify emptry string for 'a' version or the likes.

#WORKUNIT('name','PRTE Header Build ('+filedate+')');
run_build:=sequential(
                if(PRTE2_Header.constants.PRTE_BUILD=false,fail('PLEASE SET _PRTE_BUILD FLAG TO TRUE'))
                ,PRTE2_Header.proc_build_all(filedate)
              );

update_dops := PRTE2_Header.Proc_build_update_dops(filedate);

// NOTES:
// -------------
// The BWR WILL FAIL TO COMPILE if PRTE2_Header.constants._PRTE_BUILD (line 2) is NOT set to TRUE
// This is a safetly mechanism in addition to the if statement in the sequential action above.
// The build automatically runs 3 workunits which builds all the necessary keys and update the superfiles
// Make sure all 3 workunits have completed BEFORE trying to deploy to DOPS.

// run_build;   // Run run_build FIRST. Once all 3 wuid complete you can run update_dops
// update_dops; // DO NOT put run_build and update_dops in 1 sequential action, all keys might no be ready
