//Executable code
IMPORT SALT34;
EXPORT Proc_Iterate(STRING iter,DATASET(Layout_in_file) InFile0 = Scrubs_Corp2_Mapping_GA_Main.In_in_file,STRING OutFileNameP = '~temp::::Scrubs_Corp2_Mapping_GA_Main::it',UNSIGNED MatchThreshold = Config.MatchThreshold,BOOLEAN Debugging = true) := MODULE
SHARED InFile := InFile0;
SHARED MM := Scrubs_Corp2_Mapping_GA_Main.matches(InFile,MatchThreshold); // Get the matching module
OSR := OUTPUT(CHOOSEN(MM.MatchSampleRecords,10000),NAMED('MatchSampleRecords'));
OSL := OUTPUT(CHOOSEN(MM.ToSlice,1000),NAMED('SliceOutCandidates'));
EXPORT OutputSamples := PARALLEL(OSR,OSL);// Provide the records!
SHARED BM := Scrubs_Corp2_Mapping_GA_Main.BasicMatch(InFile);
BMS := OUTPUT(CHOOSEN(BM.patch_file, 1000), NAMED('BasicMatch_Patch_File'));
OMatchSamples := OUTPUT(CHOOSEN(MM.MatchSample,1000),NAMED('MatchSample'));
OBSamples := OUTPUT(CHOOSEN(MM.BorderlineMatchSample,10000),NAMED('BorderlineMatchSample'));
OAS := OUTPUT(CHOOSEN(MM.AlmostMatchSample,10000),NAMED('AlmostMatchSample'));
EXPORT OutputExtraSamples := PARALLEL(OMatchSamples, OBSamples, OAS, BMS); // This is not called automatically - call yourself if you want them!
OS := OUTPUT(Scrubs_Corp2_Mapping_GA_Main.specificities(InFile).specificities,NAMED('Specificities'));
PRPPS := OUTPUT(MM.PreIds.IdCounts,NAMED('PreClusterCount'));
PRPP := OUTPUT(MM.PreIds._Clusters,NAMED('PreClusters'),ALL);
PPPS := OUTPUT(MM.PostIds.IdCounts,NAMED('PostClusterCount'));
PPP := OUTPUT(MM.PostIds._Clusters,NAMED('PostClusters'),ALL);
MPSP := OUTPUT(DATASET([{'MatchesPerformed', MM.MatchesPerformed}, {'BasicMatchesPerformed', Scrubs_Corp2_Mapping_GA_Main.BasicMatch(InFile).basic_match_count}, {'SlicesPerformed', MM.SlicesPerformed}], {STRING label, UNSIGNED value}), NAMED('MatchStatistics'));
PS := OUTPUT(DATASET([{'PropagationAssisted_Pcnt', MM.MatchesPropAssisted * 100 / MM.MatchesPerformed}, {'PropagationRequired_Pcnt', MM.MatchesPropRequired * 100 / MM.MatchesPerformed}], {STRING label, UNSIGNED Pcnt}), NAMED('PropogationStats'));
RE := OUTPUT(TOPN(MM.RuleEfficacy,1000,RuleNumber),NAMED('RuleEfficacy'));
CB := OUTPUT(TOPN(MM.ConfidenceBreakdown,1000,conf),NAMED('ConfidenceLevels'));
SpcS := OUTPUT(Scrubs_Corp2_Mapping_GA_Main.specificities(InFile).SpcShift,NAMED('SPCShift'));
EXPORT ExecutionStats := PARALLEL(OS,SpcS,PRPP,PPP,PRPPS,PPPS,MPSP,RE,CB, PS);
d := DATASET([{MM.PatchingError0,MM.DuplicateRids0,COUNT(Scrubs_Corp2_Mapping_GA_Main.match_candidates(InFile).Unlinkables)}],{INTEGER PatchingError0, INTEGER DuplicateRids0, UNSIGNED UnlinkableRecords0});
EXPORT ValidityStats := PARALLEL( OUTPUT(d,NAMED('ValidityStatistics')), OUTPUT(MM.PostIds.Advanced0,NAMED('IdConsistency0')));
EXPORT InputValidityStats := OUTPUT(MM.PreIds.Advanced0,NAMED('InputIdConsistency0'));
EXPORT DebugKeys := Keys(InFile).BuildAll;
EXPORT OutputFileName := OutFileNameP+iter;
EXPORT OutputFile := OUTPUT(MM.patched_infile,,OutputFileName,COMPRESSED);// Change file for each iteration
EXPORT OutputFileA := OUTPUT(MM.patched_infile,,OutputFileName,OVERWRITE,COMPRESSED);// Change file for each iteration
//EXPORT LoopN(UNSIGNED N,UNSIGNED mt=Config.MatchThreshold) := LOOP(InFile,N,Scrubs_Corp2_Mapping_GA_Main.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//EXPORT LoopThisN(d,N,mt=Config.MatchThreshold,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT Scrubs_Corp2_Mapping_GA_Main;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,Scrubs_Corp2_Mapping_GA_Main.Layout_in_file),N,Scrubs_Corp2_Mapping_GA_Main.matches(ROWS(LEFT),mt).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,Scrubs_Corp2_Mapping_GA_Main.Layout_in_file),N,Scrubs_Corp2_Mapping_GA_Main.matches(ROWS(LEFT),mt).patched_infile), LEFT.=RIGHT., TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
//EXPORT LoopThisK(d,K,NMax=100,ThinLoop=FALSE) := FUNCTIONMACRO
//	IMPORT Scrubs_Corp2_Mapping_GA_Main;
//	#IF (ThinLoop=FALSE)
//		RETURN LOOP(PROJECT(d,Scrubs_Corp2_Mapping_GA_Main.Layout_in_file),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),,ALL))>K,Scrubs_Corp2_Mapping_GA_Main.matches(ROWS(LEFT),0).patched_infile);
//	#ELSE
//		RETURN JOIN(d, LOOP(PROJECT(d,Scrubs_Corp2_Mapping_GA_Main.Layout_in_file),COUNTER<=NMax AND COUNT(DEDUP(ROWS(LEFT),,ALL))>K,Scrubs_Corp2_Mapping_GA_Main.matches(ROWS(LEFT),0).patched_infile), LEFT.=RIGHT., TRANSFORM(RECORDOF(LEFT),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
//	#END
//ENDMACRO;
SHARED LinkPhase(BOOLEAN again) := SEQUENTIAL(PARALLEL(OutputSamples,ExecutionStats,ValidityStats,IF(again,OutputFileA,OutputFile) ),IF(Debugging,DebugKeys));
EXPORT DoAll := LinkPhase(FALSE);
EXPORT DoAllAgain := LinkPhase(TRUE);
END;
