//W20120717-152918 is an example, though you can run this on hthor in 10 seconds

//EXAMPLE DATASET IN NEED OF EXTERNAL LINKING
infile := BIPV2.zzzSampleFile;
output(infile, named('infile'));

//OLD SCHOOL XLINK MACRO CALL
//MEANT TO REPRESENT YOUR EXISTING MACRO CALL
// BIPV2.zzzSampleXlinkMacro(
	// infile						// ExistingInfileParameter,
	// ,outfileNoBIP			// ExistingOutfileParameter,
	// ,recordof(infile)	// ExistingOutrecParameter,
	// ,junk							// OtherExistingParameters,
										/**NEW* parameter with default, AppendBIPids = false*/
// )
// output(outfileNoBIP, named('outfileNoBIP'));

//NEW SCHOOL XLINK MACRO CALL
//WILL BE YOUR EXISTING MACRO CALL WITH NEW RETURN LAYOUT AND NEW PARAMETER(S)
BIPRec := {{infile} - [src], BIPV2.IDlayouts.l_xlink_ids};
// BIPV2.zzzSampleXlinkMacro(
	// infile						// ExistingInfileParameter,
	// ,outfileWithBIP		// ExistingOutfileParameter,
	// ,BIPRec						// ExistingOutrecParameter, *NEW* record layout
	// ,junk							// OtherExistingParameters,
	// ,TRUE							// *NEW* parameter, now turned on, AppendBIPids
// )
import Business_Header_SS;
matchset := ['C','A','P'];
Business_Header_SS.MAC_Match_Flex(
 infile
	,matchset
	,company_name
	,company_prim_range
	,etc
	,etc
	,etc
	,etc
	,etc
	,etc
	,BDID_field
	,BIPRec
	,true
	,BDID_Score_field				//these should default to zero in definition
	,outfileWithBIP
	,//keep_count							= '1'
	,//score_threshold				= '75'
	,//pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,//pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,[BIPV2.IDconstants.xlink_version_BIP]		//pSetLinkingVersions 		= BIPV2.IDconstants.xlink_versions_default	
	,//pURL										=	''
	,//pEmail									=	''
	,//pCity									= ''	
	,//pContact_fname					= ''
	,//pContact_mname					= ''
	,//pContact_lname					= ''
  ,//contact_ssn					  = ''
  ,src//source					        = ''	
  ,rid//source_record_id				= ''
  ,//src_matching_is_priority	= FALSE
)

output(sort(outfileWithBIP, contact_id), named('outfileWithBIP'));

//NEW SCHOOL INDEX BUILD
BIPV2.IDmacros.mac_IndexWithXLinkIDs(outfileWithBIP, i, BIPV2.zzSampleKey.logicalName)
build(i, overwrite);