/*--SOAP--
<message name="ProdData" wuTimeout="300000">
	<!-- Company SearchBy Fields --> 
	<part name="CompanyName" type="xsd:string"/>
	<part name="AltCompanyName" type="xsd:string"/>
	<part name="StreetAddress1" type="xsd:string"/>
	<part name="StreetAddress2" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip9" type="xsd:string"/>
	<part name="Prim_Range" type="xsd:string"/>
	<part name="PreDir" type="xsd:string"/>
	<part name="Prim_Name" type="xsd:string"/>
	<part name="Addr_Suffix" type="xsd:string"/>
	<part name="PostDir" type="xsd:string"/>
	<part name="Unit_Desig" type="xsd:string"/>
	<part name="Sec_Range" type="xsd:string"/>
	<part name="Zip5" type="xsd:string"/>
	<part name="Zip4" type="xsd:string"/>
	<part name="Lat" type="xsd:string"/>
	<part name="Long" type="xsd:string"/>
	<part name="Addr_Type" type="xsd:string"/> 
	<part name="Addr_Status" type="xsd:string"/>
	<part name="County" type="xsd:string"/>
	<part name="Geo_Block" type="xsd:string"/>
	<part name="FEIN" type="xsd:string"/>
	<part name="Phone10" type="xsd:string"/>
	<part name="IPAddr" type="xsd:string"/>
	<part name="CompanyURL" type="xsd:string"/>
	<part name="PowID" type="xsd:integer"/>
	<part name="ProxID" type="xsd:integer"/>
	<part name="SeleID" type="xsd:integer"/>
	<part name="OrgID" type="xsd:integer"/>
	<part name="UltID" type="xsd:integer"/>
	<!-- Authorized Representative SearchBy Fields --> 
	<part name="Rep_FullName" type="xsd:string"/>
	<part name="Rep_NameTitle" type="xsd:string"/>
	<part name="Rep_FirstName" type="xsd:string"/>
	<part name="Rep_MiddleName" type="xsd:string"/>
	<part name="Rep_LastName" type="xsd:string"/>
	<part name="Rep_NameSuffix" type="xsd:string"/>
	<part name="Rep_FormerLastName" type="xsd:string"/>
	<part name="Rep_StreetAddress1" type="xsd:string"/>
	<part name="Rep_StreetAddress2" type="xsd:string"/>
	<part name="Rep_City" type="xsd:string"/>
	<part name="Rep_State" type="xsd:string"/>
	<part name="Rep_Zip" type="xsd:string"/>
	<part name="Rep_Prim_Range" type="xsd:string"/>
	<part name="Rep_PreDir" type="xsd:string"/>
	<part name="Rep_Prim_Name" type="xsd:string"/>
	<part name="Rep_Addr_Suffix" type="xsd:string"/>
	<part name="Rep_PostDir" type="xsd:string"/>
	<part name="Rep_Unit_Desig" type="xsd:string"/>
	<part name="Rep_Sec_Range" type="xsd:string"/>
	<part name="Rep_Zip5" type="xsd:string"/>
	<part name="Rep_Zip4" type="xsd:string"/>
	<part name="Rep_Lat" type="xsd:string"/>
	<part name="Rep_Long" type="xsd:string"/>
	<part name="Rep_Addr_Type" type="xsd:string"/>
	<part name="Rep_Addr_Status" type="xsd:string"/>
	<part name="Rep_County" type="xsd:string"/>
	<part name="Rep_Geo_Block" type="xsd:string"/>
	<part name="Rep_SSN" type="xsd:string"/>
	<part name="Rep_DateOfBirth" type="xsd:string"/>
	<part name="Rep_Phone10" type="xsd:string"/>
	<part name="Rep_Age" type="xsd:string"/>
	<part name="Rep_DLNumber" type="xsd:string"/>
	<part name="Rep_DLState" type="xsd:string"/>
	<part name="Rep_Email" type="xsd:string"/>
	<part name="Rep_LexID" type="xsd:integer"/>
	<!-- Option Fields --> 
	<part name="DPPA_Purpose" type="xsd:integer"/>
	<part name="GLBA_Purpose" type="xsd:integer"/>
	<part name="Data_Restriction_Mask" type="xsd:string"/>
	<part name="Data_Permission_Mask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDate" type="xsd:integer"/>
	<part name="LinkSearchLevel" type="xsd:integer"/>
	<part name="MarketingMode" type="xsd:integer"/>
	<part name="AllowedSources" type="xsd:string"/>
	<part name="BIPBestAppend" type="xsd:integer"/>
  <part name="OFAC_Version" type="xsd:integer"/>
  <part name="Global_Watchlist_Threshold" type="xsd:real"/>
  <part name="Watchlists_Requested" type="tns:XmlDataSet" cols="90" rows="10"/>
	<!-- Output Options --> 
	<part name="OutputRecordCount" type="xsd:integer"/>
	<part name="IncludeAll" type="xsd:boolean"/>
	<part name="IncludeLinkingResults" type="xsd:boolean"/>
	<part name="IncludeBusinessHeader" type="xsd:boolean"/>
	<part name="IncludeEBR" type="xsd:boolean"/>
	<part name="IncludeDNBDMI" type="xsd:boolean"/>
	<part name="IncludeBusReg" type="xsd:boolean"/>
	<part name="IncludeDCA" type="xsd:boolean"/>
	<part name="IncludeDEADCO" type="xsd:boolean"/>
	<part name="IncludeABIUS" type="xsd:boolean"/>
	<part name="IncludeInquiriesBus" type="xsd:boolean"/>
	<part name="IncludeLiensJudgments" type="xsd:boolean"/>
	<part name="IncludeOSHA" type="xsd:boolean"/>
	<part name="IncludeBBB" type="xsd:boolean"/>
	<part name="IncludeFBN" type="xsd:boolean"/>
	<part name="IncludeIRS990NonProfit" type="xsd:boolean"/>
	<part name="IncludeUtility" type="xsd:boolean"/>
	<part name="IncludePropertyAssessments" type="xsd:boolean"/>
	<part name="IncludePropertyDeeds" type="xsd:boolean"/>
	<part name="IncludeTradelines" type="xsd:boolean"/>
	<part name="IncludeUCC" type="xsd:boolean"/>
	<part name="IncludeCorpFilings" type="xsd:boolean"/>
	<part name="IncludeBankruptcy" type="xsd:boolean"/>
	<part name="IncludeCortera" type="xsd:boolean"/>
 <part name="IncludeWatchlistSearch" type="xsd:boolean"/>
 <part name="IncludeProfessionalLicense" type="xsd:boolean"/>
	<part name="IncludeSBFE" type="xsd:boolean"/>
 <part name="KeepLargeBusinesses" type="xsd:integer"/>
	<part name="OverrideExperianRestriction" type="xsd:boolean"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
</message>
*/
/*--INFO-- Prod Data Service - This is the XML Service utilizing BIP linking*/

#option('expandSelectCreateRow', true);
IMPORT Address, BBB2, BIPV2, BizLinkFull, Business_Credit, Business_Credit_KEL, Business_Risk_BIP, Corp2, DCAV2, DNB_DMI, EBR, EBR_Services, FBNv2, Gateway, GovData, iesp, InfoUSA, Inquiry_AccLogs, LiensV2, LN_PropertyV2, MDR, NID, OSHAIR, Risk_Indicators, RiskWise, UCCV2, UCCv2_Services, UT, UtilFile;

