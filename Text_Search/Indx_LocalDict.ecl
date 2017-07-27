//
// This dictionary is distributed so that all the words for each node exist on that 
// node.  Words only exist in nodes where the occured.
//
EXPORT Indx_LocalDict(FileName_Info info, BOOLEAN fPhys=FALSE,
											BOOLEAN NoIndexFile = TRUE,
											DATASET(Layout_IndxDict) dict=DATASET([], Layout_IndxDict)) := 
	INDEX(IF( NoIndexFile, dict, File_Dictionary(info, fPhys)),
				 {Types.WordFixed word := word, nominal, suffix, freq, docFreq}, 
				 {typ, Types.WordStr fullWord:=word, fpos},
				 FileName(info, Types.FileTypeEnum.LocalDictX, fPhys), DISTRIBUTED);
