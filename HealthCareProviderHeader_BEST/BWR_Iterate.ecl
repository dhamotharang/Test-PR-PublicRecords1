//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader_BEST.BWR_Iterate - Internal Linking - SALT V2.9 Beta 3');
IMPORT HealthCareProviderHeader_BEST,SALT29;
//Proc_Iterate also supports a dataset parameter to allow an arbitrary file as starting point.
//Proc_Iterate also supports a threshold parameter to override the default threshold.
// If the debugging parameter is set to off the build will go a little quicker but the debug services (such as the compare service) will not be available.
P := HealthCareProviderHeader_BEST.Proc_Iterate('1'); // Change '1' for later iterations
P.DoAll; // Change '1' for subsequent iterations
// P.DoAllAgain; // Use this version to re-run an iteration
// If IdConsistency0 has problems then you should run THIS to see if the input was valid
// P.InputValidityStats;
//MAC_MatchSamplePatterns is a tool that generates match/mismatch patterns based on the content of the Keys.MatchSample file.
//Patterns consist of field names, with or without minus sign, where the minus sign identifies mismatch fields.
//SALT29.MAC_MatchSamplePatterns(HealthCareProviderHeader_BEST.Keys(HealthCareProviderHeader_BEST.In_HealthProvider).MatchSample,MatchPatterns,LNPID1,LNPID2,8,42-48);
//OUTPUT(MatchPatterns,named('match_patterns'));
