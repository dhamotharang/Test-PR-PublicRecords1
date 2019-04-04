
r := RECORD
		string	id;
		string	criteriaClass;
		string	criteriaValue;
		string	criteria := '';
END;


SanctionCriteria := FUNCTION
	dsSanctions := DowJones.Functions.GetRawSanctions;
									
	/*ds := DISTRIBUTE(PROJECT(dsSanctions, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '7';
							val := DowJones.GetSourceValue(LEFT.refName);
							self.criteriaValue := if(val='0',SKIP,val);
							self := LEFT;)), (integer)id);
		*/					
	ds := DISTRIBUTE(
				JOIN(dsSanctions, DowJones.dsSourceCriteria, LEFT.refName=RIGHT.name,
					TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '7';
							val := RIGHT.id;
							self.criteriaValue := if(val='',SKIP,val);
							self := LEFT;), INNER),
			(integer)id);
							
	unsanctionedPersons := JOIN(File_Person, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '7';
							self.criteriaValue := '999';),
							Left Only, LOCAL);
	unsanctionedEntities := JOIN(File_Entity, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '7';
							self.criteriaValue := '999';),
							Left Only, LOCAL);
	return ds & unsanctionedPersons & unsanctionedEntities;
END;

GetDeceased := FUNCTION
			ddate := PROJECT(Functions.GetDod(File_Person), TRANSFORM(r,
									self.id := LEFT.id;
									self.criteriaClass := '1';
									self.criteriaValue := '1';));
			deceased := PROJECT(File_Person(Deceased='Yes'), TRANSFORM(r,
									self.id := LEFT.id;
									self.criteriaClass := '1';
									self.criteriaValue := '1';));
			dead := DEDUP(SORT(ddate & deceased, id, LOCAL), id, LOCAL);
			alive := JOIN(File_Person, dead, LEFT.id = RIGHT.id, TRANSFORM(r,
												self.id := LEFT.id;
												self.criteriaClass := '1';
												self.criteriaValue := '2';),
												LEFT ONLY, LOCAL);
			entities := PROJECT(File_Entity, TRANSFORM(r, 
									self.id := LEFT.id;
									self.criteriaClass := '1';
									self.criteriaValue := '9';));
			
			return dead + alive + entities;

	END;
GetActive := FUNCTION

APerson:= PROJECT(File_Person, TRANSFORM(r,
                                self.id := LEFT.id;
                                self.criteriaClass := '3';
                                self.criteriaValue  :=  CASE(left.ActiveStatus,
                                                'Active' => '1',
                                                'Inactive' => '2',
                                                '9')
));

AEntity:= PROJECT(File_Entity, TRANSFORM(r,
                                self.id := LEFT.id;
                                self.criteriaClass := '3';
                                self.criteriaValue  :=  CASE(left.ActiveStatus,
                                                'Active' => '1',
                                                'Inactive' => '2',
                                                '9')
));

return APerson + AEntity;

	END;

string TypeToValue(string entityType) := CASE(entityType,
				'Politically Exposed Person (PEP)' => '1',
				'Politically Exposed Person' => '1',
				'Relative or Close Associate (RCA)' => '2',
				'Relative or Close Associate' => '2',
				'Special Interest Entity (SIE)' => '4',
				'Special Interest Entity' => '4',
				'Special Interest Person (SIP)' => '3',
				'Special Interest Person' => '3',
				'9');
				
string SpecialInterestTypeToValue(string entityType) := CASE(entityType,
				'' => '0',
				'Additional Domestic Screening Requirement' => '10',
				'Associated Entity' => '1',
				'Corruption' => '2',
				'Enhanced Country Risk' => '12',
				'Financial Crime' => '3',
				'Organized Crime' => '4',
				'Organised Crime' => '4',
				'Organized Crime Japan' => '11',
				'Organised Crime Japan' => '11',
				'Other Official Lists' => '5',
				'Sanctions Control and Ownership' => '34',
				'Sanctions Lists' => '6',
				'Tax Crime' => '13',
				'Terror' => '7',
				'Trafficking' => '8',
				'WarCrimes' => '9',
				'War Crimes' => '9',
				'99');
				
