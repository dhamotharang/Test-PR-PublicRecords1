export Filenames := MODULE
	EXPORT FileNameBase := '~thor::pagerank::data::';
	EXPORT RawData:= FileNameBase + 'onemillion_raw';		// Provided by Python script
	EXPORT RawDataInSandiaFormat:= FileNameBase + 'SandiaFormat_raw';		// Provided by Python script
	
	EXPORT NastyRawData:= FileNameBase + 'nasty_raw';
	EXPORT NiceRawData:= FileNameBase + 'nice_raw';
	EXPORT P_RawData:= FileNameBase + 'p_raw';
	
	EXPORT Sandia_P := FileNameBase + 'Sandia_P';
	
	EXPORT StdSandia_P := FileNameBase + 'p_std';
	EXPORT ScoresSeed:= FileNameBase + 'ScoresSeed';
	EXPORT Scores:= FileNameBase + 'Scores';
	EXPORT StdSampleData := FileNameBase + 'SampleData';
	
	EXPORT OneGigSampleData 	:=  FileNameBase + 'OneGigSampleData';
	EXPORT OneGigScoresIndex	:=  FileNameBase + 'OneGigScoresSeed_INDX';
	
	EXPORT TenGigSampleData :=  FileNameBase + 'TenGigSampleData';
	EXPORT TenGigDanglers :=  FileNameBase + 'TenGigDanglers';
	EXPORT TenGigScoresIndex :=  FileNameBase + 'TenGigScoresSeed_INDX';
	
	EXPORT TerabyteSampleData :=  FileNameBase + 'TerabyteSampleData';
	EXPORT TerabyteScoresIndex :=  FileNameBase + 'TerabyteScoresSeed_INDX';
	EXPORT TerabyteSortedRaw :=  FileNameBase + 'TerabyteSortedRaw';
	
	EXPORT Sandia_P_ScoresIndex :=  FileNameBase + 'Sandia_P_ScoresSeed_INDX';
	
	//------- Base File Names		---------------------
	//EXPORT DedupedDanglers := '~thor::pagerank::data::DedupedDanglers_';
	//EXPORT ResolvedIds := '~thor::pagerank::data::ResolvedIds_';
	//EXPORT UniqueIdInfo := '~thor::pagerank::data::UniqueIdInfo_';
	//EXPORT PerPageWork := '~thor::pagerank::data::PerPageWork_';
	EXPORT PassResultsStem := '~thor::pagerank::data::PassResults_';
	
	//----- Persist File Names -----------------
	EXPORT Persist_Danglers := FileNameBase + 'Persist_Danglers_';
	EXPORT Persist_FromPageInfo := FileNameBase + 'Persist_FromPageInfo_';
	EXPORT Persist_DedupedDanglers := FileNameBase + 'Persist_DedupedDanglers_';
	EXPORT Persist_ResolvedIds := FileNameBase + 'Persist_ResolvedIds_';
	EXPORT Persist_UniqueIdInfo := FileNameBase + 'Persist_UniqueIdInfo_';
	EXPORT Persist_PerPageWork := FileNameBase + 'Persist_PerPageWork_';
END;