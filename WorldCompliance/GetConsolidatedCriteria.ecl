EXPORT GetConsolidatedCriteria(DATASET($.Layouts.rEntity) infile = $.Files.dsEntities) := FUNCTION

		dSources := DICTIONARY($.GetSanctionsCriteria, {sourceabbrev => sourceid});
		srcs := DISTRIBUTE(
							JOIN(infile, $.dsConsolidatedSanctions, left.ent_id=right.masterid,
												TRANSFORM($.rCriteriaRollup,
														self.id := LEFT.Ent_id;
														self.criteria := right.comments;
														self.criteriaClass := 6;
														self.criteriaValue := dSources[right.comments].sourceid;)
														, LEFT OUTER),
								id);
												
		return PROJECT(srcs(criteriaValue <> 0), TRANSFORM($.rSearchCriteria,
								self.id := left.id;
								self.criteria := U'6,' + (UNICODE)left.criteriaValue + U';';));

END;