string OccupationToValue(string occType) := CASE(occType,
'No Value' => '0',
'City Mayors' => '18',
'Embassy & Consular Staff' => '6',
'Heads & Deputies State/National Government' => '1',
'Heads & Deputy Heads of Regional Government' => '13',
'International Organization Officials' => '17',
'International Sporting Organisation Officials' => '26',
'Local Public Officials' => '22',
'Members of the National Legislature' => '3',
'National Government Ministers' => '2',
'National NGO Officials' => '21',
'Other' => '20',
'Political Party Officials' => '16',
'Political Pressure and Labour Group Officials' => '19',
'Regional Government Ministers' => '14',
'Religious Leaders' => '15',
'Senior Civil Servants-National Government' => '4',
'Senior Civil Servants-Regional Government' => '5',
'Senior Members of the Armed Forces' => '7',
'Senior Members of the Judiciary' => '10',
'Senior Members of the Police Services' => '8',
'Senior Members of the Secret Services' => '9',
'State Agency Officials' => '12',
'State Corporation Executives' => '11',
'99');
/*
r xOccsAndTypes({Functions.GetRawDescriptions} src, integer c) := TRANSFORM
						self.id := src.id;
						self.criteriaClass := IF(c=1,'4','5');
						val := IF(c=1, TypeToValue(src.name1),
																					OccupationToValue(src.name2));
						self.criteriaValue := if(val='0',SKIP,val);
END;
*/
GetTypes := FUNCTION
		src := Functions.GetRawDescriptions;
		ds := PROJECT(src, TRANSFORM(r,
						self.id := LEFT.id;
						self.criteriaClass := '4';
						val := TypeToValue(LEFT.name1);
						self.criteriaValue := if(val='0',SKIP,val);
		));
	unPersons := JOIN(File_Person, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '4';
							self.criteriaValue := '99';),
							Left Only, LOCAL);
	unEntities := JOIN(File_Entity, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '4';
							self.criteriaValue := '99';),
							Left Only, LOCAL);
	return ds & unPersons & unEntities;
END;

GetSpecialInterestTypes := FUNCTION
		src := Functions.GetRawDescriptions;
		ds := PROJECT(src, TRANSFORM(r,
						self.id := LEFT.id;
						self.criteriaClass := '5';
						val := SpecialInterestTypeToValue(LEFT.name2);
						self.criteriaValue := if(val='0',SKIP,val);
		));
	unPersons := JOIN(File_Person, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '5';
							self.criteriaValue := '99';),
							Left Only, LOCAL);
	unEntities := JOIN(File_Entity, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '5';
							self.criteriaValue := '99';),
							Left Only, LOCAL);
	return ds & unPersons & unEntities;

END;

