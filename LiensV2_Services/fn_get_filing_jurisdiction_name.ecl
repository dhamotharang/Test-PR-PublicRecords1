IMPORT codes;

EXPORT fn_get_filing_jurisdiction_name(STRING fj) :=
FUNCTION

  //I WONDER, SHOULD WE ALSO CONSIDER USING THE FILING_STATE FIELD WHEN IT HOLDS THE ABBREVIATION?

  st2 := fj[1..2];

  BOOLEAN isState := LENGTH(TRIM(fj)) = 2 AND codes.valid_st(fj);

  RETURN IF(isState, codes.St2Name(fj), '');
END;
