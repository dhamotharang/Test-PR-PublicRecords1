/*--SOAP--
<message name="CBDOBatchService">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
IMPORT gateway;
export CBDO_Batch_Service := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4   tribcode_value := ''	: stored('tribcode');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  	: stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');

string10 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
batchin := dataset([],riskwise.Layout_CBDI_BatchIn) : stored('batch_in', few);
gateways := Gateway.Constants.void_gateway;	// no gateways for this
tribcode := StringLib.StringToLowerCase(tribcode_value);

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

productSet := ['cd02'];

RiskWise.Layout_CBDI addseq(batchin le, integer C) := transform
	self.seq := C;
	self.tribcode := tribcode;
	self.acctno := le.acctno;
	self.account := le.account;
	self.cmpy := le.company_name;
	self.first := le.name_first;
	self.last := le.name_last;
	self.addr := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr,le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);
	self.city := le.p_city_name;
	self.state := le.st;
	self.zip := le.z5 + le.z4;
	self.hphone := le.home_phone;
	self.socs := le.ssn;
	self.dob := le.dob;
	self.wphone := le.work_phone;
	self.email := le.email;
	self.cmpy2 := le.company_name_2;
	self.first2 := le.name_first_2;
	self.last2 := le.name_last_2;
	self.addr2 := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr2,le.prim_range_2,le.predir_2,le.prim_name_2,le.suffix_2,le.postdir_2,le.unit_desig_2,le.sec_range_2);
	self.city2 := le.city_2;
	self.state2 := le.state_2;
	self.zip2 := le.z5_2 + le.z4_2;
	self.hphone2 := le.home_phone_2;
	self.socs2 := le.ssn_2;
	self.wphone2 := le.work_phone_2;
	self.apptype := le.apptype;
	self.channel := le.channel;
	self.orderamt := le.orderamt;
	self.numitems := le.numitems;
	self.orderdate := le.orderdate;
	self.shipmode := le.shipmode;
	self.pymtmethod := le.pymtmethod;
	self.avscode := le.avscode;	
	// if the record level history date isn't populated yet, use the global parameter
	self.historydate := if(le.HistoryDateYYYYMM=0, history_date, le.historydateYYYYMM); 
end;
indata := project(batchin, addseq(LEFT,COUNTER));

ret := if(tribCode in productSet, RiskWise.CBDO_Function(indata, gateways, GLB_Purpose, DPPA_Purpose, DataRestriction, DataPermission,
                                                                                                      LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                      TransactionID := TransactionID, 
                                                                                                      BatchUID := BatchUID, 
                                                                                                      GlobalCompanyID := GlobalCompanyID), 
                                                                                                      dataset([],RiskWise.Layout_CBDO));

output(ret, named('Results'));

endmacro;