export Function_CityStateZip(string pStringIn) :=
	if(stringlib.stringfind(pStringIn,',',6)!=0,
     trim(pStringIn[stringlib.stringfind(pStringIn,',',5)+2..stringlib.stringfind(pStringIn,',',5)+52],left,right),
    if(stringlib.stringfind(pStringIn,',',5)!=0,
     trim(pStringIn[stringlib.stringfind(pStringIn,',',4)+2..stringlib.stringfind(pStringIn,',',4)+52],left,right),
    if(stringlib.stringfind(pStringIn,',',4)!=0,
     trim(pStringIn[stringlib.stringfind(pStringIn,',',3)+2..stringlib.stringfind(pStringIn,',',3)+52],left,right),
    if(stringlib.stringfind(pStringIn,',',3)!=0,
     trim(pStringIn[stringlib.stringfind(pStringIn,',',2)+2..stringlib.stringfind(pStringIn,',',2)+52],left,right),
    if(stringlib.stringfind(pStringIn,',',2)!=0,
	 trim(pStringIn[stringlib.stringfind(pStringIn,',',1)+2..stringlib.stringfind(pStringIn,',',1)+52],left,right),
    if(stringlib.stringfind(pStringIn,',',1)!=0,
	 trim(pStringIn,left,right),
    ''))))));
