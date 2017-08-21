pversion := '';
#workunit('name','BIPV2_ProxID_dev.BWR_RenameKeys ' + pversion);
BIPV2_ProxID_dev.Rename_Keys(
	 pversion			:= pversion
	,pFilter			:= ''
	,pIsTesting		:= true
	,pJustKeys		:= true
);
