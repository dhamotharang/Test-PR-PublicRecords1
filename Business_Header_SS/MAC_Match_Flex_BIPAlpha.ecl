/*	

PLEASE DO NOT USE THIS MACRO IN ANY NEW CODE.
IT IS ONLY HERE FOR BACKWARD COMPATIBILITY AND LOGISITICAL REASONS

*/

import business_header, BIPV2;

EXPORT MAC_Match_Flex_BIPAlpha
(
	 infile
	,matchset
	,company_name_field
	,prange_field
	,pname_field
	,zip_field
	,srange_field
	,state_field
	,phone_field
	,fein_field
	,BDID_field
	,outrec
	,bool_outrec_has_score
	,BDID_Score_field				//these should default to zero in definition
	,outfile
	,keep_count							= '1'
	,score_threshold				= '75'
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,pURL										=	''
	,pEmail									=	''
	,pCity									= ''	
	,pContact_fname					= ''
	,pContact_mname					= ''
	,pContact_lname					= ''
  ,contact_ssn					  = ''
  ,source					        = ''
  ,source_record_id				= ''
  ,src_matching_is_priority	= FALSE
) :=
MACRO

// Need to have something in here besides just calling another macro.
#uniquename(foobarness)
%foobarness% := true;

Business_Header_SS.MAC_Match_Flex
(
	 infile
	,matchset
	,company_name_field
	,prange_field
	,pname_field
	,zip_field
	,srange_field
	,state_field
	,phone_field
	,fein_field
	,BDID_field
	,outrec
	,bool_outrec_has_score
	,BDID_Score_field				
	,outfile
	,keep_count							
	,score_threshold			
	,pFileVersion																		
	,pUseOtherEnvironment		
	,pSetLinkingVersions 		
	,pURL										
	,pEmail								
	,pCity								
	,pContact_fname					
	,pContact_mname					
	,pContact_lname					
  ,contact_ssn					 
  ,source					     
  ,source_record_id				
  ,src_matching_is_priority	
)

ENDMACRO;