IMPORT PRTE2_PropertyInfo;

EXPORT Layouts_PII := MODULE


	EXPORT PII_XRef_Base := RECORD
			UNSIGNED4 BaseRec;
			UNSIGNED4 MatchRec;
			PRTE2_PropertyInfo.Layouts.batch_in;
	END;
	
	EXPORT PII_XRef_Layout1 := RECORD
			UNSIGNED4 XRec1;
			PII_XRef_Base;
	END;

	EXPORT PII_XRef_Layout2 := RECORD
			UNSIGNED4 XRec1;
			UNSIGNED4 XRec2;
			PII_XRef_Base;
	END;
	

	EXPORT scramble_double_check := RECORD
			UNSIGNED4 XRec1;
			UNSIGNED4 XRec2;
			UNSIGNED4 BaseRec;
			UNSIGNED4 MatchRec;
			// PRTE2_PropertyInfo.Layouts.PropertyExpandedRec;
			PRTE2_PropertyInfo.z_PropertyExpandedRec;
	END;
	

END;