/*--SOAP--
<message name="PB1O_BatchService">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name = 'GLBPurpose'  type = 'xsd:byte'/>
	<part name = 'DPPAPurpose' type = 'xsd:byte'/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

import Gateway, Risk_Indicators, RiskWise;

export PB1O_Batch_Service := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4	tribcode_value := ''	: stored('tribcode');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
batchin := dataset([],Riskwise.Layout_PB1O_BatchIn) : stored('batch_in', few);
tribcode := StringLib.StringToLowerCase(tribcode_value);
unsigned1 ofac_version      := 1        : stored('OFACVersion');

gateways_in := Gateway.Configuration.Get();

BridgerGateway := gateways_in(servicename='bridgerwlc')[1].url!='';

OFACversion := map(BridgerGateway and tribcode_value = '' => 4, // this won't hit fail message on line 59 as it was determined that can't be done without changing current prod logic
                   BridgerGateway and tribcode_value in ['pb01', 'pb02'] and ofac_version = 4 => 4,
                                                                                                     ofac_version);

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode='pb01' and le.servicename in ['targus'] => le.url,// use targus gateway if needed
																	tribcode in ['', 'pb01', 'pb02'] and le.servicename in ['bridgerwlc'] => le.url,
				 ''); // default to no gateway call			 
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

RiskWise.Layout_PB1I addseq(batchin L, integer C) := transform
	self.seq := C;
	self.tribcode := tribcode;
	self.acctno := l.acctno;
	self.ACCOUNT := l.account;
     self.CMPY := l.name_company;
     self.DBANAME := l.alt_company_name;
     self.CMPYADDR := Risk_Indicators.MOD_AddressClean.street_address(l.street_addr,l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,l.unit_desig,l.sec_range);
     self.CMPYCITY := l.p_city_name;
     self.CMPYSTATE := l.st;
     self.CMPYZIP := l.z5+l.zip4;
     self.CMPYTYPE := l.cmpytype;
     self.FEIN := l.fein;
     self.CMPYPHONE1 := l.phoneno;
     self.CMPYPHONE2 := l.phoneno_2;
     self.CMPYPHONE3 := l.phoneno_3;
     self.WEBSITE := l.ip_addr;
     self.FIRST := l.name_first;
     self.LAST := l.name_last;
     self.AUTHREPTITLE := l.authreptitle;
     self.ADDR := Risk_Indicators.MOD_AddressClean.street_address(l.street_addr2,l.prim_range_2,l.predir_2,l.prim_name_2,l.suffix_2,l.postdir_2,l.unit_desig_2,l.sec_range_2);
     self.CITY := l.p_city_name_2;
     self.STATE := l.st_2;
     self.ZIP := l.z5_2+l.zip4_2;
     self.SOCS := l.ssn;
     self.DOB := l.dob;
     self.HPHONE := l.home_phone;
     self.WPHONE := l.work_phone;
     self.DRLC := l.dl_number;
     self.DRLCSTATE := l.dl_state;
     self.EMAIL := l.email;
		 // if the record level history date isn't populated yet, use the global parameter
		self.historydate := if(l.HistoryDateYYYYMM=0, history_date, l.historydateYYYYMM);
end;
//output(batchin, named('PB1O_BatchIn'));

f := project(batchin, addseq(LEFT,COUNTER));
//output(f, named('PB1I'));

ret := RiskWise.PB1O_Function(f, gateways, GLB_Purpose, DPPA_Purpose, DataRestriction:=DataRestriction, DataPermission:=DataPermission, OFACversion:=OFACversion);
output(ret, named('Results'));

endmacro;