EXPORT ProdData() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'CompanyName',
	'AltCompanyName',
	'StreetAddress1',
	'StreetAddress2',
	'City',
	'State',
	'Zip9',
	'Phone10',
	'IPAddr',
	'CompanyURL',
	'PowID',
	'ProxID',
	'SeleID',
	'OrgID',
	'UltID',
	'Rep_FirstName',
	'Rep_MiddleName',
	'Rep_LastName',
	'Rep_FormerLastName',
	'Rep_StreetAddress1',
	'Rep_StreetAddress2',
	'Rep_City',
	'Rep_State',
	'Rep_Zip',
	'Rep_SSN',
	'Rep_DateOfBirth',
	'Rep_Phone10',
	'Rep_Age',
	'Rep_DLNumber',
	'Rep_DLState',
	'Rep_Email',
	'Rep_LexID',
	'DPPA_Purpose',
	'GLBA_Purpose',
	'Data_Restriction_Mask',
	'Data_Permission_Mask',
	'IndustryClass',
	'HistoryDate',
	'LinkSearchLevel',
	'MarketingMode',
	'AllowedSources',
	'BIPBestAppend',
	'OFAC_Version',
	'Global_Watchlist_Threshold',
	'Watchlists_Requested',
	'OutputRecordCount',
	'IncludeAll',
	'IncludeABIUS',
	'IncludeBankruptcy',
	'IncludeBBB',
	'IncludeBusinessHeader',
	'IncludeBusReg',
	'IncludeCorpFilings',
  'IncludeCortera',
	'IncludeDCA',
	'IncludeDEADCO',
	'IncludeDNBDMI',
	'IncludeEBR',
	'IncludeFBN',
	'IncludeInquiriesBus',
	'IncludeIRS990NonProfit',
	'IncludeLiensJudgments',
	'IncludeLinkingResults',
	'IncludeOSHA',
	'IncludePropertyAssessments',
	'IncludePropertyDeeds',
	'IncludeSBFE',
	'IncludeTradelines',
	'IncludeUCC',
	'IncludeUtility',
	'IncludeWatchlistSearch',
 'IncludeProfessionalLicense',
	'KeepLargeBusinesses',
	'OverrideExperianRestriction',
  'gateways'
	));
	
	/* ************************************************************************
	 *                          Grab service inputs                           *
	 ************************************************************************ */
	// Company Fields
	STRING120	CompanyName          := '' : STORED('CompanyName');
	STRING120	AltCompanyName       := '' : STORED('AltCompanyName');
	STRING120	StreetAddress1       := '' : STORED('StreetAddress1');
	STRING120	StreetAddress2       := '' : STORED('StreetAddress2');
	STRING25	City                 := '' : STORED('City');
	STRING2		State                := '' : STORED('State');
	STRING9		Zip9                 := '' : STORED('Zip9');
	STRING10	Prim_Range           := '' : STORED('Prim_Range');
	STRING2		PreDir               := '' : STORED('PreDir');
	STRING28	Prim_Name            := '' : STORED('Prim_Name');
	STRING4		Addr_Suffix          := '' : STORED('Addr_Suffix');
	STRING2		PostDir              := '' : STORED('PostDir');
	STRING10	Unit_Desig           := '' : STORED('Unit_Desig');
	STRING8		Sec_Range            := '' : STORED('Sec_Range');
	STRING5		Zip5                 := '' : STORED('Zip5');
	STRING4		Zip4                 := '' : STORED('Zip4');
	STRING10	Lat                  := '' : STORED('Lat');
	STRING11	Long                 := '' : STORED('Long');
	STRING1		Addr_Type            := '' : STORED('Addr_Type');
	STRING4		Addr_Status          := '' : STORED('Addr_Status');
	STRING30	County               := '' : STORED('County');
	STRING7		Geo_Block            := '' : STORED('Geo_Block');
	STRING11	FEIN                 := '' : STORED('FEIN'); // Need to keep this at 11 to match AutoStandardI.GlobalModule and avoid compile errors even though we only allow 9
	STRING10	Phone10              := '' : STORED('Phone10');
	STRING45	IPAddr               := '' : STORED('IPAddr');
	STRING120	CompanyURL           := '' : STORED('CompanyURL');
	UNSIGNED6	PowID                := 0  : STORED('PowID');
	UNSIGNED6	ProxID               := 0  : STORED('ProxID');
	UNSIGNED6	SeleID               := 0  : STORED('SeleID');
	UNSIGNED6	OrgID                := 0  : STORED('OrgID');
	UNSIGNED6	UltID                := 0  : STORED('UltID');
	// Authorized Representative Fields
	STRING120	Rep_FullName         := '' : STORED('Rep_FullName');
	STRING5		Rep_NameTitle        := '' : STORED('Rep_NameTitle');
	STRING20	Rep_FirstName        := '' : STORED('Rep_FirstName');
	STRING20	Rep_MiddleName       := '' : STORED('Rep_MiddleName');
	STRING20	Rep_LastName         := '' : STORED('Rep_LastName');
	STRING5		Rep_NameSuffix       := '' : STORED('Rep_NameSuffix');
	STRING20	Rep_FormerLastName   := '' : STORED('Rep_FormerLastName');
	STRING120	Rep_StreetAddress1   := '' : STORED('Rep_StreetAddress1');
	STRING120	Rep_StreetAddress2   := '' : STORED('Rep_StreetAddress2');
	STRING25	Rep_City             := '' : STORED('Rep_City');
	STRING2		Rep_State            := '' : STORED('Rep_State');
	STRING9		Rep_Zip              := '' : STORED('Rep_Zip');
	STRING10	Rep_Prim_Range       := '' : STORED('Rep_Prim_Range');
	STRING2		Rep_PreDir           := '' : STORED('Rep_PreDir');
	STRING28	Rep_Prim_Name        := '' : STORED('Rep_Prim_Name');
	STRING4		Rep_Addr_Suffix      := '' : STORED('Rep_Addr_Suffix');
	STRING2		Rep_PostDir          := '' : STORED('Rep_PostDir');
	STRING10	Rep_Unit_Desig       := '' : STORED('Rep_Unit_Desig');
	STRING8		Rep_Sec_Range        := '' : STORED('Rep_Sec_Range');
	STRING5		Rep_Zip5             := '' : STORED('Rep_Zip5');
	STRING4		Rep_Zip4             := '' : STORED('Rep_Zip4');
	STRING10	Rep_Lat              := '' : STORED('Rep_Lat');
	STRING11	Rep_Long             := '' : STORED('Rep_Long');
	STRING1		Rep_Addr_Type        := '' : STORED('Rep_Addr_Type');
	STRING4		Rep_Addr_Status      := '' : STORED('Rep_Addr_Status');
	STRING3		Rep_County           := '' : STORED('Rep_County');
	STRING7		Rep_Geo_Block        := '' : STORED('Rep_Geo_Block');
	STRING9		Rep_SSN              := '' : STORED('Rep_SSN');
	STRING8		Rep_DateOfBirth      := '' : STORED('Rep_DateOfBirth');
	STRING10	Rep_Phone10          := '' : STORED('Rep_Phone10');
	STRING3		Rep_Age              := '' : STORED('Rep_Age');
	STRING25	Rep_DLNumber         := '' : STORED('Rep_DLNumber');
	STRING2		Rep_DLState          := '' : STORED('Rep_DLState');
	STRING100	Rep_Email            := '' : STORED('Rep_Email');
	UNSIGNED6	Rep_LexID            := 0  : STORED('Rep_LexID');
	// Option Fields
	UNSIGNED1	DPPA_Purpose_In      := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPA_Purpose');
	UNSIGNED1	GLBA_Purpose_In      := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBA_Purpose');
	STRING5	IndustryClass_Temp       := Business_Risk_BIP.Constants.Default_IndustryClass : STORED('IndustryClass');
	IndustryClass_In := StringLib.StringToUpperCase(TRIM(IndustryClass_Temp, LEFT, RIGHT));
	STRING50	DataRestrictionMask_In:= Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('Data_Restriction_Mask');
	STRING50	DataPermissionMask_In:= Business_Risk_BIP.Constants.Default_DataPermissionMask : STORED('Data_Permission_Mask');
	UNSIGNED6	HistoryDate          := 0  : STORED('HistoryDate');
	UNSIGNED1	LinkSearchLevel_In   := Business_Risk_BIP.Constants.LinkSearch.Default : STORED('LinkSearchLevel');
	UNSIGNED1	MarketingMode_In     := Business_Risk_BIP.Constants.Default_MarketingMode : STORED('MarketingMode');
	STRING50	AllowedSources_In    := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	UNSIGNED1 BIPBestAppend_In		 := Business_Risk_BIP.Constants.BIPBestAppend.Default : STORED('BIPBestAppend');
	UNSIGNED1 OFAC_Version_In      := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	REAL Global_Watchlist_Threshold_In := Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');

