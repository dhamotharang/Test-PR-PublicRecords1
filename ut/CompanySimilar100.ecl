import _Validate;

indic(string l) := (datalib.companyclean(l)[1..40]);
sec(string l) := datalib.companyclean(l)[41..80];
furn(string l) := datalib.companyclean(l)[81..120];

// made this a non-inline function and applied the 'define' keyword
// reduces size of generated code significantly per Gavin
EXPORT CompanySimilar100(string l, string r, boolean use_new = FALSE) := DEFINE FUNCTION
	res := 
		IF(
			use_new,
			IF(
				stringlib.stringfilter(l,_Validate.Strings.Alpha_Upper+ _Validate.Strings.digit) = stringlib.stringfilter(r,_Validate.Strings.Alpha_Upper + _Validate.Strings.digit),
				0,
				MIN(CS100S.new(indic(l), sec(l), indic(r), sec(r), l, r) 
				  , CS100S.new(indic(r), sec(r), indic(l), sec(l), r, l))
			),
			MIN(CS100S.current(indic(l), sec(l), indic(r), sec(r))
			  , CS100S.current(indic(r), sec(r), indic(l), sec(l)))
		);

	RETURN res;
END;