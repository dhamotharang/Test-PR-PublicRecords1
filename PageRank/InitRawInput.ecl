//
// This attribute will return the dataset of rolledup page information pertaining to "from" id's
// available in the raw data. This will be joined with the raw data in order to do the summation.
//
// The dangler scores will be computed last. The non-danglers will be computed as they were
// in the first iteration of the code. The algorithm was straight forward...see the code produced earlier.
//
export InitRawInput(DATASET(Mod_Data.Layout_SandiaRaw) rawSandiaData ,
																	STRING persistExtension = '') := MODULE

SHARED stdRec := Mod_Data.Layout_SandiaRaw;
SHARED resultsRec := Mod_Data.Layout_Scores;
//
// Reformat the original data into something that will work better 
// with the JOINs that need to be done.
//
initialScore := Constants.oneMinusAlpha;

resultsRec ReformatData(stdRec l) := TRANSFORM
	SELF.oneOverLinkCount := l.percent;
	SELF.vote := l.percent*initialScore;
	SELF := l;
END;
//
// Step 1 - Reformat the original data to fit into the layout that will be used with each iteration.
// This gets the data into a reusable format before doing anything else and it gets the "vote" initialized.
//
// Note: PROJECT is local by default.
EXPORT dsReformattedInputData := PROJECT(rawSandiaData,ReformatData(LEFT));

// Note: The distribution is used with the JOIN that will be required for multiple iterations.
EXPORT dsInitialDataDistByFrom := DISTRIBUTE(dsReformattedInputData,from); 

// EXPORT dsInlinks := GenerateInLinks(dsReformattedInputData);
// EXPORT dsDistInlinksByTo := DISTRIBUTE(dsInlinks, to);

END;
