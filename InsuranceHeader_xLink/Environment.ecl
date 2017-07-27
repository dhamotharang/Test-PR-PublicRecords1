/**
 * Defines which environment xLink is running so it applies different rules
 * for choosing and IDL
 */
EXPORT Environment := MODULE	
	EXPORT Values := ENUM(UNSIGNED1, ALPHA, BOCA); 
	// EXPORT Current := Values.ALPHA;
	EXPORT Current := Values.BOCA;
	EXPORT BOOLEAN isCurrentBoca := Current=Values.BOCA;
	EXPORT BOOLEAN isCurrentAlpha := Current=Values.ALPHA; 
	
END;