// BWR_FindpageStats
//


originalSrcData := PageRank.Mod_Data.File_TenGigs;
persistExtension := PageRank.Mod_Data.TenGigExtension;

#WORKUNIT('name', 'GenerateStatsFor' + persistExtension);

OUTPUT(COUNT(originalSrcData),named('RowCount'));

tab1 := TABLE(originalSrcData, {id := from, INTEGER idCnt := COUNT(GROUP)}, from,many);
tab2 := TABLE(originalSrcData, {id := to, INTEGER idCnt := COUNT(GROUP)}, to,many);
tab3 := TABLE(tab1+tab2, {id, INTEGER totalIdCnt := COUNT(GROUP)}, id, many);

OUTPUT(COUNT(tab1), named('UniqueFromIds'));
OUTPUT(COUNT(tab2), named('UniqueToIds'));
OUTPUT(COUNT(tab3), named('UniqueIds'));