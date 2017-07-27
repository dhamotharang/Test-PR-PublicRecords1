import NID;
export DATASET({string20 name}) PreferredFirstVersioned(
	NID.Interfaces.type_name name, 
	NID.Interfaces.type_versions versions = []
	) 
		:= FUNCTION

	name_rec := {NID.Interfaces.type_name name};

	RETURN CASE (COUNT(versions),
		0 => DATASET([NID.PreferredFirstNew(name)],name_rec),
		1 => DATASET([NID.PreferredFirstNew(name,2 in versions)],name_rec),
		DEDUP(DATASET([
			{if (1 in versions, NID.PreferredFirst(name),'')},
			{if (2 in versions, NID.PreferredFirstNew(name),'')}
			], name_rec)(name != ''),name)
	);
END;