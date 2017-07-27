Import Healthcare_Shared;
EXPORT Functions_Score_Record := Module
	export ScoreRec(dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) inRec) := function
			getScores := project (inRec, Healthcare_Shared.Functions_Score.score_person(left));
			resultRec := join(inRec,getScores, left.acctno=right.acctno and left.internalid = right.internalid,
																				transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																							self.record_penalty_enhanced := right.score;
																							self.MatchScore := right;
																							self := left;),left outer,
																							keep(Constants.MAX_SEARCH_RECS), limit(0));
			return resultRec; 
	end;
END;
