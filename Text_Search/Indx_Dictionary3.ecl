//
// Index for dictionary, maintained as normal key file, distributed by word
//
EXPORT Indx_Dictionary3(FileName_Info info, BOOLEAN fPhys=FALSE,
											BOOLEAN NoIndexFile = TRUE,
											DATASET(Layout_IndxDict) dict=DATASET([], Layout_IndxDict)) := 
	INDEX(IF( NoIndexFile, dict, File_Dictionary(info, fPhys)),
				 {Types.WordFixed word := word, nominal, suffix, freq, docFreq}, 
				 {typ, Types.WordStr fullWord:=word, fpos},
				 FileName(info, Types.FileTypeEnum.DictIndx3, fPhys));