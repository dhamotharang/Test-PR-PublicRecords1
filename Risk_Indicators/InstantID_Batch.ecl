/*--SOAP--
<message name="InstantIdBatch">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>	
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>	
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="IncludeFraudScores" type="xsd:boolean"/>
	<part name="IncludeRiskIndices" type="xsd:boolean"/>
	<part name="RedFlag_version" type="xsd:unsignedInt"/>
	<part name="RedFlagsOnly" type="xsd:boolean"/>
	<part name="Model" type="xsd:string"/>
	<part name="Targus" type="xsd:boolean"/>
	<part name="IncludeTargusE3220" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeCLOverride" type="xsd:boolean"/>
	<part name="IncludeDLVerification" type="xsd:boolean"/>

	<part name="ExactFirstNameMatch" type="xsd:boolean"/>
	<part name="ExactLastNameMatch" type="xsd:boolean"/>
	<part name="ExactFirstNameMatchAllowNicknames" type="xsd:boolean"/>
	<part name="ExactPhoneMatch" type="xsd:boolean"/>
	<part name="ExactSSNMatch" type="xsd:boolean"/>
	<part name="ExactDOBMatch" type="xsd:boolean"/>
	<part name="ExactAddrMatch" type="xsd:boolean"/>
	<part name="ExactDriverLicenseMatch" type="xsd:boolean"/>

	<part name="IncludeAllRiskIndicators" type="xsd:boolean"/>
	
	<part name="Include_ALL_Watchlist" type="xsd:boolean"/>
	<part name="Include_BES_Watchlist" type="xsd:boolean"/>
	<part name="Include_CFTC_Watchlist" type="xsd:boolean"/>
	<part name="Include_DTC_Watchlist" type="xsd:boolean"/>
	<part name="Include_EUDT_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBI_Watchlist" type="xsd:boolean"/>
	<part name="Include_FCEN_Watchlist" type="xsd:boolean"/>
	<part name="Include_FAR_Watchlist" type="xsd:boolean"/>
	<part name="Include_IMW_Watchlist" type="xsd:boolean"/>
	<part name="Include_OFAC_Watchlist" type="xsd:boolean"/>
	<part name="Include_OCC_Watchlist" type="xsd:boolean"/>
	<part name="Include_OSFI_Watchlist" type="xsd:boolean"/>
	<part name="Include_PEP_Watchlist" type="xsd:boolean"/>
	<part name="Include_SDT_Watchlist" type="xsd:boolean"/>
	<part name="Include_BIS_Watchlist" type="xsd:boolean"/>
	<part name="Include_UNNT_Watchlist" type="xsd:boolean"/>
	<part name="Include_WBIF_Watchlist" type="xsd:boolean"/>

	<part name="Include_ADFA_Watchlist" type="xsd:boolean"/>
	<part name="Include_FAJC_Watchlist" type="xsd:boolean"/>
	<part name="Include_FATF_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIH_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIS_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIT_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIW_Watchlist" type="xsd:boolean"/>
	<part name="Include_HKMA_Watchlist" type="xsd:boolean"/>
	<part name="Include_MASI_Watchlist" type="xsd:boolean"/>
	<part name="Include_OFFC_Watchlist" type="xsd:boolean"/>
	<part name="Include_PMLC_Watchlist" type="xsd:boolean"/>
	<part name="Include_PMLJ_Watchlist" type="xsd:boolean"/>

	<part name="DOBMatchType" type="xsd:string"/>
	<part name="DOBMatchYearRadius" type="xsd:unsignedInt"/>

	<part name="CustomCVIModelName" type="xsd:string"/>
	<part name="LastSeenThreshold" type="xsd:string"/>
	<part name="IncludeMIoverride" type="xsd:boolean"/>
	<part name="IncludeDOBInCVI" type="xsd:boolean"/>
	<part name="IncludeDriverLicenseInCVI" type="xsd:boolean"/>
	<part name="DisableInquiriesInCVI" type="xsd:boolean"/>
	<part name="DisallowInsurancePhoneHeaderGateway" type="xsd:boolean"/>
	<part name="CompanyID" type="xsd:string"/>
	<part name="ProductCode" type="xsd:string"/>
	<part name="InstantIDVersion" type="xsd:string"/>
	<part name="IIDVersionOverride" type="xsd:boolean"/>
	<part name="IncludeDPBC" type="xsd:boolean"/>

	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
	<part name="EnableEmergingID" type="xsd:boolean"/>	
	<part name="NameInputOrder" type="xsd:string"/>	
</message>
*/
/*--HELP--
<pre>
&lt;dataset&gt;
	&lt;row&gt;
		&lt;seq&gt;&lt;/seq&gt;
		&lt;acctno&gt;&lt;/acctno&gt;
		&lt;ssn&gt;&lt;/ssn&gt;
		&lt;unparsedfullname&gt;&lt;/unparsedfullname&gt;
		&lt;name_first&gt;&lt;/name_first&gt;
		&lt;name_middle&gt;&lt;/name_middle&gt;
		&lt;name_last&gt;&lt;/name_last&gt;
		&lt;name_suffix&gt;&lt;/name_suffix&gt;
		&lt;dob&gt;&lt;/dob&gt;
		&lt;street_addr&gt;&lt;/street_addr&gt;
		&lt;prim_range&gt;&lt;/prim_range&gt;
		&lt;predir&gt;&lt;/predir&gt;
		&lt;prim_name&gt;&lt;/prim_name&gt;
		&lt;suffix&gt;&lt;/suffix&gt;
		&lt;postdir&gt;&lt;/postdir&gt;
		&lt;unit_desig&gt;&lt;/unit_desig&gt;
		&lt;sec_range&gt;&lt;/sec_range&gt;
		&lt;p_city_name&gt;&lt;/p_city_name&gt;
		&lt;st&gt;&lt;/st&gt;
		&lt;z5&gt;&lt;/z5&gt;
		&lt;age&gt;&lt;/age&gt;
		&lt;dl_number&gt;&lt;/dl_number&gt;
		&lt;dl_state&gt;&lt;/dl_state&gt;
		&lt;home_phone&gt;&lt;/home_phone&gt;
		&lt;work_phone&gt;&lt;/work_phone&gt;
		&lt;ip_addr&gt;&lt;/ip_addr&gt;
		&lt;Gender&gt;&lt;/Gender&gt;
		&lt;PassportUpperLine&gt;&lt;/PassportUpperLine&gt;
		&lt;PassportLowerLine&gt;&lt;/PassportLowerLine&gt;
	&lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import ut, address, codes, models, riskwise, iesp, patriot, intliid, address, royalty, AutoStandardI, OFAC_XG5, STD;

export InstantID_Batch := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

unsigned1 DPPA_Purpose := 0 : stored('DPPAPurpose');
unsigned1 GLB_Purpose := AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');
STRING5 industry_class_val := '' : STORED('IndustryClass');
industry_class_value := StringLib.StringToUpperCase(industry_class_val);
boolean ln_branded_value := false : STORED('LnBranded');
boolean ofac_only := true : stored('OfacOnly');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false : STORED('PoBoxCompliance');

boolean ExcludeWatchLists := false : stored('ExcludeWatchLists');
unsigned1 OFAC_version :=1 :STORED('OFACversion');
boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE: stored('IncludeOfac');
real Global_WatchList_Threshold_temp := 0 :stored('GlobalWatchlistThreshold');
			global_watchlist_threshold := Map( 
																		OFAC_version >= 4	and global_watchlist_threshold_temp = 0			=> OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,
																		OFAC_version < 4  and global_watchlist_threshold_temp = 0 		=> OFAC_XG5.Constants.DEF_THRESHOLD_REAL,
																		global_watchlist_threshold_temp);
boolean IncludeFraudScores := false :stored('IncludeFraudScores');
boolean IncludeRiskIndices := false :stored('IncludeRiskIndices');
boolean use_dob_filter := FALSE :stored('UseDobFilter');
integer2 dob_radius := 2 :stored('DobRadius');
unsigned1 RedFlag_version := 0 : stored('RedFlag_version');
boolean RedFlagsOnly := false : stored('RedFlagsOnly');
string Model_in := '' : stored('Model');
model_name := StringLib.StringToLowerCase( model_in );
boolean	IncludeTargus := TRUE			: stored('Targus');	// default to TRUE so existing batch jobs work the same as they were
boolean IncludeTargus3220 := false : stored('IncludeTargusE3220');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

boolean ExactFirstNameMatch := false : stored('ExactFirstNameMatch');
boolean ExactLastNameMatch := false : stored('ExactLastNameMatch');
boolean ExactAddrMatch := false : stored('ExactAddrMatch');
boolean ExactPhoneMatch := false : stored('ExactPhoneMatch');
boolean ExactSSNMatch := false : stored('ExactSSNMatch');
boolean ExactDOBMatch := false : stored('ExactDOBMatch');
boolean ExactDriverLicenseMatch := false : stored('ExactDriverLicenseMatch');
boolean ExactFirstNameMatchAllowNicknames := false : stored('ExactFirstNameMatchAllowNicknames');

string10 ExactMatchLevel := 	if(ExactFirstNameMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactLastNameMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactAddrMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactPhoneMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactSSNMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactDOBMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) +
										if(ExactFirstNameMatchAllowNicknames, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) +
										if(ExactDriverLicenseMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse);
										
boolean   IncludeAllRiskIndicators := false	: stored('IncludeAllRiskIndicators');
unsigned1 NumReturnCodes := if(IncludeAllRiskIndicators, 20, risk_indicators.iid_constants.DefaultNumCodes);

// DOB options
string15  DOBMatchType := ''								: stored('DOBMatchType');
unsigned1 DOBMatchYearRadius := 0						: stored('DOBMatchYearRadius');
DOBMatchOptions := dataset([{DOBMatchType, DOBMatchYearRadius}], risk_indicators.layouts.Layout_DOB_Match_Options);


// constants
boolean suppressNearDups := false;
boolean require2ele := false;
boolean fromBiid := false;
boolean isFCRA := false;
boolean	nugen := true;
boolean	inCalif := false;
boolean	fdReasonsWith38 := false;
boolean OFAC := true;  // this was previously hardcoded when calling the cviScore, so will do that up here now

boolean Include_ALL_Watchlist:= false : stored('Include_ALL_Watchlist');
boolean Include_ALLV4_Watchlist:= false : stored('Include_ALLV4_Watchlist');
boolean Include_BES_Watchlist:= false : stored('Include_BES_Watchlist');
boolean Include_CFTC_Watchlist:= false : stored('Include_CFTC_Watchlist');
boolean Include_DTC_Watchlist:= false : stored('Include_DTC_Watchlist');
boolean Include_EUDT_Watchlist:= false : stored('Include_EUDT_Watchlist');
boolean Include_FBI_Watchlist:= false : stored('Include_FBI_Watchlist');
boolean Include_FCEN_Watchlist:= false : stored('Include_FCEN_Watchlist');
boolean Include_FAR_Watchlist:= false : stored('Include_FAR_Watchlist');
boolean Include_IMW_Watchlist:= false : stored('Include_IMW_Watchlist');
boolean Include_OFAC_Watchlist:= false : stored('Include_OFAC_Watchlist');
boolean Include_OCC_Watchlist:= false : stored('Include_OCC_Watchlist');
boolean Include_OSFI_Watchlist:= false : stored('Include_OSFI_Watchlist');
boolean Include_PEP_Watchlist:= false : stored('Include_PEP_Watchlist');
boolean Include_SDT_Watchlist:= false : stored('Include_SDT_Watchlist');
boolean Include_BIS_Watchlist:= false : stored('Include_BIS_Watchlist');
boolean Include_UNNT_Watchlist:= false : stored('Include_UNNT_Watchlist');
boolean Include_WBIF_Watchlist:= false : stored('Include_WBIF_Watchlist');

boolean Include_ADFA_Watchlist:= false : stored('Include_ADFA_Watchlist');
boolean Include_FAJC_Watchlist:= false : stored('Include_FAJC_Watchlist');
boolean Include_FATF_Watchlist:= false : stored('Include_FATF_Watchlist');
boolean Include_FBIH_Watchlist:= false : stored('Include_FBIH_Watchlist');
boolean Include_FBIS_Watchlist:= false : stored('Include_FBIS_Watchlist');
boolean Include_FBIT_Watchlist:= false : stored('Include_FBIT_Watchlist');
boolean Include_FBIW_Watchlist:= false : stored('Include_FBIW_Watchlist');
boolean Include_HKMA_Watchlist:= false : stored('Include_HKMA_Watchlist');
boolean Include_MASI_Watchlist:= false : stored('Include_MASI_Watchlist');
boolean Include_OFFC_Watchlist:= false : stored('Include_OFFC_Watchlist');
boolean Include_PMLC_Watchlist:= false : stored('Include_PMLC_Watchlist');
boolean Include_PMLJ_Watchlist:= false : stored('Include_PMLJ_Watchlist');

dWL := dataset([], iesp.share.t_StringArrayItem) +
if(Include_ALL_Watchlist, dataset([{patriot.constants.wlALL}], iesp.share.t_StringArrayItem)) +
if(Include_ALLV4_Watchlist, dataset([{patriot.constants.wlALLV4}], iesp.share.t_StringArrayItem)) +
if(Include_BES_Watchlist, dataset([{patriot.constants.wlBES}], iesp.share.t_StringArrayItem)) +
if(Include_CFTC_Watchlist, dataset([{patriot.constants.wlCFTC}], iesp.share.t_StringArrayItem)) +
if(Include_DTC_Watchlist, dataset([{patriot.constants.wlDTC}], iesp.share.t_StringArrayItem)) +
if(Include_EUDT_Watchlist, dataset([{patriot.constants.wlEUDT}], iesp.share.t_StringArrayItem)) +
if(Include_FBI_Watchlist, dataset([{patriot.constants.wlFBI}], iesp.share.t_StringArrayItem)) +
if(Include_FCEN_Watchlist, dataset([{patriot.constants.wlFCEN}], iesp.share.t_StringArrayItem)) +
if(Include_FAR_Watchlist, dataset([{patriot.constants.wlFAR}], iesp.share.t_StringArrayItem)) +
if(Include_IMW_Watchlist, dataset([{patriot.constants.wlIMW}], iesp.share.t_StringArrayItem)) +
if(Include_OFAC_Watchlist, dataset([{patriot.constants.wlOFAC}], iesp.share.t_StringArrayItem)) +
if(Include_OCC_Watchlist, dataset([{patriot.constants.wlOCC}], iesp.share.t_StringArrayItem)) +
if(Include_OSFI_Watchlist, dataset([{patriot.constants.wlOSFI}], iesp.share.t_StringArrayItem)) +
if(Include_PEP_Watchlist, dataset([{patriot.constants.wlPEP}], iesp.share.t_StringArrayItem)) +
if(Include_SDT_Watchlist, dataset([{patriot.constants.wlSDT}], iesp.share.t_StringArrayItem)) +
if(Include_BIS_Watchlist, dataset([{patriot.constants.wlBIS}], iesp.share.t_StringArrayItem)) +
if(Include_UNNT_Watchlist, dataset([{patriot.constants.wlUNNT}], iesp.share.t_StringArrayItem)) +
if(Include_WBIF_Watchlist, dataset([{patriot.constants.wlWBIF}], iesp.share.t_StringArrayItem)) +
if(Include_ADFA_Watchlist, dataset([{patriot.constants.wlADFA}], iesp.share.t_StringArrayItem)) +
if(Include_FAJC_Watchlist, dataset([{patriot.constants.wlFAJC}], iesp.share.t_StringArrayItem)) +
if(Include_FATF_Watchlist, dataset([{patriot.constants.wlFATF}], iesp.share.t_StringArrayItem)) +
if(Include_FBIH_Watchlist, dataset([{patriot.constants.wlFBIH}], iesp.share.t_StringArrayItem)) +
if(Include_FBIS_Watchlist, dataset([{patriot.constants.wlFBIS}], iesp.share.t_StringArrayItem)) +
if(Include_FBIT_Watchlist, dataset([{patriot.constants.wlFBIT}], iesp.share.t_StringArrayItem)) +
if(Include_FBIW_Watchlist, dataset([{patriot.constants.wlFBIW}], iesp.share.t_StringArrayItem)) +
if(Include_HKMA_Watchlist, dataset([{patriot.constants.wlHKMA}], iesp.share.t_StringArrayItem)) +
if(Include_MASI_Watchlist, dataset([{patriot.constants.wlMASI}], iesp.share.t_StringArrayItem)) +
if(Include_OFFC_Watchlist, dataset([{patriot.constants.wlOFFC}], iesp.share.t_StringArrayItem)) +
if(Include_PMLC_Watchlist, dataset([{patriot.constants.wlPMLC}], iesp.share.t_StringArrayItem)) +
if(Include_PMLJ_Watchlist, dataset([{patriot.constants.wlPMLJ}], iesp.share.t_StringArrayItem));

watchlists_request := dWL(value<>'');

IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
   FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

boolean IncludeDLverification := false : stored('IncludeDLverification');
boolean IncludeMSoverride := false : stored('IncludeMSoverride');
boolean IncludeCLoverride := false : stored('IncludeCLoverride');

// new options for CIID project spring 2014
string128 CustomCVIModelName := ''	: STORED('CustomCVIModelName');
string20 CompanyID := ''						: STORED('CompanyID');
string ProductCode := ''						: STORED('ProductCode');
unsigned3 LastSeenThreshold := risk_indicators.iid_constants.oneyear : STORED('LastSeenThreshold');
boolean IncludeMIoverride := false					: STORED('IncludeMIoverride');
boolean IncludeDOBinCVI := false						: STORED('IncludeDOBInCVI');
boolean IncludeDriverLicenseInCVI := false	: STORED('IncludeDriverLicenseInCVI');
boolean DisableInquiriesInCVI := false			: STORED('DisableInquiriesInCVI');
boolean DisallowInsurancePhoneHeaderGateway := false	: STORED('DisallowInsurancePhoneHeaderGateway');	
boolean IIDVersionOverride := false					: STORED('IIDVersionOverride');	// back office tag that, if true, allows a version lower than the lowestAllowedVersion
string1 IIDVersion := '0'										: STORED('InstantIDVersion');	// this is passed in by the customer, if nothing passed in, then 0
boolean IncludeDPBC := false 								: stored('IncludeDPBC');
boolean EnableEmergingID := false 					: stored('EnableEmergingID');
string3 NameInputOrder := ''								: STORED('NameInputOrder');	// sequence of name (FML = First/Middle/Last, LFM = Last/First/Middle) if not specified, uses default name parser


unsigned1 lowestAllowedVersion := 1;	// lowest allowed version according to product, unless the IIDVersionOveride is true
unsigned1 maxAllowedVersion := 1;	// maximum allowed version as of 1/28/2014

// calculate the actual iidVersion that will be used.  To start, versions 0 and 1 will be supported.  0 will represent the historical iid, while version 1 will
// represent the new logic implemented for 1/28/2014 release (new cvi, phones plus, inquiries, insurance header, reason codes etc).  A new input tag will allow the customer
// to choose the version they want to use.  This version cannot be lower than the lowest allowed version unless the override tag is set to true, in which case
// the customer can choose any version and if no version is passed in, it will be considered version 0.
actualIIDVersion := map((unsigned)IIDVersion > maxAllowedVersion => 99,	// they asked for a version that doesn't exist
												IIDVersionOverride = false => ut.imin2(ut.max2((unsigned)IIDversion, lowestAllowedVersion), maxAllowedVersion),	// choose the higher of the allowed or asked for because they can't override lowestAllowedVersion, however, don't let them pick a version that is higher than the highest one we currently support
												(unsigned)IIDversion); // they can override, give them whatever they asked for
if(actualIIDVersion=99, FAIL('Not an allowable InstantIDVersion.  Currently versions 0 and 1 are supported'));

//Check to see if the FP model requested requires a valid GLB 
FP3_models_requiring_GLB	:= ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9']; //these models require valid GLB, else fail
glb_ok 	:= Risk_Indicators.iid_constants.glb_ok(GLB_Purpose, isFCRA);
InvalidFP3GLBRequest := model_name in FP3_models_requiring_GLB and ~glb_ok; 
if(InvalidFP3GLBRequest, FAIL('Valid Gramm-Leach-Bliley Act (GLBA) purpose required'));

dob_radius_use := if(use_dob_filter,dob_radius,-1);

gateways_in := Gateway.Configuration.Get();

Custom_Model_Name := trim(StringLib.StringToUppercase(CustomCVIModelName));
Valid_CCVI := Custom_Model_Name in ['','CCVI1810_1'];
CustomCVIModelName_in := if(Valid_CCVI, Custom_Model_Name, error('Invalid Custom CVI model name.'));
ischase := if(CustomCVIModelName_in = 'CCVI1810_1', TRUE,FALSE);

in_format := record
	risk_indicators.Layout_Batch_In;
	string20 HistoryDateTimeStamp := '';
	string6 Gender := '';
	string44 PassportUpperLine := '';
	string44 PassportLowerLine := '';
	// fields below requested by Deni/Mike to be added for fraudpoint 2.0, even though we do nothing with them
	STRING5 Grade := '';
	string16 Channel := '';
	string8 Income := '';
	string16 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8 DateofApplication := '';
	string8 TimeofApplication := '';
	string50 email := '';
	string64 custom_input1 := '';
	string64 custom_input2 := '';
	string64 custom_input3 := '';
	string64 custom_input4 := '';
	string64 custom_input5 := '';
	string64 custom_input6 := '';
	string64 custom_input7 := '';
	string64 custom_input8 := '';
	string64 custom_input9 := '';
	string64 custom_input10 := '';
	string64 custom_input11 := '';
	string64 custom_input12 := '';
	string64 custom_input13 := '';
	string64 custom_input14 := '';
	string64 custom_input15 := '';
	string64 custom_input16 := '';
	string64 custom_input17 := '';
	string64 custom_input18 := '';
	string64 custom_input19 := '';
	string64 custom_input20 := '';
	string64 custom_input21 := '';
	string64 custom_input22 := '';
	string64 custom_input23 := '';
	string64 custom_input24 := '';
	string64 custom_input25 := '';
	string120 UnparsedFullName2;
	string30  Name_First2;
	string30  Name_Middle2;
	string30  Name_Last2;
	string5   Name_Suffix2;
	string65  Street_Addr2;
	string10  Prim_Range2;
	string2   Predir2;
	string28  Prim_Name2;
	string4   Suffix2;
	string2   Postdir2;
	string10  Unit_Desig2;
	string8   Sec_Range2;
	string25  p_City_name2;
	string2   St2;
	string5   Z52;
	string10  Home_Phone2;	
end;

f := dataset([],in_format) : stored('batch_in',few);

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := map(IncludeTargus = FALSE and le.servicename = 'targus' => '',	// don't call TG when Targus = FALSE
													IncludeTargus3220 and le.servicename = 'targus' => 'targuse3220',	// if E3220 requested, change servicename for later use
													le.servicename);
	self.url := map(IncludeTargus = FALSE and le.servicename = 'targus' => '',	// don't call TG when Targus = FALSE
									IncludeTargus3220 and le.servicename = 'targus' => le.url + '?ver_=1.39',	// need version 1.39 for E3220,
									le.url); 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));



fseqrec := record
	f;
end;

fseqrec into_seq(F L, integer C) := transform
	self.seq := C;
	self := l;
end;

fs := project(f, into_seq(LEFT,COUNTER));

// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
boolean IsInstantID := true;
reasoncode_settings := dataset([{IsInstantID, actualIIDVersion, EnableEmergingID, '', ischase}],riskwise.layouts.reasoncode_settings);
actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);


risk_indicators.Layout_Input into(fs le) := transform
	historydate := if(le.HistoryDateYYYYMM=0, history_date, le.HistoryDateYYYYMM);
	
	self.historydate := if(le.historyDateTimeStamp<>'',(unsigned)le.historyDateTimeStamp[1..6], historydate);
	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp, historydate);
	// clean up input
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.seq := le.seq;	
	self.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if ((integer)le.age = 0 and (integer)dob_val != 0,(STRING3)ut.GetAgeI((integer)dob_val), (le.age));
	
	self.phone10 := le.Home_Phone;
	self.wphone10 := le.Work_Phone;

	cleaned_name := Stringlib.StringToUppercase(
										map(trim(Stringlib.StringToUppercase(NameInputOrder)) = 'FML' => Address.CleanPersonFML73(le.UnParsedFullName),
												trim(Stringlib.StringToUppercase(NameInputOrder)) = 'LFM' => Address.CleanPersonLFM73(le.UnParsedFullName),
																																										 Address.CleanPerson73(le.UnParsedFullName)));
	
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := stringlib.stringtouppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	self.lname := stringlib.stringtouppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	self.mname := stringlib.stringtouppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	self.suffix := stringlib.stringtouppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	self.title := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));

	street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;		

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
		
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := If(ischase, risk_indicators.iid_constants.override_addr_type_chase(street_address, clean_a2[139]),risk_indicators.iid_constants.override_addr_type(street_address, clean_a2[139],clean_a2[126..129]));

	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
	
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(le.dl_state);
	
	self.ip_address := le.ip_addr;
	self.email_address := le.email;
	
	self := [];
end;

	
prep := PROJECT(fs,into(LEFT));

 

// optimization_options for red flags batch monitoring
boolean runSSNCodes:= if(RedFlagsOnly, false, true);
boolean runBestAddrCheck:= if(RedFlagsOnly, false, true);
boolean runChronoPhoneLookup:= if(RedFlagsOnly, false, true);
boolean runAreaCodeSplitSearch:= if(RedFlagsOnly, false, true);
boolean runExcludeWatchLists := if(RedFlagsOnly, false, ExcludeWatchLists);
integer ofc_version := if(RedFlagsOnly, 1, ofac_version);
integer bsversion := MAP (
													model_name in ['fp1109_0', 'fp1109_9']  =>  4, 
													model_name in ['fp1303_2', 'fp1307_2'] => 41,	
													model_name in ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'] => 51,	
													51);  // for Emerging Identities, bump default BS version to 51
boolean allowCellPhones := false;
string CustomDataFilter := '';  // this only for Phillip Morris in Identifier2
unsigned2 EverOccupant_PastMonths := 0;	// for identifier2
unsigned4 EverOccupant_StartDate := 99999999;	// for identifier2
unsigned1 AppendBest := 1;		// search best file
boolean doInquiries := ~DisableInquiriesInCVI AND dataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue AND
												actualIIDVersion=1;
boolean AllowInsuranceDL := true;
unsigned8 BSOptions := 
								if(bsversion >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0) +
                if(doInquiries, risk_indicators.iid_constants.BSOptions.IncludeInquiries, 0) +
								if(~DisallowInsurancePhoneHeaderGateway and actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IncludeInsNAP, 0) +
								if(actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IsInstantIDv1, 0) + 
                if(model_name in ['fp1303_2', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'],  
																					risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
																					risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
										0) +
								if(AllowInsuranceDL, risk_indicators.iid_constants.BSOptions.AllowInsuranceDLInfo, 0) + //Allows use of Insurance DL information
								if(EnableEmergingID, Risk_Indicators.iid_constants.BSOptions.EnableEmergingID,0);	//Invokes additional DID append logic


ret := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, industry_class_value='UTILI', ln_branded_value, ofac_only, suppressNearDups, 
									require2ele, fromBiid, isFCRA, runExcludeWatchLists ,FALSE,ofc_version,include_ofac,include_additional_watchlists,Global_WatchList_Threshold,dob_radius_use,
									bsversion, runSSNCodes, runBestAddrCheck, runChronoPhoneLookup, runAreaCodeSplitSearch, allowCellPhones, ExactMatchLevel, DataRestriction, CustomDataFilter, 
									IncludeDLverification, watchlists_request, DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, AppendBest, BSoptions, LastSeenThreshold,
									CompanyID, DataPermission);

if(exists(ret(watchlist_table = 'ERR')), FAIL('Bridger Gateway Error'));
							
tscore(UNSIGNED1 i) := IF(i=255,0,i);

Layout_InstandID_NuGenExt := record
	risk_indicators.Layout_InstandID_NuGen;
	Royalty.RoyaltyNetAcuity.IPData.Royalty_NAG;
	boolean insurance_dl_used;
end;

Layout_InstandID_NuGenExt format_out(ret le, fs R) := TRANSFORM
	SELF.acctNo		:=R.acctno;
	
	SELF.transaction_id := 0;

	isFirstExpressionFound := if(ischase, if(regexfind(Risk_Indicators.iid_constants.onlyContains_express + '|' + Risk_Indicators.iid_constants.contains_expression + '|' + Risk_Indicators.iid_constants.endsWith_expression, TRIM(STD.STR.ToUpperCase(r.Name_First)), NOCASE), TRUE, FALSE), FALSE);
	verfirst := Map(ischase AND isFirstExpressionFound => '',
											 le.combo_firstcount>0 => le.combo_first,
											 '');
	self.verfirst := verfirst;

	isLastExpressionFound  := if(ischase, if(regexfind(Risk_Indicators.iid_constants.onlyContains_express + '|' + Risk_Indicators.iid_constants.contains_expression + '|' + Risk_Indicators.iid_constants.endsWith_expression + '|' + Risk_Indicators.iid_constants.lastEndsWith_expression + '|' + Risk_Indicators.iid_constants.endingInc_expression, TRIM(STD.STR.ToUpperCase(r.Name_Last)), NOCASE), TRUE, FALSE), FALSE);
	verlast := Map(ischase AND isLastExpressionFound => '',
											le.combo_lastcount>0 => le.combo_last, 
											'');
		self.verlast := verlast;

	isAddrExpressionFound := if(ischase AND le.addr_type ='P', TRUE,FALSE);

	veraddr := Map(ischase AND le.addr_type ='P' => '', //for chase, if po box matches iid or chase pio2 logic then we blank out
											le.combo_addrcount>0 => Risk_Indicators.MOD_AddressClean.street_address('',le.combo_prim_range,
														le.combo_predir,le.combo_prim_name,le.combo_suffix,le.combo_postdir,le.combo_unit_desig,le.combo_sec_range),
											'');	
	SELF.veraddr := veraddr;	
  boolean chase_expressions := if(isFirstExpressionFound or isLastExpressionFound or isAddrExpressionFound, TRUE, FALSE);

	// clean the verified address to get the delivery point barcode information from the cleaner
	clean_ver_address := risk_indicators.MOD_AddressClean.clean_addr( veraddr, le.combo_city, le.combo_state, le.combo_zip ) ;
	// don't reference the clean fields unless the option to IncludeDPBC is turned on
	ver_zip5 := if(IncludeDPBC, clean_ver_address[117..121], le.combo_zip[1..5]);
	ver_zip4 := if(IncludeDPBC, clean_ver_address[122..125], le.combo_zip[6..9]);
	// delivery point barcode = zip5 + zip5 + barcode + check_digit
	ver_dpbc := ver_zip5 + ver_zip4 + clean_ver_address[136..138];  // include the 2 character code and 1 character check_digit
	
	// parsed verified address
	SELF.VerPrimRange := Map(ischase AND veraddr = '' => '',
													 le.combo_addrcount>0 => le.combo_prim_range,
													 '');
	
	SELF.VerPreDir := Map(ischase AND veraddr = '' => '',
												le.combo_addrcount>0 => le.combo_predir,
												'');
	
	SELF.VerPrimName := Map(ischase AND veraddr = '' => '',
													le.combo_addrcount>0 => le.combo_prim_name,
													'');
	
	SELF.VerAddrSuffix := Map(ischase AND veraddr = '' => '',
													  le.combo_addrcount>0 => le.combo_suffix,
													  '');
	
	SELF.VerPostDir := Map(ischase AND veraddr = '' => '',
												 le.combo_addrcount>0 => le.combo_postdir,
												 '');
	
	SELF.VerUnitDesignation := Map(ischase AND veraddr = '' => '',
																 le.combo_addrcount>0 => le.combo_unit_desig,
																 '');
	
	SELF.VerSecRange := Map(ischase AND veraddr = '' => '',
													le.combo_addrcount>0 => le.combo_sec_range,
													'');
	//
	SELF.vercity := IF(le.combo_addrcount>0, le.combo_city, '');
	SELF.verstate := IF(le.combo_addrcount>0, le.combo_state, '');
	SELF.verzip := IF(le.combo_addrcount>0, ver_zip5, '');
	SELF.verzip4 := IF(le.combo_addrcount>0, ver_zip4, '');
	self.verDPBC := if(le.combo_addrcount>0 and IncludeDPBC and ver_zip4<>'', ver_DPBC, '');
	self.vercounty := if(le.combo_addrcount>0, le.combo_county, '');

	SELF.verdob := IF(le.combo_dobcount>0, le.combo_dob, '');
	SELF.verssn := IF(le.combo_ssncount>0 and le.combo_ssnscore between 90 and 100, le.combo_ssn, ''); // don't output ssn for verlevel=1, per Bug 182049
	SELF.verhphone := IF(le.combo_hphonecount>0, le.combo_hphone, '');
	
	SELF.verify_addr := IF(le.addrmultiple,'O','');
	SELF.verify_dob := IF(le.combo_dobcount>0,'Y','N');
	//new for Emerging Identities - a fake DID means we verified first, last and SSN in getDIDprepOutput so set NAS to 9
	NAS_summary1 := If(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, 9, If(ischase and chase_expressions, Risk_Indicators.iid_constants.Get_chase_NAS_NAP(verfirst, verlast, veraddr, le.socsverlevel), le.socsverlevel)); 
	SELF.NAS_summary := NAS_summary1;
	
	NAP_summary1 := if(ischase and chase_expressions, Risk_Indicators.iid_constants.Get_chase_NAS_NAP(verfirst, verlast, veraddr, le.phoneverlevel),le.phoneverlevel);								
	SELF.NAP_summary := NAP_summary1;
	
	SELF.NAP_Type    := le.nap_type;
	SELF.NAP_Status  := le.nap_status;
	
	SELF.valid_ssn := IF(le.socllowissue != '', 'G', '');
	
	SELF.corrected_lname := le.correctlast;
	SELF.corrected_dob := le.correctdob;
	SELF.corrected_phone := le.correcthphone;
	SELF.corrected_ssn := le.correctssn;
	SELF.corrected_address := le.correctaddr;
	// parsed corrected address - if correctaddr is populated, it will always be the same as verified address, don't clean le.correctaddr
	haveCorrected := le.correctaddr<>'';
	SELF.CorrectedPrimRange := if(haveCorrected, le.combo_prim_range, '');
	SELF.CorrectedPreDir := if(haveCorrected, le.combo_predir, '');
	SELF.CorrectedPrimName := if(haveCorrected, le.combo_prim_name, '');
	SELF.CorrectedAddrSuffix := if(haveCorrected, le.combo_suffix, '');
	SELF.CorrectedPostDir := if(haveCorrected, le.combo_postdir, '');
	SELF.CorrectedUnitDesignation := if(haveCorrected, le.combo_unit_desig, '');
	SELF.CorrectedSecRange := if(haveCorrected, le.combo_sec_range, '');
	//
	SELF.area_code_split := if(le.areacodesplitflag='Y', le.altareacode, '');
	SELF.area_code_split_date := if(le.areacodesplitflag='Y', le.areacodesplitdate, '');
	
	SELF.additional_score1 := 0;
	SELF.additional_score2 := 0;
	
	SELF.phone_fname := le.dirsfirst;
	SELF.phone_lname := le.dirslast;
	SELF.phone_address := Risk_Indicators.MOD_AddressClean.street_address('',le.dirs_prim_range,le.dirs_predir,le.dirs_prim_name,
											le.dirs_suffix,le.dirs_postdir,le.dirs_unit_desig,le.dirs_sec_range);
	// parsed phone address
	SELF.PhonePrimRange := le.dirs_prim_range;
	SELF.PhonePreDir := le.dirs_predir;
	SELF.PhonePrimName := le.dirs_prim_name;
	SELF.PhoneAddrSuffix := le.dirs_suffix;
	SELF.PhonePostDir := le.dirs_postdir;
	SELF.PhoneUnitDesignation := le.dirs_unit_desig;
	SELF.PhoneSecRange := le.dirs_sec_range;
	//
	SELF.phone_city := le.dirscity;
	SELF.phone_st := le.dirsstate;
	SELF.phone_zip := le.dirszip;
	
	SELF.name_addr_phone := MAP(le.phonever_type='U' => le.utiliphone,
						   le.phonever_type='A' => le.dirsaddr_phone,  
						   le.phoneaddr_phonecount >= le.utiliaddr_phonecount => le.dirsaddr_phone,
						   le.utiliphone);
	
	SELF.ssa_date_first := le.socllowissue;
	SELF.ssa_date_last := le.soclhighissue;
	SELF.ssa_state := le.soclstate;
	SELF.ssa_state_name := Codes.GENERAL.STATE_LONG(le.soclstate);
	
	SELF.current_fname := le.verfirst;
	SELF.current_lname := le.verlast;
	
	addr1 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range, le.chronopredir, 
										   le.chronoprim_name, le.chronosuffix,
										   le.chronopostdir, le.chronounit_desig, le.chronosec_range);
	addr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range2, le.chronopredir2, 
										   le.chronoprim_name2, le.chronosuffix2,
										   le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2);
	addr3 := Risk_Indicators.MOD_AddressClean.street_address('',le.chronoprim_range3, le.chronopredir3, 
										   le.chronoprim_name3, le.chronosuffix3,
										   le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3);
	
	// clean the chrono address1 to get the delivery point barcode information from the cleaner
	clean_chrono_address1 := risk_indicators.MOD_AddressClean.clean_addr( addr1, le.chronocity, le.chronostate, le.chronozip ) ;
	// don't reference the clean fields unless the option to IncludeDPBC is turned on
	chrono_zipz5_1 := if(IncludeDPBC, clean_chrono_address1[117..121], le.chronozip);
	chrono_zip4_1 := if(IncludeDPBC, clean_chrono_address1[122..125], le.chronozip4);
	// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
	chrono1_dpbc := if(IncludeDPBC and chrono_zip4_1<>'', chrono_zipz5_1 + chrono_zip4_1 + clean_chrono_address1[136..138], '');  // include the 2 character code and 1 character check_digit
	
	
	// clean the chrono address2 to get the delivery point barcode information from the cleaner
	clean_chrono_address2 := risk_indicators.MOD_AddressClean.clean_addr( addr2, le.chronocity2, le.chronostate2, le.chronozip2 ) ;
	// don't reference the clean fields unless the option to IncludeDPBC is turned on
	chrono_zipz5_2 := if(IncludeDPBC, clean_chrono_address2[117..121], le.chronozip2);
	chrono_zip4_2 := if(IncludeDPBC, clean_chrono_address2[122..125], le.chronozip4_2);
	// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
	chrono2_dpbc := if(IncludeDPBC and chrono_zip4_2<>'',chrono_zipz5_2 + chrono_zip4_2 + clean_chrono_address2[136..138], '');  // include the 2 character code and 1 character check_digit
	
	// clean the chrono address3 to get the delivery point barcode information from the cleaner
	clean_chrono_address3 := risk_indicators.MOD_AddressClean.clean_addr( addr3, le.chronocity3, le.chronostate3, le.chronozip3 ) ;
	// don't reference the clean fields unless the option to IncludeDPBC is turned on
	chrono_zipz5_3 := if(IncludeDPBC, clean_chrono_address3[117..121], le.chronozip3);
	chrono_zip4_3 := if(IncludeDPBC, clean_chrono_address3[122..125], le.chronozip4_3);
	// delivery point barcode = zip5 + zip5 + barcode[136..137] + check_digit[138]
	chrono3_dpbc := if(IncludeDPBC and chrono_zip4_3<>'',chrono_zipz5_3 + chrono_zip4_3 + clean_chrono_address3[136..138], '');  // include the 2 character code and 1 character check_digit
	
	
	Chronology := DATASET([{1, addr1, le.chronoprim_range, le.chronopredir, le.chronoprim_name, le.chronosuffix, le.chronopostdir, le.chronounit_desig, le.chronosec_range, 
										le.chronocity, le.chronostate, le.chronozip, le.chronozip4, le.chronophone, le.chronodate_first, le.chronodate_last, le.chronoaddr_isbest, if(IncludeDPBC,chrono1_dpbc,'')},
									{2, addr2, le.chronoprim_range2, le.chronopredir2, le.chronoprim_name2, le.chronosuffix2, le.chronopostdir2, le.chronounit_desig2, le.chronosec_range2, 
											le.chronocity2, le.chronostate2, le.chronozip2, le.chronozip4_2, le.chronophone2, le.chronodate_first2, le.chronodate_last2, le.chronoaddr_isbest2, if(IncludeDPBC,chrono2_dpbc,'')},
									{3, addr3, le.chronoprim_range3, le.chronopredir3, le.chronoprim_name3, le.chronosuffix3, le.chronopostdir3, le.chronounit_desig3, le.chronosec_range3, 
											le.chronocity3, le.chronostate3, le.chronozip3, le.chronozip4_3, le.chronophone3, le.chronodate_first3, le.chronodate_last3, le.chronoaddr_isbest3, if(IncludeDPBC,chrono3_dpbc,'')}], 
									Risk_Indicators.Layout_AddressHistory);
	self.chronology := chronology(Address<>'');
	
	SELF.Additional_Lname := if(le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match, DATASET([{le.altfirst,le.altlast,le.altlast_date},
							    {le.altfirst2,le.altlast2,le.altlast_date2},
							    {le.altfirst3,le.altlast3,le.altlast_date3}], Risk_Indicators.Layout_LastNames), 
								dataset([], Risk_Indicators.Layout_LastNames));

	SELF.Watchlist_Table := le.watchlist_table;
	SELF.Watchlist_program :=le.watchlist_program;
	SELF.Watchlist_Record_Number := le.Watchlist_Record_Number;
	SELF.Watchlist_fname := le.Watchlist_fname;
	SELF.Watchlist_lname := le.Watchlist_lname; 
	SELF.Watchlist_address := le.Watchlist_address;
	SELF.WatchlistPrimRange := le.WatchlistPrimRange;
	SELF.WatchlistPreDir := le.WatchlistPreDir;
	SELF.WatchlistPrimName := le.WatchlistPrimName;
	SELF.WatchlistAddrSuffix := le.WatchlistAddrSuffix;
	SELF.WatchlistPostDir := le.WatchlistPostDir;
	SELF.WatchlistUnitDesignation := le.WatchlistUnitDesignation;
	SELF.WatchlistSecRange := le.WatchlistSecRange;
	SELF.Watchlist_city := le.Watchlist_city;
	SELF.Watchlist_state := le.Watchlist_state;
	SELF.Watchlist_zip := le.Watchlist_zip;
	SELF.Watchlist_contry := le.Watchlist_contry;
	SELF.Watchlist_Entity_Name := le.Watchlist_Entity_Name;

	SELF.fua := if(ischase and chase_expressions, risk_indicators.getActionCodes(le,4, NAS_summary1, NAP_summary1, ac_settings := actioncode_settings),risk_indicators.getActionCodes(le,4, SELF.NAS_summary, SELF.NAP_summary, ac_settings := actioncode_settings /*, rc*/));
	
	cvi_temp := MAP(ischase and chase_expressions => risk_indicators.cviScoreV1(NAP_summary1,NAS_summary1,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI),
									ischase => risk_indicators.cviScoreV1(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI),
										actualIIDVersion=0 => risk_indicators.cviScore(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,OFAC),	
										risk_indicators.cviScoreV1(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI));
		//need two chase checks here because chase would like their model returned in the normal CVI slot even though it is a custom model call. one for Custom model with modification, and one without.																		
									
	isCodeDI := risk_indicators.rcSet.isCodeDI(le.DIDdeceased) and actualIIDVersion=1;
	
	SELF.CVI := map(	IncludeMSoverride and risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months) and (integer)cvi_temp > 10 => '10',
							IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(le.addr_type) and (integer)cvi_temp > 10 => '10',
							IncludeCLoverride and risk_indicators.rcSet.isCodeCL(le.ssn, le.bestSSN, le.socsverlevel, le.combo_ssn) and (integer)cvi_temp > 10 => '10',
							IncludeMIoverride AND risk_indicators.rcSet.isCodeMI(le.adls_per_ssn_seen_18months) and (INTEGER)cvi_temp > 10 and actualIIDVersion=1 => '10',
							isCodeDI AND (INTEGER)cvi_temp > 10 => '10',
							cvi_temp);
	
	
	self.verdl := le.verified_dl;
		
	self.SubjectSSNCount := if(risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months), (string)le.ssns_per_adl_seen_18months, '');

	self.age := if (le.age = '***','',le.age);
	
	self.ssn := r.ssn;	// get back the original input (4 byte input could be overwritten in IIDCommon)
	self.dob := r.dob;	// get back the original input (dob can be blanked out if not 8 bytes)
	
	// if DID is flagged as deceased, use that information otherwise if ssn is verified and flagged as deceased, return the information about the deceased SSN
	ssn_verified := le.socsverlevel IN risk_indicators.iid_constants.ssn_name_match;
	isCode02 := risk_indicators.rcSet.isCode02(le.decsflag);

	self.deceasedDate := MAP(	ssn_verified and isCode02 => if(le.deceasedDate=0, '', (string)le.deceasedDate),
														isCodeDI => if(le.DIDdeceasedDate=0, '', (STRING)le.DIDdeceasedDate),
														
														'');
	self.deceasedDOB := MAP(ssn_verified and isCode02 => if(le.deceasedDOB=0, '', (string)le.deceasedDOB),
													isCodeDI => if(le.DIDdeceasedDOB=0, '', (STRING)le.DIDdeceasedDOB),
													'');
													
	self.deceasedFirst := MAP( ssn_verified and isCode02 => le.deceasedFirst,
														isCodeDI => le.DIDdeceasedFirst,
														'');
	self.deceasedLast := MAP(	ssn_verified and isCode02 => le.deceasedLast,
														isCodeDI => le.DIDdeceasedLast,
														'');
	
	risk_indicators.mac_add_sequence(le.watchlists, watchlists_with_seq);
	self.watchlists := watchlists_with_seq;
	
	reasoncode_settings_chase := dataset([{IsInstantID, actualIIDVersion, EnableEmergingID, '', ischase, isFirstExpressionFound, isLastExpressionFound, isAddrExpressionFound}],riskwise.layouts.reasoncode_settings);

	// add a sequence number to the reason codes for sorting in XML
	risk_indicators.mac_add_sequence(risk_indicators.reasonCodes(le, NumReturnCodes, reasoncode_settings), reasons_with_seq);
	risk_indicators.mac_add_sequence(risk_indicators.reasonCodes(le, NumReturnCodes, reasoncode_settings_chase), reason_with_seq_chase);

	self.ri := if(ischase and chase_expressions, reason_with_seq_chase, reasons_with_seq);
		
	passportline := r.PassportUpperLine + r.PassportLowerLine;
	self.passportValidated := if(IntlIID.ValidationFunctions().passportValidation(passportline, r.dob[3..8], r.gender), 'Y','N');
	
	self.dobmatchlevel := le.dobmatchlevel;
	
	self.SSNFoundForLexID := le.bestssn<>'' and actualIIDVersion=1;	// is this correct?
	self.addressPOBox := (Risk_Indicators.rcSet.isCode12(le.addr_type) or Risk_Indicators.rcSet.isCodePO(le.zipclass)) and actualIIDVersion=1;
	self.addressCMRA := (le.hrisksic in risk_indicators.iid_constants.setCRMA or le.ADVODropIndicator='C') and actualIIDVersion=1;
	
	custom_cvi_temp := MAP(ischase and chase_expressions => risk_indicators.cviScoreV1(NAP_summary1,NAS_summary1,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI,CustomCVIModelName_in),
													CustomCVIModelName_in <> '' => risk_indicators.cviScoreV1(le.phoneverlevel,le.socsverlevel,le,le.correctssn,le.correctaddr,le.correcthphone,'',veraddr,verlast,OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI,CustomCVIModelName_in),
													'');
	
	SELF.cviCustomScore := map(	IncludeMSoverride and risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months) and (integer)custom_cvi_temp > 10 => '10',
							IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(le.addr_type) and (integer)custom_cvi_temp > 10 => '10',
							IncludeCLoverride and risk_indicators.rcSet.isCodeCL(le.ssn, le.bestSSN, le.socsverlevel, le.combo_ssn) and (integer)custom_cvi_temp > 10 => '10',
							IncludeMIoverride AND risk_indicators.rcSet.isCodeMI(le.adls_per_ssn_seen_18months) and (INTEGER)custom_cvi_temp > 10 and actualIIDVersion=1 => '10',
							isCodeDI AND (INTEGER)custom_cvi_temp > 10 => '10',
							custom_cvi_temp);	
							

	
	self.InstantIDVersion := (string)actualIIDVersion;	
	
	//new for Emerging Identities
	isEmergingID := Risk_Indicators.rcSet.isCodeEI(le.DID, le.socsverlevel, le.socsvalid) AND EnableEmergingID;
	self.EmergingID := if(isEmergingID, true, false);  //a fake DID indicates an Emerging Identity	
	isReasonCodeSR	:= exists(reasons_with_seq(hri='SR')); //check if reason code 'SR' is set
	self.AddressSecondaryRangeMismatch := map(le.sec_range = '' and isReasonCodeSR															=> 'D',	 //no input sec range, but our data has one
																						le.sec_range <> '' and ~isReasonCodeSR and self.versecrange = ''	=> 'I',	 //input sec range, but our data does not have one
																						le.sec_range <> '' and isReasonCodeSR															=> 'M',	 //input sec range, but our data shows different sec range
																						le.sec_range = '' and ~isReasonCodeSR															=> 'N',	 //no input sec range and our data does not have one
																																																								 'V'); //input sec range matches our data
	self.StandardizedAddress := if(le.addr_status[1] in ['E',''], false, true); //check address status to see if it standardized successfully
	self.StreetAddress1 := address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.addr_suffix,le.postdir,le.unit_desig,le.sec_range);
	self.StreetAddress2 := address.Addr2FromComponents(le.p_city_name,le.st,le.z5);
	self.DID := if(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, 0, le.DID); //if DID is fake, zero it out
	
	SELF := le;
	SELF := [];  // default models and red flags datasets to empty
