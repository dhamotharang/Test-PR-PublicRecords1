

		raddr := RECORD
			string		id;
			boolean		personRecord;
			string		CountryType;
			dataset(Layouts.rCountryValues)	CountryValues;
		END;

ExtractCountryInfo(dataset(raddr) cid) := FUNCTION
		rCountry xcountry(raddr L, Layouts.rCountryValues R) := TRANSFORM
					self.id := L.id;
					self.personRecord := L.personRecord;
					self.CountryType := L.CountryType;
					self.CountryCode := R.CountryCode;
					self.Comment := IF(L.CountryType = 'Resident of','Resident of','');
		END;

		CountryInfo := NORMALIZE(cid, LEFT.CountryValues, xcountry(LEFT,RIGHT));
			
		return CountryInfo;

	end;
	
/*
 countries are available in several fields	
	Persons.Addresses
	Persons.Countries
	Entities.CompanyDetails
*/
		raddr xaddrPersons(Layouts.rPersons L, Layouts.rCountries R) := TRANSFORM
					self.id := L.id;
					self.personRecord := true;
					self.CountryType := R.CountryType;
					self.CountryValues := R.CountryValues;
		END;
		raddr xaddrEntities(Layouts.rEntities L, Layouts.rCountries R) := TRANSFORM
					self.id := L.id;
					self.personRecord := false;
					self.CountryType := R.CountryType;
					self.CountryValues := R.CountryValues;
		END;
		

EXPORT AllCountries := FUNCTION

		PersonCountries := ExtractCountryInfo(NORMALIZE(File_Person, LEFT.Countries, xaddrPersons(LEFT,RIGHT)));
		EntityCountries := ExtractCountryInfo(NORMALIZE(File_Entity, LEFT.Countries, xaddrEntities(LEFT,RIGHT)));
		countries1 := SORT(PersonCountries + EntityCountries, id, local);
		countries2 := JOIN(countries1, Lists.CountryList, LEFT.CountryCode = RIGHT.code, TRANSFORM(rCountry,
											self.CountryName := RIGHT.name; //Production
											//self.CountryName := (if(RIGHT.name<>'Not Known',RIGHT.name,'&#x20;'));//Test
											self := LEFT;), LEFT OUTER, LOOKUP) : INDEPENDENT;
		countries := JOIN(countries2, dRegions, LEFT.CountryCode = RIGHT.CountryCode, TRANSFORM(rCountry,
											self.countryid := RIGHT.countryid;
											self.Region := RIGHT.regionname;
											self.regionid := RIGHT.regionid;
											self := LEFT;), LEFT OUTER, LOOKUP);
		return countries;
END;