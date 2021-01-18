EXPORT proc_getRelationshipSuppressions := FUNCTION
	suppressDS             		:= dataset([], Layout_GetRelationship.Suppress_outrec);
	suppress_key_prefix       := '~thor_data400::key::relatives_suppress_';
	suppressKeySuper          := suppress_key_prefix + 'qa';
  suppressSuperIndex        := index(suppressDS, {did1,did2}, {suppressDS},	suppressKeySuper);
  return suppressSuperIndex;
END;