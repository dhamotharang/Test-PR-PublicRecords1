/**
 * Sets score to each result candidates
 */
 

EXPORT mac_score(infile, outfile, weight_score, distance, include_noScore = false) := MACRO;

	// Prepare to return all candidates per request
	//Score candidates correctly		
	#UNIQUENAME(trimLayout)
	%trimLayout% := RECORDOF(infile);
	#UNIQUENAME(resultsLayout)
	%resultsLayout% := RECORDOF(infile.results);
	
	#UNIQUENAME(setScore)	
	%setScore%(DATASET(%trimLayout%) ds) := FUNCTION
			f_res(DATASET(%resultsLayout%) dsres, %trimLayout% aRes) := FUNCTION						
					UNSIGNED2 goodweight := dsres[1].weight - distance;						
					goodResults := dsres(weight>=goodweight);		
					UNSIGNED1 wth1 := weight_score;
					//toScore are good candidates
					toScore := dsres(weight>=goodweight and weight>=wth1);										
					
					// notToScore are below the threshold or required distance but still worth returning
					notToScore := dsres((weight< wth1  or weight<goodweight) and score>0);
					//If we return all rest we should be good for person search.
					noScore := dsres((weight< wth1  or weight<goodweight) and score=0 and include_noScore);
					UNSIGNED1 toScoreCount := IF(aRes.xIDL >0, COUNT(toScore)-1, COUNT(toScore));					
					scoreLeft := IF(aRes.xIDL >0, 25, 100);
			
					RETURN PROJECT(toScore, TRANSFORM(%resultsLayout%, 												
						SELF.SCORE := IF(aRes.xIDL = 0, 50, 
														IF(aRes.xIDL = LEFT.DID, aRes.SCORE, scoreLeft/toScoreCount)); 
						SELF := LEFT)) + PROJECT(notToScore + noScore, TRANSFORM(%resultsLayout%,
							SELF.SCORE := IF(LEFT.SCORE < 75, LEFT.SCORE, 45);
							SELF := LEFT));  	  							
			END;
			
			res := PROJECT(ds, TRANSFORM(RECORDOF(LEFT),
							SELF.results := f_res(LEFT.results, left),
							SELF := LEFT));
			RETURN res;
		END;
		
	outfile := %setScore%(infile);
	
ENDMACRO;





