GetRoles := FUNCTION
		rid1 := RECORD
			string		id;
			string		roleType;
			dataset(Layouts.rOccTitle)	OccTitles;
		END;
		rid2 := RECORD
			string		id;
			string		roleType;
			string		information;
			string		dStart;
			string		dEnd;
			string		occCat;
			string		occTitle;
			string		occName;
		END;
		rid2 xid2(rid1 L, Layouts.rOccTitle R) := TRANSFORM
					self.id := L.id;
					self.roleType := L.roleType;
					self.Information := R.OccTitle;
					self.dStart := Dates.PiecesToString(R.SinceYear,R.SinceMonth,R.SinceDay);
					self.dEnd := Dates.PiecesToString(R.ToYear,R.ToMonth,R.ToDay);
					self.OccCat := R.OccCat;
					self.occTitle := R.OccTitle;
					self.occName := '';
		END;
		rid1 xid1(Layouts.rPersons L, Layouts.rRoleDetail R) := TRANSFORM
					self.id := L.id;
					self.roleType := R.roleType;
					self.OccTitles := R.OccTitles;
		END;
		norm1 := NORMALIZE(File_Person, LEFT.RoleDetail, xid1(LEFT,RIGHT));
		norm1a := NORMALIZE(norm1, LEFT.OccTitles, xid2(LEFT,RIGHT));
		norm1b := JOIN(norm1a, Lists.OccupationList, LEFT.occCat = RIGHT.code, TRANSFORM(rid2,
											self.Occname := RIGHT.name;
											self := LEFT;), LEFT OUTER, LOOKUP);
		ds := PROJECT(norm1b, TRANSFORM(r,
							SELF.id := LEFT.id;
							self.criteriaClass := '2';
							self.criteriaValue := OccupationToValue(Left.occName);));
		
	unPersons := JOIN(File_Person, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '2';
							self.criteriaValue := '99';),
							Left Only, LOCAL);
	unEntities := JOIN(File_Entity, ds, LEFT.id=RIGHT.id, TRANSFORM(r,
							self.id := LEFT.id;
							self.criteriaClass := '2';
							self.criteriaValue := '99';),
							Left Only, LOCAL);
	return ds & unPersons & unEntities;
END;

GetCountries(SET of STRING omitcountries) := FUNCTION
		src := AllCountries;
		ds := PROJECT(src, TRANSFORM(r,
						self.criteriaValue := IF(LEFT.countryid in omitCountries, SKIP, LEFT.countryid);
						self.id := LEFT.id;
						self.criteriaClass := '6';
		));
		return ds;

END;

GetOwnership := 
		 PROJECT($.SearchCriteria3.Ownership, TRANSFORM(r,
						self.id := LEFT.id;
						self.criteriaClass := '5';
						self.criteriaValue := (string)left.Description3;
		));


EXPORT GetSearchCriteria(SET of STRING omitcountries=[]) := FUNCTION

	ds := SanctionCriteria & GetDeceased & GetActive & GetTypes & GetSpecialInterestTypes & GetOwnership & GetCountries(omitcountries) & GetRoles;
	ds1 := PROJECT(
						SORT(DEDUP(SORT(DISTRIBUTE(ds,(integer)id),
										id, criteriaClass, criteriaValue, LOCAL),id, criteriaClass, criteriaValue, LOCAL),
									id, criteriaClass, (integer)criteriaValue, LOCAL),
									TRANSFORM(r,
											self.criteria := left.criteriaClass + ',' + left.criteriaValue;
											self := left;));
	r mergeValue(r Lft, r rght) := TRANSFORM
			self.id := Lft.id;
			self.criteriaClass := Lft.criteriaClass;
			self.criteriaValue := IF(Lft.criteriaValue NOT IN ['','99'] AND 
																	rght.criteriaValue = '99' AND rght.criteriaClass<>'7',
																	SKIP,
															TRIM(Lft.criteriaValue) + ',' + TRIM(rght.criteriaValue));
			self.criteria := self.criteriaClass + ',' + self.criteriaValue;
	END;
	r mergeClass(r Lft, r rght) := TRANSFORM
			self.id := Lft.id;
			self.criteriaClass := Lft.criteriaClass;
			self.criteriaValue := TRIM(Lft.criteriaClass) + ',' + TRIM(rght.criteriaValue);
			self.criteria := TRIM(Lft.criteria)  + ';' +
													TRIM(rght.criteria);
	END;
	ds2 := ROLLUP(ds1, mergeValue(LEFT, RIGHT), id, criteriaClass, LOCAL);
	ds3 := PROJECT(ROLLUP(ds2, mergeClass(LEFT, RIGHT), id, LOCAL), TRANSFORM(r,
											self.criteria := LEFT.criteria + ';';
											self := LEFT));
	return ds3;
END;