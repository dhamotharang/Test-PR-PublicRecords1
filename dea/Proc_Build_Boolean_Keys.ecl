import DEA;

export Proc_Build_Boolean_Keys(string filedate) := 
																							sequential(
																									Dea.BWR_Build_Segment_Metadata(filedate),
																									dea.BWR_DEA_Build_Boolean(filedate)
																									);