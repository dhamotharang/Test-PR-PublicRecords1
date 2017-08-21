import HCPInternalLinking;
EXPORT INTEGER2 fn_Taxonomy (STRING10 Taxonomy, STRING10 Taxonomy2, INTEGER2 TAXONOMY_weight100) := FUNCTION
	STRING20 s := Taxonomy + Taxonomy2; 
	Taxonomy_DS := HCPInternalLinking.File_Taxonomy;
	Taxonomy_Key_DS := project (Taxonomy_DS,transform({string20 taxonomy, integer2 score},self.taxonomy := left.taxonomy+left.taxonomy2; self.score := (integer)left.score)) : persist ('~thor::mprd::taxonomy::weight',expire(2));
	T := TABLE(Taxonomy_Key_DS,{taxonomy,score}); // Slimmer 
	Taxonomy_Map := DICTIONARY(T,{ taxonomy => T });
	INTEGER2 Taxonomy_Preferred_Weight := IF ( s IN Taxonomy_Map, (integer2)Taxonomy_Map[s].score, 0 );
	RETURN Taxonomy_Preferred_Weight * (TAXONOMY_weight100/100);
	// RETURN TAXONOMY_weight100;
END;

