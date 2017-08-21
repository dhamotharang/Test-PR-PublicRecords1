import spoke;
pversion := '';
#workunit('name','Spoke._bwr_Rename ' + pversion);
Spoke.Rename_Keys(
	 pversion			:= pversion
	,pFilter			:= ''
	,pIsTesting		:= true
	,pJustKeys		:= true
);
