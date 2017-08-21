export Mod_Data := MODULE

//////////////////// Layouts ///////////////////////////////

EXPORT	Layout_Scores := RECORD
			Types.FromType 	From;
			Types.FromType 	To;
			REAL4 oneOverLinkCount := 1;
			//
			// Each row's score will be computed using the following:
			// oneMinusAlpha + alpha(Rx.Score*Rx.oneOverLinkCount + Ry.Score*Ry.oneOverLinkCount....)
			//
			// Types.ScoreType Score := Constants.oneMinusAlpha;
			Types.ScoreType Vote := 0;
	END;
	
EXPORT Layout_RawGraphData := RECORD
		Types.FromType From;
		Types.ToType To;
	END;
//
// This is the layout used to represent the results of the first JOIN.
//
EXPORT Layout_GraphData := RECORD(Layout_RawGraphData)
		INTEGER	ToLinkCount;
		Types.ScoreType ToCurrentScore;	
END;

EXPORT Layout_SandiaRaw := RECORD(Layout_RawGraphData)
		REAL4 percent;		// This represents one over the Link Count.
END;

////////////////////////// File name extensions //////////////////

EXPORT TenGigExtension := 'TenGig';
EXPORT PDataExtension := 'P';
EXPORT TerabyteExtension := 'Terabyte';

////////////////////////// Files /////////////////////////////

EXPORT File_RawData := DATASET(Filenames.RawData,Layout_RawGraphData, CSV(SEPARATOR('->')));
EXPORT File_StdSampleData(STRING filename = Filenames.StdSampleData) := DATASET(filename, Layout_RawGraphData, THOR);

EXPORT File_SandiaRawData(STRING filename = Filenames.P_RawData, INTEGER headerCnt = 0) := 
																	DATASET(filename,Layout_SandiaRaw, CSV(SEPARATOR(' '),HEADING(headerCnt)));
																	
EXPORT File_Raw_Sandia_Nice := 	File_SandiaRawData(Filenames.NiceRawData,0);															
EXPORT File_Raw_Sandia_Nasty := 	File_SandiaRawData(Filenames.NastyRawData,0);
EXPORT File_Raw_Sandia_P := 	File_SandiaRawData(Filenames.P_RawData,1);	
//
// The 1 million Python rows converted to Sandia format.
//
EXPORT File_Sandia_P  := DATASET(Filenames.Sandia_P, Layout_SandiaRaw, THOR);
EXPORT File_SeedData := DATASET(Filenames.RawDataInSandiaFormat, Layout_SandiaRaw, THOR);
EXPORT File_TenGigs := 	DATASET(Filenames.TenGigSampleData, Layout_SandiaRaw, THOR);	
EXPORT File_TeraByte := DATASET(Filenames.TerabyteSampleData, Layout_SandiaRaw, THOR);

// EXPORT File_ResolvedIds(STRING extension =  TenGigExtension):= DATASET(Filenames.ResolvedIds + extension, Layout_Scores, THOR);														
// EXPORT File_UniqueIdInfo(STRING extension =  TenGigExtension):= DATASET(Filenames.UniqueIdInfo + extension, Layout_Scores, THOR);

END;