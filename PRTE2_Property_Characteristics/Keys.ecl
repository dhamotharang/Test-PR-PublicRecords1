import doxie;

EXPORT Keys := module

	EXPORT rid := index(files.base, {property_rid},		{files.base},	constants.KEY_PREFIX + doxie.Version_SuperKey + '::rid');
	EXPORT address := index(files.base, {prim_name,prim_range,zip,predir,postdir,addr_suffix,sec_range},
																{property_rid},	constants.KEY_PREFIX + doxie.Version_SuperKey + '::address');

end;																