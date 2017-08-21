import Worldcheck_Bridger;
export geoAKAs(DATASET(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo) infile) := FUNCTION
	countries := Accuity.Files.input.gwl.entity(type = '01');

	rAKA := RECORD
		string id;
		Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.CountryAKA_location;
	END;

	rAKA MakeAKAS(Layouts.input.rEntity L, integer c) := TRANSFORM
		self.id := L.id;
		self.type := if(c=1, SKIP, 'AKA');
		self.name := if(c=1, L.addresses[1].country_code, L.addresses[1].country_name);
	END;

	countryAKA := sort(distribute(normalize(countries, 2, MakeAKAS(LEFT, COUNTER)),hash(id)),id,LOCAL);
	
	Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo 
		makeAka(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo src, rAKA akas) := 
		TRANSFORM
			self.id := src.id;
			self.aka_list.aka := 	row(akas,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.CountryAKA_location);
			SELF := src;
		END;

	georecs2 := JOIN(infile,countryAKA, LEFT.id=RIGHT.id,
					makeAka(LEFT, RIGHT), LEFT OUTER, LOCAL);

	Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo combineAKA(
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo L,
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo R) := TRANSFORM
		SELF.id := L.id;
		SELF.aka_list.aka := L.aka_list.aka + 
						ROW({
							TRIM(R.aka_list.aka[1].type),
							R.aka_list.aka[1].name},
							Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.CountryAKA_location);
		self := L;
	END;

	georecs3 := ROLLUP(georecs2, id, combineAKA(LEFT, RIGHT));

 return georecs3;

END;