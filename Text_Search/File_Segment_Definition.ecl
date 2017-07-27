// Temporary field definition set
Extend_Segment_Definition := RECORD(Layout_Segment_Definition)
	UNSIGNED8 fpos{virtual(fileposition)} := 0;
END;

										
EXPORT File_Segment_Definition(FileName_Info info, BOOLEAN fPhys=FALSE) := 
		DATASET(FileName(info, Types.FileTypeEnum.SegList, fPhys),
						Extend_Segment_Definition, THOR);