END;

formed_pre1 := join(ret, fs, left.seq = right.seq, format_out(LEFT, RIGHT));

//for Emerging Identities, return standardized county name
formed_pre := join(formed_pre1, census_data.Key_Fips2County, 
	keyed(left.st=right.state_code) and
	keyed(left.county=right.county_fips),
	transform(Layout_InstandID_NuGenExt, 
		self.CountyName := right.county_name,
		self := left),
		left outer, KEEP(1), ATMOST(500));

//Only get royalties for hitting the Insurance DL information if they are allowed to access the information
Boolean TrackInsuranceRoyalties := Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);
InsuranceRoyalties 	:= if(TrackInsuranceRoyalties, Royalty.RoyaltyFDNDLDATA.GetBatchRoyaltiesByAcctno(formed_pre, acctno, insurance_dl_used, TRUE));

// this section is all to include the fraud scores if the boolean is set to true
	clam := risk_indicators.Boca_Shell_Function(ret, gateways, DPPA_Purpose, GLB_Purpose, industry_class_value='UTILI', ln_branded_value,  
					true, false, false, true, bsversion, DataRestriction := DataRestriction, DataPermission := DataPermission);

	ip_prep := project( fs, transform( riskwise.Layout_IPAI, self.ipaddr := left.ip_addr, self.seq := left.seq ) );
	ip_out  := risk_indicators.getNetAcuity( ip_prep, gateways, DPPA_Purpose, GLB_Purpose);

	bs_with_ip := record
		risk_indicators.Layout_Boca_Shell bs;
		riskwise.Layout_IP2O ip;
	end;

	clam_ip := join( clam, ip_out, left.seq=right.seq,
		transform( bs_with_ip,
			self.bs := left,
			self.ip := right
		),
		left outer
	);

	formedWithIP := join(formed_pre, clam_ip, (unsigned)left.seq = right.ip.seq,
										transform(Layout_InstandID_NuGenExt,
											self.Royalty_NAG := Royalty.RoyaltyNetAcuity.GetCount(right.ip.ipaddr, right.ip.iptype);
											SELF := left;
											));
	// Add model name to this list if clam_ip/netacuity is used. 
	boolean	trackNetacuityRoyalties := IncludeFraudScores and model_name IN ['fp3710_0', 'fp3710_9', 'fp1109_0', 'fp1109_9', 'fp1307_2', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'];
	// Joining with clam_ip will trigger a gateway call to NetAcuity. Must do it only if the gateway is really to be used further down.
	formed := if(trackNetacuityRoyalties, formedWithIP, formed_pre);

// 3 original fraud defender models

	m1 := Models.FD3510_0_0(clam, Include_Ofac,isFCRA, inCalif, fdReasonsWith38, nugen, Include_Additional_watchlists);
	m2 := Models.FD5510_0_0(clam, Include_Ofac,nugen, Include_Additional_watchlists);
	m3 := Models.FD9510_0_0(clam, Include_Ofac,nugen, Include_Additional_watchlists);

// fraudpoint version 1	
	fp3710_0 := project(models.FP3710_0_0( clam_ip, 4, false), transform(models.layouts.layout_fp1109, self := left, self := []));	
	fp3710_9 := project(models.FP3710_0_0( clam_ip, 4, true), transform(models.layouts.layout_fp1109, self := left, self := []));

// fraudpoint version 2
	fp1109_0 := models.FP1109_0_0(clam_ip, 6, false);
	fp1109_9 := models.FP1109_0_0(clam_ip, 6, true);
	fp1303_2 := models.FP1303_2_0(ungroup(clam), 6, false);
	fp1307_2 := Models.FP1307_2_0(clam_ip, 6, false);
	
// fraudpoint version 3
	fp31505_0 		:= Models.FP31505_0_Base( clam_ip, 6, false); 
	fp3fdn1505_0 	:= Models.FP3FDN1505_0_Base( clam_ip, 6, false); 
	fp31505_9 		:= Models.FP31505_0_Base( clam_ip, 6, true); 
	fp3fdn1505_9 	:= Models.FP3FDN1505_0_Base( clam_ip, 6, true); 
	
	mfraudpoint :=map(
		model_name = 'fp3710_0' => fp3710_0,
		model_name = 'fp3710_9' => fp3710_9,
		model_name = 'fp1109_0' => fp1109_0,
		model_name = 'fp1109_9' => fp1109_9,
		model_name = 'fp1307_2' => join(fp1109_0, fp1307_2,
																left.seq = right.seq,
																transform(models.layouts.layout_fp1109, 
																		self.StolenIdentityIndex := right.StolenIdentityIndex,
																		self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
																		self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
																		self.VulnerableVictimIndex := right.VulnerableVictimIndex,
																		self.FriendlyFraudIndex := right.FriendlyFraudIndex,
																		self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
																		self := left)),
		model_name = 'fp1303_2' =>  project(fp1303_2, transform(models.layouts.layout_fp1109, self := left, self := [])),
		model_name = 'fp31505_0' 		=> fp31505_0,
		model_name = 'fp3fdn1505_0' => fp3fdn1505_0,
		model_name = 'fp31505_9' 		=> fp31505_9,
		model_name = 'fp3fdn1505_9' => fp3fdn1505_9,
		model_name = ''         => dataset( [], models.layouts.layout_fp1109 ),
		fail(models.layouts.layout_fp1109, 'Invalid fraud version/model input combination')
	);

	layout_model_batch_fp2 := record
		Models.Layout_Model_Batch;
		string1 StolenIdentityIndex := '';
		string1 SyntheticIdentityIndex := '';
		string1 ManipulatedIdentityIndex := '';
		string1 VulnerableVictimIndex := '';
		string1 FriendlyFraudIndex := '';
		string1 SuspiciousActivityIndex := '';
	end;
	
	layout_model_batch_fp2 toModelBatch( mfraudpoint le, fs ri ) := TRANSFORM
		self.seq    := le.seq;
		self.acctno := ri.acctno;
		self.score_0_to_999 := le.score;
		self.score_10_to_50:='';
		self.score_10_to_90:='';
		self.PRI_1      := le.ri[1].hri;
		self.PRI_Desc_1 := le.ri[1].desc;
		self.PRI_2      := le.ri[2].hri;
		self.PRI_Desc_2 := le.ri[2].desc;
		self.PRI_3      := le.ri[3].hri;
		self.PRI_Desc_3 := le.ri[3].desc;
		self.PRI_4      := le.ri[4].hri;
		self.PRI_Desc_4 := le.ri[4].desc;
		self.PRI_5      := le.ri[5].hri;
		self.PRI_Desc_5 := le.ri[5].desc;
		self.PRI_6      := le.ri[6].hri;
		self.PRI_Desc_6 := le.ri[6].desc;
		self := le;
	END;
	mfraudpoint_batch := join( mfraudpoint, fs, left.seq=right.seq, toModelBatch(LEFT,RIGHT), left outer, keep(1) );

	layout_model_batch_fp2 tf1(formed l, m1 r) := transform
		self.seq := l.seq;
		self.acctno := l.acctNo;
		self.score_0_to_999 := r.score;
		self.score_10_to_50 := '';
		self.score_10_to_90 := '';
		self.PRI_1 := if(r.ri[1].hri <> '00', r.ri[1].hri, '');
		self.PRI_Desc_1 := r.ri[1].desc;
		self.PRI_2 := if(r.ri[2].hri <> '00', r.ri[2].hri, '');
		self.PRI_Desc_2 := r.ri[2].desc;
		self.PRI_3 := if(r.ri[3].hri <> '00', r.ri[3].hri, '');
		self.PRI_Desc_3 := r.ri[3].desc;
		self.PRI_4 := if(r.ri[4].hri <> '00', r.ri[4].hri, '');
		self.PRI_Desc_4 := r.ri[4].desc;
		// Don't seem to need the reason codes 5 and 6 here because these models only have 4 reason codes
	end;
	j1 := join(formed, m1, left.seq = right.seq, tf1(left,right));

	layout_model_batch_fp2 tf2(layout_model_batch_fp2 l, m2 r) := transform
		self.score_10_to_50 := intformat((integer)r.score, 3, 1);
		self := l;
	end;
	j2 := join(j1, m2, left.seq = right.seq, tf2(left,right));

	layout_model_batch_fp2 tf3(layout_model_batch_fp2 l, m3 r) := transform
		self.score_10_to_90 := intformat((integer)r.score, 3, 1);
		self := l;
	end;
	j3 := join(j2, m3, left.seq = right.seq, tf3(left,right));
// end of fraud score logic

scores := map(
	not IncludeFraudScores => dataset([], layout_model_batch_fp2),
	model_name = ''        => j3,
	mfraudpoint_batch
);
	
// scores := if(IncludeFraudScores, j3, dataset([], models.Layout_Model_Batch));

string6 cast_date(unsigned3 dt) := function
	date_field := if(dt=0, '', (string6)dt);
	return date_field;
end;

risk_indicators.Layout_InstantID_NuGen_Denorm into_final(formed L, scores R) := transform
	self.hri_1 := if (count(l.ri) >= 1, L.ri[1].hri, '');
	self.hri_desc_1 := if (count(l.ri) >= 1, L.ri[1].desc, '');
	self.hri_2 := if (count(l.ri) >= 2, L.ri[2].hri, '');
	self.hri_desc_2 := if (count(l.ri) >= 2, L.ri[2].desc, '');
	self.hri_3 := if (count(l.ri) >= 3, L.ri[3].hri, '');
	self.hri_desc_3 := if (count(l.ri) >= 3, L.ri[3].desc, '');
	self.hri_4 := if (count(l.ri) >= 4, L.ri[4].hri, '');
	self.hri_desc_4 := if (count(l.ri) >= 4, L.ri[4].desc, '');
	self.hri_5 := if (count(l.ri) >= 5, L.ri[5].hri, '');
	self.hri_desc_5 := if (count(l.ri) >= 5, L.ri[5].desc, '');
	self.hri_6 := if (count(l.ri) >= 6, L.ri[6].hri, '');
	self.hri_desc_6 := if (count(l.ri) >= 6, L.ri[6].desc, '');
	self.hri_7 := if (count(l.ri) >= 7, L.ri[7].hri, '');
	self.hri_desc_7 := if (count(l.ri) >= 7, L.ri[7].desc, '');
	self.hri_8 := if (count(l.ri) >= 8, L.ri[8].hri, '');
	self.hri_desc_8 := if (count(l.ri) >= 8, L.ri[8].desc, '');
	self.hri_9 := if (count(l.ri) >= 9, L.ri[9].hri, '');
	self.hri_desc_9 := if (count(l.ri) >= 9, L.ri[9].desc, '');
	self.hri_10 := if (count(l.ri) >= 10, L.ri[10].hri, '');
	self.hri_desc_10 := if (count(l.ri) >= 10, L.ri[10].desc, '');
	self.hri_11 := if (count(l.ri) >= 11, L.ri[11].hri, '');
	self.hri_desc_11 := if (count(l.ri) >= 11, L.ri[11].desc, '');
	self.hri_12 := if (count(l.ri) >= 12, L.ri[12].hri, '');
	self.hri_desc_12 := if (count(l.ri) >= 12, L.ri[12].desc, '');
	self.hri_13 := if (count(l.ri) >= 13, L.ri[13].hri, '');
	self.hri_desc_13 := if (count(l.ri) >= 13, L.ri[13].desc, '');
	self.hri_14 := if (count(l.ri) >= 14, L.ri[14].hri, '');
	self.hri_desc_14 := if (count(l.ri) >= 14, L.ri[14].desc, '');
	self.hri_15 := if (count(l.ri) >= 15, L.ri[15].hri, '');
	self.hri_desc_15 := if (count(l.ri) >= 15, L.ri[15].desc, '');
	self.hri_16 := if (count(l.ri) >= 16, L.ri[16].hri, '');
	self.hri_desc_16 := if (count(l.ri) >= 16, L.ri[16].desc, '');
	self.hri_17 := if (count(l.ri) >= 17, L.ri[17].hri, '');
	self.hri_desc_17 := if (count(l.ri) >= 17, L.ri[17].desc, '');
	self.hri_18 := if (count(l.ri) >= 18, L.ri[18].hri, '');
	self.hri_desc_18 := if (count(l.ri) >= 18, L.ri[18].desc, '');
	self.hri_19 := if (count(l.ri) >= 19, L.ri[19].hri, '');
	self.hri_desc_19 := if (count(l.ri) >= 19, L.ri[19].desc, '');
	self.hri_20 := if (count(l.ri) >= 20, L.ri[20].hri, '');
	self.hri_desc_20 := if (count(l.ri) >= 20, L.ri[20].desc, '');
	self.fua_1 := if (count(l.fua) >= 1, L.fua[1].hri, '');
	self.fua_desc_1 := if (count(l.fua) >= 1, L.fua[1].desc, '');
	self.fua_2 := if (count(l.fua) >= 2, L.fua[2].hri, '');
	self.fua_desc_2 := if (count(l.fua) >= 2, L.fua[2].desc, '');
	self.fua_3 := if (count(l.fua) >= 3, L.fua[3].hri, '');
	self.fua_desc_3 := if (count(l.fua) >= 3, L.fua[3].desc, '');
	self.fua_4 := if (count(l.fua) >= 4, L.fua[4].hri, '');
	self.fua_desc_4 := if (count(l.fua) >= 4, L.fua[4].desc, '');
	self.additional_fname_1 := if (count(L.additional_lname) >= 1, l.additional_lname[1].fname1,'');
	self.additional_lname_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].lname1, '');
	self.additional_lname_date_last_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].date_last, '');
	self.additional_fname_2 := if (count(L.additional_lname) >= 2, l.additional_lname[2].fname1,'');
	self.additional_lname_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].lname1, '');
	self.additional_lname_date_last_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].date_last, '');
	self.additional_fname_3 := if (count(L.additional_lname) >= 3, l.additional_lname[3].fname1,'');
	self.additional_lname_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].lname1, '');
	self.additional_lname_date_last_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].date_last, '');
	self.chron_address_1 := if (count(L.chronology) >= 1, L.chronology[1].address, '');
	// parsed chronology address 1
	self.ChronPrimRange1 := if (count(L.chronology) >= 1, L.chronology[1].PrimRange, '');
	self.ChronPreDir1 := if (count(L.chronology) >= 1, L.chronology[1].PreDir, '');
	self.ChronPrimName1 := if (count(L.chronology) >= 1, L.chronology[1].PrimName, '');
	self.ChronAddrSuffix1 := if (count(L.chronology) >= 1, L.chronology[1].AddrSuffix, '');
	self.ChronPostDir1 := if (count(L.chronology) >= 1, L.chronology[1].PostDir, '');
	self.ChronUnitDesignation1 := if (count(L.chronology) >= 1, L.chronology[1].UnitDesignation, '');
	self.ChronSecRange1 := if (count(L.chronology) >= 1, L.chronology[1].SecRange, '');
	self.chron_city_1 := if (count(L.chronology) >= 1, L.chronology[1].city, '');
	self.chron_st_1 := if (count(L.chronology) >= 1, L.chronology[1].st, '');
	self.chron_zip_1 := if (count(L.chronology) >= 1, L.chronology[1].zip, '');
	self.chron_zip4_1 := if (count(L.chronology) >= 1, L.chronology[1].zip4, '');
	self.chron_dpbc_1 := if (count(L.chronology) >= 1, L.chronology[1].dpbc, '');
	self.chron_phone_1 := if (count(L.chronology) >= 1, L.chronology[1].phone, '');
	self.Chron_dt_first_seen_1 := if (count(L.chronology) >= 1, cast_date(L.chronology[1].dt_first_seen), '');
	self.Chron_dt_last_seen_1 := if (count(L.chronology) >= 1, cast_date(L.chronology[1].dt_last_seen), '');
	self.chron_address_2 := if (count(L.chronology) >= 2, L.chronology[2].address, '');
	// parsed chronology address 2
	self.ChronPrimRange2 := if (count(L.chronology) >= 2, L.chronology[2].PrimRange, '');
	self.ChronPreDir2 := if (count(L.chronology) >= 2, L.chronology[2].PreDir, '');
	self.ChronPrimName2 := if (count(L.chronology) >= 2, L.chronology[2].PrimName, '');
	self.ChronAddrSuffix2 := if (count(L.chronology) >= 2, L.chronology[2].AddrSuffix, '');
	self.ChronPostDir2 := if (count(L.chronology) >= 2, L.chronology[2].PostDir, '');
	self.ChronUnitDesignation2 := if (count(L.chronology) >= 2, L.chronology[2].UnitDesignation, '');
	self.ChronSecRange2 := if (count(L.chronology) >= 2, L.chronology[2].SecRange, '');
	self.chron_city_2 := if (count(L.chronology) >= 2, L.chronology[2].city, '');
	self.chron_st_2 := if (count(L.chronology) >= 2, L.chronology[2].st, '');
	self.chron_zip_2 := if (count(L.chronology) >= 2, L.chronology[2].zip, '');
	self.chron_zip4_2 := if (count(L.chronology) >= 2, L.chronology[2].zip4, '');
	self.chron_dpbc_2 := if (count(L.chronology) >= 2, L.chronology[2].dpbc, '');
	self.chron_phone_2 := if (count(L.chronology) >= 2, L.chronology[2].phone, '');
	self.Chron_dt_first_seen_2 := if (count(L.chronology) >= 2, cast_date(L.chronology[2].dt_first_seen), '');
	self.Chron_dt_last_seen_2 := if (count(L.chronology) >= 2, cast_date(L.chronology[2].dt_last_seen), '');
	self.chron_address_3 := if (count(L.chronology) >= 3, L.chronology[3].address, '');
	// parsed chronology address 3
	self.ChronPrimRange3 := if (count(L.chronology) >= 3, L.chronology[3].PrimRange, '');
	self.ChronPreDir3 := if (count(L.chronology) >= 3, L.chronology[3].PreDir, '');
	self.ChronPrimName3 := if (count(L.chronology) >= 3, L.chronology[3].PrimName, '');
	self.ChronAddrSuffix3 := if (count(L.chronology) >= 3, L.chronology[3].AddrSuffix, '');
	self.ChronPostDir3 := if (count(L.chronology) >= 3, L.chronology[3].PostDir, '');
	self.ChronUnitDesignation3 := if (count(L.chronology) >= 3, L.chronology[3].UnitDesignation, '');
	self.ChronSecRange3 := if (count(L.chronology) >= 3, L.chronology[3].SecRange, '');
	self.chron_city_3 := if (count(L.chronology) >= 3, L.chronology[3].city, '');
	self.chron_st_3 := if (count(L.chronology) >= 3, L.chronology[3].st, '');
	self.chron_zip_3 := if (count(L.chronology) >= 3, L.chronology[3].zip, '');
	self.chron_zip4_3 := if (count(L.chronology) >= 3, L.chronology[3].zip4, '');
	self.chron_dpbc_3 := if (count(L.chronology) >= 3, L.chronology[3].dpbc, '');
	self.chron_phone_3 := if (count(L.chronology) >= 3, L.chronology[3].phone, '');
	self.Chron_dt_first_seen_3 := if (count(L.chronology) >= 3, cast_date(L.chronology[3].dt_first_seen), '');
	self.Chron_dt_last_seen_3 := if (count(L.chronology) >= 3, cast_date(L.chronology[3].dt_last_seen), '');
		
	self.did := intformat(L.did,12,1);
	self.transaction_id := intformat(L.transaction_id, 12, 1);
	self.nas_summary := (string)L.nas_summary;
	self.nap_summary := (string)L.nap_summary;
	self.CVI := (String)L.cvi;
	self.additional_score1 := (string)L.additional_score1;
	self.additional_score2 := (string)L.additional_score2;
	self.seq := intformat(L.seq,12,1);
	self.age := if (l.age = '***', '', L.age);	
	
	self.fd_score1 := r.score_0_to_999;
	self.fd_score2 := r.score_10_to_50;
	self.fd_score3 := r.score_10_to_90;
	self.fd_Reason1 := r.pri_1;
	self.fd_Desc1 := r.pri_desc_1;
	self.fd_Reason2 := r.pri_2;
	self.fd_Desc2 := r.pri_desc_2;
	self.fd_Reason3 := r.pri_3;
	self.fd_Desc3 := r.pri_desc_3;
	self.fd_Reason4 := r.pri_4;
	self.fd_Desc4 := r.pri_desc_4;
	self.fd_Reason5 := r.pri_5;
	self.fd_Desc5 := r.pri_desc_5;
	self.fd_Reason6 := r.pri_6;
	self.fd_Desc6 := r.pri_desc_6;
	self.StolenIdentityIndex        := if(IncludeRiskIndices, r.StolenIdentityIndex, '');
	self.SyntheticIdentityIndex     := if(IncludeRiskIndices, r.SyntheticIdentityIndex, '');
	self.ManipulatedIdentityIndex   := if(IncludeRiskIndices, r.ManipulatedIdentityIndex, '');
	self.VulnerableVictimIndex      := if(IncludeRiskIndices, r.VulnerableVictimIndex, '');
	self.FriendlyFraudIndex         := if(IncludeRiskIndices, r.FriendlyFraudIndex, '');
	self.SuspiciousActivityIndex    := if(IncludeRiskIndices, r.SuspiciousActivityIndex, '');
	
	self.Chron_addr_1_isBest := if(l.chronology[1].isBestMatch, 'Y', 'N');
	self.Chron_addr_2_isBest := if(l.chronology[2].isBestMatch, 'Y', 'N');
	self.Chron_addr_3_isBest := if(l.chronology[3].isBestMatch, 'Y', 'N');
	
	SELF.Watchlist_Table_2 := l.watchlists[2].watchlist_table;
	SELF.Watchlist_program_2 :=l.watchlists[2].watchlist_program;
	SELF.Watchlist_Record_Number_2 := l.watchlists[2].watchlist_Record_Number;
	SELF.Watchlist_fname_2 := l.watchlists[2].watchlist_fname;
	SELF.Watchlist_lname_2 := l.watchlists[2].watchlist_lname;
	SELF.Watchlist_address_2 := l.watchlists[2].watchlist_address;
	// parsed watchlist address
	SELF.WatchlistPrimRange2 := l.watchlists[2].WatchlistPrimRange;
	SELF.WatchlistPreDir2 := l.watchlists[2].WatchlistPreDir;
	SELF.WatchlistPrimName2 := l.watchlists[2].WatchlistPrimName;
	SELF.WatchlistAddrSuffix2 := l.watchlists[2].WatchlistAddrSuffix;
	SELF.WatchlistPostDir2 := l.watchlists[2].WatchlistPostDir;
	SELF.WatchlistUnitDesignation2 := l.watchlists[2].WatchlistUnitDesignation;
	SELF.WatchlistSecRange2 := l.watchlists[2].WatchlistSecRange;
	SELF.Watchlist_city_2 := l.watchlists[2].watchlist_city;
	SELF.Watchlist_state_2 := l.watchlists[2].watchlist_state;
	SELF.Watchlist_zip_2 := l.watchlists[2].watchlist_zip;
	SELF.Watchlist_contry_2 := l.watchlists[2].watchlist_contry;
	SELF.Watchlist_Entity_Name_2 := l.watchlists[2].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_3 := l.watchlists[3].watchlist_table;
	SELF.Watchlist_program_3 :=l.watchlists[3].watchlist_program;
	SELF.Watchlist_Record_Number_3 := l.watchlists[3].watchlist_Record_Number;
	SELF.Watchlist_fname_3 := l.watchlists[3].watchlist_fname;
	SELF.Watchlist_lname_3 := l.watchlists[3].watchlist_lname;
	SELF.Watchlist_address_3 := l.watchlists[3].watchlist_address;
	// parsed watchlist address
	SELF.WatchlistPrimRange3 := l.watchlists[3].WatchlistPrimRange;
	SELF.WatchlistPreDir3 := l.watchlists[3].WatchlistPreDir;
	SELF.WatchlistPrimName3 := l.watchlists[3].WatchlistPrimName;
	SELF.WatchlistAddrSuffix3 := l.watchlists[3].WatchlistAddrSuffix;
	SELF.WatchlistPostDir3 := l.watchlists[3].WatchlistPostDir;
	SELF.WatchlistUnitDesignation3 := l.watchlists[3].WatchlistUnitDesignation;
	SELF.WatchlistSecRange3 := l.watchlists[3].WatchlistSecRange;
	SELF.Watchlist_city_3 := l.watchlists[3].watchlist_city;
	SELF.Watchlist_state_3 := l.watchlists[3].watchlist_state;
	SELF.Watchlist_zip_3 := l.watchlists[3].watchlist_zip;
	SELF.Watchlist_contry_3 := l.watchlists[3].watchlist_contry;
	SELF.Watchlist_Entity_Name_3 := l.watchlists[3].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_4 := l.watchlists[4].watchlist_table;
	SELF.Watchlist_program_4 :=l.watchlists[4].watchlist_program;
	SELF.Watchlist_Record_Number_4 := l.watchlists[4].watchlist_Record_Number;
	SELF.Watchlist_fname_4 := l.watchlists[4].watchlist_fname;
	SELF.Watchlist_lname_4 := l.watchlists[4].watchlist_lname;
	SELF.Watchlist_address_4 := l.watchlists[4].watchlist_address;
	// parsed watchlist address
	SELF.WatchlistPrimRange4 := l.watchlists[4].WatchlistPrimRange;
	SELF.WatchlistPreDir4 := l.watchlists[4].WatchlistPreDir;
	SELF.WatchlistPrimName4 := l.watchlists[4].WatchlistPrimName;
	SELF.WatchlistAddrSuffix4 := l.watchlists[4].WatchlistAddrSuffix;
	SELF.WatchlistPostDir4 := l.watchlists[4].WatchlistPostDir;
	SELF.WatchlistUnitDesignation4 := l.watchlists[4].WatchlistUnitDesignation;
	SELF.WatchlistSecRange4 := l.watchlists[4].WatchlistSecRange;
	SELF.Watchlist_city_4 := l.watchlists[4].watchlist_city;
	SELF.Watchlist_state_4 := l.watchlists[4].watchlist_state;
	SELF.Watchlist_zip_4 := l.watchlists[4].watchlist_zip;
	SELF.Watchlist_contry_4 := l.watchlists[4].watchlist_contry;
	SELF.Watchlist_Entity_Name_4 := l.watchlists[4].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_5 := l.watchlists[5].watchlist_table;
	SELF.Watchlist_program_5 :=l.watchlists[5].watchlist_program;
	SELF.Watchlist_Record_Number_5 := l.watchlists[5].watchlist_Record_Number;
	SELF.Watchlist_fname_5 := l.watchlists[5].watchlist_fname;
	SELF.Watchlist_lname_5 := l.watchlists[5].watchlist_lname;
	SELF.Watchlist_address_5 := l.watchlists[5].watchlist_address;
	// parsed watchlist address
	SELF.WatchlistPrimRange5 := l.watchlists[5].WatchlistPrimRange;
	SELF.WatchlistPreDir5 := l.watchlists[5].WatchlistPreDir;
	SELF.WatchlistPrimName5 := l.watchlists[5].WatchlistPrimName;
	SELF.WatchlistAddrSuffix5 := l.watchlists[5].WatchlistAddrSuffix;
	SELF.WatchlistPostDir5 := l.watchlists[5].WatchlistPostDir;
	SELF.WatchlistUnitDesignation5 := l.watchlists[5].WatchlistUnitDesignation;
	SELF.WatchlistSecRange5 := l.watchlists[5].WatchlistSecRange;
	SELF.Watchlist_city_5 := l.watchlists[5].watchlist_city;
	SELF.Watchlist_state_5 := l.watchlists[5].watchlist_state;
	SELF.Watchlist_zip_5 := l.watchlists[5].watchlist_zip;
	SELF.Watchlist_contry_5 := l.watchlists[5].watchlist_contry;
	SELF.Watchlist_Entity_Name_5 := l.watchlists[5].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_6 := l.watchlists[6].watchlist_table;
	SELF.Watchlist_program_6 :=l.watchlists[6].watchlist_program;
	SELF.Watchlist_Record_Number_6 := l.watchlists[6].watchlist_Record_Number;
	SELF.Watchlist_fname_6 := l.watchlists[6].watchlist_fname;
	SELF.Watchlist_lname_6 := l.watchlists[6].watchlist_lname;
	SELF.Watchlist_address_6 := l.watchlists[6].watchlist_address;
	SELF.Watchlist_city_6 := l.watchlists[6].watchlist_city;
	SELF.Watchlist_state_6 := l.watchlists[6].watchlist_state;
	SELF.Watchlist_zip_6 := l.watchlists[6].watchlist_zip;
	SELF.Watchlist_contry_6 := l.watchlists[6].watchlist_contry;
	SELF.Watchlist_Entity_Name_6 := l.watchlists[6].watchlist_Entity_Name;
	
	SELF.Watchlist_Table_7 := l.watchlists[7].watchlist_table;
	SELF.Watchlist_program_7 :=l.watchlists[7].watchlist_program;
	SELF.Watchlist_Record_Number_7 := l.watchlists[7].watchlist_Record_Number;
	SELF.Watchlist_fname_7 := l.watchlists[7].watchlist_fname;
	SELF.Watchlist_lname_7 := l.watchlists[7].watchlist_lname;
	SELF.Watchlist_address_7 := l.watchlists[7].watchlist_address;
	// parsed watchlist address
	SELF.WatchlistPrimRange7 := l.watchlists[7].WatchlistPrimRange;
	SELF.WatchlistPreDir7 := l.watchlists[7].WatchlistPreDir;
	SELF.WatchlistPrimName7 := l.watchlists[7].WatchlistPrimName;
	SELF.WatchlistAddrSuffix7 := l.watchlists[7].WatchlistAddrSuffix;
	SELF.WatchlistPostDir7 := l.watchlists[7].WatchlistPostDir;
	SELF.WatchlistUnitDesignation7 := l.watchlists[7].WatchlistUnitDesignation;
	SELF.WatchlistSecRange7 := l.watchlists[7].WatchlistSecRange;
	SELF.Watchlist_city_7 := l.watchlists[7].watchlist_city;
	SELF.Watchlist_state_7 := l.watchlists[7].watchlist_state;
	SELF.Watchlist_zip_7 := l.watchlists[7].watchlist_zip;
	SELF.Watchlist_contry_7 := l.watchlists[7].watchlist_contry;
	SELF.Watchlist_Entity_Name_7 := l.watchlists[7].watchlist_Entity_Name;
	
	self := L;
	self := []; // default red flag fields to blank
