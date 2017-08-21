
EXPORT AllAkas := FUNCTION
	//akas := GetAkas(Files.dsEntities);
	akas := ParseWeakAkas();
	pAlias := 
				project(akas,transform({unsigned8 id,Layout_XG.aka_rollup},
						self.id := left.Ent_id;
						self.aka := row(left, Layout_XG.layout_aliases); 																		
						));
														
	pAlias rollRecs(pAlias L, pAlias R) := transform
		self.id  := L.id;
		self.aka := L.aka + row({R.aka[1].type,
							 R.aka[1].category,
							 R.aka[1].first_name,
							 R.aka[1].middle_name,
							 R.aka[1].last_name,
							 R.aka[1].generation,
							 R.aka[1].full_name,
							 R.aka[1].comments
		 },Layout_XG.layout_aliases);
	end;

	return
		rollup(sort(distribute(pAlias,id),id,local), id, rollRecs(left, right),local);

END;