export TypoSSN(STRING9 ssn) :=
FUNCTION

r :=
RECORD
	STRING9 ssn_val;
END;

inl := DATASET([{ssn}],r);

r explode(r le, INTEGER i) :=
TRANSFORM
	pos := (i-1) DIV 10 + 1;
	num := (STRING1)(i % 10);
	
	beforepos := le.ssn_val[1..pos-1];
	afterpos := le.ssn_val[pos+1..9];

	SELF.ssn_val := IF(le.ssn_val[pos]=num, SKIP, beforepos+num+afterpos);
END;

ds := NORMALIZE(inl,10*LENGTH(TRIM(ssn)),explode(LEFT,COUNTER))+inl;

RETURN SET(ds,ssn_val);

END;