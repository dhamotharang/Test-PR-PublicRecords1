dSuperfiles:=DATASET([
  {'customer_database'},
	{'third_party_database'},
	{'main'},
	{'old_addresses'},
	{'relatives'},
	{'alias'},
	{'adl_score'}
],{STRING name;});

EXPORT actionBuildSuperfiles:=NOTHOR(
  APPLY(
    dSuperfiles,
	  FileServices.CreateSuperFile(reunion.constants.sLocationBase+dSuperfiles.name),
	  FileServices.CreateSuperFile(reunion.constants.sLocationBase+dSuperfiles.name+'_built'),
	  FileServices.CreateSuperFile(reunion.constants.sLocationBase+dSuperfiles.name+'_father'),
	  FileServices.CreateSuperFile(reunion.constants.sLocationBase+dSuperfiles.name+'_delete')
	)
);
		