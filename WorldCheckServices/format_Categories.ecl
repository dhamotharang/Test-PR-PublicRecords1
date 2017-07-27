export SET OF STRING50 format_Categories(SET OF STRING50 c) := 
SET(PROJECT(DATASET(c, {STRING50 cat}), 
	TRANSFORM({STRING50 cat}, 
			  SELF.cat := Stringlib.StringToUpperCase(LEFT.cat))), cat);