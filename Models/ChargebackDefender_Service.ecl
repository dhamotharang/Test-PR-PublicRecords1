/*--SOAP--
	<message name="ChargebackDefender_Service">
	<part name="account" type="xsd:string"/>
	<part name="UnparsedFullName" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="middle" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="suffix" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="UnparsedFullName2" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="middle2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="suffix2" type="xsd:string"/>
	<part name="addr2" type="xsd:string"/> 
	<part name="city2" type="xsd:string"/>
	<part name="state2" type="xsd:string"/>
	<part name="zip2" type="xsd:string"/>
	<part name="hphone2" type="xsd:string"/>
	<part name="socs2" type="xsd:string"/>
	<part name="email2" type="xsd:string"/>
	<part name="drlc2" type="xsd:string"/>
	<part name="drlcstate2" type="xsd:string"/>
	<part name="DateOfBirth2" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="ipid_only" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="scores" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="RequestedAttributeGroups" type="tns:XmlDataSet" cols="70" rows="10"/>
	//CBD 5.0
	<part name="TypeOfOrder" type="xsd:string"/>
	<part name="DeviceProviderScore1" type="xsd:string"/> //KountScore
	<part name="DeviceProviderScore2" type="xsd:string"/> //TmxScore
	<part name="DeviceProviderScore3" type="xsd:string"/> //lovationScore
	<part name="DeviceProviderScore4" type="xsd:string"/> //Para41Score
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Chargeback Defender Service, scores, attributes, cbd output */
/*--HELP--
<pre>Attributes:
&lt;dataset&gt;
	&lt;row&gt;&lt;name&gt;identityv4&lt;/name&gt;&lt;/row&gt;
	&lt;row&gt;&lt;name&gt;relationshipv4&lt;/name&gt;&lt;/row&gt;
	&lt;row&gt;&lt;name&gt;velocityv4&lt;/name&gt;&lt;/row&gt;
&lt;/dataset&gt;

Scores:
&lt;scores&gt;
  &lt;row&gt;
    &lt;name&gt;Models.ChargebackDefender_Service&lt;/name&gt;
    &lt;url&gt;&lt;/url&gt;
    &lt;parameters&gt;
      &lt;row&gt;
        &lt;name&gt;Version&lt;/name&gt;
        &lt;value&gt;CDN712_0&lt;/value&gt;
      &lt;/row&gt;
    &lt;/parameters&gt;
  &lt;/row&gt;
&lt;/scores&gt;
</pre>
*/

import address, Risk_Indicators, RiskWise, Suppress, Models, ut, royalty, Risk_Reporting, Business_Risk_BIP, STD;

export ChargebackDefender_Service := MACRO

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* ************************************************************************
	 *                      Force the order on the WsECL page                 *
	 ************************************************************************ */
	#WEBSERVICE(FIELDS(
			'Account',
			'UnparsedFullName',
			'First',
			'Middle',
			'Last',
			'Suffix',
			'Addr',
			'City',
			'State',
			'Zip',
			'Hphone',
			'Socs',
			'DateOfBirth',
			'Email',
			'Drlc',
			'Drlcstate',
			
			'TypeOfOrder',

			'DeviceProviderScore1',
			'DeviceProviderScore2',
			'DeviceProviderScore3',
			'DeviceProviderScore4',
			
			'UnparsedFullName2',
			'First2',
			'Middle2',
			'Last2',
			'Suffix2',
			'Addr2', 
			'City2',
			'State2',
			'Zip2',
			'Hphone2',
			'Socs2',
			'DateOfBirth2',
			'Email2',
			'Drlc2',
			'Drlcstate2',
			'ipaddr',
			'ipid_only',
			
			'DPPAPurpose',
			'GLBPurpose',
			'DataRestrictionMask',
			'DataPermissionMask',
			'HistoryDateYYYYMM',
			'SSNMask',
			
			'scores',
			'TestDataEnabled',
			'TestDataTableName',
			'gateways',
			'RequestedAttributeGroups',
			'OutcomeTrackingOptOut'
	));

	// Set this to false for production
	Boolean DEBUG := false;
	
/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
	string6 ssnmask             := 'NONE' : STORED('SSNMask');
	string6 dobmask	            := ''	: STORED('DOBMask');
	string1 dlmask              := ''	: STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Models__ChargebackDefender_Service);
