IMPORT PRTE2_Foreclosure;

EXPORT Layouts_Foreclosures := MODULE
	
		EXPORT FRLC_XRef_Base := RECORD
				UNSIGNED4 BaseRec;
				UNSIGNED4 MatchRec;
				PRTE2_Foreclosure.Layouts.batch_in;
		END;

		EXPORT FRCL_XRef_Layout1 := RECORD
				UNSIGNED4 XRec1;
				PRTE2_Foreclosure.Layouts.batch_in;
		END;

		EXPORT FRCL_XRef_Layout2 := RECORD
				UNSIGNED4 XRec1;
				UNSIGNED4 XRec2;
				PRTE2_Foreclosure.Layouts.batch_in;
		END;

		EXPORT scramble_double_check := RECORD
				UNSIGNED4 XRec1;
				UNSIGNED4 XRec2;
				UNSIGNED4 BaseRec;
				UNSIGNED4 MatchRec;
				PRTE2_Foreclosure.Layouts.editable_spreadsheet;
		END;				
				
END;