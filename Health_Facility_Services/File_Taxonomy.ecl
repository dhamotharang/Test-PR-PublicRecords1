R := RECORD
	string10 taxonomy; 
	string10 taxonomy2; 
	string11 score;
END;

X := RECORD
	string10 taxonomy; 
	string10 taxonomy2; 
	integer3 scores;
END;

EXPORT File_Taxonomy := PROJECT (DATASET ('~thor::taxonomy::score::file',R,THOR),TRANSFORM(X, SELF.SCOREs := (INTEGER)LEFT.SCORE; SELF := LEFT;)); 