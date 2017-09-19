import BairRx_Common, iesp;

EXPORT IParam := MODULE

	EXPORT getSearchParams(iesp.bair_mapincident.t_BAIRMapIncidentSearchBy searchBy, boolean IsRAIDS = FALSE) := FUNCTION
		
		base_params := BairRx_Common.IParam.getSearchParams(searchBy, BairRx_Common.Constants.SearchType.MapIncident, , IsRAIDS,searchby.layerid);
		
		exprFilters(dataset(iesp.bair_share.t_BAIRFieldFilter) expr) := PROJECT(expr(expression != ''), 
			TRANSFORM(BairRx_Common.Layouts.FilterExpression, SELF.expression := BairRx_Common.Functions.Trim2Upper(LEFT.expression)));
		
		modeCxt := PROJECT(searchBy.ModeContext, TRANSFORM(BairRx_Common.Layouts.ModeContext,						
			_mode :=  BairRx_Common.Functions.Trim2Upper(LEFT.ID);
			SELF.mID := _mode,
			SELF.codes := BairRx_Common.Functions.SplitClassCodes(_mode, LEFT.Classification),
			SELF.clean_codes := BairRx_Common.Functions.SplitClassCodes(_mode, LEFT.Classification, TRUE),
			SELF.data_relation := BairRx_Common.DataRelation.FromInput(LEFT.DataRelation),
			SELF.sorting_clause := BairRx_Common.Functions.Trim2Upper(LEFT.SortingClause),
			SELF.filters := exprFilters(LEFT.Filters),
			SELF.filter_search := (base_params.KeyWord != '' or EXISTS(SELF.filters))
		));
		
		active_modes := DATASET([{
			exists(modeCxt(mID=BairRx_Common.Constants.Mode.EVE)[1].codes), 
			exists(modeCxt(mID=BairRx_Common.Constants.Mode.CFS)[1].codes), 
			exists(modeCxt(mID=BairRx_Common.Constants.Mode.CRA)[1].codes), 
			exists(modeCxt(mID=BairRx_Common.Constants.Mode.OFF)[1].codes), 
			exists(modeCxt(mID=BairRx_Common.Constants.Mode.LPR)[1].codes), 
			exists(modeCxt(mID=BairRx_Common.Constants.Mode.SHO)[1].codes), 
			exists(modeCxt(mID=BairRx_Common.Constants.Mode.INT)[1].codes) 
			}], BairRx_Common.Layouts.ActiveModes);	
		
		
		in_params := MODULE(project(base_params, BairRx_Common.IParam.SearchParam, opt))
			EXPORT DATASET(BairRx_Common.Layouts.ModeContext) ModeContext := modeCxt;
			EXPORT DATASET(BairRx_Common.Layouts.ActiveModes) Active := active_modes;
		END;
	
		return in_params;
	
	END;	
	
END;