// Mortgage Shell Service
/*--SOAP--
<message name="Mortgage Shell Service" wuTimeout="300000">
	<part name="AccountNumber" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="Country" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="Age" type="xsd:unsignedInt"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DLState" type="xsd:string"/>
	<part name="Email" type="xsd:string"/>
	<part name="IPAddress" type="xsd:string"/>
	<part name="HomePhone" type="xsd:string"/>
	<part name="WorkPhone" type="xsd:string"/>
	<part name="EmployerName" type="xsd:string"/>
	<part name="FormerName" type="xsd:string"/>
	<part name="FirstName2" type="xsd:string"/>
	<part name="MiddleName2" type="xsd:string"/>
	<part name="LastName2" type="xsd:string"/>
	<part name="NameSuffix2" type="xsd:string"/>
	<part name="StreetAddress2" type="xsd:string"/>
	<part name="City2" type="xsd:string"/>
	<part name="State2" type="xsd:string"/>
	<part name="Zip2" type="xsd:string"/>
	<part name="Country2" type="xsd:string"/>
	<part name="SSN2" type="xsd:string"/>
	<part name="DateOfBirth2" type="xsd:string"/>
	<part name="Age2" type="xsd:unsignedInt"/>
	<part name="DLNumber2" type="xsd:string"/>
	<part name="DLState2" type="xsd:string"/>
	<part name="Email2" type="xsd:string"/>
	<part name="IPAddress2" type="xsd:string"/>
	<part name="HomePhone2" type="xsd:string"/>
	<part name="WorkPhone2" type="xsd:string"/>
	<part name="EmployerName2" type="xsd:string"/>
	<part name="FormerName2" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="BSVersion" type = 'xsd:integer'/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="HistoryDateTimeStamp" type="xsd:string"/>
	<part name="IncludeScore" type="xsd:boolean"/>
	<part name="RetainInputDID" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/

import AutoStandardI;

export Mortgage_Shell_Service := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

#WEBSERVICE(FIELDS(
	'AccountNumber',
	'FirstName',
	'MiddleName',
	'LastName',
	'NameSuffix',
	'StreetAddress',
	'City',
	'State',
	'Zip',
	'Country',
	'SSN',
	'DateOfBirth',
	'Age',
	'DLNumber',
	'DLState',
	'Email',
	'IPAddress',
	'HomePhone',
	'WorkPhone',
	'EmployerName',
	'FormerName',
	'FirstName2',
	'MiddleName2',
	'LastName2',
	'NameSuffix2',
	'StreetAddress2',
	'City2',
	'State2',
	'Zip2',
	'Country2',
	'SSN2',
	'DateOfBirth2',
	'Age2',
	'DLNumber2',
	'DLState2',
	'Email2',
	'IPAddress2',
	'HomePhone2',
	'WorkPhone2',
	'EmployerName2',
	'FormerName2',
	'DPPAPurpose',
	'GLBPurpose', 
	'DataRestrictionMask',
	'DataPermissionMask',
	'BSVersion',
	'IndustryClass',
	'HistoryDateYYYYMM',
	'HistoryDateTimeStamp',
	'IncludeScore',
	'RetainInputDID',
	'gateways',
	'DISPLAYOutput'));

 
unsigned1 DPPA_Purpose     := 0 			                                              : stored('DPPAPurpose');
unsigned1 GLB_Purpose      := AutoStandardI.Constants.GLBPurpose_default 						: stored('GLBPurpose');
string DataRestriction     := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission      := Risk_Indicators.iid_constants.default_DataPermission 	: stored('DataPermissionMask');
unsigned1 version          := 50					                                          : stored('BSVersion');	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
STRING5   industry_class_val := ''                                                  : STORED('IndustryClass');
boolean   isUtility          := StringLib.StringToUpperCase(industry_class_val) = 'UTILI';
 
boolean   doScore          := false				                                          : stored('IncludeScore');	// allow user to turn on RV and FD scores for realtime runs
boolean   RetainInputDID   := false				                                          : stored('RetainInputDID');	
BOOLEAN   DISPLAYOutput    := Mortgage_Fraud.constants.DISPLAYOutput_default        : STORED('DISPLAYOutput');


/* Gateways                                                                           */
   gateways := Mortgage_Fraud.DO_Transform.ON_GATEWAY(version);

