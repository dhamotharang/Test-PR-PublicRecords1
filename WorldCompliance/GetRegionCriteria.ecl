import Std;

	groupid := 2;

GetRegionInfo(dataset(Layouts.rEntity) infile) := function

	ds := JOIN(infile, dsRegion, STD.uni.ToUpperCase(LEFT.EntLevel)=STD.uni.ToUpperCase(RIGHT.name),
									TRANSFORM(rCriteriaRollup,
											SELF.id := LEFT.Ent_Id;
											SELF.criteriaClass := groupid;
											SELF.criteriaValue := IF(RIGHT.valueid=0,99,RIGHT.valueid);
											SELF := LEFT;), LOOKUP, LEFT OUTER);
	return DEDUP(SORT(DISTRIBUTE(ds,(integer)id),id,criteriaValue,LOCAL),id,criteriaValue,local);
END;

EXPORT GetRegionCriteria(dataset(Layouts.rEntity) infile) := function

	regions := GetRegionInfo(infile);

	rCriteriaRollup mergeValue(rCriteriaRollup Lft, rCriteriaRollup rght) := TRANSFORM
			self.id := Lft.id;
			self.criteriaClass := Lft.criteriaClass;
			self.criteriaValue := rght.criteriaValue;
			self.criteria := (unicode)Lft.criteriaValue + ',' + (unicode)rght.criteriaValue;
	END;
	ds2 := ROLLUP(regions, mergeValue(LEFT, RIGHT), id, LOCAL);
	missingvalues := JOIN(DISTRIBUTE(infile,Ent_id), ds2, LEFT.Ent_id=RIGHT.id,
										TRANSFORM(rCriteriaRollup,
												self.id := LEFT.Ent_id;
												self.criteriaClass := groupid;
												self.criteriaValue := 99;), LOCAL, LEFT ONLY);
	
	result := PROJECT(ds2&missingvalues, TRANSFORM(rSearchCriteria,
									self.id := LEFT.id;
									searchvalues := IF(LEFT.criteria='', (string)LEFT.criteriaValue, LEFT.criteria);
									self.criteria := (unicode)groupid + U',' + searchvalues + U';';
									));
								
												
	return SORT(DISTRIBUTE(result, id), id, LOCAL);


end;