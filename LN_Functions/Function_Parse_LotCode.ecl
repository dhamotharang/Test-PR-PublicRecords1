export Function_Parse_LotCode(string pStringIn) :=
	if(stringlib.stringfind(pStringIn,'MULTIPLE LOTS, INCLUDING A PORTION OF ONE OR MORE LOTS',1)!=0,
     'MP',
	if(stringlib.stringfind(pStringIn,'MULTIPLE LOTS',1)!=0,
	 'M',
	if(stringlib.stringfind(pStringIn,'PARTIAL LOT',1)!=0,
	 'P',
	'')));