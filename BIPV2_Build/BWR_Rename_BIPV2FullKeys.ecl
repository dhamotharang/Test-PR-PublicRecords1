pversion := '';
#workunit('name','BIPV2_Build.BWR_Rename_BIPV2FullKeys ' + pversion);
BIPV2_Build.proc_rename_BIPV2FullKeys(
	 pversion			:= pversion
	,pFilter			:= ''
	,pIsTesting		:= true
);
