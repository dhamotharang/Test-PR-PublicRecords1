import lib_stringlib;
export mod_AmpersandTools := 
MODULE

	export SimpleReplace(string cn) := stringlib.StringFindReplace(cn,'&','AND');
	
	export boolean hasAmpersand(string cn) 						:= stringlib.stringFind(cn, '&', 1) > 0;
	export boolean hasAnd(string cn) 									:= stringlib.stringFind(cn, ' AND ', 1) > 0;
	export boolean hasAmpersandOrHasAnd(string cn) 		:= hasAmpersand(cn) OR hasAnd(cn);
	export string 	createAlternativeName(string cn) 	:= 
	// for now, i am ignoring the case of both ('B AND C & D PIZZA')
	map(
		hasAnd(cn) =>
			stringlib.StringFindReplace(cn,' AND ',' & '),
		hasAmpersand(cn) =>
			stringlib.StringFindReplace(stringlib.StringFindReplace(cn,' & ',' AND '),'&',' AND '), //there may or may not be a space
		cn
	);
	


END;