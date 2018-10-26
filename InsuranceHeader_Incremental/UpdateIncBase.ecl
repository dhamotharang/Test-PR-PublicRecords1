IMPORT STD;
EXPORT UpdateIncBase(DATASET(Layout_Header_Plus) dsLinkChange,
                     DATASET(Layout_Header_Plus) dsNewLinked,
										           DATASET(Layout_Header_Plus) dsExisting,
										 STRING versionIn, UNSIGNED timestampIn) := MODULE
										 
	// linked new entity data, projected to include build timestamp
	// filter out did's with more than 10k records 
	EXPORT NewBase := PROJECT(DEDUP(dsNewLinked + dsLinkChange + dsExisting,ALL),
																						TRANSFORM(Layout_Header_Incremental,
																											SELF.buildDateTimeStamp := timestampIn,
																											SELF := LEFT)) (did not in [ 191063834637, 2399102698 , 902377565 ]); 
	
	TAB            := TABLE(DISTRIBUTE(dsLinkChange,HASH(RID)),{dsLinkChange.RID, INTEGER cnt:= COUNT(GROUP)},RID,LOCAL);
	getCnt         := JOIN(DISTRIBUTE(dsLinkChange,HASH(RID)),TAB,LEFT.RID=RIGHT.RID,TRANSFORM({RECORDOF(LEFT),UNSIGNED cnt},SELF:=RIGHT;SELF:=LEFT),LOCAL);
  dsCorrections  := getCnt(cnt > 1);
	dsSuppressions := getCnt(cnt = 1 AND dt_effective_last > 0);
	
	dsCorrecionsNoDupDID := JOIN( dsCorrections , dsSuppressions , LEFT.DID = RIGHT.DID , LEFT ONLY , HASH); 
	
	//////////////////////////////////////
	// stats
	// overall
	// average cluster size
	tClustersNew := TABLE(DISTRIBUTE(dsNewLinked, did), {did, cntRID := COUNT(GROUP)}, did, LOCAL);
	tClustersAll := TABLE(DISTRIBUTE(NewBase, did), {did, cntRID := COUNT(GROUP)}, did, LOCAL);
	
  dsStatsOverall  := DATASET([

															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numRecs_All', COUNT(NewBase), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numEntities_All', COUNT(TABLE(DISTRIBUTE(NewBase, did), {did}, did, LOCAL)), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numRecs_New', COUNT(dsNewLinked), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numEntities_New', COUNT(TABLE(DISTRIBUTE(dsNewLinked, did), {did}, did, LOCAL)), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numRecs_Existing', COUNT(dsExisting), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numEntities_Existing', COUNT(TABLE(DISTRIBUTE(dsExisting, did), {did}, did, LOCAL)), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numRecs_Suppressions', COUNT(dsSuppressions), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numEntities_Suppressions', COUNT(TABLE(DISTRIBUTE(dsSuppressions, did), {did}, did, LOCAL)), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numRecs_Corrections', COUNT(dsCorrections), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'numEntities_Corrections', COUNT(TABLE(DISTRIBUTE(dsCorrecionsNoDupDID, did), {did}, did, LOCAL)), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'averageClusterSize_New', AVE(tClustersNew, cntRID), FALSE},
															{WORKUNIT, versionIn, 0, timestampIn, 'TOTAL', 'averageClusterSize_All', AVE(tClustersAll, cntRID), FALSE}
   	 
														 ], InsuranceHeader_Incremental.Layout_Stats);
														 
	mac_sourcestats(dsIn, statText) := FUNCTIONMACRO
		IMPORT InsuranceHeader_Incremental;
		dsIn_distSrc := DISTRIBUTE(dsIn, did);
		tEntitiesBySrc0 := TABLE(dsIn_distSrc, {srcUse := InsuranceHeader_Incremental.Constants.SrcToUse(src), did}, InsuranceHeader_Incremental.Constants.SrcToUse(src), did, LOCAL);
		tEntitiesBySrc  := TABLE(tEntitiesBySrc0, {srcUse, cntDID := COUNT(GROUP)}, srcUse, MERGE);
		
		dsStatsEntitiesBySrc := PROJECT(tEntitiesBySrc,
																		TRANSFORM(InsuranceHeader_Incremental.Layout_Stats,
																							SELF.wuid := WORKUNIT;
																							SELF.version := versionIn;
																							SELF.iteration := 0;
																							SELF.timeStamp := timestampIn;
																							SELF.src := LEFT.srcUse,
																							SELF.statName := 'numEntities_' + statText + 'ForSource';
																							SELF.statValue := LEFT.cntDID;
																							SELF.ignore := FALSE));
		tRecsBySrc := TABLE(dsIn_distSrc, {srcUse := InsuranceHeader_Incremental.Constants.SrcToUse(src), cntRID := COUNT(GROUP)}, InsuranceHeader_Incremental.Constants.SrcToUse(src),FEW);
		
		dsStatsRecsBySrc  := PROJECT(tRecsBySrc,
																 TRANSFORM(InsuranceHeader_Incremental.Layout_Stats,
																					 SELF.wuid := WORKUNIT;
																					 SELF.version := versionIn;
																					 SELF.iteration := 0;
																					 SELF.timeStamp := timestampIn;
																					 SELF.src := LEFT.srcUse,
																					 SELF.statName := 'numRecs_' + statText + 'ForSource';
																					 SELF.statValue := LEFT.cntRID;
																					 SELF.ignore := FALSE));
																					 
		RETURN dsStatsEntitiesBySrc & dsStatsRecsBySrc;
	ENDMACRO;
	
	// by source for new recs
	dsStatsNewBySrc := mac_sourcestats(dsNewLinked, 'New');
	// by source for updated recs
	dsStatsExistingBySrc := mac_sourcestats(dsExisting, 'Existing');
	// by source for all recs
	dsStatsTotalBySrc := mac_sourcestats(NewBase, 'All');
	
	filenameStats := Filenames.StatsIncBase_LF(versionIn, WORKUNIT);
	
	dsStats := dsStatsOverall & dsStatsNewBySrc & dsStatsExistingBySrc & dsStatsTotalBySrc;
	EXPORT Stats := dsStats;
END;
