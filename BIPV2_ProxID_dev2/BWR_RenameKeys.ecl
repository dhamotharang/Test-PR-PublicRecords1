pversion := '';
#workunit('name','BIPV2_ProxID_dev2.BWR_RenameKeys ' + pversion);
BIPV2_ProxID_dev2.Rename_Keys(
	 pversion			:= pversion
	,pFilter			:= ''
	,pIsTesting		:= true
	,pJustKeys		:= true
);
