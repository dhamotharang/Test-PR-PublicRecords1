EXPORT AllAddresses := FUNCTION

	addresses := GetAddresses(Files.dsAddresses);
	
	countries := PROJECT(Files.dsMasters, TRANSFORM({unsigned8 Ent_ID, Layout_XG.layout_addresses},
			self.Ent_ID := LEFT.Ent_id;
			self.type := 'Unknown';
			self.country := LEFT.Country;
			self := [];
		));
		
		addr := DEDUP(SORT(DISTRIBUTE(countries & addresses, Ent_id), Ent_id, country, State, City, Street_1, local), Ent_id, country, State, City, Street_1, local);

	pAddr := 
				project(addr,transform({unsigned8 id, Layout_XG.addr_rollup},
						self.id := left.Ent_id;
						self.address := row(left, Layout_XG.layout_addresses);
						));
						
	pAddr rollRecs(pAddr L, pAddr R) := transform
		self.id  := L.id;
		self.address := L.address + row({	R.address[1].type,
										R.address[1].street_1,
										R.address[1].street_2,
										R.address[1].city,
										R.address[1].state,
										R.address[1].postal_code,
										R.address[1].country,
										R.address[1].comments
				},Layout_XG.layout_addresses);
	end;
	return
		rollup(sort(distribute(pAddr,id),id,local), id, rollRecs(left, right),local);

END;