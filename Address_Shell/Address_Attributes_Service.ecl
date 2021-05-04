/*--SOAP--
<message name="Address_Attributes_Service">
	<part name="AddressAttributesReportRequest" type="tns:XmlDataSet" cols="110" rows="50" />
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="25"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="AddressBasedPRAttrVersion" type="xsd:string"/>
  <part name="PropertyInfoAttrVersion" type="xsd:string"/>
  <part name="ERCAttrVersion" type="xsd:string"/>
  <part name="ReturnFlatLayout" type="xsd:Boolean" />
</message>
*/
/*--INFO-- Address Attributes - Realtime Service */
/*--HELP--
<pre>
AddressAttributesReportRequest XML:

&lt;dataset&gt;
  &lt;row&gt;
    &lt;SearchBy&gt;
      &lt;Address&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
        &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
        &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
        &lt;StreetName&gt;&lt;/StreetName&gt;
        &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
        &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
        &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
        &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
        &lt;County&gt;&lt;/County&gt;
        &lt;PostalCode&gt;&lt;/PostalCode&gt;
        &lt;StateCityZip&gt;&lt;/StateCityZip&gt;
      &lt;/Address&gt;
    &lt;/SearchBy&gt;
    &lt;Options&gt;
      &lt;RequestedAttributeGroups&gt;
        &lt;Name&gt;AddressBasedPRAttrV1&lt;/Name&gt;
        &lt;Name&gt;PropertyInfoAttrV1&lt;/Name&gt;
        &lt;Name&gt;ERCAttrV0&lt;/Name&gt;
      &lt;/RequestedAttributeGroups&gt;
    &lt;/Options&gt;
    &lt;User&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
      &lt;DataRestrictionMask&gt;00000000000000000000&lt;/DataRestrictionMask&gt;
    &lt;/User&gt;
  &lt;/row&gt;
&lt;/dataset&gt;


Sample Gateway XML:

&lt;gateways&gt;
  &lt;row&gt;
    &lt;servicename&gt;erc&lt;/servicename&gt;
    &lt;url&gt;http://username:password@10.176.68.164:7726/WsGatewayEx?ver_=1.7&lt;/url&gt;
  &lt;/row&gt;
  &lt;row&gt;
    &lt;servicename&gt;reportservice&lt;/servicename&gt;
    &lt;url&gt;http://certstagingvip.hpcc.risk.regn.net:9876&lt;/url&gt;
  &lt;/row&gt;
&lt;/gateways&gt;
</pre>
*/

IMPORT Address, iesp, ut, Risk_Indicators, RiskWise, Gateway;

