import versioncontrol, business_header;

//Executable code
export Proc_Iterate(
	 string									iter
	,dataset(Layout_BH_BDL)	pDataset	= Business_Header.BH_BDL2()
	,string									pversion 	= ''	
) := module

OMatchSamples := output(choosen(Business_Header_BDL2.matches(pDataset).MatchSample,1000),named('BDL_SALT_MatchSample'));
OBSamples := output(choosen(Business_Header_BDL2.matches(pDataset).BorderlineMatchSample,10000),named('BDL_SALT_BorderlineMatchSample'));
OAS := output(choosen(Business_Header_BDL2.matches(pDataset).AlmostMatchSample,10000),named('BDL_SALT_AlmostMatchSample'));
OSR := output(choosen(Business_Header_BDL2.matches(pDataset).MatchSampleRecords,10000),named('BDL_SALT_MatchSampleRecords'));
//export OutputSamples := PARALLEL(OMatchSamples,OBSamples,OAS,OSR);
export OutputSamples := PARALLEL(OSR);// Most people only want the records!
OS := output(Business_Header_BDL2.specificities(pDataset).specificities,named('BDL_SALT_Specificities'));
PRPP := output(Business_Header_BDL2.matches(pDataset).PreClusters,named('BDL_SALT_PreClusters'));
PPP := output(Business_Header_BDL2.matches(pDataset).PostClusters,named('BDL_SALT_PostClusters'));
MP := output(Business_Header_BDL2.matches(pDataset).MatchesPerformed,named('BDL_SALT_MatchesPerformed'));
MPPA := output(Business_Header_BDL2.matches(pDataset).MatchesPropAssisted * 100 / Business_Header_BDL2.matches(pDataset).MatchesPerformed,named('BDL_SALT_PropagationAssisted_Pcnt'));
MPPR := output(Business_Header_BDL2.matches(pDataset).MatchesPropRequired * 100 / Business_Header_BDL2.matches(pDataset).MatchesPerformed,named('BDL_SALT_PropagationRequired_Pcnt'));
RE := output(TopN(matches(pDataset).RuleEfficacy,1000,RuleNumber),named('BDL_SALT_RuleEfficacy'));
CB := output(TopN(matches(pDataset).ConfidenceBreakdown,1000,conf),named('BDL_SALT_ConfidenceLevels'));
export ExecutionStats := PARALLEL(OS,PRPP,PPP,MP,RE,CB,MPPA,MPPR);
d := dataset([{Business_Header_BDL2.matches(pDataset).PatchingError0,Business_Header_BDL2.matches(pDataset).DidsNoRid0,Business_Header_BDL2.matches(pDataset).DidsAboveRid0,Business_Header_BDL2.matches(pDataset).DuplicateRids0,count(Business_Header_BDL2.match_candidates(pDataset).Unlinkables)}],{integer PatchingError0, integer DidsNoRid0, integer DidsAboveRid0, integer DuplicateRids0, unsigned UnlinkableRecords0});
export ValidityStats := output(d,named('BDL_SALT_ValidityStatistics'));

VersionControl.macBuildNewLogicalKey(keys(pDataset,pversion).candidates        ,KC 												);
VersionControl.macBuildNewLogicalKey(keys(pDataset,pversion).MatchSample       ,KS 												);
VersionControl.macBuildNewLogicalKey(keys(pDataset,pversion).Specificities_Key ,KSS	,pOne_node	:= true		);

export DebugKeys := parallel(KC,KS,KSS);
export OutputCandidates := buildindex(keys(pDataset, pversion).PatchedCandidates,overwrite);

VersionControl.macBuildNewLogicalFile(business_header.Filenames(pversion).base.BDL2.new +'::itr'+iter	,Business_Header_BDL2.matches(pDataset).patched_infile	,OutputFile	);
VersionControl.macBuildNewLogicalFile(business_header.Filenames(pversion).base.BDL2.new	,Business_Header_BDL2.matches(pDataset).patched_infile	,OutputFile1	);
VersionControl.macBuildNewLogicalFile(business_header.Filenames(pversion).base.BDL2.new +'::itr'+iter	,Business_Header_BDL2.matches(pDataset).patched_infile	,OutputFileA	,,true);
//export OutputFile  := output(Business_Header_BDL2.matches(pDataset).patched_infile,,_dataset().thor_cluster_persists + 'base::Business_Header_BDL2::it'+iter);// Change file for each iteration
//export OutputFileA := output(Business_Header_BDL2.matches(pDataset).patched_infile,,_dataset().thor_cluster_persists + 'base::Business_Header_BDL2::it'+iter,overwrite);// Change file for each iteration
//export LoopN(unsigned N,unsigned mt=37) := LOOP(pDataset,N,Business_Header_BDL2.matches(ROWS(LEFT),mt).patched_infile); // Loop N times
//export LoopThisN(dataset(Business_Header_BDL2.Layout_BH_BDL)d,unsigned N,unsigned mt=37) := LOOP(d,N,Business_Header_BDL2.matches(ROWS(LEFT),mt).patched_infile);
//export LoopThisK(dataset(Business_Header_BDL2.Layout_BH_BDL)d,unsigned K,unsigned NMax=100) := LOOP(d,COUNTER<=NMax AND count(dedup(rows(left),BDL,all))>K,Business_Header_BDL2.matches(ROWS(LEFT),0).patched_infile); // Loop until K clusters left
export OutputDataset := business_header_BDL2.matches(pDataset).patched_infile;
export mydsgoodmatches := keys(pDataset,pversion).MatchSample(conf >= 50);
export GoodMatchSamplesCount			:= output(count		(mydsgoodmatches					), named('BDL_SALT_GoodMatchSamplesCount'));
export GoodMatchSamplesFirst1000	:= output(choosen	(mydsgoodmatches, 1000, 1	), named('BDL_SALT_GoodMatchSamplesFirst1000'),all);
export hygienestats := output(hygiene(pDataset).ValidityErrors, named('BDL_SALT_HygieneStats'), all);
export DoAll  := if(not VersionControl.DoAllFilesExist.fNamesBuilds(keynames(pversion).dall_filenames_build)
                    ,sequential(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,OutputCandidates)
									 );
export DoAll2 := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile,GoodMatchSamplesCount,GoodMatchSamplesFirst1000, hygienestats);
export DoAll3 := PARALLEL(if(not VersionControl.DoAllFilesExist.fNamesBuilds(keynames(pversion).dall_filenames_build + business_header.Filenames(pversion).base.dall_filenames)
										,sequential(
												OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFile1,GoodMatchSamplesCount,GoodMatchSamplesFirst1000, hygienestats
										)
									));
export DoAllAgain := PARALLEL(OutputSamples,ExecutionStats,ValidityStats,DebugKeys,OutputFileA,OutputCandidates);
end;