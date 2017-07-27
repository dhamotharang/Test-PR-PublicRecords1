export person_cleaner(STRING str) :=
FUNCTION
	a := Stringlib.StringFindReplace(str,'.',' ');
	b := Stringlib.StringFindReplace(a,',',' ');
	c := Stringlib.StringFindReplace(b,':',' ');
	d := Stringlib.StringFindReplace(c,'(',' ');
	e := Stringlib.StringFindReplace(d,')',' ');
	f := Stringlib.StringToUpperCase(e);
	g := Stringlib.StringCleanSpaces(f);
	RETURN g;
END;