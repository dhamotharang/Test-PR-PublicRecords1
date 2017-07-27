export SICCodeKeys := macro
	output(choosen(Codes.Key_SIC4,10));
	output(choosen(Codes.Key_NAICS,10));
	output(choosen(infousa.Key_ABIUS_FranCode,10));
endmacro;