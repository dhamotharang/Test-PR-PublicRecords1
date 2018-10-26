/*--SOAP--
<message name="Phone_Shell_Service" wuTimeout="300000">
	<part name="AcctNo" type="xsd:string"/>
	<part name="DID" type="xsd:integer"/>
	<part name="FullName_In" type="xsd:string"/>
	<part name="TitleName_In" type="xsd:string"/>
	<part name="FirstName_In" type="xsd:string"/>
	<part name="MiddleName_In" type="xsd:string"/>
	<part name="LastName_In" type="xsd:string"/>
	<part name="SuffixName_In" type="xsd:string"/>
	<part name="StreetAddress1_In" type="xsd:string"/>
	<part name="StreetAddress2_In" type="xsd:string"/>
	<part name="City_In" type="xsd:string"/>
	<part name="State_In" type="xsd:string"/>
	<part name="Zip_In" type="xsd:string"/>
	<part name="SSN_In" type="xsd:string"/>
	<part name="DateOfBirth_In" type="xsd:integer"/>
	<part name="Age_In" type="xsd:integer"/>
	<part name="HomePhone_In" type="xsd:integer"/>
	<part name="WorkPhone_In" type="xsd:integer"/>
	<part name="Prim_Range_In" type="xsd:string"/>
	<part name="Predir_In" type="xsd:string"/>
	<part name="Prim_Name_In" type="xsd:string"/>
	<part name="Addr_Suffix_In" type="xsd:string"/>
	<part name="Postdir_In" type="xsd:string"/>
	<part name="Unit_Desig_In" type="xsd:string"/>
	<part name="Sec_Range_In" type="xsd:string"/>
	<part name="Zip5_In" type="xsd:string"/>
	<part name="Zip4_In" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
 <part name="DataPermissionMask" type="xsd:string"/>
	<part name="Phone_Restriction_Mask" type="xsd:integer"/>
	<part name="EnableTargusGateway" type="xsd:boolean"/>
	<part name="EnableTransUnionGateway" type="xsd:boolean"/>
	<part name="EnableInsuranceGateway" type="xsd:boolean"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="MaxNumberOfPhones" type="xsd:integer"/>
	<part name="InsuranceVerificationAgeLimit" type="xsd:integer"/>
	<part name="SPIIAccessLevel" type="xsd:string"/>
	<part name="RelocationsMaxDaysBefore" type="xsd:integer"/>
	<part name="RelocationsMaxDaysAfter" type="xsd:integer"/>
	<part name="RelocationsTargetRadius" type="xsd:integer"/>
	<part name="VerticalMarket" type="xsd:string"/>
 <part name="IndustryClass_In" type="xsd:string"/>
 <part name="IncludeLastResort" type="xsd:boolean"/>
 <part name="IncludePhonesFeedback" type="xsd:boolean"/>
	<part name="EnforceTestAccounts" type="xsd:boolean"/>
	<part name="SX_Match_Restriction_Limit" type="xsd:integer"/>
	<part name="Strict_APSX_Match" type="xsd:boolean"/>
	<part name="Score_Threshold" type="xsd:integer"/>

	<part name="PhoneShell_Version" type="xsd:integer"/>
	<part name="BocaShell_IncludeRelatives" type="xsd:boolean"/>
	<part name="BocaShell_IncludeDL" type="xsd:boolean"/>
	<part name="BocaShell_IncludeVehicle" type="xsd:boolean"/>
	<part name="BocaShell_IncludeDerog" type="xsd:boolean"/>
	<part name="BocaShell_Include_OFAC" type="xsd:boolean"/>
	<part name="BocaShell_OFAC_Only" type="xsd:boolean"/>
	<part name="BocaShell_ExcludeWatchlists" type="xsd:boolean"/>
	<part name="BocaShell_Include_AdditionalWatchlists" type="xsd:boolean"/>
	<part name="BocaShell_DoScore" type="xsd:boolean"/>
	<part name="BocaShell_SuppressNearDups" type="xsd:boolean"/>
	<part name="BocaShell_Require2Elements" type="xsd:boolean"/>
	<part name="BocaShell_AppendBest" type="xsd:integer"/>
	<part name="BocaShell_OFAC_Version" type="xsd:integer"/>
	<part name="BocaShell_DOB_Radius" type="xsd:integer"/>
	<part name="BocaShell_Watchlist_Threshold" type="xsd:string"/>
	<part name="BlankOutDuplicatePhones" type="xsd:boolean"/>
 <part name="Phone_Score_Model" type="xsd:string"/>
 <part name="ModelVersion" type="xsd:string"/>

	<part name="UsePremiumSource_A" type="xsd:boolean"/>
	<part name="PremiumSource_A_limit" type="xsd:integer"/>
	<part name="RunRelocation" type="xsd:boolean"/>

	<part name="Batch_Input" type="tns:XmlDataSet" cols="100" rows="20"/>
</message>
*/
/*--INFO-- Phone Shell Service - This service can run via Realtime OR Batch.  If Batch_Input is populated the service will assume batch mode. -- Combines the Boca Shell and the Phone Shell into one flat layout*/
/*--HELP-- 
<pre>
&lt;Batch_Input&gt;
  &lt;Row&gt;
    &lt;AcctNo&gt;&lt;/AcctNo&gt;
    &lt;DID&gt;&lt;/DID&gt;
    &lt;FullName&gt;&lt;/FullName&gt;
    &lt;TitleName&gt;&lt;/TitleName&gt;
    &lt;FirstName&gt;&lt;/FirstName&gt;
    &lt;MiddleName&gt;&lt;/MiddleName&gt;
    &lt;LastName&gt;&lt;/LastName&gt;
    &lt;SuffixName&gt;&lt;/SuffixName&gt;
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;State&gt;&lt;/State&gt;
    &lt;Zip&gt;&lt;/Zip&gt;
    &lt;Prim_Range&gt;&lt;/Prim_Range&gt;
    &lt;Predir&gt;&lt;/Predir&gt;
    &lt;Prim_Name&gt;&lt;/Prim_Name&gt;
    &lt;Addr_Suffix&gt;&lt;/Addr_Suffix&gt;
    &lt;Postdir&gt;&lt;/Postdir&gt;
    &lt;Unit_Desig&gt;&lt;/Unit_Desig&gt;
    &lt;Sec_Range&gt;&lt;/Sec_Range&gt;
    &lt;Zip5&gt;&lt;/Zip5&gt;
    &lt;Zip4&gt;&lt;/Zip4&gt;
    &lt;SSN&gt;&lt;/SSN&gt;
    &lt;DateOfBirth&gt;&lt;/DateOfBirth&gt;
    &lt;Age&gt;&lt;/Age&gt;
    &lt;HomePhone&gt;&lt;/HomePhone&gt;
    &lt;WorkPhone&gt;&lt;/WorkPhone&gt;
    &lt;TargusGatewayEnabled&gt;0&lt;/TargusGatewayEnabled&gt;
    &lt;TransUnionGatewayEnabled&gt;0&lt;/TransUnionGatewayEnabled&gt;
    &lt;InsuranceGatewayEnabled&gt;0&lt;/InsuranceGatewayEnabled&gt;
  &lt;/Row&gt;
&lt;/Batch_Input&gt;



&lt;Gateways&gt;
&lt;row&gt;
  &lt;servicename&gt;qsentv2&lt;/servicename&gt;
  &lt;url&gt;http://username:password@URL/WsGateway?ver_=1.67&lt;/url&gt;
&lt;/row&gt;
&lt;row&gt;
  &lt;servicename&gt;targus&lt;/servicename&gt;
  &lt;url&gt;http://username:password@URL/WsGateway&lt;/url&gt;
&lt;/row&gt;
&lt;/Gateways&gt;
</pre>
*/


