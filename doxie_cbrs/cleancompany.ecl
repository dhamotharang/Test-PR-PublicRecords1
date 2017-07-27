export cleancompany(string in_company) :=
function
  string rempunct := regexreplace('[^A-Za-z0-9]',in_company,' ');
	string redspc := regexreplace('[ ]+',rempunct,' ');
	string redspc2 := regexreplace('^ | $',redspc,'');
	string fixinc := regexreplace(' INC | INC$',redspc2,' INCORPORATED ');
	string fixltd := regexreplace(' LTD | LTD$',fixinc,' LIMITED ');
	string fixcorp := regexreplace(' CORP | CORP$',fixltd,' CORPORATION ');
	string fixco := regexreplace(' CO | CO$',fixcorp,' COMPANY ');
	string fixgrp := regexreplace(' GRP | GRP$',fixco,' GROUP ');
	string fixsvc := regexreplace(' SVC | SVC$',fixgrp,' SERVICE ');
	string fixsvcs := regexreplace(' SVCS | SVCS$',fixsvc,' SERVICES ');
	string fixfin := regexreplace(' FIN | FIN$',fixsvcs,' FINANCE ');
	string fixintl := regexreplace('^INTL |^INT L | INTL | INT L | INTL$| INT L$',fixfin,' INTERNATIONAL ');
	string fixuniv := regexreplace('^UNIV | UNIV | UNIV$',fixintl,' UNIVERSITY ');
	string fixhosp := regexreplace(' HOSP | HOSP$',fixuniv,' HOSPITAL ');
	string fixctr := regexreplace(' CTR | CTR$',fixhosp,' CENTER ');
	string fixusa := regexreplace('^U S A | U S A | U S A$',fixctr,' USA ');
	string fixllc := regexreplace(' L L C | L L C$',fixusa,' LLC ');
	string fixlp := regexreplace(' L P | L P$',fixllc,' LP ');
	string fixthe := regexreplace('^THE | THE | THE$',fixlp,' ');
	string fixand := regexreplace(' AND | AND$',fixthe,' ');
	string fixof := regexreplace(' OF | OF$',fixand,' ');
	string removeallsandspc := regexreplace('S| ',fixof,'');
	return trim(removeallsandspc,left,right);
end;