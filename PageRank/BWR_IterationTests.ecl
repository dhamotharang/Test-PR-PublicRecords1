// BWR_IterationTests
//

originalSrcData := PageRank.Mod_Data.File_TeraByte;
persistExtension := PageRank.Mod_Data.TerabyteExtension;

#WORKUNIT('name','It1Complete' + persistExtension);

resultsRec := PageRank.Mod_Data.Layout_Scores;

obj := PageRank.InitRawInput(originalSrcData,persistExtension);

//
// By excuting the TABLE function the new scores are computed.
dsScoreLinks := TABLE(obj.dsReformattedInputData, {PageRank.Types.FromType PageId := to, 
																										PageRank.Types.ScoreType NewScore := (PageRank.Constants.alpha * SUM(GROUP,vote)) + PageRank.Constants.oneMinusAlpha;},
																									to,many);
																																														
// OUTPUT(COUNT(dsScoreLinks),named('NewScoresCount'));	// ******* Uncomment this if you want just the iteration one results.
//
// To fixup the data for another iteration the DISTRIBUTE and JOIN must be performed.
// NOTE: If you want to run just one iteration and you don'e care about the data fix up at the end of the iteration then
// make sure the remaining code is commented out.
//																												
// Update the "vote" field in the original data so a second iteration can be performed....
//
dsDistNewScores := DISTRIBUTE(dsScoreLinks, PageId);

dsUpdatedVotes := JOIN(obj.dsInitialDataDistByFrom,dsDistNewScores,
												LEFT.From = RIGHT.pageId,
												TRANSFORM(resultsRec, 
																	SELF.Vote := RIGHT.NewScore * LEFT.oneOverLinkCount;
																	SELF := LEFT),
																	LEFT OUTER,
																	LOCAL);
																	
// OUTPUT(COUNT(dsUpdatedVotes), named('UpdatedVotes'));	// ****** Uncomment this line if you want to know what one iteration with the fix up time takes.																
//
// At this point a TABLE can be used again to compute the next iteration. Note, the data is 
// distributed by FROM so you might want to try to DISTRIBUTING the data by "to" before
// doing the table again. 
//

// dsScoreLinks2 := TABLE(dsUpdatedVotes, {PageRank.Types.FromType PageId := to, 
																										// PageRank.Types.ScoreType NewScore := (PageRank.Constants.alpha * SUM(GROUP,vote)) + PageRank.Constants.oneMinusAlpha;},
																									// to,many);
																									
// OUTPUT(COUNT(dsScoreLinks2),named('NewScoresCount2'));																										

																									

																									
							
