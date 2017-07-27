export Proc_Build_Boolean_Keys(string filedate) := sequential(Prof_Licensev2.BWR_Build_Segment_Metadata(filedate),
																															Prof_licensev2.BWR_Proflic_Boolean_build(filedate));