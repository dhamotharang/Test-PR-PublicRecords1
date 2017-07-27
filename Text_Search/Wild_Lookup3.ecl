IMPORT ut;
IMPORT Lib_StringLib;

EXPORT Wild_Lookup3(FileName_Info info, STRING term) := MODULE
	//
	SHARED Text_Search.Types.WordStr kwdComplete := StringLib.StringToUpperCase(term);
	SHARED Text_Search.Types.WordFixed kwdFixed := kwdComplete;
	SHARED indx := Text_Search.Indx_LocalDict2(info);
	EXPORT STRING tstArg := TRIM(kwdFixed);
	// Text terms, including wild card processing
	SHARED INTEGER2 firstSingle := StringLib.StringFind(tstArg,'?',1);
	SHARED INTEGER2 firstMultiple := StringLib.StringFind(tstArg,'*',1);
	SHARED BOOLEAN firstWild := firstSingle=1 OR firstMultiple = 1;
	SHARED BOOLEAN hasWild := firstMultiple>0 OR firstSingle>0;
	SHARED BOOLEAN complete := tstArg = kwdComplete AND NOT hasWild;
	EXPORT fixLn := ut.Min2(firstSingle,firstMultiple);
	SHARED INTEGER2 secondSingle := StringLib.StringFind(tstArg,'?',fixLn+1);
	SHARED INTEGER2 secondMultiple := StringLib.StringFind(tstArg,'*',fixLn+1);
	SHARED BOOLEAN secondWild := secondSingle>0 OR secondMultiple >0;
	SHARED endLn := IF (secondWild,ut.Min2(secondSingle,secondMultiple),LENGTH(tstArg));
	SHARED WildWord := tstArg[fixLn+1..endLn-1];
	SHARED WildWordLen := LENGTH(WildWord);

	EXPORT dSetw1 	:= indx(KEYED(typ = Types.WordType.TextStr AND 
																word[1..WildWordLen] = WildWord) AND
																(complete OR STRINGLIB.StringWildMatch(fullWord, tstArg, TRUE)));
	EXPORT dSetFirst:= LIMIT(dSetw1, Text_Search.Limits.Max_LocalWild,
														FAIL(Text_Search.Limits.Wild_Code, Text_Search.Limits.Wild_Msg));
	EXPORT dSetw2 	:= indx(KEYED(typ = Types.WordType.TextStr AND
																fixLn > 1 AND word[1..fixLn-1] = tstArg[1..fixLn-1]) AND
																NOT(substring) AND
																(complete OR STRINGLIB.StringWildMatch(fullWord, tstArg, TRUE)));
	SHARED dSetInner:= LIMIT(dSetw2, Text_Search.Limits.Max_LocalWild,
														FAIL(Text_Search.Limits.Wild_Code, Text_Search.Limits.Wild_Msg));
	SHARED dSet := IF(firstWild, dSetFirst, dSetInner);

	// Results
	EXPORT GetDictEntries 				:= dSet;
	EXPORT Get_Word_List 					:= SET(dSet, fullWord);
	EXPORT Get_Term_Freq					:= SUM(dSet, freq);
	EXPORT Get_Term_DocFreq				:= SUM(dSet, docFreq);
	EXPORT Get_Nominal_List				:= SET(SORT(dSet, nominal), nominal);
	EXPORT Get_Suffix_List				:= SET(SORT(dSet, nominal), suffix);
END;