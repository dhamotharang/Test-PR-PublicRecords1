export Proc_Build_Boolean_Keys(string filedate) := sequential(sanctn.BWR_Build_Sanc_Metadata(filedate),
																										sanctn.BWR_Build_Sanc_Boolean(filedate));