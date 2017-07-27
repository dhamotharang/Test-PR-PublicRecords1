export Proc_Build_Boolean_Keys(string filedate) := sequential(txbus.BWR_Build_Segment_Metadata(filedate),
												txbus.BWR_Build_txbus_boolean(filedate));