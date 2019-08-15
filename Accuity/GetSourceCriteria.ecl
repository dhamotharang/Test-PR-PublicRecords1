﻿EXPORT GetSourceCriteria(DATASET($.Layouts.rEntity) infile) := FUNCTION

		dSources := DICTIONARY($.dsSources(infile), {sourceabbrev => sourceid});
		srcs := DISTRIBUTE(
							JOIN(infile, $.dsConsolidatedSanctions, left.ent_id=right.masterid,
												TRANSFORM($.rCriteriaRollup,
														self.id := LEFT.Ent_id;
														self.criteria := right.comments;
														self.criteriaClass := 6;
														self.criteriaValue := dSources[right.comments].sourceid;)
														, LEFT OUTER),
								id);
												
		s2 := PROJECT(SORT(srcs(criteriaValue <> 0),id, criteriaValue, local),
							TRANSFORM($.rSearchCriteria,
								self.id := left.id;
								self.criteria := (unicode)left.criteriaValue;));
								
		s3 := ROLLUP(s2, TRANSFORM($.rSearchCriteria,
								self.id := left.id;
								self.criteria := left.criteria + U',' + right.criteria;),
								id, local);
												
		s4 := PROJECT(s3, TRANSFORM($.rSearchCriteria,
								self.id := left.id;
								self.criteria := U'6,' + left.criteria + U';';));
								
		return s4;
	
	return sources;

END;