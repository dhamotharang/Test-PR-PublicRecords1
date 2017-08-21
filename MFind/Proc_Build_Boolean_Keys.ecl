export Proc_Build_Boolean_Keys(string filedate) := sequential(Mfind.BWR_Build_Segment_Metadata(filedate),
												Mfind.BWR_Build_MFind_Boolean(filedate));