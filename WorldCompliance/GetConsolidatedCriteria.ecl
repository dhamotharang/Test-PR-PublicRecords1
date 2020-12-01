EXPORT GetConsolidatedCriteria(DATASET($.Layouts.rEntity) infile = $.Files.dsEntities) := FUNCTION

 		dSources := DICTIONARY($.GetSanctionsCriteria, {sourceabbrev => sourceid});
//		usefile := DEDUP(SORT($.Files.dsMasters_base, ent_id, EntryCategory, EntrySubcategory, local),
//								Ent_ID, EntryCategory, EntrySubcategory,All);
								
		srcs := DISTRIBUTE(
							JOIN(infile, $.dsConsolidatedSanctions, left.ent_id=right.masterid,
												TRANSFORM($.rCriteriaRollup,
														self.id := LEFT.Ent_id;
														self.criteria := right.comments;
														self.criteriaClass := 6;
														self.criteriaValue := dSources[right.comments].sourceid;)
														, LEFT OUTER),
								id);
												
		s2 := PROJECT(Dedup(SORT(srcs(criteriaValue <> 0),id, criteriaValue, local),id, criteriaValue, local),
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

END;
