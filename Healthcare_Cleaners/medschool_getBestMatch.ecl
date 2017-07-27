import std,mprd;
EXPORT medschool_getBestMatch := module

 healthcare_cleaners.layouts.layoutMedicalSchoolWord1 FinalRollup (healthcare_cleaners.layouts.layoutMedicalSchoolWord1 rslt, dataset(healthcare_cleaners.layouts.layoutMedicalSchoolWord1) allrows,unsigned parsedCnt) := transform
				CampusMatch := exists(allrows(campus=true));
				cntMatch := count(allrows);
				cntTotal := parsedCnt;
				percentMatch := (cntMatch/cntTotal)*100;
				theScore := sum(allrows,score); 
				self.MSID:=rslt.msid;
				self.words:=rslt.words;
				self.WordCountMatch := cntMatch;
				self.WordCountTotal := cntTotal;
				self.ConfidenceScore := map(CampusMatch=>90,
																		percentMatch between 60 and 90 and theScore >= 30 => percentMatch+10,
																		percentMatch >= 90 and theScore >= 30 => 99,
																		cntMatch > 2 => percentMatch,
																		percentMatch);
				self.Score:=theScore;
	 end;



export getBestMatch(string s) := FUNCTION
    //ds1:=dataset('~thor_data400::base::mprd::med_schools',Healthcare_Cleaners.layouts.layoutMedicalSchoolinfo1,flat);
    parseit := Healthcare_Cleaners.medschool_db.BusName_SplitAndSequenceWords(s,0);
		wordlist:=Healthcare_Cleaners.medschool_db.wordlist;
		cntParse := count(parseit);
		linkit := join(parseit,mprd.Keys(,true).medschool_wordlist_word_key.QA(),left.words=right.words,transform(Healthcare_cleaners.Layouts.layoutmedicalschoolword1, self:=left;self:=right;));
		groupit := group(sort(linkit,msid),msid);
		countit := choosen(sort(rollup(groupit,group,FinalRollup(left,rows(left),cntParse)),-score,-ConfidenceScore),1);
		getResults := join(countit,mprd.Keys(,true).medschool_msid_key.QA(),left.msid=right.msid,transform(Healthcare_Cleaners.layouts.layoutMedicalSchoolFinal,
																				self:=left;self:=right;));
		// output(parseit);
		// output(cntParse);
		// output(groupit);
		// output(countit);
		// output(getResults);
		//RETURN getResults;
		output(getResults,named('getResults1'),all);
		RETURN getResults;
	END;
	end;