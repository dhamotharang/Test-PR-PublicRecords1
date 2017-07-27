imax(integer2 a, integer2 b) := if(a > b, a, b);

export compute_score(unsigned8 leftdid, unsigned8 rightdid, 
					 integer2 leftscore, integer2 newscore) :=
	if(leftdid = rightdid and leftdid > 0,	//then combine then
	   leftscore + newscore - ( leftscore * newscore) div 100,
	   imax(leftscore, newscore));	//take the bigger (might be zero)