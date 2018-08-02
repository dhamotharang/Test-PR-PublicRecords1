/*--SOAP--
<message name="Business_Shell_Batch_Service" wuTimeout="300000">
	<part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="25"/>
	<!-- Option Fields --> 
	<part name="DPPA_Purpose" type="xsd:integer"/>
	<part name="GLBA_Purpose" type="xsd:integer"/>
	<part name="Data_Restriction_Mask" type="xsd:string"/>
	<part name="Data_Permission_Mask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="LinkSearchLevel" type="xsd:integer"/>
	<part name="MarketingMode" type="xsd:integer"/>
	<part name="BusShellVersion" type="xsd:integer"/>
	<part name="AllowedSources" type="xsd:string"/>
	<part name="BIPBestAppend" type="xsd:integer"/>
  <part name="OFAC_Version" type="xsd:integer"/>
  <part name="Global_Watchlist_Threshold" type="xsd:real"/>
  <part name="KeepLargeBusinesses" type="xsd:integer"/>
	<part name="IncludeTargusGateway" type="xsd:boolean"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="RunTargusGatewayAnywayForTesting" type="xsd:boolean"/>
	<part name="OverrideExperianRestriction" type="xsd:boolean"/>
	<part name="IncludeAuthRepInBIPAppend" type="xsd:boolean"/>
	<part name="Include_ALL_Watchlist" type="xsd:boolean"/>
	<part name="Include_ALLV4_Watchlist" type="xsd:boolean"/>
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
</message>
*/
/*--INFO-- Business Shell Batch Service - This is the Batch Service utilizing BIP linking. */

#option('expandSelectCreateRow', true);
IMPORT Business_Risk_BIP, Gateway, iesp, UT, Cortera, Risk_Indicators, patriot, OFAC_XG5;

