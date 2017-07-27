export MAC_Sample(infile,outfile) := macro
  #uniquename(initials)
  %initials% := infile( match_company_name in ['SEISINT',
	'MICROSOFT', 'EQUIFAX', 'EQUIFAX CREDIT INFO SERVICES', 'STARBUCKS', 
	'FEDERAL SUPPLY SERVICE', 'IBM', 'WACO AUTO IMPORTS', 'CHAD MORTON',
	'COUNTING CROWS', 'TAMPA BAY BUCCANEERS', 'ALPHA DELTA KAPPA SORORITY INC',
	'CIGARETTES CHEAPER'                                                                                                    
	] );
  #uniquename(rdids)
  %rdids% := record
  %initials%.bdid;
  end;
  #uniquename(ta)
  %ta% := dedup(table(%initials%,%rdids%),bdid,all);

  #uniquename(cpy_l)
  typeof(infile) %cpy_l%(infile le) := transform
  self := le;
  end;

  outfile := join(infile,%ta%,left.bdid=right.bdid,%cpy_l%(left),lookup);

  endmacro;