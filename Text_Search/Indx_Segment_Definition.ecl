// 
slEmpty := DATASET([], Layout_Segment_Definition);

Extend_Segment_Definition := RECORD(Layout_Segment_Definition)
	UNSIGNED8 fpos{virtual(fileposition)};
END;
Extend_Segment_Definition x(Layout_Segment_Definition l) := TRANSFORM
	SELF.fpos := 0;
	SELF := l;
END;

EXPORT Indx_Segment_Definition(FileName_Info info, BOOLEAN fPhys=FALSE, 
											BOOLEAN NoIndexFile = TRUE, BOOLEAN fPhysBase=FALSE,
											DATASET(Layout_Segment_Definition) sl=slEmpty) := 
	INDEX(IF(NoIndexFile, PROJECT(sl, x(LEFT)), File_Segment_Definition(info,fPhysBase)),
				{INTEGER1 f:=1}, {segName, segType, segList, fpos},
				FileName(info, Types.FileTypeEnum.SegListX, fPhys));