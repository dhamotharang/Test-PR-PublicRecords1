export Function_CombineFirstLastCorpNames(string pStringIn1, string pStringIn2) :=
	trim(
	 trim(pStringIn1,left,right) +
     if(trim(pStringIn1,left,right)!='' AND trim(pStringIn2,left,right)!='',', ',' ') +
	 trim(pStringIn2,left,right)
	,left,right);