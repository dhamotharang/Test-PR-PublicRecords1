/*--SOAP--
	<message name="OrderScore_Service">
		<part name="OrderScoreRequest" type="tns:XmlDataSet" cols="80"
  	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
		<part name="HistoryDateTimeStamp" type="xsd:string"/>
		<part name="ipid_only" type="xsd:boolean"/>
		<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
	</message>
*/

/*  add call to the first custom model   */  
/*        April 2017                     */

import address, Risk_Indicators, RiskWise, Suppress, Models, ut, royalty, iesp, Std, Risk_Reporting, Business_Risk_BIP;

export OrderScore_Service := MACRO

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
	#stored('DPPAPurpose',RiskWise.permittedUse.fraudDPPA);	
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	#stored('DataPermissionMask', Risk_Indicators.iid_constants.default_DataPermission);

	#WEBSERVICE(FIELDS(
			'OrderScoreRequest',
			'HistoryDateYYYYMM',
			'HistoryDateTimeStamp',
			'ipid_only',
			'gateways'));


	BOOLEAN DEBUG := False;                                    //Set to TRUE for Round 1 and Round 2 validation and to FALSE when you are creating TEST SEEDS
	
	BOOLEAN   ipid_only  := FALSE  : stored('ipid_only');

  rec_in     := iesp.orderscore.t_OrderScoreRequest;
	ds_in      := DATASET([],rec_in) : STORED('OrderScoreRequest',few);	

  firstrow := ds_in[1] : INDEPENDENT;

	searchBT := GLOBAL(firstRow.SearchBy.BillTo);
	searchST := GLOBAL(firstRow.SearchBy.ShipTo);
	
	option := GLOBAL(firstRow.Options);
	users := GLOBAL(firstRow.User);

/* **********************************************
	 *  Fields needed for improved Scout Logging  *
	 **********************************************/
	string32 _LoginID               := ''	: STORED('_LoginID');
	outofbandCompanyID							:= '' : STORED('_CompanyID');
	string20 CompanyID              := if(users.CompanyId != '', users.CompanyId, outofbandCompanyID);
	string20 FunctionName           := '' : STORED('_LogFunctionName');
	string50 ESPMethod              := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
	string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
	string10 SSN_Mask                := if(Users.SSNMask = '', 'none', Users.SSNMask);
	outofbanddobmask                := '' : STORED('DOBMask');
	string10 DOB_Mask               := if(users.DOBMask != '', users.DOBMask, outofbanddobmask);
	BOOLEAN DL_Mask                 := users.DLMask;
	BOOLEAN ExcludeDMVPII           := users.ExcludeDMVPII;
	BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
	BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Models__OrderScore_Service);
/* ************* End Scout Fields **************/


/* ***************************************
	 *           Set BILL to Search By:            *
   *************************************** */
	string62	fullname_value := searchBT.Name.Full;
	string20 first_value := searchBT.Name.First;
	string20 mname_val := searchBT.Name.Middle;
	string20 last_value := searchBT.Name.Last;
	string5 suffix_val := searchBT.Name.Suffix;
	string3 prefix_val := searchBT.Name.Prefix;
	STRING28 streetName := searchBT.Address.StreetName;
	STRING10 streetNumber := searchBT.Address.StreetNumber;
	STRING2 streetPreDirection := searchBT.Address.StreetPreDirection;
	STRING2 streetPostDirection := searchBT.Address.StreetPostDirection;
	STRING4 streetSuffix := searchBT.Address.StreetSuffix;
	STRING8 UnitNumber := searchBT.Address.UnitNumber;
	STRING10 UnitDesig := searchBT.Address.UnitDesignation;
	STRING60 tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	STRING60 in_streetAddress1 := IF(searchBT.Address.StreetAddress1='', tempStreetAddr, searchBT.Address.StreetAddress1);
	STRING60 in_streetAddress2 := searchBT.Address.StreetAddress2;
	
	STRING120 addr_value := TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2);
	STRING25 city_value := searchBT.Address.City;
	STRING2 state_value := searchBT.Address.State;
	STRING5 zip_value := searchBT.Address.Zip5;
	STRING18 County := searchBT.Address.County;
	// Other PII
	tmpDOB := iesp.ECL2ESP.DateToString(searchBT.DOB);
	STRING8 dob_value :=  IF(tmpDOB = '00000000', '', tmpDOB);
	STRING9 socs_value := searchBT.SSN;
	STRING10 hphone_value := searchBT.Phone10;
	STRING15 drlc_value := searchBT.DriverLicenseNumber;
	STRING2 drlcstate_value := searchBT.DriverLicenseState;
	STRING50 email_value := searchBT.EmailAddress;
	string45  ipaddr_value := searchBT.IPAddress;

