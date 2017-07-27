//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_EmpID.BWR_Iterate - Internal Linking - SALT V3.2.0');
IMPORT BIPV2_EmpID,SALT32;
IMPORT SALTTOOLS30;
//BIPV2_EmpID.Specificities(BIPV2_EmpID.In_EmpID).Build; // Used to create calibration keys
// Proc_Iterate also supports a dataset parameter to allow an arbitrary file as starting point.
// Proc_Iterate also supports a threshold parameter to override the default threshold.
// If the debugging parameter is set to off the build will go a little quicker but the debug services (such as the compare service) will not be available.
P := BIPV2_EmpID.Proc_Iterate('1'); // Change '1' for later iterations
P.DoAll; // Use this version to run an iteration
// P.DoAllAgain; // Use this version to re-run an iteration
 
// If IdConsistency0 has problems then you should run THIS to see if the input was valid
// P.InputValidityStats;
 
// MAC_MatchSamplePatterns is a tool that generates match/mismatch patterns based on the content of the Keys.MatchSample file.
// Patterns consist of field names, with or without minus sign, where the minus sign identifies mismatch fields.
// NOTE: It must run after Proc_Iterate.DoAll completes, so use SEQUENTIAL or a separate workunit.
// SALT32.MAC_MatchSamplePatterns(BIPV2_EmpID.Keys(BIPV2_EmpID.In_EmpID).MatchSample,MatchPatterns,EmpID1,EmpID2,8,40-46);
// OutMatchPatterns := OUTPUT(MatchPatterns,named('match_patterns'));
// OutMatchPatterns;
 
// MAC_GetSALTReviewSamples is a tool that generates Internal Linking review samples. To use this tool, please define
// reviewers (as a set), the number of review samples to be allocated to every reviewer, and the threshold.
// NOTE: It must run after Proc_Iterate.DoAll completes, so use SEQUENTIAL or a separate workunit.
// Reviewers:=['Reviewer1','Reviewer2']; // e.g. ['EM','DB']
// NumSamplesPerReviewer:=20;
// ConfThreshold:=43;
// ReviewSamples:=SALTTOOLS30.MAC_GetSALTReviewSamples(BIPV2_EmpID.Keys(BIPV2_EmpID.In_EmpID).MatchSample,BIPV2_EmpID.Keys(BIPV2_EmpID.In_EmpID).Candidates,BIPV2_EmpID.In_EmpID,EmpID,ConfThreshold,NumSamplesPerReviewer,Reviewers);
// ReviewSamples;
 
// Run all three in a single workunit - but don't forget to comment-out the individual actions above to avoid conflict
// SEQUENTIAL(P.DoAllAgain, OutMatchPatterns, ReviewSamples);
