export MAC_StripSynonyms(ds, field, idfield, result) := MACRO
#uniquename(ws)
#uniquename(alpha)
#uniquename(stuff)
#uniquename(pr)
#uniquename(dsParsed)
#uniquename(dsRolled)
#uniquename(dsMissed)
#uniquename(dsComplete)
#uniquename(dsDedupped)

	PATTERN %ws% := ' ';
	PATTERN %alpha% := PATTERN('[ABCDEFGHIJKLMNOPQRSTUVWXYZÑ]+');  //ALT 165 --> Ñ
	PATTERN %stuff% := PATTERN('[ABCDEFGHIJKLMNOPQRSTUVWXYZÑ ]+');
	RULE %pr% := %stuff% OPT('(OR' %ws% %stuff% ')');

	%dsParsed% :=
		PARSE(ds, field, %pr%,
					TRANSFORM(RECORDOF(ds),
										SELF.field := (unicode)MATCHTEXT(%stuff%[1]);
										SELF := LEFT;),
					FIRST, SCAN);
	%dsRolled% :=
		ROLLUP(DISTRIBUTED(%dsParsed%,HASH(idfield)),
					 TRANSFORM(RECORDOF(ds),
										 SELF.field := LEFT.field+u' '+RIGHT.field;
										 SELF := LEFT;),
					 idfield, LOCAL);
	%dsMissed% :=
		JOIN(DISTRIBUTED(ds,HASH(idfield)), %dsRolled%,
				 LEFT.idfield=RIGHT.idfield,
				 TRANSFORM(RECORDOF(ds),
									 SELF := LEFT;),
				 LEFT ONLY, LOCAL);
	%dsComplete% := %dsMissed%+%dsRolled%;
	%dsDedupped% := DEDUP(SORT(%dsComplete%,idfield,LOCAL),idfield,LOCAL);
	result := %dsDedupped%;

ENDMACRO;  
