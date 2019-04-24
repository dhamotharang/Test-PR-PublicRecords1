/*--SOAP--
<message name="Stand Alone OFAC Process">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="cmpy" type="xsd:string"/>
	<part name="first2" type="xsd:string"/>
	<part name="last2" type="xsd:string"/>
	<part name="cmpy2" type="xsd:string"/>
	<part name="countrycode" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- Migrating ofac and ofc2 to boca. Also added ofc3  */
    
import patriot, address, attus, risk_indicators, gateway;

export RiskWiseMainOFCO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'last',
	'addr',
	'city',
	'state',
	'zip',
	'hphone',
	'cmpy',
	'first2',
	'last2',
	'cmpy2',
	'countrycode',
	'DPPAPurpose',
	'GLBPurpose',
  'OFACversion',
	'gateways'));

string4  tribCode_value := '' : stored('tribcode');
string30 account_value := ''  : stored('account');
string20 first_value := ''    : stored('first');
string20 last_value := ''     : stored('last');
string50 addr_value := ''     : stored('addr');
string25 city_value := ''     : stored('city');
string2  state_value := ''    : stored('state');
string5  zip_value := ''      : stored('zip');
string10 hphone_value := ''   : stored('hphone');
string30 cmpy_value := ''     : stored('cmpy');
string20 first2_value := ''   : stored('first2');
string20 last2_value := ''    : stored('last2');
string30 cmpy2_value := ''    : stored('cmpy2');
string2  countrycode_value := '' : stored('countrycode');

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned1 ofac_version_      := 1        : stored('OFACVersion');
gateways_in := Gateway.Configuration.Get();

tribCode := StringLib.StringToLowerCase(tribCode_value);
Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode='ofc2' and le.servicename='attus' => le.url,  //ofc2 uses attus gateway
                  tribcode in ['ofac', 'ofc3'] and le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
                  ''); // default to no gateway call		 
	self := le;
end;

gateways := project(gateways_in, gw_switch(left));

d := dataset([{0}],RiskWise.Layout_OF2I);

risk_indicators.layout_output prep(d le, integer C) := transform
	self.seq := c;
	self.account := account_value;
	self.fname := stringlib.stringtouppercase(first_value);
	self.lname := stringlib.stringtouppercase(last_value);
	self.employer_name := stringlib.stringtouppercase(cmpy_value);
	self.country :=stringlib.stringtouppercase(countrycode_value);
	self.in_country :=stringlib.stringtouppercase(countrycode_value);
	self := [];
end;

indata := group(project(d, prep(LEFT,COUNTER)), seq);

ofac_version := map( tribcode in ['ofac', 'ofc3'] and ofac_version_ = 4 => 4,
                     tribcode='ofc3' => 3, 
                                        1);

watchlist_threshold := map(
                           tribcode in ['ofac', 'ofc3'] and ofac_version = 4 => 0.85,
                           tribcode='ofc3' => 0.85,
                           0.84);

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

// getWatchLists2( dataset, ofac_only, from_BIID, ofac_version, include_ofac, include_additional_watchlists, global_watchlist_threshold);
patriot_final := risk_indicators.getWatchLists2(indata, true, false, ofac_version, true, false, watchlist_threshold, gateways := gateways);


riskwise.Layout_OFCO add_patriot(patriot_final le) := TRANSFORM
	SELF.account := le.account;
	SELF.riskwiseid := '';
	SELF.hriskalerttable := if(le.watchlist_table='', '', if(tribcode='ofc2', le.watchlist_table, 'OFC'));
	SELF.hriskalertnum := if(le.watchlist_table='', '', 
																									if(tribcode='ofc2', le.watchlist_record_number, 
																																			if(le.watchlist_record_number[1..3]='OSC', le.watchlist_record_number[4..10], 
																																																								 le.watchlist_record_number[5..10])) );
	SELF.alertfirst := if(le.watchlist_table='', '', (string)le.watchlist_fname);
	SELF.alertlast := if(le.watchlist_table='', '', (string)le.watchlist_lname);
	SELF.alertaddr := if(le.watchlist_table='', '', le.watchlist_address);
	SELF.alertcity := if(le.watchlist_table='', '', le.watchlist_city);
	SELF.alertstate := if(le.watchlist_table='', '', le.watchlist_state);
	SELF.alertzip := if(le.watchlist_table='', '', le.watchlist_zip);
	SELF.alertentity := if(le.watchlist_table='', '', (string)le.watchlist_entity_name);
	SELF.alertcountry := if(le.watchlist_table='', '', if(tribcode='ofc3' and le.watchlist_record_number[1..3]='OSC', le.in_country, le.watchlist_contry)); // if the country hit, return the input country code like attus did
	SELF.alertphone := '';	
END;
ret := project(patriot_final, add_patriot(left));

attus_final := risk_indicators.getAttus(indata, gateways, DPPA_Purpose, GLB_Purpose);

riskwise.Layout_OFCO filterAttus(attus_final le) := TRANSFORM
	isGatewayValid := tribcode = 'ofc2' AND (gateways(servicename='attus'))[1].url != '';
	SELF.account := le.account;
	SELF.riskwiseid := '';
	SELF.hriskalerttable := if(isGatewayValid, if( le.watchlist_table='', '', if(tribcode='ofc2', le.watchlist_table, 'OFC') ), 'XXX' );
	SELF.hriskalertnum := if(le.watchlist_table='', '', if(tribcode='ofc2', le.watchlist_record_number, le.watchlist_record_number[5..10]));
	SELF.alertfirst := if(le.watchlist_table='', '', (string)le.watchlist_fname);
	SELF.alertlast := if(le.watchlist_table='', '', (string)le.watchlist_lname);
	SELF.alertaddr := if(le.watchlist_table='', '', le.watchlist_address);
	SELF.alertcity := if(le.watchlist_table='', '', le.watchlist_city);
	SELF.alertstate := if(le.watchlist_table='', '', le.watchlist_state);
	SELF.alertzip := if(le.watchlist_table='', '', le.watchlist_zip);
	SELF.alertentity := if(le.watchlist_table='', '', (string)le.watchlist_entity_name);
	SELF.alertcountry := if(le.watchlist_table='', '', le.watchlist_contry);
	SELF.alertphone := '';	
END;



attus_ret := project(attus_final, filterAttus(left));

final := if(tribcode='ofc2', attus_ret, ret);

if(exists(patriot_final(watchlist_table = 'ERR')), FAIL('Bridger Gateway Error'));

/*
output(gateways_in, named('gateways_in'));
output(gateways, named('gateways'));
output(indata, named('indata'));
output(attus_final, named('attus_final'));
output(attus_ret, named('attus_ret'));
output(tribcode, named('tribcode'));
output(patriot_final, named('patriot_final'));
*/

output(final, named('Results'));

ENDMACRO;