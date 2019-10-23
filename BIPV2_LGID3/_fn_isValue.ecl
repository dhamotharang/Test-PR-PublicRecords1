// Determine whether the specified STRING is any of up to 10 specified non-null values
// Invoked with FIELDTYPE:name:CUSTOM(fn_isValue,'term1'[...,termN]):ONFAIL(action)
EXPORT BOOLEAN _fn_isValue(
	STRING s, STRING v1,
	STRING v2='', STRING v3='', STRING v4='',
	STRING v5='', STRING v6='', STRING v7='',
	STRING v8='', STRING v9='', STRING v10='') :=
FUNCTION
	SET OF STRING valSet := [v1,v2,v3,v4,v5,v6,v7,v8,v9,v10];
	RETURN (s<>'' AND s IN valSet);
END;