IMPORT Address, Gateway, Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT;

EXPORT Phone_Shell_Service() := FUNCTION
		#stored('GLBPurpose',0);
		#stored('DataRestrictionMask', Phone_Shell.constants.default_DataRestriction);
		#stored('DataPermissionMask', Phone_Shell.constants.Default_DataPermission);
    #WEBSERVICE(FIELDS(
                'AcctNo',
                'DID',
                'FullName_In',
                'TitleName_In',
                'FirstName_In',
                'MiddleName_In',
                'LastName_In',
                'SuffixName_In',
                'StreetAddress1_In',
                'StreetAddress2_In',
                'City_In',
                'State_In',
                'Zip_In',
                'SSN_In',
                'DateOfBirth_In',
                'Age_In',
                'HomePhone_In',
                'WorkPhone_In',
                'Prim_Range_In',
                'Predir_In',
                'Prim_Name_In',
                'Addr_Suffix_In',
                'Postdir_In',
                'Unit_Desig_In',
                'Sec_Range_In',
                'Zip5_In',
                'Zip4_In',
                'GLBPurpose',
                'DPPAPurpose',
                'DataRestrictionMask',
                'DataPermissionMask',
                'Phone_Restriction_Mask',
                'EnableTargusGateway',
                'EnableTransUnionGateway',
                'EnableInsuranceGateway',
                'Gateways',
                'MaxNumberOfPhones',
                'InsuranceVerificationAgeLimit',
                'SPIIAccessLevel',
                'RelocationsMaxDaysBefore',
                'RelocationsMaxDaysAfter',
                'RelocationsTargetRadius',
                'VerticalMarket',
                'IndustryClass_In',
                'IncludeLastResort',
                'IncludePhonesFeedback',
                'EnforceTestAccounts',
                'SX_Match_Restriction_Limit',
                'Strict_APSX_Match',
                'Score_Threshold',
                'PhoneShell_Version',
                'BocaShell_IncludeRelatives',
                'BocaShell_IncludeDL',
                'BocaShell_IncludeVehicle',
                'BocaShell_IncludeDerog',
                'BocaShell_Include_OFAC',
                'BocaShell_OFAC_Only',
                'BocaShell_ExcludeWatchlists',
                'BocaShell_Include_AdditionalWatchlists',
                'BocaShell_DoScore',
                'BocaShell_SuppressNearDups',
                'BocaShell_Require2Elements',
                'BocaShell_AppendBest',
                'BocaShell_OFAC_Version',
                'BocaShell_DOB_Radius',
                'BocaShell_Watchlist_Threshold',
                'BlankOutDuplicatePhones',
                'Phone_Score_Model',
                'ModelVersion',
                'UsePremiumSource_A',
                'PremiumSource_A_limit',
                'Batch_Input',
																'RunRelocation'
                ));


	/* ************************************************************************
	 *  Grab service inputs - This service supports both Batch and Realtime   *
	 ************************************************************************ */
	STRING50 AcctNo				 													:= '' : STORED('AcctNo');
	UNSIGNED6 DID																		:= 0 : STORED('DID');
	STRING120 FullName 															:= '' : STORED('FullName_In');
	STRING5 TitleName 															:= '' : STORED('TitleName_In');
	STRING20 FirstName 															:= '' : STORED('FirstName_In');
	STRING20 MiddleName 														:= '' : STORED('MiddleName_In');
	STRING20 LastName 															:= '' : STORED('LastName_In');
	STRING5 SuffixName 															:= '' : STORED('SuffixName_In');
	STRING120 StreetAddress1 												:= '' : STORED('StreetAddress1_In');
	STRING120 StreetAddress2 												:= '' : STORED('StreetAddress2_In');
	STRING25 City 																	:= '' : STORED('City_In');
	STRING2 State 																	:= '' : STORED('State_In');
	STRING9 Zip 																		:= '' : STORED('Zip_In');
	STRING10 Prim_Range 														:= '' : STORED('Prim_Range_In');
	STRING2 Predir 																	:= '' : STORED('Predir_In');
	STRING28 Prim_Name 															:= '' : STORED('Prim_Name_In');
	STRING4 Addr_Suffix 														:= '' : STORED('Addr_Suffix_In');
	STRING2 Postdir 																:= '' : STORED('Postdir_In');
	STRING10 Unit_Desig 														:= '' : STORED('Unit_Desig_In');
	STRING8 Sec_Range 															:= '' : STORED('Sec_Range_In');
	STRING5 Zip5 																		:= '' : STORED('Zip5_In');
	STRING4 Zip4 																		:= '' : STORED('Zip4_In');
	STRING9 SSN 																		:= '' : STORED('SSN_In');
	STRING8 DateOfBirth 														:= '' : STORED('DateOfBirth_In');
	STRING3 Age 																		:= '' : STORED('Age_In');
	STRING10 HomePhone 															:= '' : STORED('HomePhone_In');
	STRING10 WorkPhone 															:= '' : STORED('WorkPhone_In');
	BOOLEAN EnableTargusGateway 										:= FALSE : STORED('EnableTargusGateway');
	BOOLEAN EnableTransUnionGateway 								:= FALSE : STORED('EnableTransUnionGateway');
	BOOLEAN EnableInsuranceGateway 									:= FALSE : STORED('EnableInsuranceGateway');
	DATASET(Phone_Shell.Layout_Phone_Shell.Input) Batch_In := DATASET([], Phone_Shell.Layout_Phone_Shell.Input) : STORED('Batch_Input');
	Gateways 																				:= Gateway.Configuration.Get();
	UNSIGNED1 GLBPurpose                            := 0 : STORED('GLBPurpose');
	UNSIGNED1 DPPAPurpose 													:= 0 : STORED('DPPAPurpose');
	STRING DataRestrictionMask 										  := Phone_Shell.constants.default_DataRestriction : STORED('DataRestrictionMask');
	STRING DataPermissionMask 										  := Phone_Shell.Constants.Default_DataPermission : STORED('DataPermissionMask');
	UNSIGNED1 PhoneRestrictionMask 									:= Phone_Shell.Constants.PRM.AllPhones : STORED('Phone_Restriction_Mask');
	UNSIGNED3 MaxNumberOfPhones 										:= Phone_Shell.Constants.Default_MaxPhones : STORED('MaxNumberOfPhones');
	UNSIGNED3 MaxPhones 														:= IF(MaxNumberOfPhones <= 0, Phone_Shell.Constants.Default_MaxPhones, MaxNumberOfPhones);
	UNSIGNED3 InsuranceVerificationAgeLimitDays 		:= Phone_Shell.Constants.Default_InsuranceVerificationAgeLimit : STORED('InsuranceVerificationAgeLimit');
	UNSIGNED3 InsuranceVerificationAgeLimit 				:= IF(InsuranceVerificationAgeLimitDays <= 0, Phone_Shell.Constants.Default_InsuranceVerificationAgeLimit, InsuranceVerificationAgeLimitDays);
	STRING2 SPIIAccessLevel 												:= Phone_Shell.Constants.Default_SPIIAccessLevel : STORED('SPIIAccessLevel');
	STRING30 VerticalMarket 												:= '' : STORED('VerticalMarket');
	STRING30 IndustryClass													:= '' : STORED('IndustryClass_In');
	INTEGER RelocationsMaxDaysBefore								:= Relocations.wdtg.default_daysBefore : STORED('RelocationsMaxDaysBefore');
	INTEGER RelocationsMaxDaysAfter									:= Relocations.wdtg.default_daysAfter : STORED('RelocationsMaxDaysAfter');
	INTEGER RelocationsTargetRadius									:= Relocations.wdtg.default_radius : STORED('RelocationsTargetRadius');
	BOOLEAN IncludeLastResort												:= FALSE : STORED('IncludeLastResort');
	BOOLEAN IncludePhonesFeedback										:= FALSE : STORED('IncludePhonesFeedback');
	BOOLEAN EnforceTestAccounts 										:= FALSE : STORED('EnforceTestAccounts');
	UNSIGNED2 SX_Match_Restriction_Limit_Temp				:= 10 : STORED('SX_Match_Restriction_Limit');
	SX_Match_Restriction_Limit := IF(SX_Match_Restriction_Limit_Temp > 0, SX_Match_Restriction_Limit_Temp, 10);
	BOOLEAN Strict_APSX															:= FALSE : STORED('Strict_APSX_Match');
	Unsigned2 Score_Threshold												:= Phone_Shell.constants.Default_PhoneScore : STORED('Score_Threshold');
	// Boca Shell Options, Phone Shell version uses 2-digit notation so 10 value = phone shell 1.0
	UNSIGNED1 PhoneShell_Version 										:= 10 : STORED('PhoneShell_Version');
	BOOLEAN BocaShell_IncludeRelatives 							:= TRUE : STORED('BocaShell_IncludeRelatives');
	BOOLEAN BocaShell_IncludeDL 										:= FALSE : STORED('BocaShell_IncludeDL');
	BOOLEAN BocaShell_IncludeVehicle 								:= FALSE : STORED('BocaShell_IncludeVehicle');
	BOOLEAN BocaShell_IncludeDerog 									:= TRUE : STORED('BocaShell_IncludeDerog');
	BOOLEAN BocaShell_Include_OFAC 									:= FALSE : STORED('BocaShell_Include_OFAC');
	BOOLEAN BocaShell_OFAC_Only 										:= TRUE : STORED('BocaShell_OFAC_Only');
	BOOLEAN BocaShell_ExcludeWatchlists 						:= FALSE : STORED('BocaShell_ExcludeWatchlists');
	BOOLEAN BocaShell_Include_AdditionalWatchlists	:= FALSE : STORED('BocaShell_Include_AdditionalWatchlists');
	BOOLEAN BocaShell_DoScore 											:= FALSE : STORED('BocaShell_DoScore');
	BOOLEAN BocaShell_SuppressNearDups 							:= FALSE : STORED('BocaShell_SuppressNearDups');
	BOOLEAN BocaShell_Require2Elements 							:= FALSE : STORED('BocaShell_Require2Elements');
	INTEGER BocaShell_AppendBest 										:= 1 : STORED('BocaShell_AppendBest');
	INTEGER BocaShell_OFAC_Version 									:= 1 : STORED('BocaShell_OFAC_Version');
	INTEGER BocaShell_DOB_Radius 										:= -1 : STORED('BocaShell_DOB_Radius');
	REAL4 BocaShell_Watchlist_Threshold 						:= 0.84 : STORED('BocaShell_Watchlist_Threshold');
	STRING25 Phone_Score_Model_Temp									:= '' : STORED('Phone_Score_Model');
 STRING2 ModelVersion_Temp               := '' : STORED('ModelVersion');
	BOOLEAN BlankOutDuplicatePhones									:= FALSE :STORED('BlankOutDuplicatePhones');
	
	BOOLEAN UsePremiumSource_A											:= FALSE :STORED('UsePremiumSource_A');
	INTEGER PremiumSource_A_limit										:= Phone_Shell.Constants.maxEQP_Phones :STORED('PremiumSource_A_limit');
 BOOLEAN RunRelocation														:= FALSE :STORED('RunRelocation');
	Phone_Score_Model := StringLib.StringToUpperCase(Phone_Score_Model_Temp);
 ModelVersion      := StringLib.StringToUpperCase(ModelVersion_Temp);

	//ensure that the user selects Equifax(phonemart data) and that the DRM is not set
	allowPremiumSource_A:= UsePremiumSource_A = true and Phone_Shell.Constants.EquiaxDRMCheck(DataRestrictionMask);
 
	/* ************************************************************************
	 *  Combine the Service Inputs - Supports both Batch and Realtime         *
	 ************************************************************************ */
	Phone_Shell.Layout_Phone_Shell.Input batchifyRealtime() := TRANSFORM
		SELF.AcctNo := AcctNo;
		SELF.DID := DID;
		SELF.TitleName := TitleName;
		SELF.FullName := FullName;
		SELF.FirstName := FirstName;
		SELF.MiddleName := MiddleName;
		SELF.LastName := LastName;
		SELF.SuffixName := SuffixName;
		SELF.StreetAddress1 := StreetAddress1;
		SELF.StreetAddress2 := StreetAddress2;
		SELF.City := City;
		SELF.State := State;
		SELF.Zip := Zip;
		SELF.Prim_Range := Prim_Range;
		SELF.Predir := Predir;
		SELF.Prim_Name := Prim_Name;
		SELF.Addr_Suffix := Addr_Suffix;
		SELF.Postdir := Postdir;
		SELF.Unit_Desig := Unit_Desig;
		SELF.Sec_Range := Sec_Range;
		SELF.Zip5 := Zip5;
		SELF.Zip4 := Zip4;
		SELF.SSN := SSN;
		SELF.DateOfBirth := DateOfBirth;
		SELF.Age := Age;
		SELF.HomePhone := HomePhone;
		SELF.WorkPhone := WorkPhone;
		SELF.TargusGatewayEnabled := EnableTargusGateway;
		SELF.TransUnionGatewayEnabled := EnableTransUnionGateway;
		SELF.InsuranceGatewayEnabled := EnableInsuranceGateway;
		SELF := [];
	END;
	realtimeTemp := DATASET ([batchifyRealtime()]);
	
	// Make sure something was actually input
	realtime := realtimeTemp (AcctNo <> '' OR DID <> 0 OR TitleName <> '' OR FullName <> '' OR FirstName <> '' OR MiddleName <> '' OR LastName <> '' OR
														SuffixName <> '' OR StreetAddress1 <> '' OR StreetAddress2 <> '' OR City <> '' OR State <> '' OR Zip <> '' OR
														Prim_Range <> '' OR Predir <> '' OR Prim_Name <> '' OR Addr_Suffix <> '' OR Postdir <> '' OR Unit_Desig <> '' OR Sec_Range <> '' OR
														Zip5 <> '' OR Zip4 <> '' OR SSN <> '' OR DateOfBirth <> '' OR Age <> '' OR HomePhone <> '' OR WorkPhone <> '');
	
	Phone_Shell.Layout_Phone_Shell.Input batchSettings(Phone_Shell.Layout_Phone_Shell.Input le) := TRANSFORM
		SELF.TargusGatewayEnabled := le.TargusGatewayEnabled OR EnableTargusGateway;
		SELF.TransUnionGatewayEnabled := le.TransUnionGatewayEnabled OR EnableTransUnionGateway;
		SELF.InsuranceGatewayEnabled := le.InsuranceGatewayEnabled OR EnableInsuranceGateway;
		SELF := le;
	END;
	batch := PROJECT(Batch_In, batchSettings(LEFT));
  
    if( BocaShell_OFAC_Version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));
	
	// Combine Realtime and Batch Inputs - this allows the service to run in either realtime OR batch mode.  If both realtime and batch fields are filled in the realtime fields simply get added to the batch input
	input := DEDUP(SORT(realtime + batch, AcctNo, FullName, FirstName, MiddleName, LastName, TitleName, SuffixName, StreetAddress1, StreetAddress2, City, State, Zip, Prim_Range, Predir, Prim_Name, Addr_Suffix, Postdir, Unit_Desig, Sec_Range, Zip5, Zip4, SSN, DateOfBirth, Age, HomePhone, 
																						WorkPhone, TransUnionGatewayEnabled, InsuranceGatewayEnabled),
																				AcctNo, FullName, FirstName, MiddleName, LastName, TitleName, SuffixName, StreetAddress1, StreetAddress2, City, State, Zip, Prim_Range, Predir, Prim_Name, Addr_Suffix, Postdir, Unit_Desig, Sec_Range, Zip5, Zip4, SSN, DateOfBirth, Age, HomePhone, WorkPhone, 
																						TransUnionGatewayEnabled, InsuranceGatewayEnabled);

	/* ************************************************************************
	 *  Get the Phone Shell Results                                           *
	 ************************************************************************ */
	results := Phone_Shell.Phone_Shell_Function(input, Gateways, GLBPurpose, DPPAPurpose, DataRestrictionMask, DataPermissionMask, PhoneRestrictionMask, 
																							MaxPhones, InsuranceVerificationAgeLimit, PhoneShell_Version, SPIIAccessLevel, VerticalMarket, IndustryClass,
																							RelocationsMaxDaysBefore, RelocationsMaxDaysAfter, RelocationsTargetRadius, IncludeLastResort, IncludePhonesFeedback, 
																							BocaShell_IncludeRelatives, BocaShell_IncludeDL, BocaShell_IncludeVehicle, BocaShell_IncludeDerog,
																							BocaShell_OFAC_Only, BocaShell_ExcludeWatchlists, BocaShell_Include_OFAC, BocaShell_Include_AdditionalWatchlists,
																							BocaShell_DoScore, BocaShell_SuppressNearDups, BocaShell_Require2Elements, BocaShell_AppendBest,
																							BocaShell_OFAC_Version, BocaShell_Watchlist_Threshold, BocaShell_DOB_Radius,
																							EnforceTestAccounts, EXISTS(batch), SX_Match_Restriction_Limit, Strict_APSX, BlankOutDuplicatePhones,  	
																							UsePremiumSource_A, RunRelocation);
	//If batch has 1 using gateway and one not a the batch level they will all go against the gateway.
	//As we don't have a way to call the gateway at the record level. It's at the dataset level.

	model_results := MAP(Phone_Score_Model not in ['PHONESCORE_V2','COLLECTIONSCORE_V3'] => results,	// If no models called, just return the shell and attributes
											           ModelVersion in ['V2'] and allowPremiumSource_A                 => Phone_Shell.PhoneScore_cp3_v2(results, Score_Threshold), 
											           ModelVersion in ['V2'] and not allowPremiumSource_A             => Phone_Shell.PhoneScore_wf8_v2(results, Score_Threshold), 
                      // Basically, ModelVersion = V2 calls the old models (above). This is the ONLY way to call the old v2 models. 
                      // Anything else in ModelVersion (blank, V3, XYZ, etc) will call the new v3 models (below).
                      allowPremiumSource_A                                            => Phone_Shell.PhoneScore_cp3_v3(results, Score_Threshold),
											                                                                              Phone_Shell.PhoneScore_wf8_v3(results, Score_Threshold)
                     ); 