/* ***************************************
	 *           Set SHIP to Search By:            *
   *************************************** */
	string62	fullname2_value := searchST.Name.Full;
	string20 first2_value := searchST.Name.First;
	string20 mname2_val := searchST.Name.Middle;
	string20 last2_value := searchST.Name.Last;
	string5 suffix2_val := searchST.Name.Suffix;
	string3 prefix2_val := searchST.Name.Prefix;
	STRING28 streetName2 := searchST.Address.StreetName;
	STRING10 streetNumber2 := searchST.Address.StreetNumber;
	STRING2 streetPreDirection2 := searchST.Address.StreetPreDirection;
	STRING2 streetPostDirection2 := searchST.Address.StreetPostDirection;
	STRING4 streetSuffix2 := searchST.Address.StreetSuffix;
	STRING8 UnitNumber2 := searchST.Address.UnitNumber;
	STRING10 UnitDesig2 := searchST.Address.UnitDesignation;
	STRING60 tempStreetAddr2 := Address.Addr1FromComponents(streetNumber2, StreetPreDirection2,	streetName2, StreetSuffix2, StreetPostDirection2, UnitDesig2, UnitNumber2);
	STRING60 in_streetAddress12 := IF(searchST.Address.StreetAddress1='', tempStreetAddr2, searchST.Address.StreetAddress1);
	STRING60 in_streetAddress22 := searchST.Address.StreetAddress2;
	
	STRING120 addr2_value := TRIM(in_streetAddress12) + ' ' + TRIM(in_streetAddress22);
	STRING25 city2_value := searchST.Address.City;
	STRING2 state2_value := searchST.Address.State;
	STRING5 zip2_value := searchST.Address.Zip5;
	STRING18 County2 := searchST.Address.County;
	// Other PII
	tmpDOB2 := iesp.ECL2ESP.DateToString(searchST.DOB);
	STRING8 dob2_value :=  IF(tmpDOB2 = '00000000', '', tmpDOB2);
	STRING9 socs2_value := searchST.SSN;
	STRING10 hphone2_value := searchST.Phone10;
	STRING15 drlc2_value := searchST.DriverLicenseNumber;
	STRING2 drlcstate2_value := searchST.DriverLicenseState;
	STRING50 email2_value := searchST.EmailAddress;

/* ***************************************
	 *           Set User Values:          *
   *************************************** */
  STRING20 account_value := users.AccountNumber;
	BOOLEAN Test_Data_Enabled := (boolean) users.TestDataEnabled;
	STRING32 Test_Data_Table_Name := StringLib.StringToUpperCase(TRIM(users.TestDataTableName, LEFT, RIGHT));
 
	STRING outOfBandDataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
  STRING DataRestriction := IF(TRIM(users.DataRestrictionMask) <> '', users.DataRestrictionMask, outOfBandDataRestriction);

	STRING outOfBandDataPermission := Risk_Indicators.iid_constants.default_DataPermission : STORED('DataPermissionMask');
  STRING DataPermission := MAP(TRIM(users.DataPermissionMask) <> '' => users.DataPermissionMask,
                                  TRIM(outOfBandDataPermission) <> ''  => outOfBandDataPermission,
                                                                           Risk_Indicators.iid_constants.default_DataPermission);
	unsigned1 DPPAPurpose_tmp := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
  unsigned1 DPPAPurpose := (unsigned1) IF(TRIM((string) users.DLPurpose) <> '', (string) users.DLPurpose, (string) DPPAPurpose_tmp);
	
	unsigned1 GLBPurposeTmp  := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
  unsigned1 GLBPurpose := (unsigned1) IF(TRIM((string) users.GLBPurpose) <> '', 
		(string) users.GLBPurpose, (string) GLBPurposeTmp);
 
	string50 QueryId := users.QueryId;
	
	#stored('DisableBocaShellLogging', DisableOutcomeTracking); 
 
  /* ***************************************
	 *          Display GLB error if it's not entered on input            *
   *************************************** */
	IF(TRIM(users.GLBPurpose) IN ['','0','-'], FAIL('GLB permissible purpose is required to utilize this product.'));
  
 /* ***************************************
	 *           Set Options Values:            *
   *************************************** */
