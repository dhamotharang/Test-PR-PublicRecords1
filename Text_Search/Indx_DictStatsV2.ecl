dsEmpty := DATASET([], Layout_DictStats);

EXPORT Indx_DictStatsV2(FileName_Info info, BOOLEAN fPhys=FALSE, 
											DATASET(Layout_DictStats) ds=dsEmpty) := 

	INDEX(ds, {version}, 
				{maxDocFreq, maxFreq, meanDocSize, uniqueNominals, docCount},
				FileName(info, Types.FileTypeEnum.DictStats2, fPhys));