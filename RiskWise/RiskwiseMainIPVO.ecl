/*--SOAP--
<message name="IP Validation Process (ipv1)">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- This process calls the netacuity gateway for IP info  */
    
import risk_indicators, gateway, royalty;

export RiskwiseMainIPVO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'ipaddr',
	'DPPAPurpose',
	'GLBPurpose', 
	'gateways'));

string4 tribcode_value := '' 							: stored('tribcode');
string30 account_value := ''	 						: stored('account');
string45 ip_value := '' 								: stored('ipaddr');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA 	: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
gateways_in := Gateway.Configuration.Get();

tribCode := StringLib.StringToLowerCase(tribCode_value);

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if(le.servicename='netacuity', le.url, '');
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

d := dataset([{(unsigned)account_value}], riskwise.Layout_IPAI);

riskwise.layout_IPAI t_f(d le) := transform
	self.seq := le.seq;
	self.ipaddr := ip_value;
end;

indata := project(d, t_f(left));

gateway_check := gateways(servicename='netacuity')[1].url;
gateway_url := IF(gateway_check='' or tribcode!='ipv1',ERROR(301,doxie.ErrorCodes(301)),gateway_check);

ret := risk_indicators.getNetAcuity(indata, gateways, dppa_purpose, glb_purpose);

riskwise.Layout_IPVO final_format(ret le) := transform
	self.account := account_value;
	self.riskwiseid := '';
	self.ipcontinent := le.continent;
     self.ipcountry := StringLib.StringToUpperCase(le.countrycode);
	self.iproutingtype := if(Stringlib.StringFilterOut(le.ipaddr[1],'0123456789') = '', le.iproutingmethod, '');
	//self.ipstate := if(StringLib.StringToUpperCase(le.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(le.state), '');
	region := StringLib.StringToUpperCase(le.ipregion);
	self.ipstate := if(region in ['?','NO REGION'], '', region);
	self.topleveldomain := StringLib.StringToUpperCase(le.topleveldomain);
     self.secondleveldomain := StringLib.StringToUpperCase(le.secondleveldomain);
	self.ipcity := StringLib.StringToUpperCase(le.ipcity);
     self.ipregiondesc := StringLib.StringToUpperCase(le.ipregion_description);
	self.latitude := le.latitude;
     self.longitude := le.longitude;
end;

final := project(ret, final_format(left));


//output(ret, named('ip2o_results'));

output(final, named('Results'));

royalties := Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, indata, ret);
output(royalties,NAMED('RoyaltySet'));


endmacro;