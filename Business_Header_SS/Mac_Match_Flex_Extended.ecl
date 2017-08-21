//MATCHSET should be set of char1's indicating matchfields
/*	'A' = Address
	'F' = FEIN
	'P'	= phone
		* company name will always be part of the match if any of
		  the above flags are set.
	'N' = Allow match on company name only.
*/
import business_header;

EXPORT Mac_Match_Flex_Extended
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
	,BDL_field
	,GroupId_field
	,outrec
	,bool_outrec_has_score
	,BDID_Score_field					//these should default to zero in definition
	,outBDIDfile
	,outBDLfile
	,score_threshold				= '75'
	,pFileVersion						= '\'prod\''														// default to using the "prod" version of the bdl superfile
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	
) := MACRO

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
	,BDID_Score_field  //these should default to zero in definition
	,outBDIDfile
	,
	,
	,pFileVersion
	,pUseOtherEnvironment

)

// Maco to add BDL and GroupId's for a given BDID file.
Business_Header_SS.Mac_Add_BDL_GroupID_By_BDID(outBDIDfile, BDID_field, bdl_field, groupId_field, outBDLfile,pFileVersion,pUseOtherEnvironment);


ENDMACRO;
