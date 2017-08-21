export Proc_Build_Boolean_Keys (string filedate) := sequential(vehiclev2.BWR_Build_Segment_Metadata(filedate),
												vehiclev2.BWR_Build_MV2_boolean(filedate));