EXPORT Address_Attributes_Service() := FUNCTION
	/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'AddressAttributesReportRequest',
	'DataRestrictionMask',
	'AddressBasedPRAttrVersion',
	'PropertyInfoAttrVersion',
	'ERCAttrVersion',
	'gateways',
	'ReturnFlatLayout'
	));
	
	requestIn := DATASET([], iesp.addressattributesreport.t_AddressAttributesReportRequest) : STORED('AddressAttributesReportRequest', FEW);
	firstRow := requestIn[1] : INDEPENDENT;
	
	option := GLOBAL(firstRow.Options);
	
	gatewaysIn := Gateway.Configuration.Get();
	// gatewaysIn := DATASET([], Risk_Indicators.Layout_Gateways_In) : STORED('gateways', FEW);
  
  STRING50 outOfBandDataRestriction := '' : STORED('DataRestrictionMask');
	
	// This is purely for ECL engineers.  It is NOT passed in by the ESP.
	flatLayout := FALSE : STORED('ReturnFlatLayout');
		
	/* ***********************************************************
	 *           Clean and format input as needed                *
   *************************************************************/
	Address_Shell.layoutInput cleanInput(iesp.addressattributesreport.t_AddressAttributesReportRequest le, UNSIGNED c) := TRANSFORM
		tempStreetAddr := IF(TRIM(le.SearchBy.Address.StreetAddress1) = '', 
														Address.Addr1FromComponents(le.SearchBy.Address.StreetNumber, le.SearchBy.Address.StreetPreDirection, 
																												le.SearchBy.Address.StreetName, le.SearchBy.Address.StreetSuffix, le.SearchBy.Address.StreetPostDirection, 
																												le.SearchBy.Address.UnitDesignation, le.SearchBy.Address.UnitNumber), 
														le.SearchBy.Address.StreetAddress1);
		cleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(tempStreetAddr, le.SearchBy.Address.City, le.SearchBy.Address.State, le.SearchBy.Address.Zip5);
		cleanedFields := Address.CleanFields(cleanAddr);
		
		SELF.StreetNumber := cleanedFields.Prim_Range;
		SELF.StreetPreDirection := cleanedFields.Predir;
		SELF.StreetName := cleanedFields.Prim_Name;
		SELF.StreetSuffix := cleanedFields.Addr_Suffix;
		SELF.StreetPostDirection := cleanedFields.Postdir;
		SELF.UnitDesignation := cleanedFields.Unit_Desig;
		SELF.UnitNumber := cleanedFields.Sec_Range;
		SELF.StreetAddress1 := Address.Addr1FromComponents(cleanedFields.Prim_Range, cleanedFields.Predir,	cleanedFields.Prim_Name, cleanedFields.Addr_Suffix, cleanedFields.Postdir, cleanedFields.Unit_Desig, cleanedFields.Sec_Range);
		SELF.StreetAddress2 := StringLib.StringToUpperCase(le.SearchBy.Address.StreetAddress2);
		SELF.City := cleanedFields.V_City_Name;
		SELF.State := cleanedFields.St;
		SELF.Zip5 := cleanedFields.ZIP;
		SELF.Zip4 := cleanedFields.ZIP4;
		SELF.County := cleanedFields.County[3..5]; // We only want the last 3 for county
		SELF.PostalCode := le.SearchBy.Address.PostalCode;
		capsCity := TRIM(StringLib.StringToUpperCase(le.SearchBy.Address.City));
		useCity := IF(capsCity = '', TRIM(cleanedFields.V_City_Name), capsCity);
		SELF.StateCityZip := IF(useCity <> '' AND TRIM(cleanedFields.St) <> '' AND TRIM(cleanedFields.ZIP) <> '', useCity + ', ' + TRIM(cleanedFields.St) + ' ' + TRIM(cleanedFields.ZIP), '');

		// We need the GeoLink and GeoLat/GeoLong for searching of keys
		SELF.GeoLat := cleanedFields.Geo_Lat;
		SELF.GeoLong := cleanedFields.Geo_Long;
		SELF.GeoLink := cleanedFields.St + cleanedFields.County[3..5] + cleanedFields.Geo_Blk; // State + County + GeoBlock
	
		// Keep the Address Cleaner Error Stat to see if we should return an Address Clean Failed attribute
		SELF.Err_Stat := cleanedFields.Err_Stat;
		
		SELF.Seq := (STRING)c;
		SELF.DPPAPurpose := IF(TRIM(le.User.DLPurpose) IN ['', '\n'], '0', le.User.DLPurpose);
		SELF.GLBPurpose := IF(TRIM(le.User.GLBPurpose) IN ['', '\n'], '0', le.User.GLBPurpose);
		SELF.AccountNumber := IF(TRIM(le.User.AccountNumber) IN ['', '\n'], (STRING)c, le.User.AccountNumber);
		SELF.DataRestrictionMask := MAP(TRIM(le.User.DataRestrictionMask) NOT IN ['', '\n'] => le.User.DataRestrictionMask,
                                    TRIM(outOfBandDataRestriction) <> ''                => outOfBandDataRestriction,
                                                                                           Risk_Indicators.iid_constants.default_DataRestriction);
		
		SELF := [];
	END;
	
	cleanedInput := PROJECT(requestIn, cleanInput(LEFT, COUNTER));
	
	/* ***********************************************************
	 *                 Get the input options                     *
	 *************************************************************/
	attributes := RECORD
		STRING30 Request := '';
	END;
	requestedAttributes := PROJECT(option.RequestedAttributeGroups, TRANSFORM(attributes, SELF.Request := LEFT.Value));
	
	// ESDL Input
	pubRecAttribRequest := requestedAttributes (StringLib.StringContains(Request, 'addressbasedprattrv', TRUE))[1];
	propertyInformationAttribRequest := requestedAttributes (StringLib.StringContains(Request, 'propertyinfoattrv', TRUE))[1];
	ERCAttribRequest := requestedAttributes (StringLib.StringContains(Request, 'ercattrv', TRUE))[1];
	
	// Out-of-band (Not Passed in by the ESP - ONLY for ECL Scripts)
	STRING30 AddressBasedPRAttrVersion := '' : STORED('AddressBasedPRAttrVersion');
	STRING30 PropertyInfoAttrVersion 	:= '' : STORED('PropertyInfoAttrVersion');
	STRING30 ERCAttrVersion 						:= '' : STORED('ERCAttrVersion');

	publicRecordsAttributesVersion := MAP(
																				TRIM(pubRecAttribRequest.Request) <> '' => (UNSIGNED1)(pubRecAttribRequest.Request[20..]), // We found a valid public records request, get the version number
																				TRIM(AddressBasedPRAttrVersion) <> '' AND StringLib.StringContains(AddressBasedPRAttrVersion, 'addressbasedprattrv', TRUE) => (UNSIGNED1)(AddressBasedPRAttrVersion[20..]), // Check the out-of-band
																				0 // No public records request
																				);
	propertyInformationAttributesVersion := MAP(
																				TRIM(propertyInformationAttribRequest.Request) <> '' => (UNSIGNED1)(propertyInformationAttribRequest.Request[18..]), // We found a valid property information request, get the version number
																				TRIM(PropertyInfoAttrVersion) <> '' AND StringLib.StringContains(PropertyInfoAttrVersion, 'propertyinfoattrv', TRUE) => (UNSIGNED1)(PropertyInfoAttrVersion[18..]), // Check the out-of-band
																				0 // No property information request
																				);
	ercAttributesVersion := MAP(
																				TRIM(ERCAttribRequest.Request) <> '' => (UNSIGNED1)(ERCAttribRequest.Request[9..]), // We found a valid erc request, get the version number
																				TRIM(ERCAttrVersion) <> '' AND StringLib.StringContains(ERCAttrVersion, 'ercattrv', TRUE) => (UNSIGNED1)(ERCAttrVersion[9..]), // Check the out-of-band
																				0 // No erc request
																				);
																				
	propertyInformationGatewayURL := gatewaysIn(StringLib.StringToLowerCase(servicename) = 'reportservice')[1].url;
	
	ercGatewayURL := gatewaysIn(StringLib.StringToLowerCase(servicename) = 'erc')[1].url;
	
	/* ***********************************************************
	 *   Verify Input Options, ensure enough data is present     *
   *************************************************************/
	// If we just want propertyInformationAttributes make sure the propertyInformationGatewayURL exists - if we want BOTH propertyInformationAttributes AND ercAttributes, make sure both gateway URLs exist
	IF((propertyInformationAttributesVersion > 0 AND ercAttributesVersion <= 0 AND TRIM(propertyInformationGatewayURL) = '') OR
		 (propertyInformationAttributesVersion > 0 AND ercAttributesVersion > 0 AND (TRIM(propertyInformationGatewayURL) = '' OR TRIM(ercGatewayURL) = '')),
					FAIL('Property Characteristic Service Attributes requested, but missing REPORTSERVICE and/or ERC gateway URLs'));
		
	/* **********************************************************
	 *             Get the requested attribues                  *
	 ************************************************************/
	comboAttributes := Address_Shell.AddressAttributesFunction(cleanedInput, publicRecordsAttributesVersion, propertyInformationAttributesVersion, ercAttributesVersion, gatewaysIn);

	final := Address_Shell.convertToIESP.getAttributes(comboAttributes, publicRecordsAttributesVersion, propertyInformationAttributesVersion, ercAttributesVersion);

/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.    ECL Developers use only. *
   ************************************************************/
	Address_Shell.debuggingFields();
	
	/* ***********************************************************
	* This allows for the result to be output in either ESDL    *
  * format or a flat layout - Useful for the modeling teams   *
  * scripts. By default it will always use ESDL, as the       *
  * flatLayout option isn't passed in by the ESP.             *
  *                                  ECL developers use only. *
  *************************************************************/
	RETURN IF(flatLayout = FALSE, OUTPUT(final, NAMED('Results')), OUTPUT(comboAttributes, NAMED('Result')));
END;
// Address_Shell.Address_Attributes_Service();

/* Sample Gateway request:
<gateways>
  <row>
    <servicename>erc</servicename>
    <url>http://rw_score_dev:Password01@10.176.68.164:7726/WsGatewayEx?ver_=1.7</url>
  </row>
  <row>
    <servicename>reportservice</servicename>
    <url>http://certstagingvip.hpcc.risk.regn.net:9876</url>
  </row>
</gateways>
*/