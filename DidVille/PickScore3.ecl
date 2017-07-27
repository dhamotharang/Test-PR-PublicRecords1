Import NID,ut;
FullName(STRING word1, STRING word2) :=
	LENGTH(TRIM(word1)) > 1 and NID.mod_PFirstTools.RinPFL(word1, word2); // >1 takes care of the NB (not blank) and the !=1

InitialMatch(string word1, string word2) :=
	LENGTH(TRIM(word1)) > 0 and NID.mod_PFirstTools.RinPFL_Initial(word1, word2);

export PickScore3(STRING fname1, STRING mname1, INTEGER Opt1a, INTEGER Opt2a = 1, INTEGER Opt3a = 1,
			 STRING fname2, STRING mname2, INTEGER Opt1b, INTEGER Opt2b = 1, INTEGER Opt3b = 1,
			 UNSIGNED count1, UNSIGNED count2, UNSIGNED count3, UNSIGNED count4) :=
	
	IF(ut.NZEQ(Opt1a, Opt1b) AND ut.NZEQ(Opt2a, Opt2b) AND ut.NZEQ(Opt3a, Opt3b),
		
		ut.imin4(IF(FullName(fname1, fname2) AND 
					FullName(mname1, mname2),			count1, 65535),
				 IF(FullName(fname1, fname2) AND 
					InitialMatch(mname1, mname2),		count2, 65535),
				 IF(InitialMatch(fname1, fname2) AND 
					InitialMatch(mname1, mname2),		count3, 65535),
				 IF(FullName(fname1, fname2),			count4, 65535)), 65535);