IMPORT $;

inFile := $.Layouts.matches_entity_name_layout; 


EXPORT key_matches_entity_name := 
         INDEX ({inFile.matches_entity_name}, inFile, $.names().i_match_name, OPT);