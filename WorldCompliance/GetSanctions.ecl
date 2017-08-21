import std;
EXPORT GetSanctions(dataset(Layouts.rEntity) infile) := 

	 JOIN(infile, Files.dsSources, STD.Str.ToUpperCase(LEFT.NameSource) = STD.Str.ToUpperCase(RIGHT.SourceAbbrev),
						TRANSFORM(rSanctions,
								self.Ent_Id := LEFT.Ent_Id;
								self.EffectiveDate := Left.EffectiveDate;
								self.ExpirationDate := Left.ExpirationDate;
								self.comment := RIGHT.SourceName + IF(LEFT.EffectiveDate='','',' Effective: '+Left.EffectiveDate)
												+ IF(LEFT.ExpirationDate='','',' Expiration: '+Left.ExpirationDate);
								self := RIGHT), lookup, INNER);
