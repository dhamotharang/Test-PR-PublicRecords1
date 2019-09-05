/*--SOAP--
<message name="USOBatchService">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- '1usa' */
import gateway, STD, riskwise, risk_indicators;

export USO_Batch_Service := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4	tribcode_value := ''							: stored('tribcode');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  							: stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
batchin := dataset([],riskwise.Layout_1USI_BatchIn) 			: stored('batch_in', few);
gateways_in := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

tribcode := STD.Str.ToLowerCase(tribcode_value);

productSet := ['1usa'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode in productSet and le.servicename in ['veris'] => le.url,  // call veris gateway
				 ''); // default to no gateway call		
	self := le;
end;

gateways := project(gateways_in, gw_switch(left));

RiskWise.Layout_1USI addseq(batchin le, integer C) := transform
	self.seq := C;
	self.tribcode := tribcode;
	self.account := le.account;
	self.acctno := le.acctno;
     self.hphone := le.home_phone;
     self.wphone := le.work_phone;
     self.socs := le.ssn;
     self.dob := le.dob;
     self.income := le.income;
     self.first := le.name_first;
     self.last := le.name_last;
     self.cmpy := le.company_name;
     self.addr := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr,le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);
     self.city := le.p_city_name;
     self.state := le.st;
     self.zip := le.z5 + le.z4;	
		 self.historydate := if(le.historydateYYYYMM=0, history_date, le.historydateYYYYMM);
end;
indata := project(batchin, addseq(LEFT,COUNTER));

ret := RiskWise.USO_Function(indata, gateways, GLB_Purpose, DPPA_Purpose, DataRestriction, DataPermission,
                                                      LexIdSourceOptout := LexIdSourceOptout, 
                                                      TransactionID := TransactionID, 
                                                      BatchUID := BatchUID, 
                                                      GlobalCompanyID := GlobalCompanyID);

output(ret, named('Results'));

endmacro;