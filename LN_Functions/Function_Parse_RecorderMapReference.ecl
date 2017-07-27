export Function_Parse_RecorderMapReference(string pStringIn) :=
	if(stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)!=0,
     if(stringlib.stringfind(pStringIn,'CENSUS TRACT:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)+25..stringlib.stringfind(pStringIn,'CENSUS TRACT:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'OWNERSHIP RECORD TYPE:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)+25..stringlib.stringfind(pStringIn,'OWNERSHIP RECORD TYPE:',1)-1],left,right),
     if(stringlib.stringfind(pStringIn,'Brief Description:',1)!=0,
	  trim(pStringIn[stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)+25..stringlib.stringfind(pStringIn,'Brief Description:',1)-1],left,right),
	 trim(pStringIn[stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)+25..stringlib.stringfind(pStringIn,'ASSESSOR'+'\'S MAP REFERENCE:',1)+40],left,right)))),
	'');