//if nothing is entered for OrderType then default to Physical
	STRING TypeOfOrder_value	:= if(option.OrderType <> '', option.OrderType, risk_indicators.iid_constants.PhysicalOrder );
	STRING20 DeviceProvider1_value := (STRING20) option.DeviceProviderScore1;
	STRING20 DeviceProvider2_value := (STRING20) option.DeviceProviderScore2;
	STRING20 DeviceProvider3_value := (STRING20) option.DeviceProviderScore3;
	STRING20 DeviceProvider4_value := (STRING20) option.DeviceProviderScore4;

	Layout_Attributes_In := RECORD
		string name;
	END;

	Layout_Attributes_In GetAttributeName(iesp.share.t_StringArrayItem le, integer c) := transform
		self.name := le.value;
	end;
	attributesInput := option.AttributesVersionRequest;
	attributesIn := project(attributesInput,  GetAttributeName(left, counter))(name != '');
	stringified_attributesIn := Business_Risk_BIP.Common.convertDelimited(attributesIn, name, '|');

	genericModelName := trim(StringLib.StringToLowerCase(option.IncludeModels.OrderScore));
	//reserved for future use of the model options - similar to code below...I think
	// cmGrade           := StringLib.StringToLowerCase(TRIM(option.IncludeModels.ModelOptions[1].OptionName)) = 'grade';
	// cmGradeValue      := StringLib.StringToUpperCase(TRIM(option.IncludeModels.ModelOptions[1].OptionValue));
  // cmDeliverable           := StringLib.StringToLowerCase(TRIM(option.IncludeModels.ModelOptions[1].OptionName)) = 'delivery';
  // cmDeliverableValue      := StringLib.StringToUpperCase(TRIM(option.IncludeModels.ModelOptions[1].OptionValue));
  // cmTotal           := StringLib.StringToLowerCase(TRIM(option.IncludeModels.ModelOptions[1].OptionName)) = 'total_amount';
  // cmTotalValue      := StringLib.StringToUpperCase(TRIM(option.IncludeModels.ModelOptions[1].OptionValue));
  
  
  cmDeliverableOption           := option.IncludeModels.ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'delivery');
  cmDeliverableValue      := StringLib.StringToUpperCase(TRIM(cmDeliverableOption[1].OptionValue));
  cmTotalAmountOption           := option.IncludeModels.ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'total_amount' );
  cmTotalValue      := StringLib.StringToUpperCase(TRIM(cmTotalAmountOption[1].OptionValue));

  /* ***************************************
	 *           Set Users Values:           *
   *************************************** */
	unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
	string20 HistoryDateTimeStamp := '' : STORED('HistoryDateTimeStamp');
	gateways_input := Gateway.Configuration.Get();

	boolean skip_businessHeader := IF(genericModelName = 'osn1608_1', true, false);
	
	Gateway.Layouts.Config gwSwitch(gateways_input le) := transform
		//notice this code is NOT the same as CBD!!!
		//adding real time Inquiry searching
		self.servicename := IF(genericModelName IN ['osn1504_0', 
		                                            'osn1608_1', 
		                                            'osn1803_1'], 
																								le.servicename, '');
																								
		netCheck := if(StringLib.StringToLowerCase(le.servicename) = 'targus' OR 
																		genericModelName NOT IN ['osn1504_0', 
																		                         'osn1608_1', 
																		                         'osn1803_1'], 
																														 false, true);
																		
		self.url := if(netCheck or (stringlib.StringToLowerCase(trim(le.servicename)) in
									[Gateway.Constants.ServiceName.DeltaInquiry]), 
									le.url,  ''); //netacuity will be the only gateway we use in the bocashell processing, default to no gateway call			 
 
		self := le;
	end;
	gateways_in := project(gateways_input, gwSwitch(left));

	isUtility        := false;
	ln_branded       := false;
	ofac_only        := true;
	suppressneardups := true;
	
	includeRelatives := true;		
	includeDLInfo    := false;		// not used anymore
	includeDerogs    := true;
	
	ExcludeWatchLists := true;	// trying this out to save some time, doesn't seem to need it ever at this point.  will turn off ofac searching

	Boolean NetAcuity_v4 := true;

	attributes_v4 := ['identityv4','velocityv4','relationshipv4'];
	attributes_allversions := attributes_v4;
		

	layout_settings := record
		unsigned1 bsVersion;
		unsigned1 attrVersion;
		boolean validRequest;
		boolean getIdentity;
		boolean getRelationship;
		boolean getVelocity;
		string names;
	end;
	layout_settings checkSettings( attributesIn le, integer c ) := TRANSFORM
		name := trim(StringLib.StringToLowercase(le.name)); 
		self.bsVersion    := map(
			name in attributes_v4 => 51,
			2
		);
		self.attrVersion    := map(
			name in attributes_v4 => 4,
			trim(name) = ''       => 0,
			error( 'Invalid attribute group requested (' + name + ')' )
		);
		self.validRequest := name in attributes_allversions;
		self.getIdentity     := name[..8]  = 'identity';
		self.getRelationship := name[..12] = 'relationship';
		self.getVelocity     := name[..8]  = 'velocity';
		self.names := name;
	END;
	settings := project( attributesIn, checkSettings(left, counter) );
	
	modelBSVersion := if (genericModelName in ['osn1803_1'],53 ,51);
											
	includeVehicles  := FALSE;
	
	attrbsversion     := max(settings, bsversion);
	bsversion := if(genericModelName != '', MAX(attrbsversion, modelBSVersion), attrbsversion);
	attrversion   := max( settings, attrversion );
	require2Ele   := exists(settings) and not exists(settings(not validRequest));
	goodAttributeRequest := not exists(settings) or not exists(settings(not validRequest));
	//if bsversion 50 for the model and want cbd attributes of 40, then we need to run the clam as 50 for CBD
	//and run another clam for 4 for attributes.
	bsV5andAttrV4 := if(bsversion >= 51 and attrbsversion = 4 and genericModelName != '', true, false);
  doscore := true; //this is to access the FDN scores/attributes

	doIdentity     := exists(settings(getIdentity));
	doRelationship := exists(settings(getRelationship));
	doVelocity     := exists(settings(getVelocity));

	d := dataset([{0}],{integer seq});
	
	Models.layouts_OrderScore.Layout_OS_In addseq(d l, INTEGER C) := TRANSFORM
	#If(DEBUG)
		self.seq := (Integer)account_value;
	#Else
		self.seq := C;
		//self.seq := (Integer)account_value;	
	#End
		self.account := account_value;
	//bill to
	cleaned_name := address.CleanPerson73(fullname_value);
	boolean valid_cleaned := fullname_value <> '';
		
		self.first := stringlib.stringtouppercase(if(first_value='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).fname, first_value));
		self.middle := stringlib.stringtouppercase(if(mname_val='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).mname, mname_val));
		self.last := stringlib.stringtouppercase(if(last_value='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).lname, last_value));
		self.suffix := stringlib.stringtouppercase(if(suffix_val ='' AND valid_cleaned, 
			address.cleanNameFields(cleaned_name).name_suffix, suffix_val));		
		self.addr := StringLib.StringToUppercase( addr_value );
		self.city := StringLib.StringToUppercase( city_value );
		self.state := StringLib.StringToUppercase( state_value );
		self.zip := StringLib.StringToUppercase( zip_value );
		self.hphone := StringLib.StringToUppercase( hphone_value );
		self.socs := StringLib.StringToUppercase( socs_value );
		self.email := StringLib.StringToUppercase( email_value );
		self.dob := riskwise.cleandob(dob_value);
		self.drlc := StringLib.StringToUppercase( drlc_value );
		self.drlcstate := StringLib.StringToUppercase( drlcstate_value );
		self.ipaddr := StringLib.StringToUppercase( ipaddr_value );
		//ship to
		cleaned_name2 := address.CleanPerson73(fullname2_value);
		boolean valid_cleaned2 := fullname2_value <> '';	
		self.first2 := stringlib.stringtouppercase(if(first2_value='' AND valid_cleaned2, 
			address.cleanNameFields(cleaned_name2).fname, first2_value));
		self.middle2 := stringlib.stringtouppercase(if(mname2_val='' AND valid_cleaned2, 
			address.cleanNameFields(cleaned_name2).mname, mname2_val));
		self.last2 := stringlib.stringtouppercase(if(last2_value='' AND valid_cleaned2, 
			address.cleanNameFields(cleaned_name2).lname, last2_value));
		self.suffix2 := stringlib.stringtouppercase(if(suffix2_val ='' AND valid_cleaned2, 
			address.cleanNameFields(cleaned_name2).name_suffix, suffix2_val));		
		self.addr2 := StringLib.StringToUppercase( addr2_value );
		self.city2 := StringLib.StringToUppercase( city2_value );
		self.state2 := StringLib.StringToUppercase( state2_value );
		self.zip2 := StringLib.StringToUppercase( zip2_value );
		self.socs2 := StringLib.StringToUppercase( socs2_value );
		self.hphone2 := StringLib.StringToUppercase( hphone2_value );
		self.TypeOfOrder := StringLib.StringToUppercase( TypeOfOrder_value );
		self.drlc2 := StringLib.StringToUppercase( drlc2_value );
		self.drlcstate2 := StringLib.StringToUppercase( drlcstate2_value );	
		self.email2 := StringLib.StringToUppercase( email2_value );
		self.dob2 := riskwise.cleandob(dob2_value);
		self.DeviceProvider1_value := DeviceProvider1_value;
		self.DeviceProvider2_value := DeviceProvider2_value;
		self.DeviceProvider3_value := DeviceProvider3_value;
		self.DeviceProvider4_value := DeviceProvider4_value;
		self.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(HistoryDateTimeStamp, history_date);
		self.historydate := if(HistoryDateTimeStamp <> '',(unsigned)HistoryDateTimeStamp[1..6], history_date);

	END;
	indata := PROJECT(d, addseq(LEFT,COUNTER));
	
	// turn on HHIDSummary searching for shell 5.0 and higher
// other options should probably also be turned on, but for right now in this release just turn on HHIDSummary so we don't impact any other customers without them knowing about it
	BSOptions := if(bsversion >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0);
	
	iid_results := Models.ChargebackDefender_Function(indata, gateways_in, GLBPurpose, DPPAPurpose, ipid_only, 
																										dataRestriction, ofac_only,
																										suppressneardups, require2Ele, bsVersion, dataPermission, BSOptions );

	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct fill_output(iid_results le, indata ri) := TRANSFORM
			self.AccountNumber := ri.account;
			self.seq := ri.seq;
			//bill to verified name
			self.Result.BillTo.UniqueID := (string)le.bill_to_output.DID;
			self.Result.BillTo.VerifiedInput.Name.First := le.bill_to_output.combo_first;
			self.Result.BillTo.VerifiedInput.Name.Last := le.bill_to_output.combo_last;
			//bill to verified address
			self.Result.BillTo.VerifiedInput.Address.StreetNumber := le.bill_to_output.combo_prim_range;
			self.Result.BillTo.VerifiedInput.Address.StreetPreDirection := le.bill_to_output.combo_predir;
			self.Result.BillTo.VerifiedInput.Address.StreetName := le.bill_to_output.combo_prim_name;
			self.Result.BillTo.VerifiedInput.Address.StreetSuffix := le.bill_to_output.combo_suffix;
			self.Result.BillTo.VerifiedInput.Address.StreetPostDirection := le.bill_to_output.combo_postdir;
			self.Result.BillTo.VerifiedInput.Address.UnitDesignation := le.bill_to_output.combo_unit_desig;
			self.Result.BillTo.VerifiedInput.Address.UnitNumber := le.bill_to_output.combo_sec_range;
			self.Result.BillTo.VerifiedInput.Address.StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('',
				le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,
				le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,
				le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,
				le.bill_to_output.combo_sec_range);
			self.Result.BillTo.VerifiedInput.Address.City := le.bill_to_output.combo_city;
			self.Result.BillTo.VerifiedInput.Address.State := le.bill_to_output.combo_state;
			self.Result.BillTo.VerifiedInput.Address.Zip5 := le.bill_to_output.combo_zip[1..5];
			self.Result.BillTo.VerifiedInput.Address.Zip4 := le.bill_to_output.combo_zip[6..9];
			self.Result.BillTo.VerifiedInput.Address.StateCityZip := trim(le.bill_to_output.combo_state)+trim(le.bill_to_output.combo_city) + trim(le.bill_to_output.combo_zip[1..5]);;		
			//bill to corrected
			self.Result.BillTo.InputCorrected.Name.Last := le.bill_to_output.correctlast;
			self.Result.BillTo.InputCorrected.Phone10 := le.bill_to_output.correcthphone;
			self.Result.BillTo.InputCorrected.Address.StreetAddress1 := le.bill_to_output.correctaddr;
			self.Result.BillTo.InputCorrected.SSN := le.bill_to_output.correctssn;
			//bill to other fields
			self.Result.BillTo.PhoneOfNameAddress := le.bill_to_output.name_addr_phone;	
			self.Result.BillTo.NameAddressSSNSummary := (string)le.bill_to_output.socsverlevel;
			self.Result.BillTo.PhoneType := (string)le.bill_to_output.hphonetypeflag;
			self.Result.BillTo.SIC := (string)le.bill_to_output.hrisksic; //is this right???
			self.Result.BillTo.NameAddressPhoneSummary := (string) le.bill_to_output.phoneverlevel;
			self.Result.BillTo.DwellingType  := if(le.bill_to_output.addr_type='S' and le.bill_to_output.addrvalflag='N', '', le.bill_to_output.addr_type); 

			self.Result.BillTo.NewAreaCode.AreaCode := le.bill_to_output.altareacode;
			//might need to convert to iesp date
			self.Result.BillTo.NewAreaCode.EffectiveDate := iesp.ECL2ESP.toDate((integer)le.bill_to_output.areacodesplitdate);
			//ship to
			self.Result.ShipTo.UniqueID := (string)le.ship_to_output.DID;
			self.Result.ShipTo.VerifiedInput.Name.First := le.ship_to_output.combo_first;
			self.Result.ShipTo.VerifiedInput.Name.Last := le.ship_to_output.combo_last;	
			//bill to verified address
			self.Result.ShipTo.VerifiedInput.Address.StreetNumber := le.Ship_To_output.combo_prim_range;
			self.Result.ShipTo.VerifiedInput.Address.StreetPreDirection := le.Ship_To_output.combo_predir;
			self.Result.ShipTo.VerifiedInput.Address.StreetName := le.Ship_To_output.combo_prim_name;
			self.Result.ShipTo.VerifiedInput.Address.StreetSuffix := le.Ship_To_output.combo_suffix;
			self.Result.ShipTo.VerifiedInput.Address.StreetPostDirection := le.Ship_To_output.combo_postdir;
			self.Result.ShipTo.VerifiedInput.Address.UnitDesignation := le.Ship_To_output.combo_unit_desig;
			self.Result.ShipTo.VerifiedInput.Address.UnitNumber := le.Ship_To_output.combo_sec_range;
			self.Result.ShipTo.VerifiedInput.Address.StreetAddress1 := Risk_Indicators.MOD_AddressClean.street_address('',
				le.Ship_To_output.combo_prim_range,le.Ship_To_output.combo_predir,
				le.Ship_To_output.combo_prim_name,le.Ship_To_output.combo_suffix,
				le.Ship_To_output.combo_postdir,le.Ship_To_output.combo_unit_desig,
				le.Ship_To_output.combo_sec_range);
			self.Result.ShipTo.VerifiedInput.Address.City := le.Ship_To_output.combo_city;
			self.Result.ShipTo.VerifiedInput.Address.State := le.Ship_To_output.combo_state;
			self.Result.ShipTo.VerifiedInput.Address.Zip5 := le.Ship_To_output.combo_zip[1..5];
			self.Result.ShipTo.VerifiedInput.Address.Zip4 := le.Ship_To_output.combo_zip[6..9];
			self.Result.ShipTo.VerifiedInput.Address.StateCityZip := trim(le.Ship_To_output.combo_state)+trim(le.Ship_To_output.combo_city) + trim(le.Ship_To_output.combo_zip[1..5]);;		
			//bill to corrected
			self.Result.ShipTo.InputCorrected.Name.Last := le.Ship_To_output.correctlast;
			self.Result.ShipTo.InputCorrected.Phone10 := le.Ship_To_output.correcthphone;
			self.Result.ShipTo.InputCorrected.Address.StreetAddress1 := le.Ship_To_output.correctaddr;
			self.Result.ShipTo.InputCorrected.SSN := le.Ship_To_output.correctssn;
			//bill to other fields
			self.Result.ShipTo.PhoneOfNameAddress := le.Ship_To_output.name_addr_phone;	
			self.Result.ShipTo.NameAddressSSNSummary := (string)le.Ship_To_output.socsverlevel;
			self.Result.ShipTo.NameAddressPhoneSummary := (string)le.Ship_To_output.phoneverlevel;
			self.Result.ShipTo.SIC := (string)le.Ship_To_output.hrisksic; //is this right???

			self.Result.ShipTo.PhoneType := (string) le.Ship_To_output.hphonetypeflag;
			self.Result.ShipTo.DwellingType  := if(le.Ship_To_output.addr_type='S' and le.Ship_To_output.addrvalflag='N', '', le.Ship_To_output.addr_type); 

			self.Result.ShipTo.NewAreaCode.AreaCode := le.Ship_To_output.altareacode;
			//might need to convert to iesp date
			self.Result.ShipTo.NewAreaCode.EffectiveDate := iesp.ECL2ESP.toDate((integer) le.Ship_To_output.areacodesplitdate);
			self.Result := []; //other fields not yet populated
	end;

	mapped_results := JOIN(iid_results, indata, 
		left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);

	// IP DATA
	riskwise.Layout_IPAI prep_ips(iid_results le) := transform
		self.seq := le.bill_to_output.seq;
		self.ipaddr := le.Bill_to_output.ip_address;
	end;
	
	ip_prep := ungroup(project(iid_results, prep_ips(left)));
		
	Gateway.Layouts.Config gwIPIDCheck(gateways_input le) := transform
		self.servicename := IF(StringLib.StringToLowerCase(le.servicename) = 'netacuity' and ~ipid_only,'', le.servicename);
		self.url := if(StringLib.StringToLowerCase(le.servicename) = 'netacuity' and ~ipid_only, '', le.url);		 
		self := le;
	end;

	gateways_in_tempNetAcuity := project(gateways_input, gwIPIDCheck(left));

	ips := risk_indicators.getNetAcuity(ip_prep, gateways_in_tempNetAcuity, DPPAPurpose, GLBPurpose, NetAcuity_v4);


	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct addIP(Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct le, ips ri) := TRANSFORM
			self.AccountNumber := le.AccountNumber;
			self.seq := le.seq;
			self.Result.IPAddressID.Continent := ri.continent;
			self.Result.IPAddressID.Country := StringLib.StringToUpperCase(ri.countrycode);
			self.Result.IPAddressID.RoutingType := if(Stringlib.StringFilterOut(ri.ipaddr[1],'0123456789') = '', ri.iproutingmethod, '');
			self.Result.IPAddressID.State := if(StringLib.StringToUpperCase(ri.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(ri.state), '');
			self.Result.IPAddressID.Zip := if(StringLib.StringToUpperCase(ri.countrycode[1..2]) = 'US', ri.zip, '');
			self.Result.IPAddressID.AreaCode := if(ri.areacode <> '0', ri.areacode, '');	
			self.Result.IPAddressID.TopLevelDomain := StringLib.StringToUpperCase(ri.topleveldomain);
			self.Result.IPAddressID.SecondLevelDomain := StringLib.StringToUpperCase(ri.secondleveldomain);
			self.Result := le.Result
	end;

	withIP := JOIN(mapped_results, ips, (left.seq*2) = right.seq, addIP(left,right), left outer);
	
ScoresInput := project(indata, transform(Risk_Indicators.Layout_BocaShell_BtSt.input_Scores,
	self.DeviceProvider1_value := DeviceProvider1_value;
	self.DeviceProvider2_value := DeviceProvider2_value;
	self.DeviceProvider3_value := DeviceProvider3_value;
	self.DeviceProvider4_value := DeviceProvider4_value;
	self.btst_order_type := StringLib.StringToUppercase( TypeOfOrder_value );
	self.seq := left.seq));	
	//self.seq := left.seq * 2)); //done in BTST function

	cd2i_in := project(indata, transform(riskwise.layout_cd2i, self := left));

	clam := Risk_Indicators.BocaShell_BtSt_Function(
		iid_results,
		gateways_in,
		DPPAPurpose,
		GLBPurpose,
		isUtility,
		false, // not needed -- isLN  
		includeRelatives,
		includeDLInfo,
		includeVehicles,
		includeDerogs,
		bsversion,
		doscore, // do score
		true, // nugen
		DataRestriction,
		BSOptions,
		DataPermission, 
		ScoresInput,
		NetAcuity_v4, //true for CBD5.1 models
		ipid_only,
		skip_businessHeader
	);

	
	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct addIP_BTSTFunc(Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct le, clam ri) := TRANSFORM
			self.AccountNumber := le.AccountNumber;
			self.seq := le.seq;
			self.Result.IPAddressID.Continent :=  ri.ip2o.continent;
			self.Result.IPAddressID.Country := StringLib.StringToUpperCase(ri.ip2o.countrycode);
			self.Result.IPAddressID.RoutingType := if(Stringlib.StringFilterOut(ri.ip2o.ipaddr[1],'0123456789') = '', ri.ip2o.iproutingmethod, '');
			self.Result.IPAddressID.State := if(StringLib.StringToUpperCase(ri.ip2o.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(ri.ip2o.state), '');
			self.Result.IPAddressID.Zip := if(StringLib.StringToUpperCase(ri.ip2o.countrycode[1..2]) = 'US', ri.ip2o.zip, '');
			self.Result.IPAddressID.AreaCode := if(ri.ip2o.areacode <> '0', ri.ip2o.areacode, '');		
			self.Result.IPAddressID.TopLevelDomain := StringLib.StringToUpperCase(ri.ip2o.topleveldomain);
			self.Result.IPAddressID.SecondLevelDomain := StringLib.StringToUpperCase(ri.ip2o.secondleveldomain);
			self.Result := le.Result
	end;
	
	withIP_BTST := JOIN(mapped_results, clam, (left.seq*2) = right.bill_to_out.seq, 
		addIP_BTSTFunc(left,right), left outer);
	
/* **************  REMOVING INTERMEDIATE LOGGING FOR NOW TO SPEED UP QUERY *******************
	// productID := Risk_Reporting.ProductID.Models__OrderScore_Service;
	// intermediateLog1 := Risk_Reporting.To_LOG_Boca_Shell_BtSt(clam, productID, bsversion);  
	// intermediateLog2 := if(bsV5andAttrV4, Risk_Reporting.To_LOG_Boca_Shell_BtSt(clam4Attributes, productID, attrbsversion));
	// intermediateLog := intermediateLog1 + intermediateLog2;
*******************************************************************************************/	
	
  // so far no clients wanting custom inputs for Order Score. If someone does want it look into the 
	//transform 'getCustomInputs' until the code 'customModelInputs' is set in CBD

/*  Models will be validated and called in this OrderScore_GetScore */   
	#If(DEBUG)
	    //getScore :=  Models.OrderScore_GetScore (clam, ungroup(cd2i_in), ipid_only, genericModelName);
	    getScore :=  Models.OrderScore_GetScore (clam, ungroup(cd2i_in), ipid_only, genericModelName, cmDeliverableValue , (Integer) cmTotalValue);
			getScoreWAcct := record
		    recordof(getScore);
		    string30 account2 := '';
	    end;
			
	    out1 := join(getScore, ungroup(cd2i_in),
		             left.seq = right.seq * 2,                                           //this needs to be the seq # of the bill to
		             transform(getScoreWAcct, self.Account2 := right.Account, self := left));
	#ELSE
	    //getScore :=  Models.OrderScore_GetScore (clam, ungroup(cd2i_in), ipid_only, genericModelName );  
	    getScore :=  Models.OrderScore_GetScore (clam, ungroup(cd2i_in), ipid_only, genericModelName, cmDeliverableValue , (Integer) cmTotalValue );  
	
	
// ****Add the Models to the output 
	iesp.share.t_SequencedRiskIndicator form_rc(getScore le, integer i) := TRANSFORM
		self.sequence := i;
		self.RiskCode := if(trim(le.ri[i].hri) <> '00', le.ri[i].hri, '');
		self.Description := le.ri[i].desc;
	END;
	
	iesp.instantid.t_RISet form_sets(getScore le, integer i) := TRANSFORM
			self.name := if(i=1, 'BillTo', 'ShipTo');
				btreasoncodes :=	PROJECT(le,form_rc(LEFT,1))
												+ PROJECT(le,form_rc(LEFT,2))
												+ PROJECT(le,form_rc(LEFT,3))
												+ PROJECT(le,form_rc(LEFT,4))
												+ PROJECT(le,form_rc(LEFT,5))
												+ PROJECT(le,form_rc(LEFT,6));
				streasoncodes := 	PROJECT(le,form_rc(LEFT,7))
												+ PROJECT(le,form_rc(LEFT,8))
												+ PROJECT(le,form_rc(LEFT,9))
												+ PROJECT(le,form_rc(LEFT,10))
												+ PROJECT(le,form_rc(LEFT,11))
												+ PROJECT(le,form_rc(LEFT,12));
				risk_indicators.mac_add_sequence(if(i=1,btreasoncodes(RiskCode<>''), streasoncodes(RiskCode<>'')), reasons_with_seq);
			self.RiskIndicators := project(reasons_with_seq, 
				transform(iesp.share.t_SequencedRiskIndicator, 
					self.sequence :=  left.seq;
					self.RiskCode := left.RiskCode;
					self.Description := left.Description));
		END;

	iesp.instantid.t_ScoreSequencedRISets form_cscore(getScore le) := TRANSFORM
			self._type := map(
				genericModelName = 'osn1504_0' => 'OSN1504_0',  // Flagship model
				genericModelName = 'osn1608_1' => 'OSN1608_1',  // Vivid Seats custom model
				genericModelName = 'osn1803_1' => 'OSN1803_1',  // Wallmart custom model
				                                  '');
			self.Value := (integer) le.score;
			
			rc_sets := PROJECT(le, form_sets(LEFT,1)) +
									PROJECT(le, form_sets(LEFT,2));
			self.RiskIndicatorSets := rc_sets;
		END;		

	tmp_t_ModelSequencedRISets := record
		string AccountNumber;
		iesp.instantid.t_ModelSequencedRISets;
	end;

	iesp.instantid.t_ModelSequencedRISets form_model(getScore le, string account_value) := TRANSFORM
			self.Name := map(
				genericModelName = 'osn1608_1' => 'OrderScoreOSN1608_1',
				genericModelName = 'osn1803_1' => 'OrderScoreOSN1803_1',
				'OrderScore');
			self.scores := PROJECT(le, form_cscore(LEFT));
	END;
	
	IPData := if(ipid_only, withIP, withIP_BTST);

	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct addBTModel( IPData le, getscore ri ) := TRANSFORM
		formed := project(ri,form_model(LEFT,le.accountNumber));
		self.Result.Models := formed;
		self := le;
	END;	

	withModel := JOIN(IPData, getScore, left.seq*2 = right.seq, 
		addBTmodel(left,right), left outer );

	// ****Choose either full results or just IP results
	ret := if(exists(getscore), withmodel, IPData);
	
	// ****specifically for test data enabled transactions
	Risk_Indicators.Layout_BocaShell_BtSt.BTST_input doTestInput(d l) := transform
	// ****	only set the necessary fields to search test seed record, don't cass input addr
		self.seq := l.seq;
		self.ssn := (string9)trim(socs_value);
		self.phone10 := (string10) trim(hphone_value);
		self.fname := (string15) trim(StringLib.StringToUppercase(first_value));
		self.lname := (string20) trim(StringLib.StringToUppercase(last_value));
		self.z5 := (string9) trim(zip_value);
		self := [];
	END;
	testPrep := PROJECT(d, doTestInput(left));
	
	ret_test_seed := Risk_Indicators.OS_Testseed_Function(testPrep, account_value, Test_Data_Table_Name);
	seed_final := project( ret_test_seed, 
			 transform( Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct,
								 self := left ) );

	os_model := if( Test_Data_Enabled, seed_final, ret );
	
	// ****get attributes
	shell2Use := clam;  

	attributes := Models.getCBDAttributes(shell2Use, account_value, indata, attrversion);	

	 attr_test_seed := Models.OSAttributes_TestSeed_FN(testPrep, account_value, Test_Data_Table_Name);
	
	attrs := map(	Test_Data_Enabled => attr_test_seed,
								~goodAttributeRequest => fail(Models.Layout_CBDAttributes, 'Invalid attribute request'),
								attributes);	// choose either real results or test results
	
	pop := Models.popCBDAttributes( account_value );
	attrgrp_tmp := map(
		attrVersion=4 =>
			  if( doIdentity,     pop.identityv4(attrs) )
			& if( doRelationship, pop.Relationshipv4(attrs) )
			& if( doVelocity,     pop.Velocityv4(attrs) ),
		dataset( [], Models.Layouts.Layout_AttributeGroup )	);

	attrgrp := project( attrgrp_tmp, 
		transform(iesp.orderscore.t_OrderScoreAttributeGroup, 
			self.name := left.name, 
			self.Attributes := project(left.Attributes.attribute, 
						transform(iesp.share.t_NameValuePair, self := left));
			));

	
	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct addTogether(os_model le) := TRANSFORM
			self.Result.AttributeGroups := attrgrp;
			self.Result := le.Result;
			self := le;
	END;
	retAttr := project(os_model, addTogether(left));

	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct blankOS( withmodel le ) := TRANSFORM
		self.Result.BillTo := [];
		self.Result.ShipTo := [];
		self.Result := le.Result;
		self := le;
	END;

	final1 := if( ipid_only, project(ret,blankOS(left)), retAttr );

	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSOut_wAcct addEcho(final1 le) := TRANSFORM
		self.Result.InputEcho.BillTo := searchBT,
		self.Result.InputEcho.ShipTo := searchST;
		self.AccountNumber := le.AccountNumber;
		self.Result := le.Result;
		self._Header.QueryId := QueryId;
		self._Header := [];
		self := le;
	END;
	final_wEcho := PROJECT(final1, addEcho(LEFT));

	Suppress.MAC_Mask(final_wEcho, final2, Result.ShipTo.InputCorrected.SSN, '', true, false, false, false, '', SSN_Mask);
	
	noAttributeScoreIPRequest := ~EXISTS(attributesIn(name<>'')) and genericModelName = '' and ~ipid_only;	// didnt request attributes or score or IPonly
	final3 := if(noAttributeScoreIPRequest, fail(Risk_Indicators.Layout_BocaShell_BtSt.layout_OSOut_wAcct, 'Not a valid request'), final2);

	riskwise.Layout_IP2O add_na(Risk_Indicators.Layout_BocaShell_BtSt_Out le) := transform
		self := le.ip2o;
	end;
	clamy := project(clam, add_na(left));
	
     	
	royalties := IF(~Test_Data_Enabled, 
		if(ipid_only, 
			//ip only
			Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways_in, ip_prep, ips),
			//ip returned from BTST functions
			Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways_in, ip_prep, clamy)));

	//Log to Deltabase
	Deltabase_Logging_prep := project(final3, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.Models__OrderScore_Service,
																								 self.function_name := FunctionName,
																								 self.esp_method := ESPMethod,
																								 self.interface_version := InterfaceVersion,
																								 self.delivery_method := DeliveryMethod,
																								 self.date_added := (STRING8)Std.Date.Today(),
																								 self.death_master_purpose := DeathMasterPurpose,
																								 self.ssn_mask := SSN_Mask,
																								 self.dob_mask := DOB_Mask,
																								 self.dl_mask := (String)(Integer)DL_Mask,
																								 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																								 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																								 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                 self.glb := GLBPurpose,
                                                 self.dppa := DPPAPurpose,
																								 self.data_restriction_mask := DataRestriction,
																								 self.data_permission_mask := DataPermission,
																								 self.industry := Industry_Search[1].Industry,
																								 self.i_attributes_name := stringified_attributesIn,
																								 self.i_ssn := socs_value,
                                                 self.i_dob := dob_value,
                                                 self.i_name_full := fullname_value,
																								 self.i_name_first := first_value,
																								 self.i_name_last := last_value,
																								 self.i_address := addr_value,
																								 self.i_city := city_value,
																								 self.i_state := state_value,
																								 self.i_zip := zip_value,
																								 self.i_dl := drlc_value,
																								 self.i_dl_state := drlcstate_value,
                                                 self.i_home_phone := hphone_value,
																								 self.i_name_first_2 := first2_value,
																								 self.i_name_last_2 := last2_value,
																								 self.i_model_name_1 := genericModelName,
																								 self.i_model_name_2 := '',
																								 self.o_score_1    := (Integer)left.Result.Models[1].Scores[1].Value,
																								 self.o_reason_1_1 := left.Result.Models[1].Scores[1].RiskIndicatorSets[1].RiskIndicators[1].RiskCode,
																								 self.o_reason_1_2 := left.Result.Models[1].Scores[1].RiskIndicatorSets[1].RiskIndicators[2].RiskCode,
																								 self.o_reason_1_3 := left.Result.Models[1].Scores[1].RiskIndicatorSets[1].RiskIndicators[3].RiskCode,
																								 self.o_reason_1_4 := left.Result.Models[1].Scores[1].RiskIndicatorSets[1].RiskIndicators[4].RiskCode,
																								 self.o_reason_1_5 := left.Result.Models[1].Scores[1].RiskIndicatorSets[1].RiskIndicators[5].RiskCode,
																								 self.o_reason_1_6 := left.Result.Models[1].Scores[1].RiskIndicatorSets[1].RiskIndicators[6].RiskCode,
																								 self.o_score_2    := 0,
																								 self.o_reason_2_1 := left.Result.Models[1].Scores[1].RiskIndicatorSets[2].RiskIndicators[1].RiskCode,
																								 self.o_reason_2_2 := left.Result.Models[1].Scores[1].RiskIndicatorSets[2].RiskIndicators[2].RiskCode,
																								 self.o_reason_2_3 := left.Result.Models[1].Scores[1].RiskIndicatorSets[2].RiskIndicators[3].RiskCode,
																								 self.o_reason_2_4 := left.Result.Models[1].Scores[1].RiskIndicatorSets[2].RiskIndicators[4].RiskCode,
																								 self.o_reason_2_5 := left.Result.Models[1].Scores[1].RiskIndicatorSets[2].RiskIndicators[5].RiskCode,
																								 self.o_reason_2_6 := left.Result.Models[1].Scores[1].RiskIndicatorSets[2].RiskIndicators[6].RiskCode,
                                                 self.o_lexid := clam[1].Bill_To_Out.did,
																								 self := left,
																								 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);

#End

#If(DEBUG)
	  OUTPUT(out1,             named('Results'));
	  // OUTPUT(getScore,         named('GetScore'));
		// OUTPUT(ungroup(cd2i_in), named('cd2i_in'));
		// OUTPUT(clam,             named('clam'));  
#Else	
	OUTPUT(final3,named('Results'));
	OUTPUT(royalties,NAMED('RoyaltySet'));
	
/* **************  REMOVING INTERMEDIATE LOGGING FOR NOW TO SPEED UP QUERY *******************
	// Note: All intermediate logs must have the following name schema:
	// Starts with 'LOG_' (Upper case is important!!)
	// Middle part is the database name, in this case: 'log__mbs'
	// Must end with '_intermediate__log'
  OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log'));
*******************************************************************************************/	
	 
	 //Improved Scout Logging
	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
#End

ENDMACRO;