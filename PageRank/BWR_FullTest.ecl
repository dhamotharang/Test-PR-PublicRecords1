// BWR_FullTest
#WORKUNIT('name','FullTest');
//
// This BWR will run through the PageRank algorithm over multiple iterations.
//
// originalSrcData := PageRank.Mod_Data.File_TeraByte;
// persistExtension := PageRank.Mod_Data.TerabyteExtension;
//
// originalSrcData := PageRank.Mod_Data.File_TenGigs;
// persistExtension := PageRank.Mod_Data.TenGigExtension;

originalSrcData := PageRank.Mod_Data.File_Sandia_P;
persistExtension := PageRank.Mod_Data.PDataExtension;

resultsRec := PageRank.Mod_Data.Layout_Scores;

// OUTPUT(originalSrcData, named('OriginalData'));

obj := PageRank.InitRawInput(originalSrcData);

OUTPUT(SORT(obj.dsReformattedInputData, from,to), named('OriginalData'));
		
PageRank.MAC_ComputeScores(obj.dsReformattedInputData, false, dsUpdatedScores_1, '1')
// dsBaseline := PROJECT(dsUpdatedScores_1,
								// TRANSFORM(PageRank.Mod_Results.Layout_NewScoreResults, 
													// SELF.iteration := 1; SELF.score := LEFT.newScore; SELF := LEFT));
													
PageRank.Mod_Results.MergeScoreResults(DATASET([], PageRank.Mod_Results.Layout_NewScoreResults), dsUpdatedScores_1, 1, dsBaseline);

OUTPUT(dsBaseline);
PageRank.MAC_UpdateVotes(obj.dsInitialDataDistByFrom, dsUpdatedScores_1, dsUpdatedVotes_1, '1')
//
// dsUpdatedVotes_1 has the original data in the reformatted layout with the updated vote information
// needed to complete another iteration.
// If only one iteration is necessary then the single execution of PageRank.InitRawInput then
// PageRank.MAC_ComputeScores is all that is required.
PageRank.MAC_ComputeScores(dsUpdatedVotes_1, false, dsUpdatedScores_2, '2')
PageRank.Mod_Results.MergeScoreResults(dsBaseline, dsUpdatedScores_2, 2, dsRes2);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_1, dsUpdatedScores_2, dsUpdatedVotes_2, '2')

PageRank.MAC_ComputeScores(dsUpdatedVotes_2, false, dsUpdatedScores_3, '3')
PageRank.Mod_Results.MergeScoreResults(dsRes2, dsUpdatedScores_3, 3, dsRes3);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_2, dsUpdatedScores_3, dsUpdatedVotes_3, '3')

PageRank.MAC_ComputeScores(dsUpdatedVotes_3, false, dsUpdatedScores_4, '4')
PageRank.Mod_Results.MergeScoreResults(dsRes3, dsUpdatedScores_4, 4, dsRes4);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_3, dsUpdatedScores_4, dsUpdatedVotes_4, '4')

PageRank.MAC_ComputeScores(dsUpdatedVotes_4, false, dsUpdatedScores_5, '5')
PageRank.Mod_Results.MergeScoreResults(dsRes4, dsUpdatedScores_5, 5, dsRes5);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_4, dsUpdatedScores_5, dsUpdatedVotes_5, '5')

PageRank.MAC_ComputeScores(dsUpdatedVotes_5, false, dsUpdatedScores_6, '6')
PageRank.Mod_Results.MergeScoreResults(dsRes5, dsUpdatedScores_6, 6, dsRes6);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_5, dsUpdatedScores_6, dsUpdatedVotes_6, '6')

PageRank.MAC_ComputeScores(dsUpdatedVotes_6, false, dsUpdatedScores_7, '7')
PageRank.Mod_Results.MergeScoreResults(dsRes6, dsUpdatedScores_7, 7, dsRes7);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_6, dsUpdatedScores_7, dsUpdatedVotes_7, '7')

PageRank.MAC_ComputeScores(dsUpdatedVotes_7, false, dsUpdatedScores_8, '8')
PageRank.Mod_Results.MergeScoreResults(dsRes7, dsUpdatedScores_8, 8, dsRes8);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_7, dsUpdatedScores_8, dsUpdatedVotes_8, '8')

PageRank.MAC_ComputeScores(dsUpdatedVotes_8, false, dsUpdatedScores_9, '9')
PageRank.Mod_Results.MergeScoreResults(dsRes8, dsUpdatedScores_9, 9, dsRes9);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_8, dsUpdatedScores_9, dsUpdatedVotes_9, '9')

PageRank.MAC_ComputeScores(dsUpdatedVotes_9, false, dsUpdatedScores_10, '10')
PageRank.Mod_Results.MergeScoreResults(dsRes9, dsUpdatedScores_10, 10, dsRes10);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_9, dsUpdatedScores_10, dsUpdatedVotes_10, '10')

PageRank.MAC_ComputeScores(dsUpdatedVotes_10, false, dsUpdatedScores_11, '11')
PageRank.Mod_Results.MergeScoreResults(dsRes10, dsUpdatedScores_11, 11, dsRes11);
PageRank.MAC_UpdateVotes(dsUpdatedVotes_10, dsUpdatedScores_11, dsUpdatedVotes_11, '11')

OUTPUT(dsRes11, named('ScoreIterations'));

PageRank.MAC_ComputeScores(dsUpdatedVotes_11, false, dsUpdatedScores_12, '12')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_11, dsUpdatedScores_12, dsUpdatedVotes_12, '12')

PageRank.MAC_ComputeScores(dsUpdatedVotes_12, false, dsUpdatedScores_13, '13')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_12, dsUpdatedScores_13, dsUpdatedVotes_13, '13')

PageRank.MAC_ComputeScores(dsUpdatedVotes_13, false, dsUpdatedScores_14, '14')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_13, dsUpdatedScores_14, dsUpdatedVotes_14, '14')

PageRank.MAC_ComputeScores(dsUpdatedVotes_14, false, dsUpdatedScores_15, '15')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_14, dsUpdatedScores_15, dsUpdatedVotes_15, '15')

PageRank.MAC_ComputeScores(dsUpdatedVotes_15, false, dsUpdatedScores_16, '16')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_15, dsUpdatedScores_16, dsUpdatedVotes_16, '16')

PageRank.MAC_ComputeScores(dsUpdatedVotes_16, false, dsUpdatedScores_17, '17')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_16, dsUpdatedScores_17, dsUpdatedVotes_17, '17')

PageRank.MAC_ComputeScores(dsUpdatedVotes_17, false, dsUpdatedScores_18, '18')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_17, dsUpdatedScores_18, dsUpdatedVotes_18, '18')

PageRank.MAC_ComputeScores(dsUpdatedVotes_18, false, dsUpdatedScores_19, '19')
PageRank.MAC_UpdateVotes(dsUpdatedVotes_18, dsUpdatedScores_19, dsUpdatedVotes_19, '19')
