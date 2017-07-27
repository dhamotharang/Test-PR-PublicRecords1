export cl(string s) := TRIM(stringlib.stringcleanspaces(stringlib.stringfilterout(s,',."\'')),left,right);

