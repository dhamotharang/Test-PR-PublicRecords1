import Text;

export MAC_MakeWordIndex(inFile, inLayout, wordsField, posField, fieldField, filterStops, outindex) :=
MACRO


#uniquename(addOne)
#uniquename(i)
#uniquename(adder)
%addOne%(UNSIGNED %i%, unsigned %adder%) := IF(%i% + %adder% > 65536, 65536, %i% + %adder%);

// ************************************ Parse out the words
#uniquename(myWord)
PATTERN %myWord% := (Text.Digit|Text.alpha|'@'|'.'|'-'|'?'|'/'|'\\'|':'|'('|')')+;

#uniquename(ParseRecord)
#uniquename(_ParseFound)
#uniquename(ParseFound)
#uniquename(wrd)
#uniquename(filepos)
#uniquename(freq)
#uniquename(population)
#uniquename(wordpos)
#uniquename(field)
#uniquename(cleanWords)
%ParseRecord% :=
RECORD
	STRING30 %wrd% := StringLib.StringToUpperCase(MATCHTEXT(%myWord%));
	unsigned8 %filepos% := inFile.posField;
	unsigned2 %freq% := 1;
	unsigned2 %population% := 1;
	unsigned4 %wordpos% := MATCHPOSITION(%myWord%);
	unsigned8 %field% := inFile.fieldField;
END;
%_ParseFound% := PARSE(inFile, wordsField, %myWord%, %ParseRecord%, MAX, MANY, maxlength(30))
				 (StringLib.StringFilter(%wrd%, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') != '');

%ParseRecord% %cleanWords%(%ParseRecord% L) :=
TRANSFORM
	SELF.%wrd% := StringLib.StringFilter(L.%wrd%, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	SELF := L;
END;

%ParseFound% := PROJECT(%_ParseFound%, %cleanWords%(LEFT));

// ********************* Change wordpos to word position rather than character position
#uniquename(DocumentOrder)
#uniquename(DocumentGroup)
#uniquename(changePos)
#uniquename(WordPosChange)
#uniquename(_WordPosChange)
#uniquename(addFieldSeparator)
%DocumentOrder% := SORT(DISTRIBUTE(%ParseFound%, HASH(%filepos%, %field%)), %filepos%, %field%, %wordpos%, LOCAL);
%DocumentGroup% := GROUP(%DocumentOrder%, %filepos%, %field%, LOCAL);
%ParseRecord% %changePos%(%ParseRecord% L, %ParseRecord% R, INTEGER c) :=
TRANSFORM
	SELF.%wordpos% := IF(c = 1, 1, %addOne%(L.%wordpos%,1));
	SELF := R;
END;
%_WordPosChange% := ITERATE(%DocumentGroup%, %changePos%(LEFT, RIGHT, COUNTER));

%ParseRecord% %addFieldSeparator%(%ParseRecord% L) :=
TRANSFORM
	SELF.%wordpos% := L.%wordpos% + L.%field%;
	SELF := L;
END;
%WordPosChange% := PROJECT(%_WordPosChange%, %addFieldSeparator%(LEFT))(~filterStops OR %wrd% NOT IN Text.StopWords);
// *************************** Calculate Frequency per doc
#uniquename(SortByDocWrd)
#uniquename(GoodWords)
#uniquename(DistByDocWord)
%GoodWords% := %WordPosChange%;
%DistByDocWord% := DISTRIBUTE(%GoodWords%, HASH(%wrd%));
%SortByDocWrd% := SORT(%DistByDocWord%, %wrd%, %filepos%, LOCAL);

#uniquename(freqTrans)
#uniquename(docFreq)
%ParseRecord% %freqTrans%(%ParseRecord% L, %ParseRecord% R) :=
TRANSFORM
	SELF.%freq% := %addOne%(L.%freq%, 1);
	SELF := L;
END;
%docFreq% := ROLLUP(%SortByDocWrd%, LEFT.%wrd% = RIGHT.%wrd% AND 
									LEFT.%filepos% = RIGHT.%filepos%, 
					%freqTrans%(LEFT, RIGHT), LOCAL);

// *************************** Calculate population frequency
#uniquename(totals)
#uniquename(cnt)
#uniquename(popFreq)
%totals% :=
RECORD
	%docFreq%.%wrd%;
	unsigned4 %cnt% := sum(group, %docFreq%.%freq%);
END;
%popFreq% := table(%docFreq%, %totals%, %wrd%, LOCAL);

// *************************** Add population frequecies back to word index
#uniquename(FreqPopTrans)
#uniquename(docpopFreq)
%ParseRecord% %FreqPopTrans%(%ParseRecord% L, %totals% R) :=
TRANSFORM
	SELF.%wrd% := L.%wrd%;
	SELF.%filepos% := L.%filepos%;
	SELF.%freq% := %addOne%(L.%freq%, 0);
	SELF.%population% := R.%cnt%;
	SELF.%wordpos% := 0;
	SELF.%field% := 0;
END;
%docpopFreq% := join(%docFreq%, %popFreq%, LEFT.%wrd% = RIGHT.%wrd%, 
					  %FreqPopTrans%(LEFT, RIGHT), local, lookup);


// *************************** Add word positions back
#uniquename(posTrans)
#uniquename(allPositions)
#uniquename(srtWordDocPos)
#uniquename(grpWordDocPos)
#uniquename(blankpops)
#uniquename(grpWordDocPos)
#uniquename(itrWordDocPos)
Text_test.Layout_WordList %posTrans%(%ParseRecord% L, %ParseRecord% R) :=
TRANSFORM
	SELF.word := L.%wrd%;
	SELF.fpos := L.%filepos%;
	SELF.freq := L.%freq%;
	SELF.population := L.%population%;
	SELF.wordpos := %addOne%(R.%wordpos%, 0);
END;
%allPositions% := JOIN(%docpopFreq%, %DistByDocWord%, 
					   LEFT.%wrd% = RIGHT.%wrd% AND LEFT.%filepos% = RIGHT.%filepos%,
					   %posTrans%(LEFT, RIGHT), LOCAL);

#uniquename(smaller)
outindex := %allPositions%; //INDEX(%allPositions%, {%allPositions%}, outindexfile);

ENDMACRO;