// for debug, pick model
//model_results := Phone_Shell.PhoneScore_cp3_v3(results, Score_Threshold); 
// model_results := Phone_Shell.PhoneScore_wf8_v3(results, Score_Threshold); 

// for debug, comment out the rest (start comment-out section)

	//need to limit the Equifax hits ...do here as we now have the equifax hits scored....want highest scores to be in the limit
	//if EQP and other sources, that is fine as we would have returned those hits even without the EQP.........
	equifax_results := model_results(Phone_Shell.Sources.Source_List = 'EQP');
	//StringLib.StringFind(Phone_Shell.Sources.Source_List, 'EQP', 1) > 0;
	PremiumSource_A_limit_max := if(allowPremiumSource_A and PremiumSource_A_limit > Phone_Shell.Constants.maxEQP_Phones, Phone_Shell.Constants.maxEQP_Phones, PremiumSource_A_limit);
	equifax_srtd := SORT(equifax_results, Phone_Shell.Input_Echo.AcctNo, Phone_Shell.Input_Echo.Seq, -((INTEGER)Phone_Shell.Phone_Model_Score), 
			-LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);
		//want it sorted and grouped by Acctno so in batch they see the limit applied to each acctno
	equifax_srt := TOPN(GROUP(equifax_srtd, Phone_Shell.Input_Echo.AcctNo, Phone_Shell.Input_Echo.Seq), PremiumSource_A_limit_max, 
			Phone_Shell.Input_Echo.AcctNo, Phone_Shell.Input_Echo.Seq, -((INTEGER)Phone_Shell.Phone_Model_Score), 
			-LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);
	
	model_results_srted := if(allowPremiumSource_A, model_results(Phone_Shell.Sources.Source_List != 'EQP') + equifax_srt, model_results);
	//sort for output
	final_results_sorted := SORT(model_results_srted, Phone_Shell.Input_Echo.AcctNo, Phone_Shell.Input_Echo.Seq, -((INTEGER)Phone_Shell.Phone_Model_Score), 
			-LENGTH(TRIM(Phone_Shell.Sources.Source_List)), Phone_Shell.Gathered_Phone);

	final_results := final_results_sorted;
	//output(model_results, named('model_results'));
	
	RETURN OUTPUT(final_results, NAMED('Results'));
// end debug comment-out section

// debug return
// RETURN OUTPUT(model_results, NAMED('Results'));

END;