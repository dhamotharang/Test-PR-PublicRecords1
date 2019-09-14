		r1 := RECORD
			unsigned8		SourceId;
			string10		SourceAbbrev;
			unicode		SourceName;
		END;

EXPORT GetSanctionsCriteria := FUNCTION

	src := DISTRIBUTE($.Files.dsSources, hash32(SourceAbbrev));

	dsConsolidated := $.dsConsolidatedSanctions;
	
	t :=  table(dsConsolidated, {dsConsolidated.comments, n := COUNT(GROUP)}, comments, few);

	t1 := DISTRIBUTE(t, hash32(comments));

	j := JOIN(t1, src, left.comments=right.sourceAbbrev, TRANSFORM(r1, self := right;), inner, local);
	RETURN sort(j,SourceId);

END;