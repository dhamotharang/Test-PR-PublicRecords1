//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID_mj6_PlatForm.BWR_Iterate - Internal Linking - SALT V3.0 Beta 2');
IMPORT BIPV2_ProxID_mj6_PlatForm,SALT30;
IMPORT SALTTOOLS30;
//BIPV2_ProxID_mj6_PlatForm.Specificities(BIPV2_ProxID_mj6_PlatForm.In_DOT_Base).Build; // Used to create callibration keys
//Proc_Iterate also supports a dataset parameter to allow an arbitrary file as starting point.
//Proc_Iterate also supports a threshold parameter to override the default threshold.
// If the debugging parameter is set to off the build will go a little quicker but the debug services (such as the compare service) will not be available.
P := BIPV2_ProxID_mj6_PlatForm.Proc_Iterate('1'); // Change '1' for later iterations
P.DoAll; // Change '1' for subsequent iterations
// P.DoAllAgain; // Use this version to re-run an iteration
// If IdConsistency0 has problems then you should run THIS to see if the input was valid
// P.InputValidityStats;
//MAC_MatchSamplePatterns is a tool that generates match/mismatch patterns based on the content of the Keys.MatchSample file.
//Patterns consist of field names, with or without minus sign, where the minus sign identifies mismatch fields.
//SALT30.MAC_MatchSamplePatterns(BIPV2_ProxID_mj6_PlatForm.Keys(BIPV2_ProxID_mj6_PlatForm.In_DOT_Base).MatchSample,MatchPatterns,Proxid1,Proxid2,8,35-41);
//OUTPUT(MatchPatterns,named('match_patterns'));
 
//MAC_GetSALTReviewSamples is a tool that generates Internal Linking review samples. To use this tool, please define
//reviewers (as a set), the number of review samples to be allocated to every reviewer, and the threshold.
 
//Reviewers:=['Reviewer1','Reviewer2']; // e.g. ['EM','DB']
//NumSamplesPerReviewer:=20;
//ConfThreshold:=38;
//ReviewSamples:=SALTTOOLS30.MAC_GetSALTReviewSamples(BIPV2_ProxID_mj6_PlatForm.Keys(BIPV2_ProxID_mj6_PlatForm.In_DOT_Base).MatchSample,BIPV2_ProxID_mj6_PlatForm.Keys(BIPV2_ProxID_mj6_PlatForm.In_DOT_Base).Candidates,BIPV2_ProxID_mj6_PlatForm.In_DOT_Base,Proxid,ConfThreshold,NumSamplesPerReviewer,Reviewers);
//ReviewSamples;
