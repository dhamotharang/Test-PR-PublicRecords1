EXPORT AllIds(boolean useLexId = false) := FUNCTION

	ids := GetIds(Files.dsMasters);
	
	LexIds := GetLexID(dsLexIds);

	allIds := if(useLexId, ids&LexIds, ids);
	
	pID := 
			project(allIds,transform({unsigned8 id,Layout_XG.id_rollup},
					self.id := left.Ent_ID;
					self.identification := row(left, Layout_XG.layout_sp);
					)
				);
														
	pID rollRecs(pID L, pID R) := transform
	self.id  := L.id;
	self.identification:= L.identification + row({R.identification[1].type,
												R.identification[1].label,
												R.identification[1].number,
												R.identification[1].issued_by,
												R.identification[1].date_issued,
												R.identification[1].date_expires,
												R.identification[1].comments
	 },Layout_XG.layout_sp);
	end;
	return
		rollup(sort(distribute(pId,id),id,local), id, rollRecs(left, right),local);

END;