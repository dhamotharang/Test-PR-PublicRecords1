export Fn_Data_Pattern(string s) := 
    stringlib.stringsubstituteout(
    stringlib.stringsubstituteout(
		  stringlib.stringsubstituteout(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','A'),
			'abcdefghijklmnopqrstuvwxyz','a'),
			'0123456789','9');