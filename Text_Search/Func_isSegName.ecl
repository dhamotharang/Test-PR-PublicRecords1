EXPORT BOOLEAN Func_isSegName(STRING str) := FUNCTION
	SET OF STRING segs := ['BODY', 'HEADLINE', 'DATE', 'DUMB_DUMB'];

	RETURN StringLib.StringToUpperCase(str) IN segs;
END;