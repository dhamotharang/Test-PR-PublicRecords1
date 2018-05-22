export fnHashIDField(string infield) := if(infield = '' , '',
																							(string)hash64(trim(stringlib.stringtouppercase(infield), left, right)));