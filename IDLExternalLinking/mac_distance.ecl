/**
	This macro selects a LexID based on weight_score and distance only.
	It also make sure the score of the selected LexID is greater or equal to Constant.GOOD_SCORE
**/

EXPORT mac_distance (trimRes, resOut, weight_score, distance) := MACRO;

#UNIQUENAME(resultsDist)
	%resultsDist% := project(trimRes, 
												TRANSFORM(RECORDOF(LEFT) ,
														totalResults 	:= COUNT(LEFT.results);
														idlWeightDiff := if(totalResults > 1, LEFT.results[1].weight - LEFT.results[2].weight, 0); 
														
														SELF.xIDL := if((idlWeightDiff >= distance or totalResults = 1)  and LEFT.results[1].weight >= weight_score, LEFT.results[1].did, 0);														
														SELF.RecDistance := idlWeightDiff;
														// IF SALT does not set the score for this in the threshold, it will set it
														SELF.score := IF(SELF.xIDL>0 and LEFT.results[1].score >= IDLExternalLinking.Constants.GOOD_SCORE, LEFT.results[1].score, IDLExternalLinking.Constants.GOOD_SCORE);
														SELF := LEFT));
	resOut := %resultsDist%;
ENDMACRO;