//
// sourcedata is the Layout_Scores formatted data. It may or may not be distributed as desired.
// wasDistributed will indicate if the data has been distributed by "to".
// outdata has the new scores for the pages that appeared in the "to" field.
// If there were no matches with id's in the "from" field then those pages don't get an updated
// score since they're not referenced.
//
export MAC_ComputeScores(sourceData, wasDistributed, outputdata, extension) := MACRO

	outputdata := If(wasDistributed= TRUE,
															TABLE(sourceData, {PageRank.Types.FromType PageId := to, 
																										PageRank.Types.ScoreType NewScore := (PageRank.Constants.alpha * SUM(GROUP,vote)) + PageRank.Constants.oneMinusAlpha;},
																									to,many, LOCAL ),
															TABLE(sourceData, {PageRank.Types.FromType PageId := to, 
																										PageRank.Types.ScoreType NewScore := (PageRank.Constants.alpha * SUM(GROUP,vote)) + PageRank.Constants.oneMinusAlpha;},
																									to,many )
								);
								
	// OUTPUT(SORT(outputdata, -NewScore), named('NewScore_' + extension));
																									
ENDMACRO;