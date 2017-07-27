export File_Simple_Test(FileName_Info info)
		:= DATASET(info.stem + '::SIMPLE_DOC::' + info.qual,
							Text_Search.Layout_Simple_Document, THOR);