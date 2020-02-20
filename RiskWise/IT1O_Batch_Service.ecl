/*--SOAP--
<message name="Batch InfoTrace Collection Scores">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- Migrating it21, it37, it51, it60, it61, it90, at00, and i200 to boca.  */

import risk_indicators, AutoStandardI, Gateway;

export IT1O_Batch_Service := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
#stored('DataPermissionMask',Risk_Indicators.iid_constants.default_DataPermission);

string4 tribCode_value := '' : stored('tribcode');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

gateways_in := Gateway.Configuration.Get();

batchin := dataset([],RiskWise.Layout_IT1O_BatchIn) : stored('batch_in');
tribcode := StringLib.StringToLowerCase(tribCode_value);

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(trim(StringLib.StringToLowerCase(le.servicename)) = 'veris', le.url, ''); // default to no gateway call			 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

RiskWise.Layout_IT1I addseq(batchin le, integer C) := transform
	self.seq := c;
	self.tribcode := tribcode;
	self.acctno := le.acctno;
	self.account := le.account;
	self.first := le.name_first;
	self.last := le.name_last;
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
	// if the record level history date isn't populated yet, use the global parameter
	self.historydate := if(le.HistoryDateYYYYMM=0, history_date, le.historydateYYYYMM); 
	self := le;
end;
indata := project(batchin, addseq(LEFT, counter));

final := riskwise.IT1O_Function(indata, gateways, dppa_purpose, glb_purpose, DataRestriction:=DataRestriction,appType:=appType, DataPermission:=DataPermission,
                                                      LexIdSourceOptout := LexIdSourceOptout, 
                                                      TransactionID := TransactionID, 
                                                      BatchUID := BatchUID, 
                                                      GlobalCompanyID := GlobalCompanyID);

output(final, named('Results'));

ENDMACRO;
// IT1O_Batch_Service()