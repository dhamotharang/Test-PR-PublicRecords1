export Function_ReformatPercent(string pStringIn) :=
   if(trim(pStringIn,left,right)!='',
	if(stringlib.stringfind(pStringIn,'.',1)!=0,
	 intformat((integer)trim(pStringIn[1..stringlib.stringfind(pStringIn,'.',1)-1],left,right),2,1)+
     stringlib.stringrepad(trim(stringlib.stringfilterout(pStringIn,'% ')[stringlib.stringfind(pStringIn,'.',1)+1..stringlib.stringfind(pStringIn,'.',1)+2],left,right),2),
    pStringIn),'');