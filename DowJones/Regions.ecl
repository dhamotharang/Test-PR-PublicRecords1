
		validTypePerson := ['Citizenship','Resident of'];
		//validTypeEntity := ['Jurisdiction','Country of Affiliation']; // OLD PRODUCTION
	  ValidTypeEntity := ['Jurisdiction','Country of Affiliation', 'Country of Registration']; //Production

		personRegions := AllCountries(countrytype in validTypePerson);
		entityRegions := AllCountries(countrytype in validTypeEntity);
		
		NoRegionForPerson := 
				JOIN(File_Person, personRegions(region <> 'COUNTRY_GROUP_UNK'), LEFT.id = RIGHT.id,
							TRANSFORM(DowJones.Layouts.rPersons,
									SELF := LEFT;),
									LEFT ONLY, LOCAL);
									
	UseAddresses(dataset(DowJones.Layouts.rPersons) infile) := FUNCTION
	
		DowJones.rCountry xid(DowJones.Layouts.rPersons L, DowJones.Layouts.rAddresses R) := TRANSFORM
					self.id := L.id;
					self.personRecord := true;
					self.countrytype := 'address';
					self.CountryCode := R.AddressCountry;
					//self.CountryCode := (if (R.AddressCountry<>'Not Known',R.AddressCountry,' '));
		END;
		
		countries1 := NORMALIZE(infile, LEFT.Addresses, xid(LEFT,RIGHT));
		countries2 := JOIN(countries1, DowJones.Lists.CountryList, LEFT.CountryCode = RIGHT.code, TRANSFORM(DowJones.rCountry,
											self.CountryName := RIGHT.name; //Production
											//self.CountryName := (if (RIGHT.name<>'Not Known',RIGHT.name,'&#x20;'));//Test
											self := LEFT;), LEFT OUTER, LOOKUP);
		countries := JOIN(countries2, DowJones.dRegions, LEFT.CountryCode = RIGHT.CountryCode, TRANSFORM(DowJones.rCountry,
											self.Region := RIGHT.regionname;
											self.regionid := RIGHT.regionid;
											self := LEFT;), LEFT OUTER, LOOKUP);

		return countries;
	end;

EXPORT Regions := FUNCTION

	newlife := UseAddresses(NoRegionForPerson);
	ds1 := personRegions & entityRegions & newlife;

	ds := DEDUP(SORT(ds1,id,region,local),id,region,local) : PERSIST('~thor::dowjones::persist::regions');
	return ds;
END;
	