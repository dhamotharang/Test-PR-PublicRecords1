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
CategoryCriteria(dataset(Layouts.rEntity) infile, dataset(layouts.rEntity) dsMasters) := FUNCTION
		//categories := TABLE(infile, {infile.EntryCategory; infile.EntrySubcategory; n := COUNT(GROUP);}, EntryCategory, EntrySubcategory, FEW);
		cat0 := DEDUP(dsMasters(Ent_ID in SET(infile, Ent_ID)),EntryCategory,EntrySubcategory, ALL);									
		categories := TABLE(cat0, {cat0.EntryCategory; cat0.EntrySubcategory; n := COUNT(GROUP);}, EntryCategory, EntrySubcategory, FEW);
		//categories := DISTRIBUTE(cat1, hash32(EntryCategory));
		return SORT(
						JOIN(DISTRIBUTE(categories), AllCategoriesFixed, LEFT.EntryCategory + '-' + LEFT.EntrySubCategory = RIGHT.name,
									TRANSFORM(rCriteria,
														self.valueid := right.valueid;
														self.name := RIGHT.name;),
														LOOKUP, INNER),
						name);
END;

ConsolidatedCriteria := FUNCTION
		sources := SORT($.GetSanctionsCriteria, SourceName);
											
		return PROJECT(sources,
									TRANSFORM(WorldCompliance.rCriteria,
														self.valueid := left.SourceId;
														self.name := PrepForXML(left.SourceName);)
					);
END;

EXPORT GetSearchCriteriaEx(dataset(Layouts.rEntity) infile, boolean IncludeSanctionsCriteria) := 
															
		MakeGroupHeader(SORT(CountryCriteria(infile),name), 1, 'Country')
		+MakeGroupHeader(dsRegion, 2, 'Regional Level')
		+MakeGroupHeader(CategoryCriteria(infile, Files.dsMasters), 3, 'Category')
		+MakeGroupHeader(dsDeceased, 4, 'Deceased State')
		+MakeGroupHeader(SourceCriteria(infile), 5, 'Source')
		+IF(IncludeSanctionsCriteria, 
			MakeGroupHeader(ConsolidatedCriteria, 6, 'Consolidated Sanctions'),
			'')
		;
