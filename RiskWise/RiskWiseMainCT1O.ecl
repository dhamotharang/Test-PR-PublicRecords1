/*--SOAP--
<message name="Call Trace">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="phone" type="xsd:string"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- Migrating ct02, ct03 and ct50 to boca */

import risk_indicators,AutoStandardI,seed_files,gateway, Royalty, RiskWise, STD;

export RiskWiseMainCT1O := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'phone',
	'runSeed',
	'DPPAPurpose',
	'GLBPurpose', 
	'ApplicationType',
	'DataRestrictionMask',
	'HistoryDateYYYYMM',
	'gateways'));

string4 tribCode_value := '' : stored('tribcode');	// not used in prii
string30 account_value := '' : stored('account');
string10 phone_value := ''   : stored('phone');
boolean runSeed_value := false : stored('runSeed');
gateways_in := Gateway.Configuration.Get();

unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean isUtility := false;
boolean ofac_only := true;
boolean suppressNearDups := true;
boolean require2Ele := true;

mod_access := MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
	EXPORT unsigned1 glb := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
	EXPORT unsigned1 dppa := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
	EXPORT string DataRestrictionMask := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	EXPORT boolean ln_branded := false;
END; 

tribcode := STD.Str.ToLowerCase(tribCode_value);

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode in ['ct02', 'ct03', 'ct50'] and le.servicename in ['targus'] => le.url,  // use targus gateway if needed
				 ''); // default to no gateway call			 
	self := le;
end;

gateways := project(gateways_in, gw_switch(left));

riskwise.Layout_CT1I prep(riskwise.Layout_CT1O_BatchIn le, integer C) := transform
	self.tribcode := tribcode;
	self.seq := C;
	self.acctno := '';
	self.account := account_value;
	self.phoneno := RiskWise.cleanPhone( phone_value );
	self.historydate := history_date;
end;

indata := project(dataset([{''}], riskwise.Layout_CT1O_BatchIn), prep(left, counter));


almost_final := riskwise.CT1O_Function(indata, gateways, mod_access, isUtility);

//don't track royalties for testseeds
dRoyalties := if(runSeed_value, dataset([], Royalty.Layouts.Royalty),
	Royalty.RoyaltyTargus.GetOnlineRoyalties(UNGROUP(almost_final), src, TargusType, TRUE, FALSE, FALSE, TRUE));

final := project(almost_final, riskwise.Layout_CT1O);

seed_files.mac_query_seedfiles(phone_value, 'ct1o', 'phni', '002', seed_out);

RiskWise.Layout_CT1O format_seed(seed_out le) := transform
	self.account := account_value;
	self.first := le.fname;
	self.last := le.lname;
	self.Billing := dataset([], risk_indicators.Layout_Billing);
	self := le;
end;
final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], riskwise.Layout_CT1O));
		
emptyset := dataset([], riskwise.Layout_CT1O);
ret := map(	tribcode='ct02' and count(final_seed)>0 and runSeed_value => final_seed,
			tribcode in ['ct02', 'ct03', 'ct50'] => ungroup(final),
			emptyset);

output(ret, named('Results'));

output(dRoyalties, named('RoyaltySet'));

ENDMACRO;
// RiskWiseMainCT1O();
