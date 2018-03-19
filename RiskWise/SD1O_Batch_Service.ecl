﻿/*--SOAP--
<message name="SD1OBatchService">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO--'ex02','ex03','ex06','ex07','ex08','ex09','ex10','ex22','ex70','sd01','sd50','cb61','2x08','2x10' */

import Address, Risk_Indicators, gateway;

export SD1O_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4	tribcode_value := ''							: stored('tribcode');
tribCode := StringLib.StringToLowerCase(tribCode_value);
unsigned1 dppa := RiskWise.permittedUse.fraudDPPA 			: stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  							: stored('HistoryDateYYYYMM');
real global_watchlist_threshold := 0.84 			: stored('GlobalWatchlistThreshold');
unsigned1 ofac_version      := 1        : stored('OFACVersion');
boolean   include_ofac       := false    : stored('IncludeOfac');
boolean   include_additional_watchlists  := false    : stored('IncludeAdditionalWatchLists');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
batchin := dataset([],riskwise.Layout_SD1I_BatchIn)			: stored('batch_in',few);
gateways_in := Gateway.Configuration.Get();

productSet := ['ex02','ex03','ex06','ex07','ex08','ex09','ex10','ex22','ex70','sd01','sd50','cb61','2x08','2x10'];

targusGatewaySet := ['ex03','ex22','ex70','sd01','cb61'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode in targusGatewaySet and le.servicename = 'targus' => le.url, // targus gateway
                 tribcode in ['ex02','ex03','ex06','ex07','ex08','ex09','ex10','ex22','ex70','sd50','2x08','2x10'] and le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
                 ''); // default to no gateway call
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));


RiskWise.Layout_SD1I addseq(batchin le, integer C) := transform
	self.seq := C;
	self.tribcode := tribcode;
	self.account := le.account;
	self.acctno := le.acctno;
	self.apptypeflag := le.apptypeflag;
	self.first := le.name_first;
	self.last := le.name_last;
	self.cmpy := le.company_name;
	self.addr := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr,le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);
	self.city := le.p_city_name;
	self.state := le.st;
	self.zip := le.z5 + le.z4;
	self.socs := le.ssn;
	self.dob := le.dob;
	self.hphone := le.home_phone;
	self.wphone := le.work_phone;
	self.drlc := le.dl_number;
	self.drlcstate := le.dl_state;
	self.email := le.email;
	self.apptypeflag2 := le.apptypeflag_2;
	self.first2 := le.name_first_2;
	self.last2 := le.name_last_2;
	self.cmpy2 := le.company_name_2;
	self.addr2 := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr2,le.prim_range_2,le.predir_2,le.prim_name_2,le.suffix_2,le.postdir_2,le.unit_desig_2,le.sec_range_2);
	self.city2 := le.city_2;
	self.state2 := le.state_2;
	self.zip2 := le.z5_2 + le.z4_2;
	self.socs2 := le.ssn_2;
	self.dob2 := le.dob_2;
	self.hphone2 := le.home_phone_2;
	self.wphone2 := le.work_phone_2;
	self.drlc2 := le.dl_number_2;
	self.drlcstate2 := le.dl_state_2;
	self.email2 := le.email_2;
	self.saleamt := le.saleamt;
	self.purchdate := le.purchdate;
	self.purchtime := le.purchtime;
	self.checkaba := le.checkaba;
	self.checkacct := le.checkacct;
	self.checknum := le.checknum;
	self.bankname := le.bankname;
	self.pymtmethod := le.pymtmethod;
	self.cctype := le.cctype;
	self.avscode := le.avscode;
	self.inquiries := le.inquiries;
	self.trades := le.trades;
	self.balance := le.balance;
	self.bankbalance := le.bankbalance;
	self.highcredit := le.highcredit;
	self.delinquent90plus := le.delinquent90plus;
	self.numrevolvingtrades := le.numrevolvingtrades;
	self.autotrades := le.autotrades;
	self.autotradesopen := le.autotradesopen;
	self.income := le.income;
	self.income2 := le.income_2;
	self.ipaddr := le.ipaddr;
	self.ccnum := le.ccnum;
	self.ccexpdate := le.ccexpdate;
	self.reserved := le.reserved;
	// if the record level history date isn't populated yet, use the global parameter
	self.historydate := if(le.HistoryDateYYYYMM=0, history_date, le.historydateYYYYMM); 
end;
f := project(batchin, addseq(LEFT,COUNTER));

ret := if(tribCode in productSet, RiskWise.SD1O_Function(f, gateways, glb, dppa, tribCode, ofac_version, include_ofac, include_additional_watchlists, 
                                                         global_watchlist_threshold, datarestriction, DataPermission), dataset([],RiskWise.Layout_SD1O));

output(ret, named('Results'));

ENDMACRO;