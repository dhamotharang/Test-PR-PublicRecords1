/*--SOAP--
<message name="St. Cloud Main Service CBDO">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>	
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="wphone" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="cmpy2" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="addr2" type="xsd:string"/>
	<part name="city2" type="xsd:string"/>
	<part name="state2" type="xsd:string"/>
	<part name="zip2" type="xsd:string"/>
	<part name="hphone2" type="xsd:string"/>
	<part name="socs2" type="xsd:string"/>
	<part name="wphone2" type="xsd:string"/>
	<part name="apptype" type="xsd:string"/>
	<part name="channel" type="xsd:string"/>
	<part name="orderamt" type="xsd:string"/>
	<part name="numitems" type="xsd:string"/>
	<part name="orderdate" type="xsd:string"/>
	<part name="shipmode" type="xsd:string"/>
	<part name="pymtmethod" type="xsd:string"/>
	<part name="avscode" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
 </message>
*/
/*--INFO-- This process is batch only and this will not be used */

      
import Risk_Indicators, gateway, STD, Riskwise;


export RiskWiseMainCBDO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'cmpy',
	'first',
	'last',	
	'addr',
	'city',
	'state',
	'zip',
	'hphone',
	'socs',
	'dob',
	'wphone',
	'email',
	'cmpy2',
	'first2',
	'last2',
	'addr2',
	'city2',
	'state2',
	'zip2',
	'hphone2',
	'socs2',
	'wphone2',
	'apptype',
	'channel',
	'orderamt',
	'numitems',
	'orderdate',
	'shipmode',
	'pymtmethod',
	'avscode',
	'DPPAPurpose',
	'GLBPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));

string4  tribCode_value := '' 	: stored('tribcode');
string30 account_value := '' 		: stored('account');
string30 cmpy_value := '' 		: stored('cmpy');
string15 first_value := ''     	: stored('first');
string20 last_value := ''    		: stored('last');
string50 addr_value := ''    		: stored('addr');
string30 city_value := ''    		: stored('city');
string2  state_value := ''    	: stored('state');
string9  zip_value := ''      	: stored('zip');
string10 hphone_value := ''  		: stored('hphone');
string9  socs_value := ''     	: stored('socs');
string8  dob_value := ''      	: stored('dob');
string10 wphone_value := ''  		: stored('wphone');
string50 email_value := ''  		: stored('email');
string30 cmpy2_value := '' 		: stored('cmpy2');
string15 first2_value := ''     	: stored('first2');
string20 last2_value := ''   		: stored('last2');
string50 addr2_value := ''   		: stored('addr2');
string30 city2_value := ''   		: stored('city2');
string2  state2_value := ''   	: stored('state2');
string9  zip2_value := ''     	: stored('zip2');
string10 hphone2_value := '' 		: stored('hphone2');
string9  socs2_value := ''    	: stored('socs2');
string10 wphone2_value := '' 		: stored('wphone2');
string2  apptype_value := ''      	: stored('apptype');
string2  channel_value := ''		: stored('channel');
string6  orderamt_value := '' 	: stored('orderamt');
string3  numitems_value := ''		: stored('numitems');
string8  orderdate_value := ''	: stored('orderdate');
string2  shipmode_value := ''		: stored('shipmode');
string2  pymtmethod_value := ''	: stored('pymtmethod');
string3  avscode_value := ''		: stored('avscode');

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  	: stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

gateways := Gateway.Constants.void_gateway;

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

tribCode := STD.Str.ToLowerCase(tribCode_value);

productSet := ['cd02'];

d := dataset([{0}],RiskWise.Layout_CBDI);

Riskwise.Layout_CBDI addseq(d le, INTEGER C) := TRANSFORM
 	self.seq := C;
	self.account := account_value;
	self.cmpy := cmpy_value;
	self.first := first_value;
	self.last := last_value;
	self.addr := addr_value;
	self.city := city_value;
	self.state := state_value;
	self.zip := zip_value;
	self.hphone := hphone_value;
	self.socs := socs_value;
	self.dob := dob_value;
	self.wphone := wphone_value;
	self.email := email_value;
	self.cmpy2 := cmpy2_value;
	self.first2 := first2_value;
	self.last2 := last2_value;
	self.addr2 := addr2_value;
	self.city2 := city2_value;
	self.state2 := state2_value;
	self.zip2 := zip2_value;
	self.hphone2 := hphone2_value;
	self.socs2 := socs2_value;
	self.wphone2 := wphone2_value;
	self.apptype := apptype_value;
	self.channel := channel_value;
	self.orderamt := orderamt_value;
	self.numitems := numitems_value;
	self.orderdate := orderdate_value;
	self.shipmode := shipmode_value;
	self.pymtmethod := pymtmethod_value;
	self.avscode := avscode_value;
	self.historydate := history_date;
end;
indata := project(d, addseq(LEFT,COUNTER));

finalOutput := if(tribCode in productSet, RiskWise.CBDO_Function(indata, gateways, GLB_Purpose, DPPA_Purpose, DataRestriction, DataPermission,
                                                                                                                   LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                                   TransactionID := TransactionID, 
                                                                                                                   BatchUID := BatchUID, 
                                                                                                                   GlobalCompanyID := GlobalCompanyID), dataset([],RiskWise.Layout_CBDO));

output(finalOutput, named('Results'));

ENDMACRO;