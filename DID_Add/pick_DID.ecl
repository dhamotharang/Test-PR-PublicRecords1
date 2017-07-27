export pick_DID(unsigned6 leftdid, unsigned6 rightdid, 
				integer2 leftscore, integer2 selfscore) := 
	if(selfscore > leftscore, 
	   rightdid,  //this means the right unseated the left
	   leftdid);  //otherwise, they combined or tied or no match