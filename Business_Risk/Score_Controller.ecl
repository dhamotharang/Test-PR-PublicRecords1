
import risk_indicators,models;

export Score_Controller(DATASET(Models.Layout_Score_Chooser) model_url, 
											 DATASET(Business_Risk.Layout_Business_Advisor_In) data_input) :=
FUNCTION


/* *************** For Scores **************** */
outer_layout := 
RECORD
	STRING30 AccountNumber;
	DATASET(Models.Layout_Model) models;
END;

outer_layout get_scores(Models.Layout_Score_Chooser le) :=
TRANSFORM
	SELF.models := SOAPCALL(data_input, TRIM(le.url), TRIM(le.name), {data_input}, DATASET(Models.Layout_Model),LOG,parallel(5));
	SELF := [];
END;

p := PROJECT(model_url, get_scores(LEFT));

outer_layout denorm(outer_layout le, Models.Layout_Model ri) :=
TRANSFORM
	SELF.AccountNumber := ri.AccountNumber;
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