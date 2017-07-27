export SET OF STRING30 format_Keywords(SET OF STRING30 k) := 
SET(PROJECT(DATASET(k, {STRING30 kw}), 
	TRANSFORM({STRING30 kw}, 
			  SELF.kw := Stringlib.StringToUpperCase(LEFT.kw))), kw);