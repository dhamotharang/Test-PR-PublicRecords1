export company_cleaner(STRING str) :=
FUNCTION
	a := Stringlib.StringToUpperCase(str);
	b := Stringlib.StringFindReplace(a,',',' ');
	c := Stringlib.StringFindReplace(b,':',' ');
	d := Stringlib.StringFindReplace(c,'(',' ');
	e := Stringlib.StringFindReplace(d,')',' ');
	f := Stringlib.StringFindReplace(e,' A.K.A. ',' ');
	g := Stringlib.StringFindReplace(f,' F.K.A. ',' ');
	h := Stringlib.StringFindReplace(g,' N.K.A. ',' ');
	i := Stringlib.StringCleanSpaces(h);
	RETURN i;
END;