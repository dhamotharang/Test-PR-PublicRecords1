export Function_Property_CityStateZip(string pStringIn1, string pStringIn2) := 
	if(trim(pStringIn1,left,right)!='',
     if(stringlib.stringfind(pStringIn1,',',3)!=0,
	  trim(pStringIn1[stringlib.stringfind(pStringIn1,',',2)+1..stringlib.stringfind(pStringIn1,',',2)+51],left,right),
	 if(stringlib.stringfind(pStringIn1,',',2)!=0,
	  trim(pStringIn1[stringlib.stringfind(pStringIn1,',',1)+1..stringlib.stringfind(pStringIn1,',',1)+51],left,right),
	 if(stringlib.stringfind(pStringIn1,',',1)!=0,
	  trim(pStringIn1,left,right),''))),
	if(trim(pStringIn2,left,right)!='',
	 if(stringlib.stringfind(pStringIn2,',',3)!=0,
	  trim(pStringIn2[stringlib.stringfind(pStringIn2,',',2)+1..stringlib.stringfind(pStringIn2,',',2)+51],left,right),
	 if(stringlib.stringfind(pStringIn2,',',2)!=0,
	  trim(pStringIn2[stringlib.stringfind(pStringIn2,',',1)+1..stringlib.stringfind(pStringIn2,',',1)+51],left,right),
	 if(stringlib.stringfind(pStringIn2,',',1)!=0,
	  trim(pStringIn2,left,right),''))),
	''));