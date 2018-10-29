/*
	This function takes a Wordbag string constructed by MAC_WordBag_AddWeights
	and converts it back to a pure wordbag string - i.e. a string with the weights stripped off
	
	The assumptions are:
	1) input has ' ' as seperator
	2) The weight always follows the word
This function will count the number of words and pick the odd-numbered words
	 
*/
EXPORT Fn_WordBag_Strip_Weights(StrType input) := FUNCTION
//convert the string into a dataset with each word in one row
	p := DATASET([{input}],{SALT311.StrType s});
	word_cnt := SALT311.WordCount(input);
	
	r := RECORD
		UNSIGNED1 pos;
		SALT311.StrType word {MAXLENGTH(8184)} := '' ;
	END;
	r nt(p le,UNSIGNED1 c) := TRANSFORM
		SELF.word := SALT311.GetNthWord(le.s,c);
		SELF.pos := c;
	 END;
	n := NORMALIZE(p,word_cnt,nt(LEFT,COUNTER));
//get rid of the added weights
	r condense (n le, n ri, UNSIGNED1 c) := TRANSFORM 
		SELF.word := IF(c%2<> 0, SKIP, ri.word);
		SELF.pos := c;
	END;
	o := ITERATE(n, condense(LEFT, RIGHT, COUNTER));
//combine the original words into a string
	r fuse (o le, o ri, UNSIGNED1 c) := TRANSFORM 
		SELF.word := IF(c = 1, ri.word, le.word + ' ' + ri.word);
		SELF.pos := c;
	END;
	out := ITERATE(o, fuse(LEFT, RIGHT, COUNTER));
// the last row will have the overall string	
	RETURN out[word_cnt/2].word;
END;
