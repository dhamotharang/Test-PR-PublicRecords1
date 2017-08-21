export unk_add(STRING5 str) :=
FUNCTION
	
	tobe_added := str[3] BETWEEN '1' AND '8';
	is_new := str[3]='K';
	num := (unsigned)(str[3]);
	is_too_high := str[3] IN ['0','9'];


	new3rd := (STRING1)
						MAP(tobe_added => (STRING1)(num+1),
								is_new => '1',
								is_too_high => '0', 'K');


RETURN 'UN'+new3rd;
END;