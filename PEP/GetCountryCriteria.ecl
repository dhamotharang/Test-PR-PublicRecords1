IMPORT Accuity, STD;
EXPORT GetCountryCriteria(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION
	groupid := 1;
	countries := 
				PROJECT(
					SORT(DISTRIBUTE(GetCountries(infile), (integer)id), id, valueid, LOCAL),
					TRANSFORM(rCriteriaRollup,
						self.id := LEFT.id;
						self.criteriaClass := groupid;
						self.criteriaValue := LEFT.valueid;));
	
	rCriteriaRollup mergeValue(rCriteriaRollup Lft, rCriteriaRollup rght) := TRANSFORM
			self.id := Lft.id;
			self.criteriaClass := Lft.criteriaClass;
			self.criteriaValue := rght.criteriaValue;
			self.criteria := (string)Lft.criteriaValue + ',' + (string)rght.criteriaValue;
	END;
	ds2 := ROLLUP(countries, mergeValue(LEFT, RIGHT), id, LOCAL);
	missingvalues := JOIN(infile, ds2, LEFT.id=RIGHT.id,
										TRANSFORM(rCriteriaRollup,
												self.id := LEFT.id;
												self.criteriaClass := groupid;
												self.criteriaValue := 99;), LEFT ONLY);
	
	result := PROJECT(ds2&missingvalues, TRANSFORM(rSearchCriteria,
									self.id := LEFT.id;
									searchvalues := IF(LEFT.criteria='', (string)LEFT.criteriaValue, LEFT.criteria);
									self.criteria := (string)groupid + ',' + searchvalues + ';';
									));
								
												
	return SORT(DISTRIBUTE(result, (integer)id), id, LOCAL);


END;