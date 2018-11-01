pversion := '';
#workunit('name','BIPV2_ProxID.BWR_RenameKeys ' + pversion);
BIPV2_ProxID.Rename_Keys(
	 pversion			:= pversion
	,pFilter			:= ''
	,pIsTesting		:= true
	,pJustKeys		:= true
);
