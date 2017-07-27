import ut, BIPV2_Best_Proxid;
EXPORT fn_valid_cphone10 (string s, string src):= function 
return  ut.isNumeric(s) and length(trim(s))= 10 and 
			  (unsigned)s[..3] > 0 and
				length(datalib.dedouble(s[..3])) > 1;
end;