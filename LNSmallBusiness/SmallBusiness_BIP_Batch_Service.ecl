/*--SOAP--
<message name="SmallBusiness_BIP_Batch_Service" wuTimeout="300000">
  <part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="100"/>
  <part name="GLBPurpose" type="xsd:integer"/>
  <part name="DPPAPurpose" type="xsd:integer"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
  <part name="Watchlists_Requested" type="tns:XmlDataSet" cols="100" rows="8"/>
  <part name="OFAC_Version" type="xsd:integer"/>
  <part name="IndustryClass" type="xsd:string"/>
  <part name="LinkSearchLevel" type="xsd:integer"/>
  <part name="MarketingMode" type="xsd:integer"/>
  <part name="AllowedSources" type="xsd:string"/>
  <part name="Global_Watchlist_Threshold" type="xsd:real"/>
	<part name="AttributesVersion1" type="xsd:string"/>
	<part name="AttributesVersion2" type="xsd:string"/>
	<part name="ModelName1" type="xsd:string"/>
	<part name="ModelName2" type="xsd:string"/>
	<part name="ModelName3" type="xsd:string"/>
	<part name="ModelName4" type="xsd:string"/>
	<part name="ModelName5" type="xsd:string"/>
	<part name="IncludeTargusGateway" type="xsd:boolean"/>
	<part name="RunTargusGatewayAnywayForTesting" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Small Business Batch Service - This service returns Small Business Attributes and Scores */
