EXPORT AllInfo := FUNCTION
	addlInfo := GetAddlInfo(Files.dsMasters);
	links := GetAddlInfoLinks(Files.dsEntities);
	sanctions := GetSanctionsAsAddlInfo;
	Dob := SORT(
					PROJECT(GetDobs(Files.dsMasters), TRANSFORM({unsigned8 Ent_ID,Layout_XG.layout_addlinfo},
							self.Ent_ID := LEFT.Ent_id;
							self.Type := 'DOB';
							self.information := LEFT.dob,
							self.parsed := LEFT.parsed,
							self := [];)),
					Ent_id, -parsed);
  AddDOB := SORT(
						PROJECT(AdditionalDOB(Files.dsSanctionsDOB), TRANSFORM({unsigned8 Ent_ID,Layout_XG.layout_addlinfo},
							self.Ent_ID := LEFT.Ent_id;
							self.Type := 'DOB';
							self.information := LEFT.dob,
							self.parsed := LEFT.parsed,
							self := [];)),
					Ent_id, -parsed);
	dobs := DEDUP(SORT(DISTRIBUTE(dob + AddDOB, ent_id), ent_id, parsed, LOCAL), ent_id, parsed, LOCAL);
	AddlSorted := SORT(DISTRIBUTE(addlInfo + links + dobs, Ent_id), ent_id, Type, -parsed, information, comments, LOCAL);
							
	pAddl := 
			project(AddlSorted,					// leave out sanctions
					transform({unsigned8 id,Layout_XG.addlinfo_rollup},
						self.id := left.Ent_id;
						self.additionalinfo := row(left, Layout_XG.layout_addlinfo); 
					)
				);
														
	pAddl rollRecs(pAddl L, pAddl R) := transform
		self.id  := L.id;
		self.additionalinfo := L.additionalinfo + row({	TRIM(R.additionalinfo[1].type),
										R.additionalinfo[1].information,
										R.additionalinfo[1].parsed,
										R.additionalinfo[1].comments
						},Layout_XG.layout_addlinfo);
		end;
		
	result := rollup(pAddl, id, rollRecs(left, right),local);

	return result;
END;