/*	

PLEASE DO NOT USE THIS MACRO IN ANY NEW CODE.
IT IS ONLY HERE FOR BACKWARD COMPATIBILITY AND LOGISITICAL REASONS

*/

import business_header,BIPV2;


EXPORT MAC_Source_Match_BIPAlpha(

	 infile
	,outfile
	,bool_bdid_field_is_string12
	,bdid_field
	,bool_infile_has_source_field
	,source_type_or_field
	,bool_infile_has_source_group
	,source_group_field
	,company_name_field
	,prim_range_field
	,prim_name_field
	,sec_range_field
	,zip_field
	,bool_infile_has_phone
	,phone_field
	,bool_infile_has_fein
	,fein_field
	,bool_infile_has_vendor_id	= 'false'
	,vendor_id_field						= 'vendor_id'
	,pFileVersion								= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment				= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,pSetLinkingVersions 				= BIPV2.IDconstants.xlink_versions_default
	,pSRC_RID_field							= BIPV2.IDconstants.SRC_RID_field_default

) := MACRO

// Need to have something in here besides just calling another macro.
#uniquename(foobarness)
%foobarness% := true;

Business_Header.MAC_Source_Match(

	 infile
	,outfile
	,bool_bdid_field_is_string12
	,bdid_field
	,bool_infile_has_source_field
	,source_type_or_field
	,bool_infile_has_source_group
	,source_group_field
	,company_name_field
	,prim_range_field
	,prim_name_field
	,sec_range_field
	,zip_field
	,bool_infile_has_phone
	,phone_field
	,bool_infile_has_fein
	,fein_field
	,bool_infile_has_vendor_id
	,vendor_id_field						
	,pFileVersion																
	,pUseOtherEnvironment				
	,pSetLinkingVersions 				
	,pSRC_RID_field						

)

ENDMACRO;