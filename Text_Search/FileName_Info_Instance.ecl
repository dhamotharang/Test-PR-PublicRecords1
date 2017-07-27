// Extended to support legacy style names
//NOTE: the values from the interface are hard-coded in this version
//      due to a lack of language support for access.  This will be
//      fixed with bug: 24547
IMPORT LIB_Word;
EXPORT FileName_Info_Instance(STRING aStem, STRING aSrcType, STRING aQual) 
			:= MODULE(FileName_Info)
	SHARED STRING 	wStem := TRIM(StringLib.StringToUpperCase(aStem));
	SHARED STRING   wSrcType := TRIM(StringLib.StringToUpperCase(aSrcType));
	SHARED STRING   wQual := TRIM(StringLib.StringToUpperCase(aQual));
	EXPORT STRING		stem := LIB_Word.StripTail(wStem, '::BASE');// FIX Users!!!!!!!!
	EXPORT STRING		srcType := IF(aSrcType<>'', aSrcType, 'UNKNOWN');
	EXPORT STRING		qual := IF(wQual<>'', wQual, 'MISSING');
END;