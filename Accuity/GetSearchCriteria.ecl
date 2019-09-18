import STD;
PrepForXML(unicode s) := 
				STD.Uni.FindReplace(
					STD.Uni.FindReplace(s,'&','&amp;'),
				'\'', '&apos;');

SourceCriteria(DATASET($.Layouts.input.rEntity) infile) := FUNCTION	

	return 	SORT(PROJECT($.dsSources(infile), TRANSFORM($.rCriteria,
									self.valueid := left.code;
									//nm := IF(left.ln_name='', left.source_name, left.ln_name);
									self.name := PrepForXML(left.name);)), name);
	
END;


EXPORT GetSearchCriteria(DATASET($.Layouts.input.rEntity) infile) := 

		MakeGroupHeader(SourceCriteria(infile), 1, 'Sources')
;