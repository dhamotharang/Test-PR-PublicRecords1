	$.rSearchCriteria mergeValue(rSearchCriteria Lft, rSearchCriteria rght) := TRANSFORM
			self.id := Lft.id;
			self.criteria := Lft.criteria + rght.criteria;
	END;
	
EXPORT ProcessSearchCriteria(DATASET($.Layouts.input.rEntity) infile) := FUNCTION

	sources := $.GetSourceCriteria(infile);

	crit := SORT(DISTRIBUTE(sources,id), id, criteria, LOCAL);
	
	result := ROLLUP(crit, mergeValue(LEFT, RIGHT), id, LOCAL);
	
	return result;

END;