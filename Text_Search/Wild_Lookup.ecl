IMPORT ut;
IMPORT Lib_StringLib;

EXPORT Wild_Lookup(FileName_Info info, STRING term) := MODULE
	//
	SHARED Types.WordStr kwdComplete := StringLib.StringToUpperCase(term);
	SHARED Types.WordFixed kwdFixed := kwdComplete;
	SHARED indx := Indx_Dictionary2(info);
	SHARED STRING tstArg := TRIM(kwdFixed);
	// Text terms, including wild card processing
	SHARED INTEGER2 firstSingle := StringLib.StringFind(tstArg,'?',1);
	SHARED INTEGER2 firstMultiple := StringLib.StringFind(tstArg,'*',1);
	SHARED BOOLEAN firstWild := firstSingle=1 OR firstMultiple = 1;
	SHARED BOOLEAN hasWild := firstMultiple>0 OR firstSingle>0;
	SHARED BOOLEAN complete := tstArg = kwdComplete AND NOT hasWild;
	SHARED fixLn := ut.Min2(firstSingle,firstMultiple);
	SHARED dSetw1:= NOLOCAL(indx(typ = Types.WordType.TextStr AND
															 STRINGLIB.StringWildMatch(fullWord, tstArg, TRUE)));
	SHARED dSetFirst:= LIMIT(dSetw1, Limits.Max_LocalWild,
														FAIL(Limits.Wild_Code, Limits.Wild_Msg));
	SHARED dSetw2 	:= NOLOCAL(indx(KEYED(fixLn > 1 AND word[1..fixLn-1] = tstArg[1..fixLn-1]) AND
																	(complete OR STRINGLIB.StringWildMatch(fullWord, tstArg, TRUE)) AND
																	typ = Types.WordType.TextStr));
	SHARED dSetInner:= LIMIT(dSetw2, Limits.Max_LocalWild,
														FAIL(Limits.Wild_Code, Limits.Wild_Msg));
	SHARED dSet := IF(firstWild, dSetFirst, dSetInner);

	// Results
	EXPORT GetDictEntries 				:= dSet;
	EXPORT Get_Word_List 					:= SET(dSet, fullWord);
	EXPORT Get_Term_Freq					:= SUM(dSet, freq);
	EXPORT Get_Term_DocFreq				:= SUM(dSet, docFreq);
	EXPORT Get_Nominal_List				:= SET(SORT(dSet, nominal), nominal);
	EXPORT Get_Suffix_List				:= SET(SORT(dSet, nominal), suffix);
END;