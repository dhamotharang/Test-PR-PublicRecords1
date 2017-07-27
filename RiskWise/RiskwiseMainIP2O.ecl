/*--SOAP--
<message name="Stand Alone IP2O Process">
	<part name="seq" type="xsd:integer"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- This process calls the netacuity gateway for IP info  */
    
import risk_indicators;

export RiskwiseMainIP2O := MACRO
unsigned4 seq_value := 0 : stored('seq');
string32 ip_value := '' : stored('ipaddr');
unsigned1 DPPA_Purpose := 0 : stored('DPPAPurpose');
unsigned1 GLB_Purpose := 5 : stored('GLBPurpose');
gateways_in := dataset([],risk_indicators.Layout_Gateways_In) : STORED('gateways',few);

risk_indicators.Layout_Gateways_In gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(le.servicename='netacuity', le.url, '');
end;
gateways := project(gateways_in, gw_switch(left));

d := dataset([{seq_value}], riskwise.Layout_IPAI);

riskwise.layout_IPAI t_f(d le) := transform
	self.seq := le.seq;
	self.ipaddr := ip_value;
end;

indata := project(d, t_f(left));

ret := risk_indicators.getNetAcuity(indata, gateways, dppa_purpose, glb_purpose);

output(ret, named('Results'));

endmacro;