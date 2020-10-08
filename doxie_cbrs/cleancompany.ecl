EXPORT cleancompany(STRING in_company) :=
FUNCTION
  STRING rempunct := regexreplace('[^A-Za-z0-9]',in_company,' ');
  STRING redspc := regexreplace('[ ]+',rempunct,' ');
  STRING redspc2 := regexreplace('^ | $',redspc,'');
  STRING fixinc := regexreplace(' INC | INC$',redspc2,' INCORPORATED ');
  STRING fixltd := regexreplace(' LTD | LTD$',fixinc,' LIMITED ');
  STRING fixcorp := regexreplace(' CORP | CORP$',fixltd,' CORPORATION ');
  STRING fixco := regexreplace(' CO | CO$',fixcorp,' COMPANY ');
  STRING fixgrp := regexreplace(' GRP | GRP$',fixco,' GROUP ');
  STRING fixsvc := regexreplace(' SVC | SVC$',fixgrp,' SERVICE ');
  STRING fixsvcs := regexreplace(' SVCS | SVCS$',fixsvc,' SERVICES ');
  STRING fixfin := regexreplace(' FIN | FIN$',fixsvcs,' FINANCE ');
  STRING fixintl := regexreplace('^INTL |^INT L | INTL | INT L | INTL$| INT L$',fixfin,' INTERNATIONAL ');
  STRING fixuniv := regexreplace('^UNIV | UNIV | UNIV$',fixintl,' UNIVERSITY ');
  STRING fixhosp := regexreplace(' HOSP | HOSP$',fixuniv,' HOSPITAL ');
  STRING fixctr := regexreplace(' CTR | CTR$',fixhosp,' CENTER ');
  STRING fixusa := regexreplace('^U S A | U S A | U S A$',fixctr,' USA ');
  STRING fixllc := regexreplace(' L L C | L L C$',fixusa,' LLC ');
  STRING fixlp := regexreplace(' L P | L P$',fixllc,' LP ');
  STRING fixthe := regexreplace('^THE | THE | THE$',fixlp,' ');
  STRING fixand := regexreplace(' AND | AND$',fixthe,' ');
  STRING fixof := regexreplace(' OF | OF$',fixand,' ');
  STRING removeallsandspc := regexreplace('S| ',fixof,'');
  RETURN TRIM(removeallsandspc,LEFT,RIGHT);
END;
