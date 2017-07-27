export Proc_Build_Deed_Boolean_Keys(string filedate) := sequential(
																																Ln_propertyv2.BWR_Build_Deeds_Metadata(filedate),
																															LN_Propertyv2.BWR_Build_Deeds_Boolean(filedate));
																																