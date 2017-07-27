//
// This dictionary is distributed so that all the words for each node exist on that 
// node.  Words only exist in nodes where they occured. This dictionary also contains substring 
// entries for leading wildcard lookup.
//
EXPORT Indx_LocalDict2(FileName_Info info, BOOLEAN fPhys=FALSE,
											BOOLEAN NoIndexFile = TRUE,
											DATASET(Layout_IndxDict2) dict=DATASET([], Layout_IndxDict2)) := 
	INDEX(IF( NoIndexFile, dict, File_Dictionary2(info, fPhys)),
				 {typ, Types.WordFixed word := word, nominal, suffix, freq, docFreq}, 
				 {fullword, subString, fpos},
				 FileName(info, Types.FileTypeEnum.LocalDictX2, fPhys), DISTRIBUTED);