/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    &lt;Bus_Company_Name&gt;&lt;/Bus_Company_Name&gt;
    &lt;Bus_Doing_Business_As&gt;&lt;/Bus_Doing_Business_As&gt;
    &lt;Bus_Street_Address&gt;&lt;/Bus_Street_Address&gt;
    &lt;Bus_City&gt;&lt;/Bus_City&gt;
    &lt;Bus_State&gt;&lt;/Bus_State&gt;
    &lt;Bus_Zip&gt;&lt;/Bus_Zip&gt;
    &lt;Bus_FEIN&gt;&lt;/Bus_FEIN&gt;
    &lt;Bus_Phone10&gt;&lt;/Bus_Phone10&gt;
    &lt;Bus_SIC_Code&gt;&lt;/Bus_SIC_Code&gt;
    &lt;Bus_NAIC_Code&gt;&lt;/Bus_NAIC_Code&gt;
    &lt;Bus_Structure&gt;&lt;/Bus_Structure&gt;
    &lt;Bus_Years_in_Business&gt;&lt;/Bus_Years_in_Business&gt;
    &lt;Bus_Start_Date&gt;&lt;/Bus_Start_Date&gt;
    &lt;Bus_Yearly_Revenue&gt;&lt;/Bus_Yearly_Revenue&gt;
    &lt;Bus_Fax_Number&gt;&lt;/Bus_Fax_Number&gt;
    &lt;Bus_Custom_Field_1&gt;&lt;/Bus_Custom_Field_1&gt;
    &lt;Bus_Custom_Field_2&gt;&lt;/Bus_Custom_Field_2&gt;
    &lt;Bus_Custom_Field_3&gt;&lt;/Bus_Custom_Field_3&gt;
    &lt;Bus_Custom_Field_4&gt;&lt;/Bus_Custom_Field_4&gt;
    &lt;Bus_Custom_Field_5&gt;&lt;/Bus_Custom_Field_5&gt;
    &lt;Rep_1_First_Name&gt;&lt;/Rep_1_First_Name&gt;
    &lt;Rep_1_Middle_Name&gt;&lt;/Rep_1_Middle_Name&gt;
    &lt;Rep_1_Last_Name&gt;&lt;/Rep_1_Last_Name&gt;
    &lt;Rep_1_Former_Last_Name&gt;&lt;/Rep_1_Former_Last_Name&gt;
    &lt;Rep_1_Suffix&gt;&lt;/Rep_1_Suffix&gt;
    &lt;Rep_1_DOB&gt;&lt;/Rep_1_DOB&gt;
    &lt;Rep_1_SSN&gt;&lt;/Rep_1_SSN&gt;
    &lt;Rep_1_Street_Address&gt;&lt;/Rep_1_Street_Address&gt;
    &lt;Rep_1_City&gt;&lt;/Rep_1_City&gt;
    &lt;Rep_1_State&gt;&lt;/Rep_1_State&gt;
    &lt;Rep_1_Zip&gt;&lt;/Rep_1_Zip&gt;
    &lt;Rep_1_Phone10&gt;&lt;/Rep_1_Phone10&gt;
    &lt;Rep_1_Age&gt;&lt;/Rep_1_Age&gt;
    &lt;Rep_1_DL_Number&gt;&lt;/Rep_1_DL_Number&gt;
    &lt;Rep_1_DL_State&gt;&lt;/Rep_1_DL_State&gt;
    &lt;Rep_1_Business_Title&gt;&lt;/Rep_1_Business_Title&gt;
    &lt;Rep_1_Custom_Field_1&gt;&lt;/Rep_1_Custom_Field_1&gt;
    &lt;Rep_1_Custom_Field_2&gt;&lt;/Rep_1_Custom_Field_2&gt;
    &lt;Rep_1_Custom_Field_3&gt;&lt;/Rep_1_Custom_Field_3&gt;
    &lt;Rep_1_Custom_Field_4&gt;&lt;/Rep_1_Custom_Field_4&gt;
    &lt;Rep_1_Custom_Field_5&gt;&lt;/Rep_1_Custom_Field_5&gt;
    &lt;Rep_2_First_Name&gt;&lt;/Rep_2_First_Name&gt;
    &lt;Rep_2_Middle_Name&gt;&lt;/Rep_2_Middle_Name&gt;
    &lt;Rep_2_Last_Name&gt;&lt;/Rep_2_Last_Name&gt;
    &lt;Rep_2_Former_Last_Name&gt;&lt;/Rep_2_Former_Last_Name&gt;
    &lt;Rep_2_Suffix&gt;&lt;/Rep_2_Suffix&gt;
    &lt;Rep_2_DOB&gt;&lt;/Rep_2_DOB&gt;
    &lt;Rep_2_SSN&gt;&lt;/Rep_2_SSN&gt;
    &lt;Rep_2_Street_Address&gt;&lt;/Rep_2_Street_Address&gt;
    &lt;Rep_2_City&gt;&lt;/Rep_2_City&gt;
    &lt;Rep_2_State&gt;&lt;/Rep_2_State&gt;
    &lt;Rep_2_Zip&gt;&lt;/Rep_2_Zip&gt;
    &lt;Rep_2_Phone10&gt;&lt;/Rep_2_Phone10&gt;
    &lt;Rep_2_Age&gt;&lt;/Rep_2_Age&gt;
    &lt;Rep_2_DL_Number&gt;&lt;/Rep_2_DL_Number&gt;
    &lt;Rep_2_DL_State&gt;&lt;/Rep_2_DL_State&gt;
    &lt;Rep_2_Business_Title&gt;&lt;/Rep_2_Business_Title&gt;
    &lt;Rep_2_Custom_Field_1&gt;&lt;/Rep_2_Custom_Field_1&gt;
    &lt;Rep_2_Custom_Field_2&gt;&lt;/Rep_2_Custom_Field_2&gt;
    &lt;Rep_2_Custom_Field_3&gt;&lt;/Rep_2_Custom_Field_3&gt;
    &lt;Rep_2_Custom_Field_4&gt;&lt;/Rep_2_Custom_Field_4&gt;
    &lt;Rep_2_Custom_Field_5&gt;&lt;/Rep_2_Custom_Field_5&gt;
    &lt;Rep_3_First_Name&gt;&lt;/Rep_3_First_Name&gt;
    &lt;Rep_3_Middle_Name&gt;&lt;/Rep_3_Middle_Name&gt;
    &lt;Rep_3_Last_Name&gt;&lt;/Rep_3_Last_Name&gt;
    &lt;Rep_3_Former_Last_Name&gt;&lt;/Rep_3_Former_Last_Name&gt;
    &lt;Rep_3_Suffix&gt;&lt;/Rep_3_Suffix&gt;
    &lt;Rep_3_DOB&gt;&lt;/Rep_3_DOB&gt;
    &lt;Rep_3_SSN&gt;&lt;/Rep_3_SSN&gt;
    &lt;Rep_3_Street_Address&gt;&lt;/Rep_3_Street_Address&gt;
    &lt;Rep_3_City&gt;&lt;/Rep_3_City&gt;
    &lt;Rep_3_State&gt;&lt;/Rep_3_State&gt;
    &lt;Rep_3_Zip&gt;&lt;/Rep_3_Zip&gt;
    &lt;Rep_3_Phone10&gt;&lt;/Rep_3_Phone10&gt;
    &lt;Rep_3_Age&gt;&lt;/Rep_3_Age&gt;
    &lt;Rep_3_DL_Number&gt;&lt;/Rep_3_DL_Number&gt;
    &lt;Rep_3_DL_State&gt;&lt;/Rep_3_DL_State&gt;
    &lt;Rep_3_Business_Title&gt;&lt;/Rep_3_Business_Title&gt;
    &lt;Rep_3_Custom_Field_1&gt;&lt;/Rep_3_Custom_Field_1&gt;
    &lt;Rep_3_Custom_Field_2&gt;&lt;/Rep_3_Custom_Field_2&gt;
    &lt;Rep_3_Custom_Field_3&gt;&lt;/Rep_3_Custom_Field_3&gt;
    &lt;Rep_3_Custom_Field_4&gt;&lt;/Rep_3_Custom_Field_4&gt;
    &lt;Rep_3_Custom_Field_5&gt;&lt;/Rep_3_Custom_Field_5&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;
