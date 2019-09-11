/*--SOAP--
<message name="PR2OBatchService">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- 'fds1','fds3','fd23','cap1','bnk1' */

import Risk_Indicators, gateway, STD, Riskwise;

EXPORT PR2O_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4	tribCode_value := ''							: stored('tribcode');
tribCode := STD.Str.ToLowerCase(tribCode_value);
unsigned1 dppa := RiskWise.permittedUse.fraudDPPA 			: stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  							: stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');

string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
batchin := dataset([],riskwise.Layout_SD1I_BatchIn)			: stored('batch_in',few);
gateways_in := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

productSet := ['fds1','fds3','fd23','cap1','bnk1'];

targusGatewaySet := ['cap1','bnk1'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(tribcode in targusGatewaySet and le.servicename = 'targus', le.url,  ''); // default to no gateway call			
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));


RiskWise.Layout_SD1I addseq(batchin le, integer C) := transform
	self.seq := C;
	self.tribcode := tribcode;
	self.acctno := le.acctno;
	self.account := le.account;
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

almost_final := RiskWise.PR2O_Function(f, gateways, glb, dppa, tribCode, DataRestriction := DataRestriction, DataPermission := DataPermission,
                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                        TransactionID := TransactionID, 
                                                                        BatchUID := BatchUID, 
                                                                        GlobalCompanyID := GlobalCompanyID);
                                                                        
final := project(almost_final, RiskWise.Layout_PR2O);

ret := if(tribcode in productSet, final, dataset([],RiskWise.Layout_PR2O));

output(ret, named('Results'));

endmacro;