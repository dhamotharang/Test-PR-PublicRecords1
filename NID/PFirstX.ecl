
export NID.Interfaces.type_PFirstX PFirstX(
	NID.Interfaces.type_name name, 
	NID.Interfaces.type_versions versions = []
	) 
		:= FUNCTION

	RETURN CASE (COUNT(versions),
		0 => [PreferredFirstNew(name)],
		1 => [PreferredFirstNew(name,2 in versions)],
		SET(DEDUP(DATASET([
			if (1 in versions, PreferredFirst(name),''),
			if (2 in versions, PreferredFirstNew(name),'')
		], {string20 name})(name != ''),name),name)
	);
/*		
	Set of string20 names := [
		if (1 in versions, PreferredFirst(name),''),
		if (2 in versions OR versions=[], PreferredFirstNew(name),'')
	];
	
	RETURN SET(DEDUP(DATASET(names, {string20 name})(name != ''),name),name);
*/
END;