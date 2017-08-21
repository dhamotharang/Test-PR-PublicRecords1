	rgxBadAddress :=
			 '\\b(GENERAL.*DELIVERY|HOMELESS|HOMLESS|HOMLSS|UNKNOWN|GENERAL LIVING|ENTREGA GENERAL|1249 DONALD LEE HOLLO(WEL)?)\\b';
	rgxBadAddress1 :=
			 '^(SAME|N A|NA|SW)$';

EXPORT fn_IsValidAddress(string addr) := NOT REGEXFIND(rgxBadAddress, TRIM(addr)) AND
																							NOT REGEXFIND(rgxBadAddress1, TRIM(addr))	;