layout_watchlists_temp := record
    dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
  end;

  watchlist_options := dataset([],layout_watchlists_temp) : stored('Watchlists_Requested', few);
  Watchlists_Requested_In := watchlist_options[1].WatchList;
	
  // Output Options
	UNSIGNED4 OutputRecordCount_In := 100 : STORED('OutputRecordCount');
	BOOLEAN IncludeAll_In							:= FALSE : STORED('IncludeAll');
	BOOLEAN IncludeLinkingResults_In	:= FALSE : STORED('IncludeLinkingResults');
	BOOLEAN IncludeBusinessHeader_In	:= FALSE : STORED('IncludeBusinessHeader');
	BOOLEAN IncludeEBR_In	:= FALSE : STORED('IncludeEBR');
	BOOLEAN IncludeDNBDMI_In	:= FALSE : STORED('IncludeDNBDMI');
	BOOLEAN IncludeBusReg_In	:= FALSE : STORED('IncludeBusReg');
	BOOLEAN IncludeDCA_In	:= FALSE : STORED('IncludeDCA');
	BOOLEAN IncludeDEADCO_In	:= FALSE : STORED('IncludeDEADCO');
	BOOLEAN IncludeABIUS_In	:= FALSE : STORED('IncludeABIUS');
	BOOLEAN IncludeInquiriesBus_In	:= FALSE : STORED('IncludeInquiriesBus');
	BOOLEAN IncludeLiensJudgments_In	:= FALSE : STORED('IncludeLiensJudgments');
	BOOLEAN IncludeOSHA_In	:= FALSE : STORED('IncludeOSHA');
	BOOLEAN IncludeBBB_In	:= FALSE : STORED('IncludeBBB');
	BOOLEAN IncludeFBN_In	:= FALSE : STORED('IncludeFBN');
	BOOLEAN IncludeIRS990_In	:= FALSE : STORED('IncludeIRS990NonProfit');
	BOOLEAN IncludeUtility_In	:= FALSE : STORED('IncludeUtility');
	BOOLEAN IncludePropertyAssessments_In	:= FALSE : STORED('IncludePropertyAssessments');
	BOOLEAN IncludePropertyDeeds_In	:= FALSE : STORED('IncludePropertyDeeds');
	BOOLEAN IncludeTradelines_In	:= FALSE : STORED('IncludeTradelines');
	BOOLEAN IncludeUCC_In	:= FALSE : STORED('IncludeUCC');
	BOOLEAN IncludeCorpFilings_In	:= FALSE : STORED('IncludeCorpFilings');
	BOOLEAN IncludeBankruptcy_In	:= FALSE : STORED('IncludeBankruptcy');
	BOOLEAN IncludeWatchlist_In := FALSE : STORED('IncludeWatchlistSearch');
	BOOLEAN IncludeProfLic_In := FALSE : STORED('IncludeProfessionalLicense');
	BOOLEAN IncludeSBFE_In := FALSE : STORED('IncludeSBFE');
	BOOLEAN IncludeCortera_In := FALSE : STORED('IncludeCortera');
	UNSIGNED1 KeepLargeBusinesses_In  := Business_Risk_BIP.Constants.DefaultJoinType : STORED('KeepLargeBusinesses');
	BOOLEAN OverrideExperianRestriction_In := FALSE : STORED('OverrideExperianRestriction');

  gateways_in := Gateway.Configuration.Get();

	/* ************************************************************************
	 *              Create the Appropriate Library Interface                  *
	 ************************************************************************ */
	// NOTE: If you change this you MUST redeploy the Library as the interface has changed.
	emptyRecord := dataset([{1}], {unsigned a});
	
	Business_Risk_BIP.Layouts.Input grabInput(emptyRecord le, UNSIGNED1 c) := TRANSFORM
		SELF.Seq := c;
		SELF.AcctNo := (STRING)c;
		SELF.CompanyName := CompanyName;
		SELF.AltCompanyName := AltCompanyName;
		SELF.StreetAddress1 := StreetAddress1;
		SELF.StreetAddress2 := StreetAddress2;
		SELF.City := City;
		SELF.State := State;
		SELF.Zip := IF(TRIM(Zip9) <> '', Zip9, TRIM(Zip5 + Zip4, LEFT, RIGHT));
		SELF.Prim_Range := Prim_Range;
		SELF.PreDir := PreDir;
		SELF.Prim_Name := Prim_Name;
		SELF.Addr_Suffix := Addr_Suffix;
		SELF.PostDir := PostDir;
		SELF.Unit_Desig := Unit_Desig;
		SELF.Sec_Range := Sec_Range;
		SELF.Zip5 := Zip5;
		SELF.Zip4 := Zip4;
		SELF.Lat := Lat;
		SELF.Long := Long;
		SELF.Addr_Type := Addr_Type; 
		SELF.Addr_Status := Addr_Status;
		SELF.County := County;
		SELF.Geo_Block := Geo_Block;
		SELF.FEIN := FEIN[1..9];
		SELF.Phone10 := Phone10;
		SELF.IPAddr := IPAddr;
		SELF.CompanyURL := CompanyURL;
		SELF.PowID := PowID;
		SELF.ProxID := ProxID;
		SELF.SeleID := SeleID;
		SELF.OrgID := OrgID;
		SELF.UltID := UltID;
		SELF.Rep_FullName := Rep_FullName;
		SELF.Rep_NameTitle := Rep_NameTitle;
		SELF.Rep_FirstName := Rep_FirstName;
		SELF.Rep_MiddleName := Rep_MiddleName;
		SELF.Rep_LastName := Rep_LastName;
		SELF.Rep_NameSuffix := Rep_NameSuffix;
		SELF.Rep_FormerLastName := Rep_FormerLastName;
		SELF.Rep_StreetAddress1 := Rep_StreetAddress1;
		SELF.Rep_StreetAddress2 := Rep_StreetAddress2;
		SELF.Rep_City := Rep_City;
		SELF.Rep_State := Rep_State;
		SELF.Rep_Zip := Rep_Zip;
		SELF.Rep_Prim_Range := Rep_Prim_Range;
		SELF.Rep_PreDir := Rep_PreDir;
		SELF.Rep_Prim_Name := Rep_Prim_Name;
		SELF.Rep_Addr_Suffix := Rep_Addr_Suffix;
		SELF.Rep_PostDir := Rep_PostDir;
		SELF.Rep_Unit_Desig := Rep_Unit_Desig;
		SELF.Rep_Sec_Range := Rep_Sec_Range;
		SELF.Rep_Zip5 := Rep_Zip5;
		SELF.Rep_Zip4 := Rep_Zip4;
		SELF.Rep_Lat := Rep_Lat;
		SELF.Rep_Long := Rep_Long;
		SELF.Rep_Addr_Type := Rep_Addr_Type;
		SELF.Rep_Addr_Status := Rep_Addr_Status;
		SELF.Rep_County := Rep_County;
		SELF.Rep_Geo_Block := Rep_Geo_Block;
		SELF.Rep_SSN := Rep_SSN;
		SELF.Rep_DateOfBirth := Rep_DateOfBirth;
		SELF.Rep_Phone10 := Rep_Phone10;
		SELF.Rep_Age := Rep_Age;
		SELF.Rep_DLNumber := Rep_DLNumber;
		SELF.Rep_DLState := Rep_DLState;
		SELF.Rep_Email := Rep_Email;
		SELF.Rep_LexID := Rep_LexID;
		
		SELF.HistoryDate := (UNSIGNED3)(((STRING12)HistoryDate)[1..6]);
		SELF.HistoryDateTime := HistoryDate;
		SELF := [];
	END;
	
	Input := PROJECT(dataset([{1}], {unsigned a}), grabInput(LEFT, COUNTER));
	
	options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
		// Clean up the Options and make sure that defaults are enforced
		EXPORT UNSIGNED1	DPPA_Purpose 				:= DPPA_Purpose_In;
		EXPORT UNSIGNED1	GLBA_Purpose 				:= GLBA_Purpose_In;
		EXPORT STRING50		DataRestrictionMask	:= IF(DataRestrictionMask_In = '', 
																							Business_Risk_BIP.Constants.Default_DataRestrictionMask, 
																							DataRestrictionMask_In);
		EXPORT STRING50		DataPermissionMask	:= IF(DataPermissionMask_In = '', 
																							Business_Risk_BIP.Constants.Default_DataPermissionMask, 
																							DataPermissionMask_In);
		EXPORT STRING10		IndustryClass				:= IndustryClass_In;
		EXPORT UNSIGNED1	LinkSearchLevel			:= IF(LinkSearchLevel_In BETWEEN Business_Risk_BIP.Constants.LinkSearch.Default AND Business_Risk_BIP.Constants.LinkSearch.UltID, 
																							LinkSearchLevel_In, 
																							Business_Risk_BIP.Constants.LinkSearch.Default);
		EXPORT UNSIGNED1	BusShellVersion			:= Business_Risk_BIP.Constants.Default_BusShellVersion;
		EXPORT UNSIGNED1	MarketingMode				:= MAX(MIN(MarketingMode_In, 1), 0);
		EXPORT STRING50		AllowedSources			:= StringLib.StringToUpperCase(AllowedSources_In);
		EXPORT UNSIGNED1	BIPBestAppend				:= MAX(MIN(BIPBestAppend_In, Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest), Business_Risk_BIP.Constants.BIPBestAppend.Default);
		EXPORT UNSIGNED1	OFAC_Version				:= MAX(MIN(OFAC_Version_In, 4), 0);
    EXPORT DATASET(Gateway.Layouts.Config) Gateways 									:= gateways_in;
		EXPORT REAL				Global_Watchlist_Threshold	:= if(OFAC_Version in [1, 2, 3], 0.84, 0.85);
		EXPORT DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Watchlists_Requested_In;
		EXPORT UNSIGNED1	KeepLargeBusinesses	:= MAX(MIN(KeepLargeBusinesses_In, 1), 0);
		EXPORT BOOLEAN		OverrideExperianRestriction := OverrideExperianRestriction_In;
    EXPORT BOOLEAN 		Include_OFAC 																		:= if(OFAC_Version = 1, false, true);
	END;
	
	// Define the default interface for output options
	OutputInterface := INTERFACE
		EXPORT UNSIGNED4	OutputRecordCount		:= 100;
		EXPORT BOOLEAN		IncludeAll					:= FALSE;
		EXPORT BOOLEAN		IncludeABIUS				:= FALSE;
		EXPORT BOOLEAN		IncludeBankruptcy		:= FALSE;
		EXPORT BOOLEAN		IncludeBBB					:= FALSE;
		EXPORT BOOLEAN		IncludeBusinessHeader	:= FALSE;
		EXPORT BOOLEAN		IncludeBusReg				:= FALSE;
		EXPORT BOOLEAN		IncludeCorpFilings	:= FALSE;
    EXPORT BOOLEAN    IncludeCortera      := FALSE;
		EXPORT BOOLEAN		IncludeDCA					:= FALSE;
		EXPORT BOOLEAN		IncludeDEADCO				:= FALSE;
		EXPORT BOOLEAN		IncludeDNBDMI				:= FALSE;
		EXPORT BOOLEAN		IncludeEBR					:= FALSE;
		EXPORT BOOLEAN		IncludeFBN					:= FALSE;
		EXPORT BOOLEAN		IncludeInquiriesBus	:= FALSE;
		EXPORT BOOLEAN		IncludeIRS990				:= FALSE;
		EXPORT BOOLEAN		IncludeLiensJudgments	:= FALSE;
		EXPORT BOOLEAN		IncludeLinkingResults	:= FALSE;
		EXPORT BOOLEAN		IncludeOSHA					:= FALSE;
		EXPORT BOOLEAN		IncludePropertyAssessments	:= FALSE;
		EXPORT BOOLEAN		IncludePropertyDeeds	:= FALSE;
		EXPORT BOOLEAN		IncludeTradelines		:= FALSE;
		EXPORT BOOLEAN		IncludeUCC					:= FALSE;
		EXPORT BOOLEAN		IncludeUtility			:= FALSE;
		EXPORT BOOLEAN		IncludeWatchlist		:= FALSE;
		EXPORT BOOLEAN		IncludeSBFE		      := FALSE;
	END;
	// Grab the output options
	outputs := MODULE(OutputInterface)
		EXPORT UNSIGNED4 OutputRecordCount := OutputRecordCount_In;
		EXPORT BOOLEAN IncludeAll := IncludeAll_In;
		EXPORT INTEGER OFAC_Version := OFAC_Version_In;
		EXPORT BOOLEAN IncludeABIUS := IncludeABIUS_In;
		EXPORT BOOLEAN IncludeBankruptcy := IncludeBankruptcy_In;
		EXPORT BOOLEAN IncludeBBB := IncludeBBB_In;
		EXPORT BOOLEAN IncludeBusinessHeader := IncludeBusinessHeader_In;
		EXPORT BOOLEAN IncludeBusReg := IncludeBusReg_In;
		EXPORT BOOLEAN IncludeCorpFilings := IncludeCorpFilings_In;
    EXPORT BOOLEAN IncludeCortera := IncludeCortera_In;
		EXPORT BOOLEAN IncludeDCA := IncludeDCA_In;
		EXPORT BOOLEAN IncludeDEADCO := IncludeDEADCO_In;
		EXPORT BOOLEAN IncludeDNBDMI := IncludeDNBDMI_In;
		EXPORT BOOLEAN IncludeEBR := IncludeEBR_In;
		EXPORT BOOLEAN IncludeFBN := IncludeFBN_In;
		EXPORT BOOLEAN IncludeInquiriesBus := IncludeInquiriesBus_In;
		EXPORT BOOLEAN IncludeIRS990 := IncludeIRS990_In;
		EXPORT BOOLEAN IncludeLiensJudgments := IncludeLiensJudgments_In;
		EXPORT BOOLEAN IncludeLinkingResults := IncludeLinkingResults_In;
		EXPORT BOOLEAN IncludeOSHA := IncludeOSHA_In;
		EXPORT BOOLEAN IncludePropertyAssessments := IncludePropertyAssessments_In;
		EXPORT BOOLEAN IncludePropertyDeeds := IncludePropertyDeeds_In;
		EXPORT BOOLEAN IncludeTradelines := IncludeTradelines_In;
		EXPORT BOOLEAN IncludeUCC := IncludeUCC_In;
		EXPORT BOOLEAN IncludeUtility := IncludeUtility_In;
		EXPORT BOOLEAN IncludeWatchlist := IncludeWatchlist_In;
		EXPORT BOOLEAN IncludeProfLic := IncludeProfLic_In;
		EXPORT BOOLEAN IncludeSBFE := IncludeSBFE_In;
	END;
	
	// Generate the linking parameters to be used in BIP's kFetch (Key Fetch) - These parameters should be global so figure them out here and pass around appropriately
	linkingOptions := MODULE(BIPV2.mod_sources.iParams)
		EXPORT STRING DataRestrictionMask		:= Options.DataRestrictionMask; // Note: Must unfortunately leave as undefined STRING length to match the module definition
		EXPORT UNSIGNED1 GLBPurpose					:= Options.GLBA_Purpose;
		EXPORT BOOLEAN AllowGLB							:= Risk_Indicators.iid_constants.GLB_OK(Options.GLBA_Purpose, FALSE /*isFCRA*/);
		EXPORT UNSIGNED1 DPPAPurpose				:= Options.DPPA_Purpose;
		EXPORT BOOLEAN AllowDPPA						:= Risk_Indicators.iid_constants.DPPA_OK(Options.DPPA_Purpose, FALSE /*isFCRA*/);
		EXPORT BOOLEAN AllowAll							:= IF(Options.AllowedSources = Business_Risk_BIP.Constants.AllowDNBDMI, TRUE, FALSE); // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
		EXPORT BOOLEAN ignoreFares					:= FALSE; // Include FARES data as appropriate
		EXPORT BOOLEAN ignoreFidelity				:= FALSE; // Include Fidelity data as appropriate
		EXPORT BOOLEAN IncludeMinors				:= TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
		EXPORT BOOLEAN LNBranded						:= TRUE; // Not entirely certain what effect this has
	END;
	
	// Clean up the input - parse the name, address, clean SSN, clean Phone, etc.
	Business_Risk_BIP.Layouts.Shell cleanInput(Business_Risk_BIP.Layouts.Input le, UNSIGNED2 seqCounter) := TRANSFORM
		SELF.Seq := seqCounter; // Uniquely Sequence our input
		SELF.Clean_Input.Seq := seqCounter;
		
		SELF.Input_Echo := le; // Keep our original input
		
		// Company Name Fields
		CompanyName := IF(le.CompanyName <> '', BizLinkFull.Fields.Make_cnp_name(le.CompanyName), BizLinkFull.Fields.Make_cnp_name(le.AltCompanyName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
		SELF.Clean_Input.CompanyName := CompanyName;
		SELF.Clean_Input.AltCompanyName := IF(le.CompanyName <> '', BizLinkFull.Fields.Make_cnp_name(le.AltCompanyName), ''); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line
		// Company Address Fields
		companyAddress := Risk_Indicators.MOD_AddressClean.street_address(le.StreetAddress1 + ' ' + le.StreetAddress2, le.Prim_Range, le.Predir, le.Prim_Name, le.Addr_Suffix, le.Postdir, le.Unit_Desig, le.Sec_Range);
		companyCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(companyAddress, le.City, le.State, le.Zip);											
		cleanedCompanyAddress := Address.CleanFields(companyCleanAddr);
		SELF.Clean_Input.StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Predir, cleanedCompanyAddress.Prim_Name, 
																											cleanedCompanyAddress.Addr_Suffix, cleanedCompanyAddress.Postdir, cleanedCompanyAddress.Unit_Desig, cleanedCompanyAddress.Sec_Range);
		SELF.Clean_Input.StreetAddress2 := TRIM(StringLib.StringToUppercase(le.StreetAddress2));
		SELF.Clean_Input.Prim_Range := cleanedCompanyAddress.Prim_Range;
		SELF.Clean_Input.Predir := cleanedCompanyAddress.Predir;
		SELF.Clean_Input.Prim_Name := cleanedCompanyAddress.Prim_Name;
		SELF.Clean_Input.Addr_Suffix := cleanedCompanyAddress.Addr_Suffix;
		SELF.Clean_Input.Postdir := cleanedCompanyAddress.Postdir;
		SELF.Clean_Input.Unit_Desig := cleanedCompanyAddress.Unit_Desig;
		SELF.Clean_Input.Sec_Range := cleanedCompanyAddress.Sec_Range;
		SELF.Clean_Input.City := cleanedCompanyAddress.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.State := cleanedCompanyAddress.St;
		SELF.Clean_Input.Zip := cleanedCompanyAddress.Zip + cleanedCompanyAddress.Zip4;
		SELF.Clean_Input.Zip5 := cleanedCompanyAddress.Zip;
		SELF.Clean_Input.Zip4 := cleanedCompanyAddress.Zip4;
		SELF.Clean_Input.Lat := cleanedCompanyAddress.Geo_Lat;
		SELF.Clean_Input.Long := cleanedCompanyAddress.Geo_Long;
		SELF.Clean_Input.Addr_Type := cleanedCompanyAddress.Rec_Type;
		SELF.Clean_Input.Addr_Status := cleanedCompanyAddress.Err_Stat;
		SELF.Clean_Input.County := companyCleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Geo_Block := cleanedCompanyAddress.Geo_Blk;
		// Company Other PII
		filteredFEIN := StringLib.StringFilter(le.FEIN, '0123456789');
		SELF.Clean_Input.FEIN := IF(LENGTH(filteredFEIN) != 9 OR (INTEGER)filteredFEIN <= 0, '', filteredFEIN); // Filter out FEIN's that aren't 9-Bytes, or are repeating 0's
		BusPhone10 := RiskWise.CleanPhone(le.Phone10);
		SELF.Clean_Input.Phone10 := BusPhone10;
		SELF.Clean_Input.IPAddr := StringLib.StringFilter(le.IPAddr, '0123456789.');
		SELF.Clean_Input.CompanyURL := REGEXREPLACE('^WWW[. ]{0,1}',TRIM(REGEXREPLACE('[:/].*$',REGEXREPLACE('HTTP://',le.CompanyURL,'',NOCASE),''),LEFT,RIGHT),'',NOCASE);
		// Authorized Representative Name Fields
		cleanedName := Address.CleanPerson73(le.Rep_FullName);
		cleanedRepName := Address.CleanNameFields(cleanedName);
		BOOLEAN validCleaned := TRIM(le.Rep_FullName) <> '';
		SELF.Clean_Input.Rep_FullName := StringLib.StringToUpperCase(le.Rep_FullName);
		SELF.Clean_Input.Rep_NameTitle := TRIM(StringLib.StringToUppercase(IF(le.Rep_NameTitle = '' AND validCleaned,		cleanedRepName.Title, le.Rep_NameTitle)), LEFT, RIGHT);
		RepFirstName := TRIM(StringLib.StringToUppercase(IF(le.Rep_FirstName = '' AND validCleaned,		cleanedRepName.FName, le.Rep_FirstName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep_FirstName := RepFirstName;
		RepPreferredFirstName := StringLib.StringToUpperCase(NID.PreferredFirstNew(RepFirstName, TRUE /*UseNew*/));
		SELF.Clean_Input.Rep_PreferredFirstName := RepPreferredFirstName;
		SELF.Clean_Input.Rep_MiddleName := TRIM(StringLib.StringToUppercase(IF(le.Rep_MiddleName = '' AND validCleaned,	cleanedRepName.MName, le.Rep_MiddleName)), LEFT, RIGHT);
		RepLastName := TRIM(StringLib.StringToUppercase(IF(le.Rep_LastName = '' AND validCleaned,			cleanedRepName.LName, le.Rep_LastName)), LEFT, RIGHT);
		SELF.Clean_Input.Rep_LastName := RepLastName;
		SELF.Clean_Input.Rep_NameSuffix := TRIM(StringLib.StringToUppercase(IF(le.Rep_NameSuffix = '' AND validCleaned,	cleanedRepName.Name_Suffix, le.Rep_NameSuffix)), LEFT, RIGHT);
		SELF.Clean_Input.Rep_FormerLastName := TRIM(StringLib.StringToUppercase(le.Rep_FormerLastName), LEFT, RIGHT);
		// Authorized Representative Address Fields
		repAddress := Risk_Indicators.MOD_AddressClean.street_address(le.Rep_StreetAddress1 + ' ' + le.Rep_StreetAddress2, le.Rep_Prim_Range, le.Rep_Predir, le.Rep_Prim_Name, le.Rep_Addr_Suffix, le.Rep_Postdir, le.Rep_Unit_Desig, le.Rep_Sec_Range);
		repCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(companyAddress, le.Rep_City, le.Rep_State, le.Rep_Zip);											
		cleanedRepAddress := Address.CleanFields(repCleanAddr);
		SELF.Clean_Input.Rep_StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedRepAddress.Prim_Range, cleanedRepAddress.Predir, cleanedRepAddress.Prim_Name, 
																											cleanedRepAddress.Addr_Suffix, cleanedRepAddress.Postdir, cleanedRepAddress.Unit_Desig, cleanedRepAddress.Sec_Range);
		SELF.Clean_Input.Rep_StreetAddress2 := TRIM(StringLib.StringToUppercase(le.Rep_StreetAddress2));
		SELF.Clean_Input.Rep_Prim_Range := cleanedRepAddress.Prim_Range;
		SELF.Clean_Input.Rep_Predir := cleanedRepAddress.Predir;
		SELF.Clean_Input.Rep_Prim_Name := cleanedRepAddress.Prim_Name;
		SELF.Clean_Input.Rep_Addr_Suffix := cleanedRepAddress.Addr_Suffix;
		SELF.Clean_Input.Rep_Postdir := cleanedRepAddress.Postdir;
		SELF.Clean_Input.Rep_Unit_Desig := cleanedRepAddress.Unit_Desig;
		SELF.Clean_Input.Rep_Sec_Range := cleanedRepAddress.Sec_Range;
		SELF.Clean_Input.Rep_City := cleanedRepAddress.V_City_Name;  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.Rep_State := cleanedRepAddress.St;
		SELF.Clean_Input.Rep_Zip := cleanedRepAddress.Zip + cleanedRepAddress.Zip4;
		SELF.Clean_Input.Rep_Zip5 := cleanedRepAddress.Zip;
		SELF.Clean_Input.Rep_Zip4 := cleanedRepAddress.Zip4;
		SELF.Clean_Input.Rep_Lat := cleanedRepAddress.Geo_Lat;
		SELF.Clean_Input.Rep_Long := cleanedRepAddress.Geo_Long;
		SELF.Clean_Input.Rep_Addr_Type := cleanedRepAddress.Rec_Type;
		SELF.Clean_Input.Rep_Addr_Status := cleanedRepAddress.Err_Stat;
		SELF.Clean_Input.Rep_County := repCleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Rep_Geo_Block := cleanedRepAddress.Geo_Blk;
		// Authorized Representative Other PII
		filteredSSN := StringLib.StringFilter(le.Rep_SSN, '0123456789');
		SELF.Clean_Input.Rep_SSN := IF(LENGTH(filteredSSN) != 9 OR (INTEGER)filteredSSN <= 0, '', filteredSSN); // Filter out SSN's that aren't 9-Bytes, or are repeating 0's
		SELF.Clean_Input.Rep_DateOfBirth := RiskWise.CleanDOB(le.Rep_DateOfBirth);
		RepPhone10 := RiskWise.CleanPhone(le.Rep_Phone10);
		SELF.Clean_Input.Rep_Phone10 := RepPhone10;
		SELF.Clean_Input.Rep_Age := IF((INTEGER)le.Rep_Age = 0 AND (INTEGER)le.Rep_DateOfBirth != 0, (STRING3)ut.Age((INTEGER)le.Rep_DateOfBirth), (le.Rep_Age));
		SELF.Clean_Input.Rep_DLNumber := RiskWise.CleanDL_Num(le.Rep_DLNumber);
		SELF.Clean_Input.Rep_DLState := StringLib.StringToUpperCase(TRIM(le.Rep_DLState, LEFT, RIGHT));
		SELF.Clean_Input.Rep_Email := StringLib.StringToUpperCase(TRIM(le.Rep_Email, LEFT, RIGHT));
		
		SELF.Clean_Input.HistoryDate := IF(le.HistoryDate <= 0, (INTEGER)Business_Risk_BIP.Constants.NinesDate, le.HistoryDate); // If HistoryDate no populated run in "realtime" mode
		
		SELF.Clean_Input := le; // Fill out the remaining fields with what was passed in
		
		SELF := []; // None of the remaining attributes have been populated yet
	END;
	cleanedInput := PROJECT(Input, cleanInput(LEFT, COUNTER));
	
	// For the AllowedSourcesSet, only include the Dunn Bradstreet source if that source is explicitly 
	// allowed and drop any unallowed Marketing sources when Marketing Mode is turned on. Also, filter 
	// out Experian data for those Scoring products intended primarily for the purpose of commercial 
	// credit origination. E.g.:
	//   o   Small Business Attributes
	//   o   Small Business Attributes with SBFE Data
	//   o   Small Business Credit Score with SBFE Data
	//   o   Small Business Blended Credit Score with SBFE Data
	//   o   Small Business Risk Score
	AllowedSourcesSet := 
			SET(
				CHOOSEN(
					Business_Risk_BIP.Constants.AllowedSources(
							(
								Source <> MDR.SourceTools.src_Dunn_Bradstreet OR 
								StringLib.StringFind(Options.AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1) > 0
							) AND
							(
								Options.MarketingMode = Business_Risk_BIP.Constants.Default_MarketingMode OR 
								Source NOT IN SET(Business_Risk_BIP.Constants.MarketingRestrictedSources, Source)
							) AND
							(
								Options.OverrideExperianRestriction = True OR
								Source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source)
							)
					), 
					300
				), 
				Source ) + [MDR.SourceTools.src_Cortera_Tradeline];
	
	Risk_Indicators.Layout_Input prepForDIDAppend(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
		SELF.Seq := le.Clean_Input.Seq;
		SELF.HistoryDate := le.Clean_Input.HistoryDate;
		SELF.Title := le.Clean_Input.Rep_NameTitle;
		SELF.FName := le.Clean_Input.Rep_FirstName;
		SELF.MName := le.Clean_Input.Rep_MiddleName;
		SELF.LName := le.Clean_Input.Rep_LastName;
		SELF.Suffix := le.Clean_Input.Rep_NameSuffix;
		SELF.In_StreetAddress := le.Clean_Input.Rep_StreetAddress1;
		SELF.In_City := le.Clean_Input.Rep_City;
		SELF.In_State := le.Clean_Input.Rep_State;
		SELF.In_ZipCode := le.Clean_Input.Rep_Zip;
		SELF.Prim_Range := le.Clean_Input.Rep_Prim_Range;
		SELF.Predir := le.Clean_Input.Rep_Predir;
		SELF.Prim_Name := le.Clean_Input.Rep_Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Rep_Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Rep_Postdir;
		SELF.Unit_Desig := le.Clean_Input.Rep_Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Rep_Sec_Range;
		SELF.P_City_Name := le.Clean_Input.Rep_City;
		SELF.St := le.Clean_Input.Rep_State;
		SELF.Z5 := le.Clean_Input.Rep_Zip5;
		SELF.Zip4 := le.Clean_Input.Rep_Zip4;
		SELF.Lat := le.Clean_Input.Rep_Lat;
		SELF.Long := le.Clean_Input.Rep_Long;
		SELF.County := le.Clean_Input.Rep_County;
		SELF.Geo_Blk := le.Clean_Input.Rep_Geo_Block;
		SELF.Addr_Type := le.Clean_Input.Rep_Addr_Type;
		SELF.Addr_Status := le.Clean_Input.Rep_Addr_Status;
		SELF.SSN := le.Clean_Input.Rep_SSN;
		SELF.DOB := le.Clean_Input.Rep_DateOfBirth;
		SELF.Age := le.Clean_Input.Rep_Age;
		SELF.DL_Number := le.Clean_Input.Rep_DLNumber;
		SELF.DL_State := le.Clean_Input.Rep_DLState;
		SELF.Email_Address := le.Clean_Input.Rep_Email;
		SELF.Phone10 := le.Clean_Input.Rep_Phone10;
		
		SELF := [];
	END;
	prepDIDAppend := PROJECT(cleanedInput, prepForDIDAppend(LEFT));
	
	DIDAppend := Risk_Indicators.iid_getDID_prepOutput(prepDIDAppend,
																										Options.DPPA_Purpose,
																										Options.GLBA_Purpose,
																										FALSE, /*isFCRA*/
																										50, /*BSVersion*/
																										Options.DataRestrictionMask,
																										0, /*Append_Best*/
																										DATASET([], Gateway.Layouts.Config), /*Gateways*/
																										0 /*BSOptions*/);
                                                    
   if(options.OFAC_Version = 4 and not exists(options.Gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));
																										
	// Pick the DID with the highest score, in the event that multiple have the same score, choose the lowest value DID to make this deterministic
	DIDKept := ROLLUP(SORT(DIDAppend, Seq, -Score, DID), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));
	
	withDID := JOIN(cleanedInput, DIDKept, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell, 
																																				SELF.Clean_Input.Rep_LexID := RIGHT.DID;
																																				SELF.Clean_Input.Rep_LexIDScore := RIGHT.Score;
																																				SELF := LEFT),
																					LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// Grab just the clean input to pass to the BIP Linking Process
	prepBIPAppend := PROJECT(withDID, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF := LEFT.Clean_Input));
	
	// Prepare the BIP Append input - These should be clean coming in
	BIPV2.IDFunctions.rec_SearchInput prepBIPInput(Business_Risk_BIP.Layouts.Input le, BOOLEAN useAlt) := TRANSFORM
		SELF.company_name := IF(useAlt = FALSE, le.CompanyName, le.AltCompanyName);
		SELF.prim_range := le.Prim_Range;
		SELF.prim_name := le.Prim_Name;
		SELF.zip5 := le.Zip5;
		SELF.sec_range := le.Sec_Range;
		SELF.city := le.City;
		SELF.state := le.State;
		SELF.phone10 := le.Phone10;
		SELF.fein := le.FEIN;
		SELF.URL := le.CompanyURL;
		SELF.Email := le.Rep_Email;
		SELF.Contact_fname := le.Rep_FirstName;
		SELF.Contact_mname := le.Rep_MiddleName;
		SELF.Contact_lname := le.Rep_LastName;
		SELF.contact_ssn := le.Rep_SSN;
		SELF.contact_did := le.Rep_LexID;
		SELF.acctno := (STRING)le.Seq; // Use the AcctNo field to merge back to the original Seq number
		// Everything below is default values
		SELF.zip_radius_miles := 0;
		SELF.sic_code := ''; // Filter results by Sic_Code (Filter results out) - Blank returns all records
		SELF.results_limit := 0; // Limit the number of results - 0 returns all possible results
		SELF.inSeleid := ''; // Specific SeleID to search for - 0 does default searching
		SELF.allow7DigitMatch := FALSE; // Allows for 7 digit match on Phone10
		SELF.HSort := FALSE;
	END;
	// Check to see if there was a unique AltCompanyName entered as well - attempt to use that for linking in case the primary company name finds nothing
	AlsoSearchFor := prepBIPAppend (AltCompanyName NOT IN ['', CompanyName]);

	BIPSearchInputMain := PROJECT(prepBIPAppend, prepBIPInput(LEFT, FALSE));
	
	BIPSearchInputAlt := PROJECT(AlsoSearchFor, prepBIPInput(LEFT, TRUE));
	
	BIPSearchInput := BIPSearchInputMain + BIPSearchInputAlt;

	// Fetch all Link IDs.  This is a non-restricted source search.
	// LinkIDsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(BIPSearchInput).Data2_;
	LinkIDsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(BIPSearchInput).UnsuppressedData2_;
	
	BIPAppend := Business_Risk_BIP.BIP_LinkID_Append(prepBIPAppend);
	
	withBIP := JOIN(withDID, BIPAppend, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																																				SELF.BIP_IDs := RIGHT;
																																				SELF.Verification.InputIDMatchPowID		:= (STRING)RIGHT.PowID.LinkID;
																																				SELF.Verification.InputIDMatchProxID	:= (STRING)RIGHT.ProxID.LinkID;
																																				SELF.Verification.InputIDMatchSeleID	:= (STRING)RIGHT.SeleID.LinkID;
																																				SELF.Verification.InputIDMatchOrgID		:= (STRING)RIGHT.OrgID.LinkID;
																																				SELF.Verification.InputIDMatchUltID		:= (STRING)RIGHT.UltID.LinkID;
																																				SELF := LEFT),
																					LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// Don't bother running a bunch of searches on Seq's that didn't find any ID's, just add them back at the end
	NoLinkIDsFound := withBIP (BIP_IDs.PowID.LinkID = 0 AND BIP_IDs.ProxID.LinkID = 0 AND BIP_IDs.SeleID.LinkID = 0 AND BIP_IDs.OrgID.LinkID = 0 AND BIP_IDs.UltID.LinkID = 0);
	// Only run the searches with Seq's that found BIP Link ID's that we can search with
	LinkIDsFoundTemp := withBIP (BIP_IDs.PowID.LinkID <> 0 OR BIP_IDs.ProxID.LinkID <> 0 OR BIP_IDs.SeleID.LinkID <> 0 OR BIP_IDs.OrgID.LinkID <> 0 OR BIP_IDs.UltID.LinkID <> 0);
	// Append "Best" Company information if only BIP ID's were passed in and it was requested in the Options that we perform the BIPBestAppend process, otherwise this function just returns what was sent to it
	LinkIDsFound := Business_Risk_BIP.BIP_Best_Append(LinkIDsFoundTemp, Options, linkingOptions, AllowedSourcesSet);
	
	cleanedInputSet := PROJECT(LinkIDsFound, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF := LEFT.Clean_Input));
	
	optionsDataset := DATASET([{outputs.OutputRecordCount, outputs.IncludeAll, outputs.IncludeABIUS, outputs.IncludeBankruptcy, outputs.IncludeBBB, outputs.IncludeBusinessHeader, outputs.IncludeBusReg, outputs.IncludeCorpFilings, outputs.IncludeCortera, outputs.IncludeDCA, outputs.IncludeDEADCO, outputs.IncludeDNBDMI, outputs.IncludeEBR, outputs.IncludeFBN, outputs.IncludeInquiriesBus, outputs.IncludeIRS990, outputs.IncludeLiensJudgments, outputs.IncludeLinkingResults, outputs.IncludeOSHA, outputs.IncludePropertyAssessments, outputs.IncludePropertyDeeds, outputs.IncludeSBFE, outputs.IncludeTradelines, outputs.IncludeUCC, outputs.IncludeUtility, outputs.OFAC_Version, outputs.IncludeWatchlist, linkingOptions.DataRestrictionMask, linkingOptions.ignoreFares, linkingOptions.ignoreFidelity, linkingOptions.AllowAll, linkingOptions.AllowGLB, linkingOptions.AllowDPPA, linkingOptions.DPPAPurpose, linkingOptions.GLBPurpose, linkingOptions.IncludeMinors, linkingOptions.LNBranded}], 
													 {UNSIGNED4 OutputRecordCount, BOOLEAN IncludeAll, BOOLEAN IncludeABIUS, BOOLEAN IncludeBankruptcy, BOOLEAN IncludeBBB, BOOLEAN IncludeBusinessHeader, BOOLEAN IncludeBusReg, BOOLEAN IncludeCorpFilings, BOOLEAN IncludeCortera, BOOLEAN IncludeDCA, BOOLEAN IncludeDEADCO, BOOLEAN IncludeDNBDMI, BOOLEAN IncludeEBR, BOOLEAN IncludeFBN, BOOLEAN IncludeInquiriesBus, BOOLEAN IncludeIRS990, BOOLEAN IncludeLiensJudgments, BOOLEAN IncludeLinkingResults, BOOLEAN IncludeOSHA, BOOLEAN IncludePropertyAssessments, BOOLEAN IncludePropertyDeeds, BOOLEAN IncludeSBFE, BOOLEAN IncludeTradelines, BOOLEAN IncludeUCC, BOOLEAN IncludeUtility, Unsigned1 OFAC_Version, BOOLEAN IncludeWatchlist, STRING DataRestrictionMask, BOOLEAN ignoreFares, BOOLEAN ignoreFidelity, BOOLEAN AllowAll, BOOLEAN AllowGLB, BOOLEAN AllowDPPA, UNSIGNED1 DPPAPurpose, UNSIGNED1 GLBPurpose, BOOLEAN IncludeMinors, BOOLEAN LNBranded});
	
	kFetchLinkIDs := Business_Risk_BIP.Common.GetLinkIDs(LinkIDsFound);
	kFetchLinkSearchLevel := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel);
	// --------------- LexisNexis Business Header ----------------
	BHBuildDate := Risk_Indicators.get_Build_date('bheader_build_version');

	BusinessHeader := Business_Risk_BIP.PD_Business_Header(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ---------------- EBR - Experian Business Records ------------------
	EBR5600 := Business_Risk_BIP.PD_EBR5600(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ---------------- DNB DMI - Dunn Bradstreet DMI ------------------
	DNBDMI := Business_Risk_BIP.PD_DNBDMI(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
		
	// ---------------- BusReg - Business Registration ------------------
	BusReg := Business_Risk_BIP.PD_BusReg(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
		// ---------------- DCA - Directory of Corporate Affiliations AKA LNCA ------------------
	DCA := Business_Risk_BIP.PD_DCA(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ---------------- DEADCO ------------------
	DEADCO := Business_Risk_BIP.PD_DEADCO(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ---------------- ABIUS ------------------
	ABIUS := Business_Risk_BIP.PD_ABIUS(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ---------------- Business Inquiries - Only Allowed in Non-Marketing Mode ------------------
	InqBuildDate := Risk_Indicators.get_Build_date('inquiry_update_build_version');

	InquiriesAll := Business_Risk_BIP.PD_Inquiries(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// --------------- Judgments and Liens ----------------
	// Get the TMSID/RMSID results for Liens and Judgments data
	LiensJudgmentsTMSIDRaw := LiensV2.Key_LinkIds.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(LiensJudgmentsTMSIDRaw, LinkIDsFound, LiensJudgmentsTMSIDSeq);
	
	// Filter out records after our history date
	LiensJudgmentsTMSID := Business_Risk_BIP.Common.FilterRecords(LiensJudgmentsTMSIDSeq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_UCCV2, AllowedSourcesSet);
	
	liens_judgments_main :=	JOIN(LiensJudgmentsTMSID, LiensV2.key_liens_main_ID, KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid), TRANSFORM(RIGHT), ATMOST(1000));
	
	
	// ---------------- OSHA - Occupational Safety and Health Administration ------------------
	OSHA := Business_Risk_BIP.PD_OSHA(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	
	// ---------------- Better Business Bureau ------------------
	BBBMember := Business_Risk_BIP.PD_BBB_Member(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	BBBNonMember := Business_Risk_BIP.PD_BBB_NonMember(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	
	// ---------------- Ficticious Business Name ---------------------
	FBN := Business_Risk_BIP.PD_FBN(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ---------------- IRS 990/IRS Non-Profit ------------------------
	IRS990 := Business_Risk_BIP.PD_IRS990(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ---------------- Utility Data ---------------------
	Util := Business_Risk_BIP.PD_Utility(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// --------------- Property Data - Using Business IDs ----------------
	PropertyRaw := LN_PropertyV2.Key_LinkIds.kFetch2(kFetchLinkIDs,
																							kFetchLinkSearchLevel,
																							0, // ScoreThreshold --> 0 = Give me everything
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses
																					 );
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(PropertyRaw, LinkIDsFound, PropertySeq);
	
	// Filter out records after our history date
	Property := Business_Risk_BIP.Common.FilterRecords(PropertySeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_LnPropV2_Fares_Asrs, AllowedSourcesSet);
	
	PropertyAssessments := JOIN(Property, LN_PropertyV2.key_assessor_fid(FALSE /*isFCRA*/), KEYED(LEFT.LN_Fares_ID = RIGHT.LN_Fares_ID),
															TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq}, SELF.Seq := LEFT.Seq; SELF := RIGHT),
															ATMOST(Business_Risk_BIP.Constants.Limit_Assessments));
	
	PropertyDeeds := JOIN(Property, LN_PropertyV2.key_deed_fid(FALSE /*isFCRA*/), KEYED(LEFT.LN_Fares_ID = RIGHT.LN_Fares_ID),
															TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq}, SELF.Seq := LEFT.Seq; SELF := RIGHT),
															ATMOST(Business_Risk_BIP.Constants.Limit_Deeds));
															
	
	// --------------- EBR Data ----------------
	EBRRaw := EBR.Key_0010_Header_linkids.kFetch2(kFetchLinkIDs,
																						 kFetchLinkSearchLevel,
																							0, // ScoreThreshold --> 0 = Give me everything
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses
																							);																	
	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(EBRRaw, LinkIDsFound, EBRSeq);
	
	// Filter out records after our history date.
	EBR_recs := Business_Risk_BIP.Common.FilterRecords(EBRSeq, date_first_seen, process_date_first_seen, MDR.SourceTools.src_EBR, AllowedSourcesSet);
	
	// Get EBR filing numbers from linkids.		
	ebr_filing_numbers_plus_seq := PROJECT( EBR_recs(file_number != ''), {UNSIGNED4 seq, EBR_Services.layout_file_number} );
  
	ebr_filing_numbers_plus_seq_ddpd := DEDUP(ebr_filing_numbers_plus_seq, ALL, HASH);

	header_recs_pre :=	JOIN(ebr_filing_numbers_plus_seq_ddpd, EBR.Key_0010_Header_FILE_NUMBER, KEYED(LEFT.file_number = RIGHT.file_number), TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq}, SELF.Seq := LEFT.Seq, SELF := RIGHT), ATMOST(EBR_Services.constants.maxcounts.default));
	
	// Mimicking what is done in other business queries, we will keep 1 file_number per sequence.  To do this we will keep the most recently processed record, following by most recently last seen, and then lastly the smallest file_number to make it determinate
	header_recs := GROUP(DEDUP(SORT(header_recs_pre, seq, -process_date_last_seen, -date_last_seen, file_number), Seq), seq);
		
	executive_recs_added :=	JOIN(header_recs, ebr.Key_1000_Executive_Summary_FILE_NUMBER,	KEYED(LEFT.file_number = RIGHT.file_number), TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq}, 
				SELF.seq                        := LEFT.seq,
				SELF.process_date               := LEFT.process_date,
				SELF.FILE_NUMBER                := LEFT.file_number,
				SELF := RIGHT), ATMOST(EBR_Services.constants.maxcounts.default));
	
	trade_payment_total_recs_added :=	JOIN(executive_recs_added, ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER,	KEYED(LEFT.file_number = RIGHT.file_number), TRANSFORM(RIGHT), ATMOST(EBR_Services.constants.maxcounts.default));
			

	// --------------- UCC - Uniform Commercial Code ----------------
	UCCDataSeq := Business_Risk_BIP.PD_UCC(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// ------------- Corp2 - Corporate Filings ------------
	CorpFilings_raw := Corp2.Key_LinkIDs.Corp.kfetch2(kFetchLinkIDs,
	                                         kFetchLinkSearchLevel,
	                                         0, // ScoreThreshold --> 0 = Give me everything
																						Business_Risk_BIP.Constants.Limit_Default,
																						Options.KeepLargeBusinesses);

	// Add back our Seq numbers.
	Business_Risk_BIP.Common.AppendSeq2(CorpFilings_raw, LinkIDsFound, CorpFilings_seq);

 // Calculate the source code by state to restrict records for Marketing properly. We'll 
 // borrow corp_src_type for the state source code.
 CorpFilings_withSrcCode := 
  PROJECT(
    CorpFilings_seq,
    TRANSFORM( RECORDOF(CorpFilings_seq),
      SELF.corp_src_type := MDR.sourceTools.fCorpV2( LEFT.corp_key, LEFT.corp_state_origin ),
      SELF := LEFT
    ) );

	// Filter out records after our history date.
	CorpFilings_recs := Business_Risk_BIP.Common.FilterRecords(CorpFilings_withSrcCode, dt_last_seen, dt_vendor_first_reported, corp_src_type, AllowedSourcesSet);
	
	
	// ------------ Bankruptcy Build Date -------------
	BkBuildDate := Risk_Indicators.get_Build_date('Bankruptcy_daily');
	
	// --------------- Bankruptcy Data ----------------
	Bankruptcy := Business_Risk_BIP.PD_Bankruptcy(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	
	// Only turn on watchlist searching if explicitly specified, unlike the others where we include them with the "ALL" results
	WatchlistResults := Business_Risk_BIP.getWatchlists(LinkIDsFound, Options, linkingOptions, AllowedSourcesSet);
	
	// --------------- Professional License data ----------------
	ProfLic := Business_Risk_BIP.PD_ProfLic(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, AllowedSourcesSet);
                  
	// --------------- SBFE data ----------------
	SBFE := Business_Risk_BIP.PD_SBFE(LinkIDsFound, options, linkingOptions, AllowedSourcesSet).SBFE_data_raw;
	
  // --------------- Cortera data ----------------
  Cortera := Business_Risk_BIP.PD_Cortera(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
  CorteraRecs := Cortera.CorteraRecs;
  Cortera_Attribute_recs := Cortera.Cortera_Attribute_recs;
  Cortera_Tradelines := Business_Risk_BIP.PD_Cortera_Tradelines(LinkIDsFound, kFetchLinkIDs, kFetchLinkSearchLevel, linkingOptions, options, AllowedSourcesSet);
	// Keep all of the outputs at the end so that we can keep them sorted more easily, and so that the function compiles
	// Inputs/Options - By outputting these two here we are forcing OSS to display the fields on the form in an order that makes sense and that we control
	OUTPUT(Input, NAMED('Raw_Input'));
	OUTPUT(CHOOSEN(cleanedInput, outputs.OutputRecordCount), NAMED('Cleaned_Input'));
	OUTPUT(optionsDataset, NAMED('ProdData_Options'));
	
	// Linking Results
	IF((outputs.IncludeLinkingResults OR outputs.IncludeAll), OUTPUT(CHOOSEN(PROJECT((LinkIDsFound + NoLinkIDsFound), TRANSFORM(Business_Risk_BIP.Layouts.LinkID_Results, SELF := LEFT.BIP_IDs)), outputs.OutputRecordCount), NAMED('Linking_Results')));
	IF((outputs.IncludeLinkingResults OR outputs.IncludeAll), OUTPUT(CHOOSEN(LinkIDsRaw, outputs.OutputRecordCount), NAMED('Raw_BIPV2_Linking_Results__BIPV2_IDfunctions_fun_IndexedSearchForXLinkIDs_Data2')));
	
	// Business Header
	IF((outputs.IncludeBusinessHeader OR outputs.IncludeAll), OUTPUT((BHBuildDate), NAMED('Business_Header_Build_Date')));
	IF((outputs.IncludeBusinessHeader OR outputs.IncludeAll), OUTPUT(CHOOSEN((BusinessHeader), outputs.OutputRecordCount), NAMED('Business_Header')));
	
	// The remainder of the datasets output alphabetically
	IF((outputs.IncludeABIUS OR outputs.IncludeAll), OUTPUT(CHOOSEN((ABIUS), outputs.OutputRecordCount), NAMED('ABIUS')));
	IF((outputs.IncludeBankruptcy OR outputs.IncludeAll), OUTPUT((BkBuildDate), NAMED('Bankruptcy_Build_Date')));
	IF((outputs.IncludeBankruptcy OR outputs.IncludeAll), OUTPUT(CHOOSEN((Bankruptcy (TRIM(Name_Type) = 'D')), outputs.OutputRecordCount), NAMED('Bankruptcy')));
	IF((outputs.IncludeBBB OR outputs.IncludeAll), OUTPUT(CHOOSEN((BBBMember), outputs.OutputRecordCount), NAMED('BBB_Member')));
	IF((outputs.IncludeBBB OR outputs.IncludeAll), OUTPUT(CHOOSEN((BBBNonMember), outputs.OutputRecordCount), NAMED('BBB_Non_Member')));
	IF((outputs.IncludeBusReg OR outputs.IncludeAll), OUTPUT(CHOOSEN((BusReg), outputs.OutputRecordCount), NAMED('Bus_Reg')));
	IF((outputs.IncludeCorpFilings OR outputs.IncludeAll), OUTPUT(CHOOSEN((CorpFilings_recs), outputs.OutputRecordCount), NAMED('Corp_Filings')));
	IF((outputs.IncludeCortera OR outputs.IncludeAll), OUTPUT(CHOOSEN((CorteraRecs), outputs.OutputRecordCount), NAMED('Cortera_Header')));
	IF((outputs.IncludeCortera OR outputs.IncludeAll), OUTPUT(CHOOSEN((Cortera_Attribute_recs), outputs.OutputRecordCount), NAMED('Cortera_Attributes')));
	IF((outputs.IncludeCortera OR outputs.IncludeAll), OUTPUT(CHOOSEN((Cortera_Tradelines), outputs.OutputRecordCount), NAMED('Cortera_Tradelines')));
	IF((outputs.IncludeDCA OR outputs.IncludeAll), OUTPUT(CHOOSEN((DCA), outputs.OutputRecordCount), NAMED('DCA')));
	IF((outputs.IncludeDEADCO OR outputs.IncludeAll), OUTPUT(CHOOSEN((DEADCO), outputs.OutputRecordCount), NAMED('DEADCO')));
	IF((outputs.IncludeDNBDMI OR outputs.IncludeAll), OUTPUT(CHOOSEN((DNBDMI), outputs.OutputRecordCount), NAMED('DNB_DMI')));
	IF((outputs.IncludeTradelines OR outputs.IncludeAll), OUTPUT(CHOOSEN((EBR_recs), outputs.OutputRecordCount), NAMED('EBR_0010_Tradelines_File_Number')));
	IF((outputs.IncludeTradelines OR outputs.IncludeAll), OUTPUT(CHOOSEN((header_recs_pre), outputs.OutputRecordCount), NAMED('EBR_0010_Tradelines_Header')));
	IF((outputs.IncludeTradelines OR outputs.IncludeAll), OUTPUT(CHOOSEN((executive_recs_added), outputs.OutputRecordCount), NAMED('EBR_0010_Tradelines_Executives')));
	IF((outputs.IncludeTradelines OR outputs.IncludeAll), OUTPUT(CHOOSEN((trade_payment_total_recs_added), outputs.OutputRecordCount), NAMED('EBR_0010_Tradelines_Payments')));
	IF((outputs.IncludeEBR OR outputs.IncludeAll), OUTPUT(CHOOSEN((EBR5600), outputs.OutputRecordCount), NAMED('EBR_5600')));
	IF((outputs.IncludeFBN OR outputs.IncludeAll), OUTPUT(CHOOSEN((FBN), outputs.OutputRecordCount), NAMED('FBN')));
	IF((outputs.IncludeInquiriesBus OR outputs.IncludeAll), OUTPUT((InqBuildDate), NAMED('Inquiries_Bus_Build_Date')));
	IF((outputs.IncludeInquiriesBus OR outputs.IncludeAll), OUTPUT(CHOOSEN((InquiriesAll), outputs.OutputRecordCount), NAMED('Inquiries_Bus')));
	IF((outputs.IncludeIRS990 OR outputs.IncludeAll), OUTPUT(CHOOSEN((IRS990), outputs.OutputRecordCount), NAMED('IRS990_Non_Profit')));
	IF((outputs.IncludeLiensJudgments OR outputs.IncludeAll), OUTPUT(CHOOSEN((LiensJudgmentsTMSID), outputs.OutputRecordCount), NAMED('Liens_TMSID')));
	IF((outputs.IncludeLiensJudgments OR outputs.IncludeAll), OUTPUT(CHOOSEN((liens_judgments_main), outputs.OutputRecordCount), NAMED('Liens')));
	IF((outputs.IncludeOSHA OR outputs.IncludeAll), OUTPUT(CHOOSEN((OSHA), outputs.OutputRecordCount), NAMED('OSHA')));
	IF((outputs.IncludePropertyAssessments OR outputs.IncludePropertyDeeds OR outputs.IncludeAll), OUTPUT(CHOOSEN((Property), outputs.OutputRecordCount), NAMED('Property_FID')));
	IF((outputs.IncludePropertyAssessments OR outputs.IncludeAll), OUTPUT(CHOOSEN((PropertyAssessments), outputs.OutputRecordCount), NAMED('Property_Assessments')));
	IF((outputs.IncludePropertyDeeds OR outputs.IncludeAll), OUTPUT(CHOOSEN((PropertyDeeds), outputs.OutputRecordCount), NAMED('Property_Deeds')));
	IF((outputs.IncludeUCC OR outputs.IncludeAll), OUTPUT(CHOOSEN((UCCDataSeq), outputs.OutputRecordCount), NAMED('UCC')));
	IF((outputs.IncludeUtility OR outputs.IncludeAll), OUTPUT(CHOOSEN((Util), outputs.OutputRecordCount), NAMED('Utility')));
	IF(outputs.IncludeWatchlist, OUTPUT(WatchlistResults[1].WatchlistHits, NAMED('Watchlist_Hits')));
	IF(outputs.IncludeProfLic OR outputs.IncludeAll, OUTPUT(CHOOSEN((ProfLic), outputs.OutputRecordCount), NAMED('ProfessionalLicense')));
	IF((outputs.IncludeSBFE OR outputs.IncludeAll), OUTPUT(CHOOSEN((SBFE), outputs.OutputRecordCount), NAMED('SBFE')));
		
	RETURN(TRUE);
END;