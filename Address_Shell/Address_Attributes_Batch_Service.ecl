/*--SOAP--
<message name="Address_Attributes_Batch_Service" wuTimeout="300000">
  <part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="100"/>
  <part name="GLBPurpose" type="xsd:integer"/>
  <part name="DPPAPurpose" type="xsd:integer"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="AddressBasedPRAttrVersion" type="xsd:string"/>
  <part name="PropertyInfoAttrVersion" type="xsd:string"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
</message>
*/
/*--INFO-- Address Attributes Batch Service - This service returns the Batch Address Shell */
/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    &lt;seq&gt;&lt;/seq&gt;
    &lt;AcctNo&gt;&lt;/AcctNo&gt;
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;State&gt;&lt;/State&gt;
    &lt;Zip5&gt;&lt;/Zip5&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;

&lt;AddressBasedPRAttrVersion&gt;AddressBasedPRAttrV1&lt;/AddressBasedPRAttrVersion&gt;
&lt;PropertyInfoAttrVersion&gt;PropertyInfoAttrV2&lt;/PropertyInfoAttrVersion&gt;
&lt;GLBPurpose&gt;1&lt;/GLBPurpose&gt;
&lt;DPPAPurpose&gt;1&lt;/DPPAPurpose&gt;
&lt;DataRestrictionMask&gt;00000000000000000000&lt;/DataRestrictionMask&gt;

&lt;gateways&gt;
  &lt;row&gt;
    &lt;servicename&gt;reportservice&lt;/servicename&gt;
    &lt;url&gt;http://certstagingvip.hpcc.risk.regn.net:9876&lt;/url&gt;
  &lt;/row&gt;
&lt;/gateways&gt;
</pre>
*/

IMPORT Address, iesp, ut, Risk_Indicators, RiskWise,Address_Shell, Gateway;

