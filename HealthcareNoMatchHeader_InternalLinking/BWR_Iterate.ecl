//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_InternalLinking.BWR_Iterate - Internal Linking - SALT V3.11.7');
/*HACK-O-MATIC*/IMPORT SALT311,HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest,STD,versioncontrol;
//HealthcareNoMatchHeader_InternalLinking.Specificities(HealthcareNoMatchHeader_InternalLinking.In_HEADER).Build; // Used to create calibration keys
// Proc_Iterate also supports a dataset parameter to allow an arbitrary file as starting point.
// Proc_Iterate also supports a threshold parameter to override the default threshold.
// If the debugging parameter is set to off the build will go a little quicker but the debug services (such as the compare service) will not be available.
pSrc :=  '00000099';
// pSrc :=  '16935732';
pVersion :=  (STRING)STD.Date.Today();
pIter :=  '1';
/*HACK-O-MATIC*/P := HealthcareNoMatchHeader_InternalLinking.Proc_Iterate(pSrc,pVersion,pIter); // Change '1' for later iterations
/*HACK-O-MATIC*/doAll := P.DoAll; // Use this version to run an iteration
/*HACK-O-MATIC*/dAll_filenames  :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Keys.dAll_filenames+
/*HACK-O-MATIC*/										HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking(pIter).dAll_filenames;
/*HACK-O-MATIC*/SEQUENTIAL(
/*HACK-O-MATIC*/	versioncontrol.mUtilities.createsupers(dAll_filenames),
/*HACK-O-MATIC*/	doAll,
/*HACK-O-MATIC*/	HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion, 'key').buildfiles.New2Built,
/*HACK-O-MATIC*/	HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion, 'key').buildfiles.Built2QA,
/*HACK-O-MATIC*/	HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,pIter).linkingfiles.New2Built,
/*HACK-O-MATIC*/	HealthcareNoMatchHeader_Ingest.Promote(pSrc, pVersion,,pIter).linkingfiles.Built2QA,
/*HACK-O-MATIC*/	HealthcareNoMatchHeader_InternalLinking.Proc_Stats(pSrc, HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).Linking(pIter).Iteration)
/*HACK-O-MATIC*/)

// P.DoAllAgain; // Use this version to re-run an iteration
 
// If IdConsistency0 has problems then you should run THIS to see if the input was valid
// P.InputValidityStats;
 
// MAC_MatchSamplePatterns is a tool that generates match/mismatch patterns based on the content of the Keys.MatchSample file.
// Patterns consist of field names, with or without minus sign, where the minus sign identifies mismatch fields.
// NOTE: It must run after Proc_Iterate.DoAll completes, so use SEQUENTIAL or a separate workunit.
// SALT311.MAC_MatchSamplePatterns(HealthcareNoMatchHeader_InternalLinking.Keys(HealthcareNoMatchHeader_InternalLinking.In_HEADER).MatchSample,MatchPatterns,nomatch_id1,nomatch_id2,8,42-48);
// OutMatchPatterns := OUTPUT(MatchPatterns,named('match_patterns'));
// OutMatchPatterns;
 
// MAC_GetSALTReviewSamples is a tool that generates Internal Linking review samples. To use this tool, please define
// reviewers (as a set), the number of review samples to be allocated to every reviewer, and the threshold.
// NOTE: It must run after Proc_Iterate.DoAll completes, so use SEQUENTIAL or a separate workunit.
// IMPORT SALTTOOLS30;
// Reviewers:=['Reviewer1','Reviewer2']; // e.g. ['EM','DB']
// NumSamplesPerReviewer:=20;
// ConfThreshold:=45;
// ReviewSamples:=SALTTOOLS30.MAC_GetSALTReviewSamples(HealthcareNoMatchHeader_InternalLinking.Keys(HealthcareNoMatchHeader_InternalLinking.In_HEADER).MatchSample,HealthcareNoMatchHeader_InternalLinking.Keys(HealthcareNoMatchHeader_InternalLinking.In_HEADER).Candidates,HealthcareNoMatchHeader_InternalLinking.In_HEADER,nomatch_id,ConfThreshold,NumSamplesPerReviewer,Reviewers);
// ReviewSamples;
 
// Run all three in a single workunit - but don't forget to comment-out the individual actions above to avoid conflict
// SEQUENTIAL(P.DoAllAgain, OutMatchPatterns, ReviewSamples);
