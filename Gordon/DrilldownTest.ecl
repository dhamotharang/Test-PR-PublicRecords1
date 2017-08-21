r := 
	record
		string9 ssn;
  end;
	
d := dataset([{'\\\\\\\'\'\'///'}, {'tab \t'}, {'cr \r'}, {'lf \n'}, {'bs \\'}, {'quote \''}], r);
export DrilldownTest := d;