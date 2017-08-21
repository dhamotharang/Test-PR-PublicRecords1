IMPORT std;

EXPORT _Functions := MODULE
	
	EXPORT rmNull(string fld):= FUNCTION
		return std.str.findReplace(stringlib.stringtouppercase(trim(fld, left, right)), '\\N', '');
	END;

END;