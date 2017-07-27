import risk_indicators,models,Gateway;

export ScoreController(DATASET(Models.Layout_Score_Chooser) model_url, 
											 DATASET(risk_indicators.Layout_Interactive_In) data_input) :=
FUNCTION


/* *************** For Scores **************** */
data_input_r := project(data_input, transform(risk_indicators.Layout_Interactive_In,
																			self._Blind := Gateway.Configuration.GetBlindOption(data_input.gateways),
																			self := left));


outer_layout := 
RECORD
	STRING30 AccountNumber;
	// DATASET(Models.Layout_Model) models;
	DATASET(models.Layouts.FP_Layout_Model) models;
END;

outer_layout get_scores(Models.Layout_Score_Chooser le) :=
TRANSFORM
	self.models := SOAPCALL(data_input_r, TRIM(le.url), TRIM(le.name), {data_input_r}, DATASET(models.Layouts.FP_Layout_Model),parallel(5));
	SELF := [];
END;

p := PROJECT(model_url, get_scores(LEFT));

outer_layout denorm(outer_layout le, models.Layouts.FP_Layout_Model ri) :=
TRANSFORM
	SELF.AccountNumber := if(trim(ri.description)='', skip, ri.AccountNumber); // filter out the rows from fraudAdvisor service that are created because of the attributes
	SELF.models := ri;
END;
normed := NORMALIZE(p, LEFT.models, denorm(LEFT,RIGHT));

outer_layout combine(outer_layout le, outer_layout ri) :=
TRANSFORM
	SELF.models := le.models+ri.models;
	SELF := le;
END;

j := ROLLUP(SORT(normed,AccountNumber),LEFT.AccountNumber=RIGHT.AccountNumber, combine(LEFT,RIGHT));

RETURN j;

END;