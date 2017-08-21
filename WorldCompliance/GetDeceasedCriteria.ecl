IMPORT STD;
	groupid := 4;
	
EXPORT GetDeceasedCriteria(DATASET(Layouts.rEntity) infile) := FUNCTION
	titles := GetTitles(infile);
	deceased := JOIN(infile, titles, LEFT.Ent_id = RIGHT.id,
					TRANSFORM(rCriteriaRollup,
						self.id := LEFT.Ent_id;
						self.criteriaClass := groupid;
						self.criteriaValue := IF(LEFT.EntryType = 'Individual',
																				IF(RIGHT.isDeceased,2,1),9);
					), LEFT OUTER, KEEP(1));
					
 	missing := JOIN(infile, deceased, LEFT.Ent_id=RIGHT.id,
										TRANSFORM(rCriteriaRollup,
												self.id := LEFT.Ent_id;
												self.criteriaClass := groupid;
												self.criteriaValue := IF(LEFT.EntryType = 'Individual',1,9);), LEFT ONLY);
									
	result := PROJECT(deceased&missing, TRANSFORM(rSearchCriteria,
									self.id := LEFT.id;
									searchvalues := IF(LEFT.criteria='', (string)LEFT.criteriaValue, LEFT.criteria);
									self.criteria := (string)groupid + ',' + searchvalues + ';';
									));

	return SORT(DISTRIBUTE(result,(integer)id), id, LOCAL);
END;