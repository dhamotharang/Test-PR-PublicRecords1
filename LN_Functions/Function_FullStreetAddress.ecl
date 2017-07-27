/*
export Function_FullStreetAddress(string pStringIn) := 
    if(stringlib.stringfind(pStringIn,',',6)!=0,
     trim(pStringIn[stringlib.stringfind(pStringIn,',',4)+2..stringlib.stringfind(pStringIn,',',5)-1],left,right),
    if(stringlib.stringfind(pStringIn,',',5)!=0 AND stringlib.stringfind(pStringIn[stringlib.stringfind(pStringIn,',',3)..stringlib.stringfind(pStringIn,',',4)],'#',1)!=0,
	 trim(pStringIn[stringlib.stringfind(pStringIn,',',2)+2..stringlib.stringfind(pStringIn,',',4)-1],left,right),
    if(stringlib.stringfind(pStringIn,',',5)!=0,
	 trim(pStringIn[stringlib.stringfind(pStringIn,',',3)+2..stringlib.stringfind(pStringIn,',',4)-1],left,right),
    if(stringlib.stringfind(pStringIn,',',4)!=0 AND stringlib.stringfind(pStringIn[stringlib.stringfind(pStringIn,',',2)..stringlib.stringfind(pStringIn,',',3)],'#',1)!=0,
	 trim(pStringIn[stringlib.stringfind(pStringIn,',',1)+2..stringlib.stringfind(pStringIn,',',3)-1],left,right),
    if(stringlib.stringfind(pStringIn,',',4)!=0,
	 trim(pStringIn[stringlib.stringfind(pStringIn,',',2)+2..stringlib.stringfind(pStringIn,',',3)-1],left,right),
    if(stringlib.stringfind(pStringIn,',',3)!=0,
	 trim(pStringIn[stringlib.stringfind(pStringIn,',',1)+2..stringlib.stringfind(pStringIn,',',2)-1],left,right),
    if(stringlib.stringfind(pStringIn,',',2)!=0,
	 trim(pStringIn[1..stringlib.stringfind(pStringIn,',',1)-1],left,right),
	'')))))));
*/	
export Function_FullStreetAddress(string pStringIn) :=
    if(stringlib.stringfind(pStringIn,'C/O',1)=0,
	 if(stringlib.stringfind(pStringIn,'#',1)=0 AND stringlib.stringfind(pStringIn,', UNIT ',1)=0,
	  if(stringlib.stringfind(pStringIn,',',3)!=0,
	   trim(pStringIn[1..stringlib.stringfind(pStringIn,',',2)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',2)!=0,
	   trim(pStringIn[1..stringlib.stringfind(pStringIn,',',1)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',1)!=0,
	   '',''))),
	 if(stringlib.stringfind(pStringIn,'#',1)!=0 OR stringlib.stringfind(pStringIn,', UNIT ',1)!=0,
	  if(stringlib.stringfind(pStringIn,',',3)!=0,
	   trim(pStringIn[1..stringlib.stringfind(pStringIn,',',2)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',2)!=0,
	   trim(pStringIn[1..stringlib.stringfind(pStringIn,',',2)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',1)!=0,
	   trim(pStringIn,left,right),
	   ''))),'')),
	if(stringlib.stringfind(pStringIn,'C/O',1)!=0,
	 if(stringlib.stringfind(pStringIn,'#',1)=0 AND stringlib.stringfind(pStringIn,', UNIT ',1)=0,
	  if(stringlib.stringfind(pStringIn,',',7)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',5)+1..stringlib.stringfind(pStringIn,',',6)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',6)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',4)+1..stringlib.stringfind(pStringIn,',',5)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',5)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',3)+1..stringlib.stringfind(pStringIn,',',4)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',4)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',2)+1..stringlib.stringfind(pStringIn,',',3)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',3)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',1)+1..stringlib.stringfind(pStringIn,',',2)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',2)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',2)+1..stringlib.stringfind(pStringIn,',',2)+61],left,right),
	  if(stringlib.stringfind(pStringIn,',',1)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',1)+1..stringlib.stringfind(pStringIn,',',1)+61],left,right),
	  ''))))))),
	 if(stringlib.stringfind(pStringIn,'#',1)!=0 OR stringlib.stringfind(pStringIn,', UNIT ',1)!=0,
	  if(stringlib.stringfind(pStringIn,',',7)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',4)+1..stringlib.stringfind(pStringIn,',',6)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',6)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',3)+1..stringlib.stringfind(pStringIn,',',5)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',5)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',2)+1..stringlib.stringfind(pStringIn,',',4)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',4)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',1)+1..stringlib.stringfind(pStringIn,',',3)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',3)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',1)+1..stringlib.stringfind(pStringIn,',',2)-1],left,right),
	  if(stringlib.stringfind(pStringIn,',',2)!=0,
	   trim(pStringIn[stringlib.stringfind(pStringIn,',',2)+1..stringlib.stringfind(pStringIn,',',2)+61],left,right),
	  '')))))),'')),''));