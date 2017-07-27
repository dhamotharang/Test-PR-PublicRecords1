// Summary data from dictionary
Extend_DictStat := RECORD(layout_DictStats)
	UNSIGNED8 fpos{virtual(fileposition)};
END;

EXPORT File_DictStat(FileName_Info info, BOOLEAN fPhys=FALSE) 
  := DATASET(FileName(info, Types.FileTypeEnum.DictStat, fPhys),
							Extend_DictStat, FLAT);