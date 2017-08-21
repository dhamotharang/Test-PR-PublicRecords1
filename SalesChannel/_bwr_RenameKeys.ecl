pversion := '';
#workunit('name','SalesChannel._bwr_RenameKeys ' + pversion);
SalesChannel.Rename_Keys(
	 pversion			:= pversion
	,pFilter			:= ''
	,pIsTesting		:= true
	,pJustKeys		:= true
);
