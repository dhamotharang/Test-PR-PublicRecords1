//
// This module is intended to be used to track the
// results from the iterations so they can be reviewed.
//
export Mod_Results := MODULE
		EXPORT Layout_NewScoreResults := RECORD
			UNSIGNED1	iteration;
			Types.FromType pageId;
			Types.ScoreType score;
		END;
		
		EXPORT MergeScoreResults( dsbase, dsNewScores, thisIteration, results) := MACRO
			#UNIQUENAME(newIt2Data);
			%newIt2data% := PROJECT(dsNewScores, TRANSFORM(PageRank.Mod_Results.Layout_NewScoreResults, 
											SELF.iteration := thisIteration; SELF.score := LEFT.NewScore; SELF := LEFT)); 
			results := SORT( dsbase+%newIt2data%, iteration, pageId);
		ENDMACRO;
END;