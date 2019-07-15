IMPORT std;

EXPORT _Functions := MODULE
	
	EXPORT keepNum(string fld):= FUNCTION
		return stringlib.stringfilter(fld, '0123456789');
	END;
	
	EXPORT keepAlph(string fld):= FUNCTION
		return stringlib.stringfilter(stringlib.stringtouppercase(fld), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	END;

	EXPORT keepAlphNum(string fld):= FUNCTION
		return stringlib.stringfilter(stringlib.stringtouppercase(fld), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .-:*&/_;\'"()!+,@#');
	END;	
	
	EXPORT rmNull(string fld):= FUNCTION
		return std.str.findReplace(stringlib.stringtouppercase(trim(fld, left, right)), '\\N', '');
	END;

END;