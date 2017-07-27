export Function_Parse_SecTwnRngMer(string pStringIn) :=
	if(stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)!=0,
     if(stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)+21..stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'CENSUS TRACT:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)+21..stringlib.stringfind(pStringIn,'CENSUS TRACT:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'OWNERSHIP RECORD TYPE:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)+21..stringlib.stringfind(pStringIn,'OWNERSHIP RECORD TYPE:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'Brief Description:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)+21..stringlib.stringfind(pStringIn,'Brief Description:',1)-1],left,right),
	 trim(pStringIn[stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)+21..stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)+23],left,right))))),
	'');	