// BWR_FabricateRawData
//
#WORKUNIT('name','FabricateRawData');
OUTPUT(PageRank.Mod_Data.File_RawData);

dsLinkCounts := TABLE(PageRank.Mod_Data.File_RawData,{from, INTEGER linkCnts := COUNT(GROUP)}, from, many);

PageRank.Mod_Data.Layout_SandiaRaw SetPercentage(PageRank.Mod_Data.Layout_RawGraphData l,dsLinkCounts r) := TRANSFORM
	SELF.percent := 1/r.linkCnts;
	SELF := l;
END;

dsJ1 := JOIN(PageRank.Mod_Data.File_RawData, dsLinkCounts, LEFT.FROM = RIGHT.From, SetPercentage(LEFT,RIGHT));

OUTPUT(dsJ1,,PageRank.Filenames.RawDataInSandiaFormat,OVERWRITE);