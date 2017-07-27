import lib_stringlib;
export Fn_SubstituteForAndString(
	string orig,
	string filt) := 
FUNCTION

// KEYBUILD GOES LIKE THIS
//	ME AND YOU  -> MEANDYOU
//	ME & YOU	-> MEYOU

// WHAT WE WANT IS TO CREATE AN ADDITIONAL SEARCH STRING FOR THE WORD MATCH SO WE FIND MORE HITS
//	INPUT		ORIG STRING		ADD'L STRING
//	ME AND YOU	MEANDYOU		MEYOU
//	ME & YOU	MEYOU			MEANDYOU

and_pos := stringlib.StringFind(orig, ' AND ', 1);
amp_pos := stringlib.StringFind(orig, ' & ', 1);

boolean has_and := and_pos > 0;
boolean has_amp := amp_pos > 0;

// IF THERE WAS AN 'AND', THEN WE WANT A VERSION WITHOUT
// before_and 		:= orig[and_pos - 1];
// after_and 		:= orig[and_pos + 5];
before_and 		:= orig[and_pos - 2..and_pos - 1];
after_and 		:= orig[and_pos + 5..and_pos + 6];

find_and 		:= before_and + 'AND' + after_and;
replace_and		:= before_and + after_and;
replaced_and 	:= stringlib.StringFindReplace(filt, find_and, replace_and);

// IF THERE WAS AN &, THEN WE WANT A VERSION WITH 'AND'
// before_amp 		:= orig[amp_pos - 1];
// after_amp 		:= orig[amp_pos + 3];
before_amp 		:= orig[amp_pos - 2..amp_pos - 1];
after_amp 		:= orig[amp_pos + 3..amp_pos + 4];

find_amp 		:= before_amp + after_amp;
replace_amp		:= before_amp + 'AND' + after_amp;
replaced_amp 	:= stringlib.StringFindReplace(filt, find_amp, replace_amp);




// output(and_pos, named('and_pos'));
// output(before_and, named('before_and'));
// output(after_and, named('after_and'));

// output(amp_pos, named('amp_pos'));
// output(before_amp, named('before_amp'));
// output(after_amp, named('after_amp'));

return map(has_and => replaced_and,
		   has_amp => replaced_amp,
		   '');

END;