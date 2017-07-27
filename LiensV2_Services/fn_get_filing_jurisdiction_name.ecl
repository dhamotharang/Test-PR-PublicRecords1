import codes;

export fn_get_filing_jurisdiction_name(string fj) :=
FUNCTION

	//I WONDER, SHOULD WE ALSO CONSIDER USING THE FILING_STATE FIELD WHEN IT HOLDS THE ABBREVIATION?

	st2 := fj[1..2];

	boolean isState := length(trim(fj)) = 2 and codes.valid_st(fj);

	return if(isState, codes.St2Name(fj), '');
END;