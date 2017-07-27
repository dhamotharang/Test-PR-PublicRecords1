// Simple word stemming, Harmon 1991
EXPORT STRING Stem_Word(STRING word) := FUNCTION
	STRING w1 := TRIM(StringLib.StringToUpperCase(word));
	STRING w2	:= StringLib.StringReverse(w1);
	rslt := MAP(
		LENGTH(w1) < 5						=>	w1,
		w1='MOVIES'								=>	'MOVIE',
		w2[1..4]='SEIE'						=>	w1,
		w2[1..4]='SEIA'						=>	w1,
		w2[1..3]='SEI'						=>	w1[1..LENGTH(w1)-3] + 'Y',
		w2[1..3]='SEA'						=>	w1,
		w2[1..3]='SEE'						=>	w1,
		w2[1..3]='SEO'						=>	w1,
		w2[1..2]='SE'							=>	w1[1..LENGTH(w1)-1],
		w2[1..2]='SU'							=>	w1,
		w2[1..2]='SS'							=>	w1,
		w2[1]='S'									=>	w1[1..LENGTH(w1)-1],
		w1);
	RETURN rslt;
END;