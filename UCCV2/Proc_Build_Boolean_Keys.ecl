export Proc_Build_Boolean_Keys(string filedate) := sequential(uccv2.BWR_Build_Segment_Metadata(filedate),
																										uccv2.BWR_Build_UCCV2_Boolean(filedate));