/* Build a record from the all of the stored values obtained from the input request. */ 
   prep := Mortgage_Fraud.DO_Transform.ON_INPUT();

/*  Set all of the options needed for this Service                                    */  
FraudPointMode           := if(version>=41, true, false);	 
doScore_again            := if(version>=51, true, doScore);                            //want to run so get FDN fields back for CBDd 5.0
useNetAcuity_v4          := True;
IncludeDLverification    := if(FraudPointMode, true, false);
unsigned8 BSOptions      := 
                            if(FraudPointMode, 
	                             risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
	                             risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
	                             0) +
                               if(RetainInputDID, risk_indicators.iid_constants.BSOptions.RetainInputDID, 0) +
                            if(version >= 50, risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0);

ln_branded                    := false;
ofac_only                     := false;
suppressNearDups              := true;
require2elements              := false;
from_BIID                     := false;
isFCRA                        := false;
excludeWatchlists             := false;
from_IT1O                     := false;
ofac_version                  := 2;
include_ofac                  := true;
include_additional_watchlists := true;
global_watchlist_threshold    := .84;
dob_radius                    := -1;

includeRelativeInfo           := true;
includeDLInfo                 := true;
includeVehicleInfo            := true;
includeDerogInfo              := true;

/*  CALL the INSTANT ID FUNCTION for these 2 borrowers  */  
iid_results    := Mortgage_Fraud.Get_InstantId_Function(prep, 
                                                        gateways, 
																												DPPA_Purpose, 
																												GLB_Purpose, 
																												isUtility, 
																												ln_branded, 
																												ofac_only, 
																												suppressNearDups, 
																												require2elements, 
																												from_BIID, 
																												isFCRA,	
																												excludeWatchlists, 
																												from_IT1O, 
																												ofac_version, 
																												include_ofac, 
																												include_additional_watchlists, 
																												global_watchlist_threshold, 
																												dob_radius, 
																												version, 
																												BSOptions,
																												DISPLAYOutput,
																												DataRestriction   := DataRestriction, 
																												runDLverification :=IncludeDLverification, 
																												DataPermission    := DataPermission
																												);

/*  CALL the BOCA SHELL FUNCTION for these 2 borrowers  */
return_results := Mortgage_Fraud.Get_Boca_Shell_Function(iid_results, 
																												gateways, 
																												DPPA_Purpose, 
																												GLB_Purpose, 
																												isUtility,
																												ln_branded, 
																												includeRelativeInfo, 
																												includeDLInfo, 
																												includeVehicleInfo, 
																												includeDerogInfo, 
																												version, 
																												doScore_again,
																												DISPLAYOutput,
																												nugen := true,
																												DataRestriction := DataRestriction, 
																												inBSOptions:=BSOptions, 
																												DataPermission := DataPermission, 
																												NetAcuity_v4 := useNetAcuity_v4
																												);

/*  CALL the VOO FUNCTION for these 2 borrowers    */
return_plus_VOO  := Mortgage_Fraud.Get_VOO_Function(return_results, 
                                                    DataRestriction,
																										GLB_Purpose,
																										DPPA_Purpose,
																										DataPermission,
																										DISPLAYOutput);
											


IF(DISPLAYOutput,output (iid_results,       NAMED('iid_results')));       /*  This is results from Instant ID                */
IF(DISPLAYOutput,output (return_results,    NAMED('return_results')));    /*  This is results from the Boca Shell            */   
                 output (return_plus_VOO,   NAMED('return_plus_VOO'));    /*  This is the final results from IID, BS and VOO */

ENDMACRO;
