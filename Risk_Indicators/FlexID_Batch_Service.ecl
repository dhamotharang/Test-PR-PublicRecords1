/*2016-05-23T23:45:58Z (Kevin Huls)
RQ-12730 EMerging Identities: fix syntax error populating UniqueID
*/
/*2016-05-19T21:10:22Z (Kevin Huls)
RQ-12730: Emerging Identities - per code review - blank out DID if fake
*/
/*2016-05-19T17:47:55Z (Kevin Huls)
RQ-12730: Emerging Identities
*/
/*--SOAP--
<message name="FlexID (aka IID Model)">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="33"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>	
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="Model" type="xsd:string"/>
	<part name="Targus" type="xsd:boolean"/>
	<part name="IncludeTargusE3220" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeCLOverride" type="xsd:boolean"/>

	<part name="ExactFirstNameMatch" type="xsd:boolean"/>
	<part name="ExactLastNameMatch" type="xsd:boolean"/>
	<part name="ExactFirstNameMatchAllowNicknames" type="xsd:boolean"/>
	<part name="ExactPhoneMatch" type="xsd:boolean"/>
	<part name="ExactSSNMatch" type="xsd:boolean"/>
	<part name="ExactDOBMatch" type="xsd:boolean"/>
	<part name="ExactAddrMatch" type="xsd:boolean"/>
	<part name="ExactDriverLicenseMatch" type="xsd:boolean"/>

	<part name="IncludeAllRiskIndicators" type="xsd:boolean"/>
	<part name="IncludeVerifiedElementSummary" type="xsd:boolean"/>
	<part name="IncludeDLverification" type="xsd:boolean"/>
	<part name="DOBMatchType" type="xsd:string"/>
	<part name="DOBMatchYearRadius" type="xsd:unsignedInt"/>

	<part name="IncludeRiskIndices" type="xsd:boolean"/>
	<part name="CustomCVIModelName" type="xsd:string"/>
	<part name="LastSeenThreshold" type="xsd:string"/>
	<part name="IncludeMIoverride" type="xsd:boolean"/>
	<part name="IncludeDOBinCVI" type="xsd:boolean"/>
	<part name="IncludeDriverLicenseInCVI" type="xsd:boolean"/>
	<part name="DisableInquiriesInCVI" type="xsd:boolean"/>
	<part name="IncludeVerifiedSSN" type="xsd:boolean"/>
	<part name="DisallowInsurancePhoneHeaderGateway" type="xsd:boolean"/>
	<part name="CompanyID" type="xsd:string"/>
	<part name="ProductCode" type="xsd:string"/>
	<part name="InstantIDVersion" type="xsd:string"/>
	<part name="IIDVersionOverride" type="xsd:boolean"/>
	
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

	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
	<part name="EnableEmergingID" type="xsd:boolean"/>	
	<part name="NameInputOrder" type="xsd:string"/>	
	<part name="IncludeOFAC" type="xsd:boolean"/>	
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>	
	<part name="ExcludeWatchLists" type="xsd:boolean"/>	
	<part name="OFACOnly" type="xsd:boolean"/>	
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>	
	<part name="OFACversion" type="xsd:unsignedInt"/>	
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

import address, iesp, identifier2, patriot, riskwise, ut, intliid, models, autostandardi, risk_indicators, ADVO, gateway, OFAC_XG5;

export FlexID_Batch_Service := MACRO

batch_in_format := record
	Risk_Indicators.LayoutsFlexID.LayoutBatchInPlus;
	string20 HistoryDateTimeStamp := '';
	string5  Grade := '';
	string16 Channel := '';
	string8  Income := '';
	string16 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8  DateofApplication := '';
	string8  TimeofApplication := '';
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

ds_in := dataset([], batch_in_format) : stored('batch_in',few);

unsigned1 DPPAPurpose := 0 								: stored('DPPAPurpose');
unsigned1 GLBPurpose := 8 									: stored('GLBPurpose');
string5 	 IndustryClassVal := '' 						: stored('IndustryClass');
unsigned3 HistoryDate := 999999 							: stored('HistoryDateYYYYMM');
boolean   IsPOBoxCompliant := false 					: stored('PoBoxCompliance');
boolean   UseDobFilter := false 							: stored('UseDobFilter');
integer2  DobRadius := 2 									: stored('DobRadius');
string    ModelIn := '' 									: stored('Model');
boolean		IncludeTargus := TRUE						: stored('Targus');	// default to TRUE so existing batch jobs work the same as they were
boolean   IncludeTargus3220 := false 					: stored('IncludeTargusE3220');
boolean   IncludeDLverification := false 				: stored('IncludeDLverification');
boolean   IncludeMSoverride := false 					: stored('IncludeMSoverride');
boolean 	IncludeCLoverride := false 				: stored('IncludeCLoverride');
string15  DOBMatchType := ''								: stored('DOBMatchType');
unsigned1 DOBMatchYearRadius := 0						: stored('DOBMatchYearRadius');
boolean   IncludeSummaryFlags := false					: stored('IncludeVerifiedElementSummary');
boolean   IncludeAllRiskIndicators := false			: stored('IncludeAllRiskIndicators');
string    DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask;
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

// new options for CIID project summer 2013
boolean IncludeRiskIndices := false :stored('IncludeRiskIndices');
string128 CustomCVIModelName := ''	: STORED('CustomCVIModelName');	// i took this out of realtime version because it already is using the model tags
string20 CompanyID := ''						: STORED('CompanyID');
string ProductCode := ''						: STORED('ProductCode');
unsigned3 LastSeenThreshold := risk_indicators.iid_constants.oneyear : STORED('LastSeenThreshold');
boolean IncludeMIoverride := false	: STORED('IncludeMIoverride');
boolean IncludeDOBinCVI := false						: STORED('IncludeDOBinCVI');
boolean IncludeDriverLicenseInCVI := false	: STORED('IncludeDriverLicenseInCVI');
boolean DisableInquiriesInCVI := false			: STORED('DisableInquiriesInCVI');
boolean IncludeVerifiedSSN := false					: STORED('IncludeVerifiedSSN');
boolean DisallowInsurancePhoneHeaderGateway := false	: STORED('DisallowInsurancePhoneHeaderGateway');	
string1 IIDVersion := '0'										: STORED('InstantIDVersion');		// set this version to 1 as default when we force version 1, a blank input should go to 1 by default, a 0 should give an error unless allow tag is set
boolean IIDVersionOverride := false					: STORED('IIDVersionOverride');	// back office tag that, if true, allows a version lower than the lowestAllowedVersion
boolean EnableEmergingID := false						: STORED('EnableEmergingID');	// back office tag that, if true, invokes additional logic for appending DID
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

											
boolean ExactFirstNameMatch := false : stored('ExactFirstNameMatch');
boolean ExactLastNameMatch := false : stored('ExactLastNameMatch');
boolean ExactAddrMatch := false : stored('ExactAddrMatch');
boolean ExactPhoneMatch := false : stored('ExactPhoneMatch');
boolean ExactSSNMatch := false : stored('ExactSSNMatch');
boolean ExactDOBMatch := false : stored('ExactDOBMatch');
boolean ExactDriverLicenseMatch := false 	: stored('ExactDriverLicenseMatch');
boolean ExactFirstNameMatchAllowNicknames := false : stored('ExactFirstNameMatchAllowNicknames');


string10 ExactMatchLevel := 	if(ExactFirstNameMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactLastNameMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactAddrMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactPhoneMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactSSNMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) + 
										if(ExactDOBMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) +
										if(ExactFirstNameMatchAllowNicknames, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse) +
										if(ExactDriverLicenseMatch, Risk_Indicators.iid_constants.sTrue, Risk_Indicators.iid_constants.sFalse);
										
boolean Include_ALL_Watchlist:= false 	: stored('Include_ALL_Watchlist');
boolean Include_BES_Watchlist:= false 	: stored('Include_BES_Watchlist');
boolean Include_CFTC_Watchlist:= false : stored('Include_CFTC_Watchlist');
boolean Include_DTC_Watchlist:= false 	: stored('Include_DTC_Watchlist');
boolean Include_EUDT_Watchlist:= false : stored('Include_EUDT_Watchlist');
boolean Include_FBI_Watchlist:= false 	: stored('Include_FBI_Watchlist');
boolean Include_FCEN_Watchlist:= false : stored('Include_FCEN_Watchlist');
boolean Include_FAR_Watchlist:= false 	: stored('Include_FAR_Watchlist');
boolean Include_IMW_Watchlist:= false 	: stored('Include_IMW_Watchlist');
boolean Include_OFAC_Watchlist:= false : stored('Include_OFAC_Watchlist');
boolean Include_OCC_Watchlist:= false 	: stored('Include_OCC_Watchlist');
boolean Include_OSFI_Watchlist:= false : stored('Include_OSFI_Watchlist');
boolean Include_PEP_Watchlist:= false 	: stored('Include_PEP_Watchlist');
boolean Include_SDT_Watchlist:= false 	: stored('Include_SDT_Watchlist');
boolean Include_BIS_Watchlist:= false 	: stored('Include_BIS_Watchlist');
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
					if(Include_ALL_Watchlist, 	dataset([{patriot.constants.wlALL}], iesp.share.t_StringArrayItem)) +
					if(Include_BES_Watchlist, 	dataset([{patriot.constants.wlBES}], iesp.share.t_StringArrayItem)) +
					if(Include_CFTC_Watchlist, dataset([{patriot.constants.wlCFTC}], iesp.share.t_StringArrayItem)) +
					if(Include_DTC_Watchlist, 	dataset([{patriot.constants.wlDTC}], iesp.share.t_StringArrayItem)) +
					if(Include_EUDT_Watchlist, dataset([{patriot.constants.wlEUDT}], iesp.share.t_StringArrayItem)) +
					if(Include_FBI_Watchlist, 	dataset([{patriot.constants.wlFBI}], iesp.share.t_StringArrayItem)) +
					if(Include_FCEN_Watchlist, dataset([{patriot.constants.wlFCEN}], iesp.share.t_StringArrayItem)) +
					if(Include_FAR_Watchlist, 	dataset([{patriot.constants.wlFAR}], iesp.share.t_StringArrayItem)) +
					if(Include_IMW_Watchlist, 	dataset([{patriot.constants.wlIMW}], iesp.share.t_StringArrayItem)) +
					if(Include_OFAC_Watchlist, dataset([{patriot.constants.wlOFAC}], iesp.share.t_StringArrayItem)) +
					if(Include_OCC_Watchlist, 	dataset([{patriot.constants.wlOCC}], iesp.share.t_StringArrayItem)) +
					if(Include_OSFI_Watchlist, dataset([{patriot.constants.wlOSFI}], iesp.share.t_StringArrayItem)) +
					if(Include_PEP_Watchlist, 	dataset([{patriot.constants.wlPEP}], iesp.share.t_StringArrayItem)) +
					if(Include_SDT_Watchlist, 	dataset([{patriot.constants.wlSDT}], iesp.share.t_StringArrayItem)) +
					if(Include_BIS_Watchlist, 	dataset([{patriot.constants.wlBIS}], iesp.share.t_StringArrayItem)) +
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

// constants
boolean suppressNearDups := false;
boolean require2ele := false;
boolean fromBiid := false;
boolean isFCRA := false;
boolean nugen := true;
boolean inCalif := false;
boolean fdReasonsWith38 := false;
boolean LNBrandedValue := false;
boolean runSSNCodes:= true;
boolean runBestAddrCheck:= true;
boolean runChronoPhoneLookup:= true;
boolean runAreaCodeSplitSearch:= true;
boolean fromIT1O := false;
boolean allowCellPhones := false;
string1 CustomDataFilter := '';  // this only for Phillip Morris in Identifier2
boolean OfacOnly := true : stored('OfacOnly');
boolean ExcludeWatchLists := false : stored('ExcludeWatchLists');
unsigned1 OFACVersion :=2 :stored('OFACversion');
boolean IncludeAdditionalWatchlists := FALSE: stored('IncludeAdditionalWatchlists');
boolean IncludeOfac := FALSE: stored('IncludeOfac');
real GlobalWatchListThreshold_temp := 0 :stored('GlobalWatchlistThreshold');
			GlobalWatchListThreshold := Map( 
																		OFACVersion >= 4	and GlobalWatchListThreshold_temp = 0	 => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,
																		OFACVersion < 4  and GlobalWatchListThreshold_temp = 0  => OFAC_XG5.Constants.DEF_THRESHOLD_REAL,
																		GlobalWatchListThreshold_temp);
unsigned2 EverOccupant_PastMonths := 0;
unsigned4 EverOccupant_StartDate  := 99999999;
unsigned1 AppendBest := 1;		// search best file
boolean doInquiries := ~DisableInquiriesInCVI AND dataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue AND
												actualIIDVersion=1;
boolean AllowInsuranceDL := true;
ModelName := StringLib.StringToLowerCase( ModelIn );

boolean OFAC := true;	// used in cviScore override, FlexID has been hardcoded to TRUE, so I am doing that here now

isUtility := StringLib.StringToUpperCase(IndustryClassVal)='UTILI';
DobRadiusUse := if(UseDobFilter,DobRadius,-1);
NumReasons := if(IncludeAllRiskIndicators, 20, risk_indicators.iid_constants.DefaultNumCodes);
DOBMatchOptions := dataset([{DOBMatchType, DOBMatchYearRadius}], risk_indicators.layouts.Layout_DOB_Match_Options);

//Check to see if the FP model requested requires a valid GLB 
FP3_models_requiring_GLB	:= ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9']; //these models require valid GLB, else fail
glb_ok 	:= Risk_Indicators.iid_constants.glb_ok(GLBPurpose, isFCRA);
InvalidFP3GLBRequest := modelname in FP3_models_requiring_GLB and ~glb_ok; 
if(InvalidFP3GLBRequest, FAIL('Valid Gramm-Leach-Bliley Act (GLBA) purpose required'));

integer BSVersion := MAP (
													ModelName in ['fp1109_0', 'fp1109_9']  =>  4, 
													ModelName in ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'] => 51,	
													51);  //for the Emerging Identities project, default BS version to 51

unsigned8 BSOptions := 	if(doInquiries, risk_indicators.iid_constants.BSOptions.IncludeInquiries, 0) +
												if(~DisallowInsurancePhoneHeaderGateway and actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IncludeInsNAP, 0) +
												if(actualIIDVersion=1, risk_indicators.iid_constants.BSOptions.IsInstantIDv1, 0) +
												if(modelname in ['fp1303_2', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'],  
																									risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
																									risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
														0) +
												if(AllowInsuranceDL, risk_indicators.iid_constants.BSOptions.AllowInsuranceDLInfo, 0) +  //Allows use of Insurance DL information
												if(EnableEmergingID, Risk_Indicators.iid_constants.BSOptions.EnableEmergingID,0) +
												if(bsversion >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0);	//Invokes additional DID append logic
												
// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
boolean IsInstantID := true;
reasoncode_settings := dataset([{IsInstantID,actualIIDVersion,EnableEmergingID}],riskwise.layouts.reasoncode_settings);


gateways_in := Gateway.Configuration.Get();

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



// populate the seq
batch_in_format into_seq(ds_in L, integer C) := transform
	self.seq := C;
	self := l;
end;
fs := project(ds_in, into_seq(LEFT,COUNTER));



risk_indicators.Layout_Input into(fs le) := transform
	// clean up input
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	history_date := if(le.HistoryDateYYYYMM=0, historydate, le.HistoryDateYYYYMM);
	self.historydate := if(le.historyDateTimeStamp<>'',(unsigned)le.historyDateTimeStamp[1..6], history_date);
	self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp, history_date);
	self.seq := le.seq;	
	self.ssn := le.ssn;
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
	self.addr_type := risk_indicators.iid_constants.override_addr_type(street_address, clean_a2[139],clean_a2[126..129]);
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
 
advoreturns := RECORD
	UNSIGNED4 seq;
	STRING1 ADVODropIndicator;
end;

with_advo := join(prep, Advo.Key_Addr1,
					left.z5 != '' and 
					left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range),
					transform(advoreturns,
											self.seq := left.seq;
											self.ADVODropIndicator := TRIM(RIGHT.Drop_Indicator)),
											left outer,
											atmost(riskwise.max_atmost), keep(1));	

ret := risk_indicators.InstantID_Function(prep, gateways, DPPAPurpose, GLBPurpose, isUtility, LNBrandedValue, 
														OFACOnly, suppressNearDups, require2ele, fromBiid, isFCRA, ExcludeWatchLists,
														fromIT1O, OFACVersion, IncludeOFAC, IncludeAdditionalWatchlists, GlobalWatchListThreshold, DobRadiusUse,
														BSVersion, runSSNCodes, runBestAddrCheck, runChronoPhoneLookup, runAreaCodeSplitSearch, allowCellPhones,
														ExactMatchLevel, DataRestriction, CustomDataFilter, IncludeDLverification, watchlists_request, DOBMatchOptions,
														EverOccupant_PastMonths, EverOccupant_StartDate, AppendBest, BSoptions, LastSeenThreshold, CompanyID, DataPermission);

if(exists(ret(watchlist_table = 'ERR')), FAIL('Bridger Gateway Error'));

LayoutFlexIDBatchOutExt := RECORD
	risk_indicators.LayoutsFlexID.LayoutFlexIDBatchOut;
	Royalty.RoyaltyNetAcuity.IPData.Royalty_NAG;
	boolean insurance_dl_used;
END;

LayoutFlexIDBatchOutExt format_out(ret le, fs ri) := TRANSFORM
	SELF.seq := (string)ri.seq;
	SELF.acctNo := ri.acctno;
	
	SELF.UniqueID := if(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, '0', (string)le.DID); //if DID is fake, zero it out
	
	SELF.verSSN := IF(IncludeVerifiedSSN and le.combo_ssncount>0 and le.combo_ssnscore between 90 and 100 and actualIIDVersion=1, le.combo_ssn, '');// i don't think we want to output the input social for level =1
	//new for Emerging Identities - a fake DID means we verified first, last and SSN in getDIDprepOutput so set NAS to 9
	SELF.NameAddressSSNSummary := If(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, '9', (string)le.socsverlevel);
	SELF.NameAddressPhoneSummary := (string)le.phoneverlevel;
	SELF.NameAddressPhoneType := le.nap_type;
	SELF.NameAddressPhoneStatus := le.nap_status;
	
	verlast := IF(le.combo_lastcount>0, le.combo_last, '');
	veraddr := IF(le.combo_addrcount>0, Risk_Indicators.MOD_AddressClean.street_address('', le.combo_prim_range, le.combo_predir, le.combo_prim_name, le.combo_suffix,
																													le.combo_postdir,le.combo_unit_desig,le.combo_sec_range), '');
	cvi_temp := if(actualIIDVersion=0, risk_indicators.cviScore(le.phoneverlevel, le.socsverlevel, le, le.correctssn, le.correctaddr, le.correcthphone, '', veraddr, verlast,
																															OFAC),
																			risk_indicators.cviScoreV1(le.phoneverlevel, le.socsverlevel, le, le.correctssn, le.correctaddr, le.correcthphone, '', veraddr, verlast,
																																	OFAC,IncludeDOBinCVI,IncludeDriverLicenseInCVI));
	isCodeDI := risk_indicators.rcSet.isCodeDI(le.DIDdeceased) and actualIIDVersion=1;
	SELF.ComprehensiveVerificationIndex := MAP(	IncludeMSoverride and risk_indicators.rcSet.isCodeMS(le.ssns_per_adl_seen_18months) and (integer)cvi_temp > 10 => '10',
							IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(le.addr_type) and (integer)cvi_temp > 10 => '10',
							IncludeCLoverride and risk_indicators.rcSet.isCodeCL(le.ssn, le.bestSSN, le.socsverlevel, le.combo_ssn) and (integer)cvi_temp > 10 => '10', 
							IncludeMIoverride AND risk_indicators.rcSet.isCodeMI(le.adls_per_ssn_seen_18months) and (INTEGER)cvi_temp > 10 => '10',
							isCodeDI AND (INTEGER)cvi_temp > 10 => '10',
							cvi_temp);
																																									
	
	// allow up to 20 reason codes (seemed like a high enough amount to show all reason codes returned)
	RiskIndicators := risk_indicators.reasonCodes(le, NumReasons, reasoncode_settings);
	SELF.CVIRiskCode1 := if (count(RiskIndicators) >= 1, RiskIndicators[1].hri, '');
	SELF.CVIDescription1 := if (count(RiskIndicators) >= 1, RiskIndicators[1].desc, '');
	SELF.CVIRiskCode2 := if (count(RiskIndicators) >= 2, RiskIndicators[2].hri, '');
	SELF.CVIDescription2 := if (count(RiskIndicators) >= 2, RiskIndicators[2].desc, '');
	SELF.CVIRiskCode3 := if (count(RiskIndicators) >= 3, RiskIndicators[3].hri, '');
	SELF.CVIDescription3 := if (count(RiskIndicators) >= 3, RiskIndicators[3].desc, '');
	SELF.CVIRiskCode4 := if (count(RiskIndicators) >= 4, RiskIndicators[4].hri, '');
	SELF.CVIDescription4 := if (count(RiskIndicators) >= 4, RiskIndicators[4].desc, '');
	SELF.CVIRiskCode5 := if (count(RiskIndicators) >= 5, RiskIndicators[5].hri, '');
	SELF.CVIDescription5 := if (count(RiskIndicators) >= 5, RiskIndicators[5].desc, '');
	SELF.CVIRiskCode6 := if (count(RiskIndicators) >= 6, RiskIndicators[6].hri, '');
	SELF.CVIDescription6 := if (count(RiskIndicators) >= 6, RiskIndicators[6].desc, '');
	SELF.CVIRiskCode7 := if (count(RiskIndicators) >= 7, RiskIndicators[7].hri, '');
	SELF.CVIDescription7 := if (count(RiskIndicators) >= 7, RiskIndicators[7].desc, '');
	SELF.CVIRiskCode8 := if (count(RiskIndicators) >= 8, RiskIndicators[8].hri, '');
	SELF.CVIDescription8 := if (count(RiskIndicators) >= 8, RiskIndicators[8].desc, '');
	SELF.CVIRiskCode9 := if (count(RiskIndicators) >= 9, RiskIndicators[9].hri, '');
	SELF.CVIDescription9 := if (count(RiskIndicators) >= 9, RiskIndicators[9].desc, '');
	SELF.CVIRiskCode10 := if (count(RiskIndicators) >= 10, RiskIndicators[10].hri, '');
	SELF.CVIDescription10 := if (count(RiskIndicators) >= 10, RiskIndicators[10].desc, '');
	SELF.CVIRiskCode11 := if (count(RiskIndicators) >= 11, RiskIndicators[11].hri, '');
	SELF.CVIDescription11 := if (count(RiskIndicators) >= 11, RiskIndicators[11].desc, '');
	SELF.CVIRiskCode12 := if (count(RiskIndicators) >= 12, RiskIndicators[12].hri, '');
	SELF.CVIDescription12 := if (count(RiskIndicators) >= 12, RiskIndicators[12].desc, '');
	SELF.CVIRiskCode13 := if (count(RiskIndicators) >= 13, RiskIndicators[13].hri, '');
	SELF.CVIDescription13 := if (count(RiskIndicators) >= 13, RiskIndicators[13].desc, '');
	SELF.CVIRiskCode14 := if (count(RiskIndicators) >= 14, RiskIndicators[14].hri, '');
	SELF.CVIDescription14 := if (count(RiskIndicators) >= 14, RiskIndicators[14].desc, '');
	SELF.CVIRiskCode15 := if (count(RiskIndicators) >= 15, RiskIndicators[15].hri, '');
	SELF.CVIDescription15 := if (count(RiskIndicators) >= 15, RiskIndicators[15].desc, '');
	SELF.CVIRiskCode16 := if (count(RiskIndicators) >= 16, RiskIndicators[16].hri, '');
	SELF.CVIDescription16 := if (count(RiskIndicators) >= 16, RiskIndicators[16].desc, '');
	SELF.CVIRiskCode17 := if (count(RiskIndicators) >= 17, RiskIndicators[17].hri, '');
	SELF.CVIDescription17 := if (count(RiskIndicators) >= 17, RiskIndicators[17].desc, '');
	SELF.CVIRiskCode18 := if (count(RiskIndicators) >= 18, RiskIndicators[18].hri, '');
	SELF.CVIDescription18 := if (count(RiskIndicators) >= 18, RiskIndicators[18].desc, '');
	SELF.CVIRiskCode19 := if (count(RiskIndicators) >= 19, RiskIndicators[19].hri, '');
	SELF.CVIDescription19 := if (count(RiskIndicators) >= 19, RiskIndicators[19].desc, '');
	SELF.CVIRiskCode20 := if (count(RiskIndicators) >= 20, RiskIndicators[20].hri, '');
	SELF.CVIDescription20 := if (count(RiskIndicators) >= 20, RiskIndicators[20].desc, '');
		
	// Summary Verification flags
	SELF.VerifiedElementSummaryFirstName := if(IncludeSummaryFlags, if(le.combo_firstcount>0, '1', '0'), '');
	SELF.VerifiedElementSummaryLastName := if(IncludeSummaryFlags, if(le.combo_lastcount>0, '1', '0'), '');
	addrScore := Risk_Indicators.AddrScore.AddressScore(	le.combo_prim_range, le.combo_prim_name, le.combo_sec_range,
																			le.prim_range, le.prim_name, le.sec_range);																					
	addrMatch := Risk_Indicators.iid_constants.ga(addrScore) and if(ExactAddrMatch, le.combo_prim_range=le.prim_range and le.combo_prim_name=le.prim_name and
																												ut.nneq(le.combo_sec_range,le.sec_range), true);																		
	SELF.VerifiedElementSummaryStreetAddress := if(IncludeSummaryFlags, 	if(addrMatch, '1', '0'), 
																								'');
																								
	CityA := stringlib.stringtouppercase(trim(le.combo_city));
	CityB := stringlib.stringtouppercase(trim(ri.p_City_name));
	CityScore := 100 - MAX(ut.StringSimilar100(CityA, CityB), ut.StringSimilar100(CityB, CityA));
	CityMatch := (ExactAddrMatch and CityA=CityB and CityB<>'') or (~ExactAddrMatch and CityScore between 80 and 100 and CityB<>'');
		
	SELF.VerifiedElementSummaryCity := if(IncludeSummaryFlags, if(CityMatch, '1', '0'), '');																							
	SELF.VerifiedElementSummaryState := if(IncludeSummaryFlags, if(trim(le.combo_state)=trim(stringlib.stringtouppercase(ri.st)) and trim(ri.st)<>'', '1', '0'), '');
	SELF.VerifiedElementSummaryZip := if(IncludeSummaryFlags, if(trim(le.combo_zip[1..5])=trim(ri.z5) and trim(ri.z5)<>'', '1', '0'), '');
	SELF.VerifiedElementSummaryHomePhone := if(IncludeSummaryFlags, if(le.combo_hphonecount>0, '1', '0'), '');
	SELF.VerifiedElementSummarySSN := if(IncludeSummaryFlags, if(le.combo_ssncount>0, '1', '0'), '');
	SELF.VerifiedElementSummaryDOB := if(le.combo_dobcount>0, '1', '0');
	SELF.VerifiedElementSummaryDOBMatchLevel := le.dobmatchlevel;
	SELF.VerifiedElementSummaryDL := if(IncludeDLVerification, if(le.verified_dl<>'', '1', '0'), '');
	
	// Summary Validation flags
	SELF.ValidElementSummarySSNDeceased := if(le.decsflag='1', '1', '0');
	SELF.ValidElementSummarySSN := if(le.socllowissue <> '', '1', '0');
	
	passportline := ri.PassportUpperLine + ri.PassportLowerLine;
	SELF.ValidElementSummaryPassport := if(IntlIID.ValidationFunctions().passportValidation(passportline, ri.dob[3..8], ri.gender), '1','0');
	SELF.ValidElementSummaryDL := if(IncludeDLVerification, if(le.drlcvalflag = '0' and le.dl_state in risk_indicators.iid_constants.SetDLValidationStates, '1', '0'), '');

	SELF.ValidElementSummaryAddressPOBox := if(Risk_Indicators.rcSet.isCode12(le.addr_type) or Risk_Indicators.rcSet.isCodePO(le.zipclass),'1','0');
	SELF.ValidElementSummaryAddressCMRA := if(le.hrisksic in ['2310','2300','2220','2280','2320'], '1','0');		// should this also include le.ADVODropIndicator='C' 
	SELF.ValidElementSummarySSNFoundForLexID := if(actualIIDVersion=1,if(le.bestssn<>'', '1', '0'),'');	
	
	SELF.cviCustomScore := '';	// new field for future use
	
	SELF.InstantIDVersion := (string)actualIIDVersion;
	SELF.insurance_dl_used := le.insurance_dl_used;
	
	//new for Emerging Identities
	self.EmergingID := if(le.DID = Risk_Indicators.iid_constants.EmailFakeIds, true, false);  //a fake DID indicates an Emerging Identity
	VerSecRange := IF(le.combo_addrcount>0, le.combo_sec_range, '');
	isReasonCodeSR	:= exists(RiskIndicators(hri='SR')); //check if reason code 'SR' is set
	SELF.AddressSecondaryRangeMismatch := map(le.sec_range = '' and isReasonCodeSR															=> 'D',	 //no input sec range, but our data has one
																						le.sec_range <> '' and ~isReasonCodeSR and versecrange = ''				=> 'I',	 //input sec range, but our data does not have one
																						le.sec_range <> '' and isReasonCodeSR															=> 'M',	 //input sec range, but our data shows different sec range
																						le.sec_range = '' and ~isReasonCodeSR															=> 'N',	 //no input sec range and our data does not have one
																																																								 'V'); //input sec range matches our data
	
	SELF := [];
END;
formedbeforeAdvo := join(ret, fs, left.seq = right.seq, format_out(LEFT, RIGHT));
formedWithAdvo := join(formedbeforeAdvo, with_advo, (integer)left.seq = right.seq, 
									TRANSFORM(LayoutFlexIDBatchOutExt,
										self.ValidElementSummaryAddressCMRA := IF(LEFT.ValidElementSummaryAddressCMRA = '1' OR RIGHT.ADVODropIndicator = 'C', '1', '0');
										self.Royalty_NAG := 0;
										self := left), left outer, keep(1));

//Only get royalties for hitting the Insurance DL information if they are allowed to access the information
Boolean TrackInsuranceRoyalties := Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);
InsuranceRoyalties 	:= if(TrackInsuranceRoyalties, Royalty.RoyaltyFDNDLDATA.GetBatchRoyaltiesByAcctno(formedWithAdvo, acctno, insurance_dl_used, TRUE));

// boca shell constants
IncludeRelatives := true;
IncludeDLInfo := false;
IncludeVehInfo := false;
IncludeDerogInfo := true;
DoScore := false;
FilterOutFares := false;

clam :=  risk_indicators.Boca_Shell_Function(	ret, 
															gateways, 
															DPPAPurpose, 
															GLBPurpose, 
															isUtility, 
															LNBrandedValue, 
															IncludeRelatives, 
															IncludeDLInfo, 
															IncludeVehInfo, 
															IncludeDerogInfo, 
															BSVersion, 
															DoScore, 
															nugen, 
															FilterOutFares,
															DataRestriction,
															BSOptions,
															DataPermission);
															
															

ip_prep := project( fs, transform( riskwise.Layout_IPAI, self.ipaddr := left.ip_addr, self.seq := left.seq ) );
ip_out  := risk_indicators.getNetAcuity( ip_prep, gateways, DPPAPurpose, GLBPurpose);

bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

clam_ip := join( clam, ip_out, left.seq=right.seq,
									transform( 	bs_with_ip,
													self.bs := left,
													self.ip := right), left outer);

	
model := map(	ModelName = 'fp3710_0' => project(models.FP3710_0_0( clam_ip, 4, false), transform(models.layouts.layout_fp1109, self := left, self := [])),
					ModelName = 'fp3710_9' => project(models.FP3710_0_0( clam_ip, 4, true), transform(models.layouts.layout_fp1109, self := left, self := [])), // FP3710_9 is simply FP3710_0 with criminal risk codes returned
					// fraudpoint version 2
					ModelName = 'fp1109_0' 			=> Models.FP1109_0_0(clam_ip, 6, false),
					ModelName = 'fp1109_9' 			=> Models.FP1109_0_0(clam_ip, 6, true),
					ModelName = 'fp31505_0' 		=> Models.FP31505_0_Base( clam_ip, 6, false),
					ModelName = 'fp31505_9' 		=> Models.FP31505_0_Base( clam_ip, 6, true),
					ModelName = 'fp3fdn1505_0' 	=> Models.FP3FDN1505_0_Base( clam_ip, 6, false),
					ModelName = 'fp3fdn1505_9' 	=> Models.FP3FDN1505_0_Base( clam_ip, 6, true),
					ModelName = ''         			=> dataset( [], models.layouts.layout_fp1109 ),
																				 fail(models.layouts.layout_fp1109, 'Invalid model name'));


formedWithIP := join(formedWithAdvo, clam_ip, (unsigned)left.seq = right.ip.seq,
									transform(LayoutFlexIDBatchOutExt,
										SELF.Royalty_NAG := Royalty.RoyaltyNetAcuity.GetCount(right.ip.ipaddr, right.ip.iptype);
										SELF := left;
										));

// Add model name to this list if clam_ip/netacuity is used. 
boolean	trackNetacuityRoyalties := ModelName IN ['fp3710_0', 'fp3710_9', 'fp1109_0', 'fp1109_9', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'];
formed := IF(trackNetacuityRoyalties, formedWithIP, formedWithAdvo);									

risk_indicators.LayoutsFlexID.LayoutFlexIDBatchOut toModelBatch( formed le, model ri ) := TRANSFORM
	self.Score1 		 := ri.score;
	self.ScoreRiskCode1    := if(ri.ri[1].hri <> '00', ri.ri[1].hri, '');
	self.ScoreDescription1 := ri.ri[1].desc;
	self.ScoreRiskCode2    := if(ri.ri[2].hri <> '00', ri.ri[2].hri, '');
	self.ScoreDescription2 := ri.ri[2].desc;
	self.ScoreRiskCode3    := if(ri.ri[3].hri <> '00', ri.ri[3].hri, '');
	self.ScoreDescription3 := ri.ri[3].desc;
	self.ScoreRiskCode4    := if(ri.ri[4].hri <> '00', ri.ri[4].hri, '');
	self.ScoreDescription4 := ri.ri[4].desc;
	self.ScoreRiskCode5    := if(ri.ri[5].hri <> '00', ri.ri[5].hri, '');
	self.ScoreDescription5 := ri.ri[5].desc;
	self.ScoreRiskCode6    := if(ri.ri[6].hri <> '00', ri.ri[6].hri, '');
	self.ScoreDescription6 := ri.ri[6].desc;
	
	self.StolenIdentityIndex        := if(IncludeRiskIndices, ri.StolenIdentityIndex, '');
	self.SyntheticIdentityIndex     := if(IncludeRiskIndices, ri.SyntheticIdentityIndex, '');
	self.ManipulatedIdentityIndex   := if(IncludeRiskIndices, ri.ManipulatedIdentityIndex, '');
	self.VulnerableVictimIndex      := if(IncludeRiskIndices, ri.VulnerableVictimIndex, '');
	self.FriendlyFraudIndex         := if(IncludeRiskIndices, ri.FriendlyFraudIndex, '');
	self.SuspiciousActivityIndex    := if(IncludeRiskIndices, ri.SuspiciousActivityIndex, '');
	
	self := le;
END;


final := join( formed, model, (unsigned)left.seq=right.seq, toModelBatch(LEFT,RIGHT), left outer, keep(1) );

output(final,named('Results')) ;

BOOLEAN  ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
dIPIn := PROJECT(fs,TRANSFORM(Royalty.RoyaltyNetAcuity.IPData,SELF.AcctNo := LEFT.AcctNo; SELF.IPAddr:=LEFT.ip_addr; SELF := [];));
dRoyaltiesByAcctno 	:= IF(trackNetacuityRoyalties, Royalty.RoyaltyNetAcuity.GetBatchRoyaltiesByAcctno(gateways, dIPIn, formed, TRUE));
dRoyalties 					:= Royalty.GetBatchRoyalties(dRoyaltiesByAcctno + InsuranceRoyalties, ReturnDetailedRoyalties);
output(dRoyalties,NAMED('RoyaltySet'));

ENDMACRO;
// risk_indicators.FlexID_Batch_Service();