/* ************* End Scout Fields **************/
 
	string30 account_value := ''        : stored('account');
	string120	fullname_value := ''    	: stored('UnParsedFullName');
	Risk_indicators.MAC_unparsedfullname(title_val,first_value,mname_val,last_value,suffix_val,'first','middle','last','suffix')
	string50 addr_value := ''           : stored('addr');
	string30 city_value := ''           : stored('city');
	string2  state_value := ''          : stored('state');
	string5  zip_value := ''            : stored('zip');
	string10 hphone_value := ''         : stored('hphone');

	string9  socs_value := ''           : stored('socs');
	string50 email_value := ''          : stored('email');
	string20 drlc_value := ''           : stored('drlc');
	string2  drlcstate_value := ''      : stored('drlcstate');

	// SECOND INPUT

	// perform unparsed name cleaning without a macro until we make MAC_UnparsedFullName completely BtSt-savvy. 
	string120 unparsed_fullname_value2 :='':stored('UnParsedFullName2');
	cleaned_name2 := Stringlib.StringToUppercase(address.CleanPerson73(unparsed_fullname_value2));
	boolean  valid_cleaned2 := unparsed_fullname_value2<>'';
	string30 pre_fname_val2 := '' : stored('first2');
	string30 first2_value :=if(pre_fname_val2='' AND valid_cleaned2,cleaned_name2[6..25],pre_fname_val2);
	string30 pre_mname_val2 := '' : stored('middle2');
	string30 mname2_val :=if(pre_mname_val2='' AND valid_cleaned2,cleaned_name2[26..45],pre_mname_val2);
	string30 pre_lname_val2 := '' : stored('last2');
	string30 last2_value :=if(pre_lname_val2='' AND valid_cleaned2,cleaned_name2[46..65],pre_lname_val2);
	string5  pre_suffix_val2 :='' : stored('suffix2');
	string5  suffix2_val := if(pre_suffix_val2='' AND valid_cleaned2,cleaned_name2[66..70],pre_suffix_val2);
	string5  title_val2 :=if(valid_cleaned2,cleaned_name2[1..5],'');
	//

	string50 addr2_value := ''          : stored('addr2');
	string30 city2_value := ''          : stored('city2');
	string2  state2_value := ''         : stored('state2');
	string5  zip2_value := ''           : stored('zip2');
	string10 hphone2_value := ''        : stored('hphone2');
	string9  socs2_value := ''          : stored('socs2');
	unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
	unsigned1 GLB_Purpose  := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
	unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
	string45  ipaddr_value := ''     : stored('ipaddr');	
	boolean   ipid_only    := false  : stored('ipid_only');
	model_url    := dataset([],Models.Layout_Score_Chooser)        : stored('scores',few);
	gateways_input  := Gateway.Configuration.Get();

	//CBD 5.0
	string TypeOfOrder_value              := risk_indicators.iid_constants.PhysicalOrder : stored('TypeOfOrder');
	string8   dob_value := ''             : stored('DateOfBirth');
	string20 drlc_value2 := ''            : stored('drlc2');
	string2  drlcstate_value2 := ''       : stored('drlcstate2');
	string8   dob_value2 := ''            : stored('DateOfBirth2');
	string20 DeviceProvider1_value := ''  : stored('DeviceProviderScore1');
	string20  DeviceProvider2_value := '' : stored('DeviceProviderScore2');
	string20  DeviceProvider3_value := '' : stored('DeviceProviderScore3');
	string20 DeviceProvider4_value := ''  : stored('DeviceProviderScore4');
	string50 email_value2 := ''           : stored('email2');
	#stored('DisableBocaShellLogging', DisableOutcomeTracking); // OR ds_in[1].User.OutcomeTrackingOptOut
	
	boolean   Test_Data_Enabled := false : stored('TestDataEnabled');
	string20  Test_Data_Table_Name := '' : stored('TestDataTableName');
	string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string  DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	isUtility        := false;
	ln_branded       := false;
	ofac_only        := true;
	suppressneardups := true;
	
	includeRelatives := true;		
	includeDLInfo    := false;		// not used anymore
	includeDerogs    := true;
	
	ExcludeWatchLists := true;	// trying this out to save some time, doesn't seem to need it ever at this point.  will turn off ofac searching
	
	cbdParams := model_url(StringLib.StringToLowerCase(name)='models.chargebackdefender_service')[1].parameters;
	cbdParamsCap := PROJECT(cbdParams, TRANSFORM(RECORDOF(cbdParams), SELF.Name := StringLib.StringToUpperCase(LEFT.Name); SELF.Value := LEFT.Value; SELF := LEFT));
	genericModelName := trim(StringLib.StringToLowerCase(cbdParamsCap(name='VERSION')[1].value));
	
	
		// Per Bug 58340 - Pricepoint does not support hitting the Targus gateway, filtering it out.
		// Also, cdn1109_1 and cdn1404_1 models have no need to call the NetAcuity Gateway
	
	  //osn1504_0 is the orderScore flagship model! We released CBD 5.0 project with this model only in OrderScore.
		//However clients now want to use this model through CBD. Enhancing CBD to call the OS flagship model per Marc Bacon.
				
	Gateway.Layouts.Config gwSwitch(gateways_input le) := transform
		self.servicename := IF(genericModelName NOT IN ['cdn1109_1','cdn1404_1','cdn1506_1'], le.servicename, '');
		self.url := if(StringLib.StringToLowerCase(le.servicename) = 'targus' OR genericModelName IN ['cdn1109_1','cdn1404_1','cdn1506_1'], '', le.url);		 
		self := le;
	end;
	gateways_in := project(gateways_input, gwSwitch(left));
	
	Boolean NetAcuity_v4 := True;
	// echo the input
	echo_in := dataset([{account_value,fullname_value,first_value,mname_val,last_value,suffix_val,
											addr_value,city_value,state_value,zip_value,hphone_value,socs_value,
											email_value,drlc_value,drlcstate_value,dob_value,
											unparsed_fullname_value2,pre_fname_val2,pre_mname_val2,pre_lname_val2,pre_suffix_val2,addr2_value,
											city2_value,state2_value,zip2_value,hphone2_value,ipaddr_value,
											socs2_value, email_value2,drlc_value2,drlcstate_value2,dob_value2,TypeOfOrder_value,
											DeviceProvider1_value,DeviceProvider2_value,DeviceProvider3_value,
											DeviceProvider4_value
											}], Models.Layouts.Layout_CBD_Echo_In);


	Layout_Attributes_In := RECORD
		string name;
	END;

	attributesIn := dataset([],Layout_Attributes_In) : stored('RequestedAttributeGroups',few);	
	
	stringified_attributesIn := Business_Risk_BIP.Common.convertDelimited(attributesIn, name, '|');
	
	attributes_v1 := ['identityv1','relationshipv1'];
	attributes_v4 := ['identityv4','relationshipv4','velocityv4'];
	attributes_allversions := attributes_v1 + attributes_v4;

	layout_settings := record
		unsigned1 bsVersion;
		unsigned1 attrVersion;
		boolean validRequest;
		boolean getIdentity;
		boolean getRelationship;
		boolean getVelocity;
	end;
	layout_settings checkSettings( attributesIn le ) := TRANSFORM
		name := StringLib.StringToLowercase(le.name); 
		self.bsVersion    := map(
			genericModelName IN ['osn1504_0'] => 51, //all OS models should run the 51 clam
			name in attributes_v4 => 4,
			name in attributes_v1 => 3,
			2
		);
		self.attrVersion    := map(
			name in attributes_v4 => 4,
			name in attributes_v1 => 1,
			trim(name) = ''       => 0,
			error( 'Invalid attribute group requested (' + name + ')' )
		);
		self.validRequest := name in attributes_allversions;
		self.getIdentity     := name[..8]  = 'identity';
		self.getRelationship := name[..12] = 'relationship';
		self.getVelocity     := name[..8]  = 'velocity';
	END;
	settings := project( attributesIn, checkSettings(left) );
	
	modelBSVersion := MAP(
													 genericModelName IN ['osn1504_0'] => 51,
													 genericModelName IN ['cdn1410_1','cdn1506_1'] => 50,
                           genericModelName IN ['cdn1305_1','cdn1404_1'] => 41,
                           genericModelName IN ['cdn1109_1'] => 4,
                                                                2
                          );
											
	includeVehicles  := IF(genericModelName IN ['cdn1109_1'], TRUE, FALSE);
	
	attrbsversion     := max(settings, bsversion);
	bsversion := MAX(attrbsversion, modelBSVersion);
	attrversion   := max( settings, attrversion );
	require2Ele   := exists(settings) and not exists(settings(not validRequest));
	goodAttributeRequest := not exists(settings) or not exists(settings(not validRequest));
	//if bsversion 50 for the model and want cbd attributes of 40, then we need to run the clam as 50 for CBD
	//and run another clam for 4 for attributes.
  doscore := if(bsversion >= 51, true, false);

	doIdentity     := exists(settings(getIdentity));
	doRelationship := exists(settings(getRelationship));
	doVelocity     := exists(settings(getVelocity));

	d := dataset([{0}],{integer seq});
	
	Models.Layout_Chargeback_In addseq(d l, INTEGER C) := TRANSFORM
	#If(DEBUG)
		self.seq := (Integer)account_value;
	#Else
		self.seq := C;
		//self.seq := (Integer)account_value;	
	#End
		self.historydate := history_date;
		self.account := account_value;
		self.first := StringLib.StringToUppercase( first_value );
		self.middle := StringLib.StringToUppercase( mname_val );
		self.last := StringLib.StringToUppercase( last_value );
		self.suffix := StringLib.StringToUppercase( suffix_val );
		self.addr := StringLib.StringToUppercase( addr_value );
		self.city := StringLib.StringToUppercase( city_value );
		self.state := StringLib.StringToUppercase( state_value );
		self.zip := StringLib.StringToUppercase( zip_value );
		// self.zip4 := ''; // no billo zip4
		self.hphone := StringLib.StringToUppercase( hphone_value );
		self.socs := StringLib.StringToUppercase( socs_value );
		self.email := StringLib.StringToUppercase( email_value );
		self.drlc := StringLib.StringToUppercase( drlc_value );
		self.drlcstate := StringLib.StringToUppercase( drlcstate_value );
		self.ipaddr := StringLib.StringToUppercase( ipaddr_value );
		self.first2 := StringLib.StringToUppercase( first2_value );
		self.middle2 := StringLib.StringToUppercase( mname2_val );
		self.last2 := StringLib.StringToUppercase( last2_value );
		self.suffix2 := StringLib.StringToUppercase( suffix2_val );
		self.addr2 := StringLib.StringToUppercase( addr2_value );
		self.city2 := StringLib.StringToUppercase( city2_value );
		self.state2 := StringLib.StringToUppercase( state2_value );
		self.zip2 := StringLib.StringToUppercase( zip2_value );
		// self.zip42 := ''; // no shipto zip4
		self.socs2 := StringLib.StringToUppercase( socs2_value );
		self.hphone2 := StringLib.StringToUppercase( hphone2_value );
		self.TypeOfOrder := StringLib.StringToUppercase( TypeOfOrder_value );
		self.dob := riskwise.cleandob(dob_value);
		self.drlc2 := StringLib.StringToUppercase( drlc_value2 );
		self.drlcstate2 := StringLib.StringToUppercase( drlcstate_value2 );	
		self.email2 := StringLib.StringToUppercase( email_value2 );
		self.dob2 := riskwise.cleandob(dob_value2);
		self.DeviceProvider1_value := DeviceProvider1_value;
		self.DeviceProvider2_value := DeviceProvider2_value;
		self.DeviceProvider3_value := DeviceProvider3_value;
		self.DeviceProvider4_value := DeviceProvider4_value;
		self.historyDateTimeStamp := ''; //don't want this functionality in CBD
	END;
	indata := PROJECT(d, addseq(LEFT,COUNTER));

