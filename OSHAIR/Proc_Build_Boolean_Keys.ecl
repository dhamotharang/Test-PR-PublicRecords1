export Proc_Build_Boolean_Keys(string filedate) := sequential(
																										Oshair.BWR_Build_Segment_Metadata(filedate),
																										Oshair.BWR_Oshair_Build_Boolean(filedate)
																										);