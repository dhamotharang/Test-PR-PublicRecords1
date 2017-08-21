import business_header_ss,ut;
EXPORT File_Business_Header_Plus := 
project(
	DATASET(
	ut.foreign_prod+'thor_data400::BASE::Business_Header_' + business_header_ss.key_version,
	Layout_Business_Header_Base_Plus, FLAT, opt)
	,transform(Layout_Business_Header_Base_Plus_Orig, self := left)
);