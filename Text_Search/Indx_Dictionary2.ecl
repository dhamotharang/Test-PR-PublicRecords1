// depricated - replaced by indx_Dictionary3
EXPORT Indx_Dictionary2(FileName_Info info, BOOLEAN fPhys=FALSE,
											BOOLEAN NoIndexFile = TRUE,
											DATASET(Layout_IndxDict) dict=DATASET([], Layout_IndxDict)) :=
DEPRICATED DEPRICATED DEPRICATE // force syntax error if referenced
	INDEX(IF( NoIndexFile, dict, File_Dictionary(info, fPhys)),
				 {Types.WordFixed word := word, nominal, suffix, freq, docFreq}, 
				 {typ, Types.WordStr fullWord:=word, fpos},
				 FileName(info, Types.FileTypeEnum.DictIndx2, fPhys), OPT);