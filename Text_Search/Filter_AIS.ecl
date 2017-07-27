export Filter_AIS(DATASET(Layout_AIS) ais, 
									 DATASET(Layout_DocScore) selected) := FUNCTION
	Layout_ScoredFlat score(Layout_AIS l, Layout_DocScore r):=TRANSFORM
		SELF.score := r.score;
		SELF.seq := 0;
		SELF := l;
	END;
	rslt := JOIN(ais, selected, LEFT.docRef=RIGHT.docRef,
							 score(LEFT,RIGHT), LOOKUP);
	RETURN rslt;
END;