EXPORT Address_Attributes_Batch_Service() := FUNCTION
/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
	'Batch_In',
	'AddressBasedPRAttrVersion',
	'PropertyInfoAttrVersion',
	'GLBPurpose',
	'DPPAPurpose',
	'DataRestrictionMask',
	'Gateways'
	));

	batch_In := DATASET([], Address_Shell.layouts.batch_in) : STORED('Batch_In');
	
	UNSIGNED1 GLBPurpose  := 0 : STORED('GLBPurpose');
  UNSIGNED1 DPPAPurpose := 0 : STORED('DPPAPurpose');
	
	// gatewaysIn := DATASET([], Risk_Indicators.Layout_Gateways_In) : STORED('Gateways', FEW);
	gatewaysIn := Gateway.Configuration.Get();
  
  STRING50 outOfBandDataRestriction := '' : STORED('DataRestrictionMask');
	
	/* ***********************************************************
	 *           Clean and format input as needed                *
   *************************************************************/
	Address_Shell.layouts.address_shell_input cleanInput(Address_Shell.layouts.batch_in le, UNSIGNED c) := TRANSFORM
		cleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(le.StreetAddress1, le.City, le.State, le.Zip5);
		cleanedFields := Address.CleanFields(cleanAddr);
		
		SELF.StreetNumber := cleanedFields.Prim_Range;
		SELF.StreetPreDirection := cleanedFields.Predir;
		SELF.StreetName := cleanedFields.Prim_Name;
		SELF.StreetSuffix := cleanedFields.Addr_Suffix;
		SELF.StreetPostDirection := cleanedFields.Postdir;
		SELF.UnitDesignation := cleanedFields.Unit_Desig;
		SELF.UnitNumber := cleanedFields.Sec_Range;
		SELF.StreetAddress1 := Address.Addr1FromComponents(cleanedFields.Prim_Range, cleanedFields.Predir,	cleanedFields.Prim_Name, cleanedFields.Addr_Suffix, cleanedFields.Postdir, cleanedFields.Unit_Desig, cleanedFields.Sec_Range);
		SELF.StreetAddress2 := le.StreetAddress2;
		SELF.City := cleanedFields.V_City_Name;
		SELF.State := cleanedFields.St;
		SELF.Zip5 := cleanedFields.ZIP;
		SELF.Zip4 := cleanedFields.ZIP4;
		SELF.County := cleanedFields.County[3..5]; // We only want the last 3 for county
		capsCity := TRIM(StringLib.StringToUpperCase(le.City));
		useCity := IF(capsCity = '', TRIM(cleanedFields.V_City_Name), capsCity);
		SELF.StateCityZip := IF(useCity <> '' AND TRIM(cleanedFields.St) <> '' AND TRIM(cleanedFields.ZIP) <> '', useCity + ', ' + TRIM(cleanedFields.St) + ' ' + TRIM(cleanedFields.ZIP), '');

		// We need the GeoLink and GeoLat/GeoLong for searching of keys
		SELF.GeoLat := cleanedFields.Geo_Lat;
		SELF.GeoLong := cleanedFields.Geo_Long;
		SELF.GeoLink := cleanedFields.St + cleanedFields.County[3..5] + cleanedFields.Geo_Blk; // State + County + GeoBlock
	
		// Keep the Address Cleaner Error Stat to see if we should return an Address Clean Failed attribute
		SELF.Err_Stat := cleanedFields.Err_Stat;
		
		SELF.Seq := (STRING)c;
		SELF.DPPAPurpose := IF(GLBPurpose > 0, (STRING)GLBPurpose, '0');
		SELF.GLBPurpose := IF(DPPAPurpose > 0, (STRING)DPPAPurpose, '0');
		SELF.AccountNumber := IF(TRIM(le.AcctNo) IN ['', '\n'], (STRING)c, le.AcctNo);
		SELF.DataRestrictionMask := IF(TRIM(outOfBandDataRestriction) <> '',outOfBandDataRestriction,Risk_Indicators.iid_constants.default_DataRestriction);
		
		SELF := [];
	END;
	
	cleanedInput := PROJECT(batch_In, cleanInput(LEFT, COUNTER));
	
	/* ***********************************************************
	 *                 Get the input options                     *
	 *************************************************************/
	STRING30 AddressBasedPRAttrVersion := '' : STORED('AddressBasedPRAttrVersion');
	STRING30 PropertyInfoAttrVersion 	:= '' : STORED('PropertyInfoAttrVersion');

	publicRecordsAttributesVersion := IF(TRIM(AddressBasedPRAttrVersion) <> '' AND StringLib.StringContains(AddressBasedPRAttrVersion, 'addressbasedprattrv', TRUE),(UNSIGNED1)(AddressBasedPRAttrVersion[20..]),0);
	propertyInformationAttributesVersion := IF(TRIM(PropertyInfoAttrVersion) <> '' AND StringLib.StringContains(PropertyInfoAttrVersion, 'propertyinfoattrv', TRUE),(UNSIGNED1)(PropertyInfoAttrVersion[18..]),0);
																				
	// propertyInformationGatewayURL := gatewaysIn(StringLib.StringToLowerCase(servicename) = 'reportservice')[1].url;
		
	/* **********************************************************
	 *             Get the requested attribues                  *
	 ************************************************************/
	pubRecs := Address_Shell.getPropertyAttributes(cleanedInput, publicRecordsAttributesVersion);
	
	propertyRecs := Address_Shell.getPropertyCharacteristics_batch(cleanedInput, propertyInformationAttributesVersion, gatewaysIn);
	
	// Combine and flatten the attributes for batch
	combinedAttributes := JOIN(propertyRecs, pubRecs, LEFT.Input.GeoLink = RIGHT.Input.GeoLink, TRANSFORM(Address_Shell.layoutBatchOutput, 
			SELF.AcctNo := LEFT.Input.AccountNumber;
			SELF := LEFT.Input; 
			SELF := RIGHT.PropertyAttributes.Version1;
			SELF := LEFT.PropertyCharacteristics.Attributes;
			SELF := LEFT.PropertyCharacteristics.Characteristics;
			SELF := LEFT.PropertyCharacteristics.Mortgages;
			SELF := LEFT.PropertyCharacteristics.Sales;
			SELF := LEFT.PropertyCharacteristics.Taxes;
			SELF.Address_Based_Public_Record__state := RIGHT.PropertyAttributes.Version1.State;
			SELF.Property_Information__county := LEFT.PropertyCharacteristics.Address.County;
			SELF.property_information__postal_code := LEFT.PropertyCharacteristics.Address.Postal_Code;
			SELF.Property_Information__census_tract := LEFT.PropertyCharacteristics.Address.census_tract;
			SELF.Property_Information__street_number := LEFT.PropertyCharacteristics.Address.street_number;
			SELF.Property_Information__street_pre_direction := LEFT.PropertyCharacteristics.Address.street_pre_direction;
			SELF.Property_Information__street_name := LEFT.PropertyCharacteristics.Address.street_name;
			SELF.Property_Information__street_suffix := LEFT.PropertyCharacteristics.Address.street_suffix;
			SELF.Property_Information__street_post_direction := LEFT.PropertyCharacteristics.Address.street_post_direction;
			SELF.Property_Information__unit_designation := LEFT.PropertyCharacteristics.Address.unit_designation;
			SELF.Property_Information__unit_number := LEFT.PropertyCharacteristics.Address.unit_number;
			SELF.Property_Information__street_address_1 := LEFT.PropertyCharacteristics.Address.street_address_1;
			SELF.Property_Information__street_address_2 := LEFT.PropertyCharacteristics.Address.street_address_2;
			SELF.Property_Information__city := LEFT.PropertyCharacteristics.Address.city;
			SELF.Property_Information__state := LEFT.PropertyCharacteristics.Address.state;
			SELF.Property_Information__zip_5 := LEFT.PropertyCharacteristics.Address.zip_5;
			SELF.Property_Information__zip_4 := LEFT.PropertyCharacteristics.Address.zip_4;
			SELF.Property_Information__state_city_zip := LEFT.PropertyCharacteristics.Address.state_city_zip;
			SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(100));

/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.    ECL Developers use only. *
   ************************************************************/
	Address_Shell.debuggingFields();
	
	RETURN OUTPUT(combinedAttributes, NAMED('Results'));
END;

