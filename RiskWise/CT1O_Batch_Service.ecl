/*--SOAP--
<message name="Call Trace Batch Service">
	<part name="tribcode" type="xsd:string"/> 
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO-- This service makes ct02, ct03 and ct50 available via batch */

import risk_indicators,AutoStandardI, gateway;

export CT1O_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4 tribcode_value := '' : stored('tribcode');
batchin := dataset([],riskwise.Layout_CT1O_BatchIn) : stored('batch_in', few);
gateways_in := Gateway.Configuration.Get();
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean isUtility := false;
boolean ln_branded := false;
boolean ofac_only := true;
boolean suppressNearDups := true;
boolean require2Ele := true;
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));


tribcode := StringLib.StringToLowerCase(tribcode_value);

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
	self.acctno := le.acctno;
	self.account := le.account;
	self.phoneno := if(tribcode in ['ct02', 'ct03', 'ct50'], le.phoneno, '');
		// if the record level history date isn't populated yet, use the global parameter
	self.historydate := if(le.HistoryDateYYYYMM=0, history_date, le.historydateYYYYMM); 
end;

indata := project(batchin, prep(left, counter));

almost_final := riskwise.CT1O_Function(indata, gateways, dppa_purpose, glb_purpose, isUtility, ln_branded, DataRestriction, appType);
final := project(almost_final, RiskWise.Layout_CT1O);
output(final, named('Results'));

endmacro;
