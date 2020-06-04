pversion := '';
#workunit('name','BIPV2_ProxID_Platform.BWR_RenameKeys ' + pversion);
BIPV2_ProxID_Platform.Rename_Keys(
	 pversion			:= pversion
	,pFilter			:= ''
	,pIsTesting		:= true
	,pJustKeys		:= true
);
