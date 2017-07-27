export stripcompany(string in_company) :=
function
  // IF YOU ADD A WORD ADD IT WITHOUT ANY SPACES OR LETTER S'S... SEE CLEANCOMPANY.
  string remtrm := regexreplace('INCORPORATED|' +
	                              'CORPORATION|' +
																'COMPANY|' +
																'LLC|' +
																'LP|' +
																'LIMITED|' +
																'THE|' +
																'GROUP|' +
																'AND|' +
																'OF',in_company,'');
	return trim(remtrm,left,right);
end;