IMPORT marriage_divorce_v2;

EXPORT _Flag := MODULE

  // The default (FALSE) is to skip recleaning of certain fields in the previous base with each build.
	// But this can be set to TRUE if there is ever a need to reclean those fields in the previous base.
	EXPORT Reclean	:= FALSE;

END;