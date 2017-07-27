/*--SOAP--
<message name="St. Cloud Main Service NP2O FCRA">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="middleini" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="wphone" type="xsd:string"/>
	<part name="income" type="xsd:string"/>
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="balance" type="xsd:string"/>
	<part name="chargeoffdate" type="xsd:string"/>
	<part name="formerlast" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="countrycode" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="FFDOptionsMask"	type="xsd:string"/>	
</message>
*/
/*--INFO-- 'np12','np32','np52','ex29','ex49','np33' */

import Risk_Indicators, RiskWise, gateway;


export RiskWiseMainNP2O := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'middleini',
	'last',
	'addr',
	'city',
	'state',
	'zip',
	'hphone',
	'socs',
	'dob',
	'wphone',
	'income',
	'drlc',
	'drlcstate',
	'balance',
	'chargeoffdate',
	'formerlast',
	'email',
	'cmpy',
	'countrycode',
	'DPPAPurpose',
	'GLBPurpose',
	'HistoryDateYYYYMM',
	'runSeed',
	'DataRestrictionMask',
	'DataPermissionMask',
	'gateways',
	'FFDOptionsMask'));

string4  tribCode_value := '' 		: stored('tribcode');
string30 account_value := '' 			: stored('account');
string15 first_value := ''     		: stored('first');
string1  middleini_value := ''     	: stored('middleini');
string20 last_value := ''     		: stored('last');
string50 addr_value := ''    			: stored('addr');
string30 city_value := ''      		: stored('city');
string2  state_value := ''      		: stored('state');
string9  zip_value := ''      		: stored('zip');
string10 hphone_value := ''   		: stored('hphone');
string9  socs_value := ''      		: stored('socs');
string8  dob_value := ''      		: stored('dob');
string10 wphone_value := ''  			: stored('wphone');
string6  income_value := ''			: stored('income');
string20 drlc_value := ''     		: stored('drlc');
string2  drlcstate_value := ''		: stored('drlcstate');
string6  balance_value := ''			: stored('balance');
string8  chargeoffdate_value := ''		: stored('chargeoffdate');
string20 formerlast_value := ''    	: stored('formerlast');
string50 email_value := ''  			: stored('email');
string30 cmpy_value := ''   			: stored('cmpy');
string2 countrycode_value := '' 		: stored('countrycode');

unsigned1 DPPA_Purpose := 0  			: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  		: stored('HistoryDateYYYYMM');
boolean   runSeed_value := false 		: stored('runSeed');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways_in := Gateway.Configuration.Get();
STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean UsePersonContext := strFFDOptionsMask_in[1] = '1';			

productSet := ['np12','np32','np52','ex29','ex49','np33'];

tribCode := StringLib.StringToLowerCase(tribCode_value);


Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(le.servicename IN RiskWiseFCRA.Neutral_Service_Name, le.url, ''); // default to no gateway call			 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

d := dataset([{0}],RiskWise.Layout_PRII);

RiskWise.Layout_PRII addseq(d le, INTEGER C) := TRANSFORM
	self.seq := C;
	self.tribcode := tribCode;
	self.account := account_value;
     self.first := first_value;
     self.middleini := middleini_value;
     self.last := last_value;
     self.addr := addr_value;
     self.city := city_value;
     self.state := state_value;
     self.zip := zip_value;
     self.hphone := hphone_value;
     self.socs := socs_value;
     self.dob := dob_value;
     self.wphone := wphone_value;
     self.income := income_value;
     self.drlc := drlc_value;
     self.drlcstate := drlcstate_value;
     self.balance := balance_value;
     self.chargeoffdate := chargeoffdate_value;
     self.formerlast := formerlast_value;
     self.email := email_value;
     self.cmpy := cmpy_value;
	self.countrycode := countrycode_value;
	self.historydate := history_date;
end;
f := PROJECT(d, addseq(left,counter));


final_seed := if(runSeed_value, RiskWise.seedNP2O(tribcode, socs_value, account_value), dataset([],RiskWise.Layout_NP2O));
				
finalOutput := if(tribCode in productSet,
			   if(count(final_seed)>0 and runSeed_value, final_seed, RiskWiseFCRA.NP2O_Function_FCRA(f, gateways, GLB_Purpose, DPPA_Purpose, tribCode, DataRestriction, DataPermission, UsePersonContext)),
			      dataset([],RiskWise.Layout_NP2O));


output(finalOutput, named('Results'));

ENDMACRO;