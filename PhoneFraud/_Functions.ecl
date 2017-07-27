EXPORT _Functions := MODULE

	IMPORT std;

	//pull alpha only
	EXPORT clAlph(string a):= FUNCTION
		return stringlib.stringfilter(stringlib.stringtouppercase(a), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	END;

	//pull string numbers only
	EXPORT clNum(string ph) := FUNCTION
		return stringlib.stringfilter(ph, '0123456789');
	END;
		
	//remove nulls
	EXPORT rmNull(string fld):= FUNCTION
		return std.str.findReplace(std.str.findReplace(std.str.findReplace(fld,'\\N', ''), '(null)', ''), '(NULL)', '');
	END;
	
	//remove pipe
	EXPORT rmPipe(string p):= FUNCTION
		return std.str.findReplace(p,'|', '');
	END;
		
END;