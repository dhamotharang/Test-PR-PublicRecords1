/*--SOAP--
<message name="St. Cloud Main Service SD1O FCRA">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="apptypeflag" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="wphone" type="xsd:string"/>
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="apptypeflag2" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="cmpy2" type="xsd:string"/>
	<part name="addr2" type="xsd:string"/>
	<part name="city2" type="xsd:string"/>
	<part name="state2" type="xsd:string"/>
	<part name="zip2" type="xsd:string"/>
	<part name="socs2" type="xsd:string"/>
	<part name="dob2" type="xsd:string"/>
	<part name="hphone2" type="xsd:string"/>
	<part name="wphone2" type="xsd:string"/>
	<part name="drlc2" type="xsd:string"/>
	<part name="drlcstate2" type="xsd:string"/>
	<part name="email2" type="xsd:string"/>
	<part name="saleamt" type="xsd:string"/>
	<part name="purchdate" type="xsd:string"/>
	<part name="purchtime" type="xsd:string"/>
	<part name="checkaba" type="xsd:string"/>
	<part name="checkacct" type="xsd:string"/>
	<part name="checknum" type="xsd:string"/>
	<part name="bankname" type="xsd:string"/>
	<part name="pymtmethod" type="xsd:string"/>
	<part name="cctype" type="xsd:string"/>
	<part name="avscode" type="xsd:string"/>
	<part name="inquiries" type="xsd:string"/>
	<part name="trades" type="xsd:string"/>
	<part name="balance" type="xsd:string"/>
	<part name="bankbalance" type="xsd:string"/>
	<part name="highcredit" type="xsd:string"/>
	<part name="delinquent90plus" type="xsd:string"/>
	<part name="numrevolvingtrades" type="xsd:string"/>
	<part name="autotrades" type="xsd:string"/>
	<part name="autotradesopen" type="xsd:string"/>
	<part name="income" type="xsd:string"/>
	<part name="income2" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="ccnum" type="xsd:string"/>
	<part name="ccexpdate" type="xsd:string"/>
	<part name="reserved" type="xsd:string"/>
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
/*--INFO-- 'ex75' */

import Risk_Indicators, RiskWise, gateway;


export RiskWiseMainSD1O := MACRO

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'apptypeflag',
	'first',
	'last',
	'cmpy',
	'addr',
	'city',
	'state',
	'zip',
	'socs',
	'dob',
	'hphone',
	'wphone',
	'drlc',
	'drlcstate',
	'email',
	'apptypeflag2',
	'first2',
	'last2',
	'cmpy2',
	'addr2',
	'city2',
	'state2',
	'zip2',
	'socs2',
	'dob2',
	'hphone2',
	'wphone2',
	'drlc2',
	'drlcstate2',
	'email2',
	'saleamt',
	'purchdate',
	'purchtime',
	'checkaba',
	'checkacct',
	'checknum',
	'bankname',
	'pymtmethod',
	'cctype',
	'avscode',
	'inquiries',
	'trades',
	'balance',
	'bankbalance',
	'highcredit',
	'delinquent90plus',
	'numrevolvingtrades',
	'autotrades',
	'autotradesopen',
	'income',
	'income2',
	'ipaddr',
	'ccnum',
	'ccexpdate',
	'reserved',
	'DPPAPurpose',
	'GLBPurpose',
	'HistoryDateYYYYMM',
	'runSeed',
	'DataRestrictionMask', 
	'DataPermissionMask', 
	'gateways',
	'FFDOptionsMask'));

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4   tribCode_value := '' 			: stored('tribcode');
string30  account_value := ''  			: stored('account');
string1   apptypeflag_value := ''			: stored('apptypeflag');
string15  first_value := ''    			: stored('first');
string20  last_value := ''     			: stored('last');
string30  cmpy_value := ''     			: stored('cmpy');
string50  addr_value := ''     			: stored('addr');
string30  city_value := ''     			: stored('city');
string2   state_value := ''    			: stored('state');
string9   zip_value := ''      			: stored('zip');
string9   socs_value := ''     			: stored('socs');
string8   dob_value := ''      			: stored('dob');
string10  hphone_value := ''   			: stored('hphone');
string10  wphone_value := ''   			: stored('wphone');
string20  drlc_value := ''     			: stored('drlc');
string2   drlcstate_value := ''			: stored('drlcstate');
string50  email_value := ''    			: stored('email');

// SECOND INPUT
string1   apptypeflag2_value := ''			: stored('apptypeflag2');
string15  first2_value := ''     			: stored('first2');
string20  last2_value := ''     			: stored('last2');
string30  cmpy2_value := ''   			: stored('cmpy2');
string50  addr2_value := ''    			: stored('addr2');
string30  city2_value := ''      			: stored('city2');
string2   state2_value := ''      			: stored('state2');
string9   zip2_value := ''      			: stored('zip2');
string9   socs2_value := ''      			: stored('socs2');
string8   dob2_value := ''      			: stored('dob2');
string10  hphone2_value := ''   			: stored('hphone2');
string10  wphone2_value := ''  			: stored('wphone2');
string20  drlc2_value := ''     			: stored('drlc2');
string2   drlcstate2_value := ''   		: stored('drlcstate2');
string50  email2_value := ''  			: stored('email2');

