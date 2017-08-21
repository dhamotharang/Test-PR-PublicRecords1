export fn_data_pattern(string s) := 
    stringlib.stringsubstituteout(
    stringlib.stringsubstituteout(
		  stringlib.stringsubstituteout(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','A'),
			'abcdefghijklmnopqrstuvwxyz','a'),
			'0123456789','9');