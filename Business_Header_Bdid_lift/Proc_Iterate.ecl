//Executable code
import versioncontrol, business_header;

//Executable code
export Proc_Iterate(

	 string																iter
	,dataset(Layout_file_business_header)	pDataset	= Business_Header.BH_Basic_Match_FEIN()
	,string																pversion 	= ''

) := module

OMatchSamples := output(choosen(Business_Header_Bdid_lift.matches(pDataset).MatchSample,1000),named('Bdid_SALT_MatchSample'));
OBSamples := output(choosen(Business_Header_Bdid_lift.matches(pDataset).BorderlineMatchSample,10000),named('Bdid_SALT_BorderlineMatchSample'));
OAS := output(choosen(Business_Header_Bdid_lift.matches(pDataset).AlmostMatchSample,10000),named('Bdid_SALT_AlmostMatchSample'));
OSR := output(choosen(Business_Header_Bdid_lift.matches(pDataset).MatchSampleRecords,10000),named('Bdid_SALT_MatchSampleRecords'));
//export OutputSamples := PARALLEL(OMatchSamples,OBSamples,OAS,OSR);
export OutputSamples := PARALLEL(OSR);// Most people only want the records!
OS := output(Business_Header_Bdid_lift.specificities(pDataset).specificities,named('Bdid_SALT_Specificities'));
OPRP := output(Business_Header_Bdid_lift.match_candidates(pDataset).prepropogationstats,named('Bdid_SALT_PrePopStats'));
OPP := output(Business_Header_Bdid_lift.match_candidates(pDataset).postpropogationstats,named('Bdid_SALT_PostPopStats'));
PRPP := output(Business_Header_Bdid_lift.matches(pDataset).PreClusters,named('Bdid_SALT_PreClusters'));
PPP := output(Business_Header_Bdid_lift.matches(pDataset).PostClusters,named('Bdid_SALT_PostClusters'));
MP := output(Business_Header_Bdid_lift.matches(pDataset).MatchesPerformed,named('Bdid_SALT_MatchesPerformed'));
MPPA := output(Business_Header_Bdid_lift.matches(pDataset).MatchesPropAssisted * 100 / Business_Header_Bdid_lift.matches(pDataset).MatchesPerformed,named('Bdid_SALT_PropagationAssisted_Pcnt'));
MPPR := output(Business_Header_Bdid_lift.matches(pDataset).MatchesPropRequired * 100 / Business_Header_Bdid_lift.matches(pDataset).MatchesPerformed,named('Bdid_SALT_PropagationRequired_Pcnt'));
RE := output(TopN(matches(pDataset).RuleEfficacy,1000,RuleNumber),named('Bdid_SALT_RuleEfficacy'));
CB := output(TopN(matches(pDataset).ConfidenceBreakdown,1000,conf),named('Bdid_SALT_ConfidenceLevels'));
export ExecutionStats := PARALLEL(OS,OPRP,OPP,PRPP,PPP,MP,RE,CB,MPPA,MPPR);
d := dataset([{Business_Header_Bdid_lift.matches(pDataset).PatchingError0,Business_Header_Bdid_lift.matches(pDataset).DidsNoRid0,Business_Header_Bdid_lift.matches(pDataset).DidsAboveRid0,Business_Header_Bdid_lift.matches(pDataset).DuplicateRids0,count(Business_Header_Bdid_lift.match_candidates(pDataset).Unlinkables)}],{integer PatchingError0, integer DidsNoRid0, integer DidsAboveRid0, integer DuplicateRids0, unsigned UnlinkableRecords0});
export ValidityStats := output(d,named('Bdid_SALT_ValidityStatistics'));

VersionControl.macBuildNewLogicalKey(keys(pDataset,pversion).candidates					,KC 												);
VersionControl.macBuildNewLogicalKey(keys(pDataset,pversion).MatchSample				,KS 												);
VersionControl.macBuildNewLogicalKey(keys(pDataset,pversion).Specificities_Key	,KSS	,pOne_node	:= true		);

export DebugKeys := parallel(KC,KS,KSS);

export OutputCandidates := buildindex(keys(pDataset, pversion).PatchedCandidates,overwrite);
export OutputFile := output(Business_Header_Bdid_lift.matches(pDataset).patched_infile,	,_dataset().thor_cluster_persists + 'base::BDID::Business_Header_Bdid_lift::it'+iter);// Change file for each iteration
export OutputFileA := output(Business_Header_Bdid_lift.matches(pDataset).patched_infile,,_dataset().thor_cluster_persists + 'base::BDID::Business_Header_Bdid_lift::it'+iter,overwrite);// Change file for each iteration
export OutputDataset := business_header_bdid_lift.matches(pDataset).patched_infile;
export mydsgoodmatches := keys(pDataset,pversion).MatchSample(conf >= 50);
export GoodMatchSamplesCount			:= output(count		(mydsgoodmatches					), named('Bdid_SALT_GoodMatchSamplesCount'));
export GoodMatchSamplesFirst1000	:= output(choosen	(mydsgoodmatches, 1000, 1	), named('Bdid_SALT_GoodMatchSamplesFirst1000'),all);
export hygienestats := output(hygiene(pDataset).ValidityErrors, named('Bdid_SALT_HygieneStats'), all);
export DoAll := if(not VersionControl.DoAllFilesExist.fNamesBuilds(keynames(pversion).dall_filenames_build)
									,sequential(
										OutputSamples,ExecutionStats,ValidityStats,DebugKeys,GoodMatchSamplesCount,GoodMatchSamplesFirst1000, hygienestats)
								);
export DoAll2 := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,GoodMatchSamplesCount,GoodMatchSamplesFirst1000, hygienestats);
export DoAllAgain := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFileA,OutputCandidates);
end;
