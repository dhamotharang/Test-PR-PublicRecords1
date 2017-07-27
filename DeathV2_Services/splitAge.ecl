import ut;
export splitAge(string p_age) :=
MODULE

shared age := trim(p_age, left);

shared firstWord := ut.Word(age, 1, ' ');
shared isInt := trim(firstWord) = trim((string)((integer8)firstWord)) OR
							  trim(firstWord) = '0' + trim((string)((integer8)firstWord));

export int := if(isInt, (integer8)firstWord, 0);

shared firstSpace := stringlib.StringFind(age, ' ', 1);
shared withOutAge := age[firstSpace+1..];
shared withOutOld := stringlib.StringFindReplace(withOutAge, ' OLD','');
shared addYears   := if(withOutOld <> '', withOutOld, 'YEARS');

export unit := if(isInt, addYears, age);

END;