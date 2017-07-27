IMPORT Lib_StringLib, ut;

EXPORT Dict_Lookup3(FileName_Info info, 
									Text_Search.IKeywording kwd, STRING term,
									Text_Search.Types.WordType wtyp, Text_Search.Types.NominalFilter ftyp,
									Text_Search.Types.DateRangeType drtyp, Text_Search.Types.SegmentName segName,
									UNSIGNED1 numEquivs, Text_Search.Types.WordList equivs,
									INTEGER8 docCount, INTEGER8 wrdCount) := MODULE
	//
	SHARED Text_Search.Types.WordStr kwdComplete := kwd.segWord(term, segName);
	SHARED Text_Search.Types.WordFixed kwdFixed := kwdComplete;
	SHARED indx := Text_Search.Indx_Dictionary3(info);
	EXPORT STRING tstArg := TRIM(kwdFixed);
	SHARED BOOLEAN isRNGType := ftyp = Text_Search.Types.NominalFilter.RNG_Filter;
	SHARED BOOLEAN useOldNumFmt := kwd.dictVersion < Text_Search.Constants.NCFMinDictVer;
	SHARED kwdMeta := Text_Search.Segment_Metadata(info, TRUE);
	SHARED reallyNumeric :=
		wtyp = Text_Search.Types.WordType.Numeric AND
					kwdMeta.isType(segName, Text_Search.Types.SegmentType.NumericType);
	SHARED reallyDate :=
		wtyp = Text_Search.Types.WordType.Date AND
					kwdMeta.isType(segName, Text_Search.Types.SegmentType.DateType);
	SHARED reallySSN := wtyp=Text_Search.Types.WordType.SSN;
	SHARED BOOLEAN forceString := MAP(
			kwd.dictVersion = 0																							=> FALSE,
			wtyp = Types.WordType.Date																			=> FALSE, //workaround
			reallySSN																												=> FALSE, // another
			isRNGType																												=> FALSE,
			wtyp = Text_Search.Types.WordType.MultiEquiv										=> FALSE,
			kwdMeta.isType(segName, Text_Search.Types.SegmentType.TextType)	=> TRUE,
			~reallyNumeric AND ~reallyDate																	=> TRUE,
			useOldNumFmt AND (LENGTH(tstArg) > 8 OR kwdFixed[1] = '0')			=> TRUE,
			FALSE);

	// Numeric search term and single date term
	SHARED Text_Search.Types.Nominal nNominal   :=
		MAP(wtyp = Text_Search.Types.WordType.Date	=>	(Text_Search.Types.Nominal) term,
				useOldNumFmt														=>	(Text_Search.Types.Nominal) term,
				Text_Search.NumericCollationFormat.StringToNCF(term));

	// Numeric and Date range term
	SHARED BOOLEAN isYMD := drtyp = Text_Search.Types.DateRangeType.YMDRange;
	SHARED INTEGER2 pos := StringLib.StringFind(term,':',1);
	SHARED STRING d1 := (STRING)ConvertDate(term[1..pos-1], isYMD);
	SHARED STRING n1 := term[1..pos-1];
	SHARED Text_Search.Types.Nominal d1_nominal	:= (Text_Search.Types.Nominal) d1;
	SHARED Text_Search.Types.Nominal n1_nominal	:= IF(useOldNumFmt, (Text_Search.Types.Nominal) n1,
																											Text_Search.NumericCollationFormat.StringToNCF(n1));
	SHARED STRING d2 := (STRING)Text_Search.ConvertDate(term[pos+1..], isYMD);
	SHARED STRING n2 := term[pos+1..];
	SHARED Types.Nominal d2_nominal := (Types.Nominal) d2;
	SHARED Types.Nominal n2_nominal := IF(useOldNumFmt, (Text_Search.Types.Nominal) n2,
																											Text_Search.NumericCollationFormat.StringToNCF(n2));
  SHARED SET OF STRING20 drSet := [d1, d2];
  SHARED SET OF STRING20 nrSet := [n1, n2];

	// Text terms, including wild card processing
	SHARED INTEGER2 firstSingle := StringLib.StringFind(tstArg,'?',1);
	SHARED INTEGER2 firstMultiple := StringLib.StringFind(tstArg,'*',1);
	SHARED BOOLEAN firstWild := firstSingle=1 OR firstMultiple = 1;
	SHARED BOOLEAN hasWild := firstMultiple>0 OR firstSingle>0;
	SHARED BOOLEAN complete := tstArg = kwdComplete AND NOT hasWild;
	SHARED fixLn := ut.Min2(firstSingle, firstMultiple);
	
	// All first wild card pushed to local dictionary, emtpy dset created.
	EXPORT dSetwEmpty  := DATASET([],RECORDOF(indx));
	// Modified to add choosen, since the LIMIT function in OSS currently doesn't stop the indx lookup, when 
	// the limit value is exceeded.
	EXPORT dSetw2 := indx(KEYED(fixLn > 1 AND word[1..fixLn-1] = tstArg[1..fixLn-1]) AND
												(complete OR StringLib.StringWildMatch(fullWord, tstArg, TRUE)) AND
												typ = Text_Search.Types.WordType.TextStr);
	EXPORT dSetInner := LIMIT(CHOOSEN(dSetw2,Text_Search.Limits.Max_Wild_Defer+1), Text_Search.Limits.Max_Wild_Defer, SKIP);
	// Note, Choice of 1 gives bad global weights.  Local weights
	// are calculated on the local nodes.
	SHARED dSetw := IF(firstWild, dSetwEmpty, CHOOSEN(dSetw2,1));
	SHARED dSet  := IF(firstWild, dSetwEmpty, dSetInner);
	w0 := indx(KEYED(word = kwdFixed) AND
						 (complete OR kwdComplete = fullWord) AND
						 (typ=Text_Search.Types.WordType.TextStr OR (reallySSN AND typ=Text_Search.Types.WordType.SSN))); 
						 
	SHARED aSet	:= CHOOSEN(w0, 1);
	SHARED Text_Search.Types.WordList multipleWordSet := SET(dSet, fullWord);
 	SHARED Text_Search.Types.WordList singleWordSet := [kwdComplete];

	EXPORT deferWildCard := firstWild OR // Defer all searches with first wildcard
													(hasWild AND EXISTS(dSetw) AND NOT EXISTS(dSet));
	
	EXPORT Wildcard := hasWild AND EXISTS(dSet);

	// Equivalent
	fixedEquivs := SET(DATASET(equivs, {Text_Search.Types.WordFixed wf}), wf);
	
	SHARED equivSet := aSet & LIMIT(indx(KEYED(word IN fixedEquivs) AND (typ = wtyp) 
																		AND (typ = Text_Search.Types.WordType.TextStr OR typ = Text_Search.Types.WordType.MultiEquiv) AND fullWord IN equivs),
																	Text_Search.Limits.Max_Equiv,
																	FAIL(Text_Search.Limits.TooManyEquiv_Code, Text_Search.Limits.TooManyEquiv_Msg));
	// Set of dictionary entries
	EXPORT GetDictEntries := PROJECT(MAP(WildCard => dSet, numEquivs > 0 => equivSet, aSet), Text_Search.Layout_Dictionary);

	// Resolve the term
	rslt := IF(term = '', [],
												IF(~isRNGType,
														 MAP(WildCard => multipleWordSet,
																 numEquivs > 0 AND wtyp = Text_Search.Types.WordType.MultiEquiv => equivs, // If Multi word equiv type, only store equivalent in word list
																 numEquivs > 0 => singleWordSet + equivs,
																 singleWordSet),
														 IF(wtyp = Text_Search.Types.WordType.Date, drSet, nrSet)));
	EXPORT Get_Word_List := rslt;


	SHARED num_unforced := wtyp = Text_Search.Types.WordType.numeric AND NOT forceString;
	SHARED isDate := wtyp = Text_Search.Types.WordType.Date;

	//
  freq := IF(term = '', 0,
												MAP(WildCard => SUM(dSet, freq),
														//deferWildCard => SUM(dSetz, freq),
														num_unforced OR isDate=> wrdCount,
														numEquivs > 0 => SUM(equivSet, freq),
														SUM(NOFOLD(aSet), freq)));
	EXPORT Get_Term_Freq := freq;

	//
	single_dfreq := SUM(NOFOLD(aSet), docFreq);
  dfreq := IF(term = '', 0,
												 MAP(WildCard => SUM(dSet, docFreq),
														 //deferWildCard => SUM(dSetz, freq),
														 num_unforced OR isDate=> docCount,
														 numEquivs > 0 => SUM(equivSet, docFreq),
														 SUM(NOFOLD(aSet), docFreq)));
	EXPORT Get_Term_DocFreq := dfreq;

	// "full" nominals
	indx makeFullNominals(indx l) := TRANSFORM
		SELF.nominal := l.nominal + l.suffix;
		SELF := l;
	END;

	aSet_f := PROJECT(aSet, makeFullNominals(LEFT));
	dSet_f := PROJECT(dSet, makeFullNominals(LEFT));
	eSet_f := PROJECT(equivSet, makeFullNominals(LEFT));

	Text_Search.Types.NominalList mFullNominalSet := SET(SORT(dSet_f, nominal), nominal);
	Text_Search.Types.NominalList sFullNominalSet := SET(aSet_f, nominal);
	Text_Search.Types.NominalList eFullNominalSet := SET(SORT(eSet_f, nominal), nominal);
	Text_Search.Types.NominalList drFullNominalSet := [d1_nominal, d2_nominal];
	Text_Search.Types.NominalList nrFullNominalSet := [n1_nominal, n2_nominal];
	Text_Search.Types.NominalList rFullNominalSet := IF(isDate, drFullNominalSet, nrFullNomiNalSet);

	lst_f := IF(term = '', [0],
												 IF(~isRNGType,
															MAP(hasWild AND EXISTS(dSet_f) => mFullNominalSet,
																	num_unforced OR isDate => [nNominal],
																	numEquivs > 0 => eFullNominalSet,
																	sFullNominalSet),
														rFullNominalSet));
	EXPORT Get_FullNominal_List := lst_f;

	SHARED BOOLEAN EQCompare := ftyp = Text_Search.Types.NominalFilter.EQ_Filter OR
																ftyp = Text_Search.Types.NominalFilter.IN_Filter;
	SHARED isText := wtyp = Text_Search.Types.WordType.TextStr OR forceString
								OR wtyp=Text_Search.Types.WordType.SSN;

	//
	Text_Search.Types.NominalList multipleNominalSet := SET(SORT(dSet, nominal), nominal);
	Text_Search.Types.NominalList singleNominalSet := SET(aSet, nominal);
	Text_Search.Types.NominalList withEquivNominalSet := SET(SORT(equivSet, nominal), nominal);
	Text_Search.Types.NominalList drNominalSet := [0, 0];

	n_lst := IF(term = '', [],
												 IF(isRNGType,
															drNominalSet,
															MAP(WildCard => multipleNominalSet,
																	numEquivs > 0 => withEquivNominalSet,
																	isText => singleNominalSet,
																	EQCompare => [nNominal],
																	[0])));
	EXPORT Get_Nominal_List := n_lst;

	//
	Text_Search.Types.NominalSuffixList multipleSuffixSet := SET(SORT(dSet, nominal), suffix);
	Text_Search.Types.NominalSuffixList singleSuffixSet := SET(aSet, suffix);
	Text_Search.Types.NominalSuffixList withEquivSuffixSet := SET(SORT(equivSet, nominal), suffix);
	Text_Search.Types.NominalSuffixList drSuffixSet := [d1_nominal, d2_nominal];
	Text_Search.Types.NominalSuffixList nrSuffixSet := [n1_nominal, n2_nominal];
	Text_Search.Types.NominalSuffixList rSuffixSet := IF(isDate, drSuffixSet, nrSuffixSet);

	s_lst := IF(term = '', [],
												 IF(isRNGType,
															rSuffixSet,
															MAP(WildCard => multipleSuffixSet,
																	numEquivs > 0 => withEquivSuffixSet,
																	isText => singleSuffixSet,
																	EQCompare => [0],
																	[nNominal])));
	EXPORT Get_Suffix_List := s_lst;

	// Fixup the type if required
	EXPORT RevisedType := MAP(forceString										=> Text_Search.Types.SegmentType.TextType,
														EQCompare											=> wtyp,
														wtyp = Types.WordType.Numeric	=> Text_Search.Types.WordType.NumericRange,
														isDate												=> Text_Search.Types.WordType.DateRange,
														wtyp);
END;