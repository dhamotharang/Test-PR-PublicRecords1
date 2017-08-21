// BWR_BuildSandiaDataFile
//
#WORKUNIT('name','BuildTerabyteData');
//
//
// NOTE: This will generate a terabyte of data on the system.
//
dsSeedData := DATASET(PageRank.Filenames.RawDataInSandiaFormat, PageRank.Mod_Data.Layout_SandiaRaw, THOR);
	Gigs := 1024;
	destFilename := PageRank.Filenames.TerabyteSampleData;
	
	Multiplier := 54 * Gigs;		// number of records to fabricate. 54 should produce just over a gig. of data based upon the one million I started with.
	fudegfactor := 1000000;		// one million since the original data had 950K+ unique "from" values.

	PageRank.Mod_Data.Layout_SandiaRaw Fabricate(PageRank.Mod_Data.Layout_SandiaRaw l, INTEGER c) := TRANSFORM
		SELF.From := l.from + (fudegfactor*c);
		SELF.To := l.To + (fudegfactor*c);
		SELF := l;
	END;

	dsNewRecords := Normalize(dsSeedData, Multiplier,Fabricate(LEFT,COUNTER));
	
	// Note, nothing special, such as sort or distribution is being done with the data file.
	// This can be tested later.
	dsAllNewRecords := dsSeedData+dsNewRecords;
	OUTPUT(dsAllNewRecords,, destFilename, OVERWRITE);