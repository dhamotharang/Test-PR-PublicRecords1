export Function_ReformatDate(string pStringIn) :=
   if(trim(pStringIn,left,right)='',
    '',
   if(stringlib.stringfind(pStringIn,'/',1)!=0 AND stringlib.stringfind(pStringIn,'/',2)=0,
    intformat((integer)trim(pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',1)+5],left,right),4,1) +
	intformat((integer)trim(pStringIn[1..stringlib.stringfind(pStringIn,'/',1)],left,right),2,1) +
	'00',    
   if(stringlib.stringfind(pStringIn,'/',1)!=0 AND stringlib.stringfind(pStringIn,'/',2)!=0,
    intformat((integer)trim(pStringIn[stringlib.stringfind(pStringIn,'/',2)+1..stringlib.stringfind(pStringIn,'/',2)+5],left,right),4,1) +
    intformat((integer)trim(pStringIn[1..stringlib.stringfind(pStringIn,'/',1)-1],left,right),2,1) +
    intformat((integer)trim(pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',2)-1],left,right),2,1),
   if(stringlib.stringfind(pStringIn,'/',1)=0,
	intformat((integer)trim(pStringIn,left,right),4,1) +
    '00' +
	'00',
   ''))));
/*   
export Function_ReformatDate(string pStringIn) :=
   if(trim(pStringIn,left,right)='',
    '',
   if(stringlib.stringfind(pStringIn,'/',1)!=0 AND stringlib.stringfind(pStringIn,'/',2)=0,
    '00' +
	intformat((integer)trim(pStringIn[1..stringlib.stringfind(pStringIn,'/',1)],left,right),2,1) +
    intformat((integer)trim(pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',1)+5],left,right),4,1),
   if(stringlib.stringfind(pStringIn,'/',1)!=0 AND stringlib.stringfind(pStringIn,'/',2)!=0,
    intformat((integer)trim(pStringIn[1..stringlib.stringfind(pStringIn,'/',1)-1],left,right),2,1) +
    intformat((integer)trim(pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',2)-1],left,right),2,1) +
    intformat((integer)trim(pStringIn[stringlib.stringfind(pStringIn,'/',2)+1..stringlib.stringfind(pStringIn,'/',2)+5],left,right),4,1),
   if(stringlib.stringfind(pStringIn,'/',1)=0,
    '00' +
	'00' +
	intformat((integer)trim(pStringIn,left,right),4,1),
   ''))));
*/   