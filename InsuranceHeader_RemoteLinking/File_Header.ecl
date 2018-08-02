IMPORT idl_header,_Control;
// EXPORT File_Header := CASE(_Control.ThisEnvironment.Name,
// 'Prod'=>idl_header.files.DS_IDL_POLICY_HEADER_BASE, 
// 'Alpha_Dev'=>DATASET('~foreign::10.194.126.207::thor_data400::base::insuranceheader::idl_salt_iter_input_201603_iter_2_w20160226-181121',Layout_Header,THOR));
EXPORT File_Header := idl_header.files.DS_IDL_POLICY_HEADER_BASE;