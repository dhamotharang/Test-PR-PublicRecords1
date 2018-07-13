EXPORT fn_NameQuality(DATASET(Layouts.rNameCache) ds) := PROJECT(ds, Layouts.rNameExtended,
											cln :=  Address.Persons.PrecleanName(LEFT.name);                                      
											SELF.fmt := Address.Persons.PersonalNameFormat(cln);
											SELF.quality := Address.Persons.NameQualityText(cln);
											SELF.segments := Address.Persons.GetNameSegments(cln);
											SELF := LEFT;)
			);