export Proc_build_boolean_keys(string filedate) := sequential(fbnv2.BWR_Build_FBN_Metadata(filedate),
																										fbnv2.BWR_Build_FBN_Boolean(filedate));