EXPORT Business_Shell_Batch_Service() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'Batch_In',
	'DPPA_Purpose',
	'GLBA_Purpose',
	'Data_Restriction_Mask',
	'Data_Permission_Mask',
	'IndustryClass',
	'LinkSearchLevel',
	'MarketingMode',
	'BusShellVersion',
	'AllowedSources',
	'BIPBestAppend',
	'OFAC_Version',
	'Global_Watchlist_Threshold',
	'KeepLargeBusinesses',
	'IncludeTargusGateway',
	'Gateways',
	'RunTargusGatewayAnywayForTesting',
	'OverrideExperianRestriction',
	'IncludeAuthRepInBIPAppend',
	'Include_ALL_Watchlist',
	'Include_ALLV4_Watchlist',
	'Include_BES_Watchlist',
	'Include_CFTC_Watchlist',
	'Include_DTC_Watchlist',
	'Include_EUDT_Watchlist',
	'Include_FBI_Watchlist',
	'Include_FCEN_Watchlist',
	'Include_FAR_Watchlist',
	'Include_IMW_Watchlist',
	'Include_OFAC_Watchlist',
	'Include_OCC_Watchlist',
	'Include_OSFI_Watchlist',
	'Include_PEP_Watchlist',
	'Include_SDT_Watchlist',
	'Include_BIS_Watchlist',
	'Include_UNNT_Watchlist',
	'Include_WBIF_Watchlist',
	'Include_ADFA_Watchlist',
	'Include_FAJC_Watchlist',
	'Include_FATF_Watchlist',
	'Include_FBIH_Watchlist',
	'Include_FBIS_Watchlist',
	'Include_FBIT_Watchlist',
	'Include_FBIW_Watchlist',
	'Include_HKMA_Watchlist',
	'Include_MASI_Watchlist',
	'Include_OFFC_Watchlist',
	'Include_PMLC_Watchlist',
	'Include_PMLJ_Watchlist'
	));
	
	/* ************************************************************************
	 *                          Grab service inputs                           *
	 ************************************************************************ */
	// NOTE: If you change this you MUST redeploy the Library as the interface has changed.
	DATASET(Business_Risk_BIP.Layouts.Input) Input_pre := DATASET([], Business_Risk_BIP.Layouts.Input) : STORED('Batch_In');
	
	// Allow for a longer HistoryDate format (e.g. YYYYMMDD, YYYYMMDDTTTT), which are preserved in full in historydatetime.
	Input := PROJECT(Input_pre, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF.HistoryDate := (UNSIGNED3)(((STRING12)LEFT.HistoryDate)[1..6]), SELF.HistoryDateTime := LEFT.HistoryDate, SELF := LEFT));

	// Option Fields
	UNSIGNED1	DPPA_Purpose         := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPA_Purpose');
	UNSIGNED1	GLBA_Purpose         := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBA_Purpose');
	STRING50	DataRestrictionMask  := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('Data_Restriction_Mask');
	STRING50	DataPermissionMask   := Business_Risk_BIP.Constants.Default_DataPermissionMask : STORED('Data_Permission_Mask');
	STRING5	IndustryClass_In		   := Business_Risk_BIP.Constants.Default_IndustryClass : STORED('IndustryClass');
	IndustryClass := StringLib.StringToUpperCase(TRIM(IndustryClass_In, LEFT, RIGHT));
	UNSIGNED1	LinkSearchLevel      := Business_Risk_BIP.Constants.LinkSearch.Default : STORED('LinkSearchLevel');
	UNSIGNED1	MarketingMode        := Business_Risk_BIP.Constants.Default_MarketingMode : STORED('MarketingMode');
	UNSIGNED1	BusShellVersion      := Business_Risk_BIP.Constants.Default_BusShellVersion : STORED('BusShellVersion');
	STRING50	AllowedSources       := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	UNSIGNED1	BIPBestAppend				 := Business_Risk_BIP.Constants.BIPBestAppend.Default : STORED('BIPBestAppend');
	UNSIGNED1 OFAC_Version		     := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	REAL Global_Watchlist_Threshold	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
	UNSIGNED1 KeepLargeBusinesses  := Business_Risk_BIP.Constants.DefaultJoinType : STORED('KeepLargeBusinesses');
	BOOLEAN IncludeTargusGateway   := FALSE : STORED('IncludeTargusGateway');
	BOOLEAN RunTargusGateway       := FALSE : STORED('RunTargusGatewayAnywayForTesting');
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	BOOLEAN IncludeAuthRepInBIPAppend := FALSE : STORED('IncludeAuthRepInBIPAppend');
	
	Gateways := Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus

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
  if(Include_WBIF_Watchlist, dataset([{patriot.constants.wlWBIF}], iesp.share.t_StringArrayItem))+
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

  Watchlists_Requested := dWL(value<>'');
  
  if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));
  
  IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Watchlists_Requested, value),
    FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );
	
	/* ************************************************************************
	 *                   Get the Business Shell Results                       *
	 ************************************************************************ */
	Shell_Results := Business_Risk_BIP.LIB_Business_Shell_Function(Input,
																																 DPPA_Purpose,
																																 GLBA_Purpose,
																																 DataRestrictionMask,
																																 DataPermissionMask,
																																 IndustryClass,
																																 LinkSearchLevel,
																																 BusShellVersion,
																																 MarketingMode,
																																 AllowedSources,
																																 BIPBestAppend,
																																 OFAC_Version,
																																 Global_Watchlist_Threshold,
																																 Watchlists_Requested,
																																 KeepLargeBusinesses, 
																																 IncludeTargusGateway,
																																 Gateways,
																																 RunTargusGateway, /* for testing purposes only */
																																 OverrideExperianRestriction,
																																 IncludeAuthRepInBIPAppend);
	
	Final_Results := PROJECT(Shell_Results, TRANSFORM(Business_Risk_BIP.Layouts.OutputLayout, SELF := LEFT));
	
	RETURN OUTPUT(Final_Results, NAMED('Results'));
END;