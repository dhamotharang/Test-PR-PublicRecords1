export MAC_Hri_SicCode_GetBestGlb(outfile, infile, key, layout) := macro
	#uniquename(tra)
	layout %tra%(infile le, recordof(key) ri) :=
	TRANSFORM
		SELF.seq := le.seq;
		SELF := ri;
	END;
	outfile := JOIN(infile, key, 
		LEFT.did=RIGHT.did AND 
		LEFT.prim_name=RIGHT.prim_name AND
		LEFT.prim_range=RIGHT.prim_range AND
		LEFT.zip=RIGHT.zip, 
		%tra%(LEFT,RIGHT));

endmacro;
