/*2011-11-09T00:36:27Z (Keith Dues)
RR 81494 - Modified to correct numeric lookup
*/
IMPORT Lib_StringLib, ut;

EXPORT Dict_Lookup2(FileName_Info info, 
									IKeywording kwd, STRING term,
									Types.WordType wtyp, Types.NominalFilter ftyp,
									Types.DateRangeType drtyp, Types.SegmentName segName,
									UNSIGNED1 numEquivs, Types.WordList equivs,
									INTEGER8 docCount, INTEGER8 wrdCount) := MODULE
	//
	SHARED Types.WordStr kwdComplete := kwd.segWord(term, segName);
	SHARED Types.WordFixed kwdFixed := kwdComplete;
	SHARED indx := Indx_Dictionary3(info);
	SHARED STRING tstArg := TRIM(kwdFixed);
	SHARED BOOLEAN isRNGType := ftyp = Types.NominalFilter.RNG_Filter;
	SHARED BOOLEAN useOldNumFmt := kwd.dictVersion < Constants.NCFMinDictVer;
	SHARED kwdMeta := Segment_Metadata(info, TRUE);
	SHARED reallyNumeric :=
		wtyp = Types.WordType.Numeric AND
					kwdMeta.isType(segName, Types.SegmentType.NumericType);
	SHARED reallyDate :=
		wtyp = Types.WordType.Date AND
					kwdMeta.isType(segName, Types.SegmentType.DateType);
	SHARED reallySSN := wtyp=Types.WordType.SSN;
	SHARED BOOLEAN forceString := MAP(
			kwd.dictVersion = 0																					=> FALSE,
			wtyp = Types.WordType.Date																	=> FALSE, //workaround
			reallySSN																										=> FALSE, // another
			isRNGType																										=> FALSE,
			wtyp = Types.WordType.MultiEquiv														=> FALSE,
			kwdMeta.isType(segName, Types.SegmentType.TextType)					=> TRUE,
			~reallyNumeric AND ~reallyDate															=> TRUE,
			useOldNumFmt AND (LENGTH(tstArg) > 8 OR kwdFixed[1] = '0')	=> TRUE,
			FALSE);

	// Numeric search term and single date term
	SHARED Types.Nominal nNominal   :=
		MAP(wtyp = Types.WordType.Date	=>	(Types.Nominal) term,
				useOldNumFmt								=>	(Types.Nominal) term,
				NumericCollationFormat.StringToNCF(term));

	// Numeric and Date range term
	SHARED BOOLEAN isYMD := drtyp = Types.DateRangeType.YMDRange;
	SHARED INTEGER2 pos := StringLib.StringFind(term,':',1);
	SHARED STRING d1 := (STRING)ConvertDate(term[1..pos-1], isYMD);
	SHARED STRING n1 := term[1..pos-1];
	SHARED Types.Nominal d1_nominal	:= (Types.Nominal) d1;
	SHARED Types.Nominal n1_nominal	:= IF(useOldNumFmt, (Types.Nominal) n1,
																											NumericCollationFormat.StringToNCF(n1));
	SHARED STRING d2 := (STRING)ConvertDate(term[pos+1..], isYMD);
	SHARED STRING n2 := term[pos+1..];
	SHARED Types.Nominal d2_nominal := (Types.Nominal) d2;
	SHARED Types.Nominal n2_nominal := IF(useOldNumFmt, (Types.Nominal) n2,
																											NumericCollationFormat.StringToNCF(n2));
  SHARED SET OF STRING20 drSet := [d1, d2];
  SHARED SET OF STRING20 nrSet := [n1, n2];

	// Text terms, including wild card processing
	SHARED INTEGER2 firstSingle := StringLib.StringFind(tstArg,'?',1);
	SHARED INTEGER2 firstMultiple := StringLib.StringFind(tstArg,'*',1);
	SHARED BOOLEAN firstWild := firstSingle=1 OR firstMultiple = 1;
	SHARED BOOLEAN hasWild := firstMultiple>0 OR firstSingle>0;
	SHARED BOOLEAN complete := tstArg = kwdComplete AND NOT hasWild;
	SHARED fixLn := ut.Min2(firstSingle, firstMultiple);
	SHARED dSetw1 := indx(typ = Types.WordType.TextStr AND
												StringLib.StringWildMatch(fullWord, tstArg, TRUE));
	// Modified to add choosen, since the LIMIT function in OSS currently doesn't stop the indx lookup, when 
	// the limit value is exceeded.
	SHARED dSetFirst := LIMIT(CHOOSEN(dSetw1,Limits.Max_Wild_Defer+1), Limits.Max_Wild_Defer, SKIP);
	SHARED dSetw2 := indx(KEYED(fixLn > 1 AND word[1..fixLn-1] = tstArg[1..fixLn-1]) AND
												(complete OR StringLib.StringWildMatch(fullWord, tstArg, TRUE)) AND
												typ = Types.WordType.TextStr);
	SHARED dSetInner := LIMIT(CHOOSEN(dSetw2,Limits.Max_Wild_Defer+1), Limits.Max_Wild_Defer, SKIP);
	// Note, Choice of 1 gives bad global weights.  Local weights
	// are calculated on the local nodes.
	SHARED dSetw := IF(firstWild, CHOOSEN(dSetw1,1), CHOOSEN(dSetw2,1));
	SHARED dSet  := IF(firstWild, dSetFirst, dSetInner);
	w0 := indx(KEYED(word = kwdFixed) AND
						 (complete OR kwdComplete = fullWord) AND
						 (typ=Types.WordType.TextStr OR (reallySSN AND typ=Types.WordType.SSN))); 
						 
	SHARED aSet	:= CHOOSEN(w0, 1);
	SHARED Types.WordList multipleWordSet := SET(dSet, fullWord);
 	SHARED Types.WordList singleWordSet := [kwdComplete];

	EXPORT deferWildCard := hasWild AND EXISTS(dSetw) AND NOT EXISTS(dSet);
	SHARED Wildcard := hasWild AND EXISTS(dSet);

	// Equivalent
	fixedEquivs := SET(DATASET(equivs, {Types.WordFixed wf}), wf);
	
	SHARED equivSet := aSet & LIMIT(indx(KEYED(word IN fixedEquivs) AND (typ = wtyp) AND (typ = Types.WordType.TextStr OR typ = Types.WordType.MultiEquiv) AND fullWord IN equivs),
																	Limits.Max_Equiv,
																	FAIL(Limits.TooManyEquiv_Code, Limits.TooManyEquiv_Msg));
	// Set of dictionary entries
	EXPORT GetDictEntries := PROJECT(MAP(WildCard => dSet, numEquivs > 0 => equivSet, aSet), Layout_Dictionary);

	// Resolve the term
	rslt := IF(term = '', [],
												IF(~isRNGType,
														 MAP(WildCard => multipleWordSet,
																 numEquivs > 0 AND wtyp = Types.WordType.MultiEquiv => equivs, // If Multi word equiv type, only store equivalent in word list
																 numEquivs > 0 => singleWordSet + equivs,
																 singleWordSet),
														 IF(wtyp = Types.WordType.Date, drSet, nrSet)));
	EXPORT Get_Word_List := rslt;


	SHARED num_unforced := wtyp = Types.WordType.numeric AND NOT forceString;
	SHARED isDate := wtyp = Types.WordType.Date;

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

	Types.NominalList mFullNominalSet := SET(SORT(dSet_f, nominal), nominal);
	Types.NominalList sFullNominalSet := SET(aSet_f, nominal);
	Types.NominalList eFullNominalSet := SET(SORT(eSet_f, nominal), nominal);
	Types.NominalList drFullNominalSet := [d1_nominal, d2_nominal];
	Types.NominalList nrFullNominalSet := [n1_nominal, n2_nominal];
	Types.NominalList rFullNominalSet := IF(isDate, drFullNominalSet, nrFullNomiNalSet);

	lst_f := IF(term = '', [0],
												 IF(~isRNGType,
															MAP(hasWild AND EXISTS(dSet_f) => mFullNominalSet,
																	num_unforced OR isDate => [nNominal],
																	numEquivs > 0 => eFullNominalSet,
																	sFullNominalSet),
														rFullNominalSet));
	EXPORT Get_FullNominal_List := lst_f;

	SHARED BOOLEAN EQCompare := ftyp = Types.NominalFilter.EQ_Filter OR
																ftyp = Types.NominalFilter.IN_Filter;
	SHARED isText := wtyp = Types.WordType.TextStr OR forceString
								OR wtyp=Types.WordType.SSN;

	//
	Types.NominalList multipleNominalSet := SET(SORT(dSet, nominal), nominal);
	Types.NominalList singleNominalSet := SET(aSet, nominal);
	Types.NominalList withEquivNominalSet := SET(SORT(equivSet, nominal), nominal);
	Types.NominalList drNominalSet := [0, 0];

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
	Types.NominalSuffixList multipleSuffixSet := SET(SORT(dSet, nominal), suffix);
	Types.NominalSuffixList singleSuffixSet := SET(aSet, suffix);
	Types.NominalSuffixList withEquivSuffixSet := SET(SORT(equivSet, nominal), suffix);
	Types.NominalSuffixList drSuffixSet := [d1_nominal, d2_nominal];
	Types.NominalSuffixList nrSuffixSet := [n1_nominal, n2_nominal];
	Types.NominalSuffixList rSuffixSet := IF(isDate, drSuffixSet, nrSuffixSet);

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
	EXPORT RevisedType := MAP(forceString										=> Types.SegmentType.TextType,
														EQCompare											=> wtyp,
														wtyp = Types.WordType.Numeric	=> Types.WordType.NumericRange,
														isDate												=> Types.WordType.DateRange,
														wtyp);
END;