end;

iid_results := join(formed, scores, left.seq=right.seq, into_final(LEFT,right), left outer);

combined_layouts := record
	unsigned seq;
	riskwise.layouts.red_flags_online_layout;
	riskwise.layouts.red_flags_batch_layout;
end;
// TMS - put reasoncode-settings back in after aug 13 release
red_flags_ret := if(RedFlag_version<>0, risk_indicators.Red_Flags_Function(ret, reasoncode_settings), dataset([], combined_layouts) );

// output(red_flags_ret, named('red_flags_ret'));

with_red_flags := join(iid_results, red_flags_ret, (unsigned)left.seq=right.seq, 
												transform(risk_indicators.Layout_InstantID_NuGen_Denorm, 
												self.seq := left.seq,
												self.acctno := left.acctno,
												self := right,
												self := left),
												left outer);

just_red_flags := join(iid_results, red_flags_ret, (unsigned)left.seq=right.seq, 
												transform(risk_indicators.Layout_InstantID_NuGen_Denorm, 
												self.seq := left.seq,
												self.acctno := left.acctno,
												self := right,
												self := []), // blank out all other fields if RedFlagsOnly is selected
												left outer);												
final := if(RedFlagsOnly, just_red_flags, with_red_flags);
output(final,named('RESULTS')) ;

BOOLEAN  ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
dIPIn := PROJECT(fs,TRANSFORM(Royalty.RoyaltyNetAcuity.IPData,SELF.AcctNo := LEFT.AcctNo; SELF.IPAddr:=LEFT.ip_addr;));
dRoyaltiesByAcctno 	:= IF(trackNetacuityRoyalties, Royalty.RoyaltyNetAcuity.GetBatchRoyaltiesByAcctno(gateways, dIPIn, formed, TRUE));
dRoyalties 					:= Royalty.GetBatchRoyalties(dRoyaltiesByAcctno + InsuranceRoyalties, ReturnDetailedRoyalties);
output(dRoyalties,NAMED('RoyaltySet'));

endmacro;
// risk_indicators.InstantID_Batch();