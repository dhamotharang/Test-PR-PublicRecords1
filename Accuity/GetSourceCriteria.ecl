EXPORT GetSourceCriteria(DATASET($.Layouts.input.rEntity) infile) := FUNCTION

		//dSources := DICTIONARY($.dsSources(infile), {sourceabbrev => sourceid});
		srcs := DISTRIBUTE(PROJECT(infile, 
												TRANSFORM($.rSearchCriteria,
														self.id := (integer)LEFT.id;
														self.criteria := U'1,' + (unicode)left.list_id + U';';
												)
											),
								id);
																				
		return srcs;


END;