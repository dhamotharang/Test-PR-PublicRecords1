//MATCHSET should be set of char1's indicating matchfields
/*	'A' = Address
	'F' = FEIN
	'P'	= phone
		* company name will always be part of the match if any of
		  the above flags are set.
	'N' = Allow match on company name only.
*/
import business_header;

EXPORT MAC_Add_BDID_Flex_Bk
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
	,BDID_Score_field					//these should default to zero in definition
	,outfile
	,score_threshold				= '75'
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod from dataland, and on prod hit prod.
	
) := MACRO

// Need to have something in here besides just calling another macro.
#uniquename(foobarness)
%foobarness% := true;

BankruptcyV2.Mac_Match_Flex_BK
(
	infile, matchset,
	company_name_field, 
	prange_field, pname_field, zip_field,
	srange_field, state_field,
	phone_field, fein_field,
	BDID_field,	
	outrec,
	bool_outrec_has_score, BDID_Score_field,  //these should default to zero in definition
	outfile,
	1,
	score_threshold
	,pFileVersion
	,pUseOtherEnvironment
)

ENDMACRO;