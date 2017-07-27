export Get_Term_Freqs(DATASET(Layout_Search_RPN_Set) rpn_srch) := FUNCTION
	
	// get freq of each term in all docs 
	Layout_TermFreq normFreqs(Layout_RPN_Oprnd r) := TRANSFORM
		SELF.termID := r.id;
		SELF.freq := r.docFreq;
	END;
	termFreqs := SORT(NORMALIZE(rpn_srch,LEFT.inputs, normFreqs(RIGHT)), termID);
	RETURN termFreqs;
END;
