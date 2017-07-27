export Function_BookPage(string21 pStringIn) :=
      if(stringlib.stringfind(pStringIn,'/',1)=0,
	   '                    ',
	  if(stringlib.stringfind(pStringIn,'/',1)=1,
	   '          ' +
	   stringlib.stringrepad(pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',1)+11],10),
	  if(stringlib.stringfind(pStringIn,'/',1)>1,
	   stringlib.stringrepad(pStringIn[1..stringlib.stringfind(pStringIn,'/',1)-1],10) +
	   stringlib.stringrepad(pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',1)+11],10),
	  ''))); 
/*	
export Function_BookPage(string21 pStringIn) :=
      if(stringlib.stringfind(pStringIn,'/',1)=0,
	   '00000000000000000000',
	  if(stringlib.stringfind(pStringIn,'/',1)=1,
	   '0000000000' +
	   stringlib.stringrepad(pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',1)+11],10),
	  if(stringlib.stringfind(pStringIn,'/',1)>1,
	   intformat((integer)pStringIn[1..stringlib.stringfind(pStringIn,'/',1)-1],10,1) +
	   intformat((integer)pStringIn[stringlib.stringfind(pStringIn,'/',1)+1..stringlib.stringfind(pStringIn,'/',1)+11],10,1),
	  ''))); 	
*/	  