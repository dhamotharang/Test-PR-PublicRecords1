numset := ['0','1','2','3','4','5','6','7','8','9'];


// Code to remove garbage from end of line
string RemoveEnd(string s) := FUNCTION

string rs := trim(Stringlib.StringReverse(s));
string lw := Stringlib.StringReverse(trim(rs[1..(Stringlib.StringFind(rs, ' ', 1) - 1)]));
string ts := trim(Stringlib.StringReverse(trim(rs[(Stringlib.StringFind(rs, ' ', 1)+1)..])));


string res := if(((lw[1] = '(' and lw[length(trim(lw))] = ')') or
                  (lw[1] in numset and lw[length(trim(lw))] in numset) or
			   Stringlib.StringFilterOut(lw, '0123456789!@#$%^&*()_-=+{}|<>?,.') = '') and lw[1] <> '#', 
                 ts, s);
			  
RETURN res;

END;

x := 'STATE FARM INSURANCE CO    1xxx53  ';

y := RemoveEnd(x);

y;


