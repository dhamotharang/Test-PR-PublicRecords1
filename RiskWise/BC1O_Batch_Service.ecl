/*--SOAP--
<message name="Custom Business Application Screening">
	<part name="tribcode" type="xsd:string"/> 
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>	
 </message>
*/
/*--INFO-- bnk4 and the new cbbl */ //cbbl and bnk4 use relatives V2 for now.....
//<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
import gateway;
export BC1O_Batch_Service := MACRO

#onwarning(4207, ignore);
// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4 tribCode_value := '' : stored('tribcode');	
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

batchin := dataset([],Riskwise.Layout_BC1O_BatchIn) : stored('batch_in', few);

tribcode := StringLib.StringToLowerCase(tribcode_value);

gateways := Gateway.Constants.void_gateway;

RiskWise.Layout_BC1I addseq(batchin l, integer C) := transform
		 self.seq := C;
		 self.tribcode := tribCode;
		 self.acctno := l.acctno;
		 self.ACCOUNT := l.account;
		 self.FIRST := l.name_first;
     self.LAST := l.name_last;
     self.ADDR := Risk_Indicators.MOD_AddressClean.street_address(l.street_addr,l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,l.unit_desig,l.sec_range);
     self.CITY := l.p_city_name;
     self.STATE := l.st;
     self.ZIP := l.z5+l.zip4;
     self.SOCS := l.ssn;
     self.DOB := l.dob;
     self.HPHONE := l.home_phone;
     self.DRLC := l.dl_number;
     self.DRLCSTATE := l.dl_state;
		 self.income := l.income;
     self.CMPY := l.name_company;
		 self.DBANAME := l.alt_company_name;
     self.CMPYADDR := Risk_Indicators.MOD_AddressClean.street_address(l.street_addr2,l.prim_range_2,l.predir_2,l.prim_name_2,l.suffix_2,l.postdir_2,l.unit_desig_2,l.sec_range_2);
     self.CMPYCITY := l.p_city_name_2;
     self.CMPYSTATE := l.st_2;
     self.CMPYZIP := l.z5_2+l.zip4_2;
		 self.CMPYPHONE := l.phoneno;
     self.FIN := l.fein;
     self.internetcommflag := l.internetcommflag;
     self.emailaddr := l.email;
     self.emailheadr := l.emailheadr;
     self.ipaddr := l.ip_addr;
     self.appdate := l.appdate;
     self.apptime := l.apptime;
		 self.historydate := if(l.HistoryDateYYYYMM=0, history_date, l.historydateYYYYMM);
end;
f := project(batchin, addseq(LEFT,COUNTER));

ret := if(tribCode in ['bnk4','cbbl'], project(RiskWise.BC1O_Function(f, gateways, GLB_Purpose, DPPA_Purpose, false, false, tribCode, DataRestriction, DataPermission),
                                               TRANSFORM(riskwise.Layout_BC1O, SELF := LEFT)), 
													  dataset([], riskwise.Layout_BC1O));

output(ret, named('Results'));

ENDMACRO;