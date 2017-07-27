export Proc_Build_Boolean_Keys(string filedate) := sequential(
																									LN_propertyv2.BWR_Build_Segment_Assess_Metadata(filedate),
																									LN_Propertyv2.BWR_Build_Assessment_Boolean(filedate));