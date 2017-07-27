Import Healthcare_Cleaners;
MedschoolWordList := Healthcare_Cleaners.medschool_db.wordlist;
Output(MedschoolWordList,named('SampleMedschoolWordList'));
NonMedschoolWordList := Healthcare_Cleaners.NonMedschool_db.wordlist;
Output(NonMedschoolWordList,named('SampleNonMedschoolWordList'));