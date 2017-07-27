fRemoveFormatting(string pStringIn) :=
  stringlib.stringfilterout(pStringIn,'$,. ');

lZeroString := '000000000000000000000000000000';

export Function_ReformatCurrency(string pStringIn, integer pLength) :=
	lZeroString[1..(pLength-length(fRemoveFormatting(pStringIn)))] + fRemoveFormatting(pStringIn);

/*
export Function_ReformatCurrency(string pStringIn, integer pTotalLength) := 
	if(stringlib.stringfind(pStringIn,'.',1)!=0,
	 intformat((integer)trim(stringlib.stringfilterout(pStringIn,'$, ')[1..stringlib.stringfind(pStringIn,'.',1)-1],left,right),7,1) +
	 trim(pStringIn[stringlib.stringfind(pStringIn,'.',1)+1..stringlib.stringfind(pStringIn,'.',1)+2],left,right),
    if(stringlib.stringfind(pStringIn,'.',1)=0,
	 stringlib.stringfilterout(pStringIn, '$, '),
	''));
	
tonymkirk: fNumbersOnly(string pString) 
:= lib_stringlib.stringlib.stringfilter(pString,'0123456789'); 

 

fZeroPad(string pString, integer1 pLength) 
:= lZeroString[1..(pLength-length(fNumbersOnly(pString)))] + fNumbersOnly(pString); 


tonymkirk: And, just in case, http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=W20050310-125039	
*/