string6   saleamt_value := ''    			: stored('saleamt');
string8   purchdate_value := ''   			: stored('purchdate');
string6   purchtime_value := ''    		: stored('purchtime');
string11  checkaba_value := ''    			: stored('checkaba');
string9   checkacct_value := ''    		: stored('checkacct');
string7   checknum_value := ''    			: stored('checknum');
string40  bankname_value := ''    			: stored('bankname');
string2   pymtmethod_value := ''   		: stored('pymtmethod');
string1   cctype_value := ''    			: stored('cctype');
string2   avscode_value := ''    			: stored('avscode');
string2   inquiries_value := ''    		: stored('inquiries');
string3   trades_value := ''    			: stored('trades');
string6   balance_value := ''    			: stored('balance');
string6   bankbalance_value := ''  		: stored('bankbalance');
string6   highcredit_value := ''   		: stored('highcredit');
string3   delinquent90plus_value := ''    	: stored('delinquent90plus');
string2   numrevolvingtrades_value := ''  	: stored('numrevolvingtrades');
string2   autotrades_value := ''   		: stored('autotrades');
string2   autotradesopen_value := ''      	: stored('autotradesopen');
string6   income_value := ''    			: stored('income');
string6   income2_value := ''    			: stored('income2');
string45  ipaddr_value := ''    			: stored('ipaddr');
string16  ccnum_value := ''    			: stored('ccnum');
string8   ccexpdate_value := ''    		: stored('ccedpdate');
string53  reserved_value := ''    			: stored('reserved');

unsigned1 DPPA_Purpose := 0  				: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  			: stored('HistoryDateYYYYMM');
boolean   runSeed_value := false 			: stored('runSeed');
gateways_in := Gateway.Configuration.Get();
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
productSet := ['ex75'];
STRING  strFFDOptionsMask_in	 :=  '0' : STORED('FFDOptionsMask');
boolean UsePersonContext := strFFDOptionsMask_in[1] = '1';

tribCode := StringLib.StringToLowerCase(tribCode_value);


Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	self.servicename := le.servicename;
	self.url := if(le.servicename IN riskwisefcra.Neutral_Service_Name, le.url, ''); // default to no gateway call			 
	self := le;
END;
gateways := project(gateways_in, gw_switch(left));


d := dataset([{0}],RiskWise.Layout_SD1I);

RiskWise.Layout_SD1I addseq(d le, INTEGER C) := TRANSFORM
	self.seq := C;
	self.tribcode := tribCode;
	self.account := account_value;
	self.apptypeflag := apptypeflag_value;
	self.first := first_value;
	self.last := last_value;
	self.cmpy := cmpy_value;
	self.addr := addr_value;
	self.city := city_value;
	self.state := state_value;
	self.zip := zip_value;
	self.socs := socs_value;
	self.dob := dob_value;
	self.hphone := hphone_value;
	self.wphone := wphone_value;
	self.drlc := drlc_value;
	self.drlcstate := drlcstate_value;
	self.email := email_value;
	self.apptypeflag2 := apptypeflag2_value;
	self.first2 := first2_value;
	self.last2 := last2_value;
	self.cmpy2 := cmpy2_value;
	self.addr2 := addr2_value;
	self.city2 := city2_value;
	self.state2 := state2_value;
	self.zip2 := zip2_value;
	self.socs2 := socs2_value;
	self.dob2 := dob2_value;
	self.hphone2 := hphone2_value;
	self.wphone2 := wphone2_value;
	self.drlc2 := drlc2_value;
	self.drlcstate2 := drlcstate2_value;
	self.email2 := email2_value;
	self.saleamt := saleamt_value;
	self.purchdate := purchdate_value;
	self.purchtime := purchtime_value;
	self.checkaba := checkaba_value;
	self.checkacct := checkacct_value;
	self.checknum := checknum_value;
	self.bankname := bankname_value;
	self.pymtmethod := pymtmethod_value;
	self.cctype := cctype_value;
	self.avscode := avscode_value;
	self.inquiries := inquiries_value;
	self.trades := trades_value;
	self.balance := balance_value;
	self.bankbalance := bankbalance_value;
	self.highcredit := highcredit_value;
	self.delinquent90plus := delinquent90plus_value;
	self.numrevolvingtrades := numrevolvingtrades_value;
	self.autotrades := autotrades_value;
	self.autotradesopen := autotradesopen_value;
	self.income := income_value;
	self.income2 := income2_value;
	self.ipaddr := ipaddr_value;
	self.ccnum := ccnum_value;
	self.ccexpdate := ccexpdate_value;
	self.reserved := reserved_value;
	self.historydate := history_date;
END;
f := project(d, addseq(left,counter));

critter := map(tribcode='ex75' => '075',
			'');
			
seed_files.mac_query_seedfiles(socs_value, 'sd1o', 'sd1i', critter, seed_out);

RiskWise.Layout_SD1O format_seed(seed_out le) := TRANSFORM
	self.account := account_value;
	self := le;
	self := [];
END;

final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], RiskWise.Layout_SD1O));
	
finalAnswer := if(tribCode in productSet,
				if(count(final_seed)>0 and runSeed_value, final_seed, RiskWiseFCRA.SD1O_Function_FCRA(f, gateways, GLB_Purpose, DPPA_Purpose, tribCode,DataRestriction, DataPermission,UsePersonContext)), 
				   dataset([], riskwise.Layout_SD1O));
output(finalAnswer, named('Results'));

ENDMACRO;