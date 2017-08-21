export Proc_Build_boolean_keys(string filedate) := sequential(FCC.BWR_Build_Segment_Metadata(filedate),
																										FCC.BWR_Build_FCC_Boolean(filedate)
																								);