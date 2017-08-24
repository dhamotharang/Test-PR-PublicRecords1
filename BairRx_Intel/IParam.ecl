import BairRx_Common, iesp;

EXPORT IParam := MODULE

	EXPORT getSearchParams(iesp.bair_intel.t_BAIRIntelSearchBy searchBy) := FUNCTION
		
		base_params := BairRx_Common.IParam.getSearchParams(searchBy, BairRx_Common.Constants.SearchType.Intel);
		
		BairRx_Common.Layouts.ModeContext xtModeContext() := TRANSFORM						
			SELF.mID := BairRx_Common.Constants.Mode.INT,
			SELF.codes := BairRx_Common.Functions.SplitClassCodes(BairRx_Common.Constants.Mode.INT, searchBy.Classification),
			SELF.clean_codes := BairRx_Common.Functions.SplitClassCodes(BairRx_Common.Constants.Mode.INT, searchBy.Classification, TRUE),
			SELF.data_relation := BairRx_Common.DataRelation.FromInput(searchBy.DataRelation),
			SELF.sorting_clause := BairRx_Common.Functions.Trim2Upper(searchBy.SortingClause),
			SELF.filters := PROJECT(searchBy.Filters(Expression != ''),TRANSFORM(BairRx_Common.Layouts.FilterExpression, SELF.expression := BairRx_Common.Functions.Trim2Upper(LEFT.Expression))),
			SELF.filter_search := (base_params.KeyWord != '' or EXISTS(SELF.filters))
		END;
		
		inModeContext := DATASET([xtModeContext()]);
		
		BairRx_Common.Layouts.ActiveModes xtActiveMode() := TRANSFORM
			SELF.INT := exists(inModeContext[1].codes);
		END;
						
		in_params := MODULE(project(base_params, BairRx_Common.IParam.SearchParam, opt))
			EXPORT DATASET(BairRx_Common.Layouts.ModeContext) ModeContext := inModeContext;
			EXPORT DATASET(BairRx_Common.Layouts.ActiveModes) Active := DATASET([xtActiveMode()]);
		END;
	
		return in_params;
	
	END;	
	
END;