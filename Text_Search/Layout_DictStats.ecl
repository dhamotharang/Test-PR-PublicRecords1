// Dictionary stats
EXPORT Layout_DictStats := RECORD
	Types.Freq	maxDocFreq;
	Types.Freq	maxFreq;
	INTEGER8    meanDocSize;
	INTEGER8		uniqueNominals;
	INTEGER8		docCount;
  INTEGER1    version;
END;