</pre>
*/

#option('expandSelectCreateRow', true);
IMPORT Business_Risk_BIP, Gateway, IESP, MDR, OFAC_XG5, Phones, Risk_Indicators, RiskWise, Royalty, Suspicious_Fraud_LN, UT, Royalty;

EXPORT SmallBusiness_BIP_Batch_Service() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'Batch_In',
	'GLBPurpose',
	'DPPAPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'Gateways',
	'ReturnDetailedRoyalties',
	'Watchlists_Requested',
	'OFAC_Version',
	'IndustryClass',
	'LinkSearchLevel',
	'MarketingMode',
	'AllowedSources',
	'Global_Watchlist_Threshold',
	'AttributesVersion1',
	'AttributesVersion2',
	'ModelName1',
	'ModelName2',
	'ModelName3',
	'ModelName4',
	'ModelName5',
	'IncludeTargusGateway',
	'RunTargusGatewayAnywayForTesting'
	));

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	// Fixes "Duplicate definition of STORED('datarestrictionmask') with different type 
	// (use #stored to override default value)" error.
	#STORED('DataRestrictionMask',Business_Risk_BIP.Constants.Default_DataRestrictionMask);
	#STORED('DPPAPurpose'        ,Business_Risk_BIP.Constants.Default_DPPA);
	#STORED('GLBPurpose'         ,Business_Risk_BIP.Constants.Default_GLBA);

	/* ************************************************************************
	 *                          Grab service inputs                           *
	 ************************************************************************ */
	 	 
	DATASET(LNSmallBusiness.BIP_Layouts.Input) Input := DATASET([], LNSmallBusiness.BIP_Layouts.Input) : STORED('Batch_In');
	// Option Fields
	UNSIGNED1	DPPA_Purpose         := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPAPurpose');
	UNSIGNED1	GLBA_Purpose         := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBPurpose');
	STRING	  DataRestrictionMask  := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('DataRestrictionMask');
	STRING	  DataPermissionMask   := Business_Risk_BIP.Constants.Default_DataPermissionMask : STORED('DataPermissionMask');
	STRING5	IndustryClass_In		   := Business_Risk_BIP.Constants.Default_IndustryClass : STORED('IndustryClass');
	IndustryClass                  := StringLib.StringToUpperCase(TRIM(IndustryClass_In, LEFT, RIGHT));
	UNSIGNED1	LinkSearchLevel      := Business_Risk_BIP.Constants.LinkSearch.Default : STORED('LinkSearchLevel');
	UNSIGNED1	MarketingMode        := Business_Risk_BIP.Constants.Default_MarketingMode : STORED('MarketingMode');
	STRING50	AllowedSources       := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	UNSIGNED1 OFAC_Version		     := Business_Risk_BIP.Constants.Default_OFAC_Version : STORED('OFAC_Version');
	REAL Global_Watchlist_Threshold	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold : STORED('Global_Watchlist_Threshold');
	DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested := Business_Risk_BIP.Constants.Default_Watchlists_Requested : STORED('Watchlists_Requested');

	IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(Watchlists_Requested, value),
		FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

	Gateways 										:= Gateway.Configuration.Get();	// Gateways Coded in this Product: Targus
	BOOLEAN  ReturnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties');
	
	STRING AttrsVer1_in  := '' : STORED('AttributesVersion1');
	STRING AttrsVer2_in  := '' : STORED('AttributesVersion2');
	STRING ModelName1_in := '' : STORED('ModelName1');
	STRING ModelName2_in := '' : STORED('ModelName2');
	STRING ModelName3_in := '' : STORED('ModelName3');
	STRING ModelName4_in := '' : STORED('ModelName4');
	STRING ModelName5_in := '' : STORED('ModelName5');
	
	BOOLEAN IncludeTargusGateway := FALSE : STORED('IncludeTargusGateway');
	BOOLEAN RunTargusGateway     := FALSE : STORED('RunTargusGatewayAnywayForTesting');
	
	AttrsRequested  := DATASET([ {StringLib.StringToUpperCase(AttrsVer1_in)},{StringLib.StringToUpperCase(AttrsVer2_in)} ], LNSmallBusiness.Layouts.AttributeGroupRec);
	ModelsRequested := DATASET([ {StringLib.StringToUpperCase(ModelName1_in)},{StringLib.StringToUpperCase(ModelName2_in)},{StringLib.StringToUpperCase(ModelName3_in)},{StringLib.StringToUpperCase(ModelName4_in)},{StringLib.StringToUpperCase(ModelName5_in)} ], LNSmallBusiness.Layouts.ModelNameRec);
	ModelOptions    := DATASET([], LNSmallBusiness.Layouts.ModelOptionsRec); // ModelOptions is never consumed in SmallBusiness_BIP_Function.
	
	/* ************************************************************************
	 *         Get the Small Business Attributes and Scores Results           *
	 ************************************************************************ */
	SBA_Results_with_PhoneSources := LNSmallBusiness.SmallBusiness_BIP_Function(Input,
																														DPPA_Purpose,
																														GLBA_Purpose,
																														DataRestrictionMask,
																														DataPermissionMask,
																														IndustryClass,
																														LinkSearchLevel,
																														MarketingMode,
																														AllowedSources,
																														OFAC_Version,
																														Global_Watchlist_Threshold,
																														Watchlists_Requested,
																														Gateways,
																														AttrsRequested,
																														ModelsRequested,
																														ModelOptions,
																														DisableIntermediateShellLogging := TRUE /* Always Turn Off Intermediate Shell Logging in Batch */,
																														IncludeTargusGateway := IncludeTargusGateway,
																														RunTargusGateway := RunTargusGateway, /* for testing purposes only */
																														BIPIDWeightThreshold := LNSmallBusiness.Constants.BIPID_WEIGHT_THRESHOLD.FOR_SmallBusiness_BIP_Batch_Service
																														);

	SBA_Results := PROJECT( SBA_Results_with_PhoneSources, LNSmallBusiness.BIP_Layouts.IntermediateLayout );

	/* ************************************************************************
	 * Transform the Small Business Attributes and Scores Results into Batch  *
	 ************************************************************************ */
	
	LNSmallBusiness.BIP_Layouts.BatchOutput xfm_to_Results(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) :=
		TRANSFORM
			model_result_1 := ROW( le.ModelResults[1], iesp.smallbusinessanalytics.t_SBAModelHRI );
			model_result_2 := ROW( le.ModelResults[2], iesp.smallbusinessanalytics.t_SBAModelHRI );
			
			SELF.AcctNo            := le.Input_Echo.AcctNo;
			SELF.BillingHit        := le.BillingHit;
			SELF.HistoryDateYYYYMM := le.Input_Echo.HistoryDateYYYYMM;
			SELF.HistoryDate       := le.Input_Echo.HistoryDate;
			SELF.Bus_Company_Name  := le.Input_Echo.Bus_Company_Name;
			SELF.Model_1_Name      := model_result_1.name; 
			SELF.Model_1_Score     := (STRING)model_result_1.Scores[1].Value;
			SELF.Model_1_RC1       := model_result_1.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_1_RC2       := model_result_1.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_1_RC3       := model_result_1.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_1_RC4       := model_result_1.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_2_Name      := model_result_2.name;
			SELF.Model_2_Score     := (STRING)model_result_2.Scores[1].Value;
			SELF.Model_2_RC1       := model_result_2.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_2_RC2       := model_result_2.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_2_RC3       := model_result_2.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_2_RC4       := model_result_2.Scores[1].ScoreReasons[4].ReasonCode;
			SELF := le;		
		END;
	
	Final_Results_pre := PROJECT(SBA_Results, xfm_to_Results(LEFT));
	
	/* ************************************************************************
	 *   Restrict/allow LN Small Business Attributes and/or SBFE Attributes.  *
	 ************************************************************************ */

	allow_SBA_attrs     := EXISTS(AttrsRequested(AttributeGroup = StringLib.StringToUpperCase(LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V1_NAME)));   // i.e. "LN" Small Business Attributes
	allow_SBA_attrs101  := EXISTS(AttrsRequested(AttributeGroup = StringLib.StringToUpperCase(LNSmallBusiness.Constants.SMALL_BIZ_ATTR_NOFEL)));   // i.e. "LN" Small Business Attributes no felloniew
	allow_SBFE_attrs    := EXISTS(AttrsRequested(AttributeGroup IN [StringLib.StringToUpperCase(LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR_NAME),StringLib.StringToUpperCase(LNSmallBusiness.Constants.SMALL_BIZ_SBFE_V1_ATTR)])); // i.e. "SBFE" Small Business Attributes
		
	LNSmallBusiness.BIP_Layouts.BatchOutput xfm_allow_SBA_only( LNSmallBusiness.BIP_Layouts.BatchOutput le ) :=
		TRANSFORM
			LNSmallBusiness.Macros.mac_base_attrs()
			LNSmallBusiness.Macros.mac_SBA_attrs()
			LNSmallBusiness.Macros.mac_scoring_attrs()
			SELF := [];
		END;

	LNSmallBusiness.BIP_Layouts.BatchOutput xfm_allow_SBFE_only( LNSmallBusiness.BIP_Layouts.BatchOutput le ) :=
		TRANSFORM
			LNSmallBusiness.Macros.mac_base_attrs()
			LNSmallBusiness.Macros.mac_SBFE_attrs()
			LNSmallBusiness.Macros.mac_scoring_attrs()
			SELF := [];
		END;

	LNSmallBusiness.BIP_Layouts.BatchOutput xfm_allow_none( LNSmallBusiness.BIP_Layouts.BatchOutput le ) :=
		TRANSFORM
			LNSmallBusiness.Macros.mac_base_attrs()
			LNSmallBusiness.Macros.mac_scoring_attrs()
			SELF := [];
		END;
		
    LNSmallBusiness.BIP_Layouts.BatchOutput xfm_allow_SBA101_only( LNSmallBusiness.BIP_Layouts.BatchOutput le ) :=
		TRANSFORM
			LNSmallBusiness.Macros.mac_base_attrs()
			LNSmallBusiness.Macros.mac_SBA_attrs101()
			LNSmallBusiness.Macros.mac_scoring_attrs()
			SELF := [];
		END;
    
     LNSmallBusiness.BIP_Layouts.BatchOutput xfm_allow_SBA101SBFE_only( LNSmallBusiness.BIP_Layouts.BatchOutput le ) :=
		TRANSFORM
			LNSmallBusiness.Macros.mac_base_attrs()
			LNSmallBusiness.Macros.mac_SBA_attrs101()
			LNSmallBusiness.Macros.mac_SBFE_attrs()
			LNSmallBusiness.Macros.mac_scoring_attrs()
			SELF := [];
		END;
    
    
    
	Final_Results :=
			MAP(
				NOT allow_SBA_attrs AND NOT allow_SBFE_attrs AND NOT allow_SBA_attrs101  => PROJECT( Final_Results_pre, xfm_allow_none(LEFT)),
				allow_SBA_attrs AND NOT allow_SBFE_attrs AND NOT allow_SBA_attrs101      => PROJECT( Final_Results_pre, xfm_allow_SBA_only(LEFT)),
				NOT allow_SBA_attrs AND allow_SBFE_attrs AND NOT allow_SBA_attrs101      => PROJECT( Final_Results_pre, xfm_allow_SBFE_only(LEFT)),
				allow_SBA_attrs101 AND not allow_SBFE_attrs AND NOT allow_SBA_attrs      => PROJECT( Final_Results_pre, xfm_allow_SBA101_only(LEFT)),
				allow_SBA_attrs101 AND  allow_SBFE_attrs AND NOT allow_SBA_attrs      => PROJECT( Final_Results_pre, xfm_allow_SBA101SBFE_only(LEFT)),
        /* default (allow both attribute groups): */    Final_Results_pre
			);
	
	/* ************************************************************************
	 *                          Calculate Royalties.                          *
	 ************************************************************************ */

	// For SBFE...:
	SBFE_royalties := Royalty.RoyaltySBFE.GetBatchRoyaltiesByAcctno(Input, Final_Results);

	// ...and for Targus Gateway: 
	layout_targus_temp := RECORD
		STRING30 acctno;
		Business_Risk_BIP.Layouts.LayoutSources;	
		STRING5 TargusType;
	END;
	
	targus_type := Phones.Constants.TargusType.WirelessConnectionSearch + Phones.Constants.TargusType.PhoneDataExpress;
		
	targus_data := 
		PROJECT(
			SBA_Results_with_PhoneSources,
			TRANSFORM( layout_targus_temp,
					targus_record := LEFT.PhoneSources(source = MDR.sourceTools.src_Targus_Gateway)[1];
				SELF.acctno        := LEFT.input_echo.acctno,
				SELF.Source        := MDR.sourceTools.src_Targus_Gateway,
				SELF.DateFirstSeen := targus_record.DateFirstSeen,
				SELF.DateLastSeen  := targus_record.DateLastSeen,
				SELF.RecordCount   := targus_record.RecordCount,
				SELF.TargusType    := IF( targus_record.RecordCount > 0, targus_type, '' )
			)
		);
	
	Targus_royalties_pre := Royalty.RoyaltyTargus.GetBatchRoyaltiesByAcctno(Input, targus_data, source, , acctno, acctno);
	Targus_royalties := PROJECT( Targus_royalties_pre, TRANSFORM( Royalty.Layouts.RoyaltyForBatch, SELF.source_type := 'G', SELF := LEFT ) ); // 'G' = Gateway source
	
	total_royalties  := SORT( (SBFE_royalties + Targus_royalties), acctno, royalty_type_code );
	
	// DEBUGs:
	// OUTPUT( SBA_Results_with_PhoneSources, NAMED('SBA_Results_with_PhoneSources') );
	// OUTPUT( targus_data, NAMED('targus_data') );

	OUTPUT( total_royalties, NAMED('RoyaltySet') );
	
	RETURN OUTPUT(Final_Results, NAMED('Results'));
END;