// BWR_ScratchPad
//

// originalSrcData := PageRank.Mod_Data.File_TeraByte;
// persistExtension := PageRank.Mod_Data.TerabyteExtension;

// originalSrcData := PageRank.Mod_Data.File_TenGigs;
// persistExtension := PageRank.Mod_Data.TenGigExtension;

originalSrcData := PageRank.Mod_Data.File_Sandia_P;
persistExtension := PageRank.Mod_Data.PDataExtension;

#WORKUNIT('name','ScratchPad' + persistExtension);

resultsRec := PageRank.Mod_Data.Layout_Scores;

// OUTPUT(originalSrcData, named('OriginalData'));

obj := PageRank.InitRawInput(originalSrcData,persistExtension);

// OUTPUT(SORT(obj.dsReformattedInputData, from), named('ReformattedInputData'));
// OUTPUT(SORT(obj.dsInlinks, from), named('Inlinks'));
// OUTPUT(obj.dsDanglers, named('dangler'));
// OUTPUT(obj.dsDistFromPageInfo,named('PageInfo'));

dsScoreLinks := TABLE(obj.dsReformattedInputData, {PageRank.Types.FromType PageId := to, 
																										PageRank.Types.ScoreType NewScore := (PageRank.Constants.alpha * SUM(GROUP,vote)) + PageRank.Constants.oneMinusAlpha;},
																									to,many);
																									
// OUTPUT(SORT(dsScoreLinks, -NewScore),named('NewScores'));																						
// OUTPUT(COUNT(dsScoreLinks),named('NewScoresCount'));	
																												
// Update the "vote" field in the original data so a second iteration can be performed....
dsDistNewScores := DISTRIBUTE(dsScoreLinks, PageId);

// OUTPUT(COUNT(obj.dsInitialDataDistByFrom),named('CntDistSrc'));

dsUpdatedVotes := JOIN(obj.dsInitialDataDistByFrom,dsDistNewScores,
												LEFT.From = RIGHT.pageId,
												TRANSFORM(resultsRec, 
																	SELF.Vote := RIGHT.NewScore * LEFT.oneOverLinkCount;
																	SELF := LEFT),
																	LEFT OUTER,
																	LOCAL);
																	
OUTPUT(COUNT(dsUpdatedVotes), named('UpdatedVotes'));																	
//
// At this point a TABLE can be used again to compute the next iteration. Note, the data is 
// distributed by FROM so you might want to try to DISTRIBUTING the data by "to" before
// doing the table again. 
// dsScoreLinks2 := TABLE(dsUpdatedVotes, {PageRank.Types.FromType PageId := to, 
																										// PageRank.Types.ScoreType NewScore := (PageRank.Constants.alpha * SUM(GROUP,vote)) + PageRank.Constants.oneMinusAlpha;},
																									// to,many);	
																									
// OUTPUT(SORT(dsScoreLinks2, -NewScore),named('NewScores2'));																										
																									

																									
							