// turn on HHIDSummary searching for shell 5.0 and higher
// other options should probably also be turned on, but for right now in this release just turn on HHIDSummary so we don't impact any other customers without them knowing about it
	BSOptions := if(bsversion >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0);
	
	iid_results := Models.ChargebackDefender_Function(indata, gateways_in, glb_purpose, dppa_purpose, ipid_only, dataRestriction, ofac_only,
																										suppressneardups, require2Ele, bsVersion, dataPermission, bsOptions );

	Models.Layout_Chargeback_Out fill_output(iid_results le, indata ri) := TRANSFORM
		self.AccountNumber := ri.account;
		
		self.chargeback.seq := ri.seq;
		self.chargeback.account := ri.account;
		
		// first input (bill to)
		self.chargeback.verfirst:= le.bill_to_output.combo_first;
		self.chargeback.verlast := le.bill_to_output.combo_last;
		self.chargeback.veraddr := Risk_Indicators.MOD_AddressClean.street_address('',
			le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,
			le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,
			le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,
			le.bill_to_output.combo_sec_range
		);
		self.chargeback.vercity := le.bill_to_output.combo_city;
		self.chargeback.verstate:= le.bill_to_output.combo_state;
		self.chargeback.verzip5 := le.bill_to_output.combo_zip[1..5];
		self.chargeback.verzip4 := le.bill_to_output.combo_zip[6..9];
		self.chargeback.nameaddrphone := le.bill_to_output.name_addr_phone;
		
		self.chargeback.socsverlevel := (string)le.bill_to_output.socsverlevel;
		self.chargeback.phoneverlevel := (string)le.bill_to_output.phoneverlevel;
		
		self.chargeback.correctlast := le.bill_to_output.correctlast;
		self.chargeback.correcthphone := le.bill_to_output.correcthphone;
		self.chargeback.correctaddr := le.bill_to_output.correctaddr;
		self.chargeback.correctsocs := le.bill_to_output.correctssn;
			
		self.chargeback.altareacode := le.bill_to_output.altareacode;
		self.chargeback.areacodesplitdate := le.bill_to_output.areacodesplitdate;
		
		self.chargeback.hphonetypeflag := le.bill_to_output.hphonetypeflag;
		self.chargeback.dwelltypeflag  := if(le.bill_to_output.addr_type='S' and le.bill_to_output.addrvalflag='N', '', le.bill_to_output.addr_type); 

		// second input (ship to)
		self.chargeback.verfirst2 := le.ship_to_output.combo_first;
		self.chargeback.verlast2 := le.ship_to_output.combo_last;
		self.chargeback.veraddr2 := Risk_Indicators.MOD_AddressClean.street_address('',
			le.ship_to_output.combo_prim_range,le.ship_to_output.combo_predir,
			le.ship_to_output.combo_prim_name,le.ship_to_output.combo_suffix,
			le.ship_to_output.combo_postdir,le.ship_to_output.combo_unit_desig,
			le.ship_to_output.combo_sec_range
		);
		self.chargeback.vercity2 := le.ship_to_output.combo_city;
		self.chargeback.verstate2:= le.ship_to_output.combo_state;
		self.chargeback.verzip52 := le.ship_to_output.combo_zip[1..5];
		self.chargeback.verzip42 := le.ship_to_output.combo_zip[6..9];
		self.chargeback.nameaddrphone2 := le.ship_to_output.name_addr_phone;
		
		//self.chargeback.socsverlevel2 := (string)le.ship_to_output.socsverlevel; //don't populate as no new changes to CBD
		self.chargeback.phoneverlevel2 := (string)le.ship_to_output.phoneverlevel;
		
		self.chargeback.correctlast2 := le.ship_to_output.correctlast;
		self.chargeback.correcthphone2 := le.ship_to_output.correcthphone;
		self.chargeback.correctaddr2 := le.ship_to_output.correctaddr;
			
		self.chargeback.altareacode2 := le.ship_to_output.altareacode;
		self.chargeback.areacodesplitdate2 := le.ship_to_output.areacodesplitdate;
		
		self.chargeback.hphonetypeflag2 := le.ship_to_output.hphonetypeflag;
		self.chargeback.dwelltypeflag2 := if(le.ship_to_output.addr_type='S' and le.ship_to_output.addrvalflag='N', '', le.ship_to_output.addr_type);
		
		// ip := trim(ri.ipaddr);

		self.chargeback := ri;
		self := [];
	END;
	mapped_results := JOIN(iid_results, indata, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);

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
	
		ips := risk_indicators.getNetAcuity(ip_prep, gateways_in_tempNetAcuity, dppa_purpose, glb_purpose);

		Models.Layout_Chargeback_Out addIP(mapped_results le, ips ri) := TRANSFORM
			self.ipdata.ipcontinent := ri.continent;
			self.ipdata.ipcountry := StringLib.StringToUpperCase(ri.countrycode);
			self.ipdata.iproutingtype := if(Stringlib.StringFilterOut(ri.ipaddr[1],'0123456789') = '', ri.iproutingmethod, '');
			self.ipdata.ipstate := if(StringLib.StringToUpperCase(ri.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(ri.state), '');
			self.ipdata.ipzip := if(StringLib.StringToUpperCase(ri.countrycode[1..2]) = 'US', ri.zip, '');
			self.ipdata.ipareacode := if(ri.areacode <> '0', ri.areacode, '');	
			self.ipdata.topleveldomain := StringLib.StringToUpperCase(ri.topleveldomain);
			self.ipdata.secondleveldomain := StringLib.StringToUpperCase(ri.secondleveldomain);
			//self.ipdata.homebusiness := ri.homebusiness;
			self := le;
		END;     
		withIP := JOIN(mapped_results, ips, (left.chargeback.seq*2) = right.seq, addIP(left,right), left outer);
	// IP
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
		dppa_purpose,
		glb_purpose,
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
		ipid_only
	);
	
	
	Models.Layout_Chargeback_Out addIP_BTSTFunc(mapped_results le, clam ri) := TRANSFORM
			self.ipdata.ipcontinent := ri.ip2o.continent;
			self.ipdata.ipcountry := StringLib.StringToUpperCase(ri.ip2o.countrycode);
			self.ipdata.iproutingtype := if(Stringlib.StringFilterOut(ri.ip2o.ipaddr[1],'0123456789') = '', ri.ip2o.iproutingmethod, '');
			self.ipdata.ipstate := if(StringLib.StringToUpperCase(ri.ip2o.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(ri.ip2o.state), '');
			self.ipdata.ipzip := if(StringLib.StringToUpperCase(ri.ip2o.countrycode[1..2]) = 'US', ri.ip2o.zip, '');
			self.ipdata.ipareacode := if(ri.ip2o.areacode <> '0', ri.ip2o.areacode, '');	
			self.ipdata.topleveldomain := StringLib.StringToUpperCase(ri.ip2o.topleveldomain);
			self.ipdata.secondleveldomain := StringLib.StringToUpperCase(ri.ip2o.secondleveldomain);
			self := le;
		END;     
		
	withIP_BTST := JOIN(mapped_results, clam, (left.chargeback.seq*2) = right.bill_to_out.seq, addIP_BTSTFunc(left,right), left outer);

	productID := Risk_Reporting.ProductID.Models__ChargebackDefender_Service;
	intermediateLog := Risk_Reporting.To_LOG_Boca_Shell_BtSt(clam, productID, bsversion);  
	
	Models.Layout_CD_CustomModelInputs getCustomInputs(indata le, INTEGER c) := TRANSFORM
		SELF.Seq := le.seq;
	
		CDN1109_1_0 := genericModelName IN ['cdn1109_1','cdn1404_1','cdn1506_1'];
		CDN1305_1_0 := genericModelName IN ['cdn1305_1'];
		CDN1410_1_0 := genericModelName IN ['cdn1410_1'];
		
		SELF.Ship_Mode_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'SHIP_MODE_')[1].value)), '');
		SELF.Original_Total_Amount_ := IF(CDN1109_1_0, (REAL8)TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'ORIGINAL_TOTAL_AMOUNT_')[1].value)), 0.0);
		SELF.Item_Lines_ := IF(CDN1109_1_0, (INTEGER8)TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'ITEM_LINES_')[1].value)), 0);
		SELF.CVV_Description_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'CVV_DESCRIPTION_')[1].value)), '');
		SELF.Payment_Type_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'PAYMENT_TYPE_')[1].value)), '');
		SELF.AVS_Code_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'AVS_CODE_')[1].value)), '');
		SELF.Device_Result_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'DEVICE_RESULT_')[1].value)), '');
		SELF.True_IP_Region_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TRUE_IP_REGION_')[1].value)), '');
		SELF.Browser_Language_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'BROWSER_LANGUAGE_')[1].value)), '');
		SELF.Proxy_Ip_Geo_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'PROXY_IP_GEO_')[1].value)), '');
		SELF.Reason_Code_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'REASON_CODE_')[1].value)), '');
		SELF.Time_Zone_Hours_ := IF(CDN1109_1_0, (INTEGER1)TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TIME_ZONE_HOURS_')[1].value)), 0);
		SELF.True_Ip_Geo_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TRUE_IP_GEO_')[1].value)), '');
		SELF.Policy_Score_ := IF(CDN1109_1_0, (REAL8)TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'POLICY_SCORE_')[1].value)), 0.0);
		SELF.Marked_For_Full_Name_H_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'MARKED_FOR_FULL_NAME_H_')[1].value)), '');
		SELF.Entry_Type_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'ENTRY_TYPE_')[1].value)), '');
		SELF.Line_Type_Header_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'LINE_TYPE_(HEADER)_')[1].value)), '');
		SELF.Paypal_Email_Address_ := IF(CDN1109_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'PAYPAL_EMAIL_ADDRESS_')[1].value)), '');
		//Tiger Direct input fields
		SELF.TD_avs := IF(CDN1305_1_0 or CDN1410_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TD_AVS')[1].value)), '');
		SELF.TD_pay_method := IF(CDN1305_1_0 or CDN1410_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TD_PAY_METHOD')[1].value)), '');
		SELF.TD_product_dollars := IF(CDN1305_1_0 or CDN1410_1_0, (REAL8)TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TD_PRODUCT_DOLLARS')[1].value)), 0);
		SELF.TD_ship_method := IF(CDN1305_1_0 or CDN1410_1_0, TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TD_SHIP_METHOD')[1].value)), '');
    SELF.TD_day_velocity_threshold := IF(CDN1410_1_0, (REAL8)TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TD_DAY_VELOCITY_THRESHOLD')[1].value)), 0.0);
		SELF.TD_week_velocity_threshold := IF(CDN1410_1_0, (REAL8)TRIM(StringLib.StringToUpperCase(cbdParamsCap(name = 'TD_WEEK_VELOCITY_THRESHOLD')[1].value)), 0.0);

		SELF := [];
	END;
	customModelInputsSet := PROJECT(indata, getCustomInputs(LEFT, COUNTER));
	
	cdn1109_1_inputList := ['SHIP_MODE_', 'ORIGINAL_TOTAL_AMOUNT_', 'ITEM_LINES_', 'CVV_DESCRIPTION_', 'PAYMENT_TYPE_', 'AVS_CODE_', 'DEVICE_RESULT_', 'TRUE_IP_REGION_', 
							'BROWSER_LANGUAGE_', 'PROXY_IP_GEO_', 'REASON_CODE_', 'TIME_ZONE_HOURS_', 'TRUE_IP_GEO_', 'POLICY_SCORE_', 'MARKED_FOR_FULL_NAME_H_',
							'ENTRY_TYPE_', 'LINE_TYPE_(HEADER)_', 'LINE_LOS_', 'PAYPAL_SHIP_ADDRESS_STATUS_', 'PAYPAL_EMAIL_ADDRESS_', 'DELIVERY_EMAIL_'];

	cdn1305_1_inputList := ['TD_AVS', 'TD_PAY_METHOD', 'TD_PRODUCT_DOLLARS', 'TD_SHIP_METHOD'];
  
	cdn1410_1_inputList := ['TD_AVS', 'TD_PAY_METHOD', 'TD_PRODUCT_DOLLARS', 'TD_SHIP_METHOD', 'TD_DAY_VELOCITY_THRESHOLD', 'TD_WEEK_VELOCITY_THRESHOLD'];

							
	// Make sure when CDN1109_1 is called that only custom input fields are entered and nothing extra - this is to help catch typos Best Buy might be sending in
	customModelInputs := MAP(genericModelName IN ['cdn1109_1','cdn1404_1','cdn1506_1'] AND COUNT(cbdParamsCap(name NOT IN cdn1109_1_inputList AND name <> 'VERSION')) > 0  => FAIL(Models.Layout_CD_CustomModelInputs, 'Invalid Model Request -- Custom model input variable not recognized.'), 
                             genericModelName IN ['cdn1305_1'] AND COUNT(cbdParamsCap(name NOT IN cdn1305_1_inputList AND name <> 'VERSION')) > 0              => FAIL(Models.Layout_CD_CustomModelInputs, 'Invalid Model Request -- Custom model input variable not recognized.'), 
                             genericModelName IN ['cdn1410_1'] AND COUNT(cbdParamsCap(name NOT IN cdn1410_1_inputList AND name <> 'VERSION')) > 0              => FAIL(Models.Layout_CD_CustomModelInputs, 'Invalid Model Request -- Custom model input variable not recognized.'), 
                             genericModelName IN ['cdn1109_1','cdn1305_1','cdn1404_1','cdn1506_1', 'cdn1410_1', 'osn1504_0']      => customModelInputsSet,	DATASET([], Models.Layout_CD_CustomModelInputs)
							);
	// For Debug Purposes
	// model goes here
#If(DEBUG)
	getScore := models.OSN1504_0_0( clam, ungroup(cd2i_in), true, true, false, true);
	//out1 := models.OSN1504_0_0( clam, ungroup(cd2i_in), false, false, false);	
	getScoreWAcct := record
		recordof(getScore);
		string30 account2 := '';
	end;
	out1 := join(getScore, ungroup(cd2i_in),
		left.seq = right.seq,
		transform(getScoreWAcct, self.Account2 := right.Account, self := left));
	
#Else

	getScore := map(
		ipid_only => dataset( [], models.Layout_ModelOut ), // don't call a score for ipid-only transactions
		genericModelName = 'cdn712_0' => models.CDN712_0_0( clam, true, false), // default model
		genericModelName = 'cdn1109_1'=> models.CDN1109_1_0( clam, customModelInputs, true, false), // Best Buy Custom
		genericModelName = 'cdn1305_1'=> models.CDN1305_1_0( clam, customModelInputs, true, true), // Tiger Direct Custom
		genericModelName = 'cdn1404_1'=> models.CDN1404_1_0( clam, customModelInputs, true, false), // Best Buy Custom
		genericModelName = 'cdn1410_1'=> models.CDN1410_1_0( clam, customModelInputs, true, false, true), // Tiger Direct Custom
    genericModelName = 'cdn1506_1'=> models.CDN1506_1_0( clam, customModelInputs, true, false), // Tiger Direct Custom		
		genericModelName = 'osn1504_0'=> models.OSN1504_0_0( clam, ungroup(cd2i_in), true, true, false, true), // Order Insight 5.1 Flagship		
		genericModelName <> '' => fail(Models.Layout_ModelOut, 'Invalid service/model input combination'),
		dataset( [], models.Layout_ModelOut ) // for transactions with an invalid modelname specified
	);
	
	// ****Add the Models to the output
		Models.Layout_Reason_Codes form_rc(getScore le, integer i) := TRANSFORM
			self.reason_code := if(trim(le.ri[i].hri) <> '00', le.ri[i].hri, '');
			self.reason_description := le.ri[i].desc;
		END;
		
		Models.Layouts.Layout_Reason_Code_Sets form_sets(getScore le, integer i) := TRANSFORM
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
				risk_indicators.mac_add_sequence(if(i=1,btreasoncodes(reason_code<>''), streasoncodes(reason_code<>'')), reasons_with_seq);
			self.reason_codes := reasons_with_seq;
		END;

		Models.Layouts.Layout_Score_multiple form_cscore(getScore le) := TRANSFORM
			self.i := le.score;
			self.description := map(
				genericModelName = 'cdn712_0' => 'CBD', // default model
				genericModelName = 'cdn1109_1' => 'CBD11091', // Custom Chargeback defender
				genericModelName = 'cdn1305_1' => 'CBD13051', // Custom Chargeback defender
				genericModelName = 'cdn1404_1' => 'CBD14041', // Custom Chargeback defender
				genericModelName = 'cdn1410_1' => 'CBD14101', // Custom Chargeback defender
				genericModelName = 'cdn1506_1' => 'CBD15061', // Custom Chargeback defender
				genericModelName = 'osn1504_0' => 'OSN15040', // OS Flagship model
				''
			);
			self.index := map(
				genericModelName = 'cdn712_0' => risk_indicators.BillingIndex.CBD_v1, // default model
				genericModelName = 'cdn1109_1' => risk_indicators.BillingIndex.CBD1109_1, // Custom Chargeback defender
				genericModelName = 'cdn1305_1' => risk_indicators.BillingIndex.CBD1305_1, // Custom Chargeback defender
				genericModelName = 'cdn1404_1' => risk_indicators.BillingIndex.CBD1404_1, // Custom Chargeback defender
				genericModelName = 'cdn1410_1' => risk_indicators.BillingIndex.CBD1410_1, // Custom Chargeback defender
        genericModelName = 'cdn1506_1' => risk_indicators.BillingIndex.CBD1506_1, // Custom Chargeback defender				
        genericModelName = 'osn1504_0' => risk_indicators.BillingIndex.OSN1504_0, // Custom Order Score just for testing INTERNALLY!							
				''
			);
			
			rc_sets := PROJECT(le, form_sets(LEFT,1)) +
									PROJECT(le, form_sets(LEFT,2));
			self.RiskIndicatorSets := rc_sets;
		END;
		
		Models.Layouts.Layout_Model_Multiple form_model(getScore le, string account_value) := TRANSFORM
			self.accountnumber := account_value;
			self.description := 'ChargebackDefender';
			self.scores := PROJECT(le, form_cscore(LEFT));
		END;
	// ****MODELS

	IPData := if(ipid_only, withIP, withIP_BTST);

	Models.Layout_Chargeback_Out addBTModel( IPData le, getscore ri ) := TRANSFORM
		formed := project(ri,form_model(LEFT,le.chargeback.account));
		self.Models := formed;
		self := le;
	END;	
	
	withModel := JOIN(IPData, getScore, left.chargeback.seq*2 = right.seq, addBTmodel(left,right), left outer );

	// ****Choose either full results or just IP results
	ret := if(exists(getscore),withmodel,IPData);
	
	// ****specifically for test data enabled transactions
	Risk_Indicators.Layout_BocaShell_BtSt.BTST_input doTestInput(d l) := transform
	// ****	only set the necessary fields to search test seed record, don't cass input addr
		self.seq := l.seq;
		self.ssn := socs_value;
		self.phone10 := hphone_value;
		self.fname := StringLib.StringToUppercase(first_value);
		self.lname := StringLib.StringToUppercase(last_value);
		self.z5 := zip_value;
		self := [];
	END;
	testPrep := PROJECT(d, doTestInput(left));
	
	/* TURN OFF TEST SEED KEYS - DEBUG ONLY : Comment out the next 3 lines of code, and comment in the second cbd_model */
	ret_test_seed := Risk_Indicators.CBD_Testseed_Function(testPrep, account_value, Test_Data_Table_Name);
	seed_final := project( ret_test_seed, transform( Models.Layout_Chargeback_Out, self := left ) );

	cbd_model := if( Test_Data_Enabled, seed_final, ret );
	// cbd_model := ret;
	
	
	// ****get attributes
	//if running modeling shell 50 and want attributes then use the 4 clam output for attribtues
	attributes := Models.getCBDAttributes(clam, account_value, indata, attrversion);	
	attr_test_seed := Models.CBDAttributes_TestSeed_FN(testPrep, account_value, Test_Data_Table_Name);  //Deactivate test seed keys - Comment out this line
	
	attrs := map(	test_data_enabled => attr_test_seed, //Deactivate test seed keys - comment out the remainder of the top line, starting after the map definition.
								~goodAttributeRequest => fail(Models.Layout_CBDAttributes, 'Invalid attribute request'),
								attributes);	// choose either real results or test results
	
	pop := Models.popCBDAttributes( account_value );
	attrgrp := map(
		attrVersion=1 =>
		    if( doIdentity,     pop.identityv1(attrs) )
		  & if( doRelationship, pop.relationshipv1(attrs) ),
		attrVersion=4 =>
			  if( doIdentity,     pop.identityv4(attrs) )
			& if( doRelationship, pop.Relationshipv4(attrs) )
			& if( doVelocity,     pop.Velocityv4(attrs) ),
		dataset( [], Models.Layouts.Layout_AttributeGroup )
	);

	Models.Layout_Chargeback_Out addTogether(ret le) := TRANSFORM
		self.AttributeGroups := attrgrp;
		self := le;
	END;
	retAttr := project(cbd_model, addTogether(left));
	
	Models.Layout_Chargeback_Out blankCB( withmodel le ) := TRANSFORM
		self.chargeback := [];
		self := le;
	END;

	final1 := if( ipid_only, project(ret,blankCB(left)), retAttr );
	Models.Layout_Chargeback_Out addEcho(final1 le) := TRANSFORM
		self.input_echo := PROJECT(echo_in, TRANSFORM(Models.Layouts.Layout_CBD_Echo_In_for_output, self := left));
		self := le;
	END;
	final_wEcho := PROJECT(final1, addEcho(LEFT));
	
	Suppress.MAC_Mask(final_wEcho, final2, chargeback.correctsocs, '', true, false, false, false, '', ssnmask);
	
		noAttributeScoreIPRequest := ~EXISTS(attributesIn(name<>'')) and genericModelName = '' and ~ipid_only;	// didnt request attributes or score or IPonly
	final3 := if(noAttributeScoreIPRequest, fail(Models.Layout_Chargeback_Out, 'Not a valid request'), final2);

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
																								 self.product_id := Risk_Reporting.ProductID.Models__ChargebackDefender_Service,
																								 self.function_name := FunctionName,
																								 self.esp_method := ESPMethod,
																								 self.interface_version := InterfaceVersion,
																								 self.delivery_method := DeliveryMethod,
																								 self.date_added := (STRING8)Std.Date.Today(),
																								 self.death_master_purpose := DeathMasterPurpose,
																								 self.ssn_mask := ssnmask,
																								 self.dob_mask := dobmask,
																								 self.dl_mask := dlmask,
																								 self.exclude_dmv_pii := ExcludeDMVPII,
																								 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																								 self.archive_opt_in := ArchiveOptIn,
                                                 self.glb := GLB_Purpose,
                                                 self.dppa := DPPA_Purpose,
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
																								 self.o_score_1    := left.Models[1].Scores[1].i,
																								 self.o_reason_1_1 := left.Models[1].Scores[1].RiskIndicatorSets[1].Reason_Codes[1].Reason_Code,
																								 self.o_reason_1_2 := left.Models[1].Scores[1].RiskIndicatorSets[1].Reason_Codes[2].Reason_Code,
																								 self.o_reason_1_3 := left.Models[1].Scores[1].RiskIndicatorSets[1].Reason_Codes[3].Reason_Code,
																								 self.o_reason_1_4 := left.Models[1].Scores[1].RiskIndicatorSets[1].Reason_Codes[4].Reason_Code,
																								 self.o_reason_1_5 := left.Models[1].Scores[1].RiskIndicatorSets[1].Reason_Codes[5].Reason_Code,
																								 self.o_reason_1_6 := left.Models[1].Scores[1].RiskIndicatorSets[1].Reason_Codes[6].Reason_Code,
																								 // self.o_score_2    := '',
																								 self.o_reason_2_1 := left.Models[1].Scores[1].RiskIndicatorSets[2].Reason_Codes[1].Reason_Code,
																								 self.o_reason_2_2 := left.Models[1].Scores[1].RiskIndicatorSets[2].Reason_Codes[2].Reason_Code,
																								 self.o_reason_2_3 := left.Models[1].Scores[1].RiskIndicatorSets[2].Reason_Codes[3].Reason_Code,
																								 self.o_reason_2_4 := left.Models[1].Scores[1].RiskIndicatorSets[2].Reason_Codes[4].Reason_Code,
																								 self.o_reason_2_5 := left.Models[1].Scores[1].RiskIndicatorSets[2].Reason_Codes[5].Reason_Code,
																								 self.o_reason_2_6 := left.Models[1].Scores[1].RiskIndicatorSets[2].Reason_Codes[6].Reason_Code,
                                                 self.o_lexid := clam[1].Bill_To_Out.DID,
																								 self := left,
																								 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);

#End

#If(DEBUG)
	OUTPUT(out1, named('results'));
#Else
	OUTPUT(final3,named('Results'));
	OUTPUT(royalties,NAMED('RoyaltySet'));
		// Note: All intermediate logs must have the following name schema:
	// Starts with 'LOG_' (Upper case is important!!)
	// Middle part is the database name, in this case: 'log__mbs'
	// Must end with '_intermediate__log'
	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log')) );
	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')) );
#End

ENDMACRO;