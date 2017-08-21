import STD;
PrepForXML(unicode s) := 
				STD.Uni.FindReplace(
					STD.Uni.FindReplace(s,'&','&amp;'),
				'\'', '&apos;');

SourceCriteria(dataset(Layouts.rEntity) infile) := FUNCTION
		sources := SORT(TABLE(infile, {infile.NameSource; n := COUNT(GROUP);}, NameSource, FEW),NameSource);
											
		return DEDUP(SORT(
						JOIN(DISTRIBUTE(sources), Files.dsSources, STD.Str.ToUpperCase(LEFT.NameSource)=STD.Str.ToUpperCase(RIGHT.SourceAbbrev), 
									TRANSFORM(rCriteria,
														self.valueid := right.SourceId;
														self.name := PrepForXML(RIGHT.SourceName);),
														LOOKUP, INNER),
						name), name, valueid);
END;

CountryCriteria(dataset(Layouts.rEntity) infile) := FUNCTION  
   countries := DEDUP(SORT(TABLE(infile,
       {cname := Std.Uni.ToUpperCase(infile.Country), n := COUNT(GROUP);}, Country, FEW),cname),cname);

   return JOIN(DISTRIBUTE(countries), dsCountryCodes,  LEFT.cname= Std.Uni.ToUpperCase(RIGHT.Name), 
      TRANSFORM(rCriteria,
								self.valueid := right.valueid;
								self.name := STD.Uni.FindReplace(right.Name,' & ',' &amp; ');), 
								LOOKUP, INNER);
END;

/* CountryCriteria(dataset(Layouts.rEntity) infile) := FUNCTION
		countries := SORT(TABLE(infile, {infile.Country; n := COUNT(GROUP);}, Country, FEW),Country);
											
		return JOIN(DISTRIBUTE(countries), dsCountryCodes, Std.Uni.ToUpperCase(LEFT.Country)=Std.Uni.ToUpperCase(RIGHT.Name),
									TRANSFORM(rCriteria,
														self.valueid := right.valueid;
														self.name := STD.Uni.FindReplace(LEFT.Country,' & ',' &amp; ');),
														LOOKUP, INNER);
END;
*/
CategoryCriteria(dataset(Layouts.rEntity) infile) := FUNCTION
		categories := TABLE(infile, {infile.EntryCategory; infile.EntrySubcategory; n := COUNT(GROUP);}, EntryCategory, EntrySubcategory, FEW);
											
		return SORT(
						JOIN(DISTRIBUTE(categories), AllCategoriesFixed, LEFT.EntryCategory + '-' + LEFT.EntrySubCategory = RIGHT.name,
									TRANSFORM(rCriteria,
														self.valueid := right.valueid;
														self.name := RIGHT.name;),
														LOOKUP, INNER),
						name);
END;

EXPORT GetSearchCriteriaEx(dataset(Layouts.rEntity) infile) := 
															
		MakeGroupHeader(SORT(CountryCriteria(infile),name), 1, 'Country')
		+MakeGroupHeader(dsRegion, 2, 'Regional Level')
		+MakeGroupHeader(CategoryCriteria(infile), 3, 'Category')
		+MakeGroupHeader(dsDeceased, 4, 'Deceased State')
		+MakeGroupHeader(SourceCriteria(infile), 5, 'Source')
		;
