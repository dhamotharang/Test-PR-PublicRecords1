import STD;
EXPORT dsCountryCodes := PROJECT(Files.dsCountries, TRANSFORM(rCriteria,
														self.name := LEFT.CountryName; //STD.Uni.FindReplace(LEFT.CountryName,' & ',' &amp; ');
														self.valueid := LEFT.CountryId;));