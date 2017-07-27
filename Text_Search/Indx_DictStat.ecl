//
dsEmpty := DATASET([], Layout_DictStats);
Extend_DictStat := RECORD(Layout_DictStats)
	UNSIGNED8 fpos{virtual(fileposition)} := 0;
END;


Extend_DictStat x1(dsEmpty l) :=TRANSFORM
	SELF.fpos := 0;
	SELF := l;
END;

EXPORT Indx_DictStat(FileName_Info info, BOOLEAN fPhys=FALSE, 
											BOOLEAN NoIndexFile = TRUE, 
											DATASET(Layout_DictStats) ds=dsEmpty) := 

	INDEX(IF(NoIndexFile, PROJECT(ds, x1(LEFT)), File_DictStat(info, fPhys)),
				{INTEGER1 f:=1}, 
				{maxDocFreq, maxFreq, meanDocSize, uniqueNominals, docCount, fpos},
				FileName(info, Types.FileTypeEnum.DictStatX, fPhys));