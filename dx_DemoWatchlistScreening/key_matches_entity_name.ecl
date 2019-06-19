IMPORT $;

inFile := $.Layouts.matches_entity_name; 


EXPORT key_matches_entity_name := 
         INDEX ({inFile}, {inFile.matches_entity_name}, $.names().i_match_name, OPT);