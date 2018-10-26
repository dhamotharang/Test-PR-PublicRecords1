/*--SOAP--
<message name="NP2OBatchService">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- 'np21','np22','np24','np25','np27','np31','np50','np60','np80','np81','np82','np90', 'np91', 'np92' */
		 
		 
import Address, Risk_Indicators, gateway;

export NP2O_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4	tribcode_value := ''	: stored('tribcode');
unsigned1 dppa := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  	: stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
batchin := dataset([],riskwise.Layout_PR2I_BatchIn)			: stored('batch_in',few);
unsigned1 ofac_version      := 1        : stored('OFACVersion');
gateways_in := Gateway.Configuration.Get();
tribcode := StringLib.StringToLowerCase(tribcode_value);

productSet := ['np21','np22','np24','np25','np27','np50','np60','np80','np81','np82','np90', 'np91', 'np92'];

BridgerGateway := gateways_in(servicename='bridgerwlc')[1].url!='';

OFACversion := map(BridgerGateway and tribcode in ['np21', 'np25', 'np27', 'np50', 'np60', 'np90', 'np91', 'np92'] and ofac_version = 4 => 4,
                   BridgerGateway and tribcode = 'np21' => 4, // this won't hit fail message on line 59 as it was determined that can't be done without changing current prod logic
																			tribcode in ['np90','np91','np92'] and ofac_version != 4 => 3,
																																						ofac_version);                                                                                                             

targusGatewaySet := ['np21','np22','np24','np25','np27','np50','np60','np80','np81','np82','np90', 'np91', 'np92'];
attusSet := ['np80','np81','np82'];

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode in attusSet and le.servicename = 'attus' => le.url, // attus gateway
				 tribcode in targusGatewaySet and le.servicename = 'targus' => le.url, // targus gateway
				 tribcode in ['np21', 'np25', 'np27', 'np50', 'np60', 'np90', 'np91', 'np92'] and le.servicename = 'bridgerwlc' and OFACversion = 4 => le.url, // bridger gateway
				 ''); // default to no gateway call		
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway)); 

RiskWise.Layout_PRII addseq(batchin le, integer C) := transform
	self.acctno := le.acctno;
	self.seq := C;
	self.tribcode := tribcode;
	self.account := le.account;
     self.first := le.name_first;
     self.middleini := le.name_middle;
     self.last := le.name_last;
     self.addr := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr,le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);
     self.city := le.p_city_name;
     self.state := le.st;
     self.zip := le.z5 + le.z4;
     self.hphone := le.home_phone;
     self.socs := le.ssn;
     self.dob := le.dob;
     self.wphone := le.work_phone;
     self.income := le.income;
     self.drlc := le.dl_number;
     self.drlcstate := le.dl_state;
     self.balance := le.balance;
     self.chargeoffdate := le.chargeoffdate;
     self.formerlast := le.formerlast;
     self.email := le.email;
     self.cmpy := le.company_name;
	self.countrycode := le.countrycode;	
	// if the record level history date isn't populated yet, use the global parameter
	self.historydate := if(le.HistoryDateYYYYMM=0, history_date, le.historydateYYYYMM); 

end;
f := project(batchin, addseq(LEFT,COUNTER));

almost_final := RiskWise.NP2O_Function(f, gateways, glb, dppa, tribCode, DataRestriction, DataPermission, OFACversion);
final := project(almost_final, RiskWise.Layout_NP2O);

ret := if(tribCode in productSet, final, dataset([],RiskWise.Layout_NP2O));

output(ret, named('Results'));

endmacro;