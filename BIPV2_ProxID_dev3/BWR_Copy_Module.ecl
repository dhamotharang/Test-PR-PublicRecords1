//Please create the SPC attribute in the new module first, since this can't create a SALT attribute
//Copies in the files, bwr and layout attributes from another module so you don't have to manually do it
tools.fun_CreateModule(
	 pOldModuleName				:= 'BIPV2_ProxID_dev3'
	,pNewModuleName				:= 'BIPV2_ProxID_dev3'
//	,pAttributeNamesRegex	:= '(bwr|file|dot_base|layouts|fn_|promote|rollback|output_test|experiment|_SPC)'
	,pShouldSaveAtts			:= true
);

//output(tools.mod_Soapcalls.fSaveAttribute('BIPV2_PROX_SALT_int_micro_test','sampleatt',pText := 'Youi just got created and saved!!'));
