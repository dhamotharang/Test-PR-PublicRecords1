IMPORT FLAccidents_Ecrash;

EXPORT fn_post_delete_counts () := FUNCTION
	
	incident := FLAccidents_Ecrash.Infiles.Incident;
	persn := FLAccidents_Ecrash.Infiles.Persn;
	vehicl := FLAccidents_Ecrash.Infiles.Vehicl;
	citation := FLAccidents_Ecrash.Infiles.Citation;
	Property_damage := FLAccidents_Ecrash.Infiles.Property_Damage;
	commercl := FLAccidents_Ecrash.Infiles.Commercl;
	document := FLAccidents_Ecrash.Infiles.Document;
	
  ds_post_delete := DATASET([{'POST_DELETE', COUNT(incident), COUNT(persn), COUNT(vehicl), COUNT(citation), COUNT(commercl), COUNT(Property_damage), COUNT(document)}], Layouts.lay_post_delete_stats);
	post_delete_stats := OUTPUT(ds_post_delete,,NAMED('POST_DELETE_COUNTS'), OVERWRITE);
	
	RETURN post_delete_stats;																					
END;