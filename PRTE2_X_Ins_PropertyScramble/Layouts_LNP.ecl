IMPORT PRTE2_LNProperty;

EXPORT Layouts_LNP := MODULE
	
	EXPORT LNP_XRef_Base := RECORD
			UNSIGNED4 BaseRec;
			UNSIGNED4 MatchRec;
			PRTE2_LNProperty.Layouts.batch_in;
	END;

	EXPORT scramble_double_check := RECORD
			UNSIGNED4 XRec1;
			UNSIGNED4 XRec2;
			UNSIGNED4 BaseRec;
			UNSIGNED4 MatchRec;
			PRTE2_LNProperty.Layouts.editable_spreadsheet;
	END;
	EXPORT LNP_XRef_Layout1 := RECORD
			UNSIGNED4 XRec1;
			UNSIGNED4 BaseRec;
			UNSIGNED4 MatchRec;
			PRTE2_LNProperty.Layouts.batch_in;
	END;
	EXPORT LNP_XRef_Layout2 := RECORD
			UNSIGNED4 XRec1;
			UNSIGNED4 XRec2;
			UNSIGNED4 BaseRec;
			UNSIGNED4 MatchRec;
			PRTE2_LNProperty.Layouts.batch_in;
	END;
	
END;