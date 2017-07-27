export Function_Parse_BriefDescription(string pStringIn) :=
	if(stringlib.stringfind(pStringIn,'Brief Description:',1)!=0,
    trim(pStringIn[stringlib.stringfind(pStringIn,'Brief Description:',1)+18..stringlib.stringfind(pStringIn,'Brief Description:',1)+143],left,right),
	'');