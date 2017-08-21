IMPORT STD;

r := RECORD
	unsigned8	id;
	unicode		country;
	integer		valueid := 72;
END;

GetCountries(DATASET(Layouts.rEntity) infile) := FUNCTION


	withvalues := JOIN(infile, Files.dsCountries, STD.Uni.ToUpperCase(LEFT.country) = STD.Uni.ToUpperCase(RIGHT.CountryName),
									TRANSFORM(r,
											self.id := LEFT.Ent_ID;
											SELF.valueid := IF(LEFT.country='',72,RIGHT.CountryId);
											SELF := LEFT;), LOOKUP, LEFT OUTER);


	return withvalues;

END;

GetUniqueCountries(DATASET(Layouts.rEntity) infile) := 
			DEDUP(SORT(DISTRIBUTE(GetCountries(infile),(integer)id),id,valueid,local),id,valueid,local);

EXPORT GetCountryCriteria(DATASET(Layouts.rEntity) infile) := FUNCTION
	groupid := 1;
	countries := 
				PROJECT(
					SORT(DISTRIBUTE(GetUniqueCountries(infile), (integer)id), id, valueid, LOCAL),
					TRANSFORM(rCriteriaRollup,
						self.id := LEFT.id;
						self.criteriaClass := groupid;
						self.criteriaValue := LEFT.valueid;));
	
	rCriteriaRollup mergeValue(rCriteriaRollup Lft, rCriteriaRollup rght) := TRANSFORM
			self.id := Lft.id;
			self.criteriaClass := Lft.criteriaClass;
			self.criteriaValue := rght.criteriaValue;
			self.criteria := (unicode)Lft.criteriaValue + ',' + (unicode)rght.criteriaValue;
	END;
	ds2 := ROLLUP(countries, mergeValue(LEFT, RIGHT), id, LOCAL);
	missingvalues := JOIN(DISTRIBUTE(infile,Ent_id), ds2, LEFT.Ent_id=RIGHT.id,
										TRANSFORM(rCriteriaRollup,
												self.id := LEFT.Ent_id;
												self.criteriaClass := groupid;
												self.criteriaValue := 999;), LOCAL, LEFT ONLY);
	
	result := PROJECT(ds2&missingvalues, TRANSFORM(rSearchCriteria,
									self.id := LEFT.id;
									searchvalues := IF(LEFT.criteria='', (unicode)LEFT.criteriaValue, LEFT.criteria);
									self.criteria := (unicode)groupid + U',' + searchvalues + U';';
									));
								
	return SORT(DISTRIBUTE(result, (integer)id), id, LOCAL);

END;