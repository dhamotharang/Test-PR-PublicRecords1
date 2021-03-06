export Function_Parse_Block(string pStringIn) :=
	if(stringlib.stringfind(pStringIn,'BLOCK:',1)!=0,
     if(stringlib.stringfind(pStringIn,'SECTION:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'SECTION:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'DISTRICT:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'DISTRICT:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'LAND LOT:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'LAND LOT:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'UNIT:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'UNIT:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'CITY:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'CITY:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'SUBDIVISION:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'SUBDIVISION:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'PHASE NUMBER:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'PHASE NUMBER:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'TRACT NUMBER:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'TRACT NUMBER:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'SEC/TWN/RNG/MERIDIAN:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'CENSUS TRACT:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'CENSUS TRACT:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'OWNERSHIP RECORD TYPE:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'OWNERSHIP RECORD TYPE:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'Brief Description:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'Brief Description:',1)-1],left,right),
	 trim(pStringIn[stringlib.stringfind(pStringIn,'BLOCK:',1)+6..stringlib.stringfind(pStringIn,'BLOCK:',1)+13],left,right)))))))))))))),
	'');