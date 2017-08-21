IMPORT Accuity, STD;
EXPORT SearchConditions := MODULE

shared rConditions := RECORD
	string				id;
	string				sdfType;
	string				name;
	integer				valueid := 99;
END;


export GetSDFs(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION
	result := normalize(infile,left.Additional_Info,
							transform(rConditions,
			
						self.id 			:= left.id;
						self.sdfType	:= right.sdf_name;
						self.name	:= right.sdf_value;	
				)
			);

	return result;

END;

export GetLevels(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION

	return PROJECT(GetSDFS(infile)(sdfType = 'EntityLevel'), TRANSFORM(rConditions,
							SELF.valueid := CASE(LEFT.name,
									'Local' => 	1,
									'National' => 2,
									'State' => 3,
									'International' => 4,
									99);
							SELF := LEFT;));

END;

export GetSubcategories(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION

	subcats := GetSDFS(infile)(sdfType = 'SubCategory');
	result := JOIN(subcats, PEP.dsSubcategories, 
									STD.Str.ToUpperCase(LEFT.name)=STD.Str.ToUpperCase(RIGHT.name),
									TRANSFORM(rCriteriaEx,
											self.id := LEFT.id,
											self.name := LEFT.name,
											self.valueid := RIGHT.valueid;
											),
									LEFT OUTER);
	return SORT(DISTRIBUTE(result, (integer)id), id, valueid,LOCAL);

END;
/*
export GetAdverseMedia(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION

	subcats := GetSDFS(infile)(sdfType = 'SubCategory');
	result := JOIN(subcats, PEP.SearchCriteriaEDD.dsAdverseMedia, 
									STD.Str.ToUpperCase(LEFT.name)=STD.Str.ToUpperCase(RIGHT.name),
									TRANSFORM(rCriteriaEx,
											self.id := LEFT.id,
											self.name := LEFT.name,
											self.valueid := RIGHT.valueid;),
									LEFT OUTER);
	return SORT(DISTRIBUTE(result, (integer)id), id, valueid,LOCAL);

END;
*/

export GetSpecifiedCriteria(DATASET(Accuity.Layouts.input.rEntity) infile,
														DATASET(rCriteria) values)
								:= FUNCTION
	subcats := GetSDFS(infile)(sdfType = 'SubCategory');
	givenvalues := JOIN(subcats, values, 
									STD.Str.ToUpperCase(LEFT.name)=STD.Str.ToUpperCase(RIGHT.name),
									TRANSFORM(rCriteriaEx,
											self.id := LEFT.id,
											self.name := LEFT.name,
											self.valueid := RIGHT.valueid;
											),
									INNER);
	missingvalues := JOIN(infile, givenvalues, LEFT.id=RIGHT.id,
										TRANSFORM(rCriteriaEx,
												self.id := LEFT.id;
												self.name := 'No Value';
												self.valueid := 99;), LEFT ONLY);
												
	return SORT(DISTRIBUTE(givenvalues & missingvalues, (integer)id), id, valueid, LOCAL);
								
								
END;

r := RECORD
		string	id;
		integer	criteriaClass;
		integer	criteriaValue;
		string	criteria := '';
END;

export FormatSearchCriteria(DATASET(Accuity.Layouts.input.rEntity) infile,
														DATASET(rCriteria) values, integer groupid)
								:= FUNCTION
		
		allCriteria := PROJECT(GetSpecifiedCriteria(infile, values), TRANSFORM(r,
												self.id := left.id;
												self.criteriaClass := groupid;
												self.criteriaValue := left.valueid;));
	r mergeValue(r Lft, r rght) := TRANSFORM
			self.id := Lft.id;
			self.criteriaClass := Lft.criteriaClass;
			self.criteriaValue := rght.criteriaValue;
			self.criteria := (string)Lft.criteriaValue + ',' + (string)rght.criteriaValue;
	END;
	ds2 := ROLLUP(allCriteria, mergeValue(LEFT, RIGHT), id, criteriaClass, LOCAL);
	
	result := PROJECT(ds2, TRANSFORM(rSearchCriteria,
									self.id := LEFT.id;
									searchvalues := IF(LEFT.criteria='', (string)LEFT.criteriaValue, LEFT.criteria);
									self.criteria := (string)groupid + ',' + searchvalues + ';';
									));
		return result;
								
END;


END;