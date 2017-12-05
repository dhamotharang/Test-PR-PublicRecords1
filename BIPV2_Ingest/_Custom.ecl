import BIPV2_Tools;
EXPORT _Custom := module

	export GetBlanks(ds) := functionmacro
		import bipv2_tools;
		return BIPV2_Tools.Blanks.GetBlanks(ds);
	endmacro;
	export FilterBlanks(ds) := functionmacro
		import bipv2_tools;
		return BIPV2_Tools.Blanks.FilterBlanks(ds);
	endmacro;

end;